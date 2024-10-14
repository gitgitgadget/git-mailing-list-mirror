Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1514A93D
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 03:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728876361; cv=none; b=CyY5nF45h8fnHPIlJuObbnQyTYaHgx/lmp32jAeC+cKjVtNxiRj6O0es2XZoe/9/1471APccX07VPhqfLVsLl5mU1rN6H955GgyKXfrL1dnjxL/gjqHwyWJ/E8spzkvUMYgZiaxtA78PKNu1PeDg5VuY3jHMJSiASoXCic/AdMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728876361; c=relaxed/simple;
	bh=aSE932yeuqBPksfOITqllcN2Bk9TIurCunIr4CxeJF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHCd8rw9VkapeMOCsvTx9K+d7X+dOQvQqvdKYVX0OP8XW8PjNxaibYv1KpxIW0agI55bVzkfWBw1OQtuVs3Ia/vDP4PD4YkR3G3vgVwpMrjj+YnItEzJT5yf243ZDD0HJet4QTyVinwd2LGztzvA+ZYCRv906H6+1MBPKHegeeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=R5yBWh/Z; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R5yBWh/Z"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2e050b1c3so2179014a91.0
        for <git@vger.kernel.org>; Sun, 13 Oct 2024 20:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728876358; x=1729481158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iN3kB7Ny6lIZzYtafZMzbtIjVm0jeuXgTd+2WW+8v5w=;
        b=R5yBWh/ZZbaY8rxATpJ7aI8WAnfDVTkE5m1Ki2OBV2KvW1jMK2Xq+/ykB/3AvNfptw
         KFgEUHJbpck7ODwySLGKUGiDEl+aHMWGk53AD4QgAL8FBZ0FLnUhvByPpWze+dHykr5j
         kUWd3LOklTRQsYVPgdG345Hz4OR2FB5VauMvcwuQEEh3zA4R1DjRzt7VQdpb0dn9wxdr
         2lwr7ewQmV34h8jrD4uzG1SJeLBMyMj7D+YJb7kPsOi6+MLUONqFYYw0ObvQzQmydbVW
         qfzssv18uBNy83usoOqOjCAOyvJYXW6JpBYScnKKY9X8Mlwpt0mkbxmaYLaqpKrpem5a
         akoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728876358; x=1729481158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iN3kB7Ny6lIZzYtafZMzbtIjVm0jeuXgTd+2WW+8v5w=;
        b=CP8XlytEq1f9m8inppoDVv7VD6ozqcLgfEEwVa2vUebwCkl8b8so/Y27xSPJd+EbOk
         iuICLNX5RG4sYfm+fBbIeYVsHIQPclXZTVt2QIVxqG4vFG4tBHxQ661EYw9PoauGlwOo
         5/ZkQc/sGqC9fB/ebweCnRWLFQhiZfzAKhNvP/xYap4ZgODjZJAtkUQQ7KkyZr66SVrz
         PY84f2PkRri8Mhk7QisWkezjeSmy49OkSwFerIo8qjbkcH3wTq5eFOyeA5nkAh+Sd4ZE
         VbPuEw3+yaujOUIYv13o8wCEpWd8fi8fYItZE/LXLsh3EDPgXXrFhKPfd46tbA2CZAnx
         VeOg==
X-Gm-Message-State: AOJu0Yzfjp3J3tqEPEbqkDioIeXCpIaK0Sa3eGqreS2NDsaVaga+oYoP
	3IFWj0Hi1zBRANPq2ajnUYh4OyxaV2IxocRzw2dFoPU1ON1QCtmpNgGR+RigzhBgo0WK0qQUsGX
	6
X-Google-Smtp-Source: AGHT+IEiGRiFX4jKBvql9dggzEmGFZMArj7axDoIfvHVehxEMTiS+A6y035TGojilA3h7EGVroLC8Q==
X-Received: by 2002:a17:90a:de93:b0:2c9:90fa:b9f8 with SMTP id 98e67ed59e1d1-2e2f0ae9f67mr16131454a91.10.1728876358618;
        Sun, 13 Oct 2024 20:25:58 -0700 (PDT)
Received: from localhost.localdomain ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2ea9d4145sm6256480a91.18.2024.10.13.20.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 20:25:57 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	sokcevic@google.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v4 1/3] repack: pack everything into packfile
Date: Mon, 14 Oct 2024 11:25:43 +0800
Message-ID: <20241014032546.68427-2-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241014032546.68427-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20241014032546.68427-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a partial repository, creating a local commit and then fetching
causes the following state to occur:

