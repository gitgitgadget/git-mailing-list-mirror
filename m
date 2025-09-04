Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56843303C9E
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996062; cv=none; b=nB3FqX90RNXLuPQ2y6wzquD7a2wOg0/rYgDMCYwiP2hyyuFDNuCxslEUCHHNLivHEY17eT5YNXox1NTBG/KItHqdxsHoGOmpPVU6Bkd0WC4Vj9/E+HfKug9dR8p/WAXokXFWhmT22laWg7v6PKrUghbcFiROZuXDhquydio90TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996062; c=relaxed/simple;
	bh=vm57RTLKxUoQXW5Wg4juldom88qn4G/WbUtDZ5nrzlM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Z1UQLF0lspt1hmc8GP5/Jo6IoD47cBePviloBjKlSrv3O16uyg5DutZZZMzs0rVPlzdd2MWgCXtv41RbdITDcy5ft+v5iKUyvVSmzWqfnjURdyKIZVBqbJMM8r8WNViT+A1yUf4GBIqs+CZCUuN06qX7SRkSxjt6lsjK42HhUY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=orrH8eDu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R/+R5Hq2; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="orrH8eDu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R/+R5Hq2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8CFB81D0024C;
	Thu,  4 Sep 2025 10:27:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 04 Sep 2025 10:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996058;
	 x=1757082458; bh=v+ivrgDgtSJ9SN0o2Psnq7ummBgJ65z2IXIRKefAUVM=; b=
	orrH8eDuxBnvd/jw+p8I3Lcz6gzKJAkXk40sMn1p77doDGprLhB1V8cnWpqxvJ7p
	vwShCfCxzX5+kSleGq3KHqpLZgoDAXeNmGy1Gjb7DqCD4bDrY1apXZYWa9r5kG8z
	q0azYGTpIaH9FjqhPlJOXaJWickPO2kgh1/aU9kYBQBjy3st8tYjNsmemOwwLbK4
	gA9ZOQUxYSIieAI4s+I9ftMKg2OZuVKDC9RrpLKF+JK2KS5Qnb+pXhbyMhwcsyUO
	QYjx/7wzWrLjn42AzH+jFOpbcMpxY/EQK7d8QhsNchPDGvFtPRJ2fT6wOxCRNN8S
	4O1oPRDs1Iawh5piz8xAtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996058; x=
	1757082458; bh=v+ivrgDgtSJ9SN0o2Psnq7ummBgJ65z2IXIRKefAUVM=; b=R
	/+R5Hq2b9iBPcycgJZYSHAdsK+qVzJVvppGaHkv1I80mlE3qpRXWe2su1HctAOC+
	hzruqe22wkG3ai2qL5HHlE+HIXupYUc+1WcEz4qS6ciNiSW8Tc3qEcwJPokEvDPq
	PwedUr1TMQ7wIF1kMD3WQ3WoTK3vdK5BxC2u0iqLXcv0B1tRk1sNKE3hl5WlyqbM
	ODtq7Vx4txnSkgV4Jf8WFpDAJXuCBP8TjXSrLfitA+KTAx/fn/Iyf/4WxMmD+3l0
	fdh236cqTsgU5LhuVRuRLv65rcluUl9PuLaeXOXd52dXTXOzjTrNpjaSBztHExvY
	Ir2tNR3cIGUaX7Paf3HZA==
X-ME-Sender: <xms:2qG5aEgOujn7Ncd0YXfk5cRNURGR9scnOfQEWSc41NRUEM4cL9EAhA>
    <xme:2qG5aKmgsEKcpl3oI6cFzTV3xIo4AH_Cd4Ko0g9hlVGAOhpVbdxoeCYp_T36fKc-X
    cCUgdXx5yRi4vJXkw>
X-ME-Received: <xmr:2qG5aCisB04b2duEK6c3M86l5fLFyfv6ippE8JmGA2p1jt0XauOReSJ63lCIcT8anTaeYNyDfT3VljeatMQCEMh5JbCat6iHEtaqVKPPfuMmsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    etueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvdenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:2qG5aG0RhcoInZEcmMpCEIjDsqTE7pT8L1Rq3urclaDkdS7em3apug>
    <xmx:2qG5aDK5GbET3iDHIRADjAHKz1s6o-q2j07m5EBjJCyqvzR50dFhhQ>
    <xmx:2qG5aOwhSQ56rM-SMbTAu4p2XizcGmD36FvHl8jsryNiQz3CSg8NOw>
    <xmx:2qG5aJV0lkUcvNYaeIv6PTjmV9V67C-62AxGwKnaQIRiAg23DYjmqA>
    <xmx:2qG5aAf_jeJkFAfzMyaaiLc4cUf4Fkzlte2THOzDSwTSduru0tB5VGOY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:27:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 119cd869 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:27:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH RFC v3 00/18] Introduce git-history(1) command for easy
 history editing
