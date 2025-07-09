Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B457B2D5C67
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059867; cv=none; b=fGOjtB00nsPN3tyBxW6w3p1HdtWr2oOBMLTSho7sCCzqUulD+2Cfb8KR1iuT0r+iF3bBByEBON6faeZu0vQAOu527zs/D2n2uAnQyR+x8ZIeCAyQKm7iXUmcomGVaM+inAyvGvHM89nnzAFU4EmCjvrIobuFF0GlHmLEDy+jt6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059867; c=relaxed/simple;
	bh=vo+BiWGl2yHZcRMRZf98nAzUNrbIDSJebYqBKM8sPw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ryjvl+7INWSlWZcUe0kDveXJELZpxObfrqxjlBcgzwECQZ8r8bi2SPyLFNEL74Zy3m7kFYw4Qdt+l+JNEMo8mB4OjtUJidQ56y/Zw3+TpEy6B81s4RnLs8tcV2JUKnJpI37jDzMgmWRezCwbN6/pSMD/RbB8sdKlCdOQAqzAfps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vwgb8z3m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c1pJcN2w; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vwgb8z3m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c1pJcN2w"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3C6B1400342
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:17:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 09 Jul 2025 07:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752059864;
	 x=1752146264; bh=XnOOrreHhU/7wOKVRs1pKp8eL/GFViu4TsgS5zuKcyE=; b=
	Vwgb8z3mdQyGJRxO66ghzUbeagguNhYRcmWrZbRP9thxiC9CWUFkwtCPeycwaw9L
	faZCUURS7DrL+lJp1/172NxE+LHKV+uOLZsBp+wmt5BnNcSN7/8gyEVv10lMuOPi
	zuKjdIsk/0SLDj2Zj031ymGSZ2Q34/zMgIR4yhUkHICB9HqjK+N5nKtHCFFOWmPI
	yWKF4VR6bKrGACPlZc8y7EU3kZRXfVRFe2m85JVN0Q8WXCueRjjjLyVwZv7WYTSv
	NZa4VYZaE3lbXFy6f+XUTqz2U/loT/o/tU3AHQBQdWTa3V6/uiQro6t19E9n2Wr2
	YftVBVy1KH0ShMjL3FqIUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059864; x=
	1752146264; bh=XnOOrreHhU/7wOKVRs1pKp8eL/GFViu4TsgS5zuKcyE=; b=c
	1pJcN2wsjOoqdZksuA13r9znKTlkEkd4UCHqdf8M4cu4dg4H5wnlVbtQ6XxBXW1x
	7gT2GGlzv86gNBUufXTTWP5e4S7WGVoPU0LjWfMloOdbsE5q5WOKLdK/o4L7Su/m
	zVXwDawRJjk2v/E0T3mI4rgvcxwEVTCCKhYdooIIzpeQCvlqnUY+kG8WCBEjU0uj
	mio+mwA92F8vTHWrKpaKHbcPIjkJIqmKHxxCXnaZAReh9yjXJ2oR1m+G6iyK6hRy
	EcZE+Cu7bhUXV7bY/JNxCl8vrbYnoD0lihTqEMf3vyTAbQSJ1pRv48+9TSAwh+WE
	c4LN2677A3+zgTpH6nD3Q==
X-ME-Sender: <xms:2E9uaOh5T2dKYF5ZQnJSw95Lh_L0UFyx74igJHU5GnmddJ6yHGXbPQ>
    <xme:2E9uaBDDX3LbGVo0XcBQIZhIb8JWnwLIyIrI21tyuk6tgUDjoG414THc4pXucq3_7
    8sjCWUqUMKz_NKHQg>
X-ME-Received: <xmr:2E9uaPfuO9cn0ILK0UAINDnZ_uMi2cpc5zRJkXrOdZ8YJ6fU_6i55BeBrbyRho_s173jZv7O7D4Yb_YPBo7CDeluYIOQ3zjXRM_BfdKb5wwzVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:2E9uaJeeD5whVG3C1NmuaS7N6p-8Dr8x3wx4h1XAIvrAfK-ldC10dA>
    <xmx:2E9uaDgdAWJkbNL9qjQowIvcng-38Z9g1rsa0jScQLQEWh069QIbCA>
    <xmx:2E9uaFTKWEni7G1XMOm5X_obGCsQUzkRAg875_dFqxR9T80YO1EKjw>
    <xmx:2E9uaEw9mTa7CzuMDdogYoWYFXJ2xaKJs3-kb_fTpgex5F5r9L9upA>
    <xmx:2E9uaEaXyw2t1d9aPFxtLYXVhkKBHMthlEmrnpCtifSTewmmu3rdPS3H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:17:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5e4148f2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:17:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 13:17:18 +0200
