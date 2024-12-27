Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09541F1928
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735296443; cv=none; b=o5rVvM3Xn8da6m+uslQrpqLCle996p3GMS77MN0sreOYjBFA0hleDmXBcezQil9UJSpxf5XgPp09mjOwzvNkAnVkNIR0czm+MJ2W+RhjnTWWZjC1zbuHn+MxWac7sD0hEkPlpNM+QFAFaVdhxsQUK+s6gqOCHUZ2+zsCWOUOQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735296443; c=relaxed/simple;
	bh=+l99LwHFc1MYAwaTp9Zp/LN5Lpan4f2C3lnuf4wpsLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IValCClKrB1GzZRk/XamXFfQONs/OQRPX+1iDPwwbEaAFnShfPoWpZlUZeejvFYRW9bNwJLb833O2fd4WIS/SxUSwPrNUxny6hTxyt4e6jlfMbll3yg3VRr29ZDGjbUzsaajCbY9vq9J+toWeOp2nzYTFLsOLgDBsHe8E/j6dk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vRlHeb2r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cTntg20o; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vRlHeb2r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cTntg20o"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EBA7D11400D9;
	Fri, 27 Dec 2024 05:47:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 27 Dec 2024 05:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735296440;
	 x=1735382840; bh=peLPTGtCri9lUYt7wnA+2OC/t2Ppy6husePTPzRP1qU=; b=
	vRlHeb2r4uDe5TJLuIx/M9H86JzzXxU3jCxrTl0702uBTVkINyv0Sxl66IAeg0gP
	GculsGecV7O73FbIKjoCPOPTeaWhBQMQ8gnwhU4AzRev3ARSLhkM6XOZNXOC/4iO
	P30359/WbnKiYk1sexnIoVkQyCp23myeNsXdmAXw3D4DaJ8rtsgMhgAqn7piq7Qi
	L6BGsL746oUslmlrweBFQldJfdE26akp8VNSxPaF/RO9A/qmwwDacYvc8cAfGUDz
	g8oO0a86EFEX14m/Jvw8qnBbj6RbARFwcTb+6QufvUysKl7MBSxldxi62Mya0pgd
	e2vDwsJmlaDwqcR802uBkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735296440; x=
	1735382840; bh=peLPTGtCri9lUYt7wnA+2OC/t2Ppy6husePTPzRP1qU=; b=c
	Tntg20opYy6HGcAMAMQttpLNpQnvcY5pDl7G5+HLfEsSWwGm6COKurV/3v8bI+15
	UhxQHhFzxBgCCwAlJiq5eKJ5/ONCU7rR1QGwgjR8DunnripeTPp7MTdyKt3fqWW6
	9STHT5dwbSzEtq96tqtSv+xHi8Jb1ADmcPOimX9/CzIhM6d89TXm74seqdQSoKrq
	VNmVjDD2WLOzPZl2t+vazdghyGKJL2an7IhwmVHhjXgOBcNBTRctHKebDTIKgVZ1
	omSU4d2YZCyFJb61Ui1KAQxdVS1TcQbn8VSdy/pFJS7/Cz9wh0uulnkxWPSXR2P+
	dQ1+mU9r2JsZXbrFXAlBg==
X-ME-Sender: <xms:uIVuZ2Z3BRWut9l2SjzfYvI4wy61mR_VxjL5vBSPvmogyiT__Hc0Xg>
    <xme:uIVuZ5aWl6oc4dft9eCroNuT9mBQcYE5rRhO7GoDtP2hZhZ-kDqq0ALCf2pvR_6Tr
    TRV7qjBzj4fbFlRCQ>
