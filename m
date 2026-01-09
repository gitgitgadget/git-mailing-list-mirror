Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD8A350A34
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947749; cv=none; b=fxT3iA5n9SzTH7bACnzIM4p8xFp/IkOZHnUQQOj9qtxattxScfy4KInK50u+qewRf3BWuhsXP2ibCKdDF7jCdJLLs5UK2IUDDw31DVf39Fz9BuSYC8jXkXbAEPZ3GDWi/byj/+ccb3zDrLucw0NELAI5MOxyHnEliD3bjTyLGlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947749; c=relaxed/simple;
	bh=wQ4iReIjBedJbj4nLZIDVv0u3cKKYEDnCLX0MKRjRTE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=i56DsSD0gdUgzTY/MVrZWzJmZhyuo711wzzfIPiidkbJ3M2x3t+EdUmsAkp9cPXBHY3fcslAfYfxzasDO4gwiv8jsEji7GzFUuuTWp1criMeE5gvO7HV86nMya+HW1SfJZGWhbFTHhH3Ohaasv9jLHwq7OeRy9WmNfrAx6dJX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YYwG0CQ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CBVBb3CZ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YYwG0CQ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CBVBb3CZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id CFD71EC00D2;
	Fri,  9 Jan 2026 03:35:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 09 Jan 2026 03:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767947743;
	 x=1768034143; bh=44DLJy01ZdUtb1Fd0i9zBqGKPmJqf5iDasTIPK5Wcb4=; b=
	YYwG0CQ4SzV8OTIykqhqN25c3vpLEh3VyEGIV2V2hrtXI7f49BrwMXuDneFQ7xog
	ZQwVedDDB2BgwR8CT9pkbUGTrHdSM+ONOq+/P0pHv9R13jJB+gnNFp7mn0LvyVRB
	hLsTNbcsNOTXNvww2qSBRn3WA4Vpt8GPQ3p7+jJtO0T5E720ww5M11cRVSwVtNDn
	gRml0ALuwvlIrlsvm5jNaHKcjvKKQKHcZvtlHy5kCouIRFwLaWMaqBj8LFeKCPX1
	/H3QJDJokZ39/XNjqw5qQWNcFFwcJ1gg/tooPTWVCkiRzYFj/fPtPxvdU73kxVMV
	vWgG6fp6bJ02cvbxu0Vk4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767947743; x=
	1768034143; bh=44DLJy01ZdUtb1Fd0i9zBqGKPmJqf5iDasTIPK5Wcb4=; b=C
	BVBb3CZa0U3HItKgYtij2AjIanFvBgVZduguPAcnkWFo1H0cItjss2yb+8WStmiB
	nhXY1Q8bx2Rlwc7B0QcHd3ZuRWMFPFrEkfurC5HTKf4r3VNWbQipQ2A11vICVfbv
	JyLhEMXxKiouNlEUKG9EKDBSTuftGh420jc0f1aT5JjCTpQleGNHz4E7ikkFRDh5
	Hb5rmZMtGQEhGT0/Shgc5+Mw+LsAYcHT1qomm9fC8fjJnA9F5/pai25wILLsxhGF
	0cvQ6L5d1Cw7zc0G+YlPi9AvYK5fdeEFfglU5w7lLgcwZyvuIwAteD6X9ooxTbC3
	nN+TvB/tBRD2rxieBeh3g==
X-ME-Sender: <xms:371gacZR5B0f7b8u2qOV98534tpWf2MHi031DPMqUUbMRbIIT6dByw>
    <xme:371gaTMgaK_69vBxRX0UyJeErXjD4lnw325s_8xFI5806-yuz4H3s--uUVE8pbjtI
    BoDLlDmxh8sKZRgpGdmdmqqrwfEG6CYf47u2PQK6dey3CVtFirsWA>
