Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B60B320133
	for <e@80x24.org>; Wed,  8 Mar 2017 07:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750783AbdCHHZ0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 02:25:26 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36241 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbdCHHZX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 02:25:23 -0500
Received: by mail-qk0-f176.google.com with SMTP id 1so49623870qkl.3
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 23:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=1tL1XcKKQGKqnpxmXnSy1RHrh1kJBSXGPAf5UYjES6E=;
        b=Wc6N0aGH0Tupd7ZF/sxv4IU4hX7/c5LgsemhsflJ4V5uRshAXMxbWR8QJARsw21HKp
         noFfmSNGyAsdDik23+t5GOConnn2JYoj3BilIs11rWiBV3Coq4oqc1TFin+z1DZw/nyH
         eDiPqlNReGMZ07Cy+Udc5mYoKA1P1XzSgtKX59kbDdRqbyHx1GAEq1J8GCrAnGg2VId+
         xQFgOa9oSRu2BUD0GWWwkG0b6GZUCw0l+VbBWACpK9dQqv9bAnHJ4ONB+0zNNsKLCtAU
         nWunwtQlG4GPYgvJuOQerSJ4UNJusUpqc1H9T3adLsomoP4RxjX2UcUMOgIBP/G0Pjeu
         q/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=1tL1XcKKQGKqnpxmXnSy1RHrh1kJBSXGPAf5UYjES6E=;
        b=qTp+qTWeRH1McBXE1oh6gU+DStamg/8lKX2ZtA/MipiKjzFfGDmaiMz2Ah1eG+vJ4k
         6PXRoLIFaQKN0ZZ2EMjbxkFlR5ksNJVrsbo8M0Nj4OlG2iDFyLY0xreH3cuq1Y8kSvkS
         7qMv9jqGPBNv0MSXgoXCPjYU1dkTwJwQgSnUaAhSlW38R8CUO/W9XLRtKZO9RizT67au
         NGOVnolLe0ZUHoZ6CKa3iWtpwHw7oXbfgmQ8/3wRM0WatCWoT3ii+coEO3ZbrTmso+uq
         nj5GarW7qZzRpMRhTynbjAeaQy4Y/9qOZztdNkDMKPelAtWDMV3yK0BJl+Qqjj/PGcjx
         3HDg==
X-Gm-Message-State: AMke39mMjfcL4XhbExSej3roNQe/RvcDqJ+mESMFhl4t2QLKV9BZsx/D7N2nF7Qlca7bOwdRcxl18/TkFyEbaw==
X-Received: by 10.233.232.87 with SMTP id a84mr4620457qkg.104.1488936662085;
 Tue, 07 Mar 2017 17:31:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.178.20 with HTTP; Tue, 7 Mar 2017 17:30:41 -0800 (PST)
In-Reply-To: <20170308005615.20321-1-sbeller@google.com>
References: <xmqq7f4066t9.fsf@gitster.mtv.corp.google.com> <20170308005615.20321-1-sbeller@google.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Tue, 7 Mar 2017 17:30:41 -0800
X-Google-Sender-Auth: LI47hWG1di--LzxiJDwm6aluCh8
Message-ID: <CAPc5daWph1wPMqo_GEjixbY=t36MMaRaQ-mt3herWwxp0qHqcA@mail.gmail.com>
Subject: Re: [PATCHv2] rev-parse: add --show-superproject-working-tree
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Benjamin Fuchs <email@benjaminfuchs.de>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks more or less right but invoke "ls-files -z" and reading the \0
delimited output would be easier; otherwise you would have to worry
about c-unquoting the pathname when the submodule is bound at a path
with funny character (like a double-quote) in it.

Also, returning the exact string of the path from the API function is
absolutely the right thing. I however have to wonder if rev-parse need
to do the c-quoting unless it is told to show pathnames in its output
without quoting (perhaps with "-z")? Or are paths from "rev-parse"
(like "--git-dir", "--show-toplevel", etc.) already excempt from the
usual quoting rules---if so, doing puts() and nothing else is fine to
be consistent with the existing practice (in the longer term, I am
sure we would need to revisit so that scripts can handle paths with
funny characters sensibly, but that would be a different topic if
existing ones like "--git-dir" are already unsafe).

Sorry for top-posting (I am not on a terminal right now).

