Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB63C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3045C224BE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 23:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgLDXTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLDXTk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 18:19:40 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D676BC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 15:18:59 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id q20so31488oos.12
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 15:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFZgyWJXhPXFp+FFvMpFvj6yCE8HWKZxW9+IEADCuOE=;
        b=s17yavtg7WncU9IsrnCjzqSnD04B0ZtId6OATzUu2zx8mA2dW1wMp70FiEPczjC+e6
         vptNFEmFzUXWMnAasvtzWHQV+GBxibp3Iq4MQtym+ffgCRqGi0Yy1WLdBKxni2A4oQRl
         uu7ey/rTDYn+z2/sZnnWfOE+zeziw72cTYcO9VflRlC4sV+fTnai0KfGD680pDicOJ7f
         ojlSt1wIhBQ9xNNBo0/5u0YzSIhCY1is6zuP06uf3UsdsxLyE0pSWN14fC12X63rd8lf
         7c3XG2IdlGwhUhVmBqlc5fz3XGRlDpW9MzalA5N3xJNvErA/6jg1wjbTBxc4DX2q/5HT
         YtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFZgyWJXhPXFp+FFvMpFvj6yCE8HWKZxW9+IEADCuOE=;
        b=C7+QfNFe5XE0e/pZuB2Ajfq0SgDFAlY+swLww7lfErrLs6YPePzTwui5EKQ3Rgpdkl
         qsmviUV+ICneKV3r429L+fBgd7Mn3Aze9VLs08YJI3vikUr4TRYn4YUmUj0mNBNCVfFO
         aCnD7MtJi5LELCX/oyDeCxvLthrG0LEMD6NXUD79odOi5mQhYbmhaOnhvS1utwLs+Oee
         ne1ki3TnlcoTgS/LW5OKqpeQ40NfGMvAHyNfqldrHlYWGTZK+fKNgs/Mx1rI4OvHZ8LS
         O0StYG2tjZT+04RsNyMuf3LfaHSi8cIsMnyLrNjJ1nSnhYQ7LAYXJvSE05+v4Vof/NtJ
         AM4g==
X-Gm-Message-State: AOAM5321sYKdM+6oUBG3Cet7IhIpcBalGEkZEqPxYox1p1YpK4L1HqOq
        TIDVgm28fKMjrLZp/xefhFK24T8LyPHVynwxOXQ=
X-Google-Smtp-Source: ABdhPJzFn4krmSpIQHqNWdUt2mSCAv9wS9hHu3yFZJfCI5ufFBtywhbvHDdUINa8n+m1RNpLSoT7pkKTRRAT7of6GrA=
X-Received: by 2002:a4a:c60c:: with SMTP id l12mr3633917ooq.45.1607123939237;
 Fri, 04 Dec 2020 15:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com> <20201204061623.1170745-7-felipe.contreras@gmail.com>
In-Reply-To: <20201204061623.1170745-7-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Dec 2020 15:18:48 -0800
Message-ID: <CABPp-BHH0baiECvtvVOoHR82upJ1C+0hy-ukS9Hi2ZFHh19nOg@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] pull: move default warning
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Up to the point where can check if we can fast-forward or not.

Seem to be missing some subjects in that sentence.  ;-)  Perhaps:

Move the default warning to the point where we can check if we can
fast-forward or not.

> No functional changes.

You didn't explain the reasoning for the change here, though I suspect
it makes it easier to change the default to ff-only later.  However,
looking over the patch and pulling up the code, I actually find it
pretty odd that this warning was in a function named
config_get_rebase().  The warning is not rebase-specific, and so
clearly does not belong there.  And for such a function name, the only
kinds of warnings I'd expect are ones where the user configured some
option but set it to a value that cannot make sense.  So it all around
seems like the wrong place to me, and I find your patch to be a good
cleanup.  It would benefit from a slightly improved commit message
though.  :-)



>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/pull.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 8daba7539c..f82e214fc8 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -27,6 +27,8 @@
>  #include "commit-reach.h"
>  #include "sequencer.h"
>
> +static int default_mode;
> +
>  /**
>   * Parses the value of --rebase. If value is a false value, returns
>   * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
> @@ -344,21 +346,7 @@ static enum rebase_type config_get_rebase(void)
>         if (!git_config_get_value("pull.rebase", &value))
>                 return parse_config_rebase("pull.rebase", value, 1);
>
> -       if (opt_verbosity >= 0 && !opt_ff) {
> -               advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> -                       "discouraged; you need to specify if you want a merge, or a rebase.\n"
> -                       "You can squelch this message by running one of the following commands:\n"
> -                       "\n"
> -                       "  git config pull.rebase false  # merge (the default strategy)\n"
> -                       "  git config pull.rebase true   # rebase\n"
> -                       "  git config pull.ff only       # fast-forward only\n"
> -                       "\n"
> -                       "You can replace \"git config\" with \"git config --global\" to set a default\n"
> -                       "preference for all repositories.\n"
> -                       "If unsure, run \"git pull --no-rebase\".\n"
> -                       "Read \"git pull --help\" for more information."
> -                       ));
> -       }
> +       default_mode = 1;
>
>         return REBASE_FALSE;
>  }
> @@ -927,6 +915,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>         struct oid_array merge_heads = OID_ARRAY_INIT;
>         struct object_id orig_head, curr_head;
>         struct object_id rebase_fork_point;
> +       int can_ff;
>
>         if (!getenv("GIT_REFLOG_ACTION"))
>                 set_reflog_message(argc, argv);
> @@ -1022,6 +1011,24 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>         if (opt_rebase && merge_heads.nr > 1)
>                 die(_("Cannot rebase onto multiple branches."));
>
> +       can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
> +
> +       if (default_mode && opt_verbosity >= 0 && !opt_ff) {
> +               advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> +                       "discouraged; you need to specify if you want a merge, or a rebase.\n"
> +                       "You can squelch this message by running one of the following commands:\n"
> +                       "\n"
> +                       "  git config pull.rebase false  # merge (the default strategy)\n"
> +                       "  git config pull.rebase true   # rebase\n"
> +                       "  git config pull.ff only       # fast-forward only\n"
> +                       "\n"
> +                       "You can replace \"git config\" with \"git config --global\" to set a default\n"
> +                       "preference for all repositories.\n"
> +                       "If unsure, run \"git pull --no-rebase\".\n"
> +                       "Read \"git pull --help\" for more information."
> +                       ));
> +       }
> +
>         if (opt_rebase) {
>                 int ret = 0;
>                 if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
> @@ -1029,7 +1036,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>                     submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
>                         die(_("cannot rebase with locally recorded submodule modifications"));
>
> -               if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
> +               if (can_ff) {
>                         /* we can fast-forward this without invoking rebase */
>                         opt_ff = "--ff-only";
>                         ret = run_merge();
> --
> 2.29.2
>
