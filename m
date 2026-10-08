Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43880489877
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453149; cv=none; b=paM2vbwh3JLaceBoSP8O9CoJDKThSDe5ghU3m283jEasO2t7MCdrM6BY82MAQiLDVlYCYFmi6eh5t/i1Y0v0CfHn/VjVaJzHtqVneXMuAFr8KXFkx/kD6GXRRcK1kVJwMKmKAvigiUkkxX68XVSMVvaFSOaSRP+DVLF8RYxncMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453149; c=relaxed/simple;
	bh=6FxxC9cFm7OAYttq0f8nLwvwmjDyi/kesNGQL1TeqTQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=d4MA7MIiaXB6oRy/WE0sT/UuyNPY6tGXqUJU/jw9k3SB+pX1qG3qmtNUv4kBlOV42zw31yXu411FIvzTNSbrzK2W3A0SrMDL00NE4iwC4rhJQmZUhH1/11XwBmMT+rSG4rlHXz20Cii9KpNS1q3bDuP0b7DdtauFZp77vy8GBlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNFKX1wG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNFKX1wG"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e812e2b31bso2903355ad.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 02:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791453147; x=1792057947; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CM1OYxRfHK4A6qb344+GTN4yBljVk8zZhWc6HwIgYkA=;
        b=PNFKX1wGkzC6aqgTqZWIqxA7+6zsW+7N1G7E6305I4mmihlFbWQ8Oe+KVe8JFPJPyN
         PRQmpotZwJBlUPtnwkm2E2nhdXI2GP0A+iGBci+X49uWhfEsRqEO8jf/6rqDLGP8Vda5
         W941Mt6t0o4c7pFLrtZ5hQcjfllN+25tP0vw7eBw0A1Uy9tb5eVVgWPFbCRUM2BBqQ3d
         m11MDPz15VqsY6CmVPg9g0RskwzSJZT2SfIdOp4m9sxhu+3+PyRZ+6M223pJ/lxBvMrD
         MJ+gEVJDjcDR4XYuu5L5/sPSocHQLkCcZQfdh+hT7lVLG7XfaeMiLmBvbEk1nfQQ2W57
         F4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453147; x=1792057947;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CM1OYxRfHK4A6qb344+GTN4yBljVk8zZhWc6HwIgYkA=;
        b=dw93m2EJ80zNbw4Ordwf6Ztf7xbl/3Agfy8TRr1SmXxEabgXA7DK1OLSTvfjXaGPQO
         zrv8ihjqM1K8gy8AIs7M52PHESQOf4pxmVjSzTNPZn7bLgtHXUrX0fAhqX8vX4tfTCF/
         f5uyadqD2h0cW8MndsEhyl6KvVEBJnPUk3abI3LowgUDn4lrh54g9sXIf6sw7ZL0IpfI
         AwprvvCE5mGXIPvScW+oY7wfg0jcp9E+1GiO8Dkq6DHVFqHsNHcTs8c7AFSUuJdR0iTH
         NwPuzOhwpsKIjefar/iKZmueyU+LBj9qPujMEbFKh3BgiYt8AGyDczAr3XhZCKpWEIWr
         7T3g==
X-Gm-Message-State: AFq9FYI43GvHGvM7l5QBXxQqpuW7+hm7XWVZe70j0Je2bjb1G4ToCZtT
	e+pZa1TGIXqLESurw1CnPUjnNJN6EjcxkdKZmLDjTXLIF4tIcSPacSUzCLunXQ==
