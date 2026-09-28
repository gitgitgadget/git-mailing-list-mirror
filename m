Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CC64477E7
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578218; cv=none; b=gfrz+7u6e4d65iaEqZDD5PLVybhdMPBX29329J9/6eGRAn+uGckRadnMH/l7aGBcsKipItyvxb9DpYaGtRZx9otTEdKyrJY+NP8in4M/B/ih6AvjK9iLIiucawc2m9CbwMeX7Jq44s5npE8Xoygn8ZLjQA/qeLfgfe/1tBv0MAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578218; c=relaxed/simple;
	bh=/DkuvMQ9eybwt+miDoWjgUG6/4BcR06mbqnrikgUpfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7gmxQUpFzC87n/x/kobmfTywik53SetayKVoPv0fU+0v7cugYyiRneOhzcoVptyPUCYhKIrbGuaivCfDrOXFTGV6UC/gUmI9jk1gQ5hGnyAyFrFkazaVX9qZ/RiOez6d886WXoWMRdhImyH13bgBIzrNwR/aykuANe3NKptfSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OPG5ReAv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZwlJN1e1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OPG5ReAv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZwlJN1e1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A30F8EC00D7;
	Mon, 28 Sep 2026 02:50:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 28 Sep 2026 02:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790578215; x=1790664615; bh=wYX2URljL2
	v+oPH4ywmrfR524ewnNWXChtgwB/zVBIs=; b=OPG5ReAvpa1cdPeQe4cm4uSjmM
	Z3DvRbvPrgLfLnX2m+2/hLinxD4mQmZfZemGdSNPwXMf6laQAmwhK9FaFkQ++2sa
	On9ki/SMDaHtxEoxJSd7qyA8/zExAwUTp6rZsdzV2kL0bNXtF/3CHvFQpQhrCFj1
	pNU4jc5vjjfb4ZCkLmAXuAA9SeFpjhiSPVCNuPW6s3bQS6Vz51f4QR2OeKM5eCeu
	9NpJWFvB+Z+aZZkGQSzHiUkPM4wVhOxaB01o2Zl6DzYouem8dB7pnGmxyCLVBcqI
	ZBnprv6bjegVMDDTyRarC3xSLknAOrNbpd+LC3yec2mGufti8NEgL0+AzRdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790578215; x=1790664615; bh=wYX2URljL2v+oPH4ywmrfR524ewnNWXChtg
	wB/zVBIs=; b=ZwlJN1e1qswe5pI8zUGudzXInZmPQYpUc6BORYPB0xNmS1yjY0a
	6H229b4VhpSldaRDRtimv27f+S5N/vZ/QcdMfgw0Eaa4sZ4HeEj6F4/raro+3gAC
	IWvzIKyWLBBH7X4oSTrR5TWaHFizAbsGbte1CukiHhYY18MIobChWU5wPudZclgn
	OQMRD18ISllQgau/F1KBS9V1nA0drXjyomCiqmCucxgdV4Rx1PQPCMoKQ4RlKrZA
	eLua+HPQog6h0jkNdvPtzh5QIG5uTrhVmB1OrVZwaiiXm4BQ6QZCmuwcMX05dJ++
	Fm9dnjvokFLvQzWNwvFbJ1L9Ykf/idcp9Gg==
X-ME-Sender: <xms:Jw66avyi65vf-F7PZHHXJ3rQeSFZKvIwoNefEgvpqtbsIGwuSEbiBg>
    <xme:Jw66auvE5JHnVEPw36MZr5h6827F9KqJtMO4INTROrRhslIseDYLxpvxwp7-3DS0c
    fGc53KukByvZXDYEFxoeaEDNhqY9RyWNsqdW7Fpdn99yWhx6LLCzmA>
X-ME-Received: <xmr:Jw66amsCdS4i1Plu4fiaP_TKdYsFjYcrUBIvcIwshQPuREkGvWUWLQ>
X-ME-Proxy-Cause: dmFkZTEeUW03Q53rsz1W6feYxipMrltRrzC/DhT3bxXW8qsVVI8ztfH985Ut2n50iDlrVr
    2s0fPBh1m+HYV1RdrTl+KTqd5ZuvWGIIFzvk+N/sBGGZU6J4Wey9L7FJt+ard3q6asXNFb
    IKTuy9pPB5WlCJPRH/UCU5PatySDMWl/GCxR8z5bKF1y50fkMhdjLCswRi20T6yPn+Q1ty
    QDFQE3+RFZBV8nhltWYN/NXuBJO6AYHAYQXIVcIU5Y+2Icb9S8zx5HSBvy6pagDtlTXOOo
    1K0SM/h/DRGV+/f2TitjX27fY3xJZ/08zzUe+rbDuGC05S7PfHpjE+81xr2LVK8p5ZdciB
    6vAifPzOTEij9nmjIwu1/kgpz95Q+0mNXYeW6xsrKPSbTDQfjokBRy0peZOzzRAMkxGS24
    TrG+B4ao6wFqzPukCB5ZTWylsxAitW/Sv/wVkHQANVMytwkmG51uLIguXnRhMe8nUmYxST
    yzJmi646t5PignG8Gwy2y6tJ2nJO1GSYWXrNwWMcKFM9RxY1kzFuhP7NOjFvap/qCxIwhL
    7MQEv2Vd0p9UcCbWSofrViW+Yd3RtQdsKydK7UAKPG4lSJTmDFeZXqdIeYwTIdpWOamfhp
    lp9jHTbPOuWBoB6y9E/ZeqPBKcVffJGZ1i51y+jGvb0pvg70scGosCcQvi6w
