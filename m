Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758C218587
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 06:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744093347; cv=none; b=eJY50Gk3RERk1W60rGPU6QinWN8XKsXJT3/tfBWuEW3i28THc0053lMPmn9bIq8GdK717KRWPYdatVlIO4Of7vpwuGCDFFAB7isFtekHalXAsBFguEneIkUOqGEkB3o13e9cNhLhEf81c1lXRD1FWUqd/B7b4JWwEF2XSLFXohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744093347; c=relaxed/simple;
	bh=W/+3ggKvQwNSnU4K0wLTJffUnqHwZ0PdkCMh97ZtGV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WsEOjMirr2xlAJzlE1Gi8csqUHABTUhlS+jzOrRNRCFFuVPMmM4n3KcaBroHVHITFywPmbLU3oGWePzRG5L4rLNA5fhxzaug9CYynEU0exK7odOqOyFlobGNF0sd7BPngOSYB1dC9emVsjSI5lCI17cBDo9E71jwjCA5P8jXGOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IVtzc9hl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bqvff4iu; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IVtzc9hl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bqvff4iu"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9DEC51380120;
	Tue,  8 Apr 2025 02:22:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 08 Apr 2025 02:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744093344;
	 x=1744179744; bh=JVfsu8w39k2i6SQG+iFiCb3UhwOKA7Zs6lGoFlaWnSQ=; b=
	IVtzc9hlpMQAJSflEDQCheKiGTJk5qkTgsz0r/qbsC5OiSNszEMkQ+gUc82AJZgz
	GgFy+nu5xLrrywsoWx3wub8wj+kjQUSwQK487eC79N8yS95koh+4jABpc7+sLzXk
	twCUYwVLuUtaTtoX1b3x7NKOcikpJRJELZuEPM7aRHlw1DP80DVP+jbgTvUQdSNF
	q3EITH72NndU2uY21dS2GdVCJDmbx+qmUZjiRvmfxyF+xE8dcyhZmu7zhA9rNhdD
	0ZMSobABFo+jHEStPn3qEZxTOSWTrDYO/MqkbFAHppScaWyb8lOVlsdAas9jMdb3
	ERpaTBV1jbBTUgb7pyXkiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744093344; x=
	1744179744; bh=JVfsu8w39k2i6SQG+iFiCb3UhwOKA7Zs6lGoFlaWnSQ=; b=b
	qvff4iuS/ZyzAhF9jEIRy+4lHixDrU9EBSU8ROCUpD1tSmTXtyEFvfpWiryZKe30
	FphwjRz/XW0yfUHZy3VZf/+hjyAZY+rg0B++GarjNCQoAkxqOpSOu38Yx2b9ki4C
	kwKmuZwQ/xEpmPxytrYoyZpX/kUBt0b2icIpMmsk13LD7qZRgATp4joqzPjt4MT9
	b6Mlh1YHGXP1Y5WEvgO22Z6o43vzvFTek83/qCx639v0EKgjrWG35p1f6UgkDjca
	VCoMEQ7fUZ0RGXDMC18/tnh/iJHzpn/zvVqTMEmDupZfDSQngiv8aW2ivZ8zs6Cz
	t/7eamWigYZn3fYVCug+Q==
X-ME-Sender: <xms:oMD0Z3ZYcEFHmMfp1ZkNiafENQRzuOfMwDO1T4-XlWjEp3bvXhIgqA>
    <xme:oMD0Z2bKDfWcKmCAFXK7DH2mAUqDrjGfJrB5jDLlsDV_YazqokI5aXYcOi2hdzygz
    poJcFv4CMCFsCR95Q>
X-ME-Received: <xmr:oMD0Z58pH7zGMObuaf8kr3cJSsMuKhlI7kbPjkl4jRMrHKh9jDvGXoT6pZgIHxRgXI8jh1XIlIiOr9ypddo8ot-75tlTtEVMsCVWdy1PxkvjLCxd_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopedvtddvheesuhigphdruggvpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgr
    mhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:oMD0Z9r-IJ7CpgUTU4Bq6IPuxu6wca_kBvm7tCp9taeHVJ00DWJZiQ>
    <xmx:oMD0ZyojQDJW5neFwYFgu5ii7Y2w3r0lYfyVl2il55vCtE7YaZmzDw>
    <xmx:oMD0ZzRRhVwzZdoYwnaZdIW40PzMf03Br8mZY99--Sqn5NX6rPdFBg>
    <xmx:oMD0Z6rcRZKZAhBD6C0kWSXX2COMOAW45gx4Drpf5YvY67drY01TGw>
    <xmx:oMD0Z0WNI91G5lyn_R8aKunvyuihd--l7R0Pcjzcylxav-aNCPVMIp3T>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 02:22:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3dd1a5eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Apr 2025 06:22:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Apr 2025 08:22:13 +0200
