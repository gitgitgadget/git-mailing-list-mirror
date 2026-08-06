Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F33B9D95
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002680; cv=none; b=EUOVVg/YDX+FzASgdk6K10q0SMPhG9K9A3Jx8x+PfiytHhrIuTE0CwTLRlTjsq/5o4JJDJzik0svKamixgJv0PsxIypkGv6dRK75Fk0wYW8ySreqS0RZ509D6GHZ32hlMpIvS+zu4/MTM2B1D2dOFvJC7YyyfsrbLJMAouzijk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002680; c=relaxed/simple;
	bh=MSAAlKp7NkFL2beKxTUQiurWT506aBXPFP+fsNOEQZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tcXrEukrI2diHYnHAvHHOlvvjXmNw2UDh3oPq6m3+hcQ2EI71Yevhe/bzXB0M+IxpVvXj/RQlnkTj4L+pUBdwwy2vYakhn6cxa5h8FLjpoKHzrV4SahMs/9nKn2PlGLS6zr5uJknnymReRiZBzCAIXtJbc78qkGRC2TmjpfAMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WPFZPb5F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xq5Q173A; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WPFZPb5F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xq5Q173A"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B12E71D0019F;
	Thu,  6 Aug 2026 03:51:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 06 Aug 2026 03:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786002677;
	 x=1786089077; bh=m4Wf5OMXb4hO3m0OWgXPtNXkpGG3jWn/phbZPpHlZbM=; b=
	WPFZPb5F2CH7IHr4WhEh5NjEf0KFcKgCtxoBHXzuiRWocB5PGkXp9ar8U62G9LdZ
	5oEI0IytodlSE8JDXylbE4xeOPasQgW7dys/7OHQUleJsvVho45/sVo971jCJr8u
	VbbcWlR/Vb4dxlrnry0uYsA2WMD5O1fIHozngw8R1n3ytv1FBXdeNOUkuDOZ1kK6
	EpbLomPMLTML3AffbotphyhQXSvfvcOzxXCfGhqUm3Zu+OSEx44gn0SN/NZpAAIR
	L17Q8p12DhHz8L6EZkHDCHNqSEWqdjy+ngNHZEMDejOI46wBkbonx60uYzMFzrI2
	ys5gpYlD+3NOiPW9vJbw0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786002677; x=
	1786089077; bh=m4Wf5OMXb4hO3m0OWgXPtNXkpGG3jWn/phbZPpHlZbM=; b=X
	q5Q173A7RiVqSZRbm+GAUqcX+6A10q2NlU0wUEYdpbWuo02M1QMSIXBqNPzXcSxI
	UIv703AxxwX1U9CtzF7XKpK6P4m1I/OD6rCSULfqdEyQDkp7qv+xeqs5KwyIbkRG
	wVvIIkjAZobyIurmV5IJvsc0Oc67eenAzWTB97tC5rjBRCYQifurGcHQbqoLP5ms
	EuY4pPOogG4yw8FGJse+WqBlq8fI8s/UzPO2xudTY4s4sbyKFBzwACZo/EOYHdLR
	jVsPyuDhn17AXCA31QKFPNC5MRnB1v9SsrCAWrrm/ZWiekQJPtqu39IXXbsc8aBg
	xGbrB2t3u86ryWun+tZJQ==
X-ME-Sender: <xms:9Tx0aqqF2hEZsvOBa_FALH-ZdxxPCpkY4LeCKwwqPmuJxQZpEZcYgA>
    <xme:9Tx0avplCPYhciIn69GdCOh7aOCVfegQe_PCVe7Gm1fU7o7sjrx-5ELY7U37Ka8bS
    6mmFupeI3Dk_xUJ5wNRqKYkVituM_TiNYgu1aat0E60-lLc15YCgzw>
