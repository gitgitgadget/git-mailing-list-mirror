Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C7320CC9
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 06:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763015667; cv=none; b=CFenkKzLJ+d7Kot1j8eFW1I3CrIMyPCxFODAKWThzLm/G/aAqHpLFv+UvLsa52lxLKNB3wvq2LORSdrSIntxPEbx/LrTR1kdUjZVv4Kv84Fs1O5jrqXXZO2zfwHgvEfCn/+x3x3c3q0avKxCQBgJfG8ElpaCChOM3uXE5HTxw9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763015667; c=relaxed/simple;
	bh=kgbz8knA4IOhr/WhxBUr9hhKsKTh+QMO0mw8hy0tavI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wcb0hYc80guhc1vawI9nFL55TbWNk3Wyq21DOkUgKoWGMzY7QX3uPk7kgxpv/F7+SwPzIxFk3FIfuJvaW1vNe2tQI8Hs+UNMme7+FmMQ1Z89RZoZ4iUGKdUU5Mam9YtZjnoWaPgos4mn9yxOndrgVnKLMQFIhBwc02/ixwk3zYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QTqkGAvg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pa2kxi3b; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QTqkGAvg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pa2kxi3b"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 021BE1D0000C;
	Thu, 13 Nov 2025 01:34:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 13 Nov 2025 01:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1763015663; x=1763102063; bh=mi1CaK8I22
	zLg2uNn5VbFYP1J+ht1PfkaBgF8/JI8f4=; b=QTqkGAvgqeFRQ8xKMGXIC62qyY
	KKLs5vHjwWjh6zv7dqHedxR2LrEKEM2IEqY/+cGZ94jUHvyrIx0AjkiqR3VIrl1Y
	NUVjZe4ZOnUz8P+Mr6HRgSQPwZzfOfvhUY2bJL5p8Hbmv7wR6nIIiKbb3B4JcC2Y
	IMYzmrCTMENyaGUh/eFHPNarisKPqkbPoda/eKcnuac7hEn4ozHVMgyWV4pvMKg4
	PRDZ/WEuJn2onkrUcprtFw3h6+wPyD7xqe0HqkoNRRx6u4BCbEaHRgdfkkCIpjgb
	xl6voDkxTSVAbbUjF/Tpw9hPYPnMY45ZkkiN+7bSHTTSGYDwEzh8XKiTp2fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763015663; x=1763102063; bh=mi1CaK8I22zLg2uNn5VbFYP1J+ht1PfkaBg
	F8/JI8f4=; b=pa2kxi3bHD3z0aLc5m5K1gvVSZI8stHVPzjzX4UxsqYwxG2xWI6
	KNpVhn9oBFcS780C4EYWXtRdFY+ae80prRKkdcU1JbDSI6KkxIPFKT5lmBhB+BBw
	DKMIs4dSi46fzTHfeqZ49bGzGN/ZS1rsmnskZJ4jlz5fpYkjpwUYNWx1Sk70GSS3
	O94avUUdYPEQc4XdDI1wXUJweYtKOLwC4hMH2abpm10n0eLLfTcZ79icTEV1/Cl9
	+CBEk40ohJvx8fEVAXlV7ozMhGXuYqoy6z1wkvD0ECdOUnkqXtOD8WUsdi8G6kJi
	S2WSlXRFin5NpAvknnwR21ztSlo04qiSCIw==
X-ME-Sender: <xms:73sVaWc25Qd1IZMEmv5zbvVDeB-lw4FuZmYAosZGVvCLDuQHkEuX9g>
    <xme:73sVaXN0mycqncr2rAXayTSyJC4zUEjrOdlc47-T4hmVPR8pfuQlu6m1gqGIQGFd_
    Xb5NgCF1Sc8xv2lV3W7Ql8RO8IBTBDAEVQzTIT2HJFVHe-2p7KGt4M>
X-ME-Received: <xmr:73sVacj0vQkyZ95b2y6GIh3vzhu_TLGaikr1AekSOYOEPZDVKhHLDWx7IgNpnohq20TZD1HUbpz-BcMI8fVe_XhFrBbRXx1S1mXEsqae9gM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdeivdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtoheptghmlhhishhtshesshgvnhhtrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:73sVaS33TME8V0x3eyxOridalaH6bRklK_4909d4hSOxzn_9jkGXEg>
    <xmx:73sVaejhlAQKju4COocwCdcNpkfEHkrpUA_miSX3iucQX1thqAV03w>
    <xmx:73sVaaft0HbewCZNVVanMqtnYiDCm0X-8UbQyC7ZappAwB3XOUAzOg>
    <xmx:73sVaZlNWLxYn1xgW5_BriovoG2SgRaet1fivJVPyTgo0ZV9O4MmzA>
    <xmx:73sVaQDlzz-qzjidIo-MHep-QTZXDk1svW6aXWMVgPISNztWThsBffDT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 01:34:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b7960913 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 13 Nov 2025 06:34:20 +0000 (UTC)
Date: Thu, 13 Nov 2025 07:34:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	correctmost <cmlists@sent.com>
Subject: Re: [PATCH 3/9] Makefile: turn on NO_MMAP when building with ASan
Message-ID: <aRV76Zays4L0u8CP@pks.im>
References: <20251112075522.GA978866@coredump.intra.peff.net>
 <20251112080215.GC979063@coredump.intra.peff.net>
 <aRRu1cxpIzd60AoU@pks.im>
 <aRVMggZi7I3vizc9@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRVMggZi7I3vizc9@nand.local>

On Wed, Nov 12, 2025 at 10:12:02PM -0500, Taylor Blau wrote:
> On Wed, Nov 12, 2025 at 12:26:13PM +0100, Patrick Steinhardt wrote:
> > On Wed, Nov 12, 2025 at 03:02:15AM -0500, Jeff King wrote:
> > > diff --git a/Makefile b/Makefile
> > > index 7e0f77e298..0f44268405 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -1587,6 +1587,7 @@ SANITIZE_LEAK = YesCompiledWithIt
> > >  endif
> > >  ifneq ($(filter address,$(SANITIZERS)),)
> > >  NO_REGEX = NeededForASAN
> > > +NO_MMAP = NeededForASAN
> > >  SANITIZE_ADDRESS = YesCompiledWithIt
> > >  endif
> > >  endif
> >
> > Let's also apply this to Meson. Thanks!
> 
> Not to derail us too far off topic, but... ;-)
> 
> I wonder what (if anything) our policy should be for keeping the
> Makefile and Meson build scripts in sync. On the one hand, I do not want
> the two of them to drift (too far) apart. But on the other, I am not
> sure that everyone who may be touching the Makefile are necessarily
> familiar enough to make the equivalent changes to the Meson build files.

They might not be, true. That's basically the reason why I'm always on
the lookout for such changes and try to help them with diffs that they
can simply apply.

> I genuinely don't have a very strong opinion here or even really a clear
> sense of what the right thing to do is. Just something that crossed my
> mind while reading and figured I'd write down in case others had similar

I don't think there needs to be a policy any stricter than "Meson
pipelines need to stay green". So new code files and tests need to be
added, but that's easy enough to do even for somebody who isn't familiar
with Meson, I think.

Other changes like this one here are not really _that_ important in most
cases. Git compiles just fine without such a change, and any real-world
user is likely to not care. So I think it's fine to handle these on a
best effort basis.

Thanks!

Patrick
