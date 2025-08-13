Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE8A1DE2D7
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066362; cv=none; b=HU12ChMCJZGwQjhjNXVuwhtRRp/HFMn6bIKs5TrGENyuv8vFVU+TCZwxKfwXw9Xh/H9+F+Mlk9UUuZhLEeXaDDtGYFm8zvils1YKpD4BH6E0MLKxvepe02SMrlQqpem9HDTXJj9YljE9LvlCrARx35RW6CkePDo43izMPSMM/9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066362; c=relaxed/simple;
	bh=s4+CPhPFdB3IABB/80159R/BL6/49MZMHG/gP6vX4tQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=csrXBjMMVHtnyYsvymrVUIKMTyRqSaPfagIyJth6+cVhlHtzjjlwqPwvZDKR9GFz4cfEoOAtcOVOUNJctP+E7j+SNFISfNDnWwTo0uZcj9UGJ1mNVa27Fc1ZsoR4a/PYKdS2PcRYQJvWropextAbh1CpMHiNWFe48XOLAByBIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Axgr4GmA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EpS3Xlo5; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Axgr4GmA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EpS3Xlo5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D8D031D00111;
	Wed, 13 Aug 2025 02:25:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 13 Aug 2025 02:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755066359;
	 x=1755152759; bh=MMqaIDCJlPseJ6AnGtmtpqVw6YqhHVy5TvlVaqaVUNE=; b=
	Axgr4GmA3N91oEAsQQDcQGn1YuknbDWX+MIu+22OcbApk3G+d750aVtd0jAu274N
	HV4Ig0PqpjlhCl9MxMardHElmQFyhvlK2kzHxiSkHL0+UW8+nEzZJZ6wXlJx9hVT
	11KaT7/VUGgbwCKC+XxUlsNs/5ihwc8DMNd0IPSSB8wrONOlTvKDH3XLqIceQzL0
	1AeLXzux2E3x/2VszLibqc1e//zhybp1B0LGGfgmkdpx6GinmEH+JnBHjqw9k6rJ
	fMGDHtTwanLFe85VFp5WL4JKuAbPdk/bFcZRuSxLrdgLe18whYDAUqRrD7woGi/f
	2x0PJz0MOc+WxsDFywMpfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755066359; x=
	1755152759; bh=MMqaIDCJlPseJ6AnGtmtpqVw6YqhHVy5TvlVaqaVUNE=; b=E
	pS3Xlo55fwiP+rWuPcrbX54n9wLZtNqqcio3owDNCznoFSP+BeaGP/g1hW/q+6BN
	vqBKl8WgGLtIq9Kdnsyy8VOjvDdWGfzaNfJj7wHuEZ7W6i5QJNjKYD1iAO8GmbNZ
	BN2xz1aUO8EKUvJ0pV4dNXM/JKgziTVVICgUH8EDRLx74vcUYM1k6ZB75LkYiH6i
	OZ79ygxddO2DnbrDveIWKlq83eEwshUxD+WE0apIveqhf6Gg/mXX7KKolg65tAOb
	bzLWK1Ew7ij4rISoGM6/2JiDhv438+qf8Sbt6/KJiBNDP2aj5v6erD1icUTY3VqB
	oWEg+4fweERSafJtjD3dg==
X-ME-Sender: <xms:9y-caLj4FGq-WMQ5ACtZzhS20Lqk2pDBje17p_uLKRjO4vyIKJuwHA>
    <xme:9y-caDjJFX_nojrPswvvsUhaLe5cltH6UAIsuYlpijRjM9md7Jx7Ky4mHVYKP5ynx
    9IpYHn4MbkL5AefJQ>
X-ME-Received: <xmr:9y-caBgnUESfy3pv3RVIgU-VfldEqDxDnC0CvK8a_N9XJ7Hql1_6KFWxRppFAZQ0ur9rVeQIuhjLySq9IfgO2teW5orPVQdAiX2P7a1WSd8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggrrhgvnh
    grshesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9y-caDLydSjSziuOKT1grV02HDPWM06j-hB_bgO2xw-l0kwFFIUnvw>
    <xmx:9y-caAFl5devUGvz8q1aM6aL7LuzcTMtKqYL26hb2sTicaR2hSpl3A>
    <xmx:9y-caHQvkFaPRE_odHTx5lP_Bw5gs9RKWY372GitPab6uvL3xBkLlg>
    <xmx:9y-caMetZ7Sn2TwDFaCR21aDgJhXJZcY-le59julRjfNuyKkgQjEYA>
    <xmx:9y-caGdgqKhChSEzVD8eC1My1mwV0snuzn8aLzEEquykZn19RNEnZMDQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 02:25:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e01c9273 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 13 Aug 2025 06:25:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 13 Aug 2025 08:25:32 +0200
