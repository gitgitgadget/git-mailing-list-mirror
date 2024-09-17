Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6465E2905
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580605; cv=none; b=i4nKHPRhqdna4dAWc2TIZANNIWTnasFEwI6Wm3NX+vU6y6DR/YPSvWBg2ARJ3mBz3/oADqtDWTihSDTXPpYzKYMD3Nj5mgAvfkgKV0zqwan2hxd97t7WvDjAUcUNdxDlXOnCPpEI82yAVELEFI/dmtBPjewxxcItP2/kpm/o4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580605; c=relaxed/simple;
	bh=aXAoMR9aqamK99/Xf5QbTcExYc8LFuINUEIWwMndDc8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYYsIxsYSBPg+XvKC6wa4FPxR3ceSiECKfBOUP7AAaTnmmOqcVbPqSzJPrm6XDHp3amgPWCCKvVnhbK1QDAwlO2y1iTy9dhMr2gze5pnXu2TuDBysw9kbjqiKLqybeeH+TxawFyxeD087KSvwsuaEm4FL54S/xVhz6fAxaGf/Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l158/PYL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dy9RWRun; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l158/PYL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dy9RWRun"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5DE0B114013D
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:43:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 17 Sep 2024 09:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726580602; x=1726667002; bh=kpOBAWBEdn
	SGkjuWLb3Y5A/quuJLV6EvpD3+BoCBZPU=; b=l158/PYLqD1M4sNUI9N3qhom3m
	tR3qct56Jhrjv0YwzcCBnjuYdU4jjUwIKsAPUwLHZx783nqbLQ08jTLnBvoxRuCO
	Y66jte3mv8qx8n+jTRJbL0aykzoinFUkwkW6i6sP6Y0WwqgFfkVLzpAkxD9AOXVi
	mLNoFpZD1NMDKV82qZ8oqS077OQkKhUXMTC9dk9YT5KvRMkh8g2rcetQI2nIWDUf
	QzQTO5NRhTKJR+WBhzIPg4gFBwEFgaiSGLBC5BadmEk4FQroC1WUxkPRoWhunaoq
	vRPlCjJPFlH2hYUT7kLBjcMQB23GtxpTi+U6RfXQmjwdeFeCKiO3asVdoCtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726580602; x=1726667002; bh=kpOBAWBEdnSGkjuWLb3Y5A/quuJL
	V6EvpD3+BoCBZPU=; b=dy9RWRunfTpQou8F2gH0ExoFaGOKMWOeTA1vEYkAOksY
	wctMb/AAv/COJQKNr6cC2wTOZaAsxwSlehJBbo4MU7e3bv7sl/PlcVW5AKiBAIMY
	rFKxZT1fPgwhM2iGapntpp5BYfRudxrl+4UgOs4gojTlZwNWicTI7R0lNjykUjkK
	QyAOwmtJuIrTNNgmazh8WoWlFojFo1vxi6v2nnD2go5Vi2SDXoYyjdANnUwKqM2Q
	8F+qxkeB6/ILr5jo8QvB0ECeJMzZwcJw6jqyg4S6/1MDZUuqFmvwMLvItFZ8U04C
	0ajED/BMQiT6hy07cv/DzK4CX5y1Xt0EZD+s0vVvLg==
X-ME-Sender: <xms:eofpZhlpZhOO9HLqX-3MqtnTz0MVBa3NxxKxuf4rA_3rSQAMdxyKdA>
    <xme:eofpZs1RCR6bAs4JbkaWCBUfUqqbWOv79dCtzqPbmJ2DZM0TDOkBPI3jfg8lwHmoV
    re6fdDQPG87hsV0bw>
X-ME-Received: <xmr:eofpZnpa0k8VQZcFY0NmAnevgknMrbDyUR5stwFsMOxDYkstUJ0GVBRm7StDHbC3vqOC3hO7qpy6RwNRCxf4nNwgqNWMCUq81a0mLpzysGHr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eofpZhmONXP6TMEkBbyLkc_HlHUBb346a87HoJErHUqOKxLHIf7M1w>
    <xmx:eofpZv26xxQvIt5V22FkOT58ln84tRVitU4AZlzthZm-bVO-sSsKXw>
    <xmx:eofpZguILJPxvw42yPpF_wsx06AihiqKedqDmjcfZrB_yZ-i_Qeyaw>
    <xmx:eofpZjVg8RKNBxChCgn3zv1MsSweCB1LScKfP31v-Npc3P528E1-0w>
    <xmx:eofpZo_jHEmlOiK_GA6avTP70rFAkf-4e81Vi-_XfxetXwYbJDYo_0UB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Sep 2024 09:43:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9829723c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Sep 2024 13:43:01 +0000 (UTC)
Date: Tue, 17 Sep 2024 15:43:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/3] refs/reftable: introduce "reftable.lockTimeout"
Message-ID: <ca3eab99f7ef86d1b7a5b4d4bdb8d2b0a55566e1.1726578382.git.ps@pks.im>
References: <cover.1726578382.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726578382.git.ps@pks.im>

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
index 05157279778..6c9449d0232 100644
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
+	another process has already acquired it. Default is 1000 (i.e., retry
+	for 1 second).
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

