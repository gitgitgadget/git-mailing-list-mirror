Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A74176FCE
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375247; cv=none; b=kvsFCZZAKDzHmzBQxsRkOFYmGFLSsopuylc5vFjMY1O20mHoazI6n3GMB285XkeBgQ6F/PecvvYQsiWKaD9BOuX+xryP9dMP1XnqoJHsfL/8eO6nBFNp8vDYFfEarLNMXHqNrcOa7s3rjSYJ6KtkZVb7M2VthRywRx6pn1EWUaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375247; c=relaxed/simple;
	bh=gHEcPIzzayJohWr4swmJWRmGWWQSP8LL1o4rEjTvnTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eetsCwHO/4JDohadx0lbeuZmFhx1WT+dTW0DE5OvtQhy0OvKJHri8Ifo/7uBx5MLfaGKlQWMBmCHAx2fI5Mqpr/ZyzIeznYXrOBQm3fWkS2XnKOJ4iMsdMzoYa6grytMOVSHN/aFZHyo/T9CMPiflp+ogAqhHNfYdy0JUj1csdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HJvz3Qvd; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HJvz3Qvd"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7e9ff6fb4c6so3497656a12.3
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 01:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728375244; x=1728980044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWJBWfKv9Al91OhxSxJXS0vP//RUxD01/MXPJIuz314=;
        b=HJvz3QvdZxS7ZjxbeMQuiTUr1nw9qPBvSKP/0Tf2qIq/OdCPFmNUAXdsjLRGHc8ArY
         +DVryJoBTJ72/CoTGmUQEla3I4duUHiXsUfHjk/bt3w/AcPvowMbHcIXlRwns2BbiOMp
         YXq1JhOloJ9yJMGIGPHi16gfAezNYLdUb1T0SC800WIVnMMk08MtbqY0J7k2f0U5kKJk
         iT3hvvpaR9r1nXEJ9mWZEflZVuDPCvL38fysc0qwjXxwPyvkTNdVuqc2yK+aCgCZmtlR
         AqyWp9+DFUMcTPbgWCunQnB0/JR3qI3eOroh+Z1kjGD3QAXy/pf+z3K1j/9GINTCOahB
         fNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728375244; x=1728980044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWJBWfKv9Al91OhxSxJXS0vP//RUxD01/MXPJIuz314=;
        b=T2NCZvI2742bg0DOUaJpaMOmH19qSX8BF84CCFuPONKDp78dp8JqJT52rUO4pPFVKm
         yL9B23XfaJPhlEy2BjLJxBvDP/nAXKZcLEBHrB4It9/RY5LDjvnS4w0j70yfBf6YeGcU
         4hBaNE6xU4dydC1uwLhTsmHCQreYZktUlorA5I4fMmb//j9f14c5ov5vCRkWaSSUSfLl
         /qZ8mAsmsZAi2yDl7JRAXnphOSKN3dFZtIkc86AVO5J1HGKezvjWIXcFJJl7ODAAcA6F
         JHS5N32GSYZ3AJ7EkmSej9Iv/pDa3ln4ksjwbwpffCvHvxAw0Bm1UBV91MFKXZjNfQ51
         w3hA==
X-Gm-Message-State: AOJu0Yx5a0zw8vSS6Xo5Sz5zi0arUilojyjZXG5AnObf77CS5awGhRpQ
	hpmzwP3l0IlHBohdbhNu15n7XNviDL35Xx6Vm9A5TxN8JxGFyA+cpI9m33Ow/5HyguXLWeE5Gu/
	6
X-Google-Smtp-Source: AGHT+IGNoMdqYra+ZvksOUl/ZjOLY3OvzLIUyFwxPZ9LC+in754ns+rw/VcOikjOBe22bs3hvnqp0A==
X-Received: by 2002:a17:90a:f311:b0:2e2:8c6f:3dd0 with SMTP id 98e67ed59e1d1-2e28c6f3ec8mr773071a91.14.1728375243918;
        Tue, 08 Oct 2024 01:14:03 -0700 (PDT)
Received: from localhost.localdomain ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e83ca28fsm8739647a91.7.2024.10.08.01.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 01:14:03 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	sokcevic@google.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v2 1/3] repack: pack everything into packfile
Date: Tue,  8 Oct 2024 16:13:48 +0800
Message-ID: <20241008081350.8950-2-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241008081350.8950-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20241008081350.8950-1-hanyang.tony@bytedance.com>
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
 builtin/repack.c | 257 ++++++++++++++++++++++++++---------------------
 1 file changed, 143 insertions(+), 114 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index cb4420f085..e9e18a31fe 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -321,6 +321,23 @@ static int write_oid(const struct object_id *oid,
 	return 0;
 }
 
