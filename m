Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824963E51EC
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832209; cv=none; b=QaaAOQAbHy0AAOmAANBVzNQIozEwOf5pZyBDR46ObGe/5Mp9do1iIJJzvOPclC4um3r6yQOBalfenQ6tA8qqvuu1ihuN7DY6Xfr+rI1T6mFQuwZlposDln8E0G216qAAU5t4D7JafdFj4jl8HStOyWa6PQ+uVKK4ieX23Ine+lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832209; c=relaxed/simple;
	bh=Laphd0cmyzVO4iu7OskbY+T1377tPZOkpoOXzagAy7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GnixZkUkXCaE7ZpjayU7pu4z/vIPP4TUROT6ByXANTXpOF4Fxeo2V9GqnoCrKYVY2nigPvlNHEWw/Ok3ECELAz8vxxpMqh1v1HPCmSezla/O0aYZSjjMQ8GFb34w7KyncEzpipDIO0GBRS4aJ0z73v1z+LTrKf1YAhWrPQt+DWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hVtQWl8/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gPkpjypH; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hVtQWl8/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gPkpjypH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4BF541D001AC;
	Tue,  4 Aug 2026 04:30:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 04 Aug 2026 04:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785832206;
	 x=1785918606; bh=KlKq1HkChS9+LJ7Yo6/ERKF7McH7u4lg/IoazJC2YR4=; b=
	hVtQWl8/lYz8DwQe4ft9fkM175ygnnZQmdvrmeo/3pxYgW5pH+Lo58Q1PSA44Ffx
	7AzMJ18P1u562q69CEtBt2JLe7bPDBEjMwe80nHzvqfJCMgacflYj5B+VFmO4oG1
	lzMEbaSJoIsMD2oqf/3qcy9Bxo87+2p94zVvTF2u0hmjCByVAdzhvrne58pGuWhd
	yIaiLJiHyQdxu145HRceS5mbk5D1oSwzY3g6nCxm5yN8aNdKrd6bpN/sFEoHYuA+
	RGy/fBtsfZlK1wwHiRMjKFXD91BuqJd77xc+0ZzczlSKnnemd9eBuo/0cgswbs3J
	MWKBseWQNKiPUlxNzwNKKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785832206; x=
	1785918606; bh=KlKq1HkChS9+LJ7Yo6/ERKF7McH7u4lg/IoazJC2YR4=; b=g
	PkpjypHMzPaJcLRyV0GwpDGF/4Abx29ljQmSwrYpOCrsTzwDZ2CbsF6vldYfyurw
	1ntz7r6NjfZFp7FBahTAWjhPIkGBLehGnWY0QqJNIXDPo+AtDByoTmwlzmpSB7+n
	UkAXkgXgU4ABLFtQpMVtRP7U8BczZulOjTQIIdHZDQoY0daLVCDpCpGpIoSeNSns
	nr6RoQ8b2dLANDq2IVjJiwyWZGH/pIIje9KXVAt+rGx9qXgRi06D74M5eWPHm1//
	sz6oBabYj6mwhm1ps+2ZOyCFL1fhPq37wMIlSk2/HP+6yvpjAp2BvKPSjYar2I9F
	uLeRJqr2gH5VkrrKc55Cg==
X-ME-Sender: <xms:DqNxaox5UQozxqG4dbizMLKIKShprTjI0E2VhghJ83I5fk2p4i1oFQ>
    <xme:DqNxajRJI3BH3oZRDAOmhntrtOfp6FBBhMPkYrsx4yEygygL9mJSM5CRDIJ79kXOl
    Z_S18Kuvsy_DKxm_TZVy10Gm6Fw6aHRysW3cXRFHPgDS0CuSt0jONw>
X-ME-Received: <xmr:DqNxavXwpHQuPLg2O7uk_zojNEt0dv5SQaYSgJLbPeOKdKNsKqvGgmyCf4aKS6UuyGlTSHKNoun7QJWmFJ_zVu5X-XWwExi3eDt0FNZ6>
X-ME-Proxy-Cause: dmFkZTEbgtzG3LVU36iLnTJFOTKaJnVb3Xpa8gL5U4HxfIGy3b8t4xIrlpDR2DpqRIZvzf
    n1NI56hVabElJrPx6MSMtz1cn1wl+/2e6XDDCQz5bBcc7tZPYbMw6N04VMFOLBi2SKlZCi
    bIg2EyW+/zEy6CTrZbhGwQc/+oDHdUmiW5xr3HKqR+v9ls9TXLukerfdzTR0S7RkaDq84C
    Pr7XwrqTs0UBCsvWclzxevhVY9QLcuIyCKGZfoFXEvWt3uFBZ852qzUxPP9qmgChakaEfl
    TykiJDiQj60J06EdA2jtQ7uStMrFkhicj42WfaCa9v3sW7CnzNa4vaxT9e6yFwS4In4Jsv
    0CZOfVLiKuBwBsG2DMkXoj6EntMcBtDrB9ExrFSy2AcCJJPTBSWef86C3AXwE/2nBFfZx5
    in6tDuB4peP61qqt+K2bnmmDk8p5WqRr+g6MhnanRqMe1L3MTphFCOS90dd0KriufCnN+1
    tUQIuj7d1wwSl7ix/km+p1EkgD5ifsXzj2p1MvbjzkGT13zkdNYXv9u6vdZ+rVvlpCo/Ra
    STTtq90HIMPk2/Mp0C6pxLaLlVgzug9KJqFm150jnfx+aF3ya4pzczmFPrEWfzE9vx/mUK
    Z57Jh1j61psskGs4kvQ/3XA1zE8oM5hO00/2/s55u2BJoduucIqLaZkrWCHA
