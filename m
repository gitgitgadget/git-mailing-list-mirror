Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEEB426408
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327866; cv=none; b=AVLQOvtUonhdyCGdHiBsCwmLd4N+vonaMbm4aXyBM8iuXXwiwPXJ9maJ86v1bL2KdvDO4wpQZ8am7iu6F00+f+P0qHBxXjt/xPHsQKuY0l0rQ1/tGz8JyvFS1GSjYU32JPt4jULsKYLXS4QBDHrjDoG7BJoorQUAjGkvTnqAgNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327866; c=relaxed/simple;
	bh=T/v9Gm2MfJezqeg1wElQht5BX5UPiRZq2lkPgZlUWqI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cInfey4/iyCsv3PvAeBUYcVIXokx7dGct/Scdfc+NJZMYXsJu5+yWSW61cNiYwvNfzw/NO21e22rlDwZSkYc1EqnEKhdfYMssw8OqlZVz7TFSu99AlIMD+UgsoC7nsYsS/DM+RWVMG0fedCX6vmDIjZ1ApeIjP8UYaBS3+dA+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oK1jpO2Q; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oK1jpO2Q"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e67555e24so121667985a.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 01:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783327853; x=1783932653; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sdnnFpJIut9/osA6+qXCWjjC1AUm4ZJ+y4meCBvhvlc=;
        b=oK1jpO2Q6VfNDBQ2GXKIMl6SI6fcAzOyATcALHu+08/OeIc5X4PZSBPk67DwXchmg+
         k/YL3DRVuZlgvHLPWkbAELRr/SQ6wQecJJ6KMiq0UNH2GVhjHExAIWdgisXkAHt6zGGc
         rylDESmxdUxgAjPJao0Y+mf3vLC+PegN1Y6KwNqqyb21Z+zcHCVpdkZpxEmScHLWt/Gw
         XYTaBTjXby1Oo1tnlDxiatl+oH50XZ9R9bIeQS5CcDVoTzNW4q6UzaJUb7M9wM7QsPLD
         /uH2qIwIOd8IGDPOQIv4sRLUHHxsAKE7enE5Ui5fUbHinD+ea6yBT/pXF8yfOXQAn9nw
         mQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783327853; x=1783932653;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sdnnFpJIut9/osA6+qXCWjjC1AUm4ZJ+y4meCBvhvlc=;
        b=UWzZmIRPBVsrbOl9MDk73WknyVRcfjv2W+1rW7FICRmUeO0oj/yKSq2aeEiArVYjW/
         /y2nW2WfsmDj4yJgOCIHV7NI6akDYApMiuiD/T8EbtYLG6rX7+sHs1Xz+iXN01oDfHNh
         bj7lGlsld8pRoMsiZhvZT+SUd9QdVeCTMuu3vGdFdtXlyoDpUfkA97AEmn6veNR+HmKn
         z40SgzxCqDXbpJFMM3bkAKGAUp3r3a3MeB4RmTgCK6guT+SIBl6cZvNK1spUWwDAr2QR
         iZMhVS4VW/qaym6F9IjHtNfckZnVLhuPKeiA/ZEb9Jj/YleKxRMxdn80eU/E8LIsmZ0v
         o6FA==
X-Gm-Message-State: AOJu0Yx/s2xSmbCSUtJb0rq8DFRH5yhX9vC/ywnhlRnzoGRu33p+cbOP
	zU7bvumNbd/iuCetWipXKjvd2GfM0NjF8Mn4bOLu7nnvorTTMO7V6j4mv5WXcUvG
