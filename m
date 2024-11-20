Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD6415B122
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089112; cv=none; b=FekZP42iI+BeUsDbilXGFrDVR5s+Hxbva9KezEV2Zqqv88BXZpFqven7nLr/B7fCb+RmHUVa0jQgzqJhEgEMOhTpuT5D//AHzqwhrj0RM03ndrEL6Eu7bYgtTArE8AsJQR2LTXkxpPupTAtQC8F5EoTBN6LzyeMR8RNM2fXNHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089112; c=relaxed/simple;
	bh=OjiTeSixc8q4F+0tCp8BD5Jxtw4ayBAqPEhlGEeRzBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZ19Su3jRtiMSvYcTQQLwh2QFfJda58egpnTdUbtnfqv+aF6A2oLCNsEg3C4RWqyrHmGpqnKrwLM8mYrU1D4xqt4xloqaVlvh0txDQITzPhy+Qf2R6xo7Zu8xY+lrRtJLppETmZVDzSsM55J8idk9PODStzq6wrlQsKM9IR7gSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p1SFahPg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O9L57g1f; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p1SFahPg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O9L57g1f"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7017613801F5;
	Wed, 20 Nov 2024 02:51:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 20 Nov 2024 02:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732089109;
	 x=1732175509; bh=YYE2I49hdVByxgSjx/jKB5u9o5Huc2g+HUhKRyJex6k=; b=
	p1SFahPgxEwwxjsiLN9GUJX+4+wz3LnjA5hdWSpMfUGTFDufGXvNUgoii9W+I9D1
	Q8YBJNX0O4OoCZSOd9OdA3PkVHyD9UsW6hLu8AUnvXcd1GcnlQsIfe0ysD1nVf9m
	foEtPz4GIc5zjxJngusNQn4o3TXcXlBK93QsD5kJmOmfazeRYZpYQbzICQsEW9xg
	WQY5y/6W9svJrkpq8pU5YD1ESjIEUDvDXhHPDCz7w6UmODHfYVGNHNMTsOrmoas2
	yvFW8L/audRtdXRlobU+RnY4RPTmKdkJL7dbzoXrjZE2jqg39Jdk7eP1sMvNuGgT
	nUDqXW4XSH1osq/Q1WAqlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732089109; x=
	1732175509; bh=YYE2I49hdVByxgSjx/jKB5u9o5Huc2g+HUhKRyJex6k=; b=O
	9L57g1fsI5svNlFAdMUVqlH19/MFuEmV6KCz4MG4h8ffn2XdqdWB46LwkyLt2Mrv
	nIDQvZqauOdS2OUXT9RGFLQlyOSc/Ruof14t54R+4ciDUIQTrz5SUw8JC7NTZKS4
	VHvOgC2ya4VmuNxxha2itLrH2qcMac+Ks8xbeBavU1HShI0gx5/EC85n1p3n/FaB
	J3DB1KmojKkSH4M9aS/CDyJtUrBUjeO1LtTiQHIB+3al8CkaWsFSXpUw160UluEE
	B6eIeQjGNerzrslsU/3RNvZAsGg1rnGdUT/auGll9milzlFV0wtRcGEu6S1rlphR
	Zs1li4Eph353AoidgtSJA==
X-ME-Sender: <xms:FZU9Z_UK80xtC1Dwudpa0tIXZ2sZVk_GfAYgZ5HG8K1xdBAeon8i-g>
    <xme:FZU9Z3nkJffkGV7dVfDT4dTVvy3JPdnYfp5DkYFzFE5YoFi1fXbO0Mkh9MC1qOQYl
    X_OEafNXPQSP-Crlw>
X-ME-Received: <xmr:FZU9Z7ZVU8swLXLZkJNcpt2IivWfXM3uJc5-2UZjbMzQjNG8rVHgT7n1aU32NHI_zd3zARB2SkzUiTmxQ2A-ByV5NkHYZ85UiPFCVYvW2HY2PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudff
    udevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:FZU9Z6VuKI6e90llz7DEh0Dclyw9c0SJrb4z2id2WyDi9UrxiS3CXA>
    <xmx:FZU9Z5ke_yxMJmlRz_9bznnBK5GT4PD4jCRf01uetfAp5qdq3vTy8A>
    <xmx:FZU9Z3cZEMJDQejaUzAd5BNMYQ1A5qORoJC3fk3EetYbCIPDGCE_BA>
    <xmx:FZU9ZzFTDTZvU0-JhSBeYzo_0hh2rbCnSM36PQD1Glky7ypiAzZBBA>
    <xmx:FZU9Z_iWv4DA3r83G0imDdCyNtTKnNQ0bg2Wq2Ns7kC21v0UiQNVpAGZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 02:51:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7d6c21da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 07:50:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 08:51:34 +0100
Subject: [PATCH v2 05/10] refs: use "initial" transaction semantics to
 migrate refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241120-pks-refs-optimize-migrations-v2-5-a233374b7452@pks.im>
References: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
In-Reply-To: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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
2.47.0.274.g962d0b743d.dirty

