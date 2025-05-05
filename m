Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449D918C008
	for <git@vger.kernel.org>; Mon,  5 May 2025 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435113; cv=none; b=smheu8sMyvqh1qC9Heqp4OGtnvyqSyIPGeW4Rns5tLvLmxxg5JpQGp2lcALLVee7DVoZvo91DPP6GM6otE+Pss2KYx2ttrjjidOR2JV5g9BZJsU4y9s/94cPYAM0Ekl/4vPc7l7yPJzyND9HC+a8x8U1ZAXERCqVcr6vG0xkTUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435113; c=relaxed/simple;
	bh=RcHEibn8ZVVYcDxHpfjm6qNPJghzvn+zLihGGJrHW3U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=H8iXVrvCLDJBsxow+V8v6nbXba2N0WbuBUGJ4+Evr6Jp8UPGeDT48SF03ULbC1R27IVwnOFS7aKegvFY6Unny4d9BfBwUcduqgWGof367thZXn1eoIMP3x8ZYxNqHjQY7rxzF9IkxNbMox639n8wAvGMHfhXsr+UHtlu5cQlFUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s9Hwn2Dh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bisnlY+e; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s9Hwn2Dh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bisnlY+e"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 179112540235;
	Mon,  5 May 2025 04:51:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 05 May 2025 04:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746435109;
	 x=1746521509; bh=c9EzOv0O8GAyrdJu0y/c62RcbaZu6hkgeBTBcUmbXq4=; b=
	s9Hwn2DhSqXsRAwMbAkQk1Hps7xaNTr8wcAyOQ1xr08xL4cY0j2wKn1axa0/Ss5x
	6jS3XZ/NPMWQFO8NRi+JKajBxjVFCKbF3y8l0RB9fBQHqvGzEN5St7PQN8Tuvwns
	eZ21JHN7Y1w3N9G86tXVToramFO2OYtK0Gher7RjZhshwUl89pWPe8sg9/IqmYC2
	2UjSqukwO1h6zEkd6PyV8Wy1O8J3zGpDpEc1PRaKy2wFUMQz9TaZ6TacYpq7rFZs
	/oc/D3ls7kkTh7x63EjKfkJmIj8lNh4Rkg1NIAOXW2dLKjGyG5GEpbOctiKvnqL/
	Itt1uUGYDm94AH/qZVcbhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746435109; x=
	1746521509; bh=c9EzOv0O8GAyrdJu0y/c62RcbaZu6hkgeBTBcUmbXq4=; b=b
	isnlY+erCOnapiWnjr7Nv5FWjpqJ7n36q2d9AZ/h9Z9JaywcQZI2wr4NYp5aL2DX
	eHEfYawr9VPcYS7mH8Av5WbRRw4MuX6kGJ3SvpuhoS7cTjXmAVtkbh5gA9rQ8NXu
	nx3urY4v4rNANFjhG93ZYm4PNWXfvXNGvDW+P3T/WnufQwyWMTjRIXATS6gVC2uO
	W50bzWu/4bgMbVhcGmj9rA92zuPmWbZHMJKfyaCvgd9gXF4jljKZ+kGYcCiOc+kD
	HhA2s8ULlsV0EKY2ngpzmin3UmPnzE1c1XllXEvmorZJGM0bsIrTVN8WwusN1aQQ
	0EzeruCSaDraH3ks95J3g==
X-ME-Sender: <xms:JXwYaDg8_lpfAfuP8XjX53kRCMjVBX8bcsTN788_kDnwzrMvXDLyqA>
    <xme:JXwYaAAQ8IMOoC1u1kYaWp7pAzPlpkhkxNDTyYhAXj3yDs1Z61G4GyhEoQ6QEJHRH
    upcDJHshfXCIzOTMw>
