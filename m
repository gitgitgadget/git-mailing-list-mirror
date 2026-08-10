Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C52B424D65
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383684; cv=none; b=N3RanUInrr2OjPmnJx3mzUqn++StxUxWMyP0bQxboPdug4SZAWeEVfMpWZxRS1yqqoTmjQx7MId3wa+RXDJpFQ5kYcqZlqbX91CaIsdagjXx0ruabdVJRuxfcPkxyWRJR5URbFx6+wzw99XT22Ug3geIVgc5nlQVv/mA5vIpMyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383684; c=relaxed/simple;
	bh=reRGVp/P00VSTGJXnpSDQsrvfXLUv0GSLJJcgifTGXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uR/luylQQ8hdduBreuu96bIGBs/1gywJ2QDZioPqnh7xBWuv7xlpU9vuL4pXqZCryGMwLfKt6YEN0VrJDbvEZ6Oo26GK3jlayxdgYY56HkdPQxp+Lvv0uf49QGh5KeK1PvhRgLvcNVG3uyJJYd8kw4vptcNFn4xeyMha/snVeP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgT0hVzg; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgT0hVzg"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca7c1176317so1691676a12.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 10:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786383683; x=1786988483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fsEVIughs3+oPPfcsIzfu0AvjIj/0PV/Icjfm8okZM4=;
        b=HgT0hVzguFkpyNetn+gEa8zR5RcwE/XsYYqrX29wKbGGEGfiM3Gn5L/gkd5mvEQk8J
         E36QlvW7226BYaq0dKTx9QfFXxOq7exaZDm6TNcb/k/NUPDJcitrgSck5Mm6OXlAH3ze
         E2y1ArwQDopWDhxR/DK+E5ld25pgUJjfaXQj/ElEk7Wf2Zay1RELDLYD308teO8xPTez
         kME4vVrx93986u97/L3vbLz37Z3lb9daEgiLm7fLuAm6RcqqTg0Yavbc3fZ0zVExdAiu
         4m/r/dS/Ma2czzDmJPkFztUsSmFJdNCmzOn9s0K6Nvm1in2JHA5cPSltXjFWYVHkIFGa
         qmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786383683; x=1786988483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fsEVIughs3+oPPfcsIzfu0AvjIj/0PV/Icjfm8okZM4=;
        b=DHFq44Om91oU3/rO6k7b5n1vkI/Y827tysTwrhkPgUhZuxQ8WoodLLTizyz+fsGF/k
         fl+H/uC9ghn/dJpeNX7rCyOXXbQAFcWH8hOeRuHC5uxNWgXPJrIsJLfmJnjlCiGOluKP
         4I8e2cIs9AX5iabxcO9G1ubwGERRaCYujKQdB/QsqmaF7E9n45Lcwkm35QW0/ydC/Csu
         F0ytf8p4keQwVXj9BpMhLdkF34zuI+nnkjTqajrjUM7NppprWoAfPfuL/fgynVDL3KTq
         NoZkNKUOWKE0cols/+UNQ+ulirJJ2Gh+6r9YbZJ/IrpaJVNVchsA8m0KdCU/x7TPzuUE
         JP8Q==
X-Gm-Message-State: AOJu0YzalYVu9IJX0iX7GJfdnWT5CJ31vAWkFvOCdNE79wyfhn+nxFtd
	II9ObRH5fF82HwzvWbB7cVNuOApFIQv9eRjmjPABiWxxS5Pn22+ktMTkLV+v0Q==
X-Gm-Gg: AR+sD11cfSKXY+SDK8F2ZuEkRBDZgAsVMZ/Ec5anRopMR0CZ35nc4gVPLUx0chFfV/n
	H7r1+W5InRqu6JX25bvjKsvuRqdWBPlH+C9G5KhF0mZv3EOuPj/4+HN4Dtu6m9SkDG6c6W3vH5P
	fV+UvOkQ1H5mJA5p6BCs3piPsYn9zVbJVVKtLgwFR4hl4XJSpaU4LNA5q4LtjmzkdCC29Gu6CEy
	wYktQry96VtCu4CP4RYS/dFR/cS+bOciol+HgWD64kIdQIGC4DG1dpn51auscyUAft4TnIw+FXM
	vnpkyu1UodC0iQ2x9yaWuqWYKuuqAQtoZvDgrDsquD2yvTPNq+9WW8NaU2HmwaNv4eqn/gF2RTg
	gJzSnB77nPeFGg1l6XanQyE4xy4J22JP0i8AKWi98VLgseJmM6HzD/d5XlZk6gK0nOZcxWpqtF3
	bSY1GmBBcYRkP7D412qkcp3DUS2CDZWxh8hbAzsZBP8u0WUud0vPQORDYDcI0A5RhsSz69uayMj
	7REBCZQn11oUtoZRutxqaqbbtYyx9oGUKRPA8bGAWEzYcfBNbmoaXiJqEdVSEj82PHcaOyD+OUE
	Myjjz+eLwMSNGtzWtybCgQ==
X-Received: by 2002:a05:6a20:2d13:b0:3cb:7b9d:9869 with SMTP id adf61e73a8af0-3cbce9de817mr25009103637.35.1786383682579;
        Mon, 10 Aug 2026 10:41:22 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5026:8db8:20aa:c615:9a47:206a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101b7b39bsm36865585c88.14.2026.08.10.10.41.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Aug 2026 10:41:21 -0700 (PDT)
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
Subject: [GSoC PATCH v4 3/7] repack-promisor: allow excluding objects from the rebuilt promisor pack
Date: Mon, 10 Aug 2026 23:10:43 +0530
Message-ID: <20260810174047.6524-4-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
References: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
 <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
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
index 19b26ca723..e1c283e255 100644
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

