Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D02EA732
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784864961; cv=none; b=DU6yJWrgaIVqKEmu7afMzuO9lQS/fSjazzzaLqWdMNWrSNZD0V/rweyOJiygCJzvwbzjnKgfO8ndBWOaa/Vo35g7NLbrvuYaXgmcLDTehLW/Qbw/KCnvToBL7imxPK2noFbnjFeUJBALahckJqCvrseWG+PwCTtyX3JDZLYA/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784864961; c=relaxed/simple;
	bh=WlMhlKdfmx4dtPwVWPIM6ErEJduOAiavRW7vhSZ3jMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YRcu9JWMOyXEk7EFkUcBx4KfbHoJ8CasQw7h7GwjeOlPHTSpBQxC06cK6LADEc6300zH+D6KRzlz1PUp0XpQmGlGG5MDldewUBqcDutEG2Q1S3wC8aLxs1bEN8zSLp4uvwml2j8YU6c8T9y14aQhMb56C3soeRJIP6QnblJbPHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bAGYrIYF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kL85GCE6; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bAGYrIYF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kL85GCE6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 581297A0313
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 23:49:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 23 Jul 2026 23:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784864959;
	 x=1784951359; bh=sFc7QEqyBKmEODZS8hAUpNH4CoTbIcStzNaUy3Gq5WI=; b=
	bAGYrIYF69y0TVCfDNW+XiqjWOCfCU3KhrcVNaiCWwY4jEtr9oLf6i0Fz9UpmznT
	+MZBkoVFZRTwXiM4pfUo9OzoHFj3lKSxqCPpzoxGVpvbjWY3wSzDpDp/XuNaEKZL
	EkebVDqoIvogWeT/GITea8pbiEBqxXv9OuAkhd3ZCa8qwA0usCSGlIRTS7wCIFRr
	y1H0HGv0INvPN2CblQanMbAAa5szn03JJ9PK1mqehFhJVam5mXTiTWtImyOIATW+
	8SGFuRv5QgkGHxlm5vxlxyp+lLUmLG1+s7HPjBZrHs5mLaaMTH6C5aEiAqq27/F5
	1yekdIkOa6duMG+ZVf44jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784864959; x=
	1784951359; bh=sFc7QEqyBKmEODZS8hAUpNH4CoTbIcStzNaUy3Gq5WI=; b=k
	L85GCE6VWfc8+UxdzOoPGq8E+v93n3F61PXHFcAlfdIdK4eUmIuMBZry0E+4phby
	wPVwQI1BvZUbhzh6ajbx1hMIljBWmDGP7DB7mzwDMG656kxTwxVSqO8A5AFLOzhD
	uhUxqPSlhjKaPllKggUZvFAIPBJU/TciECRmhp7f4RMJT3dOFuE7AOBdxGsI9FRH
	Y6aUO8Qsgkk/Zc+bj0FsAeOD79OEBlFKzDXXgJ3aq1p1yZlIKcrqtVWiLu/BuY/b
	bKHB5rmZqrHbFp5vPf13HksDDgS004EB8bnegQNeztGbnEmqrMeqJqhJqhrFLHJn
	olwSl0KFhkmyiRus+QmMg==
X-ME-Sender: <xms:v-BianWclNfiMXBr15I8jJJaiZDZSKqrA2YQ3Xy-PpqKyEvCAttFeQ>
    <xme:v-BiamjQU6d6lMQqKqvde7v61dBdw8avLuoaQ04FpsAi3LPuSVemK2VdRY-XghB3E
    cTkSM1HJKswZKSInq1xykElZTtYsyCnmEJvUnYS45JKdOxG575eyg>
