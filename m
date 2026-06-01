Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D66389111
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302057; cv=none; b=DNwcr9Nx/kDYhq+gia8eekB4wqX938SV52nPNMAYZfiSZzDTri2yxuhwlMdXfgjUzT2vJ0rnMPtzwf5pmrKwdZNisIe0XIhpi8QVArgwym7bFNCaI8AcHEKbe4BdOz2pcmtVSbzFJ3b0L47Myvx95bXolY3Ts5wrI5x0Jx7lGPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302057; c=relaxed/simple;
	bh=o/vUP1VrpWIBianHDkBEcMYIqNxVPMEexFkWyRwqsdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQ4IFySG1YpnuV5fnRa/CXshQAj07GTiZyDLZIroSzXvCzKzI9EUiWgmMbqHayypbFVUTYgyES90EnYfQfSsGKr9ukeFzWQeqG0rJobYRuuVmdNjV1fc12dp0gqoOtF0gDzvjRsiK255S+qKeJTBEHLev0JvdcDoCjdrUq14Er8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MeZRTN7m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g0pDywVD; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MeZRTN7m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g0pDywVD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F9AFEC012A;
	Mon,  1 Jun 2026 04:20:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 04:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302055;
	 x=1780388455; bh=bnQCUeE3olnmr1nCx+smYyw1PCShZSKEx4YURev88TU=; b=
	MeZRTN7mQESBnlSaY3I7v7rA/5qwEtMK/2VPyIoULa2+euRJY6x7TJRKE7Jg93QN
	V5xfXneE2TONQ5KwMM1cGas5OejSuKkFhgDXc3TVqAHtDsXmxdU8tv4jO6n7C84V
	2NYtIFEUcA7N0G/W8Ip9rk3GbtuzBAaG3MBL/jHEMqWIdY6T5f1aUpR0+NBFvKUe
	SXhRBdmHkG0YQOWRZ+t6Yz3w4yCHtRBB4AGE45LFYttXEYB5PHlwDFT+jWe5nV7n
	5u7l+WH13JJQ9t+F+iNFFCMOd0i50WDUBtmFFRLsnH+4biBr4GjSw5zwqYy/5v50
	VUAMrZgSTKbbiifSXxuekw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302055; x=
	1780388455; bh=bnQCUeE3olnmr1nCx+smYyw1PCShZSKEx4YURev88TU=; b=g
	0pDywVDiIv5swf0JveK9j9CAe/4fy0jxvd5If/HYcHzbmocyx7rycolOHM5ESNrO
	kqGOyyDiGVzM1GSggrlNC0RKZ3wxXEwX8zKkwLQRoceWTVJTM9wBtz7vMEczETsI
	kIdx57+4QD3R2UWA2xVf+Pdn+BRzm5mP7jC5XJ7mXXcB0x+4B4Dqb1OJZYkTSDoD
	vGVukaKPAKhttwUeoos3k+U9yl+wvS/aiRPaRkr/g7w6SXOFDZrc/BHr5zyFYu9o
	b7osAXxRi1yhLwzbGRv2B/TMQu7KwOKEo0BNILOxSQGXJ2tu3KJrzbS2G9DmYiI8
	e14JDj/86Lnz7kT2l+6QQ==
X-ME-Sender: <xms:50AdatO1QUTUWpd6cYax0LpDbZ0Aokoo0v1l1af4QXslu2eCiUzJzA>
    <xme:50Adal-cbYqSZEguoXx6DsqHBybgmbWUcsa5D5kElayBCu3nWwEzZa3pn73eAnoPq
    1cvvQZtS3L-8fw9m02BGisuTrFhEXD3Z26MaqVNv9tUmifLyoghaxs>
X-ME-Received: <xmr:50Adap7kBSl6WIjnu9pB7lH38WorFSqCPqgSvpdsCFk1jVhTPr6sXhXad0v2uLsN0W4YCrk2g_RLYsKkaPOyhXUSWGIiQGXUzgZvUxzt0qvo>
X-ME-Proxy-Cause: dmFkZTGAvlr99fUPh+wq8DbP5Cv/432DAL8bPUQuEcMRYS/J8sF6SFSZRAu6b8+hkicYoi
    NaMUjkAT2RF5/+7ujsGJEEpzmys+Rmzvyxg3aWR994GZyEUUhg3Ly4a9caaplqsvUH3I3C
    ElGsi0gkv1W/ITHo7Xm80XQntzH7UIVhL+I8XRwQu1IFXxfKMyP+V2E2/CLP3HRpCql+AU
    tj8YI43L3w9/105WKmU4+rC9s91Ywak8RIWY2boAX4JfkGjpq5n5J6mjzIvfTmFRZLoi18
    xDbtc7Qc+3nHUfgXbLC5kTFNu1aIYFyKoVbIA7+PKXz4TGx/JwiUm+ZA5lkCoPc3pa7qht
    KZDSAPIWa6e7MkxcqwI8OfT39bUGM06TqNTP4l//V0pFR1hYahNdBcoRu/8TNaBvg7VPuI
    luHznmHvKeJYtwUNcm8oaQeIMFh61DdKqnftE5W/tC26OWvol7UafVmEtcA9HkkKbc6iFb
    xSQ2cQ2XWr9viMJI14aTwselzQV3RUjZanwCiCik+nLx3cUnfoZD3hps/nLRAr3RDFJGjr
    UoBV++4mzqR7ftuf7Dq2CUdZTKr02duWo98fn+tv1tWxzeKU/9HprODBSDRzytcd1LKyQz
    7HgN3zfXX/MJNYv6LoEzSFvWshrTLYeRjAZK+hP0rkCzBaQ38HpvlH9QhFxQ
X-ME-Proxy: <xmx:50Adak2UarDiGk5ivt3OYO6fKvtdZILi5W1H3l74r05gEYht-dlXrw>
    <xmx:50AdaoDQYEUOkY3-Uu2c_oapvycffVD5cdJ1B3M2iho4-cv-6VczVg>
    <xmx:50Adau2xI1k4kelCzPPOer0dEzwnqUw4JGHbNQ3RZjlOrCb5oUjciw>
    <xmx:50AdaqtiHm5gDmk_od9bDViv9Qn9b5xOAul2jz3etM1VHqCwnjPBfg>
    <xmx:50Adaokp_f8jOrdz16sdM9wr77Ikrs-hsD8VH-i6lzR6nHpEbrc8myJA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:20:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 93165d19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:20:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 10:20:33 +0200
Subject: [PATCH v2 10/18] odb/source-loose: wire up `count_objects()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-odb-source-loose-v2-10-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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

