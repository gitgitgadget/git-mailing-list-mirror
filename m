Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D394B14F138
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308520; cv=none; b=m/YLGro1cMSZNM1qW3ial9rxwxOP9Ge8AdW/4OYfaD9kwvHZ5Sl5LMMs4WCrj6HzB+cR9IPFvbyX776QEIpHfyz2eUbsz5WfpPZhnyx+PpWFxp44P/Ii9vhrVNIw6/MQVwW/tgfYZf35URnGCApz0Qh2Fvi0CuSEiVH6AMtzjBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308520; c=relaxed/simple;
	bh=JgKj1Aa9yUWGk/3/J14PocxDq0yttPGEAe+8SKh57F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz99/2vOOh+Ib4HQOkUnO2SLd3Mh6V/wweE9wgG2+zs7/Ks9Xbdr+J0ghsW6XAswLpyk1At+4CF6+NOEdXnSQJ+x6w+LLNjwOKCxindosiDi06y5nzGN4gMzt9ipGXLYwGCKBE2KxIJOnV4OyhyqGwxEji2U07HxVyrSywZL/+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b6BKFMlh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EZS+0Xvy; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b6BKFMlh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EZS+0Xvy"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 03F911151C11;
	Thu, 22 Aug 2024 02:35:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 22 Aug 2024 02:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724308517; x=1724394917; bh=j28WK6mDeG
	HWF8/XAlSF/jVi0yi90iFz3naMJuhkkZM=; b=b6BKFMlh/HQ/sGbSK/PxU/BfkW
	c2ingHcyxUVUm2mCgfkFubkBU4YWgtxiZLA+9yu/QeU+nnzz2BO56CFrz2UChMx2
	DEv9AEh8qDVliTXQjzXBKOw4CYUpgkWcPiBWrs6kFTQY44VkbwUgHdn7/CeqS+2b
	B4+GzAtJP/4IG9ZnhWi+6jO11kAPpPOmYKbJnNYzL40IrcCsQHBGDxCrBmjjQayW
	dSsqtjin/ZfSn5uK6ox7ZWJlAk+RhFCYF7PYkJH99TzzVjMEc1OF5DUDVcHXKG28
	u2UG3WKfxezEHySd9bGNn5TWKrFHIGKP/04BefS/U3ukwFyGiWrkYcR1fSLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724308517; x=1724394917; bh=j28WK6mDeGHWF8/XAlSF/jVi0yi9
	0iFz3naMJuhkkZM=; b=EZS+0Xvy4u3/q58o0JCjp8FrEsfoGiCbF7gqzUtlTikF
	NwM3a9JQw8Ko06Lvobr8PuzOkTiyUkz5MlQc6axUN8nTac96m2pVSrGPGUadsZkj
	1AMuo2m1TOF1oDGK2+yhMp/fh6MDxjBhotqWd2W7kLRioKFzEnkj/K2Hwsn+cSjk
	WMFSmvETGf9ycyF3Z0zHm40tE+bNJFyCdss3ov/4+0aBUdxrkiLifbmJDAA6YQzB
	bYMQrsLaFEImHslUIwgJEA5Ey0SFyzHKDtKpZdsk07jg7v0M1ndP4P3MLoRM1U1q
	3GNQeTonbEz8QJpCAQeQROByk7pGUxf4AiX37vokcg==
X-ME-Sender: <xms:JdzGZswmtCkpU9-NYdhOmwmO6m0j2-Jl34k30pM9mQy5hnf7wUU_Yg>
    <xme:JdzGZgTplZDCSJebstG-jgTvHcZZZDMYRTAwmVZv63xUZlqZ-zjU4Ucq3b5FYmeD8
    gOXwlFpV9uLnNCwzg>
X-ME-Received: <xmr:JdzGZuUmPn4tr9JRfWkd948WxwhdbrCVxMsPIrjSFsmaS0fGJkKMSJ73EMnEKuGtcxbxDGbcQuzM_RQxDUKsjaow9MYGGGqB7c8ghs7zRJOM14s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:JdzGZqi5Z01v8U6YVDgTHcNhoD2x1rHVhqXQpYE93hn2NmDrU2e-NA>
    <xmx:JdzGZuDAGjnMUeZhRYtGs0K8pkERl9K3k14HRfDttRXqtfgy3BjGWg>
    <xmx:JdzGZrL7E-kzcC2a4T6XVF6yMpAPk-O5SL_zT60vonFXuyrZTp2JNw>
    <xmx:JdzGZlCoWQimaxnuQG11Oxq40Xe68RKIsF_9OYmnmBaUZBT8rkKhmA>
    <xmx:JdzGZpNlSUnBu1Q_mh87hf2PzzdZ69FAR_5Z3H3u1azFh57o10p3TF39>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 02:35:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fe72c824 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 06:34:42 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:35:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 11/15] t/helper: inline `reftable_table_print()`
Message-ID: <a05e20609962676a2b5f0cd8ce678c2c86c84114.1724308389.git.ps@pks.im>
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

