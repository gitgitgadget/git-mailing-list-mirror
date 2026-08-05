Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771B3EAC84
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922149; cv=none; b=OLHQJkKtJ67TO/At08JtNYBtqAWkdlGL1A3kZUq1dEZf4iqRMTQQiNxYeDMr4NipooMyPf4rppmN7uVzKnpNxQBI5P1jxkm5M4Gyqff78MESedJiJA5RQGWimyi+z98v2GvovpYqSM3/63Fggsl+jhJiSiLjvQH+otU39RHxRu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922149; c=relaxed/simple;
	bh=eyLBM8CvEjreYshmPvRSYJ9Ae2s/7rq32Kgf8/HtMbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=owuXvDD1e8UWpBOIG+j8+HZNaIWlRFgRnX2i4NcGm6QTh6QbfHrRJx05W1igmMedFH6ypNl1Q4E0sjHrKFGXoz5xi4DNBqAArlHnn5e/eUQ74uMmAvPj1kAytavC9W2NcylZb7u1w6Rct2RFPCc80INL++8P22ujShdPpLGt+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NHFD+wfV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f1kEBGHd; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NHFD+wfV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f1kEBGHd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 57248140017A;
	Wed,  5 Aug 2026 05:29:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 05:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785922147;
	 x=1786008547; bh=dnqnCUf99ZAM0rUDDaxZ5z7UvEUsu8CT/paRqpSGUXY=; b=
	NHFD+wfV3C+QwNcVT1wZVXuqsrg99NvulcZvxBUENDw4HSm9hRX1zSd9RNja+/Rr
	sIdBFfDh1bU/p5S0fCBhiw8fKb2apPxnsuO6QZih+TsMVGBA+IwxxFHpBeOMT02B
	KF3ZMdsA50MR8WZ+dzyKZKVSMC4bPaVmtzrsTQpMd3GssdCmqZh07FflRm0xmpiv
	ZG5pcgasZ/4OeqonMV0kRVlImWVrW6ZDfh4RuCUGvvTEhBqaLdJ2PEdkP1q6bCZU
	uT9JopKfFU9Un6OeLYPEgb6yo18AmlA5LgGNJ1oYaP+3JuZv1Rl4JoanQcOKXqCt
	MyrmEsYI6F+ZrUzN+sestA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785922147; x=
	1786008547; bh=dnqnCUf99ZAM0rUDDaxZ5z7UvEUsu8CT/paRqpSGUXY=; b=f
	1kEBGHd37FLdKL5DAty/YwhWteMWnEmSdJ2u2PatuvjVHPwFPCjgiA3AQIPraURb
	yq19Zj/RWlphq5hSSyWgr5313bF7FZTOA914K4gx7kLNjeWCelayipuqCkWPJTzW
	GwbtMCSPZeJTle5GPZQHHijuBDsFfdk8FAaSzNKmrBXgSYbCdTVYTi31bgEKYt9G
	QPCciM0jdQiMZuyfbTaIs4e3yc+UoiOSZAZvRJVsSBIZPrWlxJ6ZifbbJvVbGHAB
	pzbukK/nZhGPFnx6NkxmebcfYlQitd93kjx6TlPugJp3RKk6Dqmb/07uv6bcLPi8
	OUFD7K3CtIA32mH3AwN9w==
X-ME-Sender: <xms:YwJzaqopA3RVqTZrjzpwlDaeGc_hQLqBnGTY9YKRncmLv2qvis4l-Q>
    <xme:YwJzavo5rnTM5i7kUxC1AYMYaqljXsKfdRw_604ytWWqygetnM8QxRz-UpD-9w-lL
    jHb4pOq125vxpZ8DUOjfch8wlgMUEuMWEcOzHy3LL_Z5qP9XjZXwA>
X-ME-Received: <xmr:YwJzakNZp-IfpcSZ-nferisM4ZWmY_SApyrL6pz1eMXSV3J7lZOqcEw29kQ--6d_YS8b9O_1sRmimccvSr9gst0pz7nXV1zvK2qtcZLKpA>
X-ME-Proxy-Cause: dmFkZTGCg08mHnbL6Ku27mFVSg/gOaDjs+UcofcoeicjzOTo7RVd5XldBXHrGU8Zx4/s/F
    rVjJCh+2b4YSdHxw47pAUHRHb8BO5/XYSWCyoc3Zr9gW/g5A+R9L8BYHfKkFeQKuBQRfuh
    5mfpfrXfymHk+ZvVpfB3g/IO2R67idCH1iPaHh+Ku5r3ADVW9q6EYGcLa4mLO+ID9N1Syb
    aLMdP0l3soz4nGz9sDXKDvxrN0TOqtVFLbJJebgtQw91fhP8R076d/BE4mkGLQnt6EpP16
    aFljR4Q09yRbloFlFRR2cZSqGrLUaiMljDj7Z2Wt+itNK/qCuMhsxm6ETIIyMOYcp2C/Er
    Jb4wj4eFZZZ4eI6kRCZK69hD1NCfCB8mRSnmWdMXo/C76jRWzdfd+x7CUUFdNx7c0pY/ty
    gtz6TmA564uEedVaXhhbIg7IBXjRBwvmLeKs/hWIiLSNGh+/V+W11fY7+NIIc0dCxRrSNW
    ccS8RRYCZoXsGRU+UKTtCZggyDYsMsQffn6wjdi3WbxvBBCKpHkZhgVCEWYXuV3MEVx3sy
    ClGJf8n7MoRfiiAmVFXI3Qcjsexr+/ozpZ98RqbTo1kBSCMX+UTYmwiWlwwsieoEkNrIui
    CbKiKXvVAwZckQfGAwRdERVLPxYbvmI0fUCj6j0AWasZ9PJJWxel6m8SJsxg
X-ME-Proxy: <xmx:YwJzaoxBVxhuHJY2AkWtxigWIqdO6tW2UMa1T_zo-RdJabiCoc-G4w>
    <xmx:YwJzalvmW0Qf0POqyqOCGDA_0cZGGJxhi-s5TtQhOOUga2KIDEWxrg>
    <xmx:YwJzap4kkUDuE1dVLjYnJY359yBswf1IBTmBNARM_2kZpZlDHl0txw>
    <xmx:YwJzasSeRTKDvIzE51A6_MtMPWQD92Q64Mb_nBI0tu_Sd56Kz7YgFA>
    <xmx:YwJzalOSjZnfH7Hw7ZkTpnCmjSzDFLXP2UokikRk_ezcg_S9QNCmTVxg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:29:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7eca9aee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 09:29:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 05 Aug 2026 11:28:53 +0200
Subject: [PATCH v3 3/6] setup: handle ODB-related environment variables in
 `odb_new()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pks-odb-create-on-disk-v3-3-c0ee3ac5141f@pks.im>
References: <20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im>
In-Reply-To: <20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im>
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
 odb.c                         | 20 ++++++++++++--------
 odb.h                         | 17 +++++++++++++++--
 setup.c                       | 11 ++++-------
 t/unit-tests/u-odb-inmemory.c |  2 +-
 4 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/odb.c b/odb.c
index cf6e7938c0..b463afa072 100644
--- a/odb.c
+++ b/odb.c
@@ -1004,26 +1004,30 @@ int odb_write_object_stream(struct object_database *odb,
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
 	o->alternate_db = xstrdup_or_null(secondary_sources);
 	o->inmemory_objects = &odb_source_inmemory_new(o)->base;
 
-	free(to_free);
-
+	free(secondary_sources);
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

