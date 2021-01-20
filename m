Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0527DC433E6
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 00:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEC6F23730
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 00:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392999AbhAUA0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 19:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404166AbhATXZw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 18:25:52 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B935FC061348
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 15:13:48 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m25so36429956lfc.11
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 15:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G55qiNCoC70F6VBO6S0JScqaAmfM6NEy2YEL+LMcALA=;
        b=kyCxizrg4/kVZvTRM8uM3ZD1jVzSt14Xdmv8/YZF+cACB98IefqPmpayl/tQoYhnwW
         HCEOIgbk7yU/eF3ulOu7PRAY5mihAtRIpv3cGGK6oO8YkUiGzuagK3P/FhET8BR2FUOe
         MQhMJLOgAtC57pw4/uTYYiZ+5GAiUQLjmQIKhyLGBR28LwKGJKE1+v8OkiCUm+OQ+F+/
         2rPxh50fS3HGZwKHn3/O78FVTYxnebNmLbVJG2q17ZIfKvldLYjRaPyQ4pKC2UforZtH
         wCwDKSnctxaGaFDf69pVUhz7tvXAbrxiHyvlPjRKAgtMHl0bbqMG8037vIY5c0OljqDl
         cPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G55qiNCoC70F6VBO6S0JScqaAmfM6NEy2YEL+LMcALA=;
        b=FckZKIqmr/ufmimGxlyUVhDn/JuJDMSwZowJQbt6yFgrEpYwXZukUTOriy1FoLyWjh
         mAqQ8A9GeFMMpblR6JijBMEsNAV3aWWBnCdrJWACWUP9Apkvy5SQ6oQI1CB4GyPmjO0Y
         0FhkrnzibKYlzYLDOZoibTxnbs+KAl/9Y/ef4KwT1dNz9BIXoqisa0ywxvdT5T6s8igm
         aMW0oQnNc5oLnLqQLIvZSWktQ2gC/R09vX1WTAJXEjng5+QV29ScB83gIrqYZ2avyRHp
         auTYkFn+cHH59a3Y6MgYgEWi/9YxNVSOU3Q6pMFlxAMmuc9k5ejAjhFy5U6+X2FQgRHX
         iqoQ==
X-Gm-Message-State: AOAM530spca2mFgMK+glZpzOc3is1L4mKlr4ujLQYAlw4lFlf6YjJBWg
        yHSDgheNN/e1DC4R3gEHL32e/QpimTfONm/gQmBe9+C8sP0=
X-Google-Smtp-Source: ABdhPJyqUksFXV6EuU1ww6nyna5DNsJNE8LzqTcgilWZkzF9XRZRz0RHfL5Di4qQ42vVRbq9glkjH6h5OIRBIx091r0=
X-Received: by 2002:a05:6512:491:: with SMTP id v17mr5196112lfq.148.1611184427248;
 Wed, 20 Jan 2021 15:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20210120044435.53509-1-alexhenrie24@gmail.com> <xmqqturbdxi2.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqturbdxi2.fsf@gitster.c.googlers.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 20 Jan 2021 16:13:35 -0700
Message-ID: <CAMMLpeQM7JCP0=TMqf0DxDCVJvkCGDEPSKN6vYTU_xc7+QaA1Q@mail.gmail.com>
Subject: Re: [PATCH] rebase: add a config option for --no-fork-point
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 4:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > @@ -1095,6 +1097,12 @@ static int rebase_config(const char *var, const char *value, void *data)
> >               return 0;
> >       }
> >
> > +     if (!strcmp(var, "rebase.forkpoint")) {
> > +             if (!git_config_bool(var, value))
> > +                     opts->fork_point = 0;
> > +             return 0;
> > +     }
>
> It is curious that this code seems to deliberatly ignore
>
>         [rebase] forkpoint = true
>
> but honors
>
>         [rebase] forkpoint = false
>
> Intended?  IOW, why isn't this just like this?
>
>         if (!strcmp(var, "rebase.forkpoint")) {
>                 opts->fork_point = git_config_bool(var, value);
>                 return 0;
>         }
>
> > @@ -1306,7 +1314,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >       const char *gpg_sign = NULL;
> >       struct string_list exec = STRING_LIST_INIT_NODUP;
> >       const char *rebase_merges = NULL;
> > -     int fork_point = -1;
> >       struct string_list strategy_options = STRING_LIST_INIT_NODUP;
> >       struct object_id squash_onto;
> >       char *squash_onto_name = NULL;
> > @@ -1406,7 +1413,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >                       N_("mode"),
> >                       N_("try to rebase merges instead of skipping them"),
> >                       PARSE_OPT_OPTARG, NULL, (intptr_t)""},
> > -             OPT_BOOL(0, "fork-point", &fork_point,
> > +             OPT_BOOL(0, "fork-point", &options.fork_point,
> >                        N_("use 'merge-base --fork-point' to refine upstream")),
> >               OPT_STRING('s', "strategy", &options.strategy,
> >                          N_("strategy"), N_("use the given merge strategy")),
> > @@ -1494,7 +1501,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >                       die(_("cannot combine '--keep-base' with '--root'"));
> >       }
> >
> > -     if (options.root && fork_point > 0)
> > +     if (options.root && options.fork_point > 0)
> >               die(_("cannot combine '--root' with '--fork-point'"));
>
> Is that because of this code?

Yes. I was trying to avoid annoying the user with errors when
rebase.forkPoint is set to "true" and --root is given on the command
line.

> If so, perhaps the configuration parser should set the .fork_point
> to (-1), so that "[rebase] forkpoint = false" that appears in your
> ~/.gitconfig file can be countermanded with "[rebase] forkpoint"
> that is placed in .git/config for one particular project that you do
> not mind using the feature?

That's a great point. I will make that change and resubmit. Thanks!

-Alex