X-Gm-Gg: AYBFou2TDTXxeDswIAjXX1F9kd/WdSF+gLz/+tAhQ3nfv+j+Fg62BTxO08fGd7YhGsy
	jnB4hCqIW6/t7R56VU6S21iF4RxhL2fErsMwkQsC9bboafWg5z0HyzdFH4+Hq1rRaP4OOYE6gYk
	rH0s6PpyljtsNBJKVAPrIs09UTR80bda43d6UTQI/M7s+pjkbS9yaYfySoMuneQWaSRL/K9wbQJ
	V/OmwzPNpRM3LSlCquQ22Ki2PgzV1Gi8r1f41E54Z+zxxt/9xU/XHTJ3ahWOk3Mr/C6Lm5Drh5+
	Ggfj7jBLCwjGYtK2A8bMmNCPqzfXjqJTZ5PSdx/hLyPf1nLx417nlbYTmfxn/rAj4yQ9ZlN9O4L
	Dew9oOQ0srEFPx3QC23uIVAdbKwxvOo8mMrMkzU9LOMKrmLpB4el2LI3MecqXOleo7VUdPgRk6Z
	vz0RP+NCm1T4ot2gEBuJEviwjSfHg/wn3MiueJlnq77MUVMdEYDJgf/GcNVUmEJY0UJoWd/4mk4
	Q==
X-Received: by 2002:a17:903:2ac5:b0:2e2:aa17:477f with SMTP id d9443c01a7336-2e600554231mr46308745ad.58.1791453147418;
        Thu, 08 Oct 2026 02:52:27 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.246.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e6044389e7sm22237735ad.4.2026.10.08.02.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:52:25 -0700 (PDT)
Message-Id: <58019e4983586888191ca16e042511d257f46d4b.1791453141.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.v3.git.1791453141.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
	<pull.2219.v3.git.1791453141.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 08 Oct 2026 09:52:18 +0000
Subject: [PATCH v3 2/5] pack-objects: reset kept-pack cache for cruft walk
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <ttaylorr@openai.com>,
    Junio C Hamano <gitster@pobox.com>,
    Justin Tobler <jltobler@gmail.com>,
    qeesung <qeesung@live.com>,
    Qin ShiCheng <qeesung@live.com>

From: Qin ShiCheng <qeesung@live.com>

When writing a cruft pack with an expiration, pack-objects first
collects the recent objects and then walks from them to rescue
whatever they reach, expired or not. A pack the caller did not list is
marked kept while collecting, so that its objects are not copied into
the cruft pack, and unmarked before the walk, so that the walk can go
through it.

The walk does not see the unmarking. Whether an object sits in a kept
pack is answered from a cache that is built on first use and only
dropped when asked about a different kind of kept pack. Collecting
builds it while the unlisted pack is still marked, the walk asks the
same kind of question, and so the unlisted pack stays in it: the walk
stops there, and whatever lies beyond it in an expired pack is left
out of the cruft pack, to go when that pack is deleted.

This went unnoticed because of "--honor-pack-keep". repack passes it,
and when there is a ".keep" file it makes the collecting side ask
about on-disk and in-core kept packs together while the walk asks
about in-core ones alone; the cache is rebuilt each time the question
changes, and by accident the walk sees the current marks. Take the
".keep" file away and the objects are lost today. A later commit stops
repack from passing "--honor-pack-keep" at all, so fix this first.

Drop the cache after re-marking. The loop over the object sources
that does so lives in packfile.c, as repo_invalidate_kept_pack_caches(),
next to has_object_kept_pack() which reads the cache. Like it, the
loop assumes every source is a files backend; keeping that assumption
in packfile.c rather than adding it to pack-objects means the two can
move together once packfile management is pushed down into that
backend.

The test builds an unreachable chain whose middle commit sits in a
pack pack-objects is not told about and whose oldest objects have
expired; without the fix the cruft pack holds only the recent tip.

Signed-off-by: Qin ShiCheng <qeesung@live.com>
---
 builtin/pack-objects.c        |  3 +++
 odb/source-packed.h           |  3 ++-
 packfile.c                    | 19 +++++++++++++++--
 packfile.h                    |  7 ++++++
 t/t5329-pack-objects-cruft.sh | 40 +++++++++++++++++++++++++++++++++++
 5 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6f579173b0..f86b3661c5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4301,10 +4301,13 @@ static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
 	/*
 	 * Re-mark only the fresh packs as kept so that objects in
 	 * unknown packs do not halt the reachability traversal early.
+	 * The kept-pack cache was built while those packs were still
+	 * marked, so drop it too.
 	 */
 	repo_for_each_pack(the_repository, p)
 		p->pack_keep_in_core = 0;
 	mark_pack_kept_in_core(fresh_packs, 1);
