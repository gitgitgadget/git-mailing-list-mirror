Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358EDC433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 05:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F014A64E0F
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 05:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhCOFdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 01:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhCOFdg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 01:33:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1311C061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 22:33:35 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h10so15794253edt.13
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 22:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+KfdY+tQXvuu0dFahH0eUEL3ULYE0iiWPrRbuQhPm0=;
        b=UOi4cwwHc/IoKrZ5bsrrBrY393kEuVQ4DPkPTvVSg/m9Dz26aga9Hl+8t+J0R/K5fl
         MZuhD+Oh4HfZnL76DKeasjDnO0XYMdhK67YzTQqBRIiWMTuWAozHSmRfHPIZ+eovpkXV
         GdbcJ2IuXrMaLhPGGDr//Mm1onek0C52JZyilOwmHhH5DpzArEzhGVse8s+XmyXH32yw
         qpSz52OSPkmlg5wLHBUGp/71hQPoLkORhgCIj6xSTTZ4cZrCFwpmNSXsq+R1fMNbblO+
         i67R9rYW3FM7B33jgXDhPC601TDptJWfNIn4rjHzUAicibc97cL5mBGkL4GfscnbAa7N
         NhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+KfdY+tQXvuu0dFahH0eUEL3ULYE0iiWPrRbuQhPm0=;
        b=pvvgjO4ekExHTZTUotMPz7Lg64VZjrUlWIDittdyC0l01H1S4etjE3EzqpS6D0SaMp
         dDgxh2g/L2hAxq19M0SBbPFhyNBfXSlyU+u1r07obbdVc77Nlk+c+P1hQtB3iMDkPHPi
         qI/BEI3ZOHX2/afF7ZINZKjGrlPfyrVg3wzBcpTTyOebbInBMV8vdMYg5VP8xhj8xqs/
         +sI5QFux9xK5nxfGcZmXozYkT8NilT4T7nPHDsP0o0Vr4tM5fKN/qvRbrzIOGnNpQJ7C
         +vLOcmhmJ5FRBsSHjzFrUJG3kTIBIeeiu258dKPxoaR+u2emiMONq6x07XbNz6khb/ts
         WTIQ==
X-Gm-Message-State: AOAM531velC4rCjsaPpY6T9dZ1bBhVfWgUK1CtBDIKtytmLvVCnockfW
        MeJNx1SNB4hTL/iX3chSWXhZb8se2rUc1chSb8xy1tvQ/uK7aQ==
X-Google-Smtp-Source: ABdhPJyyxPxq7yEmARrOczj6gBGPVsCOVhNmG2nlZUN4MM8WxSEYAMczW0r8aSBTTl23iXFEGXa/Bf8xxnhpm01GJ/E=
X-Received: by 2002:a05:6402:170f:: with SMTP id y15mr28039671edu.127.1615786409065;
 Sun, 14 Mar 2021 22:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v4.git.1615737505834.gitgitgadget@gmail.com> <pull.901.v5.git.1615778692784.gitgitgadget@gmail.com>
In-Reply-To: <pull.901.v5.git.1615778692784.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 15 Mar 2021 06:33:17 +0100
Message-ID: <CAP8UFD3mpu6eTqifnwUV4uHoAASaQnxX21CacOn4dGSp+juVKw@mail.gmail.com>
Subject: Re: [PATCH v5] [GSOC] commit: add --trailer option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 4:24 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 739110c5a7f6..24fccb561398 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -113,6 +113,9 @@ static int config_commit_verbose = -1; /* unspecified */
>  static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
>  static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
>  static char *sign_commit, *pathspec_from_file;
> +struct child_process run_trailer = CHILD_PROCESS_INIT;

It seems to me that `run_trailer` is used only in the `if
(trailer_args.nr) {...}` block, so it could be declared there instead
of as a global variable.

> +struct strvec trailer_args = STRVEC_INIT;
> +static const char *trailer;

I am not sure that this `trailer`variable is really needed. It seems
to be used only as the third argument to OPT_CALLBACK(), but there are
other places in the code base where we pass NULL as the third
argument.
