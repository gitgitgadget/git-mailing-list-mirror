Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792C82D8391
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 05:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791524824; cv=none; b=jgyHwbT8XfOHUYTyt4oOMvJPtf2fCo0MYNDHeiukbJDQiEUxxN0aSb5XFb2EmnAqtNDHRQGimcc7WXhHxuQFoHCvOI++oNz/8k9RJ5Yg7/nCNQltYrMs7uEU3Syx+XXxPnO7R6KD3hju/P7U0WpGgmeyLq58ZKBjm4gnBaN7HJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791524824; c=relaxed/simple;
	bh=f22GI8cXWQrOhCoU0N0U2GIS2U5YEbkzl2G7Ob/ZQdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOorKRqJmcA+4UGTeJSTsHJW5/i8rKPqKb4dbUNJhP208vKjHB5+q/qqI0J/+X0saKDkloqKldZdwGqfZOS/HEW3GZ262+sxvXlNSS1qPhttsCOKE8/AkoCLC4qPQCgMB0RDD1dKiXAJUnFlrnCHRZWrOjNqMTyj9WpQzSLBUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LOBo1N52; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=edMvFtg6; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LOBo1N52";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="edMvFtg6"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7BDF37A00CF
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 01:47:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 09 Oct 2026 01:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791524822; x=1791611222; bh=yWeVCyBSPx
	hitr6hjDkLzJE5YbLXbBFBPqoqSdSNdXs=; b=LOBo1N52zG5WvL5x0cJH0JljQZ
	VrW9wm0VVDpz6UD/JdfPvvR5lNf2BuMEYT5T0HVR/skM9CdBxRdVVFf9AyM37Wxy
	2B0RNqj1MywwPSJ1P88NiEtyL98cu5GTpBYQzxYmHtWB06zwFH/oezs0WDm1ZKfy
	0AF6q8nv/Yzq1KhZ1QS26AX3MxYJC2jjkXceGMstyMOdkO1I2/TMwLl+9TrUP73+
	836IkbPfGqGQJ+8KbyekPrT7FdX+7gOJ3zddtNi/TM4oP9ldNOSBRJof93sQb3/C
	LRvi636nSCLgR0JmwGdAShx20c/Kgwk2kkjjoSE/YqMBarHoM9kiz5AJaimw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791524822; x=1791611222; bh=yWeVCyBSPxhitr6hjDkLzJE5YbLXbBFBPqo
	qSdSNdXs=; b=edMvFtg6gIn/hqIG+sUG9nuhvvw6ApSz7B1eTXPrrEVk0KPt9yY
	KDQ9euLXavPExafPbpPOf/TvuXg20l/4Tn14gMKsBB1BXTobW0gbUgPUp3yK5N1D
	84DhRdFPNx1l+wj7R8YSvdSWMU0swiqQNY1MoP+ke8Yxyhgq6PYDdfiUNnJfX3+j
	ZpugQn3mPfKj02QAp3CRFUWjciUE3LroM8xsQ1MfBaPzgakRHPBvznUokabQM5EN
	0CXAmTzK88I4BhqetyJUcFTnj8qvv0rbwa6U0ksJUvpAbYDyVXlyOjm8PV7UFpC4
	xvn/aAmIvjjQ7BjdILrFPaHK9hcl4QghQzg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791524822; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:pFhjdVCQ7ZXWeEulwyYekMu4L94vCM8UeKs8L1tnxG3Zfw8
	ESqP5ZqPVLlRerLo6sjkjhh4PduPoOh/3vvm06EPuNI9PkOVAgXpZzCRdue7j3kQ
	KVmZecSY2jlCawWj6FmirjajD51DOTYVFx4a9TsiXmvcRuPK3717Q0uuaFkj6Txw
	P3JKsjAebiTc+ZMPaT/1M+vaRyKo/mESQl5eSiK8mUh+vgV60Zk3G2ZOtZkJLyGA
	k5Ts57wDS/22aMDLHKO+xRhIE+U5uVorsrpnqULXJwQ5/yPwKBfwRQmLO/KmhuC7
	UjitH47PiIr7rC1vhXPlMeec766uYBMx9PD0/Jw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:jS+08dD7I/T29rRTokG3RbJhf+ZVIcDyZmYMA2LzATY=:f22GI8cXWQrOhCoU0N0U2GIS2U5YEbkzl2G7Ob/ZQdI=;
X-ME-Sender: <xms:1n_IatmIiaJuIadohP87yi1gEEknbEgZ-SC_U-_-TM06rNShcNEPrg>
    <xme:1n_Iav36vH7A6EnkL8CEaBtBSxR4BIjTKOewYvoP8eajRBmg1ltvHhNwSkftALXGw
    NF1bjzhrKuX9Z-0Cl6t2hK4OaqHNpaqztPw_rQbFsPcBySbo7lQa50>