On Tue, Mar 7, 2017 at 4:56 PM, Stefan Beller <sbeller@google.com> wrote:
> In some situations it is useful to know if the given repository
> is a submodule of another repository.
>
> Add the flag --show-superproject-working-tree to git-rev-parse
> to make it easy to find out if there is a superproject.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> * not RFC anymore, but for real this time; including a test and docs :)
>
> * Following Junios advice: there is only one function
>   (superproject_exists was dropped) using ls-files.
>   (the test actually tests for a staged submodule)
>
> Thanks,
> Stefan
>
>
>  Documentation/git-rev-parse.txt |  5 +++
>  builtin/rev-parse.c             |  7 ++++
>  submodule.c                     | 83 +++++++++++++++++++++++++++++++++++++++++
>  submodule.h                     |  8 ++++
>  t/t1500-rev-parse.sh            | 14 +++++++
>  5 files changed, 117 insertions(+)
>
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 91c02b8c85..b841bad7c7 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -261,6 +261,11 @@ print a message to stderr and exit with nonzero status.
>  --show-toplevel::
>         Show the absolute path of the top-level directory.
>
> +--show-superproject-working-tree
> +       Show the absolute path of the top-level directory of
> +       the superproject. A superproject is a repository that records
> +       this repository as a submodule.
> +
>  --shared-index-path::
>         Show the path to the shared index file in split index mode, or
>         empty if not in split-index mode.
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index e08677e559..2549643267 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -12,6 +12,7 @@
>  #include "diff.h"
>  #include "revision.h"
>  #include "split-index.h"
> +#include "submodule.h"
>
>  #define DO_REVS                1
>  #define DO_NOREV       2
> @@ -779,6 +780,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>                                         puts(work_tree);
>                                 continue;
>                         }
> +                       if (!strcmp(arg, "--show-superproject-working-tree")) {
> +                               const char *superproject = get_superproject_working_tree();
> +                               if (superproject)
> +                                       puts(superproject);
> +                               continue;
> +                       }
>                         if (!strcmp(arg, "--show-prefix")) {
>                                 if (prefix)
>                                         puts(prefix);
> diff --git a/submodule.c b/submodule.c
> index 3b98766a6b..06473d3646 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1514,3 +1514,86 @@ void absorb_git_dir_into_superproject(const char *prefix,
>                 strbuf_release(&sb);
>         }
>  }
> +
> +const char *get_superproject_working_tree(void)
> +{
> +       struct child_process cp = CHILD_PROCESS_INIT;
> +       struct strbuf sb = STRBUF_INIT;
> +       const char *one_up = real_path_if_valid("../");
> +       const char *cwd = xgetcwd();
> +       const char *ret = NULL;
> +       const char *subpath;
> +       int code;
> +       ssize_t len;
> +
> +       if (!is_inside_work_tree())
> +               /*
> +                * FIXME:
> +                * We might have a superproject, but it is harder
> +                * to determine.
> +                */
> +               return NULL;
> +
> +       if (!one_up)
> +               return NULL;
> +
> +       subpath = relative_path(cwd, one_up, &sb);
> +
> +       prepare_submodule_repo_env(&cp.env_array);
> +       argv_array_pop(&cp.env_array);
> +
> +       argv_array_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
> +                       "ls-files", "--stage", "--full-name", "--", subpath, NULL);
> +       strbuf_reset(&sb);
> +
> +       cp.no_stdin = 1;
> +       cp.no_stderr = 1;
> +       cp.out = -1;
> +       cp.git_cmd = 1;
> +
> +       if (start_command(&cp))
> +               die(_("could not start ls-files in .."));
> +
> +       len = strbuf_read(&sb, cp.out, PATH_MAX);
> +       close(cp.out);
> +
> +       if (starts_with(sb.buf, "160000")) {
> +               int super_sub_len;
> +               int cwd_len = strlen(cwd);
> +               char *super_sub, *super_wt;
> +
> +               /*
> +                * There is a superproject having this repo as a submodule.
> +                * The format is <mode> SP <hash> SP <stage> TAB <full name> LF,
> +                * First remove LF, then skip up to \t.
> +                */
> +               strbuf_rtrim(&sb);
> +               super_sub = strchr(sb.buf, '\t') + 1;
> +
> +               super_sub_len = sb.buf + sb.len - super_sub;
> +               if (super_sub_len > cwd_len ||
> +                   strcmp(&cwd[cwd_len - super_sub_len], super_sub))
> +                       die (_("BUG: returned path string doesn't match cwd?"));
> +
> +               super_wt = xstrdup(cwd);
> +               super_wt[cwd_len - super_sub_len] = '\0';
> +
> +               ret = real_path(super_wt);
> +
> +               free(super_wt);
> +       }
> +       strbuf_release(&sb);
> +
> +       code = finish_command(&cp);
> +
> +       if (code == 128)
> +               /* '../' is not a git repository */
> +               return NULL;
> +       if (code == 0 && len == 0)
> +               /* There is an unrelated git repository at '../' */
> +               return NULL;
> +       if (code)
> +               die(_("ls-tree returned unexpected return code %d"), code);
> +
> +       return ret;
> +}
> diff --git a/submodule.h b/submodule.h
> index 05ab674f06..c8a0c9cb29 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -93,4 +93,12 @@ extern void prepare_submodule_repo_env(struct argv_array *out);
>  extern void absorb_git_dir_into_superproject(const char *prefix,
>                                              const char *path,
>                                              unsigned flags);
> +
> +/*
> + * Return the absolute path of the working tree of the superproject, which this
> + * project is a submodule of. If this repository is not a submodule of
> + * another repository, return NULL.
> + */
> +extern const char *get_superproject_working_tree(void);
> +
>  #endif
> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> index 9ed8b8ccba..03d3c7f6d6 100755
> --- a/t/t1500-rev-parse.sh
> +++ b/t/t1500-rev-parse.sh
> @@ -116,4 +116,18 @@ test_expect_success 'git-path inside sub-dir' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'showing the superproject correctly' '
> +       git rev-parse --show-superproject-working-tree >out &&
> +       test_must_be_empty out &&
> +
> +       test_create_repo super &&
> +       test_commit -C super test_commit &&
> +       test_create_repo sub &&
> +       test_commit -C sub test_commit &&
> +       git -C super submodule add ../sub dir/sub &&
> +       echo $(pwd)/super >expect  &&
> +       git -C super/dir/sub rev-parse --show-superproject-working-tree >out &&
> +       test_cmp expect out
> +'
> +
>  test_done
> --
> 2.12.0.190.g6a12a61b77.dirty
>
