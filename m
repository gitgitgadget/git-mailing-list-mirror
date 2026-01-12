Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2924244675
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227434; cv=none; b=Q+db5XFZ044C1YMOpepLg+XVZlXBf30A8tu76Mn3DqSajtZh8T/DCmlWjcJVUXGLBClW8NVYJYTIEmjx6x/nNr6ItS1Eh6gb5M6IXgC6F6uSGTVPrjZ4+uPKBXtCSNEGZrvLuEeTNDITc7yx/8RKw0dwwkK9EaRvPac50MIvBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227434; c=relaxed/simple;
	bh=Sb10GAtg2PUJ2SpVHQ0rezdI5GHkN29wKfsAJLNUHuE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=DHQpsn3YdBfC0epqn9xwYEjkpcwQ0R2HPaQeEfIbhKzkICgv42c0GJqJapRuP+LDml5MI95oQlFQ+ckseOzmPaRXoY5vF7snTSv9ZJ0B+sPuFmIodLBYraPcO0VD+qt1huh+vsIuL9weatVBNheCtXX+SA9/nlot9GNZ0wYrf60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W1cIq1kx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=giV8sSU1; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W1cIq1kx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="giV8sSU1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D7BF2140004B;
	Mon, 12 Jan 2026 09:17:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 12 Jan 2026 09:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768227425;
	 x=1768313825; bh=Uy1WzeLE9gxgOHmd1ki89V2ogEdwe9FWKdSeHcjGISQ=; b=
	W1cIq1kxJxNWCSnye7qlBXj9LydZ8as4SqpM1kFj21dMKViRi90utfHdTmZZ8rPn
	HZQFXpTgo32vhjYnI/tfIKHBbA2e+f0rBCK7+W5wTNXnGeJ9K3ql4JFmCpY/TcZt
	TAG/mO3HfluuGeMbCSFUi/9DTz5iA0UfKQ63frr2cDxs2mCLPii3nxB77x2opwgR
	ufDP+/PEbQqdEIdsW3H0FotviGMChiTnX51KrhpebZpVtk6msHcEmdCUY8OxKaYs
	jwgkOa3gNEwI2Al+8OPmy4/J1LU0AOETzjZ8dRlSdf0kmJs85v4zr9Y7F7WDmkAK
	W9S87EHqsjSSy0kJNUN2sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768227425; x=
	1768313825; bh=Uy1WzeLE9gxgOHmd1ki89V2ogEdwe9FWKdSeHcjGISQ=; b=g
	iV8sSU1xbRQZkmkgKaORlqMVEZBwqy1l2c3JUVn+lBYA8Lzb+DK7bmeoESXhhS3Z
	NGZmD1PdgNhSvKMw4hrhZFd6SjKSm8vK9G0e/U7XD9iP6zjpkcJ9jpXWDaYatfas
	77pesHLLLGTn1evvQEZ4KqOXCHG9cn7CU8gv4k0/Ij3/QVy9oci47n9a6nDtGdjM
	TEUDOmeqe1BTFHNGoAow499JN/+zsFqAy5KCnZxmSZoDrhkdSh8SfJP+fS5DmJb5
	e1tbIWv8msb5B852IRrJpXsynFQRILzPVYF4G9V9lSnM+brRGnPJ9gb9Up/jYg5f
	ddSeYTblUkhe61P9aKFFg==
X-ME-Sender: <xms:YQJlacRxAXxp85RRGNkx5K-vG7bvEbAf5m1QL3a2VCS6Cv2DRyo-8Q>
    <xme:YQJlaVnztK67MWlh_ZAFTK4gCTtMCUZd-duoV2FmSHAeI8gkwL4JNQU-pWYeYAmrQ
    YLas-VJgnRNspq_NjNDGexWZFwuuUGdTawgWMtSP2lO5BUTWlYuEQ>