X-ME-Received: <xmr:1n_Iaoo5HPXDzh1KJBlwHChcqUcIiS1kDnOzY6wA7bdnNn1OqbLbPZo2ExjTDBcissvI4A>
X-ME-Proxy-Cause: dmFkZTGLCx++7w/C+Ynd3dP6bfczdPxM1iIQyHBjp1QwJI0zyMZ7nJDm7urNojmtIsOBFw
    H//dPiRpAGatP9ThLn5ynjR4n2Wcn1ElUJRqXKwhrAmquInFYujhhIBxk6ecpr07aTQ+67
    hPp/q4KUBXZpsGPc2FLC5vG9zOPVtMLiP4UbvUGuw3ACPGjPc3m4Fj71+6rXt3Zyq+IiOq
    8c22mX9L1wWP9LvyyELqkmCNbUGbpxyVdVVFEoSqk7/rH09yblrOL5G3+zLYyDHJKSzcMM
    dlgMZW4XTrEK1GmnTveY+xicCb2lzErGbxtvny8NhCW0ujAgerJGFCsbSauFcbYQtwxbIb
    MAUP8eF6d62gZ5fVYs4jXmtf3tBvdwUW2Cts/9PQEAuAqSetfdSXZ4N999yEBbW1o9PwlG
    jjYTGx6VUygvN8XfRiB8lDRPd/7/HOTTa2FvwZusp0LpdWMxoAIyM4fy8fkNYToUfwZe4v
    gL6SC193yvmZx4A73FwVicaiApQGzIhFaS/LZ079MiZLEuB4Y2nJazwSfL4apsBQQ9wXJ0
    FwIr4IHznAQTu5l31xO5IJ3ttz3uYdzHbG4EnSZzJwkdVF6gT0xWe93CrpOMR5wnX650KI
    zl9V3rzRx7ZfpAkDeVf0t4tIHzCRCS+ZwYyOP1eb34Xuwg4WCpbWuYy222Sw
X-ME-Proxy: <xmx:1n_IaseJDknIul8xX8EY5OVORjZYDm7TGEFtAiroGUrmMYi3cYupBw>
    <xmx:1n_Ianqprm1J-tfHmGlUfnl0_yRhB88uDXLuEE5X0_31Yz2zdNqi3g>
    <xmx:1n_IatESsPZBDJZ68NUlXsKRbGFZO0A9cSdFzBJYKCbLQV5OrRpxPw>
    <xmx:1n_IanvcdlheXzLik7wZ61SI20edaatLw9zdTbCVnon6A3rpBxXmoA>
    <xmx:1n_IahkwzypedBZhWJESBfl2Mzws7Nqfnl8biyw_3hMzb4vj6nCXk5mf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 01:47:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id de721fd6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 05:47:00 +0000 (UTC)
Date: Fri, 9 Oct 2026 07:46:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] ci: switch away from unsupported i386/ubuntu image
Message-ID: <ash_0TF-PG710XJS@pks.im>
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
 <20261008-pks-ci-housekeeping-v1-4-baf015c589c0@pks.im>
 <20261008150336.CzZS-oEZ@teonanacatl.net>
 <xmqq4iew12pw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4iew12pw.fsf@gitster.g>

On Thu, Oct 08, 2026 at 11:12:11AM -0700, Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
> 
> > Patrick Steinhardt wrote:
> >> The linux32 job is used to exercise Git on a 32 bit platform. That job
> >> uses i386/ubuntu:20.04 though, and that version of Ubuntu is end of life
> >> nowadays. Furthermore, Ubuntu has dropped support for 32 bit entirely
> >> with the 20.04 release, so we cannot easily upgrade it to a more recent
> >> image anymore.
> >
> > Should "with the 20.04 release" be 22.04 (or whatever
> > release dropped i386)?
> 
> FWIW, I read the above to mean "32bit support, together with 20.04,
> are now gone", and did not feel any need for rephrasing.  But
> reading it again, yes, it can be read both ways.
> 
>     Ubuntu has dropped support for 32-bit entirely, together with
>     20.04 release, so upgrading it to a more recent image would not
>     help us keeping 32-bit support.
> 
> perhaps?

I think that still reads a bit awkward. I've rewritten it to the
following:

  The linux32 job is used to exercise Git on a 32 bit platform. That job
  uses i386/ubuntu:20.04 though, and that version of Ubuntu is end of life
  nowadays. Furthermore, Ubuntu 20.04 is the last release that has support
  for 32 bit, so we cannot upgrade the image to a later version, either.

Patrick
