Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C03FA5E9
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922158; cv=none; b=FpDtExrh6Nh2tr/BDkeT6EjTE6wLqiwtPnB9LbccrCY+XEhEMKoyc1gLXnIj9uQK8+qeFddNN+ZCzN812YIAS4TofaOvIR1ILceBcMeC15eQK5E5fcMpbt+GfLOp8R8D8gI2TIzilgLD1lILTL1O/Xi/dwnM6kDmSUWInfhAF80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922158; c=relaxed/simple;
	bh=eas1ETgmZzqgeYG3yhGeFocL4MCphEFdBWOs1wPJk0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iTDD3nF4bLqwyZk6RDdrWdAOYXFAYQfKr9z38pxdlZaAUvkzFdOy0+gVu3mL61GVNXsx6qFSkHWxOeA9a+tLX0/MrJM77y6ng7qjRpxkiiOhvRGmzTjTnFS5A0hnf788chKlQVwy89ezBbTwH/a4YT6xD4xTkIhpmIoBAYAgBGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cJbrMqba; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RqBrD9Zm; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cJbrMqba";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RqBrD9Zm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 000A8EC01CB;
	Wed,  5 Aug 2026 05:29:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 05:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785922155;
	 x=1786008555; bh=9IZtddoi8gCCLzrMQ9eAFDwYqiCvXnqCNlpjsqe1Cck=; b=
	cJbrMqba2XqzwJK0slapNQivaGov/ici8+MDCofxobAzQ5Vxra4Udbhlngg1YJqt
	T1ZPJ4CnRSvFo34QFj5qnJGZ1xjUJRg5buvxwy3oNM2Env3NJoOa87XN5UuSB8t3
	lJWu9J0GyEAt2H+Qux4lwW+N0W5fc+UtTRzxPUZ6QSLrg/2grxq9VdRBz5yjnBEc
	6MIAZ6Nk9+8Hg7cwI34p0ZXLN5MdJXd5bpL1RVg3P1bMOi8dmnwtFpDGxMS9K4ut
	55EIvtecA4zUVIl38PAsU0PnEsOC2VEWkoNpdKH3q3txSltzisHgGKKraVYLrvsE
	k6PbwHEcMWSM9I4dkI67sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785922155; x=
	1786008555; bh=9IZtddoi8gCCLzrMQ9eAFDwYqiCvXnqCNlpjsqe1Cck=; b=R
	qBrD9ZmG94wXoCaZKWKSfUbBPywHRqQzB7o0wCfs0PbuvOBxT6ZxxVnN4YNHJyha
	T4IDmG5AVeOb/4LC71f5fVORYGKd4AqBipf/8ts4QH9DXPaPlAlxSA2MuhCCZgkB
	nC9cwKoHmtBrn6mvs+DLcnieZO1/LjOraSkZVTjWs/V6WIbbKgGa4pGInuc7AfsH
	SkS8C1lN99VL76XLL0HUrhH3kSEQKdwjA76r6lY5DAt0+VzGANY+DyER4kp9sqMd
	kivM/oG3HWJDO0DxljplqTl0Cd5ywsmg4qcTxEldJxQGovQ424zJCdcgvZ1HablG
	v2IwUGZGu5HRpvMIvDs3Q==
X-ME-Sender: <xms:awJzavsJnuPft6gpH97O9sJ1JJLHDhVuckgACTCgI9rcgszjSnYHEw>
    <xme:awJzaneC1CcO8gj64WEFmFI-PhYvOWN4wT6rlONpo_kJaA0tslR4BbVbfAf_uLMiq
    ZFZpWcy3VAJzuuP-gIzn4DzBj8EwBblld6FCuJ_qpd95qyS-cy-7A>
