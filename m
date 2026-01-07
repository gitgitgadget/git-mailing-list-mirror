Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F8630F92E
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780623; cv=none; b=aAZapfFINZ2PBmUwhzBYKSNZ8kb/w/8REjrqXAtYJS2zeBJFa/AKig0kN2jr1vK5f4NDBpSW9dTiBzxW+jSA8WBja3Ng7mOiFViw27MDdTyPF4fItajSmf2bJCkN25VsQfrjmQom6Y8497YuDhm6VE+oZKdbxocW71NjTss3V0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780623; c=relaxed/simple;
	bh=2KqzHH00Su54WROK8kOyK/fghtjmQFsD8BOt1aAur3U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ZNFvkBanr/BGYIw9tNUKMgjPZLEg+/tfXoymsrm/5q5TYxw4TLbOyC23huNAx4sE8S5CVE3YwowadMEMZpzB6CmJQmA4jmlkUmozGV/UpOrceedoPU9VR8M3hE3MYyB/4SUXSOie7Lge1dmpXXrcTWzlT/8fdWqjjjlVHlWLb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZCExHXvA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xqHgHeTy; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZCExHXvA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xqHgHeTy"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E02AFEC0233;
	Wed,  7 Jan 2026 05:10:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 07 Jan 2026 05:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767780617;
	 x=1767867017; bh=V77DxkWG/w4uF2CpdjHcSt202YzwieazLzPubaxRCzM=; b=
	ZCExHXvA5ZdsRi1NHcsZMLwGFIq2t+cpeH/mtrcuyKoV+uW7MZN5TkCPac+76TvB
	3/Or4a7nvhOVDNgVsJq80qfUopKx9EjFa/EH/bOFdPe9kU2dRnQcRyFYuCdk7NoO
	nFaUXNLNxPmN+NHEC51P7TgfbaMoUPRqwqEqsdubAxvuXZbo1sRmg35xKz8EoVLj
	Za6UoyAkewbJu+etMEm0Dj6fq4dIp52mIQ3MQ0StUWWTrtGfMBp37S30QxTeZ86R
	bds4rfC7ygu9ZkMlgpJa2v+L57lUh+G2ux9Zz8R960F2v38fs4yBomniTZ/4clzo
	JFr5XmDb0eXdavFsd5avWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767780617; x=
	1767867017; bh=V77DxkWG/w4uF2CpdjHcSt202YzwieazLzPubaxRCzM=; b=x
	qHgHeTyDbBKsEbQKCr3k54Uj1pvsfsuGKrZy7WH9ypiVVPP4upeUDti/X3675FoP
	6tC1910xkHJH2L2GnObum9KeXdw0tCTUqro+1XjnCHapnXPMvpEI3ZTDtb2yDaDr
	7wqUGZog3spHIRA7SO5XJdOF6Tptuktgibu+heaATqs7NZkYKPR9QXCbJ3604Myn
	Dt5I6Di1sDx9nSfi/8X2IPtuq20hTEkfbQqcAPvar9RXzaKYYpJeeuCdGp++1YY4
	XYlSRFwRRdPqHiY2n3dfG/8yFUcXHqRfj4tyuoUjWFBWOOTZw59+wSiGwmhlkJqc
	pxpJKmbvLddzP3u2tD20A==
X-ME-Sender: <xms:CTFead2OyPU6jw0klIIpv7rIY9Zj_8VDlCMpa_nfFc7DzOtlQNgJZg>
    <xme:CTFeaf7MrO1vOwsxAIELpJNx3r4zmfSq0SYX5245gg9nD4_9kktpUGNKPihwZjWor
    d4nCF1lPnxG1GhuSIf21JtyC_GHE5tbnwQUaVHILaDhBtef0Cw3lA>
X-ME-Received: <xmr:CTFeaZS1OHlqO7LeyNxMPHpm6-vHlDDMshhE1AuUg_H4N0Gfn2h6Tdv_mK_qGD3m2LQn0jKGJQ0__nCocchCxx5VQVcfhqSJ3tUXEAv-y2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    rhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhn
    iiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepmhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvg
X-ME-Proxy: <xmx:CTFeaUWFZn-0XJuQIf-tNyi36DD1a1EeWMMr-ev849QW20ciGWgbDA>
    <xmx:CTFeaeFSiVI5WNuZ8Z9Q8o1sVJUvWVnU0ffQ7F8HPaBydp_v0m0qXg>
    <xmx:CTFeaXdBWTVpl-xPTbKQKi51rMipJdS6MMY_Ly7BGNhAnLyCeNcklA>
    <xmx:CTFeaXrXHj0H31SDm_a4IjZ01we0YH-5k2qPkJhSP40evVnOm6IbnQ>
    <xmx:CTFeaU0JpBmkLRRbVieVCb9Ufdiw2rKXRiCHJGXsoWF1g-WAhQ0zpqvK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 05:10:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ad8634b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 10:10:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v8 0/7] Introduce git-history(1) command for easy history
 editing
