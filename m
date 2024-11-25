Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E891426C
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 06:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732516051; cv=none; b=HV5bgtwSJ4HLxt5gjVsaRqEq03NyfuaOw6ADdLuiL4cLj5wq5EaM6WF2IJkHZmMhFeol0QqbrBaUnLrQYqvlewsyUDmC2jdG2Gwnn+yLhuSWBOcXPCP4a7w4MxYvXAzo5Is3BeBTXUAwc+IAd84OKZKNuz6qiyuJd0kImAOhGPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732516051; c=relaxed/simple;
	bh=UVoZLP028VRFwVNJwEuD1w5yPGoEInEkyWu3NHuG6dg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=CN3OjY5Hbmf8z2B8LSM11CZ7t95wMxzwhSNmXh4GKJruFl84MOqg/3eE3GBOHeSzKkvfk5+ZKMl+k0lICpEGiCRZjNDeqC0ZzkNAA4Bg2KhmmyioMWiTNp5Ob/tlZ6vub2FEyk/zga8sAmkYBAVEllE3y1ZpjKGlm1ehCCZd/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n5b11tyH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dqDfcYd8; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n5b11tyH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dqDfcYd8"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 17E911140169;
	Mon, 25 Nov 2024 01:27:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 25 Nov 2024 01:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732516044;
	 x=1732602444; bh=DgpFzu4jQ/4U4jrgM1YCP4nkYcey1qxiPWmEtSc31vQ=; b=
	n5b11tyH0GQ1n+hjI1gzNMM+dYDIIvQ1U4huQ5HtdSqaHmT9XI08IUYl12Mj2VJ5
	QlhkTMoog0f26bmk/h2FI+5wyM8Bgal6cn1s64tcFNtcWduo76b2LumcEfYv/jCP
	I0fo8c1CxhRB2gamLFP4K5oqKtziPa+/6sDfhYSn7AB/uFkWwdtXUOzqFYVJPOBS
	vPm+GwgNPZPX3yrUUXruY5heoVwcfQPnT2e/mEw6DUWqoUPI7FA02iyVnSlegc/7
	8FSKdoCik/9+4T/Z/SerutJTJ7xnXyScTXXjMCiaQE3MVolv2C5bqh9seleZ4ciI
	H4eUbGA6Rs0R+AfL/+cUsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732516044; x=
	1732602444; bh=DgpFzu4jQ/4U4jrgM1YCP4nkYcey1qxiPWmEtSc31vQ=; b=d
	qDfcYd8JJ3vBvdawbHxxT4ulg5rW8k3Q56F6ZagwmU1ChKoMYbddbAwcedw3C89b
	Lv1vGuwP4Yi2eWorN0UDJ0EJcbx3lIeehOAwkCg8Kjo4OYtpBg4Z48Hz3yZhPJ04
	ySHNwrBMBdaeC0xLH+DNjNtpiEZJg+T00bAE006uDK8/C8PgBYJ/0UkPttKqVk4V
	pVGVTyh8k8UQkvmiIVoH4+0QIzA38cZDtCThSikhVG8EQ8LU4cqArtRCPLd3vvoZ
	1greYP/w5XB7r0sWoXzqYer0U/xrH3Cg2LouxQM2ywxaaBocAAj8l+PbBcP9lG2D
	hlhGQEeWRTIDGFEHOrFGA==
X-ME-Sender: <xms:zBhEZ3ftq5IuuqTR6zrVOakOGyO5eL0e-33HjfY8Z1-TgpBLg1DDUg>
    <xme:zBhEZ9MhN04YXRaRTM_isi57QzhfeyXhhoEw_BHQAX6BWwQunhi23KYLKCOsRDZYl
    5CdkAEsOA9yOA0XCw>
