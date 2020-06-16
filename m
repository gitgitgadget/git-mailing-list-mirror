Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21D6C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD81020810
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJrodrM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbgFPTNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbgFPTNo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 15:13:44 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC90C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:13:44 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id a21so20262459oic.8
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aTRU4eiZ8KawQvY7RQMna4rSGOuSfq4yk8lKImf2bi8=;
        b=KJrodrM/22ukE8G0OuLHigZT9p1Ddtri1MR2RjML/0/d2LDqcGdJ8LV6T+D0y1N+D3
         liWOw4XeQDoJ8Ts7L47yKnR2+EWpJBEwdz8PrrzJYBlY0siRNWJeIT5RAyVd9RXqGR+B
         H5fEO8KURP5oA/7WtPcbBKkAUuAP+HrjAkoy5KwtnpF4mWf6RgSI0qistT9NMGxfu1EC
         mMfL7cqnPTYH0qN/1iS+PurXXjrkbOttvTO0Skuzhi15W2s65VRMkFg611Hg96kWz7E2
         MVcSTU51sZM8YgwUs3BjA1GuQKG/0sBLEQ3vGPHUtSiPBtLD1hHRerynRlU8PD1NeQmh
         JIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTRU4eiZ8KawQvY7RQMna4rSGOuSfq4yk8lKImf2bi8=;
        b=oUmjlrZJzWNAzZGRqmP+m6u61Q46QjVMc65p64M3x8nn8H1yzvQe0QGkuxaszM2zfZ
         cWJh0Mdjgj+UMleHaAVAeA+jMRUqwXBPmfQG16frAgjmuMTY//8O5fzhyb9hDIbi7q5w
         8DoltF0Dwa7G08ujTS1D6362mRcWy4EkfUjHZFb6Hsq9jsa8IwLqtXgi2C30Dw5/toYQ
         oU63c5FMfvIZt8XBVZZRvrnUbmKoYYa8mqpU1Am6TFMQecPEBOqDShYGav6m8Muzp0LJ
         FPqymXPf8QaCZj9iNx/YZCp4aI3UguT/p/TZpQBXMyO6WBWuap5+FFhcsBnYHGYwi+0j
         +7pQ==
X-Gm-Message-State: AOAM530cEMfLHFycYA58zcKd+yfuYoUkqHC8GkLN4zCVtAs+ft4TCTZK
        Pno7hWszTW/NsGU+his9Yl3xq9cJKq3pkbkpKqE=
X-Google-Smtp-Source: ABdhPJzS5sZvUz5wnHuhM4GzblvYJ/171+3lIq1Udq/kpSNUvduC3IKOcqJJXZzzaiTLYiK8Ll2sO+BtSOCcD4goNGQ=
X-Received: by 2002:aca:6287:: with SMTP id w129mr4847375oib.167.1592334821762;
 Tue, 16 Jun 2020 12:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591974940.git.matheus.bernardino@usp.br> <6402c968077900d48d189551a652e10984437a9f.1591974940.git.matheus.bernardino@usp.br>
In-Reply-To: <6402c968077900d48d189551a652e10984437a9f.1591974940.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 16 Jun 2020 12:13:30 -0700
Message-ID: <CABPp-BGdEyEeajYZj_rdxp=MyEQdszuyjVTax=hhYj3fOtRQUQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] config: correctly read worktree configs in submodules
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Jun 12, 2020 at 8:45 AM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> One of the steps in do_git_config_sequence() is to load the
> worktree-specific config file. Although the function receives a git_dir
> string, it relies on git_pathdup(), which uses the_repository->git_dir,
> to make the path to the file. Furthermore, it also checks that
> extensions.worktreeConfig is set through the
> repository_format_worktree_config variable, which refers to
> the_repository only. Thus, when a submodule has worktree-specific
> settings, a command executed in the superproject that recurses into the
> submodule won't find the said settings.
>
> This will be especially important in the next patch: git-grep will learn
> to honor sparse checkouts and, when running with --recurse-submodules,
> the submodule's sparse checkout settings must be loaded. As these
> settings are stored in the config.worktree file, they would be ignored
> without this patch. So let's fix this by reading the right
> config.worktree file and extensions.worktreeConfig setting, based on the
> git_dir and commondir paths given to do_git_config_sequence(). Also
> add a test to avoid any regressions.

Thanks for splitting this part of the change out from the previous patch.

>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  config.c                   | 21 +++++++++---
>  t/helper/test-config.c     | 67 +++++++++++++++++++++++++++++++++-----
>  t/t2404-worktree-config.sh | 16 +++++++++
>  3 files changed, 91 insertions(+), 13 deletions(-)
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

What happens when opts->git_dir is NULL?  (Does that ever even
happen?)  Should it fall back to the old code path in that case?

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

