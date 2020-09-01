Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414CFC433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 21:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEBA22078B
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 21:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="xxeVjx8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgIAVod (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 17:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbgIAVoc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 17:44:32 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB721C061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 14:44:31 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b19so3356957lji.11
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 14:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3GdypPqA9N3KuiYJkdPM1A2Fb3wiYpCG2U8YG8WYyw=;
        b=xxeVjx8CNKDowsCokgLU4u2ky9IZe+eq53NTyJdWUKJ44fufVbS2d9V6Tzr7iHlHZO
         qmz1dEfP1WOANIl0lkS+1su6N+F4EfUAqikcsMCeux8LBoX7VVjGS14I6BIB87983LPL
         WYmw3x2OPDrp9W55bOnRWoBQeOigYo3lY8G+f1heKXUpPxlGlVFAGKcJTp5moz5ONS6o
         MqShcFHKjZ8X+Di1LBZAGq0DvkTNzOgXN4lg2xSpaFQCbt01bleFKs9eIs0BSBCre2iI
         pQ2IyIGaunHGcl7l7JMxyoTRK4o5B1akMyOKDHIp6awbSoEI7VCNgtEo/v/xy5Vc74dJ
         Nvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3GdypPqA9N3KuiYJkdPM1A2Fb3wiYpCG2U8YG8WYyw=;
        b=M3RuNu5tNq1ybq1c+2OZ/prVOyqeSVGKFBj5bJGFRzXEApL4798SQefh9zfE5h1Pzk
         YgzJ9n8I+hMGDACs7ukWiaw7UQjiXSEIfmdz9dbz1uu1SvEyal5O3Z88zzlvc3d1WS9+
         DyWES6Sh+fWS+f27j+DDfcFOT7NgnH3oX9SZecO1ZKMfL483a+/oKQoUqe0+Fu3eykM4
         FVC0qLb+zTtrnfDrlPZbb8TnbyRp7aLJE1R+cnSvVL4pBOc7JDR1PLR2o/R6Op+w0qW0
         cId/SMw9C6shLpr8TkOV5vbSM4phXmuGV6Uaq2DLcN5WlzS1tCSOMfTFptraFMDPCOdd
         J31Q==
X-Gm-Message-State: AOAM533LxNBKIfEvtdy7n9FoW/0I/jIObyE0lTmRIRRM5Zcao+T2DhWj
        Va229IeDrxRAjdmNokDXqXQdImenXBRa9RmxuA8paQ==
X-Google-Smtp-Source: ABdhPJxvqOoWV4S1Wgk+XEgK4jBDpV3kphbO+pe+SKqZoG/ExcO/Sn/VEYJwsGAR2XlN2LJuxZmFJoAQRmg3rlht95g=
X-Received: by 2002:a2e:8346:: with SMTP id l6mr1571454ljh.202.1598996669985;
 Tue, 01 Sep 2020 14:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591974940.git.matheus.bernardino@usp.br>
 <6402c968077900d48d189551a652e10984437a9f.1591974940.git.matheus.bernardino@usp.br>
 <20200901024130.GA3332286@google.com>
In-Reply-To: <20200901024130.GA3332286@google.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 1 Sep 2020 18:44:18 -0300
Message-ID: <CAHd-oW6LA7Ovnu-e9c+WapF-e+JMichWZEetxmnbjCT_H6D0AQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] config: correctly read worktree configs in submodules
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Jonathan

On Mon, Aug 31, 2020 at 11:41 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Matheus Tavares wrote:
>
> > One of the steps in do_git_config_sequence() is to load the
> > worktree-specific config file. Although the function receives a git_dir
> > string, it relies on git_pathdup(), which uses the_repository->git_dir,
> > to make the path to the file. Furthermore, it also checks that
> > extensions.worktreeConfig is set through the
> > repository_format_worktree_config variable, which refers to
> > the_repository only. Thus, when a submodule has worktree-specific
> > settings, a command executed in the superproject that recurses into the
> > submodule won't find the said settings.
>
> I think the above goes out of order: it states the "how" before the
> "what".  Instead, a commit message should lead with the problem the
> change aims to solve.

Thanks. I will reorder these two sections in the commit message.

> Is the idea here that until this patch, we're only able to read
> worktree config from a repository when extensions.worktreeConfig is
> set in the_repository, meaning that
>
> - when examining submodule config in a process where the_repository
>   represents the superproject, we do not read the submodule's worktree
>   config even if extensions.worktreeConfig is set in the submodule,
>   unless the superproject has extensions.worktreeConfig set, and

Right.

> - when examining submodule config in a process where the_repository
>   represents the superproject, we *do* read the submodule's worktree
>   config even if extensions.worktreeConfig is not set in the submodule,
>   if the superproject has extensions.worktreeConfig set, and
>
> ?

Right, but with one change: if extensions.worktreeConfig is not set in
the submodule and it is set in the superproject, the *superproject's*
worktree config is read (independently of which git_dir was given as
argument).

