Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFCF1B29A3
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641809; cv=none; b=Fk56tgm+MaS+UxlIW0JPhugeYq/mpx+7i9tfyJyStx8AlNw5JDLw1wyE/SxhG+plhiQcZxImwmrBS/SoIVhemHgE6wjCSd7gsojJ2tT+/YAAyDHi0dufjorLSY9yTIZV+6LWA7lKT7xrZyEecvs033pkwXAOhRXVU0Nvpvh3uMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641809; c=relaxed/simple;
	bh=E626MfdB8fkqJc29ZyxACLx+qCkQOswqvT88tGxwGtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppfKKYSmFLpIXWB41wneiIyzpXbk76AqjHqW+JPWa5bhVpU5yO4IKiwuz3u/LssuOAYO3SQnEX/2+vC6JU1mBS1T53n8zHsHKTc1gImrTlDmXIsDuX5DeO0TCf3tV3h2BzkC4pLiWt/Oe5LRAn6CZcjn82WcgyqrHiQSz2Yqbto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cKTJPBXe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FlxcAOx9; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cKTJPBXe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FlxcAOx9"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 88A28138FCA1;
	Wed, 14 Aug 2024 09:23:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 14 Aug 2024 09:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723641806; x=1723728206; bh=I+/cnwUJiw
	CNGZkNExRHdMR+DPsjyJZMhxov2QVRomU=; b=cKTJPBXeS1o1ujH9WLrEDnzaVi
	3GgX5EGZ6BY2hLIJhyPV0/kow+TnFhuKJ7WsY1AY5uSlTCe8sxdRKBxcB6yS8iXB
	oQDNPULwS0RE7VZRl1bE+PjoPGnBcTNnLeVCspuHOK+YNrPeD4yIskj4E3owgxQX
	70pUdpJnCeP+iQLSdizPCEeKEIPqM7YMg5mR3+yYqaQnOugCx7HMF6sQ/wDTzt0V
	YZOHbbGIUZbj+0d1Dw2BPQ7kV9uoszaeFAZAF4OBg/lDvQPokvY53AUY6TCraF5v
	gKgvAJEwNKiuZcHmmpz2J43qB8ulLgCB6l3n0GIrWDdLrFb6QgoONoW+rQ1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723641806; x=1723728206; bh=I+/cnwUJiwCNGZkNExRHdMR+DPsj
	yJZMhxov2QVRomU=; b=FlxcAOx96c1ynK58nhAiqBgtcclYoyHYxIg9KgaSz699
	7SbokwBUCs56OKm9PuZT4XylOAHTAIYL2eCYCXGAlK8gYEcCQvtIsBmbVG2XgrwK
	/xkQaQ+RuFHqYY+VuFnzbsYWRbq5p/qo5kddVlDoI51150JzLxtC3gY4CIUgIErD
	Emq+p+ZmodJpxyfaE/DFwMVr8et6m1gPdWWnJ65TFK97maqGDNDIjV4V+LOIpbkH
	nIeZ4Qty1El7U4PQq1RB3+PQzFvN14v0D4S4LoLunhg7ec+ETpdxBjwXjVOkjhQH
	i/YLEECw5GPaWP578wlsyHhct4ILNsyUG/D+S/jqRQ==
X-ME-Sender: <xms:zq-8ZsPlRlQ0cN7gCcm-DOCGSwQyOxwqn6O91MtVP_XDgK1F_khP2g>
    <xme:zq-8Zi8iV8aCKsr_jUINOgZdUM5ee5v6Xp-OG1XcEoQSyRFEpjvFznuCW12-S1idS
    bk9jVgZCmorc4x1Iw>
X-ME-Received: <xmr:zq-8ZjQghPgGi_iYAFLMu61KMbC6tUnmTvSlGej4hIKXjqTXAvHp4iSgkpCxl4DE2J4NfF0IsdXeg9HKDQpOyYYK2pEYQfYrZrUN4190WMgeBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:zq-8ZkvaA5LD0t0i20yrU20fzfjOW0Ppz_-LHpOj3kSiNlyk6vAqfA>
    <xmx:zq-8ZkcYKyXcinOpk0kAwbNnHX5Wjo83NzhhmYaQmOWVpGsqt8JtWw>
    <xmx:zq-8Zo28g_92ENRolvucTznSrIdicMCg3CCppzpI1Mz2d_Aq75_thA>
    <xmx:zq-8Zo-HF7H6fmKsA-AcYZkhNPoO-IjhdoAXwPHJjcv6D3wHwF0g3Q>
    <xmx:zq-8ZlpHsOacJL5e9wS7pBxumGslcWs_KmCo0-QzZhhWxXWb9riEr6lN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:23:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 232f5fc6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 13:23:06 +0000 (UTC)
Date: Wed, 14 Aug 2024 15:23:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 11/15] t/helper: inline `reftable_table_print()`
Message-ID: <8bd53a1a656c5d2b288a54dfaa0e0861a29f6a52.1723640107.git.ps@pks.im>
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

Move `reftable_table_print()` into the "dump-reftable" helper. This
follows the same reasoning as the preceding commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/generic.c          | 47 ---------------------------------
 reftable/reftable-generic.h |  3 ---
 t/helper/test-reftable.c    | 52 +++++++++++++++++++++++++++++++++++--
 3 files changed, 50 insertions(+), 52 deletions(-)

diff --git a/reftable/generic.c b/reftable/generic.c
index 6ecf9b880f..495ee9af6b 100644
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
index 65670ea093..b8b1323a33 100644
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
index db62ea8dc3..82159fa51f 100644
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
2.46.0.46.g406f326d27.dirty

