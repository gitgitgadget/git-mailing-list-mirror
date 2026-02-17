Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F1F1E1C11
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 07:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771311757; cv=none; b=MGaB7kRkcnUa0X3YWSvBZT287oiNHnqOSgzztGgUcYYIdifJa6tabuq1FJysplreTzDBNnPGHAkY7uz1kVn/ueO4HTocaIq/EH8+64WHsodM8EIFyihWhxRUdJJJpHR8xsR0FtsUrOjvtYfino+h7Eiw0/ICspGiP/DJfoaxhn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771311757; c=relaxed/simple;
	bh=JXYoeItHmBzmmGplYKnL3mN9VH3x3i4yXO+57JqzcYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i02wgXk/7t54mF90DG3lPSeeBrhQBKLogwvxntFRbZ9J0R2XzMwZChGUQ3+b0LMSO7c0iQ1xlrWvnyP12hza9SUSvNBJNV6LDmvgzLRQVTMhGlO2GX3ckyRphVJUcG1/8iUKn+FDkw03heDBQp50SV4mlmqrCwYqNHxsuHRSY2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XBPBVZFe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AFo12EQi; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XBPBVZFe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AFo12EQi"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 913571D0028B;
	Tue, 17 Feb 2026 02:02:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 17 Feb 2026 02:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771311755; x=1771398155; bh=y/2E7mpLXJ
	WRUzJ9kt9aDRN6/YjTUAlOwNVUuaokwlw=; b=XBPBVZFePWul6MXrhSD8CCfYA7
	+emszhPPTukrtsuiSK6bk/R/U3YRsLpTdQAUN22Gi8lb+jx/SKwEdRmMhrFiypNC
	AcarNHXEPI6wqsB6HYzBbPPtFjCgG6BtqTXwYw8xbGlRGvh12PUMUhI6K5V0ocrG
	JzwatKyUPJ7FflP+dqF2+3OEH1rdjuWVPd9PwH6EsdA2rsB/BfTPWilOWogfWddT
	bZKu89NPfeFj4xeQ/ebsjuvGxHd6VJJr3FKQ0a7lGcSbvbwzVGDbhfvl+PtYzDmn
	QBbaoBiBMW1ZJ3+7oyGSjdlCeXEuHF8D2XyYEADpVL6ZSVySopPoQoFrO7Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771311755; x=1771398155; bh=y/2E7mpLXJWRUzJ9kt9aDRN6/YjTUAlOwNV
	Uuaokwlw=; b=AFo12EQit9t7au2OGljlEe4sHC7Lsgo0GVwMuACYV8SiJmRcJip
	IQRj6mhgoUDVewG3LTlscLJZmW+gVKo5t5YmBJqn/cN9M2dXlAg7CqEZQVwqvHYS
	7Y1lkJLJiZu5Wh+LaUHOd6Sah1VkTo6YNycGiOge5zsYZMcjUXAECy0enQu/Ln0z
	CLUKIKn8rNSr0MQKiJunwgfZrun8gFlPiMXwk99o7aUxLqZjI8SzOAvanVH0fSYG
	zjYGuCYpZjnMKFA6g+sQPXXU6pNCFvgIyUaLwHxorQV4PD4asN8aps8ahMkClmEF
	Wd0gTB9y0nkdJUmRrspvkcUVERfuqb0lPNA==
X-ME-Sender: <xms:ihKUaThqu7InwAnI7qRp3W9R89AA2NOEFvhM1iTUIH392RwpYbJfag>
    <xme:ihKUaRi0e3z3RvUDqaH3d5kQuT-OYmqS9UjbUeyC-70qbEK1qzDqp-i9HDPn_mMHH
    Vj91LmydeZbghAiQnSatdXY41wsxee2IyZZvOmlXA7Z-WA1EN4ejA>
X-ME-Received: <xmr:ihKUaTL7ri-u24OpgvuKO-yZVpoDv7jyjsMDEQm9E12dggekfuenjRFl8jA9XRAC0OWkBYk-4-dd8Tubt7vDhVzRVDf4oWGMlE0V0NiSyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeludduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknh
    hosghlvgdoghhithhhuhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghvrghnrdhm
    rghrthhinhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhr
    ghdruhhk
