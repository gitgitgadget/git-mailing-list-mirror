Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230BBC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 03:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbiBWDL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 22:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbiBWDL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 22:11:26 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805E653E33
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 19:10:59 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gb39so49077144ejc.1
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 19:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbu8M1zl6P+KTXvsNrCmsymu90iYCFUDZdMVyVNEP2g=;
        b=SCEQYPdyNnoXBg8zotIlVqRIj//C5S27uF0BKth+5LdsjSC0i3QH7fpaEWGqNDLfWn
         DQYRcI9CxHXAp+/uoG7jXgbybbXi9+25FPJNd9rjxR4MksJ8kdK7D+CVnG9Qh75mTdmx
         lDlXcYLCwhDGWt2iAtQLf1auP26ns+pIb0wmJLjSlnnzCDqFewOaoJmIWzV6ywgv2yvW
         bwT+R428X5vMHgKNhzXeZFfqyoite9cZ7LTiRoo273V1fpUrhDqfscTuibdaUhyc8hLp
         36IGOpj4zRdtXQXPEI/6Mv3b/udCC+EQBGnkj7J36j98Wbea1rfk5JWeO/gtRbh6TgWi
         KNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbu8M1zl6P+KTXvsNrCmsymu90iYCFUDZdMVyVNEP2g=;
        b=MXgGmBscOGnQ2THCCS8NMCM62+xdDG7UcXBafheVFisSvLg8kPWz9eWRe/iu2/mDZD
         tgtRFwnr6C/1aF2RVbxEwYF8L11y84I9cA1TkUSNkpEUNj5Zo04sMmvOu4/zdZ+FsJks
         EUsl3JC26wgc3IwQ5PbQYg3t/rOjisvg/wEpXtEMLLm86bfeHBJCda6lwFINuq5wwanr
         sE7vYpHijP/NWww139Eq7ZwkWR08uIpJbakgwTNZLFDnis8AyXFuC/lV8l3qexUhK47J
         z7OFLdfNmC+abQH+3h9JWnN9/ap/dxIDbahBrUx2DBxV1QqH0pEv7/IRsb3zn0oMGYHz
         iofQ==
X-Gm-Message-State: AOAM532KqpfhasldJ29P29/AJB+6bMK/LCR/9tKwTr5W5v5ocXgzPlHq
        VUlmhNkdeFdRpC6pRs3wrHQmRn5g0dyJRaHmDPQ=
X-Google-Smtp-Source: ABdhPJzvcFp1z680Bd/NfQ4s/iNMBW1Uxml3i7tshYA+g/b1QH4PwyJ/nMG9djLcinDHJDWLLSffAItrM1TyiuwWKEM=
X-Received: by 2002:a17:906:3a18:b0:6cd:ba45:995f with SMTP id
 z24-20020a1709063a1800b006cdba45995fmr22139094eje.328.1645585857868; Tue, 22
 Feb 2022 19:10:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1153.git.1645333542011.gitgitgadget@gmail.com> <YhWbWOd6PeF1RZw1@google.com>