commit  tree  blob
 C3 ---- T3 -- B3 (fetched from remote, in promisor pack)
 |
 C2 ---- T2 -- B2 (created locally, in non-promisor pack)
 |
 C1 ---- T1 -- B1 (fetched from remote, in promisor pack)

During garbage collection, parents of promisor objects are marked as
UNINTERESTING and are subsequently garbage collected. In this case, C2
would be deleted and attempts to access that commit would result in "bad
object" errors (originally reported here[1]).

For partial repos, repacking is done in two steps. We first repack all the
objects in promisor packfile, then repack all the non-promisor objects.
It turns out C2, T2 and B2 are not repacked in either steps, ended up deleted.
We can avoid this by packing everything into a promisor packfile, if the repo
is partial cloned.

[1] https://lore.kernel.org/git/20240802073143.56731-1-hanyang.tony@bytedance.com/

Helped-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
 builtin/repack.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index d6bb37e84a..071d2171da 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -338,6 +338,23 @@ static int write_oid(const struct object_id *oid,
 	return 0;
 }
 
+static int write_loose_oid(const struct object_id *oid,
+			   const char *path UNUSED,
+			   void *data)
+{
+	struct child_process *cmd = data;
+
+	if (cmd->in == -1) {
+		if (start_command(cmd))
+			die(_("could not start pack-objects to repack promisor objects"));
+	}
+
+	if (write_in_full(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
+	    write_in_full(cmd->in, "\n", 1) < 0)
+		die(_("failed to feed promisor objects to pack-objects"));
+	return 0;
+}
+
 static struct {
 	const char *name;
 	unsigned optional:1;
@@ -387,12 +404,15 @@ static int has_pack_ext(const struct generated_pack_data *data,
 	BUG("unknown pack extension: '%s'", ext);
 }
 
-static void repack_promisor_objects(const struct pack_objects_args *args,
-				    struct string_list *names)
+static int repack_promisor_objects(const struct pack_objects_args *args,
+				    struct string_list *names,
+				    struct string_list *list,
+				    int pack_all)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *out;
 	struct strbuf line = STRBUF_INIT;
+	struct string_list_item *item;
 
 	prepare_pack_objects(&cmd, args, packtmp);
 	cmd.in = -1;
@@ -404,13 +424,19 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	 * {type -> existing pack order} ordering when computing deltas instead
 	 * of a {type -> size} ordering, which may produce better deltas.
 	 */
-	for_each_packed_object(write_oid, &cmd,
-			       FOR_EACH_OBJECT_PROMISOR_ONLY);
+	if (pack_all)
+		for_each_packed_object(write_oid, &cmd, 0);
+	else
+		for_each_string_list_item(item, list) {
+			pack_mark_retained(item);
+		}
+
+	for_each_loose_object(write_loose_oid, &cmd, 0);
 
 	if (cmd.in == -1) {
 		/* No packed objects; cmd was never started */
 		child_process_clear(&cmd);
-		return;
+		return 0;
 	}
 
 	close(cmd.in);
@@ -448,6 +474,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	if (finish_command(&cmd))
 		die(_("could not finish pack-objects to repack promisor objects"));
 	strbuf_release(&line);
+	return 0;
 }
 
 struct pack_geometry {
@@ -1349,9 +1376,13 @@ int cmd_repack(int argc,
 	if (use_delta_islands)
 		strvec_push(&cmd.args, "--delta-islands");
 
-	if (pack_everything & ALL_INTO_ONE) {
-		repack_promisor_objects(&po_args, &names);
+	if (repo_has_promisor_remote(the_repository)) {
+		ret = repack_promisor_objects(&po_args, &names,
+			&existing.non_kept_packs, pack_everything & ALL_INTO_ONE);
+		goto pack_objects_end;
+	}
 
+	if (pack_everything & ALL_INTO_ONE) {
 		if (has_existing_non_kept_packs(&existing) &&
 		    delete_redundant &&
 		    !(pack_everything & PACK_CRUFT)) {
@@ -1471,6 +1502,7 @@ int cmd_repack(int argc,
 		}
 	}
 
+pack_objects_end:
 	if (po_args.filter_options.choice) {
 		if (!filter_to)
 			filter_to = packtmp;
-- 
2.46.0

