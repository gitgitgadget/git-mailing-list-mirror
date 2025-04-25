Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7304822B8C3
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 06:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745562351; cv=none; b=OtM9Uzv79TFMwmc/pN4H6Sh+snGrALgS9Q2Vblp8hl6VjyLAjAIPetW82Rmxj2QxrLBPD3kGsToQoueCEl9StFGLkFZDXwDVMPOvMLTvVoYU/UF2nWOldGZxtKOl4UQ3Bg4pCFeaI7kFDSNeLn9SBJji3atSmqRuB9tDr8Gq1fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745562351; c=relaxed/simple;
	bh=KOExOUws+BDC9S0SWTnwJlRPNdOPHkdZ8YBGmclXX0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3e/0+IKKWCeG0RT+E83Rb0i5JIjHAww20FKxZshdlBp+q3QmQpI9BeVWAE4J446VhXH0OrWx/VCox2ZHMBzMvc2cCZxAFZukwja3n3AMXaCVQ/D8L5ufQd/1MSPV4A06l97uoaseadTMHgyyAvdxHMsNQIkPiEax70KLm0wwww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wH2TJe3+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SS44242X; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wH2TJe3+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SS44242X"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7A4B21380217;
	Fri, 25 Apr 2025 02:25:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 25 Apr 2025 02:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745562347;
	 x=1745648747; bh=GZzp8+pUM98fK+mMTdxj0SkJCgrdRxp+Bv0WpRj6sHk=; b=
	wH2TJe3+ZyYf716WGvhCFUjkvxujG+AH8JxolpVfaq3Rjz9G4IE8phDUgD7dcT0h
	SwzT1CWKAxU3AsiNYDIikSHHmhCgFwYlxpTPnIH05EG7pCWEyOsdHqt/qBweoC9T
	YU/OOI08113dn5ysEVpbw0jXXzkFHB48s5/R8Ojj1MmUQYJdEyh2ILg9gZ7ofvux
	lR6AHaQVedi916mAtpzWsly1KzWclIIsfh3B1FzYJi2av+h6Iw+bJhJyDMINDyaW
	EZejDqBMKAFvEB4auFQZUtAjJGO5JK3XoHDvp0afUaJNYAJHohr4wmHE0Y3XPs2E
	7m4L0TtYbp+173nvmsDTVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745562347; x=
	1745648747; bh=GZzp8+pUM98fK+mMTdxj0SkJCgrdRxp+Bv0WpRj6sHk=; b=S
	S44242XOMRXwst5QGWLYzp7CXTvJRP8fXWOHhYXa1ZKPFaJqHmcK3us+N71mfkOr
	wZ3F0UnbemH8aa02lHa82kUjyanzdvUaZsAPk1MZKepWUg/LI+1x6kbHbSyBmFU/
	FbtzOa6Fwuejw7iFIScXbEshtklXqrCRQDjWZOvFES0ggqHZT0PcftF9Pk/yb4f2
	Lo5EC/ZSXLHQ7yaIDe4c14HTIVGaq/fTddA7UEzDpANR0MzQSKPSQqZfN86fwye0
	1jjWJ6dXtmiu8XTOpRARLL1VNcKNIXOK3VmrQct51gLVqOYNN97aURzJ7YcGtIg0
	92dMcBJoCpCqFvsA5B0pQ==
X-ME-Sender: <xms:6yoLaCLl3-fugKvaP07K549g0WA1JBKACpeaCOuTVAqrdD2SZGxa3Q>
    <xme:6yoLaKI3f-Fha6zZ-8oDlxTi8hFvFXUHYYtLMS3wcXu6s-dKmWJ7zQuVNUiCD4d1u
    8YLA1ioW5cft1hyWw>
X-ME-Received: <xmr:6yoLaCuU3gs6niBHuV7ExV_bYVyd8uFyhzFaoo9PhQ0KLV4MlZ0xxPIE5J5YG3iiDdftmNhdpT8qj3x2cwGMEDqBxZpglHy1U2p0cpvJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheduieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheptghonhhguggrnhhhqhigsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6yoLaHYkay2k9xqVN8KfoiHT50rSc02Gw2LuXJEFYSVKiAhxa7obMA>
    <xmx:6yoLaJZObMbdnmaP7pRZWA9HAsT0a2jlAApdmDJ4y4z-FN1LMjVuvg>
    <xmx:6yoLaDDW5tENHMU_QayFmkjpTstr-sU-97kNaSC41vc4uYHhVwtsCA>
    <xmx:6yoLaPbjlUpaPX988qd-5MclWyPjLA7TLBNgD1nv6TC7uPA7vKl-zQ>
    <xmx:6yoLaA2901W5_N34jHEwP0AcysS5OtzMKdGfXXqd58Gj1U5oYVyynazV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 02:25:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b3411927 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 06:25:44 +0000 (UTC)
Date: Fri, 25 Apr 2025 08:25:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] meson: allow customize perl installation path
Message-ID: <aAsq4g_ddLZlKpVg@pks.im>
References: <80a2a6ce7c6b05323cf931cdc20d4decb6270002.1745507677.git.congdanhqx@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80a2a6ce7c6b05323cf931cdc20d4decb6270002.1745507677.git.congdanhqx@gmail.com>

On Thu, Apr 24, 2025 at 10:16:18PM +0700, Đoàn Trần Công Danh wrote:
> diff --git a/meson.build b/meson.build
> index 223384b130b62..830deb9a069a6 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1826,14 +1826,19 @@ if perl_features_enabled
>      perl_header_template = 'perl/header_templates/runtime_prefix.template.pl'
>    endif
>  
> +  perllibdir = get_option('perllibdir')
> +  if perllibdir == ''
> +    perllibdir = get_option('datadir') / 'perl5'
> +  endif

Makes sense. We try to do the "right thing" by default, but let the
users override the location.

>    perl_header = configure_file(
>      input: perl_header_template,
>      output: 'GIT-PERL-HEADER',
>      configuration: {
>        'GITEXECDIR_REL': get_option('libexecdir') / 'git-core',
> -      'PERLLIBDIR_REL': get_option('datadir') / 'perl5',
> +      'PERLLIBDIR_REL': perllibdir,
>        'LOCALEDIR_REL': get_option('datadir') / 'locale',
> -      'INSTLIBDIR': get_option('datadir') / 'perl5',
> +      'INSTLIBDIR': perllibdir,
>        'PATHSEP': pathsep,
>      },
>    )
> diff --git a/meson_options.txt b/meson_options.txt
> index 78d172a74019a..43f3f2d234a8e 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -1,3 +1,8 @@
> +# Configuration for Git installation
> +

Pedantic nit: let's drop this empty newline, we don't have it for any of
the other sections, either.

> +option('perllibdir', type: 'string', value: '',
> +  description: 'Directory to install perl lib to. Default to <datadir>/perl5')

s/perl lib/the Perl library/
s/Default/Defaults/

The remainder of this patch looks good to me, thanks!

Patrick
