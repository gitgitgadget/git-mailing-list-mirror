Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48883A2D
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 04:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726633885; cv=none; b=kQVG8QquskCmyI/2RxRqzJezTatBrfF2ZgrOvMBQZZaWQpSR5M9EpecJvhHW5OpaiMTyWrBsI24DjqPW2kJETGwFrab9X9+n/ErVH+yV8s8ap2qR8g3/d9yNe8hykyT2tulr1Zr+gVThN/RQhFeMmmtyhKViPqnQcVFYZ22jjKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726633885; c=relaxed/simple;
	bh=q7KpNI3lsX+O2KmFNJ2iw3MV2avVZprUh+gTowWrYh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kp2ZfgxGQmxmIFm+vCjQca9sRgqtYW4Q3XyurDNCRFQ7wjE7GgTbIu2Kw24VteFaMM8RfFUEbHSeCED1XKC/TxHf7HT2jDZFJ4AD79lBjRyPyVY/D8mYrPOnUL2k1H3zVlspkNce4yIL9vIucMlIiX/2OHaRwj3gPONUmlYQeQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k/46wtiX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e7oPScVH; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k/46wtiX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e7oPScVH"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 4011D138025E;
	Wed, 18 Sep 2024 00:31:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 18 Sep 2024 00:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726633881;
	 x=1726720281; bh=lwLI6dS4TRAxzt2pH67hb2MRDZMOBbvKW55ZN7Gpnso=; b=
	k/46wtiXTgtJFq2fU0Y+obwnzOUfqZss6bQ39R2m+Ivqn8QSoDfH+dFGuh4czUb0
	C8YQNhDzvRAUw4x82g7DoSVGwuHC7ws7jk3XNm82u/Fon3MnUpIlZNKzqIKe59Pn
	m6SAgzlsHsMssrZ9stqkdts2XFshbmNgm6oIYA1ZBTmEbfBrzEviGOkryYuzwmNB
	am+lHYSRwfyG4QRr1frU4Hu8bm4l2O2JSX/VFc2Rx9u9ngi9dOFR431vs5VImS0+
	V0XSgOBsiDcD+SJNLF5bn6i3OmzQQGhL+JGBLZ4GxJX+lVVydQF0Kz/iWeV5bY6O
	iZN3/NQbk2MrQAM3bgxJbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726633881; x=
	1726720281; bh=lwLI6dS4TRAxzt2pH67hb2MRDZMOBbvKW55ZN7Gpnso=; b=e
	7oPScVHOIjQ4D9/+xVWBSsls+e0QWSMIKoEKQBaOaRpA/gR4s9Ik81p9kp5S3gAO
	cZv+3CcfYiizpRgmRH8jH8/9ImGjv7WGBvlUbsDO9vHMMLhgFKSCMQ/q2KzJYYXb
	CxVl3ay5hkmSXYPEtVxSZ1fENj59a5mik1+Vyke0B8LRArV4j7tBtVD3YlyZn4s5
	nrphsrLtVSOxuVqh0NO+nQb3ggwSw+n6Ad/nXH7xO+pbdKsfuZmH9Bgi9bZwMvO5
	bMC9AOsnnV0HtLQJKNjkDWOyqW37ZzFHbv7/fREIvKva1WaD/EJgWVOhc33NYUFD
	HRSVqZW+digG4xglWyrwQ==
X-ME-Sender: <xms:mFfqZpPsDB6vdj75ohTEWEV5eg3D0xr5EBLmkJqNhtFQiHx5sTuj_g>
    <xme:mFfqZr_ohkE8juX7b17eLk7kXkh0YuNtXRtCHsSDt2tBUwQnX96EsGbaEIz_HndME
    kznR6DwweYC4V6WnQ>
X-ME-Received: <xmr:mFfqZoQLAUVU_HK-FMUFQCdnoFH5E023pWurgjJDFJzw35V3PAbYy_C7kxwEQIm5SAE7vbY3NmyFgne6G9PXhFh5h5XtAya039OLAisaI8Q-mYVc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekkedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:mFfqZlvrXaxSMRvtEIiZ0UUB_DUIA-vc3Cd1jaMm9sN3aTUyEBO-ow>
    <xmx:mFfqZhe8mOMVDwlry5ukrYkRm15trOfy-ZM9vuGLWPjOidpFm8Ye7A>
    <xmx:mFfqZh1cH_knZQGUt77c0MP2NZtNXmLGMxgtYdG4Xwa_Tk-_xnY1VQ>
    <xmx:mFfqZt_XdcIgItE5ItUzP6onUwRPffpDzSKsRBRTz71_eroMDXSe3A>
    <xmx:mVfqZl5IGtCjFInv6TUPqAYfi8dJAOivRrs2fe4cGlZp7hH9TBuZS5Yj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 00:31:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cd69e550 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Sep 2024 04:30:57 +0000 (UTC)
Date: Wed, 18 Sep 2024 06:31:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: karthik nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] refs/reftable: introduce "reftable.lockTimeout"
Message-ID: <ZupXlaLP3QcP8SPb@pks.im>
References: <cover.1726578382.git.ps@pks.im>
 <ca3eab99f7ef86d1b7a5b4d4bdb8d2b0a55566e1.1726578382.git.ps@pks.im>
 <CAOLa=ZTja-nFmKZ8iyyp0szuaAWAnPncy0E6rM5=WWgnr=01uA@mail.gmail.com>
 <CAPig+cQ_+C65V6Rj9uCBKJy-rdymRd93-0S_w-bfSSJj82Zsrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQ_+C65V6Rj9uCBKJy-rdymRd93-0S_w-bfSSJj82Zsrw@mail.gmail.com>

On Tue, Sep 17, 2024 at 01:50:27PM -0400, Eric Sunshine wrote:
> On Tue, Sep 17, 2024 at 1:46 PM karthik nayak <karthik.188@gmail.com> wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > > +test_expect_success 'ref transaction: retry acquiring tables.list lock' '
> > > +     test_when_finished "rm -rf repo" &&
> > > +     git init repo &&
> > > +     (
> > > +             cd repo &&
> > > +             test_commit initial &&
> > > +             LOCK=.git/reftable/tables.list.lock &&
> > > +             >$LOCK &&
> > > +             {
> > > +                     ( sleep 1 && rm -f $LOCK ) &
> > > +             } &&
> > > +             git -c reftable.lockTimeout=5000 update-ref refs/heads/branch HEAD
> > > +     )
> > > +'
> >
> > Nit: This does stall the test for 1s. Which is slightly annoying when
> > running single tests locally. Couldn't we achieve this by doing `sleep
> > 0.1`?
> 
> `sleep 0.1` is neither POSIX nor portable.

The above test also verifies that the timeout can in fact be overridden.
If we only had `sleep 0.1` we wouldn't be able to reliably verify that,
as the default is a timeout of 100ms.

We also have essentially the same tests in t0601 for packed-refs, I
mostly just copied the logic over from there. It's not exactly pretty,
and I'm not a huge fan of introducing timing sensitive tests, but in the
end I guess it's okayish.

Patrick