> That sounds like a serious problem indeed.  Thanks for fixing it.
>
> > This will be especially important in the next patch: git-grep will learn
> > to honor sparse checkouts and, when running with --recurse-submodules,
> > the submodule's sparse checkout settings must be loaded. As these
> > settings are stored in the config.worktree file, they would be ignored
> > without this patch. So let's fix this by reading the right
> > config.worktree file and extensions.worktreeConfig setting, based on the
> > git_dir and commondir paths given to do_git_config_sequence(). Also
> > add a test to avoid any regressions.
>
> I see.  I'm not sure that's more important than other cases, but I
> can understand if the problem was noticed in this circumstance. :)
>
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> >  config.c                   | 21 +++++++++---
> >  t/helper/test-config.c     | 67 +++++++++++++++++++++++++++++++++-----
> >  t/t2404-worktree-config.sh | 16 +++++++++
> >  3 files changed, 91 insertions(+), 13 deletions(-)
> >
> > diff --git a/config.c b/config.c
> > index 8db9c77098..c2d56309dc 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -1747,11 +1747,22 @@ static int do_git_config_sequence(const struct config_options *opts,
> >               ret += git_config_from_file(fn, repo_config, data);
> >
> >       current_parsing_scope = CONFIG_SCOPE_WORKTREE;
> > -     if (!opts->ignore_worktree && repository_format_worktree_config) {
> > +     if (!opts->ignore_worktree && repo_config && opts->git_dir) {
>
> Can we eliminate the repository_format_worktree_config global to save
> the next caller from the same problem?

Hmm, I think it's possible, I will investigate it further.

> > +             struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
> > +             struct strbuf buf = STRBUF_INIT;
> > +
> > +             read_repository_format(&repo_fmt, repo_config);
> > +
> > +             if (!verify_repository_format(&repo_fmt, &buf) &&
> > +                 repo_fmt.worktree_config) {
>
> This undoes the caching the repository_format_worktree_config means to
> do.  Can we cache the value in "struct repository" instead?  That way,
> in the common case where we're reading the_repository, we wouldn't
> experience a slowdown.

Yeah, that would be the best solution. But, unfortunately,
do_git_config_sequence() doesn't receive a complete repository struct,
just the 'commondir' and 'git_dir' strings.

> > -             char *path = git_pathdup("config.worktree");
> > +                     char *path = mkpathdup("%s/config.worktree", opts->git_dir);
>
> Can this use a helper like repo_git_path or strbuf_repo_git_path
> (preferably one using strbuf like the latter)?

Hmm, here we would have the same problem of not having a 'struct
repository' to pass to those functions :(

> [...]
> > +             strbuf_release(&buf);
> > +             clear_repository_format(&repo_fmt);
> >       }
> >
> >       current_parsing_scope = CONFIG_SCOPE_COMMAND;
> > diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> > index 61da2574c5..284f83a921 100644
> > --- a/t/helper/test-config.c
> > +++ b/t/helper/test-config.c
> > @@ -2,12 +2,19 @@
> >  #include "cache.h"
> >  #include "config.h"
> >  #include "string-list.h"
> > +#include "submodule-config.h"
> >
> >  /*
> >   * This program exposes the C API of the configuration mechanism
> >   * as a set of simple commands in order to facilitate testing.
> >   *
> > - * Reads stdin and prints result of command to stdout:
> > + * Usage: test-tool config [--submodule=<path>] <cmd> [<args>]
> > + *
> > + * If --submodule=<path> is given, <cmd> will operate on the submodule at the
> > + * given <path>. This option is not valid for the commands: read_early_config,
> > + * configset_get_value and configset_get_value_multi.
>
> Nice!
>
> [...]
> > @@ -93,7 +102,18 @@ int cmd__config(int argc, const char **argv)
> >       if (argc == 0)
> >               goto print_usage_error;
> >
> > +     if (skip_prefix(*argv, "--submodule=", &subrepo_path)) {
> > +             argc--;
> > +             argv++;
> > +             if (argc == 0)
> > +                     goto print_usage_error;
> > +     }
>
> Can this use the parse_options API?

Right, it would make it easier to add more options in the future.
There is only one consideration, though, about parse_options()'s exit
codes on error, but more on that below...

> > +
> >       if (argc == 2 && !strcmp(argv[0], "read_early_config")) {
> > +             if (subrepo_path) {
> > +                     fprintf(stderr, "Cannot use --submodule with read_early_config\n");
> > +                     return TC_USAGE_ERROR;
>
> Should this use die() or BUG()?

The idea of using TC_USAGE_ERROR (129) here and not die() (128), was
that some users of the test-config helper want to detect die() errors
from the config machinery itself. So by using a different exit code,
we can avoid false positives in these tests. Of course they should
also be checking stderr/stdout, but there is at least one test which
only checks the exit code. Rethinking about that now, instead of using
different exit codes in test-config.c, should we adjust the tests to
use `test_must_fail` and only check stderr/stdout? Then we could use
die() (or BUG()) here, as you suggested, as well as the parse_options
API in the snippet above. Does that sound reasonable?

> > +             }
> >               read_early_config(early_config_cb, (void *)argv[1]);
> >               return TC_SUCCESS;
> >       }
> > @@ -101,8 +121,23 @@ int cmd__config(int argc, const char **argv)
> >       setup_git_directory();
> >       git_configset_init(&cs);
> >
> > +     if (subrepo_path) {
> > +             const struct submodule *sub;
> > +             struct repository *subrepo = xcalloc(1, sizeof(*repo));
>
> nit: this could be scoped to cmd__config:
>
>         struct repository subrepo = {0};

OK, will do. Thanks

> > +
> > +             sub = submodule_from_path(the_repository, &null_oid, subrepo_path);
> > +             if (!sub || repo_submodule_init(subrepo, the_repository, sub)) {
> > +                     fprintf(stderr, "Invalid argument to --submodule: '%s'\n",
> > +                             subrepo_path);
> > +                     free(subrepo);
> > +                     ret = TC_USAGE_ERROR;
>
> Likewise: I think may want to use die() or BUG() (and likewise for other
> USAGE_ERROR cases).
>
> Thanks and hope that helps,
> Jonathan

It did :) Thanks a lot for the comments!