Date: Thu, 04 Sep 2025 16:27:30 +0200
Message-Id: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANKhuWgC/4XNywrCMBAF0F+RrB3Jo4/ElSD4AW7FRdMmdlDbk
 tSglP67MYi4EZd3Zu6ZiXjj0HiyXkzEmYAe+y4GsVyQuq26kwFsYiac8pxKpkBnMJw9tOjH3j1
 A3/AyYgdSCCWtqmhuKYnlwRmL9wQfyH63Jcc4fJfSs8DS6p8bGFBQuixrwQsprdnEqxVekxf4l
 8GznwZ/GUVW1YzbItfNx5jn+QnS8rhxAgEAAA==
X-Change-ID: 20250819-b4-pks-history-builtin-83398f9a05f0
In-Reply-To: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

Hi,

over recent months I've been playing around with Jujutsu quite
frequently. While I still prefer using Git, there's been a couple
features in it that I really like and that I'd like to have in Git, as
well.

A copule of these features relate to history editing. Most importantly,
I really dig the following commands:

  - jj-abandon(1) to drop a specific commit from your history.

  - jj-absorb(1) to take some changes and automatically apply them to
    commits in your history that last modified the respective hunks.

  - jj-split(1) to split a commit into two.

  - jj-new(1) to insert a new commit after or before a specific other
    commit.

Not all of these commands can be ported directly into Git. jj-new(1) for
example doesn't really make a ton of sense for us, I'd claim. But some
of these commands _do_ make sense.

I thus had a look at implementing some of these commands in Git itself,
where the result is this patch series. Specifically, the following
commands are introduced by this patch series:

  - `git history drop` to drop a specific commit. This is basically the
    same as jj-abandon(1).

  - `git history reorder` to reorder a specific commit before or after
    another commit. This is inspired by jj-new(1).

  - `git history split` takes a commit and splits it into two. This is
    basically the same as jj-split(1).

If this is something we want to have I think it'd be just a starting
point. There's other commands that I think are quite common and that
might make sense to introduce eventually:

  - An equivalent to jj-absorb(1) would be awesome to have.

  - `git history reword` to change only the commit message of a specific
    commit.

  - `git history squash` to squash together multiple commits into one.

In the end, I'd like us to learn from what people like about Jujutsu and
apply those learnings to Git. We won't be able to apply all learnings
from Jujutsu, as the workflow is quite different there due to the lack
of the index. But other things we certainly can apply to Git directly.

Changes in v2:
  - Add a new "reword" subcommand.
  - List git-history(1) in "command-list.txt".
  - Add some missing error handling.
  - Simplify calling convention of `apply_commits()` to handle root
    commits internally instead of requiring every caller to do so.
  - Add tests to verify that git-history(1) refuses to work with changes
    in the worktree or index.
  - Mark git-history(1) as experimental.
  - Introduce commands to manage interrupted history edits.
  - A bunch of improvements to the manpage.
  - Link to v1: https://lore.kernel.org/r/20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im

Changes in v3:
  - Add logic to drive the "post-rewrite" hook and add tests to verify
    that all hooks are executed as expected.
  - Deduplicate logic to turn a replay action into a todo command.
  - Move the addition of tests for the top-level git-history(1) command
    to the correct commit.
  - Some smaller commit message fixes.
  - Honor "commit.verbose".
  - Fix copy-paste error with an error message.
  - Link to v2: https://lore.kernel.org/r/20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im

Note: this patch series is growing quite large overall. I'll send one
last version of the complete series with the RFC tag, but after that
I'll probably split the series into two and stop after introducing the
"reorder" command.

Thanks!

Patrick

