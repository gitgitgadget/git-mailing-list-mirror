Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C981B1421
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641801; cv=none; b=iJ08V+DjrL/vJ8o9+UHV7On+SLr6WHtonN74nnhisqlUAvd1NIMglRGqD4AxXLaR3w2M0XxkPbjGmGDdiaO6EQo4k2sd/8gCSqLrqWEioA6qP+KcrS58Uf+/106Hcbabhs0yGygU+LKhwqiP6PzQBL7twaqaNgVXcD5aoBrKhJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641801; c=relaxed/simple;
	bh=yL326INcgSlGwTefA72LgC1tFA93gcgSpgAlEoOzKBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9QcPWKBBYWiJES9H0L8vQEkzIHdfnlAY4tlQIRCpDs5ZVEB2t5tUdCk0pKiwMzTxNko1sVsZq0vmsJmzPXUioBfy43Oyp+PBnKUKyIdKUfD8AiPpiezj0K4rXehuItQwZ5xj2Rsgu86qKaq6rdii8VXWWiym3f67l8TX86c/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HVF77354; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k+eyazGZ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HVF77354";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k+eyazGZ"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7C85C138FCA7;
	Wed, 14 Aug 2024 09:23:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Aug 2024 09:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723641799; x=1723728199; bh=PhzvTclXZl
	cTbAOHxTyW/V9U+wbYK9RMD2KKxvJdTjQ=; b=HVF77354UIQkaHquaN6CHr3W6k
	P/o3e3qEXZGZWLN/EsCNHhrCLfJku6z/j6lEw6upzxLBER77JOcasnlgSdMLe8tm
	/JOqyw8OkgCszXeoazbjAIoYtaQaIiXsaI7MHIithP5wg6qFqoT6eie1tFWUbcd0
	59jHA8veAcvyypM2YyiRHBvdY1vhMy6tDzzJc0mxDhBiNgBSwy96OsRDSGIrntXs
	skBV2RfYuIstUov0hIX+fjMythiQ7ckcbMC6PvlSU3ObJAcZYGSkat0B0FTgEwTi
	Z/UYefZ22F1jY21wcvFb96URJVNGkWLsnjBmpDR2TpxyFYlFToubxDMl1GIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723641799; x=1723728199; bh=PhzvTclXZlcTbAOHxTyW/V9U+wbY
	K9RMD2KKxvJdTjQ=; b=k+eyazGZGYU+avcFLPj3ZSznqdwhagB8nkI0PKJiXQlr
	r4gAsF43ieNXnvwr/jRmdcoef3bnQfK+EHCQtnHTvmdKs8txHWqnjQqZYUNUhTYI
	EBpRQwVeyxdkFt1BbQHAHS0g/TIE1HQ0PgjnMANaJZ6VJvCPc18xOfPKk+9seX9D
	KfSWAKBJOJHlbpUF/y5v7VrnS2JPqdfhpy3juXm/7wUqbSmEm8ZeJd4wMPfD5jVN
	6o0jtVKMxFJ4qpohXLinZn4oAbNp+MlbwQAzNpdBO3q6qQNVk9ZRrX0LoGcvGMpt
	q/QSapbNPe4QHEvTNAGujuON2Ri2EXQdhwui2/BCdg==
X-ME-Sender: <xms:x6-8Zhdo_tM_ljGJGQzDNXccwvUGHkBxzk2ibj1GnFB3psSCAEPC4g>
    <xme:x6-8ZvMXAQSi432u5aUOQZYW-8S3Hv53RQ8Kf16zE1HaYA6U123tf2F8wkLtcWnEE
    qUyvhSgCRsG9ociog>
