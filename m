Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841EE29ACDB
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206190; cv=none; b=YX7R9YULh/bNZY+zasn4gUov3L4lZaEYOKPIGgI/tQColZsQGEjgtUyH5lx0x2qsx8rNYpMQK5c9JocI3IlccstxyzIMrO6v215CIfWRZAKEGdg/gQWPtItO/INCt+D4E1uuvnKMv5ICimo9xjGT9qlDX7UD8TSDrtWTnC+QOUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206190; c=relaxed/simple;
	bh=Fb5OQj6wxI9Kur8Ar5vLcwaPaYBRSPbp4V2LWK5IxIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtLwKKA2qwikaod0b2aalYawnJE484TnagN/SrugMRLISuZx+NcgprnhklB4mWU/jXrbDtRZfNZG2lih33ptEonvxDHuJe4vxnGcahFFWeQVYupX6vObPCR5uEAJjujotm7mpbFfgJdrEwiXzuvoAItZewvinWwQd/7U0B69q6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ATz6og8N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VPW5YNH5; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ATz6og8N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VPW5YNH5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD1817A0176;
	Wed,  4 Feb 2026 06:56:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 04 Feb 2026 06:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770206189; x=1770292589; bh=n0n0OeXSp+
	fxgAzKzI/uMigd5XcRuRKyvOjQrVjr+Tc=; b=ATz6og8NwAefKF/we2nx5GgZ3W
	zIARZQtNd1OsqJtJJfgTNx/wkF06wunCtRySVdJQOG3D5oiTOUzX7ushIu4Pzfur
	/yUO12RGuLpg19zC5wKXibCWnl90PPYdRSFH9qMiEzBR01jNy/H3EdcE9TtrUHbF
	M5NC3URu+fVAEINw841XWHVmMVP5Ysnt313FBSEkY9zfL/S91UdGx+TemLG2dD4K
	qn0Xn/Ex8TTjiTh7n3cZ/7DPvYhYgbWJkzONuT19CoUpJfNEyHo1HBg+s2TQ10fE
	x6+Sq8Y8QGqr0Rq+bMmFMMXUas6lqbKjWYan1kXAJztKP3wLFDAHgvzqJFgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770206189; x=1770292589; bh=n0n0OeXSp+fxgAzKzI/uMigd5XcRuRKyvOj
	QrVjr+Tc=; b=VPW5YNH5tjhb/9pUcVFAEGThy9/abyWCwGrJSL0cX9kjsFxVHGm
	ZV94Np9RIzUNezqdIn2TIjDrQjF4gyn+kyC73MJIc2sa0k3rkjLueG3eaeQ7e7BZ
	4SDvLCQl+FcF91I+V0pF1iEprNaRnOGsfO7tIybahX8IKUXEBd6cXW61DZWTtcwP
	a1ZjkJeNFbj7vGWINXQpiwIFDXhS7GIlafTwgkE9p0GxFulTEr5jp83kDYFcb8d4
	VZcBx1/3vmFy+vNsS+UvupbmyA81kvzSgCfSPwfp+NrwZ1QHhThppLEtROrt9QNz
	AuHGKXxW1361yfVYYZemoG+gWZfV5AO2hQw==
X-ME-Sender: <xms:7TODaWzA5zWPGuLkWPuFpYKlpCu_RS3qrWpQ4Bi4e-8vY3D2vCfv6A>
    <xme:7TODaZvt7-diXKUJTlN29uNrnZAHyGK75QDWH7BHdBV1W44jSxxYzrQxl3MwBQwEl
    cHgRkqsvx4r4zcgmX3MmhGDlOTaf8xaY_90njMxInE6NaU5utU>
X-ME-Received: <xmr:7TODaVt1A_rCdI8byuIDCh8K0d5YX2b4a5izkRljAq_XN0dKd26Ys4jKSIdI0BXoXw183mBWzFe313C3waGwwR2RpwkNxcLFXmsLo8WtpX8Jgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:7TODaWM9l5FTQ0nGCclPlq_TpUtx_ZZWcPefgeGKoPd5yqDUL6JCVA>
    <xmx:7TODab2QMbpTsLklcDrRctkrrBskboH6-1vDyCpi3L2CiD3uRhZB3A>
    <xmx:7TODaaPv8S0-lySTbx8FiNsDKJgiLBBdNKnu-iDQ4cQDwQ0LEMus1A>
    <xmx:7TODaT2EZp8U4LHOn40irXLJwHeHJ9Iv3FPyWZPZC6WTEJL9pzoVTg>
    <xmx:7TODaTZ-zWC8uGc04AwAjICiej71Rz48Gdh6Sow8EIY1VCzEHT8xp928>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 06:56:28 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 25d5f226 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Feb 2026 11:56:26 +0000 (UTC)
Date: Wed, 4 Feb 2026 12:56:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] meson: wire up gitk and git-gui
Message-ID: <aYMz6A1kBUO6FQf9@pks.im>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
 <20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>
 <CAOLa=ZSeyKJD07xHKezQzry6KuwNnB=DzwE81Sx0A+b2u41rjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSeyKJD07xHKezQzry6KuwNnB=DzwE81Sx0A+b2u41rjA@mail.gmail.com>

On Wed, Feb 04, 2026 at 05:00:11AM -0500, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Wire up both gitk and git-gui in Meson as subprojects. These two
> > programs should be the last missing pieces for feature compatibility
> > with our Makefile for distributors.
> >
> > Note that Meson expects subprojects to live in the "subprojects/"
> > directory. Create symlinks to fulfill this requirement.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > Hi,
> >
> > I have upstreamed support for Meson into both gitk [1] and git-gui [2].
> > This small patch series wires up support in Git.
> >
> > Changes in v2:
> >   - Use symlinks instead of moving both gitk and git-gui into the
> >     "subprojects/" directory.
> >   - Rebased on v2.53.0, as it's been a while since v1 :)
> >   - Link to v1: https://lore.kernel.org/r/20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im
> >
> > Thanks!
> >
> > Patrick
> 
> 
> So in the previous version, we moved these projects into 'subprojects/',
> but we now use symlinks instead. Do you know if there is perhaps an
> issue in Meson to support configurable subproject paths? If so, we could
> eventually drop the symlink.

There already is such support: you can configure subprojects to live in
an arbitrary location by setting the `subproject_dir` parameter in the
`project()` call. But there are some restrictions in place here:

  - It cannot be an absolute path.

  - It must not start with a dot.

  - It must not contain "../".

So that means it's not possible to specify the top-level directory, and
that seems to be a concious decision.

Patrick
