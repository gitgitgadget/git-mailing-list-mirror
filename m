Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C6181CE8
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782188; cv=none; b=W8wIDQrN3pichM3waW72l4ge73OgIwlV3u5/JWhjLBXUfnDYUQrJ7cRaCoyPw543C/dzhb5zqSvnDkXZN5lBOyn4HWHLuGpBWSn1lOjCP0o1kI5F/euHMLP89WLfYENPbjcl+wLXSUHLP3LX6AvfiDfj8/YR06nYdinrhvbstsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782188; c=relaxed/simple;
	bh=kpFEpPfc4IgMjJinD/2hCP1RgrTdFtULtyC7QWCkz8Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYvL5wvKAY3qio8VleYg/aWT0Ljj1Y5tqSlv4W1Q4l7SVK0TCT22f1Gl3nZJhHuxNdJggkcbZt4tCoTfzySgyMw+GLfi3esE/6L168CDmvb29pTFLsHkgKqYjzBmZ4lADUmiV5kRjNZ+WRtEQC4/FLd13vItc3bXdW86lWhE/wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dC/0As0M; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dC/0As0M"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36af9bcbc0fso1970045ab.0
        for <git@vger.kernel.org>; Wed, 10 Apr 2024 13:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712782185; x=1713386985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7M6UfMyxDBfMWwfzcVQDn/iizjtYt303RDarU7NklX4=;
        b=dC/0As0M6MDZeCNFfpgUMftZOZV0OdX77uD2L1hVhdyJ+zjv1RsnFxTRfxCzAzOoMU
         8yIQoHIeulkRjuR1nY5WwFxcegKvAlMUDXm9WRMtUkwvUDj7PUZ1KJSSnKF+CQ0ki9cm
         bWfb0bDVNnWpXgnNFM4lSTO5yVTr0l0p/vei46C+qgbu05iayRz6jGdvWGVuPIownQ3u
         7WAk9Zi30eB6thQPZKadmiw5ar1uylZYvlndcNCsgs+8g91T5i+NvuSW+OA6ON5RkS04
         LH6e5FdK7IAZvPFPcmWoua+keDczoQ3CVlNiJ2mKrh9pOByQ6wgO643zPG+ysOP6X1UK
         WH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712782185; x=1713386985;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7M6UfMyxDBfMWwfzcVQDn/iizjtYt303RDarU7NklX4=;
        b=So+NL4Bma3JKKWwN7qn7VPHCuhlbY3sNykfJGRhbzYl2yKk00K3s1sUMyGNs0iLSrc
         j0xae4Zi2x6DBhdwLCpPeq4ch5easG+ykBgb0hdkr9EECkpWgkt/OYhKvG7L1l5rOyq/
         Rsb2OeWK2IcPRr03MjsHmenQ7NRNNaOd8Bf2fvHQl6m/2dZ+CNZA7imegxZqRZdb3nlv
         3BSpE6uuh9SvvdTMoZZevoLALyTgnwmZsmzQCVBIWzfSDC1krGmj9ZrBTKFaAY+Izo02
         TdBjshFlrf8UiVIqZ5dEOCi+D181GzzGqpAbmkMpfPGk4sU/49gJ0WGI8SjGixqkiz6A
         RKrw==
X-Forwarded-Encrypted: i=1; AJvYcCUA0b1to86pfmS2d8rmdP3pOiGKcfJYKRo3tQdBUCH3WoyLSsz43vf20UYmmc5GhrydOt3DevpyYG8W0iNUPdrjwBmn
X-Gm-Message-State: AOJu0YwtVq2yRJCFMo7KgI1/XK0exa1+Iesd/BsGvofsP8StDPHswdNu
	rF10wEgr6RBvT81FPRc/xbD18gYVXOBbsibIQ0tWQUsw1WKrBSrQdMLotLYJrN2QJpV3tMmFMQJ
	H3g==
X-Google-Smtp-Source: AGHT+IEk8KBqt9xWyZ3zG/fH787Oxr8KYIONJsCmCysRJpqA/zCE3h/kCXUV/anoa69LZgc0BMvnMA==
X-Received: by 2002:a05:6e02:152d:b0:36a:3d00:365f with SMTP id i13-20020a056e02152d00b0036a3d00365fmr3337400ilu.11.1712782185403;
        Wed, 10 Apr 2024 13:49:45 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:bac7:cc84:8615:9b55])
        by smtp.gmail.com with ESMTPSA id n8-20020a63f808000000b005f41617d80csm3695872pgh.10.2024.04.10.13.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 13:49:44 -0700 (PDT)
