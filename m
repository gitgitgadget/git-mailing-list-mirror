Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB27360EDC
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921938; cv=none; b=czj5K00C9wJCzLzktGTdtm59WFQ8T1O3zqS8ypQohUYVqkcnY0IgkOR0hzVV2CFsDjBty+euyz1hIJ2J4Nb4WjkYiRvhnHmUb/ASTjiM2fSkj4zRH/HY277dRCJ2qBF0S8+UCFi2FCbSQk/hRddG7w6rz3nwFMwYXcjBPZvobzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921938; c=relaxed/simple;
	bh=xaOwnW5WOksrYAKPJy0T7xL8zLNBVZcq1KXdvrcoJJ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=DLBGDtp/WHZgd6LMRPT2SnqLX4gPx7rtvaNcOgV4Fz0AlSpbr+4Z4Y7Z+JwRTTgbERyhUC5f/5mZ2BWU9Ln5+hhQ4aNehEXNuZM5wrBkXHjNnp9qO9CEdgzryr1HgPtqWsJM3+whyapwQDtDm8SdqppBcZQ8Jxn4SZHUJZENy78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bep+Eh7i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W5jOHC2K; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bep+Eh7i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5jOHC2K"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE4421400071;
	Mon, 13 Jul 2026 01:52:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jul 2026 01:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783921936;
	 x=1784008336; bh=9BU990uUikONb1R+OHDFinCAjF2pWQ08HyFAhS2IUrY=; b=
	bep+Eh7iw6cJCtKxQhRZ7vZGJlpU/GizY/Q4TriO+4SkBu4RugZY7Det7ujMRX8A
	qW3cnr49nrPbAqqWVWDPrIbPmUg4RneTeCYE1UiZ5KrUcIfqVOYNRlOu2AP6AUg2
	yxEZu66C2/icZ7SQCWdbN0zSt9AcqheO7WUsM9WVzMKBnrb3ZYk8LBGAviHH0xo/
	Plv4uZFNKA22jEcf2HedDNy/GHBji+AiUbljtA5cttNAgUcjYzoLEdRFzEE+0wn6
	JbQIi4ypm7kGUC0M6aqGFh1p86ju6y6d0CNbvQX0N6BVLTTtn02RuKy9P+Y5U7/2
	0KAiADwLnY4IF6dgYQqR6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783921936; x=
	1784008336; bh=9BU990uUikONb1R+OHDFinCAjF2pWQ08HyFAhS2IUrY=; b=W
	5jOHC2KJ1rvS8CKqhE+jDdNInEJwRtN95HUa1fu9R73lvZn2oLI19/fACrW1jchP
	5h+72P/MUcoAsYabIfhfX7KKogeL747Ikbd0fxwQOlmUzn4PNXnyjtylOxvAVAFK
	tZw9Ko4eVm/Xmj2SC8BtloVCqEBCa/0HAOi3mTddWGdXvhovrsI6PKv9mjZij1cu
	DcAHN4LLxXJwKMexKC5YBy2flmCXN0X2g18/Ee+sTJyXt8DsG2beAlIpxRR1lQZL
	kSlZmORaNcqsgk9HPONkDYoXrLb65w0Yyt9pxP9qeKFFRHgh0Hd1e8QvZxf97Mli
	80PhtqrlPMOCZaMt/HiCw==
X-ME-Sender: <xms:EH1UalNukQn44YVEeZCLGgaVVKn1-XlBX7aYg6RiW4lSYaYHUxJqUQ>
    <xme:EH1Uat8qIkN8dloDHxjLHsUE8wSq02v4Rg0Jx7wUoEoPumOSnM26Hi2VEhObODpEw
    HSJl5Du6SanR6eHN0lmyqoOFQnZVKTW2kQNndEC48YMDw6YBa9viA>
