Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAB9ECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 20:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbiJ0UaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 16:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbiJ0UaH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 16:30:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CB058DD4
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 13:30:05 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 21so4851278edv.3
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 13:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yi+l/0tdXPjNNx7bjnVTpJ/jcaaxzaAU299lirGUls0=;
        b=V1F4yEHqZX0m1B8BY9sYTh8Go0ViwRZR9h9EP6TiGEGfKE29pnqi3fmeb17jnRmFm8
         GRWM8Ie66Gv5Uny5W3D0m8kYRorQvMr6RosLK/geRgudcwzkYr9HkAY3rjfuOHeO9pUX
         xmVY+0Df5mHyjA8QtDjYQMyimP6XALqY8bh/vB3t+b3oJwfMOic2hp8NyAU5ruruDrvb
         BqotJCrOlTtE034Jw8VgRCSqd8TEQrA4N4mrwtbfZJmsFRPKi7z1GaNbFBoz2DNMc8YX
         qK0cxDmHyDG5q+RE+va0tLrbURyUI1xtZo5hOKzqhVijHzrQl9kZ56lXWWWppZUjeLda
         gWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yi+l/0tdXPjNNx7bjnVTpJ/jcaaxzaAU299lirGUls0=;
        b=M112C7hbwAJ17ugvLrN3QgL08kqRL5ts19cMFXv56ZQXWOeX683L8YsrottrXR0vMR
         AL1PJMwQB0VnsVqAyalYOkkowJL+5Bnj3Ecn17YqlPsqdlII0SoJjZYIWHn95ij4lp0q
         krOd2kPa1XQGgAu/KovRiT063Ejn5Wkx7Hh1VUw7uwqogNzmPpyZy3zjQHZpg/WztnmK
         ziS66UMmyTxljz7g2/AcS7SGLYbIFifeIXiSJgrmCA2Q6oqv4EJX7A+JIyZrVjas5XAu
         2r2+4f632zWQPlShoeCSjn1TyftjwNM+y5zCQkjlE68SowOrbJ2tuioPNtq6ST7nFoG8
         ZrRg==
X-Gm-Message-State: ACrzQf3kFJR7aTPFAVnCf0TyZg2P2bFkx1/yFNbwyqsgW3f74VQ4tj5r
        o7jNI4ZQsWRXEm6Q1yj3CmnulQ0WfD2u8g==
X-Google-Smtp-Source: AMsMyM5RAfXVPVR8flxkPF238Q2xZnllY4hxkmwic2AFCGRQ1d6P74nrHejqo+S2RYwxTH4gSt9hmg==
X-Received: by 2002:a05:6402:11c7:b0:462:549d:fbbe with SMTP id j7-20020a05640211c700b00462549dfbbemr10582471edw.199.1666902603998;
        Thu, 27 Oct 2022 13:30:03 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r17-20020a17090609d100b007815ca7ae57sm1234164eje.212.2022.10.27.13.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 13:30:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oo9Vq-009a14-1M;
        Thu, 27 Oct 2022 22:30:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/8] replace and remove run_command_v_opt_cd_env()
Date:   Thu, 27 Oct 2022 22:16:54 +0200
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <e72a1abe-3098-e4fb-f064-a8b5c8f14239@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <e72a1abe-3098-e4fb-f064-a8b5c8f14239@web.de>
Message-ID: <221027.864jvpau2d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 27 2022, Ren=C3=A9 Scharfe wrote:

> run_command_v_opt_cd_env() is only used in an example in a comment.

Is it? I could have sworn that....

....ah, it is used be before this series, but whereas I arranged it as:

 1. Remove run_command_v_opt_cd_env() and its last user:
    https://lore.kernel.org/git/patch-v2-07.10-3b3d3777232-20221017T170316Z=
-avarab@gmail.com/
 2. Remove run_command_v_opt_tr2() and its last user:
    https://lore.kernel.org/git/patch-v2-08.10-4f1a051823f-20221017T170316Z=
-avarab@gmail.com/

