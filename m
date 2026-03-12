Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E9A39D6C7
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334813; cv=none; b=r4wcRCRZdkDP5JNLIcIfJGYruZVLHCZuO4fxaxbvTg7htEYnPADW3yAl5MpNNGzPWaWhpYu/oFTSPppfOqSGOFfX41jy91ogwGL33LRVgANDFnkoWbFSzqhHh7QzptkbZHDKETHvsmxo4lSGSyI+P9GdG6VGJUimUdcAzTiyCvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334813; c=relaxed/simple;
	bh=ZLEO+Cf22itZ8jiR8GSBdTP44F6lGq2S4/4Vtjv8z98=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P3Vqfyc/0ZRaksL8xcrhlOsWbIsum+iOuMNXbenTYJrIG83hbS0vqa8z9klKVlsoYwmtHF+DlLeTlNFIbvGUrgdubdnDW4I0/mRW5O1zEDId0ewqJtIG8z9AitZk4zLQfCm+Avq7ftHQghoPxzNmZ3P2/X3c6BqBDsSqNMYx7AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sr6LQrt7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ezmZvEOg; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sr6LQrt7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ezmZvEOg"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A48587A01E7;
	Thu, 12 Mar 2026 13:00:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 13:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773334810; x=1773421210; bh=VFyabwzyL+
	T/7GJBXuSNcgwoeQ9etBlcinf22bIeXTc=; b=Sr6LQrt7Dw8AOm6y66QEX/QVBy
	otncTQ51W7sHU8zEEbGFo7EmlB4X9mquPh6YD7df6YnD+ltW6LR3DCax+PH8BqH+
	CdDKmOJUl5hFjJkE5Cc5fk2mS1Mqoj9lp1+t3FolguWg2YNTBDvBZZRcviFPSEdV
	j03PJpAY/DVA/xwzxYMIrpe5npmtW/SoIfg21DD0CG1ejqtD+AcfUXDiK7OOsEiI
	jQkNXaOzMLVDAhvr3dVtDd77Sy1WDuekcIEzC5Ils5ssLe8Ck7AR/qHCV+BrSGVn
	OozZb1qK4GdzzcW/fnxjbF6OJXPu03NCNwbA6VtTiGlY7W382lqiWxO6RWng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773334810; x=1773421210; bh=VFyabwzyL+T/7GJBXuSNcgwoeQ9etBlcinf
	22bIeXTc=; b=ezmZvEOgd1IDf8GvRh/VSHpL4aMy4xFDEJOHLOy3XO0K6MrIFbf
	MxonYOvgSHUkMU6Lo1qcsj+nNIe4d84d/LGeWoMAr3+Xj6WdBYOty18L4SmRAvJN
	rGUIJzPpMlmH/L8yOW75oKJ7vbK34sD6/liKNiRl7mqPm84VjMWy5VGvz5LshV8J
	zQJyONVqOBY5PN1m6I4tCBh8EXLbM17UAAkjdD0JSKYd9kMdGtGnuRwDxZ5AZP2W
	UngRLpOoKGo4y5LEl81Iq2f0YK/t/ywfzXOiQnnrSn2ayoED4RzhPBs+LBEv8Oij
	EBye/QTCqDVUno+W3JLNG+jpXhdeQii1qOA==
X-ME-Sender: <xms:GvGyacraHbFHJkFzRojOFcR2ZQKYEvcu0J5iIPJGWsBic693ybhmuw>
    <xme:GvGyaWXl8BFNB2R8oQSXxL0Mnbwry1vFVrrTAphaLOAORpm60VWwlGFpwf4CuHoQw
    2AksKg7D6Dkq_GLAX3z7vyES-L4N_iupSt3NVilpZtAAi7EQ5MOiw>
X-ME-Received: <xmr:GvGyabDEiWleS2rbR44MKFJ0yByCAGqB87warEhnlzOPf6LxBSX3fEg6peiNGjx9ZIVMhGTB-QgvAo9f28t1dtWSptZ1GU-sjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvrhhtrdifvghsrghrghesghhoohhglhgv
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GvGyaa1OjIxh7SfULfplNrEyBzTvH9zf6eEoHsiaDPNDeVRMD5j5iA>
    <xmx:GvGyad28XtoM26N1Vabt09wPIEiAaRni3v626x2LKvWZhK2MbhZKGw>
    <xmx:GvGyafAW8WjUp6D7XJdy-F3QMl-4na53aSBEbcwMWXV6Pos2eobP-w>
    <xmx:GvGyac7aipw_NPdW6DIGp5bXQ0RRLWhEaSt2zBgW_zbjbD8upipokg>
    <xmx:GvGyaZ5Jvw98_NAG7RkUQEgnZUcp7SK93pdmbVq_RChZcZzgnv8iom4u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 13:00:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v8 4/4] format-patch: add commitListFormat config
In-Reply-To: <50b1f37e8cd6091deca793f9a972b1d15d9aae7d.1773331754.git.mroik@delayed.space>
	(Mirko Faina's message of "Thu, 12 Mar 2026 17:20:11 +0100")
References: <cover.1772839973.git.mroik@delayed.space>
	<cover.1773331753.git.mroik@delayed.space>
	<50b1f37e8cd6091deca793f9a972b1d15d9aae7d.1773331754.git.mroik@delayed.space>
Date: Thu, 12 Mar 2026 10:00:07 -0700
Message-ID: <xmqqwlzhf0fc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> Using "--cover-letter" we can tell format-patch to generate a cover
> letter, in this cover letter there's a list of commits included in the
> patch series and the format is specified by the "--cover-letter-format"
> option. Would be useful if this format could be configured from the
> config file instead of always needing to pass it from the command line.
>
> Teach format-patch how to read the format spec for the cover letter from
> the config files. The variable it should look for is called
> format.commitListFormat, it accepts the same values as the option
> "--cover-letter-format".

If we are calling this commitListFormat, we would want to name the
command line option to match it more closely.  Doing so would have
an added benefit that tab completion on the command line becomes
easier to use, because --cover-<TAB> would expand to --cover-letter
uniquely and we do not have to force the user choose between
"--cover-letter" and "--cover-letter-format=".

Perhaps "--commit-list-format=<format>" or something?
