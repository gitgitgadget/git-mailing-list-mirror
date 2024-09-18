Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754D412FB1B
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 04:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726633948; cv=none; b=i4Yq2xq9/rd06HO66JNBkYK9npY5ZRW0SDCds9/HGtyZUW/Al12sT/GY6J7pLrh5iRNuKPlWBRaPFhqO50x8nBM3b/lOGW1nPfag0dOPK51Y+gKSfxsr5g7hrFRxbmlLFK/7tKbxlGeG/X6sbC1g0cUvXu140xdya4sChc4DhoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726633948; c=relaxed/simple;
	bh=JUqbuaDq5/8MwcRT0uSDO2kwnqgqRz0S7KdJTYaHhjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYbduJFTuXoJK2iQI1xfA8/ZU6TydQZDjPn+zPL853tugS2rrEoE4tnhW/3Qvr8F8OPosc/IhRzpllGZaj0l4DeNIJTad6hA95kMukKnwv8UI/M+5hmtZrQBBU60BkYZ0lI+v++PbkOgieIgVjlbzJ3zhmAb7ypAZDP5zzfzZpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LpThFTe2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CgKK6THq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LpThFTe2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CgKK6THq"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B5EC11140181;
	Wed, 18 Sep 2024 00:32:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 18 Sep 2024 00:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726633945; x=1726720345; bh=sD2BJpIuQy
	NRqAto9zy6LL5NdsJCoYTnkH2k9F1ahr8=; b=LpThFTe26uVMKyxFsq2vhP3IIQ
	16o/GI4L4RDR0xeXIodKEFRwha0uNtEixcLwFJ0n9xlwFqEhVQ1j7e5TCWmSyveg
	HC+IEIxTN4FkDJ4196PMcH3Y4aKuBmYvqhxYx2Z1By3qKkSgYI4gtMGz4zr8QAFj
	xhpm1ThRBwuyTx5pBNvaRmuBN56k1UKmqC/TdE6MFvhfATdVLd276U+04rgjcyg/
	WcPgNPNnhS6L9Zrju7hWUW62hpK5w1B1VctS5c0/eqW4Epq6u8qTZc1s1Lm6G6EA
	IdFEr/paxtq6szLPumvDFwkM+YXG2LC5N9HCE7MO9SXjRzMppoBtwWNRoamg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726633945; x=1726720345; bh=sD2BJpIuQyNRqAto9zy6LL5NdsJC
	oYTnkH2k9F1ahr8=; b=CgKK6THq23O2Ug0PtfeugwdXpP4Haq6yHsjaNpk9OOnV
	ukbGtauS5ZxHZGtLlzDFGUAf4q0es7VvknRlmHuLulpXjjHnJbcPloOkvBzXQ9HD
	GCyIHJLbWBpnoKCrePKxt1KN0Tbm2M0/AtaAJX8+Co3m1NShViQXaQNvkT5UXiwt
	sRvnzueJGIvvzOM9XoHaI8SdkEVQhbq8PbJOqKyORku2/1PNWMJRF2W4wQOMq0ab
	ITMtd0aiuocPI+pgr1HhyAT74Nd3rAgLvZ98lXFak3Jj8Pnr+dt7xPc3pAmM/4cm
	EswQrOKF955x+1tqEG/w1CNLzUIjhbEVn7QqfYSjWQ==
X-ME-Sender: <xms:2VfqZhNoQgJ6l9lnljV-f9NTm8PYsluCWzQoVDZwiPAfoHF5NI7VSQ>
    <xme:2VfqZj9-QVOt97OBdSVbazP3WDAk1HAxuAaYAPNCchQ9Gscsp286PBzF46f-0HNGm
    8r-g3I1sSmK3zZq4Q>
X-ME-Received: <xmr:2VfqZgSzw0XoZTCRS2hXDT_aKGY-5tmzaRUe3nCfkFPFnf4_YAu0iHxqUy9GyRxUIpQyir4N1A8pUO8Rk_jKaM3nUKD9couC9K27ih4Q9_hGzMVT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekkedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:2VfqZts8vEtLYALRFnB030x2f62OLx1ELXdJQVaAJDWe80bl7ZSeOQ>
    <xmx:2VfqZpdv-p0COZ4kNfVbkHPdGToh3xTQTSERupDPUqtE6I88wHD04A>
    <xmx:2VfqZp3J_ZXbrcd_W1CohRZEu67WsLP_fN5kMfYC2ysc9BITJqu8Gw>
    <xmx:2VfqZl93i1UtWIP2BQ4mLOBkJyI1zR15ydzfgeNDnLe0z2UvoyQwkg>
    <xmx:2VfqZt7lSIKWKEh_ilBQoIM8ILa_2kcabOjkQJxoo6Kf-BHqNtRU6fg8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 00:32:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bbe62ac0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Sep 2024 04:32:04 +0000 (UTC)
Date: Wed, 18 Sep 2024 06:32:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/3] refs/reftable: introduce "reftable.lockTimeout"
Message-ID: <700a35df125eca6639d08d30720332dbc1ed15a1.1726633812.git.ps@pks.im>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1726633812.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726633812.git.ps@pks.im>

When multiple concurrent processes try to update references in a
repository they may try to lock the same lockfiles. This can happen even
when the updates are non-conflicting and can both be applied, so it
doesn't always make sense to abort the transaction immediately. Both the
"loose" and "packed" backends thus have a grace period that they wait
for the lock to be released that can be controlled via the config values
"core.filesRefLockTimeout" and "core.packedRefsTimeout", respectively.

The reftable backend doesn't have such a setting yet and instead fails
immediately when it sees such a lock. But the exact same concepts apply
here as they do apply to the other backends.

