Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A99C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 02:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D14861353
	for <git@archiver.kernel.org>; Tue, 18 May 2021 02:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbhERC2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 22:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236747AbhERC2q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 22:28:46 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A20C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 19:27:28 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so7355954oth.5
        for <git@vger.kernel.org>; Mon, 17 May 2021 19:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKvSCc8yoLQvs5ldsxoD0UKBzHJmi4E8haD0NxgWOLQ=;
        b=JDSXhFiUTNYsdsM0bB7eJwjf/8YmFnkPkGK01eQXclLVLKZnWmnJgbdpOWhS52F5hi
         q8DEUO83bfN8KdHz7HBXbscYpHCqS2EMP9dy9usxreO/X3ldTnBvMgy7ckAPCIBSS9r7
         DnYHZdPz+o+N4lVSAHpEuxJ/ct6xX/IovO/sWtinf6XU/psmdPsNVxt2ztcamM5e2/uW
         jZ2uhLZheuxfLneGdzQSE3extykoxh6vaDZ3z2hE6hVGVDCAjo67+26PsbFyiOFmH6gU
         KLQXJazRkck2sX9/pmzxA+WsfgH/pzWiBik6Bm8Wp3kGt3ux/yyr6bwk6xtG0dxxCiVU
         Vsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKvSCc8yoLQvs5ldsxoD0UKBzHJmi4E8haD0NxgWOLQ=;
        b=opLqd0NEtBC18kMUuN9GcGtvWKNUlMXCB3fdtkr5PCtRiNR14ZiT/p0YKvWc38D8bV
         MxtnmR8OZM0hhrT3/S/uUOAIYPy3cvSO2SaeuNSVxecWhrQLxi9nHn8DQA/KvKbIxuWf
         b9M5yYKFsP1o8hcBImB4tpCyO6chEUc59wfKY4vvSf9SFIbyzIFCK251T59zAiV0Amsy
         BRvWBx2cAjknG8zD/AJiILlp2+fwo5E7iFIY+ev0muyByg9RkK58vVIzSmnHUX5MTPFJ
         K54FEJRyGtUyYoL4KumsEP1f7/XJEhQUTbAOaIGcJvptZDj8mlyvJwlZtXVGNj8iVQYa
         krog==
X-Gm-Message-State: AOAM532sozbnHfTqGI9voxQMFitrvasRBA6TBMCRFlcH4I4gh/IWFB6V
        eon63EKz9gDk3G4VTRnr6Y4jz50hXQ4X3wEVJy8=
X-Google-Smtp-Source: ABdhPJzVdpjZJXQGsKbdRu/6lnP7W+zjtVNpDbQR7f9vTyLRhDl8pUl+4OYDw7RToCJC/gTUhAfEQWaHkLRQuB/3jp8=
X-Received: by 2002:a9d:67c5:: with SMTP id c5mr2221722otn.162.1621304848217;
 Mon, 17 May 2021 19:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
 <pull.932.v3.git.1621017072.gitgitgadget@gmail.com> <3b42783d4a86473420480b2789d61d8103e6e7d4.1621017072.git.gitgitgadget@gmail.com>
In-Reply-To: <3b42783d4a86473420480b2789d61d8103e6e7d4.1621017072.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 May 2021 19:27:17 -0700
Message-ID: <CABPp-BGww6VPMmp9dDyRJ2vgNCOdj16-LjU3aM3MM1NQ+T-pmg@mail.gmail.com>
Subject: Re: [PATCH v3 11/12] wt-status: expand added sparse directory entries
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 14, 2021 at 11:31 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> It is difficult, but possible, to get into a state where we intend to
> add a directory that is outside of the sparse-checkout definition. Add a

Then we need to fix that; allowing things to be added outside the
sparse-checkout definition is a bug[1][2].  That's an invariant I
believe we should maintain everywhere; things get really confusing to
users somewhere later down the road if we don't.  Matheus worked to
fix that with 'git add'; if there are other commands that need fixing
too, then we should also fix them.

[1] https://lore.kernel.org/git/CABPp-BFhyFiKSXdLM5q5t=ZKzr6V0pY7dbheierRaOHFbMEdkg@mail.gmail.com/
[2] https://lore.kernel.org/git/CABPp-BF0ZhbSs42R3Bw_r-hbhQ71qtbXSBqXdq0djyaan=8p=A@mail.gmail.com/

> test to t1092-sparse-checkout-compatibility.sh that demonstrates this
> using a combination of 'git reset --mixed' and 'git checkout --orphan'.

I think `git checkout --orphan` should just throw an error if
sparse-checkout is in use.  Allowing adding paths outside the
sparse-checkout set causes too much collateral and deferred confusion
for users.

