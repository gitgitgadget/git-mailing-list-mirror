Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D213CFBB
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308517; cv=none; b=gegpHY2kRQFY9KVK4qlUoNl+ZeZFXqsKVrsSES2ylppvzInc4feifrqvbTao47RwdKLR+A56lzzJTP7rqkq85EPQ/Be/LekNirF6uCEyRkn4e2IyONLp3f7o7rX83SkKZ6WaZLB4bvVii/aZuFoLV5LKxSxnE7me1qXogEscimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308517; c=relaxed/simple;
	bh=kBe3EzKn2Bd1uMyTgATbudChpB1k107AytiCQusESws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnJ3j/2as+P1DhRGeDXdooV7xM1s+76l5xuNBABz0kzsQePxzw29H03NZWLTHpUMTDKWwpFV5XOJpqRFQWTnq8OpAXDgimIPzWLPSXWSXSxD/JfEa1JNvSMbB+mj4e6j2SxolPRGDJcVFe7gffcFVSV6KUNTe4jYMmFzon2mDBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f3fEDp3Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sJtH7o9m; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f3fEDp3Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sJtH7o9m"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id CBB14138EFB6;
	Thu, 22 Aug 2024 02:35:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 22 Aug 2024 02:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724308514; x=1724394914; bh=utK2VRBCxF
	JYa69lguubEG+J35Ad/UePl4MznHM4MyA=; b=f3fEDp3Zxbzg9K8NQyfbxAcimP
	i6nvfpg87uAh++c/g+X4w1MpezM07Lt7h1/eKOpOsBNUO/vPeMDZIRnqlqHvUlbj
	w71+Y/pQptP2VVCutC1PLPyx/G8FooWSHJGb4idT0SI2U+Qija9pxHzCWU1aF2qY
	3z2qyUzWmF0UhXD+/4m6TZOZThQlNuArRvSuH0ty/d6Qrj0tHpXYSyN43HYKCb03
	R9IXpLd1JTeuxtFugoTjewia0GitGIaDE56JdwMwT/3qcyo97MoMSJJRCstr7ZLS
	lm9XKpbxbexvgsuLtpmS8sIlJU0iLx2DvmO2QuxzrnRGef2DemOhqeZfyHSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724308514; x=1724394914; bh=utK2VRBCxFJYa69lguubEG+J35Ad
	/UePl4MznHM4MyA=; b=sJtH7o9m+zJd82H6Y+RQy8Eci6kgZL5mbv21dOq64iBV
	wIKGggMPX0oq9BKvyUP2HcpwD2xJQnHsCUPWT0HBgK7VZ7QrhS7/7S+NNrzgK5OV
	SGUlaxKPF8iqb8nP7cN774vOwjrQ/7HOlnTQgpAiwgM0/Q5t/BjLOfspypSo2Nlm
	YGdS+xp0tD22juFxXrdpW+s+44ltW0xALn9rGBPtukLO+BhXrmfQN1DurYvzYsjD
	zFnVgsH87271t8IYmnS2s7sF+bCslTkkZcLR5PFaMMLkaXYlBvDttFKGkdChJWBS
	T7NeL8H3Tjn2TdJ1LwQzb1FKTqHHDTvBTg8M3X47OQ==
X-ME-Sender: <xms:ItzGZsN2AeG0nzVnq9-g5fL8ifyI-2qTn94wWv9PJrev4JLaWHfzXQ>
    <xme:ItzGZi_fDPwK115eXucr4FRfUAMnJHnN2SxR-TZTdlCcCggizyFN9ExjuV0mEsAEI
    nXrbOcx7JkdWX8jmw>
X-ME-Received: <xmr:ItzGZjSZs1q9uescofAeoifnhqOyMxRi4bSSeaYTHXKFIwJBnz-tlqu-6pQzEWL5X7G9tqGdOz2uAEXHqaIgC9F9mR3dxx2zTzKdW0O6-wqeIOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ItzGZktf8JKYUdCXpqGGyWXzKThPzHlJsPJUUtlbATpqYh-_QdUWkw>
    <xmx:ItzGZke5XaUXdTcUaeVDyWvc2dq48fD_luwskoypsVZVArPDAWvF1A>
    <xmx:ItzGZo1JuH15ulS8zjQEQNNXkTCBW1JkXgFIgZrPBRXqOYZcR0-u3w>
    <xmx:ItzGZo-QJaA2U97oBLFwQ5wtOxoyzdpB-lSc2xd4aU1-elgW1HqrCg>
    <xmx:ItzGZs5zecSAESmfVMlD5wk9MLzdx0z5xQwJXVtoecpngeSCPVDJJfC5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 02:35:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ec903025 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 06:34:39 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:35:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 10/15] t/helper: inline `reftable_stack_print_directory()`
