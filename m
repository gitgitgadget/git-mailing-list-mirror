Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F622B8B8
	for <git@vger.kernel.org>; Fri,  2 May 2025 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175454; cv=none; b=Cds78/42/dnUojjU8W7SdIV2ToV8JJDNEA67UhoC/bQk+RziR4Qg8AaeI7h+weaKAhDxsl93wwKvFNn6X4Jo+ZnllpphRW+oMnIsKB1s3xUmbbkGk69Tl+gJYWzXh0Rd+txxPfCv9d+t7pTu0LyU+xJb2t0jK8cvdF1Cmz+OF+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175454; c=relaxed/simple;
	bh=gzKIJQsEjT/g1iqwNg2T1nCfUPWO++PCGriQB73/Y60=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=PuQd+EcmFndXlEErX3YCIBzgJMm+ydNdwRZIPjp8HuFxGKrSP1GCUiaWwf191DV7eb5goBT5qkjw5ylpORZ2et+tIXo+AHDwsXrvYDld5w42+Rdd5J/7Mvire/pYE2PmVfz/JYojVMcJD3RCs1xI9sRG2LN6BQ5whHBNeMYNkk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E3CtWs6Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p7omempi; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E3CtWs6Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p7omempi"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AFBFE11401E2;
	Fri,  2 May 2025 04:44:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 02 May 2025 04:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746175448;
	 x=1746261848; bh=TacHJ4HQyzy0eclXcFxzZwUHEcMYScKfhhiZYtL3O2U=; b=
	E3CtWs6QOlPyAQERVtON9REXO4KhSmUA5uGdqfDRzeFi4ft1QkTy5+1mVV5OLW4N
	iErlwdqSFqMP8MH/PaYA6k5C4y3KwaKuW1gcoGmC3Y0tIUGCJrn+MI1oxDlPbUy2
	Q3S3NX6RCNFs/p4u322LKKalVOQoEZYW0U1lwlaKx5s+9DCQEv4wal9hNB+KJXii
	0/84Sg8/28nXghRy4NcVafcueReSbD0QIBcCtmMd8LL4r/b9J1E9pq/QMErAyxKv
	6RMV0PgXQMNNLzjIIvOt4DlsdaNzhvNC4eRDUpi4cO+/1jdEueBKlOrN19/rUeoh
	loNhATOiIkS+siAgFefalA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746175448; x=
	1746261848; bh=TacHJ4HQyzy0eclXcFxzZwUHEcMYScKfhhiZYtL3O2U=; b=p
	7omempiyuLMhlVMZu5vvFqj5SzaQNGbanBw/KwvEwb7MEXMftTkiiPOL9Uu0Y3Qf
	R68hOa7I+bn0zz7A+SjgiahJ9QZSlGYjbhbw7BLydXIKAH5JaWA0n0lndz+/6iov
	BmhL2W/rENZc8zIGPxJR+gOqGVu3nRnDBE77d1z6w6tfgrAYDiHLNDlmO+FRYByR
	hcb+2ffMa7igeX8VB6uVZJ48pcYE9JizczaWbC0PI2TERRgNr0SSBoXkrPKA2/1p
	z901pih41Ea2kxdD8QylHTU1JjJ3HnT6a6ku5h51d2b0k6f1x1dFLQGKAqwdHRHA
	P/KvvAidcsG/cFUsJeWng==
X-ME-Sender: <xms:2IUUaPPRC8tBu8Ii5J29s3usFHpWTP2f2cxWhJseOTtiuO2U9mR1xg>
    <xme:2IUUaJ_SoqCR3FKO0KRKNTX3XbYNpyHlar-dLZPeiYJBiPlZhWBazeSCgAMMvhmeK
    zI2W1DC6bMWFuabkQ>