X-ME-Proxy: <xmx:ihKUaQE6RHXTPYB9EoEFIB6EHsB0Mu1r547ZKWWl31WeJzwnxeMdkg>
    <xmx:ihKUaXTgTuc8JxLU2rxgpTc3A5zbeDuIcCARqycxyeDKzdZdlkkn-Q>
    <xmx:ihKUaccKn9SH5e0TvxTZCFoAWh6efDS2VE46k05uTT1FDl1Pd7jwmg>
    <xmx:ihKUaWq7nTXYId66Mhs4sK0uEmXyOP0oIn05BXtxxo88h-PGY5IzUQ>
    <xmx:ixKUabUpNA-eL6Vn1GFVe07beccjmowl4OLWieRRNwo1BZ_T9xN1PBpJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 02:02:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f548c478 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 07:02:31 +0000 (UTC)
Date: Tue, 17 Feb 2026 08:02:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Evan Martin <evan.martin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] meson: regenerate config-list.h when Documentation
 changes
Message-ID: <aZQSf9yaNa693IFF@pks.im>
References: <0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>
 <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>

On Mon, Feb 16, 2026 at 05:28:57PM -0500, D. Ben Knoble wrote:
> The Meson-based build doesn't know when to rebuild config-list.h, so the
> header is sometimes stale.
> 
> For example, an old build directory might have config-list.h from before
> 4173df5187 (submodule: introduce extensions.submodulePathConfig,
> 2026-01-12), which added submodule.<name>.gitdir to the list. Without
> it, t9902-completion.sh fails. Regenerating the config-list.h artifact
> from sources fixes the artifact and the test.
> 
> Teach the meson build to depend on the Documentation files that
> generate-configlist.sh reads by having it an additional output as a list
> of dependency files, since Meson does not have (or want) builtin support
> for globbing like Make. We assume that if a user adds a new file under
> Documentation/config then they will also edit one of the existing files
> to include that new file, and that will trigger a rebuild.
> 
> Also mark the generator script as a dependency.
> 
> Combining the following commands helps debug dependencies:
> 
>     ninja -C <builddir> -t deps config-list.h
>     ninja -C <builddir> -t browse config-list.h
> 
> The former lists all the dependencies discovered from our output ".d"
> file (the config documentation) and the latter shows the dependency on
> the script itself, among other useful edges in the dependency graph.

Good hint, thanks for putting it here.

> diff --git a/generate-configlist.sh b/generate-configlist.sh
> index 75c39ade209..63a2e8b6938 100755
> --- a/generate-configlist.sh
> +++ b/generate-configlist.sh
> @@ -36,3 +37,12 @@ print_config_list ()
>  	echo
>  	print_config_list
>  } >"$OUTPUT"
> +
> +if test -n "$DEPFILE"
> +then
> +	for doc in "$SOURCE_DIR"/Documentation/*config.adoc \
> +		"$SOURCE_DIR"/Documentation/config/*.adoc
> +	do
> +		printf "$OUTPUT: %s\n" "$(printf '%s\n' "$doc" | sed 's/[# ]/\\&/g')"

Tiny nit: can't we simplify this to "$(echo "$doc" | sed ...)"?

> diff --git a/meson.build b/meson.build
> index 3a1d12caa4b..e4b8f1e33d2 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -720,11 +720,14 @@ endif
>  
>  builtin_sources += custom_target(
>    output: 'config-list.h',
> +  depfile: 'config-list.h.d',
> +  depend_files: [ 'generate-configlist.sh' ],
>    command: [
>      shell,
> -    meson.current_source_dir() + '/generate-configlist.sh',
> +    meson.current_source_dir() / 'generate-configlist.sh',
>      meson.current_source_dir(),
>      '@OUTPUT@',
> +    '@DEPFILE@',
>    ],
>    env: script_environment,
>  )

And this looks as expected now, too. I also verified locally that this
correctly rebuilds things when either the script or any of the files
change.

I wonder whether we also want to have a second patch on top to adjust
our Makefile? E.g. something like this:

diff --git a/Makefile b/Makefile
index 47ed9fa7fd..ed82775ec2 100644
--- a/Makefile
+++ b/Makefile
@@ -2688,8 +2688,10 @@ $(BUILT_INS): git$X
 
 config-list.h: generate-configlist.sh
 
-config-list.h: Documentation/*config.adoc Documentation/config/*.adoc
-	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@
+config-list.h: generate-configlist.sh
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@ .depend/config-list.h.d
+
+-include .depend/config-list.h.d
 
 command-list.h: generate-cmdlist.sh command-list.txt
 

Please feel free to skip this part though.

Thanks!

Patrick
