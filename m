Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1DD3C13EE
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160710; cv=none; b=MdLJ3cILUTm3X/Ts873sO/HKC6YEs3BzSbyHDesDsCDSmR+Tx88o5WR6BZp4xR7iTjxKQa9okZiqly6K4oMSknSb/kvLLitUj1IlLc+n27l6K6Exqc6Ojt2XrSoUEP8NYppzDwomU4qoldkj6oIb5JJo9eBdoQ+57e8pczENvo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160710; c=relaxed/simple;
	bh=CR842DMY8l7cR/SV2lguppEtoL8Fmw/PnoTmyEIwuMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGw8HfYKDHmI9sr5UimEUEgjYu18FsuXaKBLOJlYvRTaGkN5oCqlaaQth+tKpMZB2Ep+UbQhtyn9efAEmwyOonvZBPZslnJhuFWXu1DLCWDbGRE9zHYyS9LYWL4JgwPpBrxqI2EA4u3HzY09iclA8BoB8C94Cu7BBAr1cjbUArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mSFKZ2cf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HdK3o/il; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mSFKZ2cf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HdK3o/il"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0338C7A014E;
	Mon, 31 Aug 2026 03:18:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 31 Aug 2026 03:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788160707; x=1788247107; bh=d64TiMQhOC
	ThYknvOGKubFe60WYOhiB9Zv5Rdg5AH6Q=; b=mSFKZ2cfgw2Lknz2fL+DBHUiEj
	rRWATe6XeIm/6rukHAQlMrbMQd4M75eghMGYoX6MiVb345Bek/BY+TtXtF8Y6bEq
	M4pFCm3eefqktLG19BvAxKZI7TWXeGgBcy4S0V/BCwk+YC9leavGz2Vq6R+nBwhm
	r9jyay9TtHYUnZOWBvzu3G/CGeVGN0UuOmocfN5qcf3HNPZoBYmx4ieINR6l2MKH
	OZ5N9pYvAMtbPfC4K58OvLYonAxaod7o96Klk+qFh590s0EsSipcnGhG8fbq7jkd
	UY8ETlWNWg9PFJQtOaUMzmPVlAnXWTBSvHfrvzmB5yfTR0cNQxnLi/eKE+hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788160707; x=1788247107; bh=d64TiMQhOCThYknvOGKubFe60WYOhiB9Zv5
	Rdg5AH6Q=; b=HdK3o/ilQL6i8+dYvygUr7uxY/csvSLgBOK6yfUkylMYY9BBHdC
	j8U1YuQd/g0o6w1Ytc1Ly4DxNzvIuScOm3Po/Odw4vrN6e0P4jLc8wD6wItjXFdq
	y3ykk7t5QJwMVKVud5Ej2jS5WK8/8NZbC1vQWavL6dKx2IRmxHmiVed76rqCX9L3
	EgPCF/irwE2EbQXvNUYvKh6XfqnQfQI95+e+z4Yc7iMmxNa7RNL0eMMdi5rHCsvl
	tMqAvwisu0QShI1RaUPBBH8LhV82TEXYM/+NovQJZpN4G23LtTUBrPw+CublQ6yH
	ODyv/OvgMfIsjs2q1E/p3Dros7hVp4moNXw==
X-ME-Sender: <xms:wyqVarx7uOcQkL3CJqBEplr3G0wfx4oEdLju2jgFpydkmRGLqOaPkg>
    <xme:wyqVaqRXNuUO3t3i0Qu_IP26B7_hw01GWAaErehGeSNRQr2-fIUnLlqdvNCiebljD
    DCWdzKFBl5k64c1ldpx8ZC-CvUoj3JvqFvKtlyxSxnQCorbprUVBg>