Subject: [PATCH v4 8/8] refs/reftable: always reload stacks when creating
 lock
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-pks-reftable-fixes-for-libgit2-v4-8-42b5544c8e2a@pks.im>
References: <20250813-pks-reftable-fixes-for-libgit2-v4-0-42b5544c8e2a@pks.im>
In-Reply-To: <20250813-pks-reftable-fixes-for-libgit2-v4-0-42b5544c8e2a@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Carlo Arenas <carenas@gmail.com>
X-Mailer: b4 0.14.2

When creating a new addition via either `reftable_stack_new_addition()`
or its convenince wrapper `reftable_stack_add()` we:

  1. Create the "tables.list.lock" file.

  2. Verify that the current version of the "tables.list" file is
     up-to-date.

  3. Write the new table records if so.

By default, the second step would cause us to bail out if we see that
there has been a concurrent write to the stack that made our in-memory
copy of the stack out-of-date. This is a safety mechanism to not write
records to the stack based on outdated information.

The downside though is that concurrent writes may now cause us to bail
out, which is not a good user experience. In addition, this isn't even
necessary for us, as Git knows to perform all checks for the old state
of references under the lock. (Well, in all except one case: when we
expire the reflog we first create the log iterator before we create the
lock, but this ordering is fixed as part of this commit.)

Consequently, most writers pass the `REFTABLE_STACK_NEW_ADDITION_RELOAD`
flag. The effect of this flag is that we reload the stack after having
acquired the lock in case the stack is out-of-date. This plugs the race
with concurrent writers, but we continue performing the verifications of
the expected old state to catch actual conflicts in the references we
are about to write.

Adapt the remaining callsites that don't yet pass this flag to do so.
While at it, drop a needless manual reload.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 3f0deab338..66d25411f1 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1006,10 +1006,6 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 	if (!arg) {
 		struct reftable_addition *addition;
 
-		ret = reftable_stack_reload(be->stack);
-		if (ret)
-			return ret;
-
 		ret = reftable_stack_new_addition(&addition, be->stack,
 						  REFTABLE_STACK_NEW_ADDITION_RELOAD);
 		if (ret) {
@@ -1960,7 +1956,8 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
 	ret = backend_for(&arg.be, refs, newrefname, &newrefname, 1);
 	if (ret)
 		goto done;
-	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg, 0);
+	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg,
+				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
 
 done:
 	assert(ret != REFTABLE_API_ERROR);
@@ -1989,7 +1986,8 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
 	ret = backend_for(&arg.be, refs, newrefname, &newrefname, 1);
 	if (ret)
 		goto done;
-	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg, 0);
+	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg,
+				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
 
 done:
 	assert(ret != REFTABLE_API_ERROR);
@@ -2360,7 +2358,8 @@ static int reftable_be_create_reflog(struct ref_store *ref_store,
 		goto done;
 	arg.stack = be->stack;
 
-	ret = reftable_stack_add(be->stack, &write_reflog_existence_table, &arg, 0);
+	ret = reftable_stack_add(be->stack, &write_reflog_existence_table, &arg,
+				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
 
 done:
 	return ret;
@@ -2431,7 +2430,8 @@ static int reftable_be_delete_reflog(struct ref_store *ref_store,
 		return ret;
 	arg.stack = be->stack;
 
-	ret = reftable_stack_add(be->stack, &write_reflog_delete_table, &arg, 0);
+	ret = reftable_stack_add(be->stack, &write_reflog_delete_table, &arg,
+				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
 
 	assert(ret != REFTABLE_API_ERROR);
 	return ret;
@@ -2552,15 +2552,16 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_stack_init_log_iterator(be->stack, &it);
+	ret = reftable_stack_new_addition(&add, be->stack,
+					  REFTABLE_STACK_NEW_ADDITION_RELOAD);
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_iterator_seek_log(&it, refname);
+	ret = reftable_stack_init_log_iterator(be->stack, &it);
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_stack_new_addition(&add, be->stack, 0);
+	ret = reftable_iterator_seek_log(&it, refname);
 	if (ret < 0)
 		goto done;
 

-- 
2.51.0.rc1.215.g0f929dcec7.dirty

