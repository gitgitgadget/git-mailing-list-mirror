Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCC9328630
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267271; cv=none; b=Gs0mXXA5+SVD6gEkczLCFuglrtmixes5TgLdlxms6rj6t49jWJGzvmM5stNso66m8fpdhS1jIz5yrdO8bJbYuhX40kGeGDqokQF6DUFf57hecqsWRlCRx2HTmmPKe2sVVjX8VRO03wI5b5c9PkqNipD5SaK2uWABR+dKud1HnkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267271; c=relaxed/simple;
	bh=yrI7Kr4zxnBEXMFhANo52TUXNmZqn69IQDa1GCfYaVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qbTa3XtI5Akw7CifUZyxzs6OXVpuaT/pw75/0y998Qubm+Si2Jofci4K7YexWCSHe8zWUuI7OXu/jIohh3vksEdDX1C8bRnafkxDpxjgH/EFrBG7cOWhEOoEfpN5K86pjuIvFvn1u6PreaPPx8AumQg+Jckt8LwrJ3oG2dYuuHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SQ8IyYyA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=relDgWyN; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SQ8IyYyA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="relDgWyN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 14C7114001FE;
	Tue,  4 Nov 2025 09:41:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 04 Nov 2025 09:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762267268; x=1762353668; bh=zMcy6UM4WH
	Iry1jtJaYfrtfAyxryR5DgJR9LyhjUZHI=; b=SQ8IyYyAnw1KpwteJxIJRAJInn
	gsjZNGhYSwJA3df6IKtqKfZcZyhFyhiFf79hVOVSkhA3tx0xDwXHvRi7xQyPNcpl
	+py2WSmky34x/ok9MBUcPQWsuz7a7ZK65HIaKISWr7VYALsIkU9s3XMyFGLA4AJ4
	LV0/4RJ75nZL6oLNCjSlSU13m9GXySi/Ti1OmGQ7l4QsvvI0pigaRaWGI3BWXwIF
	/cEscsr8B5TsUERQlTuVTLl8tLrv6kot6pQHrE9TEdrn0de+3ch82F3WKTPmMODI
	ZadNVtZ/vDwkTJxT3i6UIVNzsCADPPxcHm/28g3psvarxu5Dtb/d/uwwHiIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762267268; x=1762353668; bh=zMcy6UM4WHIry1jtJaYfrtfAyxryR5DgJR9
	LyhjUZHI=; b=relDgWyN2qzM2WYiVzKaVIxMLmr0MUuMCO+9QjXkrmp/XjzLHEK
	0PiUhfGNCDdqzrMx/pMhbC3FlW7Zu2MoXyggwidz5ZIowhz3PRKTlPOftn+U/IoB
	CO12ow0fXy6cMOP4PMqA2fxYUtO+evNV8zvd0bBdBjoJTG1ufnRXPe6VJuWmnxm9
	pxoJo3NT8s06rg8C2bs+a/Y96PAYRwfRvqEB+EaPVrivDkMeH6znAyA517Nts8pV
	J29gf34kR3zxtS1Q+q794+NTjWd+7jJ0TO7+e4onMzMS/iTqKtI6lGLKvoLjQhDm
	glIpDnOVvM5VwoqHw38FFGCDHdJujZyFWHg==
X-ME-Sender: <xms:gxAKaRakYVHUZ3Aio54y6gCHWOwdQjcZ-W2qwrz2uagw9ihhhnqe0A>
    <xme:gxAKafSHc9PIpTNmjhTA_m6cHoE4mh4Tqwd8AaEIFuIC_FqOQA1DSodhOvXzVSPrG
    tZLmLbM7ATCJuajwwm-5aDOm5de6zbN6hs-IxbghS9GkfOc79TVsQ>
X-ME-Received: <xmr:gxAKacStWGQZ2SjuE9GRrx9ePzKsAojbeDoi0P85KOfTpJT1rnMe7dOKSq-b0jXFWK-URFsL1BPL500mVOcMjGXvuFLMCwJPgYV7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeduvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gxAKabQ-MRQzAFO2n8xzRWNgE_9iJTSStS59TBx-aPKJfe6QCHt1HQ>
    <xmx:gxAKaZ4nU_KokeSlwgZSmTsFwBOXAWLGR7KIUA36Pq3ufzmnk_y7qw>
    <xmx:gxAKaf0rpHA_DguCMv9YktukY8gC5cEWH90L2oGRQY32Z8lZd5mfvg>
    <xmx:gxAKacBQ4b5OPiUdc0nJw7nLazMbDGWPzDVisQJMX1YaOrnLA8giMg>
    <xmx:hBAKaeiJmSr4U1iDQZUJlC7ClA7VBxiGH23z8ajeea3tkXUytctpmpWB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 09:41:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Todd Zullinger
 <tmz@pobox.com>
