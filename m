Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5604A37FF79
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298084; cv=none; b=Ur3dSJ5HMsmXCM5Ei/2gbI6KgraaasTuTv5wVDSeMJkreXqAw1Bk2YPfmbuc+i6QX83lsWMNtcAQTN2N3wefj6ELKDMPD/JGoiQsmmQbbgsnzirRbLn3s7/Xad3bQzgZ9Ax9nMdWmZjE96k1fjcDVcMk7GEDOhpNptKQomZZADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298084; c=relaxed/simple;
	bh=HFyAydZunKDlbZvMrty8yh+JNQrvebAekbzOyyHBIQg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=WL+zaS8Ix2NwLelI4IYyevXctA5PUCCmJ4QZUN3jvNrlvOcwZeh4hMBbh3PHqyWqBwBk58v+6ivfKL1s9ar61JGGq3yyC0nzXg57JzkRSCd+u41xGkKSgHdMu/OO50X9aFKrRvUvWfXN75bPVK2y2z3rNkY8s1yH9KX5WoiqM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UDvgwaeg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mh0oMUVy; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UDvgwaeg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mh0oMUVy"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 318541400163;
	Tue, 13 Jan 2026 04:54:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 13 Jan 2026 04:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768298080;
	 x=1768384480; bh=eV9YivnpKe1e+PQckxXJG/VB/8BQLXkqUgVs1PfGyU0=; b=
	UDvgwaeg/51yYa1MuPM2c7/Wo/TBUVbhpd4tRlguEWkdPkZS2LHfH7J1P1N/6QZZ
	mpNyICQoNITeXo4+NrLDlIVmO0IZwNCjYuSfW5pkIOGx5UCdMhtkihSQHEN+x3/v
	lAVDhPZrZ2UodxNgPJZx5oJYrjkSAoXO0yfIi3/SeGaG3eTTKWCfN0U94/Jk4fu0
	DHEp3MORaXYDOcBzHSsj6p5IPdB85gVazNd8qYm4Z5J04NPTJgc0bevFShiP4rcf
	8cc4BfKN1ESnv45ghPx3HdvUOLVrsZViT2O1ifXN4w5gTogAKGXRbnTBPqiRvTgQ
	EwM7gXRrpfTWkw7+9JJGlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768298080; x=
	1768384480; bh=eV9YivnpKe1e+PQckxXJG/VB/8BQLXkqUgVs1PfGyU0=; b=M
	h0oMUVyCsAmRkGHqgKRtu6VGrqpBt4Uwg5M9XbQKntzZdrKipuQo1OKeC0bOaHuk
	Y1RYw/sfqB6e2y0Hm4Yj6KQ8EB3tBw/LPaFeoB4sLD7BDTPDIDjbzIaFKiAyA3T0
	5yfgDczR3Wkc1WLRs9N5A1myey583GD8plLqiVOdN0J+CCLfTsmHq3GXIgzjwXDu
	8Qsy8eWxL+pqOgZgb+uL6xauyY8IQk//sc0CvmIXYJOCJQfl0W+lv2+mAPcN5oM2
	bickK9PPtPIehCHP2A/97Bx+dcTTcoHH6PWYHt6ZTYmkr6CAYj4hwJbFW3OfGcIi
	g+/o5fI1lCqRildADJtZw==
X-ME-Sender: <xms:XxZmaeN23fEp2pZBoThkjKkE6-AoA7cLPcyb376Wnuo_uVJiz2rXxg>
    <xme:XxZmaYz7kCRVuuwuKZNTCsbkzrWhpa2_3NL72bLQCEgqS-YO-p0TpbXG-sYcdB-_8
    Z_k-MJ90AYEpkYBeqmhFCCPryDh_ezE2M_bhmef8NtNvCGkMAiOZS8>
X-ME-Received: <xmr:XxZmaQocHOlh1Vm41GlDfY7IROJ4C6JmfYqxJWQOxbmwJ4IuMDlqlePOprErJpvcyAl1MDiWygEXMKSCWubUl27UgDXgYi8dt_w1fo9RtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddttdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmrghilhessggvhigv
    rhhmrghtthhhihgrshdruggvpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:XxZmaYMpDzpS0rZsl89YmT8owN1GlDv0rrkUU1Wuj-m4Hl9RvQbrbg>
    <xmx:XxZmaUf1Dn18GwrEqxDeJMdxByOc9k786IQmA4E-kKDAGVDIOT5d9Q>
    <xmx:XxZmaeUKL4rijQc39JsxwZ1EHOXNlR_4IYS-oAZy09JPfeL09tGS_g>
    <xmx:XxZmaVBvhoTkIBLjqw60biSkKoVznOmhwm6U99fKn2TZz1-HSVFYjA>
    <xmx:YBZmaXNzuscYOUlRd8079h6g_EWCzcP9Ic11HnW0U_2eKmTC2oFQV0Ib>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 04:54:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fdcebd97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 09:54:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v11 0/8] Introduce git-history(1) command for easy history
 editing
