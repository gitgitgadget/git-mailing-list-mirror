Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0507C4332B
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 07:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7780320724
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 07:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyfnMKrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgCXHzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:55:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36629 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgCXHzH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 03:55:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id l23so6080149otf.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 00:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=034BaOTCWULqYz3F4sjxR+5d0ERskGM6eg2VWarAP08=;
        b=dyfnMKrg5cQKFw8U34sxEIIt0BKe/L3ru8YkHAf+/v7af6mwr++X5eXiDwkoQsfNno
         BemM/1J6DjnzgMExsKYcuWo909/gkeZEqpDRY/1cRJvC11vSNzdONdy9Zgkq/SPKnDnW
         JatNSycGRF+1SGXjjsznbhEEeXrUKKs4mPsVgOc7HYXC6buE+49+CyjUd5R6QDue7pDn
         SMcO+U0fETyK5GAGqbsYWEDSRkdaspE4WxdI7k7+gpi1HAWm4GAZBNo+4P5TMjP7RFzG
         ZVcK1i/4r1aAvycGcNNWmWPETbWI8c5qntyZj3wVpvEwM9hzp7HOx7gaUo9YWpijHQBU
         H49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=034BaOTCWULqYz3F4sjxR+5d0ERskGM6eg2VWarAP08=;
        b=cymboP8cr9fgSDmLuRjIHwD/rcczxmPtH5f7vESqzmUruPNL7WZZAvOUbTsO+z/3Eg
         P4MLi1xOewc3W6sISlPGr1rtPy19SyVjWz4qRT1/5gFh9V1BzTjwZF/dikcHG853efb9
         Bvbwwvfsvke5oop9yeEAwy/ZLwHmvmctgCoE8jur9FBMOaZ2jcKZRKG+5wWLiy/SxTLc
         5f7KesX3Br3RQsdVVVsUBFi5RnQAxu6YVyiQtnz23dCDLI73yqbkLXMAV7YUbyyiy/YS
         jAf/x13VGMXnsnd9lD5dPkLy4OmFr0SeXnWeuNJcmG0K4y65mUTQAryy+r+4lh4nspc0
         HhEg==
X-Gm-Message-State: ANhLgQ0slJaPM0RfbODcYAVpZb60nK4xW7O3g5swwLEk5oZoUuCPX96P
        eu6FEwGQ1IGl6Kow5n8gN/SD0cIJdORWbTRO8YU75P6KebU=
X-Google-Smtp-Source: ADFU+vvI4Wdo47dVkCn5nHqMmIihaaUPa2BmArRwFrEwnfoKNoLZrbuE8O2FvOgvyYFwNId5ju3QMZ6tfK69qhLVLI4=
X-Received: by 2002:a05:6830:2428:: with SMTP id k8mr1161534ots.345.1585036506059;
 Tue, 24 Mar 2020 00:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br> <a76242ecfa69cf29995bd859305dc2ab1bc1a221.1585027716.git.matheus.bernardino@usp.br>
In-Reply-To: <a76242ecfa69cf29995bd859305dc2ab1bc1a221.1585027716.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 Mar 2020 00:54:54 -0700
Message-ID: <CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] grep: add option to ignore sparsity patterns
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 23, 2020 at 11:13 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> In the last commit, git-grep learned to honor sparsity patterns. For
> some use cases, however, it may be desirable to search outside the
> sparse checkout. So add the '--ignore-sparsity' option, which restores
> the old behavior. Also add the grep.ignoreSparsity configuration, to
> allow setting this behavior by default.

Should `--ignore-sparsity` be a global git option rather than a
grep-specific one?  Also, should grep.ignoreSparsity rather be
core.ignoreSparsity or core.searchOutsideSparsePaths or something?  In
particular, I want a world where:

* Someone can do a "sparse" clone that is NOT just about
sparse-checkout but also about partial clone.  In particular, it makes
use of partial clones to download only the history for the sparsity
paths, and does a sparse-checkout --cone to get those checked out.
(Or, perhaps, defaults to just downloading history for the toplevel
dir, much like `sparse-checkout init --cone`, and then when the user
runs `sparse-checkout set $dir1 $dir2 ...` then it downloads the extra
bits).
* grep, diff, log, shortlog, blame, bisect (and maybe others) all by
default make use of the sparsity patterns to limit their output (but
can all use whatever flag(s) are added here to search outside the
sparsity pattern cones).  This helps users feel they are in a smaller
repo and searching just their area of interest, and it avoids partial
clones downloading blobs unnecessarily.  Nice for the user, and nice
for the system.
* worktrees behave nicer; when creating a new one it inherits the
sparsity patterns of the parent (again to avoid partail clones having
to download everything, and let users continue working on their area
of interest, though they can disable sparse checkouts at any time, of
course).  Still would like Junio's feedback on this one.
* rebase, merge, cherry-pick, etc. (all via the merge machiner) have
smarter tree-merging logic such that when trees are unchanged on one
or both sides of history, we take advantage of the subset of those
cases where we can avoid traversing into subtrees but can resolve the
merge at the tree level.  This is a performance optimization even when
you have all trees and blob available, but an even more important one
if you don't want partial clones to suddenly have to download
unnecessary objects.  I have ideas and am working on this as part of
merge-ort.

> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>
> Note: I still have to make --ignore-sparsity be able to work together
> with --untracked. Unfortunatelly, this won't be as simple because the
> codeflow taken by --untracked goes to grep_directory() which just
> iterates the working tree, without looking the index entries. So I will
> have to either: make --untracked use grep_cache(), and grep the
> untracked files later; or try matching the working tree paths against
> the sparsity patterns, without looking for the skip_worktree bit in
> the index (as I mentioned in the previous patch's comments). Any
> preferences regarding these two approaches? (or other suggestions?)

Hmm.  So, 'tracked' in git is the idea that we are keeping information
about specific files.  'sparse-checkout' is the idea that we have a
subset of those that we can work with without materializing all the
other tracked files; it's clearly a subset of the realm of 'tracked'.
'untracked' is about getting everything outside the set of 'tracked'
files, which to me means it is clearly outside the set of sparsity
paths too (and thus you could take --untracked as implying
--ignore-sparsity, though whether you do might not matter in practice
because of the items I'll discuss next).  Of course, I am also
assuming `--untracked` is incompatible with --cached or specifying
revisions or trees (based on it's definiton of "In addition to
searching in the tracked files in the *working tree*, search also in
untracked files." -- emphasis added.)  If the incompatibility of
--untracked and --cached/REVSIONS/TREES is not enforced, we may want
to look into erroring out if they are given together.  Once we do, we
don't have to worry about grep_cache() at all in the case of
--untracked and shouldn't.  Files with the skip_worktree bit won't
exist in the working directory, and thus won't be searched (this is
what makes --untracked imply --ignore-sparsity not really matter).

In short: With --untracked you are grepping ALL (non-ignored) files in
the working directory -- either because they are both tracked and in
the sparsity paths (anything tracked that isn't in the sparsity paths
has the skip_worktree bit and thus isn't present), or because it is an
untracked file.  [And this may be what grep_directory() already does.]

Does that make sense?

>  Documentation/config/grep.txt   |  3 +++
>  Documentation/git-grep.txt      |  5 ++++
>  builtin/grep.c                  | 19 +++++++++++----
>  t/t7817-grep-sparse-checkout.sh | 42 +++++++++++++++++++++++++++++++++
>  4 files changed, 65 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
> index 76689771aa..c1d49484c8 100644
> --- a/Documentation/config/grep.txt
> +++ b/Documentation/config/grep.txt
> @@ -25,3 +25,6 @@ grep.fullName::
>  grep.fallbackToNoIndex::
>         If set to true, fall back to git grep --no-index if git grep
>         is executed outside of a git repository.  Defaults to false.
> +
> +grep.ignoreSparsity::
> +       If set to true, enable `--ignore-sparsity` by default.
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 97e25d7b1b..5c5c66c056 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -65,6 +65,11 @@ OPTIONS
>         mechanism.  Only useful when searching files in the current directory
>         with `--no-index`.
>
> +--ignore-sparsity::
> +       In a sparse checked out repository (see linkgit:git-sparse-checkout[1]),
> +       also search in files that are outside the sparse checkout. This option
> +       cannot be used with --no-index or --untracked.

If they are outside the sparse checkout, then they are not present on
disk -- so what is this outside stuff that is being searched?  Perhaps
clarify that this is only useful in combination with
--cached/REVISION/TREE, where there do exist paths outside the
sparsity patterns that become relevant?

>  --recurse-submodules::
>         Recursively search in each submodule that has been initialized and
>         checked out in the repository.  When used in combination with the
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 52ec72a036..17eae3edd6 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -33,6 +33,8 @@ static char const * const grep_usage[] = {
>
>  static int recurse_submodules;
>
> +static int ignore_sparsity = 0;
> +
>  static int num_threads;
>
>  static pthread_t *threads;
> @@ -292,6 +294,9 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
>         if (!strcmp(var, "submodule.recurse"))
>                 recurse_submodules = git_config_bool(var, value);
>
> +       if (!strcmp(var, "grep.ignoresparsity"))
> +               ignore_sparsity = git_config_bool(var, value);
> +
>         return st;
>  }
>
> @@ -487,7 +492,7 @@ static int grep_cache(struct grep_opt *opt,
>         for (nr = 0; nr < repo->index->cache_nr; nr++) {
>                 const struct cache_entry *ce = repo->index->cache[nr];
>
> -               if (ce_skip_worktree(ce))
> +               if (!ignore_sparsity && ce_skip_worktree(ce))

Oh boy on the double negatives...maybe we want to rename this flag somehow?

>                         continue;
>
>                 strbuf_setlen(&name, name_base_len);
> @@ -502,7 +507,8 @@ static int grep_cache(struct grep_opt *opt,
>                          * cache entry are identical, even if worktree file has
>                          * been modified, so use cache version instead
>                          */
> -                       if (cached || (ce->ce_flags & CE_VALID)) {
> +                       if (cached || (ce->ce_flags & CE_VALID) ||
> +                           ce_skip_worktree(ce)) {
>                                 if (ce_stage(ce) || ce_intent_to_add(ce))
>                                         continue;
>                                 hit |= grep_oid(opt, &ce->oid, name.buf,
> @@ -549,7 +555,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>                 name_base_len = name.len;
>         }
>
> -       if (from_commit && repo_read_index(repo) < 0)
> +       if (!ignore_sparsity && from_commit && repo_read_index(repo) < 0)
>                 die(_("index file corrupt"));
>
>         while (tree_entry(tree, &entry)) {
> @@ -570,7 +576,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>
>                 strbuf_add(base, entry.path, te_len);
>
> -               if (from_commit) {
> +               if (!ignore_sparsity && from_commit) {
>                         int pos = index_name_pos(repo->index,
>                                                  base->buf + tn_len,
>                                                  base->len - tn_len);
> @@ -932,6 +938,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>                 OPT_BOOL_F(0, "ext-grep", &external_grep_allowed__ignored,
>                            N_("allow calling of grep(1) (ignored by this build)"),
>                            PARSE_OPT_NOCOMPLETE),
> +               OPT_BOOL(0, "ignore-sparsity", &ignore_sparsity,
> +                        N_("also search in files outside the sparse checkout")),
>                 OPT_END()
>         };
>
> @@ -1073,6 +1081,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>         if (recurse_submodules && untracked)
>                 die(_("--untracked not supported with --recurse-submodules"));
>
> +       if (ignore_sparsity && (!use_index || untracked))
> +               die(_("--no-index or --untracked cannot be used with --ignore-sparsity"));
> +
>         if (show_in_pager) {
>                 if (num_threads > 1)
>                         warning(_("invalid option combination, ignoring --threads"));
> diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
> index fccf44e829..1891ddea57 100755
> --- a/t/t7817-grep-sparse-checkout.sh
> +++ b/t/t7817-grep-sparse-checkout.sh
> @@ -85,4 +85,46 @@ test_expect_success 'grep <tree-ish> should search outside sparse checkout' '
>         test_cmp expect_t-tree actual_t-tree
>  '
>
> +for cmd in 'git grep --ignore-sparsity' 'git -c grep.ignoreSparsity grep' \
> +          'git -c grep.ignoreSparsity=false grep --ignore-sparsity'
> +do
> +       test_expect_success "$cmd should search outside sparse checkout" '
> +               cat >expect <<-EOF &&
> +               a:text
> +               b:text
> +               dir/c:text
> +               EOF
> +               $cmd "text" >actual &&
> +               test_cmp expect actual
> +       '
> +
> +       test_expect_success "$cmd --cached should search outside sparse checkout" '
> +               cat >expect <<-EOF &&
> +               a:text
> +               b:text
> +               dir/c:text
> +               EOF
> +               $cmd --cached "text" >actual &&
> +               test_cmp expect actual
> +       '
> +
> +       test_expect_success "$cmd <commit-ish> should search outside sparse checkout" '
> +               commit=$(git rev-parse HEAD) &&
> +               cat >expect_commit <<-EOF &&
> +               $commit:a:text
> +               $commit:b:text
> +               $commit:dir/c:text
> +               EOF
> +               cat >expect_t-commit <<-EOF &&
> +               t-commit:a:text
> +               t-commit:b:text
> +               t-commit:dir/c:text
> +               EOF
> +               $cmd "text" $commit >actual_commit &&
> +               test_cmp expect_commit actual_commit &&
> +               $cmd "text" t-commit >actual_t-commit &&
> +               test_cmp expect_t-commit actual_t-commit
> +       '
> +done
> +
>  test_done
> --
> 2.25.1

I think there are several things that we need to straighten out first
and will affect a lot of this patch quite a bit:
* The feedback from the previous patch that the revision handling
should use sparsity patterns rather than ce_skip_worktree() is going
to affect this patch a fair amount.
* I think the fact that --ignore-sparsity is meaningless without
--cached or a REVISION or TREE may also affect things.
* The decision about how to globally name and set the
"ignore-sparsity" bit without requiring users to set it for each and
every subcommand will change this patch a bit too.


I'm super excited to see work in this area.  I hope I'm not
discouraging you by attempting to provide what I think is the bigger
picture I'd like us to work towards.