X-ME-Received: <xmr:EH1Uah6R7WMCpcAyAB9Fs8A-eLV3CnEQ0woeqc6_qvqWlii70Ws16ObflaKkIMA01WWFj4SU700ne1th9sw0R3FT3OfXML1Hy8KRiSxS>
X-ME-Proxy-Cause: dmFkZTF45doL5xfI+4x3dE0vweFcanQ1/Lj+u5DIsdYP5M55IRVVeSMtE3IvZr+4Czqczo
    AgVyLyeUW7wW+5IMO9RwnTzljsTLD4H22AjG3hOczS+i/BBAf+NlQ5KigKnzM86XRv2dAo
    GfUwgt238sro/0rjAQfnzbXMPv7XD+U6qGaAESKNVrL2G+O8YmPrpMUQqZtood9AnZWX0D
    DxqrleuToQtExbvxbNDhIDi5bOBrWtHhWAohQfF6+PxWlyP06Rp72JqOP+o1I8y+N+ihFZ
    EQGlMRf85sKgVZBUQsAEjOpMG3ooauBNmLk38touq24cR3Ojm8sSox0c/Jz+dUWbCTkFQy
    iOzhTbSBl1ap9XioBbqWuxH0oex2+mJtNn24QDanQq9blahsKckeqxkdu+hftHKvoaJqG7
    11je8G0LEICzmOU4loFGzyunNyrLGLNE2FmqkaJmZxihQmGUOBnxD7vA8/6u3wIMTItf3I
    ubM1h9VoEmfitsLfZ5JDzI9ybB4asstVdkllLQmembcdi/SPdbAFZIGayp2K/ecz9wA11o
    LJ/aFqhTjhVCn6rjFNPymInWxpTHunLXcvBRdp9sbBYkoomIq5/lVzShZTEfKsEnEUkx7u
    4PV4yGlzuI5QKRT5YpXPLWjGvffQfkOGjV7yZMWfvHR4T4X4mIJQVvxxBSmQ
X-ME-Proxy: <xmx:EH1Uas0GCvBAJfA2XLYV1VzvAlDYmbd_RAWo4YEbh0b2h-H53nO7oA>
    <xmx:EH1UagCRIyuuWS3wPoSlz1A00yvUa0hj8IG-m-Krp2ShmtyO9J7eFQ>
    <xmx:EH1Uam2oApzMzx29FAp-XPrdkBAnMiupugOjXU_dZCjsChstYZ-sIg>
    <xmx:EH1UaitXhHY8z7YPZ0jvRKJ6cP1rdqVi2iH7jb8v81Khd2sM0C6jqA>
    <xmx:EH1UagkiE3apokCMPN5De0ZKMEl1SZBF-FpTwPlyyNJDLSh8bXSqoZT5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 01:52:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 07cd7494 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 05:52:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/12] odb: make optimizations pluggable
Date: Mon, 13 Jul 2026 07:52:03 +0200
Message-Id: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0Jm7ZhSoE1ceQ/CgpZRRgNtWiQq4
 e4W2Lp8yfv/LRApMEW4ZAsEmjmyGxPIUwa2b8c7IXeJQQqphMolmhL9M6LrDDo/8cBfwqKUyla
 aKlsISEsf6Mbv/bVuDo4v8yA7bVeb0XOcXPjs2TnfvKOghf5bmHMU2LaUDKW0ofKalDMP0Kzr+
 gPK0FNpxQAAAA==
X-Change-ID: 20260612-b4-pks-odb-optimize-3426c57e5c30
In-Reply-To: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
References: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

this patch series converts object housekeeping to become pluggable.
There isn't really anything else to say about this.

The series is built on top of f85a7e6620 (Start Git 2.56 cycle,
2026-07-06).

Changes in v2:
  - Make tests in t7900 a bit more robust by not checking for exact
    commands, but instead by checking for executed tasks.
  - Link to v1: https://patch.msgid.link/20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (12):
      t7900: simplify how we check for maintenance tasks
      odb: run "pre-auto-gc" hook for all maintenance tasks
      builtin/gc: move worktree and rerere tasks before object optimizations
      builtin/gc: extract object database optimizations into separate function
      builtin/gc: make repack arguments self-contained
      builtin/gc: inline config values specific to the "files" backend
      builtin/gc: introduce object database optimization options
      builtin/gc: move geometric repacking into `odb_optimize()`
      builtin/gc: introduce `odb_optimize_required()`
      builtin/gc: refactor ODB optimizations to operate on "files" source
      builtin/gc: fix signedness issues in ODB-related functionality
      odb: make optimizations pluggable

 builtin/gc.c           | 534 ++++++++-----------------------------------------
 odb.c                  |  12 ++
 odb.h                  |  45 +++++
 odb/source-files.c     | 470 +++++++++++++++++++++++++++++++++++++++++++
 odb/source-files.h     |  15 ++
 odb/source.h           |  36 ++++
 t/t7900-maintenance.sh | 338 +++++++++++++++++++++----------
 7 files changed, 894 insertions(+), 556 deletions(-)

