Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5C4C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A5B20637
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akBV8kgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCJS4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:56:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46869 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgCJS4b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 14:56:31 -0400
Received: by mail-ot1-f68.google.com with SMTP id 111so9903197oth.13
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWhS28BVCxP51Mx5JBRIXSr/BsvufbO1IYUndLoSogs=;
        b=akBV8kgf065ISUq04U+Nn/TaYl7JX/CtbTp29dAihll1VJFUhA7h0lk255MW3z+p1P
         28fuybskqi8m4qkYE7QTeSY0TPFkj6YQteJ3Pxk2U47/hTHm4r9PC6YdoIJsTi2n+xQz
         gO8o0hy2CYtAE7jw7VN5ODZNQmwZ4Md2TmTykdUhaUlIJeviQ703Jk/jySFNyjaYrdOa
         fO8Bk855d2pBXf3QSkfTPMBg42yBYaXXnDgReYMUGAHjXvkt8vnJKhhZniOz/mu4jNxk
         GCGj+CHAPJxWOOzjubIO/Xj4GYr/BztIOBAuTZIDmuOq6Qpebb3KAia8/ZpSwIyW4ARw
         zJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWhS28BVCxP51Mx5JBRIXSr/BsvufbO1IYUndLoSogs=;
        b=RLc69Q8Oxak4wtPXYeg725rw072wdi5KhWmzZ6OjGFT7Mg3U3Eo8woPZSVwdzbuEom
         wGCLDKjt9KaEb7jrwL0GPJ0TdiZLn4t96IZE0zniUriYJW9uc/XeufFV71Dg3tLTEGzN
         k0o24kQO5YIXP5Bbl46n/Ihk3NJkvchSLKBjJtMyRjyzOj7axY2I2VS4KKPD3A6i2cvr
         vIz3hS8B8019IoIAFQYK/b5BzI+EffUzan4gDelTBwwwmpjm6iBItho2zy6dwtLi5ngo
         oq72GHCDWQlu8Q4v1S3etC0A4+zE3VRzUSIbUkF27Z0V1oHHotD1cHK29po7c9WYcXqE
         tWUA==
X-Gm-Message-State: ANhLgQ1m0sNilLnC5tvHfUzz58rSVn2dlVAhX49+BZaG9/J2Ab7EXGde
        oGD5ui+kIpRkXliblVM6WNCSP7LS+cmSwHu3+XEPUusd
X-Google-Smtp-Source: ADFU+vt9pg8aBtIhmlrFe7GbYiQ0UfBfjsgM7aUcBWFRUjE4K7Wvsr2S5MH6lS6IVwy2MziLPwbpNJ16kKgEQBee4pQ=
X-Received: by 2002:a9d:6a99:: with SMTP id l25mr10525209otq.316.1583866589540;
 Tue, 10 Mar 2020 11:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200309205523.121319-1-jonathantanmy@google.com>
In-Reply-To: <20200309205523.121319-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 10 Mar 2020 11:56:23 -0700
Message-ID: <CABPp-BF17qYVZE6BWEh56QYKGojDG6yNz8QawX14XD8zeR=jig@mail.gmail.com>
Subject: Re: [PATCH] rebase --merge: optionally skip upstreamed commits
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 9, 2020 at 1:58 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> When rebasing against an upstream that has had many commits since the
> original branch was created:
>
>  O -- O -- ... -- O -- O (upstream)
>   \
>    -- O (my-dev-branch)
>
> because "git rebase" attempts to exclude commits that are duplicates of
> upstream ones, it must read the contents of every novel upstream commit,
> in addition to the tip of the upstream and the merge base. This can be a
> significant performance hit, especially in a partial clone, wherein a
> read of an object may end up being a fetch.

Does this suggest that the cherry-pick detection is suboptimal and
needs to be improved?  When rebasing, it is typical that you are just
rebasing a small number of patches compared to how many exist
upstream.  As such, any upstream patch modifying files outside the set
of files modified on the rebased side is known to not be PATCHSAME
without looking at those new files.  Or is the issue just the sheer
number of upstream commits that modify only the files also modified on
the rebased side is large?

