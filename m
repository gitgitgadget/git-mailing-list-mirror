Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5F7381E9D
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832216; cv=none; b=FfzniyuXYn/ITeEGYD02y8GjNl73ZKiKTsg7aMnz1Z+57unXwSngpJT+dODG+SsfrvwENKVi2ri5VsmyMi9G2qAo/ER9u2OYRQlb9lxOKvNtlEFVrdDyLLI26FNoOzzFTZUnugrihM96f5CmvUj2PoSbWq2vWAwE6P1JuwZ3+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832216; c=relaxed/simple;
	bh=DJiF8C/5VMV/HexFvLMNKpoIu/PlplkuqFSw8m6XGsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RLrEQwKA9oc2QA/h6C3H4FMI4qYZgBsbD3K4W3kDvdJEh7qf4inB2N2m2FZDNOh2QOrVDWStvn8TwEdgwTW42wGYmEatWEGFTies+DUg6lw/KPRH6JL0UDsE3QPT88idzNFBn/bnUyiNdU/n+EBaku7oySUwMz7QKNKDCc0gIWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aDue5+LK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RCdZNlOT; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aDue5+LK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RCdZNlOT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 170091D0016E;
	Tue,  4 Aug 2026 04:30:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 04 Aug 2026 04:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785832213;
	 x=1785918613; bh=6K/nZzmDY6gL1F+qNPkT364QWMW2vTyK+UBd7ciGuxA=; b=
	aDue5+LKOQlIBpSa/RX1ZzBhYYWmXKRa0MfmJF6K5PhxVcRlS9AB2m+VZAOHiNNv
	Giyhvk1TCTShDqBuv7f7CErKI9XHwgF34wmOfKlLn8obzJ09q2YndCXgrZd2kqJS
	kHRjw0A5lfdK3t+fHcbrOjcmIkgPyZbTSYZFpyGb0A9SPsSORhHJmr8W3Ru3pvcQ
	HhmJSRr7rxi19Ek/bZpuhnyP7JPHNxRzguGD0EuilybbbM96prjmqTe6oXjPmjdx
	GzeMueoIS88IcdIrkT3JgdzgLlEgPvaFStGhLWV2y3XGCAj5IhRtW7ngQZSW2c3b
	S//cnemaP86td4AGVWMaeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785832213; x=
	1785918613; bh=6K/nZzmDY6gL1F+qNPkT364QWMW2vTyK+UBd7ciGuxA=; b=R
	CdZNlOTsfZsgWqW6DblWK+amZuXvX6THFIQzecyPyE+BxohDwStuVrKOKdEXtNCx
	lnTi+cyt9wKPMiGZZ0WNe4BUjx1UEpEpXmNZpkOIV9OZ0DMzZHY8B4p1/xw8/d3l
	nei0I4BvmFiMTxuxPxfIIzKrJ6zh7VazaOW4fNm7HpVjZ4WU1aedtDiL17pY4A2s
	I+VpPYCWh5aoiQrRTFTjjIr0RDOYA8cI5g9nGR/5uFgzmo9zbiwwifYNtZQ9fTny
	asLL+UWK/ipi7P0bkDA6um2icv8zqZ5IJMGAtJMUpcxEPWGp97+8/0ejiZMVRG5a
	aox/TQEdchI1SYioNjQ+g==
X-ME-Sender: <xms:FaNxarQ-fwTdxDScXfiwv-0lexebZF9ESbBfUp6dilIJUX7oxvQ9cA>
    <xme:FaNxajwrooVgEcIVtSY6lGa81ETOyxBTFlM-EyDB-VJpEuQEmwQ5vCIcaEQK4vipL
    YbnpLLT-oGD7tSuoSPJBoXez1-0njFbETk5GU2qv_CTt5Z6zlJQf6I>
X-ME-Received: <xmr:FaNxal1eHuoaUYulORqwec3bfiZ6melW8ht1MXr8P9fOTCsP9NlLw6AycgB22bLuKUicjeQLNqapUHrFVbpwlzkntlZuPc-KkC92PRsE>
X-ME-Proxy-Cause: dmFkZTEUFTUpa27s20+FEluJpTteW72nBUuZKu8o+qytp6CyGkdYLrEZod0abY/0bdD9wT
    dNJEGprhGegPdUzzhs90OWTp/MQgV+2T2WoeUBgnG75toDgIdlrZz2h/pSyNEJ6y+J9qsL
    RESyvNhmCZrCht2gUwqhmXCPhNknquTKGZtaw76Fnl2LK/YLQTCUhJ4RM6zOqEqGOZJI63
    NJlhXwwBeUjKd8tJsl0ga5dmCm6dRHo3YYzarO1y+LZCf8n4lsVhmaADN3URHboDAfnt3L
    JhLznMSPRpMD78g6Qd8RZ2jpTMP3jqMsuYbcBpNipFVIUtRCd9hmXGJo5V0RjFnblghaZk
    rHJ1PRSKHdU92ZBNN1OKSCe6UubrpqfB6hp4gcoxX5saYzVfhaVSUxEwz24mqkKCqx9PBo
    b5wYNzyLkKP8JlMF08mWNpL52Krs9jXeRYDFIhmMMjReRvb3aEWZdJBU7P+wggnv3Dsmmg
    i1Ji9WMLPBickHN9ZGJlPKT9Gnv6FPWxOiQWXvHfkdDTNkXKwN5MbGtdDoxkFrzdscgjen
    6QbnKFeGIVeE6GZhX1c2ZdpQoqMn+6MbvPCcTTbA49K67ucpkqYxEhbUkkFOPrJy1F7kop
    DTjiko/TDfDemHpjY4TdHce6QryJ4QpBpSBjLEUQ10jGQNHoPvAEW3fu3FiQ
X-ME-Proxy: <xmx:FaNxap7JkXTlTGUwtjvYjniARr-MzbXzZojiDlXidN7hQTj6llrfFA>
    <xmx:FaNxagUCICyMBqaa3qb8w5vAVYY4d2CmyQ8-QEdkJXNruUwju53HAA>
    <xmx:FaNxagCoowwRrXJllPjD0u2E1Dvpy4QVAIeOpjWBsRoLteAU-LK_jw>
    <xmx:FaNxan6bidJxPBOSekcG5yR7oL5F5I5FEdcHzZPPOZkEW8JnmWykCg>
    <xmx:FaNxas0olzwvvCeNibtsMSVXbY6R8b42QJ4WqsK2LvNZjVTMojI8zvHY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 04:30:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 06992921 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 08:30:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 04 Aug 2026 10:29:10 +0200
Subject: [PATCH v2 5/5] odb: make creation of on-disk structures pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-pks-odb-create-on-disk-v2-5-ddf8b59bd207@pks.im>
References: <20260804-pks-odb-create-on-disk-v2-0-ddf8b59bd207@pks.im>
In-Reply-To: <20260804-pks-odb-create-on-disk-v2-0-ddf8b59bd207@pks.im>
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
2.55.0.679.g6767b8d81c.dirty