Date: Tue, 13 Jan 2026 10:54:31 +0100
Message-Id: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFcWZmkC/4XSS04DMQwA0KtUWRNk55+uuAdikS+NgLaaKSNQ1
 buTVNBOFhFLW85L7PhM5jSVNJPt5kymtJS5HPY1QHzYkLBz+9dES6wJwoBJMGipF/T4NtNdmU+
 H6Zv6z/J+KntqOLcmWwcyA6mHj1PK5esqP7/U+Lf+etGCLfsvuSAFar3WgTNlTE5PteqxfJDmL
 WxlMDE0WDOUcAFZVtLHzuB3w8LY4NVoFZJLFFrKzhA3AwFwaIhqmKQwRm8UR90ZcmWwsSGroU1
 kPEtdx6E6Q60NPTRUNQToGBviIu8MfTcY8KGh20yTzUZYnyP0/2L+DAUI43eYaqBJVmubuGN9L
 3ZtjPfDtplqpRDQoAi9gbBCkI2XDKqSeFDOSS9CCjflcrn8ANRERe0gAwAA
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

Changes in v11:
  - Fix overly clever `BUG()` condition.
  - Drop the `struct replay_result::merge_conflict` field.
  - Return a positive value from `replay_revisions()` in case there was
    a conflict.
  - Improve a commit message.
  - Fix check for whether `setup_revisions_from_strvec()` was
    successful.
  - Link to v10: https://lore.kernel.org/r/20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im

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
 builtin/replay.c               | 373 +++--------------------------------
 command-list.txt               |   1 +
 git.c                          |   1 +
 meson.build                    |   2 +
 replay.c                       | 371 +++++++++++++++++++++++++++++++++++
 replay.h                       |  61 ++++++
 t/meson.build                  |   2 +
 t/t3450-history.sh             |  17 ++
 t/t3451-history-reword.sh      | 391 +++++++++++++++++++++++++++++++++++++
 t/t3650-replay-basics.sh       |   9 +
 wt-status.c                    |  24 +++
 wt-status.h                    |   9 +
 18 files changed, 1425 insertions(+), 341 deletions(-)

Range-diff versus v10:

