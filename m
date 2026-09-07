Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A53643E092
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769568; cv=none; b=nBy/NG3rWOlATbCmHHR7Jat/o6F7uw5aEAoIMCp7f15zyzmxxySuuPUbpXAcjsjtH0fX+MIYYl6AolfW2mLmwdo8uzpAAJzdYXKqhXmEDV9MFLvm6lTtmS0Cdbgb89AeIQOD9PhSpGLk9MdyowMHzw6NdzmzPDt/H8cMoua9Joo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769568; c=relaxed/simple;
	bh=6g6epBVxJQ2RDNnjvrbZXQWyhM9VbnMubjZPczYlO7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LGVEwHbT8tYDUBV0f2caO/1spKi2/RXQt2L5WXvbpUTe5iDrHljC0MWbO1IsKwhMgixy0O+ZOER+7RgT1g8VLjMHHhsJvu3c+KRSAvq6sZuRDo++87hy4aqkoPd8HrVBWjKKtXSpN3lO9Rp5BhWNodC8uAA0QCKCK4wbURRTJhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q5kcaAmM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W1RdlpO0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q5kcaAmM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W1RdlpO0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 63514EC0230;
	Mon,  7 Sep 2026 04:26:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 07 Sep 2026 04:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788769566;
	 x=1788855966; bh=x7ry43oNwcGo9JRaGctk4L8Uz7EeRBgLX73h4yGUddE=; b=
	q5kcaAmMzV7xfhexPKChtHsSlT7/PB9tZHy50JbcagbjngF88X+hY/KUVA4hsuJ+
	/WcB1mWQQM35Z9D6xIPs8xx+6fFAU+sOjEmcPe+/HHCq8ZxxZIBGYoe8w/IOoATO
	sqGyLyo0ECTUmY7T4auR4/r13FQD1fUen0MZpKrjHqDG3ZR6gjlJOc3mpwYSiBX0
	CGsNPdmkaLmk2RHq+MJIkyzQDHbVsQj9Ch7kRIK1wJvliyeSHvsEJsXQcvOlbzHG
	MwBGKdyX+YMMK7T6K1QmcL+bCrG0/rR+t1FBNDDOzlPHrID7jHw6Lm+OXmU/rIuI
	6NTnRIH9EfLH8uSIcAIcEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788769566; x=
	1788855966; bh=x7ry43oNwcGo9JRaGctk4L8Uz7EeRBgLX73h4yGUddE=; b=W
	1RdlpO0J5imZESSb1rKK+SSfyrsRK+OOV4N6Ads/FtShNkyxNxfZZkClbLN7gr8L
	4NuXrEyhvadLBgcc7H3hfr08dm6AP8ety49B9/6HfU0uH6V0CC5ot3hbKN2PcHPE
	Fufso04KYYMCH7tz441hBSZcbNwEt+85UNzh9UuDlJvuv2FgxAyB8AyO0BCy/MAm
	H1+fVNdeQrYfFCDjO+umyr0MwPAf2Dpb+uPt6JO/pNVbNfQtwSYsJcI2azHSbKPB
	Z43tElGoHYftXiFahpD6JuogQJolN+FSawzS1Od5FuT0qaB/tXVii3qIf+rUtK9m
	Fl8ZGlA5/eKCY8zCT+lpg==
X-ME-Sender: <xms:HnWeapIzMIsptMbh_cc2RQVCmBqVrMO3AH3Lex0kfk4zd-VDS7aTUA>
    <xme:HnWeasLhoRunjyfZFlZeuMSN__rtOPhs1yVkJQYEpfJmTtReBqrVpiDwwhW5aVwkj
    kwlauJIYijPQb_dHAXchWD-3HNoPQU1vKPCZczepAS8mE8R35T4Qw>
X-ME-Received: <xmr:HnWeamt5g_1ddspEo5zvI4h-nrov7HpwnRzzP6o_NviDFkkl7SYvUg>
X-ME-Proxy-Cause: dmFkZTEKi7Tq2gM9kI04RZ7AxwxWYGlFfv7IpMvr6TFJshIykzk8cWZwrnl2r9BRAgYCGF
    svyVZ24paJqQTflWYnS1XUi6nxhcg5aUaz3lDZ4sP6CqkSSsvJAX1vGa1llKApY52k+tIp
    JUhgwCy9VKuEXQHpTZuR3yuGFLdoJIv1+RvEwC+02R4TGFHBGTVtLukA9AAdLbirgc4ORB
    9s5H/S5ZFboEvWTNS/GztHbTHvYByFqFeNQnbZtrMmRajkT54bqptIl/+dJTuh+le0o9LT
    EBAxQx9xRD0nrN1n1n1kdpD/T5PPCxT/87kY3rpi+OwggpbvfFnU8sST591vWsinZpqBTJ
    rYrxscLcko0IQsobrt3JFkMNyL3B4AgIKqPytiVp6V1SNN3suiQqJEyTlnrCvW5HB7bSNn
    du0L2tkeqADKBzPQtch51NtRfrYHlHIBwJTifsxR54ppj15jRAUtR+erz8mug3HOZXpPor
    3wno1ZkVI0l0mEsgaOCTHz5B9rO1/or7WR9E6rtwJvH7oLkqEkQ2s+gy6vgMsuYsekkevu
    9ioFh02s6fY6itmdIWfzEwJS3vL/31/jIR0Hu5j7YoKN5c9hik7h16zjvJGaUZGVzXeABn
    ARWrE5a05u75AhTsqoqnm/57Ko5D7xHHM0sBZFlVJwe00VLpAlgHtDHF2TVQ
