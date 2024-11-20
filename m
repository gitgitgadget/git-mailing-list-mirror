Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79340189521
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089115; cv=none; b=DlDzFPrPvCZrcLIU8aPG4jMkYDSLJk+brhVDfC9ZFbls5oP1XiEuEE1i0HNyQv6dpdus5+79wuK7HLcXRDl+6I4z2uAWB0dTpnbBnr1QDAFy8/Q510RQvhLmYzN6vsdlRifK2WUz9ACg4SFtGduC3FMO/4bNsVCxixmYw0I3TiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089115; c=relaxed/simple;
	bh=DZqmLnMQAIrB/plXR2SEf9fEUnaovqIyOA6bjPwHSbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=puEE6nv20GMV1Hw+6eV6uRUF/VWKBpOHC4nl1pNJnWV+qc25wBLmh3HbR7ZalEYDlZQ2Go8dCCX1uAHLaAoapU68fE68pgDERpS7cKCMLp66xSghBLvtKONIOLbGlDkwLuC+2WRyNyBqHBmCr5oXF4pMY1G5kk7GkCbnNiEXqZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oBb070x3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b7c90Efm; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oBb070x3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b7c90Efm"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id A88461380240;
	Wed, 20 Nov 2024 02:51:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 20 Nov 2024 02:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732089112;
	 x=1732175512; bh=WK1vA4YcKnT0ynaV/647p2H1/il1NPDH39j+Y3yFS+U=; b=
	oBb070x35LamC8jc3DZGO2ekRJglsYtoHf4iAPjmwuBMt0DhBZ9dTn90O7sZw3Om
	rJUsYlj256FX7mXCsUSiZiBUhVmxJ3BJscVh83VxGqnGgKwm4FzmwBLUUFeFcTQM
	eqW6x+isLyVFAsR7lyRDxhK+lmVJ/7ySuXRR20FQz8WPdBDhuGPHTM1zjmjFYaNW
	sm97FQJZYH+t6gdUx+MnSNePO2jipWBAjnxRyQZPGDZ2poI5hA4H/w3OJUDgbi6t
	42wSgwdpG0rclNCWoqhZ+cakPf3K+cANaW42IOEvjPvxcDEW53c2W9HasX2iCwRl
	K/hbL5Qoqrumr+kZXQxaAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732089112; x=
	1732175512; bh=WK1vA4YcKnT0ynaV/647p2H1/il1NPDH39j+Y3yFS+U=; b=b
	7c90EfmFzSvkO7eGSt02Y3dniWKoar82Kvjd+Jb8ukuLgXnl+TUcCUcaNQhTTVA1
	fjcAR3F8AVh0UQJrdW47eGMyRAhpIXG0Q7Wogy45HPSVybsra9jeJNVQasolh+f+
	R46Q6nHN5cPofgDcRMDbIgvmsSZA2p1EgdEB4HmnXtgfzxZ2GrV0krFN8ti+R5Ce
	+1rLYIN3jMaW9wsOif3uffqGw4JWYICw5agJC9UPPYzSzADsthLOnyEIgIm94Srb
	Kf5K2civeXEw5aQI2Fs//5x5E4LdLzJdFaV9G4DMEVUXIGI2dQKBshcNNoM/uCZY
	SHQ00WfZehtWgsNfAyquw==
X-ME-Sender: <xms:GJU9Z1gbkk2EQUrD6TIQxCHkawoYEeqPWbkhVl5TX1gsQJAgQT8AJw>
    <xme:GJU9Z6DQ3BjZNm6KvW53D_mB0EAO-AA2AI6Ep1lJxOrg2UOSrdmzIyrg4Vf5Y80To
    PQRXzrjrnd6d4lfRQ>
X-ME-Received: <xmr:GJU9Z1HsVAQJZu_nrQeUwb7rU4MOgun3XITrfVMbtHkBMIjM5OKCpS4RDd2tvaAMHW0Uv95n44C3A39kqQOXZzCGzLKP50_qpue-7hhMxhbMIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudff
    udevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GJU9Z6TQCILSV1kb7sHSBcLhw6GqOjBrwD9nzV2GSILg94RI5xTQYA>
    <xmx:GJU9ZyzypxRk1udW5bLLP0IhlkBH0CJsG6DOrdzogY5Avx3kZkicwg>
    <xmx:GJU9Zw5BjJjt7_Ev075reAaapXsY9MucWkmVN70r1fGmK0aMkmGthA>
    <xmx:GJU9Z3zYr4WjCA_T2CcoAX06rRgRy1T9QHG8LlcxsDB83xdkd3cNrQ>
    <xmx:GJU9Z296KsV79XYTiHxnp0JUxDLQupQXWUBRjYy2ldIYeOx0f0dP8stU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 02:51:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 17ee5917 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 07:50:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 08:51:37 +0100
Subject: [PATCH v2 08/10] reftable/writer: optimize allocations by using a
 scratch buffer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241120-pks-refs-optimize-migrations-v2-8-a233374b7452@pks.im>
References: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
In-Reply-To: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Both `writer_add_record()` and `reftable_writer_add_ref()` get executed
for every single ref record we're adding to the reftable writer. And as
both functions use a local buffer to write data, the allocations we have
to do here add up during larger transactions.