X-ME-Received: <xmr:x6-8ZqjcX3Ux1LpBUUo4nW_NsuIxiohiZY9ksYAFt6G1-XdaTjDv_eWSROZJF7GiGDnvIhPlfgRQECaa8vjAJTyI9Mm4hVUoSE2fxzC-bPwYeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:x6-8Zq9P03kqvXE_qhDiiMxatZgjBxOxP2qGbDZTUiXUm8cObyXPaQ>
    <xmx:x6-8ZtvrJyy-RsO-EG4aammqpXayl3KcUCFJsfzBdCd7bz1m5oEing>
    <xmx:x6-8ZpHKsIOAL_mp1HWVJQD2P3CbaFCCYAu8QqkFMCb4lGrr2S-4Fg>
    <xmx:x6-8ZkMXjtZIzXLfcGQv83iORyQxrl7JpVYAIw_iSNkBtGlO5ZnfqA>
    <xmx:x6-8Zm55FFWILHWQ5d-JTn-0X9CGJr1eEJzFbZLeWUgHTVkGloPxigkS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:23:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 612f87ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 13:22:59 +0000 (UTC)
Date: Wed, 14 Aug 2024 15:23:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 09/15] t/helper: inline `reftable_reader_print_file()`
Message-ID: <a62e4612e97dbe9c719ce1bf698158729bc14dd0.1723640107.git.ps@pks.im>
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

Move `reftable_reader_print_file()` into the "dump-reftable" helper.
This follows the same reasoning as the preceding commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c          | 21 ---------------------
 reftable/reftable-reader.h |  2 --
 t/helper/test-reftable.c   | 23 ++++++++++++++++++++++-
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index e3f5854229..fbd93b88df 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -798,27 +798,6 @@ void reftable_table_from_reader(struct reftable_table *tab,
 	tab->table_arg = reader;
 }
 
-
-int reftable_reader_print_file(const char *tablename)
-{
-	struct reftable_block_source src = { NULL };
-	int err = reftable_block_source_from_file(&src, tablename);
-	struct reftable_reader *r = NULL;
-	struct reftable_table tab = { NULL };
-	if (err < 0)
-		goto done;
-
-	err = reftable_new_reader(&r, &src, tablename);
-	if (err < 0)
-		goto done;
-
-	reftable_table_from_reader(&tab, r);
-	err = reftable_table_print(&tab);
-done:
-	reftable_reader_free(r);
-	return err;
-}
-
 int reftable_reader_print_blocks(const char *tablename)
 {
 	struct {
diff --git a/reftable/reftable-reader.h b/reftable/reftable-reader.h
index a32f31d648..7c7d171651 100644
--- a/reftable/reftable-reader.h
+++ b/reftable/reftable-reader.h
@@ -64,8 +64,6 @@ uint64_t reftable_reader_min_update_index(struct reftable_reader *r);
 void reftable_table_from_reader(struct reftable_table *tab,
 				struct reftable_reader *reader);
 
-/* print table onto stdout for debugging. */
-int reftable_reader_print_file(const char *tablename);
 /* print blocks onto stdout for debugging. */
 int reftable_reader_print_blocks(const char *tablename);
 
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 7f37d0cd34..19367c25f9 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -1,5 +1,6 @@
 #include "reftable/system.h"
 #include "reftable/reftable-error.h"
+#include "reftable/reftable-generic.h"
 #include "reftable/reftable-reader.h"
 #include "reftable/reftable-stack.h"
 #include "reftable/reftable-tests.h"
@@ -28,6 +29,26 @@ static void print_help(void)
 	       "\n");
 }
 
+static int dump_reftable(const char *tablename)
+{
+	struct reftable_block_source src = { NULL };
+	int err = reftable_block_source_from_file(&src, tablename);
+	struct reftable_reader *r = NULL;
+	struct reftable_table tab = { NULL };
+	if (err < 0)
+		goto done;
+
+	err = reftable_new_reader(&r, &src, tablename);
+	if (err < 0)
+		goto done;
+
+	reftable_table_from_reader(&tab, r);
+	err = reftable_table_print(&tab);
+done:
+	reftable_reader_free(r);
+	return err;
+}
+
 int cmd__dump_reftable(int argc, const char **argv)
 {
 	int err = 0;
@@ -64,7 +85,7 @@ int cmd__dump_reftable(int argc, const char **argv)
 	if (opt_dump_blocks) {
 		err = reftable_reader_print_blocks(arg);
 	} else if (opt_dump_table) {
-		err = reftable_reader_print_file(arg);
+		err = dump_reftable(arg);
 	} else if (opt_dump_stack) {
 		err = reftable_stack_print_directory(arg, opt_hash_id);
 	}
-- 
2.46.0.46.g406f326d27.dirty