X-ME-Received: <xmr:371gaSXBmO30AOjw5f8mCAJoGYYUnGQ1n053ouf0Nxw3l4bUHtvGN_Q7OyvFgMEBTxQJYRQsKaJ1J4sCtv0kRAFBJ_80mFT7bMka25QVBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghilhessggvhigvrhhmrg
    htthhhihgrshdruggvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepmhgrrhhtihhnvhhonhii
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:371gaQK4W75DTeW2J847dIdIQeX0jHhyHYb4UL543iqAIk-POisp0A>
    <xmx:371gaVq7wRiP3wTyVupQj82bBc9Jtj8PdfGe8edEi9quvRYeiFxvvA>
    <xmx:371gafxyxoYB68BkGmlxkGr-COK1K1TONgirEnmIld1mOAoM6807Qg>
    <xmx:371gaRtrtv8JlY9sIn89EoLd9r4OVgK6y0eZkJ9YAu9SvJdj78dG2g>
    <xmx:371gaWYp8dvDLUELovL29D7fNjutK3B7ezOdR_JeubOG1qDBtstgudVf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 03:35:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8fbbb946 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 08:35:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v9 0/7] Introduce git-history(1) command for easy history
 editing
Date: Fri, 09 Jan 2026 09:35:35 +0100
Message-Id: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANe9YGkC/4XRzU7EIBQF4FeZsBZz+b0XV76HcdEWcIjambRjo
 5n03YWJ2rIgLg85fMDlyuYwpTCzh8OVTWFJczqNObi7AxuO3fgSePI5MwnSAAnHe83PrzM/pvl
 ymr54/5HeLmnkpJSj6DowEVjefJ5CTJ83+Ok555/+7ZxFlNV/yUVw4K5HHJS0RDE85tZ9emfFW
 +TOkLppyGJY3Q1CRmt6XxlqMxy0DZWN0jDKCI3GVIb+MwSAaBo6GxSs8L4nqwRWhtkZsm2YbCB
 5qaLBPA5bGXZvYNOw2dCA3hek86oycDMkqKaBZabBRdKujx7qf6Ffw4KA9j0oG4KCQ3RBdXJ7y
 7qu32yd5P2VAgAA
X-Change-ID: 20250819-b4-pks-history-builtin-83398f9a05f0
In-Reply-To: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Matthias Beyer <mail@beyermatthias.de>
X-Mailer: b4 0.14.3

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

This patch series is a starting point for such a command. For now, it
only implements rewording of commits. I'll continue introducing new
commands once this patch series has been merged though.

Changes in v9:
  - Rename `struct replay_ref_updates` to `struct replay_result` to make
    its semantics less focussed on ref updates, only.
  - Clarify and fix return codes of git-replay(1) so that we return 1 on
    conflict, 128 on an error and 0 on success.
  - The usual small improvements to commit messages.
  - Link to v8: https://lore.kernel.org/r/20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im

Changes in v8:
  - The series is now built on top of e0bfec3dfc (The 15th batch,
    2026-01-06) with kh/replay-invalid-onto-advance at 56b77a687e
    (t3650: add more regression tests for failure conditions,
    2026-01-05) merged into it. The latter is expected to hit 'next'
    soonish.
  - Another biggish revamp to build almost completely on top of the
    git-replay(1) logic.
  - We now advance all branches descending from the rewritten commit by
    default.
  - I've dropped the patches introducing `git history split` and will
    send this as a follow-up patch series once this once has been
    merged. This was done to focus attention on the underlying mechanics
    as much as possible (and to keep my own sanity with the frequent
    revamps).
  - Link to v7: https://lore.kernel.org/r/20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im

Changes in v7:
  - I've rebased the patch series on top of f0ef5b6d9b (The fifth batch,
    2025-11-30) with pw/replay-exclude-gpgsig-fix at 9f3a115087 (replay:
    do not copy "gpgsign-sha256" header, 2025-11-26) merged into it to
    fix some conflicts.
  - I refactored a bunch of code to be shared between split and reword.
  - I am now using "--ancestry-path" and "--reverse" to enumerate
    commits.
  - `git history split` now asks for commit messages for both commits.
  - `git history split` no longer allows the user to edit hunks so that
    conflicts become impossible. This may be reintroduced at a later
    point in time.
  - A bunch of test improvements.
  - Several commit message and documentation improvements.
  - Link to v6: https://lore.kernel.org/r/20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im

Changes in v6:
  - I've rebased the patch series again to pull in the latest updates
    from sa/replay-atomic-ref-updates and fix conflicts. It is now based
    on 4e98b730f1 (The twenty-fourth batch, 2025-10-24) with ab661bb1bb
    (replay: add replay.refAction config option, 2025-10-23) merged into
    it.
  - I've dropped the "-m" options for now, so commit messages are always
    asked for via the editor. These can be introduced in a subsequent
    patch series once discussion around them has settled.
  - We don't use the merge machinery anymore to pick the commits.
  - Drop the commit to parse commits in the replay machinery. It didn't
    seem to be necessary in v5 anymore, and now that we don't use the
    merge machinery at all we don't ever take that code path in the
    first place.
  - Link to v5:
    https://lore.kernel.org/r/20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im

