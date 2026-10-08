Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5430B3E4117
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 08:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448585; cv=none; b=EGa0rQMBm4yhsc4STt+XoQ3T7yDk+HPruuDwutxxPfyRN7Blz9MnZ1TQfaBYVloYYqso/TqkaQOfNWbCRFd4FueCTb2Q8MX1QetidO6DgtFTkelKSJeT8DigtD2gHC/sEqQzPp/OdsRLJCKy6bE7lIWL+EJVcX5hXhjseyopjYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448585; c=relaxed/simple;
	bh=RphBW9bRmQACsiCH1u0C+2Q3Nh9UkiNhwi2PhlpDArY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TgyYE+A93uh2HTuLG8ZvzHNd0fRusssdbOORis0UdNTEGOSCsehUYbMuxGQKVef2cvwW0w2I7Q/130bahxMDUXsNH+VUCRfn/lTYOQWlniJ3cvMCVJGzywDNyLj4OlEzZd4dq+xXfWVllKTtz/K1sTaQjIibcC0YwjGe9QjpSkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=niAxU5pN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=digP8sS/; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="niAxU5pN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="digP8sS/"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 88A1DEC0053
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 04:36:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 08 Oct 2026 04:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791448582;
	 x=1791534982; bh=0ltLBAzgWP8Wd5+NVX8Uzc20psqX0CdT4XlsR7lInhc=; b=
	niAxU5pNaGJyIYTFIlgen6JEFEOB9fJuN9IztYVgy3kZ8LFiY1X5rARi8SH4weA7
	o6LDbGmVbhMDj6g8QShuiYEpVj3L1tfTTEOn0sK6+1hEtjh1v5MsShJBxQMKtRg9
	/hjlzZr/vD0zwb7c5cpeIiE8gbaQkLXMFmJVk+tKP60VNxbh2H5y3+09Gh8XetfV
	rfY1dXX3LLwO+UkMxHKooQ7LIEAX5a72kq3Jc0s/iNW0TvZb/p+DbJGMWzBnW3wO
	kGJxNOK+QcNoD8uksYwcknnXVGkIwfZnj7HoQaefZ6HqDGWVZKQBZm2USaF0we8r
	nVjgpeJAEaxFTLu0tLP0pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791448582; x=
	1791534982; bh=0ltLBAzgWP8Wd5+NVX8Uzc20psqX0CdT4XlsR7lInhc=; b=d
	igP8sS/T3HNNcNdKKhUdXkMvD+1iUP1ojZ+g0Z1lz2VfdU0JGy+5Q4+d3OIDl0JO
	PJlipm9YM6EGkrcowoIZ/1kk09pRjnKScAqWOYpx8E66nlKlBcGBRGagxKA3nwB9
	T8gQatnnkUECynufBZoIKIv2WtQNvMUSE+9aayBaZKYJZuIlGatZMrD9YzUDmGc5
	2HTMRwj3IKtlgqbzwTYZYwXjLbcxQk4eVE8n6MEMVUfS1T/Sm0191mkLV7kQPaWV
	LomfpvUUMCzotSwxQTMp+cEA7NFbSgHFrZZowLrIbzS4S0szS6PY8a1XLQ5Lg+Y9
	B2gouo2hw1Jg21CkEiS0w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791448582; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:vjvrWXwxPufRc8SIDcwwUIPc+L4HLvDytEJeHJ1WMsz9cyK
	sAUfhXLlq4GaMS655c0NO4RzWaw6mNZIelN4BBM1lWc6Gj9PNTSldU65J52NXE8W
	F63KBAzgZfaH3zJeFJ8+DHeC9I6EA6p3KwePcb40Kk1IfLPcM7z6RqJ6/spR9CnI
	E0LWGBnXa2op2Vk0G8yCCUwLonNs21x4n1MiOhoJcE/uo0dQY61nCiyKjwbWYzV4
	AUP7mn6Y8D5vsUKFF0uPzXDXsVnhCcOl6s7sF2uFe/ixGo7ifq2v5RGlYWTnfKnc
	w0x8m081osCTVOj7c+wkLSrFt7a6hBASkhh30Ow==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ya87j+IclI+DEpICG/AAM9gPfVXxlrjHDcNY/m0gBDA=:RphBW9bRmQACsiCH1u0C+2Q3Nh9UkiNhwi2PhlpDArY=;