Date: Wed, 07 Jan 2026 11:10:08 +0100
Message-Id: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAxXmkC/4XRz07EIBAG8FfZcBYzDP/35HsYD6WAS9TupqyNZ
 tN3FzbGlgPx+JGP3yQzN5LDnEImx8ONzGFJOZ2nEszDgYynYXoNNPmSCQJKMMxSJ+jlLdNTytf
 z/E3dZ3q/pokazq2JdgAZgZTPlznE9HWHn19K/u3f5yysvv5LLowCtU7rkaMyJoan0npMH6R6C
 +4MFF0Dq6HEMDKMSjrfGHwzLPQNXozakFwyoaVsDPFnMADWNUQxTFDMe2cUZ7ox5M7AviGLoY1
 HHqUu61CNofaG7hqqGAK09xUZPG8MvRkIvGvoutNgoxHWRQ/bXdZ1/QHu5nuyUQIAAA==
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
 builtin/replay.c               | 374 +++-----------------------------------
 command-list.txt               |   1 +
 git.c                          |   1 +
 meson.build                    |   2 +
 replay.c                       | 347 +++++++++++++++++++++++++++++++++++
 replay.h                       |  77 ++++++++
 t/meson.build                  |   2 +
 t/t3450-history.sh             |  17 ++
 t/t3451-history-reword.sh      | 344 +++++++++++++++++++++++++++++++++++
 wt-status.c                    |  24 +++
 wt-status.h                    |   9 +
 17 files changed, 1335 insertions(+), 345 deletions(-)