> Add a flag to "git rebase" to allow suppression of this feature. This
> flag only works when using the "merge" backend.

Interesting.  A little over a year ago we discussed not only making
such a change in behavior, but making it the default; see
https://public-inbox.org/git/nycvar.QRO.7.76.6.1901211635080.41@tvgsbejvaqbjf.bet/
(from "Ooh, that's interesting" to "VFS for Git").

Since that time, we did indeed change the handling of commits that
become empty (so that they now default to dropping), which certainly
goes well with the new behavior to skip the cherry-pick detection.

One note: I think that old thread was wrong about the apply versus the
merge backends (which were referred to as "am" and "interactive" at
the time): both the apply and the merge backends have done the
cherry-pick detection so it wasn't a difference between the two.

> This flag changes the behavior of sequencer_make_script(), called from
> do_interactive_rebase() <- run_rebase_interactive() <-
> run_specific_rebase() <- cmd_rebase(). With this flag, limit_list()
> (indirectly called from sequencer_make_script() through
> prepare_revision_walk()) will no longer call cherry_pick_list(), and
> thus PATCHSAME is no longer set. Refraining from setting PATCHSAME both
> means that the intermediate commits in upstream are no longer read (as
> shown by the test) and means that no PATCHSAME-caused skipping of
> commits is done by sequencer_make_script(), either directly or through
> make_script_with_merges().
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> More improvements for partial clone, but this is a benefit for
> non-partial-clone as well, hence the way I wrote the commit message (not
> focusing too much on partial clone) and the documentation.

Yes, I've wanted to kill that performance overhead too even without
partial clones, though I was slightly worried about cases of a known
cherry-pick no longer cleanly applying and thus forcing the user to
detect that it has become empty.  I guess that's why it's a flag
instead of the new default, but there's something inside of me that
asks why this special case is detected for the user when other
conflict cases aren't...  Not sure if I'm just pigeonholing on
performance too much.

> I've chosen --skip-already-present and --no-skip-already-present to
> reuse the language already existing in the documentation and to avoid a
> double negative (e.g. --avoid-checking-if-already-present and
> --no-avoid-checking-if-already-present) but this causes some clumsiness
> in the documentation and in the code. Any suggestions for the name are
> welcome.

I'll add comments on this below.

> I've only implemented this for the "merge" backend since I think that
> there is an effort to migrate "rebase" to use the "merge" backend by
> default, and also because "merge" uses diff internally which already has
> the (per-commit) blob batch prefetching.

I understand the first half of your reason here, but I don't follow
the second half.  The apply backend uses diff to generate the patches,
but diff isn't the relevant operation here; it's the rev-list walking,
and both call the exact same rev-list walk the last time I checked so
I'm not sure what the difference is here.  Am I misunderstanding one
or more things?

> ---
>  Documentation/git-rebase.txt | 12 +++++-
>  builtin/rebase.c             | 10 ++++-
>  sequencer.c                  |  3 +-
>  sequencer.h                  |  2 +-
>  t/t3402-rebase-merge.sh      | 77 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 100 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 0c4f038dd6..f73a82b4a9 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -318,6 +318,15 @@ See also INCOMPATIBLE OPTIONS below.
>  +
>  See also INCOMPATIBLE OPTIONS below.
>
> +--skip-already-present::
> +--no-skip-already-present::
> +       Skip commits that are already present in the new upstream.
> +       This is the default.
> ++
> +If the skip-if-already-present feature is unnecessary or undesired,
> +`--no-skip-already-present` may improve performance since it avoids
> +the need to read the contents of every commit in the new upstream.
> +

I'm afraid the naming might be pretty opaque and confusing to users.
Even if we do keep the names, it might help to be clearer about the
ramifications.  And there's a missing reference to the option
incompatibility.  Perhaps something like:

--skip-cherry-pick-detection
--no-skip-cherry-pick-detection

    Whether rebase tries to determine if commits are already present
upstream, i.e. if there are commits which are cherry-picks.  If such
detection is done, any commits being rebased which are cherry-picks
will be dropped, since those commits are already found upstream.  If
such detection is not done, those commits will be re-applied, which
most likely will result in no new changes (as the changes are already
upstream) and result in the commit being dropped anyway.  cherry-pick
detection is the default, but can be expensive in repos with a large
number of upstream commits that need to be read.

