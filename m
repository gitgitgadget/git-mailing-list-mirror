Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799831B823
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062799; cv=none; b=EXHy0eW+XdiPpvVNGU4cFIzkvZDMNXZh/y/ArAzM720lAXLwMiwN+4va1xMXBpn3nmYU+igBxtLRL+94X/iAA4lepaWO+r4Ij5iJD4HwGx1l7FCoxXm0Q+l/zZb85cEMpBpmOcKyh8vy/KZ8jHf1eiNco3SQCzwsHYYpmRh8jy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062799; c=relaxed/simple;
	bh=xJ/f0DZKcDesSk4z31G/hxmY1dHk8cSTlZjewebO2+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tj0rTNRQ39CO2mtUZmFhsHFGTSRz3HKweSsbOYIvydT+WxtW7cUQOdVkYN61QEmIQGRnXMroDkKeSWybkqrpzrPEv2oz0IlOQBM72llPi4lJHxkQr/0yXbWoBXsodm4kBLvWhut07DwUQ6pavbGFPFQSEecxaAHXC6rGdQ406O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Drm/UcZg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JDSr+3MF; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Drm/UcZg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JDSr+3MF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E0A307A00CF
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 10:19:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 18 Aug 2026 10:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787062796;
	 x=1787149196; bh=t6BC5o4DsTDW0n1le0XX26cu5O8LIQIasepgAd0IU74=; b=
	Drm/UcZgoFeVPFLILK/vnXe13+QBQcx6ZJfynio/fh7VKevvcLcsT1W7p8BHTFaG
	wb/xWZ0ngYTB8E/SL3KbxvAnMaU5odkAUY8RQegCpDzFI/K8vGGQh9pKW1x5Slfa
	APZ8OJ4YzGp79D/h86dgPZ8XQsmn3xWe76rGkQz9kX2SiNEMgO2bKIPu2PiVGa0R
	0mAA3su/xTlNAKWgBo1oNIi9NcaJ+suDqdEaD5N2S6u2g/lR+nesBQCO2mvfcazq
	jRB9Klbf8fNHwLLOAPl3n2W8m+uJ/16jCqgm6mTtujuFuyhVd05wl7ui4Hieg8HU
	104/3VaPpoV3AKT46iNHqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787062796; x=
	1787149196; bh=t6BC5o4DsTDW0n1le0XX26cu5O8LIQIasepgAd0IU74=; b=J
	DSr+3MFAmJrlQLAeEtjGOFAZ1/zOVDVawqyb2p9Q/yNxYYZyCrfbJVYo43kz21r+
	ResUGjT9AvBZG8MHwhzH4l0JCJVAJ5cA3HK/FWOVtu63JL5J95JGXO7gEN35cGYb
	v2m4BktrSBS38E+E5BsmXvILBD24CxytmnsE3PeO6J4+v9I4L/qXXCPzQ6dyH8xW
	/r8bIEiCbgDnr3QZhfnPsrtY7Bpef6DyeT6j7R2rKVLfhU6M0Kfsou2vQSKRR+sZ
	0Tosd8yV17Vbc14E9CwRJJZlzjXnSzI19HH10e+LMZhfcnXls0Z6C9DdA5DL71NC
	lJIyZpOPUGhqFlgBl5vcw==
X-ME-Sender: <xms:DGqEarurux_ADh5PxaJgvihUXxOK1I6nRwl1Te3_VSOCLM9N9MhT-g>
    <xme:DGqEajY1NkAcjaKBu9aNiY4pshzW7p0jOuukjyOKQyHcu_zJ8BV9jRGScMCXfVHlh
    pQbNG359kef2D4bdazny-zr7jy3F8RY2qNcye-bbX2rfziSJ7fu1hM>
X-ME-Received: <xmr:DGqEakaXzWjKC6X2atTVBKUApTQBPaDSWlgQgv4N3Gj8UBeFNxI-02R4NAMRvCVhem2tcEanJH-nq4ldPmPc5FC1sawCmVRM7DS22t-o>
X-ME-Proxy-Cause: dmFkZTGeWRQN3XJ+PCNWaJB6ek4wiuWITJp8nrJrFe5zUiT+9z6FJmBFXt58En+JFG8Ahk
    FjnJhBE4mSzVmmsEUNOGAUwO4n39XmwHetw+P4ubGz9r6fdxcmxV9AxXxnusQdf37/Ioyy
    +vomc7Z1xsgdsGhpzB0rjafSmXfqYlJuhx8Dc4CZDd4D2t/qMQ0uG/XePzmvsV/cy0+mAO
    1OZ96+wlC1PFCPDB5t3rHq/W4hWDU2921Y6Fd2o5BroIviNd7EII2MiFRqIzRPfT3/6Nre
    v95UyaPEJ3G03TtKwBh0h+fah1hzkAlz+PyRBiiYQ0EEy8oYXJ2mbqtI5fId0u8E9+RqHW
    JZ9fIkmYDhPy/GAxxYRqhK+0ISGEKnimdvVdsSkY+qZjVLVu2aXn6C8Ys4I5M/CWJ7R34L
    9RgseUNtDSN99ZbcA2905MTdMpTe1z5sTsIsy/HbJgD/hV1ShLatKhSIsCmqwh5worJMf5
    1GmEhQw2jOtfHaUoQBzs7aHkNhfQh2xs7ODRukbu1qvaKUd/nHa5f7jx56+gWM+2w4/BvU
    p9Svs0AD2+Z4dKLw3etKxr2nlfig679m6yA3+d8ojP/EDIBtvXYYvI3eYqjB1CD6bUKXPP
    k26DVmi3rpOe/LYM8xtZyDJqmxlgmAbpoFhGcPtYnl6ehkCxmhF2hg29TqiA
