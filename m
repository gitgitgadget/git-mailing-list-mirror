Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D83BED2B
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081558; cv=none; b=RCp/O137QwKGfTCQU66PWdtRizxQEuOr8WnorVd7JH+IKDQtd+3dHjaf+ONq2cTjzYcBMebDwEgNu7dY19HXWvFto9MIFWcljMQmX/4qxzibaX/tajnpVCUOC/zhKogQJSdhmF4a6S4YML0swP6MWtjSL2QPGlstpZrblyYKbkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081558; c=relaxed/simple;
	bh=HwVnM7FJurg/Y9FVmifoU3pNwVsVaSDSFzLTR1pICxc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=eReN1ti/bxVf0EX3KV+t+bYJ95+tJVAmFz6q/mXAo8htf+6gdyZF8RZu5SfwzJsBJRnJAvzzBXPtuEXPHkBI3QTLCFdLXzuk4JFY8JsWbEXuTVe7OrwmCpvRMSmL6LhK21jT9qxFhRhgXwlftEy1yZRnjWJ5niIUZLn8kOhuxmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ROwS2T1C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AL59JxBB; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ROwS2T1C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AL59JxBB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9A73C1D00086;
	Wed, 10 Jun 2026 04:52:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 04:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781081555;
	 x=1781167955; bh=3QVdegl9dPA60er6riTr/jUwAPYgC62W1SMCZEHoxxg=; b=
	ROwS2T1CgPmHMmxyA0ZJvsH3BMTjkI8OthBzhADaHOBtiRO3N2wFfbIB3/3vnPZc
	40S9DB1iPdI9uitjW9y9tpVUSI3uhywWIaqlSJgztcz0obsMYFCYAa+uBWQPGlYO
	T8Vz3F8AD65ICwYVa0Fke9uY1NYP+QzzsddUTZ9aERMPv+SKez806+4x52nrXJNG
	ZwIT9i6XqYbqNSr2k/gUSG0sKAt5K6x9Ga+RPF89FPwbsnktKsycK1W/SWkBo8Da
	9mccu7si4ZwL6fmFjwOIqEVgLZu8yzWETF4LdaqFfHN+3b/MUBKve9HdRzW70chW
	E7+si9yKAiaQnDLNeChr3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781081555; x=
	1781167955; bh=3QVdegl9dPA60er6riTr/jUwAPYgC62W1SMCZEHoxxg=; b=A
	L59JxBB9U74j2UBoK2tEdqe1x8VLY6M01hRteNCNIS2Blc7VVqsT+1OYwnJX7wyM
	tHHBPWUQNDx2TLav9P/wmJEcJycB/kKgxRZRKZZWCl5ksqnIRTe0AvxYhGIQyDtK
	cr85eD4asuZ6wMhwH3eXNiF0x5XEgMpgximKNkZLQQMswWYP+afUPBiWDUTqKJoq
	wvkY3arybcQQoO8kxovdL5LaeYI4wcAqmaxKC9s50zHSGPuyucTH/BxLfNP1tCpb
	sByjtLvgYzU2O8/t93Dubon/n/fCWGS6U/nwSh1Aw2c7nlTtyTS6dY3Aw78u5a/5
	kSAXtbJ9Yj83fTVKTyumg==
X-ME-Sender: <xms:0iUpathEXmbNff4i8WE_rUpNC4_lJKA98DC24aMlelO0C3xTe8-Ykg>
    <xme:0iUpajiKvpQFJhwByhk5R49KFRQd-X4TjFccnxjDG4X6bGvb29IssvItmpYPf93Da
    XL63UYkj4FYO96qRvT1qsdOf75WBTiXOoSEwg8DqmE9ldY8hL_91Q>