X-ME-Proxy: <xmx:Jw66ajOtbNWHfQ5UTG-YI8L_DgC_kHi_PHI8T9yKxiCV-KgxOyBuNQ>
    <xmx:Jw66ak0MR9K2pbxtRZ98l7JTLe3yTHDYsdBsUyWGFZqD44JM6Yf1Eg>
    <xmx:Jw66avPr2oT_c5Fcd5vW6jhpZ5eBukS9f4jFEjzfm46KGObFPMbW0w>
    <xmx:Jw66ak3SCe20HP6_O-qGKzhPma07mxVwb6uMg9Lf8ZYKAZ9MXTjTXw>
    <xmx:Jw66anO0CQVMpwvqIm9iWztF8_PeQndbrt-dpJfmEfKxLy8G0Sx7qpZH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 02:50:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0ebe5d7c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 06:50:14 +0000 (UTC)
Date: Mon, 28 Sep 2026 08:50:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 3/4] ci(gitlab,windows): fix Rust setup for GitLab's
 MinGW build
Message-ID: <aroOJHlxCs9Rnwv-@pks.im>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
 <57a83d15fda4ad3d4297f665d6c35e205e916e7a.1789819933.git.gitgitgadget@gmail.com>
 <arUH2KM2rHQwhmpf@pks.im>
 <1c829af9-1923-a6ff-78a1-b738cc6bf5a6@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c829af9-1923-a6ff-78a1-b738cc6bf5a6@gmx.de>

On Thu, Sep 24, 2026 at 09:55:53PM +0200, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Thu, 24 Sep 2026, Patrick Steinhardt wrote:
> 
> > On Sat, Sep 19, 2026 at 12:12:12PM +0000, Johannes Schindelin via GitGitGadget wrote:
> > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > index cd6fd4a504..3f24835500 100644
> > > --- a/.gitlab-ci.yml
> > > +++ b/.gitlab-ci.yml
> > > @@ -133,8 +133,11 @@ build:mingw64:
> > >    before_script:
> > >      - *windows_before_script
> > >      - ./ci/install-sdk.ps1 -directory "git-sdk"
> > > +    - ./ci/install-dependencies.ps1 -Mingw
> > 
> > I wonder whether it would now make sense to also hoist "install-sdk.ps1"
> > into "install-dependencies.ps1" now.
> 
> Honestly, I wouldn't. It is conceptually a different thing, the SDK brings
> a ready-configured environment (which _partially_ ships dependencies,
> that's right, but it's a Venn diagram, not a strict super set
> relationship).

Fair enough.

> > >    script:
> > > -    - git-sdk/usr/bin/bash.exe -l -c 'ci/make-test-artifacts.sh artifacts'
> > > +    # The minimal SDK's profile resets PATH.
> > > +    - git-sdk/usr/bin/bash.exe -l -c
> > > +        'PATH=$PATH:/c/Rust/bin ci/make-test-artifacts.sh artifacts'
> > 
> > Are we sure that PATH cannot ever contain spaces or should we rather
> > quote here?
> 
> Ah, quoting in shell, what a wonderfully magical world. While you would be
> correct that passing an unquoted `$PATH` as an _argument_ would cause
> unwanted misinterpretation as multiple arguments instead of a single one,
> _assigning variables_ is a completely different issue. Observe:
> 
>   $ x="Patrick Steinhardt"; x=$x=hello env | grep ^x=
>   x=Patrick Steinhardt=hello
> 
> Wha...? It did _not_ split the $x at whitespace? No. In what must have
> occurred as quite logical to the inventors of the Unix shell syntax,
> interpolating unquoted variables in assignments does *not* split at
> whitespace, unlike in other instances where unquoted variables are very
> much split at whitespace.

Well, TIL :)

Patrick
