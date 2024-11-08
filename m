Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0FD1E104F
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058509; cv=none; b=g90e2aKgG08iv4CEvLfdHATFL2B/8icMCLd7uZep4gd7u2aFRa1uaIV7ff+TEJVx1+1vBBdMWFBm5bEvn4PFYZ/8/jFqKiWQtD5cN3+/9deY3tNvtj+MYrFswbFHFv1+dRBniv3ASwfZVS0SFnXfs7l1Q98EFjr7VAkeHaKNrxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058509; c=relaxed/simple;
	bh=UAx8AO3dfh6sm4DlRMo7mW1Ss6mMF+OCcLmcCsAQAtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MHeObCsRGzs5rhrZ+nNutb3ovQRKIYdsUxGXlwhCAFT3Bti+4An+R5PLXKvOCV1ropLjGjI7xZ24YFEtQ2ldCdEHGracdfyg4w8XAxsgPzFERQixRQDHGjfI1++RX2HywrElpCCGTYqn2XPTEmIFeFJSw0in2WWqHjSceQMMxLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aNsuhEWD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WXvxh/dS; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aNsuhEWD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WXvxh/dS"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 97A5925400F3
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 04:35:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 08 Nov 2024 04:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731058506;
	 x=1731144906; bh=HAYzmWxnzUTa7oDdzxvWxHu0S7YGRV/i/bcR+fw9zIo=; b=
	aNsuhEWD4sWEClinyEEoyCxpiQiBwGP973jY2pkt/3eTNH1wK+Mz5FAMF3tCx2gS
	F/ihCScERYQvh9vMbl/ELPo+/CA82+Tpv2lQA+378E0fKsp4vjLhvC67sij5xmto
	3xWipy666SCzthvbGB3QStDd46iGzDppEVnzsk1rjqMJrVKVtRGHFcDTFZ0EU8nV
	crmREqh+8DrQo3HfTdBcaWIdsy+iCENR+J+9ILff/3bHWesXQJPIXVU5RuRKxM0e
	+OoFxRJaCplVGk8eReBndEKGs/M4us2yB50ney9fpUrdh1yF5IvUs1OlKEiDxg6C
	nnD+XtGFZ6mEKvVNEhF1DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731058506; x=
	1731144906; bh=HAYzmWxnzUTa7oDdzxvWxHu0S7YGRV/i/bcR+fw9zIo=; b=W
	Xvxh/dSnks3cu9z+/9WgsBcwDqbalqsv1DlwcFz0dm0yKyFsEYxtFxPjMNTA9Vxt
	2xSf6dqjZVbn62z78ZgJv5uDDJVt9JzZKEfCqgpCg2Y+z+T4Xpm3A3NSEIVsM+H4
	LSmjgGy95/I9kCMq3SH7zDMnPKkMCw1wbaVlH7Qy8RtjEHpTB7uN10DGxcQRTPom
	9PDSeNEscYkSZ/FCHDunL8wDjpOU7nFbwehXDU1DZLDQ8Dh2esPz2RKaHQPlK3VN
	9qlEeiN/bONsfpOF3zOJazJqZ0CZ4ejIPsoproEyf2dCTq3UpWRW7VvXuHbMGDz0
	GWzKClMU3W1/rNdzCeZvQ==
X-ME-Sender: <xms:StstZ1Jx5yjFmF7og_QQFMD5wpTyYkmjucvoWJZwsl8IVx86h2GSFg>
    <xme:StstZxII6TVqm7NZWHrwrC7rokKEFTfc3upkA1ZgEYLumS3GR-UUqrBnq2l4Uh38O
    p0hAemgqt5khSAUqw>