X-ME-Received: <xmr:0iUpatLmBLaeNY80ys1YetuCxEs_yQ4kyPMyJzlLyc2NclDJVkst4V9q0iTZIWAYq53MWl3wWEkerg8IRlHXOzzJn2dNpm5p7giX-K9bnA>
X-ME-Proxy-Cause: dmFkZTF490sB0StSPWpz4GA0OxC8AuVNloFioej7v9mBC0C3W3nDoezjCDTmv8f3HRCkAy
    Y45bZyfEDToGGVAE37AaTpYxBm9jWGz7mXwkgkHqLmr0cV6h/cZpCAnLDhh8cxYKxhCJ26
    Hh67CyXYyYBCnEBVm3di4leHmY2ofhPefKqGqBjfvpqQMdbYPkbfFgSoiPDeOquuPYT1AN
    84hIRAg8LhT0noLS2GFLLcombh/aYpCmc4TgflVozKwqT6Bf74yD8ESIPT4nEx0axbNaJ4
    iJjSf7VBZDu8H5dvqyWomFtn+jyH5vbVOJTDP99MxKyFp0sez9SJzgYXPMcru6A02F3LOh
    8h8N7xDbu7tk8CgdnXZ6dChmpSzQPGooiJJO0UV9Z7NqhajqMBIR9MZ/hfUP34bN5wJPE0
    4sm6DddwlVY2WYJmYX8shhgrVzKj8YmWIB19rRSWWOTTXWF6BbBKlApSf+ceitXbZ5fr/F
    L6OXaWM2EODZoU/uhCMTsZIIkqrcqhvUWJ/JXQRmMUdG0q6z+N2yYOQkEcX8JPfINEHcWt
    YrQjuUxMzJtPsTQ4709XyCvVptA2Jx5GQtj99zlWVkrui3Ka66MKYdZ9/w7pcGVCmJnNGl
    jJVJqPWrYFedB3OuODU0kTiqM/oR8MwQpP3cHf2TEJiT0pKsav4okz9lPrtw
X-ME-Proxy: <xmx:0iUpaiFNC9EyQA8xJoTN_-4uU9DZP0zOZ7WfyfSlRSVfTigdl1nD2w>
    <xmx:0iUpahTFwDcbVvgksEp23zbtnnOSfqjgZhUclokKV1rLCbqotG5DeQ>
    <xmx:0iUpauciBewed3rwv98JIkwb40CQQiNtoYPYoYuM8k4-QqfxxeSs_w>
    <xmx:0iUpagrBQuO_hyNVoClOYOJduyK0g2jvpo5Dq-8p8B7ZpvO0okbsyA>
    <xmx:0yUpatV-qMS25d9N-bb3rsjRMwB0YENtxI4SPDLPWiab4PqzaqHU2MDr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 04:52:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6eadac31 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 08:52:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/10] builtin/history: introduce "drop" subcommand
Date: Wed, 10 Jun 2026 10:52:20 +0200
Message-Id: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMQlKWoC/33OTQ6CMBAF4KuYrq0p/QNceQ/jgraDVCOQFhsN4
 e62aAwmxOVL3nxvRuTBWfBovxmRg2C97doY+HaDdFO1Z8DWxIwooZJIkmHFcX/1uLF+6NwTG9f
 1mBa11JKVJeQKxcveQW0fs3o8vbO/qwvoIVGp8TmfZ0OWev8XQoYJlpwBo4wTI8QhVnb2hhIf6
 BJg6wCNQM6pVkKJLJfmB2BLoFgHWAQKrqsC4hsly7/ANE0vZc1GRkcBAAA=
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

Changes in v4:
  - Remove the `SKIP_REF_UPDATES` flag in favor of a new `UPDATE_HEAD`
    flag, as suggested by Phillip.
  - Rename `reset_head()` to `reset_working_tree()`. This better matches
    the new scope of the function, and it helps us to catch any
    in-flight patches that would now have to set the `UPDATE_HEAD` flag.
  - Link to v3: https://patch.msgid.link/20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im

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
Patrick Steinhardt (10):
      read-cache: split out function to drop unmerged entries to stage 0
      reset: drop `USE_THE_REPOSITORY_VARIABLE`
      reset: rename `reset_head()`
      reset: modernize flags passed to `reset_working_tree()`
      reset: introduce dry-run mode
      reset: introduce ability to skip updating HEAD
      reset: allow the caller to specify the current HEAD object
      reset: stop assuming that the caller passes in a clean index
      builtin/history: split handling of ref updates into two phases
      builtin/history: implement "drop" subcommand

 Documentation/git-history.adoc |  38 ++-
 builtin/history.c              | 288 +++++++++++++++++++---
 builtin/rebase.c               |  41 ++--
 read-cache-ll.h                |   1 +
 read-cache.c                   |  12 +-
 reset.c                        |  99 +++++---
 reset.h                        |  51 ++--
 sequencer.c                    |  17 +-
 t/meson.build                  |   1 +
 t/t3454-history-drop.sh        | 537 +++++++++++++++++++++++++++++++++++++++++
 10 files changed, 968 insertions(+), 117 deletions(-)

