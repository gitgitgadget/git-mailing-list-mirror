Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21D47201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 20:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750951AbdKLUrN (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 15:47:13 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40554 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdKLUrM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 15:47:12 -0500
Received: by mail-wm0-f65.google.com with SMTP id b189so4534554wmd.5
        for <git@vger.kernel.org>; Sun, 12 Nov 2017 12:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=PpwX3w4AFvuOtuWcXBinfuVT+s76Ep0kTLC0my7GjUo=;
        b=JDQwoigc0YufdsHa7EibhrhSlLIp62/wyOrBrOwH/2iyeX5XwGSO1RpMtNtT971cQ9
         OPbCu6+YrU4H9PpLBUjCXVMbkbcM2lFS8DIA0zoL6Lbi7UiSPa1XDAfRhQDqf4UQgPzU
         GMQtz99s56WtdIrPOgomxQXtnXRSc+iuOAcLu57fgvfg1AJKrk1HUpmniTdoopafWg/v
         gVg+DLJE3d3HhX20wMDJ61ZhbxSwLYyu3qawsLOI99cqCiuHmQFw1J2NReOc3NYuQIG1
         cI2upGh+wpBwysTE9CzcYvD85NNQTBuJtHOoycr9++kqygidA771Spbm7VbGQOQ2/0nA
         Chyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=PpwX3w4AFvuOtuWcXBinfuVT+s76Ep0kTLC0my7GjUo=;
        b=AaYzrv4O5ITWPuqmToeB0VZxP7zT5TV5OD4T7Kq0I/irgzvOLb0G7h/WfZ5jZ7Hu6z
         NEfTky3IdFUP3Co63WTFbflTzvXTrWL7f/I2LwF00+SlBKq/H+vhbHGllI2ysJ6F6q6d
         f2sixynYgTLuiOq6rKHLbWz6Mzj51pzON2hr58gHiU4Xiwvm3Vmt/JS6HmTAbFyvbbBy
         JkDCg7sihUNTrP6a/t01gC95Uk14mAltNRRXlF1+6nzB4sJJXSzQ7h9WXgfPkV6P0pb8
         I8rN9XWyyi0cx/Dzyxeg51pAo7//X9Oek0NvIJqWGwMUY+9gr+4T18xf6QhBam+xboLg
         rj1g==
X-Gm-Message-State: AJaThX5aRAXdp2Q/98IsrMFDfbzv/kF5BLpno+l+O5ZbiYXY0y372NpJ
        d/x9CF5pLWl3eF3dRViCmOQ=
X-Google-Smtp-Source: AGs4zMatzrPElIzccjyISw356RuvqHr1cJhRsOkct5mLB+z68EKL4KtXp/OkGbZZprwW4YWr6LZM8w==
X-Received: by 10.80.163.101 with SMTP id 92mr9867423edn.100.1510519631198;
        Sun, 12 Nov 2017 12:47:11 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id e24sm12054989edc.9.2017.11.12.12.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Nov 2017 12:47:09 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eDz9o-0005dd-PK; Sun, 12 Nov 2017 21:47:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Charles Bailey <charles@hashpling.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix NO_LIBPCRE1_JIT to fully disable JIT
References: <20171112165938.8787-1-charles@hashpling.org>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171112165938.8787-1-charles@hashpling.org>
Date:   Sun, 12 Nov 2017 21:47:08 +0100
Message-ID: <87tvxzxm0j.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 12 2017, Charles Bailey jotted:

> From: Charles Bailey <cbailey32@bloomberg.net>
>
> If you have a pcre1 library which is compiled with JIT enabled then
> PCRE_STUDY_JIT_COMPILE will be defined whether or not the
> NO_LIBPCRE1_JIT configuration is set.
>
> This means that we enable JIT functionality when calling pcre_study
> even if NO_LIBPCRE1_JIT has been explicitly set and we just use plain
> pcre_exec later.
>
> Fix this by using own macro (GIT_PCRE_STUDY_JIT_COMPILE) which we set to
> PCRE_STUDY_JIT_COMPILE only if NO_LIBPCRE1_JIT is not set and define to
> 0 otherwise, as before.
> ---
>
> I was bisecting an issue with the PCRE support that was causing a test
> suite failure on our Solaris builds and reached fbaceaac47 ("grep: add
> support for the PCRE v1 JIT API"). It appeared to be a misaligned memory
> access somewhere inside the libpcre code. I tried disabling the use of
> JIT with NO_LIBPCRE1_JIT but it turned out that even with this set we
> were still triggering the JIT code path in the call to pcre_study.
>
> Yes, we probably should fix our PCRE1 library build on Solaris or move
> to PCRE2, but really NO_LIBPCRE1_JIT should have prevented us from
> triggering this crash.
>
>  grep.c | 2 +-
>  grep.h | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index ce6a48e..d0b9b6c 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -387,7 +387,7 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
>  	if (!p->pcre1_regexp)
>  		compile_regexp_failed(p, error);
>
> -	p->pcre1_extra_info = pcre_study(p->pcre1_regexp, PCRE_STUDY_JIT_COMPILE, &error);
> +	p->pcre1_extra_info = pcre_study(p->pcre1_regexp, GIT_PCRE_STUDY_JIT_COMPILE, &error);
>  	if (!p->pcre1_extra_info && error)
>  		die("%s", error);
>
> diff --git a/grep.h b/grep.h
> index 52aecfa..399381c 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -7,11 +7,12 @@
>  #if PCRE_MAJOR >= 8 && PCRE_MINOR >= 32
>  #ifndef NO_LIBPCRE1_JIT
>  #define GIT_PCRE1_USE_JIT
> +#define GIT_PCRE_STUDY_JIT_COMPILE PCRE_STUDY_JIT_COMPILE
>  #endif
>  #endif
>  #endif
> -#ifndef PCRE_STUDY_JIT_COMPILE
> -#define PCRE_STUDY_JIT_COMPILE 0
> +#ifndef GIT_PCRE_STUDY_JIT_COMPILE
> +#define GIT_PCRE_STUDY_JIT_COMPILE 0
>  #endif
>  #if PCRE_MAJOR <= 8 && PCRE_MINOR < 20
>  typedef int pcre_jit_stack;

[CC-ing Junio]

Thanks a lot. This patch looks good to me.

I could have sworn I was handling this already, but looking at this now
I wasn't really.

However, as a bit of extra info I *did* test this, and it works just
fine for me, i.e. if I compile PCRE 8.32 now (as I did at the time)
--without-jit it'll error with just USE_LIBPCRE=YesPlease as expected,
but add NO_LIBPCRE1_JIT=UnfortunatelyYes and it works just fine without
your patch.

However, as your patch shows (and as I've independently verified)
PCRE_STUDY_JIT_COMPILE will still be defined in that case, since PCRE
will be exposing the same headers. This is the logic error in my initial
patch.

*But* for some reason you still get away with that on Linux. I don't
know why, but I assume the compiler toolchain is more lax for some
reason than on Solaris.

All of which is a roundabout way of saying that we should apply this
patch, but that I still have no idea why this worked on Linux before ,
but it does.

But that we should take it anyway regardless of that since it'll *also*
work on Linux with your patch, and this logic makes some sense whereas
the other one clearly didn't and just worked by pure accident of some
toolchain semantics that I haven't figured out yet.