Changes in v5:
  - I've changed the patch series to be based on top of 133d151831 (The
    twenty-first batch, 2025-10-20) with sa/replay-atomic-ref-updates at
    a1c22e627e (SQAUASH??? t0450 band-aid, 2025-10-14) merged into it.
    This is one the one hand to fix a conflict, but also to get some of
    the CI updates to make GitLab CI work again.
  - Some slight commit message improvements.
  - Deduplicate subcommand usage strings by using defines.
  - Fix the desendancy checks to properly verify that HEAD is a
    descendant of the commit to be rewritten. Also add some tests for
    this.
  - Fix the hint that mentions that lines starting with the comment
    character will be tripped after having written the commit message.
  - Move an include to the correct commit.
  - Link to v4: https://lore.kernel.org/r/20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im

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

Thanks!

Patrick

---
Patrick Steinhardt (7):
      builtin/replay: extract core logic to replay revisions
      builtin/replay: move core logic into "libgit.a"
      replay: small set of cleanups
      replay: yield the object ID of the final rewritten commit
      wt-status: provide function to expose status for trees
      builtin: add new "history" command
      builtin/history: implement "reword" subcommand

 .gitignore                     |   1 +
 Documentation/git-history.adoc |  73 ++++++++
 Documentation/meson.build      |   1 +
 Makefile                       |   2 +
 builtin.h                      |   1 +
 builtin/history.c              | 404 +++++++++++++++++++++++++++++++++++++++++
 builtin/replay.c               | 380 ++++----------------------------------
 command-list.txt               |   1 +
 git.c                          |   1 +
 meson.build                    |   2 +
 replay.c                       | 355 ++++++++++++++++++++++++++++++++++++
 replay.h                       |  80 ++++++++
 t/meson.build                  |   2 +
 t/t3450-history.sh             |  17 ++
 t/t3451-history-reword.sh      | 344 +++++++++++++++++++++++++++++++++++
 wt-status.c                    |  24 +++
 wt-status.h                    |   9 +
 17 files changed, 1352 insertions(+), 345 deletions(-)

Range-diff versus v8:

