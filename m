Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006723FC7
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 23:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756424150; cv=none; b=qDitfG1spEbxgt3oH9v6EMuwN11Yaadg6jVM0Bak+m56vRVxUr68sTxuqAOI0+hS7wNsSgN28jT3rckLaFmDi7IzY1SG/8OerZGQdSvoUGWj84T6rPld/ADssqF9uyV0eZyzf0EGhMndZWD/oMVIXOVLAdI5oQjG5iKdoZUnJws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756424150; c=relaxed/simple;
	bh=erTZlUOi93L2PEiR1MuOMtAYbjd2QhP8ZYJfQ+6ZkhI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KE0CrJhA+BS8EF3yJPfF3FSn5OdUwOu/EF/C/bVhZrK6WjquLkVypFVY/Okv6cK2AjqZGcXOi/GKgG14RMEpSTIVdprN7ihDJYITqmw/b6Guhu9DGeViz7CFJPHAvP0wtrifjlgOUYXSP5qDU6ewcJOZRA+I/yEKq8t2JKz+KYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=onBgHGMo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XiAvEdla; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="onBgHGMo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XiAvEdla"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F22CC7A01E5;
	Thu, 28 Aug 2025 19:35:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 28 Aug 2025 19:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756424147; x=1756510547; bh=LKKiPMBZEZ
	RqFOoWqef1WRnDIC0OhPC4eXyduOX1t2M=; b=onBgHGMofGpSEWyViAKd8Xfbwp
	qvs3RVK8UDOPPDf30YVSqkt53/uwaZv1sCyLNbpOqoy+zqEplSAV+nolmJ6TxGZd
	vMlj/Kea/PRi6MJn/KnhTofTYsAv8L7ZiWgWwWIxe4KgbnIaXu28XeHp9t+31beh
	VRgVDQiDsTmjsheoPDrxO6pB6RlcT4vKcQsgK7Xb1IdDtVdNZHZAwxufwCyqHeWb
	3/1IY1tmTTzc/e5gRdBJdNV/2Lm0zoAKF82826a8nl/AY+JumiyUlnygHLJdqAHm
	xlhZb7kmADiPdXMYxvL0ppzsKqWIno8wLRUbXz/sf5pQh1PvSlVkQmAc9Mpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756424147; x=1756510547; bh=LKKiPMBZEZRqFOoWqef1WRnDIC0OhPC4eXy
	duOX1t2M=; b=XiAvEdlaWCXlShMVEtx3lv/qTPs0l2rQlX3zP0BKtlGJDuj5aEo
	KuoSn5dmj/UMl8AqJFgL+YB17HRpsxEVV+9tCBmbYicdlpCyP7Ouzzzx8eKwVZuT
	Hw1hoRc4/JRa4Lsuw77NEes2XYHokGflBWUcXNFPbRENk1H72zK+PHMgqFKxm1K/
	Ua4Lst7N7x2z3cDDeCjzH99JBm20lanmw/muiZxG5Fsagg8xfbu7MXthYmzy3p73
	T6aRhba3zFGf8dVWuJax4N4fp0zPWqOycoKpUBn4okV95b9aBVGoXfJw6zH4iISy
	PaZxo8epNFxAR6ljLJqvUQGaVmAfNwjOLqw==
X-ME-Sender: <xms:0-ewaOJJo6Xp2iTBsrvWe3lcxHV1kk9BRrk6iWlsilHEpOZ1WY4CuQ>
    <xme:0-ewaBnP1aGf3i1Gj3-eLLQ5Qt2W6LGl-4PmCWlxV88JpCUC10RBL2ELvcwXwZyM1
    XtUg7tsDHcnNsPFOw>
X-ME-Received: <xmr:0-ewaCO3ECG8SEnpUX6vmt73o82zRQJ661xR3D_zPGrx8QRBn3cyZD1Gq7DYMqOa9vXWjO9DIUks-9i6aaXn2OsvGpZCAvjydevf56s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgeslhhi
    nhhugidrsggvrghuthihpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvg
    hlmhdrohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0-ewaH1SGGIf_DFuL03-RcPGpTuIW3SjKwSL9_XAVDitqLSO4qtT6Q>
    <xmx:0-ewaBkAxrIlxzYlcCfAdbYHWmKLvI0L98G_gdSa2yDJjYxbMJvx0A>
    <xmx:0-ewaOWqEU0cB-SF08XuEsyMHa1zaX3ZVITCPehBXV8GO7qEZcHH5g>
    <xmx:0-ewaHs-QQYGR_Ow8kvfes7pAgTXN5231Nv1tNR6spdSMOKF2H26lg>
    <xmx:0-ewaOnUeTtDPeeusxGaSDr0SzNaLZALseTNjWoG4Pb7K4JTqI555WPG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 19:35:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Li Chen <me@linux.beauty>
Cc: "phillipwood" <phillip.wood@dunelm.org.uk>,  "git" <git@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] rebase: support --trailer
In-Reply-To: <198826665b6.317113211709957.1514728503207030488@linux.beauty>
	(Li Chen's message of "Thu, 07 Aug 2025 10:40:05 +0800")
References: <20250803150059.402017-1-me@linux.beauty>
	<20250803150059.402017-3-me@linux.beauty>
	<e911d897-8664-40a7-b7a9-8eb9f71a8735@gmail.com>
	<499da566-66a8-4c38-a2b3-13c06092568f@gmail.com>
	<198826665b6.317113211709957.1514728503207030488@linux.beauty>
Date: Thu, 28 Aug 2025 16:35:45 -0700
Message-ID: <xmqqiki7qasu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Li Chen <me@linux.beauty> writes:

> Hi Phillip, 
>
> Thanks for your thorough review; I will address them in the next version.

As I do not want to keep an inactive topic in 'seen' for more than a
month, I was doing my usual "sweep" of the topics, and found this
exchange.  

Is this still being worked on?  No rush, but just checking to see
what the status is.

Since the summer is a slow season, I do not mind keeping the topic
for a few more weeks in 'seen', but I can simply discard the one I
have, and requeue a new version in 'seen' when it materializes.

Thanks.
