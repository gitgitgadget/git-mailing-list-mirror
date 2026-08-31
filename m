Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89513E009F
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170554; cv=none; b=XNFhkn1JOM3rbLJDffEnpc+kEIt8aokQewULhBAUcvds5FnpS+80FBr1vo6OTndnVWZPhLypQRpS8klVIzPjkuLFaoAAMA5g+kPk8Sn8NMvp6iQEmvSXkW+5Z4cSZnLfK7ySz99lLtL6K+BFs0ip+Nca+0WK235J5ETxuDnbOf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170554; c=relaxed/simple;
	bh=2GkF1Ol71U7uEZmpGv88AThVerrTDhS7kYaK62N3G4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cYybWk06ZiEYiW9GuIFjD8z6JhY7SVhK70wdAttpMu+CYWGwCBWfNYSa2wSD61d+GF3H7BFNwF54H4/Nv6kj4RctPS8p3Zs6G7bKGICq89GRwPL50wy0QLkoslF7O8HRd9HVzP9/VarDcI8huifqM9ZrIhI4E0tlAOfTgphFrsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R0QVDNX4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PCWMCNF6; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R0QVDNX4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PCWMCNF6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D7B7A7A00D8;
	Mon, 31 Aug 2026 06:02:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 31 Aug 2026 06:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788170551;
	 x=1788256951; bh=XJjfpRtpMwfpLye57NJtaM3AK50OfVv4K4Uz4zRymY8=; b=
	R0QVDNX4DH3Wph0tWOyGFmvlNjQsbGBrxr4cpdWQ2jx9yV+pfsZdGr0B0NN0gXEN
	0dqGWl76z+5/eNvFaAM2O6De3LMnajhxSYkD9r44AazqI8wlUD8XGalkP5KQ0Wrz
	8tvp4zPZc9Lu1VwVXbXEgxIXDAs09/AGc7JiQhPyGuFCz9GLYKIh4EKjVmeU1FDF
	NfTMtbwSpMSRMs9P0IVb9WMLkHH8PCJUbnjISi6eUuIqEHMkOBPgEGEq3SOz83Lb
	VNDdY9chpWHdJgsMmTF9p4AfvqS/9I+l7HHbtu9c6z8Bq8+1U6MO9ACfbkAg1Nsz
	aktpg1ZeRnnU7YRuuAAkRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788170551; x=
	1788256951; bh=XJjfpRtpMwfpLye57NJtaM3AK50OfVv4K4Uz4zRymY8=; b=P
	CWMCNF6Bs7a3eU0JmpgjZDR2A6ZO84VUsh+i1Ts2D3O3/T8klDYxJ8foXIwQb18v
	pz5tpaVYpUUyM1N2rZuWv/p+8MhDIjZfjesQRXn2QX0l2o/aGn9dQoeujCMhEQ9S
	039c4jKH1ho12Eq6Njywr+hBa/wZZ3ias0a3K/6FcBrdjh3HNjk8HJ6upx0WuLPd
	QjG1UP2GZEtqZgkjgXzGFh5sFPMvE8TuvZzjfTZHlsWU902GKVbAR7PTge+Maiyp
	qNh8jACKWJcx6Lxbrl1TlCGBYoXBkRrajsFtbOqPsrDOA6ADxTYzxnw4xFTwYvjL
	p9jesWeJBGEOwcB2Sjbsg==
X-ME-Sender: <xms:N1GVanMiu10J0bGRtMS70Su_WkwpsX9kmhPvThLZTQb_T4DqoaHOOQ>
    <xme:N1GVapb0djc7V-kf11A6pI9bja4vO14pOZLkOp-Se7L5mIjvzLtmkD1XJtFgC4VW2
    HxsjYYzjmEAmtqKEG2BbmjdpsBU2UtceJ9FupvIsOAOvrYMDyEAtg>
X-ME-Received: <xmr:N1GVajrwKkCbUNEojfzxV-CrdjRAuZDdbiG_8TOystrvDT-Xh0qm4xTreMR9sBWL4t6X2Q>
X-ME-Proxy-Cause: dmFkZTGyq3uJ/qDpAEjypjPB9S6h4YZ2xNUGnTuf5Y0GXxGOskTR/ujfuDaXxm8ivhriFr
    qNbRyJanxrc4jWisuVr/DgmVAbzSrmfAQp6IE680SZ/6i9NTwl5dObCX99Q9OScaE6no32
    hS9+AVDqv3xCrfFRLm6hfS6+/4Anh6vJsCtiGd8dB+QqgbTW0GnE6PjgmI31BYZTiEA9ma
    fSn8HUKFAV6TAqx4mKT+Kb1L9ZlcCr7WSIYhwwMzrvFbxy4OZVAuw83r+dXgduFJiOLBcy
    sdQzr8BsUdG/lDFmcLyrFNc8DgyQ3aGjPi7FBhwHByJDF3dcuECSaac7qUccx0FHY3Gce3
    5ozmHrcAVzjL+eDPT3lpj2O4/KTA+VoUIO9FIS2D9D/qWg36OcTe7JoUNUqLrcpsC/mVSy
    gahdMgzwJxC4cxJCTu0Z8u7N9N2F4bwbZm+7Roq90w1EOrO6BrJwiEEJjO26IR6O3lG7GU
    ZbPpCI6yJOXkXRfTJWaU09JwuooxwQyldZNsdW8GMlzZlH4gXmOJ5z/GMVFbeVzOMylXQV
    xA238ALhtJ9x+uLOf551YfhYJbR1fiPT9wSGpOqJNVNR3blmhF01nS7OsTl7PZ+MULcD/r
    GDizZybeh+eQb9N3+H00qEalGSVrZ9NI6pzmUpd8NpNZQpt4aUGPDou8Miag
X-ME-Proxy: <xmx:N1GValboXpD2fyffqk1OO9-fsygDPyMSJLZQY8yIzlYZ_eCJFy5CfQ>
    <xmx:N1GVajSsz-pU-cWNWHsFmMPd5ZxxgoSbBxhrFPr2iKS7_c8Ras8pew>
    <xmx:N1GVak6LpHG5cWra2QJd0uG_BCpYO_0WeRfZ3cxQXW-_TT-WWOFptw>
    <xmx:N1GVagxu8rX8ziAzvGsxM566Bv-qQ7tIolo2L1LUGKtA27fYwblmoQ>
    <xmx:N1GVapCpAHTeY3hGTKk-Xirn8wZaajNla9o_H-IXObvxqB5k-yOhHBEa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 06:02:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 895a988e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 10:02:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Aug 2026 12:02:10 +0200
Subject: [PATCH v2 6/8] odb/source: support writing alternates when
 creating the database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-pks-odb-write-alternates-at-creation-time-v2-6-aecd2382ba1c@pks.im>
References: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
In-Reply-To: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
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
2.55.0.979.g7e5102b832.dirty

