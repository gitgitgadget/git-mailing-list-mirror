Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F34481FCE
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667171; cv=none; b=FB3nqGaOFcPxoqbSj2/N5Ksd0GB+cMUvfdu+5TuTHhiHXqrOn+sgjeUf4OUsqz3OFWaM8c2W3guNEhnSF2Ul/rOETd3FZa/j75U83DfgJQXCPCrUpg5fXN+TQ0xDBAeXCnZjuS5umtuNrlZVXphPltRKlCMxiA1g/DGZ0/KopxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667171; c=relaxed/simple;
	bh=KzbQrlhoM5O6r+LdfvKx9zNgnuhrXOCdF1ZpuYwk+2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bd6AvOz+o8cnH/Ihhgae9pA9u87xr65ZkY2+R6m8OLhDj4iKcbI3Fk9bDnk42LkPUkW08RGgEcW8f/WxTtvdLWOs4Q/fuJnrvzirMl4KzTlIVLk8Vbl2YAQlZ9TYKVp5fFJXKCEPE4jtgx+3qaz/OV+Lj3SPB09JP327MAqyzKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YopyeKP9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WUPWbZk4; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YopyeKP9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WUPWbZk4"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 033911D00046
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:12:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 25 Aug 2026 10:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787667168;
	 x=1787753568; bh=PgfzmaBMrkP9Wooo18RvwN1L+Do5jMAp4Lo8MmisTUY=; b=
	YopyeKP9wLW4xcZYbCdZfaNJeNBWi2Upg/ktMB0GSLbe3WpEzljFHCF5bX8wedfl
	L+xQ+Rf8WyZ6CK1USM37A9a0HSXdtLOqlWqGg/oI/aMHPkcG3hCbNTRr7N/9GtdV
	eO/zfmA7XCl7MUH728VK90FfXPUYSBjWhT4KKpk7mNa0dseSfK2JaSGyxP+a+WJd
	GKnTnFp9DZSI/3hovUapk0uQwef2FeSdY2Bc6ErPboyNcegVcH8oeLZwvFFe6fEX
	qdrFTWBj1A/TOOaJ0X9PKK2ILPQXapXzanAgGkfMNHiBnsKO2gmAKYB1hYgenI0U
	UmQWyS56SHnn9hBZ/3d3QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787667168; x=
	1787753568; bh=PgfzmaBMrkP9Wooo18RvwN1L+Do5jMAp4Lo8MmisTUY=; b=W
	UPWbZk4LgJvTGTe05Z6qhiSlKkRyLsChGsRrVFxm7MI3CcqLMA5Ze50thxtrnPWb
	nSmE6/D2KIoDoMDUOKNOOHBJ0KUfq7BVe3NnvSyspacoVJPXvMoXvmCwO3qiX9GD
	6291wJ9gb4ybkZ6gomd3xROX48CGLCg3M9FRc1VaEoffk7wr9lvmuvERjZX8nHyv
	QImHim3QhntoWKTPd1S8PbBWhWOaQXt4680QH9TZTEdY4SiUScfM638JG19AgBgS
	kQyxK5VuMhw4Q5Bxhrfavk+2Cn0ht2R16YwbgGRC/kZcP9moA9lTVDQnzzymmukw
	zU+U6YOb2Hs7njnoEygEQ==
X-ME-Sender: <xms:4KKNakR1e63O-ZBkwU_BhEow8057DN4Ekxrb_9GJtim2ucPZktWyYw>
    <xme:4KKNaosaPILN2kvoE3DHLY1TBxVcKvqMRJ99rhIo4OdIDB6xlm0sUN9nfoTOPtQUz
    Q8e0tnOnJvBQ7-qSVbXUMgxvfq9u3NCJJV7Pgth2fLWQc_12O6eRg>