Move `reftable_table_print()` into the "dump-reftable" helper. This
follows the same reasoning as the preceding commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/generic.c          | 47 ---------------------------------
 reftable/reftable-generic.h |  3 ---
 t/helper/test-reftable.c    | 52 +++++++++++++++++++++++++++++++++++--
 3 files changed, 50 insertions(+), 52 deletions(-)

diff --git a/reftable/generic.c b/reftable/generic.c
index 6ecf9b880f7..495ee9af6b0 100644
--- a/reftable/generic.c
+++ b/reftable/generic.c
@@ -61,53 +61,6 @@ int reftable_table_read_ref(struct reftable_table *tab, const char *name,
 	return err;
 }
 
-int reftable_table_print(struct reftable_table *tab) {
-	struct reftable_iterator it = { NULL };
-	struct reftable_ref_record ref = { NULL };
-	struct reftable_log_record log = { NULL };
-	uint32_t hash_id = reftable_table_hash_id(tab);
-	int err;
-
-	reftable_table_init_ref_iter(tab, &it);
-
-	err = reftable_iterator_seek_ref(&it, "");
-	if (err < 0)
-		return err;
-
-	while (1) {
-		err = reftable_iterator_next_ref(&it, &ref);
-		if (err > 0) {
-			break;
-		}
-		if (err < 0) {
-			return err;
-		}
-		reftable_ref_record_print(&ref, hash_id);
-	}
-	reftable_iterator_destroy(&it);
-	reftable_ref_record_release(&ref);
-
-	reftable_table_init_log_iter(tab, &it);
-
-	err = reftable_iterator_seek_log(&it, "");
-	if (err < 0)
-		return err;
-
-	while (1) {
-		err = reftable_iterator_next_log(&it, &log);
-		if (err > 0) {
-			break;
-		}
-		if (err < 0) {
-			return err;
-		}
-		reftable_log_record_print(&log, hash_id);
-	}
-	reftable_iterator_destroy(&it);
-	reftable_log_record_release(&log);
-	return 0;
-}
-
 uint64_t reftable_table_max_update_index(struct reftable_table *tab)
 {
 	return tab->ops->max_update_index(tab->table_arg);
diff --git a/reftable/reftable-generic.h b/reftable/reftable-generic.h
index 65670ea093b..b8b1323a331 100644
--- a/reftable/reftable-generic.h
+++ b/reftable/reftable-generic.h
@@ -41,7 +41,4 @@ uint64_t reftable_table_min_update_index(struct reftable_table *tab);
 int reftable_table_read_ref(struct reftable_table *tab, const char *name,
 			    struct reftable_ref_record *ref);
 
-/* dump table contents onto stdout for debugging */
-int reftable_table_print(struct reftable_table *tab);
-
 #endif
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index db62ea8dc3b..82159fa51f4 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -30,6 +30,54 @@ static void print_help(void)
 	       "\n");
 }
 
+static int dump_table(struct reftable_table *tab)
+{
+	struct reftable_iterator it = { NULL };
+	struct reftable_ref_record ref = { NULL };
+	struct reftable_log_record log = { NULL };
+	uint32_t hash_id = reftable_table_hash_id(tab);
+	int err;
+
+	reftable_table_init_ref_iter(tab, &it);
+
+	err = reftable_iterator_seek_ref(&it, "");
+	if (err < 0)
+		return err;
+
+	while (1) {
+		err = reftable_iterator_next_ref(&it, &ref);
+		if (err > 0) {
+			break;
+		}
+		if (err < 0) {
+			return err;
+		}
+		reftable_ref_record_print(&ref, hash_id);
+	}
+	reftable_iterator_destroy(&it);
+	reftable_ref_record_release(&ref);
+
+	reftable_table_init_log_iter(tab, &it);
+
+	err = reftable_iterator_seek_log(&it, "");
+	if (err < 0)
+		return err;
+
+	while (1) {
+		err = reftable_iterator_next_log(&it, &log);
+		if (err > 0) {
+			break;
+		}
+		if (err < 0) {
+			return err;
+		}
+		reftable_log_record_print(&log, hash_id);
+	}
+	reftable_iterator_destroy(&it);
+	reftable_log_record_release(&log);
+	return 0;
+}
+
 static int dump_stack(const char *stackdir, uint32_t hash_id)
 {
 	struct reftable_stack *stack = NULL;
@@ -43,7 +91,7 @@ static int dump_stack(const char *stackdir, uint32_t hash_id)
 
 	merged = reftable_stack_merged_table(stack);
 	reftable_table_from_merged_table(&table, merged);
-	err = reftable_table_print(&table);
+	err = dump_table(&table);
 done:
 	if (stack)
 		reftable_stack_destroy(stack);
@@ -64,7 +112,7 @@ static int dump_reftable(const char *tablename)
 		goto done;
 
 	reftable_table_from_reader(&tab, r);
-	err = reftable_table_print(&tab);
+	err = dump_table(&tab);
 done:
 	reftable_reader_free(r);
 	return err;
-- 
2.46.0.164.g477ce5ccd6.dirty

