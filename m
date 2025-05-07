Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0743F21FF2C
	for <git@vger.kernel.org>; Wed,  7 May 2025 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602509; cv=none; b=BDrDmfQHycnZAo7ZrQrFYM8DewQDm0948O3V+j4+F81TbixtIkRGiDmqJ/hBsta0pR2IYXTfOKhv7VJQ3Tmx7QV4PGGqNukTsL9kABYqq+a2erl1RMk8dENMlTh6AerNtAELKVI8rU8kh4HtldRMTunLJlZcX0lwvRmRCvA3kLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602509; c=relaxed/simple;
	bh=+8fcs/UyJCTessyLWw9YhtMnf8Zl9H4n6mzNbf/ZmUE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Fqdc5lydGEKt8b/17Ui7yu21SbFNWU8ebOFQslP+K37BxKvmuEzzSkmh49UQoOib+s/gplSc/S7J7h7dAJE8pANIknS2qmSers1EgofAJjlivHKKdFWRTHVpY1Ke7a6DBazdlwrGQpdLWqHGbTJtU7gNYuZ46htc5AwSk82Rd1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oQMHN7oM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LzbtSdeN; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oQMHN7oM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LzbtSdeN"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C7B6F25400DB;
	Wed,  7 May 2025 03:21:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 07 May 2025 03:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746602506;
	 x=1746688906; bh=zOdXS3JDKAomXuF3DYRhdLfO6hAGqwfexW6GygnolX4=; b=
	oQMHN7oMp8yDsO0/WanZ7+IR7PZ5i2B0ywL7f3KIXk3pIKcALF0TrARAUkA9TWz1
	rY5cduGj7McUzU9NJmyMBSDy2bAG90ZW5wkc2GGo98wSiD/bLA6sMBElSym530eC
	Lbw4lhAT3Pb0AlRH1eqJQAalohmJdTMopAtz5+hxpvAM178CD81T9FSYwiFKClix
	rK1SJT3Bw/qgNkL+/qWy9svqfsGB8SHixl8YM8NQSSWxqKSyrCyOqVWwJLvIi+pj
	Cfsl0JaJ0Ce5toIl74fUCSpbCU7tRa6KaDwbXCuFn8d5PpPrhU4FtOg74D2LvDCU
	UgfF8Ugv3k53PGt5pLsBww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746602506; x=
	1746688906; bh=zOdXS3JDKAomXuF3DYRhdLfO6hAGqwfexW6GygnolX4=; b=L
	zbtSdeN0nQTI8IDlzDeZ1W4nuiRr4bpG139DLaoR02KwxX6cPZVOqGoj/5atiAYN
	VQtJp4dD3TvoEIgoN5tzirT3hmv/ZKqZFyudd7JEtv6Us5BlQiQULLDjni3KJsee
	J2lSij6TssOR3Jnc8GC0EemWTRhuWqhtN9NHDzngslmZ6DhKjDj9Dv2IX0UPWxJ2
	vZxue0HhVg0LiXvPcnQo9Cuhw66/Uk08N9vBzen3RWPW7hUKsspeSyplO6+Wvk9H
	blzFOMaJ29OaA4RihJogtg01pe4NH05/OMjDi+Il/NC6AysDY6VSlI8UkXeXs8Ug
	JUc8+wIJAVH0O1L7gzAqw==
X-ME-Sender: <xms:CgobaFwz5bErPv6uv6uECW6uwhaWKNOi7El3NLZXz_1OtX9L8rrYqg>
    <xme:CgobaFSigRPr5_IcXhpMzzjJA8rryyJc898-R50anwBbYbnJczgKKtnj7uAmxx1ky
    SK6-jX7Ez6W8X0Mcw>