+	repo_invalidate_kept_pack_caches(the_repository);
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
diff --git a/odb/source-packed.h b/odb/source-packed.h
index a0f6b5096d..c8c6088a69 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -25,7 +25,8 @@ struct odb_source_packed {
 	 * Should not be accessed directly, but via
 	 * `packfile_store_get_kept_pack_cache()`. The list of packs gets
 	 * invalidated when the stored flags and the flags passed to
-	 * `packfile_store_get_kept_pack_cache()` mismatch.
+	 * `packfile_store_get_kept_pack_cache()` mismatch, or explicitly via
+	 * `repo_invalidate_kept_pack_caches()`.
 	 */
 	struct {
 		struct packed_git **packs;
diff --git a/packfile.c b/packfile.c
index 4fa5fd67c8..399c0622cd 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1870,6 +1870,22 @@ int packfile_fill_entry(struct packed_git *p,
 	return 1;
 }
 
+static void invalidate_kept_pack_cache(struct odb_source_packed *store)
+{
+	FREE_AND_NULL(store->kept_cache.packs);
+	store->kept_cache.flags = 0;
+}
+
+void repo_invalidate_kept_pack_caches(struct repository *r)
+{
+	struct odb_source *source;
+
+	for (source = r->objects->sources; source; source = source->next) {
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		invalidate_kept_pack_cache(files->packed);
+	}
+}
+
 static void maybe_invalidate_kept_pack_cache(struct odb_source_packed *store,
 					     unsigned flags)
 {
@@ -1877,8 +1893,7 @@ static void maybe_invalidate_kept_pack_cache(struct odb_source_packed *store,
 		return;
 	if (store->kept_cache.flags == flags)
 		return;
-	FREE_AND_NULL(store->kept_cache.packs);
-	store->kept_cache.flags = 0;
+	invalidate_kept_pack_cache(store);
 }
 
 struct packed_git **packfile_store_get_kept_pack_cache(struct odb_source_packed *store,
diff --git a/packfile.h b/packfile.h
index 6d30d15a00..e2db6bfff7 100644
--- a/packfile.h
+++ b/packfile.h
@@ -144,6 +144,13 @@ enum kept_pack_type {
 struct packed_git **packfile_store_get_kept_pack_cache(struct odb_source_packed *store,
 						       unsigned flags);
 
+/*
+ * Drop every packfile store's cache of kept packs, so that the next call
+ * to `packfile_store_get_kept_pack_cache()` rebuilds it, e.g. after
+ * changing which packs are kept in core.
+ */
+void repo_invalidate_kept_pack_caches(struct repository *r);
+
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 12cda06373..6302f60b75 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -332,6 +332,46 @@ test_expect_success 'cruft trees rescue sub-trees, blobs' '
 	)
 '
 
+test_expect_success 'cruft traversal rescues through a pack it was not told about' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit packed &&
+		git repack -Ad &&
+		keep="$(basename "$(ls $packdir/pack-*.pack)")" &&
+
+		test_commit old &&
+		test_commit mid &&
+		test_commit new &&
+
+		# "old" has expired, "new" is recent, and "mid" sits in a
+		# pack that pack-objects is not told about. Rescuing "old"
+		# from "new" means walking through that pack.
+		git rev-list --objects --no-object-names packed..old >old &&
+		while read object
+		do
+			test-tool chmtime -1000 \
+				"$objdir/$(test_oid_to_path $object)" || exit 1
+		done <old &&
+		git rev-list --objects --no-object-names old..mid |
+		git pack-objects $packdir/pack >/dev/null &&
+		git prune-packed &&
+
+		cruft="$(echo $keep | git pack-objects --cruft \
+			--cruft-expiration=750.seconds.ago \
+			$packdir/pack)" &&
+		test-tool pack-mtimes "pack-$cruft.mtimes" >actual.raw &&
+
+		cut -d" " -f1 <actual.raw | sort >actual &&
+		git rev-list --objects --no-object-names packed..new >expect.raw &&
+		sort <expect.raw >expect &&
+
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'expired objects are pruned' '
 	git init repo &&
 	test_when_finished "rm -fr repo" &&
-- 
gitgitgadget