X-Gm-Gg: AfdE7ck6E5KwowKaCGvt6B0U9s8lnnh0uH6uov/eI/X+ImXEhaDRxScHPKt9FOdFc2H
	Kc2FSXPLb0SpHSJ63QxVcEGBXa+NabpgfnVTFCdplskWAUOdkV1U7yz3ffH3oiGv+Pdh6kQZrFy
	Aj4ftVqMiLdmQbbNSe4HAzvFCoZQKcCUxPbc3LMRk4ZQ5bKr7eigx7xI/BRZsdI5kcy8BBkp+/3
	zJ6FrCHN8YWDdjVau3sUquZZ5s8OjVSeFpUyeBB+9F/o/oa8WSGFLQWItfa6iOLb4EZxJoo0zgm
	BFulWfuCav77oEgus1vQWu3IGctE/6/tODGlu5gz0/SPOGUPzPoI25YRkz1Yh88OQ6853hVcJZU
	5qxnFrwDdbknE0yoho9z7RTUvsGanoaueaMT23fzlbq3xhccfMTthnthgc3G3viSLgkMrHFn0ld
	Mffr3Cy6JwvOANc8PDyRpb2yipcw==
X-Received: by 2002:a05:620a:1b82:b0:92d:6961:9519 with SMTP id af79cd13be357-92e9a353d3cmr1228892585a.8.1783327852432;
        Mon, 06 Jul 2026 01:50:52 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.174.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ccdf8dsm881127785a.37.2026.07.06.01.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:50:50 -0700 (PDT)
Message-Id: <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
References: <pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 08:50:44 +0000
Subject: [PATCH v7 0/5] history: add squash subcommand to fold a range
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>

Adds git history squash <revision-range> to fold a range of commits.

Changes in v7:

 * --reedit-message now builds the same editor template git rebase -i shows
   for a squash (a combination of N commits banner with each folded message
   under its own header) and follows autosquash for markers: a fixup!
   message falls out (commented under a will be skipped header), while a
   squash! or amend! keeps its body with only the marker subject commented
   so its remark can be reworded in. Only the message text is affected,
   every commit's changes are always folded in.
 * Reuse git rebase -i's squash-message code: a preparatory sequencer:
   commit extracts the banner, header and marker-comment helpers so both
   rebase and git history squash build the identical template from one
   source.
 * Refuse a range whose oldest commit is a fixup!, squash! or amend!, since
   the marker's target cannot be inside the range.
 * Reorder the squash usage so dashed options come before <revision-range>,
   and spell out HEAD instead of @ in the documentation and examples.
 * Expand the squash commit message and documentation with this overview,
   and scope the merge limitation so it no longer contradicts squash folding
   a single-base interior merge.

Changes in v6:

 * git history squash now accepts multiple revision arguments, read like the
   arguments to git-rev-list, so a compound range such as @~3.. ^topic
   works.
 * The base to reparent onto is now the oldest in-range commit's parent; a
   boundary other than that base means the range has more than one base and
   is rejected. This also fixes the earlier overly-restrictive handling of
   merges and side branches.
 * A single-commit range (e.g. @^!) is rejected with "nothing to squash"
   (this also covers the @^!-style example that previously succeeded
   silently).
 * Commit messages reworded: the squash commit now gives an overview of
   fixup!/squash!/amend! handling, rewording, merge-parent and ref behavior.

Changes in v5:

 * The range walk now uses --ancestry-path, so only commits descended from
   the base are folded; a single revision such as HEAD or HEAD~1 is now
   rejected as "not a <base>..<tip> range" rather than treated as a squash
   down to the root.
 * This adopts the --ancestry-path suggestion; the multi-base rejection is
   unchanged, so a side branch that forked before the base and merged in is
   still refused.
 * Added tests covering more merge topologies: two interior merges, a nested
   merge, an octopus merge, an octopus arm forked before the base, a merge
   among the descendants replayed above the range, and a ref pointing at an
   interior merge commit.

Changes in v4:

 * git history squash now detects when another ref points at a commit inside
   the range being folded and refuses, with an advice.historyUpdateRefs hint
   to use --update-refs=head.
 * A merge inside the range is folded fine as long as the range has a single
   base; a range with merge commit at the tip or base also folds correctly.
   Only a range with more than one base is rejected.

Changes in v3:

 * Moved the feature out of git rebase and into a new git history squash
   <revision-range> subcommand, per the list discussion. git rebase --squash
   is dropped.
 * Takes an arbitrary range (git history squash @~3.., git history squash
   @~5..@~2), folding it into the oldest commit and replaying any
   descendants on top.
 * Implemented as a single tree operation rather than picking each commit,
   so there are no repeated conflict stops (addresses Phillip's efficiency
   point).
 * A merge inside the range is folded fine, only a range with more than one
   base is rejected.
 * --reedit-message seeds the editor with every folded-in message, not just
   the oldest.

