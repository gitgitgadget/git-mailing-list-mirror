Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B174389459
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302064; cv=none; b=TX1k0JwvUuXwfsroqfqRUwvdrmlfnRhhSMGaIoevly92wHLSgkS5Bh7bA0rDE6SPh8WQZ6RtiuNS1/ek4DcmnloHIry3taFr/PkBq7nbEXua280h9WCZGJkiCDRkALuw6M5S1hYdMWgG3703mfxBFtDkdSZzS2QucEeEXYPUFFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302064; c=relaxed/simple;
	bh=ixw+/8mvHjiAZ0VHUzItrJzZ9N2OZBaytqBe8NUDz68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i4j89at+IYc6IO0J7IHfNKlyF5o19xZByfanOV692OOag+p0rAzKrZmRd1hmx2Xpi3vYD3Z401MfiKQM3Rx2LsF7H1OUAf7kfKDpi4WxIZC/3cEP56nHNqzZQcFu6+9CfUPThOAgmWWoeW3FBAaJX/3BQT+9rRRrLE6BGE0YWvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vsDdQADC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pbce9IkR; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vsDdQADC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pbce9IkR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A23861400085;
	Mon,  1 Jun 2026 04:21:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 01 Jun 2026 04:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302062;
	 x=1780388462; bh=ndUZ+0J75HOXcfQBZPNMShZPIBUTph5ZgtHRfxvJZW0=; b=
	vsDdQADCUYtlTt6uJWSGMZUKJrPvm8l6MWp3RxfrI1xWw5jMjuI0h0qVdPIqKvHP
	hFbInBgqNYU0B41V7sPApL/HuEb3wgWkW2TZMN2lawSegoW4sJdND9doTtipFdY8
	aKmZYqqsXX5QWZDEebQhjqtoyIrETi4l7rYfgITzr7dZQcf34LIM8ZMALaZzN/wd
	WV6Ah85WTn53SYqqTUWgWuxEKzP3oyKqPCsPimKqZEkwKfC6Eg3OijPrxlyaAXC1
	oB1M/9H4EkvJFWpA7LW65PcVpS2MOAl8JJTyp1qRbjtKncYvehIL3RiC9EFsx3cT
	0Kjpwmmkh+/bGzsAJntmUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302062; x=
	1780388462; bh=ndUZ+0J75HOXcfQBZPNMShZPIBUTph5ZgtHRfxvJZW0=; b=P
	bce9IkRzQbGNBlE+quZwBUGzKTJutxw9clL5ia139eLNVrdA8TTsYtlYeJkNe8QR
	J9BGwP9h0BEsipO4cgoTc+wVb9o/HMDLn43FLEHY2+g6B7resj3AEdC36h6wl0GU
	OT2JcIiQRNwXkYGjBu6fM8iaUCHZKWVK3QgeDdB9Ob/K3+mCO6/c1aWlENeeCyJa
	J46H0GzE7abCmKc05cyeWAL8ezdooDdJPklmgsdlBcB72YHn2iB6CGkmRN5xhBo0
	+uuVKkMX7FnXnpQ+KVBP3lwBBYM5d5dzC1uyB2rULgTJG0TNiy6SQyM9mAZkRGM9
	+bBxJmghfyucZlfZshlOw==
X-ME-Sender: <xms:7kAdatQABLFdmIrWQYGXEBkZuIYuzMPUmPN1ET0_ZJLSkAw7IvwGjg>
    <xme:7kAdasxxdmt5ht72gtF13fJr1lpUWF6zXAh2qf7dLF7L_TjiEgjyDp7u0iIleeijP
    jQfAbkZdmUTBXD06XCgF_SBnL9d19tZpbNaPzOpvP6g_tcjlLEH>
X-ME-Received: <xmr:7kAdageyBDCY7sgYD4wMb06uywqHt6qCPVQrXfAyHEVNP8KzOfYWRNFW3S3T3p28y7vP8nuYKKDWCZPUMyuSNb4wveEJQZeVXzMOuI6_Gx3m>
X-ME-Proxy-Cause: dmFkZTFUm9EvzxDyDKebPxlXI4ruaJR1Pier/Fr49ppMjRQ4uPDPeN5XKXu7zSwLseMDDK
    hCSr1zVhGpvkoCUKczS0U5Hcwr55dXFWBJvIAlBHnzdhvkTqGbBDhodYXUQfeMaL1F6tvw
    tVWQ0hMk04QJceIWyPVSJKfVrA4S4e/rmQjGcIlHjUzj/pdusLSG1HKdK0G4uE/Lm53pxd
    bHLQgN3x9WuwB/AnNkpUB9mDnnGJHDESw+AsKAOo0BosyBOIYziNV8sFWSanoPUpD5ZAlP
    SzwYVTB5HdsPRS+Hy9hmBfjeTiuGCMz0fqT0W9EjwMXcglskhcFT9ZZrqh5/74MugkYJXs
    C5ztUytMejiWBgOO8RCaNiE5FQrPz5pZ4tCM1/gyR0vXuJBITAgTvTnsUVaFvPqfWPAhFR
    IeYwW9u2zwGhwVLDjiQ10TbCi7VA1fFni1TaHImU/eGIB1tMYydCM0HW4gAQJaYhbUCTHg
    sk16YNSN5Hym2Rz7baB7nJAo6d8DhXzIsC9eeFTyRQ3WHmmkYEuLg649MdZB7dlBhdVjcA
    K9w7pE8vIK89h5PCdVyyWLPoIw5awTuTHALpZsNqOdy0R4ySMpIUWUZ67NfvoiGVUPEtJe
    prZ8btY35QWLm0PhsiLu+in1p9238Pt5EY+vRlrnPabVco5yT3foYWWovuAg
