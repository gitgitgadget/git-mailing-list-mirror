Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE217A92E
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653573; cv=none; b=YOQZRh58MylpxzJoPLdT9sDj2dkUo1h/BhjMj5kngoYZioM0+KWjUbhy2ys2WVAA5VERLkj60qckhU3kRDkmUdELYBfKVOsA0acHWksxBatZgs0oKLFVI0hAJJblkqHvFrI9IE44uvCgx1G1ShdxsCPYvqNRdGjdFkQTZ2bFAXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653573; c=relaxed/simple;
	bh=OYHprMcU3KfL1NT+BK3QDx+jtqRsldwhCV6VXqAEDm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbBPfbcXEZEQRMmkhNd+whjWDEJpwJErcFFY6P7vNa8yA2Bsv1YWMpVaElZi9B+lj+MduOfjfhQ+Awkcoj+ssS64FeWnvHgzkVMsV6Ncg0haw+9zdsCu3PnHpyFdUjLwlTqL4hZahR7p9E4kpOKnz3LTtoL1/pgZinypBkvU46U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OeVtf2dF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LBz2Ir1B; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OeVtf2dF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LBz2Ir1B"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5B70F11402E6;
	Wed, 18 Sep 2024 05:59:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 18 Sep 2024 05:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726653570; x=1726739970; bh=OIiz8siCq3
	svQraTGa8A6pzjhnpaCX0GstoY9rk1/RI=; b=OeVtf2dFwgqdXyTQ8N25z4MO6H
	AJCsOdSXGai12KOGTKxJ49Qe81RgbLY1Vd9XZDyMv0f4G/6sqZFsBXlUQ8Nf1qLW
	GSUxjNT7p1Ic1DezKfe/rlMc802OLEUyIf+PHL2uFNWjfsVwGZ/N9OyzRd7MCkNH
	WEiKjXQEzOw29ycxPK2fEngm8rT1kb5F7FXknQn/G4PTfAqzRrk9TH4cJ8dJwDK1
	yp6AsHfvn0PzJONmZYziQECOPVk3Q/o87xjrclo401LGxya+P+8zgvLMaEXVttzz
	JQgIQ+ykYiPnZntLEzQQwgdBReHuuwqM7DtM1YC/nOhpRt6CMe2Vjpc1EDlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726653570; x=1726739970; bh=OIiz8siCq3svQraTGa8A6pzjhnpa
	CX0GstoY9rk1/RI=; b=LBz2Ir1BwL/TgJOTB+A+d/dtqQD9JEqaZFuALqmQYh1v
	viEl0130QNEhuVUEKmlWIg3d7JLG3DpSZcpKrotLpS6457t1pCpBwXL5ldIvqCRC
	ZXHahtUnvQCFBFLLDbQzo+QT8RSr0Vaji0R+nZe/WBRLo0kTXJFIGSkvq+9GsVQq
	uIdhk/466Y4q/udA+/pDHKoEOzq4jkNEC3/b5r3JAatIrgeHAEl3p3vaca5Yv3Xf
	qInEMsb5Q11TlxQII/7FGTQgDewwNfxhOlnX72clhl5exGIehnovKnwUwNlklFAA
	Oc8lJZVv7rGE1gCxu4jtGMDFgDWWIc8LeNRNq7Zygg==
X-ME-Sender: <xms:gqTqZkJ7r6RvCBipslXLo6qPL6oC1OvCiqWMlK7jEhsc6jEC2lyJiQ>
    <xme:gqTqZkLjQuzYHqY2TZqNEJmEg4onEkF04CEU90PG2kbRJF46CpF-ok34y3KIjrcN8
    e2izCamnNqf-G6bPA>
