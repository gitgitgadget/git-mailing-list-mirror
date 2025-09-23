Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD10321454
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622669; cv=none; b=L1lfA1x8E9PjaiwHBmkYd2gA8YPZKh0GikPZ3Ioe7lY7nSh5a5XI2ZOniEIA2lFJXNmms/5cyO1cWKDo8ZARXLb9BcawBdJZJrxslBkl99CRMGCTVlHztWu3BsVV+cf63MBj11iWXuZcePGVawhg2PJYrvYMTbEQU3MEQyNhpVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622669; c=relaxed/simple;
	bh=WfMlJUCpJ93nhMPNPbGrWLGq4HIOmByu1iX61YcsYIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJ+hstl/UWHzRnQN+NlVfieoYYxO02/GbTIF/ip+OPdVTDlm5WRB3QYz6SvZFAkfkPU8qg8PKFz1zDNz571WOzwfLgIVbpZL4K8PbJMyFOQTUl61NnJONwVAi4zvD1F+66conEQKd6kJQ/Pu6tM8fELYuhA5Ar07g2v5OfuMLlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l3yPWdwq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mIq3Wg4m; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l3yPWdwq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mIq3Wg4m"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id EB3E91D00260;
	Tue, 23 Sep 2025 06:17:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 23 Sep 2025 06:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758622666;
	 x=1758709066; bh=GkcKIg+0cJD/VLwAaFdsPAfnjaT2+PcMLs1usYEK7+Q=; b=
	l3yPWdwqbHVBhbW4MK1oX0GiG4pvgjwF0mxUxd+FqyGbfFTjOKQ8vLzww2grctRe
	1ojCYVGG4/Th4zYU5sz4KHlvUmWhnuYjC6+eSI4b9n2y/Xn79mo18b1r7UKpEjqC
	igGXIeGlypayYfZBD3p6lmXq20/Yxx4KAM/uj+CUalbJvSDK40VvEcB9bKVE3HCz
	khdhMbcEryJaqssDcK4kxwCnuymAh+BoFA+J1yvKfjyq/DWL27Y95Ia098GYUA8l
	sBu/Oh9IfDLAvhDuI/rdGYcYhsYi1nSVYS3dwdbjQreu87yrP9GzKnDsdBeBOQKb
	DBGj8+BqzQsui2yACRiabQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758622666; x=
	1758709066; bh=GkcKIg+0cJD/VLwAaFdsPAfnjaT2+PcMLs1usYEK7+Q=; b=m
	Iq3Wg4mazcY91VThON4YnDjrE1kADJc702biv5XhezwXWLdaHRp92YTEpefW3+0V
	p/Dvk4ak9pF1lR99KVdjeXivmxPIdixyvEz4NJmVFr7F6ZeXd1/bEC1fWRcPq0F3
	EeHwq5Cg4zZ3IhJshYGoHFqxrWfU0ogs879u3F8JqmRdZ/WAdZ1WxeogmcLFdSez
	a6dzqjSFup08SNOYNN2INbU5Mlry5sZwlz4i9PrJYTUCPPLFrlyynbfgCxx9gr3M
	g0AtUizEjcGZ3+jL1geYBcfsO07/1m3RyLrD5QdV9W/xpadsYUZUhY22NGMMi8KV
	V2afRZA6yH0OUCQk1S4ZA==
X-ME-Sender: <xms:ynPSaM1q7-dUU67NeLH3PafN-VnDAIK7jbpRY3HEvrjTRmeROm_gHg>
    <xme:ynPSaKzoUQ33snvi8zW1jkpO59r3xGwiWr2zmKoSQ8kz89si-y-ScvIvwmPnfCTyx
    x3oSMLbAdl6N6qPPsTGfi5OwY4Qnn5jKt66fn_MMBLRGexdFXU5Uw>