X-ME-Received: <xmr:v-BiapCX71famrUKJx_k8qX8n3MgLLM8PVAs22QV6uQyEy0gwEMQAFs6-xRNdsnFwnaPrj8YKFUvdOrj5QRGSR4ljBr6ketCnyeogvfeoEg>
X-ME-Proxy-Cause: dmFkZTGu+wQeRerJm1Z/lERLfY9RoIY8Tr0gWi+/WhheCw/mmrklXpb6g5xHMxR7XzajeM
    Ty3H6dG6pUMhNxy/EqyFfesFO40zU97Fwp66zd0TFPRcjaZ3O2ySyPHy02XBEMHjol9/fi
    VunmqG8FGYlE5HwQMnRP7WYY57X9HhIkSQLYq4aXqxoxE/ua/8S+s+1kp+/Rqm/zm/IJzy
    A3KtcwTO3yNKagOuX3FsDQKBZUx25wd5VwMDTxNdOtObXe3VmIhn7vP8tKdmm/6MkCofwG
    clbls8qgJOFjg95yH/UpHjjQBgrQ6HALNlIoSGbFjMVHgvEP11cHrzxPNkHh2U/PI6rJgX
    D2ktPhE45uueXWctsc38djEZuy+LfRVREBSIITqXggSAeaF5cBl7cm60G3JkoTFwR3N/pF
    2yiePwlJ2JRiBj7iQqW6+gpA6+ktc1gRWVb1AjXKSp96pJuqkNkSt/IvsmZaOkYQsxolnJ
    fceYkaFxlJKhmEcSRKgxwWIZqt9xZuqDEAhJ3aYhdXkL4iEsEhYQsG4GwQ5yiJhC/eVINO
    UNt1ytwpzbbeVE4ctfcn33Xq38ZWmTQ56qZcfGdeF3Atk8THz5hzT2U2ir3UL8e6HC96ue
    JlKOYlpLRRC8ukvfMJXrckay2akXrdAeYp3VJHf8BcNg7tn8HYFi86xlKAmg
X-ME-Proxy: <xmx:v-BiandpZLQPLF_yzd3SPgAf3fRjs-E6dpMnLsJLixa8EgdbOcI73Q>
    <xmx:v-BiahfHWhLPY7WgFg54VgU-Upq1Aez-bxVXQtEPYla18EGM2WMTzQ>
    <xmx:v-BiarhbZJwmNoRARvPHOMMgLVvqo-G9irWfRmgET7F1ji9JQr8CLw>
    <xmx:v-BiatRmwe3GJeqzX_XBz40JvL6Qzwaduvlg6Hh6NLI2Py2SP1F-EQ>
    <xmx:v-BiaqkEMmLwrTV6u02hG__fN0S53s7ugOCRenBgHpjEjEA3a1e0hZrq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 Jul 2026 23:49:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5bc82ef2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Jul 2026 03:49:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Jul 2026 05:48:44 +0200
Subject: [PATCH 5/5] odb: make creation of on-disk structures pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-pks-odb-create-on-disk-v1-5-3b3d265d979b@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
In-Reply-To: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When creating a new "files" object database source we have to create a
couple of directories. These directories are of course specific to this
particular backend, and a different backend may require a setup that is
completely different.

Make the creation of on-disk structures pluggable to accommodate for
this.

Note that there is one exception though: the "objects" directory must
exist in a repository regardless of which backend is in use. If it
doesn't exist then the repository is not treated as a Git repository at
all. Consequently, we create this directory regardless of the backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 19 +++++++++++++++++++
 odb/source.h       | 23 +++++++++++++++++++++++
 setup.c            | 35 ++++++++++++++++++++---------------
 3 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 4138758511..0db6e681fe 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -9,6 +9,7 @@
 #include "odb/source-files.h"
 #include "odb/source-loose.h"
 #include "packfile.h"
+#include "path.h"
 #include "strbuf.h"
 #include "write-or-die.h"
 
@@ -41,6 +42,23 @@ static void odb_source_files_close(struct odb_source *source)
 	odb_source_close(&files->packed->base);
 }
 
