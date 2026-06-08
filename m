Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A53313550
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914217; cv=none; b=KQoHNpY7p5oJuMJNocVB/PJhnDuyQdAR5QgNtZ2bsKkyyPnmYlrENSLjhTxkKduJ/m1Fzy1H00rznwOst5Ze2R3c3JbFj4+CQMitrzlmP4m5TFlAm2yvPVJLeIOFX9KWhHyLCVb3PbfWf7iluBfTNbScOaHGsL51I1nTtjhgQ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914217; c=relaxed/simple;
	bh=OI00JqLYx6fbHl6QK1XmaR01HnIsh3brd/yrf2s3kcg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=fRXJj8alQOTv6JFVa+IF//en+O4LLzw5EzMhNEoa3JE8xxEfFecezMRpxwWYL9E8PvQkYKer2PhF3B+KSvA2J+ynBoWpgFyIDxPmMUGnVth6/6MJf9oyn8g5fmJj4G8VgxQw9NSvFAQmbMKnImxElfQPhKSPurx3d377DeMR++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g/NvO22j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dX4SiDFv; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g/NvO22j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dX4SiDFv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD3EC7A0106;
	Mon,  8 Jun 2026 06:23:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 08 Jun 2026 06:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780914214;
	 x=1781000614; bh=nuuy38jRmVN2nyd57XcYdAsmUNqIc+qCH9AfiDfkIkA=; b=
	g/NvO22j2NPqJ6nYWMppCw69eDKhBun3iDJkfy2o9RYSIX9gD0XSZ5jMCEr/+dH5
	enmdip9AZK9z/4m7gTLXl696ZsztzZ5efimaZ711JbB58E178ivrTmu9stmUFXGr
	+ZHTifTDW5H/HcOVRq7e9XWx8svJy/lPwYFlDCXgv5S4MoR8hextvj7tuf380uQL
	G0MhXUtc7C7bEt6FRoBE7hAekFyossHfDBYj/3fqS55Xf45nGiy82E1fe0j89mUY
	gVggM7z48k6jrRRt0knMpqdtozG4aohqOI3dg4sKQEkNhEwtS5JtoQYmzjMNJYti
	96qGNO+s515JhWMdTHhnEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780914214; x=
	1781000614; bh=nuuy38jRmVN2nyd57XcYdAsmUNqIc+qCH9AfiDfkIkA=; b=d
	X4SiDFvC2CslWIXYhRUVBOUpiJei3jiL+pxvKXpwDFjgDprvEDz7ECT1vb6k0WMK
	GO3swR4RLitRKHLvb/mwxP43koWEl516z8s4i++za9wcq7yi5ZFZfSMe3BKxG5Ep
	AV4lFB+BbxSeSSOEvDXZIWaLkYSIeGKzLnpb6cLn7AZ+PeJL/Zy7ZsVW196566k0
	JOO5+Xh7ktUqS0fbEzvBdE/zEE5TO2vhcTcaJL7+HcqvgG3SIpidlm9jzxlPovNI
	PmV2O7SdLyNlRbaHaSENdTa1T/ReI5swkfeKRt650yGDBZ1Il0WS0eEpw3L76pWF
	uGzq18mGqhCeDwSSi3s0w==
X-ME-Sender: <xms:Jpgmar6Kd1Tn1AOLlVasiSWMUaZtu-fHs6Hdc_soju1baBOwt9VQTw>
    <xme:JpgmaibxVY6rLQkn0511Z_pduDa_yiNOx1kFQrpV886_aIdag9r6MHZnEH-GiWDHj
    VzFqmvZFpkwzEy8zVFtoHjs15KG5LB9fWzqsxEpxaQhDE_SMPy9Xg>
X-ME-Received: <xmr:JpgmaiiOXUnK7HeDY3gQfDGdiWix5tNUmDwlgmHlvwV2jXR3k4IHUiXvCqT03pPZCLZHLWCOMv4NSLIMKCruGugpYh3mNDmNtg6UmLzCfQ>
X-ME-Proxy-Cause: dmFkZTGJ1hEv6Wg0ozSQ9izmBZjnxB959KiNwZppI1keFykmT9WaontBQ+AyuZ72fz5wXu
    7D4jIRZCHCZbfIPG/ljY7ZOOqmjnCh1ip/iu18aCRlVEqASiXM3ASQ2Rb7YWTqAhItFWhU
    uDu6c8+MIfPUB3uw+q8YUBXMQLTqXBzmDuHwJxTSQ17d4wUT8OxtY9KaLWpasyaK8TBesY
    NNkXNfaNrBH5T8r8zSa/xRRpWUYUDU1M9gEXz/YJqsPzUWZ8b9OzNsbppPJB3zbu7CZ+nL
    K6NsAOdWaarLCbFEChTAaaduR55ZZ41qKhRKsqrcui3/W2Jd3XTVoQv9cEVrej4n+h9nRP
    fAphJgGKmWURJYoiKgHj0SPJz4uh8ppMhjqTengVZFX9X/glA/Yvm3LSXD6n9i16oY4U3n
    PMzy/NvsB2fVFBkg0EZ2B4mo23hZo4K3JxQaDyTvg7TY3+G7pcct4ZWhvBVM58jjQsE95d
    v+BSuwK285vA2pgxdVJmPXRf3ZO2NS3ZS1i5vMuxmkc6Ynb+q51VyUFprTfCjwSf1RNzDG
    Ee6xh9H2fd0SEo5V/GB22FG4rvBYk6YWQl/S4M57ga3BxUuNo51ILQszE2yubLzs4yGuVX
    lVI6u2TsojEGIIQa9oYF+ghhavQ2HAVMWwdqWyfm2FpooH8MdV4nYpaoFy/g