X-ME-Sender: <xms:BlbHatSNT7quI48-JxgoBpChrH40vt-leKVIyzFMyNDfi9n4NXipmQ>
    <xme:BlbHasx6Tz2mCIvH5wkY8mwHlfRxtBJQV-djD5ZN89qG43XbfLViDFAkcR-1YYIEN
    8IynUpdVFCGBZpBf8hVSw1w0p6QedYPCr280OwZxzuVdC_0RmilKXo>
X-ME-Received: <xmr:BlbHageHg9PEzak9f9ZJnNSrDBojkDEvEtHv9-R82g3ZWC3e0SP_Ew>
X-ME-Proxy-Cause: dmFkZTEJ12PrM6lPkulG2HrVHQhK7W+nzWtv82fCmVg5Srp1vYOBsOZXk+3zbaSKR1o9q9
    zgaDeQtd8exjkN8iOx8gK+wWQ1lxo0Q9l5NbSN30f6p85fJAxnBnfB37gvWssqHY0VvvFk
    PiSqXLopWAifncYeDTw784/UzhaCYudHQhaoZVmElltXFrtbNxE9yoMHYjh+fC+7+cmO4F
    trDv6wR/hEYFDz8+qQNhsJOcx0mrPE3FW04oN9df+1q7n0ABLdhTxdS8UQHC0rVd1KtZxV
    7/37M0p9gjidiOzO6b0dZkeD/ejphFx+/vQQFlrVrQqcWyOiFkr2KBwIfyyln8WZPtNomn
    NemunNDErZCQilODSH0kzzojQ2xQBiaGnlxIyaxWWhQpLAbF7p9G2TYHx+zdQ8N70H9PmG
    2THijyO9DdotP4sDFKuBPmQzw2HlzxJ9x/JXT59uURJXidVy7diSBt7OKYA9zhrpGyPSna
    sk7kIBjk5LERZhOV1Zlfbq+CQFasw3gBsIv8vhDc4k3Pk5OQT9SreFyWjyByXQL7I2xbeP
    7BSTLoT301HU5cB6BFWYqtzlW8QzBGnSWIzJLMRsKIEEYwc/VCtYgeriSd7eV4E9sgPxom
    sn4DM52IiHNt+jWcbQP+R4vVNr7of7//5ucl/monGATT3o6QdbjkgJEJK20g
X-ME-Proxy: <xmx:BlbHagIRn-4RfLSXu3T5RMgK-_21dEf-U0sYNdMBno5lZOj7cqurkQ>
    <xmx:BlbHapGHoNYMgt-99E9UpKzKQ6XprgNoKQmybRP9CUjyHblyVt88yw>
    <xmx:BlbHairqafFmwO5CD01gZwdIj_d6Lf5u8E3ks-9jRQZnINQIWkIQbw>
    <xmx:BlbHaqQixxi36MFerI5p_5q-pZYBcL72jf0Fq-Ji0FnvuLvJTHA0Pw>
    <xmx:BlbHahBGwBsplEXmPn9a5P-7tuTzzs390GJo8jc7Pv7See6GGc_XWcB1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 04:36:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a025c802 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 08:36:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 10:35:56 +0200
Subject: [PATCH v2 06/13] odb/source-files: add the ability to have
 multiple object dirs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-odb-move-alternates-v2-6-b47e8189baa5@pks.im>
References: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
In-Reply-To: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

In a subsequent commit we'll migrate handling of alternates into the
"files" backend. As part of that, the backend will need to grow the
ability to handle multiple object directories for alternates and for
transactions.

Introduce a `struct odb_files_dir::next` pointer so that we can have
multiple directories. Adapt the backend to loop through this list as
necessary. In general:

  - For reading paths we will loop through all object directories until
    we have found the object.

  - For writing paths we will typically write to the first of our object
    directories.

