Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905BA1FBEA7
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 21:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262785; cv=none; b=DiQPPZvWh55L2oJbHr802gOEIZEhP6LWGmwv12iXq3AapJwEoeQuljkNM1yjZVUOxBtRkoTUu9XPESZP9d5l0a1m8gYIpUvaQo4K0MRB9OTRLyyD7hB+pjkHkLyykpuzvq6BjxkQ6l9mA8vHcObRTqCkzqRxV7f/cZSOQHHcMLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262785; c=relaxed/simple;
	bh=CUEIWvURSubmvumRn/4Dk/TphslCRo+Q/kDcOlNpgw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OFuyrp/yVW1g44BobPftgy0JnBRPbpcXOrpJFNymt7cxg7AhN02EkrVfUYfvYw4ENRe1Lb34KmvqANB4xSzui/Ah9Fm10sQ8P3enB6AUt+YdGtMI1wIeLypWrOgjajIV1zBon8vVGj1QNqX9y/opwuP+GiG2uAyy+Ek3UQ8q1ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0YRRoQUu; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0YRRoQUu"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-72467c300a6so185637b3a.0
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 13:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262783; x=1733867583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o2G4SSla57aF4GIAeWoBSIxKru0BAHIYgXUN7YmxNNU=;
        b=0YRRoQUu3ScsLdniA4/eBusF0bTOZIhPdBzH7vD7mOVhooLTYsotSun+3EKf/rxJFx
         aQj5SL+dgPh4ggXGXkKn0xA90No+eZijhfvo/oyjsxY8pp/zja14mDHC5L3oGLrJclPQ
         IE2LGJnI7HZbvnSd1n55f2KyRHn8+LknEJAknyFV1rAvT32pV5eVlWQ18oF2IbB9bxpt
         EV9UjmsK377vgzI/h74hunMSf0+fFmV2PrMHK9rpMN3ZvzUtCYqMybDmskfDR3GZnmWb
         7s7hOAkvGiXyH44lEyD25YGeBrpuy1IuPh9Pl1PRzRJ/wl7ZtduYOYoufVRut6qeBQ63
         DPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262783; x=1733867583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2G4SSla57aF4GIAeWoBSIxKru0BAHIYgXUN7YmxNNU=;
        b=ryb6R0RYDAG3+f/u34a26ao9VuBR+TS0DKJa36Sv6EDLma57UzuK/YojnMZhnVdbOV
         0WsTN8KkYeLIFplJ8en6ifMgAf7SKQ2hQATxKPLUVWxr/2zCNFuAkuG4PwU3DbTos0oC
         xdCbJtf42iOIlOVNv1q9op1LKtcOBXLSdym63+pTdE9YkS9XuOFH4mQwq53bXxeAZaib
         wSTGHW7n9SWg3N8zxf8C9ipNG+AZCgqoy8VoO2Gf6nnMBRfxeVqOrPNlzMhYU2y1jWQV
         nXjiSRrJQ6sXSO8FKhUUnC1pL2oLTjlZHS/UEMeo9oneJgqsjC0VVsIXeE7PHVlFHbOa
         WFPA==
X-Gm-Message-State: AOJu0YyaWzu7Ehd510fMU2GjUEEbN0vplSKElNxeKFwfcair0KN8cWxG
	RUjryN60gKzstyTJi+TdOG1tjWFGakKgbez3RX6bf/gzIQBu8RVzGAyuh389MLdPkTWdozUOOL7
	a5J97KoJM/jwVe03hsTfYNu/g0divnR4Yd5PAoK8EXkKZ14kMnUyKyMeEedKOJYT7SbBRDf/NjM
	nCzdIj249E6AkeOXt9vz6tSxeCdeJc0CV8AyaC2v9qM8K0PBrRq7LXJiP5G8inQOMqOQ==
X-Google-Smtp-Source: AGHT+IGXg+FqAS/hzQWA7mckdYFpk3j9kg1Kad2jFUQJnuKMCf378SEUjpFNJc8zF5Tw6lpwuDnxACD8cxR9GBjOD8Tr
X-Received: from pjbsv12.prod.google.com ([2002:a17:90b:538c:b0:2ea:61ba:b8f7])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:80c:b0:2ee:e2f6:8abc with SMTP id 98e67ed59e1d1-2eee2f68f8dmr11132619a91.10.1733262782782;
 Tue, 03 Dec 2024 13:53:02 -0800 (PST)
Date: Tue,  3 Dec 2024 13:52:54 -0800
In-Reply-To: <cover.1733262661.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1733170252.git.jonathantanmy@google.com> <cover.1733262661.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <7ae21c921fe367d4b15cd4a299196009c15205d9.1733262662.git.jonathantanmy@google.com>
Subject: [PATCH v3 1/3] index-pack --promisor: dedup before checking links
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, ps@pks.im, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Commit c08589efdc (index-pack: repack local links into promisor packs,
2024-11-01) fixed a bug with what was believed to be a negligible
decrease in performance [1] [2]. But at $DAYJOB, with at least one repo,
it was found that the decrease in performance was very significant.

Looking at the patch, whenever we parse an object in the packfile to
be indexed, we check the targets of all its outgoing links for its
existence. However, this could be optimized by first collecting all such
targets into an oidset (thus deduplicating them) before checking. Teach
Git to do that.

On a certain fetch from the aforementioned repo, this improved
performance from approximately 7 hours to 24m47.815s. This number will
be further reduced in a subsequent patch.