X-ME-Received: <xmr:CgobaPXt2TqmonNhy39D8KAdTG26L2ImmpeH4OkiAGpMBaM8eyJ0b_5c_qRy-47-qMPhYFX0h5jlMZQEyEFwcxYidhdxxlKG62qRUo-bv67Qww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeivdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeevjeffudfftdekjeekhfdutdfhleefuddvveet
    ueegudekhfdvkeelgedtgeeuudenucffohhmrghinhepfihorhhkthhrvggvqdhprhhunh
    gvrdgruhhtohdprhgvrhgvrhgvqdhgtgdrrghuthhopdhkvghrnhgvlhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpth
    htohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:CgobaHjbU_Np4CxOPwAgrTVpnHlGZuh74WXk7Vr5H72qiC9zwjAsZA>
    <xmx:CgobaHAGxpASVojGKB9h4BnQgOno_y_aerTZm8OrXUeThUQAOKbz7A>
    <xmx:CgobaAL6Px4EMIixjKOPfFsnxEfCJx_zA4Ta5Z3u5eI1L5OpNd5PLg>
    <xmx:CgobaGDQUARB45TN2gMgdfvnfwFyVdHgO5Rh8EA6ZvFUC7nIVY4xWQ>
    <xmx:CgobaLWGwMCuZj-vejcpxkTC-gCWCknrCF3-Ym-q7dfIV9dv5_3uNkgD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 03:21:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 537b3a90 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 07:21:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 0/6] builtin/maintenance: implement missing tasks
 compared to git-gc(1)
Date: Wed, 07 May 2025 09:21:36 +0200
Message-Id: <20250507-pks-maintenance-missing-tasks-v5-0-aa5fdfb82891@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAKG2gC/4XPz27CMAwG8FdBOS/Icf605bT3mDikiQPW1ICaq
 tqE+u6kSBtw6vGzP/0s30ShkamIw+4mRpq58CXXYD92Ipx9PpHkWLNAQAsGjbx+Fzl4zhNlnwP
 JgUvhfJKTL3XTphRitJ3rGy2qcR0p8c/D/zrWfOYyXcbfx7lZrdM/2W7Is5IguwYpOt9jgPhZ+
 3sexMrO+EJp2KKwUmhb6Ju+DV77N0o/KQu4RelKKU1KQ9TOGXijzCu1+aBZKaOSiakD59U/tSz
 LHZPbX4uoAQAA
X-Change-ID: 20250424-pks-maintenance-missing-tasks-8ffcdd596b73
In-Reply-To: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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

Changes in v5:
  - Drop `get_worktree_names()` in favor of an open-coded loop.
  - Fix a memory leak.
  - Simplified the logic in `worktree_prune_condition()` a bit.
  - Link to v4: https://lore.kernel.org/r/20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (6):
      builtin/gc: fix indentation of `cmd_gc()` parameters
      builtin/gc: remove global variables where it is trivial to do
      builtin/gc: move pruning of worktrees into a separate function
      builtin/maintenance: introduce "worktree-prune" task
      builtin/gc: move rerere garbage collection into separate function
      builtin/maintenance: introduce "rerere-gc" task

 Documentation/config/maintenance.adoc |  17 ++++
 Documentation/git-maintenance.adoc    |   8 ++
 builtin/gc.c                          | 148 +++++++++++++++++++++++++++-------
 t/t7900-maintenance.sh                | 115 ++++++++++++++++++++++++++
 4 files changed, 257 insertions(+), 31 deletions(-)

Range-diff versus v4:

1:  59edf54e3ec = 1:  815904a68a1 builtin/gc: fix indentation of `cmd_gc()` parameters
2:  9f02c33f5b9 ! 2:  91f4c304232 builtin/gc: remove global variables where it trivial to do
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    builtin/gc: remove global variables where it trivial to do
    +    builtin/gc: remove global variables where it is trivial to do
     
         We use a couple of global variables to assemble command line arguments
         for subprocesses we execute in git-gc(1). All of these variables except
3:  b280af7bbc4 ! 3:  9232c8aac1d builtin/gc: move pruning of worktrees into a separate function
    @@ Metadata
      ## Commit message ##
         builtin/gc: move pruning of worktrees into a separate function
     
    -    Move pruning of worktrees into a separate function. This prepares for a
    -    subsequent commit where we introduce a new "worktree-prune" task for
    -    git-maintenance(1).
    +    In a subsequent commit we will introduce a new "worktree-prune" task for
    +    git-maintenance(1). To prepare for this, refactor the code that spawns
    +    `git worktree prune` into a separate function.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