Range-diff versus v7:

 -:  ---------- >  1:  53a845e874 builtin/replay: extract core logic to replay revisions
 -:  ---------- >  2:  3ff1c0bacf builtin/replay: move core logic into "libgit.a"
 -:  ---------- >  3:  598df4e186 replay: small set of cleanups
 -:  ---------- >  4:  fd6a0ec5b8 replay: yield the object ID of the final rewritten commit
 1:  0e2d8db69f =  5:  04b832320f wt-status: provide function to expose status for trees
 2:  087c563575 <  -:  ---------- replay: extract logic to pick commits
 3:  4ab2a6f807 <  -:  ---------- replay: stop using `the_repository`
 4:  d2138e95d4 !  6:  e223659b86 builtin: add new "history" command
    @@ Commit message
     
         While these operations are all doable, it often feels needlessly kludgey
         to do so by doing an interactive rebase, using the editor to say what
    -    one wants, and then perform the actions. Furthermore, some operations
    -    like splitting up a commit into two are way more involved than that and
    +    one wants, and then perform the actions. Also, some operations like
    +    splitting up a commit into two are way more involved than that and
         require a whole series of commands.
     
    -    Add a new "history" command to plug this gap. This command will have
    +    Another problem that rebases have is that dependent branches are not
    +    being updated. The use of stacked branches has grown quite common with
    +    competiting version control systems like Jujutsu though, so it clearly
    +    is a need that users have. While rebases _can_ serve this use case if
    +    one always works on the latest stacked branch, it is somewhat awkward
    +    and very easy to get wrong.
    +
    +    Add a new "history" command to plug these gaps. This command will have
         several different subcommands to imperatively rewrite history for common
    -    use cases like the above. Some of these subcommands will be implemented
    -    in subsequent commits.
    +    use cases like the above.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ Documentation/git-history.adoc (new)
     +
     +NAME
     +----
    -+git-history - EXPERIMENTAL: Rewrite history of the current branch
    ++git-history - EXPERIMENTAL: Rewrite history
     +
     +SYNOPSIS
     +--------
    @@ Documentation/git-history.adoc (new)
     +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
     +
     +This command is related to linkgit:git-rebase[1] in that both commands can be
    -+used to rewrite history. You should use rebases if you want to reapply a range
    -+of commits onto a different base, or interactive rebases if you want to edit a
    -+range of commits.
    ++used to rewrite history. There are a couple of major differences though:
    ++
    ++* linkgit:git-history[1] can work in a bare repository as it does not need to
    ++  touch either the index or the worktree.
    ++* linkgit:git-history[1] does not execute any linkgit:githooks[5] at the
    ++  current point in time. This may change in the future.
    ++* linkgit:git-history[1] by default updates all branches that are descendants
    ++  of the original commit to point to the rewritten commit.
    ++
    ++Overall, linkgit:git-history[1] aims to provide a more opinionated way to modify
    ++your commit history that is simpler to use compared to linkgit:git-rebase[1] in
    ++general.
     +
    -+Note that this command does not (yet) work with histories that contain
    -+merges. You should use linkgit:git-rebase[1] with the `--rebase-merges`
    -+flag instead.
    ++If you want to reapply a range of commits onto a different base, or interactive
    ++rebases if you want to edit a range of commits.
    ++
    ++LIMITATIONS
    ++-----------
    ++
    ++This command does not (yet) work with histories that contain merges. You
    ++should use linkgit:git-rebase[1] with the `--rebase-merges` flag instead.
    ++
    ++Furthermore, the command does not support operations that can result in merge
    ++conflicts. This limitation is by design as history rewrites are not intended to
    ++be stateful operations. The limitation can be lifted once (if) Git learns about
    ++first-class conflicts.
     +
     +COMMANDS
     +--------
     +
     +Several commands are available to rewrite history in different ways:
     +
    -+CONFIGURATION
    -+-------------
    -+
    -+include::includes/cmd-config-section-all.adoc[]
    -+
     +GIT
     +---
     +Part of the linkgit:git[1] suite
 5:  4279bd9522 !  7:  2644bbb605 builtin/history: implement "reword" subcommand
    @@ Commit message
         is similar to the user performing an interactive rebase with a single
         commit changed to use the "reword" instruction.
     
    -    The major difference is that we do not check out the commit that is to
    -    be reworded. This has the obvious benefit of being significantly faster
    -    compared to git-rebase(1), but even more importantly it allows the user
    -    to rewrite history even if there are local changes in the working tree
    -    or in the index.
    +    The "reword" subcommand is built on top of the replay subsystem
    +    instead of the sequencer. This leads to some major differences compared
    +    to git-rebase(1):
    +
    +      - We do not check out the commit that is to be reworded and instead
    +        perform the operation in-memory. This has the obvious benefit of
    +        being significantly faster compared to git-rebase(1), but even more
    +        importantly it allows the user to rewrite history even if there are
    +        local changes in the working tree or in the index.
    +
    +      - We do not execute any hooks, even though we leave some room for
    +        changing this in the future.
    +
    +      - By default, all local branches that contain the commit will be
    +        rewritten. This especially helps with workflows that use stacked
    +        branches.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Documentation/git-history.adoc ##
    -@@ Documentation/git-history.adoc: git-history - EXPERIMENTAL: Rewrite history of the current branch
    +@@ Documentation/git-history.adoc: git-history - EXPERIMENTAL: Rewrite history
      SYNOPSIS
      --------
      [synopsis]
     -git history [<options>]
    -+git history reword <commit>
    ++git history reword <commit> [--ref-action=(branches|head|print)]
      
      DESCRIPTION
      -----------
    +@@ Documentation/git-history.adoc: Overall, linkgit:git-history[1] aims to provide a more opinionated way to modify
    + your commit history that is simpler to use compared to linkgit:git-rebase[1] in
    + general.
    + 
    +-If you want to reapply a range of commits onto a different base, or interactive
    +-rebases if you want to edit a range of commits.
    ++Use linkgit:git-rebase[1] if you want to reapply a range of commits onto a
    ++different base, or interactive rebases if you want to edit a range of commits
    ++at once.
    + 
    + LIMITATIONS
    + -----------
     @@ Documentation/git-history.adoc: COMMANDS
      
      Several commands are available to rewrite history in different ways:
    @@ Documentation/git-history.adoc: COMMANDS
     +	details of this commit remain unchanged. This command will spawn an
     +	editor with the current message of that commit.
     +
    - CONFIGURATION
    - -------------
    - 
    ++OPTIONS
    ++-------
    ++
    ++`--ref-action=(branches|head|print)`::
    ++	Control which references will be updated by the command, if any. With
    ++	`branches`, all local branches that point to commits which are
    ++	decendants of the original commit will be rewritten. With `head`, only
    ++	the current `HEAD` reference will be rewritten. With `print`, all
    ++	updates as they would be performed with `branches` are printed in a
    ++	format that can be consumed by linkgit:git-update-ref[1].
    ++
    + GIT
    + ---
    + Part of the linkgit:git[1] suite
     
      ## builtin/history.c ##
     @@
     +#define USE_THE_REPOSITORY_VARIABLE
     +
      #include "builtin.h"
    -+#include "commit-reach.h"
     +#include "commit.h"
    ++#include "commit-reach.h"
     +#include "config.h"
     +#include "editor.h"
     +#include "environment.h"
    @@ builtin/history.c
      #include "parse-options.h"
     +#include "refs.h"
     +#include "replay.h"
    -+#include "reset.h"
     +#include "revision.h"
     +#include "sequencer.h"
     +#include "strvec.h"
     +#include "tree.h"
     +#include "wt-status.h"
     +
    -+#define GIT_HISTORY_REWORD_USAGE N_("git history reword <commit>")
    -+
    -+static int collect_commits(struct repository *repo,
    -+			   struct commit *old_commit,
    -+			   struct commit *new_commit,
    -+			   struct strvec *out)
    -+{
    -+	struct setup_revision_opt revision_opts = {
    -+		.assume_dashdash = 1,
    -+	};
    -+	struct strvec revisions = STRVEC_INIT;
    -+	struct commit *child;
    -+	struct rev_info rev = { 0 };
    -+	int ret;
    -+
    -+	repo_init_revisions(repo, &rev, NULL);
    -+	rev.reverse = 1;
    -+	strvec_push(&revisions, "");
    -+	strvec_push(&revisions, oid_to_hex(&new_commit->object.oid));
    -+	if (old_commit) {
    -+		strvec_pushf(&revisions, "^%s", oid_to_hex(&old_commit->object.oid));
    -+		strvec_pushf(&revisions, "--ancestry-path=%s", oid_to_hex(&old_commit->object.oid));
    -+	}
    -+
    -+	setup_revisions_from_strvec(&revisions, &rev, &revision_opts);
    -+	if (revisions.nr != 1 || prepare_revision_walk(&rev)) {
    -+		ret = error(_("revision walk setup failed"));
    -+		goto out;
    -+	}
    -+
    -+	while ((child = get_revision(&rev))) {
    -+		if (old_commit && !child->parents)
    -+			BUG("revision walk did not find child commit");
    -+		if (child->parents && child->parents->next) {
    -+			ret = error(_("cannot rearrange commit history with merges"));
    -+			goto out;
    -+		}
    -+
    -+		strvec_push(out, oid_to_hex(&child->object.oid));
    -+	}
    -+
    -+	ret = 0;
    -+
    -+out:
    -+	strvec_clear(&revisions);
    -+	release_revisions(&rev);
    -+	reset_revision_walk();
    -+	return ret;
    -+}
    -+
    -+static int gather_commits_between_head_and_revision(struct repository *repo,
    -+						    const char *revision,
    -+						    struct commit **original_commit,
    -+						    struct commit **parent_commit,
    -+						    struct commit **head,
    -+						    struct strvec *commits)
    -+{
    -+	struct commit_list *from_list = NULL;
    -+	int ret;
    -+
    -+	*original_commit = lookup_commit_reference_by_name(revision);
    -+	if (!*original_commit) {
    -+		ret = error(_("commit cannot be found: %s"), revision);
    -+		goto out;
    -+	}
    -+
    -+	*parent_commit = (*original_commit)->parents ? (*original_commit)->parents->item : NULL;
    -+	if (*parent_commit && repo_parse_commit(repo, *parent_commit)) {
    -+		ret = error(_("unable to parse commit %s"),
    -+			    oid_to_hex(&(*parent_commit)->object.oid));
    -+		goto out;
    -+	}
    -+
    -+	*head = lookup_commit_reference_by_name("HEAD");
    -+	if (!(*head)) {
    -+		ret = error(_("could not resolve HEAD to a commit"));
    -+		goto out;
    -+	}
    -+
    -+	commit_list_append(*original_commit, &from_list);
    -+	if (!repo_is_descendant_of(repo, *head, from_list)) {
    -+		ret = error(_("commit must be reachable from current HEAD commit"));
    -+		goto out;
    -+	}
    -+
    -+	/*
    -+	 * Collect the list of commits that we'll have to reapply now already.
    -+	 * This ensures that we'll abort early on in case the range of commits
    -+	 * contains merges, which we do not yet handle.
    -+	 */
    -+	ret = collect_commits(repo, *parent_commit, *head, commits);
    -+	if (ret < 0)
    -+		goto out;
    -+
    -+out:
    -+	free_commit_list(from_list);
    -+	return ret;
    -+}
    -+
    -+static void replace_commits(struct strvec *commits,
    -+			    const struct object_id *commit_to_replace,
    -+			    const struct object_id *replacements,
    -+			    size_t replacements_nr)
    -+{
    -+	char commit_to_replace_oid[GIT_MAX_HEXSZ + 1];
    -+	struct strvec replacement_oids = STRVEC_INIT;
    -+	bool found = false;
    -+
    -+	oid_to_hex_r(commit_to_replace_oid, commit_to_replace);
    -+	for (size_t i = 0; i < replacements_nr; i++)
    -+		strvec_push(&replacement_oids, oid_to_hex(&replacements[i]));
    -+
    -+	for (size_t i = 0; i < commits->nr; i++) {
    -+		if (strcmp(commits->v[i], commit_to_replace_oid))
    -+			continue;
    -+		strvec_splice(commits, i, 1, replacement_oids.v, replacement_oids.nr);
    -+		found = true;
    -+		break;
    -+	}
    -+	if (!found)
    -+		BUG("could not find commit to replace");
    -+
    -+	strvec_clear(&replacement_oids);
    -+}
    -+
    -+static int apply_commits(struct repository *repo,
    -+			 const struct strvec *commits,
    -+			 struct commit *onto,
    -+			 struct commit *orig_head,
    -+			 const char *action)
    -+{
    -+	struct reset_head_opts reset_opts = { 0 };
    -+	struct strbuf buf = STRBUF_INIT;
    -+	int ret;
    -+
    -+	for (size_t i = 0; i < commits->nr; i++) {
    -+		struct object_id commit_id;
    -+		struct commit *commit;
    -+		const char *end;
    -+
    -+		if (parse_oid_hex_algop(commits->v[i], &commit_id, &end,
    -+					repo->hash_algo)) {
    -+			ret = error(_("invalid object ID: %s"), commits->v[i]);
    -+			goto out;
    -+		}
    -+
    -+		commit = lookup_commit(repo, &commit_id);
    -+		if (!commit || repo_parse_commit(repo, commit)) {
    -+			ret = error(_("failed to look up commit: %s"), oid_to_hex(&commit_id));
    -+			goto out;
    -+		}
    -+
    -+		if (!onto) {
    -+			onto = commit;
    -+		} else {
    -+			struct tree *tree = repo_get_commit_tree(repo, commit);
    -+			onto = replay_create_commit(repo, tree, commit, onto);
    -+			if (!onto) {
    -+				ret = -1;
    -+				goto out;
    -+			}
    -+		}
    -+	}
    -+
    -+	reset_opts.oid = &onto->object.oid;
    -+	strbuf_addf(&buf, "%s: switch to rewritten %s", action, oid_to_hex(reset_opts.oid));
    -+	reset_opts.flags = RESET_HEAD_REFS_ONLY | RESET_ORIG_HEAD;
    -+	reset_opts.orig_head = &orig_head->object.oid;
    -+	reset_opts.default_reflog_action = action;
    -+	if (reset_head(repo, &reset_opts) < 0) {
    -+		ret = error(_("could not switch to %s"), oid_to_hex(reset_opts.oid));
    -+		goto out;
    -+	}
    -+
    -+	ret = 0;
    -+
    -+out:
    -+	strbuf_release(&buf);
    -+	return ret;
    -+}
    ++#define GIT_HISTORY_REWORD_USAGE \
    ++	N_("git history reword <commit> [--ref-action=(branches|head|print)]")
     +
     +static void change_data_free(void *util, const char *str UNUSED)
     +{
    @@ builtin/history.c
     +
     +static int commit_tree_with_edited_message(struct repository *repo,
     +					   const char *action,
    -+					   struct commit *original_commit,
    -+					   const struct object_id *new_tree_oid,
    -+					   const struct commit_list *parents,
    -+					   const struct object_id *parent_tree_oid,
    -+					   struct object_id *out)
    ++					   struct commit *original,
    ++					   struct commit **out)
     +{
     +	const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
     +	const char *original_message, *original_body, *ptr;
     +	struct commit_extra_header *original_extra_headers = NULL;
     +	struct strbuf commit_message = STRBUF_INIT;
    ++	struct object_id rewritten_commit_oid;
    ++	struct object_id original_tree_oid;
    ++	struct object_id parent_tree_oid;
     +	char *original_author = NULL;
    ++	struct commit *parent;
     +	size_t len;
     +	int ret;
     +
    ++	original_tree_oid = repo_get_commit_tree(repo, original)->object.oid;
    ++
    ++	parent = original->parents ? original->parents->item : NULL;
    ++	if (parent) {
    ++		if (repo_parse_commit(repo, parent)) {
    ++			ret = error(_("unable to parse parent commit %s"),
    ++				    oid_to_hex(&parent->object.oid));
    ++			goto out;
    ++		}
    ++
    ++		parent_tree_oid = repo_get_commit_tree(repo, parent)->object.oid;
    ++	} else {
    ++		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
    ++	}
    ++
     +	/* We retain authorship of the original commit. */
    -+	original_message = repo_logmsg_reencode(repo, original_commit, NULL, NULL);
    ++	original_message = repo_logmsg_reencode(repo, original, NULL, NULL);
     +	ptr = find_commit_header(original_message, "author", &len);
     +	if (ptr)
     +		original_author = xmemdupz(ptr, len);
     +	find_commit_subject(original_message, &original_body);
     +
    -+	ret = fill_commit_message(repo, parent_tree_oid, new_tree_oid,
    ++	ret = fill_commit_message(repo, &parent_tree_oid, &original_tree_oid,
     +				  original_body, action, &commit_message);
     +	if (ret < 0)
     +		goto out;
     +
    -+	original_extra_headers = read_commit_extra_headers(original_commit, exclude_gpgsig);
    ++	original_extra_headers = read_commit_extra_headers(original, exclude_gpgsig);
     +
    -+	ret = commit_tree_extended(commit_message.buf, commit_message.len, new_tree_oid,
    -+				   parents, out, original_author, NULL, NULL,
    -+				   original_extra_headers);
    ++	ret = commit_tree_extended(commit_message.buf, commit_message.len, &original_tree_oid,
    ++				   original->parents, &rewritten_commit_oid, original_author,
    ++				   NULL, NULL, original_extra_headers);
     +	if (ret < 0)
     +		goto out;
     +
    ++	*out = lookup_commit_or_die(&rewritten_commit_oid, "rewritten commit");
    ++
     +out:
     +	free_commit_extra_headers(original_extra_headers);
     +	strbuf_release(&commit_message);
    @@ builtin/history.c
     +	return ret;
     +}
     +
    ++enum ref_action {
    ++	REF_ACTION_DEFAULT,
    ++	REF_ACTION_BRANCHES,
    ++	REF_ACTION_HEAD,
    ++	REF_ACTION_PRINT,
    ++};
    ++
    ++static int parse_ref_action(const struct option *opt, const char *value, int unset)
    ++{
    ++	enum ref_action *action = opt->value;
    ++
    ++	BUG_ON_OPT_NEG_NOARG(unset, value);
    ++	if (!strcmp(value, "branches")) {
    ++		*action = REF_ACTION_BRANCHES;
    ++	} else if (!strcmp(value, "head")) {
    ++		*action = REF_ACTION_HEAD;
    ++	} else if (!strcmp(value, "print")) {
    ++		*action = REF_ACTION_PRINT;
    ++	} else {
    ++		return error(_("%s expects one of 'branches', 'head' or 'print'"),
    ++			     opt->long_name);
    ++	}
    ++
    ++	return 0;
    ++}
    ++
    ++static int handle_reference_updates(enum ref_action action,
    ++				    struct repository *repo,
    ++				    struct commit *original,
    ++				    struct commit *rewritten,
    ++				    const char *reflog_msg)
    ++{
    ++	const struct name_decoration *decoration;
    ++	struct replay_revisions_options opts = { 0 };
    ++	struct replay_ref_updates updates = {
    ++		.final_oid = rewritten->object.oid,
    ++	};
    ++	struct ref_transaction *transaction = NULL;
    ++	struct strvec args = STRVEC_INIT;
    ++	struct strbuf err = STRBUF_INIT;
    ++	struct commit *head = NULL;
    ++	struct rev_info revs;
    ++	char hex[GIT_MAX_HEXSZ + 1];
    ++	int ret;
    ++
    ++	repo_init_revisions(repo, &revs, NULL);
    ++	strvec_push(&args, "ignored");
    ++	strvec_push(&args, "--reverse");
    ++	strvec_push(&args, "--topo-order");
    ++	strvec_push(&args, "--full-history");
    ++
    ++	/* We only want to see commits that are descendants of the old commit. */
    ++	strvec_pushf(&args, "--ancestry-path=%s",
    ++		     oid_to_hex(&original->object.oid));
    ++
    ++	/*
    ++	 * Ancestry path may also show ancestors of the old commit, but we
    ++	 * don't want to see those, either.
    ++	 */
    ++	strvec_pushf(&args, "^%s", oid_to_hex(&original->object.oid));
    ++
    ++	/*
    ++	 * When we're asked to update HEAD we need to verify that the commit
    ++	 * that we want to rewrite is actually an ancestor of it and, if so,
    ++	 * update it. Otherwise we'll update (or print) all descendant
    ++	 * branches.
    ++	 */
    ++	if (action == REF_ACTION_HEAD) {
    ++		struct commit_list *from_list = NULL;
    ++
    ++		head = lookup_commit_reference_by_name("HEAD");
    ++		if (!head) {
    ++			ret = error(_("cannot look up HEAD"));
    ++			goto out;
    ++		}
    ++
    ++		commit_list_insert(original, &from_list);
    ++		ret = repo_is_descendant_of(repo, head, from_list);
    ++		free_commit_list(from_list);
    ++
    ++		if (ret < 0) {
    ++			ret = error(_("cannot determine descendance"));
    ++			goto out;
    ++		} else if (!ret) {
    ++			ret = error(_("rewritten commit must be an ancestor "
    ++				      "of HEAD when using --ref-action=head"));
    ++			goto out;
    ++		}
    ++
    ++		strvec_push(&args, oid_to_hex(&head->object.oid));
    ++	} else {
    ++		strvec_push(&args, "--branches");
    ++	}
    ++
    ++	setup_revisions_from_strvec(&args, &revs, NULL);
    ++	if (revs.nr)
    ++		BUG("revisions were set up with invalid argument '%s'", args.v[0]);
    ++
    ++	opts.onto = oid_to_hex_r(hex, &rewritten->object.oid);
    ++
    ++	ret = replay_revisions(repo, &revs, &opts, &updates);
    ++	if (ret)
    ++		goto out;
    ++
    ++	switch (action) {
    ++	case REF_ACTION_DEFAULT:
    ++	case REF_ACTION_BRANCHES:
    ++		transaction = ref_store_transaction_begin(get_main_ref_store(repo), 0, &err);
    ++		if (!transaction) {
    ++			ret = error(_("failed to begin ref transaction: %s"), err.buf);
    ++			goto out;
    ++		}
    ++
    ++		for (size_t i = 0; i < updates.nr; i++) {
    ++			ret = ref_transaction_update(transaction,
    ++						     updates.items[i].refname,
    ++						     &updates.items[i].new_oid,
    ++						     &updates.items[i].old_oid,
    ++						     NULL, NULL, 0, reflog_msg, &err);
    ++			if (ret) {
    ++				ret = error(_("failed to update ref '%s': %s"),
    ++					    updates.items[i].refname, err.buf);
    ++				goto out;
    ++			}
    ++		}
    ++
    ++		/*
    ++		 * `replay_revisions()` only updates references that are
    ++		 * ancestors of `rewritten`, so we need to manually
    ++		 * handle updating references that point to `original`.
    ++		 */
    ++		for (decoration = get_name_decoration(&original->object);
    ++		     decoration;
    ++		     decoration = decoration->next)
    ++		{
    ++			if (decoration->type != DECORATION_REF_LOCAL)
    ++				continue;
    ++
    ++			ret = ref_transaction_update(transaction,
    ++						     decoration->name,
    ++						     &rewritten->object.oid,
    ++						     &original->object.oid,
    ++						     NULL, NULL, 0, reflog_msg, &err);
    ++			if (ret) {
    ++				ret = error(_("failed to update ref '%s': %s"),
    ++					    decoration->name, err.buf);
    ++				goto out;
    ++			}
    ++		}
    ++
    ++		if (ref_transaction_commit(transaction, &err)) {
    ++			ret = error(_("failed to commit ref transaction: %s"), err.buf);
    ++			goto out;
    ++		}
    ++
    ++		break;
    ++	case REF_ACTION_HEAD:
    ++		ret = refs_update_ref(get_main_ref_store(repo), reflog_msg, "HEAD",
    ++				      &updates.final_oid, &head->object.oid, 0,
    ++				      UPDATE_REFS_MSG_ON_ERR);
    ++		if (ret)
    ++			goto out;
    ++		break;
    ++	case REF_ACTION_PRINT:
    ++		for (size_t i = 0; i < updates.nr; i++)
    ++			printf("update %s %s %s\n",
    ++			       updates.items[i].refname,
    ++			       oid_to_hex(&updates.items[i].new_oid),
    ++			       oid_to_hex(&updates.items[i].old_oid));
    ++		break;
    ++	default:
    ++		BUG("unsupported ref action %d", action);
    ++	}
    ++
    ++	ret = 0;
    ++
    ++out:
    ++	replay_ref_updates_release(&updates);
    ++	ref_transaction_free(transaction);
    ++	release_revisions(&revs);
    ++	strbuf_release(&err);
    ++	strvec_clear(&args);
    ++	return ret;
    ++}
    ++
     +static int cmd_history_reword(int argc,
     +			      const char **argv,
     +			      const char *prefix,
    @@ builtin/history.c
     +		GIT_HISTORY_REWORD_USAGE,
     +		NULL,
     +	};
    ++	enum ref_action action = REF_ACTION_DEFAULT;
     +	struct option options[] = {
    ++		OPT_CALLBACK_F(0, "ref-action", &action, N_("<action>"),
    ++			       N_("control ref update behavior (branches|head|print)"),
    ++			       PARSE_OPT_NONEG, parse_ref_action),
     +		OPT_END(),
     +	};
    -+	struct commit *original_commit, *parent, *head;
    -+	struct strvec commits = STRVEC_INIT;
    -+	struct object_id parent_tree_oid, original_commit_tree_oid;
    -+	struct object_id rewritten_commit;
    ++	struct strbuf reflog_msg = STRBUF_INIT;
    ++	struct commit *original, *rewritten;
     +	int ret;
     +
     +	argc = parse_options(argc, argv, prefix, options, usage, 0);
    @@ builtin/history.c
     +	}
     +	repo_config(repo, git_default_config, NULL);
     +
    -+	ret = gather_commits_between_head_and_revision(repo, argv[0], &original_commit,
    -+						       &parent, &head, &commits);
    -+	if (ret < 0)
    ++	original = lookup_commit_reference_by_name(argv[0]);
    ++	if (!original) {
    ++		ret = error(_("commit cannot be found: %s"), argv[0]);
     +		goto out;
    ++	}
     +
    -+	original_commit_tree_oid = repo_get_commit_tree(repo, original_commit)->object.oid;
    -+	if (parent)
    -+		parent_tree_oid = repo_get_commit_tree(repo, parent)->object.oid;
    -+	else
    -+		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
    -+
    -+	/* We retain authorship of the original commit. */
    -+	ret = commit_tree_with_edited_message(repo, "reworded", original_commit,
    -+					      &original_commit_tree_oid,
    -+					      original_commit->parents, &parent_tree_oid,
    -+					      &rewritten_commit);
    ++	ret = commit_tree_with_edited_message(repo, "reworded", original, &rewritten);
     +	if (ret < 0) {
     +		ret = error(_("failed writing reworded commit"));
     +		goto out;
     +	}
     +
    -+	replace_commits(&commits, &original_commit->object.oid, &rewritten_commit, 1);
    ++	strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
     +
    -+	ret = apply_commits(repo, &commits, parent, head, "reword");
    -+	if (ret < 0)
    ++	ret = handle_reference_updates(action, repo, original, rewritten,
    ++				       reflog_msg.buf);
    ++	if (ret < 0) {
    ++		ret = error(_("failed replaying descendants"));
     +		goto out;
    ++	}
     +
     +	ret = 0;
     +
     +out:
    -+	strvec_clear(&commits);
    ++	strbuf_release(&reflog_msg);
     +	return ret;
     +}
      
    @@ builtin/history.c
     +	return fn(argc, argv, prefix, repo);
      }
     
    + ## replay.c ##
    +@@ replay.c: int replay_revisions(struct repository *repo, struct rev_info *revs,
    + 	struct commit *commit;
    + 	struct commit *onto = NULL;
    + 	struct merge_options merge_opt;
    +-	struct merge_result result;
    ++	struct merge_result result = {
    ++		.clean = 1,
    ++	};
    + 	char *advance;
    + 	int ret;
    + 
    +@@ replay.c: int replay_revisions(struct repository *repo, struct rev_info *revs,
    + 	}
    + 
    + 	init_basic_merge_options(&merge_opt, repo);
    +-	memset(&result, 0, sizeof(result));
    + 	merge_opt.show_rename_progress = 0;
    + 	last_commit = onto;
    + 	replayed_commits = kh_init_oid_map();
    +
      ## t/meson.build ##
     @@ t/meson.build: integration_tests = [
        't3437-rebase-fixup-options.sh',
    @@ t/t3451-history-reword.sh (new)
     +test_description='tests for git-history reword subcommand'
     +
     +. ./test-lib.sh
    ++. "$TEST_DIRECTORY/lib-log-graph.sh"
     +
     +reword_with_message () {
     +	cat >message &&
    @@ t/t3451-history-reword.sh (new)
     +	rm fake-editor.sh message
     +}
     +
    -+test_expect_success 'refuses to work with merge commits' '
    -+	test_when_finished "rm -rf repo" &&
    -+	git init repo &&
    -+	(
    -+		cd repo &&
    -+		test_commit base &&
    -+		git branch branch &&
    -+		test_commit ours &&
    -+		git switch branch &&
    -+		test_commit theirs &&
    -+		git switch - &&
    -+		git merge theirs &&
    -+		test_must_fail git history reword HEAD~ 2>err &&
    -+		test_grep "cannot rearrange commit history with merges" err &&
    -+		test_must_fail git history reword HEAD 2>err &&
    -+		test_grep "cannot rearrange commit history with merges" err
    -+	)
    -+'
    ++expect_graph () {
    ++	cat >expect &&
    ++	lib_test_cmp_graph --graph --format=%s "$@"
    ++}
     +
    -+test_expect_success 'refuses to work with unrelated commits' '
    -+	test_when_finished "rm -rf repo" &&
    -+	git init repo &&
    -+	(
    -+		cd repo &&
    -+		test_commit base &&
    -+		git branch branch &&
    -+		test_commit ours &&
    -+		git switch branch &&
    -+		test_commit theirs &&
    -+		test_must_fail git history reword ours 2>err &&
    -+		test_grep "commit must be reachable from current HEAD commit" err
    -+	)
    -+'
    ++expect_log () {
    ++	git log --format="%s" "$@" >actual &&
    ++	cat >expect &&
    ++	test_cmp expect actual
    ++}
     +
     +test_expect_success 'can reword tip of a branch' '
     +	test_when_finished "rm -rf repo" &&
    @@ t/t3451-history-reword.sh (new)
     +		git symbolic-ref HEAD >actual &&
     +		test_cmp expect actual &&
     +
    -+		cat >expect <<-EOF &&
    ++		expect_log <<-\EOF &&
     +		third reworded
     +		second
     +		first
     +		EOF
    -+		git log --format=%s >actual &&
    -+		test_cmp expect actual &&
     +
     +		git reflog >reflog &&
     +		test_grep "reword: updating HEAD" reflog
    @@ t/t3451-history-reword.sh (new)
     +		git symbolic-ref HEAD >actual &&
     +		test_cmp expect actual &&
     +
    -+		cat >expect <<-EOF &&
    ++		expect_log <<-\EOF
     +		third
     +		second reworded
     +		first
     +		EOF
    -+		git log --format=%s >actual &&
    -+		test_cmp expect actual
     +	)
     +'
     +
    @@ t/t3451-history-reword.sh (new)
     +		first reworded
     +		EOF
     +
    -+		cat >expect <<-EOF &&
    ++		expect_log <<-\EOF
     +		third
     +		second
     +		first reworded
     +		EOF
    -+		git log --format=%s >actual &&
    -+		test_cmp expect actual
    ++	)
    ++'
    ++
    ++test_expect_success 'can reword in a bare repo' '
    ++	test_when_finished "rm -rf repo repo.git" &&
    ++	git init repo &&
    ++	test_commit -C repo first &&
    ++	git clone --bare repo repo.git &&
    ++	(
    ++		cd repo.git &&
    ++		reword_with_message HEAD <<-EOF &&
    ++		reworded
    ++		EOF
    ++
    ++		expect_log <<-\EOF
    ++		reworded
    ++		EOF
    ++	)
    ++'
    ++
    ++test_expect_success 'can reword a commit on a different branch' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit base &&
    ++		git branch theirs &&
    ++		test_commit ours &&
    ++		git switch theirs &&
    ++		test_commit theirs &&
    ++
    ++		git rev-parse ours >ours-before &&
    ++		reword_with_message theirs <<-EOF &&
    ++		Reworded theirs
    ++		EOF
    ++		git rev-parse ours >ours-after &&
    ++		test_cmp ours-before ours-after &&
    ++
    ++		expect_graph --branches <<-\EOF
    ++		* Reworded theirs
    ++		| * ours
    ++		|/
    ++		* base
    ++		EOF
    ++	)
    ++'
    ++
    ++test_expect_success 'can reword a merge commit' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit base &&
    ++		git branch branch &&
    ++		test_commit ours &&
    ++		git switch branch &&
    ++		test_commit theirs &&
    ++		git switch - &&
    ++		git merge theirs &&
    ++
    ++		# It is not possible to replay merge commits embedded in the
    ++		# history (yet).
    ++		test_must_fail git history reword HEAD~ 2>err &&
    ++		test_grep "replaying merge commits is not supported yet" err &&
    ++
    ++		# But it is possible to reword a merge commit directly.
    ++		reword_with_message HEAD <<-EOF &&
    ++		Reworded merge commit
    ++		EOF
    ++		expect_graph <<-\EOF
    ++		*   Reworded merge commit
    ++		|\
    ++		| * theirs
    ++		* | ours
    ++		|/
    ++		* base
    ++		EOF
    ++	)
    ++'
    ++
    ++test_expect_success '--ref-action=print prints ref updates without modifying repo' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo --initial-branch=main &&
    ++	(
    ++		cd repo &&
    ++		test_commit base &&
    ++		git branch branch &&
    ++		test_commit ours &&
    ++		git switch branch &&
    ++		test_commit theirs &&
    ++
    ++		git refs list >refs-expect &&
    ++		reword_with_message --ref-action=print base >updates <<-\EOF &&
    ++		reworded commit
    ++		EOF
    ++		git refs list >refs-actual &&
    ++		test_cmp refs-expect refs-actual &&
    ++
    ++		test_grep "update refs/heads/branch" updates &&
    ++		test_grep "update refs/heads/main" updates &&
    ++		git update-ref --stdin <updates &&
    ++		expect_log --branches <<-\EOF
    ++		theirs
    ++		ours
    ++		reworded commit
    ++		EOF
    ++	)
    ++'
    ++
    ++test_expect_success '--ref-action=head updates only HEAD' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo --initial-branch=main &&
    ++	(
    ++		cd repo &&
    ++		test_commit base &&
    ++		git branch branch &&
    ++		test_commit theirs &&
    ++		git switch branch &&
    ++		test_commit ours &&
    ++
    ++		# When told to update HEAD, only, the command will refuse to
    ++		# rewrite commits that are not an ancestor of HEAD.
    ++		test_must_fail git history reword --ref-action=head theirs 2>err &&
    ++		test_grep "rewritten commit must be an ancestor of HEAD" err &&
    ++
    ++		reword_with_message --ref-action=head base >updates <<-\EOF &&
    ++		reworded base
    ++		EOF
    ++		expect_log HEAD <<-\EOF &&
    ++		ours
    ++		reworded base
    ++		EOF
    ++		expect_log main <<-\EOF
    ++		theirs
    ++		base
    ++		EOF
     +	)
     +'
     +
 6:  725bea8b19 <  -:  ---------- add-patch: split out header from "add-interactive.h"
 7:  09af5da957 <  -:  ---------- add-patch: split out `struct interactive_options`
 8:  9faad738f3 <  -:  ---------- add-patch: remove dependency on "add-interactive" subsystem
 9:  2ccce1afd7 <  -:  ---------- add-patch: add support for in-memory index patching
10:  b5fb633f9c <  -:  ---------- add-patch: allow disabling editing of hunks
11:  0c30a1eae2 <  -:  ---------- cache-tree: allow writing in-memory index as tree
12:  c7898ca2ff <  -:  ---------- builtin/history: implement "split" subcommand

---
base-commit: 02bdc12118c43e0a65258eb742492965859bffb6
change-id: 20250819-b4-pks-history-builtin-83398f9a05f0