Introduce a new "reftable.lockTimeout" config that controls how long we
may wait for a "tables.list" lock to be released. The default value of
this config is 100ms, which is the same default as we have it for the
"loose" backend.

Note that even though we also lock individual tables, this config really
only applies to the "tables.list" file. This is because individual
tables are only ever locked when we already hold the "tables.list" lock
during compaction. When we observe such a lock we in fact do not want to
compact the table at all because it is already in the process of being
compacted by a concurrent process. So applying the same timeout here
would not make any sense and only delay progress.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/reftable.txt |  7 +++++++
 refs/reftable-backend.c           |  4 ++++
 reftable/reftable-writer.h        |  8 ++++++++
 reftable/stack.c                  | 18 ++++++++++++------
 t/t0610-reftable-basics.sh        | 27 +++++++++++++++++++++++++++
 5 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/reftable.txt b/Documentation/config/reftable.txt
index 05157279778..abb793bcbb0 100644
--- a/Documentation/config/reftable.txt
+++ b/Documentation/config/reftable.txt
@@ -46,3 +46,10 @@ reftable.geometricFactor::
 By default, the geometric sequence uses a factor of 2, meaning that for any
 table, the next-biggest table must at least be twice as big. A maximum factor
 of 256 is supported.
+
+reftable.lockTimeout::
+	Whenever the reftable backend appends a new table to the stack, it has
+	to lock the central "tables.list" file before updating it. This config
+	controls how long the process will wait to acquire the lock in case
+	another process has already acquired it. Default is 100 (i.e., retry
+	for 100ms).
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 1c4b19e737f..e90ddfb98dd 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -256,6 +256,9 @@ static int reftable_be_config(const char *var, const char *value,
 		if (factor > UINT8_MAX)
 			die("reftable geometric factor cannot exceed %u", (unsigned)UINT8_MAX);
 		opts->auto_compaction_factor = factor;
+	} else if (!strcmp(var, "reftable.locktimeout")) {
+		unsigned long lock_timeout = git_config_ulong(var, value, ctx->kvi);
+		opts->lock_timeout_ms = lock_timeout;
 	}
 
 	return 0;
@@ -281,6 +284,7 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	refs->write_options.default_permissions = calc_shared_perm(0666 & ~mask);
 	refs->write_options.disable_auto_compact =
 		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
+	refs->write_options.lock_timeout_ms = 100;
 
 	git_config(reftable_be_config, &refs->write_options);
 
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 189b1f4144f..d5f2446220b 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -51,6 +51,14 @@ struct reftable_write_options {
 	 * tables to compact. Defaults to 2 if unset.
 	 */
 	uint8_t auto_compaction_factor;
+
+	/*
+	 * The number of milliseconds to wait when trying to lock "tables.list".
+	 * Note that this does not apply to locking individual tables, as these
+	 * should only ever be locked when already holding the "tables.list"
+	 * lock.
+	 */
+	unsigned lock_timeout_ms;
 };
 
 /* reftable_block_stats holds statistics for a single block type */
diff --git a/reftable/stack.c b/reftable/stack.c
index ce0a35216ba..5ccad2cff31 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -603,8 +603,10 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 
 	add->stack = st;
 
-	err = hold_lock_file_for_update(&add->tables_list_lock, st->list_file,
-					LOCK_NO_DEREF);
+	err = hold_lock_file_for_update_timeout(&add->tables_list_lock,
+						st->list_file,
+						LOCK_NO_DEREF,
+						st->opts.lock_timeout_ms);
 	if (err < 0) {
 		if (errno == EEXIST) {
 			err = REFTABLE_LOCK_ERROR;
@@ -1056,8 +1058,10 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * Hold the lock so that we can read "tables.list" and lock all tables
 	 * which are part of the user-specified range.
 	 */
-	err = hold_lock_file_for_update(&tables_list_lock, st->list_file,
-					LOCK_NO_DEREF);
+	err = hold_lock_file_for_update_timeout(&tables_list_lock,
+						st->list_file,
+						LOCK_NO_DEREF,
+						st->opts.lock_timeout_ms);
 	if (err < 0) {
 		if (errno == EEXIST)
 			err = REFTABLE_LOCK_ERROR;
@@ -1156,8 +1160,10 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * "tables.list". We'll then replace the compacted range of tables with
 	 * the new table.
 	 */
-	err = hold_lock_file_for_update(&tables_list_lock, st->list_file,
-					LOCK_NO_DEREF);
+	err = hold_lock_file_for_update_timeout(&tables_list_lock,
+						st->list_file,
+						LOCK_NO_DEREF,
+						st->opts.lock_timeout_ms);
 	if (err < 0) {
 		if (errno == EEXIST)
 			err = REFTABLE_LOCK_ERROR;
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 37510c2b2a5..62da3e37823 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -423,6 +423,33 @@ test_expect_success 'ref transaction: fails gracefully when auto compaction fail
 	)
 '
 
+test_expect_success 'ref transaction: timeout acquiring tables.list lock' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		>.git/reftable/tables.list.lock &&
+		test_must_fail git update-ref refs/heads/branch HEAD 2>err &&
+		test_grep "cannot lock references" err
+	)
+'
+
+test_expect_success 'ref transaction: retry acquiring tables.list lock' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		LOCK=.git/reftable/tables.list.lock &&
+		>$LOCK &&
+		{
+			( sleep 1 && rm -f $LOCK ) &
+		} &&
+		git -c reftable.lockTimeout=5000 update-ref refs/heads/branch HEAD
+	)
+'
+
 test_expect_success 'pack-refs: compacts tables' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.46.0.551.gc5ee8f2d1c.dirty