X-ME-Received: <xmr:gqTqZktn4GRklg0IMMgWcc-w1DTXxpVFLJqETgB71Rlqz_EZXZEss9BSxTbcf-IsHhux8J1sT_GjIrv6jzo47KzeIi7hgbsbP2VrdqWdaDHU6uAa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekledgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehjrghmvg
    hssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:gqTqZhbJYBheHs4AIKoYewmOu9Go9mHXdcikFe05G7eGXEIHGugOhg>
    <xmx:gqTqZrYmawbw2KP757KQh7v_G_lrGD1FlufffHBcFAYR43SaJCdKTQ>
    <xmx:gqTqZtCbFQVyMBeU89OKUgvNuutQacO9gOpLIIz57awhROaIIheksw>
    <xmx:gqTqZhbJjQqJv8Uny85yeMZyWwl5gItR0s51wiejagHSy3W5hX5BIA>
    <xmx:gqTqZqUkS3saVvSni79zIrc0bYd85UYp4zSmnsNvEmPhzRPb4hXNLFgt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 05:59:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bb0e2ecc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Sep 2024 09:59:07 +0000 (UTC)
Date: Wed, 18 Sep 2024 11:59:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	James Liu <james@jamesliu.io>
Subject: [PATCH v3 1/3] refs/reftable: introduce "reftable.lockTimeout"
Message-ID: <77cffd3b1eb638e05c031e2949fdc9374d599e05.1726653185.git.ps@pks.im>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1726653185.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726653185.git.ps@pks.im>

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
 Documentation/config/reftable.txt |  8 ++++++++
 refs/reftable-backend.c           |  8 ++++++++
 reftable/reftable-writer.h        | 11 +++++++++++
 reftable/stack.c                  | 18 ++++++++++++------
 t/t0610-reftable-basics.sh        | 27 +++++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/reftable.txt b/Documentation/config/reftable.txt
index 05157279778..57087803a54 100644
--- a/Documentation/config/reftable.txt
+++ b/Documentation/config/reftable.txt
@@ -46,3 +46,11 @@ reftable.geometricFactor::
 By default, the geometric sequence uses a factor of 2, meaning that for any
 table, the next-biggest table must at least be twice as big. A maximum factor
 of 256 is supported.
+
+reftable.lockTimeout::
+	Whenever the reftable backend appends a new table to the stack, it has
+	to lock the central "tables.list" file before updating it. This config
+	controls how long the process will wait to acquire the lock in case
+	another process has already acquired it. Value 0 means not to retry at
+	all; -1 means to try indefinitely. Default is 100 (i.e., retry for
+	100ms).
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 1c4b19e737f..ca281e39a29 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -256,6 +256,13 @@ static int reftable_be_config(const char *var, const char *value,
 		if (factor > UINT8_MAX)
 			die("reftable geometric factor cannot exceed %u", (unsigned)UINT8_MAX);
 		opts->auto_compaction_factor = factor;
+	} else if (!strcmp(var, "reftable.locktimeout")) {
+		int64_t lock_timeout = git_config_int64(var, value, ctx->kvi);
+		if (lock_timeout > LONG_MAX)
+			die("reftable lock timeout cannot exceed %"PRIdMAX, (intmax_t)LONG_MAX);
+		if (lock_timeout < 0 && lock_timeout != -1)
+			die("reftable lock timeout does not support negative values other than -1");
+		opts->lock_timeout_ms = lock_timeout;
 	}
 
 	return 0;
@@ -281,6 +288,7 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	refs->write_options.default_permissions = calc_shared_perm(0666 & ~mask);
 	refs->write_options.disable_auto_compact =
 		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
+	refs->write_options.lock_timeout_ms = 100;
 
 	git_config(reftable_be_config, &refs->write_options);
 
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 189b1f4144f..f5e25cfda16 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -51,6 +51,17 @@ struct reftable_write_options {
 	 * tables to compact. Defaults to 2 if unset.
 	 */
 	uint8_t auto_compaction_factor;
+
+	/*
+	 * The number of milliseconds to wait when trying to lock "tables.list".
+	 * Note that this does not apply to locking individual tables, as these
+	 * should only ever be locked when already holding the "tables.list"
+	 * lock.
+	 *
+	 * Passing 0 will fail immediately when the file is locked, passing a
+	 * negative value will cause us to block indefinitely.
+	 */
+	long lock_timeout_ms;
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