X-ME-Proxy: <xmx:7kAdagJgQAKj__y5f5-D1kWHBJo6E2I24zzVMKxvgFMSBYWVvnL_-Q>
    <xmx:7kAdapEqSfNgXrgyLo6iC5ynTEImBQ9Rpu7GOSbTiArl6f1w1YmDfg>
    <xmx:7kAdaipRqevqLKmHSl59pasn2Eeqcaz2kZEQ7n2iCUl2AxX74zBhJw>
    <xmx:7kAdaqT9T5C77fQDYYkMb7LF1ZdBjKukh9Z4hLCZwSkkOAo_WgfYcw>
    <xmx:7kAdagoJrjUh03--3p9vFcxsOIz7xmkIpMlixnqry9kwk8DRFk2mKtmQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:21:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 86ff9ac1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:21:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 10:20:36 +0200
Subject: [PATCH v2 13/18] loose: refactor object map to operate on `struct
 odb_source_loose`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-odb-source-loose-v2-13-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

While the loose object map functions in "loose.c" accept a generic
`struct odb_source *`, they always expect this to be the "files"
backend. Furthermore, the subsystem doesn't even care about the "files"
backend, but only uses it as a stepping stone to get to the "loose"
backend.

This assumption is implicit and thus not immediately obvious. Refactor
the interfaces to instead operate on a `struct odb_source_loose`
instead, which eliminates the implicit dependency and unnecessary detour
via the "files" source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 loose.c       | 45 ++++++++++++++++++++++-----------------------
 loose.h       |  4 ++--
 object-file.c |  9 ++++++---
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/loose.c b/loose.c
index f7a3dd1a72..0b626c1b85 100644
--- a/loose.c
+++ b/loose.c
@@ -46,38 +46,36 @@ static int insert_oid_pair(kh_oid_map_t *map, const struct object_id *key, const
 	return 1;
 }
 
