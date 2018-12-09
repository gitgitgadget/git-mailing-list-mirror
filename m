Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15E4B20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 23:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeLIXvE (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 18:51:04 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43520 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeLIXvE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 18:51:04 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so8001973eds.10
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 15:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SFfWlU3ZQ71pzLCBIC4tH9UM/4d4t1OrBwDIDclu80Y=;
        b=IVjFFupTHIrw6H/t32Nx0BoD+QjFpBjakpQ9IGeNmTAfaq5tNWTmDvP2lrFVQbI5Sk
         +HpyHyBYjxqTcafBBFG/Qdn8z1T+vqYt3LwcrFpN1IfLm29bAffDi0YP0F6RaXm8xM0o
         BlBFMNlQ1c1AdbSHKckbQ0ot9fsUWVNBGe+xHqHigfkUtnjOkrp8WKpwzj2t3jMVirhD
         I/MWEUvyheDwU/3CD4ZOM96+z/gpeq3Rfw7Thk3v9l6q4J1ti+QotTaJnjwxQ0v+/1vt
         7WcoUo1kma+MdhcplE0Zix3WwvVTBJ8EQRwDE8nep9U9VSzztTj6GdGxBOJsqTXp7Tdm
         VnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=SFfWlU3ZQ71pzLCBIC4tH9UM/4d4t1OrBwDIDclu80Y=;
        b=s8V47FvWUclX3rFfZOWQSQZAnba2U+CsnwTYs2gHZVlzZuj0vjcFeAkDdKpmOWQ6o3
         zETp5V9Qay48NqXUbt+LRZ+6WLUbeTfb2+xPPsGLY2NEjXknEyFKetpboykLGHR0RtPN
         vXFGmCXrKs4FfwqCNz47NkhBRRZ43PYwK9hUYw05QgjlM/5Ikg+3C2fqsZ0xx+5yQwQJ
         vOV3PitZcztLNp3TkI21qN01oXybVJLPpiLuJPcf4Wqbt3Y5RtwQBRw2vwuT5x5KV2sN
         aA4ls4esYCvG+pQs/RcgRF/Rn6gQL+tDJo0XELk/KZpZ/xfWmIdi/UU/RWuplzd/Ez7V
         JCTw==
X-Gm-Message-State: AA+aEWaUACRsTg39qMMMwo8zyOgJEww81IGUQV1oQqLyvc99RsChsAiV
        zO+sIYTwkvmj+LNS/1PY5c7J1J6E
X-Google-Smtp-Source: AFSGD/Vl+Tmky7aWxmRFMi3wLOunqYSg+d1rPYhesenxOHpPwoDgsb7sUwvH8ftJYN9LM6FgFJDRdQ==
X-Received: by 2002:a50:983a:: with SMTP id g55mr9736460edb.143.1544399462521;
        Sun, 09 Dec 2018 15:51:02 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id e53sm2867463ede.90.2018.12.09.15.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 15:51:01 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, pcre-dev@exim.org
Subject: Re: [RFC PATCH 1/2] grep: fallback to interpreter if JIT fails with pcre1
References: <20181209230024.43444-1-carenas@gmail.com> <20181209230024.43444-2-carenas@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181209230024.43444-2-carenas@gmail.com>
Date:   Mon, 10 Dec 2018 00:51:01 +0100
Message-ID: <87r2eqxnru.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 09 2018, Carlo Marcelo Arenas Belón wrote:

[+CC pcre-dev]

> JIT support was added to 8.20 but the interface we rely on is only
> enabled after 8.32 so try to make the message clearer.
>
> in systems where there are restrictions against creating executable
> pages programatically (like OpenBSD, NetBSD, macOS or seLinux) JIT
> will fail, resulting in a error message to the user.
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  Makefile | 12 ++++++------
>  grep.c   |  6 ++++++
>  2 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 1a44c811aa..62b0cb6ee6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -32,14 +32,14 @@ all::
>  # USE_LIBPCRE is a synonym for USE_LIBPCRE2, define USE_LIBPCRE1
>  # instead if you'd like to use the legacy version 1 of the PCRE
>  # library. Support for version 1 will likely be removed in some future
> -# release of Git, as upstream has all but abandoned it.
> +# release of Git, as upstream is focusing all development for new
> +# features in the newer version instead.

I think whatever we do here it makes sense to split this into its own
patch, since it doesn't have to do with this fallback mechanism.

FWIW I was trying to word this in some way that very briefly described
the v1 v.s. v2 situation. Just saying "new features" doesn't quite
capture it, e.g. some bugs in v1 are closed with some resolution like
"this isn't trivial to fix, use v2 instead".

>  # When using USE_LIBPCRE1, define NO_LIBPCRE1_JIT if the PCRE v1
> -# library is compiled without --enable-jit. We will auto-detect
> -# whether the version of the PCRE v1 library in use has JIT support at
> -# all, but we unfortunately can't auto-detect whether JIT support
> -# hasn't been compiled in in an otherwise JIT-supporting version. If
> -# you have link-time errors about a missing `pcre_jit_exec` define
> +# library is newer than 8.32 but compiled without --enable-jit or
> +# you want to disable JIT
> +#
> +# If you have link-time errors about a missing `pcre_jit_exec` define
>  # this, or recompile PCRE v1 with --enable-jit.
>  #
>  # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are
> diff --git a/grep.c b/grep.c
> index 4db1510d16..5ccc0421a1 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -405,6 +405,12 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
>  		die("%s", error);
>
>  #ifdef GIT_PCRE1_USE_JIT
> +	if (p->pcre1_extra_info &&
> +		!(p->pcre1_extra_info->flags & PCRE_EXTRA_EXECUTABLE_JIT)) {
> +		/* JIT failed so fallback to the interpreter */
> +		p->pcre1_jit_on = 0;
> +		return;
> +	}

Obviously this & what you have in 2/2 needs to be fixed in some way.

Is the issue on SELinux, OpenBSD, NetBSD etc. *how* PCRE is creating the
the JIT'd code? I.e. presumably Google Chrome's JIT engine, Java JIT and
the like work on those setup, or not? I.e. is this something upstream
can/is likely to fix eventually?

Are there cases where we can JIT, but fail for some entirely unrelated
reason, and are now hiding the error?

Are we mixing a condition where one some OS's or OS versions this just
won't work at all, and thus maybe should be something turned on in
config.mak.uname, v.s. e.g. SELinux where presumably it'll dynamically
change.

I'm inclined to suggest that we should have another ifdef here for "if
JIT fails I'd like it to die", so that e.g. packages I build (for
internal use) don't silently slow down in the future, only for me to
find some months later that someone enabled an overzealous SELinux
policy and we swept this under the rug.

But maybe that's just dumb for some reason and we always need to do this
dynamically...
