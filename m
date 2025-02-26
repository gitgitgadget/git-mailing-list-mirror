Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E4321D3FC
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583482; cv=none; b=qgIIif+ED8eqyLZaC4NxgFiQJfLIV6DnMUfg8zik7dPafQ2HH3rV+MXptjDEA1xW6jlpJJZu4nmPJ2rR0H7M3fpnYos19QKbyYlwlMW+54rY5F9JLVRIbosjWR8VjojjEtp9ZpbLAhGunezotZyG/YhX07DVM/nyLGWAQqEqH9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583482; c=relaxed/simple;
	bh=WJNbDQyFBEH9X7ySrswwCTZ7Mf1Hx2ltmKihQY4hKXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u6ZPpIsoigAXlED0mPijo86IuRBYdKHRV2dW6ohuLVI1QgmILmlkt7KTN99YCDcW63UcryJKR+rmHKNUpOBUgfA8cdRfJBn+Dztb2ClPd7gODq1iFlYiE0xzxH4H/n4MuC05LDWzMEg3vBA8RQgggKd3nX2fwZ9vczZFwYZqOqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SiPNXxwn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ScXiqTAp; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SiPNXxwn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ScXiqTAp"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 9956711401C0;
	Wed, 26 Feb 2025 10:24:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 26 Feb 2025 10:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740583479;
	 x=1740669879; bh=uQ3DzmeqhRBGJZ1u8rcfNYL7DJq2TNIP2BvyiJModh4=; b=
	SiPNXxwn9oT6p7JUXvDXINNnH5E2P7UbA7Cc1W7vPEiDDAXbcWiLXt07rF+TIMDq
	jPaYES2sk1tJqN1X2KZZaCKbyPhde9ZA9FyyBrVyojHdVxUgfp9bf6/MWmMeu8dh
	89uMT+nR1Pgzlxc3IlxEeUIKMGzd45EVA13K38rNJhqC75f8QwbG336iw4ThlU0x
	jvM+42DWub5/fKaw5fy9jsZpBTBrAW5HgzwLTlr9yja1lC+QhiGMOpu7BulEt1dr
	nO5rTkxmd68V8CBh5Uklgw0y1hIqf8FbJaDyOhp/lAjSGaL2kL6Oc7R07aUjtnhY
	VI7sibL2oHQ4pliFRyAWEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740583479; x=
	1740669879; bh=uQ3DzmeqhRBGJZ1u8rcfNYL7DJq2TNIP2BvyiJModh4=; b=S
	cXiqTApj5MiDlOypZQeEjqYG7AvKF1/qzKAGOrkHZ68b64FwX/HPh6Wj2n4V4jtB
	e1Qi4+wZlOKL1aNjwvk5XTfzi5NwIZhHTR9QEkrudRo7s0T0ERs/8gr0wndzjmqR
	0z2bZJHNWumsZkNlponBrgrr7reXhM+ClHpnUomFBJgHCXjrO/Jps5AgtTYKuN+V
	+wS24I7NwFM4WSW8u/22QkPCqpMZfebWi2HCfUMzPS0QTOBLyryZKWVSG66QBtw6
	5v3xLb9o7Z32Tk9Ci8syQoy7z8afATQAtBS5KhtJAQQOh4YbuKU0i+paZAlphoEY
	X7ylbrqbTM1WUpVAvg7pg==
X-ME-Sender: <xms:NzK_Zw9CbvjP-Ew4ArZY1-kTAaN3it2E7yphIFArPfrYUGy26Lx15Q>
    <xme:NzK_Z4u2FQZfQFj1Qmfkc0kB5lvYR6jsSLtFOPdpQDoreuc152fmAXw_XaIcf18fQ
    UhTz2h2pKhNh_QXiw>
X-ME-Received: <xmr:NzK_Z2Dzw-KVdqMXQdQOP8pmzD0yv2VCUPXM0jBFWvt6wxu_Kn7yqo3OBHKxiWUsQLXedXQqcOKT_9tEOkv2rIB81FMhlIdya6cQOBp-1eUn0nHS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvddtvdehsehugihprdguvgdprhgtphhtthhope
    hsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NzK_ZwdMentua_JnPDjiFcYnyrdf0MIcl1yuZtDjk4x62kb_ee9MSw>
    <xmx:NzK_Z1NtGNgsHKuf1k4Z7quSxW1e4Y9c2-l2p7yi-HqJ3O9dKHpMiw>
    <xmx:NzK_Z6m6CTiFKIPd4ZOmLd2iQRWXke9Thk2g9jOO7vPhGlne38Ijgw>
    <xmx:NzK_Z3vhQa5VD3Nyo4pG-_TuHc9GfmjXV73NkBKUEkrauhSr3Sm01Q>
    <xmx:NzK_Z6oEQrLOUuTOvJuK5-xgDYED7NZpANHFnLhF3zpopbKmLdeX27eY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 10:24:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 72658fe8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 15:24:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 26 Feb 2025 16:24:27 +0100
Subject: [PATCH 2/6] builtin/reflog: stop storing default reflog expiry
 dates globally
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-pks-maintenance-reflog-expire-v1-2-a1204a814952@pks.im>
References: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
In-Reply-To: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
To: git@vger.kernel.org
Cc: Markus Gerstel <2025@uxp.de>, Junio C Hamano <gitster@pobox.com>, 
 Derrick Stolee <stolee@gmail.com>
X-Mailer: b4 0.14.2

When expiring reflog entries, it is possible to configure expiry dates
that depend on the name of the reflog. This requires us to store a
couple of different expiry dates:

  - The default expiry date for reflog entries that aren't otherwise
    specified.

  - The per-reflog expiry date.

  - The currently active set of expiry dates for a given reference.

While the last item is stored in `struct reflog_expiry_options`, the
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
2.48.1.741.g8a9f3a5cdc.dirty

