Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804BBC4167B
	for <git@archiver.kernel.org>; Sun, 18 Dec 2022 02:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiLRCLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 21:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRCLe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 21:11:34 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A40CE1C
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 18:11:33 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 21so4123602pfw.4
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 18:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbcOyWt899t6GjMucsvOZjprIEBXifGn6ywgWfjUY+c=;
        b=gn+P/WvEgbkoRe/tVdotybRmQn+tp4eGzJVuKiBZ9kcrleL5fuDuq4/zeo60y0uQ3Z
         iYGfBl2pRNZWKWN2OWvNXGGMAUhJmZ3l84jiBLPi9gaq77DlPp/afbUYqAufLSgJmlC6
         bP35F7OdeSHV3A4+D74Gr1oCzFBUvwYUnD4Tunfbp+oGJYDNWwZkwZLot5mMQHjaw0Ya
         3e2wD3m0CuCC6cdZp5iajq9zTgPbGlOzTdR/92/Dyy/FrNV6pVNWmEwDOTAkW/7Dn+f0
         S+6RhknKN4y2uBXHti/D378mD/4aHAA5HLOpsn4mfUFA5p4m0kx7e03bz15I0hWaW4Js
         GikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JbcOyWt899t6GjMucsvOZjprIEBXifGn6ywgWfjUY+c=;
        b=6LUNFD+pOxulDabIFsNll6OnqJaVUtgNdlTihBWTFIEjJA123wO8wg8DB7rrJyZNuk
         gxX8q+xnL6xFvvaUsGkv4tmP1vUsyL2H/yUBgq1ksT+U0+iQyK91ujWAGgrjlY221V41
         0YCHzO+jND6I59Acs378K87a1aKM/edpBMOXR8z4O6JlCAH6jH109/mpkkXwT8m+WDqX
         uJMWGmIqPrnjYcxpO2gJOiVjKKcGlTjJIsc3eI6AobThmVeHHjVb2Pm66EJen/h9bTGZ
         0NUQlaLY8j9o0Hhs7g9lmUN3A/bApkwqlbHnFI3XfOgBCGdAFSQwtyCCgigURhRKNUNC
         rtrQ==
X-Gm-Message-State: ANoB5pmlXaL298wShu5kZVfFL+Z/Mb2l9jpHUwhcsNEk1RFtuiOCqiCG
        5Q/ZFLw9pEVDw6F9YxmBOAg=
X-Google-Smtp-Source: AA0mqf4UKu2mEVdiBAvsWJGWP8LKT2K3ZK+QFP8T+EqHfWEOPrBbzneQbzi7ggjDfKl504TqxWup7g==
X-Received: by 2002:aa7:9522:0:b0:577:c181:bd61 with SMTP id c2-20020aa79522000000b00577c181bd61mr38412247pfp.20.1671329492814;
        Sat, 17 Dec 2022 18:11:32 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c13-20020a056a00008d00b00574ee8d8779sm3750543pfj.65.2022.12.17.18.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 18:11:32 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Harshil-Jani via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Harshil Jani <harshiljani2002@gmail.com>
Subject: Re: [PATCH 2/2] mingw: remove msysGit/MSYS1 support
References: <pull.1433.git.1670274213.gitgitgadget@gmail.com>
        <e6d3d280a4f9216aa6e9c3c83a38b0fb8ba3a8a1.1670274213.git.gitgitgadget@gmail.com>
