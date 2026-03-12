Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448B737C933
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 02:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773283137; cv=none; b=PWIxQJd6slUm+3KF0TnhB6nX4ogcPowv3FzOSK8f2qXk7h+RmuWyCitm73qnNi+G7XPNsA3YhKRI9GL3yw7QMmJc91umQGGaIVuy4oFUbfOiEHHZYmYNEF1x9x6SVCT35DaJA1ouzzndd5btwVoxTGcYNNzEKPEEoBTqLIPzOaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773283137; c=relaxed/simple;
	bh=yqW82naAFO0WIohQKy/Ys/iDoInVbmj+WhUUAXugV1Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jmL4yRnXa23Kbx8BM6aCAWn5zekPZ7kG4w30UIDbnmyH1IXtwRMpbFxaTzQ7eHuHH4bSDRnDaEr6WMN3x5NMzO3BEMqn6GTzOWk+3cu5yIFtsFdWWAzpqtzVraru5DPZI2AllsoTfvxFF6tXll0hVMrnSCIWFcr19JR/fET+psI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OJJ8M9Zz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hboktxT5; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OJJ8M9Zz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hboktxT5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A4CCC1D001E1;
	Wed, 11 Mar 2026 22:38:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 11 Mar 2026 22:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773283133; x=1773369533; bh=W5XfhGmAuA
	5L0b3W+LROdbsVxA2IiHROgioRgHNjj9M=; b=OJJ8M9ZzySYaO0d1SNqyRITxrK
	FLjkmQ8q1eZ6ExEqm1Bl65VZ/5FpQRZZwkbqYysFuVoOP7oRi02JkQA59m3Wembn
	YLuTqNepRsdx2SwzzLchSZU0ninvSOrlFg0bLJbbH99EZsZu08pzqFyDfrE5K71K
	BCZBR5/MlykqtZ7h9euuQvNBgXPyial9LANYvqzStYTjnRpnBzDff5FvRp7HcdVL
	LnintP/OHEb1IbJq6IuH3hVs2vr5Jy3x+9WRRq4kYfeuDEF/B0EDJLx38mUdDQrb
	eaS9vCAiPT5xTte0A1xWwT2xDKGwVd8LR9sceA0Ya5myBm23cf6vt5SvrLxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773283133; x=1773369533; bh=W5XfhGmAuA5L0b3W+LROdbsVxA2IiHROgio
	RgHNjj9M=; b=hboktxT5cN9qZerKqP9Y+ZXVSfU9euYmR6g0628QejFm6d6c2vn
	4pQun7E0lbV0DcjyV1q42uylcf5j7HM4SsQUTcNRj5MHORvejtGe9jIb/LkVaX2e
	o+tJFen3Dy+TEZEP5jxuRWu+C+LBnJCoHdYobDpe/AclTY9P5mrTxwsKl23mQV8b
	kOIhlBGlxYscLYHmwVqLLneVPLtJ/VAUxDftVS40lTRD7d3qmdVwxoFXFzEm+4Bi
	sqIaaMoSnIMIWPEsAu8UKXxmN/ob8r1y5HECk4guX9y6kSv/uwghfO9zNJhQFODy
	P9lu1DOfYpPtw/Rfn4ZcJG0zRie6247pmug==
X-ME-Sender: <xms:PSeyac-7JMD6eWlkBQJpWwy0D5YeytsEv3GpeCXMHogpqVCqdIBwiw>
    <xme:PSeyacLoBSfXy_jqvBv7ciFffUVdkp5RHd0-qA4YqIIFGgOtchR-5_MJ4dKrb3jW5
    -S_aKrkDmELE0Ytt_EqfYtgn1n3cc-RNBCXTkzdJnLQMyQlfGVmfQ>
X-ME-Received: <xmr:PSeyafZu-O9ZrU0YibrFRuqqLIGc0QCGmmVs7TRoI3XjVWTNusnET0adUCaoKdPEyc5B1H2jKvBEOhANd5_dXUrL3U19lu4KMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeehiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeefleessggr
    rhhrohhithdrshhhpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PSeyaWLGCuiQqc31GH4cpNcH-tgPsDEiolO-N5hhA-TZ3ttprcvfwA>
    <xmx:PSeyaVD_i8Nnyir71_bGXrK_dEe5KiqGuNyIoGIqdLg19m9-4i5yEQ>
    <xmx:PSeyaToWT9KE5nREWn5cIS_EUUC48otVNUkw9va1LwWGbLq3NVAy4g>
    <xmx:PSeyaYic79AqU-saxJlWGroGp_k5gBBWhKAwJ3qckyV52RoRqgqkHw>
    <xmx:PSeyaXFzKvG1pfBMsWnfoXZxzZgRZUrvRD8qoFcHfVqBCM-wlTri4vLO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 22:38:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiamu Sun <39@barroit.sh>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 6/8] parseopt: autocorrect mistyped subcommands
In-Reply-To: <SY0P300MB0801C9B110080DA6DE9827BFCE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	(Jiamu Sun's message of "Thu, 12 Mar 2026 08:26:11 +0900")
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB08011B31B360FC14F05418C1CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<xmqq7brjtp7c.fsf@gitster.g>
	<SY0P300MB0801DA185098623A3729B9F8CE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB0801C9B110080DA6DE9827BFCE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Date: Wed, 11 Mar 2026 19:38:51 -0700
Message-ID: <xmqq4imlkc04.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiamu Sun <39@barroit.sh> writes:

> "commi" to "commit". Do you know if this behavior is by design or
> something else?

I don't, but others who have their hand in the code may.  "git
blame" or "git shortlog --no-merges" may be good tools to use to
find out who they are.

Thanks.