X-ME-Received: <xmr:ynPSaOvzPTKyTYxAO5LDZn6d-z9RdoKSnd2AXL2-5wZ_vu46uNzxdkDfIX0sbxKxFHdhsOcl9bRA-Qt-NS9eGWogH_M6ClGA-v5iGlsSeXYL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:ynPSaMxsF5hcMwKR7R-i7QlhUPUd67phF6RoW4piobq-0tr6ax4kgQ>
    <xmx:ynPSaBBqPmiR2YQqCodpGj3vj5AWCpItC93qnh1_axs4epkYUnziGg>
    <xmx:ynPSaKenzauYby1gsb9Z75oca-h8-y3m8IMnjegE1e18XEcC0Ovy9g>
    <xmx:ynPSaLniLFlLIIIUeTm2vsdgqkM91MNTFCG0FvrLkWXuaT35C2Y02A>
    <xmx:ynPSaPRTcAKzLdFMQ4qedpoQJNYvjZP9XE1THDZ286Nu1-aXYyv9DyZc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 06:17:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4decf2d5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 10:17:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 12:17:11 +0200
Subject: [PATCH v6 12/15] packfile: move `get_multi_pack_index()` into
 "midx.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-packfiles-store-v6-12-b48f2a882759@pks.im>
References: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
In-Reply-To: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

The `get_multi_pack_index()` function is declared and implemented in the
packfile subsystem, even though it really belongs into the multi-pack
index subsystem. The reason for this is likely that it needs to call
`packfile_store_prepare()`, which is not exposed by the packfile system.
In a subsequent commit we're about to add another caller outside of the
packfile system though, so we'll have to expose the function anyway.

Do so now already and move `get_multi_pack_index()` into the MIDX
subsystem.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     |  6 ++++++
 midx.h     |  1 +
 packfile.c |  8 +-------
 packfile.h | 10 +++++++++-
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/midx.c b/midx.c
index 3faeaf2f8f..1d6269f957 100644
--- a/midx.c
+++ b/midx.c
@@ -93,6 +93,12 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
 	return 0;
 }
 
+struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
+{
+	packfile_store_prepare(source->odb->packfiles);
+	return source->midx;
+}
+
 static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *source,
 							  const char *midx_name)
 {
diff --git a/midx.h b/midx.h
index e241d2d690..6e54d73503 100644
--- a/midx.h
+++ b/midx.h
@@ -94,6 +94,7 @@ void get_midx_chain_filename(struct odb_source *source, struct strbuf *out);
 void get_split_midx_filename_ext(struct odb_source *source, struct strbuf *buf,
 				 const unsigned char *hash, const char *ext);
 
+struct multi_pack_index *get_multi_pack_index(struct odb_source *source);
 struct multi_pack_index *load_multi_pack_index(struct odb_source *source);
 int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id);
 struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
diff --git a/packfile.c b/packfile.c
index 9224ca424c..7a9193e5ef 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1003,7 +1003,7 @@ static void packfile_store_prepare_mru(struct packfile_store *store)
 		list_add_tail(&p->mru, &store->mru);
 }
 
-static void packfile_store_prepare(struct packfile_store *store)
+void packfile_store_prepare(struct packfile_store *store)
 {
 	struct odb_source *source;
 
@@ -1033,12 +1033,6 @@ struct packed_git *get_packed_git(struct repository *r)
 	return r->objects->packfiles->packs;
 }
 
-struct multi_pack_index *get_multi_pack_index(struct odb_source *source)
-{
-	packfile_store_prepare(source->odb->packfiles);
-	return source->midx;
-}
-
 struct packed_git *get_all_packs(struct repository *r)
 {
 	packfile_store_prepare(r->objects->packfiles);
diff --git a/packfile.h b/packfile.h
index fcefcbbef6..a9e561ac39 100644
--- a/packfile.h
+++ b/packfile.h
@@ -112,6 +112,15 @@ void packfile_store_free(struct packfile_store *store);
  */
 void packfile_store_close(struct packfile_store *store);
 
+/*
+ * Prepare the packfile store by loading packfiles and multi-pack indices for
+ * all alternates. This becomes a no-op if the store is already prepared.
+ *
+ * It shouldn't typically be necessary to call this function directly, as
+ * functions that access the store know to prepare it.
+ */
+void packfile_store_prepare(struct packfile_store *store);
+
 /*
  * Clear the packfile caches and try to look up any new packfiles that have
  * appeared since last preparing the packfiles store.
@@ -213,7 +222,6 @@ extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
-struct multi_pack_index *get_multi_pack_index(struct odb_source *source);
 struct packed_git *get_all_packs(struct repository *r);
 
 /*

-- 
2.51.0.536.g15c5d4f767.dirty