Subject: Re: [PATCH] meson: make GIT_HTML_PATH configurable
In-Reply-To: <385992f6020703558f0ba75a1be6c4f9dae08b83.1762264709.git.ben.knoble+github@gmail.com>
	(D. Ben Knoble's message of "Tue, 4 Nov 2025 08:58:29 -0500")
References: <385992f6020703558f0ba75a1be6c4f9dae08b83.1762264709.git.ben.knoble+github@gmail.com>
Date: Tue, 04 Nov 2025 06:41:06 -0800
Message-ID: <xmqqms51rhbx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> Makefile-based builds can configure Git's internal HTML_PATH by defining
> htmldir, which is useful for packagers that put documentation in
> different locations. Gentoo, for example, uses version-suffixed
> directories like ${prefix}/share/doc/git-2.51 and puts the HTML
> documentation in an 'html' subdirectory of the same.
>
> Propagate the same configuration knob to Meson-based builds so that
> "git --html-path" on such systems can be configured to output the
> correct directory.
>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---

Makes sense (a more meson-minded person needs to double check my
knee-jerk reaction, though).  It is surprising that 

    $ git grep "dir', " meson_options.txt
    meson_options.txt:option('perllibdir', type: 'string', value: '',

has only a single hit (now two), though.  I thought we have a lot
more flexibility in our build process.

I am also a bit surprised that these things are of type 'string'; I
somehow was expecting that more modern build system would offer
richer (relative to Makefile, that is) types like 'filename' or
'path'.

> I've tested this with a modified live Gentoo ebuild [1] and had good results.

Thanks.  Will queue and wait for others to chime in.

>
> [1]: https://github.com/benknoble/gentoo-repo/commit/f2e6bbc8ec5e061a7f8151e56fa91a9d31b5b30b



>
>  Documentation/howto/meson.build     |  4 ++--
>  Documentation/meson.build           | 12 ++++++------
>  Documentation/technical/meson.build |  4 ++--
>  contrib/contacts/meson.build        |  2 +-
>  contrib/subtree/meson.build         |  2 +-
>  meson.build                         |  7 ++++++-
>  meson_options.txt                   |  2 ++
>  7 files changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/howto/meson.build b/Documentation/howto/meson.build
> index ece20244af..16b9056f24 100644
> --- a/Documentation/howto/meson.build
> +++ b/Documentation/howto/meson.build
> @@ -35,7 +35,7 @@ doc_targets += custom_target(
>    output: 'howto-index.html',
>    depends: documentation_deps,
>    install: true,
> -  install_dir: get_option('datadir') / 'doc/git-doc',
> +  install_dir: htmldir,
>  )
>  
>  foreach howto : howto_sources
> @@ -57,6 +57,6 @@ foreach howto : howto_sources
>      output: fs.stem(howto_stripped.full_path()) + '.html',
>      depends: documentation_deps,
>      install: true,
> -    install_dir: get_option('datadir') / 'doc/git-doc/howto',
> +    install_dir: htmldir / 'howto',
>    )
>  endforeach
> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index 9d24f2da54..c00c9fe7f4 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -412,7 +412,7 @@ foreach manpage, category : manpages
>        input: manpage,
>        output: fs.stem(manpage) + '.html',
>        install: true,
> -      install_dir: get_option('datadir') / 'doc/git-doc',
> +      install_dir: htmldir,
>      )
>    endif
>  endforeach
> @@ -423,7 +423,7 @@ if get_option('docs').contains('html')
>      output: 'docinfo.html',
>      copy: true,
>      install: true,
> -    install_dir: get_option('datadir') / 'doc/git-doc',
> +    install_dir: htmldir,
>    )
>  
>    configure_file(
> @@ -431,11 +431,11 @@ if get_option('docs').contains('html')
>      output: 'docbook-xsl.css',
>      copy: true,
>      install: true,
> -    install_dir: get_option('datadir') / 'doc/git-doc',
> +    install_dir: htmldir,
>    )
>  
>    install_symlink('index.html',
> -    install_dir: get_option('datadir') / 'doc/git-doc',
> +    install_dir: htmldir,
>      pointing_to: 'git.html',
>    )
>  
> @@ -466,7 +466,7 @@ if get_option('docs').contains('html')
>      input: 'docbook.xsl',
>      output: 'user-manual.html',
>      install: true,
> -    install_dir: get_option('datadir') / 'doc/git-doc',
> +    install_dir: htmldir,
>    )
>  
>    articles = [
> @@ -492,7 +492,7 @@ if get_option('docs').contains('html')
>        output: fs.stem(article) + '.html',
>        depends: documentation_deps,
>        install: true,
> -      install_dir: get_option('datadir') / 'doc/git-doc',
> +      install_dir: htmldir,
>      )
>    endforeach
>  
> diff --git a/Documentation/technical/meson.build b/Documentation/technical/meson.build
> index be698ef22a..faff3964a9 100644
> --- a/Documentation/technical/meson.build
> +++ b/Documentation/technical/meson.build
> @@ -53,7 +53,7 @@ doc_targets += custom_target(
>    output: 'api-index.html',
>    depends: documentation_deps,
>    install: true,
> -  install_dir: get_option('datadir') / 'doc/git-doc/technical',
> +  install_dir: htmldir / 'technical',
>  )
>  
>  foreach article : api_docs + articles
> @@ -63,6 +63,6 @@ foreach article : api_docs + articles
>      output: fs.stem(article) + '.html',
>      depends: documentation_deps,
>      install: true,
> -    install_dir: get_option('datadir') / 'doc/git-doc/technical',
> +    install_dir: htmldir / 'technical',
>    )
>  endforeach
> diff --git a/contrib/contacts/meson.build b/contrib/contacts/meson.build
> index c8fdb35ed9..4ae6b32a03 100644
> --- a/contrib/contacts/meson.build
> +++ b/contrib/contacts/meson.build
> @@ -50,6 +50,6 @@ if get_option('docs').contains('html')
>      input: 'git-contacts.adoc',
>      output: 'git-contacts.html',
>      install: true,
> -    install_dir: get_option('datadir') / 'doc/git-doc',
> +    install_dir: htmldir,
>    )
>  endif
> diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
> index 46cdbcc30c..161435abeb 100644
> --- a/contrib/subtree/meson.build
> +++ b/contrib/subtree/meson.build
> @@ -68,6 +68,6 @@ if get_option('docs').contains('html')
>      input: 'git-subtree.adoc',
>      output: 'git-subtree.html',
>      install: true,
> -    install_dir: get_option('datadir') / 'doc/git-doc',
> +    install_dir: htmldir,
>    )
>  endif
> diff --git a/meson.build b/meson.build
> index 2b763f7c53..1f95a06edb 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -768,13 +768,18 @@ if test_output_directory == ''
>    test_output_directory = meson.project_build_root() / 'test-output'
>  endif
>  
> +htmldir = get_option('htmldir')
> +if htmldir == ''
> +  htmldir = get_option('datadir') / 'doc/git-doc'
> +endif
> +
>  # These variables are used for building libgit.a.
>  libgit_c_args = [
>    '-DBINDIR="' + get_option('bindir') + '"',
>    '-DDEFAULT_GIT_TEMPLATE_DIR="' + get_option('datadir') / 'git-core/templates' + '"',
>    '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
>    '-DGIT_HOST_CPU="' + host_machine.cpu_family() + '"',
> -  '-DGIT_HTML_PATH="' + get_option('datadir') / 'doc/git-doc"',
> +  '-DGIT_HTML_PATH="' + htmldir + '"',
>    '-DGIT_INFO_PATH="' + get_option('infodir') + '"',
>    '-DGIT_LOCALE_PATH="' + get_option('localedir') + '"',
>    '-DGIT_MAN_PATH="' + get_option('mandir') + '"',
> diff --git a/meson_options.txt b/meson_options.txt
> index 143dee9237..13d421c067 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -1,6 +1,8 @@
>  # Configuration for Git installation
>  option('perllibdir', type: 'string', value: '',
>    description: 'Directory to install perl lib to. Defaults to <datadir>/perl5')
> +option('htmldir', type: 'string', value: '',
> +  description: 'Directory to install HTML docs to. Defaults to <datadir>/doc/git-doc')
>  
>  # Configuration for how Git behaves at runtime.
>  option('default_pager', type: 'string', value: 'less',
>
> base-commit: 7f278e958afbf9b7e0727631b4c26dcfa1c63d6e