X-ME-Received: <xmr:9Tx0akMVlIlzq0TTKN4tK19HgAx3OJuZd4_5d0Q0aUlIK3Dlpxw_N6swJUU6vrflNwZGwjlSXGyIYYx8N2aqF6EENbwtSKGH3XnZmx4-Ad4>
X-ME-Proxy-Cause: dmFkZTFBN7xbBgla2U/+r+ckfSvCUlVky9++sxcZ+p6LL50ntOX5+FLTsDVRiZ20eVaAUU
    h16YOJMnDiuG+KR5q10oHfOv4BwKd8GNH36ZQihNr9kJZAos6qf1toMXE1uWK9JSi8rjx2
    l2qj0boS0Ncgmc4XuUJ3TrOJBRuremEn2slLm5DB1gDdxxF6a5m63U/qCzieqCMoFenthN
    zFlKV06LdfwwiOQRyyAmYiqNa42xuBMnTsXLJiA//iBJ3qKfZoRvMvem09ReoJf9tlZglw
    MjisNSbMilxa3KrHFDWH30KlTKq7b0pIzogQpexr5MFRF6BB6cS32lScu44VjcK5cWLFpm
    xd6rNbHZ87nXpe7dtxu3dvRI+WLa1rnIRHqly947CMvWl8ZmcqSGnoeU7xeKaq2kQ2Hl/O
    DsJOVCF7BKme0fDucalmOgNwRu2ZgpKWrZ3epLkgbqLPw1UuFVRM3idGixmoNMHsd8CGm3
    pPovgo4PhW6R9aP2aL50fc52ckof2wLPPnMPG1ln8GS4advrXhO2Z0R3ju3hVCKpNDtPeg
    7IERU1cbfIYxmhLmwzT0Jjjk3EVmIuWTg+uLDucPzH1n2tsJzTvgM0LbhIQhL2dPeRHikA
    Fd5lcbH2hF4axxB5h1Ryh7IushEpXwFsYn6kZO3HlKNGcltd8EheYjHiksFg
X-ME-Proxy: <xmx:9Tx0aoxNCywlDQERSd1_LgwCNIxKLCKS60REZNMB04bUPUSH1zz0pg>
    <xmx:9Tx0alsCzXrhOkGQRuR5X_T1JViqEpseTgVj82E91qLp--GTRgSqOQ>
    <xmx:9Tx0ap4Q4t0Oiq-U5X8z9_9i-EwQMNO2y0CLJMWD9oLMdSOcUgKjUg>
    <xmx:9Tx0asQawnG0-GCSTFbkrmDnxAEYgRGnd8qME4zRbr5jC3PaiTHTtw>
    <xmx:9Tx0alOO8D7geq_Z-BZAb0fHtITr5EILcDX8qSLlhThi8tpa_Ga9oK7v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 03:51:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8b32e06b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Aug 2026 07:51:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Aug 2026 09:51:01 +0200
