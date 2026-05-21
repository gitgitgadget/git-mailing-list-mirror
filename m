Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D03AC0F2
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351778; cv=none; b=o1fOAPeVonSq3Y87SG/uS6a8h8ydAc6PhV0ZOyt4otZ/lFxORgohVa1QKIqNPndO44Q7AKkcb2aa9QALoH9+/oTVytGF/5n6J9IF0vzJiUhixmvJKbjf//7XQuJE6V4d016Okqc5/PgD/elwfMux3cwC2uL8xTHCDUgVKML5ivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351778; c=relaxed/simple;
	bh=o/vUP1VrpWIBianHDkBEcMYIqNxVPMEexFkWyRwqsdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CHQggE9Znd0EhjUd58wqHEVdY9xQBoBO0ToT2792BBvlOEKfdIYlBCRFD0DcsYqubEqTUYZNMdFcjNJwo+CpDoSfH701/fzwK+fSiO2gZp3EBXPYV7i9MGX1eozc00Rw1ywdOgZFcehuins4CtXQDjNsx+FT6Uuo3kMVK716HNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QUs9W4BK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QaAixd3B; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QUs9W4BK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QaAixd3B"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9CC3DEC00A2
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:22:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 21 May 2026 04:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779351776;
	 x=1779438176; bh=bnQCUeE3olnmr1nCx+smYyw1PCShZSKEx4YURev88TU=; b=
	QUs9W4BKtdaAQhJZFehVVbQhs7LRlwpOPyyzuwncLhBvBLHYj/clukEpjpTF3Quu
	wT/7P+m+VKp4m9fo8IM/lXM4ZgniWa/coRlOsyFWQmsGKuqU2nyvGOMkh+cs3dgX
	Y3YgVUlXiSI7GbnKkpQVbhLHdywzD8e5ap+Ow3i0sC4nGSHaJWbKtBKhxMYoGIKM
	pX3ONMpbLGz3Ty15vOHT9xJEQp+u4jxTIRINKD5ZLR2LSqJxVYZh0Nay/1sbsmvm
	WysNnuBc0bEAUTpxv2TetZCVJOFd1Vt7cUIgjASujjDxjh7PO1zIbLGEKMRID8WW
	a0XVQJ182DBfsNquk2w2YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779351776; x=
	1779438176; bh=bnQCUeE3olnmr1nCx+smYyw1PCShZSKEx4YURev88TU=; b=Q
	aAixd3BZ0JGT4x+E/QfzpMD5cKIPs0JIU9JMUSNkZPeDm0c9CAGWTMIscBrxOeGB
	Zdcm655P4dnFicV5g4/cFYtRpQ8xfU2+e8/K74GB8jP4U+hW6KqxhJuNjVjw+VMA
	EA+w+JGmK0uitDzr7bgLqIeldC2V07obuUdKE0lfaXBUhpV+nJu6kVAv+YGyU9NE
	Fl4HvdTaD3RqANvHw/wOwBDSu1S1/o42VrF+RFK4mhyU1pVBUZMO1ksvyjE4Z0xV
	1EWZhjhX2II5pXgjoy/UFcFKqxRax96YWm8/yYM3gH5dAGQLEYGDSfMq+bMp6922
	/JaQZ6IVzzRcg6oP8wJqw==
X-ME-Sender: <xms:4MAOaj-RroSuY2qeSf22S-sx0gtb_aqRE8Z3QlQE2iLX7yeXGxyNRg>
    <xme:4MAOamqGhoNLOUl_xx3EYmsV-2m4BPAxvfsk-k-LZwQkhe2kkmEUEnvr7ZzjZEMDx
    cTNuNKGL3QiSLFUWOTiyedqwQrafY3opHIo4vCG_OG3_jUU2OlXqA>
