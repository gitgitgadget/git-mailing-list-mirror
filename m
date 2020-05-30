Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE54C433DF
	for <git@archiver.kernel.org>; Sat, 30 May 2020 14:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF752074D
	for <git@archiver.kernel.org>; Sat, 30 May 2020 14:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCCufA7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgE3Otf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 10:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3Ote (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 10:49:34 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0BFC03E969
        for <git@vger.kernel.org>; Sat, 30 May 2020 07:49:33 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h7so4319209otr.3
        for <git@vger.kernel.org>; Sat, 30 May 2020 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+DB8HzNLijzPn4AjtBJXO0rAu3dhJfdXiIuofTn16I=;
        b=DCCufA7a0adBWbURZbdeXQs/vF54m0flzxPEtQRh/RT4dn1SPXMePKJ5wi3eM5Dhvp
         yUjIY4vF2L5V0smuOBaINGfB0ZyK25GVrnDSxt9K+GU7NFTmqRYu3uuDuGkghSp5mDxo
         seAYlrh5nnvi2NjRJVQ2QF+YXYzeUtr9J4vBort0y14ueWwRYtj1mRpawRaZ09Y/B8kC
         VT8tfsa8Pgr51r36XB3bWSz1dMKM7I3FVzACPDHpFP/yDwznyXPpTiG/IYDzk1/JNq77
         OAVzbcPZLtnXQ7Pn1PQd5oJy2uMuu+dBBe8/hAJzjqEirkN536lZn2VUlw9d5elvZFd1
         AY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+DB8HzNLijzPn4AjtBJXO0rAu3dhJfdXiIuofTn16I=;
        b=qpzrfMsfWWvEKavj6ygNJzjqSHs7Ntr6ZlTcgggl/hWiGU7cDi+QKtVl07k78rxcAi
         VbpQTtoNgOJreLw5tju9otJaQ+6yhzoaItWfebLltC6Qeqgn6A3Hf2ZtEUfaQsWusMi0
         kibvzTPq9wRXYPZvtwd6FNsajfC+MARtcpIXfn73eLZDdJL4qsjQ0WWMSSeCfw5iujEz
         giXiX7SnjdAhtbojA5Ib+CeuziV9MkNlkmuGRSSLBG4x6u8gUJkIIuNFumq1+tk99jH5
         x7HlEfJmWiJ0yg+HWEWiWa4v31WhYrPKxau4phZL7umFL+yzkElZVwNX7YlMmAiYCmlC
         6gcA==
X-Gm-Message-State: AOAM530bE/tgMD+YiMxUFaGJVJ06R9qCduQ8dbjsaHBljcIfYSiCo8Om
        7nxmXo9AT9n3XNKMSzoRBjdGvRqfSyqviOs/bWV/I6cm
X-Google-Smtp-Source: ABdhPJwKrr79fcUsPBeF/msJkf4EVZMvAG31GGk8zvdIQ2HG9Io4/iaNBncFSMZvYNmIAxPWirMOIMxq6dJd5UgcWhA=
X-Received: by 2002:a05:6830:4c3:: with SMTP id s3mr10488707otd.162.1590850172389;
 Sat, 30 May 2020 07:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590627264.git.matheus.bernardino@usp.br> <448e0efffd0bbc89d8ea891923f242b5123c5826.1590627264.git.matheus.bernardino@usp.br>
In-Reply-To: <448e0efffd0bbc89d8ea891923f242b5123c5826.1590627264.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 30 May 2020 07:49:20 -0700
Message-ID: <CABPp-BGVaMM9Naiu3HeO6n2aOxsHwiuc813MF-hFWezSFa9CsA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] config: correctly read worktree configs in submodules
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 27, 2020 at 6:13 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> One of the steps in do_git_config_sequence() is to load the
> worktree-specific config file. Although the function receives a git_dir
> string, it relies on git_pathdup(), which uses the_repository->git_dir,
> to make the path to the file. Furthermore, it also checks that
> extensions.worktreeConfig is set through the
> repository_format_worktree_config variable, which refers to
> the_repository only. Thus, when a submodule has worktree settings, a
> command executed in the superproject that recurses into the submodule
> won't find the said settings.
>
> Such a scenario might not be needed now, but it will be in the following

It's not needed?  Are there not other config values that affect grep's
behavior, such as smudge filters of the submodule that might be
important if doing a 'git grep --recurse-submodules $REVISION'?

Also, is there a similar issue here for .gitattributes?  (e.g. if the
submodule declares certain files to be binary?)