Subject: [PATCH v4 3/6] setup: handle ODB-related environment variables in
 `odb_new()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-pks-odb-create-on-disk-v4-3-ba8b4fdd2e3c@pks.im>
References: <20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im>
In-Reply-To: <20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

When initializing a repository's object database we have to respect the
GIT_OBJECT_DIRECTORY and GIT_ALTERNATE_OBJECT_DIRECTORIES environment
variables, which can be set by the user to override the default location
of where we write objects to and read objects from.

This is handled in `apply_repository_format()`, which is fine. But in a
subsequent commit we'll have to defer constructing the object database
to a later point in some cases, and that will require a second site
where we call `odb_new()`. And of course, that second site would have to
handle those environment variables, as well.

It would be somewhat awkward to duplicate the logic though. But there's
a better alternative: instead of handling this logic in "setup.c", we
can easily handle environment variables in `odb_new()` itself. This
ensures that object database creation is neatly self-contained, and we
don't have to duplicate any of the logic.

Another benefit is that in a future patch series we plan to move
handling of alternates into the backends themselves [1], and that will
require us to also handle those environment variables in the "files"
backend itself. So moving the logic into the ODB level already gets us
one step closer to that goal.

Refactor the logic accordingly.

[1]: https://lore.kernel.org/git/amLgMqkqxR8mKIbT@pks.im/

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                         | 21 ++++++++++++---------
 odb.h                         | 17 +++++++++++++++--
 setup.c                       | 11 ++++-------
 t/unit-tests/u-odb-inmemory.c |  2 +-
 4 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/odb.c b/odb.c
index cf6e7938c0..ed1d63f4bd 100644
--- a/odb.c
+++ b/odb.c
@@ -1004,26 +1004,29 @@ int odb_write_object_stream(struct object_database *odb,
 }
 
 struct object_database *odb_new(struct repository *repo,
-				const char *primary_source,
-				const char *secondary_sources)
+				enum odb_new_flags flags)
 {
-	struct object_database *o = xmalloc(sizeof(*o));
-	char *to_free = NULL;
+	char *primary_source = NULL, *secondary_sources = NULL;
+	struct object_database *o;
 
-	memset(o, 0, sizeof(*o));
+	CALLOC_ARRAY(o, 1);
 	o->repo = repo;
 	pthread_mutex_init(&o->replace_mutex, NULL);
 	string_list_init_dup(&o->submodule_source_paths);
 
+	if (flags & ODB_NEW_HONOR_ENV) {
+		primary_source = xstrdup_or_null(getenv(DB_ENVIRONMENT));
+		secondary_sources = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
+	}
 	if (!primary_source)
-		primary_source = to_free = xstrfmt("%s/objects", repo->commondir);
+		primary_source = xstrfmt("%s/objects", repo->commondir);
+
 	o->sources = odb_source_new(o, primary_source, true);
 	o->sources_tail = &o->sources->next;
-	o->alternate_db = xstrdup_or_null(secondary_sources);
+	o->alternate_db = secondary_sources;
 	o->inmemory_objects = &odb_source_inmemory_new(o)->base;
 
-	free(to_free);
-
+	free(primary_source);
 	return o;
 }
 
diff --git a/odb.h b/odb.h
index 7995bed97b..8ec335c7f7 100644
--- a/odb.h
+++ b/odb.h
@@ -100,6 +100,20 @@ struct object_database {
 	struct string_list submodule_source_paths;
 };
 
+enum odb_new_flags {
+	/*
+	 * Honor environment variables when constructing the object database
+	 * sources. This makes us respect the following environment variables:
+	 *
+	 *   - GIT_OBJECT_DIRECTORY to override the primary object directory.
+	 *
+	 *   - GIT_ALTERNATE_OBJECT_DIRECTORIES to override alternates.
+	 *
+	 * Environment variables may be backend-specific.
+	 */
+	ODB_NEW_HONOR_ENV = (1 << 0),
+};
+
 /*
  * Create a new object database for the given repository.
  *
@@ -112,8 +126,7 @@ struct object_database {
  * Returns the newly created object database.
  */
 struct object_database *odb_new(struct repository *repo,
-				const char *primary_source,
-				const char *alternate_sources);
+				enum odb_new_flags flags);
 
 /* Free the object database and release all resources. */
 void odb_free(struct object_database *o);
diff --git a/setup.c b/setup.c
index 825572f5f1..5dfab3e79e 100644
--- a/setup.c
+++ b/setup.c
@@ -1765,7 +1765,7 @@ int apply_repository_format(struct repository *repo,
 			    enum apply_repository_format_flags flags,
 			    struct strbuf *err)
 {
-	char *object_directory = NULL, *alternate_object_directories = NULL;
+	enum odb_new_flags odb_new_flags = 0;
 
 	if (verify_repository_format(format, err) < 0)
 		return -1;
@@ -1779,8 +1779,6 @@ int apply_repository_format(struct repository *repo,
 	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV) {
 		const char *shallow_file;
 
-		object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
-		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
 		shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
 		if (shallow_file)
 			set_alternate_shallow_file(repo, shallow_file);
@@ -1803,11 +1801,10 @@ int apply_repository_format(struct repository *repo,
 	repo->repository_format_precious_objects =
 		format->precious_objects;
 
-	repo->objects = odb_new(repo, object_directory,
-				alternate_object_directories);
+	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV)
+		odb_new_flags |= ODB_NEW_HONOR_ENV;
+	repo->objects = odb_new(repo, odb_new_flags);
 
-	free(alternate_object_directories);
-	free(object_directory);
 	return 0;
 }
 
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index 6844bfc37c..db323e10fd 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -38,7 +38,7 @@ static void cl_assert_object_info(struct odb_source_inmemory *source,
 
 void test_odb_inmemory__initialize(void)
 {
-	odb = odb_new(&repo, "", "");
+	odb = odb_new(&repo, 0);
 }
 
 void test_odb_inmemory__cleanup(void)

-- 
2.55.0.679.g6767b8d81c.dirty