X-ME-Received: <xmr:4MAOamri5C5YtGxLF3hZBFNAU4SXAMEbJAwypy83v7kU7r-H8wcSkAyuP0aHg7wXhXgX6DUP7RYo54eoenhdTRXkJFxlvsOhjpVVLDvd9Ic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:4MAOakkkDamSXI_HV-96im84fLk-PGXBVuPiJmBSQeOotm_NXOHPwA>
    <xmx:4MAOaoH-oiv7R5LIz6mZhYKlYsv3fSP_MDKm8peBzODJjd-keMAbTw>
    <xmx:4MAOatovpUMNrFFJoFJLo7Rv-_TxPUuEBBnObwZhEcqfMQAVEPM-6Q>
    <xmx:4MAOak5FSm5Yd6QrGsa3PQjCb0JqrvByGfZ3D2MBn9qTq3GOJSNkjA>
    <xmx:4MAOavsXpzlfrsLGITLPS7Ec6_sNkqbbRkvFD23-ZHDQnAOyyreImtbQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:22:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 34d6a598 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:22:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:22:30 +0200
Subject: [PATCH 10/18] odb/source-loose: wire up `count_objects()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-odb-source-loose-v1-10-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Move `odb_source_loose_count_objects()` and its associated helpers from
"object-file.c" into "odb/source-loose.c" and wire it up as the
`count_objects()` callback of the loose source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c       |  6 +++---
 object-file.c      | 60 -----------------------------------------------------
 object-file.h      | 14 -------------
 odb/source-files.c |  2 +-
 odb/source-loose.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 65 insertions(+), 78 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 84a66d3240..c26c93ee0f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -466,6 +466,7 @@ static int rerere_gc_condition(struct gc_config *cfg UNUSED)
 
 static int too_many_loose_objects(int limit)
 {
+	struct odb_source_files *files = odb_source_files_downcast(the_repository->objects->sources);
 	/*
 	 * This is weird, but stems from legacy behaviour: the GC auto
 	 * threshold was always essentially interpreted as if it was rounded up
@@ -474,9 +475,8 @@ static int too_many_loose_objects(int limit)
 	int auto_threshold = DIV_ROUND_UP(limit, 256) * 256;
 	unsigned long loose_count;
 
-	if (odb_source_loose_count_objects(the_repository->objects->sources,
-					   ODB_COUNT_OBJECTS_APPROXIMATE,
-					   &loose_count) < 0)
+	if (odb_source_count_objects(&files->loose->base, ODB_COUNT_OBJECTS_APPROXIMATE,
+				     &loose_count) < 0)
 		return 0;
 
 	return loose_count > auto_threshold;
diff --git a/object-file.c b/object-file.c
index 11957aa44f..9b2044de37 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1602,66 +1602,6 @@ int for_each_loose_file_in_source(struct odb_source *source,
 	return r;
 }
 
-static int count_loose_object(const struct object_id *oid UNUSED,
-			      struct object_info *oi UNUSED,
-			      void *payload)
-{
-	unsigned long *count = payload;
-	(*count)++;
-	return 0;
-}
-
-int odb_source_loose_count_objects(struct odb_source *source,
-				   enum odb_count_objects_flags flags,
-				   unsigned long *out)
-{
-	struct odb_source_files *files = odb_source_files_downcast(source);
-	const unsigned hexsz = source->odb->repo->hash_algo->hexsz - 2;
-	char *path = NULL;
-	DIR *dir = NULL;
-	int ret;
-
-	if (flags & ODB_COUNT_OBJECTS_APPROXIMATE) {
-		unsigned long count = 0;
-		struct dirent *ent;
-
-		path = xstrfmt("%s/17", source->path);
-
-		dir = opendir(path);
-		if (!dir) {
-			if (errno == ENOENT) {
-				*out = 0;
-				ret = 0;
-				goto out;
-			}
-
-			ret = error_errno("cannot open object shard '%s'", path);
-			goto out;
-		}
-
-		while ((ent = readdir(dir)) != NULL) {
-			if (strspn(ent->d_name, "0123456789abcdef") != hexsz ||
-			    ent->d_name[hexsz] != '\0')
-				continue;
-			count++;
-		}
-
-		*out = count * 256;
-		ret = 0;
-	} else {
-		struct odb_for_each_object_options opts = { 0 };
-		*out = 0;
-		ret = odb_source_for_each_object(&files->loose->base, NULL, count_loose_object,
-						 out, &opts);
-	}
-
-out:
-	if (dir)
-		closedir(dir);
-	free(path);
-	return ret;
-}
-
 static int check_stream_oid(git_zstream *stream,
 			    const char *hdr,
 			    unsigned long size,
diff --git a/object-file.h b/object-file.h
index 96760db0e1..bc72d89f54 100644
--- a/object-file.h
+++ b/object-file.h
@@ -96,20 +96,6 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 				each_loose_subdir_fn subdir_cb,
 				void *data);
 
-/*
- * Count the number of loose objects in this source.
- *
- * The object count is approximated by opening a single sharding directory for
- * loose objects and scanning its contents. The result is then extrapolated by
- * 256. This should generally work as a reasonable estimate given that the
- * object hash is supposed to be indistinguishable from random.
- *
- * Returns 0 on success, a negative error code otherwise.
- */
-int odb_source_loose_count_objects(struct odb_source *source,
-				   enum odb_count_objects_flags flags,
-				   unsigned long *out);
-
 /**
  * format_object_header() is a thin wrapper around s xsnprintf() that
  * writes the initial "<type> <obj-len>" part of the loose object
diff --git a/odb/source-files.c b/odb/source-files.c
index 4a54b10e4a..d5454e170d 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -109,7 +109,7 @@ static int odb_source_files_count_objects(struct odb_source *source,
 	if (!(flags & ODB_COUNT_OBJECTS_APPROXIMATE)) {
 		unsigned long loose_count;
 
-		ret = odb_source_loose_count_objects(source, flags, &loose_count);
+		ret = odb_source_count_objects(&files->loose->base, flags, &loose_count);
 		if (ret < 0)
 			goto out;
 
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 4b8d10bc87..27be066327 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -520,6 +520,66 @@ static int odb_source_loose_find_abbrev_len(struct odb_source *source,
 	return ret;
 }
 
+static int count_loose_object(const struct object_id *oid UNUSED,
+			      struct object_info *oi UNUSED,
+			      void *payload)
+{
+	unsigned long *count = payload;
+	(*count)++;
+	return 0;
+}
+
+static int odb_source_loose_count_objects(struct odb_source *source,
+					  enum odb_count_objects_flags flags,
+					  unsigned long *out)
+{
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
+	const unsigned hexsz = source->odb->repo->hash_algo->hexsz - 2;
+	char *path = NULL;
+	DIR *dir = NULL;
+	int ret;
+
+	if (flags & ODB_COUNT_OBJECTS_APPROXIMATE) {
+		unsigned long count = 0;
+		struct dirent *ent;
+
+		path = xstrfmt("%s/17", source->path);
+
+		dir = opendir(path);
+		if (!dir) {
+			if (errno == ENOENT) {
+				*out = 0;
+				ret = 0;
+				goto out;
+			}
+
+			ret = error_errno("cannot open object shard '%s'", path);
+			goto out;
+		}
+
+		while ((ent = readdir(dir)) != NULL) {
+			if (strspn(ent->d_name, "0123456789abcdef") != hexsz ||
+			    ent->d_name[hexsz] != '\0')
+				continue;
+			count++;
+		}
+
+		*out = count * 256;
+		ret = 0;
+	} else {
+		struct odb_for_each_object_options opts = { 0 };
+		*out = 0;
+		ret = odb_source_for_each_object(&loose->base, NULL, count_loose_object,
+						 out, &opts);
+	}
+
+out:
+	if (dir)
+		closedir(dir);
+	free(path);
+	return ret;
+}
+
 static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
 	oidtree_clear(loose->cache);
@@ -577,6 +637,7 @@ struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 	loose->base.read_object_stream = odb_source_loose_read_object_stream;
 	loose->base.for_each_object = odb_source_loose_for_each_object;
 	loose->base.find_abbrev_len = odb_source_loose_find_abbrev_len;
+	loose->base.count_objects = odb_source_loose_count_objects;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(NULL, odb_source_loose_reparent, loose);

-- 
2.54.0.926.g75ba10bac6.dirty