X-ME-Received: <xmr:zBhEZwhRwfUSoFcCqei19tsx56oMQFZiQm-CQgM8-P6U90fPkPNdLH8feWgZU48zweV1J2SzC4gNUwY5MZ44OjqpDp_nNgGfCjlY4XzgDOUwMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthekredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepudduveejffffgeejgeehieetuefftddvheelgeeffeev
    tdegteelhfekveettdehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhes
    thhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:zBhEZ48cYDoilFoS-79SfJffjt2xq-3INlP4pc0Bj4n53SmF3KmxFg>
    <xmx:zBhEZztnrMbj_edyjLOJqGN1Hohvimw9oPwY73x1V8IE1cwxz8Yv3g>
    <xmx:zBhEZ3GScVEwvxDhfTX7LUa89-_63HIEL4ZKQ24LCXPcMQwY73XeDQ>
    <xmx:zBhEZ6Nxtic-FLrAvyu7J1od4c3eZPl_VYnQBb_JiT4L3kFt4hUCHw>
    <xmx:zBhEZ5UYecQv1Wh3rXfMQp5IsoXKhXVEX9Cmlo9BNNtbB9_T-kLPKGGa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 01:27:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b691f221 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 06:26:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/10] refs: optimize ref format migrations
Date: Mon, 25 Nov 2024 07:27:05 +0100
Message-Id: <20241125-pks-refs-optimize-migrations-v3-0-17bc85e33ad7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALkYRGcC/43Nyw6CMBAF0F8hXTumLyxx5X8YFwUGmBgeaUmjE
 v7dgYVxp8s7uffMIiIGwijO2SICJoo0DhzMIRNV54cWgWrOQkttlZIFTPcIAZsI4zRTTy+Entr
 gZ95FONWyQkTry9IJJiZu0mPnrzfOHcV5DM/9W1Lb9U84KZDgmtq4xhcSTX7h+pF6salJf0la/
 pA0S14bY5wtnc31R1rX9Q1xIYPCDwEAAA==
X-Change-ID: 20241108-pks-refs-optimize-migrations-6d0ceee4abb7
In-Reply-To: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Hi,

I have recently learned that ref format migrations can take a
significant amount of time in the order of minutes when migrating
millions of refs. This is probably not entirely surprising: the initial
focus for the logic to migrate ref backends was mostly focussed on
getting the basic feature working, and I didn't yet invest any time into
optimizing the code path at all. But I was still mildly surprised that
the migration of a couple million refs was taking minutes to finish.

This patch series thus optimizes how we migrate ref formats. This is
mostly done by expanding upon the "initial transaction" semantics that
we already use for git-clone(1). These semantics allow us to assume that
the ref backend is completely empty and that there are no concurrent
writers, and thus we are free to perform certain optimizations that
wouldn't have otherwise been possible. On the one hand this allows us to
drop needless collision checks. On the other hand, it also allows us to
write regular refs directly into the "packed-refs" file when migrating
from the "reftable" backend to the "files" backend.

This leads to some significant speedups. Migrating 1 million refs from
"files" to "reftable":

    Benchmark 1: migrate files:reftable (refcount = 1000000, revision = origin/master)
      Time (mean ± σ):      4.580 s ±  0.062 s    [User: 1.818 s, System: 2.746 s]
      Range (min … max):    4.534 s …  4.743 s    10 runs

    Benchmark 2: migrate files:reftable (refcount = 1000000, revision = pks-refs-optimize-migrations)
      Time (mean ± σ):     767.7 ms ±   9.5 ms    [User: 629.2 ms, System: 126.1 ms]
      Range (min … max):   755.8 ms … 786.9 ms    10 runs

    Summary
      migrate files:reftable (refcount = 1000000, revision = pks-refs-optimize-migrations) ran
        5.97 ± 0.11 times faster than migrate files:reftable (refcount = 1000000, revision = origin/master)