Harald Nordgren (5):
  history: extract helper for a commit's parent tree
  history: give commit_tree_ext a message template
  history: add squash subcommand to fold a range
  sequencer: extract helpers for the squash message markers
  history: re-edit a squash with every message

 Documentation/config/advice.adoc |   4 +
 Documentation/git-history.adoc   |  49 ++-
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/history.c                | 390 +++++++++++++++++--
 sequencer.c                      |  64 ++--
 sequencer.h                      |  23 ++
 t/meson.build                    |   1 +
 t/t3455-history-squash.sh        | 632 +++++++++++++++++++++++++++++++
 9 files changed, 1099 insertions(+), 66 deletions(-)
 create mode 100755 t/t3455-history-squash.sh


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2337%2FHaraldNordgren%2Frebase-fixup-fold-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2337/HaraldNordgren/rebase-fixup-fold-v7
Pull-Request: https://github.com/git/git/pull/2337

Range-diff vs v6:

 1:  fea6b79e60 = 1:  56ed8fadbb history: extract helper for a commit's parent tree
 2:  e2674e0bc4 = 2:  212e9c228f history: give commit_tree_ext a message template
 3:  811e393ab4 ! 3:  cf3346a1cd history: add squash subcommand to fold a range
     @@ Commit message
          Add "git history squash <revision-range>" to do this directly. It folds
          every commit in the range into the oldest one, keeping that commit's
          message and authorship and taking the tree of the newest commit, then
     -    replays the commits above the range on top. fixup!, squash! and amend!
     -    commits are folded like any other and are not interpreted, so the
     -    squashed message comes from the oldest commit, or from an editor with
     -    --reedit-message.
     +    replays the commits above the range on top. The squashed message comes
     +    from the oldest commit, or from an editor with --reedit-message. As that
     +    message is reused, a range whose oldest commit is a fixup!, squash! or
     +    amend! is refused, since the marker's target cannot be in the range.
      
          The range is read like the arguments to "git rev-list", so several
     -    arguments such as "@~3.. ^topic" are allowed. A merge inside the range
     -    is folded when its other parent is reachable from the base, otherwise
     -    the range has more than one base and is rejected. By default the command
     -    also refuses when a ref points at a commit that the fold would discard.
     -    Use --update-refs=head to rewrite only the current branch instead.
     +    arguments such as "HEAD~3..HEAD ^topic" are allowed. A merge inside the
     +    range is folded when its other parent is reachable from the base,
     +    otherwise the range has more than one base and is rejected. By default
     +    the command also refuses when a ref points at a commit that the fold
     +    would discard. Use --update-refs=head to rewrite only the current branch
     +    instead.
      
          Inspired-by: Sergey Chernov <serega.morph@gmail.com>
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
     @@ Documentation/git-history.adoc: SYNOPSIS
       git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
       git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
       git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
     -+git history squash <revision-range> [--dry-run] [--update-refs=(branches|head)] [--reedit-message]
     ++git history squash [--dry-run] [--update-refs=(branches|head)] [--reedit-message] <revision-range>
       
       DESCRIPTION
       -----------
     +@@ Documentation/git-history.adoc: at once.
     + LIMITATIONS
     + -----------
     + 
     +-This command does not (yet) work with histories that contain merges. You
     +-should use linkgit:git-rebase[1] with the `--rebase-merges` flag instead.
     ++This command does not (yet) replay merge commits onto the rewritten
     ++history: if a commit that would be replayed is a merge, the operation is
     ++rejected, and you should use linkgit:git-rebase[1] with the
     ++`--rebase-merges` flag instead. The `squash` subcommand can still fold a
     ++merge that lies inside the range, as long as the range has a single base.
     + 
     + Furthermore, the command does not support operations that can result in merge
     + conflicts. This limitation is by design as history rewrites are not intended to
      @@ Documentation/git-history.adoc: linkgit:gitglossary[7].
       It is invalid to select either all or no hunks, as that would lead to
       one of the commits becoming empty.
     @@ Documentation/git-history.adoc: linkgit:gitglossary[7].
      ++
      +The range is given in the usual `<base>..<tip>` form, where _<base>_ is
      +the commit just below the oldest commit to squash. For example, `git
     -+history squash @~3..` folds the three most recent commits into one, and
     -+`git history squash @~5..@~2` squashes an interior range while leaving
     -+the two newest commits in place. _<revision-range>_ is read like the
     -+arguments to linkgit:git-rev-list[1], so several arguments may be given,
     -+for example `@~3.. ^topic` to additionally exclude what is already on
     -+`topic`.
     ++history squash HEAD~3..HEAD` folds the three most recent commits into
     ++one, and `git history squash HEAD~5..HEAD~2` squashes an interior range
     ++while leaving the two newest commits in place. _<revision-range>_ is read
     ++like the arguments to linkgit:git-rev-list[1], so several arguments may be
     ++given, for example `HEAD~3..HEAD ^topic` to additionally exclude what is
     ++already on `topic`.
      ++
      +The oldest commit's message and authorship are preserved by default,
      +unless you specify `--reedit-message`. A merge commit inside the range is
     @@ Documentation/git-history.adoc: linkgit:gitglossary[7].
      +that reaches more than one entry point (for example a side branch that
      +forked before the range and was later merged into it) is rejected.
      ++
     -+The folded commits disappear from the history, so with the default
     -+`--update-refs=branches` the command refuses when another ref points at
     -+one of them. Rerun with `--update-refs=head` to rewrite only the current
     -+branch and leave those refs pointing at the old commits.
     ++Because the oldest commit's message is reused, the range may not begin
     ++with a `fixup!`, `squash!`, or `amend!` commit, whose target is
     ++necessarily outside the range.
     +++
     ++A branch or tag that points at a commit inside the range would be left
     ++dangling once those commits are folded away, so with the default
     ++`--update-refs=branches` the command refuses. Rerun with
     ++`--update-refs=head` to rewrite only the current branch and leave such
     ++refs pointing at the old commits.
      +
       OPTIONS
       -------
       
     +@@ Documentation/git-history.adoc: OPTIONS
     + 	ref updates is generally safe.
     + 
     + `--reedit-message`::
     +-	Open an editor to modify the target commit's message.
     ++	Open an editor to modify the rewritten commit's message. For `squash`
     ++	the editor is pre-filled with the messages of all the folded commits.
     + 
     + `--empty=(drop|keep|abort)`::
     + 	Control what happens when a commit becomes empty as a result of the
      
       ## advice.c ##
      @@ advice.c: static struct {
     @@ builtin/history.c
       #define GIT_HISTORY_SPLIT_USAGE \
       	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]")
      +#define GIT_HISTORY_SQUASH_USAGE \
     -+	N_("git history squash <revision-range> [--dry-run] [--update-refs=(branches|head)] [--reedit-message]")
     ++	N_("git history squash [--dry-run] [--update-refs=(branches|head)] [--reedit-message] <revision-range>")
       
       static void change_data_free(void *util, const char *str UNUSED)
       {
     @@ builtin/history.c: out:
      +	return ret;
      +}
      +
     ++static int reject_fixupish_oldest(struct repository *repo,
     ++				  struct commit *oldest)
     ++{
     ++	const char *message, *subject;
     ++	int ret = 0;
     ++
     ++	message = repo_logmsg_reencode(repo, oldest, NULL, NULL);
     ++	find_commit_subject(message, &subject);
     ++	if (starts_with(subject, "fixup! ") ||
     ++	    starts_with(subject, "squash! ") ||
     ++	    starts_with(subject, "amend! "))
     ++		ret = error(_("the range begins with a fixup!, squash! or amend! "
     ++			      "commit whose target is not in the range"));
     ++	repo_unuse_commit_buffer(repo, oldest, message);
     ++	return ret;
     ++}
     ++
      +struct interior_ref_cb {
      +	const struct oidset *interior;
      +	const char *name;
     @@ builtin/history.c: out:
      +	if (ret < 0)
      +		goto out;
      +
     ++	ret = reject_fixupish_oldest(repo, oldest);
     ++	if (ret < 0)
     ++		goto out;
     ++
      +	if (action == REF_ACTION_BRANCHES) {
      +		struct interior_ref_cb cb = { .interior = &interior };
      +
     @@ t/t3455-history-squash.sh (new)
      +
      +test_expect_success 'squashes a range into a single commit without changing the tree' '
      +	git reset --hard three &&
     ++	head_before=$(git rev-parse HEAD) &&
      +	tip_tree=$(git rev-parse HEAD^{tree}) &&
      +
     ++	git history squash --dry-run start.. >out &&
     ++	predicted=$(awk "/^update refs\/heads\// {print \$3}" out) &&
     ++	test_cmp_rev "$head_before" HEAD &&
     ++
      +	git history squash start.. &&
      +
     ++	test "$predicted" = "$(git rev-parse HEAD)" &&
      +	git rev-list --count start..HEAD >count &&
      +	echo 1 >expect &&
      +	test_cmp expect count &&
     @@ t/t3455-history-squash.sh (new)
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'keeps the oldest message even if it is a fixup!' '
     ++test_expect_success 'refuses a range whose oldest commit is a fixup!' '
      +	git reset --hard start &&
      +	test_commit --no-tag "fixup! something" file b &&
     -+	test_commit tail file c &&
     ++	test_commit --no-tag tail file c &&
     ++	head_before=$(git rev-parse HEAD) &&
     ++
     ++	test_must_fail git history squash start.. 2>err &&
     ++	test_grep "target is not in the range" err &&
     ++	test_cmp_rev "$head_before" HEAD
     ++'
     ++
     ++test_expect_success 'does not interpret squash! or amend! markers' '
     ++	git reset --hard start &&
     ++	test_commit --no-tag marker-oldest file b &&
     ++	git commit --allow-empty -m "squash! marker-oldest" &&
     ++	git commit --allow-empty -m "amend! marker-oldest" &&
     ++	test_commit --no-tag marker-newest file c &&
      +
      +	git history squash start.. &&
      +
     ++	git rev-list --count start..HEAD >count &&
     ++	echo 1 >expect &&
     ++	test_cmp expect count &&
      +	git log --format="%s" -1 >actual &&
     -+	echo "fixup! something" >expect &&
     ++	echo marker-oldest >expect &&
      +	test_cmp expect actual
      +'
      +
     @@ t/t3455-history-squash.sh (new)
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success '--dry-run predicts the rewrite without performing it' '
     -+	git reset --hard three &&
     -+	head_before=$(git rev-parse HEAD) &&
     -+	tip_tree=$(git rev-parse HEAD^{tree}) &&
     -+
     -+	git history squash --dry-run start.. >out &&
     -+	predicted=$(awk "/^update refs\/heads\// {print \$3}" out) &&
     -+	test_cmp_rev "$head_before" HEAD &&
     -+
     -+	git history squash start.. &&
     -+	test "$predicted" = "$(git rev-parse HEAD)" &&
     -+	git rev-list --count start..HEAD >count &&
     -+	echo 1 >expect &&
     -+	test_cmp expect count &&
     -+	test_cmp_rev start HEAD^ &&
     -+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
     -+'
     -+
      +test_expect_success '--update-refs=head only moves HEAD' '
      +	git reset --hard three &&
      +	git branch -f other HEAD &&
 -:  ---------- > 4:  001356db93 sequencer: extract helpers for the squash message markers
 4:  4edf012b77 ! 5:  615fe4dd3f history: re-edit a squash with every message
     @@ Commit message
          When --reedit-message is given it only reopened that one message, so the
          messages of the folded-in commits were lost.
      
     -    Gather the messages of every commit in the range, oldest first, and use
     -    them as the editor template when re-editing, mirroring how "git rebase
     -    -i" presents a squash.
     +    Gather the messages of every commit in the range, oldest first, and build
     +    the same editor template that "git rebase -i" shows for a squash, using
     +    add_squash_combination_header(), add_squash_message_header() and
     +    squash_subject_comment_len(). Only the message text differs, the changes
     +    are always folded in. Following autosquash, a fixup!'s message is
     +    commented out in full under a "will be skipped" header, while a squash! or
     +    amend! keeps its body with only the marker subject commented.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Documentation/git-history.adoc ##
     -@@ Documentation/git-history.adoc: arguments to linkgit:git-rev-list[1], so several arguments may be given,
     - for example `@~3.. ^topic` to additionally exclude what is already on
     - `topic`.
     +@@ Documentation/git-history.adoc: like the arguments to linkgit:git-rev-list[1], so several arguments may be
     + given, for example `HEAD~3..HEAD ^topic` to additionally exclude what is
     + already on `topic`.
       +
      -The oldest commit's message and authorship are preserved by default,
      -unless you specify `--reedit-message`. A merge commit inside the range is
     @@ Documentation/git-history.adoc: arguments to linkgit:git-rev-list[1], so several
       folded like any other, but the range must have a single base, so a range
       that reaches more than one entry point (for example a side branch that
       forked before the range and was later merged into it) is rejected.
     + +
     + Because the oldest commit's message is reused, the range may not begin
     + with a `fixup!`, `squash!`, or `amend!` commit, whose target is
     +-necessarily outside the range.
     ++necessarily outside the range. The changes from every commit in the range
     ++are always folded in. Only the message text differs. With
     ++`--reedit-message` the template mirrors `git rebase -i`: the message of a
     ++`fixup!` elsewhere in the range is commented out in full, while a
     ++`squash!` or `amend!` keeps its message body with only the marker subject
     ++commented, so you can fold the remark into the result.
     + +
     + A branch or tag that points at a commit inside the range would be left
     + dangling once those commits are folded away, so with the default
      
       ## builtin/history.c ##
      @@ builtin/history.c: static int find_interior_ref(const struct reference *ref, void *cb_data)
     @@ builtin/history.c: static int find_interior_ref(const struct reference *ref, voi
      +				struct commit *tip,
      +				struct strbuf *out)
      +{
     ++	struct commit_list *commits = NULL, **tail = &commits, *c;
      +	struct rev_info revs;
      +	struct commit *commit;
      +	struct strvec args = STRVEC_INIT;
     -+	int n = 0, ret;
     ++	int n = 0, total, ret;
      +
      +	repo_init_revisions(repo, &revs, NULL);
      +	strvec_push(&args, "ignored");
     @@ builtin/history.c: static int find_interior_ref(const struct reference *ref, voi
      +		goto out;
      +	}
      +
     -+	while ((commit = get_revision(&revs))) {
     ++	while ((commit = get_revision(&revs)))
     ++		tail = &commit_list_insert(commit, tail)->next;
     ++	total = commit_list_count(commits);
     ++
     ++	for (c = commits; c; c = c->next) {
      +		const char *message, *body;
     -+		struct strbuf one = STRBUF_INIT;
     ++		size_t commented_len;
     ++		int skip;
      +
     -+		message = repo_logmsg_reencode(repo, commit, NULL, NULL);
     ++		message = repo_logmsg_reencode(repo, c->item, NULL, NULL);
      +		find_commit_subject(message, &body);
     -+		strbuf_addstr(&one, body);
     -+		strbuf_trim_trailing_newline(&one);
      +
     -+		if (n++)
     -+			strbuf_addch(out, '\n');
     -+		strbuf_addbuf(out, &one);
     ++		skip = starts_with(body, "fixup! ");
     ++		commented_len = skip ? strlen(body) :
     ++			squash_subject_comment_len(body, 1);
     ++
     ++		if (!n)
     ++			add_squash_combination_header(out, total);
      +		strbuf_addch(out, '\n');
     ++		add_squash_message_header(out, ++n, skip);
     ++		strbuf_addstr(out, "\n\n");
     ++		strbuf_add_commented_lines(out, body, commented_len, comment_line_str);
     ++		strbuf_addstr(out, body + commented_len);
     ++		strbuf_complete_line(out);
      +
     -+		strbuf_release(&one);
     -+		repo_unuse_commit_buffer(repo, commit, message);
     ++		repo_unuse_commit_buffer(repo, c->item, message);
      +	}
      +
      +	ret = 0;
      +
      +out:
     ++	commit_list_free(commits);
      +	reset_revision_walk();
      +	release_revisions(&revs);
      +	strvec_clear(&args);
     @@ t/t3455-history-squash.sh: test_expect_success 'preserves authorship of the olde
      +	test_commit re-three file d &&
      +
      +	write_script editor <<-\EOF &&
     -+	cp "$1" buffer &&
     ++	cat "$1" >edited &&
      +	echo combined >"$1"
      +	EOF
      +	test_set_editor "$(pwd)/editor" &&
      +	git history squash --reedit-message start.. &&
      +
     -+	test_grep "re-one subject" buffer &&
     -+	test_grep "re-one body line" buffer &&
     -+	test_grep re-two buffer &&
     -+	test_grep re-three buffer &&
     -+	git log --format="%s" -1 >actual &&
     ++	cat >expect <<-EOF &&
     ++	# This is a combination of 3 commits.
     ++	# This is the 1st commit message:
     ++
     ++	re-one subject
     ++
     ++	re-one body line
     ++
     ++	# This is the commit message #2:
     ++
     ++	re-two
     ++
     ++	# This is the commit message #3:
     ++
     ++	re-three
     ++
     ++	# Please enter the commit message for the squash changes. Lines starting
     ++	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
     ++	# Changes to be committed:
     ++	#	modified:   file
     ++	#
     ++	EOF
     ++	test_cmp expect edited &&
      +	echo combined >expect &&
     ++	git log --format="%s" -1 >actual &&
      +	test_cmp expect actual
      +'
      +
     ++test_expect_success '--reedit-message handles fixup!, squash! and amend! like rebase' '
     ++	git reset --hard start &&
     ++	test_commit --no-tag mark-base file b &&
     ++	printf "fixup! mark-base\n\nfixup body\n" >msg &&
     ++	echo c >file &&
     ++	git add file &&
     ++	git commit -qF msg &&
     ++	printf "squash! mark-base\n\nsquash remark\n" >msg &&
     ++	echo d >file &&
     ++	git add file &&
     ++	git commit -qF msg &&
     ++	printf "amend! mark-base\n\namended message\n" >msg &&
     ++	echo e >file &&
     ++	git add file &&
     ++	git commit -qF msg &&
     ++
     ++	write_script editor <<-\EOF &&
     ++	cat "$1" >edited
     ++	EOF
     ++	test_set_editor "$(pwd)/editor" &&
     ++	git history squash --reedit-message start.. &&
     ++
     ++	cat >expect <<-EOF &&
     ++	# This is a combination of 4 commits.
     ++	# This is the 1st commit message:
     ++
     ++	mark-base
     ++
     ++	# The commit message #2 will be skipped:
     ++
     ++	# fixup! mark-base
     ++	#
     ++	# fixup body
     ++
     ++	# This is the commit message #3:
     ++
     ++	# squash! mark-base
     ++
     ++	squash remark
     ++
     ++	# This is the commit message #4:
     ++
     ++	# amend! mark-base
     ++
     ++	amended message
     ++
     ++	# Please enter the commit message for the squash changes. Lines starting
     ++	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
     ++	# Changes to be committed:
     ++	#	modified:   file
     ++	#
     ++	EOF
     ++	test_cmp expect edited &&
     ++	git log -1 --format="%B" >final &&
     ++	test_grep ! "fixup body" final &&
     ++	test_grep "squash remark" final &&
     ++	test_grep "amended message" final
     ++'
     ++
      +test_expect_success '--reedit-message aborts on an empty message' '
      +	git reset --hard three &&
      +	head_before=$(git rev-parse HEAD) &&
     @@ t/t3455-history-squash.sh: test_expect_success 'preserves authorship of the olde
      +	test_cmp_rev "$head_before" HEAD
      +'
      +
     - test_expect_success '--dry-run predicts the rewrite without performing it' '
     + test_expect_success '--update-refs=head only moves HEAD' '
       	git reset --hard three &&
     - 	head_before=$(git rev-parse HEAD) &&
     + 	git branch -f other HEAD &&

-- 
gitgitgadget
