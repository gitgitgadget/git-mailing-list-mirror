Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA60C433E0
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 04:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC917206E2
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 04:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="RcJq2W1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgFAEop (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 00:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFAEoo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 00:44:44 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D827C061A0E
        for <git@vger.kernel.org>; Sun, 31 May 2020 21:44:44 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id o9so6465081ljj.6
        for <git@vger.kernel.org>; Sun, 31 May 2020 21:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+OQ0uKAa/XK7zCYjWfrxWhw75QItB+FbT7WaUSa2aw=;
        b=RcJq2W1CFl7wdP7//AGFNVJ6JkNnSPo1vXaTNw62HpabU0b2Nagt3RYbt3JampePHY
         iRmZSwB4+aniXIbUthfZVVjWyrCVtV9uXMiI7ji8s/nVgD0oGOJKYMp4HWxHXiDlb6CN
         P6CLvTlTBK8RulDVUy22dn3uJ7WeQSUEXHnL6gUeNZxunGiMuFlokNkdaepwYxdFeuJ0
         FNPQjPN+704LiO5YbnpC5vKj3kYRyTGtI4PlpkLnF19BJv8JA85e0qLcp0clyxdvawz5
         BbKvTgQvb4L6HY1YkdkBF8hWULcU2PJjfsy0SZgL6363pym8lhv4GLOQ8HnjHaQLdAkk
         sfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+OQ0uKAa/XK7zCYjWfrxWhw75QItB+FbT7WaUSa2aw=;
        b=YTaY5TcFYHmtp6M/+H2j/kuOGlmW9qkZk+7VnAK9CSX2tIi46efB1Chg7njluAJ608
         5oKhjiRxL4QKSYc497w3KhBfyuqn0SWrDpioPZCvWOKXmmVRoHupg5fF3Tg/husKlumw
         hZXgtD1BltKXhaCEK+e1sPolD+IHbmpO2fZOWF4roThVjiMiOO3YfTHkh9gdd9DUpqfl
         THalmRSZLgANQFfIX2n2Q8s/bFBfiD6YGZEz/yoi5Z09StdqL4u+dzviZiBtH4fgQLpR
         qhKODwh+de0hWQje6Vnn9uUzX7CBCUGuB7JNu8V/bDBBU43CqBZSkOwwc8nRo4Q7OtEv
         /2TA==
X-Gm-Message-State: AOAM532w27sQiVRGE7Hb3bnb/ww7IG+iio1f6WaYuEyhB7jOGEvETGJg
        4KGuNz5Qu+/mKYCENFdNbTm3seRExH6Wg9nCEB6mKA==
X-Google-Smtp-Source: ABdhPJyOoOEysEsWYma/9tPttBiRQvOKr4jQRXkX3AK6JcN9BPljCzcSadWYSpsJbj1JNZlGQrBpZfr1bcGeEeNdvjE=
X-Received: by 2002:a2e:9dc2:: with SMTP id x2mr822709ljj.22.1590986682288;
 Sun, 31 May 2020 21:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590627264.git.matheus.bernardino@usp.br>
 <5ddac818185d316cd5ad9576105f0e4e695b9456.1590627264.git.matheus.bernardino@usp.br>
 <CABPp-BFsCPPNOZ92JQRJeGyNd0e-TCW-LcLyr0i_+VSQJP+GCg@mail.gmail.com>
