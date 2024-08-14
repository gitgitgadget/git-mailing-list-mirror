Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDA01B1421
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641806; cv=none; b=nwfTrRXBT5WarPdt8u3Nd0kHZZ1SnB2eL35Fp4zneKJpt6rUfTx1ia4/VXMDcaKtBxo06/cT01irYlJ21Y6jKn50Y9GCPQb1/fTrGazevNivWOmdQIV3ck8OureMbMf/U2ekaT4c5FdOYxqeRlDayzmmjxLAv1TE9h9zqm8CHBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641806; c=relaxed/simple;
	bh=qdWXOpgkNAVlhfbfgL4vX4sCfC+7MhazDvFFtU/Dl78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYepBOkyTNbSIxGJUdATSb+HTU4p927Eh91RBM8ZLqNKBJ7q2bLFWefd4KQQIiJZyha6nt8bBLmt6+SszzEjLUVXckNGxbwi+bVxu3TdWib2ZdjEJJfxVAIMNi87b+ybT+RyS9ba2AwRVIE9luDag9JbhW7wlBdx2RtuLI8PLHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GxgRaxJs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IP2qrjeo; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GxgRaxJs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IP2qrjeo"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8A3681151A8C;
	Wed, 14 Aug 2024 09:23:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 14 Aug 2024 09:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723641803; x=1723728203; bh=DJtmA9IExt
	X4oVgjDOzquHJH4qPv+p48yjj6yqTd7DU=; b=GxgRaxJsu7QruLL4cQ9LfY9BwC
	vA9IVapkTmZ1J9Xpm+rDf3mikKA/4/05EOfikk1VJRzc3JrVEoFzTaTNg4pJz+AI
	zjGgwbkdCNSSdWQpUhU62AH2iFBHnY9+gqaWoWMGk8imlRb1SsI3macCKKrHUZyj
	bhZEBTeX+X0bjZxu1XXTSqUj3ndOSh68XIE8wBmtS0ss3Nx1y5+FPfmdQOHv3f3F
	bzSoaHutry4puwqoqZ5Od1JbToER/Q9SDZ/3VaRJ8jSom2QErl2+Lxl6b8jV2I51
	FR67osGM8bb0onfu0cnIYwu3IjXU3v5F4p/Mpf+iVo3bCgbbwK0Z/CmTmNtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723641803; x=1723728203; bh=DJtmA9IExtX4oVgjDOzquHJH4qPv
	+p48yjj6yqTd7DU=; b=IP2qrjeoJHKXX3eWYdB0bz/Bseav3M79+4ChhABXLTFg
	ENKutdKH3OYttZJYSt2wp5WpMj1IEFuf/GCfOUre2V5UrgA7j4yIOoolvVtXwsmO
	FX9UOnJWlu2c5/7Ni2QATEF6wkycH7hFy8RkaQtoElKZEqfUV8FfsG9NG0xibs+q
	Ty2Lk/8unAXVCoHwebDFtHcvqSLz2YJ1YTt5CsqfmePh9h09XIqKCScMK6L4/krq
	58h/gRRUKZIocHJe1tuE1L4LBdFiGgc6K83wQnV+fTRkqwsQUv+894fIGjpOBKgi
	oyfHAQ+60oMmN2xy++s4yGZOrRVeBUVpgUWWaUe5pA==
X-ME-Sender: <xms:y6-8ZkGlAVyanUzvm8j5ESCpb8ErrsQNq_f72_NctadqbGaACj6Hxw>
    <xme:y6-8ZtXeDaXiKBmGko1FVvzs30ULiTf09_8Z2nn0PnsAy56iGcUxWfYXV1oJsBegs
    a078qOIMj5nbrCbqw>
X-ME-Received: <xmr:y6-8ZuKW19bEVksCWLdDY0AZlr-XkCd85Y3KfGsKojMgzh4KTqjR-RxUYPg_WQTWDUqAJcT_JmKwplouDioNY1iVgBuMtZXDZuZnPXTeJAPUNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:y6-8ZmG2lYSiEsLHhxnCbqFyBTRDHdYEGmzK2YUtdvGtT2oeXZLQOQ>
    <xmx:y6-8ZqWRSXHm1tKjDpBcsKo4jQa8o2b08-Tbd28iBxS6e_g-mw6ciA>
    <xmx:y6-8ZpPdLzARlayvTWCqIEicBGb-fXlv6pyThVUNCXFvvMGf1S4BPQ>
    <xmx:y6-8Zh37lLWTiYsClzxUw1Y4Qk5N4bFuptXVhgOZ5xs4LNDoBPNJkQ>
    <xmx:y6-8ZnhOlZCN43STxEXvkPMMT7J0z2jxZmLAwnBCF_XlO9Q7dl78L_Si>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:23:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 12a2f51c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 13:23:03 +0000 (UTC)
Date: Wed, 14 Aug 2024 15:23:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 10/15] t/helper: inline `reftable_stack_print_directory()`
Message-ID: <7acfe4fecc54beaa71d65f04c92e31ebe95aa1a0.1723640107.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723640107.git.ps@pks.im>

Move `reftable_stack_print_directory()` into the "dump-reftable" helper.
This follows the same reasoning as the preceding commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-stack.h |  3 ---
 reftable/stack.c          | 20 --------------------
 reftable/stack_test.c     |  7 -------
 t/helper/test-reftable.c  | 23 ++++++++++++++++++++++-
 4 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index 09e97c9991..f4f8cabc7f 100644
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
index d08ec00959..bedd503e7e 100644
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
index dbca9eaf4a..42044ed8a3 100644
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
index 19367c25f9..db62ea8dc3 100644
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
2.46.0.46.g406f326d27.dirty

