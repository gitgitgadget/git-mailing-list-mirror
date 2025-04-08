Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD445218EBA
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 06:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744093348; cv=none; b=Ndq5djyFC6pAzHYnRe9hQmFQ4rWi4qUS7upR5z0yuhl8VwMFxS5Ujkl+ex/OAS+JH+MwqJe7RxAfRQYKcUymdB1XSpqAvW/uIdWu5mIGggfjdqDIcNKvSTtga+EfHR3j0vCl3l8YrsYGVd2QInkZy9R3x68BffePjhqpW5MVKAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744093348; c=relaxed/simple;
	bh=loqvyB451Bvw0DiTXjsUWbF/0xZQ87RGIcGDRT2wdd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rg+Nhr2xAheLsDoHInyNxS4RgE3U0j1TyaLpbqvFV5JKVg5bq14jwV5T2XXTgqeb0m6CwjC/2+rbMYcedWHAwj00qHrdWhba7l4Mx1VevwAbgb/UbXcEmU30TxEyPIJx5pHTmc8xKvRVMYDZuql3AapfIT8DRn44AeXOzWiML6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xy5OrkXb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YmvWLtem; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xy5OrkXb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YmvWLtem"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0A7941380154;
	Tue,  8 Apr 2025 02:22:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 08 Apr 2025 02:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744093346;
	 x=1744179746; bh=TPzDhMb+pG/5OJVwQdLNbfp7Ql12ddRi5CRFQCpfQGM=; b=
	Xy5OrkXbm4kefQRq+SUJcmR76xX9+xwjZqm3CaCviyLxBpexuSWYw96KFZevdBcM
	7IGgSa6wwCfATPvw90wrVJlW1NeUyYgGJYDY+ZjBiNlml4XAssCOjUMXmQwoIhFo
	BNDTrnkAbF65ykm0vvavs5VI1HdBBlwZGLsm0TRxS5sN4HRCkTcuS11gxae2wl6Q
	wwsIgnnyDFkUr3Fq/Cc+STQ2v4Ab0G8tJ8I3ngK/jbLUI3lgabFUArb96/NxicFP
	rYFeyh/AwM5v1gfqY95ypQFynNJ34/b7qfUbeMgjpDos5EGVJTDYmjuZpmU1VEfD
	bq7VntXydw6yzLaf8K+o5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744093346; x=
	1744179746; bh=TPzDhMb+pG/5OJVwQdLNbfp7Ql12ddRi5CRFQCpfQGM=; b=Y
	mvWLtemPgcjn5hD1fRh4MUXfMSpccOH9zz4lGas5xHsi+S0FSOTe70zxS4YxwQiw
	mT2ZbHhr/lA5MccZIb5bfBHvNdGTDtBYG65NB7MATQnPUrv9VgxkNrBIYFkZFLXJ
	jjrMzUV3OiqFLqsGFCI5pvKRGOkSiPn/ICDIkybl5P6xTPid8uO+006MUJFuhOmu
	7hCPUqlc0QtrM8GGNQCVQZWeDK03B1MHTbOsgFgCE5YZB1c7Edoro1BYe/71mOn1
	jzE5g/rnJhGmfXlP6DCAT3IT4Ctcvzg375a4DOoaG1mTXmFPlCFWubEq4K8z07rI
	idXuJ9FUiVMF9jFHPC1Tw==
X-ME-Sender: <xms:ocD0Z-QqHwpNc2oqSTA3kdiLtr0NVNbIrU_IrFs0H1qB7X6oRflggw>
    <xme:ocD0Zzw39NnvMARRMlr4a3e9bs7_H2vDiIJIaQ0s-7GFDwUu6XdwamtA9HBr2NjG9
    NQ-C-yruJEQIEhZLA>
X-ME-Received: <xmr:ocD0Z73ESyH-I1b8e_sPOiWa9vt7cwGZrqnJ07is3U3wiEbeT-GaGVCzuO9NFWP9DMMxqtz6XYZjKmYydibpMtwQ_Tbs4xreRrXox04cADAEMDJl4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopedvtddvheesuhigphdruggvpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgr
    mhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:ocD0Z6D-I8mMUDxNZs7n3QvuiFUYPQMdyZCTTeWN80MXttAgLMaVBA>
    <xmx:ocD0Z3ju2rJc6s8NL88DCdRj9PsbSv2xA2vwD61Ns9nCcWmtO1f67Q>
    <xmx:ocD0Z2r1_UAXQyw1_SeDN-pdrkLnmyum_XKvOvlFFyNygY7n9ket0A>
    <xmx:ocD0Z6hL9HLATOB0nRNzpXkbSziigDyPqzdgTErG0vVt0yoaRp3gQQ>
    <xmx:osD0Z2NdpNHpqx5pemWmrdtDKNVH6ioIaYqc1oHM3_T2r_1t8aJnBybw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 02:22:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 83a2a951 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Apr 2025 06:22:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Apr 2025 08:22:15 +0200
