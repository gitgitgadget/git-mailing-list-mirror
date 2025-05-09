Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766B916D4E6
	for <git@vger.kernel.org>; Fri,  9 May 2025 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746780695; cv=none; b=HY+Kuf16ch9j7tL8c6xiB+O1eNMdcAX3gejpxFRgUqyKFBZWApAhc+JSlUu9Ui9ek7Jgl8ASsaFPSTEpcW/XNonmLg/+ACr5sUewld4TQlKDDRQE0MDLuK99DqPoqX0pbFswUwuf6Z0WKaLygJ8DzCxuwxEeXFtz63RfSWoQfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746780695; c=relaxed/simple;
	bh=4seK2LUZNR0TsxjSPyk1LExZdzTsPA+TuSlcysEf038=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmhPdCKtat/UhaUNu1nzCtxNfdoYxVmEmb5lt7sLJqAegSwpo9yv5fySByQ/5wPkcF7BtiWVu5eK+dMiBuJnKPKolSiI9OOjd/L8jin1Q3wuW3hBBG7Pyj7OBj3cdm7pnzRxYjf7zOs3pItpmlljzV1DkyRWPs7TL7c5fZnCQzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kUnTJiYK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=isBy934j; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kUnTJiYK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="isBy934j"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 410D711400EB;
	Fri,  9 May 2025 04:51:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 09 May 2025 04:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746780692; x=1746867092; bh=jUhgp0Khfi
	3juScDhFOMOT3PmkHskPCiNdeCOzFecmI=; b=kUnTJiYKqySAWDLRykZy4i9d/U
	/RdJ3lZn2DSYaTgvGeomPuk1d06gTE0q8OArxHpzQMOVxFUABnPufiCHZfjfdwST
	ZNZ1s4utVaZ7p2zXMG73v/xbXprF1gsMYCA8bOlBAurM1S2NjGTKyzGNUwTWlfQd
	+SH75kR3KKY0ZkryzaqahevGUgbG+wQpzrNiKXKAx/xtcEJ16Lum09CSBkx1P2lH
	4mnXrXcl6X5G44Y5Q4Mou+RA18070uPNqdp9ddUwDVkrPpN3X7qGi+KxwLn/mEaW
	I6Kw0L1cNadviDd8hHSwFRCLdHr0rjR69l28sWDuQB3Widl0d8ka8bPIJjvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746780692; x=1746867092; bh=jUhgp0Khfi3juScDhFOMOT3PmkHskPCiNde
	COzFecmI=; b=isBy934jhw3NA9vgh3kilJaWv1XM/OBEbddWG+euXKM4ZRe02Bd
	FWRGsDRCDk5TXgUyt8/1a+Wm6ZtyNXzDmVEZVwRNgBVf1rqG0x037p1uW+AF0Fez
	PK0USwB2cTNCm3UK1ORH8/Lws2n7B6FHjawbQeGTB63KizUAHjiJHKRN9e8d1wIN
	ihCY7aa+7uCgLh4zElzW8PjxzwU9z3atrPnNR+eQirRYFJJxZlrKI0mVazBi0efq
	dIRRU8IxTzuE2YQYea11TeI0kLauA1EaN2ukybs5RHJl1AL2uryeW8FAv7uffUV8
	F6Og66xv4uTDcM0LctFPvStsOjpX20ewC+g==
X-ME-Sender: <xms:E8IdaC8foa_QWMYr2F-UP9hMnqnjyAIYRVnem4vKgqCWhV-DpsfYEQ>
    <xme:E8IdaCud6FKn2Px1S1FSDo43rtQep5n7Y4lFbldqh74bKbpx8GQniqQRVzETq-D5v
    CZcMQfOztOAfI3-WQ>