This mechanism isn't used yet as we still only ever have a single object
directory at the current point in time. But that will change over
subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 147 +++++++++++++++++++++++++++++++++--------------------
 odb/source-files.h |   9 ++++
 2 files changed, 100 insertions(+), 56 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index e5e43b1543..9389546b3e 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -63,8 +63,15 @@ static void odb_source_files_reparent(const char *old_cwd,
 static void odb_source_files_free(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
+
 	chdir_notify_unregister(odb_source_files_reparent, files);
-	odb_files_dir_free(files->dirs);
+
+	while (files->dirs) {
+		struct odb_files_dir *next = files->dirs->next;
+		odb_files_dir_free(files->dirs);
+		files->dirs = next;
+	}
+
 	odb_source_release(&files->base);
 	free(files);
 }
@@ -72,8 +79,11 @@ static void odb_source_files_free(struct odb_source *source)
 static void odb_source_files_close(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	odb_source_close(&files->dirs->loose->base);
-	odb_source_close(&files->dirs->packed->base);
+
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		odb_source_close(&dir->loose->base);
+		odb_source_close(&dir->packed->base);
+	}
 }
 
 static int odb_source_files_create_on_disk(struct odb_source *source,
@@ -168,8 +178,11 @@ static void odb_source_files_prepare(struct odb_source *source,
 				     enum odb_prepare_flags flags)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	odb_source_prepare(&files->dirs->loose->base, flags);
-	odb_source_prepare(&files->dirs->packed->base, flags);
+
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		odb_source_prepare(&dir->loose->base, flags);
+		odb_source_prepare(&dir->packed->base, flags);
+	}
 }
 
 static enum odb_read_status odb_source_files_read_object_info(struct odb_source *source,
@@ -179,28 +192,33 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 							      struct strbuf *errmsg)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	enum odb_read_status ret_packed, ret_loose;
-
-	ret_packed = odb_source_read_object_info(&files->dirs->packed->base, oid, oi,
-						 flags, errmsg);
-	if (!ret_packed)
-		return 0;
-
-	ret_loose = odb_source_read_object_info(&files->dirs->loose->base, oid, oi, flags,
-						ret_packed == ODB_READ_NOT_FOUND ? errmsg : NULL);
-	if (!ret_loose)
-		return 0;
+	enum odb_read_status status = ODB_READ_NOT_FOUND;
 
 	/*
-	 * Reading the packed object may have failed even though the object
-	 * exists, for example because it is corrupt. Report this failure to
-	 * the caller in case neither of the sources was able to read the
-	 * object, and prefer the error of the packed source in case both
-	 * reads have failed.
+	 * Reading an object may fail even though the object exists, for
+	 * example because it is corrupt. Report this failure to the caller in
+	 * case none of the directories was able to read the object, and
+	 * prefer the first such error in case multiple reads have failed.
 	 */
-	if (ret_packed != ODB_READ_NOT_FOUND)
-		return ret_packed;
-	return ret_loose;
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		enum odb_read_status ret;
+
+		ret = odb_source_read_object_info(&dir->packed->base, oid, oi, flags,
+						  status == ODB_READ_NOT_FOUND ? errmsg : NULL);
+		if (!ret)
+			return 0;
+		if (ret != ODB_READ_NOT_FOUND && status == ODB_READ_NOT_FOUND)
+			status = ret;
+
+		ret = odb_source_read_object_info(&dir->loose->base, oid, oi, flags,
+						  status == ODB_READ_NOT_FOUND ? errmsg : NULL);
+		if (!ret)
+			return 0;
+		if (ret != ODB_READ_NOT_FOUND && status == ODB_READ_NOT_FOUND)
+			status = ret;
+	}
+
+	return status;
 }
 
 static int odb_source_files_read_object_stream(struct odb_stream **out,
@@ -208,9 +226,12 @@ static int odb_source_files_read_object_stream(struct odb_stream **out,
 					       const struct object_id *oid)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	if (!odb_source_read_object_stream(out, &files->dirs->packed->base, oid) ||
-	    !odb_source_read_object_stream(out, &files->dirs->loose->base, oid))
-		return 0;
+
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next)
+		if (!odb_source_read_object_stream(out, &dir->packed->base, oid) ||
+		    !odb_source_read_object_stream(out, &dir->loose->base, oid))
+			return 0;
+
 	return -1;
 }
 