X-ME-Received: <xmr:StstZ9vzcFWWE1SecmZEfJOyjd6q-4qd17TY0cFM87ccUSm0RkYtY8yjqikprQttK1yH-p2o2g_kioRplMJwZj4nPCJnN13VaJKkgAPLxc_E7yY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelhe
    efjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:StstZ2YC9thCnXTJS69htr5cWtGTulIlwZ0SeqnjBsE48Pv4KIOdaw>
    <xmx:StstZ8ZtMk2LDeqEVxjzXGwuzvrf31mwXuUEaQxLznf1FVHuCFf2Dg>
    <xmx:StstZ6A9h5QbLRxZzuCN7mW-qBoQ00bzQAndugIHQR-D92xSjJUixA>
    <xmx:StstZ6aOEMHXEAqxcME9jAVcgRbj1UqUjLG0MjWIAGcxdUaOIboW-g>
    <xmx:StstZ3y0SJF1P34MsUa4-5Sc3mxhZqkqwbbqGsCxdoezjblJCU32F_TD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 8 Nov 2024 04:35:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2dc3ebab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 09:34:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 08 Nov 2024 10:34:45 +0100
Subject: [PATCH 05/10] refs: use "initial" transaction semantics to migrate
 refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241108-pks-refs-optimize-migrations-v1-5-7fd37fa80e35@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
In-Reply-To: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.14.2

Until now, we couldn't use "initial" transaction semantics to migrate
refs because the "files" backend only supported writing regular refs via
the initial transaction because it simply mapped the transaction to a
"packed-refs" transaction. But with the preceding commit, the "files"
backend has learned to also write symbolic and root refs in the initial
transaction by creating a second transaction for all refs that need to
be written as loose refs.

Adapt the code to migrate refs to commit the transaction as an initial
transaction. This results in a signiticant speedup when migrating many
refs:

    Benchmark 1: migrate reftable:files (refcount = 100000, revision = HEAD~)
      Time (mean ± σ):      3.247 s ±  0.034 s    [User: 0.485 s, System: 2.722 s]
      Range (min … max):    3.216 s …  3.309 s    10 runs

    Benchmark 2: migrate reftable:files (refcount = 100000, revision = HEAD)
      Time (mean ± σ):     453.6 ms ±   1.9 ms    [User: 214.6 ms, System: 230.5 ms]
      Range (min … max):   451.5 ms … 456.4 ms    10 runs

    Summary
      migrate reftable:files (refcount = 100000, revision = HEAD) ran
        7.16 ± 0.08 times faster than migrate reftable:files (refcount = 100000, revision = HEAD~)

As the reftable backend doesn't (yet) special-case initial transactions
there is no comparable speedup for that backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                  | 10 ++--------
 t/t1460-refs-migrate.sh |  2 +-
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 8b9dfc6173fd144fe9a172cb81cf33057ae31368..0f10c565bbb4e0d91210c52a3221a224e4264d28 100644
--- a/refs.c
+++ b/refs.c
@@ -2827,7 +2827,8 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	if (ret < 0)
 		goto done;
 
-	transaction = ref_store_transaction_begin(new_refs, 0, errbuf);
+	transaction = ref_store_transaction_begin(new_refs, REF_TRANSACTION_FLAG_INITIAL,
+						  errbuf);
 	if (!transaction)
 		goto done;
 
@@ -2852,13 +2853,6 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	if (ret < 0)
 		goto done;
 
-	/*
-	 * TODO: we might want to migrate to `initial_ref_transaction_commit()`
-	 * here, which is more efficient for the files backend because it would
-	 * write new refs into the packed-refs file directly. At this point,
-	 * the files backend doesn't handle pseudo-refs and symrefs correctly
-	 * though, so this requires some more work.
-	 */
 	ret = ref_transaction_commit(transaction, errbuf);
 	if (ret < 0)
 		goto done;
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index f7c0783d30ccd61b0fee67c115193b42bb0e2c77..b90b38a87f7bb905afeeceb4f9a3bfc8b772e16a 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -237,7 +237,7 @@ test_expect_success 'migrating from reftable format deletes backend files' '
 	test_path_is_missing repo/.git/reftable &&
 	echo "ref: refs/heads/main" >expect &&
 	test_cmp expect repo/.git/HEAD &&
-	test_path_is_file repo/.git/refs/heads/main
+	test_path_is_file repo/.git/packed-refs
 '
 
 test_done

-- 
2.47.0.229.g8f8d6eee53.dirty

