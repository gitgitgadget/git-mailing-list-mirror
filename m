Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E0E18D643
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753958556; cv=none; b=YQ7GAM6bUKPusfcF1TgnxLXfRNDRtR2Et8vA/u39McjwG5tkCrBEA1lc88NBMv4JdowY663/wCus5yXbSV0CqfiITipAW/il34q4OLK22f6mU36ZdLFn4hNLmDKvXU+A52CpZviYnb1nZlJieJtvaUbSdAE3yajbIzoOEiJqZUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753958556; c=relaxed/simple;
	bh=ZWL3UDLwVTrekTCyZPSMgemS8BMCkBWGhzuRAQmOXXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyHzinpwwIxc3krB4lqTIU8A74hLMjwMtArMeH3OYRT1m9lU8cUafCitE6jpIldHq8z9+Iu2LUYD5HYo6A9UN1PETU4+O/K0Z/SmxnEROCanER4CY+nARrTTCfDerd2iXquwJHUza+RrJ6mMYwcuCzEYCuhxOIxz70/pt7ANAbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KPy5qVF0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pp3jGQzW; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KPy5qVF0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pp3jGQzW"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 066EA7A0B36;
	Thu, 31 Jul 2025 06:42:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 31 Jul 2025 06:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753958552;
	 x=1754044952; bh=3Wu0/mq142FB85kX/mhtZu4hRDo6HXWFbbfMZsC3Yes=; b=
	KPy5qVF0TTGd1Hp92pYnphwWC8oL8PZA/9bkJkH+TrHf58pm/xY+b1B/an2BW+/1
	MNeU3XnWG0YpTpbtG2jDP8FptGPfneaQ/T4XkgCNiszUC3DIi00XJB+AZgZ4+mdg
	GTlC0wRfDsmW0YIChtRV6KZSc8mZI1VVqpJDb1S+goOz2STw87VyEGb2evrTnodH
	8B2G7Glo7t0SlJa2Q4mANjINL3oHu11jhoQV1gpPy5UPe0JTBvJmOvv+MgsHVaW9
	QDWLt2uL2pCMnXBE4jgRdacxQ6B8FlhGgtdo67eAcHRbtNUCdRrpN0Vjj8rZ/mFg
	EwbwFvsncKfnVAk+9fLQKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753958552; x=
	1754044952; bh=3Wu0/mq142FB85kX/mhtZu4hRDo6HXWFbbfMZsC3Yes=; b=P
	p3jGQzWTXNFtGyOHKFGll8gle6yHTk/Kxjx/ZTAuC6iPOWsuJcXUSfVNHtObqGPb
	57z/E+Cblyaxk6VhwmtgxJ//9Glqr+XJ+iwnNf8AenNIusXqZIrun1lHb9ahJ44X
	mFnokMEyaV1LWSAt2mQ90in9QHu/5y0eBVtYfZRsNCa7LIxv9tn7HZfSLKViHbFv
	hAyOa7h7R9jCNeJRrEOVi64gT1aPrmvFB4x+iQ75t6Gs2yfNttzMNoga5Q6aze+o
	o61qsAfLCSiJsxRAPzk00fDHZHPUVTRoLQZ2wY4M2WNUuxy/UE1Zl40px8Mj5FJA
	yGLmGYa0PuBaQptai2zKw==
X-ME-Sender: <xms:mEiLaNENc6OzookZc8igbZ0BEzS4NwKTAdLA7hmgqRHgQ8xYLmXMuQ>
    <xme:mEiLaN06JZRSp50rwTmeLujdqoxQh2yK3yhAEci9J_tiAUXT_xj-J7FuwElM9gGQY
    hBO3Vxa5piVyltVOw>
X-ME-Received: <xmr:mEiLaFnIGfbUDqyF7jd4XxHAUyxQZhCFXJYzrso0iZ_hXNR6evUMbLhV7BWj0hIjqBDLC2iE8-GyDdMbGylgjK9_QRn-DE-8FUFIaCi46A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskh
    gusghgrdhorhhgpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtph
    htthhopehmlhgvvhgvuggrhhhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:mEiLaN8AHAiDGHGrqpsm0bI3Pp1_Tcwe02lolMWQyWlEzIIHDK_QYQ>
    <xmx:mEiLaKoSRdDdS3S7o6QnVlFUzVn2X5cvmsdiLqGMxL28yLhNdGntsQ>
    <xmx:mEiLaGn2HrPByc2puV0PDxPfPlhBACEVJwDWGTxxxzC4btPwuwzz2w>
    <xmx:mEiLaBiCzkN04QxLw-XA7e2P7EJfkYa09UiYezLUwy_VKQrZZSfAmQ>
    <xmx:mEiLaLLHfNYAj2Om_QL7pD18WBqF82W9zbaGedu3LFvlwF3pPcCw5yaw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 06:42:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3116fe20 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 31 Jul 2025 10:42:29 +0000 (UTC)
Date: Thu, 31 Jul 2025 12:42:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: [PATCH 4/5] git-gui: honor TCLTK_PATH in git-gui--askpass
Message-ID: <aItIkhAPMuq6tlNS@pks.im>
References: <20250730164052.15371-1-carenas@gmail.com>
 <20250730164052.15371-5-carenas@gmail.com>
 <cb63b63b-4a74-4649-bebb-002d1e6e66f7@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb63b63b-4a74-4649-bebb-002d1e6e66f7@kdbg.org>

On Wed, Jul 30, 2025 at 09:02:50PM +0200, Johannes Sixt wrote:
> Am 30.07.25 um 18:40 schrieb Carlo Marcelo Arenas Belón:
> > diff --git a/meson.build b/meson.build
> > index 1cedc82..320ba09 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -38,14 +38,6 @@ version_file = custom_target(
> >    build_always_stale: true,
> >  )
> >  
> > -configure_file(
> > -  input: 'git-gui--askpass',
> > -  output: 'git-gui--askpass',
> > -  copy: true,
> > -  install: true,
> > -  install_dir: get_option('libexecdir') / 'git-core',
> > -)
> > -
> >  gitgui_main = 'git-gui'
> >  gitgui_main_install_dir = get_option('libexecdir') / 'git-core'
> >  
> > @@ -61,6 +53,20 @@ if target_machine.system() == 'windows'
> >    )
> >  endif
> >  
> > +custom_target(
> > +  output: 'git-gui--askpass',
> > +  input: 'git-gui--askpass.sh',
> > +  command: [
> > +    shell,
> > +    meson.current_source_dir() / 'generate-script.sh',
> > +    '@OUTPUT@',
> > +    '@INPUT@',
> > +    meson.current_build_dir() / 'GIT-GUI-BUILD-OPTIONS',
> > +  ],
> > +  install: true,
> > +  install_dir: get_option('libexecdir') / 'git-core',
> > +)
> > +
> >  custom_target(
> >    input: 'git-gui.sh',
> >    output: gitgui_main,
> 
> I can't comment on the meson part at all.

The Meson part looks reasonable to me.

Patrick