4:  58ce12459c2 < -:  ----------- worktree: expose function to retrieve worktree names
5:  efeec465db0 ! 4:  24ca70b35b9 builtin/maintenance: introduce "worktree-prune" task
    @@ builtin/gc.c: static int maintenance_task_worktree_prune(struct maintenance_run_
      
     +static int worktree_prune_condition(struct gc_config *cfg)
     +{
    -+	struct strvec worktrees = STRVEC_INIT;
    -+	struct strbuf reason = STRBUF_INIT;
    ++	struct strbuf buf = STRBUF_INIT;
    ++	int should_prune = 0, limit = 1;
     +	timestamp_t expiry_date;
    -+	int should_prune = 0;
    -+	int limit = 1;
    ++	struct dirent *d;
    ++	DIR *dir = NULL;
     +
     +	git_config_get_int("maintenance.worktree-prune.auto", &limit);
     +	if (limit <= 0) {
    @@ builtin/gc.c: static int maintenance_task_worktree_prune(struct maintenance_run_
     +		goto out;
     +	}
     +
    -+	if (parse_expiry_date(cfg->prune_worktrees_expire, &expiry_date) ||
    -+	    get_worktree_names(the_repository, &worktrees) < 0)
    ++	if (parse_expiry_date(cfg->prune_worktrees_expire, &expiry_date))
     +		goto out;
     +
    -+	for (size_t i = 0; i < worktrees.nr; i++) {
    -+		char *wtpath;
    ++	dir = opendir(repo_git_path_replace(the_repository, &buf, "worktrees"));
    ++	if (!dir)
    ++		goto out;
     +
    -+		strbuf_reset(&reason);
    -+		if (should_prune_worktree(worktrees.v[i], &reason, &wtpath, expiry_date)) {
    ++	while (limit && (d = readdir_skip_dot_and_dotdot(dir))) {
    ++		char *wtpath;
    ++		strbuf_reset(&buf);
    ++		if (should_prune_worktree(d->d_name, &buf, &wtpath, expiry_date))
     +			limit--;
    -+
    -+			if (!limit) {
    -+				should_prune = 1;
    -+				goto out;
    -+			}
    -+		}
     +		free(wtpath);
     +	}
     +
    ++	should_prune = !limit;
    ++
     +out:
    -+	strvec_clear(&worktrees);
    -+	strbuf_release(&reason);
    ++	if (dir)
    ++		closedir(dir);
    ++	strbuf_release(&buf);
     +	return should_prune;
     +}
     +
    @@ t/t7900-maintenance.sh: test_expect_success 'reflog-expire task --auto only pack
     +
     +	# Zero should never prune.
     +	test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=0 maintenance run --auto --task=worktree-prune &&
    -+	# A positive value should require at least this man prunable worktrees.
    ++	# A positive value should require at least this many prunable worktrees.
     +	test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=4 maintenance run --auto --task=worktree-prune &&
     +	test_expect_worktree_prune git -c maintenance.worktree-prune.auto=3 maintenance run --auto --task=worktree-prune
     +'
6:  10ed12cc737 ! 5:  67e05501fbb builtin/gc: move rerere garbage collection into separate function
    @@ Metadata
      ## Commit message ##
         builtin/gc: move rerere garbage collection into separate function
     
    -    Move garbage collection of cached rerere entries into a separate
    -    function. This prepares us for a subsequent commit where we introduce a
    -    new "rerere-gc" task for git-maintenance(1).
    +    In a subsequent commit we are going to introduce a new "rerere-gc" task
    +    for git-maintenance(1). To prepare for this, refactor the code that
    +    spawns `git rerere gc` into a separate function.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
7:  be7fa13115c = 6:  818ed6b8999 builtin/maintenance: introduce "rerere-gc" task

---
base-commit: a2955b34f48265d240ab8c7deb0a929ec2d65fd0
change-id: 20250424-pks-maintenance-missing-tasks-8ffcdd596b73