I've tried to poke around a little at this block, but as with the
previous series, I still feel like it should be reviewed by someone
who knows submodules and/or config handling better.  That's easier now
that the patch has been split up.  Unfortunately, trying to figure out
who the submodule expert(s) are (looking at authors of
submodule*.[ch]) seems to lead me to a who's who of people who are no
longer active in the project.  :-(  Maybe Peff or jrnieder would have
suggestions; cc'ing them.

>         }
>
>         current_parsing_scope = CONFIG_SCOPE_COMMAND;
> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> index 61da2574c5..284f83a921 100644
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
> @@ -86,6 +93,8 @@ int cmd__config(int argc, const char **argv)
>         const struct string_list *strptr;
>         struct config_set cs = { .hash_initialized = 0 };
>         enum test_config_exit_code ret = TC_SUCCESS;
> +       struct repository *repo = the_repository;
> +       const char *subrepo_path = NULL;
>
>         argc--; /* skip over "config" */
>         argv++;
> @@ -93,7 +102,18 @@ int cmd__config(int argc, const char **argv)
>         if (argc == 0)
>                 goto print_usage_error;
>
> +       if (skip_prefix(*argv, "--submodule=", &subrepo_path)) {
> +               argc--;
> +               argv++;
> +               if (argc == 0)
> +                       goto print_usage_error;
> +       }
> +
>         if (argc == 2 && !strcmp(argv[0], "read_early_config")) {
> +               if (subrepo_path) {
> +                       fprintf(stderr, "Cannot use --submodule with read_early_config\n");
> +                       return TC_USAGE_ERROR;
> +               }
>                 read_early_config(early_config_cb, (void *)argv[1]);
>                 return TC_SUCCESS;
>         }
> @@ -101,8 +121,23 @@ int cmd__config(int argc, const char **argv)
>         setup_git_directory();
>         git_configset_init(&cs);
>
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
> +
>         if (argc == 2 && !strcmp(argv[0], "get_value")) {
> -               if (!git_config_get_value(argv[1], &v)) {
> +               if (!repo_config_get_value(repo, argv[1], &v)) {
>                         if (!v)
>                                 printf("(NULL)\n");
>                         else
> @@ -112,7 +147,7 @@ int cmd__config(int argc, const char **argv)
>                         ret = TC_VALUE_NOT_FOUND;
>                 }
>         } else if (argc == 2 && !strcmp(argv[0], "get_value_multi")) {
> -               strptr = git_config_get_value_multi(argv[1]);
> +               strptr = repo_config_get_value_multi(repo, argv[1]);
>                 if (strptr) {
>                         for (i = 0; i < strptr->nr; i++) {
>                                 v = strptr->items[i].string;
> @@ -126,27 +161,33 @@ int cmd__config(int argc, const char **argv)
>                         ret = TC_VALUE_NOT_FOUND;
>                 }
>         } else if (argc == 2 && !strcmp(argv[0], "get_int")) {
> -               if (!git_config_get_int(argv[1], &val)) {
> +               if (!repo_config_get_int(repo, argv[1], &val)) {
>                         printf("%d\n", val);
>                 } else {
>                         printf("Value not found for \"%s\"\n", argv[1]);
>                         ret = TC_VALUE_NOT_FOUND;
>                 }
>         } else if (argc == 2 && !strcmp(argv[0], "get_bool")) {
> -               if (!git_config_get_bool(argv[1], &val)) {
> +               if (!repo_config_get_bool(repo, argv[1], &val)) {
>                         printf("%d\n", val);
>                 } else {
> +
>                         printf("Value not found for \"%s\"\n", argv[1]);
>                         ret = TC_VALUE_NOT_FOUND;
>                 }
>         } else if (argc == 2 && !strcmp(argv[0], "get_string")) {
> -               if (!git_config_get_string_const(argv[1], &v)) {
> +               if (!repo_config_get_string_const(repo, argv[1], &v)) {
>                         printf("%s\n", v);
>                 } else {
>                         printf("Value not found for \"%s\"\n", argv[1]);
>                         ret = TC_VALUE_NOT_FOUND;
>                 }
>         } else if (argc >= 2 && !strcmp(argv[0], "configset_get_value")) {
> +               if (subrepo_path) {
> +                       fprintf(stderr, "Cannot use --submodule with configset_get_value\n");
> +                       ret = TC_USAGE_ERROR;
> +                       goto out;
> +               }
>                 for (i = 2; i < argc; i++) {
>                         int err;
>                         if ((err = git_configset_add_file(&cs, argv[i]))) {
> @@ -165,6 +206,11 @@ int cmd__config(int argc, const char **argv)
>                         ret = TC_VALUE_NOT_FOUND;
>                 }
>         } else if (argc >= 2 && !strcmp(argv[0], "configset_get_value_multi")) {
> +               if (subrepo_path) {
> +                       fprintf(stderr, "Cannot use --submodule with configset_get_value_multi\n");
> +                       ret = TC_USAGE_ERROR;
> +                       goto out;
> +               }
>                 for (i = 2; i < argc; i++) {
>                         int err;
>                         if ((err = git_configset_add_file(&cs, argv[i]))) {
> @@ -187,14 +233,19 @@ int cmd__config(int argc, const char **argv)
>                         ret = TC_VALUE_NOT_FOUND;
>                 }
>         } else if (!strcmp(argv[0], "iterate")) {
> -               git_config(iterate_cb, NULL);
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
