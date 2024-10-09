Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A25316BE3A
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728512684; cv=none; b=pIZL+B+0vkMc8pd6c9ALhCJEmXfKzU46kIM3ZJ2mw0NWImLQJ9+I/G+TmScbUO40TxBO9P1OEsQp0um8vkli3i/CRwZB0KnxrwBJtI2Zsm+LAfHNhGFDjQoERIgbxNggtT/Q0qs8q9jFTGOO1HyUAYLUBC2/e1ZyVHAaVgrES+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728512684; c=relaxed/simple;
	bh=Y/kWI8y+qgnHeqdgfokB81tEnGzQosCrsqi9ufcFQ0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4cL06lC1Kvoa/F/2ipgc69Y1ZAMPmAa2d42xB73HHDl3zTIZ6hHIP+Lf8MM+VU72ZhFMI8nDtsyCO+FQVYprZ4ywXEEnG1kIKMY10BDXTgLl6EeT4J/3yzi9vf+gSFyYXedLQd2LsdzDS0wr6+X13DeVfqtU+ZaJe+M9Q5IvBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lxGT26C9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lxGT26C9"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c5fdd0fe3so76965ad.0
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 15:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728512683; x=1729117483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sr7N6No04EE1QGOlXDHJCDqqmkWHQ0rQ+dfMApQgdKE=;
        b=lxGT26C9VKIo3TLz752LnbhDUGcOagWVwHEFNddjujK0dSn6dkAcptT9bJ+sVUxkNQ
         +0UZKI/Mlqj+7sc0VvZxjLliu8lioy6SsBs3dJPPQAV9bu9Y0q46OwYJ0EYHksc5c4uK
         UCAu0vkrLwH4B9+3QUeNcrSWuPcXNtNSA3e5IgtbIKRgr5D0rPypno5LTQljWfnac32w
         MqqKhkMN25ZDG5Tbnb2Wfv1hzPyZ63gNc0RLVDQQ6+mGU8I3Hj5TK3G05rVFvWUCkhlB
         8dnPX+bwtsTjWWKu8bkhEoVIdylHPPKoAYpOPyRY2RIhy/YJwY35miS6b8SvvsDj2i0b
         kefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728512683; x=1729117483;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sr7N6No04EE1QGOlXDHJCDqqmkWHQ0rQ+dfMApQgdKE=;
        b=B7RcJQga4cOdjM3HjDtTAEvKO166gKOJtGb+/5MDrSquVhSfSs2z3n4n4lHTg9xEzg
         DffC0suN5SfSswzoB2fgLlrTwYc1VVcN9jQ3Rk6t6KMgliWCh4hZ8SRUpbx4urRJsCtV
         y81OajXGng9y79YXJQ4bwPmDwvTxL4Bvs9JDxhrGchgIdgLyj5tTDm7Uvr8LunVE54Hh
         seTcKNhiIyIbOr5JBvOEull0gTTCETtRc4GoGlldTq2my5c/moZQknkrvaczBirxk0j7
         jZdsu2TzGWQsMCcv3c4rQ6bdWUA7MC1WgiZ5Ztns2t679cAsS+N5QxqjSQMFiik7wWO1
         jvnQ==
X-Gm-Message-State: AOJu0YxvjHZHlbf55wnGEr4x60ALBiPCRV4zfGuGuPa0m0e4ep0yRmSP
	jUaq42wPErNT2NNEIKFjofsO2avZ8ENnygMciJk1G02TdJ6fF/7dCtMPC4G5vQ==
X-Google-Smtp-Source: AGHT+IGKr2zWNiTFcw/v21aOLxgXOJAMkvZv6Gviq/IuQUhLe9gwctWNH7DSwArt74j2370xkAkcQQ==
X-Received: by 2002:a17:902:e806:b0:206:9e8f:7cb with SMTP id d9443c01a7336-20c8258ac66mr1170865ad.2.1728512682406;
        Wed, 09 Oct 2024 15:24:42 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:4268:1c66:e2c:2ffb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c139317desm74672465ad.125.2024.10.09.15.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 15:24:41 -0700 (PDT)