Range-diff versus v1:

 -:  ---------- >  1:  b05988c150 t7900: simplify how we check for maintenance tasks
 1:  df9ed71c10 !  2:  734d3c6d17 odb: run "pre-auto-gc" hook for all maintenance tasks
    @@ t/t7900-maintenance.sh: test_expect_success 'geometric repacking honors configur
     +			git maintenance run --auto 2>/dev/null &&
     +
     +		# The successful hook does not inhibit any of the tasks...
    -+		test_subcommand git reflog expire --all <trace2.txt &&
    -+		test_subcommand_flex git repack <trace2.txt &&
    -+		test_subcommand git rerere gc <trace2.txt &&
    ++		test_maintenance_tasks trace2.txt <<-\EOF &&
    ++		reflog-expire foreground
    ++		geometric-repack
    ++		rerere-gc
    ++		EOF
     +		# ... but it must only have been executed a single time.
     +		test_line_count = 1 hook.log
     +	)
    @@ t/t7900-maintenance.sh: test_expect_success 'geometric repacking honors configur
     +		# is expected to be the only child process being spawned, and
     +		# it must only run a single time.
     +		test_grep "child_start.*pre-auto-gc" trace2.txt &&
    -+		test_subcommand_flex ! git trace2 &&
    ++		test_maintenance_tasks trace2.txt <<-\EOF &&
    ++		EOF
     +		test_line_count = 1 hook.log
     +	)
     +'
    @@ t/t7900-maintenance.sh: test_expect_success 'geometric repacking honors configur
     +		# is expected to be the only child process being spawned, and
     +		# it must only run a single time.
     +		test_grep "child_start.*pre-auto-gc" trace2.txt &&
    ++		test_maintenance_tasks trace2.txt <<-\EOF &&
    ++		EOF
     +		test_subcommand_flex ! git trace2 &&
     +		test_line_count = 1 hook.log
     +	)
 2:  ba358cede1 =  3:  a61f01a1c1 builtin/gc: move worktree and rerere tasks before object optimizations
 3:  ffbaf71f46 =  4:  3d6ea9927b builtin/gc: extract object database optimizations into separate function
 4:  7b568dcd0c =  5:  de2c2c084d builtin/gc: make repack arguments self-contained
 5:  e18465b4b2 =  6:  0b4f6a553d builtin/gc: inline config values specific to the "files" backend
 6:  4ee5a61e44 =  7:  e231c437ba builtin/gc: introduce object database optimization options
 7:  2b428d4516 !  8:  b015c35c8a builtin/gc: move geometric repacking into `odb_optimize()`
    @@ t/t7900-maintenance.sh: test_expect_success 'geometric repacking honors configur
      	)
      '
      
    -@@ t/t7900-maintenance.sh: test_expect_success 'maintenance.strategy is respected' '
    - 		test_strategy geometric <<-\EOF &&
    - 		git pack-refs --all --prune
    - 		git reflog expire --all
    --		git repack -d -l --geometric=2 --quiet --write-midx
    -+		git repack -d -l -q --geometric=2 --write-midx
    - 		git commit-graph write --split --reachable --no-progress
    - 		git worktree prune --expire 3.months.ago
    - 		git rerere gc
    -@@ t/t7900-maintenance.sh: test_expect_success 'maintenance.strategy is respected' '
    - 		test_strategy geometric --schedule=weekly <<-\EOF
    - 		git pack-refs --all --prune
    - 		git reflog expire --all
    --		git repack -d -l --geometric=2 --quiet --write-midx
    -+		git repack -d -l -q --geometric=2 --write-midx
    - 		git commit-graph write --split --reachable --no-progress
    - 		git worktree prune --expire 3.months.ago
    - 		git rerere gc
 8:  79c3d77210 =  9:  426a06b349 builtin/gc: introduce `odb_optimize_required()`
 9:  15f65ab0bf = 10:  cfb6014c30 builtin/gc: refactor ODB optimizations to operate on "files" source
10:  9035d7d679 = 11:  a478e0e0b3 builtin/gc: fix signedness issues in ODB-related functionality
11:  8fa84c3aa0 = 12:  5383b9027c odb: make optimizations pluggable

---
base-commit: f85a7e662054a7b0d9070e432508831afa214b47
change-id: 20260612-b4-pks-odb-optimize-3426c57e5c30

