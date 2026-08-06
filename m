Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CFC3DDAED
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002682; cv=none; b=uDsg0jDnkCPnd3f57qvQA6Ndvi7qPyNWXEY4yz2chkdnm35uDqUcHGL+qhrz/WtSYVfWN5emca6oQTFWIw9b5KV6o5CNb7RjUjCyeCmYHYW30YncM2CyXnadP19TXe9iQhhFh9sXR24ekMQcl77sJ2v3+gPKju7VLlO5Tb+Dgcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002682; c=relaxed/simple;
	bh=2rcZyDK1/oabAe9xN0++rMEZO7YAsXqlLKY7rfDy/yE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jLWn60OEbDFw0Ri30rwPpeBcAMPqcnTRrRgfPYe/0Fik1BbRyZ2f2lP9vfqxuEE4aCRB8DxbKps1pSde3GdQmPN/Fd5Mhpgcir4jqIbQkNZDsbjBEqYxm/a3+tZ6RrbDPqP+C7Y6QYEwNFajLm7Rje7BNh4t6IF/cvLUDuIreEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CUM8Hr4c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QFxE3HkB; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CUM8Hr4c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QFxE3HkB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B36F1D00198;
	Thu,  6 Aug 2026 03:51:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 06 Aug 2026 03:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786002679;
	 x=1786089079; bh=lBW7umLmFt/rw385rEHcm4pB1SI44ElujJpcYZtYaHc=; b=
	CUM8Hr4cLe9yBmwqs7TaTlAO4jvOaD0NrU9yK2l1o0U4oK8/TE/9TN+Q3uL+CIFR
	uWtB0Dwullx7cVzUD64DvjIA1ibtYSTLPvXESnh5Vi4RpCJRnZl5y2C+dRnMQr/V
	jgdf+wllXVhLoSQaaWKG0aIqRFcdP9aXjDUqBcKGIeLBJ4aCbrOzIBD6pNZ7VX6D
	h55LYbol60tqWlNMg75gFMfeVdDzWUoTfawM4RM9V/2jf7+CjwpqBpT5kIg74D35
	uqSfDFB94EK6DeJv0Tykj1Mup8DIfrBx6kb1bE9ZeT70mvnLTGfdo25eS0w2Zq/F
	PHLqE35DpwqyYxzl3rU/bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786002679; x=
	1786089079; bh=lBW7umLmFt/rw385rEHcm4pB1SI44ElujJpcYZtYaHc=; b=Q
	FxE3HkBinuQAbl4MiJiZngFTeWuU8Z9VrnGx+xYrLU4aYQcp8wRB9RGQEBUclCa2
	osehAK++eVeTiK/gfRi0UezbYKDr785u7zKGY1M6P5jJ0b6Z9fspLduyTO0JMfIb
	YwSKtRJLImxlx+uokTQqv2lQ1QLoKXynZfDZ4Hr1tf8Fk/kO7+XC+TdY7OCQTjQZ
	4UVJgGInIIb9/t3ta95+tliyHxXp9pT9sR7AXC7nJUGiQO5vQ4FlQYxy1jIk0bA0
	i24d7AXPn2nRSnWtmDyc5zsSw9EkDp9eGUnUrTdtJ80nQPqfC3QzRM9a8P/thVYn
	Jc6LV9vpmZg+eLfPe7acw==
X-ME-Sender: <xms:9zx0amrShzrP19Cd18GeG-IJfqGhUSho7qZ84fyZy7zwV0U-3yyyzw>
    <xme:9zx0arqTxjv9d0cJyq8LFlZd4FbBOCcaE5z8aO2dld8yeI5YyMLuQDA1YRmfBQi2H
    K5g-gXulz_pNMr2qALdcpbdh_Lj7vteU8oIGOd5QQWmpYiy-BRTF80>
X-ME-Received: <xmr:9zx0agMQqMX6vjBeHNrmDbERcPJA8Bbp6Z8-tgZKOUU0eHiFTe3kAUfUDLnwjecmtk0G9HWn9U9nB4n5U31u390jmO0qD_ahhuHLe2mprc8>
X-ME-Proxy-Cause: dmFkZTGJiFop5Eo7uUgbFGmEFhj+5nj6icWyraTDQIYOPUKU2fZsPkxCJWcyicJ0UouqvP
    h2OQhoDZCtyJjqI5q8mR0jmJwL8i7rfGe6oQYxSjvf+FqWpojPB8RP52RC3Zop9FrXNOEf
    4MbvEMu2TNdZgrmAtmZaQOpKM5Sa1wKSY2NP/ifHOPJ8fmMFAS7RDet52+61Pr92CddgnB
    wV9xqgUkMHTf5kM94PyIqUU/Ij6MgO+B5w49KfK8y8pKbeabufQ4FkVvQr8b1nCF1awoR3
    /HWjArmpEwRBCCuwbHDnL4nwmozT8bfNNR+phxsj0YP8nC5l+N1VoCeUrYvojSWkmQQnTU
    SHuXor3+wAP1OFdipHvkVnaaw7gPTEBXDTrz5Q8UfNepwwuM92v7GsvKsPM/aaz8l0ZAKQ
    75t57/GV8X7tnkPjHjhppt2heFRYmlcJcu4UckVWWBY1cVAmg3uzOoAi3gYqWax7KrUUhu
    jZRSAmm8/VYCksb7h8MgQ2BvbGY0KNjbGXxKMyCkXYTn7pojY0hGlIUqoZ5dd3PvCUNdrW
    j4vQLiOJZsYsLUjRZkHZRNhLflazSchdbShxL8o1jurC6aJ2FIEhomMv2NS648uoR0QvCE
    Sf3tNlmpMxTfUxbo7uuit+Uq4PjjZPJytJwZU7yKxmzlehDgPC3RZtE3uZmA