X-ME-Received: <xmr:wyqVaqW2-tsElYSWFRdGzDjuVxXnZfA_G8C0zVqSdLO26RS_kY8uA9k1Wj-jj911SyLSew>
X-ME-Proxy-Cause: dmFkZTEH4SDvy/QEv3Lb6l6jSsgxlBuza9zT9L4wbrHCBUdJ6fzHwZ4ZhYaEYhXcZJ8fzU
    J3L/d6Oe1iiNP83aLagxkaD/1Zyvga9DslaqUoJ1+gRtUYQM6dqeA7sUe45sXYPwPsciMR
    EROuaINCjV6Z6r8nHSnZWdVzp9ZjAXFywl8iyBrZjtY3x736hvUdaBjEqZal4z/lAcQEQz
    LEDpTqoCuuwlbAn88gXGvdppoyaOxQ8q0VQLOHN/v6kGJfOVJ5mHkk++iK1LtTJixV3CQC
    qKRMAbejnLNuJevsJvZvHeBiyeubbg4aPM880SIcp4ejqduKcynNVslHVIfo42qV1EjSDn
    WQaFrdxOIjizH5xjQl8uzdcmeXGJdE8mMi1NprqLsh+oACrNjm5Ymg6sJUeSyy1YIphsKY
    Ema8AapEFz/jyZepqUundneDV+RqHjUefM5kq/MZWlARPGZcv4owDdPS7+lsZZOkjcoUYu
    NhiXyBdHrNiUyox5RzqnKNweZ29vPBp1e5tfprHf7BCwsnk88kCbrrFwXHUmGGPEtkyTQj
    1MDwx5xXxvjM90dLp5J7QvACitUCCClT9ioH+5c3kXan68Nu5IsEXkPZn3+qhzF3FMi0Y/
    unLqMD2pRsZ8wK9r+15N8WiZrB0W0gmbBgoZyWg0xL6a4kdksADGjChx9qww
X-ME-Proxy: <xmx:wyqVakYQFDndxEsJXrbPuuSN9fvg9mK7Wt2HO4eGwFMPzk5MQb_OhA>
    <xmx:wyqVao0H87XlQ7E1eAAzHB7Mr9JpPCiN0T_R-slRbiIhOkP1T4VKWQ>
    <xmx:wyqVaugy1VvEX8hX0qoVG2e5IY2-y7N0Fq-9gEYJ49y-8FHxhHfuLw>
    <xmx:wyqVakYwTkuVb4htD9zkxSZDbwrbqU-baOGR857Hd5jcUjZ-QPTDaA>
    <xmx:wyqVah294e5giY_7fSBv2QslBjY6Ql53QOj5MLMlbQAttwACA2yQkp1s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 03:18:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dea6326f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 07:18:33 +0000 (UTC)
Date: Mon, 31 Aug 2026 09:18:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v3 0/3] t/lib-httpd: make CGI test helpers
 concurrency-safe
Message-ID: <apUqvjWbbZCRUS0n@pks.im>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
 <pull.2171.v3.git.1786583137.gitgitgadget@gmail.com>
 <xmqq1pbkfyb1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pbkfyb1.fsf@gitster.g>

On Wed, Aug 26, 2026 at 12:59:14PM -0700, Junio C Hamano wrote:
> "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> >  * Patch 1 fixes apply-one-time-script.sh (the actual flake) and adds t5567,
> >    which drives the helper directly with no web server so the overlap can be
> >    forced deterministically.
> >  * Patch 2 makes http-429.sh atomic.
> >  * Patch 3 documents the atomic idioms next to where t/lib-httpd.sh installs
> >    the CGI scripts, so the guidance is in front of anyone adding another
> >    helper.
> >
> > Changes since v2:
> >
> >  * Patch 1 now consumes the marker with a plain "rm" (without "-f") instead
> >    of a rename. "rm" without "-f" already fails once the marker is gone,
> >    which is the atomicity the helper needs. A new comment explains why the
> >    helper discards the one-time script's stderr: a losing request can find
> >    the marker already removed.
> >
> >  * Patch 3 is now specific to the lib-httpd CGI helpers and lives beside
> >    their install site in t/lib-httpd.sh, rather than as a general section in
> >    t/README.
> >
> >  * Reworded several helper comments and the patch 1 and 2 log messages for
> >    clarity and to match the code; no behavior change.
> 
> After giving a cursory review to the previous round, I was hoping
> that somebody more clueful than I am about HTTP tests would lend an
> eye or two to these patches, but nobody seems interested.
> 
> Any takers?

I think this version is good enough. It's quite a bit puffed up by AI
generated messages that are overly long and use lots of meaningless
jargon, but I don't think that's worth another reroll.

Patrick
