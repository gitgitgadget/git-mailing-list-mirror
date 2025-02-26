Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E6221DB3
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583483; cv=none; b=FRILjh6IHX5KxhBN/kPvRlZbIDjQ+DZPGfYhWAzAk5oJqEB4xkgMkMNJ6VVyudC9ZGuTxR1cE7DykfUYMw7LjAMc5Cocw9Oe11tpwZCVjU3lHDrJ4sGZEcrbEZ4Fchp1HiyI5NZY34qA4p8jXhc/N5TbEHF8/+ZwoWM0qMmJOcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583483; c=relaxed/simple;
	bh=Uo/LcpRB2gq3vG2ZRCQOyL6whxmLh+v+ex8UmOr1CRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l/tAExJlKCywROjpyGf7lyYQ1BSoSu/PKD4CA13OzaYgJSsJ6bqFI3Lv3tLoNjWbRR8FrxGa8CqorqIVwuZCZ7m/qlCyf8qDKLHA1YRQYkr0BlzfG7oFQcUSwcrgPtRYnipv5KPDTOX1dw8wUZDflPJAxInk/6Q+S5mVqaEbRT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QgkFDbqP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UgU7ZdbH; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QgkFDbqP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UgU7ZdbH"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 43A6611401EF;
	Wed, 26 Feb 2025 10:24:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 26 Feb 2025 10:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740583480;
	 x=1740669880; bh=+6jTyxRlqh3QmYJUQX5bfH1MzBPGt2WQHO7YBwMgnEI=; b=
	QgkFDbqP3VVzTi64F4Dq3cL0FC3obb5P7f4ubroGVqvhr8P/g+LrMyhn4TB+A3In
	WxWL4+kNsEdey7F6i61u72lEmt+fR8Di/MSJouue2YbHvG+sE9iu6GVbkU3H0W2D
	fnHBOvc0mWASS+RpDRCsPF+W/6KRedLwC5fPAsvo1fFLeWPKW63XMh1BQGDMu64j
	qejbCIZVhIiGVDKfJTm4qjLVcDSK6UHIElCbHTmI48UaVIvmsJYtM/SzdhCh3yps
	ZT13eBRIE3rdQbki7dO3QgvXXSKDgu5Sz0jYTwIOzRN4NuYZmkEoerd7DTQIvUjM
	kpNQLYwh4HRcZZio+X1QNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740583480; x=
	1740669880; bh=+6jTyxRlqh3QmYJUQX5bfH1MzBPGt2WQHO7YBwMgnEI=; b=U
	gU7ZdbHfF0S6jvZHPljVeyaKzcPRlSMlM3iZrekE9Zg7Vuugv3Ugn8ciyWk8MHnC
	dCIZ2n1Cwum90OJ0TBua6ueo34i+bk+L61PuKuZt88TZ6eMwBzG1R/p237eYBYOZ
	CYjNgTgRp4/fk5aGIZuhaIUY3UkgabOFChg362ahrXrG0b8bqYqzd2R5sc9NJoUR
	reGGKeAP56/NSr+s5IHELWvfy4WIPwIXq2wzKC5C/Lk0GywVRQdhZlllICSw+j8r
	oG4b9/TOzmkt2XpxOiM99SOOtCo3FwiMFCZmKnE2GzmBOyPRDvS4+rxIXJIsN8Go
	HPMMYQIY4RXJVCBTulUIA==
X-ME-Sender: <xms:NzK_Zw9bcnGwj7t0B8aZ6azx9DbHotClXJb9hiHM5KksUMLRl7mbDA>
    <xme:NzK_Z4tbSkcnc1Pk45_JUGarkGeB4Uga36mYdtVgRp-3HovBs0R36vTio_CLJbrKF
    8IMbZSkmfh1P8dATA>
X-ME-Received: <xmr:NzK_Z2A0bA7BFejIl2sRFWrqqF4tEo8PUCnfFAo2Uco9iMg7vym9QSjt0zfHrEjsmNXGSirL2eoFWZFVA1a97bq3NY0RLXzZ7Kbb1UTt4tjoCwDT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvddtvdehsehugihprdguvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:NzK_Zwf5gyjEzaV0cabcSg9H_R2qUeMsKuTRPa-HZ7-VdYkORp6YDw>
    <xmx:ODK_Z1MWpbJR2rr-0skx7Q6Jl9KWdu0wRo9hvNWNRkmBP1yVEY7G9w>
    <xmx:ODK_Z6mvw3Fe9KOo_82TQhIcaLCKrOJNSanVBB6ZimEuivfeHbqTXQ>
    <xmx:ODK_Z3syjTAxjzmiBc-ZKnPqBTe7jpYa63lwkWVVD34a-BT5kNkXgw>
    <xmx:ODK_Z6p1Rvrp_CPH9FeiUFdFQ4XyMuNu6cLl6Ua94OGdIIuF6tsSYc6v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 10:24:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 38b4452c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 15:24:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 26 Feb 2025 16:24:29 +0100
Subject: [PATCH 4/6] builtin/reflog: make functions regarding
 `reflog_expire_options` public
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-pks-maintenance-reflog-expire-v1-4-a1204a814952@pks.im>
References: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
In-Reply-To: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
To: git@vger.kernel.org
Cc: Markus Gerstel <2025@uxp.de>, Junio C Hamano <gitster@pobox.com>, 
 Derrick Stolee <stolee@gmail.com>
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
2.48.1.741.g8a9f3a5cdc.dirty

