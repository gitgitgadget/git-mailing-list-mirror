Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBD72236F4
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554208; cv=none; b=EgALn1lMUdYr7KhDdQVdSqcLTV2AX+pE+UiNFzE2CG0Rd/wbu/xSZVmDdsF1AcE9PngZw1JntqUtI5qvRmCtsfOj+zjBz+rUR7RHTQpf0pnsjciOZLp3LMUwqlsKldxE43Dx3tLE6/MvFjNo2jDnzVMC0PY4NCowC0u7uf70rGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554208; c=relaxed/simple;
	bh=PSNQR0gBstsHOoKvRwX0Z02okgZEcv6B5yYWOZCgia8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=McmRdfozYg+UibkUP7FAqkf4vNGnTOiYelKhCKKWWHCCU2VVZIuTa9AI8b0XzCo0oQWOOSQdKFg9B0Rj/itxClVPK6+px+TCYEEcyj6yU/cdQ7i5fYvEY3O8gIBrF1/z+000SVdLpK0MZ7dLw73sK4qxKFxbnn+P7qRlvSu21So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bgZapY6q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iKCIQc2T; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bgZapY6q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iKCIQc2T"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 23B2FEC00D8;
	Thu,  7 Aug 2025 04:10:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 07 Aug 2025 04:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754554205;
	 x=1754640605; bh=6jN3NteXNUXMhnziuGXcJIxYzGFw+IcnxyK+NEfgYI4=; b=
	bgZapY6q2A6po10oaQMOz4y5DBblpma+ZVvCTjud+5fo8r7MvKNuwuzgE8uAq5pN
	amocuuWbIyxXKJEDrC1o3w75AN1LeDcXuX11s9EF9HXbGw7R+8VJMYk+oD8a69OC
	DC9DKCS8zN2Wtl9ZIHAvfNsGP5ecFu0UzY9DJIycogpwZYMII+hDxibSIEyKQzDR
	mS/D+zD0HUUksKiFRdxNzy30fUintYVVYR7L44JG6vOAGdP1CKx+Ua4N2xT1fdQh
	0JCred67Srdh8hbz4kWHl5Klln/eVS3iDU3GDQKdeuYdZl9vOj/BBS74PDjVVdFw
	AyuuSrX3x8GJNZEebLI71g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754554205; x=
	1754640605; bh=6jN3NteXNUXMhnziuGXcJIxYzGFw+IcnxyK+NEfgYI4=; b=i
	KCIQc2TbN95FPVRNH3QR6WKgCrzqkiWmdEJgCsTGNsMxS1YMfC0BKGnew3B34Qqn
	GaPe6Tb1DlnFquvnCwn4IZwf3zsEpgsLnsRLQjYJLWWrN8CgN4eIB8axLtD299Os
	muoVfO4sSwvnFdWpvpIB6sGaERLN2hsSkdAG/dgX0YCNNZiMXJRBa/Ajv+O+v8Lm
	mzSBpA4vIc2HDtQWt7TIl4v4uyykR3eYx8TP8KbxgEh2XyT0GbtBRMz+l9ol2B21
	jcMfDwiuzkQjplGfgXdJJdqIFFAx7CK3fIt2F+yP8OQKzMG8qhLtFctAmDy0mafP
	qamFNDw0YsDNbA0WGNmkg==
X-ME-Sender: <xms:XF-UaMOIk9dua1WEx6yj5hNxxqIxPG2ACmMTYwx2C51LMGOs9aJ3aA>
    <xme:XF-UaGN18rjMWLMqro4DIdo2tEY6yvc3K-VCaHiYNLprUz77lNvUwwmPnhFm5rH-X
    XBrx7A7hrUW4lIBRQ>
X-ME-Received: <xmr:XF-UaMtwwY7DsrQ2OlVNfVyTTnlRtKDnx5crXM2MYrycKf1fJVeJxU12vqrt0Qsy5xNSTTfyVP6bO_Mog8aukBKSISpwyFkNzyjPuLEYyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XF-UaAXkOAP52g_iez6bWMQ0NJBHsO04LyYu9Zn5Qf2divDQTtfsvw>
    <xmx:XF-UaEsVQxFK-sQgdOMSC3gMoR89ey_fzdV2SD-fB9mxpLzYRG3c8Q>
    <xmx:XF-UaMV8qLeOzW3X1n2ZTy7SxE_fmnnMDSZgtoRVuqhirCn2HWs3CA>
    <xmx:XF-UaHneoNGpxbM2eHFu84h5-jJlO2Rtng0TyrhNTYFDPdsPaA2cpA>
    <xmx:XV-UaJ5ehs8gDmS1xS9BqZEb217EI-FUICZqAqcoHnrjn8jU2Dj7wJN5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 04:10:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bd9cab38 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 08:10:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 07 Aug 2025 10:09:51 +0200