---
Patrick Steinhardt (18):
      sequencer: optionally skip printing commit summary
      sequencer: add option to rewind HEAD after picking commits
      sequencer: introduce new history editing mode
      sequencer: stop using `the_repository` in `sequencer_remove_state()`
      sequencer: wire up "rewritten-hook" for REPLAY_HISTORY_EDIT
      cache-tree: allow writing in-memory index as tree
      builtin: add new "history" command
      builtin/history: introduce subcommands to manage interrupted rewrites
      builtin/history: implement "drop" subcommand
      builtin/history: implement "reorder" subcommand
      add-patch: split out header from "add-interactive.h"
      add-patch: split out `struct interactive_options`
      add-patch: remove dependency on "add-interactive" subsystem
      add-patch: add support for in-memory index patching
      wt-status: provide function to expose status for trees
      sequencer: allow callers to provide mappings for the old commit
      builtin/history: implement "split" subcommand
      builtin/history: implement "reword" subcommand

 .gitignore                     |   1 +
 Documentation/git-history.adoc | 188 ++++++++
 Documentation/meson.build      |   1 +
 Makefile                       |   1 +
 add-interactive.c              | 151 ++-----
 add-interactive.h              |  43 +-
 add-patch.c                    | 270 ++++++++++--
 add-patch.h                    |  61 +++
 builtin.h                      |   1 +
 builtin/add.c                  |  22 +-
 builtin/checkout.c             |   7 +-
 builtin/commit.c               |  16 +-
 builtin/history.c              | 958 +++++++++++++++++++++++++++++++++++++++++
 builtin/rebase.c               |   4 +-
 builtin/reset.c                |  16 +-
 builtin/revert.c               |   2 +-
 builtin/stash.c                |  46 +-
 cache-tree.c                   |   5 +-
 cache-tree.h                   |   3 +-
 command-list.txt               |   1 +
 commit.h                       |   2 +-
 git.c                          |   1 +
 meson.build                    |   1 +
 sequencer.c                    | 259 ++++++++---
 sequencer.h                    |  23 +-
 t/meson.build                  |   7 +-
 t/t3450-history.sh             |  42 ++
 t/t3451-history-drop.sh        | 207 +++++++++
 t/t3452-history-reorder.sh     | 278 ++++++++++++
 t/t3453-history-split.sh       | 468 ++++++++++++++++++++
 t/t3454-history-reword.sh      | 202 +++++++++
 wt-status.c                    |  24 ++
 wt-status.h                    |   3 +
 33 files changed, 3005 insertions(+), 309 deletions(-)

