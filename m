Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FBA221726
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583482; cv=none; b=Kv58uzqiJ3+mpCfkyDq29A7Z9IKjtBT76dC1MLuPdHxBEyoo4KEKL+jreepYltogsH0daP2gi6q/k+AOB0EP9Tgy067AGgY1EVCluP4btX6rZxL8+FbY3ru9OiZJOLvWLKpsrPc1cMYssl6tdQFUtP7ZmBecV3vCcmXAVXhFxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583482; c=relaxed/simple;
	bh=/8F/exj/d48uaDSJSPMlk4a/4zR7XpDny/YTRo6mhbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A8ybnKtdEfnj0iX/h1NAt+kNZCU4Mw6CdHvg30InoexfZQ2Fo1k2INNdTeSEYGl0aXvmBIVohFiNPOniTeYweTVUDHOYZ5C3EZskDJmVJjpWm3NUsHcLDXcvCTCWK9uCSo6Mn9SpBZc0hcdXVC2X4UvwwD7NuV4kNdlKwjRNUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jdQdC3SC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q1DwZmVk; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jdQdC3SC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q1DwZmVk"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id ED2E311401D8;
	Wed, 26 Feb 2025 10:24:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 26 Feb 2025 10:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740583479;
	 x=1740669879; bh=X18WWKDmLCcw+GPaSN6ZDkA2mvd4Z6o5V5zCSNyvhI0=; b=
	jdQdC3SCgYzQCKYI8baV7DaYp3kwsHwyREWw9LpeAIcQU5yRoTRBQa7/nhOvXcz+
	rU+mc9vYIH78uKlXqSXgbOJq12XmEKr6Eep3APh3K/Mk710lFlkyN8sdnAEOlr8T
	98KkalW20XFS8ZXdw4sKVm/xlK8wqaAzmrO5ZWjEgQO9ohJLodzc0BXbzhTV1H4u
	OVBVzGc1Rk/oSR7ypfgfvUrbI/v6Wl8SXi4HGfP75JHt74FEfQ5Vjj011LWK4Ydi
	CbiXDnmGPVcC5BaonsNl0In4srDRHOcmEgqgmuOjE13c/89dzEj5KYtJonUViC6e
	/mzF6yC4SSn4agQkv5j4nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740583479; x=
	1740669879; bh=X18WWKDmLCcw+GPaSN6ZDkA2mvd4Z6o5V5zCSNyvhI0=; b=Q
	1DwZmVk32Gz10th+LuINvBSQDTij+T7wuWRtR7hHJ9Rrh1Gnvss/9MFnYmGUCgxm
	4bIZZEddb2ks1V3xvq11TjiUO1F8qzdfnj0mjITlK0zdEKkhw/ChAHjLNERnNdhq
	6RjNTF3CjQ1G+niJGwhKPmpXnKk1QOkw1hNHWSppXrIOFEif9tTM3U2gHB1F2I7s
	+rU+2NqP5We0U0HTI5m6saxiYPvvO/c12e8XqAbgdDQjkFpXCBsQF+9J2pnB7kEQ
	JlWWzG2AoIyadbS3ZvfFMuYoXwvTSE5u4nyyu2QHyzfnIDaelU8ZYtJ0Lg/H+oas
	SNraMJXJ9YVwC+4NeZORA==
X-ME-Sender: <xms:NzK_ZyOFHuKcUzd3NHn_JKt8uQ7ltQ6fMN9Q9NtuogsuT29sJTZzSA>
    <xme:NzK_Zw8-1hCyjGh1Gr8IqdsYnAzgMljMFwnM9sex0ZJ8R-_b7WLk1NRNhv8gnQMjN
    TFXRZYlrGXUwn1xyA>
X-ME-Received: <xmr:NzK_Z5Q-LtYJEtqFqgaf-CgLsTCEuml3bDUwBnWWh4Y9Lj0NXbjeecoyulhhl2Gz3Bc8rpfZLcrMtnisqxXupImgZN54cy-BLsy1OH9vDBjC1_hf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopedvtddv
    heesuhigphdruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NzK_ZysJPQsk_4O5zyNmGMsIbr_dJdaGMJaI_LaoZIv7IQLKxBB8pw>
    <xmx:NzK_Z6dNIZkFHYMQ2-Oz6gvax1uJkCg0vZopZ_bnpESs2yMyfa9JrQ>
    <xmx:NzK_Z222zAelLnEQWnv5IA8M_pK3-4Dit0meuKl_cnkNFaWOR431AQ>
    <xmx:NzK_Z-8rKWNF8iICUD206ngh9Kk1F_49WftuR7VyrrLB7clz3iiB0A>
    <xmx:NzK_Z56pFHqNgilijMHvysTTm047-SF5jsk2iWBRYadkK_aaOSgE9AWM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 10:24:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1534144f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 15:24:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 26 Feb 2025 16:24:28 +0100