X-ME-Received: <xmr:uIVuZw86frFC3ljJxUsiC6gsgrQ6XFqTI4CZ_JiUG9cp8uw7Nt5Eh4c1xbnopDwIUbbQ7iyNKE2jX69-jgtese5tT2VBq969O6caNjm6-M5CvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:uIVuZ4qen8eKgP47YO4JLB5FGQeVe4l6cHWnN6enTkI2tBLNHWCN7A>
    <xmx:uIVuZxpB4nauPZsd2CvnnmQHod0t3PJRZB885P0EC6idlWluxhiB_A>
    <xmx:uIVuZ2SwsfUSdQXu7AfD1mzmlmjKxfvd97zGrSWcDASqxishKRez9g>
    <xmx:uIVuZxqE7wcuxDRYdOK4oAfq5wkxMw0RWT3-Gj4amQcVZdElSYiVLQ>
    <xmx:uIVuZ42XJiU1uiD0L2Hvbhewz40UTPRYIWmW4zTnf5duX_nqnyUby2ss>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 05:47:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0b36e5c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 10:45:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 11:46:26 +0100
Subject: [PATCH 6/9] builtin/log: use `size_t` to track indices
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-commit-reach-sign-compare-v1-6-07c59c2aa632@pks.im>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
In-Reply-To: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Similar as with the preceding commit, adapt "builtin/log.c" so that it
tracks array indices via `size_t` instead of using signed integers. This
fixes a couple of -Wsign-compare warnings and prepares the code for
a similar refactoring of `repo_get_merge_bases_many()` in a subsequent
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/log.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 75e1b34123b348f57334d5592879398064de246e..805b2355d964915732edf5928d54fb6d06e394d4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1746,11 +1746,12 @@ struct base_tree_info {
 
 static struct commit *get_base_commit(const struct format_config *cfg,
 				      struct commit **list,
-				      int total)
+				      size_t total)
 {
 	struct commit *base = NULL;
 	struct commit **rev;
-	int i = 0, rev_nr = 0, auto_select, die_on_failure, ret;
+	int auto_select, die_on_failure, ret;
+	size_t i = 0, rev_nr = 0;
 
 	switch (cfg->auto_base) {
 	case AUTO_BASE_NEVER:
@@ -1885,13 +1886,12 @@ define_commit_slab(commit_base, int);
 static void prepare_bases(struct base_tree_info *bases,
 			  struct commit *base,
 			  struct commit **list,
-			  int total)
+			  size_t total)
 {
 	struct commit *commit;
 	struct rev_info revs;
 	struct diff_options diffopt;
 	struct commit_base commit_base;
-	int i;
 
 	if (!base)
 		return;
@@ -1906,7 +1906,7 @@ static void prepare_bases(struct base_tree_info *bases,
 	repo_init_revisions(the_repository, &revs, NULL);
 	revs.max_parents = 1;
 	revs.topo_order = 1;
-	for (i = 0; i < total; i++) {
+	for (size_t i = 0; i < total; i++) {
 		list[i]->object.flags &= ~UNINTERESTING;
 		add_pending_object(&revs, &list[i]->object, "rev_list");
 		*commit_base_at(&commit_base, list[i]) = 1;
@@ -2007,7 +2007,7 @@ int cmd_format_patch(int argc,
 	struct rev_info rev;
 	char *to_free = NULL;
 	struct setup_revision_opt s_r_opt;
-	int nr = 0, total, i;
+	size_t nr = 0, total, i;
 	int use_stdout = 0;
 	int start_number = -1;
 	int just_numbers = 0;
@@ -2500,11 +2500,14 @@ int cmd_format_patch(int argc,
 
 	if (show_progress)
 		progress = start_delayed_progress(_("Generating patches"), total);
-	while (0 <= --nr) {
+	for (i = 0; i < nr; i++) {
+		size_t idx = nr - i - 1;
 		int shown;
-		display_progress(progress, total - nr);
-		commit = list[nr];
-		rev.nr = total - nr + (start_number - 1);
+
+		display_progress(progress, total - idx);
+		commit = list[idx];
+		rev.nr = total - idx + (start_number - 1);
+
 		/* Make the second and subsequent mails replies to the first */
 		if (cfg.thread) {
 			/* Have we already had a message ID? */

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