X-ME-Received: <xmr:JXwYaDEo95Jz32NiRsGdb6VL5wk0UBPfgGmYFid_4DtbQGm0qmi0IaOJVpEStgq3iO2Og3OC6wdlSWc9YoqlcEPByjmOW4Uv4jLSMUUP5l-z_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpefgfeehudejveeuuedtgffgvdektdffgeekfefh
    geeffedutdejtdetudfhvefhheenucffohhmrghinhepfihorhhkthhrvggvqdhprhhunh
    gvrdgruhhtohdprhgvrhgvrhgvqdhgtgdrrghuthhopdhkvghrnhgvlhdrohhrghdprhgv
    fhhlohhgqdgvgihpihhrvgdrrghuthhonecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JXwYaASPZ3HyyG59Tnq84TFkIhvkzMo2P6aR7d_56ckrAPMR1MXh2A>
    <xmx:JXwYaAxBid886bILeoHFdYfrkm7y8CRxvIgZShI19oA_y-FEj1bzeg>
    <xmx:JXwYaG4W2F3RrJeo5ZD5zoosvN0pq3E7ECHej7sQ98EiJ09m2u3Hpw>
    <xmx:JXwYaFzyLZ3bWMRYMRqGqd1JjzL5qyuYZwYRlhgKgPiKYeCZqamO-Q>
    <xmx:JXwYaLt7bzh9QTJVKjXXkFWaOuF2021RHeY3mAgFyj_52ZMnf6GgmdA4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 04:51:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3b85ea47 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 08:51:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/7] builtin/maintenance: implement missing tasks
 compared to git-gc(1)
Date: Mon, 05 May 2025 10:51:40 +0200
Message-Id: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABx8GGgC/4XNzQ6CMAzA8VcxOztTOgboyfcwHsZWsDEMwgjRE
 N7dQeLXieO/bX6dRKCeKYjTbhI9jRy49THS/U7Ym/E1SXaxBQJqSDGV3T3IxrAfyBtvSTYcAvt
 aDibETVFV1jl9zMpciWh0PVX8WP3LNfaNw9D2z/XdmCzTt6w35DGRII85kstMiRbcOd4fuBELO
 +IPpWCLwkihLqDMy8IaZf4o9aU04BalIpUoShQ4lWUpfKh5nl8WUs/mXQEAAA==
X-Change-ID: 20250424-pks-maintenance-missing-tasks-8ffcdd596b73
In-Reply-To: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series implements the last couple of remaining tasks
that are missing compared to the functionality git-gc(1) provides.

Right now, git-maintenance(1) still executes git-gc(1). With these last
gaps plugged though we can in theory fully replace git-gc(1) with finer
grained tasks without losing any functionality. The benefit is that it
becomes possible for users to have finer-grained control over what
exactly the maintenance does.

This patch series doesn't do that yet, but only implements whatever is
needed to get there.

Changes in v2:
  - Introduce "maintenance.worktree-prune.auto", which controls how many
    stale worktrees need to exist before executing `git worktree prune`.
  - Introduce "maintenance.rerere-gc.auto", which controls how many
    stale rerere entries need to exist before executing `git rerere gc`.
  - Add tests to verify that "gc.worktreePruneExpire" works.
  - Remove some fragile test logic by introducing functions that check
    for a given maintenance subprocess.
  - Link to v1: https://lore.kernel.org/r/20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im

Changes in v3:
  - Simplify the heuristic for "rerere-gc" so that we only count the
    number of directory entries in ".git/rr-cache", without considering
    staleness.
  - Link to v2: https://lore.kernel.org/r/20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im

Changes in v4:
  - simplified the heuristic for "rerere-gc" even further. A positive
    value for "maintenance.rerere-gc.auto" now indicates that the
    command will run whenever there is at least one directory entry in
    ".rr-cache". The exact value does not matter anymore.
  - Link to v3: https://lore.kernel.org/r/20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (7):
      builtin/gc: fix indentation of `cmd_gc()` parameters
      builtin/gc: remove global variables where it trivial to do
      builtin/gc: move pruning of worktrees into a separate function
      worktree: expose function to retrieve worktree names
      builtin/maintenance: introduce "worktree-prune" task
      builtin/gc: move rerere garbage collection into separate function
      builtin/maintenance: introduce "rerere-gc" task

 Documentation/config/maintenance.adoc |  17 ++++
 Documentation/git-maintenance.adoc    |   8 ++
 builtin/gc.c                          | 149 +++++++++++++++++++++++++++-------
 builtin/worktree.c                    |  25 +++---
 t/t7900-maintenance.sh                | 115 ++++++++++++++++++++++++++
 worktree.c                            |  30 +++++++
 worktree.h                            |   8 ++
 7 files changed, 308 insertions(+), 44 deletions(-)

