Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8BD4A3D30
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052981; cv=none; b=VqBqpTFVQANRc8v8pu7TsMVC6h3kxoTJkQpVw7wH32tJ7ezJBVVpG/A5Hz602N7sjmU6/D81CxNVDD9gjWsHk8DTNqLZAZa/ku++rwiJxWGUsBvwrsJAcFx+wFIb35WPF7VVZh222AcTH6UOPRCL4vKOxG3unG02RlIVIagRqmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052981; c=relaxed/simple;
	bh=wtAQzODMpfpPOVm2esc86TxQQ7mVWT0ERVpzRGEtc7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VRp9q+K0hbnkyFTjhglEDEyokOv6vuoYKbOUaqqMaoPtYuqOnUEZKH9RM4QGQw8b+Uts7WpMbhNQQ1aS+GVg2LzXmLD/U5fB4sXQVODSuhUZBL20eRLcyJSROCfQFZsjvpfdQOEUL034APZObgNxHbCTxqcNt9UL3ab16f7mZEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c+j7m9x9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CGkSojGW; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c+j7m9x9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CGkSojGW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D9A86EC00CF;
	Thu, 10 Sep 2026 11:09:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 10 Sep 2026 11:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789052975;
	 x=1789139375; bh=Bu4I/OjFyzJot8vwBJ9wIzq5Wcr3FXV2VHU/p7YREJo=; b=
	c+j7m9x96qPqOt0W7turR+dF+h2ZDUU4T3oYQxAPQqZwoMa4jH0hmubmeHCszt2R
	ErIOaxL2DsvPiIWzKriHbwb7RxhPlT7xNfzckB+hy/FyQQHdWl7XdcPhM0hIKxc3
	t8l98PvaJLapRiFF4vCjE4V3ZphFrRjryOsioHvG1c4P1+IbadyxUtI1n4HNk+Qc
	YryjZCAksMGTvTibwfGcp1glodU+NREamB3bwQpsgeQ3zvfQwBiNsID7dZVq1lKJ
	24RPjxWuuwfMSRInh/Ep1K4AwegbzZEV8slY26pYbFrKwv6zBRJj7HMg7St09+nQ
	hLe6h9tCedPpC2RAEDAHxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789052975; x=
	1789139375; bh=Bu4I/OjFyzJot8vwBJ9wIzq5Wcr3FXV2VHU/p7YREJo=; b=C
	GkSojGWIhNhTLuBQC3ewbYSWvYWToMkDnWVMxbXL8/QVjSU8gx12ESkTkiZCabtA
	7nGgL/973F4yoLBhjXbgMgpX/YTna9kTZFd2WjXs6fRqNc6Q9KfQfdVKqn1xRsjv
	wYfciv3ZeScx7OUGFMZYtZgS1AnidFjrvoReqeHcyepVhSDqpMwFPw7fZ0YDk3OZ
	IteYfJawP6mGTN7FOf+febfdnn2Pz5rxAwhvv1oT9bWV9CzAuu557EfVzzhMyAEU
	ust+NDrht2l+/0/ABsudFOwxQNuH/fwaEv10ZkN7HYDLBK1HpTKTuIO0VLxJD2Jy
	TOOHyCo/pVhxLSbfLndOQ==
X-ME-Sender: <xms:L8iiauKolAR351-cbek06q1I-kP8-iJB1ZiqcC9G8vaaAzwt-XVS5Q>
    <xme:L8iiatDai0rC0Mq1xH2xuUyuhSwFQZdBVhb7MkINE5rBaHEjSR1B3Bb3oaiyxXknt
    VLJBAuDkTKwXzp_T0tg_DqbY6ma76ttw0Kd1kO1fRFXIyJZnhNgVvA>
X-ME-Received: <xmr:L8iianCd9R4FfF5fhzVz1lLaX0jVKAjxERBK15yS780RsrF2i9-kEg>
X-ME-Proxy-Cause: dmFkZTFmToSEG6cpqmLCQ+r8QOZo2Uv1HNL8Pjsku61QT1eJxv8HAXxDAkSPnus9Vecpme
    pJafvckUfXllYevYRFBkacQXQBn8rdjuicwUxeuiCeGMLu8JV5gc998H1ANxSJZJOzN8ST
    fcVH+3fxr6p6VED5/2o1IDBicBEufCXUWBqkwMMuqmPUJ04FWOlsiERIZyEc1auESI2D1v
    8fOEzyOGNyBRwuu2ZC+3sLGRJwSWFrThXiJ5wahfsXtQegDTI0WAbln4OJXJ+DLBsD59Dl
    B9aM5LBBYPa4dZUBIuUN0qT0ZLAElCSu868se35c7jrWDNfeTWqToQ3iexsoc34cVFG3UL
    +uGhU45zsrXE6WUksKNdewppBn3DGMaZOog/c/1Cl5iKYRWfQPGja8quDR+izPzMeLJTs+
    1Yl9eHZoSfBbBa7/VCKHW7vAlTKZedXkSXJKfUdr0jR0pngzfl7BLIyY0JhKujUvein5k2
    zcucHk6UpgbYOM6+yAaTWvY7nFtqbo9hQ+XmSGnnsxGerbRg23aGqLon8vtLR7IaIyzfF4
    SFbkI/JAmCelrteH8wvjoTCYmjwsPJ9ASnaOX5ThBZ0UGl8Xa28/E6zmubIfNhGDYtNhDL
    TSJm1Gg+O+JbLqGXgY6KOZFZ5iybGlyiHkgM+cwu6Oy9bZC4Ne8rXNzhI0+w
X-ME-Proxy: <xmx:L8iiavDS56KCTe0MgxP0ghvMGsxL5RUBsbhsIeeCd9z4H0Su0FnTag>
    <xmx:L8iiaiotjm5yhZz-TTul7jYPPHGCUZwkByKMBv4Fi_wDBXryPc1tFA>
    <xmx:L8iiaplQ0eEqRn3EOgNh_9S7l0wEHVUZJunq6GKWSo4j-haHuLyKJw>
    <xmx:L8iiaiwPzoU9YOgI7O0jQ6TyComWbg-muIUaAsLPNtBzL6XNTux2hw>
    <xmx:L8iiaueHM80ioeMjT5VILxacEQeiZCyTQppzhBxb3Fp0_0wNCo4bch7Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 11:09:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e6eb7a56 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Sep 2026 15:09:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 10 Sep 2026 17:09:17 +0200
Subject: [PATCH v5 7/9] odb/source: support writing alternates when
 creating the database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-pks-odb-write-alternates-at-creation-time-v5-7-8d10c4238edc@pks.im>
References: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
In-Reply-To: <20260910-pks-odb-write-alternates-at-creation-time-v5-0-8d10c4238edc@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
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