In-Reply-To: <CABPp-BFsCPPNOZ92JQRJeGyNd0e-TCW-LcLyr0i_+VSQJP+GCg@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 1 Jun 2020 01:44:31 -0300
Message-ID: <CAHd-oW7JEu0rBrBMyjfFZ4WZ982+WwpGSvqg4meOwxmHjocknQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] grep: honor sparse checkout patterns
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 30, 2020 at 12:48 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, May 27, 2020 at 6:13 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > One of the main uses for a sparse checkout is to allow users to focus on
> > the subset of files in a repository in which they are interested. But
> > git-grep currently ignores the sparsity patterns and report all matches
> > found outside this subset, which kind of goes in the opposite direction.
> > Let's fix that, making it honor the sparsity boundaries for every
> > grepping case where this is relevant:
> >
> > - git grep in worktree
> > - git grep --cached
> > - git grep $REVISION
> >
> > For the worktree case, we will not grep paths that have the
> > SKIP_WORKTREE bit set, even if they are present for some reason (e.g.
> > manually created after `git sparse-checkout init`).
>
> This seems worded to rise alarm bells and make users suspect
> implementation difficulties or regrets rather than desired behavior.
> It would be much better to word this simply as something like:
>
>     For the worktree and cached cases, we iterate over paths without
> the SKIP_WORKTREE bit set, and limit our searches to these paths.
>
> > But the next patch
> > will add an option to do so. (See 'Note' below.)
>
> Because this was in the same paragraph as the previous sentence, it
> made it sound like you were going to provide a special worktree-only
> option to search outside the SKIP_WORKTREE bits.  Very confusing.  I
> think I'd combine this sentence into the very first paragraph of the
> commit message and massage the wording a little.  Perhaps something
> like:  ...goes in the opposite direction.  There are some usecases for
> ignoring the sparsity patterns and the next commit will add an option
> to obtain this behavior, but here we start by making grep honor the
> sparsity boundaries for every...
>
> > For `git grep $REVISION`, we will choose to honor the sparsity patterns
> > only when $REVISION is a commit-ish object. The reason is that, for a
> > tree, we don't know whether it represents the root of a repository or a
> > subtree. So we wouldn't be able to correctly match it against the
> > sparsity patterns. E.g. suppose we have a repository with these two
> > sparsity rules: "/*" and "!/a"; and the following structure:
> >
> > /
> > | - a (file)
> > | - d (dir)
> >     | - a (file)
> >
> > If `git grep $REVISION` were to honor the sparsity patterns for every
> > object type, when grepping the /d tree, we would wrongly ignore the /d/a
> > file. This happens because we wouldn't know it resides in /d and
> > therefore it would wrongly match the pattern "!/a". Furthermore, for a
> > search in a blob object, we wouldn't even have a path to check the
> > patterns against. So, let's ignore the sparsity patterns when grepping
> > non-commit-ish objects.
>
> This doesn't actually make it clear how you handle $REVISION which is
> a commit object; you focus so much on when $REVISION is just a tree
> and contrasting that case that you omit the behavior for the case of
> interest.  Also, $REVISION to my mind implies "commit"; if you want to
> imply that a commit or tree could be used, you'd use $TREE or
> $TREE_ISH or something else.  I think it'd make sense to cover all
> three relevant cases into a single paragraph (thus combining with the
> previous paragraph), and then add a second paragraph about the $TREE
> case that streamlines the last two pargraphs above.  So, perhaps we
> can your paragraphs from "For the worktree case, we will not grep
> paths..." all the way to "So, let's ignore the sparsity patterns when
> grepping non-commit-ish objects" (after first moving the comment about
> adding an option in the next commit to some other area of the commit
> message, as dicussed above) with something like the following:
>
>     For the worktree and cached cases, we iterate over paths without
> the SKIP_WORKTREE bit set, and limit our searches to these paths.  For
> the $REVISION case, we limit the paths we search to those that match
> the sparsity patterns.  (We do not check the SKIP_WORKTREE bit for the
> $REVISION case, because $REVISION may contain paths that do not exist
> in HEAD and thus for which we have no SKIP_WORKTREE bit to consult.
> The sparsity patterns tell us how the SKIP_WORKTREE bit would be set
> if we were to check out $REVISION, so we consult those.  Also, we
> don't use the sparsity paths with the worktree or cached cases, both
> because we have a bit we can check directly and more efficiently, and
> because unmerged entries from a merge or a rebase could cause more
> files to temporarily be present than the sparsity patterns would
> normally select.)
>
>     Note that there is a special case here: `git grep $TREE`.  In this
> case we cannot know whether $TREE corresponds to the root of the
> repository or some sub-tree, and thus there is no way for us to know
> which sparsity patterns, if any, apply.  So the $TREE case will not
> use sparsity patterns or any SKIP_WORKTREE bits and will instead
> always search all files within the $TREE.
>
> >
> > Note: The behavior introduced in this patch is what some users have
> > reported[1] that they would like by default. But the old behavior is
> > still desirable for some use cases. Therefore, the next patch will add
> > an option to allow restoring it when needed.
>
> This paragraph duplicates information you already stated previously.
> It's much clearer than what you stated before, but if you just reword
> the previous comments and combine them into the first paragraph, then
> we can drop this final note.

