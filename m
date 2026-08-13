Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468B35BDA8
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651747; cv=none; b=mwoYO5SmO9r1eKSX2zAmwZFwEez5Vfr5OMZo0q3dreToNXDncXYM+lslQIMCRlO2Rjd3xMj1NXMhvs6slEbu2rR0QO1DltH08vdIA0dPzOqaiqdZ4md7Yya1zIQE360/PWc3QjxrFSp06CZ2ZzeGI4sAdIug9SFFGByRjYnTI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651747; c=relaxed/simple;
	bh=Ms0twJvquyH23nC7aB9sBArFCJCAgkBlhrC2AMC7FQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5zt7zFViM5oRUgGXIabqP6FvXxCjHzFgXcOvpGn7YPU9OfhMsT4foT8IlCt+IRs4RqHgfDucaNBlUomqYLl7yzhw4Q+Nc3xKY0tIKwxgUtM1X3SNiyOOdrKxyIqhjDgiGhcnfZlhWRKt8EFrbd/26sVrh/zqL9DsqXKcmi3bXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiuL/7n/; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiuL/7n/"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca88130e09aso131965a12.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 13:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786651745; x=1787256545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BGLGjf9fykPYmlkPFkB8D7KuvSH+vZDNfX1WaVgv+MU=;
        b=iiuL/7n/hm3oRrSwo1NlizQvZwjTh2IwZda2+DhM8aLvidXeRfDj1KKdSZ+diaH+V0
         1LI2Ns4IP6z/JQkfnCzAb+I+l0C0gkgiNuh66oLXLUAMM8Oe84pZ4QLbebFw68+p4Dcc
         nez5lgql/TuO6BKe6Bb1MfEWffSTKLAX7Phs9QEIKLA6uimFW9CHxhLCci/llSnjQ6qC
         LrtNP4InIF3l3uUC7fbylZ/ai1UcY6ixHkGyvHSKla4c0T7vIfli1v1gTiRNH4bSJi03
         o662bCNoY4W4evGhmUGfxawU0W3nAjmiVMXOL+r9umPnJ7DYoMv1sjoASPURqQ8anX2m
         wJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786651745; x=1787256545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BGLGjf9fykPYmlkPFkB8D7KuvSH+vZDNfX1WaVgv+MU=;
        b=Ac/04dGg/M45OUFck9vHpAtpnQ1Z1uD5bPfWzuLSX9p6gUOwOnszeLG9R1l6bSN8Ag
         hMLEYErDkTxmoNRK5fMgGbgXAWzxfURrL3A4HgnUen7BjJxvoTzHCw2mw+DzLTdPq2kU
         ct1rVzozK4F4A+EdxYtfjEWFNxzMoF08aiLokZPjl3gBmZxrOKAzyFighS+OLN4z4/oL
         kzyeDxsHCx7MtFkljxWW49+zQZzcZlVdjy5VheNwywuCe3DTI6Zsqv/Lai46D4oFPOQ6
         GquvcYDrUON39jj1USoTeGkUSJACYjx2jrmwK3W0ejmeLslzyYt5ruj66qGtbV7xoxFd
         50Hg==
X-Gm-Message-State: AOJu0YzZdC0v5QdNT9cYPztUVa2L5+NK3Usvi2kilpjDYYw1/JJUNIlQ
	E9RxTwAvWHay99nCBdWxRxFAZEjwmQKs8reDnjQ6MNJBfH3sPW9MoVpPFKDTehXY
X-Gm-Gg: AR+sD10rf9TCBfDQ+8Yu18Qo2ruN7Ea0mNwJqr8kd2Qgi1b3D0arvITeGNui9XVCaIe
	bC+PD1QhvK/OKzja1tX8/rbtVr7Uji7d7K2OfdbtKgvo4KCT73ZbZ402S6AUlaBsj+rG8z6WAJZ
	xIEvNdT2OqlmulMFr2Mfoyv84mv2JaQPeY3Op1sFCCQV5rShJrJ8l2EGl2zmAwlYK6tv2o8R1Yu
	h6NOABbYBqHZBrlufUZ7TBb9/0ZMtpTuPa5ivPsfw0dtJSc7XpaxyK5bzd5Iw4Hq5MvHCjtORiZ
	DbgEXmgI9AfHHGkHuFc2vsbPL5BZ9OVjAPew4/Z96kpxK+2K3ZarAcylWFo77XAFv+LlyG6mvd8
	Usbd0jOBmCHeCngXJB46Ws3DyBirhX+mR2/A9HmwrDMOtYGlo3e0X/JJ+mUJTQrzup9yh+BLiNB
	M+Divz6rCXY5POPnXwrKqtrVbZ6rHFEHtEpBsmlUTPAQx338rU/PWZWTTpAw04vhog1yb6VqZ3q
	XA3j23R1wu+3KPAd39fsMjA/wi3EmaTRiiTVImLTyM6RHpcHriBeNMDi9bY5GbkwsELyAwPEGWT
	tQMUnj+cgRUNKUUlJ2XvpQ==
