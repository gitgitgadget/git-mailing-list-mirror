Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B4F492E38
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 05:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788932957; cv=none; b=nP6Hsd3A+9roAW3/KwRiOfAbtlcfTDSLSlX0FdmBOYu1yEv+amGxCebzyGIBUnopxZeJSzFlmO122Q/j5EMIU+alxR/JvJ9UFGVS5enTTO/bM0YhxeIP/qOmi79jK9HWagfrbmFskMG3Qe1voRpF0vV2xMKmZNJKI44gQrqvExU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788932957; c=relaxed/simple;
	bh=wtAQzODMpfpPOVm2esc86TxQQ7mVWT0ERVpzRGEtc7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cEZBuHKsO4QVUrgSZDYnmU36nj8hQIcWeVw11/2LXr2HR430How37f0onGF9zZ45p42UkPy9CpvgNJbi37Gty4FaLNMI0KxpF4e3ty0zvoJTl8nZuaSf05TTgiwZqjThcSvYigtNWoP/2d0qHJ++6xKvKQJVu8syGkS7g3oPzEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YqSgAxr1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YjylzgrT; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YqSgAxr1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YjylzgrT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D52907A00AD;
	Wed,  9 Sep 2026 01:49:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 09 Sep 2026 01:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788932954;
	 x=1789019354; bh=Bu4I/OjFyzJot8vwBJ9wIzq5Wcr3FXV2VHU/p7YREJo=; b=
	YqSgAxr162EdVoqjqq6yCv9gkkcPdbA2qVOc0N7IMk8V9gSFcnqda4dZixKUsjCr
	mbYMKvW4OoIm1U7O0JEfLEp6WJfK82lPKdmv/LOM8EL7JU75uPBcv68S5a0+7qbR
	rS2tMGxpXKaye8zh/IeQsalkHdYKOr2pdchwh/8xsND586IcKFdbo4UEAi7chvmB
	Nj+jD9uUOKXP+zYdPt9Rhj3mQImpDlCzdxBN37hMzmQcHqSfejgeoouyTr0TjYyk
	XtZb7IFpEs5zCUK+0p5o4cO86K0JlfVVMn8SSRl4Bweij9k9Ut23TMKeMQV7uDH2
	Lpof8MzL8NPaHuDsxS0Qnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788932954; x=
	1789019354; bh=Bu4I/OjFyzJot8vwBJ9wIzq5Wcr3FXV2VHU/p7YREJo=; b=Y
	jylzgrTGCy+0qrnEGhVq0h76jyUIRpEoNtZ2eyS+rNikS5yCFVQzXvPQqaFjrSbF
	Zk0OiSPSQAM0fY4c+Yn6Pm/lISV0iS2WgA1fSOteJa8xseAZ1YDiiBckVUjzeolv
	To1OTDPfFQXLmP+7XL7KC4mJaH8CASgMcdod/qUnEZkD1IIPvTmf9B2IdQROmeen
	SVhxfPEDx6JkqX/90Nx0+KOloUyeGmdeGcz58QPrJOI7JI01bgn1NaRVPbNuKDrb
	uR9uS9BgT32FGdmN033ULvtkQ/v/JlBY+mcPqLawVRkt9KPo0SNNRKrCBd19w3vI
	TQxtaS0iKsWQEDWc2JYKQ==
X-ME-Sender: <xms:WvOgauNWCwlworvWmykfRgoSpZOdfybI02ygCkBR-lyjNb1yR2850w>
    <xme:WvOgaj-xVmDx559nb8DlXWhFigqFN9u9SoxLcDHH3NQj8i8zW-uWFB8RrVX5rrMqP
    70x5rf3UT2ytQqBtqb3UZE8574xBdtRNCJCMjh4so6LlSNwTyyELA>
X-ME-Received: <xmr:WvOgaqQfJl4WeJG0BzNYd8pSEXJZP_uCPI32lEq8GOSbbKD7gHpDd6ZG4TWmKroBiSzU1Q>
X-ME-Proxy-Cause: dmFkZTEO5N4/wRkUGETagV1iliwdFQpV+cs4U6YeYU5TvgMv/ATqJVK1f27ZFzwKVJOUS7
    wCoSru23TiKYHjTDNxQCgu7q4blsVPNJ+eUEzb5tjdqyknI9FyFC2q7Gsy/D7l26beIyVQ
    HHxlURFw8VEPIU0sxcuIuxpsH0HJwr5SAPAPnA94yxCdm5eo2gHVmCUbPKybOiJyBDC8W8
    wb5V7z8SQaRPfUSGu1Rmp1BwzrA04ODauUynmPX0aRXAER3Xzd5IgC6MDE2giTOD4cpMts
    0+5J5DPPtwD9wzjKGVG+sm9ORLCw3jBqNzMMFHGbjCtu69MYnBOEiGgpW0BzwPH4QgUQuJ
    fAwivj8rKN0OqX7G1p5y5kaJQPbTQ+kgcDllNIwMFdhh6UF7pwDR2eQG9UXQgwFG+akAg3
    tgrFWQNAHncDAD+Zr1G9jx0U4gWNemvyu9ZDTBR1KyfM5isaKynWO1fcHYh5N4r9RuZmb4
    IM4R5fafQaUP9fBN2awudBabLTQFHVBB+qLsUKW1evs3ZHy/wlcXNQSDTef+8TTK+G+1In
    xsvr+zHrH4MJqKU5f7XYwtXNVxFGqewjemlSZVr2w6PIccVcd74pZscsJs1PlDREWpVFXH
    2Toh12GRo8hODm70LY1C24zDHkGzUEhCKx9HsPR9/sPCldnD3yxejy8N86UQ
X-ME-Proxy: <xmx:WvOgatne-JJ0wAvvVH9yDMeZuyMT1GdnykvNcSQZIsRM7hZtsfP2NA>
    <xmx:WvOgaiQOe3dhRNrX16ADk7pKfi5Is9Cpv9cYBAXTHLsuAdiLiFToyg>
    <xmx:WvOgajOr3_2mQcmJAKK_IJob9QGz4VdE5QAocRi-rsGhy3vK0hG8zw>
    <xmx:WvOgajXK-qDv8qJGdAXIPmtBJfWRc4FVvrfy4urYE2bgC2nRwH8Asw>
    <xmx:WvOgaiRaIexkDGuweOj3vddEYxtc4zzpE1zVZ2iDP4niaavthyWW1jxV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 01:49:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f38d39f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 05:49:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 07:48:49 +0200
Subject: [PATCH v4 7/9] odb/source: support writing alternates when
 creating the database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-pks-odb-write-alternates-at-creation-time-v4-7-d8a78ffc32e4@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
In-Reply-To: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
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
2.55.0.1074.ge7621b4bad.dirty