And migrating from "reftable" to "files:

    Benchmark 1: migrate reftable:files (refcount = 1000000, revision = origin/master)
      Time (mean ± σ):     35.409 s ±  0.302 s    [User: 5.061 s, System: 29.244 s]
      Range (min … max):   35.055 s … 35.898 s    10 runs

    Benchmark 2: migrate reftable:files (refcount = 1000000, revision = pks-refs-optimize-migrations)
      Time (mean ± σ):     855.9 ms ±  61.5 ms    [User: 646.7 ms, System: 187.1 ms]
      Range (min … max):   830.0 ms … 1030.3 ms    10 runs

    Summary
      migrate reftable:files (refcount = 1000000, revision = pks-refs-optimize-migrations) ran
       41.37 ± 2.99 times faster than migrate reftable:files (refcount = 1000000, revision = origin/master)

Changes in v2:

  - Mention in the first commit message that the introduced flag will be
    used in a subsequent patch.
  - Link to v1: https://lore.kernel.org/r/20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im

Changes in v3:

  - Mention that we store the ref transaction flag for access by the
    backend in the first commit message.
  - Fix a missing word in another commit message.
  - Use `unsigned int` to pass `initial_transaction` flag.
  - Rename the scratch buffers and provide a comment for why they exist.
  - Link to v2: https://lore.kernel.org/r/20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (10):
      refs: allow passing flags when setting up a transaction
      refs/files: move logic to commit initial transaction
      refs: introduce "initial" transaction flag
      refs/files: support symbolic and root refs in initial transaction
      refs: use "initial" transaction semantics to migrate refs
      refs: skip collision checks in initial transactions
      refs: don't normalize log messages with `REF_SKIP_CREATE_REFLOG`
      reftable/writer: optimize allocations by using a scratch buffer
      reftable/block: rename `block_writer::buf` variable
      reftable/block: optimize allocations by using scratch buffer

 branch.c                  |   2 +-
 builtin/clone.c           |   4 +-
 builtin/fast-import.c     |   4 +-
 builtin/fetch.c           |   4 +-
 builtin/receive-pack.c    |   4 +-
 builtin/replace.c         |   2 +-
 builtin/tag.c             |   2 +-
 builtin/update-ref.c      |   4 +-
 refs.c                    |  70 ++++++-------
 refs.h                    |  45 +++++----
 refs/debug.c              |  13 ---
 refs/files-backend.c      | 244 +++++++++++++++++++++++++---------------------
 refs/packed-backend.c     |   8 --
 refs/refs-internal.h      |   2 +-
 refs/reftable-backend.c   |  14 +--
 reftable/block.c          |  33 +++----
 reftable/block.h          |  10 +-
 reftable/writer.c         |  23 +++--
 reftable/writer.h         |   2 +
 sequencer.c               |   6 +-
 t/helper/test-ref-store.c |   2 +-
 t/t1460-refs-migrate.sh   |   2 +-
 walker.c                  |   2 +-
 23 files changed, 249 insertions(+), 253 deletions(-)