X-ME-Received: <xmr:YQJlaVPMCkIBqtm3GZik-30cLuIB6Pb7ZVXWoog1tztbwK4676D-moXL0bUaFmD_tvuAOi8qbF90WlnSVHcsKKy-x69AxIArqUJ68Uxz4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    grihhlsegsvgihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopehsiigvuggvrhdr
    uggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrges
    fhhrvggvrdhfrhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:YQJlaZjOXVsQBcRaiSHYHTm5i61ib2rb2bQE_Ggk17yju0G2zp8ggA>
    <xmx:YQJlaTgdOLnWNzFPhnE-UszRqD_ivbHS7hCydCqbcZtop0qLCTNjAw>
    <xmx:YQJlaYKSw_FyJxjKnmRgbSAOb5LxmR-IiSH-05ypkQ6k0bInf992JA>
    <xmx:YQJlaSk7VztXS1yii0GsA-eeWRSEIwY533vz_NyvZGiC47HLN2fRSg>
    <xmx:YQJlaQSeK3579LFvbUenGG5dG3yAL_9FMwHa40U44r9n8fMgWB0867cd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 09:17:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4627f0b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 14:17:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v10 0/8] Introduce git-history(1) command for easy history
 editing
Date: Mon, 12 Jan 2026 15:15:12 +0100
Message-Id: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPABZWkC/4XSzU7EIBAH8FfZcBYzw9eAJ9/DeGgLuETtbtq10
 Wz67sJGbTkQjzMZfsAfrmwOUwozezhc2RSWNKfTmAuEuwMbjt34EnjyucEECA0WHe8VP7/O/Jj
 my2n64v1HerukkVspnY2uAx2B5cXnKcT0eZOfnnP9M3/baMHS/ZdckAN3PdEghbE2hsc8dZ/eW
 fEWsTOEahqiGEZ1A4podO8rQ26Gg7Yhs1EmtNSoSOvKUH8GAmDTUNmwwaD3vTUSqTL0zhBtQ2e
 DrBcyaspxmMowe4OahsmGAvK+IJ2XlUGbIUA2DSqZBhetcn30UL+L/TUMILTPYbOBNjgiF2Qn6
 ru4vdH+H65kSsYgoEU1bMa6rt/lL03V2gIAAA==
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

Changes in v10:
  - Split out changes that make `replay_revisions()` handle empty
    revision ranges properly.
  - Drop redundant `struct repository` parameter in
    `replay_revisions()`.
  - Move around `die_for_incompatible_opt2()`.
  - Fix up some of the headers in "replay.c".
  - Split out the changes that make `replay_revisions()` handle empty
    revision ranges properly.
  - Create a separate commit that fixes updating detached HEAD.
  - Strip "encoding" header as we're reencoding commit messages.
  - Merge the logic to update refs in in `REF_ACTION_HEAD` and
    `REF_ACTION_BRANCHES` modes.
  - Link to v9: https://lore.kernel.org/r/20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im

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
Patrick Steinhardt (8):
      builtin/replay: extract core logic to replay revisions
      builtin/replay: move core logic into "libgit.a"
      replay: small set of cleanups
      replay: support empty commit ranges
      replay: support updating detached HEAD
      wt-status: provide function to expose status for trees
      builtin: add new "history" command
      builtin/history: implement "reword" subcommand

 .gitignore                     |   1 +
 Documentation/git-history.adoc |  73 +++++++
 Documentation/meson.build      |   1 +
 Makefile                       |   2 +
 builtin.h                      |   1 +
 builtin/history.c              | 427 +++++++++++++++++++++++++++++++++++++++++
 builtin/replay.c               | 382 ++++--------------------------------
 command-list.txt               |   1 +
 git.c                          |   1 +
 meson.build                    |   2 +
 replay.c                       | 372 +++++++++++++++++++++++++++++++++++
 replay.h                       |  64 ++++++
 t/meson.build                  |   2 +
 t/t3450-history.sh             |  17 ++
 t/t3451-history-reword.sh      | 391 +++++++++++++++++++++++++++++++++++++
 t/t3650-replay-basics.sh       |   9 +
 wt-status.c                    |  24 +++
 wt-status.h                    |   9 +
 18 files changed, 1434 insertions(+), 345 deletions(-)

Range-diff versus v9:

