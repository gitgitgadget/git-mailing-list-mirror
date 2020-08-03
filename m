Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93711C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 15:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2A32076E
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 15:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+zrVedE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgHCPHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHCPHU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 11:07:20 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18D9C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 08:07:19 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u24so23632717oiv.7
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 08:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJujd8SQrzOdRO9tdi4K8G3/MhkXKS+OZt3p0vXDM2I=;
        b=k+zrVedE0NywAxN5Rpl+z/AzlPACJ77TqYBkaWGnerAXbsNAhBjrNj4ESVsvCSKL8L
         s8YQVJOL3zkUvVjZ5tBK0A/+rzWr7uIEgPIgBDmwmOomI6O6ikOQ/T3s9u5Gm3a0VftW
         ryQkx3PsIdeiIx/9SGXCBYZa/9RMZjK/gzJvE6OGbltj5LV4cbAnKbWGiB/XcdJzymDT
         xrLCcIDvhnk7EUPuOjvv5RU92x5gqaguTA06TKWIcsCXsZ1SRKUKLPs12y6HCTtYNKnf
         FO2TdDQU7qj93BOOhJNCinBjlsYU0xozCuQUc2IGucWPZdkIj8enkVEq2QkmG/f1m2Bo
         +vWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJujd8SQrzOdRO9tdi4K8G3/MhkXKS+OZt3p0vXDM2I=;
        b=JAOn7RUzUlsptANri5UQo9uyRzYRL+2OE9E27LhbIDw+MttxbzQ1FE9azyut6ByvgW
         tAqU6N1Q3jiDLHJGs/kOyQiJN2+zCcX+RZ2bg+aT1pggJmrxzFVYVz5lEgpRP+yJBUTA
         ZesvndAcbH7sdrQsf2jUNpYuEx+xuXQB/mvLSVdFpkn7+4uY+rEHAE3i5iuU5o9axaQn
         FcvllW8oleUkalMhMp1QDsxJwUCgapVYjZHMDmy6QK8i4a7CmnGsQq+EF3ihVXxRZQIg
         CiqJzqIX5j51pvmLUGJtTYCmbtMhUs3k9G/HCX8ewVF7WpRM4c8CngpbZRt/680s9zea
         7ZBg==
X-Gm-Message-State: AOAM532n3WST06aWSRoWt9CyLwIof5L7iCkh7KKvWehHi83HXj8z28um
        e5Z7MpeNZ9HcCQ1HXWDjwE6G+BS8Nwt1qMsTGkWpRAaV
X-Google-Smtp-Source: ABdhPJxzoRPLyUXSDgtqPdhEE13lBugkaog2lWefCuoR/OVAh0pXbFU3tbI7iv02DtJAW0kAw+FTqYUpFSdYLcu4DNA=
X-Received: by 2002:aca:ea08:: with SMTP id i8mr13452377oih.167.1596467239220;
 Mon, 03 Aug 2020 08:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
 <08c8080b3196a1bd09bbf20ce705ec5ed5180c34.1596349986.git.gitgitgadget@gmail.com>
 <xmqqd048svhk.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqd048svhk.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 3 Aug 2020 08:07:07 -0700