Range-diff versus v3:

1:  0cf3cb937c3 = 1:  6614504400b builtin/gc: fix indentation of `cmd_gc()` parameters
2:  5982d47cc95 = 2:  6c8c66282c5 builtin/gc: remove global variables where it trivial to do
3:  afda176acd3 = 3:  bfa8fc00434 builtin/gc: move pruning of worktrees into a separate function
4:  b3b6a14bf1c = 4:  d87b883cf62 worktree: expose function to retrieve worktree names
5:  e02d59bb944 = 5:  354a1985b4b builtin/maintenance: introduce "worktree-prune" task
6:  cb31ec6b8bd = 6:  6f40349b53f builtin/gc: move rerere garbage collection into separate function
7:  65e8483fe4a ! 7:  e3c9da19a2c builtin/maintenance: introduce "rerere-gc" task
    @@ Documentation/config/maintenance.adoc: maintenance.reflog-expire.auto::
     +	This integer config option controls how often the `rerere-gc` task
     +	should be run as part of `git maintenance run --auto`. If zero, then
     +	the `rerere-gc` task will not run with the `--auto` option. A negative
    -+	value will force the task to run every time. Otherwise, a positive
    -+	value implies the command should run when there are at least this many
    -+	directory entries in the "rr-cache" directory. The default value is 1.
    ++	value will force the task to run every time. Otherwise, any positive
    ++	value implies the command will run when the "rr-cache" directory exists
    ++	and has at least one entry, regardless of whether it is stale or not.
    ++	This heuristic may be refined in the future. The default value is 1.
     +
      maintenance.worktree-prune.auto::
      	This integer config option controls how often the `worktree-prune` task
    @@ builtin/gc.c: static int maintenance_task_rerere_gc(struct maintenance_run_opts
     +
     +	/*
     +	 * We skip garbage collection in case we either have no "rr-cache"
    -+	 * directory or when it doesn't contain at least as many directories as
    -+	 * indicated by "maintenance.rerere-gc.auto".
    ++	 * directory or when it doesn't contain at least one entry.
     +	 */
     +	repo_git_path_replace(the_repository, &path, "rr-cache");
     +	dir = opendir(path.buf);
     +	if (!dir)
     +		goto out;
    -+
    -+	while (readdir_skip_dot_and_dotdot(dir)) {
    -+		if (--limit)
    -+			continue;
    -+
    -+		should_gc = 1;
    -+		goto out;
    -+	}
    ++	should_gc = !!readdir_skip_dot_and_dotdot(dir);
     +
     +out:
     +	strbuf_release(&path);
    @@ t/t7900-maintenance.sh: test_expect_success 'worktree-prune task honors gc.workt
     +	# A negative value should always prune.
     +	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=-1 maintenance run --auto --task=rerere-gc &&
     +
    ++	# A positive value prunes when there is at least one entry.
    ++	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=9000 maintenance run --auto --task=rerere-gc &&
     +	mkdir .git/rr-cache &&
    ++	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=9000 maintenance run --auto --task=rerere-gc &&
     +	: >.git/rr-cache/entry-1 &&
    -+	: >.git/rr-cache/entry-2 &&
    ++	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=9000 maintenance run --auto --task=rerere-gc &&
     +
     +	# Zero should never prune.
    -+	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc &&
    -+	# A positive value should require at least this many stale rerere entries.
    -+	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=3 maintenance run --auto --task=rerere-gc &&
    -+	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=2 maintenance run --auto --task=rerere-gc
    ++	: >.git/rr-cache/entry-1 &&
    ++	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc
     +'
     +
      test_expect_success '--auto and --schedule incompatible' '

---
base-commit: a2955b34f48265d240ab8c7deb0a929ec2d65fd0
change-id: 20250424-pks-maintenance-missing-tasks-8ffcdd596b73