X-ME-Proxy: <xmx:9zx0akyR1VwD-eQ5CgdndQ_xu55cgvhtmWHo71qMuj0pk5wcAq5BLg>
    <xmx:9zx0ahtbyu7nwBJ4iGAikG2IQ6BVnnfybl5bnlkcnMqws7MFyfzfOg>
    <xmx:9zx0al5afS_z3-kKA5GazajY52dzKMbetkciD_lmEdgzLme01f7i1g>
    <xmx:9zx0aoQBIzImgg4nRvaWGhi09xR8uPTxZx4fLsmo3WyyHO5lh4DGoQ>
    <xmx:9zx0ahN96QZsAeOkqfwsooV95LQeKfwLDCvB2IBR3-mxf3je9Mg_rymf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 03:51:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 017ab14b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Aug 2026 07:51:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Aug 2026 09:51:02 +0200
Subject: [PATCH v4 4/6] setup: defer object database creation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-pks-odb-create-on-disk-v4-4-ba8b4fdd2e3c@pks.im>
References: <20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im>
In-Reply-To: <20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

In a subsequent commit we'll make the creation of the on-disk data
structures of an object database pluggable. This will lead to an
in-between state where we have already configured the repository's
object database, but it's not usable yet until we eventually call
`create_object_directory()`.

Lift the call to `odb_new()` out of `apply_repository_format()` so that
callers have more wiggle room with when exactly they call it, and adapt
them accordingly. The only exception is `init_db()`, where we now defer
creating the object database until we call `create_object_database()`.

With this change, initializing and creating the object database on disk
is now neatly encapsulated in a single function, which will make it
easier for a subsequent commit to move creation of the on-disk data
structures into the `struct odb_source` backends.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c |  1 +
 setup.c      | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/repository.c b/repository.c
index 6d633002b4..5ec264e607 100644
--- a/repository.c
+++ b/repository.c
@@ -294,6 +294,7 @@ int repo_init(struct repository *repo,
 		warning("%s", err.buf);
 		goto error;
 	}
+	repo->objects = odb_new(repo, 0);
 
 	if (worktree)
 		repo_set_worktree(repo, worktree);
diff --git a/setup.c b/setup.c
index 5dfab3e79e..e39a1646bb 100644
--- a/setup.c
+++ b/setup.c
@@ -1765,8 +1765,6 @@ int apply_repository_format(struct repository *repo,
 			    enum apply_repository_format_flags flags,
 			    struct strbuf *err)
 {
-	enum odb_new_flags odb_new_flags = 0;
-
 	if (verify_repository_format(format, err) < 0)
 		return -1;
 
@@ -1801,10 +1799,6 @@ int apply_repository_format(struct repository *repo,
 	repo->repository_format_precious_objects =
 		format->precious_objects;
 
-	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV)
-		odb_new_flags |= ODB_NEW_HONOR_ENV;
-	repo->objects = odb_new(repo, odb_new_flags);
-
 	return 0;
 }
 
@@ -1888,6 +1882,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 		read_and_verify_repository_format(&fmt, ".", NULL);
 		if (apply_repository_format(repo, &fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 			die("%s", err.buf);
+		repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
 		startup_info->have_repository = 1;
 
 		clear_repository_format(&fmt);
@@ -2090,6 +2085,7 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 			if (apply_repository_format(repo, &discovery.format,
 						    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 				die("%s", err.buf);
+			repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
 
 			clear_repository_format(&discovery.format);
 			strbuf_release(&err);
@@ -2651,11 +2647,13 @@ static int create_default_files(struct repository *repo,
 	return reinit;
 }
 
-static void create_object_directory(struct repository *repo)
+static void create_object_database(struct repository *repo)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t baselen;
 
+	repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
+
 	strbuf_addstr(&path, repo_get_object_directory(repo));
 	baselen = path.len;
 
@@ -2864,9 +2862,9 @@ int init_db(struct repository *repo,
 	 */
 	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
 	repository_format_configure(&repo_fmt, hash, ref_storage_format);
-	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
+	if (apply_repository_format(repo, &repo_fmt,
+				    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 		die("%s", err.buf);
-	startup_info->have_repository = 1;
 
 	/*
 	 * Ensure `core.hidedotfiles` is processed. This must happen after we
@@ -2882,7 +2880,9 @@ int init_db(struct repository *repo,
 
 	if (!(flags & INIT_DB_SKIP_REFDB))
 		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
-	create_object_directory(repo);
+	create_object_database(repo);
+
+	startup_info->have_repository = 1;
 
 	if (repo_settings_get_shared_repository(repo)) {
 		char buf[10];

-- 
2.55.0.679.g6767b8d81c.dirty