Date: Wed, 10 Apr 2024 13:49:39 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] fuzz: link fuzz programs with `make all` on Linux
Message-ID: <Zhb7YwMdtNKzpCSw@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1709673020.git.steadmon@google.com>
 <eef15e3d3da3ca6953fa8bf3ade190da8e68bf46.1709673020.git.steadmon@google.com>
 <xmqqplw8z73y.fsf@gitster.g>
 <ZhW6BM9V-Rto_CW4@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhW6BM9V-Rto_CW4@google.com>

On 2024.04.09 14:58, Josh Steadmon wrote:
> On 2024.03.05 13:44, Junio C Hamano wrote:
> > Josh Steadmon <steadmon@google.com> writes:
> > 
> > > Since 5e47215080 (fuzz: add basic fuzz testing target., 2018-10-12), we
> > > have compiled object files for the fuzz tests as part of the default
> > > 'make all' target. This helps prevent bit-rot in lesser-used parts of
> > > the codebase, by making sure that incompatible changes are caught at
> > > build time.
> > >
> > > However, since we never linked the fuzzer executables, this did not
> > > protect us from link-time errors. As of 8b9a42bf48 (fuzz: fix fuzz test
> > > build rules, 2024-01-19), it's now possible to link the fuzzer
> > > executables without using a fuzzing engine and a variety of
> > > compiler-specific (and compiler-version-specific) flags, at least on
> > > Linux. So let's add a platform-specific option in config.mak.uname to
> > > link the executables as part of the default `make all` target.
> > >
> > > Suggested-by: Junio C Hamano <gitster@pobox.com>
> > > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > > ---
> > >  Makefile         | 14 +++++++++++---
> > >  config.mak.uname |  1 +
> > >  2 files changed, 12 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 4e255c81f2..f74e96d7c2 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -409,6 +409,9 @@ include shared.mak
> > >  # to the "<name>" of the corresponding `compat/fsmonitor/fsm-settings-<name>.c`
> > >  # that implements the `fsm_os_settings__*()` routines.
> > >  #
> > > +# Define LINK_FUZZ_PROGRAMS if you want `make all` to also build the fuzz test
> > > +# programs in oss-fuzz/.
> > > +#
> > >  # === Optional library: libintl ===
> > >  #
> > >  # Define NO_GETTEXT if you don't want Git output to be translated.
> > > @@ -763,9 +766,6 @@ FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
> > >  .PHONY: fuzz-objs
> > >  fuzz-objs: $(FUZZ_OBJS)
> > >  
> > > -# Always build fuzz objects even if not testing, to prevent bit-rot.
> > > -all:: $(FUZZ_OBJS)
> > > -
> > >  FUZZ_PROGRAMS += $(patsubst %.o,%,$(filter-out %dummy-cmd-main.o,$(FUZZ_OBJS)))
> > >  
> > >  # Empty...
> > > @@ -2368,6 +2368,14 @@ ifndef NO_TCLTK
> > >  endif
> > >  	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
> > >  
> > > +# Build fuzz programs if possible, or at least compile the object files; even
> > > +# without the necessary fuzzing support, this prevents bit-rot.
> > > +ifdef LINK_FUZZ_PROGRAMS
> > > +all:: $(FUZZ_PROGRAMS)
> > > +else
> > > +all:: $(FUZZ_OBJS)
> > > +endif
> > 
> > It would have been easier on the eyes if we had the fuzz things
> > together, perhaps like this simplified version?  We build FUZZ_OBJS
> > either way, and when the LINK_FUZZ_PROGRAMS is requested, we follow
> > the fuzz-all recipe, too.
> 
> We need the LINK_FUZZ_PROGRAMS conditional to happen after we import
> config.mak.uname (line 1434 in my V1). We also need to define FUZZ_OBJS
> prior to adding it to OBJECTS (line 2698 in V1). I can move all of the
> fuzz-definition within that range, keeping everything in one place at
> the cost of a larger diff. I'll do that for V2, but if you prefer
> otherwise please let me know.
> 
> Although I'm not 100% sure that we even need to add FUZZ_OBJS to
> OBJECTS, so let me check that tomorrow. If not, then I can move
> everything to the bottom of the Makefile where we also define fuzz-all
> and the build rules for FUZZ_PROGRAMS.

It turns out we do need FUZZ_OBJS in OBJECTS so that we define a build
rule, otherwise the Makefile doesn't know how to compile the fuzzer
objects. So V2 will have most of the fuzzer rules in the line
(1434,2698) range.
