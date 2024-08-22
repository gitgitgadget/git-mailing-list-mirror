Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D321487F9
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308531; cv=none; b=P2R6XZstE2f8DcN5c079KmpWOC6/zoyhmOIDBTEltFAie2n5r3x8REjT0z2OhW2y2vX/2y9ap9SSVv84rc7OsuBWgNg+oF/Bil/6apZ5O0SW3XjUwTASjFpt+2ihaXwHaV1Ox9mRmAONGRd8ASvvEZRQorzKhnXfjc5g8Q3qLfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308531; c=relaxed/simple;
	bh=HXaYwMm0emX9TDOvEcQoMqTc+6N5lzbBbDiSEqNI73I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYspobBoVlQy8tKSzDvneuiiC7g+CZE0Kxa9YDD92I8KCOOLOBrqmhAir+7zwhj6+8gZ6wQN5cMw+Q3d9zipJJcWORfDQg0BtZs7+XU2EHnPrtccR4egfYTZXjOBdnxllcqXI2DSZV8Axs/JaM4KSld+m+r8DfQaXaYOM2k0Mbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f4J3Lp6o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K5NK5fEu; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f4J3Lp6o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K5NK5fEu"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A3A5E1151AFF;
	Thu, 22 Aug 2024 02:35:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 22 Aug 2024 02:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724308529; x=1724394929; bh=9jNogeP9qC
	ouxRjRwy1Wl1chF9oyTsFasgZrjg+sFW4=; b=f4J3Lp6oVfCddWYdhEyxOxuB9A
	IAf5/cehZ2IPz/wO8FnVfgQ22g8h09z3GGPTeZ/kT8IhpAhNEzCkGVMK1ao455Sa
	iCEGoow4t00yRcZUMI6904IWhoggfq0T9Tb4FCYtoaQB6hgU9Pjcc+td4/cmRTL1
	Mi5aKxTW4dXMU2/swMbWUqP9SfWupGAU/wCDOFjccEMFRELYYPMLiP66+CW8qtmR
	ieHtKHUZFKQx2DPixuD5jq7NnEg32Wwwv6VwOPgdxwMrfBt/59PJQRCDqh+yA8Ah
	DVwx7XwM8QlTC4IjXuqmggiowJFFGuXNUx6XuRf3e17Qrm9fRxpqxb4ZODOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724308529; x=1724394929; bh=9jNogeP9qCouxRjRwy1Wl1chF9oy
	TsFasgZrjg+sFW4=; b=K5NK5fEuqqXKNphyAaVdfqL/kCJx0rnhUTq2QBJ6EPG3
	Zbho+WKBFc8z0bX/MU4QpOLIB/j/ofEtMNiIvf/wEogzyuAO2LXqlZ4mtK9waxFx
	YUcFiAUGi/naTSSOkuBo2YdxYQODVwGd61E3qS3oHbLLkDno7b2HIpibfjn1cdw+
	nWK+Iw62AA04GPJvUgEPajrE1Y58pqzsuHvaoy8cEZUbOocDeUEl8qo7NkEG90qz
	xS40hKbGD/SDH/3OKk82QvmnG8a+e2QfF8rWSGB0M+dGtM5L9A/cKSxA6CQqvtDK
	2phHeQjSLVqWFTrdbOYeTropKXEtpN05eAeggdDAqw==
X-ME-Sender: <xms:MdzGZoRdktslM_tGHPsA22HuHNXw0ZBeGJZgJd7-Js3fBJf05-cwGw>
    <xme:MdzGZlyF_PLM2rzJgdTVD6A2UlMN-nwLMhsKlA2vYPqaCk6CZoET6QEPXHkF_kUkl
    8wL6st5gOZBykinxg>
X-ME-Received: <xmr:MdzGZl3IhQWCkgwMhHRQphCx1rxsr7Y9Ts8PrsEL1nCj0NLX8lMDWMA0iXXANKqrhs_LWI5mtFi5dx7Uq4eWxEDWiqpZcP_ydyaefQAaopvenD4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MdzGZsBJmSycdEEbVhXYH2AYjTGcoSmN9IJw5k3Hq-oCggbRmzDk4w>
    <xmx:MdzGZhirym4kIflfQPIn0Fi6TFhpcwsc7MI7A6xccX7GgPf0SQK2xw>
    <xmx:MdzGZooFCU2D6ehsvvMdiexYmBYYyBhA8pP4Vwi5nRdvHCKaoGbv2Q>
    <xmx:MdzGZkjppiF5X9ibCaY0sg6t8qZeeLyY6W2t0YWzZ-xQg3ItM-_bww>
    <xmx:MdzGZmvSNPFgOb-I-MwID__kXD7AgVkO7MQFnHqB00gs3esl0FDtyWbX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 02:35:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5c786b8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 06:34:53 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:35:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 14/15] t/helper: refactor to not use `struct
 reftable_table`