1:  4b58ceb517 ! 1:  5f3123028a builtin/replay: extract core logic to replay revisions
    @@ builtin/replay.c: static enum ref_action_mode get_ref_action_mode(struct reposit
     +	int contained;
     +};
     +
    -+struct replay_ref_updates {
    ++struct replay_result {
     +	struct replay_ref_update {
     +		char *refname;
     +		struct object_id old_oid;
     +		struct object_id new_oid;
    -+	} *items;
    -+	size_t nr, alloc;
    ++	} *updates;
    ++	size_t updates_nr, updates_alloc;
    ++
    ++	bool merge_conflict;
     +};
     +
    -+static void replay_ref_updates_release(struct replay_ref_updates *updates)
    ++static void replay_result_release(struct replay_result *result)
    ++{
    ++	for (size_t i = 0; i < result->updates_nr; i++)
    ++		free(result->updates[i].refname);
    ++	free(result->updates);
    ++}
    ++
    ++static void replay_result_queue_update(struct replay_result *result,
    ++				       const char *refname,
    ++				       const struct object_id *old_oid,
    ++				       const struct object_id *new_oid)
     +{
    -+	for (size_t i = 0; i < updates->nr; i++)
    -+		free(updates->items[i].refname);
    -+	free(updates->items);
    ++	ALLOC_GROW(result->updates, result->updates_nr + 1, result->updates_alloc);
    ++	result->updates[result->updates_nr].refname = xstrdup(refname);
    ++	result->updates[result->updates_nr].old_oid = *old_oid;
    ++	result->updates[result->updates_nr].new_oid = *new_oid;
    ++	result->updates_nr++;
     +}
     +
     +static int replay_revisions(struct repository *repo, struct rev_info *revs,
     +			    struct replay_revisions_options *opts,
    -+			    struct replay_ref_updates *updates)
    ++			    struct replay_result *out)
     +{
     +	kh_oid_map_t *replayed_commits = NULL;
     +	struct strset *update_refs = NULL;
    @@ builtin/replay.c: static enum ref_action_mode get_ref_action_mode(struct reposit
     +			if (decoration->type == DECORATION_REF_LOCAL &&
     +			    (opts->contained || strset_contains(update_refs,
     +								decoration->name))) {
    -+				ALLOC_GROW(updates->items, updates->nr + 1, updates->alloc);
    -+				updates->items[updates->nr].refname = xstrdup(decoration->name);
    -+				updates->items[updates->nr].old_oid = commit->object.oid;
    -+				updates->items[updates->nr].new_oid = last_commit->object.oid;
    -+				updates->nr++;
    ++				replay_result_queue_update(out, decoration->name,
    ++							   &commit->object.oid,
    ++							   &last_commit->object.oid);
     +			}
     +			decoration = decoration->next;
     +		}
     +	}
     +
     +	if (!result.clean) {
    ++		out->merge_conflict = true;
     +		ret = -1;
     +		goto out;
     +	}
     +
     +	/* In --advance mode, advance the target ref */
    -+	if (advance) {
    -+		ALLOC_GROW(updates->items, updates->nr + 1, updates->alloc);
    -+		updates->items[updates->nr].refname = xstrdup(advance);
    -+		updates->items[updates->nr].old_oid = onto->object.oid;
    -+		updates->items[updates->nr].new_oid = last_commit->object.oid;
    -+		updates->nr++;
    -+	}
    ++	if (advance)
    ++		replay_result_queue_update(out, advance,
    ++					   &onto->object.oid,
    ++					   &last_commit->object.oid);
     +
     +	ret = 0;
     +
    @@ builtin/replay.c: int cmd_replay(int argc,
     -	const char *onto_name = NULL;
     -	int contained = 0;
     +	struct replay_revisions_options opts = { 0 };
    -+	struct replay_ref_updates updates = { 0 };
    ++	struct replay_result result = { 0 };
      	const char *ref_action = NULL;
      	enum ref_action_mode ref_mode;
     -
    @@ builtin/replay.c: int cmd_replay(int argc,
     -			   &onto, &update_refs);
     -
     -	/* FIXME: Should allow replaying commits with the first as a root commit */
    -+	ret = replay_revisions(repo, &revs, &opts, &updates);
    ++	ret = replay_revisions(repo, &revs, &opts, &result);
     +	if (ret)
     +		goto cleanup;
      
    @@ builtin/replay.c: int cmd_replay(int argc,
     -				      &onto->object.oid,
     -				      reflog_msg.buf,
     -				      &transaction_err) < 0) {
    -+	for (size_t i = 0; i < updates.nr; i++) {
    -+		ret = handle_ref_update(ref_mode, transaction, updates.items[i].refname,
    -+					&updates.items[i].new_oid, &updates.items[i].old_oid,
    ++	for (size_t i = 0; i < result.updates_nr; i++) {
    ++		ret = handle_ref_update(ref_mode, transaction, result.updates[i].refname,
    ++					&result.updates[i].new_oid, &result.updates[i].old_oid,
     +					reflog_msg.buf, &transaction_err);
     +		if (ret) {
      			ret = error(_("failed to update ref '%s': %s"),
     -				    advance_name, transaction_err.buf);
    -+				    updates.items[i].refname, transaction_err.buf);
    ++				    result.updates[i].refname, transaction_err.buf);
      			goto cleanup;
      		}
      	}
    @@ builtin/replay.c: int cmd_replay(int argc,
      cleanup:
      	if (transaction)
      		ref_transaction_free(transaction);
    -+	replay_ref_updates_release(&updates);
    ++	replay_result_release(&result);
      	strbuf_release(&transaction_err);
      	strbuf_release(&reflog_msg);
      	release_revisions(&revs);
    @@ builtin/replay.c: int cmd_replay(int argc,
     -	if (ret < 0)
     -		exit(128);
     -	return ret ? 0 : 1;
    -+	return ret ? 1 : 0;
    ++	if (ret) {
    ++		if (result.merge_conflict)
    ++			return 1;
    ++		return 128;
    ++	}
    ++
    ++	return 0;
      }
2:  2b46a91628 ! 2:  fd63cca82f builtin/replay: move core logic into "libgit.a"
    @@ builtin/replay.c: static enum ref_action_mode get_ref_action_mode(struct reposit
     -	int contained;
     -};
     -
    --struct replay_ref_updates {
    +-struct replay_result {
     -	struct replay_ref_update {
     -		char *refname;
     -		struct object_id old_oid;
     -		struct object_id new_oid;
    --	} *items;
    --	size_t nr, alloc;
    +-	} *updates;
    +-	size_t updates_nr, updates_alloc;
    +-
    +-	bool merge_conflict;
     -};
     -
    --static void replay_ref_updates_release(struct replay_ref_updates *updates)
    +-static void replay_result_release(struct replay_result *result)
     -{
    --	for (size_t i = 0; i < updates->nr; i++)
    --		free(updates->items[i].refname);
    --	free(updates->items);
    +-	for (size_t i = 0; i < result->updates_nr; i++)
    +-		free(result->updates[i].refname);
    +-	free(result->updates);
    +-}
    +-
    +-static void replay_result_queue_update(struct replay_result *result,
    +-				       const char *refname,
    +-				       const struct object_id *old_oid,
    +-				       const struct object_id *new_oid)
    +-{
    +-	ALLOC_GROW(result->updates, result->updates_nr + 1, result->updates_alloc);
    +-	result->updates[result->updates_nr].refname = xstrdup(refname);
    +-	result->updates[result->updates_nr].old_oid = *old_oid;
    +-	result->updates[result->updates_nr].new_oid = *new_oid;
    +-	result->updates_nr++;
     -}
     -
     -static int replay_revisions(struct repository *repo, struct rev_info *revs,
     -			    struct replay_revisions_options *opts,
    --			    struct replay_ref_updates *updates)
    +-			    struct replay_result *out)
     -{
     -	kh_oid_map_t *replayed_commits = NULL;
     -	struct strset *update_refs = NULL;
    @@ builtin/replay.c: static enum ref_action_mode get_ref_action_mode(struct reposit
     -			if (decoration->type == DECORATION_REF_LOCAL &&
     -			    (opts->contained || strset_contains(update_refs,
     -								decoration->name))) {
    --				ALLOC_GROW(updates->items, updates->nr + 1, updates->alloc);
    --				updates->items[updates->nr].refname = xstrdup(decoration->name);
    --				updates->items[updates->nr].old_oid = commit->object.oid;
    --				updates->items[updates->nr].new_oid = last_commit->object.oid;
    --				updates->nr++;
    +-				replay_result_queue_update(out, decoration->name,
    +-							   &commit->object.oid,
    +-							   &last_commit->object.oid);
     -			}
     -			decoration = decoration->next;
     -		}
     -	}
     -
     -	if (!result.clean) {
    +-		out->merge_conflict = true;
     -		ret = -1;
     -		goto out;
     -	}
     -
     -	/* In --advance mode, advance the target ref */
    --	if (advance) {
    --		ALLOC_GROW(updates->items, updates->nr + 1, updates->alloc);
    --		updates->items[updates->nr].refname = xstrdup(advance);
    --		updates->items[updates->nr].old_oid = onto->object.oid;
    --		updates->items[updates->nr].new_oid = last_commit->object.oid;
    --		updates->nr++;
    --	}
    +-	if (advance)
    +-		replay_result_queue_update(out, advance,
    +-					   &onto->object.oid,
    +-					   &last_commit->object.oid);
     -
     -	ret = 0;
     -
    @@ replay.c (new)
     +	return create_commit(repo, result->tree, pickme, replayed_base);
     +}
     +
    -+void replay_ref_updates_release(struct replay_ref_updates *updates)
    ++void replay_result_release(struct replay_result *result)
     +{
    -+	for (size_t i = 0; i < updates->nr; i++)
    -+		free(updates->items[i].refname);
    -+	free(updates->items);
    ++	for (size_t i = 0; i < result->updates_nr; i++)
    ++		free(result->updates[i].refname);
    ++	free(result->updates);
    ++}
    ++
    ++static void replay_result_queue_update(struct replay_result *result,
    ++				       const char *refname,
    ++				       const struct object_id *old_oid,
    ++				       const struct object_id *new_oid)
    ++{
    ++	ALLOC_GROW(result->updates, result->updates_nr + 1, result->updates_alloc);
    ++	result->updates[result->updates_nr].refname = xstrdup(refname);
    ++	result->updates[result->updates_nr].old_oid = *old_oid;
    ++	result->updates[result->updates_nr].new_oid = *new_oid;
    ++	result->updates_nr++;
     +}
     +
     +int replay_revisions(struct repository *repo, struct rev_info *revs,
     +		     struct replay_revisions_options *opts,
    -+		     struct replay_ref_updates *updates)
    ++		     struct replay_result *out)
     +{
     +	kh_oid_map_t *replayed_commits = NULL;
     +	struct strset *update_refs = NULL;
    @@ replay.c (new)
     +			if (decoration->type == DECORATION_REF_LOCAL &&
     +			    (opts->contained || strset_contains(update_refs,
     +								decoration->name))) {
    -+				ALLOC_GROW(updates->items, updates->nr + 1, updates->alloc);
    -+				updates->items[updates->nr].refname = xstrdup(decoration->name);
    -+				updates->items[updates->nr].old_oid = commit->object.oid;
    -+				updates->items[updates->nr].new_oid = last_commit->object.oid;
    -+				updates->nr++;
    ++				replay_result_queue_update(out, decoration->name,
    ++							   &commit->object.oid,
    ++							   &last_commit->object.oid);
     +			}
     +			decoration = decoration->next;
     +		}
     +	}
     +
     +	if (!result.clean) {
    ++		out->merge_conflict = true;
     +		ret = -1;
     +		goto out;
     +	}
     +
     +	/* In --advance mode, advance the target ref */
    -+	if (advance) {
    -+		ALLOC_GROW(updates->items, updates->nr + 1, updates->alloc);
    -+		updates->items[updates->nr].refname = xstrdup(advance);
    -+		updates->items[updates->nr].old_oid = onto->object.oid;
    -+		updates->items[updates->nr].new_oid = last_commit->object.oid;
    -+		updates->nr++;
    -+	}
    ++	if (advance)
    ++		replay_result_queue_update(out, advance,
    ++					   &onto->object.oid,
    ++					   &last_commit->object.oid);
     +
     +	ret = 0;
     +
    @@ replay.h (new)
     +};
     +
     +/* This struct is used as an out-parameter by `replay_revisions()`. */
    -+struct replay_ref_updates {
    ++struct replay_result {
     +	/*
     +	 * The set of reference updates that are caused by replaying the
     +	 * commits.
    @@ replay.h (new)
     +		char *refname;
     +		struct object_id old_oid;
     +		struct object_id new_oid;
    -+	} *items;
    -+	size_t nr, alloc;
    ++	} *updates;
    ++	size_t updates_nr, updates_alloc;
    ++
    ++	/* Set to true in case the replay failed with a merge conflict. */
    ++	bool merge_conflict;
     +};
     +
    -+void replay_ref_updates_release(struct replay_ref_updates *updates);
    ++void replay_result_release(struct replay_result *result);
     +
     +/*
     + * Replay a set of commits onto a new location. Leaves both the working tree,
    @@ replay.h (new)
     + */
     +int replay_revisions(struct repository *repo, struct rev_info *revs,
     +		     struct replay_revisions_options *opts,
    -+		     struct replay_ref_updates *updates);
    ++		     struct replay_result *out);
     +
     +#endif
