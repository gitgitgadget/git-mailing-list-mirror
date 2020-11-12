Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86DAC2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 23:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F6A21D79
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 23:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5qoYKVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgKLXyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 18:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKLXyb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 18:54:31 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8421BC0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 15:54:31 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id n15so7378616otl.8
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 15:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AgmnS+Eil8UVHN0PMn6gkJxoWjA+1YkDephvwKXcrdE=;
        b=I5qoYKVeLaYNR0bJb0rBiHSLYdmzS+T4SMbhDkLR0ub4QKbFn3W+hjk3Kdmc4ENnV1
         A63g9BLo+ZF6zIrtfaFIFL7gR+H/+uBW3/9Gs09NMWda/4iRl8TztLyyA850DkuuH+oX
         7b/S7q7cPLiknD3prkmYLoJp24BAhUGJX4JPTwq6PhqOuSNYHUPNCH7b4igQkXZVngCu
         Z9sw2qiEWhcS4M67OyYnitVFoTerJIYOO8HmwGN2dgUzpQzGNqmov5rPY+mtMqzQdBZa
         VrM0ooIvwuhd2p9hBJDil/mriUcutzf3bNPEsPLGIt6mNen04F1ETw0xRo2FZ0pwWWNs
         GKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AgmnS+Eil8UVHN0PMn6gkJxoWjA+1YkDephvwKXcrdE=;
        b=YNTk4F3+pesylpQJwd4kqavzxEBsoIVR6W9nf2jZhagyzzXz6L8BvrUkWePpRfnlTm
         b1W7vidnYI49jT5GsJAtQXHx69kBlYldR2WfxyPG0A47K2d4qJXW3/ezJou5XiEkArdq
         hzTASrpj0O2ojaaM7rP5YZHwRWfgUpPOwixX9Fqa+WPqGfdtmjkBHqAG6RQ7PJXA9XKz
         StD4pSNWfHEMZjq+OPdtqyc7axtzrBKre50F2nKEsPX3QhZdvhXb9jac4WUXZLQdtXGb
         9mczxoPlBi/2U7KvqiKP3C3sqjRH4UnZuXIKRSSwUt7xeaQt7aoYTsKwY9x4+5WblBMy
         KHNQ==
X-Gm-Message-State: AOAM530T85ZmL8MD6+uEyo5NgfuweR8iYMfCjHtnmiM76RZ/E6pizBSW
        gLmNQm8Amhu6JMvf5XG0hMcSFmmTk5rbYhmDruw=
X-Google-Smtp-Source: ABdhPJzJc4ck01AcGc8UHxBmvfPey09H4wQDYoJZxtuPGW8V5u6L8zJZm3ecO8yc+hDf1Ol+hmn7O7P1Wh7klrTqhbo=
X-Received: by 2002:a05:6830:12c2:: with SMTP id a2mr1285752otq.162.1605225270553;
 Thu, 12 Nov 2020 15:54:30 -0800 (PST)
MIME-Version: 1.0
References: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
In-Reply-To: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 Nov 2020 15:54:19 -0800
Message-ID: <CABPp-BGkkNwdjLB4HSygvU43OZRiuhDyt7RjrDGodWrfNgkBXQ@mail.gmail.com>
Subject: Re: [PATCH] rm: honor sparse checkout patterns
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Nov 12, 2020 at 1:02 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Make git-rm honor the 'sparse.restrictCmds' setting, by restricting its
> operation to the paths that match both the command line pathspecs and
> the repository's sparsity patterns. This better matches the expectations
> of users with sparse-checkout definitions, while still allowing them
> to optionally enable the old behavior with 'sparse.restrictCmds=false'
> or the global '--no-restrict-to-sparse-paths' option.

(For Stolee:) Did this arise when a user specified a directory to
delete, and a (possibly small) part of that directory was in the
sparse checkout while other portions of it were outside?

I can easily see users thinking they are dealing with just the files
relevant to them, and expecting the directory deletion to only affect
that relevant subset, so this seems like a great idea.  We'd just want
to make sure we have a good error message if they explicitly list a
single path outside the sparse checkout.

