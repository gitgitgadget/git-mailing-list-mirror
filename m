Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8E1158A3C
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699916; cv=none; b=r30zSNrXsjmh5d9GverVGsawj048WjwVegpIezb4kuJEF7ABX31Sw0cGLb7t5bi6ioWI0offejTiUJZlyO6E8p2lrg+ZcxUZrAkdHiSnsW3b6/Jy5+6fJ0NvaPetG4+wD1nKBvE5I07tMhQ3bb31LJm57ojRogL1P8IGSb2/+lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699916; c=relaxed/simple;
	bh=WdqrkxKCGomgX86uEDtC0jVqEi7bHq+miJ7x0HtHBFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1fLTY1yqC9xN13qq2zMeGu3awVyIvEtAxm7uhLSxi3qx7/wBKLDrER541S4GPgJOOm30Mlj7NxVcQYA7ScYoJ8AyNGeTikc7uZ8YsupunrxLwJJRQLHw75JdrNz0UDnqBx7e0QAx5k510wlMYIF1aTxezI7XmbbfO0bTN+Axi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y4gld0C8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y4gld0C8"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so39272775ad.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 14:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712699914; x=1713304714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Zk3ZSduQOGQNj46YOVk71Q9mx5H1sCg5DZmtA6Y/qE=;
        b=y4gld0C8cGloLnqNDeDq1NXQPAbkW0TsX8JUSquBKpQe9o2MQ09+EAn7ilJNMvVMx/
         j92jH1aw+5n4co9xmICuYfeNGZrwI50BhK8sYjV4ey6gIwWCzLsqxqCnM4Zwy3jL1zuS
         2OQtQRA7QfziFmMG5DDgRrghYJoOb9iiNiDaHQ1e18koO9Kou8UY1/JWDUPLrKAN1/fC
         UiFD2Wa5fFrvibto1UgMrFFeam3ulDM6DsE4B8UF0q59tph/6cBpfQA0zIC1UjyX56nX
         8YOOCBQpl3cbarknPXzj2RM62foef9F/k1ccC7BV/OAOEqlaVtuAJY76bKrIKCpr3Sod
         UjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712699914; x=1713304714;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Zk3ZSduQOGQNj46YOVk71Q9mx5H1sCg5DZmtA6Y/qE=;
        b=xRlGqKwX+dqaMYom+Jvs5OVSSR/fIj/mefJv9/u0iiCwjnHYBtT/edRqxvuzupOTjA
         lFJeJwLDWSQolmNNlqy43Z+k0MFuCPHBqRJtkqZl7ZfFfp1wAQyrO+SxcT1IPEtTfpVZ
         YytQGgGzCGtjcu/ELKVlMpl+oxHMvZRsfGzXC/cjnw+a6pLppzTXQSHTzxD6gR9djtHk
         +Rm71ywpKKLpB/uJHpjWwYat+FmrhyujlYRF3mVlI0aIO7RKQhFmfzxva1lZZCyCl/CC
         U7bubPbKG7H6m862OzGAJNtH0YkeyqiWQ+w49KN0eKRunLOKFORFS+1W8bmCNFZWM+QN
         xQhA==
X-Gm-Message-State: AOJu0YwaeogWKUmGoIT2pEopRyar89YrVcBE12TeM0ut0yIe42TkxpZ2
	LljLjdWHWGmhE6uTqRDOzciqem5y2nKzXm20kfWXqMAcfwdTfOiXou5vlpr+Xioq/fhezJB9jX5
	Vxw==
X-Google-Smtp-Source: AGHT+IHp5UoQ00s09GNzKA7fTwWml57JK0n9k0pVnbA0LeUFlhmxJz1ZL107YhOlWHa4P3qetPr2PA==
X-Received: by 2002:a17:902:f601:b0:1e4:cb0e:2988 with SMTP id n1-20020a170902f60100b001e4cb0e2988mr1396860plg.2.1712699913602;
        Tue, 09 Apr 2024 14:58:33 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:4457:b729:59d8:3a21])
        by smtp.gmail.com with ESMTPSA id n15-20020a170903110f00b001e20587b552sm9418370plh.163.2024.04.09.14.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:58:32 -0700 (PDT)
Date: Tue, 9 Apr 2024 14:58:28 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] fuzz: link fuzz programs with `make all` on Linux
Message-ID: <ZhW6BM9V-Rto_CW4@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1709673020.git.steadmon@google.com>
 <eef15e3d3da3ca6953fa8bf3ade190da8e68bf46.1709673020.git.steadmon@google.com>
 <xmqqplw8z73y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqplw8z73y.fsf@gitster.g>