+static int write_loose_oid(const struct object_id *oid,
+				 const char *path UNUSED,
+				 void *data)
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
@@ -370,12 +387,15 @@ static int has_pack_ext(const struct generated_pack_data *data,
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
@@ -387,13 +407,19 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
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
@@ -431,6 +457,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	if (finish_command(&cmd))
 		die(_("could not finish pack-objects to repack promisor objects"));
 	strbuf_release(&line);
+	return 0;
 }
 
 struct pack_geometry {
@@ -1312,8 +1339,7 @@ int cmd_repack(int argc,
 		strvec_push(&cmd.args, "--reflog");
 		strvec_push(&cmd.args, "--indexed-objects");
 	}
-	if (repo_has_promisor_remote(the_repository))
-		strvec_push(&cmd.args, "--exclude-promisor-objects");
+
 	if (!write_midx) {
 		if (write_bitmaps > 0)
 			strvec_push(&cmd.args, "--write-bitmap-index");
@@ -1323,125 +1349,128 @@ int cmd_repack(int argc,
 	if (use_delta_islands)
 		strvec_push(&cmd.args, "--delta-islands");
 
-	if (pack_everything & ALL_INTO_ONE) {
-		repack_promisor_objects(&po_args, &names);
-
-		if (has_existing_non_kept_packs(&existing) &&
-		    delete_redundant &&
-		    !(pack_everything & PACK_CRUFT)) {
-			for_each_string_list_item(item, &names) {
-				strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
-					     packtmp_name, item->string);
-			}
-			if (unpack_unreachable) {
-				strvec_pushf(&cmd.args,
-					     "--unpack-unreachable=%s",
-					     unpack_unreachable);
-			} else if (pack_everything & LOOSEN_UNREACHABLE) {
-				strvec_push(&cmd.args,
-					    "--unpack-unreachable");
-			} else if (keep_unreachable) {
-				strvec_push(&cmd.args, "--keep-unreachable");
-				strvec_push(&cmd.args, "--pack-loose-unreachable");
+	if (repo_has_promisor_remote(the_repository)) {
+		ret = repack_promisor_objects(&po_args, &names,
+			&existing.non_kept_packs, pack_everything & ALL_INTO_ONE);
+	} else {
+		if (pack_everything & ALL_INTO_ONE) {
+			if (has_existing_non_kept_packs(&existing) &&
+			delete_redundant &&
+			!(pack_everything & PACK_CRUFT)) {
+				for_each_string_list_item(item, &names) {
+					strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
+						packtmp_name, item->string);
+				}
+				if (unpack_unreachable) {
+					strvec_pushf(&cmd.args,
+						"--unpack-unreachable=%s",
+						unpack_unreachable);
+				} else if (pack_everything & LOOSEN_UNREACHABLE) {
+					strvec_push(&cmd.args,
+						"--unpack-unreachable");
+				} else if (keep_unreachable) {
+					strvec_push(&cmd.args, "--keep-unreachable");
+					strvec_push(&cmd.args, "--pack-loose-unreachable");
+				}
 			}
+		} else if (geometry.split_factor) {
+			strvec_push(&cmd.args, "--stdin-packs");
+			strvec_push(&cmd.args, "--unpacked");
+		} else {
+			strvec_push(&cmd.args, "--unpacked");
+			strvec_push(&cmd.args, "--incremental");
 		}
-	} else if (geometry.split_factor) {
-		strvec_push(&cmd.args, "--stdin-packs");
-		strvec_push(&cmd.args, "--unpacked");
-	} else {
-		strvec_push(&cmd.args, "--unpacked");
-		strvec_push(&cmd.args, "--incremental");
-	}
 
-	if (po_args.filter_options.choice)
-		strvec_pushf(&cmd.args, "--filter=%s",
-			     expand_list_objects_filter_spec(&po_args.filter_options));
-	else if (filter_to)
-		die(_("option '%s' can only be used along with '%s'"), "--filter-to", "--filter");
+		if (po_args.filter_options.choice)
+			strvec_pushf(&cmd.args, "--filter=%s",
+				expand_list_objects_filter_spec(&po_args.filter_options));
+		else if (filter_to)
+			die(_("option '%s' can only be used along with '%s'"), "--filter-to", "--filter");
 
-	if (geometry.split_factor)
-		cmd.in = -1;
-	else
-		cmd.no_stdin = 1;
+		if (geometry.split_factor)
+			cmd.in = -1;
+		else
+			cmd.no_stdin = 1;
 
-	ret = start_command(&cmd);
-	if (ret)
-		goto cleanup;
+		ret = start_command(&cmd);
+		if (ret)
+			goto cleanup;
 
-	if (geometry.split_factor) {
-		FILE *in = xfdopen(cmd.in, "w");
-		/*
-		 * The resulting pack should contain all objects in packs that
-		 * are going to be rolled up, but exclude objects in packs which
-		 * are being left alone.
-		 */
-		for (i = 0; i < geometry.split; i++)
-			fprintf(in, "%s\n", pack_basename(geometry.pack[i]));
-		for (i = geometry.split; i < geometry.pack_nr; i++)
-			fprintf(in, "^%s\n", pack_basename(geometry.pack[i]));
-		fclose(in);
-	}
+		if (geometry.split_factor) {
+			FILE *in = xfdopen(cmd.in, "w");
+			/*
+			* The resulting pack should contain all objects in packs that
+			* are going to be rolled up, but exclude objects in packs which
+			* are being left alone.
+			*/
+			for (i = 0; i < geometry.split; i++)
+				fprintf(in, "%s\n", pack_basename(geometry.pack[i]));
+			for (i = geometry.split; i < geometry.pack_nr; i++)
+				fprintf(in, "^%s\n", pack_basename(geometry.pack[i]));
+			fclose(in);
+		}
 
-	ret = finish_pack_objects_cmd(&cmd, &names, 1);
-	if (ret)
-		goto cleanup;
-
-	if (!names.nr && !po_args.quiet)
-		printf_ln(_("Nothing new to pack."));
-
-	if (pack_everything & PACK_CRUFT) {
-		const char *pack_prefix = find_pack_prefix(packdir, packtmp);
-
-		if (!cruft_po_args.window)
-			cruft_po_args.window = po_args.window;
-		if (!cruft_po_args.window_memory)
-			cruft_po_args.window_memory = po_args.window_memory;
-		if (!cruft_po_args.depth)
-			cruft_po_args.depth = po_args.depth;
-		if (!cruft_po_args.threads)
-			cruft_po_args.threads = po_args.threads;
-		if (!cruft_po_args.max_pack_size)
-			cruft_po_args.max_pack_size = po_args.max_pack_size;
-
-		cruft_po_args.local = po_args.local;
-		cruft_po_args.quiet = po_args.quiet;
-
-		ret = write_cruft_pack(&cruft_po_args, packtmp, pack_prefix,
-				       cruft_expiration, &names,
-				       &existing);
+		ret = finish_pack_objects_cmd(&cmd, &names, 1);
 		if (ret)
 			goto cleanup;
 
-		if (delete_redundant && expire_to) {
-			/*
-			 * If `--expire-to` is given with `-d`, it's possible
-			 * that we're about to prune some objects. With cruft
-			 * packs, pruning is implicit: any objects from existing
-			 * packs that weren't picked up by new packs are removed
-			 * when their packs are deleted.
-			 *
-			 * Generate an additional cruft pack, with one twist:
-			 * `names` now includes the name of the cruft pack
-			 * written in the previous step. So the contents of
-			 * _this_ cruft pack exclude everything contained in the
-			 * existing cruft pack (that is, all of the unreachable
-			 * objects which are no older than
-			 * `--cruft-expiration`).
-			 *
-			 * To make this work, cruft_expiration must become NULL
-			 * so that this cruft pack doesn't actually prune any
-			 * objects. If it were non-NULL, this call would always
-			 * generate an empty pack (since every object not in the
-			 * cruft pack generated above will have an mtime older
-			 * than the expiration).
-			 */
-			ret = write_cruft_pack(&cruft_po_args, expire_to,
-					       pack_prefix,
-					       NULL,
-					       &names,
-					       &existing);
+		if (!names.nr && !po_args.quiet)
+			printf_ln(_("Nothing new to pack."));
+			
+		if (pack_everything & PACK_CRUFT) {
+			const char *pack_prefix = find_pack_prefix(packdir, packtmp);
+
+			if (!cruft_po_args.window)
+				cruft_po_args.window = po_args.window;
+			if (!cruft_po_args.window_memory)
+				cruft_po_args.window_memory = po_args.window_memory;
+			if (!cruft_po_args.depth)
+				cruft_po_args.depth = po_args.depth;
+			if (!cruft_po_args.threads)
+				cruft_po_args.threads = po_args.threads;
+			if (!cruft_po_args.max_pack_size)
+				cruft_po_args.max_pack_size = po_args.max_pack_size;
+
+			cruft_po_args.local = po_args.local;
+			cruft_po_args.quiet = po_args.quiet;
+
+			ret = write_cruft_pack(&cruft_po_args, packtmp, pack_prefix,
+					cruft_expiration, &names,
+					&existing);
 			if (ret)
 				goto cleanup;
+
+			if (delete_redundant && expire_to) {
+				/*
+				* If `--expire-to` is given with `-d`, it's possible
+				* that we're about to prune some objects. With cruft
+				* packs, pruning is implicit: any objects from existing
+				* packs that weren't picked up by new packs are removed
+				* when their packs are deleted.
+				*
+				* Generate an additional cruft pack, with one twist:
+				* `names` now includes the name of the cruft pack
+				* written in the previous step. So the contents of
+				* _this_ cruft pack exclude everything contained in the
+				* existing cruft pack (that is, all of the unreachable
+				* objects which are no older than
+				* `--cruft-expiration`).
+				*
+				* To make this work, cruft_expiration must become NULL
+				* so that this cruft pack doesn't actually prune any
+				* objects. If it were non-NULL, this call would always
+				* generate an empty pack (since every object not in the
+				* cruft pack generated above will have an mtime older
+				* than the expiration).
+				*/
+				ret = write_cruft_pack(&cruft_po_args, expire_to,
+						pack_prefix,
+						NULL,
+						&names,
+						&existing);
+				if (ret)
+					goto cleanup;
+			}
 		}
 	}
 
-- 
2.46.0