X-ME-Proxy: <xmx:Jpgmar_QaQsq7HR5r7zrRUpQ3FLSiGR55jETHxKkAGEFq7He38R_Vw>
    <xmx:JpgmalrD5lVVtSISuSK16CfpS2JNxe6ROnGRvfy5-s6bIYq6-lvDtA>
    <xmx:JpgmarVKLQGEnc8QkHe3TnhdwOdXz75niwMWi_a7Ajq17JRp4Yu4bg>
    <xmx:JpgmasDHBk9VaW-8IppI7JvIwPtN7AsqFxFXBFd3d-drigjpkPZtMQ>
    <xmx:JpgmalMjWFdJUvEwDj2eZ8QpUW0EsX6A5nnD8dIw7G0Mz3x8OzRDWibr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 06:23:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id edd1ff66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 10:23:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/9] builtin/history: introduce "drop" subcommand
Date: Mon, 08 Jun 2026 12:23:24 +0200
Message-Id: <20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAByYJmoC/33NTQ6CMBQE4KuQrn2m9A9x5T2MC9s+pBqBtNhoC
 He3RWNcGJeTzHwzkYDeYSDbYiIeowuu71Lgq4KY9tidEJxNmTDKFFW0BC1guARoXRh7/wDr+wH
 YplFG8brGSpO0HDw27r6o+8Mrh5s+oxkzlRvv+XIby9z7/xBLoKAER864oFbKXaqs3ZVkPrJvg
 P8GWAIqwYyWWpaVsh9gnucnzz96gAYBAAA=
X-Change-ID: 20260601-b4-pks-history-drop-28f6c6399e7b
In-Reply-To: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im>
References: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

Hi,

this small patch series introduces the new "drop" subcommand for
git-history(1). As a reader might guess, the command does exactly that:
given a commit, it will drop that commit from the commit history and
replay descendant branches on top of it.

Changes in v3:
  - Fix commit message typos.
  - Make `update_orig_head` and `skip_ref_updates` mutually exclusive.
  - Use fancy revisions to specify the commit to drop in the example
    section.
  - Detect conflicting changes in the index/working tree in dry-run
    mode.
  - Consistently use a subshell.
  - Rename `RESET_HEAD_ORIG_HEAD` to `RESET_HEAD_UPDATE_ORIG_HEAD`.
  - 
  - Link to v2: https://patch.msgid.link/20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im

Changes in v2:
  - Reworked `update_worktree()` to use `reset_head()`, which required a
    bunch of changes to `reset_head()`.
  - Consistently mention the commit that cannot be dropped as part of
    error messages.
  - Adapt error message to not use backticks anymore.
  - Drop redundant "--graph" flag in a test helper.
  - Link to v1: https://patch.msgid.link/20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (9):
      read-cache: split out function to drop unmerged entries to stage 0
      reset: drop `USE_THE_REPOSITORY_VARIABLE`
      reset: modernize flags passed to `reset_head()`
      reset: introduce dry-run mode
      reset: introduce ability to skip reference updates
      reset: allow the caller to specify the current HEAD object
      reset: stop assuming that the caller passes in a clean index
      builtin/history: split handling of ref updates into two phases
      builtin/history: implement "drop" subcommand

 Documentation/git-history.adoc |  38 ++-
 builtin/history.c              | 289 +++++++++++++++++++---
 builtin/rebase.c               |   2 +-
 read-cache-ll.h                |   1 +
 read-cache.c                   |  12 +-
 reset.c                        |  91 ++++---
 reset.h                        |  44 +++-
 sequencer.c                    |   2 +-
 t/meson.build                  |   1 +
 t/t3454-history-drop.sh        | 537 +++++++++++++++++++++++++++++++++++++++++
 10 files changed, 929 insertions(+), 88 deletions(-)