+static int odb_source_files_create_on_disk(struct odb_source *source)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	safe_create_dir(source->odb->repo, source->path, 1);
+
+	strbuf_addf(&path, "%s/pack", source->path);
+	safe_create_dir(source->odb->repo, path.buf, 1);
+
+	strbuf_reset(&path);
+	strbuf_addf(&path, "%s/info", source->path);
+	safe_create_dir(source->odb->repo, path.buf, 1);
+
+	strbuf_release(&path);
+	return 0;
+}
+
 static void odb_source_files_prepare(struct odb_source *source,
 				     enum odb_prepare_flags flags)
 {
@@ -271,6 +289,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 
 	files->base.free = odb_source_files_free;
 	files->base.close = odb_source_files_close;
+	files->base.create_on_disk = odb_source_files_create_on_disk;
 	files->base.prepare = odb_source_files_prepare;
 	files->base.read_object_info = odb_source_files_read_object_info;
 	files->base.read_object_stream = odb_source_files_read_object_stream;
diff --git a/odb/source.h b/odb/source.h
index ab16d152f4..4abc418bdd 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -89,6 +89,18 @@ struct odb_source {
 	 */
 	void (*close)(struct odb_source *source);
 
+	/*
+	 * This callback is expected to create on-disk data structures that are
+	 * required for this source to operate.
+	 *
+	 * The callback is expected to return 0 on success, a negative error
+	 * code otherwise.
+	 *
+	 * This callback may be NULL in case the source does not need any
+	 * on-disk setup.
+	 */
+	int (*create_on_disk)(struct odb_source *source);
+
 	/*
 	 * This callback is expected to prepare the source so that it becomes
 	 * ready for use. It optionally clears underlying caches of the object
@@ -316,6 +328,17 @@ static inline void odb_source_close(struct odb_source *source)
 	source->close(source);
 }
 
+/*
+ * Create on-disk data structures that are required for this source to operate
+ * correctly. Returns 0 on success, a negative error code otherwise.
+ */
+static inline int odb_source_create_on_disk(struct odb_source *source)
+{
+	if (!source->create_on_disk)
+		return 0;
+	return source->create_on_disk(source);
+}
+
 /*
  * Prepare the object database source and clear any caches. Depending on the
  * backend used this may have the effect that concurrently-written objects
diff --git a/setup.c b/setup.c
index a7b1b9eaef..14ef119cb7 100644
--- a/setup.c
+++ b/setup.c
@@ -2666,29 +2666,34 @@ static int create_default_files(struct repository *repo,
 static void create_object_database(struct repository *repo)
 {
 	char *object_directory, *alternate_object_directories;
-	struct strbuf path = STRBUF_INIT;
-	size_t baselen;
 
 	get_object_directories(&object_directory, &alternate_object_directories);
-	repo->objects = odb_new(repo, object_directory,
-				alternate_object_directories);
 
-	strbuf_addstr(&path, repo_get_object_directory(repo));
-	baselen = path.len;
-
-	safe_create_dir(repo, path.buf, 1);
+	/*
+	 * Create the "objects" directory in the common directory. This is done
+	 * so that the repository can be discovered regardless of the backend
+	 * used.
+	 *
+	 * Note that we only do this in case the object directory wasn't
+	 * overwritten via an environment variable. If it _is_ being overridden
+	 * then we skip this step, as the repository won't be discoverable
+	 * anyway without the environment variable.
+	 */
+	if (!object_directory) {
+		struct strbuf objects_dir = STRBUF_INIT;
+		repo_common_path_append(repo, &objects_dir, "objects");
+		safe_create_dir(repo, objects_dir.buf, 1);
+		strbuf_release(&objects_dir);
+	}
 
-	strbuf_setlen(&path, baselen);
-	strbuf_addstr(&path, "/pack");
-	safe_create_dir(repo, path.buf, 1);
+	repo->objects = odb_new(repo, object_directory,
+				alternate_object_directories);
 
-	strbuf_setlen(&path, baselen);
-	strbuf_addstr(&path, "/info");
-	safe_create_dir(repo, path.buf, 1);
+	if (odb_source_create_on_disk(repo->objects->sources) < 0)
+		die("failed creating object database");
 
 	free(alternate_object_directories);
 	free(object_directory);
-	strbuf_release(&path);
 }
 
 static void separate_git_dir(const char *git_dir, const char *git_link)

-- 
2.55.0.407.g700c83d4f3.dirty