3:  881988bcfa = 3:  eb455cade1 replay: small set of cleanups
4:  197fa292c4 ! 4:  ccd323f6db replay: yield the object ID of the final rewritten commit
    @@ Commit message
     
      ## replay.c ##
     @@ replay.c: int replay_revisions(struct repository *repo, struct rev_info *revs,
    - 		updates->nr++;
    - 	}
    + 					   &onto->object.oid,
    + 					   &last_commit->object.oid);
      
    -+	updates->final_oid = last_commit->object.oid;
    ++	out->final_oid = last_commit->object.oid;
     +
      	ret = 0;
      
      out:
     
      ## replay.h ##
    -@@ replay.h: struct replay_ref_updates {
    - 		struct object_id new_oid;
    - 	} *items;
    - 	size_t nr, alloc;
    +@@ replay.h: struct replay_result {
    + 
    + 	/* Set to true in case the replay failed with a merge conflict. */
    + 	bool merge_conflict;
     +
     +	/*
     +	 * The final object ID that was rewritten. Note that this field has
    @@ replay.h: struct replay_ref_updates {
     +	struct object_id final_oid;
      };
      
    - void replay_ref_updates_release(struct replay_ref_updates *updates);
    + void replay_result_release(struct replay_result *result);
5:  91df8f3813 = 5:  a40034bcc1 wt-status: provide function to expose status for trees
6:  025e13874e ! 6:  4d566d6c43 builtin: add new "history" command
    @@ Commit message
         splitting up a commit into two are way more involved than that and
         require a whole series of commands.
     
    -    Another problem that rebases have is that dependent branches are not
    -    being updated. The use of stacked branches has grown quite common with
    -    competiting version control systems like Jujutsu though, so it clearly
    -    is a need that users have. While rebases _can_ serve this use case if
    -    one always works on the latest stacked branch, it is somewhat awkward
    -    and very easy to get wrong.
    +    Rebases also do not update dependent branches. The use of stacked
    +    branches has grown quite common with competing version control systems
    +    like Jujutsu though, so it clearly is a need that users have. While
    +    rebases _can_ serve this use case if one always works on the latest
    +    stacked branch, it is somewhat awkward and very easy to get wrong.
     
         Add a new "history" command to plug these gaps. This command will have
         several different subcommands to imperatively rewrite history for common
7:  b5cfe7da4e ! 7:  666fec826c builtin/history: implement "reword" subcommand
    @@ builtin/history.c
     +{
     +	const struct name_decoration *decoration;
     +	struct replay_revisions_options opts = { 0 };
    -+	struct replay_ref_updates updates = {
    ++	struct replay_result result = {
     +		.final_oid = rewritten->object.oid,
     +	};
     +	struct ref_transaction *transaction = NULL;
    @@ builtin/history.c
     +
     +	opts.onto = oid_to_hex_r(hex, &rewritten->object.oid);
     +
    -+	ret = replay_revisions(repo, &revs, &opts, &updates);
    ++	ret = replay_revisions(repo, &revs, &opts, &result);
     +	if (ret)
     +		goto out;
     +
    @@ builtin/history.c
     +			goto out;
     +		}
     +
    -+		for (size_t i = 0; i < updates.nr; i++) {
    ++		for (size_t i = 0; i < result.updates_nr; i++) {
     +			ret = ref_transaction_update(transaction,
    -+						     updates.items[i].refname,
    -+						     &updates.items[i].new_oid,
    -+						     &updates.items[i].old_oid,
    ++						     result.updates[i].refname,
    ++						     &result.updates[i].new_oid,
    ++						     &result.updates[i].old_oid,
     +						     NULL, NULL, 0, reflog_msg, &err);
     +			if (ret) {
     +				ret = error(_("failed to update ref '%s': %s"),
    -+					    updates.items[i].refname, err.buf);
    ++					    result.updates[i].refname, err.buf);
     +				goto out;
     +			}
     +		}
    @@ builtin/history.c
     +		break;
     +	case REF_ACTION_HEAD:
     +		ret = refs_update_ref(get_main_ref_store(repo), reflog_msg, "HEAD",
    -+				      &updates.final_oid, &head->object.oid, 0,
    ++				      &result.final_oid, &head->object.oid, 0,
     +				      UPDATE_REFS_MSG_ON_ERR);
     +		if (ret)
     +			goto out;
     +		break;
     +	case REF_ACTION_PRINT:
    -+		for (size_t i = 0; i < updates.nr; i++)
    ++		for (size_t i = 0; i < result.updates_nr; i++)
     +			printf("update %s %s %s\n",
    -+			       updates.items[i].refname,
    -+			       oid_to_hex(&updates.items[i].new_oid),
    -+			       oid_to_hex(&updates.items[i].old_oid));
    ++			       result.updates[i].refname,
    ++			       oid_to_hex(&result.updates[i].new_oid),
    ++			       oid_to_hex(&result.updates[i].old_oid));
     +		break;
     +	default:
     +		BUG("unsupported ref action %d", action);
    @@ builtin/history.c
     +	ret = 0;
     +
     +out:
    -+	replay_ref_updates_release(&updates);
     +	ref_transaction_free(transaction);
    ++	replay_result_release(&result);
     +	release_revisions(&revs);
     +	strbuf_release(&err);
     +	strvec_clear(&args);

---
base-commit: 02bdc12118c43e0a65258eb742492965859bffb6
change-id: 20250819-b4-pks-history-builtin-83398f9a05f0