Range-diff versus v2:

 1:  ac3e60d11f =  1:  d397c84460 sequencer: optionally skip printing commit summary
 2:  411212b581 =  2:  9f6444ab79 sequencer: add option to rewind HEAD after picking commits
 3:  670a1879ea !  3:  6918f3fc1b sequencer: introduce new history editing mode
    @@ sequencer.c: void sequencer_post_commit_cleanup(struct repository *r, int verbos
      	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD")) {
      		if (!refs_delete_ref(get_main_ref_store(r), "", "REVERT_HEAD",
      				     NULL, REF_NO_DEREF) &&
    +@@ sequencer.c: static void todo_list_write_total_nr(struct todo_list *todo_list)
    + 	}
    + }
    + 
    ++static enum todo_command action_to_command(enum replay_action action)
    ++{
    ++	switch (action) {
    ++	case REPLAY_PICK:
    ++	case REPLAY_HISTORY_EDIT:
    ++		return TODO_PICK;
    ++	case REPLAY_REVERT:
    ++		return TODO_REVERT;
    ++	default:
    ++		BUG("unsupported action %d", action);
    ++	}
    ++}
    ++
    + static int read_populate_todo(struct repository *r,
    + 			      struct todo_list *todo_list,
    + 			      struct replay_opts *opts)
     @@ sequencer.c: static int read_populate_todo(struct repository *r,
      		return error(_("no commits parsed."));
      
      	if (!is_rebase_i(opts)) {
     -		enum todo_command valid =
     -			opts->action == REPLAY_PICK ? TODO_PICK : TODO_REVERT;
    -+		enum todo_command valid;
    ++		enum todo_command valid = action_to_command(opts->action);
      		int i;
      
     -		for (i = 0; i < todo_list->nr; i++)
    -+		switch (opts->action) {
    -+		case REPLAY_PICK:
    -+		case REPLAY_HISTORY_EDIT:
    -+			valid = TODO_PICK;
    -+			break;
    -+		default:
    -+			valid = TODO_REVERT;
    -+			break;
    -+		}
    -+
     +		for (i = 0; i < todo_list->nr; i++) {
      			if (valid == todo_list->items[i].command)
      				continue;
    @@ sequencer.c: int write_basic_state(struct replay_opts *opts, const char *head_na
      	if (prepare_revs(opts))
      		return -1;
      
    -+	switch (opts->action) {
    -+	case REPLAY_PICK:
    -+	case REPLAY_HISTORY_EDIT:
    -+		command = TODO_PICK;
    -+		break;
    -+	default:
    -+		command = TODO_REVERT;
    -+		break;
    -+	}
    -+
    ++	command = action_to_command(opts->action);
     +	command_string = todo_command_info[command].str;
      	encoding = get_log_output_encoding();
      
    @@ sequencer.c: static int single_pick(struct repository *r,
      
     -	item.command = opts->action == REPLAY_PICK ?
     -			TODO_PICK : TODO_REVERT;
    -+	switch (opts->action) {
    -+	case REPLAY_PICK:
    -+	case REPLAY_HISTORY_EDIT:
    -+		item.command = TODO_PICK;
    -+		break;
    -+	default:
    -+		item.command = TODO_REVERT;
    -+		break;
    -+	}
    ++	item.command = action_to_command(opts->action);
      	item.commit = cmit;
      
      	return do_pick_commit(r, &item, opts, 0, &check_todo);
    @@ sequencer.h: extern const char *rebase_resolvemsg;
      };
      
      enum commit_msg_cleanup_mode {
    -
    - ## t/t3450-history.sh (new) ##
    -@@
    -+#!/bin/sh
    -+
    -+test_description='tests for git-history command'
    -+
    -+. ./test-lib.sh
    -+
    -+test_expect_success 'refuses to do anything without subcommand' '
    -+	test_must_fail git history 2>err &&
    -+	test_grep foo err
    -+'
    -+
    -+test_done
 4:  6f2605f63d =  4:  e5317d44a3 sequencer: stop using `the_repository` in `sequencer_remove_state()`
 -:  ---------- >  5:  cc5108af10 sequencer: wire up "rewritten-hook" for REPLAY_HISTORY_EDIT
 5:  727ec4955d =  6:  457042c591 cache-tree: allow writing in-memory index as tree
 6:  eec4f74fd8 !  7:  1acf4de28a builtin: add new "history" command
    @@ meson.build: builtin_sources = [
        'builtin/hook.c',
        'builtin/index-pack.c',
        'builtin/init-db.c',
    +
    + ## t/meson.build ##
    +@@ t/meson.build: integration_tests = [
    +   't3436-rebase-more-options.sh',
    +   't3437-rebase-fixup-options.sh',
    +   't3438-rebase-broken-files.sh',
    ++  't3450-history.sh',
    +   't3500-cherry.sh',
    +   't3501-revert-cherry-pick.sh',
    +   't3502-cherry-pick-merge.sh',
    +@@ t/meson.build: if perl.found() and time.found()
    +       timeout: 0,
    +     )
    +   endforeach
    +-endif
    + \ No newline at end of file
    ++endif
    +
    + ## t/t3450-history.sh (new) ##
    +@@
    ++#!/bin/sh
    ++
    ++test_description='tests for git-history command'
    ++
    ++. ./test-lib.sh
    ++
    ++test_expect_success 'refuses to do anything without subcommand' '
    ++	test_must_fail git history 2>err &&
    ++	test_grep foo err
    ++'
    ++
    ++test_done
 7:  2820521f46 !  8:  07fff4c157 builtin/history: introduce subcommands to manage interrupted rewrites
    @@ builtin/history.c
     +	return fn(argc, argv, prefix, repo);
      }
     
    - ## t/meson.build ##
    -@@ t/meson.build: integration_tests = [
    -   't3436-rebase-more-options.sh',
    -   't3437-rebase-fixup-options.sh',
    -   't3438-rebase-broken-files.sh',
    -+  't3450-history.sh',
    -   't3500-cherry.sh',
    -   't3501-revert-cherry-pick.sh',
    -   't3502-cherry-pick-merge.sh',
    -@@ t/meson.build: if perl.found() and time.found()
    -       timeout: 0,
    -     )
    -   endforeach
    --endif
    - \ No newline at end of file
    -+endif
    -
      ## t/t3450-history.sh ##
     @@ t/t3450-history.sh: test_description='tests for git-history command'
      
 8:  3438f23f1b !  9:  a68cd72864 builtin/history: implement "drop" subcommand
    @@ Documentation/git-history.adoc: COMMANDS
     +`drop <commit>`::
     +	Drop a commit from the history and reapply all children of that
     +	commit on top of the commit's parent. The commit that is to be
    -+	dropped must be reachable from the current `HEAD` commit.
    ++	dropped must be reachable from the currently checked-out commit.
     ++
     +Dropping the root commit converts the child of that commit into the new
     +root commit. It is invalid to drop a root commit that does not have any
    @@ t/t3451-history-drop.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'hooks are executed for rewritten commits' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit first &&
    ++		test_commit second &&
    ++		test_commit third &&
    ++
    ++		write_script .git/hooks/prepare-commit-msg <<-EOF &&
    ++		echo "prepare-commit-msg: \$@" >>"$(pwd)/hooks.log"
    ++		EOF
    ++		write_script .git/hooks/post-commit <<-EOF &&
    ++		echo "post-commit" >>"$(pwd)/hooks.log"
    ++		EOF
    ++		write_script .git/hooks/post-rewrite <<-EOF &&
    ++		{
    ++			echo "post-rewrite: \$@"
    ++			cat
    ++		} >>"$(pwd)/hooks.log"
    ++		EOF
    ++
    ++		git history drop HEAD~ &&
    ++		cat >expect <<-EOF &&
    ++		prepare-commit-msg: .git/COMMIT_EDITMSG message
    ++		post-commit
    ++		post-rewrite: history
    ++		$(git rev-parse third) $(git rev-parse HEAD)
    ++		EOF
    ++		test_cmp expect hooks.log
    ++	)
    ++'
    ++
     +test_expect_success 'can drop root commit' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
 9:  1af60a15fe ! 10:  3caf8f8e23 builtin/history: implement "reorder" subcommand
    @@ Documentation/git-history.adoc: git history abort
      
      DESCRIPTION
      -----------
    -@@ Documentation/git-history.adoc: rewrite history in different ways:
    - `drop <commit>`::
    - 	Drop a commit from the history and reapply all children of that
    - 	commit on top of the commit's parent. The commit that is to be
    --	dropped must be reachable from the current `HEAD` commit.
    -+	dropped must be reachable from the currently checked-out commit.
    - +
    - Dropping the root commit converts the child of that commit into the new
    +@@ Documentation/git-history.adoc: Dropping the root commit converts the child of that commit into the new
      root commit. It is invalid to drop a root commit that does not have any
      child commits, as that would lead to an empty branch.
      
    @@ t/t3452-history-reorder.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'hooks are executed for rewritten commits' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit first &&
    ++		test_commit second &&
    ++		test_commit third &&
    ++
    ++		write_script .git/hooks/prepare-commit-msg <<-EOF &&
    ++		echo "prepare-commit-msg: \$@" >>"$(pwd)/hooks.log"
    ++		EOF
    ++		write_script .git/hooks/post-commit <<-EOF &&
    ++		echo "post-commit" >>"$(pwd)/hooks.log"
    ++		EOF
    ++		write_script .git/hooks/post-rewrite <<-EOF &&
    ++		{
    ++			echo "post-rewrite: \$@"
    ++			cat
    ++		} >>"$(pwd)/hooks.log"
    ++		EOF
    ++
    ++		git history reorder :/third --before=:/second &&
    ++		cat >expect <<-EOF &&
    ++		second
    ++		third
    ++		first
    ++		EOF
    ++		git log --format=%s >actual &&
    ++		test_cmp expect actual &&
    ++
    ++		cat >expect <<-EOF &&
    ++		prepare-commit-msg: .git/COMMIT_EDITMSG message
    ++		post-commit
    ++		prepare-commit-msg: .git/COMMIT_EDITMSG message
    ++		post-commit
    ++		post-rewrite: history
    ++		$(git rev-parse third) $(git rev-parse HEAD~)
    ++		$(git rev-parse second) $(git rev-parse HEAD)
    ++		EOF
    ++		test_cmp expect hooks.log
    ++	)
    ++'
    ++
     +test_expect_success 'conflicts are detected' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
10:  a5e90d5b2f = 11:  5f509b2edc add-patch: split out header from "add-interactive.h"
11:  927f2d226b = 12:  cba60462f5 add-patch: split out `struct interactive_options`
12:  1b232881f2 = 13:  316b830d2c add-patch: remove dependency on "add-interactive" subsystem
13:  4f1fcc0f85 = 14:  4e964cdcf8 add-patch: add support for in-memory index patching
14:  b88ac830f1 = 15:  9b33852290 wt-status: provide function to expose status for trees
 -:  ---------- > 16:  2a7fc74da1 sequencer: allow callers to provide mappings for the old commit
15:  163e8d4d6e ! 17:  9b68e75de2 builtin/history: implement "split" subcommand
    @@ Commit message
     
         It is quite a common use case that one wants to split up one commit into
         multiple commits by moving parts of the changes of the original commit
    -    out of it into a separate commit. This is quite an involved operation
    -    though:
    +    out into a separate commit. This is quite an involved operation though:
     
           1. Identify the commit in question that is to be dropped.
     
    @@ builtin/history.c
      
      static int cmd_history_abort(int argc,
      			     const char **argv,
    +@@ builtin/history.c: static int apply_commits(struct repository *repo,
    + 			 const struct strvec *commits,
    + 			 struct commit *head,
    + 			 struct commit *base,
    ++			 const struct oidmap *rewritten_commits,
    + 			 const char *action)
    + {
    + 	struct setup_revision_opt revision_opts = {
    +@@ builtin/history.c: static int apply_commits(struct repository *repo,
    + 		replay_opts.strategy = replay_opts.default_strategy;
    + 		replay_opts.default_strategy = NULL;
    + 	}
    ++	replay_opts.old_oid_mappings = rewritten_commits;
    + 
    + 	strvec_push(&args, "");
    + 	strvec_pushv(&args, commits->v);
    +@@ builtin/history.c: static int cmd_history_drop(int argc,
    + 		if (ret < 0)
    + 			goto out;
    + 
    +-		ret = apply_commits(repo, &commits, head, commit_to_drop, "drop");
    ++		ret = apply_commits(repo, &commits, head, commit_to_drop,
    ++				    NULL, "drop");
    + 		if (ret < 0)
    + 			goto out;
    + 	}
    +@@ builtin/history.c: static int cmd_history_reorder(int argc,
    + 	replace_commits(&commits, &commit_to_reorder->object.oid, NULL, 0);
    + 	replace_commits(&commits, &anchor->object.oid, replacement, ARRAY_SIZE(replacement));
    + 
    +-	ret = apply_commits(repo, &commits, head, old, "reorder");
    ++	ret = apply_commits(repo, &commits, head, old, NULL, "reorder");
    + 	if (ret < 0)
    + 		goto out;
    + 
     @@ builtin/history.c: static int cmd_history_reorder(int argc,
      	return ret;
      }
    @@ builtin/history.c: static int cmd_history_reorder(int argc,
     +			       struct strbuf *out)
     +{
     +	if (!provided_message) {
    -+		struct wt_status s;
     +		const char *path = git_path_commit_editmsg();
     +		const char *hint =
     +			_("Please enter the commit message for the %s changes. Lines starting\n"
     +			  "with '%s' will be kept; you may remove them yourself if you want to.\n");
    ++		int verbose = 1;
     +
     +		strbuf_addstr(out, default_message);
     +		strbuf_addch(out, '\n');
     +		strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
     +		write_file_buf(path, out->buf, out->len);
     +
    -+		wt_status_prepare(repo, &s);
    -+		FREE_AND_NULL(s.branch);
    -+		s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
    -+		s.commit_template = 1;
    -+		s.colopts = 0;
    -+		s.display_comment_prefix = 1;
    -+		s.hints = 0;
    -+		s.use_color = 0;
    -+		s.whence = FROM_COMMIT;
    -+		s.committable = 1;
    -+
    -+		s.fp = fopen(git_path_commit_editmsg(), "a");
    -+		if (!s.fp)
    -+			return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
    -+
    -+		wt_status_collect_changes_trees(&s, old_tree, new_tree);
    -+		wt_status_print(&s);
    -+		wt_status_collect_free_buffers(&s);
    -+		string_list_clear_func(&s.change, change_data_free);
    ++		repo_config_get_bool(repo, "commit.verbose", &verbose);
    ++		if (verbose) {
    ++			struct wt_status s;
    ++
    ++			wt_status_prepare(repo, &s);
    ++			FREE_AND_NULL(s.branch);
    ++			s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
    ++			s.commit_template = 1;
    ++			s.colopts = 0;
    ++			s.display_comment_prefix = 1;
    ++			s.hints = 0;
    ++			s.use_color = 0;
    ++			s.whence = FROM_COMMIT;
    ++			s.committable = 1;
    ++
    ++			s.fp = fopen(git_path_commit_editmsg(), "a");
    ++			if (!s.fp)
    ++				return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
    ++
    ++			wt_status_collect_changes_trees(&s, old_tree, new_tree);
    ++			wt_status_print(&s);
    ++			wt_status_collect_free_buffers(&s);
    ++			string_list_clear_func(&s.change, change_data_free);
    ++		}
     +
     +		strbuf_reset(out);
     +		if (launch_editor(path, out, NULL)) {
    -+			fprintf(stderr, _("Please supply the message using either -m or -F option.\n"));
    ++			fprintf(stderr, _("Please supply the message using the -m option.\n"));
     +			return -1;
     +		}
     +		strbuf_stripspace(out, comment_line_str);
    -+
     +	} else {
     +		strbuf_addstr(out, provided_message);
     +	}
    @@ builtin/history.c: static int cmd_history_reorder(int argc,
     +		OPT_STRING('m', "message", &commit_message, N_("message"), N_("commit message")),
     +		OPT_END(),
     +	};
    ++	struct oidmap rewritten_commits = OIDMAP_INIT;
     +	struct commit *original_commit, *head;
     +	struct strvec commits = STRVEC_INIT;
     +	struct commit_list *list = NULL;
     +	struct object_id split_commits[2];
    ++	struct replay_oid_mapping mapping[2] = { 0 };
     +	struct pathspec pathspec = { 0 };
     +	int ret;
     +
    @@ builtin/history.c: static int cmd_history_reorder(int argc,
     +	if (ret < 0)
     +		goto out;
     +
    ++	mapping[0].entry.oid = split_commits[0];
    ++	mapping[0].rewritten_oid = original_commit->object.oid;
    ++	oidmap_put(&rewritten_commits, &mapping[0]);
    ++	mapping[1].entry.oid = split_commits[1];
    ++	mapping[1].rewritten_oid = original_commit->object.oid;
    ++	oidmap_put(&rewritten_commits, &mapping[1]);
    ++
     +	replace_commits(&commits, &original_commit->object.oid,
     +			split_commits, ARRAY_SIZE(split_commits));
     +
    -+	ret = apply_commits(repo, &commits, head, original_commit, "split");
    ++	ret = apply_commits(repo, &commits, head, original_commit,
    ++			    &rewritten_commits, "split");
     +	if (ret < 0)
     +		goto out;
     +
     +	ret = 0;
     +
     +out:
    ++	oidmap_clear(&rewritten_commits, 0);
     +	clear_pathspec(&pathspec);
     +	strvec_clear(&commits);
     +	free_commit_list(list);
    @@ t/t3453-history-split.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'skips change summary with commit.verbose=false' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		touch bar foo &&
    ++		git add . &&
    ++		git commit -m split-me &&
    ++
    ++		write_script fake-editor.sh <<-\EOF &&
    ++		cp "$1" . &&
    ++		echo "some commit message" >>"$1"
    ++		EOF
    ++		test_set_editor "$(pwd)"/fake-editor.sh &&
    ++
    ++		git -c commit.verbose=false history split HEAD <<-EOF &&
    ++		y
    ++		n
    ++		EOF
    ++
    ++		cat >expect <<-EOF &&
    ++
    ++		# Please enter the commit message for the split-out changes. Lines starting
    ++		# with ${SQ}#${SQ} will be kept; you may remove them yourself if you want to.
    ++		EOF
    ++		test_cmp expect COMMIT_EDITMSG &&
    ++
    ++		expect_log <<-EOF
    ++		split-me
    ++		some commit message
    ++		EOF
    ++	)
    ++'
    ++
     +test_expect_success 'can use pathspec to limit what gets split' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    @@ t/t3453-history-split.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'hooks are executed for rewritten commits' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		touch bar foo &&
    ++		git add . &&
    ++		git commit -m split-me &&
    ++		old_head=$(git rev-parse HEAD) &&
    ++
    ++		write_script .git/hooks/prepare-commit-msg <<-EOF &&
    ++		echo "prepare-commit-msg: \$@" >>"$(pwd)/hooks.log"
    ++		EOF
    ++		write_script .git/hooks/post-commit <<-EOF &&
    ++		echo "post-commit" >>"$(pwd)/hooks.log"
    ++		EOF
    ++		write_script .git/hooks/post-rewrite <<-EOF &&
    ++		{
    ++			echo "post-rewrite: \$@"
    ++			cat
    ++		} >>"$(pwd)/hooks.log"
    ++		EOF
    ++
    ++		set_fake_editor &&
    ++		git history split HEAD <<-EOF &&
    ++		y
    ++		n
    ++		EOF
    ++
    ++		expect_log <<-EOF &&
    ++		split-me
    ++		split-out commit
    ++		EOF
    ++
    ++		cat >expect <<-EOF &&
    ++		prepare-commit-msg: .git/COMMIT_EDITMSG message
    ++		post-commit
    ++		prepare-commit-msg: .git/COMMIT_EDITMSG message
    ++		post-commit
    ++		post-rewrite: history
    ++		$old_head $(git rev-parse HEAD~)
    ++		$old_head $(git rev-parse HEAD)
    ++		EOF
    ++		test_cmp expect hooks.log
    ++	)
    ++'
    ++
     +test_expect_success 'refuses to create empty original commit' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
16:  142e1e627b ! 18:  07eca0b266 builtin/history: implement "reword" subcommand
    @@ builtin/history.c: static int split_commit(struct repository *repo,
     +	struct object_id parent_tree_oid, original_commit_tree_oid;
     +	struct object_id rewritten_commit;
     +	const char *original_message, *original_body, *ptr;
    ++	struct oidmap rewritten_commits = OIDMAP_INIT;
    ++	struct replay_oid_mapping mapping = { 0 };
     +	char *original_author = NULL;
     +	size_t len;
     +	int ret;
    @@ builtin/history.c: static int split_commit(struct repository *repo,
     +
     +	original_commit = lookup_commit_reference_by_name(argv[0]);
     +	if (!original_commit) {
    -+		ret = error(_("commit to be split cannot be found: %s"), argv[0]);
    ++		ret = error(_("commit to be reworded cannot be found: %s"), argv[0]);
     +		goto out;
     +	}
     +
    @@ builtin/history.c: static int split_commit(struct repository *repo,
     +
     +	replace_commits(&commits, &original_commit->object.oid, &rewritten_commit, 1);
     +
    -+	ret = apply_commits(repo, &commits, head, original_commit, "reword");
    ++	mapping.entry.oid = rewritten_commit;
    ++	mapping.rewritten_oid = original_commit->object.oid;
    ++	oidmap_put(&rewritten_commits, &mapping);
    ++
    ++	ret = apply_commits(repo, &commits, head, original_commit,
    ++			    &rewritten_commits, "reword");
     +	if (ret < 0)
     +		goto out;
     +
     +	ret = 0;
     +
     +out:
    ++	oidmap_clear(&rewritten_commits, 0);
     +	strbuf_release(&final_message);
     +	strvec_clear(&commits);
     +	free(original_author);
    @@ t/t3454-history-reword.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'hooks are executed for rewritten commits' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit first &&
    ++		test_commit second &&
    ++		test_commit third &&
    ++
    ++		write_script .git/hooks/prepare-commit-msg <<-EOF &&
    ++		echo "prepare-commit-msg: \$@" >>"$(pwd)/hooks.log"
    ++		EOF
    ++		write_script .git/hooks/post-commit <<-EOF &&
    ++		echo "post-commit" >>"$(pwd)/hooks.log"
    ++		EOF
    ++		write_script .git/hooks/post-rewrite <<-EOF &&
    ++		{
    ++			echo "post-rewrite: \$@"
    ++			cat
    ++		} >>"$(pwd)/hooks.log"
    ++		EOF
    ++
    ++		git history reword -m "second reworded" HEAD~ &&
    ++
    ++		cat >expect <<-EOF &&
    ++		third
    ++		second reworded
    ++		first
    ++		EOF
    ++		git log --format=%s >actual &&
    ++		test_cmp expect actual &&
    ++
    ++		cat >expect <<-EOF &&
    ++		prepare-commit-msg: .git/COMMIT_EDITMSG message
    ++		post-commit
    ++		prepare-commit-msg: .git/COMMIT_EDITMSG message
    ++		post-commit
    ++		post-rewrite: history
    ++		$(git rev-parse second) $(git rev-parse HEAD~)
    ++		$(git rev-parse third) $(git rev-parse HEAD)
    ++		EOF
    ++		test_cmp expect hooks.log
    ++	)
    ++'
    ++
     +test_expect_success 'aborts with empty commit message' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    @@ t/t3454-history-reword.sh (new)
     +	)
     +'
     +
    -+
     +test_done

---
base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
change-id: 20250819-b4-pks-history-builtin-83398f9a05f0