On 2024.03.05 13:44, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > Since 5e47215080 (fuzz: add basic fuzz testing target., 2018-10-12), we
> > have compiled object files for the fuzz tests as part of the default
> > 'make all' target. This helps prevent bit-rot in lesser-used parts of
> > the codebase, by making sure that incompatible changes are caught at
> > build time.
> >
> > However, since we never linked the fuzzer executables, this did not
> > protect us from link-time errors. As of 8b9a42bf48 (fuzz: fix fuzz test
> > build rules, 2024-01-19), it's now possible to link the fuzzer
> > executables without using a fuzzing engine and a variety of
> > compiler-specific (and compiler-version-specific) flags, at least on
> > Linux. So let's add a platform-specific option in config.mak.uname to
> > link the executables as part of the default `make all` target.
> >
> > Suggested-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  Makefile         | 14 +++++++++++---
> >  config.mak.uname |  1 +
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 4e255c81f2..f74e96d7c2 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -409,6 +409,9 @@ include shared.mak
> >  # to the "<name>" of the corresponding `compat/fsmonitor/fsm-settings-<name>.c`
> >  # that implements the `fsm_os_settings__*()` routines.
> >  #
> > +# Define LINK_FUZZ_PROGRAMS if you want `make all` to also build the fuzz test
> > +# programs in oss-fuzz/.
> > +#
> >  # === Optional library: libintl ===
> >  #
> >  # Define NO_GETTEXT if you don't want Git output to be translated.
> > @@ -763,9 +766,6 @@ FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
> >  .PHONY: fuzz-objs
> >  fuzz-objs: $(FUZZ_OBJS)
> >  
> > -# Always build fuzz objects even if not testing, to prevent bit-rot.
> > -all:: $(FUZZ_OBJS)
> > -
> >  FUZZ_PROGRAMS += $(patsubst %.o,%,$(filter-out %dummy-cmd-main.o,$(FUZZ_OBJS)))
> >  
> >  # Empty...
> > @@ -2368,6 +2368,14 @@ ifndef NO_TCLTK
> >  endif
> >  	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
> >  
> > +# Build fuzz programs if possible, or at least compile the object files; even
> > +# without the necessary fuzzing support, this prevents bit-rot.
> > +ifdef LINK_FUZZ_PROGRAMS
> > +all:: $(FUZZ_PROGRAMS)
> > +else
> > +all:: $(FUZZ_OBJS)
> > +endif
> 
> It would have been easier on the eyes if we had the fuzz things
> together, perhaps like this simplified version?  We build FUZZ_OBJS
> either way, and when the LINK_FUZZ_PROGRAMS is requested, we follow
> the fuzz-all recipe, too.

We need the LINK_FUZZ_PROGRAMS conditional to happen after we import
config.mak.uname (line 1434 in my V1). We also need to define FUZZ_OBJS
prior to adding it to OBJECTS (line 2698 in V1). I can move all of the
fuzz-definition within that range, keeping everything in one place at
the cost of a larger diff. I'll do that for V2, but if you prefer
otherwise please let me know.

Although I'm not 100% sure that we even need to add FUZZ_OBJS to
OBJECTS, so let me check that tomorrow. If not, then I can move
everything to the bottom of the Makefile where we also define fuzz-all
and the build rules for FUZZ_PROGRAMS.


> diff --git c/Makefile w/Makefile
> index 4e255c81f2..46e457a7a8 100644
> --- c/Makefile
> +++ w/Makefile
> @@ -409,6 +409,9 @@ include shared.mak
>  # to the "<name>" of the corresponding `compat/fsmonitor/fsm-settings-<name>.c`
>  # that implements the `fsm_os_settings__*()` routines.
>  #
> +# Define LINK_FUZZ_PROGRAMS if you want `make all` to also build the fuzz test
> +# programs in oss-fuzz/.
> +#
>  # === Optional library: libintl ===
>  #
>  # Define NO_GETTEXT if you don't want Git output to be translated.
> @@ -766,6 +769,12 @@ fuzz-objs: $(FUZZ_OBJS)
>  # Always build fuzz objects even if not testing, to prevent bit-rot.
>  all:: $(FUZZ_OBJS)
>  
> +# Build fuzz programs, even without the necessary fuzzing support,
> +# this prevents bit-rot.
> +ifdef LINK_FUZZ_PROGRAMS
> +all:: fuzz-all
> +endif
> +
>  FUZZ_PROGRAMS += $(patsubst %.o,%,$(filter-out %dummy-cmd-main.o,$(FUZZ_OBJS)))
>  
>  # Empty...
