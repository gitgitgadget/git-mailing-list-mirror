Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B1C208981
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262192; cv=none; b=RGIOAAQx1hifdGtI481ZYDiip4QRYq8JZGCtmvdnA54JY1Hm404gb8nR7WVATvA0B6b+z3Jo1+Z67or7x4A9SIfBzAIA+RMHrm98C4pmlMtfkZNayGgTCk1ET7LQMKSxj0A7FQEkCvesADEK131T7cwsPVylaVUSUp6zdZTfdSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262192; c=relaxed/simple;
	bh=CUEIWvURSubmvumRn/4Dk/TphslCRo+Q/kDcOlNpgw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X4lK0W5zFaAVLmhxRVYL8DLGJiXBe9x8/OAJ3MGwyHpfWc6BncmeEm5s8+HdFJUTHkF2bO4R1NRltzKB0ml6lXNg9htX95aGKDIhlJZhFPeKObnisdKiCmB3fn14g/zCJjtNXIcK8Ra8MLGj4rfvpY6bB1LsxwjM3eSL7swKdko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AAuaRoRZ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AAuaRoRZ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fcd0eff40cso2126948a12.0
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 13:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262189; x=1733866989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o2G4SSla57aF4GIAeWoBSIxKru0BAHIYgXUN7YmxNNU=;
        b=AAuaRoRZzA4jgCjHH4/cD3kdCI3YtlMNH7x0xkTTm9gzO3JWhsma/Ic/XrvmrSE0Iu
         Z5BSy2aVVQrD2kXGgllwQpqtR5AYad7thsNKMT5JDifl1geXK+Nvew1LmDk81n3fVyw2
         rLe3fFAZXivw7FrhfbxB87175fwbzY+fOI1+6r93sQHjDPvZ9A/ZXRMioKq0KUfN9dCS
         E7VPQz9YbwU+h8+FG2t5ElcWORGiA1yv0/Vi9HCZEPzZMKfux5bmfcX+losxhquz7kUG
         8P7x/gTc1Kos2poZ9/CWiFhuIwaHeVjHzDoRtZGyld/o4yACSp3C4sZDyIZFj260RDv7
         zmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262189; x=1733866989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2G4SSla57aF4GIAeWoBSIxKru0BAHIYgXUN7YmxNNU=;
        b=nRNAbQhQeIQPSc3luoKcpUP1SnhutYxCsqPdoEeD8+7dKKiZbZLO33qm7tfrW+SEg5
         9ai62dZqlLK7342jZjieDertSXcM+C32PZJbdd/9JLHoOfOooUYeaI+oWgK27aor+ges
         /J7l1+tBTLPxWyKJJ6MeqNk2iH2bIHrwWU9+OT79K3Ger7yPm7ygay9U5CvjmgWA5tw2
         8+dP9TLJwbXz1ljp1MgP56Do2MB26Mk0PVLwT7NDmYwaSBl1+bXtsugM2b9t4bY/QNQ2
         nmdI7IPl5y1e7D2RjB6JbHDlGSU2Sx9Piaf4jTkH5FlF4s7reziexg7Sogr5qHlI+fS3
         Ve6A==
X-Gm-Message-State: AOJu0YwlnxSSSphVscTjYYFE/TBKNeCxCLLcYKLP0CtcOSBhZkQw6WVP
	Mp/H793S3X19VpnBKKiqAo7bgnC01rQ8KkxJIzQJxKrDER0Bw0hS4w7F4jMZ2uwYkv2EJp/w3gX
	zHtSY14p9btYA/nnVjNYhnMSfT03E99uT9Q2yBXWT9UX96aV1XPR0we/Dcfp2qBFKhTOje13z1c
	AaeFQXBKOLk2axolNgDutbS1dMGGWtjuxpB0JUYA28ydIcJIJKWkEQxmTCkiM33mMBEg==
X-Google-Smtp-Source: AGHT+IEs+JcJ1ftfBdJ0NPLXotjDT61Zq0FctBsXGp7XzJ1evITq77UlQKeLVpViiQbLBNjVLleSUDnZ3ae42ztORK26
X-Received: from pgbdk14.prod.google.com ([2002:a05:6a02:c8e:b0:7fb:db54:f065])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9f4b:b0:1e0:bb0d:b1f4 with SMTP id adf61e73a8af0-1e16bdfb82fmr2916538637.11.1733262189503;
 Tue, 03 Dec 2024 13:43:09 -0800 (PST)
Date: Tue,  3 Dec 2024 13:43:02 -0800
In-Reply-To: <cover.1733259949.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1733170252.git.jonathantanmy@google.com> <cover.1733259949.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <7ae21c921fe367d4b15cd4a299196009c15205d9.1733259949.git.jonathantanmy@google.com>
Subject: [PATCH v2 1/3] index-pack --promisor: dedup before checking links
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