1:  0cae2364ee ! 1:  99b47e1af2 builtin/replay: extract core logic to replay revisions
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/replay.c ##
    -@@ builtin/replay.c: static enum ref_action_mode get_ref_action_mode(struct repository *repo, const c
    - 	return REF_ACTION_UPDATE;
    +@@ builtin/replay.c: static void set_up_replay_mode(struct repository *repo,
    + 	if (!rinfo.positive_refexprs)
    + 		die(_("need some commits to replay"));
    + 
    +-	die_for_incompatible_opt2(!!onto_name, "--onto",
    +-				  !!*advance_name, "--advance");
    ++	if (!(!!onto_name ^ !!*advance_name))
    ++		BUG("expected either onto_name or *advance_name in this function");
    ++
    + 	if (onto_name) {
    + 		*onto = peel_committish(repo, onto_name, "--onto");
    + 		if (rinfo.positive_refexprs <
    +@@ builtin/replay.c: static struct commit *pick_regular_commit(struct repository *repo,
    + 	return create_commit(repo, result->tree, pickme, replayed_base);
      }
      
     +struct replay_revisions_options {
    @@ builtin/replay.c: static enum ref_action_mode get_ref_action_mode(struct reposit
     +	result->updates_nr++;
     +}
     +
    -+static int replay_revisions(struct repository *repo, struct rev_info *revs,
    ++static int replay_revisions(struct rev_info *revs,
     +			    struct replay_revisions_options *opts,
     +			    struct replay_result *out)
     +{
    @@ builtin/replay.c: static enum ref_action_mode get_ref_action_mode(struct reposit
     +	int ret;
     +
     +	advance = xstrdup_or_null(opts->advance);
    -+	set_up_replay_mode(repo, &revs->cmdline, opts->onto, &advance,
    ++	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto, &advance,
     +			   &onto, &update_refs);
     +
     +	/* FIXME: Should allow replaying commits with the first as a root commit */
    @@ builtin/replay.c: static enum ref_action_mode get_ref_action_mode(struct reposit
     +		goto out;
     +	}
     +
    -+	init_basic_merge_options(&merge_opt, repo);
    ++	init_basic_merge_options(&merge_opt, revs->repo);
     +	memset(&result, 0, sizeof(result));
     +	merge_opt.show_rename_progress = 0;
     +	last_commit = onto;
    @@ builtin/replay.c: static enum ref_action_mode get_ref_action_mode(struct reposit
     +		if (commit->parents->next)
     +			die(_("replaying merge commits is not supported yet!"));
     +
    -+		last_commit = pick_regular_commit(repo, commit, replayed_commits,
    ++		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
     +						  onto, &merge_opt, &result);
     +		if (!last_commit)
     +			break;
    @@ builtin/replay.c: static enum ref_action_mode get_ref_action_mode(struct reposit
     +	return ret;
     +}
     +
    - static int handle_ref_update(enum ref_action_mode mode,
    - 			     struct ref_transaction *transaction,
    - 			     const char *refname,
    + static enum ref_action_mode parse_ref_action_mode(const char *ref_action, const char *source)
    + {
    + 	if (!ref_action || !strcmp(ref_action, "update"))
     @@ builtin/replay.c: int cmd_replay(int argc,
      	       const char *prefix,
      	       struct repository *repo)
    @@ builtin/replay.c: int cmd_replay(int argc,
     -				  contained, "--contained");
     +	die_for_incompatible_opt2(!!opts.advance, "--advance",
     +				  opts.contained, "--contained");
    ++	die_for_incompatible_opt2(!!opts.advance, "--advance",
    ++				  !!opts.onto, "--onto");
      
      	/* Parse ref action mode from command line or config */
      	ref_mode = get_ref_action_mode(repo, ref_action);
    @@ builtin/replay.c: int cmd_replay(int argc,
     -			   &onto, &update_refs);
     -
     -	/* FIXME: Should allow replaying commits with the first as a root commit */
    -+	ret = replay_revisions(repo, &revs, &opts, &result);
    ++	ret = replay_revisions(&revs, &opts, &result);
     +	if (ret)
     +		goto cleanup;
      
2:  c5fca546e5 ! 2:  0945b53ecb builtin/replay: move core logic into "libgit.a"
    @@ builtin/replay.c
     -	if (!rinfo.positive_refexprs)
     -		die(_("need some commits to replay"));
     -
    --	die_for_incompatible_opt2(!!onto_name, "--onto",
    --				  !!*advance_name, "--advance");
    +-	if (!(!!onto_name ^ !!*advance_name))
    +-		BUG("expected either onto_name or *advance_name in this function");
    +-
     -	if (onto_name) {
     -		*onto = peel_committish(repo, onto_name, "--onto");
     -		if (rinfo.positive_refexprs <
    @@ builtin/replay.c
     -	return create_commit(repo, result->tree, pickme, replayed_base);
     -}
     -
    - static enum ref_action_mode parse_ref_action_mode(const char *ref_action, const char *source)
    - {
    - 	if (!ref_action || !strcmp(ref_action, "update"))
    -@@ builtin/replay.c: static enum ref_action_mode get_ref_action_mode(struct repository *repo, const c
    - 	return REF_ACTION_UPDATE;
    - }
    - 
     -struct replay_revisions_options {
     -	const char *advance;
     -	const char *onto;
    @@ builtin/replay.c: static enum ref_action_mode get_ref_action_mode(struct reposit
     -	result->updates_nr++;
     -}
     -
    --static int replay_revisions(struct repository *repo, struct rev_info *revs,
    +-static int replay_revisions(struct rev_info *revs,
     -			    struct replay_revisions_options *opts,
     -			    struct replay_result *out)
     -{
    @@ builtin/replay.c: static enum ref_action_mode get_ref_action_mode(struct reposit
     -	int ret;
     -
     -	advance = xstrdup_or_null(opts->advance);
    --	set_up_replay_mode(repo, &revs->cmdline, opts->onto, &advance,
    +-	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto, &advance,
     -			   &onto, &update_refs);
     -
     -	/* FIXME: Should allow replaying commits with the first as a root commit */
    @@ builtin/replay.c: static enum ref_action_mode get_ref_action_mode(struct reposit
     -		goto out;
     -	}
     -
    --	init_basic_merge_options(&merge_opt, repo);
    +-	init_basic_merge_options(&merge_opt, revs->repo);
     -	memset(&result, 0, sizeof(result));
     -	merge_opt.show_rename_progress = 0;
     -	last_commit = onto;
    @@ builtin/replay.c: static enum ref_action_mode get_ref_action_mode(struct reposit
     -		if (commit->parents->next)
     -			die(_("replaying merge commits is not supported yet!"));
     -
    --		last_commit = pick_regular_commit(repo, commit, replayed_commits,
    +-		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
     -						  onto, &merge_opt, &result);
     -		if (!last_commit)
     -			break;
    @@ builtin/replay.c: static enum ref_action_mode get_ref_action_mode(struct reposit
     -	return ret;
     -}
     -
    - static int handle_ref_update(enum ref_action_mode mode,
    - 			     struct ref_transaction *transaction,
    - 			     const char *refname,
    + static enum ref_action_mode parse_ref_action_mode(const char *ref_action, const char *source)
    + {
    + 	if (!ref_action || !strcmp(ref_action, "update"))
     
      ## meson.build ##
     @@ meson.build: libgit_sources = [
    @@ replay.c (new)
     +#include "hex.h"
     +#include "merge-ort.h"
     +#include "object-name.h"
    -+#include "oidset.h"
    -+#include "parse-options.h"
     +#include "refs.h"
     +#include "replay.h"
     +#include "revision.h"
    ++#include "strmap.h"
     +#include "tree.h"
     +
     +static const char *short_commit_name(struct repository *repo,
    @@ replay.c (new)
     +	if (!rinfo.positive_refexprs)
     +		die(_("need some commits to replay"));
     +
    -+	die_for_incompatible_opt2(!!onto_name, "--onto",
    -+				  !!*advance_name, "--advance");
    ++	if (!(!!onto_name ^ !!*advance_name))
    ++		BUG("expected either onto_name or *advance_name in this function");
    ++
     +	if (onto_name) {
     +		*onto = peel_committish(repo, onto_name, "--onto");
     +		if (rinfo.positive_refexprs <
    @@ replay.c (new)
     +	result->updates_nr++;
     +}
     +
    -+int replay_revisions(struct repository *repo, struct rev_info *revs,
    ++int replay_revisions(struct rev_info *revs,
     +		     struct replay_revisions_options *opts,
     +		     struct replay_result *out)
     +{
    @@ replay.c (new)
     +	int ret;
     +
     +	advance = xstrdup_or_null(opts->advance);
    -+	set_up_replay_mode(repo, &revs->cmdline, opts->onto, &advance,
    ++	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto, &advance,
     +			   &onto, &update_refs);
     +
     +	/* FIXME: Should allow replaying commits with the first as a root commit */
    @@ replay.c (new)
     +		goto out;
     +	}
     +
    -+	init_basic_merge_options(&merge_opt, repo);
    ++	init_basic_merge_options(&merge_opt, revs->repo);
     +	memset(&result, 0, sizeof(result));
     +	merge_opt.show_rename_progress = 0;
     +	last_commit = onto;
    @@ replay.c (new)
     +		if (commit->parents->next)
     +			die(_("replaying merge commits is not supported yet!"));
     +
    -+		last_commit = pick_regular_commit(repo, commit, replayed_commits,
    ++		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
     +						  onto, &merge_opt, &result);
     +		if (!last_commit)
     +			break;
    @@ replay.h (new)
     + *
     + * Returns 0 on success, a negative error code otherwise.
     + */
    -+int replay_revisions(struct repository *repo, struct rev_info *revs,
    ++int replay_revisions(struct rev_info *revs,
     +		     struct replay_revisions_options *opts,
     +		     struct replay_result *out);
     +
3:  1d55aab054 = 3:  85ebe5853f replay: small set of cleanups
4:  451717f951 < -:  ---------- replay: yield the object ID of the final rewritten commit
-:  ---------- > 4:  a24641dbfb replay: support empty commit ranges
-:  ---------- > 5:  e0ab803a46 replay: support updating detached HEAD
5:  7cde288c8d = 6:  abc33b25ca wt-status: provide function to expose status for trees
6:  b315c04169 ! 7:  387d1ded10 builtin: add new "history" command
    @@ Documentation/git-history.adoc (new)
     +your commit history that is simpler to use compared to linkgit:git-rebase[1] in
     +general.
     +
    -+If you want to reapply a range of commits onto a different base, or interactive
    -+rebases if you want to edit a range of commits.
    ++Use linkgit:git-rebase[1] if you want to reapply a range of commits onto a
    ++different base, or interactive rebases if you want to edit a range of commits
    ++at once.
     +
     +LIMITATIONS
     +-----------
    @@ Documentation/git-history.adoc (new)
     +COMMANDS
     +--------
     +
    -+Several commands are available to rewrite history in different ways:
    ++No commands are supported yet.
     +
     +GIT
     +---
7:  f71911586d ! 8:  aeb895475b builtin/history: implement "reword" subcommand
    @@ Commit message
             rewritten. This especially helps with workflows that use stacked
             branches.
     
    +    Helped-by: Elijah Newren <newren@gmail.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Documentation/git-history.adoc ##
    @@ Documentation/git-history.adoc: git-history - EXPERIMENTAL: Rewrite history
      
      DESCRIPTION
      -----------
    -@@ Documentation/git-history.adoc: Overall, linkgit:git-history[1] aims to provide a more opinionated way to modify
    - your commit history that is simpler to use compared to linkgit:git-rebase[1] in
    - general.
    - 
    --If you want to reapply a range of commits onto a different base, or interactive
    --rebases if you want to edit a range of commits.
    -+Use linkgit:git-rebase[1] if you want to reapply a range of commits onto a
    -+different base, or interactive rebases if you want to edit a range of commits
    -+at once.
    - 
    - LIMITATIONS
    - -----------
    -@@ Documentation/git-history.adoc: COMMANDS
    - 
    - Several commands are available to rewrite history in different ways:
    +@@ Documentation/git-history.adoc: first-class conflicts.
    + COMMANDS
    + --------
      
    +-No commands are supported yet.
    ++The following commands are available to rewrite history in different ways:
    ++
     +`reword <commit>`::
     +	Rewrite the commit message of the specified commit. All the other
     +	details of this commit remain unchanged. This command will spawn an
    @@ Documentation/git-history.adoc: COMMANDS
     +`--ref-action=(branches|head|print)`::
     +	Control which references will be updated by the command, if any. With
     +	`branches`, all local branches that point to commits which are
    -+	decendants of the original commit will be rewritten. With `head`, only
    ++	descendants of the original commit will be rewritten. With `head`, only
     +	the current `HEAD` reference will be rewritten. With `print`, all
     +	updates as they would be performed with `branches` are printed in a
     +	format that can be consumed by linkgit:git-update-ref[1].
    -+
    + 
      GIT
      ---
    - Part of the linkgit:git[1] suite
     
      ## builtin/history.c ##
     @@
    @@ builtin/history.c
     +					   struct commit *original,
     +					   struct commit **out)
     +{
    -+	const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
    ++	const char *exclude_gpgsig[] = {
    ++		/* We reencode the message, so the encoding needs to be stripped. */
    ++		"encoding",
    ++		/* We need to strip signatures as those will become invalid. */
    ++		"gpgsig",
    ++		"gpgsig-sha256",
    ++		NULL,
    ++	};
     +	const char *original_message, *original_body, *ptr;
     +	struct commit_extra_header *original_extra_headers = NULL;
     +	struct strbuf commit_message = STRBUF_INIT;
    @@ builtin/history.c
     +{
     +	const struct name_decoration *decoration;
     +	struct replay_revisions_options opts = { 0 };
    -+	struct replay_result result = {
    -+		.final_oid = rewritten->object.oid,
    -+	};
    ++	struct replay_result result = { 0 };
     +	struct ref_transaction *transaction = NULL;
     +	struct strvec args = STRVEC_INIT;
     +	struct strbuf err = STRBUF_INIT;
     +	struct commit *head = NULL;
     +	struct rev_info revs;
     +	char hex[GIT_MAX_HEXSZ + 1];
    ++	bool detached_head;
    ++	int head_flags = 0;
     +	int ret;
     +
    ++	refs_read_ref_full(get_main_ref_store(repo), "HEAD",
    ++			   RESOLVE_REF_NO_RECURSE, NULL, &head_flags);
    ++	detached_head = !(head_flags & REF_ISSYMREF);
    ++
     +	repo_init_revisions(repo, &revs, NULL);
     +	strvec_push(&args, "ignored");
     +	strvec_push(&args, "--reverse");
    @@ builtin/history.c
     +			goto out;
     +		}
     +
    -+		strvec_push(&args, oid_to_hex(&head->object.oid));
    ++		strvec_push(&args, "HEAD");
     +	} else {
     +		strvec_push(&args, "--branches");
    ++		strvec_push(&args, "HEAD");
     +	}
     +
     +	setup_revisions_from_strvec(&args, &revs, NULL);
    @@ builtin/history.c
     +
     +	opts.onto = oid_to_hex_r(hex, &rewritten->object.oid);
     +
    -+	ret = replay_revisions(repo, &revs, &opts, &result);
    ++	ret = replay_revisions(&revs, &opts, &result);
     +	if (ret)
     +		goto out;
     +
     +	switch (action) {
    -+	case REF_ACTION_DEFAULT:
     +	case REF_ACTION_BRANCHES:
    ++	case REF_ACTION_HEAD:
     +		transaction = ref_store_transaction_begin(get_main_ref_store(repo), 0, &err);
     +		if (!transaction) {
     +			ret = error(_("failed to begin ref transaction: %s"), err.buf);
    @@ builtin/history.c
     +		     decoration;
     +		     decoration = decoration->next)
     +		{
    -+			if (decoration->type != DECORATION_REF_LOCAL)
    ++			if (decoration->type != DECORATION_REF_LOCAL &&
    ++			    decoration->type != DECORATION_REF_HEAD)
    ++				continue;
    ++
    ++			if (action == REF_ACTION_HEAD &&
    ++			    decoration->type != DECORATION_REF_HEAD)
    ++				continue;
    ++
    ++			/*
    ++			 * We only need to update HEAD separately in case it's
    ++			 * detached. If it's not we'd already update the branch
    ++			 * it is pointing to.
    ++			 */
    ++			if (action == REF_ACTION_BRANCHES &&
    ++			    decoration->type == DECORATION_REF_HEAD &&
    ++			    !detached_head)
     +				continue;
     +
     +			ret = ref_transaction_update(transaction,
    @@ builtin/history.c
     +		}
     +
     +		break;
    -+	case REF_ACTION_HEAD:
    -+		ret = refs_update_ref(get_main_ref_store(repo), reflog_msg, "HEAD",
    -+				      &result.final_oid, &head->object.oid, 0,
    -+				      UPDATE_REFS_MSG_ON_ERR);
    -+		if (ret)
    -+			goto out;
    -+		break;
     +	case REF_ACTION_PRINT:
     +		for (size_t i = 0; i < result.updates_nr; i++)
     +			printf("update %s %s %s\n",
    @@ builtin/history.c
     +	}
     +	repo_config(repo, git_default_config, NULL);
     +
    ++	if (action == REF_ACTION_DEFAULT)
    ++		action = REF_ACTION_BRANCHES;
    ++
     +	original = lookup_commit_reference_by_name(argv[0]);
     +	if (!original) {
     +		ret = error(_("commit cannot be found: %s"), argv[0]);
    @@ builtin/history.c
     +	return fn(argc, argv, prefix, repo);
      }
     
    - ## replay.c ##
    -@@ replay.c: int replay_revisions(struct repository *repo, struct rev_info *revs,
    - 	struct commit *commit;
    - 	struct commit *onto = NULL;
    - 	struct merge_options merge_opt;
    --	struct merge_result result;
    -+	struct merge_result result = {
    -+		.clean = 1,
    -+	};
    - 	char *advance;
    - 	int ret;
    - 
    -@@ replay.c: int replay_revisions(struct repository *repo, struct rev_info *revs,
    - 	}
    - 
    - 	init_basic_merge_options(&merge_opt, repo);
    --	memset(&result, 0, sizeof(result));
    - 	merge_opt.show_rename_progress = 0;
    - 	last_commit = onto;
    - 	replayed_commits = kh_init_oid_map();
    -
      ## t/meson.build ##
     @@ t/meson.build: integration_tests = [
        't3437-rebase-fixup-options.sh',
    @@ t/t3451-history-reword.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'can reword commit in the middle even on detached head' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit first &&
    ++		test_commit second &&
    ++		test_commit third_on_main &&
    ++		git checkout --detach HEAD^ &&
    ++		test_commit third_on_head &&
    ++
    ++		reword_with_message HEAD~ <<-EOF &&
    ++		second reworded
    ++		EOF
    ++
    ++		expect_graph HEAD --branches <<-\EOF
    ++		* third_on_head
    ++		| * third_on_main
    ++		|/
    ++		* second reworded
    ++		* first
    ++		EOF
    ++       )
    ++'
    ++
    ++test_expect_success 'can reword the detached head' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit first &&
    ++		test_commit second &&
    ++		git checkout --detach HEAD &&
    ++		test_commit third &&
    ++
    ++		reword_with_message HEAD <<-EOF &&
    ++		third reworded
    ++		EOF
    ++
    ++		expect_log <<-\EOF
    ++		third reworded
    ++		second
    ++		first
    ++		EOF
    ++	)
    ++'
    ++
     +test_expect_success 'can reword root commit' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&

---
base-commit: 02bdc12118c43e0a65258eb742492965859bffb6
change-id: 20250819-b4-pks-history-builtin-83398f9a05f0