X-ME-Received: <xmr:2IUUaOTfgrKcPXVLZ6TZz7A61Dgrao0KCLSt9VDYv-qOIXcfkLyjh24gK48tWmD0YvDEFW6Q5EJFbew1c9ovYFeXOhEr6FexHpvKbCmjIiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvtddtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:2IUUaDuY8_lAdp1IRsMSp8UUNzZIqAzoGJeV7-WyX5lKQ8Zvmf6FHQ>
    <xmx:2IUUaHeXJARBvnAhtbM2Tygj9bftnA973zQo92EaAl85WSDfqk_mag>
    <xmx:2IUUaP0DRPjlmDqTp3nQ3QVgXj8P5KjqiGcqT6kJ1lJ49hjJWEn99Q>
    <xmx:2IUUaD-SZFZYV8m627_Xk42n5bhErA3It3ckCwFJEkjLiUhDEWAkkw>
    <xmx:2IUUaKKFW2F8WMRPrO-qs9BYCfybX-sgtS2GaAkUJ9L-9d5vukbKuGvk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 04:44:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2761a600 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 08:44:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/7] builtin/maintenance: implement missing tasks
 compared to git-gc(1)
Date: Fri, 02 May 2025 10:43:57 +0200
Message-Id: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM2FFGgC/4XNzQ6CMAzA8VcxOzszNsaHJ9/DeBhbgcYwyEoWD
 eHdHSQabxz/bfPrwggCArHraWEBIhKOPoU6n5jtje+Ao0vNpJBa5DLn05P4YNDP4I23wAckQt/
 x2VDaVG1rndN10ZSKJWMK0OJr9++P1D3SPIb3/i5m2/Qr6wM5ZlzwupTgCtNIK9wt3V9wYBsb5
 R+lxBElEyV1JZqyqaxR5ket6/oB7URRrxIBAAA=
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

 Documentation/config/maintenance.adoc |  16 ++++
 Documentation/git-maintenance.adoc    |   8 ++
 builtin/gc.c                          | 157 +++++++++++++++++++++++++++-------
 builtin/worktree.c                    |  25 +++---
 t/t7900-maintenance.sh                | 114 ++++++++++++++++++++++++
 worktree.c                            |  30 +++++++
 worktree.h                            |   8 ++
 7 files changed, 314 insertions(+), 44 deletions(-)

Range-diff versus v2:

1:  fe67cebba69 = 1:  ac3cd73438b builtin/gc: fix indentation of `cmd_gc()` parameters
2:  623c53de24c = 2:  662dee455b6 builtin/gc: remove global variables where it trivial to do
3:  7c6b33075ca = 3:  522d40d8da7 builtin/gc: move pruning of worktrees into a separate function
4:  423963c589e = 4:  737df0a7dcc worktree: expose function to retrieve worktree names
5:  a031d9aa9fc = 5:  8a24fb6547b builtin/maintenance: introduce "worktree-prune" task
6:  6610b72a0f5 < -:  ----------- rerere: provide function to collect stale entries
7:  4e6c461e0b6 = 6:  3ce62afb54f builtin/gc: move rerere garbage collection into separate function
8:  4763c2aa09e ! 7:  90e86a52fcc builtin/maintenance: introduce "rerere-gc" task
    @@ Documentation/config/maintenance.adoc: maintenance.reflog-expire.auto::
     +	should be run as part of `git maintenance run --auto`. If zero, then
     +	the `rerere-gc` task will not run with the `--auto` option. A negative
     +	value will force the task to run every time. Otherwise, a positive
    -+	value implies the command should run when the number of prunable rerere
    -+	entries exceeds the value. The default value is 20.
    ++	value implies the command should run when there are at least this many
    ++	directory entries in the "rr-cache" directory. The default value is 1.
     +
      maintenance.worktree-prune.auto::
      	This integer config option controls how often the `worktree-prune` task
    @@ builtin/gc.c: static int maintenance_task_rerere_gc(struct maintenance_run_opts
     +static int rerere_gc_condition(struct gc_config *cfg UNUSED)
     +{
     +	struct strbuf path = STRBUF_INIT;
    -+	struct string_list prunable_dirs = STRING_LIST_INIT_DUP;
    -+	struct rerere_id *prunable_entries = NULL;
    -+	size_t prunable_entries_nr;
    -+	int should_gc = 0;
    -+	int limit = 20;
    ++	int should_gc = 0, limit = 1;
    ++	DIR *dir = NULL;
     +
     +	git_config_get_int("maintenance.rerere-gc.auto", &limit);
     +	if (limit <= 0) {
    @@ builtin/gc.c: static int maintenance_task_rerere_gc(struct maintenance_run_opts
     +		goto out;
     +	}
     +
    -+	/* Skip garbage collecting the rerere cache in case rerere is disabled. */
    ++	/*
    ++	 * We skip garbage collection in case we either have no "rr-cache"
    ++	 * directory or when it doesn't contain at least as many directories as
    ++	 * indicated by "maintenance.rerere-gc.auto".
    ++	 */
     +	repo_git_path_replace(the_repository, &path, "rr-cache");
    -+	if (!is_directory(path.buf))
    ++	dir = opendir(path.buf);
    ++	if (!dir)
     +		goto out;
     +
    -+	if (rerere_collect_stale_entries(the_repository, &prunable_dirs,
    -+					 &prunable_entries, &prunable_entries_nr) < 0)
    -+		goto out;
    ++	while (readdir_skip_dot_and_dotdot(dir)) {
    ++		if (--limit)
    ++			continue;
     +
    -+	should_gc = prunable_entries_nr >= limit;
    ++		should_gc = 1;
    ++		goto out;
    ++	}
     +
     +out:
    -+	string_list_clear(&prunable_dirs, 0);
    -+	free(prunable_entries);
     +	strbuf_release(&path);
    ++	if (dir)
    ++		closedir(dir);
     +	return should_gc;
     +}
     +
    @@ t/t7900-maintenance.sh: test_expect_success 'worktree-prune task honors gc.workt
      	test_path_is_missing .git/worktrees/worktree
      '
      
    -+setup_stale_rerere_entry () {
    -+	rr=.git/rr-cache/"$(printf "%0$(test_oid hexsz)d" "$1")" &&
    -+	mkdir -p "$rr" &&
    -+	>"$rr/preimage" &&
    -+	>"$rr/postimage" &&
    -+
    -+	test-tool chmtime ="$((-61 * 86400))" "$rr/preimage" &&
    -+	test-tool chmtime ="$((-61 * 86400))" "$rr/postimage"
    -+}
    -+
     +test_expect_rerere_gc () {
     +	negate=
     +	if test "$1" = "!"
    @@ t/t7900-maintenance.sh: test_expect_success 'worktree-prune task honors gc.workt
     +'
     +
     +test_expect_success 'rerere-gc task with --auto only prunes with prunable entries' '
    ++	test_when_finished "rm -rf .git/rr-cache" &&
     +	test_expect_rerere_gc ! git maintenance run --auto --task=rerere-gc &&
    -+	for i in $(test_seq 19)
    -+	do
    -+		setup_stale_rerere_entry $i || return 1
    -+	done &&
    ++	mkdir .git/rr-cache &&
     +	test_expect_rerere_gc ! git maintenance run --auto --task=rerere-gc &&
    -+	setup_stale_rerere_entry 20 &&
    ++	: >.git/rr-cache/entry &&
     +	test_expect_rerere_gc git maintenance run --auto --task=rerere-gc
     +'
     +
     +test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.auto' '
    ++	test_when_finished "rm -rf .git/rr-cache" &&
    ++
     +	# A negative value should always prune.
     +	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=-1 maintenance run --auto --task=rerere-gc &&
     +
    -+	for i in $(test_seq 20)
    -+	do
    -+		setup_stale_rerere_entry $i || return 1
    -+	done &&
    ++	mkdir .git/rr-cache &&
    ++	: >.git/rr-cache/entry-1 &&
    ++	: >.git/rr-cache/entry-2 &&
     +
     +	# Zero should never prune.
     +	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc &&
     +	# A positive value should require at least this many stale rerere entries.
    -+	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=21 maintenance run --auto --task=rerere-gc &&
    -+	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=10 maintenance run --auto --task=rerere-gc
    ++	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=3 maintenance run --auto --task=rerere-gc &&
    ++	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=2 maintenance run --auto --task=rerere-gc
     +'
     +
      test_expect_success '--auto and --schedule incompatible' '

---
base-commit: a2955b34f48265d240ab8c7deb0a929ec2d65fd0
change-id: 20250424-pks-maintenance-missing-tasks-8ffcdd596b73

