Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05661DED67
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733170728; cv=none; b=IvDB9uYeUQZA7E0GkPvELM9foK8hF9FVpLUzbaEiHo41cI9hrvvXlUBb0T5QVUqN7ZlyELPOKzVzcs0ItmwzX+fqbh7+ap3jTUXCYG9QbaaKtRDzqAAMu8kCh40aZBkhxC5CzOgW8icOoPwjeolSIpuSbx+IljVaOfH044i3GWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733170728; c=relaxed/simple;
	bh=x6uTvDqau67ublwB1WoByA/IK4JjhTqi8H86eRiBTeU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kjAXX2WkBpegSFkHlkHXlg2mi+eBDOsfICPgH3yKcxBQNgnAxV9ePS3di1fLRym0FE9zGUm68fT299tO9r3zucVQmRlHnJPKfmxggUe+DwE7Vr4AD4d3SJ1+1TRio3/IZyRJE8EWvWbaqvODakJRomXrA0VnEMQpLznWyaihIeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sUMd+sTq; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUMd+sTq"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-5eb7826862cso1677798eaf.1
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 12:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733170726; x=1733775526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0DQ4NuPogRmj48mB6MtiliPEuMhqVgH0zVzX8wiYp7Q=;
        b=sUMd+sTqpNa9Veg6XBXGlDf1EoUL2Epzv4n1zxbHRsJxFK2b245aWG8rU8I5+/Uwh5
         2NnXT3Ron7ndOR8P8BjWb1/4gx8ZAjYr/CscsYqDgeXHxsmh9D22gtScMAOSzz/mLNM2
         3f1R3ULF2TWKc90YowjUBGUQTDK6LHgwS9BXLkndM1RsDRQ72jt5DKBdZt5JcKRnb0+s
         lM98UZdQVcGJppDhj3d0wIjdm1HenvTuLan8X5QiVbTdlMrbWC9Z9N3bHk+xE56Qr4vm
         99rDunInelGtdWrWmYhc++dRR0+Lyak3oA+O0y+1RRuy/DZCkwhm1oy+ebWCmqgwi6Yt
         g0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733170726; x=1733775526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DQ4NuPogRmj48mB6MtiliPEuMhqVgH0zVzX8wiYp7Q=;
        b=midrYA0uCT4TwmbGgx7wR3DdQMdEuuXRMhXS5UQKP/tnSdNkA7EGdfrcs4Q0bIcg2n
         eoFQAxMzrzWiTAxsa85Sm1QOcx4JqToYOIpqXYJkEiIrxRqdqF6GY4urtnS3prViJu3u
         SU5qTMed0Qgs86Q8hPzau/d28RUondW+r7JPw8B/R0ALzf1KVG00UnIrc130UwCPPAXn
         kTIauPxtFxadzaFw806+T06QQZKPUXcdLq640atlVGjSkdjzgmgad4fjV11Bil+/iB2X
         OkQDdNXSZh/gW7su9B/ExB+58Vj3V2IxDrbCJ3ak0kx3NmOjyxXRNGK62UmL7SFrhQVq
         +LOQ==
X-Gm-Message-State: AOJu0YwEPOpgQnISpZr5oDE30FNOBczmy49nqx1j+X6xxzcFcRJOLVHi
	1zbxF76dW+nW+ajqDVzLSF8YtPVbLEXBhhzgTa/h1ZexqnFacTuhFpW6YAIV4pd5W5nRIon5Tba
	xKImPILOnpkbuwaPqzyiitp7L1AhroYZL0MJ/NgXK4lwW3TBQscanIAJth8+uTtXHobpkhru5Kp
	AKV7YkEVDGpgJp0cy7LRPm8x3mp86t+gAv7FfI2jBMU0/5FrUUfLk4+zCbZ9N+QGeChw==
X-Google-Smtp-Source: AGHT+IFquogFUUBY+4l4h7SBMetnTNo8Tf1u3bzEE2ctY5g9Nq48GVon6AephhHR4xuXlIYG/t7/R3I24oMNc6PRBRZw
X-Received: from oabfu18.prod.google.com ([2002:a05:6870:5d92:b0:29d:c6f7:1bb2])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:aa9b:b0:29e:684d:274d with SMTP id 586e51a60fabf-29e684d2fdbmr4849543fac.11.1733170725884;
 Mon, 02 Dec 2024 12:18:45 -0800 (PST)
Date: Mon,  2 Dec 2024 12:18:38 -0800
In-Reply-To: <cover.1733170252.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1733170252.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <5f0f114dbdf00fe246308490f09b649bd8de242c.1733170252.git.jonathantanmy@google.com>
Subject: [PATCH 1/3] index-pack: dedup first during outgoing link check
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, hanyang.tony@bytedance.com
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
 builtin/index-pack.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 95babdc5ea..8e7d14c17e 100644
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
@@ -1781,7 +1775,7 @@ static void repack_local_links(void)
 	struct object_id *oid;
 	char *base_name;
 
-	if (!oidset_size(&local_links))
+	if (!oidset_size(&outgoing_links))
 		return;
 
 	base_name = mkpathdup("%s/pack/pack", repo_get_object_directory(the_repository));
@@ -1795,8 +1789,14 @@ static void repack_local_links(void)
 	if (start_command(&cmd))
 		die(_("could not start pack-objects to repack local links"));
 
-	oidset_iter_init(&local_links, &iter);
+	oidset_iter_init(&outgoing_links, &iter);
 	while ((oid = oidset_iter_next(&iter))) {
+		struct object_info info = OBJECT_INFO_INIT;
+		if (oid_object_info_extended(the_repository, oid, &info, 0))
+			/* Missing; assume it is a promisor object */
+			continue;
+		if (info.whence == OI_PACKED && info.u.packed.pack->pack_promisor)
+			continue;
 		if (write_in_full(cmd.in, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
 		    write_in_full(cmd.in, "\n", 1) < 0)
 			die(_("failed to feed local object to pack-objects"));
@@ -1899,7 +1899,7 @@ int cmd_index_pack(int argc,
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