X-ME-Proxy: <xmx:DqNxalbEskt5m3owy1GuC3tPzWX1KKs1CPAela8lXMdWbEIpo-ootQ>
    <xmx:DqNxal0SDBh2urfpgXG_musDD9oeW5pBfhtd5AC_9XWI9hi7KWl2Cg>
    <xmx:DqNxanit9fe0iqWlAb6kU0X48aSPpzfpQPahcN2yJ_0NCIEkh4NORw>
    <xmx:DqNxapa__88aLFllTumQQNx_xAhzLV1hlv0C4oeT-ZBoL9plhauiiw>
    <xmx:DqNxauWFfXE9X2uj4vnBgXvkZex1_Ls4MtH4siGQ4CYCUN-CmaKmtfRB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 04:30:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c3afd6ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 08:30:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 04 Aug 2026 10:29:08 +0200
Subject: [PATCH v2 3/5] setup: defer object database creation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-pks-odb-create-on-disk-v2-3-ddf8b59bd207@pks.im>
References: <20260804-pks-odb-create-on-disk-v2-0-ddf8b59bd207@pks.im>
In-Reply-To: <20260804-pks-odb-create-on-disk-v2-0-ddf8b59bd207@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

In a subsequent commit we'll make the creation of the on-disk data
structures of an object database pluggable. This will lead to an
in-between state where we have already configured the repository's
object database, but it's not usable yet until we eventually call
`create_object_directory()`.

Defer the object database creation so that we handle both steps in the
same function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 35 +++++++++++++++++++++++++++--------
 setup.h |  9 +++++++++
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/setup.c b/setup.c
index 825572f5f1..a7b1b9eaef 100644
--- a/setup.c
+++ b/setup.c
@@ -1760,6 +1760,13 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
 	return result;
 }
 
+static void get_object_directories(char **object_directory,
+				   char **alternate_object_directories)
+{
+	*object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
+	*alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
+}
+
 int apply_repository_format(struct repository *repo,
 			    const struct repository_format *format,
 			    enum apply_repository_format_flags flags,
@@ -1779,8 +1786,9 @@ int apply_repository_format(struct repository *repo,
 	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV) {
 		const char *shallow_file;
 
-		object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
-		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
+		get_object_directories(&object_directory,
+				       &alternate_object_directories);
+
 		shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
 		if (shallow_file)
 			set_alternate_shallow_file(repo, shallow_file);
@@ -1803,8 +1811,9 @@ int apply_repository_format(struct repository *repo,
 	repo->repository_format_precious_objects =
 		format->precious_objects;
 
-	repo->objects = odb_new(repo, object_directory,
-				alternate_object_directories);
+	if (!(flags & APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION))
+		repo->objects = odb_new(repo, object_directory,
+					alternate_object_directories);
 
 	free(alternate_object_directories);
 	free(object_directory);
@@ -2654,11 +2663,16 @@ static int create_default_files(struct repository *repo,
 	return reinit;
 }
 
-static void create_object_directory(struct repository *repo)
+static void create_object_database(struct repository *repo)
 {
+	char *object_directory, *alternate_object_directories;
 	struct strbuf path = STRBUF_INIT;
 	size_t baselen;
 
+	get_object_directories(&object_directory, &alternate_object_directories);
+	repo->objects = odb_new(repo, object_directory,
+				alternate_object_directories);
+
 	strbuf_addstr(&path, repo_get_object_directory(repo));
 	baselen = path.len;
 
@@ -2672,6 +2686,8 @@ static void create_object_directory(struct repository *repo)
 	strbuf_addstr(&path, "/info");
 	safe_create_dir(repo, path.buf, 1);
 
+	free(alternate_object_directories);
+	free(object_directory);
 	strbuf_release(&path);
 }
 
@@ -2867,9 +2883,10 @@ int init_db(struct repository *repo,
 	 */
 	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
 	repository_format_configure(&repo_fmt, hash, ref_storage_format);
-	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
+	if (apply_repository_format(repo, &repo_fmt,
+				    APPLY_REPOSITORY_FORMAT_HONOR_ENV |
+				    APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION, &err) < 0)
 		die("%s", err.buf);
-	startup_info->have_repository = 1;
 
 	/*
 	 * Ensure `core.hidedotfiles` is processed. This must happen after we
@@ -2885,7 +2902,9 @@ int init_db(struct repository *repo,
 
 	if (!(flags & INIT_DB_SKIP_REFDB))
 		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
-	create_object_directory(repo);
+	create_object_database(repo);
+
+	startup_info->have_repository = 1;
 
 	if (repo_settings_get_shared_repository(repo)) {
 		char buf[10];
diff --git a/setup.h b/setup.h
index 654f10e059..e55d647b70 100644
--- a/setup.h
+++ b/setup.h
@@ -241,6 +241,15 @@ enum apply_repository_format_flags {
 	 * relate to the object database.
 	 */
 	APPLY_REPOSITORY_FORMAT_HONOR_ENV = (1 << 0),
+
+	/*
+	 * Usually, the object database is created after the repository format
+	 * was applied. This step is skipped if this flag is set, which leaves
+	 * us with a partially-working repository.
+	 *
+	 * This is useful when initializing a new repository.
+	 */
+	APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION = (1 << 1),
 };
 
 /*

-- 
2.55.0.679.g6767b8d81c.dirty

