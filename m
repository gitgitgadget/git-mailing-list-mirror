Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8978C1CFBC
	for <git@vger.kernel.org>; Wed, 14 May 2025 04:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197398; cv=none; b=lmlE9514oz6s5LBE1cm3J20b1Wf1KGmBPVVCG2Y5QterkFwJpDCQTj2XzDi+JP4zyacK1z3Vy8u725dFv9hlAR974RQSCl4HzEDe/NhibOV+WRMx6EebY/CZ0t+sAnMWQlwof6xzQbJYaXx+Oex0wXtO7SSfOF4T5WgGMIrdTHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197398; c=relaxed/simple;
	bh=KyOG4yua2gduaIlk1yDUba9AKFFCj0L/zNPoADVo59k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdIsikGEhKIZrNIi0+1ZBESSLk4jtz3pQbOBUpD0newXF5k5CgoYjfRVkpW4PApJfGSJJ46LYSrFUACah/5mJ3jma861DBa6husrytGjHwcYuIeWH6cpuNsSsk2oTznOEXWusNhBlzuiUTj21QzkS407352AOeBeSCwWaeMULPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=2uNFGe7a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DY45KOIm; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="2uNFGe7a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DY45KOIm"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9DC3913801D3;
	Wed, 14 May 2025 00:36:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 May 2025 00:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747197394; x=1747283794; bh=08PMu9dqqo
	i9Fc1CfUtdumwbC0h9FiGyJAIYE3nwiN8=; b=2uNFGe7aN+Hq0SLxj+zWEQzKz9
	Zhpi9YjxZaMHATRJk7Xt2KxCsOPtCSPnE1ZwhIWGvRxCth9ooGwAZo1WdAT01lYf
	K+78lEPrpUw35pkR3Kb/GoaQapKmrPd5hitjMMDxyny9Cukee3q8rVxUFbdGELgi
	ryJAIddlfQ7OnH/LKsvvRb3D/v0Wo6kS4+pfOrUgfksumB9i1cqNCcfDDzvnoPao
	UxV+ap9D6wXCpX1H11cNMGVTs7x4g8FK+H2qrPGrH8Cn2glesQKEgjOQhUgwrcAu
	t7yO2cg3+qVUv6cUivhTrA26UfnhD3RqfpKDn67bLnMePBnsgCY9RyuouDHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747197394; x=1747283794; bh=08PMu9dqqoi9Fc1CfUtdumwbC0h9FiGyJAI
	YE3nwiN8=; b=DY45KOImbqUYSdT7rUyLeURJWmBlqAtHBPGr7ptO0/UdeOFbrDQ
	RH0vU56iVCpkvOx/zULF2JWj+dogZ5BkGS0VMoS1qEwYXWynx95CfbqzOgxyyx7g
	fkfag0+OOcu84d41JbY2KlbTybm4Y/G2WT95aW+4QNDolQLNDZx+XYoHpScYlkUf
	0mcNT4bzBYV3k5X71+qny4+3esm947qXbTteLjU3MmuAuj3ciAlRtY4wqdRkzGPg
	npnq6B1Eo5JfidjrVOlTQ6fJY+iL+DujBRn578fZ7wiTivGAY8ncVu1JxqvcekUi
	CoKhqT7oh+myirLrZhi1SnjJSsTwMSbDP2w==
X-ME-Sender: <xms:0R0kaDGFwo32qV2cnZEhv_NU4q7lN101ehVYSMoy8DnnukU2YQKQ_w>
    <xme:0R0kaAXYnq4AOGi2C0u1w0lwN-3CzV8aD83L-kG5lNdDP8iGuRLayMSR2ZI-jj3Nd
    WolLdQn2rzZMlVkDw>
X-ME-Received: <xmr:0R0kaFLQsoH_FkWeEYfmTNyweLci39m0Wlib46Bk2MZ02qz8Ii7QTsweKFPBXJw-9DmAxKONZ03sha8Ftp61A5w8w3jg0QEMRQcSMZ3iKeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiudel
    ueelgfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorh
    hgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegtohhnghgurghnhhhq
    giesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:0R0kaBHLx0zgyMUhnBJ4RKDzGseZ0Ylre92P2K1JejlM4aleKQ4dMg>
    <xmx:0R0kaJWAcl-CyCqoPfmCzTmAeda3HuZKiGldGriAjC59ygQvLJ7ENA>
    <xmx:0R0kaMM5icMC7xgZLZ6ppJknTb47zDvyDPVn0cVMoG1EInBt4dgzKw>
    <xmx:0R0kaI1btFc43Ar7JYLjrYVzs6mmRi4WEyaub8KfjJJ0WVokzUl0gg>
    <xmx:0h0kaM3sw6YS8nrazpL-yXevENgp0mz4NGYsqFSyvBHXIG79SACJK_Zl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 00:36:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d93c6d68 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 04:36:31 +0000 (UTC)
Date: Wed, 14 May 2025 06:36:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: 'GIT Mailing-list ' <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
Subject: Re: [PATCH v2 3/5] meson: correct path to system config/attribute
 files
Message-ID: <aCQdznsNfaIeSPDI@pks.im>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
 <20250513191739.1513460-4-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513191739.1513460-4-ramsay@ramsayjones.plus.com>

On Tue, May 13, 2025 at 08:17:24PM +0100, Ramsay Jones wrote:
> diff --git a/meson.build b/meson.build
> index 48f31157a0..7f811030bd 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -769,6 +767,20 @@ libgit_c_args = [
>    '-DSHELL_PATH="' + fs.as_posix(target_shell.full_path()) + '"',
>  ]
>  
> +system_attributes = get_option('gitattributes')
> +if system_attributes != ''
> +  libgit_c_args += '-DETC_GITATTRIBUTES="' + system_attributes + '"'
> +else
> +  libgit_c_args += '-DETC_GITATTRIBUTES="' + get_option('sysconfdir') + '/gitattributes"'
> +endif
> +
> +system_config = get_option('gitconfig')
> +if system_config != ''
> +  libgit_c_args += '-DETC_GITCONFIG="' + system_config + '"'
> +else
> +  libgit_c_args += '-DETC_GITCONFIG="' + get_option('sysconfdir') + '/gitconfig"'
> +endif

Nit: I still think that we should use `get_option('sysconfdir') /
'gitattributes'`, with the slash instead of a plus, mostly because it is
more idiomatic and reads better. But that alone doesn't warrant a
reroll.

>  editor_opt = get_option('default_editor')
>  if editor_opt != '' and editor_opt != 'vi'
>    libgit_c_args += '-DDEFAULT_EDITOR="' + editor_opt + '"'
> diff --git a/meson_options.txt b/meson_options.txt
> index 8547c0eb47..ff877e67ce 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -3,9 +3,9 @@ option('default_pager', type: 'string', value: 'less',
>    description: 'Fall-back pager.')
>  option('default_editor', type: 'string', value: 'vi',
>    description: 'Fall-back editor.')
> -option('gitconfig', type: 'string', value: '/etc/gitconfig',
> +option('gitconfig', type: 'string', # default 'etc/gitconfig'
>    description: 'Path to the global git configuration file.')
> -option('gitattributes', type: 'string', value: '/etc/gitattributes',
> +option('gitattributes', type: 'string', # default 'etc/gitattributes'
>    description: 'Path to the global git attributes file.')

I'd prefer if we documented the default value in the description.
Otherwise it is impossible to discover it without having a look at the
sources.

Other than that the range-diff looks as expected, thanks!

Patrick