Subject: [PATCH v2 4/6] builtin/reflog: make functions regarding
 `reflog_expire_options` public
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-pks-maintenance-reflog-expire-v2-4-1ad8634798b7@pks.im>
References: <20250408-pks-maintenance-reflog-expire-v2-0-1ad8634798b7@pks.im>
In-Reply-To: <20250408-pks-maintenance-reflog-expire-v2-0-1ad8634798b7@pks.im>
To: git@vger.kernel.org
Cc: Markus Gerstel <2025@uxp.de>, Junio C Hamano <gitster@pobox.com>, 
 Derrick Stolee <stolee@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>
X-Mailer: b4 0.14.2

Make functions that are required to manage `reflog_expire_options`
available elsewhere by moving them into "reflog.c" and exposing them in
the corresponding header. The functions will be used in a subsequent
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/reflog.c | 115 ++-----------------------------------------------------
 reflog.c         | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++
 reflog.h         |  17 ++++++++
 3 files changed, 128 insertions(+), 111 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index a231cf4b857..5fea31f9c3c 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -88,113 +88,6 @@ static int collect_reflog(const char *ref, void *cb_data)
 	return 0;
 }
 
-static struct reflog_expire_entry_option *find_cfg_ent(struct reflog_expire_options *opts,
-						       const char *pattern, size_t len)
-{
-	struct reflog_expire_entry_option *ent;
-
-	if (!opts->entries_tail)
-		opts->entries_tail = &opts->entries;
-
-	for (ent = opts->entries; ent; ent = ent->next)
-		if (!xstrncmpz(ent->pattern, pattern, len))
-			return ent;
-
-	FLEX_ALLOC_MEM(ent, pattern, pattern, len);
-	*opts->entries_tail = ent;
-	opts->entries_tail = &(ent->next);
-	return ent;
-}
-
-/* expiry timer slot */
-#define EXPIRE_TOTAL   01
-#define EXPIRE_UNREACH 02
-
-static int reflog_expire_config(const char *var, const char *value,
-				const struct config_context *ctx, void *cb)
-{
-	struct reflog_expire_options *opts = cb;
-	const char *pattern, *key;
-	size_t pattern_len;
-	timestamp_t expire;
-	int slot;
-	struct reflog_expire_entry_option *ent;
-
-	if (parse_config_key(var, "gc", &pattern, &pattern_len, &key) < 0)
-		return git_default_config(var, value, ctx, cb);
-
-	if (!strcmp(key, "reflogexpire")) {
-		slot = EXPIRE_TOTAL;
-		if (git_config_expiry_date(&expire, var, value))
-			return -1;
-	} else if (!strcmp(key, "reflogexpireunreachable")) {
-		slot = EXPIRE_UNREACH;
-		if (git_config_expiry_date(&expire, var, value))
-			return -1;
-	} else
-		return git_default_config(var, value, ctx, cb);
-
-	if (!pattern) {
-		switch (slot) {
-		case EXPIRE_TOTAL:
-			opts->default_expire_total = expire;
-			break;
-		case EXPIRE_UNREACH:
-			opts->default_expire_unreachable = expire;
-			break;
-		}
-		return 0;
-	}
-
-	ent = find_cfg_ent(opts, pattern, pattern_len);
-	if (!ent)
-		return -1;
-	switch (slot) {
-	case EXPIRE_TOTAL:
-		ent->expire_total = expire;
-		break;
-	case EXPIRE_UNREACH:
-		ent->expire_unreachable = expire;
-		break;
-	}
-	return 0;
-}
-
-static void set_reflog_expiry_param(struct reflog_expire_options *cb, const char *ref)
-{
-	struct reflog_expire_entry_option *ent;
-
-	if (cb->explicit_expiry == (EXPIRE_TOTAL|EXPIRE_UNREACH))
-		return; /* both given explicitly -- nothing to tweak */
-
-	for (ent = cb->entries; ent; ent = ent->next) {
-		if (!wildmatch(ent->pattern, ref, 0)) {
-			if (!(cb->explicit_expiry & EXPIRE_TOTAL))
-				cb->expire_total = ent->expire_total;
-			if (!(cb->explicit_expiry & EXPIRE_UNREACH))
-				cb->expire_unreachable = ent->expire_unreachable;
-			return;
-		}
-	}
-
-	/*
-	 * If unconfigured, make stash never expire
-	 */
-	if (!strcmp(ref, "refs/stash")) {
-		if (!(cb->explicit_expiry & EXPIRE_TOTAL))
-			cb->expire_total = 0;
-		if (!(cb->explicit_expiry & EXPIRE_UNREACH))
-			cb->expire_unreachable = 0;
-		return;
-	}
-
-	/* Nothing matched -- use the default value */
-	if (!(cb->explicit_expiry & EXPIRE_TOTAL))
-		cb->expire_total = cb->default_expire_total;
-	if (!(cb->explicit_expiry & EXPIRE_UNREACH))
-		cb->expire_unreachable = cb->default_expire_unreachable;
-}
-
 static int expire_unreachable_callback(const struct option *opt,
 				 const char *arg,
 				 int unset)
