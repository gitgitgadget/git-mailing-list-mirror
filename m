Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4A621A431
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 06:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744093348; cv=none; b=mvFsoOWXy2aZKqKcO7MNroWjRxKjl36VMKK3xIG6/8vGPewWF8bS1ojjr1hQ5QZe25USJ8g49/MkFm4tOTVvk6l4E1nvQo2+iH1qUAuh79ADJy2qMaBWGCaOFlMaC8l82+eRqHXJmzWMBs3UtoJrKVmfeB3+J59j92Mp12SaTmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744093348; c=relaxed/simple;
	bh=eAFqXpoK+MfAL8fO+OfwJpx0JtJczPbS/FIhR6wIeWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LwzJ/ql6wfs8f+tOM6jErbTj7ebqRM6+wxHXuOuaEjL1syLwQArOadSJuPcsNfgsQhWOx/WT6soFu9O7hIfxr2H0EKdHwZifybli4jBAy9jVL+ir+mLaHY/Mgmg0Bc/NA2QNlzgpIu1mVFmcX8qcy3kbGBZ19jBc2vPQpOJmy6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E6DdoNIH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B35+x9PS; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E6DdoNIH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B35+x9PS"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B25A9138014A;
	Tue,  8 Apr 2025 02:22:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 08 Apr 2025 02:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744093345;
	 x=1744179745; bh=ScARK2TgiBex9ZjZx4pXnge+H0zzuCBoT8n764YXEIQ=; b=
	E6DdoNIHQHjHGeJNTo8Z1NnUyDr2ZlgtbeYQzbiCF3DHRSyXhvYhe1WBs8uzRMcy
	eXHOddEekFNjE9buFJa40tfwtjdN7nbKnrAz4bRisgdZMqRyc5woeh93bPSt7BTg
	h759KNeN2nnL6WgifZczFMo+NC1gEEaxpxKZ3NTaYsbgJIoD4JVeP5B8J9BCjEBp
	q0XTqMm6J9fOj94Su+/TAEv40oqc74MsmF/DC0H/0VxYfuW9t6e7XV9bWy6mgRWX
	3lOOPb0RJF/gd0Qdu/PHYJNUil6zBR8q+xeF6iBXcZdfBGwxNSqL4An15EhF5Gbb
	ifn2lbYXGrSVkUVqpGK3OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744093345; x=
	1744179745; bh=ScARK2TgiBex9ZjZx4pXnge+H0zzuCBoT8n764YXEIQ=; b=B
	35+x9PSivgkWxPY3Ga4aT/wGPOhF6b+lHKscwqGmmInPMQjJ1XbzkpyL+EZU0csc
	1Mn7GygSuRgVfXG7VlqwanbfkkPoMQ1RupRPvAOVF9Aw48Ocgf9qBl3M3eJ5sqFG
	IpP3Y8eQql6Y/iyydIfSIL3uG0NuYM8GhdR6vPUR3gOjjYsCzCH85lnnMAQvIByT
	g0S5q5lK8LDWCQdNKpLVTCz8rPjKMafLRQfBbt/NPqpKDs5mI02qLL9AtKGalFLL
	MdJWf87gflLI7RsjUH7qIIhNGiPhuJiL8Y8g+IilLFOfekdDQvGz6fjQsFpqgSjg
	1SOTOpgLidNIboUlBsh/g==
X-ME-Sender: <xms:ocD0ZzpT4hSzVpo0eLs3nqawv7PiItEfhFicL8mqGtDZWgn7KAdvaw>
    <xme:ocD0Z9qnkYhpRHvjgqDbLoKoytpetzQf-zEnG9YMxpx3WGTjPoujZQ21cnOn6X6_9
    rJzPfI1LGQGtldSMw>
X-ME-Received: <xmr:ocD0ZwOsKsPffDhM7zc6cqpTzFCw9invgia1r_69NWjObrqY4UfmCo9jMkzYLkniz3SsiPPJfM22SDO2trTU319cHsMq8AWyc6Jlb4cCyq6amWUjyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmh
    hsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepvddtvdehsehugihprdgu
    vgdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ocD0Z25bXeG-ncqCJZIc2Jg1mzLbO_HwPdwRSRlVpMchjZf5Z30p_g>
    <xmx:ocD0Zy6GkL41enaxZirkjk7m5OUH4o48TGO57diwEvVB2DcqM5W5og>
    <xmx:ocD0Z-gRZRPNc3Lo1UKO-vi-I9Lx50msjLEqXPDEx436QZeMH7e2yw>
    <xmx:ocD0Z06hnDStQjSte1w4LBCj-dLlnkbTLQO0tTUIJMQBIcYIO7iBdw>
    <xmx:ocD0Zyd_cz691UTayWdfqomCezYFWJpxOB2plpZHIjBiXITYQPf5BZi2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 02:22:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 90b64e10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Apr 2025 06:22:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Apr 2025 08:22:14 +0200
Subject: [PATCH v2 3/6] builtin/reflog: stop storing per-reflog expiry
 dates globally
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-pks-maintenance-reflog-expire-v2-3-1ad8634798b7@pks.im>
References: <20250408-pks-maintenance-reflog-expire-v2-0-1ad8634798b7@pks.im>
In-Reply-To: <20250408-pks-maintenance-reflog-expire-v2-0-1ad8634798b7@pks.im>
To: git@vger.kernel.org
Cc: Markus Gerstel <2025@uxp.de>, Junio C Hamano <gitster@pobox.com>, 
 Derrick Stolee <stolee@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>
X-Mailer: b4 0.14.2

As described in the preceding commit, the per-reflog expiry dates are
stored in a global pair of variables. Refactor the code so that they are
contained in `struct reflog_expire_options` to make the structure useful
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
2.49.0.682.gc9b6a7b2b0.dirty