All great suggestions! I will amend the commit message using your
proposed paragraphs. Thanks!

> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> >  builtin/grep.c                   | 125 ++++++++++++++++++++--
> >  t/t7011-skip-worktree-reading.sh |   9 --
> >  t/t7817-grep-sparse-checkout.sh  | 174 +++++++++++++++++++++++++++++++
[...]
> > +static struct pattern_list *get_sparsity_patterns(struct repository *repo)
> > +{
> > +       struct pattern_list *patterns;
> > +       char *sparse_file;
> > +       int sparse_config, cone_config;
> > +
> > +       if (repo_config_get_bool(repo, "core.sparsecheckout", &sparse_config) ||
> > +           !sparse_config) {
> > +               return NULL;
> > +       }
>
> Is core_apply_sparse_checkout not initialized for some reason?

It should be already initialized, yes. But we cannot rely on that as
`repo` might be a submodule, and core_apply_sparse_checkout holds the
configuration's value for `the_repository`.

> > +static int in_sparse_checkout(struct strbuf *path, int prefix_len,
>
> This function name in_sparse_checkout() makes me think "Does the
> working tree represent a sparse checkout?"  Perhaps we could rename it
> to path_matches_sparsity_patterns() ?
>
> Also, is there a reason we can't use dir.c's
> path_matches_pattern_list() here?

Oh, we do use path_matches_pattern_list() inside:

> > +       *match = path_matches_pattern_list(path->buf, path->len,
> > +                                          path->buf + prefix_len, &dtype,
> > +                                          sparsity, istate);
> > +       if (*match == UNDECIDED)
> > +               *match = parent_match;

> How does this new function differ
> in behavior from that function?

The idea of in_sparse_checkout() is to implement a logic closer to
what we have in clear_ce_flags_1(). Here, it is effectively a wrapper
to path_matches_pattern_list() but with some extra logic to decide
whether grep should search in a given entry, based on its mode, the
match result against the sparsity patterns, and the result from the
parent dir.

> > diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
> > new file mode 100755
> > index 0000000000..ce080cf572
> > --- /dev/null
> > +++ b/t/t7817-grep-sparse-checkout.sh
> > @@ -0,0 +1,174 @@
> > +#!/bin/sh
> > +
> > +test_description='grep in sparse checkout
> > +
> > +This test creates a repo with the following structure:
> > +
> > +.
> > +|-- a
> > +|-- b
> > +|-- dir
> > +|   `-- c
> > +|-- sub
> > +|   |-- A
> > +|   |   `-- a
> > +|   `-- B
> > +|       `-- b
> > +`-- sub2
> > +    `-- a
> > +
> > +Where . has non-cone mode sparsity patterns, sub is a submodule with cone mode
>
> Maybe "Where the outer repository has non-code mode..."?  The use of
> '.' threw me for a bit.

Sure!

> > +test_done
> > --
> > 2.26.2
>
> Looks good.  Do we want to add a testcase where a file is unmerged and
> present in the working copy despite not matching the sparsity patterns
> (i.e. to emulate being in the middle of a merge/rebase/cherry-pick)?

Sure, I can add that. But after a quick test here, it seems that the
unmerged path doesn't have the SKIP_WORKTREE bit set. Is this how it
should be?