X-ME-Proxy: <xmx:HnWeapTi1KElIVQXaOsaf_ZhrAyd9FPBhcPLjSRlSRRPTpm9izOT6Q>
    <xmx:HnWeasOm5hBsmX1h4d5EpUFi8e7n2zQD66xe8ATP3rS_LeOmkCRslg>
    <xmx:HnWeauaAYpClkRC9yDYBIzAYT5iiE-FFv3urcbPAkpwTN5KYj0o6UA>
    <xmx:HnWeamyZssm6r0129X-95KCRha97WW_aOD17nMII6epbBUQAfPHf7Q>
    <xmx:HnWeavtb5354iXUDfigsmklei2CMrdmq89f18C9pPsfD1d3i4R4KR4gr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 04:26:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1e1b3322 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 08:26:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 10:25:44 +0200
Subject: [PATCH v3 7/9] odb/source: support writing alternates when
 creating the database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-pks-odb-write-alternates-at-creation-time-v3-7-735d0b5b3e00@pks.im>
References: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
In-Reply-To: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Add the ability to write alternates when creating the object database.
This change allows us to remove the `write_alternates()` callback in a
subsequent patch.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 odb/source.h       | 17 +++++++++---
 setup.c            |  4 ++-
 3 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index b7b3a297bb..8fe65d91f8 100644
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
+	struct lock_file alternates_lock = LOCK_INIT;
 	struct strbuf path = STRBUF_INIT;
+	struct strset seen = STRSET_INIT;
+	struct strbuf line = STRBUF_INIT;
+	int ret;
 
 	safe_create_dir(source->odb->repo, source->path, 1);
 
@@ -64,8 +70,74 @@ static int odb_source_files_create_on_disk(struct odb_source *source)
 	strbuf_addf(&path, "%s/info", source->path);
 	safe_create_dir(source->odb->repo, path.buf, 1);
 
+	if (opts->alternates && opts->alternates->nr) {
+		FILE *alternates, *orig;
+
+		strbuf_reset(&path);
+		strbuf_addf(&path, "%s/info/alternates", source->path);
+
+		repo_hold_lock_file_for_update(source->odb->repo, &alternates_lock,
+					       path.buf, LOCK_DIE_ON_ERROR);
+
+		alternates = fdopen_lock_file(&alternates_lock, "w");
+		if (!alternates) {
+			ret = error_errno(_("unable to fdopen alternates lockfile"));
+			goto out;
+		}
+
+		/*
+		 * The alternates file may already exist, e.g. when it has been
+		 * seeded from a template directory. Read any preexisting
+		 * entries so that we don't end up writing duplicates.
+		 */
+		orig = fopen(path.buf, "r");
+		if (orig) {
+			while (strbuf_getline(&line, orig) != EOF) {
+				strset_add(&seen, line.buf);
+				fprintf(alternates, "%s\n", line.buf);
+			}
+
+			if (ferror(orig)) {
+				ret = error_errno(_("unable to read alternates file"));
+				fclose(orig);
+				goto out;
+			}
+
+			fclose(orig);
+		} else if (errno != ENOENT) {
+			ret = error_errno(_("unable to read alternates file"));
+			goto out;
+		}
+
+		for (size_t i = 0; i < opts->alternates->nr; i++) {
+			const char *alternate = opts->alternates->v[i];
+			if (!strset_add(&seen, alternate))
+				continue;
+			fprintf(alternates, "%s\n", alternate);
+		}
+
+		if (ferror(alternates)) {
+			ret = error_errno(_("unable to write alternates file"));
+			goto out;
+		}
+
+		if (commit_lock_file(&alternates_lock)) {
+			ret = error_errno(_("unable to commit alternates file"));
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
+	rollback_lock_file(&alternates_lock);
+	strbuf_release(&line);
 	strbuf_release(&path);
-	return 0;
+	strset_clear(&seen);
+	return ret;
 }
 
 static void odb_source_files_prepare(struct odb_source *source,
diff --git a/odb/source.h b/odb/source.h
index ea8675247e..63f1c0c531 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -36,6 +36,15 @@ struct object_id;
 struct odb_stream;
 struct strvec;
 
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
  * The source is the part of the object database that stores the actual
  * objects. It thus encapsulates the logic to read and write the specific
@@ -106,7 +115,8 @@ struct odb_source {
 	 * This callback may be NULL in case the source does not need any
 	 * on-disk setup.
 	 */
-	int (*create_on_disk)(struct odb_source *source);
+	int (*create_on_disk)(struct odb_source *source,
+			      const struct odb_create_on_disk_options *opts);
 
 	/*
 	 * This callback is expected to prepare the source so that it becomes
@@ -356,11 +366,12 @@ static inline void odb_source_close(struct odb_source *source)
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
index 8c7b97f92e..37a8e6f124 100644
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
2.55.0.1007.g17ff1f9808.dirty

