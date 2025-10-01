Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA9646BF
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334273; cv=none; b=SWU0ijwXZwiXjTx27WpExTf/O2gtZHK2UHoz2q6nbFiobcpGmBptAFU9bLMiXWN8H5WSaD+MHY5ZYo1rQgOm8J3wk3iNBilg2PNoJBvJQOZUM4N1C2g0VfXKR06faX96E/KOMEABHqs2ovPlPrm3C6C2xIdaBwjxKdvZ7utEGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334273; c=relaxed/simple;
	bh=IcyS2n+W3LrwMtNsaVUtSpfSN1AIpP1LuyME53P5X60=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=iWzL/+aXzFrtiozRoq1X1utkgOOvGt2EpHvufa2/at8NsAhGWqLJUcLaoBHTxRcT3NV0HwyFWetjS/wLypyCVrQQqwTND6ojnqZeatEfwXdown35Z80WmTZDESnC5YATK44i0hF4FzxgFKeoqdhJC8ar4ZUwi4k1pudZZJsW6+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=roNNXezk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f4ID4Z5g; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="roNNXezk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f4ID4Z5g"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 99EA47A0163;
	Wed,  1 Oct 2025 11:57:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 01 Oct 2025 11:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759334267;
	 x=1759420667; bh=1W+AA8xxt2IUZ9PY69+g+kxp7fbTeRQykoMZ7/5cBz8=; b=
	roNNXezk0ppjSFHOc4EWbbKFtih4FMAqdPjbUzHq0un9LIYz484gdGy2K6fZbU8z
	Uuv3EBcErGr4ois3EAD7S2aIAhKTVv3CgLNxdUuOFIigSCjVujdrBEaJQLT4yi28
	oy9fsnb+5amid3Q83EySLkY32Ds4h0xaWS2eD0iQYzyPD4vORchcMIcUMaQ4AqRe
	1fn1pOPWVz4++H79aPR5YkiPR44hJzOEa/K6Tjx3crMxy3mXOBh4WmKTzUoGK+Qy
	/o2pqQDZfzwXj+JBdaSnuGd/94bL9EUyKe4UNHp+CCIALubIF6dQeo0UfLZQ63wk
	HYu/gwIWM4UQk+JSGmiraw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759334267; x=
	1759420667; bh=1W+AA8xxt2IUZ9PY69+g+kxp7fbTeRQykoMZ7/5cBz8=; b=f
	4ID4Z5goUEXjqPkcC+fvLwkPZo2E+RQD0q+ZEx4eylcjzd/aVbgosRJavD6tXDBN
	jODrsSM3xV27uh2wxxcSfcvHd2aNp4iXeDoNia+yIusT2xXezTd14Xuk2DnNArLv
	WgFErXIob170Do9mKmk4WO/NifA9FICLmA+GiXEZlqCpVw68JOEzgNq1zGUa+RAD
	C9OHkQK+ZDVFAjaKLBMC34pk+uZgOwqzLJZ7bY5IssN8ACOAxRg4qej/JlgLxBD8
	+Hb/Pmq53cM5ecMWAVGJIRb22gaCJS+7/mGBwkLedm8GTTpgzW3Rg2Zg9ajlS7IF
	5efqRTcHA0SySvQBJjqWg==
X-ME-Sender: <xms:ek_daBzyk6RVFWGxMbVEtRhuJkWeiZqbgHcs4DK11kLsMfoPxMDJuA>
    <xme:ek_daAU5vAYGWV10Ijj5ZhG4zepSWurnosVsc2yW7_FOmQwgv95kJHyDiqZnyQgW8
    NYsgpLpdcJ7jT6TjaBMlUbiFFcD704FZtmD0b-pCbknBjC_P0kiNA>
X-ME-Received: <xmr:ek_daBiDh3ODXJAhXazc4rAFMtw9iJ9Hm-skghN6ZbU-yv5BRLgeqwUlTtyjJV0wOH2OTsqaFkyVlXvGjC-D_7Xb6BKKrF3ryCo4xK1adQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrg
    hilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:e0_daAB_gw88uMyVWM6E-WRA6GgFPTsh000Cd5uKS53PzM-l5ZuU6g>
    <xmx:e0_daHuhVfvYo95QadVmxIOgI3bfrRhTnI-vghBUxXNeDroQtYJRYA>
    <xmx:e0_daEdBplo7UlKFfRgknpwxG4tE6-y-KNdRLjKG_atYDMT7SUK2bg>
    <xmx:e0_daM_lpjmwnXozPrw-93risGM4fPp92YIFdKvcUmML-ldZ-lb03g>
    <xmx:e0_daFMTE3_ubXGOV58fjzDGs_0M_FV92uzNF9IVVNtQvUTsV55CgaVX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 11:57:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f9feefc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 1 Oct 2025 15:57:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/12] Introduce git-history(1) command for easy history
 editing
Date: Wed, 01 Oct 2025 17:57:26 +0200
Message-Id: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGZP3WgC/4XNyw6CMBAF0F8hXVvTJ7Su/A/jgkIrExVIi42G8
 O8WYnwsiMs7uffMiIL1YAPaZSPyNkKArk1BbDJUNWV7shjqlBEjTBJFNTYC9+eAGwhD5x/Y3OA
 yQIsV51o5XRLpCErj3lsH9wU+HFN+9Zc/kc7Xv2SkmGBtiqLiLFfK2X1qbeGKZi+yL4OJVYPNR
 i7KijKXS1P/GPxjaLJu8GTMDcklFYWUb2Oapif7SWhIQQEAAA==
X-Change-ID: 20250819-b4-pks-history-builtin-83398f9a05f0
In-Reply-To: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>
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

This patch series is a starting point for such a command. I've
significantly slimmed it down from the first couple revisions now
following the discussions at the Contributor's Summit yesterday. This
was my intent anyway, as I already mentioned on the last iteration.

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

Changes in v4:
  - I've rebuilt the patch series. It is now based on 821f583da6 (The
    thirteenth batcn, 2025-09-29) with sa/replay-atomic-ref-updates
    at 665c66a743 (replay: make atomic ref updates the default behavior,
    2025-09-27) merged into it. This should fix all conflicts with seen.
  - I've reworked this patch series to use the same infra as
    git-replay(1), as discussed during the Contributor's Summit.
  - I've slimmed down the patch series to only tackle those commands
    that cannot result in a conflict to keep it simple. I also learned
    that Elijah has been working on a "git replay edit" command, so I
    dropped that command so that we can instead use his version.
  - During the Contributor's Summit we have agreed that for now, we
    won't care about hook execution just yet. This may be backfilled at
    a later point in time.
  - I dropped "commit.verbose" handling for now, as my understanding of
    it was wrong at first. This is something we should backfill.
  - Link to v3: https://lore.kernel.org/r/20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (12):
      wt-status: provide function to expose status for trees
      replay: extract logic to pick commits
      replay: stop using `the_repository`
      replay: parse commits before dereferencing them
      builtin: add new "history" command
      builtin/history: implement "reword" subcommand
      add-patch: split out header from "add-interactive.h"
      add-patch: split out `struct interactive_options`
      add-patch: remove dependency on "add-interactive" subsystem
      add-patch: add support for in-memory index patching
      cache-tree: allow writing in-memory index as tree
      builtin/history: implement "split" subcommand

 .gitignore                     |   1 +
 Documentation/git-history.adoc | 114 ++++++++
 Documentation/meson.build      |   1 +
 Makefile                       |   2 +
 add-interactive.c              | 174 +++---------
 add-interactive.h              |  46 +--
 add-patch.c                    | 295 +++++++++++++++++---
 add-patch.h                    |  64 +++++
 builtin.h                      |   1 +
 builtin/add.c                  |  22 +-
 builtin/checkout.c             |   7 +-
 builtin/commit.c               |  16 +-
 builtin/history.c              | 614 +++++++++++++++++++++++++++++++++++++++++
 builtin/replay.c               | 110 +-------
 builtin/reset.c                |  16 +-
 builtin/stash.c                |  46 +--
 cache-tree.c                   |   5 +-
 cache-tree.h                   |   3 +-
 command-list.txt               |   1 +
 commit.h                       |   2 +-
 git.c                          |   1 +
 meson.build                    |   2 +
 replay.c                       | 118 ++++++++
 replay.h                       |  18 ++
 t/meson.build                  |   3 +
 t/t3450-history.sh             |  17 ++
 t/t3451-history-reword.sh      | 202 ++++++++++++++
 t/t3452-history-split.sh       | 432 +++++++++++++++++++++++++++++
 wt-status.c                    |  24 ++
 wt-status.h                    |   3 +
 30 files changed, 1984 insertions(+), 376 deletions(-)

Range-diff versus v3:

 1:  166ba26bea <  -:  ---------- sequencer: optionally skip printing commit summary
 2:  60173823a9 <  -:  ---------- sequencer: add option to rewind HEAD after picking commits
 3:  74d21ea445 <  -:  ---------- sequencer: introduce new history editing mode
 4:  b1c052afc7 <  -:  ---------- sequencer: stop using `the_repository` in `sequencer_remove_state()`
 5:  0884c4fd96 <  -:  ---------- sequencer: wire up "rewritten-hook" for REPLAY_HISTORY_EDIT