Range-diff versus v2:

 1:  a93e804936 =  1:  41a723b3d0 read-cache: split out function to drop unmerged entries to stage 0
 2:  d8f39e7dc4 =  2:  db850730ef reset: drop `USE_THE_REPOSITORY_VARIABLE`
 3:  fdec5a57b4 !  3:  bd18736141 reset: modernize flags passed to `reset_head()`
    @@ builtin/rebase.c: int cmd_rebase(int argc,
      	ropts.oid = &options.onto->object.oid;
      	ropts.orig_head = &options.orig_head->object.oid;
     -	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
    -+	ropts.flags = RESET_HEAD_DETACH | RESET_HEAD_ORIG_HEAD |
    ++	ropts.flags = RESET_HEAD_DETACH | RESET_HEAD_UPDATE_ORIG_HEAD |
      			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
      	ropts.head_msg = msg.buf;
      	ropts.default_reflog_action = options.reflog_action;
    @@ reset.c: static int update_refs(struct repository *repo,
      	unsigned detach_head = opts->flags & RESET_HEAD_DETACH;
      	unsigned run_hook = opts->flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
     -	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
    -+	unsigned update_orig_head = opts->flags & RESET_HEAD_ORIG_HEAD;
    ++	unsigned update_orig_head = opts->flags & RESET_HEAD_UPDATE_ORIG_HEAD;
      	const struct object_id *orig_head = opts->orig_head;
      	const char *switch_to_branch = opts->branch;
      	const char *reflog_branch = opts->branch_msg;
    @@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts
      	unsigned reset_hard = opts->flags & RESET_HEAD_HARD;
      	unsigned refs_only = opts->flags & RESET_HEAD_REFS_ONLY;
     -	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
    -+	unsigned update_orig_head = opts->flags & RESET_HEAD_ORIG_HEAD;
    ++	unsigned update_orig_head = opts->flags & RESET_HEAD_UPDATE_ORIG_HEAD;
      	struct object_id *head = NULL, head_oid;
      	struct tree_desc desc[2] = { { NULL }, { NULL } };
      	struct lock_file lock = LOCK_INIT;
    @@ reset.h
     +	RESET_HEAD_REFS_ONLY = (1 << 3),
     +
     +	/* Update ORIG_HEAD as well as HEAD */
    -+	RESET_HEAD_ORIG_HEAD = (1 << 4),
    ++	RESET_HEAD_UPDATE_ORIG_HEAD = (1 << 4),
     +};
      
      struct reset_head_opts {
    @@ reset.h: struct reset_head_opts {
      	/*
      	 * Optional reflog message for ORIG_HEAD, if this omitted and flags
     -	 * contains RESET_ORIG_HEAD then default_reflog_action must be given.
    -+	 * contains RESET_HEAD_ORIG_HEAD then default_reflog_action must be given.
    ++	 * contains RESET_HEAD_UPDATE_ORIG_HEAD then default_reflog_action must be given.
      	 */
      	const char *orig_head_msg;
      	/*
    @@ sequencer.c: static int checkout_onto(struct repository *r, struct replay_opts *
      		.oid = onto,
      		.orig_head = orig_head,
     -		.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
    -+		.flags = RESET_HEAD_DETACH | RESET_HEAD_ORIG_HEAD |
    ++		.flags = RESET_HEAD_DETACH | RESET_HEAD_UPDATE_ORIG_HEAD |
      				RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
      		.head_msg = reflog_message(opts, "start", "checkout %s",
      					   onto_name),
 4:  3af7c9a4fd !  4:  8c79e56076 reset: introduce dry-run mode
    @@ Metadata
      ## Commit message ##
         reset: introduce dry-run mode
     
    -    In a subsequent commit we'll add add another caller to `reset_head()`
    -    that wants to perform a dry-run check of whether it would be possible to
    -    udpate the index and working tree when moving to a new commit. Introduce
    +    In a subsequent commit we'll add another caller to `reset_head()` that
    +    wants to perform a dry-run check of whether it would be possible to
    +    update the index and working tree when moving to a new commit. Introduce
         a new flag that lets the caller perform this operation.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    @@ reset.c
     @@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts)
      	unsigned reset_hard = opts->flags & RESET_HEAD_HARD;
      	unsigned refs_only = opts->flags & RESET_HEAD_REFS_ONLY;
    - 	unsigned update_orig_head = opts->flags & RESET_HEAD_ORIG_HEAD;
    + 	unsigned update_orig_head = opts->flags & RESET_HEAD_UPDATE_ORIG_HEAD;
     +	unsigned dry_run = opts->flags & RESET_HEAD_DRY_RUN;
      	struct object_id *head = NULL, head_oid;
      	struct tree_desc desc[2] = { { NULL }, { NULL } };
    @@ reset.h
     @@ reset.h: enum reset_head_flags {
      
      	/* Update ORIG_HEAD as well as HEAD */
    - 	RESET_HEAD_ORIG_HEAD = (1 << 4),
    + 	RESET_HEAD_UPDATE_ORIG_HEAD = (1 << 4),
     +
     +	/*
     +	 * Perform a dry-run by performing the operation without updating
 5:  31d1ff1d4c !  5:  c112fbbd14 reset: introduce ability to skip reference updates
    @@ Commit message
      ## reset.c ##
     @@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts)
      	unsigned refs_only = opts->flags & RESET_HEAD_REFS_ONLY;
    - 	unsigned update_orig_head = opts->flags & RESET_HEAD_ORIG_HEAD;
    + 	unsigned update_orig_head = opts->flags & RESET_HEAD_UPDATE_ORIG_HEAD;
      	unsigned dry_run = opts->flags & RESET_HEAD_DRY_RUN;
     +	unsigned skip_ref_updates = opts->flags & RESET_HEAD_SKIP_REF_UPDATES;
      	struct object_id *head = NULL, head_oid;
    @@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts
      	if (opts->branch_msg && !opts->branch)
      		BUG("branch reflog message given without a branch");
      
    -+	if (skip_ref_updates && (opts->branch || refs_only))
    ++	if (skip_ref_updates && (opts->branch || refs_only || update_orig_head))
     +		BUG("asked to perform ref updates and skip them at the same time");
     +
      	if (!refs_only && !dry_run && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
 6:  21b2d4d281 =  6:  9550257dd1 reset: allow the caller to specify the current HEAD object
 7:  7c032ca1e3 =  7:  8a3d517020 reset: stop assuming that the caller passes in a clean index
 8:  fcd4479178 =  8:  a09be2ffc0 builtin/history: split handling of ref updates into two phases
 9:  6b1c17a8df !  9:  682b11af93 builtin/history: implement "drop" subcommand
    @@ Documentation/git-history.adoc: The staged addition of `unrelated.txt` has been
     +def5678 second
     +ghi9012 first
     +
    -+$ git history drop def5678
    ++$ git history drop 'main^{/second}'
     +
     +$ git log --oneline
     +jkl3456 (HEAD -> main) third
    @@ builtin/history.c: static int cmd_history_split(int argc,
     +	 * inconsistent repository state. So we first perform a dry-run merge
     +	 * here before updating refs.
     +	 */
    -+	if (!dry_run && !is_bare_repository()) {
    ++	if (!is_bare_repository()) {
     +		ret = find_head_tree_change(repo, &result, &old_head,
     +					    &new_head, &head_moves);
     +		if (ret < 0)
    @@ builtin/history.c: static int cmd_history_split(int argc,
     +		goto out;
     +	}
     +
    -+	if (head_moves && update_worktree(repo, old_head, new_head, false) < 0) {
    ++	if (!dry_run && head_moves && update_worktree(repo, old_head, new_head, false) < 0) {
     +		ret = error(_("could not update working tree to new commit %s"),
     +			    oid_to_hex(&new_head->object.oid));
     +		goto out;
    @@ t/t3454-history-drop.sh (new)
     +test_expect_success 'errors with invalid --empty= value' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    -+	test_commit -C repo initial &&
    -+	test_commit -C repo second &&
    -+	test_must_fail git -C repo history drop --empty=bogus HEAD 2>err &&
    -+	test_grep "unrecognized.*--empty.*bogus" err
    ++	(
    ++		cd repo &&
    ++		test_commit initial &&
    ++		test_commit second &&
    ++		test_must_fail git history drop --empty=bogus HEAD 2>err &&
    ++		test_grep "unrecognized.*--empty.*bogus" err
    ++	)
     +'
     +
     +test_expect_success 'drops a commit in the middle and replays descendants' '
    @@ t/t3454-history-drop.sh (new)
     +	)
     +'
     +
    ++test_expect_success '--dry-run detects conflicts with modified working tree' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo --initial-branch=main &&
    ++	(
    ++		cd repo &&
    ++		test_commit first &&
    ++		test_commit second modify-me &&
    ++		echo modified >modify-me &&
    ++
    ++		git refs list >refs-expect &&
    ++		git diff >diff-expect &&
    ++		test_must_fail git history drop --dry-run HEAD 2>err &&
    ++		test_grep "dropping this commit would overwrite local changes" err &&
    ++		git diff >diff-actual &&
    ++		git refs list >refs-actual &&
    ++
    ++		test_cmp diff-expect diff-actual &&
    ++		test_cmp refs-expect refs-actual
    ++	)
    ++'
    ++
     +test_expect_success '--update-refs=head updates only HEAD' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo --initial-branch=main &&

---
base-commit: 1666c1265231b0bc5f613fbbf3f0a9896cdef76e
change-id: 20260601-b4-pks-history-drop-28f6c6399e7b