X-ME-Received: <xmr:E8IdaIDlQ2-25VeCkwAiGvSOmQIWco_bRROwj3PMbnCqCSk58TpYsyhd1hiyMWC_Z_9RZRuxYhnzV6Jvj28NoE0Y2TNZv9xlXJhPO94thQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehr
    rghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtoheptg
    honhhguggrnhhhqhigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:E8IdaKcj_TbuVpLfFkgbDyxAZrV1gTcsxn--3IkPj3T4V-4gigxdmw>
    <xmx:E8IdaHP8B8TMIYEcYGyf5tpc0eld6DEZdERJ94HN9MFxbWo5jMELwg>
    <xmx:E8IdaElrIJlHIyrVoqCaTWwNz2xa3POTwOdHnIAz5qkDkX2JxuTy4A>
    <xmx:E8IdaJvVGvtJ0x8-cS_xBqzJcm5c6oR5jDnB6QuSHJzt50nhbPEmFQ>
    <xmx:FMIdaPPSGDhA-lQPZDWWh9gHSlId7wnH856HJPCjaKM1lAf7AMVsDlYP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 04:51:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5baf88a6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 08:51:28 +0000 (UTC)
Date: Fri, 9 May 2025 10:51:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
Subject: Re: [PATCH 3/5] meson: correct path to system config/attribute files
Message-ID: <aB3CDOljn9zJsVwt@pks.im>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-3-ramsay@ramsayjones.plus.com>
 <20250508164443.1506440-4-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508164443.1506440-4-ramsay@ramsayjones.plus.com>

On Thu, May 08, 2025 at 05:44:37PM +0100, Ramsay Jones wrote:
> diff --git a/meson.build b/meson.build
> index 48f31157a0..106cb17612 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -757,8 +757,6 @@ endif
>  libgit_c_args = [
>    '-DBINDIR="' + get_option('bindir') + '"',
>    '-DDEFAULT_GIT_TEMPLATE_DIR="' + get_option('datadir') / 'git-core/templates' + '"',
> -  '-DETC_GITATTRIBUTES="' + get_option('gitattributes') + '"',
> -  '-DETC_GITCONFIG="' + get_option('gitconfig') + '"',
>    '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
>    '-DGIT_HOST_CPU="' + host_machine.cpu_family() + '"',
>    '-DGIT_HTML_PATH="' + get_option('datadir') / 'doc/git-doc"',
> @@ -769,6 +767,18 @@ libgit_c_args = [
>    '-DSHELL_PATH="' + fs.as_posix(target_shell.full_path()) + '"',
>  ]
>  
> +system_attributes = get_option('gitattributes')
> +if system_attributes != ''
> +  libgit_c_args += '-DETC_GITATTRIBUTES="' + system_attributes + '"'
> +else
> +  libgit_c_args += '-DETC_GITATTRIBUTES="' + get_option('sysconfdir') + '/gitattributes"'
> +endif
> +system_config = get_option('gitconfig')
> +if system_config != ''
> +  libgit_c_args += '-DETC_GITCONFIG="' + system_config + '"'
> +else
> +  libgit_c_args += '-DETC_GITCONFIG="' + get_option('sysconfdir') + '/gitconfig"'

Instead of `get_option('sysconfdir') + '/gitconfig'` you can say
`get_option('sysconfdir') / 'gitconfig'`. It's a bit pointless in this
case and not really needed, but '/' has some special magic for handling
absolute and relative paths.

> +endif
>  editor_opt = get_option('default_editor')
>  if editor_opt != '' and editor_opt != 'vi'
>    libgit_c_args += '-DDEFAULT_EDITOR="' + editor_opt + '"'

Nit: let's maybe add an empty newline after each of these blocks to make
it a bit easier to see where handling for each specific option stops.

> diff --git a/meson_options.txt b/meson_options.txt
> index 8547c0eb47..4d78d4c7ac 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -3,9 +3,9 @@ option('default_pager', type: 'string', value: 'less',
>    description: 'Fall-back pager.')
>  option('default_editor', type: 'string', value: 'vi',
>    description: 'Fall-back editor.')
> -option('gitconfig', type: 'string', value: '/etc/gitconfig',
> +option('gitconfig', type: 'string',
>    description: 'Path to the global git configuration file.')
> -option('gitattributes', type: 'string', value: '/etc/gitattributes',
> +option('gitattributes', type: 'string',
>    description: 'Path to the global git attributes file.')
>  option('pager_environment', type: 'string', value: 'LESS=FRX LV=-c',
>    description: 'Environment used when spawning the pager')

Makes sense. Should we maybe document the default values here now that
they aren't immediately obvious anymore?

Patrick