X-Received: by 2002:a05:6a21:3391:b0:3bf:a638:4376 with SMTP id adf61e73a8af0-3cc71ccc432mr273269637.21.1786651745309;
        Thu, 13 Aug 2026 13:09:05 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:ad47:4055:841d:89ad:96b0:2f73])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387c6f95sm1533440c88.6.2026.08.13.13.09.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 13:09:04 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	ttaylorr@openai.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v5 3/6] repack-promisor: allow excluding objects from the rebuilt promisor pack
Date: Fri, 14 Aug 2026 01:38:27 +0530
Message-ID: <20260813200830.84348-4-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813200830.84348-1-r.siddharth.shrimali@gmail.com>
References: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
 <20260813200830.84348-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a to_drop oidset parameter to repack_promisor_objects(). When it is
non-NULL, write_oid() omits those objects from the rebuilt promisor
pack. This is the mechanism --drop-filtered will use to remove promisor
blobs, i.e. rebuild the promisor pack without them.

All existing callers pass NULL, so behavior is unchanged.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 builtin/repack.c  |  2 +-
 repack-promisor.c | 15 ++++++++++++++-
 repack.h          |  4 +++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index ed79c04e13..2ad6358535 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -430,7 +430,7 @@ int cmd_repack(int argc,
 		strvec_push(&cmd.args, "--delta-islands");
 
 	if (pack_everything & ALL_INTO_ONE) {
-		repack_promisor_objects(repo, &po_args, &names, packtmp);
+		repack_promisor_objects(repo, &po_args, &names, packtmp, NULL);
 
 		if (existing_packs_has_non_kept(&existing) &&
 		    delete_redundant &&
diff --git a/repack-promisor.c b/repack-promisor.c
index 90318ce150..fabfdc168a 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -6,10 +6,12 @@
 #include "path.h"
 #include "repository.h"
 #include "run-command.h"
+#include "oidset.h"
 
 struct write_oid_context {
 	struct child_process *cmd;
 	const struct git_hash_algo *algop;
+	const struct oidset *to_drop;
 };
 
 /*
@@ -23,6 +25,15 @@ static int write_oid(const struct object_id *oid,
 	struct write_oid_context *ctx = data;
 	struct child_process *cmd = ctx->cmd;
 
+	/*
+	 * Objects in to_drop are being removed from the repository, so
+	 * omit them from the rebuilt promisor pack. Each such object is a
+	 * promisor object and therefore remains recoverable from the
+	 * promisor remote.
+	 */
+	if (ctx->to_drop && oidset_contains(ctx->to_drop, oid))
+		return 0;
+
 	if (cmd->in == -1) {
 		if (start_command(cmd))
 			die(_("could not start pack-objects to repack promisor objects"));
@@ -81,7 +92,8 @@ static void finish_repacking_promisor_objects(struct repository *repo,
 
 void repack_promisor_objects(struct repository *repo,
 			     const struct pack_objects_args *args,
-			     struct string_list *names, const char *packtmp)
+			     struct string_list *names, const char *packtmp,
+			     const struct oidset *to_drop)
 {
 	struct write_oid_context ctx;
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -98,6 +110,7 @@ void repack_promisor_objects(struct repository *repo,
 	 */
 	ctx.cmd = &cmd;
 	ctx.algop = repo->hash_algo;
+	ctx.to_drop = to_drop;
 	odb_for_each_object(repo->objects, NULL, write_oid, &ctx,
 			    ODB_FOR_EACH_OBJECT_PROMISOR_ONLY);
 
diff --git a/repack.h b/repack.h
index f9fbc895f0..a5a3f7c6ba 100644
--- a/repack.h
+++ b/repack.h
@@ -3,6 +3,7 @@
 
 #include "list-objects-filter-options.h"
 #include "string-list.h"
+#include "oidset.h"
 
 struct pack_objects_args {
 	char *window;
@@ -100,7 +101,8 @@ void generated_pack_install(struct generated_pack *pack, const char *name,
 
 void repack_promisor_objects(struct repository *repo,
 			     const struct pack_objects_args *args,
-			     struct string_list *names, const char *packtmp);
+			     struct string_list *names, const char *packtmp,
+			     const struct oidset *to_drop);
 
 struct pack_geometry {
 	struct packed_git **pack;
-- 
2.54.0