Subject: [PATCH 3/6] builtin/reflog: stop storing per-reflog expiry dates
 globally
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-pks-maintenance-reflog-expire-v1-3-a1204a814952@pks.im>
References: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
In-Reply-To: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
To: git@vger.kernel.org
Cc: Markus Gerstel <2025@uxp.de>, Junio C Hamano <gitster@pobox.com>, 
 Derrick Stolee <stolee@gmail.com>
X-Mailer: b4 0.14.2

As described in the preceding commit, the per-reflog expiry dates are
stored in a global pair of variables. Refactor the code so that they are
contained in `sturct reflog_expire_options` to make the structure useful
in other contexts.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/reflog.c | 30 ++++++++++++------------------
 reflog.h         |  8 ++++++++
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 0910a4e25dc..a231cf4b857 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -88,27 +88,21 @@ static int collect_reflog(const char *ref, void *cb_data)
 	return 0;
 }
 
-static struct reflog_expire_cfg {
-	struct reflog_expire_cfg *next;
-	timestamp_t expire_total;
-	timestamp_t expire_unreachable;
-	char pattern[FLEX_ARRAY];
-} *reflog_expire_cfg, **reflog_expire_cfg_tail;
-
-static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
+static struct reflog_expire_entry_option *find_cfg_ent(struct reflog_expire_options *opts,
+						       const char *pattern, size_t len)
 {
-	struct reflog_expire_cfg *ent;
+	struct reflog_expire_entry_option *ent;
 
-	if (!reflog_expire_cfg_tail)
-		reflog_expire_cfg_tail = &reflog_expire_cfg;
+	if (!opts->entries_tail)
+		opts->entries_tail = &opts->entries;
 
-	for (ent = reflog_expire_cfg; ent; ent = ent->next)
+	for (ent = opts->entries; ent; ent = ent->next)
 		if (!xstrncmpz(ent->pattern, pattern, len))
 			return ent;
 
 	FLEX_ALLOC_MEM(ent, pattern, pattern, len);
-	*reflog_expire_cfg_tail = ent;
-	reflog_expire_cfg_tail = &(ent->next);
+	*opts->entries_tail = ent;
+	opts->entries_tail = &(ent->next);
 	return ent;
 }
 
@@ -124,7 +118,7 @@ static int reflog_expire_config(const char *var, const char *value,
 	size_t pattern_len;
 	timestamp_t expire;
 	int slot;
-	struct reflog_expire_cfg *ent;
+	struct reflog_expire_entry_option *ent;
 
 	if (parse_config_key(var, "gc", &pattern, &pattern_len, &key) < 0)
 		return git_default_config(var, value, ctx, cb);
@@ -152,7 +146,7 @@ static int reflog_expire_config(const char *var, const char *value,
 		return 0;
 	}
 
-	ent = find_cfg_ent(pattern, pattern_len);
+	ent = find_cfg_ent(opts, pattern, pattern_len);
 	if (!ent)
 		return -1;
 	switch (slot) {
@@ -168,12 +162,12 @@ static int reflog_expire_config(const char *var, const char *value,
 
 static void set_reflog_expiry_param(struct reflog_expire_options *cb, const char *ref)
 {
-	struct reflog_expire_cfg *ent;
+	struct reflog_expire_entry_option *ent;
 
 	if (cb->explicit_expiry == (EXPIRE_TOTAL|EXPIRE_UNREACH))
 		return; /* both given explicitly -- nothing to tweak */
 
-	for (ent = reflog_expire_cfg; ent; ent = ent->next) {
+	for (ent = cb->entries; ent; ent = ent->next) {
 		if (!wildmatch(ent->pattern, ref, 0)) {
 			if (!(cb->explicit_expiry & EXPIRE_TOTAL))
 				cb->expire_total = ent->expire_total;
diff --git a/reflog.h b/reflog.h
index a9d464bbf8c..b08780a30a7 100644
--- a/reflog.h
+++ b/reflog.h
@@ -2,7 +2,15 @@
 #define REFLOG_H
 #include "refs.h"
 
+struct reflog_expire_entry_option {
+	struct reflog_expire_entry_option *next;
+	timestamp_t expire_total;
+	timestamp_t expire_unreachable;
+	char pattern[FLEX_ARRAY];
+};
+
 struct reflog_expire_options {
+	struct reflog_expire_entry_option *entries, **entries_tail;
 	int stalefix;
 	int explicit_expiry;
 	timestamp_t default_expire_total;

-- 
2.48.1.741.g8a9f3a5cdc.dirty