X-ME-Proxy: <xmx:DGqEavXNb-YCSEPoKfofEfHrTgM1tvg-ei_DMQ1HAF8_pOYYxkczHQ>
    <xmx:DGqEar3EpYVYGMchydvBJ2U20yEwBn0n7SY356_DRJwUGEctIDhF1w>
    <xmx:DGqEamZ_PdxStKqQToYsTD3yWnQgcWW5CAY5fklsbEapEPz5maQ8Kw>
    <xmx:DGqEaurrq_uV5Y2o9euUVoJxzomnNcPQCNRT-r4P1R3M8HJVlUs8wA>
    <xmx:DGqEaqeE9_Y1gNha2hN5fb0ZPa7lp42bOpKwQB4J39XZWO6QQX1ZsVSl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 18 Aug 2026 10:19:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 86de90d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 18 Aug 2026 14:19:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Aug 2026 16:19:34 +0200
Subject: [PATCH 7/7] odb: handle `OBJECT_INFO_DIE_IF_CORRUPT` generically
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-pks-odb-generic-corrupt-objects-v1-7-ec234567510f@pks.im>
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
In-Reply-To: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When a lookup with `OBJECT_INFO_DIE_IF_CORRUPT` fails we want to die in
case the object exists, but cannot be read. This flag is handled in two
different spots right now:

  - `do_oid_object_info_extended()` calls `has_packed_and_bad()` to
    check whether the object is known to be corrupt in any packfile.
    This function reaches into the internals of the packed source and
    thus breaks the abstraction provided by our object sources.

  - The loose source handles the flag itself and dies directly in
    `read_object_info_from_path()`, which means that we die even in
    cases where another source may still have a good copy of the
    object.

Besides being inconsistent, it also ties us to the specific backend used
by the database sources because `has_packed_and_bad()` assumes that they
use the "files" backend. Any other backend will instead cause us to die
when calling `odb_source_files_downcast()`, even if the object was
simply nonexistent.

In the preceding commits we've carved out the infrastructure to make
this mechanism fully generic. On the one hand, all backends now tell us
whether the object is missing or corrupt via their return values. And
on the other hand, they have been tought to provide a readable error
message to the caller.

Adapt `do_oid_object_info_extended()` to use those new mechanisms. This
means that we won't die immediately anymore when a loose object is
corrupt, and we properly handle backends other than the "files" backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                        | 46 ++++++++++++++++++++++++++++++--------------
 odb/source-loose.c           |  5 -----
 packfile.c                   | 17 ----------------
 packfile.h                   |  1 -
 t/t1060-object-corruption.sh | 18 +++++++++++++++++
 5 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/odb.c b/odb.c
index 6cb0a9534b..206988f39b 100644
--- a/odb.c
+++ b/odb.c
@@ -15,7 +15,6 @@
 #include "object-name.h"
 #include "odb.h"
 #include "odb/source-inmemory.h"
-#include "packfile.h"
 #include "path.h"
 #include "promisor-remote.h"
 #include "quote.h"