X-ME-Received: <xmr:awJzanyEUMgEMewN_EP0I85v8Skn__l1uZ57j7917usMCSLWxQtt0ZI0qHMY8iNXHx5nQbTW2-Q_V_NORtmakLXW9ewghHNBy5DGIoUQrA>
X-ME-Proxy-Cause: dmFkZTFMVDDgcjzGyb+u0o2NlPOyghMJKRGY8OF2IZN3wXX8OG6FCq0RnyXS3DXLwcFp5a
    WHvHvWeNnAu48J9SF22nYx9A0P1AHqFjPruFaaJCQdPNwTuW9gPEej71oDylC10BQ8w2th
    K/3gZu/fYfadWKtYYHSHbrSakyvA8i53poWZ4MhlKD0RFe/ZCdVMiLO27/ejQ9DsUbOKgA
    NzrLSOwheez59ND0rXt4GQq4b3K9D5WqcJlICqMpf/WSBi5Mh9CFv1W9UmuT6kR5umLfI3
    IAEWxvxW4h3rmS/hAsX/S1lFdX0IT0wiQ/h0c23T4sWXL5mWtKQUvn+HRPFS2DzI9ZUYKd
    YrV6SDYaSb5JVaM7P3qW/ojfJyLqTF+7dmtTJwtQgvzBtWD+i7vkJMywRsagHaWKAOGGUh
    QAZxahsjtrmFtXU/HAWVKbxn4BylexJYxSsi3isyl9WfAmNDL02Y5oxa0Lt9Q9Z/onFkqz
    tkLhqSq52yqcq1iOT/utyLXi964IHmF8J38vaSmHKi+/ofbHs0WlFbjxCM36ZR8UVY6fdD
    +gfJ9z2rReJhx+zgEYNL1QRpazN9rRNA4r/k8U4pylJUSZB3L/eZpd0lXZGzv87E+ThNyP
    QSRspcc867Vt15MhhbYMKw2KGiiBAFIS2vY7YBQ4rjfA3n6/5+Pm6pxPI9OQ
X-ME-Proxy: <xmx:awJzatHevyQdgLsVi-OSn8DwlwzRG4ABOon1u0wNYS5-UKZp_DHa1w>
    <xmx:awJzarzazlsvWz4znYa5Jeu5_0prdaJuxvPgfUGlUC2LdOBFbMsqCQ>
    <xmx:awJzautXfusbhFY-gQOOvzwx35oRussEnv2OuSAZeQ_qOxf-anyg_g>
    <xmx:awJzao2kVyYbBE8WhGBPZ1Dncac3KD7eQyVtHpp5aLOpa8QlAqlIYw>
    <xmx:awJzanxFG34hK0EANpZVooGzkRnLXHPXRZkzRZbNxB0Y9fIg3bS7OoOs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:29:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6e511c57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 09:29:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 05 Aug 2026 11:28:56 +0200
Subject: [PATCH v3 6/6] odb: make creation of on-disk structures pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pks-odb-create-on-disk-v3-6-c0ee3ac5141f@pks.im>
References: <20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im>
In-Reply-To: <20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
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
 setup.c            | 34 ++++++++++++++++++----------------
 3 files changed, 60 insertions(+), 16 deletions(-)

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
index d85171f3b6..af02cd965c 100644
--- a/setup.c
+++ b/setup.c
@@ -2654,25 +2654,27 @@ static int create_default_files(struct repository *repo,
 
 static void create_object_database(struct repository *repo)
 {
-	struct strbuf path = STRBUF_INIT;
-	size_t baselen;
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
+	if (!getenv(DB_ENVIRONMENT)) {
+		struct strbuf objects_dir = STRBUF_INIT;
+		repo_common_path_append(repo, &objects_dir, "objects");
+		safe_create_dir(repo, objects_dir.buf, 1);
+		strbuf_release(&objects_dir);
+	}
 
 	repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
 
-	strbuf_addstr(&path, repo_get_object_directory(repo));
-	baselen = path.len;
-
-	safe_create_dir(repo, path.buf, 1);
-
-	strbuf_setlen(&path, baselen);
-	strbuf_addstr(&path, "/pack");
-	safe_create_dir(repo, path.buf, 1);
-
-	strbuf_setlen(&path, baselen);
-	strbuf_addstr(&path, "/info");
-	safe_create_dir(repo, path.buf, 1);
-
-	strbuf_release(&path);
+	if (odb_source_create_on_disk(repo->objects->sources) < 0)
+		die("failed creating object database");
 }
 
 static void separate_git_dir(const char *git_dir, const char *git_link)

-- 
2.55.0.679.g6767b8d81c.dirty