Date:   Sun, 18 Dec 2022 11:11:32 +0900
In-Reply-To: <e6d3d280a4f9216aa6e9c3c83a38b0fb8ba3a8a1.1670274213.git.gitgitgadget@gmail.com>
        (Harshil-Jani via GitGitGadget's message of "Mon, 05 Dec 2022 21:03:33
        +0000")
Message-ID: <xmqqsfhdxxyj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Harshil-Jani via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harshil-Jani <harshiljani2002@gmail.com>
>
> The msysGit (i.e. Git for Windows 1.x' SDK) is no longer used and the
> last known user for MSys1 + MinGW has switched to MSys2.

It is curious that we can speak with such a certainty of the lack of
users of such a popular project.  References?

> So there was no
> reason to keep the msysGit/MSys1 config section. This Patch intends to
> remove the support of both the builds and throw an error on
> execution.
>
> The output of `uname -r` if returns us with '1.' then it relates with MSys1
> build environment and msysGit which we don't want to continue ahead and thus
> an error can be expected.

The above clearly explains what is written in the patch text, but
the proposed log message does not explain what ../THIS_IS_MSYSGIT
used to guard and why now we can remove it.

> The MSYS2 is currently used into the MinGW so we can get that part
> running directly without any conditionals required.
>
> Signed-off-by: Harshil-Jani <harshiljani2002@gmail.com>
> ---
>  config.mak.uname | 85 ++++++++++++++++++++----------------------------
>  1 file changed, 35 insertions(+), 50 deletions(-)

Thanks.  It always is good to see more lines go away ;-) but these
two patches need to be explained a bit better and supported by folks
who have been active on Windows port of the project.

> diff --git a/config.mak.uname b/config.mak.uname
> index 377667c4bbc..965ec530837 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -623,6 +623,9 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	SHELL_PATH = /usr/coreutils/bin/bash
>  endif
>  ifeq ($(uname_S),MINGW)
> +	ifeq ($(shell expr "$(uname_R)" : '1\.'),2)
> +		$(error "Building with MSys is no longer supported")
> +	endif
>  	pathsep = ;
>  	HAVE_ALLOCA_H = YesPlease
>  	NO_PREAD = YesPlease
> @@ -676,61 +679,43 @@ ifeq ($(uname_S),MINGW)
>  	RC = windres -O coff
>  	NATIVE_CRLF = YesPlease
>  	X = .exe
> -ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
> -	htmldir = doc/git/html/
> -	prefix =
> +	# MSys2
> +	prefix = /usr/
> +	# Enable DEP
> +	BASIC_LDFLAGS += -Wl,--nxcompat
> +	# Enable ASLR (unless debugging)
> +	ifneq (,$(findstring -O,$(filter-out -O0 -Og,$(CFLAGS))))
> +		BASIC_LDFLAGS += -Wl,--dynamicbase
> +	endif
> +	ifeq (MINGW32,$(MSYSTEM))
> +		prefix = /mingw32
> +		HOST_CPU = i686
> +		BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup
> +	endif
> +	ifeq (MINGW64,$(MSYSTEM))
> +		prefix = /mingw64
> +		HOST_CPU = x86_64
> +		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
> +	else
> +		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
> +		BASIC_LDFLAGS += -Wl,--large-address-aware
> +	endif
> +	CC = gcc
> +	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
> +		-fstack-protector-strong
> +	EXTLIBS += -lntdll
>  	INSTALL = /bin/install
> -	EXTLIBS += /mingw/lib/libz.a
>  	INTERNAL_QSORT = YesPlease
>  	HAVE_LIBCHARSET_H = YesPlease
> -	NO_GETTEXT = YesPlease
> -	NO_PYTHON = YesPlease
> -	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS
> -else
> -	ifneq ($(shell expr "$(uname_R)" : '1\.'),2)
> -		# MSys2
> -		prefix = /usr/
> -		# Enable DEP
> -		BASIC_LDFLAGS += -Wl,--nxcompat
> -		# Enable ASLR (unless debugging)
> -		ifneq (,$(findstring -O,$(filter-out -O0 -Og,$(CFLAGS))))
> -			BASIC_LDFLAGS += -Wl,--dynamicbase
> -		endif
> -		ifeq (MINGW32,$(MSYSTEM))
> -			prefix = /mingw32
> -			HOST_CPU = i686
> -			BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup
> -		endif
> -		ifeq (MINGW64,$(MSYSTEM))
> -			prefix = /mingw64
> -			HOST_CPU = x86_64
> -			BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
> -		else
> -			COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
> -			BASIC_LDFLAGS += -Wl,--large-address-aware
> -		endif
> -		CC = gcc
> -		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
> -			-fstack-protector-strong
> -		EXTLIBS += -lntdll
> -		INSTALL = /bin/install
> -		INTERNAL_QSORT = YesPlease
> -		HAVE_LIBCHARSET_H = YesPlease
> -		USE_GETTEXT_SCHEME = fallthrough
> -		USE_LIBPCRE = YesPlease
> -		USE_NED_ALLOCATOR = YesPlease
> -		ifeq (/mingw64,$(subst 32,64,$(prefix)))
> -			# Move system config into top-level /etc/
> -			ETC_GITCONFIG = ../etc/gitconfig
> -			ETC_GITATTRIBUTES = ../etc/gitattributes
> -		endif
> -	else
> -		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO
> -		NO_CURL = YesPlease
> -		NO_PYTHON = YesPlease
> +	USE_GETTEXT_SCHEME = fallthrough
> +	USE_LIBPCRE = YesPlease
> +	USE_NED_ALLOCATOR = YesPlease
> +	ifeq (/mingw64,$(subst 32,64,$(prefix)))
> +		# Move system config into top-level /etc/
> +		ETC_GITCONFIG = ../etc/gitconfig
> +		ETC_GITATTRIBUTES = ../etc/gitattributes
>  	endif
>  endif
> -endif
>  ifeq ($(uname_S),QNX)
>  	COMPAT_CFLAGS += -DSA_RESTART=0
>  	EXPAT_NEEDS_XMLPARSE_H = YesPlease