@@ -551,8 +550,11 @@ static int do_oid_object_info_extended(struct object_database *odb,
 				       const struct object_id *oid,
 				       struct object_info *oi, unsigned flags)
 {
+	struct strbuf corrupt_err = STRBUF_INIT;
 	const struct object_id *real = oid;
 	int already_retried = 0;
+	bool corrupt = false;
+	int ret;
 
 	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
 		real = lookup_replace_object(odb->repo, oid);
@@ -568,9 +570,14 @@ static int do_oid_object_info_extended(struct object_database *odb,
 	while (1) {
 		struct odb_source *source;
 
-		for (source = odb->sources; source; source = source->next)
-			if (!odb_source_read_object_info(source, real, oi, flags, NULL))
-				return 0;
+		for (source = odb->sources; source; source = source->next) {
+			ret = odb_source_read_object_info(source, real, oi, flags,
+							  corrupt_err.len ? NULL : &corrupt_err);
+			if (!ret)
+				goto out;
+			if (ret < 0)
+				corrupt = true;
+		}
 
 		/*
 		 * When the object hasn't been found we try a second read and
@@ -578,11 +585,15 @@ static int do_oid_object_info_extended(struct object_database *odb,
 		 * caches or reload on-disk state.
 		 */
 		if (!(flags & OBJECT_INFO_QUICK)) {
-			for (source = odb->sources; source; source = source->next)
-				if (!odb_source_read_object_info(source, real, oi,
-								 flags | OBJECT_INFO_SECOND_READ,
-								 NULL))
-					return 0;
+			for (source = odb->sources; source; source = source->next) {
+				ret = odb_source_read_object_info(source, real, oi,
+								  flags | OBJECT_INFO_SECOND_READ,
+								  corrupt_err.len ? NULL : &corrupt_err);
+				if (!ret)
+					goto out;
+				if (ret < 0)
+					corrupt = true;
+			}
 		}
 
 		/*
@@ -605,16 +616,23 @@ static int do_oid_object_info_extended(struct object_database *odb,
 		}
 
 		if (flags & OBJECT_INFO_DIE_IF_CORRUPT) {
-			const struct packed_git *p;
 			if ((flags & OBJECT_INFO_LOOKUP_REPLACE) && !oideq(real, oid))
 				die(_("replacement %s not found for %s"),
 				    oid_to_hex(real), oid_to_hex(oid));
-			if ((p = has_packed_and_bad(odb->repo, real)))
-				die(_("packed object %s (stored in %s) is corrupt"),
-				    oid_to_hex(real), p->pack_name);
+			if (corrupt) {
+				if (corrupt_err.len)
+					die("%s", corrupt_err.buf);
+				die(_("object %s is corrupt"), oid_to_hex(real));
+			}
 		}
-		return -1;
+
+		ret = -1;
+		goto out;
 	}
+
+out:
+	strbuf_release(&corrupt_err);
+	return ret;
 }
 
 static int oid_object_info_convert(struct repository *r,
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 3cee012a6d..8ca5a78858 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -195,11 +195,6 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 	if (ret < 0 && errmsg)
 		strbuf_addf(errmsg, _("loose object %s (stored in %s) is corrupt"),
 			    oid_to_hex(oid), path);
-
-	if (ret < 0 && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
-		die(_("loose object %s (stored in %s) is corrupt"),
-		    oid_to_hex(oid), path);
-
 	if (stream_to_end)
 		git_inflate_end(stream_to_end);
 	if (map)
diff --git a/packfile.c b/packfile.c
index 3cde39a01c..cd38be088d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -985,23 +985,6 @@ void mark_bad_packed_object(struct packed_git *p, const struct object_id *oid)
 	oidset_insert(&p->bad_objects, oid);
 }
 
-const struct packed_git *has_packed_and_bad(struct repository *r,
-					    const struct object_id *oid)
-{
-	struct odb_source *source;
-
-	for (source = r->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct packfile_list_entry *e;
-
-		for (e = files->packed->packs.head; e; e = e->next)
-			if (oidset_contains(&e->pack->bad_objects, oid))
-				return e->pack;
-	}
-
-	return NULL;
-}
-
 off_t get_delta_base(struct packed_git *p,
 		     struct pack_window **w_curs,
 		     off_t *curpos,
diff --git a/packfile.h b/packfile.h
index 3229a6ed47..573fe003d0 100644
--- a/packfile.h
+++ b/packfile.h
@@ -329,7 +329,6 @@ int packed_object_info_with_index_pos(struct odb_source_packed *source,
 				      uint32_t *maybe_index_pos, struct object_info *oi);
 
 void mark_bad_packed_object(struct packed_git *, const struct object_id *);
-const struct packed_git *has_packed_and_bad(struct repository *, const struct object_id *);
 
 int has_object_pack(struct repository *r, const struct object_id *oid);
 int has_object_kept_pack(struct repository *r, const struct object_id *oid,
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index 502a5ea1c5..d2ef468b45 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -145,4 +145,22 @@ test_expect_success 'partial clone of corrupted repository' '
 	test_must_fail git -C corrupt-partial checkout --force
 '
 
+test_expect_success 'corrupted loose commit can be read from alternate' '
+	git init repo-a &&
+	tree=$(git -C repo-a write-tree) &&
+	commit=$(git -C repo-a commit-tree $tree </dev/null) &&
+
+	cp -r repo-a repo-b &&
+	(
+		cd repo-b &&
+		echo ../../../repo-a/.git/objects >.git/objects/info/alternates &&
+		corrupt_byte "$commit" 1
+	) &&
+
+	git -C repo-a cat-file -p "$commit" >expect &&
+	git -C repo-b cat-file -p "$commit" >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "inflate: data stream error" err
+'
+
 test_done

-- 
2.55.0.822.g20453c30eb.dirty