-static int insert_loose_map(struct odb_source *source,
+static int insert_loose_map(struct odb_source_loose *loose,
 			    const struct object_id *oid,
 			    const struct object_id *compat_oid)
 {
-	struct odb_source_files *files = odb_source_files_downcast(source);
-	struct loose_object_map *map = files->loose->map;
+	struct loose_object_map *map = loose->map;
 	int inserted = 0;
 
 	inserted |= insert_oid_pair(map->to_compat, oid, compat_oid);
 	inserted |= insert_oid_pair(map->to_storage, compat_oid, oid);
 	if (inserted)
-		oidtree_insert(files->loose->cache, compat_oid, NULL);
+		oidtree_insert(loose->cache, compat_oid, NULL);
 
 	return inserted;
 }
 
-static int load_one_loose_object_map(struct repository *repo, struct odb_source *source)
+static int load_one_loose_object_map(struct repository *repo, struct odb_source_loose *loose)
 {
-	struct odb_source_files *files = odb_source_files_downcast(source);
 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
 	FILE *fp;
 
-	if (!files->loose->map)
-		loose_object_map_init(&files->loose->map);
-	if (!files->loose->cache) {
-		ALLOC_ARRAY(files->loose->cache, 1);
-		oidtree_init(files->loose->cache);
+	if (!loose->map)
+		loose_object_map_init(&loose->map);
+	if (!loose->cache) {
+		ALLOC_ARRAY(loose->cache, 1);
+		oidtree_init(loose->cache);
 	}
 
-	insert_loose_map(source, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
-	insert_loose_map(source, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
-	insert_loose_map(source, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
+	insert_loose_map(loose, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
+	insert_loose_map(loose, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
+	insert_loose_map(loose, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
 
 	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
 	fp = fopen(path.buf, "rb");
@@ -97,7 +95,7 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source
 		    parse_oid_hex_algop(p, &compat_oid, &p, repo->compat_hash_algo) ||
 		    p != buf.buf + buf.len)
 			goto err;
-		insert_loose_map(source, &oid, &compat_oid);
+		insert_loose_map(loose, &oid, &compat_oid);
 	}
 
 	strbuf_release(&buf);
@@ -119,7 +117,8 @@ int repo_read_loose_object_map(struct repository *repo)
 	odb_prepare_alternates(repo->objects);
 
 	for (source = repo->objects->sources; source; source = source->next) {
-		if (load_one_loose_object_map(repo, source) < 0) {
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		if (load_one_loose_object_map(repo, files->loose) < 0) {
 			return -1;
 		}
 	}
@@ -171,7 +170,7 @@ int repo_write_loose_object_map(struct repository *repo)
 	return -1;
 }
 
-static int write_one_object(struct odb_source *source,
+static int write_one_object(struct odb_source_loose *loose,
 			    const struct object_id *oid,
 			    const struct object_id *compat_oid)
 {
@@ -180,7 +179,7 @@ static int write_one_object(struct odb_source *source,
 	struct stat st;
 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
 
-	strbuf_addf(&path, "%s/loose-object-idx", source->path);
+	strbuf_addf(&path, "%s/loose-object-idx", loose->base.path);
 	hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1);
 
 	fd = open(path.buf, O_WRONLY | O_CREAT | O_APPEND, 0666);
@@ -196,7 +195,7 @@ static int write_one_object(struct odb_source *source,
 		goto errout;
 	if (close(fd))
 		goto errout;
-	adjust_shared_perm(source->odb->repo, path.buf);
+	adjust_shared_perm(loose->base.odb->repo, path.buf);
 	rollback_lock_file(&lock);
 	strbuf_release(&buf);
 	strbuf_release(&path);
@@ -210,18 +209,18 @@ static int write_one_object(struct odb_source *source,
 	return -1;
 }
 
-int repo_add_loose_object_map(struct odb_source *source,
+int repo_add_loose_object_map(struct odb_source_loose *loose,
 			      const struct object_id *oid,
 			      const struct object_id *compat_oid)
 {
 	int inserted = 0;
 
-	if (!should_use_loose_object_map(source->odb->repo))
+	if (!should_use_loose_object_map(loose->base.odb->repo))
 		return 0;
 
-	inserted = insert_loose_map(source, oid, compat_oid);
+	inserted = insert_loose_map(loose, oid, compat_oid);
 	if (inserted)
-		return write_one_object(source, oid, compat_oid);
+		return write_one_object(loose, oid, compat_oid);
 	return 0;
 }
 
diff --git a/loose.h b/loose.h
index 6af1702973..6c9b3f4571 100644
--- a/loose.h
+++ b/loose.h
@@ -4,7 +4,7 @@
 #include "khash.h"
 
 struct repository;
-struct odb_source;
+struct odb_source_loose;
 
 struct loose_object_map {
 	kh_oid_map_t *to_compat;
@@ -17,7 +17,7 @@ int repo_loose_object_map_oid(struct repository *repo,
 			      const struct object_id *src,
 			      const struct git_hash_algo *dest_algo,
 			      struct object_id *dest);
-int repo_add_loose_object_map(struct odb_source *source,
+int repo_add_loose_object_map(struct odb_source_loose *loose,
 			      const struct object_id *oid,
 			      const struct object_id *compat_oid);
 int repo_read_loose_object_map(struct repository *repo);
diff --git a/object-file.c b/object-file.c
index 0689a4e67b..fe24f00d1b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -810,6 +810,7 @@ int odb_source_loose_write_stream(struct odb_source *source,
 				  struct odb_write_stream *in_stream, size_t len,
 				  struct object_id *oid)
 {
+	struct odb_source_files *files = odb_source_files_downcast(source);
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	struct object_id compat_oid;
 	int fd, ret, err = 0, flush = 0;
@@ -918,7 +919,7 @@ int odb_source_loose_write_stream(struct odb_source *source,
 	err = finalize_object_file_flags(source->odb->repo, tmp_file.buf, filename.buf,
 					 FOF_SKIP_COLLISION_CHECK);
 	if (!err && compat)
-		err = repo_add_loose_object_map(source, oid, &compat_oid);
+		err = repo_add_loose_object_map(files->loose, oid, &compat_oid);
 cleanup:
 	strbuf_release(&tmp_file);
 	strbuf_release(&filename);
@@ -931,6 +932,7 @@ int odb_source_loose_write_object(struct odb_source *source,
 				  struct object_id *compat_oid_in,
 				  enum odb_write_object_flags flags)
 {
+	struct odb_source_files *files = odb_source_files_downcast(source);
 	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	struct object_id compat_oid;
@@ -962,13 +964,14 @@ int odb_source_loose_write_object(struct odb_source *source,
 	if (write_loose_object(source, oid, hdr, hdrlen, buf, len, 0, flags))
 		return -1;
 	if (compat)
-		return repo_add_loose_object_map(source, oid, &compat_oid);
+		return repo_add_loose_object_map(files->loose, oid, &compat_oid);
 	return 0;
 }
 
 int force_object_loose(struct odb_source *source,
 		       const struct object_id *oid, time_t mtime)
 {
+	struct odb_source_files *files = odb_source_files_downcast(source);
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	void *buf;
 	unsigned long len;
@@ -998,7 +1001,7 @@ int force_object_loose(struct odb_source *source,
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 	ret = write_loose_object(source, oid, hdr, hdrlen, buf, len, mtime, 0);
 	if (!ret && compat)
-		ret = repo_add_loose_object_map(source, oid, &compat_oid);
+		ret = repo_add_loose_object_map(files->loose, oid, &compat_oid);
 	free(buf);
 
 	return ret;

-- 
2.54.0.926.g75ba10bac6.dirty