Range-diff versus v2:

 1:  74d23ad64d !  1:  64ebf2d3c6 refs: allow passing flags when setting up a transaction
    @@ Metadata
      ## Commit message ##
         refs: allow passing flags when setting up a transaction
     
    -    Allow passing flags when setting up a transaction such that the
    -    behaviour of the transaction itself can be altered. This functionality
    -    will be used in a subsequent patch.
    +    Allow passing flags when creating a new transaction. These flagas are
    +    stored in the `struct ref_transaction` and can be used by the respective
    +    backends to alter their behaviour depending on the flag's value. This
    +    functionality will be used in a subsequent patch.
     
         Adapt callers accordingly.
     
 2:  b7d50b9270 =  2:  616a5d66de refs/files: move logic to commit initial transaction
 3:  2a0fff3748 =  3:  8d4b867641 refs: introduce "initial" transaction flag
 4:  3904f337f6 =  4:  70961f6295 refs/files: support symbolic and root refs in initial transaction
 5:  131161d467 =  5:  ccae50e766 refs: use "initial" transaction semantics to migrate refs
 6:  a443916bbd !  6:  ec5de7e1a2 refs: skip collision checks in initial transactions
    @@ Commit message
         well as the creation of a ref iterator for every ref we're checking,
         which adds up quite fast when performing the check for many refs.
     
    -    Introduce a new flag that allows us to skip this check and wire it up in
    -    such that the backends pass it when running an initial transaction. This
    +    Introduce a new flag that allows us to skip this check and wire it up so
    +    that the backends pass it when running an initial transaction. This
         leads to significant speedups when migrating ref storage backends. From
         "files" to "reftable":
     
    @@ refs.c: int refs_verify_refname_available(struct ref_store *refs,
      				  const char *refname,
      				  const struct string_list *extras,
      				  const struct string_list *skip,
    -+				  int initial_transaction,
    ++				  unsigned int initial_transaction,
      				  struct strbuf *err)
      {
      	const char *slash;
    @@ refs.h: int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refn
      				  const char *refname,
      				  const struct string_list *extras,
      				  const struct string_list *skip,
    -+				  int initial_transaction,
    ++				  unsigned int initial_transaction,
      				  struct strbuf *err);
      
      int refs_ref_exists(struct ref_store *refs, const char *refname);
 7:  4bd95e5661 =  7:  f60f692ea0 refs: don't normalize log messages with `REF_SKIP_CREATE_REFLOG`
 8:  de1573c1f7 !  8:  e8881d67db reftable/writer: optimize allocations by using a scratch buffer
    @@ reftable/writer.c: int reftable_writer_new(struct reftable_writer **out,
      
      	reftable_buf_init(&wp->block_writer_data.last_key);
      	reftable_buf_init(&wp->last_key);
    -+	reftable_buf_init(&wp->buf);
    ++	reftable_buf_init(&wp->scratch);
      	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
      	if (!wp->block) {
      		reftable_free(wp);
    @@ reftable/writer.c: static void writer_release(struct reftable_writer *w)
      		w->block_writer = NULL;
      		writer_clear_index(w);
      		reftable_buf_release(&w->last_key);
    -+		reftable_buf_release(&w->buf);
    ++		reftable_buf_release(&w->scratch);
      	}
      }
      
    @@ reftable/writer.c: static int writer_index_hash(struct reftable_writer *w, struc
      	int err;
      
     -	err = reftable_record_key(rec, &key);
    -+	err = reftable_record_key(rec, &w->buf);
    ++	err = reftable_record_key(rec, &w->scratch);
      	if (err < 0)
      		goto done;
      
     -	if (reftable_buf_cmp(&w->last_key, &key) >= 0) {
    -+	if (reftable_buf_cmp(&w->last_key, &w->buf) >= 0) {
    ++	if (reftable_buf_cmp(&w->last_key, &w->scratch) >= 0) {
      		err = REFTABLE_API_ERROR;
      		goto done;
      	}
      
      	reftable_buf_reset(&w->last_key);
     -	err = reftable_buf_add(&w->last_key, key.buf, key.len);
    -+	err = reftable_buf_add(&w->last_key, w->buf.buf, w->buf.len);
    ++	err = reftable_buf_add(&w->last_key, w->scratch.buf, w->scratch.len);
      	if (err < 0)
      		goto done;
      
    @@ reftable/writer.c: int reftable_writer_add_ref(struct reftable_writer *w,
      
      	if (!w->opts.skip_index_objects && reftable_ref_record_val1(ref)) {
     -		err = reftable_buf_add(&buf, (char *)reftable_ref_record_val1(ref),
    -+		reftable_buf_reset(&w->buf);
    -+		err = reftable_buf_add(&w->buf, (char *)reftable_ref_record_val1(ref),
    ++		reftable_buf_reset(&w->scratch);
    ++		err = reftable_buf_add(&w->scratch, (char *)reftable_ref_record_val1(ref),
      				       hash_size(w->opts.hash_id));
      		if (err < 0)
      			goto out;
      
     -		err = writer_index_hash(w, &buf);
    -+		err = writer_index_hash(w, &w->buf);
    ++		err = writer_index_hash(w, &w->scratch);
      		if (err < 0)
      			goto out;
      	}
    @@ reftable/writer.c: int reftable_writer_add_ref(struct reftable_writer *w,
      	if (!w->opts.skip_index_objects && reftable_ref_record_val2(ref)) {
     -		reftable_buf_reset(&buf);
     -		err = reftable_buf_add(&buf, reftable_ref_record_val2(ref),
    -+		reftable_buf_reset(&w->buf);
    -+		err = reftable_buf_add(&w->buf, reftable_ref_record_val2(ref),
    ++		reftable_buf_reset(&w->scratch);
    ++		err = reftable_buf_add(&w->scratch, reftable_ref_record_val2(ref),
      				       hash_size(w->opts.hash_id));
      		if (err < 0)
      			goto out;
      
     -		err = writer_index_hash(w, &buf);
    -+		err = writer_index_hash(w, &w->buf);
    ++		err = writer_index_hash(w, &w->scratch);
      		if (err < 0)
      			goto out;
      	}
    @@ reftable/writer.h: struct reftable_writer {
      	void *write_arg;
      	int pending_padding;
      	struct reftable_buf last_key;
    -+	struct reftable_buf buf;
    ++	/* Scratch buffer used to avoid allocations. */
    ++	struct reftable_buf scratch;
      
      	/* offset of next block to write. */
      	uint64_t next;
 9:  903fb084d5 =  9:  1127729311 reftable/block: rename `block_writer::buf` variable
10:  27692b8a00 ! 10:  7b8ddad673 reftable/block: optimize allocations by using scratch buffer
    @@ reftable/block.c: int block_writer_add(struct block_writer *w, struct reftable_r
      	int err;
      
     -	err = reftable_record_key(rec, &key);
    -+	err = reftable_record_key(rec, &w->buf);
    ++	err = reftable_record_key(rec, &w->scratch);
      	if (err < 0)
      		goto done;
      
     -	if (!key.len) {
    -+	if (!w->buf.len) {
    ++	if (!w->scratch.len) {
      		err = REFTABLE_API_ERROR;
      		goto done;
      	}
      
     -	n = reftable_encode_key(&is_restart, out, last, key,
    -+	n = reftable_encode_key(&is_restart, out, last, w->buf,
    ++	n = reftable_encode_key(&is_restart, out, last, w->scratch,
      				reftable_record_val_type(rec));
      	if (n < 0) {
      		err = -1;
    @@ reftable/block.c: int block_writer_add(struct block_writer *w, struct reftable_r
      
      	err = block_writer_register_restart(w, start.len - out.len, is_restart,
     -					    &key);
    -+					    &w->buf);
    ++					    &w->scratch);
      done:
     -	reftable_buf_release(&key);
      	return err;
    @@ reftable/block.c: void block_writer_release(struct block_writer *bw)
      	REFTABLE_FREE_AND_NULL(bw->zstream);
      	REFTABLE_FREE_AND_NULL(bw->restarts);
      	REFTABLE_FREE_AND_NULL(bw->compressed);
    -+	reftable_buf_release(&bw->buf);
    ++	reftable_buf_release(&bw->scratch);
      	reftable_buf_release(&bw->last_key);
      	/* the block is not owned. */
      }
    @@ reftable/block.h: struct block_writer {
      	uint32_t restart_cap;
      
      	struct reftable_buf last_key;
    -+	struct reftable_buf buf;
    ++	/* Scratch buffer used to avoid allocations. */
    ++	struct reftable_buf scratch;
      	int entries;
      };
      

---
base-commit: facbe4f633e4ad31e641f64617bc88074c659959
change-id: 20241108-pks-refs-optimize-migrations-6d0ceee4abb7