@@ -223,16 +244,21 @@ static int odb_source_files_for_each_object(struct odb_source *source,
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	int ret;
 
-	if (!(opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)) {
-		ret = odb_source_for_each_object(&files->dirs->loose->base, request, cb, cb_data, opts);
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		if (opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !dir->local)
+			continue;
+
+		if (!(opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)) {
+			ret = odb_source_for_each_object(&dir->loose->base, request, cb, cb_data, opts);
+			if (ret)
+				return ret;
+		}
+
+		ret = odb_source_for_each_object(&dir->packed->base, request, cb, cb_data, opts);
 		if (ret)
 			return ret;
 	}
 
-	ret = odb_source_for_each_object(&files->dirs->packed->base, request, cb, cb_data, opts);
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
@@ -241,21 +267,23 @@ static int odb_source_files_count_objects(struct odb_source *source,
 					  unsigned long *out)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	unsigned long count;
+	unsigned long count = 0;
 	int ret;
 
-	ret = odb_source_count_objects(&files->dirs->packed->base, flags, &count);
-	if (ret < 0)
-		goto out;
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		unsigned long dir_count;
 
-	if (!(flags & ODB_COUNT_OBJECTS_APPROXIMATE)) {
-		unsigned long loose_count;
-
-		ret = odb_source_count_objects(&files->dirs->loose->base, flags, &loose_count);
+		ret = odb_source_count_objects(&dir->packed->base, flags, &dir_count);
 		if (ret < 0)
 			goto out;
+		count += dir_count;
 
-		count += loose_count;
+		if (!(flags & ODB_COUNT_OBJECTS_APPROXIMATE)) {
+			ret = odb_source_count_objects(&dir->loose->base, flags, &dir_count);
+			if (ret < 0)
+				goto out;
+			count += dir_count;
+		}
 	}
 
 	*out = count;
@@ -272,15 +300,17 @@ static int odb_source_files_find_abbrev_len(struct odb_source *source,
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	unsigned len = min_len;
-	int ret;
+	int ret = 0;
 
-	ret = odb_source_find_abbrev_len(&files->dirs->packed->base, oid, len, &len);
-	if (ret < 0)
-		goto out;
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		ret = odb_source_find_abbrev_len(&dir->packed->base, oid, len, &len);
+		if (ret < 0)
+			goto out;
 
-	ret = odb_source_find_abbrev_len(&files->dirs->loose->base, oid, len, &len);
-	if (ret < 0)
-		goto out;
+		ret = odb_source_find_abbrev_len(&dir->loose->base, oid, len, &len);
+		if (ret < 0)
+			goto out;
+	}
 
 	*out = len;
 	ret = 0;
@@ -294,9 +324,12 @@ static int odb_source_files_freshen_object(struct odb_source *source,
 					   const time_t *mtime)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	if (odb_source_freshen_object(&files->dirs->packed->base, oid, mtime) ||
-	    odb_source_freshen_object(&files->dirs->loose->base, oid, mtime))
-		return 1;
+
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next)
+		if (odb_source_freshen_object(&dir->packed->base, oid, mtime) ||
+		    odb_source_freshen_object(&dir->loose->base, oid, mtime))
+			return 1;
+
 	return 0;
 }
 
@@ -958,11 +991,13 @@ static int odb_source_files_fsck(struct odb_source *source,
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	int ret = 0;
 
-	if (!(opts->flags & ODB_FSCK_FULL) && !source->local)
-		return 0;
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		if (!(opts->flags & ODB_FSCK_FULL) && !dir->local)
+			continue;
 
-	ret |= odb_source_fsck(&files->dirs->loose->base, opts);
-	ret |= odb_source_fsck(&files->dirs->packed->base, opts);
+		ret |= odb_source_fsck(&dir->loose->base, opts);
+		ret |= odb_source_fsck(&dir->packed->base, opts);
+	}
 
 	return ret;
 }
diff --git a/odb/source-files.h b/odb/source-files.h
index 77f4d842e0..36af0c1b8b 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -15,6 +15,9 @@ struct odb_files_dir {
 	/* Absolute path to the object directory. */
 	char *abspath;
 
+	/* List of alternate object directories. */
+	struct odb_files_dir *next;
+
 	/* The two sources derived from this object directory. */
 	struct odb_source_loose *loose;
 	struct odb_source_packed *packed;
@@ -36,6 +39,12 @@ void odb_files_dir_free(struct odb_files_dir *dir);
  */
 struct odb_source_files {
 	struct odb_source base;
+
+	/*
+	 * List of all object directories; the main directory is first (and
+	 * cannot be NULL after initialization). Subsequent directories are
+	 * alternates.
+	 */
 	struct odb_files_dir *dirs;
 };
 

-- 
2.56.0.406.ga2d225a756.dirty

