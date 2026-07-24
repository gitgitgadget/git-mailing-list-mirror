Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB2F2EA732
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784864952; cv=none; b=l1iIrf2lXnNqA9eU1SHDdIN7k75cCsNcF6E/GcygFTKuUhBYaJMncpIL9OaaVA72eFriObV8VlpkzcAcNeraTL0l5aavQ+pvHgNTJIQOHB6qVmXBLBOFAw/8PfOJP+vRY5BVIfpX6jMPrpgtSU6WvtArcHUf671aHvn9a7aImO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784864952; c=relaxed/simple;
	bh=CavY69nS4cIYj2omx6oYDTz6SWzbxwR0bQ4yiGUKsmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QqZpzSDJXbl7h/yaIGUCyZK3LJ0mS0xbk6KV/qqlYxwKqZoTbMhfeo2cvjSbjqv6IrP/alrcC3M8sxLngpUCPznAL8ddJGxBnFNSXGZIY39LaIv36q+szZPN9GFyD/K9nabwcLyA7Vj4FPFcFG/v73+rAzGbRBNqn6DqJfMKvdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aE9Mmi3D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DjPW8F12; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aE9Mmi3D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DjPW8F12"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 560167A0302
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 23:49:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 23 Jul 2026 23:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784864950;
	 x=1784951350; bh=QUpkxYRIKdS6RhHGnn8kMWc4cmwwzORGk1z0psPVBx8=; b=
	aE9Mmi3DK/X12KHH2hjrme806WDZQZTN0h19zMM8zvFoBbEi12zEKhpn80cm9rX9
	J8EwvqoCnbHErkC3iskV18R9m7B+qOB9e6zloLiGqlmwckWFxanqNsDWlk2DafYZ
	DbhaaoVg724b/YgEtFqFQ80COrNtCCa8P07W4q+M8svdRpnxK2jHtaPpwft5Z0bP
	NAnXcwdG3hqslxMR8aJkAwj9C+74b1R56HSLmGTbTzt62vXaZL5LuRuNbhJGJyBq
	6uVZg/JJLr5yykDpVmE1p7b1DjEoUirNb6aQ46//GyOq6tAud8JiMzC64Zo825Kw
	X4UrOcGt2b3Ug7b1mNrRtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784864950; x=
	1784951350; bh=QUpkxYRIKdS6RhHGnn8kMWc4cmwwzORGk1z0psPVBx8=; b=D
	jPW8F12eQBcim7idr+HrzzpQSuvplyZ2BdqaR/lynwuqiPNRWLZ0mFkTbaVkvmXO
	MQDaLEVne0DU4Ev7KuoM2WzyUvJVKN+6p4uMXc0+X7POAQwwofKp5V811kmO4H5v
	Yg29URQcGP4J2s0wYaZiq5IXjDJTt1MlMIYud26iz5/hdJ8E+Oyv2gYHg2Qw+bt/
	xGy+inOgMmsNbe8jasb5iiQpy7ME97jbZDW+PkeU/iRRiKdls8VZkkSPA4h0VmWT
	dOdqDzSXAlTwQYC29uN0mKbQJnd3Ysa/9Fs6QLB1RBuniU/So3M08SIYqiu6Go+E
	ytuqBBS2khGZz9IkYwsaA==
X-ME-Sender: <xms:tuBiarRA3Jl_t3uQtKkmpwB4WNumUUxY7uhV1i_n79XrDYYU174xuQ>
    <xme:tuBiajtZecnRjIFlxhXasQ5RgFC5YV6rvu8vjnPSm99GY_g5BV0RpbtEtfvoGSHNk
    L1K_072oBgY8eP22EmP4AeWDd-i0rLl2EbFmX-oQK1zfVWdi7uvTA>
X-ME-Received: <xmr:tuBiamdrXLf9AfwkvtyNMAYJWxZHm5-dumNuCjlcXcLtTbKWGckIM3ourUebT0z85BHvb_WowrLXJCeN8xtPLb7bN2I4J3CCGO2rR70g2qo>
X-ME-Proxy-Cause: dmFkZTE5s95v3MzVKQuLlCTgOtPWE8JcONB5mmSXhBqplzdEVdd7Ehq3xPjm0jRh0piJX2
    CwP16BgnGF0m9IFR2U5wfCOiIhSa255qQ7DR8RVzg+0iAYlP8HUBWf1EVQ7AfD0z8z9Mbb
    1zYtRib+CS36c1eL1cYkrmHZorcRqJnlwdECry7R4UpejVTwwopDELYjtgbsaYBjFUL6Nx
    3nVmt1DRxGNd38ylaILnoPALP/ruZEKWX9GHMavZvBRhixncs+YdNerSlM5pV1K+/xAsBg
    r6v09i46+IkAysRiinJE6ln5UjaSoJSymPgm+su0DcxydCpzq59XKEtyz+DUL/G7PLH7Y5
    ++yRZV6owfb3xMhFae7t5gzvD/c6TLwhYTfwRVlnD0zZ9HqMSzzvXftT0g5EPUFg/zs2CP
    eRNcA+w9jV/Qp5/+6b+5NgmMe8hgE9iKvQ2SbaIvcheLk+WBmti1Xg0gXx9lwzyUm9yBwV
    bra2Cw9xOXDnX+wNNEkmFnE87qkxUbU7oDcIZicxseD48rM/1+ApHcEDVw3BvsYNfAURhA
    XcJg9Jkbcz5275VvJJ4P831Apq5YwNnq6bdFC+7N7iRq+A8FWNWPwrtj6TRlGICVzppmfQ
    QszoMwE9/B2Xmq3Ss5aJunMhbtp/Y6bupXa47lrU0okgH0KRscFOWvdWfYTQ
X-ME-Proxy: <xmx:tuBiagLGQdjeVnIjfKvMUF6ghF7VimVv1L1y3UZpwNTForEGWgEtCQ>
    <xmx:tuBiakYQ5BIJ_v8QnMaQMesvyLghlpc0xukQ6bSArt7vDWCGpZEPnA>
    <xmx:tuBiaru-7GdJpNIxnEWMFo7UNvj-iMi1J5VzNjr8_fv-07a7sRcHLg>
    <xmx:tuBiahtBjABXMZavb8VxIlZ5nzaNd1jbhRkSbdNmNzoP3EMXDx1hWg>
    <xmx:tuBiavSZG0cCygMd9vR4E_1O_2AviiLXFXyr2aM8JC7f4gr4Ohr-6wsk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 Jul 2026 23:49:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4dbeef17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Jul 2026 03:49:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Jul 2026 05:48:42 +0200
Subject: [PATCH 3/5] setup: defer object database creation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-pks-odb-create-on-disk-v1-3-3b3d265d979b@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
In-Reply-To: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.55.0.407.g700c83d4f3.dirty

