Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A02C0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 17:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386152051A
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 17:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCCEoa5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbgCPRFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:05:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36616 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732008AbgCPRFu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 13:05:50 -0400
Received: by mail-ot1-f66.google.com with SMTP id 39so3186934otu.3
        for <git@vger.kernel.org>; Mon, 16 Mar 2020 10:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvyTVHG5Ww6j3bZL5ZGgFpLX2M6L39QWBXm+BdYmtXQ=;
        b=XCCEoa5lFpIgLZFWoHnxcwtLM136IiEfwjccL1WPM+IpUbQlrrOEv5QT53qMaTEVF/
         ryKjet3ypzc7E5S/qjJx5OX43kvEejYq8BNwJBkdyPwXOYXMJ8g2zSbmkp2cSKjCDTh2
         nwPK8jdp1mxcLuf0JyOGL9dd8iX8mhsDAViZnEKOmp/wOwuk+C3vlqjD01ifA43DJ2Ae
         GQnlrWNUUEocn/XTtzANlpV6VKT3y9B8y1Lnu3ZqXuTCYWPr6UwZ60kK/soCyE6rHVUy
         gG90AfwiD3WbvdtOvXB+noieNC15fzj/I7HWGfFvN3jLeuQFB/EWTzK8vpW5lW1gjWy2
         VB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvyTVHG5Ww6j3bZL5ZGgFpLX2M6L39QWBXm+BdYmtXQ=;
        b=kTHasz2kr66Dpp709Uo15UB0Av9ClyOV68atxioSsNN7L75f/iLOZ3f4bBHXVFKvHq
         0sfZGv9kHBdoR85rGAancEnaj8YxvhL/BvXAu0c7X6FejyuW2tVOaNXsYh1TYGyIDAM4
         Xm8PPRCD+RtjVV6VL4nHHraMmjq+6eI23lVc53bqPWyVu6Aqi6yofijgelN1VxJqNEUi
         GBBPg0VTKoT13n5v5lpKSJPGWKMLZvbNVTJcmcV68dAOK3JBwMLZks3C+T1fCDn0A+Ze
         fmJOiF92y3dfIrfCl74lLrJvWkJ0kOU8OjNZeT0gHQpLSJ6lvxiRK5dJUzmY0sT+aAiB
         RgTg==
X-Gm-Message-State: ANhLgQ2FWRMP+0WAmQp+2tX2inc4s9TmRpo0h2fnRflFSIlZmaQep8M0
        FMnxmVQf0fcrxcuukPCnPeBrfZu6wxW7e5I1hEc=
X-Google-Smtp-Source: ADFU+vvUQ2vZmICAWsr9isXYiPzIncK26sM3r2FtY+VmuDauNJ41sJLFbVnGCYcfQsxWV8GhVFhtS4BA94KRxLFOoSk=
X-Received: by 2002:a05:6830:1ad4:: with SMTP id r20mr221726otc.316.1584378348671;
 Mon, 16 Mar 2020 10:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <650db6863426ae2b324ba717f898247f44279cb8.1584169893.git.gitgitgadget@gmail.com>
 <ee9e8bc6-252f-8ac5-e769-26302f3eb1eb@gmail.com>
In-Reply-To: <ee9e8bc6-252f-8ac5-e769-26302f3eb1eb@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Mar 2020 10:05:37 -0700
Message-ID: <CABPp-BE=VdSAfAWR_2KivXbGOYknhJ=4sbRjVPAS+URNgjLFPQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] sparse-checkout: provide a new update subcommand
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 15, 2020 at 9:24 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/14/2020 3:11 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > If commands like merge or rebase materialize files as part of their work,
> > or a previous sparse-checkout command failed to update individual files
> > due to dirty changes, users may want a command to simply 'reapply' the
> > sparsity rules.  Provide one.
>
> I was actually thinking "refresh" would be a better name, but also you
> use "reapply" which is good, too. I'm concerned that "update" may imply
> that the sparse-checkout patterns can change, but you really mean to
> re-do the work from a previous "git sparse-checkout (set|add)".
>
> I also thought of "reset" but that would be a confusing overload.

Makes sense; I'll switch it over to "reapply".

> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  Documentation/git-sparse-checkout.txt | 10 ++++++++++
> >  builtin/sparse-checkout.c             | 10 +++++++++-
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> > index c0342e53938..27f4392489f 100644
> > --- a/Documentation/git-sparse-checkout.txt
> > +++ b/Documentation/git-sparse-checkout.txt
> > @@ -70,6 +70,16 @@ C-style quoted strings.
> >       `core.sparseCheckoutCone` is enabled, the given patterns are interpreted
> >       as directory names as in the 'set' subcommand.
> >
> > +'update'::
> > +     Update the sparseness of paths in the working tree based on the
> > +     existing patterns.  Commands like merge or rebase can materialize
> > +     paths to do their work (e.g. in order to show you a conflict), and
> > +     other sparse-checkout commands might fail to sparsify an individual
> > +     file (e.g. because it has unstaged changes or conflicts).  In such
> > +     cases, it can make sense to run `git sparse-checkout update` later
> > +     after cleaning up affected paths (e.g. resolving conflicts, undoing
> > +     or committing changes, etc.).
> > +
> >  'disable'::
> >       Disable the `core.sparseCheckout` config setting, and restore the
> >       working directory to include all files. Leaves the sparse-checkout
> > diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> > index 5d3ec2e6be9..2ae21011dfd 100644
> > --- a/builtin/sparse-checkout.c
> > +++ b/builtin/sparse-checkout.c
> > @@ -18,7 +18,7 @@
> >  static const char *empty_base = "";
> >
> >  static char const * const builtin_sparse_checkout_usage[] = {
> > -     N_("git sparse-checkout (init|list|set|add|disable) <options>"),
> > +     N_("git sparse-checkout (init|list|set|add|update|disable) <options>"),
> >       NULL
> >  };
> >
> > @@ -552,6 +552,12 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
> >       return modify_pattern_list(argc, argv, m);
> >  }
> >
> > +static int sparse_checkout_update(int argc, const char **argv)
> > +{
> > +     repo_read_index(the_repository);
> > +     return update_working_directory(NULL);
> > +}
> > +
>
> Short and sweet! I suppose my earlier comment about whether
> repo_read_index() was necessary is answered here. Perhaps it
> should be part of update_working_directory()? (And pass a
> repository pointer to it?)

Good question.  Is there a chance we want to make
update_working_directory() available to other areas of git outside of
sparse-checkout.c?  If so, potentially re-reading the index might not
be friendly, but if sparse-checkout.c is going to remain the only
caller then it probably makes sense to move it inside.

> >  static int sparse_checkout_disable(int argc, const char **argv)
> >  {
> >       struct pattern_list pl;
> > @@ -601,6 +607,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
> >                       return sparse_checkout_set(argc, argv, prefix, REPLACE);
> >               if (!strcmp(argv[0], "add"))
> >                       return sparse_checkout_set(argc, argv, prefix, ADD);
> > +             if (!strcmp(argv[0], "update"))
> > +                     return sparse_checkout_update(argc, argv);
> >               if (!strcmp(argv[0], "disable"))
> >                       return sparse_checkout_disable(argc, argv);
> >       }