[1] https://lore.kernel.org/git/CAG1j3zGiNMbri8rZNaF0w+yP+6OdMz0T8+8_Wgd1R_p1HzVasg@mail.gmail.com/
[2] https://lore.kernel.org/git/20241105212849.3759572-1-jonathantanmy@google.com/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 73 +++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 95babdc5ea..d1c777a6af 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -155,11 +155,11 @@ static int input_fd, output_fd;
 static const char *curr_pack;
 
 /*
- * local_links is guarded by read_mutex, and record_local_links is read-only in
- * a thread.
+ * outgoing_links is guarded by read_mutex, and record_outgoing_links is
+ * read-only in a thread.
  */
-static struct oidset local_links = OIDSET_INIT;
-static int record_local_links;
+static struct oidset outgoing_links = OIDSET_INIT;
+static int record_outgoing_links;
 
 static struct thread_local_data *thread_data;
 static int nr_dispatched;
@@ -812,18 +812,12 @@ static int check_collison(struct object_entry *entry)
 	return 0;
 }
 
-static void record_if_local_object(const struct object_id *oid)
+static void record_outgoing_link(const struct object_id *oid)
 {
-	struct object_info info = OBJECT_INFO_INIT;
-	if (oid_object_info_extended(the_repository, oid, &info, 0))
-		/* Missing; assume it is a promisor object */
-		return;
-	if (info.whence == OI_PACKED && info.u.packed.pack->pack_promisor)
-		return;
-	oidset_insert(&local_links, oid);
+	oidset_insert(&outgoing_links, oid);
 }
 
-static void do_record_local_links(struct object *obj)
+static void do_record_outgoing_links(struct object *obj)
 {
 	if (obj->type == OBJ_TREE) {
 		struct tree *tree = (struct tree *)obj;
@@ -837,16 +831,16 @@ static void do_record_local_links(struct object *obj)
 			 */
 			return;
 		while (tree_entry_gently(&desc, &entry))
-			record_if_local_object(&entry.oid);
+			record_outgoing_link(&entry.oid);
 	} else if (obj->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *) obj;
 		struct commit_list *parents = commit->parents;
 
 		for (; parents; parents = parents->next)
-			record_if_local_object(&parents->item->object.oid);
+			record_outgoing_link(&parents->item->object.oid);
 	} else if (obj->type == OBJ_TAG) {
 		struct tag *tag = (struct tag *) obj;
-		record_if_local_object(get_tagged_oid(tag));
+		record_outgoing_link(get_tagged_oid(tag));
 	}
 }
 
@@ -896,7 +890,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 		free(has_data);
 	}
 
-	if (strict || do_fsck_object || record_local_links) {
+	if (strict || do_fsck_object || record_outgoing_links) {
 		read_lock();
 		if (type == OBJ_BLOB) {
 			struct blob *blob = lookup_blob(the_repository, oid);
@@ -928,8 +922,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 				die(_("fsck error in packed object"));
 			if (strict && fsck_walk(obj, NULL, &fsck_options))
 				die(_("Not all child objects of %s are reachable"), oid_to_hex(&obj->oid));
-			if (record_local_links)
-				do_record_local_links(obj);
+			if (record_outgoing_links)
+				do_record_outgoing_links(obj);
 
 			if (obj->type == OBJ_TREE) {
 				struct tree *item = (struct tree *) obj;
@@ -1781,26 +1775,41 @@ static void repack_local_links(void)
 	struct object_id *oid;
 	char *base_name;
 
-	if (!oidset_size(&local_links))
+	if (!oidset_size(&outgoing_links))
 		return;
 
-	base_name = mkpathdup("%s/pack/pack", repo_get_object_directory(the_repository));
+	oidset_iter_init(&outgoing_links, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		struct object_info info = OBJECT_INFO_INIT;
+		if (oid_object_info_extended(the_repository, oid, &info, 0))
+			/* Missing; assume it is a promisor object */
+			continue;
+		if (info.whence == OI_PACKED && info.u.packed.pack->pack_promisor)
+			continue;
 
-	strvec_push(&cmd.args, "pack-objects");
-	strvec_push(&cmd.args, "--exclude-promisor-objects-best-effort");
-	strvec_push(&cmd.args, base_name);
-	cmd.git_cmd = 1;
-	cmd.in = -1;
-	cmd.out = -1;
-	if (start_command(&cmd))
-		die(_("could not start pack-objects to repack local links"));
+		if (!cmd.args.nr) {
+			base_name = mkpathdup(
+				"%s/pack/pack",
+				repo_get_object_directory(the_repository));
+			strvec_push(&cmd.args, "pack-objects");
+			strvec_push(&cmd.args,
+				    "--exclude-promisor-objects-best-effort");
+			strvec_push(&cmd.args, base_name);
+			cmd.git_cmd = 1;
+			cmd.in = -1;
+			cmd.out = -1;
+			if (start_command(&cmd))
+				die(_("could not start pack-objects to repack local links"));
+		}
 
-	oidset_iter_init(&local_links, &iter);
-	while ((oid = oidset_iter_next(&iter))) {
 		if (write_in_full(cmd.in, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
 		    write_in_full(cmd.in, "\n", 1) < 0)
 			die(_("failed to feed local object to pack-objects"));
 	}
+
+	if (!cmd.args.nr)
+		return;
+
 	close(cmd.in);
 
 	out = xfdopen(cmd.out, "r");
@@ -1899,7 +1908,7 @@ int cmd_index_pack(int argc,
 			} else if (skip_to_optional_arg(arg, "--keep", &keep_msg)) {
 				; /* nothing to do */
 			} else if (skip_to_optional_arg(arg, "--promisor", &promisor_msg)) {
-				record_local_links = 1;
+				record_outgoing_links = 1;
 			} else if (starts_with(arg, "--threads=")) {
 				char *end;
 				nr_threads = strtoul(arg+10, &end, 0);
-- 
2.47.0.338.g60cca15819-goog

