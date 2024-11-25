Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEB91531DC
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 06:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732516052; cv=none; b=bhIsT634oW5S0M91YGmY5g32H4Nu5W1xVy4XH8cjn/FHHWm8NJ+fp7Sr0/AzIPp1zsRN4Ql+2Qn7+hXwbim7DEvTBgy7q48R89fg5i1rI4UrBR3jBiggf2Kpk08pV4nFKFzUNiChIdb6xkb0daLDO4mHzvMCyTkOUon4gtQ37nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732516052; c=relaxed/simple;
	bh=OjiTeSixc8q4F+0tCp8BD5Jxtw4ayBAqPEhlGEeRzBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EebDVD/w7uLlqwWS5EnwSlRdqpcmKl2wLVy7sFrfmxkcXJWkqAputt0+uGT84GlDJ8X1xGX2d92koN6ooacanFkwbxMEigV0KcibFBxpL/n7ipJNqzDH1Gu33SbgMU6Udr4k4WBFPrXIrNYW/KFq3yPQ9SOwn6EMhDBjgDCNEgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yRyCDPcO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0y0J+jHG; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yRyCDPcO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0y0J+jHG"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 599BA2540182;
	Mon, 25 Nov 2024 01:27:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 25 Nov 2024 01:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732516049;
	 x=1732602449; bh=YYE2I49hdVByxgSjx/jKB5u9o5Huc2g+HUhKRyJex6k=; b=
	yRyCDPcOEaOGPdRkSzJIDtPx770m1uCcPklj9XYjplLHj0WLiVwnHbFRt1JCUsRn
	4gtQzl2xlMRe2CFO4+eIzN2i5giZhislHyHGb3pCmgkraYDccUzD57EFDrMeqAQS
	nFZBbDndTiAxBme+ODc+T8X4u7WVaIHE+FN6D3sfLNuiJOQCuuMuDnn6PKQBpI30
	yehAjaTI8TaNLxmvdwyQ/GulHp6lFdx9NLLCyp79tashcyyO8eBZH/sKruP33Z0a
	Vus99RHaVjdF4X+Wt2+7Sf4SRltP50ka19UCY/Cxjoz8Ml6XSqJfK+y8VX2mq5Xh
	MIDKzMdAy68vnchHtbiTIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732516049; x=
	1732602449; bh=YYE2I49hdVByxgSjx/jKB5u9o5Huc2g+HUhKRyJex6k=; b=0
	y0J+jHGO/2/I1y79qspr/gOFB4K/FF03h27Wus8qCqOFu67/nMGpLiuiAV63s2wu
	YjeTIrfvAX2FsoITN1Tyd7AFwZB8Ano0Oxmo8UeYiZYGL/o2Flr9Ntlci3fLo2u8
	GTwnRmHPXtDRiPcjG7xvfVkiZAFE9BZ6LOXxZ89CYI+56ucDg96qs2rMw1y/48jh
	nnwW8QVNv0q9C2h9w9FmTYQu96gBry5/fDb4fwHjMJNfcRT3WSXo3kWh80oCKeC7
	fgx1Emx7ALA/fSqf23Q1b8QV3/YqUEc3f+xAmga57uIxyVgMHxqHGt/4JLLMlGuW
	U3gjDDz256LchJhS1HDEw==
X-ME-Sender: <xms:0RhEZ1vUsiqJ_eVfHOYu8gDpnfY6K86Fqg46iNbNtg1aDKEqLkA25w>
    <xme:0RhEZ-dIyM5cPWU965XLa964Y6ZHZN7W7_f9GsJU4qnT3UwvEP6HMIVnoNCsVi9mV
    yksMcrWkqUotwJDnA>
X-ME-Received: <xmr:0RhEZ4zsGnv5I_MVjBsIxfPBtN_xS5ZIhUHCcLZFpTy-CTMhim_1SdZhCnftrU2vP17rVLsPhiG-La3LLw01T9c03BIn3eU-HdQ4ThSeTdHBBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtdduffdu
    veevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0RhEZ8Pr71gMyZvWIoO3EKAwXk6qeGEli_6pdbvSMRrLCxdCxwf6Gg>
    <xmx:0RhEZ19YABr6XADDz7wSTEEfTg9p4dYzX-zDndC3F9wFEQ3iSBRCRA>
    <xmx:0RhEZ8WWBbwCAFT0nDUQsmGS3B5BMlr6DKZVVnUPg7KB_K7So-hzgw>
    <xmx:0RhEZ2fBD1qlQcWEYvzUM348WPUE-jJcl9tAfIxfnkhipNNmRm8l7g>
    <xmx:0RhEZ4kBuin238qibiy-fCYgrwh7J5jKBbZQ1IxBJeLs9d7k9iKWxHPp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 01:27:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b30db16c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 06:26:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 07:27:10 +0100
Subject: [PATCH v3 05/10] refs: use "initial" transaction semantics to
 migrate refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241125-pks-refs-optimize-migrations-v3-5-17bc85e33ad7@pks.im>
References: <20241125-pks-refs-optimize-migrations-v3-0-17bc85e33ad7@pks.im>
In-Reply-To: <20241125-pks-refs-optimize-migrations-v3-0-17bc85e33ad7@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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

