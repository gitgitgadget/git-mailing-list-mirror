Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F9D4734F7
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935727; cv=none; b=aouZL8mN3yy0HrLctT51tbi2603aTqZxIy5SpT4z1lp6vCHeQA0GT/obtEVaCrPLDd3FW8zqpth+Z5UFQ66Kkr0LIsR5pxUjU480MyGuzfY3GsdvbJLfK79dWAWoHvVlhOHkgPAJfedle5d+QaYR3q/s421bLb5KUgauUYcUHT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935727; c=relaxed/simple;
	bh=v51ZEP1VQknjf/cOb26LGVyCvMBTOTQKldGyVoC9uuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KR+mVgGhqwr0e/ewLGEgpb/vsfGtdYgTzu/Ko80RB1sp/jDZchxDSnScyY7WDMuOTeXcqvrZZ/rKGd6Nm5JuVIOv4DJSID/YlvW6X2CScHJkH5Nbpw6Xixj4UtIOdj8EobhQq59AWjm/18qYSIp7cBPEPURnd2Xc4EGfgTDLdbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h9eLrT+H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CewMttvo; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h9eLrT+H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CewMttvo"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id F2CD9EC00C0
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 06:08:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 02 Oct 2026 06:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790935723;
	 x=1791022123; bh=iD+RGcdn2dM+RvicakSkroORgjKC22AcZyztRjL4Jdc=; b=
	h9eLrT+H2gO1fVX1JV35AkqdLf1wywGIQF3YNW+WFsZ4E080mOpoWc8ufVAs3CpJ
	vGOS/muY+nleaYHsYh1mYeXCswsc4OekkSv1GVI5d/9mGXFQNVawauFlyBgE8pKf
	/KIb9Ju+J1ds1LdMktYHypH/qU8uQ2Ac84DZF9vnc/FlgSVwRvGsfABG1hUTGRaL
	4HBAB8W/5lr8X0RqMYtaPFmkheMK2IaqDrYKDQnV7uXHigVxUYQu1iqr0q+tGbz+
	jeMrPwFZZE/eUJHy6dek0Hq6Soba5I81vcf1/kcsnHae8GrNe9K//IGHBCsZweTY
	8g35Q6mjRJY4JpS9dRdC3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790935723; x=
	1791022123; bh=iD+RGcdn2dM+RvicakSkroORgjKC22AcZyztRjL4Jdc=; b=C
	ewMttvoXATf/jx2m3E/M4oDnmIYv5Yeu+KL43aRr7QVAoxQb61PUFmvCJ6jsC6dS
	JnIjy9q9FXk03dDjBGVJUptpWDJeUpgPpc+T/JV2iR7wyjLz5g4TT9TIsGU7js3c
	zEK20BrUcbJ8KybwugDSNMWqTth2nnLqvRWEjuNw63059cR6GtDbiEnKLMlzhXDK
	wJmcMXRjHAdZ+7EZm7VRyfUz/ONZ16dnjIZSK1jkBf/9DOX5Luuy6qnbGOsmZxvC
	5KW9U/LnD06f7m1dA1Fd76XNFqbu0SMxjKHKvXgnNaIOOjUCdbvO0c7NA73Ct4Z6
	ftYliTprImyYiT/CDl4bw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790935723; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:CNv3KKcw3IGqX+ya5hHKWoGSRk101uO6wcItvmeJSXW2hq7
	XL4u0bYTZBdTulKeu5c2/p6B9yaYfYii8zzVj1LGPLC+mwDHE/SM9E2oynVQtOi1
	im5Skr3kDicr3sMRouDnYcO3F1OpunBWFHi+3OzsjqrAZO+vRN7IqaCxnI0axQqT
	7uHHA9G8OBuhQ1fhuuwyEsbeE/A0awGNe6qaQ39N1rhTU972am1EOPZ61awLl4hd
	hG3DQX4BzMXi90dGoLNPTrkF8RZmtA2xc0WpGof9+H6oXLc0uq19IA34QPmcEEWG
	i80B1NeGa3KSXRwD5GWJJdFr12k8ovzpxAKTfMg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yPikH3WKmzuCzaEv1UgSi2t2vhqrfrZieWsgQ+2rr78=:v51ZEP1VQknjf/cOb26LGVyCvMBTOTQKldGyVoC9uuI=;