15:  b77e378615 =  1:  695fc789d5 wt-status: provide function to expose status for trees
 -:  ---------- >  2:  55707c8cb3 replay: extract logic to pick commits
 -:  ---------- >  3:  1308a0bbbb replay: stop using `the_repository`
 -:  ---------- >  4:  d153d366b5 replay: parse commits before dereferencing them
 7:  243d36cb45 !  5:  820a2f4c17 builtin: add new "history" command
    @@ builtin/history.c (new)
     +	};
     +
     +	argc = parse_options(argc, argv, prefix, options, usage, 0);
    ++	if (argc)
    ++		usagef("unrecognized argument: %s", argv[0]);
     +	return 0;
     +}
     
    @@ t/meson.build: integration_tests = [
        't3500-cherry.sh',
        't3501-revert-cherry-pick.sh',
        't3502-cherry-pick-merge.sh',
    -@@ t/meson.build: if perl.found() and time.found()
    -       timeout: 0,
    -     )
    -   endforeach
    --endif
    - \ No newline at end of file
    -+endif
     
      ## t/t3450-history.sh (new) ##
     @@
    @@ t/t3450-history.sh (new)
     +
     +. ./test-lib.sh
     +
    -+test_expect_success 'refuses to do anything without subcommand' '
    -+	test_must_fail git history 2>err &&
    -+	test_grep foo err
    ++test_expect_success 'does nothing without any arguments' '
    ++	git history >out 2>&1 &&
    ++	test_must_be_empty out
    ++'
    ++
    ++test_expect_success 'raises an error with unknown argument' '
    ++	test_must_fail git history garbage 2>err &&
    ++	test_grep "unrecognized argument: garbage" err
     +'
     +
     +test_done