> This test failed before because the output of 'git status
> --porcelain=v2' would not match on the lines for folder1/:
>
> * The sparse-checkout repo (with a full index) would output each path
>   name that is intended to be added.
>
> * The sparse-index repo would only output that "folder1/" is staged for
>   addition.
>
> The status should report the full list of files to be added, and so this
> sparse-directory entry should be expanded to a full list when reaching
> it inside the wt_status_collect_changes_initial() method. Use
> read_tree_at() to assist.

Having a sparse directory entry whose object_id in the index does not
match HEAD should be an error.  Have a CE_SKIP_WORKTREE non-directory
whose object_id in the index does not match HEAD should also be an
error.  I don't think we should complicate the code to try to handle
violations of those assumptions.  I do think we should add checks to
enforce that constraint (or BUG() if it's violated).

And yeah, that also means 'git sparse-checkout add/set' would need to
error out if paths are requested to be sparsified despite being
different from HEAD.

> Somehow, this loop over the cache entries was not guarded by
> ensure_full_index() as intended.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 28 +++++++++++++
>  wt-status.c                              | 50 ++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 59faf7381093..cd3669d36b53 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -492,4 +492,32 @@ test_expect_success 'sparse-index is not expanded' '
>         test_region ! index ensure_full_index trace2.txt
>  '
>
> +test_expect_success 'reset mixed and checkout orphan' '
> +       init_repos &&
> +
> +       test_all_match git checkout rename-out-to-in &&
> +       test_all_match git reset --mixed HEAD~1 &&
> +       test_sparse_match test-tool read-cache --table --expand &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git status --porcelain=v2 &&
> +
> +       # At this point, sparse-checkouts behave differently
> +       # from the full-checkout.
> +       test_sparse_match git checkout --orphan new-branch &&
> +       test_sparse_match test-tool read-cache --table --expand &&
> +       test_sparse_match git status --porcelain=v2 &&
> +       test_sparse_match git status --porcelain=v2
> +'
> +
> +test_expect_success 'add everything with deep new file' '
> +       init_repos &&
> +
> +       run_on_sparse git sparse-checkout set deep/deeper1/deepest &&
> +
> +       run_on_all touch deep/deeper1/x &&
> +       test_all_match git add . &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git status --porcelain=v2
> +'
> +
>  test_done
> diff --git a/wt-status.c b/wt-status.c
> index 0425169c1895..90db8bd659fa 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -654,6 +654,34 @@ static void wt_status_collect_changes_index(struct wt_status *s)
>         run_diff_index(&rev, 1);
>  }
>
> +static int add_file_to_list(const struct object_id *oid,
> +                           struct strbuf *base, const char *path,
> +                           unsigned int mode, void *context)
> +{
> +       struct string_list_item *it;
> +       struct wt_status_change_data *d;
> +       struct wt_status *s = context;
> +       char *full_name;
> +
> +       if (S_ISDIR(mode))
> +               return READ_TREE_RECURSIVE;
> +
> +       full_name = xstrfmt("%s%s", base->buf, path);
> +       it = string_list_insert(&s->change, full_name);
> +       d = it->util;
> +       if (!d) {
> +               CALLOC_ARRAY(d, 1);
> +               it->util = d;
> +       }
> +
> +       d->index_status = DIFF_STATUS_ADDED;
> +       /* Leave {mode,oid}_head zero for adds. */
> +       d->mode_index = mode;
> +       oidcpy(&d->oid_index, oid);
> +       s->committable = 1;
> +       return 0;
> +}
> +
>  static void wt_status_collect_changes_initial(struct wt_status *s)
>  {
>         struct index_state *istate = s->repo->index;
> @@ -668,6 +696,28 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
>                         continue;
>                 if (ce_intent_to_add(ce))
>                         continue;
> +               if (S_ISSPARSEDIR(ce->ce_mode)) {
> +                       /*
> +                        * This is a sparse directory entry, so we want to collect all
> +                        * of the added files within the tree. This requires recursively
> +                        * expanding the trees to find the elements that are new in this
> +                        * tree and marking them with DIFF_STATUS_ADDED.
> +                        */
> +                       struct strbuf base = STRBUF_INIT;
> +                       struct pathspec ps;
> +                       struct tree *tree = lookup_tree(istate->repo, &ce->oid);
> +
> +                       memset(&ps, 0, sizeof(ps));
> +                       ps.recursive = 1;
> +                       ps.has_wildcard = 1;
> +                       ps.max_depth = -1;
> +
> +                       strbuf_add(&base, ce->name, ce->ce_namelen);
> +                       read_tree_at(istate->repo, tree, &base, &ps,
> +                                    add_file_to_list, s);
> +                       continue;
> +               }
> +
>                 it = string_list_insert(&s->change, ce->name);
>                 d = it->util;
>                 if (!d) {
> --
> gitgitgadget

This was a really nice catch that you got this particular testcase.
While I disagree with the fix, I do have to say nice work on the catch
and the implementation otherwise.
