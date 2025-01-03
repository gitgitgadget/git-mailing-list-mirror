Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11D516F8F5
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735886427; cv=none; b=FvNA3VVhXiEJRNMgEwbeJpRALvEiITWQzfg8MgFcI2y1FceLv2g+yLeaYAAUznRqINNKBpwa5dwOxnJS/cLN7pevWBdmBBwtpSkHlP7NvT8aTu7dZt3KVuyU8lTIUyf6oWH6zkpouNLC+2VmjHiJjTt4reHp/KAiWS3d/REs++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735886427; c=relaxed/simple;
	bh=skvE2xkx34bfWXwc3Su/PIW+GTeicbevMKcxolW1BFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGv2Mt6gIik44DmjYPp3g30w59DQhLEile7lsGBgm7jS+HsLb1sJ8RwOUXHfY18UOrsROitZJrnbdgI4t6twBIfaQxZ9Mejhlqcq14t05/FkSFZ+BvillcBQDNxwtz+gUHTlFk34BuTmzfU5or8Redx6/KB94WRvtF8DJUyxBds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tZ5WGizl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QV0HPlMM; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tZ5WGizl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QV0HPlMM"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 8DF8713802E6;
	Fri,  3 Jan 2025 01:40:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 03 Jan 2025 01:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735886423; x=1735972823; bh=bHdkWEWslt
	5Vjcsrwi1g5dDyq7SRhLmR6HxrSDlhxcw=; b=tZ5WGizltVjawUDRsno7LQVJka
	1QHlnpeQ2rBtscO60cyWgbOlPBfGHXeGlmvV4zSKS+PxYuggLGUBfM3z1W+T271w
	5+T6v2ANu8QIvAFZcCGl5gjeYl5Olv3dlJjffMKL98UkQNrQOHF5lKyi1hJazc2H
	NoLMHwer3aJjrQ0cgbJe5ZhocVnoMNgXgNSA6PuSuogPBHUCzgVOvDJpyqMr5bFO
	JiQV0i64+ui+pgE1HqJNgtmEWt12Id5KcqOzeKg2uFMPgLF4Vd18jS8Dxrtr7cjC
	wq+21Io5X1xj0LdqTKuJHxMwahkT9oJtpwZXCDw0xQlCWf6L9hQ1qq1o/B5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735886423; x=1735972823; bh=bHdkWEWslt5Vjcsrwi1g5dDyq7SRhLmR6Hx
	rSDlhxcw=; b=QV0HPlMMTIDpXXdwyda2ZhVL3p4snLae0vRSoRWDUkKVJ2K4P4k
	GUepzMkZ2RMCaSpI+dELnnh+8g6ikU4xHJWaHk7/CHGG6hvPtoUBOKj+yIyo+lfw
	3gbmt2Xj6yPIA02GBo1omx7BL3GpLvJ8vFBvd8+1rnqcYJN4I6ug3HfrYYWgXc2d
	PgERgC1mtBI7F4Bw+3ScG/HEi2R+3/iK1sp76i8sEjRk3nbohQBUxA/EhAQKlhWI
	0wAS6zPzsAiSG/STIo3PFs5MVDqZ/dgOp5hZAPuGcweIS3y6lL3vxOfl2VRFyOhK
	aUdDfFF8x/fXEhME7FNjMhkvhdvtqzDdphw==
X-ME-Sender: <xms:V4Z3Z4vz-EnOP55_-24BxOxxpgBX7Jnkdx1Wnq_tUvF-RBFeMJwjSg>
    <xme:V4Z3Z1ew6H9zcedMgQMP2kcTgAk8ScD3w6EkxpnQQFlgqc_OOnmNiTad8b7p5aTUT
    JxejcHHW-zVrNxSWA>
X-ME-Received: <xmr:V4Z3ZzyXFX5rkagDiZRP82qe-yDlfVxppN5tyuM4ZpPF4lNkEt_Y79Zc25PabxAmp4YoR6avIJN2eOgFx3Ozv0T2Ro7kF_I9OPKkJ2xLRw7Lass>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeffedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrh
    hnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghnugihrdhkohhpphgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:V4Z3Z7O4RM1Y6QlLH3HqJshmNyBl_RPv7ixusV8EGR5sTVeNNYnhzQ>
    <xmx:V4Z3Z486e985SiuxmVCkI2VNDQf_Ab-zbp_LU0JHM1O44IEzZ1zjSQ>
    <xmx:V4Z3ZzUFz1zR8hpPrSiRRWD9_skzLpmBHzuS0Q3lJTYeX-T59q3ANA>
    <xmx:V4Z3ZxdnTLjO0BKVZe7bKLxy35EP_64UgNeLurhdRuK2cj4iaL9oEQ>
    <xmx:V4Z3Z8YhJbq7rhkQ_o_qEvtrrCxuL4x98E2kWmXF-QK5-g6_nzLO3NR1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 01:40:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2a99dcbb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jan 2025 06:40:18 +0000 (UTC)
Date: Fri, 3 Jan 2025 07:40:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Andy Koppe <andy.koppe@gmail.com>,
	git@vger.kernel.org
Subject: Re: meson-test syntax error
Message-ID: <Z3eGS68PkwDtBl1V@pks.im>
References: <CAHWeT-boK3x6mup11boEinNDQiAxxf0vwvZkxsGRc_GRvXYA8g@mail.gmail.com>
 <Z3ah2YQSx4ZreBpK@google.com>
 <xmqq5xmxwabj.fsf@gitster.g>
 <Z3avRmaMr70FOs8A@google.com>
 <xmqqr05lusvp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr05lusvp.fsf@gitster.g>

On Thu, Jan 02, 2025 at 07:39:54AM -0800, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> Jonathan Nieder <jrnieder@gmail.com> writes:
> >>> Andy Koppe wrote:
> >
> >>>>   make[1]: Entering directory '/src/git/t'
> >>>>   rm -f -r 'test-results'
> >>>>   /bin/sh: 10: Syntax error: "(" unexpected
> >>>>   make[1]: *** [Makefile:119: check-meson] Error 2
> >>>>
> >>>> Due to this line:
> >>>>
> >>>>   diff -u <(echo "$$meson_tests") <(echo "$$actual_tests");
> > [...]
> >>> I ran into the same today.  Let's discuss in the review thread
> >>> (https://lore.kernel.org/git/20241213-pks-meson-ci-v2-5-634affccc694@pks.im/).
> >>
> >> Probably this one?
> >>
> >> <20241227-b4-pks-meson-docs-v2-11-f61e63edbfa1@pks.im>
> >
> > Ah, yes, that's the one I mean.  Sorry for the noise.
> 
> Sorry for being extra sloppy on this one.  A patch like that with
> blatant bash-ism shouldn't have slipped the review process.
> 
> One thing I had trouble with is that, with /bin/sh linked to
> /bin/bash, none of these
> 
>     $ SHELL=/bin/dash make test
>     $ cd t && SHELL=/bin/dash make test
>     $ cd t && SHELL=/bin/dash make check-meson
> 
> seem to fail for me.

Sorry, as well. Thanks for the report and investigations!

Patrick