Message-ID: <242c179df5fdfaafdb133e4c5af37c1fd860c5ce.1724308389.git.ps@pks.im>
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

Move `reftable_stack_print_directory()` into the "dump-reftable" helper.
This follows the same reasoning as the preceding commit.

Note that this requires us to remove the tests for this functionality in
`reftable/stack_test.c`. The test does not really add much anyway,
because all it verifies is that we do not crash or run into an error,
and it specifically doesn't check the outputted data. Also, as the code
is now part of the test helper, it doesn't make much sense to have a
unit test for it in the first place.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-stack.h |  3 ---
 reftable/stack.c          | 20 --------------------
 reftable/stack_test.c     |  7 -------
 t/helper/test-reftable.c  | 23 ++++++++++++++++++++++-
 4 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index 09e97c99915..f4f8cabc7fb 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -140,7 +140,4 @@ struct reftable_compaction_stats {
 struct reftable_compaction_stats *
 reftable_stack_compaction_stats(struct reftable_stack *st);
 
-/* print the entire stack represented by the directory */
-int reftable_stack_print_directory(const char *stackdir, uint32_t hash_id);
-
 #endif
diff --git a/reftable/stack.c b/reftable/stack.c
index d08ec009590..bedd503e7e1 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1603,23 +1603,3 @@ int reftable_stack_clean(struct reftable_stack *st)
 	reftable_addition_destroy(add);
 	return err;
 }
-
-int reftable_stack_print_directory(const char *stackdir, uint32_t hash_id)
-{
-	struct reftable_stack *stack = NULL;
-	struct reftable_write_options opts = { .hash_id = hash_id };
-	struct reftable_merged_table *merged = NULL;
-	struct reftable_table table = { NULL };
-
-	int err = reftable_new_stack(&stack, stackdir, &opts);
-	if (err < 0)
-		goto done;
-
-	merged = reftable_stack_merged_table(stack);
-	reftable_table_from_merged_table(&table, merged);
-	err = reftable_table_print(&table);
-done:
-	if (stack)
-		reftable_stack_destroy(stack);
-	return err;
-}
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index dbca9eaf4a8..42044ed8a3e 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -179,13 +179,6 @@ static void test_reftable_stack_add_one(void)
 	EXPECT(0 == strcmp("master", dest.value.symref));
 	EXPECT(st->readers_len > 0);
 
-	printf("testing print functionality:\n");
-	err = reftable_stack_print_directory(dir, GIT_SHA1_FORMAT_ID);
-	EXPECT_ERR(err);
-
-	err = reftable_stack_print_directory(dir, GIT_SHA256_FORMAT_ID);
-	EXPECT(err == REFTABLE_FORMAT_ERROR);
-
 #ifndef GIT_WINDOWS_NATIVE
 	strbuf_addstr(&scratch, dir);
 	strbuf_addstr(&scratch, "/tables.list");
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 19367c25f9a..db62ea8dc3b 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -1,6 +1,7 @@
 #include "reftable/system.h"
 #include "reftable/reftable-error.h"
 #include "reftable/reftable-generic.h"
+#include "reftable/reftable-merged.h"
 #include "reftable/reftable-reader.h"
 #include "reftable/reftable-stack.h"
 #include "reftable/reftable-tests.h"
@@ -29,6 +30,26 @@ static void print_help(void)
 	       "\n");
 }
 
+static int dump_stack(const char *stackdir, uint32_t hash_id)
+{
+	struct reftable_stack *stack = NULL;
+	struct reftable_write_options opts = { .hash_id = hash_id };
+	struct reftable_merged_table *merged = NULL;
+	struct reftable_table table = { NULL };
+
+	int err = reftable_new_stack(&stack, stackdir, &opts);
+	if (err < 0)
+		goto done;
+
+	merged = reftable_stack_merged_table(stack);
+	reftable_table_from_merged_table(&table, merged);
+	err = reftable_table_print(&table);
+done:
+	if (stack)
+		reftable_stack_destroy(stack);
+	return err;
+}
+
 static int dump_reftable(const char *tablename)
 {
 	struct reftable_block_source src = { NULL };
@@ -87,7 +108,7 @@ int cmd__dump_reftable(int argc, const char **argv)
 	} else if (opt_dump_table) {
 		err = dump_reftable(arg);
 	} else if (opt_dump_stack) {
-		err = reftable_stack_print_directory(arg, opt_hash_id);
+		err = dump_stack(arg, opt_hash_id);
 	}
 
 	if (err < 0) {
-- 
2.46.0.164.g477ce5ccd6.dirty