X-ME-Received: <xmr:4KKNaneatvGc6f9dQnR8AEbYPooeVkI2Hnqe47ZycGj-GQ-sefqdgyFgTfbKKqf_hd2YvTuFd67Ug5l1nlsAI2eEUGjazU6XygtFsCeclA>
X-ME-Proxy-Cause: dmFkZTGeb4bxLdeGsZIHwBpNvHkBYVFqb0gPBRFQdjclKFZL9iepAsMrQPToqlL/TKVr+q
    N4zotQK8qWu/iZbZxMh9T+enbjab8RTI96+ANj5zdevsOZpx/k2kbDA/Ezij5R9InemX2I
    ieATfXIkvh0YiRX3YRriT1epVXzuvh+X9pcDU66Ymz3EVbvLlj2rZKEI0CELpv6/vw7ah2
    elZ11v6nTiFLLnUx3cpsB978r+ZIEPLEKCBDKbZEAm79gm+cy32vgIs/g1+gOLXs07WJ70
    65IHgmKSzOBkB+IYs7mYVzgUR2wQOS5+Tr0YSbucb929Tar/yOh4FpTSqzhx1xlgLk0GZR
    NgShsdssvGsTVBC2QYhERW//F9XLyHZkYxVE6jmdeDWANCTiSxchVxcCLfQW5VWkZWiOqD
    8GWWNgScTI/0FVYmW5LioIf9kTkmE+Sr5aAMF14J1NKTpKUqDkQCA41jv9BRA2ZeGyh0Rj
    atxH6Agr75zXQbQzV8nb+fJGOd91eTXIu/VHBdxkzBFzWuczvHRKKlewdtsatV44lt2CLm
    2dNW7SdoPJ3fgviKsdWsocnarUVTHnNBVt94i508VAruH90aJazr0R94TvdWz93IYGnvbb
    pG66t6LAsWToXdCg2x3auscGoAyEeJ7+1CMVmYlbNlKLwo9W/r4BwvIrzuSg
X-ME-Proxy: <xmx:4KKNatIvsPnNFHKNIdJx2M9-9OP-eOLUIjY30bKY758E1bR6krZAWg>
    <xmx:4KKNatb9t226OwZCYxEvbYEyt7YdJ94lDZyjfGEodIBgJsZTIP_AJg>
    <xmx:4KKNagtFWFxP6De7_Fq_Z4cOWNqMtPb2GIE2Z34fL7b3B8A8gI0flQ>
    <xmx:4KKNaitRwN62LSQLxeS1-85jn7LJX4aldlPO9SrkzS5YC8YTDmzL5Q>
    <xmx:4KKNasQXOJOIG55FR9zqjm2TSqRAadNM4ewxKE-Pho23ZEW_3cu2G1SF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:12:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b87bb7dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:12:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Aug 2026 16:11:55 +0200
Subject: [PATCH 6/8] odb/source: support writing alternates when creating
 the database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pks-odb-write-alternates-at-creation-time-v1-6-911513ba95c3@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
In-Reply-To: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Add the ability to write alternates when creating the object database.
This change allows us to remove the `write_alternates()` callback in a
subsequent patch.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 odb/source.h       | 18 +++++++++++---
 setup.c            |  4 ++-
 3 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index b7b3a297bb..5e77b21d9f 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -18,6 +18,7 @@
 #include "run-command.h"
 #include "strbuf.h"
 #include "string-list.h"
+#include "strmap.h"
 #include "strvec.h"
 #include "tree.h"
 #include "write-or-die.h"
@@ -51,9 +52,14 @@ static void odb_source_files_close(struct odb_source *source)
 	odb_source_close(&files->packed->base);
 }
 