Subject: [PATCH v2 1/9] odb: store locality in object database sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-b4-pks-midx-deduplicate-source-info-v2-1-bcffb8fc119c@pks.im>
References: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
In-Reply-To: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Object database sources are classified either as:

  - Local, which means that the source is the repository's primary
    source. This is typically ".git/objects".

  - Non-local, which is everything else. Most importantly this includes
    alternates and quarantine directories.

This locality is often computed ad-hoc by checking whether a given
object source is the first one. This works, but it is quite roundabout.

Refactor the code so that we store locality when creating the sources in
the first place. This makes it both more accessible and robust.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c       | 5 +++--
 midx.h       | 2 +-
 odb.c        | 1 +
 odb.h        | 8 ++++++++
 packfile.c   | 9 ++++-----
 repository.c | 1 +
 6 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/midx.c b/midx.c
index 7d407682e6..b9ca0915a6 100644
--- a/midx.c
+++ b/midx.c
@@ -723,7 +723,7 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 	return 0;
 }
 
-int prepare_multi_pack_index_one(struct odb_source *source, int local)
+int prepare_multi_pack_index_one(struct odb_source *source)
 {
 	struct repository *r = source->odb->repo;
 
@@ -734,7 +734,8 @@ int prepare_multi_pack_index_one(struct odb_source *source, int local)
 	if (source->midx)
 		return 1;
 
-	source->midx = load_multi_pack_index(r, source->path, local);
+	source->midx = load_multi_pack_index(r, source->path,
+					     source->local);
 
 	return !!source->midx;
 }
diff --git a/midx.h b/midx.h
index 076382de8a..28c426a823 100644
--- a/midx.h
+++ b/midx.h
@@ -122,7 +122,7 @@ int fill_midx_entry(struct repository *r, const struct object_id *oid, struct pa
 int midx_contains_pack(struct multi_pack_index *m,
 		       const char *idx_or_pack_name);
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id);
-int prepare_multi_pack_index_one(struct odb_source *source, int local);
+int prepare_multi_pack_index_one(struct odb_source *source);
 
 /*
  * Variant of write_midx_file which writes a MIDX containing only the packs
diff --git a/odb.c b/odb.c
index 1f48a0448e..1761a50840 100644
--- a/odb.c
+++ b/odb.c
@@ -176,6 +176,7 @@ static int link_alt_odb_entry(struct object_database *odb,
 
 	CALLOC_ARRAY(alternate, 1);
 	alternate->odb = odb;
+	alternate->local = false;
 	/* pathbuf.buf is already in r->objects->source_by_path */
 	alternate->path = strbuf_detach(&pathbuf, NULL);
 
diff --git a/odb.h b/odb.h
index 09177bf430..f9300439ba 100644
--- a/odb.h
+++ b/odb.h
@@ -63,6 +63,14 @@ struct odb_source {
 	 */
 	struct multi_pack_index *midx;
 
+	/*
+	 * Figure out whether this is the local source of the owning
+	 * repository, which would typically be its ".git/objects" directory.
+	 * This local object directory is usually where objects would be
+	 * written to.
+	 */
+	bool local;
+
 	/*
 	 * This is a temporary object store created by the tmp_objdir
 	 * facility. Disable ref updates since the objects in the store
diff --git a/packfile.c b/packfile.c
index 5d73932f50..a38544b87b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -935,14 +935,14 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
 }
 
-static void prepare_packed_git_one(struct odb_source *source, int local)
+static void prepare_packed_git_one(struct odb_source *source)
 {
 	struct string_list garbage = STRING_LIST_INIT_DUP;
 	struct prepare_pack_data data = {
 		.m = source->midx,
 		.r = source->odb->repo,
 		.garbage = &garbage,
-		.local = local,
+		.local = source->local,
 	};
 
 	for_each_file_in_pack_dir(source->path, prepare_pack, &data);
@@ -1037,9 +1037,8 @@ static void prepare_packed_git(struct repository *r)
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
-		int local = (source == r->objects->sources);
-		prepare_multi_pack_index_one(source, local);
-		prepare_packed_git_one(source, local);
+		prepare_multi_pack_index_one(source);
+		prepare_packed_git_one(source);
 	}
 	rearrange_packed_git(r);
 
diff --git a/repository.c b/repository.c
index ecd691181f..97f0578381 100644
--- a/repository.c
+++ b/repository.c
@@ -168,6 +168,7 @@ void repo_set_gitdir(struct repository *repo,
 	if (!repo->objects->sources) {
 		CALLOC_ARRAY(repo->objects->sources, 1);
 		repo->objects->sources->odb = repo->objects;
+		repo->objects->sources->local = true;
 		repo->objects->sources_tail = &repo->objects->sources->next;
 	}
 	expand_base_dir(&repo->objects->sources->path, o->object_dir,

-- 
2.51.0.rc0.215.g125493bb4a.dirty

