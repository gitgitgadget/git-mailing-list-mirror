Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A220C468
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 08:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635061; cv=none; b=ki9sYaW9qbVvMWMG2SnZ6rifiHeHHhhEphkBI1uoNMjRgmhM2zqlfAd1bCJX+whUaXe0nPbxh129hTus4mKX1oIxkAsIDoPdiwfLkcGsTlCqzBzCELgYwS0+e83Qx/h0pvZXHvIXhUHMS2sxEx6t3buIf6vbJcmhSqTXbXBGl3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635061; c=relaxed/simple;
	bh=Oc8mUiSDPYD7e7uN8dTUt9hZLlSVgkQxaLE2MCnHI10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xzj7fL3hWmtmsWBCs5PqhnYIdy+e910kAf0cjLoeROqXckDSzvhPRh5epKRzvEIZaY0fjZGth/tr7NfIQs3PkEF0lnC3xuDC/Pw2UHXHFuabr6bX1e2V9L5DN/OEkHQNeYjj6MwmJe8mC87nOEaBfCgYwTij3qkmM+Bm1OvvQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=R/dHuxsJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R/dHuxsJ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e0c3e85c5so1536792b3a.2
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728635058; x=1729239858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zy22cqmnSBnWHMSGhvCmtgsJ7BifbyyKybuZmevynqs=;
        b=R/dHuxsJZBJjBvLtsmIZrx66cYxRfzJ2eJIMxMUqSzLEdALZsscl4oe5jkfZjvuU1+
         M+20lWU30YyOJ2gfpJ3MHLws/yfUquhF56YswZKcDd3+hnKivcAXLDUMq2/ogC0ai3eR
         nmreryTirzHJFmu7fHJer3yCbhz2ZyF+62Sox5SaXqOHOhe2WaqENizR0k9DGQeZRHd6
         /iwhZAkfFpYmbcMDVzQkG6TaLNOZDAxnxS8RzaJf3UuPwZKhHhXq/O99bmIZgabrzN7E
         HIr5DAniWiMyMnZiWzOtMG5sqhM1xdg6DeriZ7Xu0YWFItJ7O4O1MEGDSI3Czpkx/xji
         6uZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728635058; x=1729239858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zy22cqmnSBnWHMSGhvCmtgsJ7BifbyyKybuZmevynqs=;
        b=Pm+DAAO+U24mabRBrhE69YNKZf7qYdWmZHq599XTAw2BUDgkO1oJgGneoY+xphRQ4k
         DWxyc96cUVGAQDx2Cv6F93FFU37jg23gy90DMNwYD9CN/Mu5H+Sri4pzGYItwuXP1+sX
         PQZeCeNpaDcxkKClYoi+Al3ys0L9g0X6lUgiKi/ypWZ2vUy4cisP1PyotcxvJBS29W4l
         wQo7NdZWiQZJlRcuKIyu0etRnSQoH/2L2p8PLbDcgJgD2+eNKEm6JO3eFGjylh2RUoT2
         /z/cJUX/6SbGnGze3qeE+S50hPAskmZyTTFnOlh9Dz8UHpr2m+FPY+rNmBw37qMYoVe0
         5u6Q==
X-Gm-Message-State: AOJu0Yz3hdovlMsVLFM2HmroTDAoFJpAIRPwh3HMZOMOyEIT7TF9XaKW
	0uYbMKaI13ECOngsOv9IBIMJTLL+iy2Enhw0aYN2QiYbx6gsVb7I4+gRh9NON4H1NUyuuzETKtN
	pFS8=
X-Google-Smtp-Source: AGHT+IEKfwY+a+q5ywW2IPd0T7ZFYHN8VsZGXkTQh7Coqzkw90PSAlmrkRmA6CEPFM1XG0Cv0Ov7mQ==
X-Received: by 2002:a05:6a21:386:b0:1d7:7ea:2f53 with SMTP id adf61e73a8af0-1d8bcefd50cmr2213027637.1.1728635058276;
        Fri, 11 Oct 2024 01:24:18 -0700 (PDT)
Received: from localhost.localdomain ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5fa8ddesm2643121a91.39.2024.10.11.01.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 01:24:17 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	sokcevic@google.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v3 1/3] repack: pack everything into packfile
Date: Fri, 11 Oct 2024 16:24:02 +0800
Message-ID: <20241011082404.88939-2-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241011082404.88939-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20241011082404.88939-1-hanyang.tony@bytedance.com>
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
index 79f407ca04..50e14ccfc4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -343,6 +343,23 @@ static int write_oid(const struct object_id *oid,
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
@@ -392,12 +409,15 @@ static int has_pack_ext(const struct generated_pack_data *data,
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
@@ -409,13 +429,19 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
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
@@ -453,6 +479,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	if (finish_command(&cmd))
 		die(_("could not finish pack-objects to repack promisor objects"));
 	strbuf_release(&line);
+	return 0;
 }
 
 struct pack_geometry {
@@ -1356,9 +1383,13 @@ int cmd_repack(int argc,
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
@@ -1478,6 +1509,7 @@ int cmd_repack(int argc,
 		}
 	}
 
+pack_objects_end:
 	if (po_args.filter_options.choice) {
 		if (!filter_to)
 			filter_to = packtmp;
-- 
2.47.0.266.g0b04b6b485.dirty