See also INCOMPATIBLE OPTIONS below.

>  --rerere-autoupdate::
>  --no-rerere-autoupdate::
>         Allow the rerere mechanism to update the index with the
> @@ -866,7 +875,8 @@ Only works if the changes (patch IDs based on the diff contents) on
>  'subsystem' did.
>
>  In that case, the fix is easy because 'git rebase' knows to skip
> -changes that are already present in the new upstream.  So if you say
> +changes that are already present in the new upstream (unless
> +`--no-skip-already-present` is given). So if you say
>  (assuming you're on 'topic')
>  ------------
>      $ git rebase subsystem
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 6154ad8fa5..943211e5bb 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -88,13 +88,15 @@ struct rebase_options {
>         struct strbuf git_format_patch_opt;
>         int reschedule_failed_exec;
>         int use_legacy_rebase;
> +       int skip_already_present;
>  };
>
>  #define REBASE_OPTIONS_INIT {                          \
>                 .type = REBASE_UNSPECIFIED,             \
>                 .flags = REBASE_NO_QUIET,               \
>                 .git_am_opts = ARGV_ARRAY_INIT,         \
> -               .git_format_patch_opt = STRBUF_INIT     \
> +               .git_format_patch_opt = STRBUF_INIT,    \
> +               .skip_already_present = 1               \
>         }
>
>  static struct replay_opts get_replay_opts(const struct rebase_options *opts)
> @@ -373,6 +375,7 @@ static int run_rebase_interactive(struct rebase_options *opts,
>         flags |= opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
>         flags |= opts->root_with_onto ? TODO_LIST_ROOT_WITH_ONTO : 0;
>         flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
> +       flags |= opts->skip_already_present ? TODO_LIST_SKIP_ALREADY_PRESENT : 0;
>
>         switch (command) {
>         case ACTION_NONE: {
> @@ -1507,6 +1510,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                 OPT_BOOL(0, "reschedule-failed-exec",
>                          &reschedule_failed_exec,
>                          N_("automatically re-schedule any `exec` that fails")),
> +               OPT_BOOL(0, "skip-already-present", &options.skip_already_present,
> +                        N_("skip changes that are already present in the new upstream")),
>                 OPT_END(),
>         };
>         int i;
> @@ -1840,6 +1845,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                               "interactive or merge options"));
>         }
>
> +       if (!options.skip_already_present && !is_interactive(&options))
> +               die(_("--no-skip-already-present does not work with the 'am' backend"));
> +

with the *apply* backend, not the 'am' one (the backend was renamed in
commit 10cdb9f38a ("rebase: rename the two primary rebase backends",
2020-02-15))