Range-diff versus v3:

 1:  e9291b8592 =  1:  63c1a10ca0 read-cache: split out function to drop unmerged entries to stage 0
 2:  6ae06725ca =  2:  b83e2124e8 reset: drop `USE_THE_REPOSITORY_VARIABLE`
 3:  53bf10c527 <  -:  ---------- reset: modernize flags passed to `reset_head()`
 -:  ---------- >  3:  0488effe71 reset: rename `reset_head()`
 -:  ---------- >  4:  364e71ee9c reset: modernize flags passed to `reset_working_tree()`
 4:  b8e5464d06 !  5:  0fa45bd263 reset: introduce dry-run mode
    @@ Metadata
      ## Commit message ##
         reset: introduce dry-run mode
     
    -    In a subsequent commit we'll add another caller to `reset_head()` that
    -    wants to perform a dry-run check of whether it would be possible to
    +    In a subsequent commit we'll add another caller to `reset_working_tree()`
    +    that wants to perform a dry-run check of whether it would be possible to
         update the index and working tree when moving to a new commit. Introduce
         a new flag that lets the caller perform this operation.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## reset.c ##
    -@@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts)
    - 	unsigned reset_hard = opts->flags & RESET_HEAD_HARD;
    - 	unsigned refs_only = opts->flags & RESET_HEAD_REFS_ONLY;
    - 	unsigned update_orig_head = opts->flags & RESET_HEAD_UPDATE_ORIG_HEAD;
    -+	unsigned dry_run = opts->flags & RESET_HEAD_DRY_RUN;
    +@@ reset.c: int reset_working_tree(struct repository *r,
    + 	unsigned reset_hard = opts->flags & RESET_WORKING_TREE_HARD;
    + 	unsigned refs_only = opts->flags & RESET_WORKING_TREE_REFS_ONLY;
    + 	unsigned update_orig_head = opts->flags & RESET_WORKING_TREE_UPDATE_ORIG_HEAD;
    ++	unsigned dry_run = opts->flags & RESET_WORKING_TREE_DRY_RUN;
      	struct object_id *head = NULL, head_oid;
      	struct tree_desc desc[2] = { { NULL }, { NULL } };
      	struct lock_file lock = LOCK_INIT;
    @@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts
      	const char *action;
      	int ret = 0, nr = 0;
      
    -@@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts)
    +@@ reset.c: int reset_working_tree(struct repository *r,
      	if (opts->branch_msg && !opts->branch)
      		BUG("branch reflog message given without a branch");
      
    @@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts
      		ret = -1;
      		goto leave_reset_head;
      	}
    -@@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts)
    +@@ reset.c: int reset_working_tree(struct repository *r,
      	if (!oid)
      		oid = &head_oid;
      
    @@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts
      	unpack_tree_opts.merge = 1;
      	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
      	unpack_tree_opts.skip_cache_tree_update = 1;
    -@@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts)
    +@@ reset.c: int reset_working_tree(struct repository *r,
      	if (reset_hard)
      		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
      
    @@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts
      	if (!reset_hard && !fill_tree_descriptor(r, &desc[nr++], &head_oid)) {
      		ret = error(_("failed to find tree of %s"),
      			    oid_to_hex(&head_oid));
    -@@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts)
    +@@ reset.c: int reset_working_tree(struct repository *r,
      		goto leave_reset_head;
      	}
      
    @@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts
      	tree = repo_parse_tree_indirect(r, oid);
      	if (!tree) {
      		ret = error(_("unable to read tree (%s)"), oid_to_hex(oid));
    -@@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts)
    +@@ reset.c: int reset_working_tree(struct repository *r,
      leave_reset_head:
      	rollback_lock_file(&lock);
      	clear_unpack_trees_porcelain(&unpack_tree_opts);
    @@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts
      	return ret;
     
      ## reset.h ##
    -@@ reset.h: enum reset_head_flags {
    +@@ reset.h: enum reset_working_tree_flags {
      
      	/* Update ORIG_HEAD as well as HEAD */
    - 	RESET_HEAD_UPDATE_ORIG_HEAD = (1 << 4),
    + 	RESET_WORKING_TREE_UPDATE_ORIG_HEAD = (1 << 4),
     +
     +	/*
     +	 * Perform a dry-run by performing the operation without updating
     +	 * any user-visible state.
     +	 */
    -+	RESET_HEAD_DRY_RUN = (1 << 5),
    ++	RESET_WORKING_TREE_DRY_RUN = (1 << 5),
      };
      
    - struct reset_head_opts {
    + struct reset_working_tree_options {
 5:  bbb8b98f8e <  -:  ---------- reset: introduce ability to skip reference updates
 -:  ---------- >  6:  4f844adaa7 reset: introduce ability to skip updating HEAD
 6:  24cccf728f !  7:  28e7dd039e reset: allow the caller to specify the current HEAD object
    @@ Metadata
      ## Commit message ##
         reset: allow the caller to specify the current HEAD object
     
    -    When calling `reset_head()` we automatically derive the commit that the
    -    callers wants to move from by reading the HEAD commit. Some callers may
    -    already have resolved it, or they may want to move from a different
    -    commit that doesn't match HEAD.
    +    When calling `reset_working_tree()` we automatically derive the commit
    +    that the callers wants to move from by reading the HEAD commit. Some
    +    callers may already have resolved it, or they may want to move from a
    +    different commit that doesn't match HEAD.
     
         Introduce a new `oid_from` option that lets the caller specify the
         commit.
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## reset.c ##
    -@@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts)
    +@@ reset.c: int reset_working_tree(struct repository *r,
      		goto leave_reset_head;
      	}
      
    @@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts
      		ret = error(_("could not determine HEAD revision"));
     
      ## reset.h ##
    -@@ reset.h: struct reset_head_opts {
    +@@ reset.h: struct reset_working_tree_options {
      	 * The commit to checkout/reset to. Defaults to HEAD.
      	 */
      	const struct object_id *oid;
 7:  4b79437a50 !  8:  6b590da34e reset: stop assuming that the caller passes in a clean index
    @@ Commit message
         reset: stop assuming that the caller passes in a clean index
     
         In 652bd0211d (rebase: use 'skip_cache_tree_update' option, 2022-11-10),
    -    we updated `reset_head()` to stop updating the index tree cache. This
    -    was done as a performance optimization: the function is only called by
    -    "sequencer.c" and "rebase.c", both of which assume a clean index before
    -    they perform their operation, so we know that the end result will be a
    -    clean index, too. Consequently, we can skip recomputing the cache as we
    -    can instead use `prime_cache_tree()` directly.
    +    we updated `reset_working_tree()` to stop updating the index tree cache.
    +    This was done as a performance optimization: the function is only called
    +    by "sequencer.c" and "rebase.c", both of which assume a clean index
    +    before they perform their operation, so we know that the end result will
    +    be a clean index, too. Consequently, we can skip recomputing the cache
    +    as we can instead use `prime_cache_tree()` directly.
     
         In a subsequent commit we're about to add a new caller though where the
         assumption doesn't hold anymore: the index may be dirty before calling
    -    `reset_head()`, and consequently we cannot prime the cache with a given
    -    tree anymore as the index and tree will mismatch.
    +    `reset_working_tree()`, and consequently we cannot prime the cache with
    +    a given tree anymore as the index and tree will mismatch.
     
         Adapt the logic so that we only skip the cache tree update in case we're
         doing a hard reset. While we could introduce logic that only skips the
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## reset.c ##
    -@@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts)
    +@@ reset.c: int reset_working_tree(struct repository *r,
      	unpack_tree_opts.dry_run = dry_run;
      	unpack_tree_opts.merge = 1;
      	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
    @@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts
      
      	if (!reset_hard && !fill_tree_descriptor(r, &desc[nr++], &head_oid)) {
      		ret = error(_("failed to find tree of %s"),
    -@@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts)
    +@@ reset.c: int reset_working_tree(struct repository *r,
      		goto leave_reset_head;
      	}
      
 8:  d01c7ffb29 =  9:  fddadbf87f builtin/history: split handling of ref updates into two phases
 9:  c75925f7ed ! 10:  cb09216db3 builtin/history: implement "drop" subcommand
    @@ builtin/history.c: static int cmd_history_split(int argc,
     +			   const struct commit *new_head,
     +			   bool dry_run)
     +{
    -+	struct reset_head_opts opts = {
    ++	struct reset_working_tree_options opts = {
     +		.oid_from = &old_head->object.oid,
     +		.oid = &new_head->object.oid,
    -+		.flags = RESET_HEAD_SKIP_REF_UPDATES,
     +	};
     +	if (dry_run)
    -+		opts.flags |= RESET_HEAD_DRY_RUN;
    -+	return reset_head(repo, &opts);
    ++		opts.flags |= RESET_WORKING_TREE_DRY_RUN;
    ++	return reset_working_tree(repo, &opts);
     +}
     +
     +static int find_head_tree_change(struct repository *repo,

---
base-commit: 1666c1265231b0bc5f613fbbf3f0a9896cdef76e
change-id: 20260601-b4-pks-history-drop-28f6c6399e7b