Message-ID: <CABPp-BFPjcMatwgC+TQXBcB6_HdK5kW3=vzRTQ94kiCEyLj9Mg@mail.gmail.com>
Subject: Re: [PATCH 3/4] merge: make merge.renormalize work for all uses of
 merge machinery
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 2, 2020 at 12:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > The 'merge' command is not the only one that does merges; other commands
> > like checkout -m or rebase do as well.  Unfortunately, the only area of
> > the code that checked for the "merge.renormalize" config setting was in
> > builtin/merge.c, meaning it could only affect merges performed by the
> > "merge" command.  Move the handling of this config setting to
> > merge_recursive_config() so that other commands can benefit from it as
> > well.  Fixes a few tests in t6038.
>
> Makes sense, but.
>
> > @@ -771,13 +771,6 @@ static int merge_working_tree(const struct checkout_opts *opts,
> >                        */
> >
> >                       add_files_to_cache(NULL, NULL, 0);
> > -                     /*
> > -                      * NEEDSWORK: carrying over local changes
> > -                      * when branches have different end-of-line
> > -                      * normalization (or clean+smudge rules) is
> > -                      * a pain; plumb in an option to set
> > -                      * o.renormalize?
> > -                      */
> >                       init_merge_options(&o, the_repository);
>
> Now init_merge_options() takes care of setting o.renormalize, which
> does exactly what the comment wanted to see happen.
>
> > diff --git a/builtin/merge.c b/builtin/merge.c
> > index 7da707bf55..52f03ea715 100644
> > --- a/builtin/merge.c
> > +++ b/builtin/merge.c
> > @@ -72,7 +72,7 @@ static const char **xopts;
> >  static size_t xopts_nr, xopts_alloc;
> >  static const char *branch;
> >  static char *branch_mergeoptions;
> > -static int option_renormalize;
> > +static int option_renormalize = -1;
>
> Do we still need this file-scope static variable at all?
>
> > @@ -621,8 +621,6 @@ static int git_merge_config(const char *k, const char *v, void *cb)
> >               return git_config_string(&pull_octopus, k, v);
> >       else if (!strcmp(k, "commit.cleanup"))
> >               return git_config_string(&cleanup_arg, k, v);
> > -     else if (!strcmp(k, "merge.renormalize"))
> > -             option_renormalize = git_config_bool(k, v);
>
> We no longer set value to option_renormalize in git_merge_config()
> that is used only from cmd_merge().
>
> > @@ -721,7 +719,8 @@ static int try_merge_strategy(const char *stra
> >               if (!strcmp(strategy, "subtree"))
> >                       o.subtree_shift = "";
> >
> > -             o.renormalize = option_renormalize;
> > +             if (option_renormalize != -1)
> > +                     o.renormalize = option_renormalize;
>
> And if somebody sets option_renormalize, then (and only then) we
> override o.renormalize.  One line before the precontext of this hunk
> is a call to init_merge_options() that would have set o.renormalize
> by reading merge.renormalize configuration.  So there must be another
> place where option_renormalize comes from other than that configuration
> variable.
>
> But I do not see the variable mentioned anywhere else in the
> original   The assignment to it in git_merge_config() you just got
> rid of was the only one that used to assign to it.
>
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index 36948eafb7..a1c8b36ddb 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -3791,9 +3791,12 @@ int merge_recursive_generic(struct merge_options *opt,
> >  static void merge_recursive_config(struct merge_options *opt)
> >  {
> >       char *value = NULL;
> > +     int renormalize = 0;
> >       git_config_get_int("merge.verbosity", &opt->verbosity);
> >       git_config_get_int("diff.renamelimit", &opt->rename_limit);
> >       git_config_get_int("merge.renamelimit", &opt->rename_limit);
> > +     git_config_get_bool("merge.renormalize", &renormalize);
> > +     opt->renormalize = renormalize;
> >       if (!git_config_get_string("diff.renames", &value)) {
> >               opt->detect_renames = git_config_rename("diff.renames", value);
> >               free(value);
>
> OK.
>
> IOW, wouldn't the attached be a no-op code clean-up on top?
>
>  builtin/merge.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 52f03ea715..74829a838e 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -72,7 +72,6 @@ static const char **xopts;
>  static size_t xopts_nr, xopts_alloc;
>  static const char *branch;
>  static char *branch_mergeoptions;
> -static int option_renormalize = -1;
>  static int verbosity;
>  static int allow_rerere_auto;
>  static int abort_current_merge;
> @@ -719,8 +718,6 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
>                 if (!strcmp(strategy, "subtree"))
>                         o.subtree_shift = "";
>
> -               if (option_renormalize != -1)
> -                       o.renormalize = option_renormalize;
>                 o.show_rename_progress =
>                         show_progress == -1 ? isatty(2) : show_progress;
>

Indeed; I'll squash that in for my next iteration.