Message-ID: <8eab399dfc6e0b3abaa9d8fe291850d692e019b4.1724308389.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im>
 <cover.1724308389.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724308389.git.ps@pks.im>

The `struct reftable_table` interface in our "reftable" test helper gets
used such that we can easily print either a single table, or a merged
stack. This generic interface is about to go away.

Prepare the code for this change by using merged tables instead. When
printing the stack we've already got one. When using a single table, we
can create a merged table from it to adapt.

This removes the last user of the generic interface.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-reftable.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 234fb80010f..c1942156b50 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -3,7 +3,6 @@
 #include "hex.h"
 #include "reftable/system.h"
 #include "reftable/reftable-error.h"
-#include "reftable/reftable-generic.h"
 #include "reftable/reftable-merged.h"
 #include "reftable/reftable-reader.h"
 #include "reftable/reftable-stack.h"
@@ -33,7 +32,7 @@ static void print_help(void)
 	       "\n");
 }
 
-static int dump_table(struct reftable_table *tab)
+static int dump_table(struct reftable_merged_table *mt)
 {
 	struct reftable_iterator it = { NULL };
 	struct reftable_ref_record ref = { NULL };
@@ -41,13 +40,12 @@ static int dump_table(struct reftable_table *tab)
 	const struct git_hash_algo *algop;
 	int err;
 
-	reftable_table_init_ref_iter(tab, &it);
-
+	reftable_merged_table_init_ref_iterator(mt, &it);
 	err = reftable_iterator_seek_ref(&it, "");
 	if (err < 0)
 		return err;
 
-	algop = &hash_algos[hash_algo_by_id(reftable_table_hash_id(tab))];
+	algop = &hash_algos[hash_algo_by_id(reftable_merged_table_hash_id(mt))];
 
 	while (1) {
 		err = reftable_iterator_next_ref(&it, &ref);
@@ -77,8 +75,7 @@ static int dump_table(struct reftable_table *tab)
 	reftable_iterator_destroy(&it);
 	reftable_ref_record_release(&ref);
 
-	reftable_table_init_log_iter(tab, &it);
-
+	reftable_merged_table_init_log_iterator(mt, &it);
 	err = reftable_iterator_seek_log(&it, "");
 	if (err < 0)
 		return err;
@@ -118,15 +115,13 @@ static int dump_stack(const char *stackdir, uint32_t hash_id)
 	struct reftable_stack *stack = NULL;
 	struct reftable_write_options opts = { .hash_id = hash_id };
 	struct reftable_merged_table *merged = NULL;
-	struct reftable_table table = { NULL };
 
 	int err = reftable_new_stack(&stack, stackdir, &opts);
 	if (err < 0)
 		goto done;
 
 	merged = reftable_stack_merged_table(stack);
-	reftable_table_from_merged_table(&table, merged);
-	err = dump_table(&table);
+	err = dump_table(merged);
 done:
 	if (stack)
 		reftable_stack_destroy(stack);
@@ -135,10 +130,12 @@ static int dump_stack(const char *stackdir, uint32_t hash_id)
 
 static int dump_reftable(const char *tablename)
 {
-	struct reftable_block_source src = { NULL };
-	int err = reftable_block_source_from_file(&src, tablename);
+	struct reftable_block_source src = { 0 };
+	struct reftable_merged_table *mt = NULL;
 	struct reftable_reader *r = NULL;
-	struct reftable_table tab = { NULL };
+	int err;
+
+	err = reftable_block_source_from_file(&src, tablename);
 	if (err < 0)
 		goto done;
 
@@ -146,9 +143,15 @@ static int dump_reftable(const char *tablename)
 	if (err < 0)
 		goto done;
 
-	reftable_table_from_reader(&tab, r);
-	err = dump_table(&tab);
+	err = reftable_merged_table_new(&mt, &r, 1,
+					reftable_reader_hash_id(r));
+	if (err < 0)
+		goto done;
+
+	err = dump_table(mt);
+
 done:
+	reftable_merged_table_free(mt);
 	reftable_reader_free(r);
 	return err;
 }
-- 
2.46.0.164.g477ce5ccd6.dirty