You are:

 1. In your 3/8 you rewrite a bunch of callers, and one of those is the
    odd one out in 3/8 using run_command_v_opt_cd_env().
 2. There's an in-between unrelated cleanup in 4/8
 3. This 5/8 commit, removing the now-stale run_command_v_opt_cd_env().
 4. A nicely atomic 6/8 removing run_command_v_opt_tr2() and its last caller
 5. Your 7/8 has the run_command_v_opt_cd_env_tr2(), but unlike this
    commit you didn't bundle up the "Use [...it...] directly" like here.

Anyway, I find the end state to be mostly OK, but FWIW I wouldn't mind
if this were a bit less confusing.

You seem to have ended up with this because of grouping the '"args" and
"env" directly' callers together.

FWIW I'd be fine with just squashing most of this together, it's already
a ~200 line commit, the commit message could just call out these
exceptions.

*Or* do it more incrementally, but then the choice of not doing the last
callers of the odd ones out atomically seems a bit weird....

Anyway, if you want to just keep it as it is I'm also fine with it. I
mainly wrote the above while narrating the state of this to myself, to
see if there were any lurking issues...

> Use
> the struct child_process member "env" and run_command() directly instead
> and then remove the unused convenience function.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  run-command.c | 7 +------
>  run-command.h | 4 +---
>  tmp-objdir.h  | 4 ++--
>  3 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 5ec3a46dcc..1c9ed510f8 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1006,7 +1006,7 @@ int run_command(struct child_process *cmd)
>
>  int run_command_v_opt(const char **argv, int opt)
>  {
> -	return run_command_v_opt_cd_env(argv, opt, NULL, NULL);
> +	return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, NULL);
>  }
>
>  int run_command_v_opt_tr2(const char **argv, int opt, const char *tr2_cl=
ass)
> @@ -1014,11 +1014,6 @@ int run_command_v_opt_tr2(const char **argv, int o=
pt, const char *tr2_class)
>  	return run_command_v_opt_cd_env_tr2(argv, opt, NULL, NULL, tr2_class);
>  }
>
> -int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir=
, const char *const *env)
> -{
> -	return run_command_v_opt_cd_env_tr2(argv, opt, dir, env, NULL);
> -}
> -
>  int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char =
*dir,
>  				 const char *const *env, const char *tr2_class)
>  {
> diff --git a/run-command.h b/run-command.h
> index 0e85e5846a..a5e210fd1a 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -151,8 +151,7 @@ struct child_process {
>
>  /**
>   * The functions: child_process_init, start_command, finish_command,
> - * run_command, run_command_v_opt, run_command_v_opt_cd_env, child_proce=
ss_clear
> - * do the following:
> + * run_command, run_command_v_opt, child_process_clear do the following:
>   *
>   * - If a system call failed, errno is set and -1 is returned. A diagnos=
tic
>   *   is printed.
> @@ -250,7 +249,6 @@ int run_command_v_opt_tr2(const char **argv, int opt,=
 const char *tr2_class);
>   * env (the environment) is to be formatted like environ: "VAR=3DVALUE".
>   * To unset an environment variable use just "VAR".
>   */
> -int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir=
, const char *const *env);
>  int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char =
*dir,
>  				 const char *const *env, const char *tr2_class);
>
> diff --git a/tmp-objdir.h b/tmp-objdir.h
> index 76efc7edee..615b188573 100644
> --- a/tmp-objdir.h
> +++ b/tmp-objdir.h
> @@ -11,8 +11,8 @@
>   * Example:
>   *
>   *	struct tmp_objdir *t =3D tmp_objdir_create("incoming");
> - *	if (!run_command_v_opt_cd_env(cmd, 0, NULL, tmp_objdir_env(t)) &&
> - *	    !tmp_objdir_migrate(t))
> + *	strvec_pushv(&cmd.env, tmp_objdir_env(t));
> + *	if (!run_command(&cmd)) && !tmp_objdir_migrate(t))
>   *		printf("success!\n");
>   *	else
>   *		die("failed...tmp_objdir will clean up for us");

