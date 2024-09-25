Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B1C15A843
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727248842; cv=none; b=MH1m7BIIqREqFY5yHufOQH0F20/5k2IIjax2ae4SDZazJUifZ9jWU3GGBdK7iHLEDMiB/pd2NTHNYA8N7G6oTd7f9ghyw6Jo7x7kr7RT/7C2FoxyRdyKpJocLJeCtHVP+zR/eYMy7V65QlDQXvkjfLmCTX83oyRFxxKnyP+vrFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727248842; c=relaxed/simple;
	bh=gHEcPIzzayJohWr4swmJWRmGWWQSP8LL1o4rEjTvnTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1dqAzevncvZefz0ueFUjXyXgs8V1eVFh/U2JXVG/n7oWr389TnA0NwMvO0ijvS0DhTrQ5u1P7/eNXfcESGX/bmiitaQ2XwBrUR93AxiYNgl9pt7i2UxcoJRYCDsjrTaF8UgqRWrfDOW+rq+Hb7+n14OQVpQbO83I2Ba/M5iRlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eh65ldkY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eh65ldkY"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718d91eef2eso463262b3a.1
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 00:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727248839; x=1727853639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWJBWfKv9Al91OhxSxJXS0vP//RUxD01/MXPJIuz314=;
        b=eh65ldkYc3rEPqjTZBDEdAeBhGeI2gC2d0L9XGclF0XohX/4YOJfouayi4dMp8XQjK
         zZ+tRa60fMjKWysz4kNUIrlGsmlAvFaZM20ibjU7BH6si4LvI5Z57tWtCZ8OGM0cjyAs
         Px5v4oxArgvUAgSEtaDDWQMSFC5s5hltfJsXlQhUCvdOSXSxS1riT6CZ0dj+t1mTaswE
         btQcDL2IyL0/y1BDnzwmvZTGP67/Dw3Ur96k95wz9G7odWylPefh6DxVFa/BGzsklq3t
         A4wC2VBWrsSQpm8SVEJ7iTeB1JhA/fbdk+OJP/gktXFpKINs3GhKuV++6GqLTZ2fP42X
         erEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727248839; x=1727853639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWJBWfKv9Al91OhxSxJXS0vP//RUxD01/MXPJIuz314=;
        b=OT0tgxUAPMOrkVMX7WF5lR9waeG8Ptkl1I1ubZ0Y25ojDaaQx4acVJ5wBJbEk787Al
         3MkP018doZwShmH8kjQt+CEc3EOf1KXRdkAQz6shp71ydwSHBSA37qV+kHweouiX2Xw9
         U3CPpGkp0e+NnaTkr0tZkzXLqNz9J2dj96kZHVwxMBUKRQS3RGOCUw4dnv4QCM7Bgycy
         wPNm7LrwISUq5aqHwIMwy/M4pmqK81/zPWNjt7qv/UCKobL4WXeA4A4hoHOuI55apHqL
         b87nayMB6wkusMSQyN7B8ZxlSzz/VzwwKsVkZbFlkpTXJvqBadUDFZIKvQNrpoF0sbhj
         4K8Q==
X-Gm-Message-State: AOJu0YzuS+kz8FklLdSMBehPLE30Qm07qbRdxRYQBNkXwRyw1C0aVguT
	20SMyQ4aoqlKnWTcvgUK1ri2xdrlIiY9hgtlmVnvddbaF5pkOvuafsD/EFEI6RxWiIoTCwCey3U
	r
X-Google-Smtp-Source: AGHT+IErYQy3xOLM3fuv4cXGb/DzD2JGTA3SCx/sQSNgUJarseIYHYzQeq43pxKKUKuM4M4NSOBdUQ==
X-Received: by 2002:a05:6a00:6596:b0:718:eeab:97ca with SMTP id d2e1a72fcca58-71afa1f76dbmr7605293b3a.2.1727248839224;
        Wed, 25 Sep 2024 00:20:39 -0700 (PDT)
Received: from localhost.localdomain ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc938e25sm2185838b3a.131.2024.09.25.00.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 00:20:38 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	sokcevic@google.com,
	gitster@pobox.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH 1/2] repack: pack everything into packfile
Date: Wed, 25 Sep 2024 15:20:20 +0800
Message-ID: <20240925072021.77078-2-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240925072021.77078-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20240925072021.77078-1-hanyang.tony@bytedance.com>
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