Subject: [PATCH v2 2/6] builtin/reflog: stop storing default reflog expiry
 dates globally
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-pks-maintenance-reflog-expire-v2-2-1ad8634798b7@pks.im>
References: <20250408-pks-maintenance-reflog-expire-v2-0-1ad8634798b7@pks.im>
In-Reply-To: <20250408-pks-maintenance-reflog-expire-v2-0-1ad8634798b7@pks.im>
To: git@vger.kernel.org
Cc: Markus Gerstel <2025@uxp.de>, Junio C Hamano <gitster@pobox.com>, 
 Derrick Stolee <stolee@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>
X-Mailer: b4 0.14.2

When expiring reflog entries, it is possible to configure expiry dates
that depend on the name of the reflog. This requires us to store a
couple of different expiry dates:

  - The default expiry date for reflog entries that aren't otherwise
    specified.

  - The per-reflog expiry date.

  - The currently active set of expiry dates for a given reference.

While the last item is stored in `struct reflog_expire_options`, the
other items aren't, which makes it hard to reuse the structure in other
places.

Refactor the code so that the default expiry date is stored as part of
the structure. The per-reflog expiry dates will be adapted accordingly
in the subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/reflog.c | 22 +++++++---------------
 reflog.h         |  6 ++++++
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index dee49881d32..0910a4e25dc 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -63,9 +63,6 @@ static const char *const reflog_usage[] = {
 	NULL
 };
 
-static timestamp_t default_reflog_expire;
-static timestamp_t default_reflog_expire_unreachable;
-
 struct worktree_reflogs {
 	struct worktree *worktree;
 	struct string_list reflogs;
@@ -122,6 +119,7 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
 static int reflog_expire_config(const char *var, const char *value,
 				const struct config_context *ctx, void *cb)
 {
+	struct reflog_expire_options *opts = cb;
 	const char *pattern, *key;
 	size_t pattern_len;
 	timestamp_t expire;
@@ -145,10 +143,10 @@ static int reflog_expire_config(const char *var, const char *value,
 	if (!pattern) {
 		switch (slot) {
 		case EXPIRE_TOTAL:
-			default_reflog_expire = expire;
+			opts->default_expire_total = expire;
 			break;
 		case EXPIRE_UNREACH:
-			default_reflog_expire_unreachable = expire;
+			opts->default_expire_unreachable = expire;
 			break;
 		}
 		return 0;
@@ -198,9 +196,9 @@ static void set_reflog_expiry_param(struct reflog_expire_options *cb, const char
 
 	/* Nothing matched -- use the default value */
 	if (!(cb->explicit_expiry & EXPIRE_TOTAL))
-		cb->expire_total = default_reflog_expire;
+		cb->expire_total = cb->default_expire_total;
 	if (!(cb->explicit_expiry & EXPIRE_UNREACH))
-		cb->expire_unreachable = default_reflog_expire_unreachable;
+		cb->expire_unreachable = cb->default_expire_unreachable;
 }
 
 static int expire_unreachable_callback(const struct option *opt,
@@ -276,8 +274,8 @@ static int cmd_reflog_list(int argc, const char **argv, const char *prefix,
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 			     struct repository *repo UNUSED)
 {
-	struct reflog_expire_options opts = { 0 };
 	timestamp_t now = time(NULL);
+	struct reflog_expire_options opts = REFLOG_EXPIRE_OPTIONS_INIT(now);
 	int i, status, do_all, single_worktree = 0;
 	unsigned int flags = 0;
 	int verbose = 0;
@@ -308,17 +306,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 
-	default_reflog_expire_unreachable = now - 30 * 24 * 3600;
-	default_reflog_expire = now - 90 * 24 * 3600;
-	git_config(reflog_expire_config, NULL);
+	git_config(reflog_expire_config, &opts);
 
 	save_commit_buffer = 0;
 	do_all = status = 0;
 
-	opts.explicit_expiry = 0;
-	opts.expire_total = default_reflog_expire;
-	opts.expire_unreachable = default_reflog_expire_unreachable;
-
 	argc = parse_options(argc, argv, prefix, options, reflog_expire_usage, 0);
 
 	if (verbose)
diff --git a/reflog.h b/reflog.h
index eb948119e53..a9d464bbf8c 100644
--- a/reflog.h
+++ b/reflog.h
@@ -5,10 +5,16 @@
 struct reflog_expire_options {
 	int stalefix;
 	int explicit_expiry;
+	timestamp_t default_expire_total;
 	timestamp_t expire_total;
+	timestamp_t default_expire_unreachable;
 	timestamp_t expire_unreachable;
 	int recno;
 };
+#define REFLOG_EXPIRE_OPTIONS_INIT(now) { \
+	.default_expire_total = now - 30 * 24 * 3600, \
+	.default_expire_unreachable = now - 90 * 24 * 3600, \
+}
 
 struct expire_reflog_policy_cb {
 	enum {

-- 
2.49.0.682.gc9b6a7b2b0.dirty