Subject: [PATCH 08/19] loose: write loose objects map via their source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-8-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When a repository is configured to have a compatibility hash algorithm
we keep track of object ID mappings for loose objects via the loose
object map. This map simply maps an object ID of the actual hash to the
object ID of the compatibility hash. This loose object map is an
inherent property of the loose files backend and thus of one specific
object source.

Refactor the interfaces to reflect this by requiring a `struct
odb_source` as input instead of a repository. This prepares for
subsequent commits where we will refactor writing of loose objects to
work on a `struct odb_source`, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 loose.c       | 16 +++++++++-------
 loose.h       |  4 +++-
 object-file.c |  6 +++---
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/loose.c b/loose.c
index 519f5db7935..e8ea6e7e24b 100644
--- a/loose.c
+++ b/loose.c
@@ -166,7 +166,8 @@ int repo_write_loose_object_map(struct repository *repo)
 	return -1;
 }
 
-static int write_one_object(struct repository *repo, const struct object_id *oid,
+static int write_one_object(struct odb_source *source,
+			    const struct object_id *oid,
 			    const struct object_id *compat_oid)
 {
 	struct lock_file lock;
@@ -174,7 +175,7 @@ static int write_one_object(struct repository *repo, const struct object_id *oid
 	struct stat st;
 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
 
-	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
+	strbuf_addf(&path, "%s/loose-object-idx", source->path);
 	hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1);
 
 	fd = open(path.buf, O_WRONLY | O_CREAT | O_APPEND, 0666);
@@ -190,7 +191,7 @@ static int write_one_object(struct repository *repo, const struct object_id *oid
 		goto errout;
 	if (close(fd))
 		goto errout;
-	adjust_shared_perm(repo, path.buf);
+	adjust_shared_perm(source->odb->repo, path.buf);
 	rollback_lock_file(&lock);
 	strbuf_release(&buf);
 	strbuf_release(&path);
@@ -204,17 +205,18 @@ static int write_one_object(struct repository *repo, const struct object_id *oid
 	return -1;
 }
 
-int repo_add_loose_object_map(struct repository *repo, const struct object_id *oid,
+int repo_add_loose_object_map(struct odb_source *source,
+			      const struct object_id *oid,
 			      const struct object_id *compat_oid)
 {
 	int inserted = 0;
 
-	if (!should_use_loose_object_map(repo))
+	if (!should_use_loose_object_map(source->odb->repo))
 		return 0;
 
-	inserted = insert_loose_map(repo->objects->sources, oid, compat_oid);
+	inserted = insert_loose_map(source, oid, compat_oid);
 	if (inserted)
-		return write_one_object(repo, oid, compat_oid);
+		return write_one_object(source, oid, compat_oid);
 	return 0;
 }
 
diff --git a/loose.h b/loose.h
index 28512306e5f..6af1702973c 100644
--- a/loose.h
+++ b/loose.h
@@ -4,6 +4,7 @@
 #include "khash.h"
 
 struct repository;
+struct odb_source;
 
 struct loose_object_map {
 	kh_oid_map_t *to_compat;
@@ -16,7 +17,8 @@ int repo_loose_object_map_oid(struct repository *repo,
 			      const struct object_id *src,
 			      const struct git_hash_algo *dest_algo,
 			      struct object_id *dest);
-int repo_add_loose_object_map(struct repository *repo, const struct object_id *oid,
+int repo_add_loose_object_map(struct odb_source *source,
+			      const struct object_id *oid,
 			      const struct object_id *compat_oid);
 int repo_read_loose_object_map(struct repository *repo);
 int repo_write_loose_object_map(struct repository *repo);
diff --git a/object-file.c b/object-file.c
index 6a7049a9e98..a9248760a26 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1025,7 +1025,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 	err = finalize_object_file_flags(the_repository, tmp_file.buf, filename.buf,
 					 FOF_SKIP_COLLISION_CHECK);
 	if (!err && compat)
-		err = repo_add_loose_object_map(the_repository, oid, &compat_oid);
+		err = repo_add_loose_object_map(the_repository->objects->sources, oid, &compat_oid);
 cleanup:
 	strbuf_release(&tmp_file);
 	strbuf_release(&filename);
@@ -1069,7 +1069,7 @@ int write_object_file_flags(const void *buf, unsigned long len,
 	if (write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags))
 		return -1;
 	if (compat)
-		return repo_add_loose_object_map(repo, oid, &compat_oid);
+		return repo_add_loose_object_map(repo->objects->sources, oid, &compat_oid);
 	return 0;
 }
 
@@ -1103,7 +1103,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
 	if (!ret && compat)
-		ret = repo_add_loose_object_map(the_repository, oid, &compat_oid);
+		ret = repo_add_loose_object_map(the_repository->objects->sources, oid, &compat_oid);
 	free(buf);
 
 	return ret;

-- 
2.50.1.327.g047016eb4a.dirty