@@ -207,7 +100,7 @@ static int expire_unreachable_callback(const struct option *opt,
 		die(_("invalid timestamp '%s' given to '--%s'"),
 		    arg, opt->long_name);
 
-	opts->explicit_expiry |= EXPIRE_UNREACH;
+	opts->explicit_expiry |= REFLOG_EXPIRE_UNREACH;
 	return 0;
 }
 
@@ -223,7 +116,7 @@ static int expire_total_callback(const struct option *opt,
 		die(_("invalid timestamp '%s' given to '--%s'"),
 		    arg, opt->long_name);
 
-	opts->explicit_expiry |= EXPIRE_TOTAL;
+	opts->explicit_expiry |= REFLOG_EXPIRE_TOTAL;
 	return 0;
 }
 
@@ -353,7 +246,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 				.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
 			};
 
-			set_reflog_expiry_param(&cb.opts,  item->string);
+			reflog_expire_options_set_refname(&cb.opts,  item->string);
 			status |= refs_reflog_expire(get_main_ref_store(the_repository),
 						     item->string, flags,
 						     reflog_expiry_prepare,
@@ -372,7 +265,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 			status |= error(_("%s points nowhere!"), argv[i]);
 			continue;
 		}
-		set_reflog_expiry_param(&cb.opts, ref);
+		reflog_expire_options_set_refname(&cb.opts, ref);
 		status |= refs_reflog_expire(get_main_ref_store(the_repository),
 					     ref, flags,
 					     reflog_expiry_prepare,
diff --git a/reflog.c b/reflog.c
index bcdb75514d0..642b162ef70 100644
--- a/reflog.c
+++ b/reflog.c
@@ -2,13 +2,120 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
+#include "config.h"
 #include "gettext.h"
 #include "object-store-ll.h"
+#include "parse-options.h"
 #include "reflog.h"
 #include "refs.h"
 #include "revision.h"
 #include "tree.h"
 #include "tree-walk.h"
+#include "wildmatch.h"
+
+static struct reflog_expire_entry_option *find_cfg_ent(struct reflog_expire_options *opts,
+						       const char *pattern, size_t len)
+{
+	struct reflog_expire_entry_option *ent;
+
+	if (!opts->entries_tail)
+		opts->entries_tail = &opts->entries;
+
+	for (ent = opts->entries; ent; ent = ent->next)
+		if (!xstrncmpz(ent->pattern, pattern, len))
+			return ent;
+
+	FLEX_ALLOC_MEM(ent, pattern, pattern, len);
+	*opts->entries_tail = ent;
+	opts->entries_tail = &(ent->next);
+	return ent;
+}
+
+int reflog_expire_config(const char *var, const char *value,
+			 const struct config_context *ctx, void *cb)
+{
+	struct reflog_expire_options *opts = cb;
+	const char *pattern, *key;
+	size_t pattern_len;
+	timestamp_t expire;
+	int slot;
+	struct reflog_expire_entry_option *ent;
+
+	if (parse_config_key(var, "gc", &pattern, &pattern_len, &key) < 0)
+		return git_default_config(var, value, ctx, cb);
+
+	if (!strcmp(key, "reflogexpire")) {
+		slot = REFLOG_EXPIRE_TOTAL;
+		if (git_config_expiry_date(&expire, var, value))
+			return -1;
+	} else if (!strcmp(key, "reflogexpireunreachable")) {
+		slot = REFLOG_EXPIRE_UNREACH;
+		if (git_config_expiry_date(&expire, var, value))
+			return -1;
+	} else
+		return git_default_config(var, value, ctx, cb);
+
+	if (!pattern) {
+		switch (slot) {
+		case REFLOG_EXPIRE_TOTAL:
+			opts->default_expire_total = expire;
+			break;
+		case REFLOG_EXPIRE_UNREACH:
+			opts->default_expire_unreachable = expire;
+			break;
+		}
+		return 0;
+	}
+
+	ent = find_cfg_ent(opts, pattern, pattern_len);
+	if (!ent)
+		return -1;
+	switch (slot) {
+	case REFLOG_EXPIRE_TOTAL:
+		ent->expire_total = expire;
+		break;
+	case REFLOG_EXPIRE_UNREACH:
+		ent->expire_unreachable = expire;
+		break;
+	}
+	return 0;
+}
+
+void reflog_expire_options_set_refname(struct reflog_expire_options *cb,
+				       const char *ref)
+{
+	struct reflog_expire_entry_option *ent;
+
+	if (cb->explicit_expiry == (REFLOG_EXPIRE_TOTAL|REFLOG_EXPIRE_UNREACH))
+		return; /* both given explicitly -- nothing to tweak */
+
+	for (ent = cb->entries; ent; ent = ent->next) {
+		if (!wildmatch(ent->pattern, ref, 0)) {
+			if (!(cb->explicit_expiry & REFLOG_EXPIRE_TOTAL))
+				cb->expire_total = ent->expire_total;
+			if (!(cb->explicit_expiry & REFLOG_EXPIRE_UNREACH))
+				cb->expire_unreachable = ent->expire_unreachable;
+			return;
+		}
+	}
+
+	/*
+	 * If unconfigured, make stash never expire
+	 */
+	if (!strcmp(ref, "refs/stash")) {
+		if (!(cb->explicit_expiry & REFLOG_EXPIRE_TOTAL))
+			cb->expire_total = 0;
+		if (!(cb->explicit_expiry & REFLOG_EXPIRE_UNREACH))
+			cb->expire_unreachable = 0;
+		return;
+	}
+
+	/* Nothing matched -- use the default value */
+	if (!(cb->explicit_expiry & REFLOG_EXPIRE_TOTAL))
+		cb->expire_total = cb->default_expire_total;
+	if (!(cb->explicit_expiry & REFLOG_EXPIRE_UNREACH))
+		cb->expire_unreachable = cb->default_expire_unreachable;
+}
 
 /* Remember to update object flag allocation in object.h */
 #define INCOMPLETE	(1u<<10)
diff --git a/reflog.h b/reflog.h
index b08780a30a7..63bb56280f4 100644
--- a/reflog.h
+++ b/reflog.h
@@ -2,6 +2,9 @@
 #define REFLOG_H
 #include "refs.h"
 
+#define REFLOG_EXPIRE_TOTAL   (1 << 0)
+#define REFLOG_EXPIRE_UNREACH (1 << 1)
+
 struct reflog_expire_entry_option {
 	struct reflog_expire_entry_option *next;
 	timestamp_t expire_total;
@@ -24,6 +27,20 @@ struct reflog_expire_options {
 	.default_expire_unreachable = now - 90 * 24 * 3600, \
 }
 
+/*
+ * Parse the reflog expire configuration. This should be used with
+ * `repo_config()`.
+ */
+int reflog_expire_config(const char *var, const char *value,
+			 const struct config_context *ctx, void *cb);
+
+/*
+ * Adapt the options so that they apply to the given refname. This applies any
+ * per-reference reflog expiry configuration that may exist to the options.
+ */
+void reflog_expire_options_set_refname(struct reflog_expire_options *cb,
+				       const char *refname);
+
 struct expire_reflog_policy_cb {
 	enum {
 		UE_NORMAL,

-- 
2.49.0.682.gc9b6a7b2b0.dirty

