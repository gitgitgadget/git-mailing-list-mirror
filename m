Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA3738AC80
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433361; cv=none; b=iFnYPDJApkx5GQdO5wwXW+kyO5hLxjwbvzTDUhIfRMGXI2ZaAQMTP6go9VrSqi1gSK/1YpwzteOle8k+IP92mKxQhFS63MlgWw0eyEESF/yZfx3NzRPjHL3o2Pz+/DUYfsnyhVueS7KbDkIzUNKIjgoJjlFyMuXOwrOx1NLaf4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433361; c=relaxed/simple;
	bh=Ou1YfVJ9PnBnAbXKL4861G5cAPYoa+15U8qrsOp2FSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRI5a4wrvosgeSsyiyY76GDJTPaMCep0HTZmU6vSbCinTOADD30Pi1QFMdpgyFfcW+9majiFnNfxdmY+2fKej6JOySbPGfWbvfyZfJXfMrw7PpQBfDhzVJ9oQ/17qoc/C2OneUEkFiZdHpWGL1IKlnA1YKnA2JY78wnaTz4VrNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/Nmwhv5; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/Nmwhv5"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca957432c7fso46133a12.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785433358; x=1786038158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D8CohtX5w2RTn4tJCzC7UQnzpGVceX3jigBu9h98ztM=;
        b=M/Nmwhv5/83RwHxHdZNnI8W4kqcN1r7whEu9GHXgYg4A6gf+dq66t3eMce9JdfP69z
         o5oicEwIQl6DWTtrH20wOrkEYVC//cx15OcEHLfuep+NFw4yynq3iUDSju/sxv0XB8Ax
         Mckhu7luuqENMBvQ3skT/clRTMsV42rw/ScCA4xpAzd3FRV+PEK2aNNvKgyZ87+6XhdB
         Z9Wly6zNX1+DFOQTBlRtVagWmHus1TjwNXbYYEkOZ2nB1WKAxbPE4yP34xl6PMpRUIiq
         8IE/G1neCB5FEHQNE/dnP/B5ueCc5I8bzGqoF8NmmlU9G18UDDCXVLDHhMwI/chNzvUT
         0/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433358; x=1786038158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D8CohtX5w2RTn4tJCzC7UQnzpGVceX3jigBu9h98ztM=;
        b=WfcFzeNwDl2YBAIe2y3iNbPGYKPqHjQ9rGIb9K0rK3mLoU0RHMfqlV2y5YtAX8ZdFr
         nxTdMr7WpifPp7/sM91i+x9ELFHAjVpt7MAfy47cP8QFKw7EGyWx8FbpQFVH2WuwEIrb
         3cfNX/CeNLTwS9hOfTK5+jzGw9USq4dJZTJCg7IzAJKBwm350iQ9s4lUWY/Ds/6+m+B/
         2JF/vHbUtHSR3llzzlR8i87Q1v9k7I/rxI/OvwSGnTLf84C53owyhBKCpRSzmiyoVy8Q
         Zc9KbADT39FHYWu6vJl2P86abijX3dCJwzJmO3nhUyTlB+PNYkE1QtpmXH9lsZseSxk4
         dyjg==
X-Gm-Message-State: AOJu0Yy3WBqb7ISMQC6H7j0OHYKopW37kn20TR+78BiN9XtZHKmWXR/0
	9KEDMOdQH6neaeuXaMyJsE3lsuP/xTaZr0ViE/OQOqhxxYRjhQuO/zMRgsBxFQ==
X-Gm-Gg: AR+sD10K8/UFCvf/uQr0suJFjMZ217hGvKuu3J+MgUVReKX/Hp6epqYrWdSugqNoLHE
	AAcAu6KfzOESbqZVBBsJj+y/DZhXgv7KKOgK4FS4P5HUhbdwMNJU4Lz+8Cu7S0CQwBYVIRRiBDX
	HPOy8sizNr8ddxlwPZ3wiEMs0i2rh/YKs/s9Zry9iDE/Mew5G5xk72Oy0PRQUMnNPu+wwZXLJvQ
	1+0FOOjMJn2wg3lZVyFZiGUf3Bbx4AlaosrX6Y4FMFxhVHO55H8b8hnQbw05NGYrYWNLxSfDphq
	WGwjnaRHFxFMa34Qaa6Y5eeVSO4cCKfhr7MKQFzUs9V6k1pXymu5vRGcoNNyBmBbJ3kMpME7JSo
	FprSX2GD2IQE9WDWjlNTLD2JP86CQYxv1VjBRoNe296AmTTYlEXBjr4jCDQSNHqN++cXW+kj6/Y
	cajVcV0HtnHlcItnlJoAVaK0+wIXVQuwRO+/IlnTOxF2nOoYh1/MYApWkNrA2T6edCMmwBywDew
	ebyiP/s13E2cjTg4Qz2AzEHIzlhG1H+13cGrZmYhpbWxUPKcR/Q7JEZAvjv+QwPfWH6cjJfs8gg
	E7klbEegLZDQYzGhagxH1pKOAllMcBPzpbeX4g==
X-Received: by 2002:a05:6a20:6a0c:b0:3c3:8bab:804 with SMTP id adf61e73a8af0-3c9008c41a8mr3596007637.49.1785433357619;
        Thu, 30 Jul 2026 10:42:37 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5622:d88b:20c4:5444:d41a:b6c2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc9dffsm25163964eec.14.2026.07.30.10.42.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 10:42:37 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v2 3/7] repack-promisor: allow excluding objects from the rebuilt promisor pack
Date: Thu, 30 Jul 2026 23:11:49 +0530
Message-ID: <20260730174153.9949-4-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
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
index 322b01cb3e..f25d189b07 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -425,7 +425,7 @@ int cmd_repack(int argc,
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