Date: Wed, 9 Oct 2024 15:24:36 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	ps@pks.im, sunshine@sunshineco.com, phillip.wood123@gmail.com, 
	allred.sean@gmail.com
Subject: Re: [PATCH v4 5/5] Makefile: add option to build and test libgit-rs
 and libgit-rs-sys
Message-ID: <bn4qspsmqtbbr6mi2tx3gjbldopc5qf7iaqjudnahrhllwecqe@rtk6inujylzc>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	ps@pks.im, sunshine@sunshineco.com, phillip.wood123@gmail.com, 
	allred.sean@gmail.com
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1728429158.git.steadmon@google.com>
 <2ed503216f8e14d7b516c488caf3c76ffcb15697.1728429158.git.steadmon@google.com>
 <xmqq1q0qxhj2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1q0qxhj2.fsf@gitster.g>

On 2024.10.08 17:10, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > From: Calvin Wan <calvinwan@google.com>
> >
> > Add libgitrs, libgitrs-sys, libgitrs-test, and libgitrs-sys-test targets
> > to their respective Makefiles so they can be built and tested without
> > having to run cargo build/test.
> >
> > Add environment variable, INCLUDE_LIBGIT_RS, that when set,
> > automatically builds and tests libgit-rs and libgit-rs-sys when `make
> > all` is ran.
> >
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  Makefile   | 16 ++++++++++++++++
> >  t/Makefile | 16 ++++++++++++++++
> >  2 files changed, 32 insertions(+)
> 
> After 
> 
>     $ make INCLUDE_LIBGIT_RS=YesPlease
> 
> running either
> 
>     $ make INCLUDE_LIBGIT_RS=YesPlease distclean
>     $ make distclean
> 
> leaves
> 
>     $ git clean -n -x
>     Would remove contrib/libgit-rs/libgit-sys/libgitpub.a
> 
> behind.  We'd need to add a bit more to the Makefile, it seems.
> 
> 
> 
>  Makefile | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git i/Makefile w/Makefile
> index 41ad458aef..2acb5353d1 100644
> --- i/Makefile
> +++ w/Makefile
> @@ -392,6 +392,9 @@ include shared.mak
>  # INSTALL_STRIP can be set to "-s" to strip binaries during installation,
>  # if your $(INSTALL) command supports the option.
>  #
> +# Define INCLUDE_LIBGIT_RS if you want your gostak to distim
> +# the doshes.
> +#
>  # Define GENERATE_COMPILATION_DATABASE to "yes" to generate JSON compilation
>  # database entries during compilation if your compiler supports it, using the
>  # `-MJ` flag. The JSON entries will be placed in the `compile_commands/`
> @@ -771,6 +774,9 @@ PROGRAM_OBJS += shell.o
>  .PHONY: program-objs
>  program-objs: $(PROGRAM_OBJS)
>  
> +# libgit-rs stuff
> +LIBGITPUB_A = contrib/libgit-rs/libgit-sys/libgitpub.a
> +
>  # Binary suffix, set to .exe for Windows builds
>  X =
>  
> @@ -3708,6 +3714,7 @@ clean: profile-clean coverage-clean cocciclean
>  	$(RM) po/git.pot po/git-core.pot
>  	$(RM) git.res
>  	$(RM) $(OBJECTS)
> +	$(RM) $(LIBGITPUB_A)
>  	$(RM) headless-git.o
>  	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
>  	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
> @@ -3892,5 +3899,5 @@ contrib/libgit-rs/libgit-sys/partial_symbol_export.o: contrib/libgit-rs/libgit-s
>  contrib/libgit-rs/libgit-sys/hidden_symbol_export.o: contrib/libgit-rs/libgit-sys/partial_symbol_export.o
>  	$(OBJCOPY) --localize-hidden $^ $@
>  
> -contrib/libgit-rs/libgit-sys/libgitpub.a: contrib/libgit-rs/libgit-sys/hidden_symbol_export.o
> +$(LIBGITPUB_A): contrib/libgit-rs/libgit-sys/hidden_symbol_export.o
>  	$(AR) $(ARFLAGS) $@ $^

Done in V5.