X-ME-Sender: <xms:q4K_auJI-f2Q0vhNBdwGt-8q9pji1j6p5Pe4n6KAHom-N5fUxt6d_g>
    <xme:q4K_atEol-2RlAom61BnzUidvNT0ciZsAV-tAPkv3bDrGTk3sP33f2GR2qazZcCSL
    PQFtVf6bwTRsmNnfBquu5hFpEe1SXh_gUmbXOdOY59D4k6al7_OwgU>
X-ME-Received: <xmr:q4K_akWS1lLaCHRkclcW26ZJ3S3vfR8dQecnwcuBuaBoqhpTTibKvg>
X-ME-Proxy-Cause: dmFkZTF34l82022tRH/XgLve1GnCAagsK1/sNQ03J1wZMCaKRfCFCANyInDwpxNlKo26XL
    EXnDaIhvf6eeyj8SFpLxHe7kMLyAMTddf/VH/Rk//b+JdUzKpEnqhJ/mj6T6WBc3r6ZJE/
    Hr1v675783mYwdLtIr+rwnhjt9V2Sg0kW0Y2Oh+akYz5iWsSjkq3O4mWIO7qqzL2LqWlBu
    4qb3Nz76srjHiKLX7WGKMZWL03bhjvTx5w07iAecZ2+wGDzrZnOrFMya6obWUIWKlk9RXi
    ATp2I5KNGIOri6x7B1ZipZsHWqVLLL4aev/pKUNaysgOv1nDj7mFcdqRSD+T2EP7frLRXj
    4WmnIc4EnaWqjA/LgA/PawCMV3B6cNE/6kkysKbPySBPPSM4S39t+1cYEOcsYMrErr9L4a
    T+zGxIJ2Vwj6oukeCBvU5zk20SoGLYsDehtgE4ctwW3oOmSAHTh51kdpShtEfSlY1lTNTX
    AHATerGVuMMSWWlyvFKlfQRi6fi/C+ZFyUXctvdxz13TcZTRsNdwT8LPe7f2O9r1GMWpD+
    5IgOHsLwrCqzVoN5IAIYhT5fRRXQMUxfMk/vhhBZJi25BeLESxuHOK5rlvJCsuGxgfzFxe
    MT3K3fl3xqHa/U5lr/sPm0IrTE7uLH7fxl62JCPJ3MKvax3V8wReB2wyY4bA
X-ME-Proxy: <xmx:q4K_aojG1yJ2334P9BRn66CViuhy9kk9QqF528MvZm_AOWX4qnHd7A>
    <xmx:q4K_alStwkjH7eJlwdXQv8eMJKvEurrblpLL5vqlOpBe_eCE2ltqrw>
    <xmx:q4K_arExuEVMTQ2YA2qEV2PK47lZ4QTDe3p2jIe_5Jx4lKuCJ3qRbA>
    <xmx:q4K_atk3PYgHmWWBo976ZTpO210X7qEIVkLyXK6qNJu2ApHSdJ1HwQ>
    <xmx:q4K_avrH6t8JRmFEZllLRYMdYcTkkdnYUWKPJu9yE7c2qgppzmsWkjDq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Oct 2026 06:08:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ce59bc48 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 2 Oct 2026 10:08:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 Oct 2026 12:08:17 +0200
Subject: [PATCH 06/13] odb/source-files: add the ability to have multiple
 object dirs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-pks-odb-move-alternates-v1-6-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
In-Reply-To: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.56.0.379.gc618271300.dirty