18:  0a1ff48827 !  6:  43af6dc4dc builtin/history: implement "reword" subcommand
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Documentation/git-history.adoc ##
    -@@ Documentation/git-history.adoc: git history continue
    - git history quit
    - git history drop <commit>
    - git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)
    +@@ Documentation/git-history.adoc: SYNOPSIS
    + --------
    + [synopsis]
    + git history [<options>]
     +git history reword [<options>] <commit>
    - git history split [<options>] <commit> [--] [<pathspec>...]
      
      DESCRIPTION
    -@@ Documentation/git-history.adoc: child commits, as that would lead to an empty branch.
    - 	be related to one another and must be reachable from the current `HEAD`
    - 	commit.
    + -----------
    +@@ Documentation/git-history.adoc: COMMANDS
    + This command requires a subcommand. Several subcommands are available to
    + rewrite history in different ways:
      
     +`reword <commit> [--message=<message>]`::
     +	Rewrite the commit message of the specified commit. All the other
    -+	details of this commit remain unchanged.
    ++	details of this commit remain unchanged. If no commit message is
    ++	provided, then this command will spawn an editor with the current
    ++	message of that commit.
     +
    - `split [--message=<message>] <commit> [--] [<pathspec>...]`::
    - 	Interactively split up <commit> into two commits by choosing
    - 	hunks introduced by it that will be moved into the new split-out
    + CONFIGURATION
    + -------------
    + 
     
      ## builtin/history.c ##
    -@@ builtin/history.c: static int split_commit(struct repository *repo,
    - 	return ret;
    - }
    - 
    +@@
    ++#define USE_THE_REPOSITORY_VARIABLE
    ++
    + #include "builtin.h"
    ++#include "commit-reach.h"
    ++#include "commit.h"
    ++#include "config.h"
    ++#include "editor.h"
    ++#include "environment.h"
    + #include "gettext.h"
    ++#include "hex.h"
    ++#include "oidmap.h"
    + #include "parse-options.h"
    ++#include "refs.h"
    ++#include "replay.h"
    ++#include "reset.h"
    ++#include "revision.h"
    ++#include "sequencer.h"
    ++#include "strvec.h"
    ++#include "tree.h"
    ++#include "wt-status.h"
    ++
    ++static int collect_commits(struct repository *repo,
    ++			   struct commit *old_commit,
    ++			   struct commit *new_commit,
    ++			   struct strvec *out)
    ++{
    ++	struct setup_revision_opt revision_opts = {
    ++		.assume_dashdash = 1,
    ++	};
    ++	struct strvec revisions = STRVEC_INIT;
    ++	struct commit_list *from_list = NULL;
    ++	struct commit *child;
    ++	struct rev_info rev = { 0 };
    ++	int ret;
    ++
    ++	/*
    ++	 * Check that the old commit actually is an ancestor of HEAD. If not
    ++	 * the whole request becomes nonsensical.
    ++	*/
    ++	if (old_commit) {
    ++		commit_list_insert(old_commit, &from_list);
    ++		if (!repo_is_descendant_of(repo, new_commit, from_list)) {
    ++			ret = error(_("commit must be reachable from current HEAD commit"));
    ++			goto out;
    ++		}
    ++	}
    ++
    ++	repo_init_revisions(repo, &rev, NULL);
    ++	strvec_push(&revisions, "");
    ++	strvec_push(&revisions, oid_to_hex(&new_commit->object.oid));
    ++	if (old_commit)
    ++		strvec_pushf(&revisions, "^%s", oid_to_hex(&old_commit->object.oid));
    ++
    ++	setup_revisions_from_strvec(&revisions, &rev, &revision_opts);
    ++	if (revisions.nr != 1 || prepare_revision_walk(&rev)) {
    ++		ret = error(_("revision walk setup failed"));
    ++		goto out;
    ++	}
    ++
    ++	while ((child = get_revision(&rev))) {
    ++		if (old_commit && !child->parents)
    ++			BUG("revision walk did not find child commit");
    ++		if (child->parents && child->parents->next) {
    ++			ret = error(_("cannot rearrange commit history with merges"));
    ++			goto out;
    ++		}
    ++
    ++		strvec_push(out, oid_to_hex(&child->object.oid));
    ++
    ++		if (child->parents && old_commit &&
    ++		    commit_list_contains(old_commit, child->parents))
    ++			break;
    ++	}
    ++
    ++	/*
    ++	 * Revisions are in newest-order-first. We have to reverse the
    ++	 * array though so that we pick the oldest commits first.
    ++	 */
    ++	for (size_t i = 0, j = out->nr - 1; i < j; i++, j--)
    ++		SWAP(out->v[i], out->v[j]);
    ++
    ++	ret = 0;
    ++
    ++out:
    ++	free_commit_list(from_list);
    ++	strvec_clear(&revisions);
    ++	release_revisions(&rev);
    ++	reset_revision_walk();
    ++	return ret;
    ++}
    ++
    ++static void replace_commits(struct strvec *commits,
    ++			    const struct object_id *commit_to_replace,
    ++			    const struct object_id *replacements,
    ++			    size_t replacements_nr)
    ++{
    ++	char commit_to_replace_oid[GIT_MAX_HEXSZ + 1];
    ++	struct strvec replacement_oids = STRVEC_INIT;
    ++	bool found = false;
    ++
    ++	oid_to_hex_r(commit_to_replace_oid, commit_to_replace);
    ++	for (size_t i = 0; i < replacements_nr; i++)
    ++		strvec_push(&replacement_oids, oid_to_hex(&replacements[i]));
    ++
    ++	for (size_t i = 0; i < commits->nr; i++) {
    ++		if (strcmp(commits->v[i], commit_to_replace_oid))
    ++			continue;
    ++		strvec_splice(commits, i, 1, replacement_oids.v, replacement_oids.nr);
    ++		found = true;
    ++		break;
    ++	}
    ++	if (!found)
    ++		BUG("could not find commit to replace");
    ++
    ++	strvec_clear(&replacement_oids);
    ++}
    ++
    ++static int apply_commits(struct repository *repo,
    ++			 const struct strvec *commits,
    ++			 struct commit *onto,
    ++			 struct commit *orig_head,
    ++			 const char *action)
    ++{
    ++	struct reset_head_opts reset_opts = { 0 };
    ++	struct merge_options merge_opts = { 0 };
    ++	struct merge_result result = { 0 };
    ++	struct strbuf buf = STRBUF_INIT;
    ++	kh_oid_map_t *replayed_commits;
    ++	int ret;
    ++
    ++	replayed_commits = kh_init_oid_map();
    ++
    ++	init_basic_merge_options(&merge_opts, repo);
    ++	merge_opts.show_rename_progress = 0;
    ++
    ++	for (size_t i = 0; i < commits->nr; i++) {
    ++		struct object_id commit_id;
    ++		struct commit *commit;
    ++		const char *end;
    ++		int hash_result;
    ++		khint_t pos;
    ++
    ++		if (parse_oid_hex_algop(commits->v[i], &commit_id, &end,
    ++					repo->hash_algo)) {
    ++			ret = error(_("invalid object ID: %s"), commits->v[i]);
    ++			goto out;
    ++		}
    ++
    ++		commit = lookup_commit(repo, &commit_id);
    ++		if (!commit || repo_parse_commit(repo, commit)) {
    ++			ret = error(_("failed to look up commit: %s"), oid_to_hex(&commit_id));
    ++			goto out;
    ++		}
    ++
    ++		if (!onto) {
    ++			onto = commit;
    ++			result.clean = 1;
    ++			result.tree = repo_get_commit_tree(repo, commit);
    ++		} else {
    ++			onto = replay_pick_regular_commit(repo, commit, replayed_commits,
    ++							  onto, &merge_opts, &result);
    ++			if (!onto)
    ++				break;
    ++		}
    ++
    ++		pos = kh_put_oid_map(replayed_commits, commit->object.oid, &hash_result);
    ++		if (hash_result == 0) {
    ++			ret = error(_("duplicate rewritten commit: %s\n"),
    ++				    oid_to_hex(&commit->object.oid));
    ++			goto out;
    ++		}
    ++		kh_value(replayed_commits, pos) = onto;
    ++	}
    ++
    ++	if (!result.clean) {
    ++		ret = error(_("could not merge"));
    ++		goto out;
    ++	}
    ++
    ++	reset_opts.oid = &onto->object.oid;
    ++	strbuf_addf(&buf, "%s: switch to rewritten %s", action, oid_to_hex(reset_opts.oid));
    ++	reset_opts.flags = RESET_HEAD_REFS_ONLY | RESET_ORIG_HEAD;
    ++	reset_opts.orig_head = &orig_head->object.oid;
    ++	reset_opts.default_reflog_action = action;
    ++	if (reset_head(repo, &reset_opts) < 0) {
    ++		ret = error(_("could not switch to %s"), oid_to_hex(reset_opts.oid));
    ++		goto out;
    ++	}
    ++
    ++	ret = 0;
    ++
    ++out:
    ++	kh_destroy_oid_map(replayed_commits);
    ++	merge_finalize(&merge_opts, &result);
    ++	strbuf_release(&buf);
    ++	return ret;
    ++}
    ++
    ++static void change_data_free(void *util, const char *str UNUSED)
    ++{
    ++	struct wt_status_change_data *d = util;
    ++	free(d->rename_source);
    ++	free(d);
    ++}
    ++
    ++static int fill_commit_message(struct repository *repo,
    ++			       const struct object_id *old_tree,
    ++			       const struct object_id *new_tree,
    ++			       const char *default_message,
    ++			       const char *provided_message,
    ++			       const char *action,
    ++			       struct strbuf *out)
    ++{
    ++	if (!provided_message) {
    ++		const char *path = git_path_commit_editmsg();
    ++		const char *hint =
    ++			_("Please enter the commit message for the %s changes. Lines starting\n"
    ++     "with '%s' will be kept; you may remove them yourself if you want to.\n");
    ++		struct wt_status s;
    ++
    ++		strbuf_addstr(out, default_message);
    ++		strbuf_addch(out, '\n');
    ++		strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
    ++		write_file_buf(path, out->buf, out->len);
    ++
    ++		wt_status_prepare(repo, &s);
    ++		FREE_AND_NULL(s.branch);
    ++		s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
    ++		s.commit_template = 1;
    ++		s.colopts = 0;
    ++		s.display_comment_prefix = 1;
    ++		s.hints = 0;
    ++		s.use_color = 0;
    ++		s.whence = FROM_COMMIT;
    ++		s.committable = 1;
    ++
    ++		s.fp = fopen(git_path_commit_editmsg(), "a");
    ++		if (!s.fp)
    ++			return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
    ++
    ++		wt_status_collect_changes_trees(&s, old_tree, new_tree);
    ++		wt_status_print(&s);
    ++		wt_status_collect_free_buffers(&s);
    ++		string_list_clear_func(&s.change, change_data_free);
    ++
    ++		strbuf_reset(out);
    ++		if (launch_editor(path, out, NULL)) {
    ++			fprintf(stderr, _("Please supply the message using the -m option.\n"));
    ++			return -1;
    ++		}
    ++		strbuf_stripspace(out, comment_line_str);
    ++	} else {
    ++		strbuf_addstr(out, provided_message);
    ++	}
    ++
    ++	cleanup_message(out, COMMIT_MSG_CLEANUP_ALL, 0);
    ++
    ++	if (!out->len) {
    ++		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
    ++		return -1;
    ++	}
    ++
    ++	return 0;
    ++}
    ++
     +static int cmd_history_reword(int argc,
     +			      const char **argv,
     +			      const char *prefix,
    @@ builtin/history.c: static int split_commit(struct repository *repo,
     +		OPT_END(),
     +	};
     +	struct strbuf final_message = STRBUF_INIT;
    -+	struct commit *original_commit, *head;
    ++	struct commit *original_commit, *parent, *head;
     +	struct strvec commits = STRVEC_INIT;
     +	struct object_id parent_tree_oid, original_commit_tree_oid;
     +	struct object_id rewritten_commit;
     +	const char *original_message, *original_body, *ptr;
    -+	struct oidmap rewritten_commits = OIDMAP_INIT;
    -+	struct replay_oid_mapping mapping = { 0 };
     +	char *original_author = NULL;
     +	size_t len;
     +	int ret;
    @@ builtin/history.c: static int split_commit(struct repository *repo,
     +		ret = error(_("commit to be reworded cannot be found: %s"), argv[0]);
     +		goto out;
     +	}
    ++	if (repo_parse_commit(repo, original_commit)) {
    ++		ret = error(_("unable to parse commit %s"),
    ++			    oid_to_hex(&original_commit->object.oid));
    ++		goto out;
    ++	}
    ++	original_commit_tree_oid = repo_get_commit_tree(repo, original_commit)->object.oid;
    ++
    ++	parent = original_commit->parents ? original_commit->parents->item : NULL;
    ++	if (parent) {
    ++		if (repo_parse_commit(repo, parent)) {
    ++			ret = error(_("unable to parse commit %s"),
    ++				    oid_to_hex(&parent->object.oid));
    ++			goto out;
    ++		}
    ++		parent_tree_oid = repo_get_commit_tree(repo, parent)->object.oid;
    ++	} else {
    ++		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
    ++	}
     +
     +	head = lookup_commit_reference_by_name("HEAD");
     +	if (!head) {
    @@ builtin/history.c: static int split_commit(struct repository *repo,
     +	 * This ensures that we'll abort early on in case the range of commits
     +	 * contains merges, which we do not yet handle.
     +	 */
    -+	ret = collect_commits(repo, original_commit->parents ? original_commit->parents->item : NULL,
    -+			      head, &commits);
    ++	ret = collect_commits(repo, parent, head, &commits);
     +	if (ret < 0)
     +		goto out;
     +
    @@ builtin/history.c: static int split_commit(struct repository *repo,
     +		original_author = xmemdupz(ptr, len);
     +	find_commit_subject(original_message, &original_body);
     +
    -+	if (original_commit->parents)
    -+		parent_tree_oid = *get_commit_tree_oid(original_commit->parents->item);
    -+	else
    -+		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
    -+	original_commit_tree_oid = *get_commit_tree_oid(original_commit);
    -+
     +	ret = fill_commit_message(repo, &parent_tree_oid, &original_commit_tree_oid,
     +				  original_body, commit_message, "reworded", &final_message);
     +	if (ret < 0)
    @@ builtin/history.c: static int split_commit(struct repository *repo,
     +
     +	replace_commits(&commits, &original_commit->object.oid, &rewritten_commit, 1);
     +
    -+	mapping.entry.oid = rewritten_commit;
    -+	mapping.rewritten_oid = original_commit->object.oid;
    -+	oidmap_put(&rewritten_commits, &mapping);
    -+
    -+	ret = apply_commits(repo, &commits, head, original_commit,
    -+			    &rewritten_commits, "reword");
    ++	ret = apply_commits(repo, &commits, parent, head, "reword");
     +	if (ret < 0)
     +		goto out;
     +
     +	ret = 0;
     +
     +out:
    -+	oidmap_clear(&rewritten_commits, 0);
     +	strbuf_release(&final_message);
     +	strvec_clear(&commits);
     +	free(original_author);
     +	return ret;
     +}
    -+
    - static int cmd_history_split(int argc,
    - 			     const char **argv,
    - 			     const char *prefix,
    -@@ builtin/history.c: int cmd_history(int argc,
    - 		N_("git history quit"),
    - 		N_("git history drop <commit>"),
    - 		N_("git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)"),
    + 
    + int cmd_history(int argc,
    + 		const char **argv,
    + 		const char *prefix,
    +-		struct repository *repo UNUSED)
    ++		struct repository *repo)
    + {
    + 	const char * const usage[] = {
    + 		N_("git history [<options>]"),
     +		N_("git history reword [<options>] <commit>"),
    - 		N_("git history split [<options>] <commit> [--] [<pathspec>...]"),
      		NULL,
      	};
    -@@ builtin/history.c: int cmd_history(int argc,
    - 		OPT_SUBCOMMAND("quit", &fn, cmd_history_quit),
    - 		OPT_SUBCOMMAND("drop", &fn, cmd_history_drop),
    - 		OPT_SUBCOMMAND("reorder", &fn, cmd_history_reorder),
    ++	parse_opt_subcommand_fn *fn = NULL;
    + 	struct option options[] = {
     +		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
    - 		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
      		OPT_END(),
      	};
    + 
    + 	argc = parse_options(argc, argv, prefix, options, usage, 0);
    +-	if (argc)
    +-		usagef("unrecognized argument: %s", argv[0]);
    +-	return 0;
    ++	return fn(argc, argv, prefix, repo);
    + }
     
      ## t/meson.build ##
     @@ t/meson.build: integration_tests = [
    -   't3451-history-drop.sh',
    -   't3452-history-reorder.sh',
    -   't3453-history-split.sh',
    -+  't3454-history-reword.sh',
    +   't3437-rebase-fixup-options.sh',
    +   't3438-rebase-broken-files.sh',
    +   't3450-history.sh',
    ++  't3451-history-reword.sh',
        't3500-cherry.sh',
        't3501-revert-cherry-pick.sh',
        't3502-cherry-pick-merge.sh',
     
    - ## t/t3454-history-reword.sh (new) ##
    + ## t/t3450-history.sh ##
    +@@ t/t3450-history.sh: test_description='tests for git-history command'
    + . ./test-lib.sh
    + 
    + test_expect_success 'does nothing without any arguments' '
    +-	git history >out 2>&1 &&
    +-	test_must_be_empty out
    ++	test_must_fail git history 2>err &&
    ++	test_grep "need a subcommand" err
    + '
    + 
    + test_expect_success 'raises an error with unknown argument' '
    + 	test_must_fail git history garbage 2>err &&
    +-	test_grep "unrecognized argument: garbage" err
    ++	test_grep "unknown subcommand: .garbage." err
    + '
    + 
    + test_done
    +
    + ## t/t3451-history-reword.sh (new) ##
     @@
     +#!/bin/sh
     +
    @@ t/t3454-history-reword.sh (new)
     +	)
     +'
     +
    -+test_expect_success 'refuses to work with changes in the worktree or index' '
    -+	test_when_finished "rm -rf repo" &&
    -+	git init repo &&
    -+	(
    -+		cd repo &&
    -+		test_commit base file &&
    -+		echo foo >file &&
    -+		test_must_fail git history reword HEAD 2>err &&
    -+		test_grep "Your local changes to the following files would be overwritten" err &&
    -+		git add file &&
    -+		test_must_fail git history reword HEAD 2>err &&
    -+		test_grep "Your local changes to the following files would be overwritten" err
    -+	)
    -+'
    -+
     +test_expect_success 'can reword tip of a branch' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    @@ t/t3454-history-reword.sh (new)
     +	)
     +'
     +
    ++# For now, git-history(1) does not yet execute any hooks. This is subject to
    ++# change in the future, and if it does this test here is expected to start
    ++# failing. In other words, this test is not an endorsement of the current
    ++# status quo.
     +test_expect_success 'hooks are executed for rewritten commits' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    @@ t/t3454-history-reword.sh (new)
     +		test_commit third &&
     +
     +		write_script .git/hooks/prepare-commit-msg <<-EOF &&
    -+		echo "prepare-commit-msg: \$@" >>"$(pwd)/hooks.log"
    ++		touch "$(pwd)/hooks.log
     +		EOF
     +		write_script .git/hooks/post-commit <<-EOF &&
    -+		echo "post-commit" >>"$(pwd)/hooks.log"
    ++		touch "$(pwd)/hooks.log
     +		EOF
     +		write_script .git/hooks/post-rewrite <<-EOF &&
    -+		{
    -+			echo "post-rewrite: \$@"
    -+			cat
    -+		} >>"$(pwd)/hooks.log"
    ++		touch "$(pwd)/hooks.log
     +		EOF
     +
     +		git history reword -m "second reworded" HEAD~ &&
    @@ t/t3454-history-reword.sh (new)
     +		git log --format=%s >actual &&
     +		test_cmp expect actual &&
     +
    -+		cat >expect <<-EOF &&
    -+		prepare-commit-msg: .git/COMMIT_EDITMSG message
    -+		post-commit
    -+		prepare-commit-msg: .git/COMMIT_EDITMSG message
    -+		post-commit
    -+		post-rewrite: history
    -+		$(git rev-parse second) $(git rev-parse HEAD~)
    -+		$(git rev-parse third) $(git rev-parse HEAD)
    -+		EOF
    -+		test_cmp expect hooks.log
    ++		test_path_is_missing hooks.log
     +	)
     +'
     +
    @@ t/t3454-history-reword.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'retains changes in the worktree and index' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		touch a b &&
    ++		git add . &&
    ++		git commit -m "initial commit" &&
    ++		echo foo >a &&
    ++		echo bar >b &&
    ++		git add b &&
    ++		git history reword HEAD -m message &&
    ++		cat >expect <<-\EOF &&
    ++		 M a
    ++		M  b
    ++		?? actual
    ++		?? expect
    ++		EOF
    ++		git status --porcelain >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
     +test_done
11:  01cab3d8a5 =  7:  62e11acdfe add-patch: split out header from "add-interactive.h"
12:  6726e2ee02 !  8:  e0b65245fb add-patch: split out `struct interactive_options`
    @@ add-interactive.c
      #include "prompt.h"
      #include "tree.h"
      
    --static void init_color(struct repository *r, struct add_i_state *s,
    +-static void init_color(struct repository *r, enum git_colorbool use_color,
     -		       const char *section_and_slot, char *dst,
     -		       const char *default_color)
     -{
     -	char *key = xstrfmt("color.%s", section_and_slot);
     -	const char *value;
     -
    --	if (!s->use_color)
    +-	if (!want_color(use_color))
     -		dst[0] = '\0';
     -	else if (repo_config_get_value(r, key, &value) ||
     -		 color_parse(value, dst))
    @@ add-interactive.c
     -
     -	free(key);
     -}
    +-
    +-static enum git_colorbool check_color_config(struct repository *r, const char *var)
    +-{
    +-	const char *value;
    +-	enum git_colorbool ret;
    +-
    +-	if (repo_config_get_value(r, var, &value))
    +-		ret = GIT_COLOR_UNKNOWN;
    +-	else
    +-		ret = git_config_colorbool(var, value);
    +-
    +-	/*
    +-	 * Do not rely on want_color() to fall back to color.ui for us. It uses
    +-	 * the value parsed by git_color_config(), which may not have been
    +-	 * called by the main command.
    +-	 */
    +-	if (ret == GIT_COLOR_UNKNOWN &&
    +-	    !repo_config_get_value(r, "color.ui", &value))
    +-		ret = git_config_colorbool("color.ui", value);
    +-
    +-	return ret;
    +-}
     -
      void init_add_i_state(struct add_i_state *s, struct repository *r,
     -		      struct add_p_opt *add_p_opt)
     +		      struct interactive_options *opts)
      {
    --	const char *value;
    --
      	s->r = r;
     -	s->context = -1;
     -	s->interhunkcontext = -1;
     -
    --	if (repo_config_get_value(r, "color.interactive", &value))
    --		s->use_color = -1;
    --	else
    --		s->use_color =
    --			git_config_colorbool("color.interactive", value);
    --	s->use_color = want_color(s->use_color);
    +-	s->use_color_interactive = check_color_config(r, "color.interactive");
     -
    --	init_color(r, s, "interactive.header", s->header_color, GIT_COLOR_BOLD);
    --	init_color(r, s, "interactive.help", s->help_color, GIT_COLOR_BOLD_RED);
    --	init_color(r, s, "interactive.prompt", s->prompt_color,
    --		   GIT_COLOR_BOLD_BLUE);
    --	init_color(r, s, "interactive.error", s->error_color,
    --		   GIT_COLOR_BOLD_RED);
    +-	init_color(r, s->use_color_interactive, "interactive.header",
    +-		   s->header_color, GIT_COLOR_BOLD);
    +-	init_color(r, s->use_color_interactive, "interactive.help",
    +-		   s->help_color, GIT_COLOR_BOLD_RED);
    +-	init_color(r, s->use_color_interactive, "interactive.prompt",
    +-		   s->prompt_color, GIT_COLOR_BOLD_BLUE);
    +-	init_color(r, s->use_color_interactive, "interactive.error",
    +-		   s->error_color, GIT_COLOR_BOLD_RED);
    +-	strlcpy(s->reset_color_interactive,
    +-		want_color(s->use_color_interactive) ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
     -
    --	init_color(r, s, "diff.frag", s->fraginfo_color,
    --		   diff_get_color(s->use_color, DIFF_FRAGINFO));
    --	init_color(r, s, "diff.context", s->context_color, "fall back");
    --	if (!strcmp(s->context_color, "fall back"))
    --		init_color(r, s, "diff.plain", s->context_color,
    --			   diff_get_color(s->use_color, DIFF_CONTEXT));
    --	init_color(r, s, "diff.old", s->file_old_color,
    --		diff_get_color(s->use_color, DIFF_FILE_OLD));
    --	init_color(r, s, "diff.new", s->file_new_color,
    --		diff_get_color(s->use_color, DIFF_FILE_NEW));
    +-	s->use_color_diff = check_color_config(r, "color.diff");
     -
    --	strlcpy(s->reset_color,
    --		s->use_color ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
    +-	init_color(r, s->use_color_diff, "diff.frag", s->fraginfo_color,
    +-		   diff_get_color(s->use_color_diff, DIFF_FRAGINFO));
    +-	init_color(r, s->use_color_diff, "diff.context", s->context_color,
    +-		   "fall back");
    +-	if (!strcmp(s->context_color, "fall back"))
    +-		init_color(r, s->use_color_diff, "diff.plain",
    +-			   s->context_color,
    +-			   diff_get_color(s->use_color_diff, DIFF_CONTEXT));
    +-	init_color(r, s->use_color_diff, "diff.old", s->file_old_color,
    +-		   diff_get_color(s->use_color_diff, DIFF_FILE_OLD));
    +-	init_color(r, s->use_color_diff, "diff.new", s->file_new_color,
    +-		   diff_get_color(s->use_color_diff, DIFF_FILE_NEW));
    +-	strlcpy(s->reset_color_diff,
    +-		want_color(s->use_color_diff) ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
     -
     -	FREE_AND_NULL(s->interactive_diff_filter);
     -	repo_config_get_string(r, "interactive.difffilter",
    @@ add-interactive.c
     -	FREE_AND_NULL(s->interactive_diff_algorithm);
     +	interactive_config_clear(&s->cfg);
      	memset(s, 0, sizeof(*s));
    --	s->use_color = -1;
    +-	s->use_color_interactive = GIT_COLOR_UNKNOWN;
    +-	s->use_color_diff = GIT_COLOR_UNKNOWN;
     +	interactive_config_clear(&s->cfg);
      }
      
    @@ add-interactive.c: int run_add_i(struct repository *r, const struct pathspec *ps
      	 * When color was asked for, use the prompt color for
      	 * highlighting, otherwise use square brackets.
      	 */
    --	if (s.use_color) {
    +-	if (want_color(s.use_color_interactive)) {
     -		data.color = s.prompt_color;
    --		data.reset = s.reset_color;
    -+	if (s.cfg.use_color) {
    +-		data.reset = s.reset_color_interactive;
    ++	if (want_color(s.cfg.use_color_interactive)) {
     +		data.color = s.cfg.prompt_color;
    -+		data.reset = s.cfg.reset_color;
    ++		data.reset = s.cfg.reset_color_interactive;
      	}
      	print_file_item_data.color = data.color;
      	print_file_item_data.reset = data.reset;
    @@ add-interactive.h
      
      struct add_i_state {
      	struct repository *r;
    --	int use_color;
    +-	enum git_colorbool use_color_interactive;
    +-	enum git_colorbool use_color_diff;
     -	char header_color[COLOR_MAXLEN];
     -	char help_color[COLOR_MAXLEN];
     -	char prompt_color[COLOR_MAXLEN];
     -	char error_color[COLOR_MAXLEN];
    --	char reset_color[COLOR_MAXLEN];
    +-	char reset_color_interactive[COLOR_MAXLEN];
    +-
     -	char fraginfo_color[COLOR_MAXLEN];
     -	char context_color[COLOR_MAXLEN];
     -	char file_old_color[COLOR_MAXLEN];
     -	char file_new_color[COLOR_MAXLEN];
    +-	char reset_color_diff[COLOR_MAXLEN];
     -
     -	int use_single_key;
     -	char *interactive_diff_filter, *interactive_diff_algorithm;
    @@ add-patch.c: struct add_p_state {
      };
      
     +static void init_color(struct repository *r,
    -+		       struct interactive_config *cfg,
    ++		       enum git_colorbool use_color,
     +		       const char *section_and_slot, char *dst,
     +		       const char *default_color)
     +{
     +	char *key = xstrfmt("color.%s", section_and_slot);
     +	const char *value;
     +
    -+	if (!cfg->use_color)
    ++	if (!want_color(use_color))
     +		dst[0] = '\0';
     +	else if (repo_config_get_value(r, key, &value) ||
     +		 color_parse(value, dst))
    @@ add-patch.c: struct add_p_state {
     +	free(key);
     +}
     +
    ++static enum git_colorbool check_color_config(struct repository *r, const char *var)
    ++{
    ++	const char *value;
    ++	enum git_colorbool ret;
    ++
    ++	if (repo_config_get_value(r, var, &value))
    ++		ret = GIT_COLOR_UNKNOWN;
    ++	else
    ++		ret = git_config_colorbool(var, value);
    ++
    ++	/*
    ++	 * Do not rely on want_color() to fall back to color.ui for us. It uses
    ++	 * the value parsed by git_color_config(), which may not have been
    ++	 * called by the main command.
    ++	 */
    ++	if (ret == GIT_COLOR_UNKNOWN &&
    ++	    !repo_config_get_value(r, "color.ui", &value))
    ++		ret = git_config_colorbool("color.ui", value);
    ++
    ++	return ret;
    ++}
    ++
     +void interactive_config_init(struct interactive_config *cfg,
     +			     struct repository *r,
     +			     struct interactive_options *opts)
     +{
    -+	const char *value;
    -+
     +	cfg->context = -1;
     +	cfg->interhunkcontext = -1;
     +
    -+	if (repo_config_get_value(r, "color.interactive", &value))
    -+		cfg->use_color = -1;
    -+	else
    -+		cfg->use_color =
    -+			git_config_colorbool("color.interactive", value);
    -+	cfg->use_color = want_color(cfg->use_color);
    ++	cfg->use_color_interactive = check_color_config(r, "color.interactive");
     +
    -+	init_color(r, cfg, "interactive.header", cfg->header_color, GIT_COLOR_BOLD);
    -+	init_color(r, cfg, "interactive.help", cfg->help_color, GIT_COLOR_BOLD_RED);
    -+	init_color(r, cfg, "interactive.prompt", cfg->prompt_color,
    -+		   GIT_COLOR_BOLD_BLUE);
    -+	init_color(r, cfg, "interactive.error", cfg->error_color,
    -+		   GIT_COLOR_BOLD_RED);
    ++	init_color(r, cfg->use_color_interactive, "interactive.header",
    ++		   cfg->header_color, GIT_COLOR_BOLD);
    ++	init_color(r, cfg->use_color_interactive, "interactive.help",
    ++		   cfg->help_color, GIT_COLOR_BOLD_RED);
    ++	init_color(r, cfg->use_color_interactive, "interactive.prompt",
    ++		   cfg->prompt_color, GIT_COLOR_BOLD_BLUE);
    ++	init_color(r, cfg->use_color_interactive, "interactive.error",
    ++		   cfg->error_color, GIT_COLOR_BOLD_RED);
    ++	strlcpy(cfg->reset_color_interactive,
    ++		want_color(cfg->use_color_interactive) ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
     +
    -+	init_color(r, cfg, "diff.frag", cfg->fraginfo_color,
    -+		   diff_get_color(cfg->use_color, DIFF_FRAGINFO));
    -+	init_color(r, cfg, "diff.context", cfg->context_color, "fall back");
    -+	if (!strcmp(cfg->context_color, "fall back"))
    -+		init_color(r, cfg, "diff.plain", cfg->context_color,
    -+			   diff_get_color(cfg->use_color, DIFF_CONTEXT));
    -+	init_color(r, cfg, "diff.old", cfg->file_old_color,
    -+		diff_get_color(cfg->use_color, DIFF_FILE_OLD));
    -+	init_color(r, cfg, "diff.new", cfg->file_new_color,
    -+		diff_get_color(cfg->use_color, DIFF_FILE_NEW));
    ++	cfg->use_color_diff = check_color_config(r, "color.diff");
     +
    -+	strlcpy(cfg->reset_color,
    -+		cfg->use_color ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
    ++	init_color(r, cfg->use_color_diff, "diff.frag", cfg->fraginfo_color,
    ++		   diff_get_color(cfg->use_color_diff, DIFF_FRAGINFO));
    ++	init_color(r, cfg->use_color_diff, "diff.context", cfg->context_color,
    ++		   "fall back");
    ++	if (!strcmp(cfg->context_color, "fall back"))
    ++		init_color(r, cfg->use_color_diff, "diff.plain",
    ++			   cfg->context_color,
    ++			   diff_get_color(cfg->use_color_diff, DIFF_CONTEXT));
    ++	init_color(r, cfg->use_color_diff, "diff.old", cfg->file_old_color,
    ++		diff_get_color(cfg->use_color_diff, DIFF_FILE_OLD));
    ++	init_color(r, cfg->use_color_diff, "diff.new", cfg->file_new_color,
    ++		diff_get_color(cfg->use_color_diff, DIFF_FILE_NEW));
    ++	strlcpy(cfg->reset_color_diff,
    ++		want_color(cfg->use_color_diff) ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
     +
     +	FREE_AND_NULL(cfg->interactive_diff_filter);
     +	repo_config_get_string(r, "interactive.difffilter",
    @@ add-patch.c: struct add_p_state {
     +	FREE_AND_NULL(cfg->interactive_diff_filter);
     +	FREE_AND_NULL(cfg->interactive_diff_algorithm);
     +	memset(cfg, 0, sizeof(*cfg));
    -+	cfg->use_color = -1;
    ++	cfg->use_color_interactive = GIT_COLOR_UNKNOWN;
    ++	cfg->use_color_diff = GIT_COLOR_UNKNOWN;
     +}
     +
      static void add_p_state_clear(struct add_p_state *s)
    @@ add-patch.c: static void err(struct add_p_state *s, const char *fmt, ...)
     -	fputs(s->s.error_color, stdout);
     +	fputs(s->s.cfg.error_color, stdout);
      	vprintf(fmt, args);
    --	puts(s->s.reset_color);
    -+	puts(s->s.cfg.reset_color);
    +-	puts(s->s.reset_color_interactive);
    ++	puts(s->s.cfg.reset_color_interactive);
      	va_end(args);
      }
      
    @@ add-patch.c: static int parse_diff(struct add_p_state *s, const struct pathspec
      		struct object_id oid;
      		strvec_push(&args,
     @@ add-patch.c: static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
    + 	}
    + 	strbuf_complete_line(plain);
      
    - 	if (want_color_fd(1, -1)) {
    +-	if (want_color_fd(1, s->s.use_color_diff)) {
    ++	if (want_color_fd(1, s->s.cfg.use_color_diff)) {
      		struct child_process colored_cp = CHILD_PROCESS_INIT;
     -		const char *diff_filter = s->s.interactive_diff_filter;
     +		const char *diff_filter = s->s.cfg.interactive_diff_filter;
    @@ add-patch.c: static void render_hunk(struct add_p_state *s, struct hunk *hunk,
      		if (len)
      			strbuf_add(out, p, len);
      		else if (colored)
    --			strbuf_addf(out, "%s\n", s->s.reset_color);
    -+			strbuf_addf(out, "%s\n", s->s.cfg.reset_color);
    +-			strbuf_addf(out, "%s\n", s->s.reset_color_diff);
    ++			strbuf_addf(out, "%s\n", s->s.cfg.reset_color_diff);
      		else
      			strbuf_addch(out, '\n');
      	}
    @@ add-patch.c: static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
     +			      s->s.cfg.file_new_color :
     +			      s->s.cfg.context_color);
      		strbuf_add(&s->colored, plain + current, eol - current);
    --		strbuf_addstr(&s->colored, s->s.reset_color);
    -+		strbuf_addstr(&s->colored, s->s.cfg.reset_color);
    +-		strbuf_addstr(&s->colored, s->s.reset_color_diff);
    ++		strbuf_addstr(&s->colored, s->s.cfg.reset_color_diff);
      		if (next > eol)
      			strbuf_add(&s->colored, plain + eol, next - eol);
      		current = next;
    @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
      						: 1));
      		printf(_(s->mode->prompt_mode[prompt_mode_type]),
      		       s->buf.buf);
    --		if (*s->s.reset_color)
    --			fputs(s->s.reset_color, stdout);
    -+		if (*s->s.cfg.reset_color)
    -+			fputs(s->s.cfg.reset_color, stdout);
    +-		if (*s->s.reset_color_interactive)
    +-			fputs(s->s.reset_color_interactive, stdout);
    ++		if (*s->s.cfg.reset_color_interactive)
    ++			fputs(s->s.cfg.reset_color_interactive, stdout);
      		fflush(stdout);
      		if (read_single_character(s) == EOF)
      			break;
    @@ add-patch.h
     +}
     +
     +struct interactive_config {
    -+	int use_color;
    ++	enum git_colorbool use_color_interactive;
    ++	enum git_colorbool use_color_diff;
     +	char header_color[COLOR_MAXLEN];
     +	char help_color[COLOR_MAXLEN];
     +	char prompt_color[COLOR_MAXLEN];
     +	char error_color[COLOR_MAXLEN];
    -+	char reset_color[COLOR_MAXLEN];
    ++	char reset_color_interactive[COLOR_MAXLEN];
    ++
     +	char fraginfo_color[COLOR_MAXLEN];
     +	char context_color[COLOR_MAXLEN];
     +	char file_old_color[COLOR_MAXLEN];
     +	char file_new_color[COLOR_MAXLEN];
    ++	char reset_color_diff[COLOR_MAXLEN];
     +
     +	int use_single_key;
     +	char *interactive_diff_filter, *interactive_diff_algorithm;
13:  fe853dff04 !  9:  3fef9306d3 add-patch: remove dependency on "add-interactive" subsystem
    @@ add-patch.c: static void err(struct add_p_state *s, const char *fmt, ...)
     -	fputs(s->s.cfg.error_color, stdout);
     +	fputs(s->cfg.error_color, stdout);
      	vprintf(fmt, args);
    --	puts(s->s.cfg.reset_color);
    -+	puts(s->cfg.reset_color);
    +-	puts(s->s.cfg.reset_color_interactive);
    ++	puts(s->cfg.reset_color_interactive);
      	va_end(args);
      }
      
    @@ add-patch.c: static int parse_diff(struct add_p_state *s, const struct pathspec
      		struct object_id oid;
      		strvec_push(&args,
     @@ add-patch.c: static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
    + 	}
    + 	strbuf_complete_line(plain);
      
    - 	if (want_color_fd(1, -1)) {
    +-	if (want_color_fd(1, s->s.cfg.use_color_diff)) {
    ++	if (want_color_fd(1, s->cfg.use_color_diff)) {
      		struct child_process colored_cp = CHILD_PROCESS_INIT;
     -		const char *diff_filter = s->s.cfg.interactive_diff_filter;
     +		const char *diff_filter = s->cfg.interactive_diff_filter;
    @@ add-patch.c: static void render_hunk(struct add_p_state *s, struct hunk *hunk,
      		if (len)
      			strbuf_add(out, p, len);
      		else if (colored)
    --			strbuf_addf(out, "%s\n", s->s.cfg.reset_color);
    -+			strbuf_addf(out, "%s\n", s->cfg.reset_color);
    +-			strbuf_addf(out, "%s\n", s->s.cfg.reset_color_diff);
    ++			strbuf_addf(out, "%s\n", s->cfg.reset_color_diff);
      		else
      			strbuf_addch(out, '\n');
      	}
    @@ add-patch.c: static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
     +			      s->cfg.file_new_color :
     +			      s->cfg.context_color);
      		strbuf_add(&s->colored, plain + current, eol - current);
    --		strbuf_addstr(&s->colored, s->s.cfg.reset_color);
    -+		strbuf_addstr(&s->colored, s->cfg.reset_color);
    +-		strbuf_addstr(&s->colored, s->s.cfg.reset_color_diff);
    ++		strbuf_addstr(&s->colored, s->cfg.reset_color_diff);
      		if (next > eol)
      			strbuf_add(&s->colored, plain + eol, next - eol);
      		current = next;
    @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
      						: 1));
      		printf(_(s->mode->prompt_mode[prompt_mode_type]),
      		       s->buf.buf);
    --		if (*s->s.cfg.reset_color)
    --			fputs(s->s.cfg.reset_color, stdout);
    -+		if (*s->cfg.reset_color)
    -+			fputs(s->cfg.reset_color, stdout);
    +-		if (*s->s.cfg.reset_color_interactive)
    +-			fputs(s->s.cfg.reset_color_interactive, stdout);
    ++		if (*s->cfg.reset_color_interactive)
    ++			fputs(s->cfg.reset_color_interactive, stdout);
      		fflush(stdout);
      		if (read_single_character(s) == EOF)
      			break;
14:  37f6cc2a69 = 10:  9948b99601 add-patch: add support for in-memory index patching
 6:  e18b8b86c0 = 11:  19dfc229c9 cache-tree: allow writing in-memory index as tree
 8:  8c6179ef85 <  -:  ---------- builtin/history: introduce subcommands to manage interrupted rewrites
 9:  f5c931a657 <  -:  ---------- builtin/history: implement "drop" subcommand
10:  3ab680968c <  -:  ---------- builtin/history: implement "reorder" subcommand
16:  a66825ed24 <  -:  ---------- sequencer: allow callers to provide mappings for the old commit
17:  731b243497 ! 12:  f72e364f92 builtin/history: implement "split" subcommand
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Documentation/git-history.adoc ##
    -@@ Documentation/git-history.adoc: git history continue
    - git history quit
    - git history drop <commit>
    - git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)
    +@@ Documentation/git-history.adoc: SYNOPSIS
    + [synopsis]
    + git history [<options>]
    + git history reword [<options>] <commit>
     +git history split [<options>] <commit> [--] [<pathspec>...]
      
      DESCRIPTION
      -----------
    -@@ Documentation/git-history.adoc: child commits, as that would lead to an empty branch.
    - 	be related to one another and must be reachable from the current `HEAD`
    - 	commit.
    +@@ Documentation/git-history.adoc: rewrite history in different ways:
    + 	provided, then this command will spawn an editor with the current
    + 	message of that commit.
      
     +`split [--message=<message>] <commit> [--] [<pathspec>...]`::
     +	Interactively split up <commit> into two commits by choosing
    @@ Documentation/git-history.adoc: child commits, as that would lead to an empty br
     +It is invalid to select either all or no hunks, as that would lead to
     +one of the commits becoming empty.
     +
    - The following commands are used to manage an interrupted history-rewriting
    - operation:
    + CONFIGURATION
    + -------------
      
    -@@ Documentation/git-history.adoc: f44a46e third
    - bf7438d first
    - ----------
    +@@ Documentation/git-history.adoc: include::includes/cmd-config-section-all.adoc[]
      
    + include::config/sequencer.adoc[]
    + 
    ++EXAMPLES
    ++--------
    ++
     +Split a commit
     +~~~~~~~~~~~~~~
     +
    @@ -0,0 +1 @@
     + 1 file changed, 1 insertion(+)
     +----------
     +
    -+
    - CONFIGURATION
    - -------------
    - 
    + GIT
    + ---
    + Part of the linkgit:git[1] suite
     
      ## builtin/history.c ##
     @@
    -+/* Required for `comment_line_str`. */
    -+#define USE_THE_REPOSITORY_VARIABLE
    -+
    + #define USE_THE_REPOSITORY_VARIABLE
    + 
      #include "builtin.h"
    - #include "branch.h"
     +#include "cache-tree.h"
    - #include "commit.h"
      #include "commit-reach.h"
    + #include "commit.h"
      #include "config.h"
    -+#include "editor.h"
    - #include "environment.h"
    - #include "gettext.h"
    +@@
      #include "hex.h"
    - #include "object-name.h"
    + #include "oidmap.h"
      #include "parse-options.h"
     +#include "path.h"
    -+#include "pathspec.h"
    -+#include "read-cache-ll.h"
    ++#include "read-cache.h"
      #include "refs.h"
    + #include "replay.h"
      #include "reset.h"
      #include "revision.h"
     +#include "run-command.h"
      #include "sequencer.h"
    -+#include "sparse-index.h"
    - 
    - static int cmd_history_abort(int argc,
    - 			     const char **argv,
    -@@ builtin/history.c: static int apply_commits(struct repository *repo,
    - 			 const struct strvec *commits,
    - 			 struct commit *head,
    - 			 struct commit *base,
    -+			 const struct oidmap *rewritten_commits,
    - 			 const char *action)
    - {
    - 	struct setup_revision_opt revision_opts = {
    -@@ builtin/history.c: static int apply_commits(struct repository *repo,
    - 		replay_opts.strategy = replay_opts.default_strategy;
    - 		replay_opts.default_strategy = NULL;
    - 	}
    -+	replay_opts.old_oid_mappings = rewritten_commits;
    - 
    - 	strvec_push(&args, "");
    - 	strvec_pushv(&args, commits->v);
    -@@ builtin/history.c: static int cmd_history_drop(int argc,
    - 		if (ret < 0)
    - 			goto out;
    - 
    --		ret = apply_commits(repo, &commits, head, commit_to_drop, "drop");
    -+		ret = apply_commits(repo, &commits, head, commit_to_drop,
    -+				    NULL, "drop");
    - 		if (ret < 0)
    - 			goto out;
    - 	}
    -@@ builtin/history.c: static int cmd_history_reorder(int argc,
    - 	replace_commits(&commits, &commit_to_reorder->object.oid, NULL, 0);
    - 	replace_commits(&commits, &anchor->object.oid, replacement, ARRAY_SIZE(replacement));
    - 
    --	ret = apply_commits(repo, &commits, head, old, "reorder");
    -+	ret = apply_commits(repo, &commits, head, old, NULL, "reorder");
    - 	if (ret < 0)
    - 		goto out;
    - 
    -@@ builtin/history.c: static int cmd_history_reorder(int argc,
    + #include "strvec.h"
    + #include "tree.h"
    +@@ builtin/history.c: static int cmd_history_reword(int argc,
      	return ret;
      }
      
    -+static void change_data_free(void *util, const char *str UNUSED)
    -+{
    -+	struct wt_status_change_data *d = util;
    -+	free(d->rename_source);
    -+	free(d);
    -+}
    -+
    -+static int fill_commit_message(struct repository *repo,
    -+			       const struct object_id *old_tree,
    -+			       const struct object_id *new_tree,
    -+			       const char *default_message,
    -+			       const char *provided_message,
    -+			       const char *action,
    -+			       struct strbuf *out)
    -+{
    -+	if (!provided_message) {
    -+		const char *path = git_path_commit_editmsg();
    -+		const char *hint =
    -+			_("Please enter the commit message for the %s changes. Lines starting\n"
    -+			  "with '%s' will be kept; you may remove them yourself if you want to.\n");
    -+		int verbose = 1;
    -+
    -+		strbuf_addstr(out, default_message);
    -+		strbuf_addch(out, '\n');
    -+		strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
    -+		write_file_buf(path, out->buf, out->len);
    -+
    -+		repo_config_get_bool(repo, "commit.verbose", &verbose);
    -+		if (verbose) {
    -+			struct wt_status s;
    -+
    -+			wt_status_prepare(repo, &s);
    -+			FREE_AND_NULL(s.branch);
    -+			s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
    -+			s.commit_template = 1;
    -+			s.colopts = 0;
    -+			s.display_comment_prefix = 1;
    -+			s.hints = 0;
    -+			s.use_color = 0;
    -+			s.whence = FROM_COMMIT;
    -+			s.committable = 1;
    -+
    -+			s.fp = fopen(git_path_commit_editmsg(), "a");
    -+			if (!s.fp)
    -+				return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
    -+
    -+			wt_status_collect_changes_trees(&s, old_tree, new_tree);
    -+			wt_status_print(&s);
    -+			wt_status_collect_free_buffers(&s);
    -+			string_list_clear_func(&s.change, change_data_free);
    -+		}
    -+
    -+		strbuf_reset(out);
    -+		if (launch_editor(path, out, NULL)) {
    -+			fprintf(stderr, _("Please supply the message using the -m option.\n"));
    -+			return -1;
    -+		}
    -+		strbuf_stripspace(out, comment_line_str);
    -+	} else {
    -+		strbuf_addstr(out, provided_message);
    -+	}
    -+
    -+	cleanup_message(out, COMMIT_MSG_CLEANUP_ALL, 0);
    -+
    -+	if (!out->len) {
    -+		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
    -+		return -1;
    -+	}
    -+
    -+	return 0;
    -+}
    -+
     +static int split_commit(struct repository *repo,
     +			struct commit *original_commit,
     +			struct pathspec *pathspec,
    @@ builtin/history.c: static int cmd_history_reorder(int argc,
     +	original_commit_tree_oid = *get_commit_tree_oid(original_commit);
     +
     +	/*
    -+	 * Construct the first commit. This is done by taking the original
    -+	 * commit parent's tree and selectively patching changes from the diff
    -+	 * between that parent and its child.
    -+	 */
    ++	* Construct the first commit. This is done by taking the original
    ++	* commit parent's tree and selectively patching changes from the diff
    ++	* between that parent and its child.
    ++	*/
     +	repo_git_path_replace(repo, &index_file, "%s", "history-split.index");
     +
     +	read_tree_cmd.git_cmd = 1;
    @@ builtin/history.c: static int cmd_history_reorder(int argc,
     +	unlink(index_file.buf);
     +
     +	/*
    -+	 * We disallow the cases where either the split-out commit or the
    -+	 * original commit would become empty. Consequently, if we see that the
    -+	 * new tree ID matches either of those trees we abort.
    -+	 */
    ++	* We disallow the cases where either the split-out commit or the
    ++	* original commit would become empty. Consequently, if we see that the
    ++	* new tree ID matches either of those trees we abort.
    ++	*/
     +	if (oideq(&split_tree->object.oid, &parent_tree_oid)) {
     +		ret = error(_("split commit is empty"));
     +		goto out;
    @@ builtin/history.c: static int cmd_history_reorder(int argc,
     +	}
     +
     +	/*
    -+	 * The second commit is much simpler to construct, as we can simply use
    -+	 * the original commit details, except that we adjust its parent to be
    -+	 * the newly split-out commit.
    -+	 */
    ++	* The second commit is much simpler to construct, as we can simply use
    ++	* the original commit details, except that we adjust its parent to be
    ++	* the newly split-out commit.
    ++	*/
     +	find_commit_subject(original_message, &original_body);
     +	first_commit = lookup_commit_reference(repo, &out[0]);
     +	commit_list_append(first_commit, &parents);
    @@ builtin/history.c: static int cmd_history_reorder(int argc,
     +		OPT_END(),
     +	};
     +	struct oidmap rewritten_commits = OIDMAP_INIT;
    -+	struct commit *original_commit, *head;
    ++	struct commit *original_commit, *parent, *head;
     +	struct strvec commits = STRVEC_INIT;
     +	struct commit_list *list = NULL;
     +	struct object_id split_commits[2];
    -+	struct replay_oid_mapping mapping[2] = { 0 };
     +	struct pathspec pathspec = { 0 };
     +	int ret;
     +
    @@ builtin/history.c: static int cmd_history_reorder(int argc,
     +		goto out;
     +	}
     +
    ++	parent = original_commit->parents ? original_commit->parents->item : NULL;
    ++	if (parent && repo_parse_commit(repo, parent)) {
    ++		ret = error(_("unable to parse commit %s"),
    ++			    oid_to_hex(&parent->object.oid));
    ++		goto out;
    ++	}
    ++
     +	head = lookup_commit_reference_by_name("HEAD");
     +	if (!head) {
     +		ret = error(_("could not resolve HEAD to a commit"));
    @@ builtin/history.c: static int cmd_history_reorder(int argc,
     +	}
     +
     +	parse_pathspec(&pathspec, 0,
    -+		       PATHSPEC_PREFER_FULL | PATHSPEC_SYMLINK_LEADING_PATH | PATHSPEC_PREFIX_ORIGIN,
    -+		       prefix, argv + 1);
    ++		PATHSPEC_PREFER_FULL | PATHSPEC_SYMLINK_LEADING_PATH | PATHSPEC_PREFIX_ORIGIN,
    ++		prefix, argv + 1);
     +
     +	/*
    -+	 * Collect the list of commits that we'll have to reapply now already.
    -+	 * This ensures that we'll abort early on in case the range of commits
    -+	 * contains merges, which we do not yet handle.
    -+	 */
    -+	ret = collect_commits(repo, original_commit->parents ? original_commit->parents->item : NULL,
    -+			      head, &commits);
    ++	* Collect the list of commits that we'll have to reapply now already.
    ++	* This ensures that we'll abort early on in case the range of commits
    ++	* contains merges, which we do not yet handle.
    ++	*/
    ++	ret = collect_commits(repo, parent, head, &commits);
     +	if (ret < 0)
     +		goto out;
     +
    @@ builtin/history.c: static int cmd_history_reorder(int argc,
     +	if (ret < 0)
     +		goto out;
     +
    -+	mapping[0].entry.oid = split_commits[0];
    -+	mapping[0].rewritten_oid = original_commit->object.oid;
    -+	oidmap_put(&rewritten_commits, &mapping[0]);
    -+	mapping[1].entry.oid = split_commits[1];
    -+	mapping[1].rewritten_oid = original_commit->object.oid;
    -+	oidmap_put(&rewritten_commits, &mapping[1]);
    -+
     +	replace_commits(&commits, &original_commit->object.oid,
     +			split_commits, ARRAY_SIZE(split_commits));
     +
    -+	ret = apply_commits(repo, &commits, head, original_commit,
    -+			    &rewritten_commits, "split");
    ++	ret = apply_commits(repo, &commits, parent, head, "split");
     +	if (ret < 0)
     +		goto out;
     +
    @@ builtin/history.c: static int cmd_history_reorder(int argc,
      		const char **argv,
      		const char *prefix,
     @@ builtin/history.c: int cmd_history(int argc,
    - 		N_("git history quit"),
    - 		N_("git history drop <commit>"),
    - 		N_("git history reorder <commit> (--before=<following-commit>|--after=<preceding-commit>)"),
    + 	const char * const usage[] = {
    + 		N_("git history [<options>]"),
    + 		N_("git history reword [<options>] <commit>"),
     +		N_("git history split [<options>] <commit> [--] [<pathspec>...]"),
      		NULL,
      	};
      	parse_opt_subcommand_fn *fn = NULL;
    -@@ builtin/history.c: int cmd_history(int argc,
    - 		OPT_SUBCOMMAND("quit", &fn, cmd_history_quit),
    - 		OPT_SUBCOMMAND("drop", &fn, cmd_history_drop),
    - 		OPT_SUBCOMMAND("reorder", &fn, cmd_history_reorder),
    + 	struct option options[] = {
    + 		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
     +		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
      		OPT_END(),
      	};
    @@ builtin/history.c: int cmd_history(int argc,
     
      ## t/meson.build ##
     @@ t/meson.build: integration_tests = [
    +   't3438-rebase-broken-files.sh',
        't3450-history.sh',
    -   't3451-history-drop.sh',
    -   't3452-history-reorder.sh',
    -+  't3453-history-split.sh',
    +   't3451-history-reword.sh',
    ++  't3452-history-split.sh',
        't3500-cherry.sh',
        't3501-revert-cherry-pick.sh',
        't3502-cherry-pick-merge.sh',
     
    - ## t/t3453-history-split.sh (new) ##
    + ## t/t3452-history-split.sh (new) ##
     @@
     +#!/bin/sh
     +
    @@ t/t3453-history-split.sh (new)
     +	)
     +'
     +
    -+test_expect_success 'refuses to work with changes in the worktree or index' '
    -+	test_when_finished "rm -rf repo" &&
    -+	git init repo &&
    -+	(
    -+		cd repo &&
    -+		test_commit initial &&
    -+		touch bar foo &&
    -+		git add . &&
    -+		git commit -m split-me &&
    -+
    -+		echo changed >bar &&
    -+		test_must_fail git history split -m message HEAD 2>err <<-EOF &&
    -+		y
    -+		n
    -+		EOF
    -+		test_grep "Your local changes to the following files would be overwritten" err &&
    -+
    -+		git add bar &&
    -+		test_must_fail git history split -m message HEAD 2>err <<-EOF &&
    -+		y
    -+		n
    -+		EOF
    -+		test_grep "Your local changes to the following files would be overwritten" err
    -+	)
    -+'
    -+
     +test_expect_success 'can split up tip commit' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    @@ t/t3453-history-split.sh (new)
     +	)
     +'
     +
    -+test_expect_success 'skips change summary with commit.verbose=false' '
    -+	test_when_finished "rm -rf repo" &&
    -+	git init repo &&
    -+	(
    -+		cd repo &&
    -+		touch bar foo &&
    -+		git add . &&
    -+		git commit -m split-me &&
    -+
    -+		write_script fake-editor.sh <<-\EOF &&
    -+		cp "$1" . &&
    -+		echo "some commit message" >>"$1"
    -+		EOF
    -+		test_set_editor "$(pwd)"/fake-editor.sh &&
    -+
    -+		git -c commit.verbose=false history split HEAD <<-EOF &&
    -+		y
    -+		n
    -+		EOF
    -+
    -+		cat >expect <<-EOF &&
    -+
    -+		# Please enter the commit message for the split-out changes. Lines starting
    -+		# with ${SQ}#${SQ} will be kept; you may remove them yourself if you want to.
    -+		EOF
    -+		test_cmp expect COMMIT_EDITMSG &&
    -+
    -+		expect_log <<-EOF
    -+		split-me
    -+		some commit message
    -+		EOF
    -+	)
    -+'
    -+
     +test_expect_success 'can use pathspec to limit what gets split' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    @@ t/t3453-history-split.sh (new)
     +		old_head=$(git rev-parse HEAD) &&
     +
     +		write_script .git/hooks/prepare-commit-msg <<-EOF &&
    -+		echo "prepare-commit-msg: \$@" >>"$(pwd)/hooks.log"
    ++		touch "$(pwd)/hooks.log"
     +		EOF
     +		write_script .git/hooks/post-commit <<-EOF &&
    -+		echo "post-commit" >>"$(pwd)/hooks.log"
    ++		touch "$(pwd)/hooks.log"
     +		EOF
     +		write_script .git/hooks/post-rewrite <<-EOF &&
    -+		{
    -+			echo "post-rewrite: \$@"
    -+			cat
    -+		} >>"$(pwd)/hooks.log"
    ++		touch "$(pwd)/hooks.log"
     +		EOF
     +
     +		set_fake_editor &&
    @@ t/t3453-history-split.sh (new)
     +		split-out commit
     +		EOF
     +
    -+		cat >expect <<-EOF &&
    -+		prepare-commit-msg: .git/COMMIT_EDITMSG message
    -+		post-commit
    -+		prepare-commit-msg: .git/COMMIT_EDITMSG message
    -+		post-commit
    -+		post-rewrite: history
    -+		$old_head $(git rev-parse HEAD~)
    -+		$old_head $(git rev-parse HEAD)
    -+		EOF
    -+		test_cmp expect hooks.log
    ++		test_path_is_missing hooks.log
     +	)
     +'
     +
    @@ t/t3453-history-split.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'retains changes in the worktree and index' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		echo a >a &&
    ++		echo b >b &&
    ++		git add . &&
    ++		git commit -m "initial commit" &&
    ++		echo a-modified >a &&
    ++		echo b-modified >b &&
    ++		git add b &&
    ++		git history split HEAD -m a-only <<-EOF &&
    ++		y
    ++		n
    ++		EOF
    ++
    ++		expect_tree_entries HEAD~ <<-EOF &&
    ++		a
    ++		EOF
    ++		expect_tree_entries HEAD <<-EOF &&
    ++		a
    ++		b
    ++		EOF
    ++
    ++		cat >expect <<-\EOF &&
    ++		 M a
    ++		M  b
    ++		?? actual
    ++		?? expect
    ++		EOF
    ++		git status --porcelain >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
     +test_done

---
base-commit: 896ecf94ed941815749901ff6ad06d7141904cb2
change-id: 20250819-b4-pks-history-builtin-83398f9a05f0