Refactor the code to use a scratch buffer part of the `reftable_writer`
itself such that we can reuse it. This signifcantly reduces the number
of allocations during large transactions, e.g. when migrating refs from
the "files" backend to the "reftable" backend. Before this change:

    HEAP SUMMARY:
        in use at exit: 80,048 bytes in 49 blocks
      total heap usage: 5,032,171 allocs, 5,032,122 frees, 418,792,092 bytes allocated

After this change:

    HEAP SUMMARY:
        in use at exit: 80,048 bytes in 49 blocks
      total heap usage: 3,025,864 allocs, 3,025,815 frees, 372,746,291 bytes allocated

This also translate into a small speedup:

    Benchmark 1: migrate files:reftable (refcount = 1000000, revision = HEAD~)
      Time (mean ± σ):     827.2 ms ±  16.5 ms    [User: 689.4 ms, System: 124.9 ms]
      Range (min … max):   809.0 ms … 924.7 ms    50 runs

    Benchmark 2: migrate files:reftable (refcount = 1000000, revision = HEAD)
      Time (mean ± σ):     813.6 ms ±  11.6 ms    [User: 679.0 ms, System: 123.4 ms]
      Range (min … max):   786.7 ms … 833.5 ms    50 runs

    Summary
      migrate files:reftable (refcount = 1000000, revision = HEAD) ran
        1.02 ± 0.02 times faster than migrate files:reftable (refcount = 1000000, revision = HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 23 +++++++++++------------
 reftable/writer.h |  1 +
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index fd136794d5a27b33b5017f36fbd6b095ab8dac5b..6501376ce826469556a7dfa3c39258847300ae66 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -148,6 +148,7 @@ int reftable_writer_new(struct reftable_writer **out,
 
 	reftable_buf_init(&wp->block_writer_data.last_key);
 	reftable_buf_init(&wp->last_key);
+	reftable_buf_init(&wp->buf);
 	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
 	if (!wp->block) {
 		reftable_free(wp);
@@ -180,6 +181,7 @@ static void writer_release(struct reftable_writer *w)
 		w->block_writer = NULL;
 		writer_clear_index(w);
 		reftable_buf_release(&w->last_key);
+		reftable_buf_release(&w->buf);
 	}
 }
 
@@ -249,20 +251,19 @@ static int writer_index_hash(struct reftable_writer *w, struct reftable_buf *has
 static int writer_add_record(struct reftable_writer *w,
 			     struct reftable_record *rec)
 {
-	struct reftable_buf key = REFTABLE_BUF_INIT;
 	int err;
 
-	err = reftable_record_key(rec, &key);
+	err = reftable_record_key(rec, &w->buf);
 	if (err < 0)
 		goto done;
 
-	if (reftable_buf_cmp(&w->last_key, &key) >= 0) {
+	if (reftable_buf_cmp(&w->last_key, &w->buf) >= 0) {
 		err = REFTABLE_API_ERROR;
 		goto done;
 	}
 
 	reftable_buf_reset(&w->last_key);
-	err = reftable_buf_add(&w->last_key, key.buf, key.len);
+	err = reftable_buf_add(&w->last_key, w->buf.buf, w->buf.len);
 	if (err < 0)
 		goto done;
 
@@ -312,7 +313,6 @@ static int writer_add_record(struct reftable_writer *w,
 	}
 
 done:
-	reftable_buf_release(&key);
 	return err;
 }
 
@@ -325,7 +325,6 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 			.ref = *ref
 		},
 	};
-	struct reftable_buf buf = REFTABLE_BUF_INIT;
 	int err;
 
 	if (!ref->refname ||
@@ -340,24 +339,25 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 		goto out;
 
 	if (!w->opts.skip_index_objects && reftable_ref_record_val1(ref)) {
-		err = reftable_buf_add(&buf, (char *)reftable_ref_record_val1(ref),
+		reftable_buf_reset(&w->buf);
+		err = reftable_buf_add(&w->buf, (char *)reftable_ref_record_val1(ref),
 				       hash_size(w->opts.hash_id));
 		if (err < 0)
 			goto out;
 
-		err = writer_index_hash(w, &buf);
+		err = writer_index_hash(w, &w->buf);
 		if (err < 0)
 			goto out;
 	}
 
 	if (!w->opts.skip_index_objects && reftable_ref_record_val2(ref)) {
-		reftable_buf_reset(&buf);
-		err = reftable_buf_add(&buf, reftable_ref_record_val2(ref),
+		reftable_buf_reset(&w->buf);
+		err = reftable_buf_add(&w->buf, reftable_ref_record_val2(ref),
 				       hash_size(w->opts.hash_id));
 		if (err < 0)
 			goto out;
 
-		err = writer_index_hash(w, &buf);
+		err = writer_index_hash(w, &w->buf);
 		if (err < 0)
 			goto out;
 	}
@@ -365,7 +365,6 @@ int reftable_writer_add_ref(struct reftable_writer *w,
 	err = 0;
 
 out:
-	reftable_buf_release(&buf);
 	return err;
 }
 
diff --git a/reftable/writer.h b/reftable/writer.h
index e8a6fbb78543e6e56920a2999601db0db9fe4d97..421a897dccd85ad0532860ff1b4f38b2813d438d 100644
--- a/reftable/writer.h
+++ b/reftable/writer.h
@@ -20,6 +20,7 @@ struct reftable_writer {
 	void *write_arg;
 	int pending_padding;
 	struct reftable_buf last_key;
+	struct reftable_buf buf;
 
 	/* offset of next block to write. */
 	uint64_t next;

-- 
2.47.0.274.g962d0b743d.dirty