-static int odb_source_files_create_on_disk(struct odb_source *source)
+static int odb_source_files_create_on_disk(struct odb_source *source,
+					   const struct odb_create_on_disk_options *opts)
 {
 	struct strbuf path = STRBUF_INIT;
+	struct strset seen = STRSET_INIT;
+	struct strbuf line = STRBUF_INIT;
+	FILE *f = NULL;
+	int ret;
 
 	safe_create_dir(source->odb->repo, source->path, 1);
 
@@ -64,8 +70,71 @@ static int odb_source_files_create_on_disk(struct odb_source *source)
 	strbuf_addf(&path, "%s/info", source->path);
 	safe_create_dir(source->odb->repo, path.buf, 1);
 
+	if (opts->alternates && opts->alternates->nr) {
+		strbuf_reset(&path);
+		strbuf_addf(&path, "%s/info/alternates", source->path);
+
+		/*
+		 * The alternates file may already exist, e.g. when it has been
+		 * seeded from a template directory. Read any preexisting
+		 * entries so that we don't end up writing duplicates.
+		 */
+		f = fopen(path.buf, "r");
+		if (f) {
+			while (strbuf_getline(&line, f) != EOF)
+				strset_add(&seen, line.buf);
+
+			if (ferror(f)) {
+				ret = error_errno(_("unable to read alternates file"));
+				goto out;
+			}
+
+			fclose(f);
+		} else if (errno != ENOENT) {
+			ret = error_errno(_("unable to read alternates file"));
+			goto out;
+		}
+
+		f = fopen(path.buf, "a");
+		if (!f) {
+			ret = error_errno(_("unable to open alternates file for writing"));
+			goto out;
+		}
+
+		for (size_t i = 0; i < opts->alternates->nr; i++) {
+			const char *alternate = opts->alternates->v[i];
+
+			if (!strset_add(&seen, alternate))
+				continue;
+
+			fprintf(f, "%s\n", alternate);
+		}
+
+		if (ferror(f)) {
+			ret = error_errno(_("unable to write alternates file"));
+			goto out;
+		}
+
+		ret = fclose(f);
+		f = NULL;
+		if (ret) {
+			ret = error_errno(_("unable to write alternates file"));
+			goto out;
+		}
+	}
+
+	/* Reprepare the object database to activate alternates. */
+	odb_reprepare(source->odb);
+
+	ret = 0;
+
+out:
+	if (f)
+		fclose(f);
+	strbuf_release(&line);
 	strbuf_release(&path);
-	return 0;
+	strset_clear(&seen);
+	return ret;
 }
 
 static void odb_source_files_prepare(struct odb_source *source,
diff --git a/odb/source.h b/odb/source.h
index ea8675247e..86b82fab3b 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -5,6 +5,7 @@
 #include "object.h"
 #include "odb.h"
 #include "odb/transaction.h"
+#include "strvec.h"
 
 enum odb_source_type {
 	/*
@@ -26,6 +27,15 @@ enum odb_source_type {
 	ODB_SOURCE_INMEMORY,
 };
 
+struct odb_create_on_disk_options {
+	/*
+	 * Alternates that shall be written into the newly created object
+	 * database. Whether or not this option can be handled is specific to
+	 * the backend.
+	 */
+	const struct strvec *alternates;
+};
+
 /*
  * Convert between the enum and its name. Returns the equivalent of "unknown"
  * for unknown types.
@@ -106,7 +116,8 @@ struct odb_source {
 	 * This callback may be NULL in case the source does not need any
 	 * on-disk setup.
 	 */
-	int (*create_on_disk)(struct odb_source *source);
+	int (*create_on_disk)(struct odb_source *source,
+			      const struct odb_create_on_disk_options *opts);
 
 	/*
 	 * This callback is expected to prepare the source so that it becomes
@@ -356,11 +367,12 @@ static inline void odb_source_close(struct odb_source *source)
  * Create on-disk data structures that are required for this source to operate
  * correctly. Returns 0 on success, a negative error code otherwise.
  */
-static inline int odb_source_create_on_disk(struct odb_source *source)
+static inline int odb_source_create_on_disk(struct odb_source *source,
+					    const struct odb_create_on_disk_options *opts)
 {
 	if (!source->create_on_disk)
 		return 0;
-	return source->create_on_disk(source);
+	return source->create_on_disk(source, opts);
 }
 
 /*
diff --git a/setup.c b/setup.c
index e654e27d05..426cc7dff8 100644
--- a/setup.c
+++ b/setup.c
@@ -2649,6 +2649,8 @@ static int create_default_files(struct repository *repo,
 
 void create_object_database(struct repository *repo)
 {
+	struct odb_create_on_disk_options opts = { 0 };
+
 	/*
 	 * Create the "objects" directory in the common directory. This is done
 	 * so that the repository can be discovered regardless of the backend
@@ -2668,7 +2670,7 @@ void create_object_database(struct repository *repo)
 
 	repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
 
-	if (odb_source_create_on_disk(repo->objects->sources) < 0)
+	if (odb_source_create_on_disk(repo->objects->sources, &opts) < 0)
 		die(_("failed creating object database"));
 }
 

-- 
2.55.0.822.g20453c30eb.dirty