(I don't actually know if these are issues but I'm just surprised to
hear that this would be the first case that would need to look at
submodule-specific configuration.  If the current code handles these
other scenarios I bring up, then you just need to correct your commit
message.  If these aren't issues, then I'd appreciate a quick
explanation of why I'm off base.  If these are current issues and the
current code isn't handling them, I'm not saying you need to address
them in this patch series, but you might need to reword the commit
message to mention that was already an issue that has previously been
overlooked and we're starting by fixing one case.)

> patch. git-grep will learn to honor sparse checkouts and, when running
> with --recurse-submodules, the submodule's sparse checkout settings must
> be loaded. As these settings are stored in the config.worktree file,
> they would be ignored without this patch. So let's fix this by reading
> the right config.worktree file and extensions.worktreeConfig setting,
> based on the git_dir and commondir paths given to
> do_git_config_sequence(). Also add a test to avoid any regressions.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  config.c                   |  21 +++++--
>  t/helper/test-config.c     | 119 +++++++++++++++++++++++++++----------
>  t/t2404-worktree-config.sh |  16 +++++
>  3 files changed, 118 insertions(+), 38 deletions(-)
>
> diff --git a/config.c b/config.c
> index 8db9c77098..c2d56309dc 100644
> --- a/config.c
> +++ b/config.c
> @@ -1747,11 +1747,22 @@ static int do_git_config_sequence(const struct config_options *opts,
>                 ret += git_config_from_file(fn, repo_config, data);
>
>         current_parsing_scope = CONFIG_SCOPE_WORKTREE;
> -       if (!opts->ignore_worktree && repository_format_worktree_config) {
> -               char *path = git_pathdup("config.worktree");
> -               if (!access_or_die(path, R_OK, 0))
> -                       ret += git_config_from_file(fn, path, data);
> -               free(path);
> +       if (!opts->ignore_worktree && repo_config && opts->git_dir) {
> +               struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
> +               struct strbuf buf = STRBUF_INIT;
> +
> +               read_repository_format(&repo_fmt, repo_config);
> +
> +               if (!verify_repository_format(&repo_fmt, &buf) &&
> +                   repo_fmt.worktree_config) {
> +                       char *path = mkpathdup("%s/config.worktree", opts->git_dir);
> +                       if (!access_or_die(path, R_OK, 0))
> +                               ret += git_config_from_file(fn, path, data);
> +                       free(path);
> +               }
> +
> +               strbuf_release(&buf);
> +               clear_repository_format(&repo_fmt);
>         }
>
>         current_parsing_scope = CONFIG_SCOPE_COMMAND;
> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> index 1c8e965840..284f83a921 100644
> --- a/t/helper/test-config.c
> +++ b/t/helper/test-config.c
> @@ -2,12 +2,19 @@
>  #include "cache.h"
>  #include "config.h"
>  #include "string-list.h"
> +#include "submodule-config.h"
>
>  /*
>   * This program exposes the C API of the configuration mechanism
>   * as a set of simple commands in order to facilitate testing.
>   *
> - * Reads stdin and prints result of command to stdout:
> + * Usage: test-tool config [--submodule=<path>] <cmd> [<args>]
> + *
> + * If --submodule=<path> is given, <cmd> will operate on the submodule at the
> + * given <path>. This option is not valid for the commands: read_early_config,
> + * configset_get_value and configset_get_value_multi.
> + *
> + * Possible cmds are:
>   *
>   * get_value -> prints the value with highest priority for the entered key
>   *
> @@ -84,33 +91,63 @@ int cmd__config(int argc, const char **argv)
>         int i, val;
>         const char *v;
>         const struct string_list *strptr;
> -       struct config_set cs;
> +       struct config_set cs = { .hash_initialized = 0 };
>         enum test_config_exit_code ret = TC_SUCCESS;
> +       struct repository *repo = the_repository;
> +       const char *subrepo_path = NULL;
> +
> +       argc--; /* skip over "config" */

This line alone is responsible for a fairly big set of changes
throughout this file, just decrementing indices everywhere.  It might
be nice for review purposes if this and the other changes it caused
were pulled out into a separate step, so we can more easily
concentrate on the primary additions and changes you are making to
this file.  In particular, being so unfamiliar with submodules I'd
really like to try to find someone who knows them a bit better to
review all the subrepo_path related portions of this change to this
file plus the config.c changes, but I think that'd be easier if the
change were more focused.

> +       argv++;
> +
> +       if (argc == 0)
> +               goto print_usage_error;
> +
> +       if (skip_prefix(*argv, "--submodule=", &subrepo_path)) {
> +               argc--;
> +               argv++;
> +               if (argc == 0)
> +                       goto print_usage_error;
> +       }
>
> -       if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
> -               read_early_config(early_config_cb, (void *)argv[2]);
> +       if (argc == 2 && !strcmp(argv[0], "read_early_config")) {
> +               if (subrepo_path) {
> +                       fprintf(stderr, "Cannot use --submodule with read_early_config\n");
> +                       return TC_USAGE_ERROR;
> +               }
> +               read_early_config(early_config_cb, (void *)argv[1]);
>                 return TC_SUCCESS;
>         }
>
>         setup_git_directory();
> -
>         git_configset_init(&cs);
>
> -       if (argc < 2)
> -               goto print_usage_error;
> +       if (subrepo_path) {
> +               const struct submodule *sub;
> +               struct repository *subrepo = xcalloc(1, sizeof(*repo));
> +
> +               sub = submodule_from_path(the_repository, &null_oid, subrepo_path);
> +               if (!sub || repo_submodule_init(subrepo, the_repository, sub)) {
> +                       fprintf(stderr, "Invalid argument to --submodule: '%s'\n",
> +                               subrepo_path);
> +                       free(subrepo);
> +                       ret = TC_USAGE_ERROR;
> +                       goto out;
> +               }
> +               repo = subrepo;
> +       }
>
> -       if (argc == 3 && !strcmp(argv[1], "get_value")) {
> -               if (!git_config_get_value(argv[2], &v)) {
> +       if (argc == 2 && !strcmp(argv[0], "get_value")) {
> +               if (!repo_config_get_value(repo, argv[1], &v)) {
>                         if (!v)
>                                 printf("(NULL)\n");
>                         else
>                                 printf("%s\n", v);
>                 } else {
> -                       printf("Value not found for \"%s\"\n", argv[2]);
> +                       printf("Value not found for \"%s\"\n", argv[1]);
>                         ret = TC_VALUE_NOT_FOUND;
>                 }
> -       } else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
> -               strptr = git_config_get_value_multi(argv[2]);
> +       } else if (argc == 2 && !strcmp(argv[0], "get_value_multi")) {
> +               strptr = repo_config_get_value_multi(repo, argv[1]);
>                 if (strptr) {
>                         for (i = 0; i < strptr->nr; i++) {
>                                 v = strptr->items[i].string;
> @@ -120,32 +157,38 @@ int cmd__config(int argc, const char **argv)
>                                         printf("%s\n", v);
>                         }
>                 } else {
> -                       printf("Value not found for \"%s\"\n", argv[2]);
> +                       printf("Value not found for \"%s\"\n", argv[1]);
>                         ret = TC_VALUE_NOT_FOUND;
>                 }
> -       } else if (argc == 3 && !strcmp(argv[1], "get_int")) {
> -               if (!git_config_get_int(argv[2], &val)) {
> +       } else if (argc == 2 && !strcmp(argv[0], "get_int")) {
> +               if (!repo_config_get_int(repo, argv[1], &val)) {
>                         printf("%d\n", val);
>                 } else {
> -                       printf("Value not found for \"%s\"\n", argv[2]);
> +                       printf("Value not found for \"%s\"\n", argv[1]);
>                         ret = TC_VALUE_NOT_FOUND;
>                 }
> -       } else if (argc == 3 && !strcmp(argv[1], "get_bool")) {
> -               if (!git_config_get_bool(argv[2], &val)) {
> +       } else if (argc == 2 && !strcmp(argv[0], "get_bool")) {
> +               if (!repo_config_get_bool(repo, argv[1], &val)) {
>                         printf("%d\n", val);
>                 } else {
> -                       printf("Value not found for \"%s\"\n", argv[2]);
> +
> +                       printf("Value not found for \"%s\"\n", argv[1]);
>                         ret = TC_VALUE_NOT_FOUND;
>                 }
> -       } else if (argc == 3 && !strcmp(argv[1], "get_string")) {
> -               if (!git_config_get_string_const(argv[2], &v)) {
> +       } else if (argc == 2 && !strcmp(argv[0], "get_string")) {
> +               if (!repo_config_get_string_const(repo, argv[1], &v)) {
>                         printf("%s\n", v);
>                 } else {
> -                       printf("Value not found for \"%s\"\n", argv[2]);
> +                       printf("Value not found for \"%s\"\n", argv[1]);
>                         ret = TC_VALUE_NOT_FOUND;
>                 }
> -       } else if (argc >= 3 && !strcmp(argv[1], "configset_get_value")) {
> -               for (i = 3; i < argc; i++) {
> +       } else if (argc >= 2 && !strcmp(argv[0], "configset_get_value")) {
> +               if (subrepo_path) {
> +                       fprintf(stderr, "Cannot use --submodule with configset_get_value\n");
> +                       ret = TC_USAGE_ERROR;
> +                       goto out;
> +               }
> +               for (i = 2; i < argc; i++) {
>                         int err;
>                         if ((err = git_configset_add_file(&cs, argv[i]))) {
>                                 fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
> @@ -153,17 +196,22 @@ int cmd__config(int argc, const char **argv)
>                                 goto out;
>                         }
>                 }
> -               if (!git_configset_get_value(&cs, argv[2], &v)) {
> +               if (!git_configset_get_value(&cs, argv[1], &v)) {
>                         if (!v)
>                                 printf("(NULL)\n");
>                         else
>                                 printf("%s\n", v);
>                 } else {
> -                       printf("Value not found for \"%s\"\n", argv[2]);
> +                       printf("Value not found for \"%s\"\n", argv[1]);
>                         ret = TC_VALUE_NOT_FOUND;
>                 }
> -       } else if (argc >= 3 && !strcmp(argv[1], "configset_get_value_multi")) {
> -               for (i = 3; i < argc; i++) {
> +       } else if (argc >= 2 && !strcmp(argv[0], "configset_get_value_multi")) {
> +               if (subrepo_path) {
> +                       fprintf(stderr, "Cannot use --submodule with configset_get_value_multi\n");
> +                       ret = TC_USAGE_ERROR;
> +                       goto out;
> +               }
> +               for (i = 2; i < argc; i++) {
>                         int err;
>                         if ((err = git_configset_add_file(&cs, argv[i]))) {
>                                 fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
> @@ -171,7 +219,7 @@ int cmd__config(int argc, const char **argv)
>                                 goto out;
>                         }
>                 }
> -               strptr = git_configset_get_value_multi(&cs, argv[2]);
> +               strptr = git_configset_get_value_multi(&cs, argv[1]);
>                 if (strptr) {
>                         for (i = 0; i < strptr->nr; i++) {
>                                 v = strptr->items[i].string;
> @@ -181,18 +229,23 @@ int cmd__config(int argc, const char **argv)
>                                         printf("%s\n", v);
>                         }
>                 } else {
> -                       printf("Value not found for \"%s\"\n", argv[2]);
> +                       printf("Value not found for \"%s\"\n", argv[1]);
>                         ret = TC_VALUE_NOT_FOUND;
>                 }
> -       } else if (!strcmp(argv[1], "iterate")) {
> -               git_config(iterate_cb, NULL);
> +       } else if (!strcmp(argv[0], "iterate")) {
> +               repo_config(repo, iterate_cb, NULL);
>         } else {
>  print_usage_error:
> -               fprintf(stderr, "Invalid syntax. Usage: test-tool config <cmd> [args]\n");
> +               fprintf(stderr, "Invalid syntax. Usage: test-tool config"
> +                               " [--submodule=<path>] <cmd> [args]\n");
>                 ret = TC_USAGE_ERROR;
>         }
>
>  out:
>         git_configset_clear(&cs);
> +       if (repo != the_repository) {
> +               repo_clear(repo);
> +               free(repo);
> +       }
>         return ret;
>  }
> diff --git a/t/t2404-worktree-config.sh b/t/t2404-worktree-config.sh
> index 286121d8de..b6ab793203 100755
> --- a/t/t2404-worktree-config.sh
> +++ b/t/t2404-worktree-config.sh
> @@ -76,4 +76,20 @@ test_expect_success 'config.worktree no longer read without extension' '
>         test_cmp_config -C wt2 shared this.is
>  '
>
> +test_expect_success 'correctly read config.worktree from submodules' '
> +       test_unconfig extensions.worktreeConfig &&
> +       git init sub &&
> +       (
> +               cd sub &&
> +               test_commit A &&
> +               git config extensions.worktreeConfig true &&
> +               git config --worktree wtconfig.sub test-value
> +       ) &&
> +       git submodule add ./sub &&
> +       git commit -m "add sub" &&
> +       echo test-value >expect &&
> +       test-tool config --submodule=sub get_value wtconfig.sub >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.26.2

The index updates seem fine, and I like the test, and I tried to look
at the submodule and config bits but I'm quite unfamiliar with that
area of the code and I'd like to see if we can find someone who knows
submodules and/or config a bit better to review those pieces.  A split
of this patch into two in your next roll of this series would be nice
so we can ask someone to look at just the relevant bits.
