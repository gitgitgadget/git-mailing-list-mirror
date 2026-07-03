Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B2C2F39C2
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783100216; cv=none; b=Ef9+qRR7+WMRd412dWmX8Z/6vdlBygNF4XVuwD5/N65+Ml/pB+166PditVWW4rFBQuo3y04Em0TFgT4ZvXi8pcMJ/7LoKM6pc7FYOfutxqZotcoFT7ALthb5ykcHd89gFOuIaFJETWu9tSAgozbaxZDPZlPKXKvGrBMVP9iZbCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783100216; c=relaxed/simple;
	bh=YfXijKGgCAbkW/dGS1RfPbD7P86SaTbwpAQkMmXlBTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KUnJZ8QKQbvfzZt6ubNrfhhXEUEFtCZ405BkMoYblsqjApsUGu/Pw2jecVj217KORps6BGIg8dL7r5m0Nzu4ua52t/LbHycO6vprEOMefWXleP0DgNVbYX2oa5PNV4LTqEGGjCcT3uDlqEmmhQWtdEWzKqxiEvjHEw394iTNKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V3pYITID; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hiQ25XMY; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V3pYITID";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hiQ25XMY"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5D0A814000BB;
	Fri,  3 Jul 2026 13:36:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jul 2026 13:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783100214; x=1783186614; bh=1cxake3aTA
	h3gZb3+GpQnRWakZyC1zJ8RfQl+PQjlrM=; b=V3pYITIDB65gRtXmavHP/Skcj9
	faYUpTDKrQfijfu0IfWpcTnl3pXLw1WANN0THGg4xC9M6JnnhEjQzNIRCU3ptPPW
	89R/DsObv0yqvmqgUhx4xETgHUXF/MjO8XSXkrftp8PfZPqoPb4yrFOGsvZFFEgC
	xnYzRW7E4o2BnienXmEEskLS1W4XqdaoCN8qn3uKlyps3z31PkKlPYRMTnUh3zfG
	7d/KenmVii7cNUYT+VpPqtwufL/GZEFIWMh1CeJf5xgg8t4jPP24c72kfMwtM7ox
	gnitow4hD3KWcUnEM6vCYXF1Zl6jPkMY/84rg5/le4/kvdiNbkHlles1q8Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783100214; x=1783186614; bh=1cxake3aTAh3gZb3+GpQnRWakZyC1zJ8RfQ
	l+PQjlrM=; b=hiQ25XMYfss8V4ZS9kKnX9rmUNiUAr9z87ZPvd7NZvyJmONUxRH
	8hK3jXi1jt9v8GIhgmD8mhzUfdNbBiD2TSkcIgWFUpzVc+3XSiwdkBebsg5inlZs
	YC0KE3xc9x8IZyp/Oyqs/FzpgpAg7yA7ME8oyI59QtVIc8RdTxg8US3XzQ8V32vM
	WzfhffPc2g13qZZDWOzIGBdCKvT9FBX0yWYcxI5V6QkOnoosZRo5iaeRV8a7K0+d
	jlRTHRBzF/bpg1MDfsEa5ZlR1n7Q459+aHQmPZ5e7fR9vlYctnDCx2VyR2wNgEqs
	NnM9rpWYMOsIUokyCvKJnUdj7Ts4D26vzcA==
X-ME-Sender: <xms:NvNHaiQCVDDsGw2HQJAlckkrS6Aw01UdlYMYQbmfQboiw9xAu2vy_Q>
    <xme:NvNHareCUjbtUuKwNlUapquUlUigrZhBlXeouCPQKL6Xl9VF1ueh34lyC1fz2LxA1
    ndKbwI22fht_s0LrmAfm2fJq2ZFZ4l-AsCpyGx3XLEPtwLL5wPrCEg>
X-ME-Received: <xmr:NvNHappsCb6bhbbpUXkl6tU354wzUhCE1xKin5S63gEAFR2C_DrjvVM9QuK8L9Wsmiaa7Q8TNdJXqw6uwEuoYwB0JtPiJNT95EbL4LE>
X-ME-Proxy-Cause: dmFkZTEF5BvGxsSsblHdKFgOM9TrorrMydUZ3xC7OQRzB7rPI5sYJ0RxR5bwZcu4SwCvXX
    S/QLBx0+NjiWkE3VRdA/cTg95M72yNe5iYzHNeX1JYVOOggpgMAvgwCu0JTYW3Cy9/Ezy3
    HVUJsAwZDEFEPfw84KsMVOrF7T76ylEc85vsotlng4+FUEJdpkdMAzFA1LT0+H0Xuo0M2X
    knMuFlwccTNqyzQEroPhryu9qkRK3A+r00weWayW4d+R9/RyY6rE/dlYsO4iumw+Um4d1x
    e4Lo2x9S9QntxLySRG7Brbm8bagknDlmg692vvRjAqSFbc0a1hfuijVCJWWXjHKLNAWfGa
    Ehxcuk7T1X2MAC6FuehxPcnDhKpmxRZxrvCctfDf9ycQwytjv+fxAe4gN0/DzG72LTgcFS
    Ab0Jy7hb61E6rHEGkzhrB9Am2x/ME80iRP671GFIUo6Y8YtVtkDW/OSEJ+xRiGuic7LFpI
    8jES0LXMYDEC0yPLFMteRkQJED+ieBnzj6iN+8q9NgjyLSwmYatdYtPUiL5O/c3tg852ck
    HG2JuudxfbtWXkLuzJFBf6Vbqx+Vn5b3Pnc1SruBPiLNGpVY+YabxqWSZDvh98m7+vY2Ab
    nMX1zJTN34XGCT3BjNijZihmokmw4EHkJFcf6viMmgd23sQQni4s1xQQ/0kA
X-ME-Proxy: <xmx:NvNHak8Je--8aa_DHrdNBIBGNa9c4VyhGwqA1T2p92vqtteGryLRgg>
    <xmx:NvNHate_Cf83o-Q04KtpCa-yGoxlICRLDuOX84QEDs4Cc9eUAs49uQ>
    <xmx:NvNHamL35TTqEkFa-c8JjcYDuQcB0fxZvFMSW-rWneYF8oQ68rBj4g>
    <xmx:NvNHaljXjDpitIS143lp2u4iY1J2nEdqQDhyBIv3sqC_lrFXpcmEWA>
    <xmx:NvNHamboYlPT_swhDwEqP_pby4twdgRFzxeu9CNjWIuxK64wRzuVPEAW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 13:36:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v2 2/9] t0021: skip EXPENSIVE test that is broken
 without SIZE_T_IS_32BIT
In-Reply-To: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-2-79076a7e0c62@pks.im>
	(Patrick Steinhardt's message of "Fri, 03 Jul 2026 11:24:05 +0200")
References: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
	<20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-2-79076a7e0c62@pks.im>
Date: Fri, 03 Jul 2026 10:36:52 -0700
Message-ID: <xmqqse60ht57.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

The subject reads "skip EXPENSIVE test that is broken without
SIZE_T_IS_32BIT", but we need to add prerequisite for 64BIT,
wouldn't it be more accurate to say without SIZE_T_IS_64BIT?

That is, the test is broken with SIZE_T_IS_32BIT, no?

> ...
> -test_expect_success EXPENSIVE 'filter large file' '
> +test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'filter large file' '
>  	test_config filter.largefile.smudge cat &&
>  	test_config filter.largefile.clean cat &&
>  	test_seq -f "%1048576d" 1 2048 >2GB &&