>         if (options.signoff) {
>                 if (options.type == REBASE_PRESERVE_MERGES)
>                         die("cannot combine '--signoff' with "
> diff --git a/sequencer.c b/sequencer.c
> index ba90a513b9..752580c017 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4797,12 +4797,13 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
>         int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
>         const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
>         int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
> +       int skip_already_present = !!(flags & TODO_LIST_SKIP_ALREADY_PRESENT);
>
>         repo_init_revisions(r, &revs, NULL);
>         revs.verbose_header = 1;
>         if (!rebase_merges)
>                 revs.max_parents = 1;
> -       revs.cherry_mark = 1;
> +       revs.cherry_mark = skip_already_present;
>         revs.limited = 1;
>         revs.reverse = 1;
>         revs.right_only = 1;
> diff --git a/sequencer.h b/sequencer.h
> index 393571e89a..39bb12f624 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -149,7 +149,7 @@ int sequencer_remove_state(struct replay_opts *opts);
>   * `--onto`, we do not want to re-generate the root commits.
>   */
>  #define TODO_LIST_ROOT_WITH_ONTO (1U << 6)
> -
> +#define TODO_LIST_SKIP_ALREADY_PRESENT (1U << 7)
>
>  int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
>                           const char **argv, unsigned flags);
> diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
> index a1ec501a87..9b52739a10 100755
> --- a/t/t3402-rebase-merge.sh
> +++ b/t/t3402-rebase-merge.sh
> @@ -162,4 +162,81 @@ test_expect_success 'rebase --skip works with two conflicts in a row' '
>         git rebase --skip
>  '
>
> +test_expect_success '--no-skip-already-present' '
> +       git init repo &&
> +
> +       # O(1-10) -- O(1-11) -- O(0-10) master
> +       #        \
> +       #         -- O(1-11) -- O(1-12) otherbranch
> +
> +       printf "Line %d\n" $(test_seq 1 10) >repo/file.txt &&
> +       git -C repo add file.txt &&
> +       git -C repo commit -m "base commit" &&
> +
> +       printf "Line %d\n" $(test_seq 1 11) >repo/file.txt &&
> +       git -C repo commit -a -m "add 11" &&
> +
> +       printf "Line %d\n" $(test_seq 0 10) >repo/file.txt &&
> +       git -C repo commit -a -m "add 0 delete 11" &&
> +
> +       git -C repo checkout -b otherbranch HEAD^^ &&
> +       printf "Line %d\n" $(test_seq 1 11) >repo/file.txt &&
> +       git -C repo commit -a -m "add 11 in another branch" &&
> +
> +       printf "Line %d\n" $(test_seq 1 12) >repo/file.txt &&
> +       git -C repo commit -a -m "add 12 in another branch" &&
> +
> +       # Regular rebase fails, because the 1-11 commit is deduplicated
> +       test_must_fail git -C repo rebase --merge master 2> err &&
> +       test_i18ngrep "error: could not apply.*add 12 in another branch" err &&
> +       git -C repo rebase --abort &&
> +
> +       # With --no-skip-already-present, it works
> +       git -C repo rebase --merge --no-skip-already-present master
> +'
> +
> +test_expect_success '--no-skip-already-present refrains from reading unneeded blobs' '
> +       git init server &&
> +
> +       # O(1-10) -- O(1-11) -- O(1-12) master
> +       #        \
> +       #         -- O(0-10) otherbranch
> +
> +       printf "Line %d\n" $(test_seq 1 10) >server/file.txt &&
> +       git -C server add file.txt &&
> +       git -C server commit -m "merge base" &&
> +
> +       printf "Line %d\n" $(test_seq 1 11) >server/file.txt &&
> +       git -C server commit -a -m "add 11" &&
> +
> +       printf "Line %d\n" $(test_seq 1 12) >server/file.txt &&
> +       git -C server commit -a -m "add 12" &&
> +
> +       git -C server checkout -b otherbranch HEAD^^ &&
> +       printf "Line %d\n" $(test_seq 0 10) >server/file.txt &&
> +       git -C server commit -a -m "add 0" &&
> +
> +       test_config -C server uploadpack.allowfilter 1 &&
> +       test_config -C server uploadpack.allowanysha1inwant 1 &&
> +
> +       git clone --filter=blob:none "file://$(pwd)/server" client &&
> +       git -C client checkout origin/master &&
> +       git -C client checkout origin/otherbranch &&
> +
> +       # Sanity check to ensure that the blobs from the merge base and "add
> +       # 11" are missing
> +       git -C client rev-list --objects --all --missing=print >missing_list &&
> +       MERGE_BASE_BLOB=$(git -C server rev-parse master^^:file.txt) &&
> +       ADD_11_BLOB=$(git -C server rev-parse master^:file.txt) &&
> +       grep "\\?$MERGE_BASE_BLOB" missing_list &&
> +       grep "\\?$ADD_11_BLOB" missing_list &&
> +
> +       git -C client rebase --merge --no-skip-already-present origin/master &&
> +
> +       # The blob from the merge base had to be fetched, but not "add 11"
> +       git -C client rev-list --objects --all --missing=print >missing_list &&
> +       ! grep "\\?$MERGE_BASE_BLOB" missing_list &&
> +       grep "\\?$ADD_11_BLOB" missing_list
> +'
> +
>  test_done
> --
> 2.25.1.481.gfbce0eb801-goog

Should there be a config setting to flip the default?  And should
feature.experimental and/or feature.manyFiles enable it by default?