> Suggested-by: Derrick Stolee <stolee@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>
> This is based on mt/grep-sparse-checkout.
> Original feature request: https://github.com/gitgitgadget/git/issues/786
>
>  Documentation/config/sparse.txt  |  3 ++-
>  Documentation/git-rm.txt         |  9 +++++++++
>  builtin/rm.c                     |  7 ++++++-
>  t/t3600-rm.sh                    | 22 ++++++++++++++++++++++
>  t/t7011-skip-worktree-reading.sh |  5 -----
>  5 files changed, 39 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/config/sparse.txt b/Documentation/config/sparse.txt
> index 494761526e..79d7d173e9 100644
> --- a/Documentation/config/sparse.txt
> +++ b/Documentation/config/sparse.txt
> @@ -12,7 +12,8 @@ When this option is true (default), some git commands may limit their behavior
>  to the paths specified by the sparsity patterns, or to the intersection of
>  those paths and any (like `*.c`) that the user might also specify on the
>  command line. When false, the affected commands will work on full trees,
> -ignoring the sparsity patterns. For now, only git-grep honors this setting.
> +ignoring the sparsity patterns. For now, only git-grep and git-rm honor this
> +setting.
>  +
>  Note: commands which export, integrity check, or create history will always
>  operate on full trees (e.g. fast-export, format-patch, fsck, commit, etc.),
> diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
> index ab750367fd..25dda8ff35 100644
> --- a/Documentation/git-rm.txt
> +++ b/Documentation/git-rm.txt
> @@ -25,6 +25,15 @@ When `--cached` is given, the staged content has to
>  match either the tip of the branch or the file on disk,
>  allowing the file to be removed from just the index.
>
> +CONFIGURATION
> +-------------
> +
> +sparse.restrictCmds::
> +       By default, git-rm only matches and removes paths within the
> +       sparse-checkout patterns. This behavior can be changed with the
> +       `sparse.restrictCmds` setting or the global
> +       `--no-restrict-to-sparse-paths` option. For more details, see the
> +       full `sparse.restrictCmds` definition in linkgit:git-config[1].

Hmm, I wonder what people will think who are reading through the
manual and have never used sparse-checkout.  This seems prone to
confusion for them.  Maybe instead we could word this as:

When sparse-checkouts are in use, by default git-rm will only match
and remove paths within the sparse-checkout patterns...

>
>  OPTIONS
>  -------
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 4858631e0f..e1fe71c321 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -14,6 +14,7 @@
>  #include "string-list.h"
>  #include "submodule.h"
>  #include "pathspec.h"
> +#include "sparse-checkout.h"
>
>  static const char * const builtin_rm_usage[] = {
>         N_("git rm [<options>] [--] <file>..."),
> @@ -254,7 +255,7 @@ static struct option builtin_rm_options[] = {
>  int cmd_rm(int argc, const char **argv, const char *prefix)
>  {
>         struct lock_file lock_file = LOCK_INIT;
> -       int i;
> +       int i, sparse_paths_only;
>         struct pathspec pathspec;
>         char *seen;
>
> @@ -293,8 +294,12 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>
>         seen = xcalloc(pathspec.nr, 1);
>
> +       sparse_paths_only = restrict_to_sparse_paths(the_repository);
> +
>         for (i = 0; i < active_nr; i++) {
>                 const struct cache_entry *ce = active_cache[i];
> +               if (sparse_paths_only && ce_skip_worktree(ce))
> +                       continue;
>                 if (!ce_path_match(&the_index, ce, &pathspec, seen))
>                         continue;
>                 ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> index efec8d13b6..7bf55b42eb 100755
> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -892,4 +892,26 @@ test_expect_success 'rm empty string should fail' '
>         test_must_fail git rm -rf ""
>  '
>
> +test_expect_success 'rm should respect --[no]-restrict-to-sparse-paths' '
> +       git init sparse-repo &&
> +       (
> +               cd sparse-repo &&
> +               touch a b c &&
> +               git add -A &&
> +               git commit -m files &&
> +               git sparse-checkout set "/a" &&
> +
> +               # By default, it should not rm paths outside the sparse-checkout
> +               test_must_fail git rm b 2>stderr &&
> +               test_i18ngrep "fatal: pathspec .b. did not match any files" stderr &&

Ah, this answers my question about whether the user gets an error
message when they explicitly call out a single path outside the sparse
checkout.  I'm curious if we want to be slightly more verbose on the
error message when sparse-checkouts are in effect.  In particular, if
no paths match the sparsity patterns, but some paths would have
matched the pathspec ignoring the sparsity patterns, then perhaps the
error message should include a reference to the
--no-restrict-to-sparse-paths flag.

> +
> +               # But it should rm them with --no-restrict-to-sparse-paths
> +               git --no-restrict-to-sparse-paths rm b &&
> +
> +               # And also with sparse.restrictCmds=false
> +               git reset &&
> +               git -c sparse.restrictCmds=false rm b
> +       )
> +'
> +
>  test_done

Do we also want to include a testcase where the user specifies a
directory and part of that directory is within the sparsity paths and
part is out?  E.g.  'git sparse-checkout set /sub/dir && git rm -r
sub' ?

> diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
> index 26852586ac..1761a2b1b9 100755
> --- a/t/t7011-skip-worktree-reading.sh
> +++ b/t/t7011-skip-worktree-reading.sh
> @@ -132,11 +132,6 @@ test_expect_success 'diff-files does not examine skip-worktree dirty entries' '
>         test -z "$(git diff-files -- one)"
>  '
>
> -test_expect_success 'git-rm succeeds on skip-worktree absent entries' '
> -       setup_absent &&
> -       git rm 1
> -'
> -
>  test_expect_success 'commit on skip-worktree absent entries' '
>         git reset &&
>         setup_absent &&
> --
> 2.28.0

Sweet, nice and simple.  Thanks for sending this in; I think it'll be very nice.