1:  f02aa5abd1 ! 1:  bdefcad12d builtin/replay: extract core logic to replay revisions
    @@ builtin/replay.c: static void set_up_replay_mode(struct repository *repo,
      
     -	die_for_incompatible_opt2(!!onto_name, "--onto",
     -				  !!*advance_name, "--advance");
    -+	if (!(!!onto_name ^ !!*advance_name))
    -+		BUG("expected either onto_name or *advance_name in this function");
    ++	if (!onto_name == !*advance_name)
    ++		BUG("one and only one of onto_name and *advance_name must be given");
     +
      	if (onto_name) {
      		*onto = peel_committish(repo, onto_name, "--onto");
    @@ builtin/replay.c: static struct commit *pick_regular_commit(struct repository *r
     +		struct object_id new_oid;
     +	} *updates;
     +	size_t updates_nr, updates_alloc;
    -+
    -+	bool merge_conflict;
     +};
     +
     +static void replay_result_release(struct replay_result *result)
    @@ builtin/replay.c: static struct commit *pick_regular_commit(struct repository *r
     +	}
     +
     +	if (!result.clean) {
    -+		out->merge_conflict = true;
    -+		ret = -1;
    ++		ret = 1;
     +		goto out;
     +	}
     +
    @@ builtin/replay.c: int cmd_replay(int argc,
     -		free(update_refs);
     -	}
     -	ret = result.clean;
    --
    ++	ret = 0;
    + 
      cleanup:
      	if (transaction)
      		ref_transaction_free(transaction);
    @@ builtin/replay.c: int cmd_replay(int argc,
      	release_revisions(&revs);
     -	free(advance_name);
      
    --	/* Return */
    --	if (ret < 0)
    --		exit(128);
    + 	/* Return */
    + 	if (ret < 0)
    + 		exit(128);
     -	return ret ? 0 : 1;
    -+	if (ret) {
    -+		if (result.merge_conflict)
    -+			return 1;
    -+		return 128;
    -+	}
    -+
    -+	return 0;
    ++	return ret;
      }
2:  078d713391 ! 2:  80eaf3f9fd builtin/replay: move core logic into "libgit.a"
    @@ builtin/replay.c
     -	if (!rinfo.positive_refexprs)
     -		die(_("need some commits to replay"));
     -
    --	if (!(!!onto_name ^ !!*advance_name))
    --		BUG("expected either onto_name or *advance_name in this function");
    +-	if (!onto_name == !*advance_name)
    +-		BUG("one and only one of onto_name and *advance_name must be given");
     -
     -	if (onto_name) {
     -		*onto = peel_committish(repo, onto_name, "--onto");
    @@ builtin/replay.c
     -		struct object_id new_oid;
     -	} *updates;
     -	size_t updates_nr, updates_alloc;
    --
    --	bool merge_conflict;
     -};
     -
     -static void replay_result_release(struct replay_result *result)
    @@ builtin/replay.c
     -	}
     -
     -	if (!result.clean) {
    --		out->merge_conflict = true;
    --		ret = -1;
    +-		ret = 1;
     -		goto out;
     -	}
     -
    @@ replay.c (new)
     +	if (!rinfo.positive_refexprs)
     +		die(_("need some commits to replay"));
     +
    -+	if (!(!!onto_name ^ !!*advance_name))
    -+		BUG("expected either onto_name or *advance_name in this function");
    ++	if (!onto_name == !*advance_name)
    ++		BUG("one and only one of onto_name and *advance_name must be given");
     +
     +	if (onto_name) {
     +		*onto = peel_committish(repo, onto_name, "--onto");
    @@ replay.c (new)
     +	}
     +
     +	if (!result.clean) {
    -+		out->merge_conflict = true;
    -+		ret = -1;
    ++		ret = 1;
     +		goto out;
     +	}
     +
    @@ replay.h (new)
     +		struct object_id new_oid;
     +	} *updates;
     +	size_t updates_nr, updates_alloc;
    -+
    -+	/* Set to true in case the replay failed with a merge conflict. */
    -+	bool merge_conflict;
     +};
     +
     +void replay_result_release(struct replay_result *result);
    @@ replay.h (new)
     + * index and references untouched. Reference updates caused by the replay will
     + * be recorded in the `updates` out pointer.
     + *
    -+ * Returns 0 on success, a negative error code otherwise.
    ++ * Returns 0 on success, 1 on conflict and a negative error code otherwise.
     + */
     +int replay_revisions(struct rev_info *revs,
     +		     struct replay_revisions_options *opts,
3:  44f96f6b93 = 3:  bd6783570b replay: small set of cleanups
4:  0c861b1a37 ! 4:  e927f66224 replay: support empty commit ranges
    @@ Commit message
     
         In a subsequent commit we're about to introduce a new user of the replay
         subsystem. With that new user, the range of commits that we'll want to
    -    replay will be identified implicitly via "HEAD". With such implicit
    -    ranges it becomes likely that the range of revisions that we're asked to
    -    replay becomes empty. This case does not make sense with git-replay(1),
    -    but with the new command it will.
    +    replay will be identified implicitly via a single commit, and will
    +    include all descendants of that commit to any branch. If that commit has
    +    no descendants (because it's the tip of some branch), then the range of
    +    revisions that we're asked to replay becomes empty. This case does not
    +    make sense with git-replay(1), but with the new command it will.
     
         This case is not currently supported by `replay_revisions()` though
         because we zero-initialize `struct merge_result`. This includes its
5:  03a64727ab = 5:  c8ed32bfae replay: support updating detached HEAD
6:  453a5769a6 = 6:  79f8bf7613 wt-status: provide function to expose status for trees
7:  f73ad9a468 = 7:  d0d56cc4fc builtin: add new "history" command
8:  e7af330353 ! 8:  464f5467ab builtin/history: implement "reword" subcommand
    @@ builtin/history.c
     +	}
     +
     +	setup_revisions_from_strvec(&args, &revs, NULL);
    -+	if (revs.nr)
    -+		BUG("revisions were set up with invalid argument '%s'", args.v[0]);
    ++	if (args.nr != 1)
    ++		BUG("revisions were set up with invalid argument");
     +
     +	opts.onto = oid_to_hex_r(hex, &rewritten->object.oid);
     +

---
base-commit: 02bdc12118c43e0a65258eb742492965859bffb6
change-id: 20250819-b4-pks-history-builtin-83398f9a05f0