In-Reply-To: <YhWbWOd6PeF1RZw1@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Feb 2022 19:10:46 -0800
Message-ID: <CABPp-BHv4VVyPv1v-pgPXf_u=6EpRhcn7Cm551o2HEbdEthAaw@mail.gmail.com>
Subject: Re: [PATCH v2] repo_read_index: add config to expect files outside
 sparse patterns
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 22, 2022 at 6:26 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> From: Elijah Newren <newren@gmail.com>
>
> Typically with sparse checkouts, we expect files outside the sparsity
> patterns to be marked as SKIP_WORKTREE and be missing from the working
> tree.  In edge cases, this can be violated and cause confusion, so in
> a sparse checkout, since 11d46a399d ("repo_read_index: clear
> SKIP_WORKTREE bit from files present in worktree", 2022-01-06), Git
> automatically clears the SKIP_WORKTREE bit at read time for entries
> corresponding to files that are present in the working tree.
>
> However, there is a more atypical situation where this situation would
> be expected.  A Git-aware virtual file system[1] takes advantage of
> its position as a file system driver to expose all files in the
> working tree, fetch them on demand using partial clone on access, and
> tell Git to pay attention to them on demand by updating the sparse
> checkout pattern on writes.  This means that commands like "git
> status" only has to examine files that have potentially been modified,
> whereas commands like "ls" are able to show the entire codebase
> without requiring manual updates to the sparse checkout pattern.

Should that be s/commands/a command/ or else s/only has/only have/?

> Thus since 11d46a399d, Git with such Git-aware virtual file systems
> unsets the SKIP_WORKTREE bit for all files and commands like "git
> status" have to fetch and examine them all.
>
> Introduce a configuration setting sparse.expectFilesOutsideOfPatterns
> to allow limiting the tracked set of files to a small set once again.
> A Git-aware virtual file system or other application that wants to
> maintain files outside of the sparse checkout can set this in a
> repository to instruct Git not to check for the presence of
> SKIP_WORKTREE files.  The setting defaults to false, so most users of
> sparse checkout will still get the benefit of an automatically
> updating index to recover from interrupted updates that forget to

Please don't presume that these only come from interrupted updates.
As per the referenced 11d46a399d that started all this:

"""
    There are various ways for users to get files to be present in the
    working copy despite having the SKIP_WORKTREE bit set for that file in
    the index.  This may come from:
      * various git commands not really supporting the SKIP_WORKTREE bit[1,2]
      * users grabbing files from elsewhere and writing them to the worktree
        (perhaps even cached in their editor)
      * users attempting to "abort" a sparse-checkout operation with a
        not-so-early Ctrl+C (updating $GIT_DIR/info/sparse-checkout and the
        working tree is not atomic)[3].
"""

> delete some files or unset SKIP_WORKTREE for them.

The only problem 11d46a399d corrects is having the SKIP_WORKTREE being
*set* despite the file being present.  So the "recover from...updates
that...unset SKIP_WORKTREE" doesn't make any sense.

> [1] such as the vfsd described in
> https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google.com/
>
> [jn: fleshed out commit message and documentation, added missing
>  include to config.txt, moved to a separate config callback]
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Some minor updates, but this is basically the same as the patch you
> sent.  Thoughts?

...and it looks even more like the v2 I was about to send, so it seems
like we're pretty much on the same page.  :-)

Overall, it looks good, and your version has some things that are
nicer than mine, but I did have a couple small notes on the commit
message above and a similar one on the config description below.

> Thanks,
> Jonathan
>
>  Documentation/config.txt         |  2 ++
>  Documentation/config/sparse.txt  | 24 ++++++++++++++++++++++++
>  cache.h                          |  1 +
>  config.c                         | 14 ++++++++++++++
>  environment.c                    |  1 +
>  sparse-index.c                   |  3 ++-
>  t/t1090-sparse-checkout-scope.sh | 19 +++++++++++++++++++
>  7 files changed, 63 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/config/sparse.txt
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index b168f02dc3d..8628ae2634d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -468,6 +468,8 @@ include::config/sequencer.txt[]
>
>  include::config/showbranch.txt[]
>
> +include::config/sparse.txt[]
> +
>  include::config/splitindex.txt[]
>
>  include::config/ssh.txt[]
> diff --git a/Documentation/config/sparse.txt b/Documentation/config/sparse.txt
> new file mode 100644
> index 00000000000..c790c728276
> --- /dev/null
> +++ b/Documentation/config/sparse.txt
> @@ -0,0 +1,24 @@
> +sparse.expectFilesOutsideOfPatterns::
> +       Typically with sparse checkouts, files not matching any
> +       sparsity patterns are marked as such in the index file and
> +       missing from the working tree.  Accordingly, Git will
> +       ordinarily check whether files that the index indicates are
> +       outside of the sparse area are present in the working tree and
> +       mark them as present in the index if so.  This option can be
> +       used to tell Git that such present-but-unmatching files are
> +       expected and to stop checking for them.
> ++
> +The default is `false`.  Leaving this set to `false` is recommended in
> +most situations because it allows Git to recover from an interrupted
> +operation that updated the working tree without updating the index or
> +vice versa.

Again, please don't claim this is only for recovering from interrupted
operations; there are other cases -- Git commands that write the
working tree but not the index (checkout-index, git apply), and users
mucking around with files, for example.

> ++
> +A Git-based virtual file system (VFS) can turn the usual expectation
> +on its head: files are present in the working copy but do not take
> +up much disk space because their contents are not downloaded until
> +they are accessed.  With such a virtual file system layer, most files
> +do not match the sparsity patterns at first, and the VFS layer
> +updates the sparsity patterns to add more files whenever files are
> +written.  Setting this to `true` supports such a setup where files are
> +expected to be present outside the sparse area and a separate, robust
> +mechanism is responsible for keeping the sparsity patterns up to date.
> diff --git a/cache.h b/cache.h
> index 281f00ab1b1..b6b8e83ae35 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1003,6 +1003,7 @@ extern const char *core_fsmonitor;
>
>  extern int core_apply_sparse_checkout;
>  extern int core_sparse_checkout_cone;
> +extern int sparse_expect_files_outside_of_patterns;
>
>  /*
>   * Returns the boolean value of $GIT_OPTIONAL_LOCKS (or the default value).
> diff --git a/config.c b/config.c
> index 2bffa8d4a01..9b9ad1500aa 100644
> --- a/config.c
> +++ b/config.c
> @@ -1544,6 +1544,17 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
>         return platform_core_config(var, value, cb);
>  }
>
> +static int git_default_sparse_config(const char *var, const char *value)
> +{
> +       if (!strcmp(var, "sparse.expectfilesoutsideofpatterns")) {
> +               sparse_expect_files_outside_of_patterns = git_config_bool(var, value);
> +               return 0;
> +       }
> +
> +       /* Add other config variables here and to Documentation/config/sparse.txt. */
> +       return 0;
> +}
> +
>  static int git_default_i18n_config(const char *var, const char *value)
>  {
>         if (!strcmp(var, "i18n.commitencoding"))
> @@ -1675,6 +1686,9 @@ int git_default_config(const char *var, const char *value, void *cb)
>                 return 0;
>         }
>
> +       if (starts_with(var, "sparse."))
> +               return git_default_sparse_config(var, value);
> +
>         /* Add other config variables here and to Documentation/config.txt. */
>         return 0;
>  }
> diff --git a/environment.c b/environment.c
> index fd0501e77a5..fb55bf61290 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -70,6 +70,7 @@ char *notes_ref_name;
>  int grafts_replace_parents = 1;
>  int core_apply_sparse_checkout;
>  int core_sparse_checkout_cone;
> +int sparse_expect_files_outside_of_patterns;
>  int merge_log_config = -1;
>  int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
>  unsigned long pack_size_limit_cfg;
> diff --git a/sparse-index.c b/sparse-index.c
> index eed170cd8f7..daeb5112a18 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -396,7 +396,8 @@ void clear_skip_worktree_from_present_files(struct index_state *istate)
>
>         int i;
>
> -       if (!core_apply_sparse_checkout)
> +       if (!core_apply_sparse_checkout ||
> +           sparse_expect_files_outside_of_patterns)
>                 return;
>
>  restart:
> diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
> index 3deb4901874..d1833c0f31b 100755
> --- a/t/t1090-sparse-checkout-scope.sh
> +++ b/t/t1090-sparse-checkout-scope.sh
> @@ -52,6 +52,25 @@ test_expect_success 'return to full checkout of main' '
>         test "$(cat b)" = "modified"
>  '
>
> +test_expect_success 'skip-worktree on files outside sparse patterns' '
> +       git sparse-checkout disable &&
> +       git sparse-checkout set --no-cone "a*" &&
> +       git checkout-index --all --ignore-skip-worktree-bits &&
> +
> +       git ls-files -t >output &&
> +       ! grep ^S output >actual &&
> +       test_must_be_empty actual &&
> +
> +       test_config sparse.expectFilesOutsideOfPatterns true &&
> +       cat <<-\EOF >expect &&
> +       S b
> +       S c
> +       EOF
> +       git ls-files -t >output &&
> +       grep ^S output >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_expect_success 'in partial clone, sparse checkout only fetches needed blobs' '
>         test_create_repo server &&
>         git clone "file://$(pwd)/server" client &&
> --
> 2.35.1.574.g5d30c73bfb
