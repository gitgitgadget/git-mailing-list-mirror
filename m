Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C291D3BFAE1
	for <git@vger.kernel.org>; Tue, 26 May 2026 05:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775045; cv=none; b=YzJQhAea2teEGgxcSXbIkh2y2ScWcVb8/4IJvKCRTZGP0awriAmLGttl/PLq0drRf6ICjOijTqK6udM88ilF89nYBtun0m1AK5nE0tonIKvI5vSjtjRAfDkKnV8q0GSFEA8oLeU3wfxIoDp7t6+WsPZPapxMaSrg1zWhOgGtTUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775045; c=relaxed/simple;
	bh=s+3bUtodUXbA2jjSTBsA7KhapyxyQBRAj7toIMAPFl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gJSGuXfM2oErtzIbZ03TBt4JISMmdCGKnl81IqFAB9EpdeSCzcpRmoxHhEMhUDe9S4zzt+91qRkmxmPfQNMFzmcwIUTfnVeH0uK9YAD7Nq2WJdHTKoROV46H+5YoYijNF8qcxZHcXM2fBelHfAnBrymQQQQvVDYjIEhJimGzbtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g9lRCh/D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=blStn6sU; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g9lRCh/D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="blStn6sU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 50FAD7A0112;
	Tue, 26 May 2026 01:57:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 26 May 2026 01:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779775043;
	 x=1779861443; bh=J/HP521Fb4tiinOUz4NYgbcmnkzaZ26imKaBqjmA4qE=; b=
	g9lRCh/Dx2s8BgnykBXyHa/vZ97AmFcDUUJA+jYOJtkpRDx1h9cIjjjkMQC/GWrv
	ZYnrufTuCOePnIyNPGwtTWNBOUalZW/TvMYyTdmLcUB0tyhTaJ23EkBoJt9KWjfW
	eAQMH9a58I3HVF2pkMxAegjhdCuz0M5vbeaXq2Ey94IFbqwFVjjR9N7qrO5DykGi
	Zy+NJ+OHFejKEIQnku9y5gTI5CyDAHG0s82YT7PpZEfQ/O443OKw/zoBSAIzcH6e
	HQDuWWYypCDHa14Nf9bb+3cvsZEbaaSJ81ZjEBY36T3QEPZmlDyeP9b7dTj876CH
	3t/M0iy/d7z9DzHDXYIFJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779775043; x=
	1779861443; bh=J/HP521Fb4tiinOUz4NYgbcmnkzaZ26imKaBqjmA4qE=; b=b
	lStn6sUEm+Hu45kG4rOrEYVNwNdbN5WLN0/OI6V8nQUflJOlSMxZree64tBWf8WT
	40HDECvMUQ5cslACU7rNFi3qcCi8IFOslHMa5Vm0yeUtlrC/M+aIsVoiNunBAT95
	o1iegZI1Ri0T1pHnpY62Qd3dpL2Ix17iGFKNNfigSikA20dEgS14GfCA2oV4XMAN
	pzW5IhyKxtnXF/m4dtsmeqRIVEPBIeuXhugqK5K130xaoQu7Ot0zjOfeJ1KQL4Rt
	ruRsLjlyFlz3y8N+j6Tx654mLNOyN9veGpilMjoELcvVMdjTyameATBujuN1ofRx
	WNscTRfc9sHpbJPsf2Nbw==
X-ME-Sender: <xms:QzYVaiD_5jMzsIf1cdzxVYzi5Vbt9uucY2IGPSZEBXp7N53UlSqONQ>
    <xme:QzYVaj9Y40Wc0x_5MMPbH25ppCVY31AMqAZAuwMtStDINrL49LKaAW7v5i9nw1xe6
    PrKjiNTvrCkLNjT0pCLxXYfUnq5uaxM-QlvKwMF8E4epR7VbU5-Gw>
X-ME-Received: <xmr:QzYVai81pzOSdp2Vn0YvTKc2bekmeKahHpTNX5RRERjtiE03Xt8flr9S_mTgSAU4hL_eF6lMZM5KQDJT72CcH9DcPCH3o0X_OUAjIcAlDg>
X-ME-Proxy-Cause: dmFkZTGKVi/YY8vhf7uHQZo7wdjnVIMcaXKRsnOhBVX4gOLRllOFGSs81FW/zVR6IvHQNc
    6BacJJ55kNRB5bGeD4SMBiYvXG76IWyUOYczzLeYxFfr9p1+yPq3Spy94MkhDLEs9ydojV
    mYPV4ge1dg4bM6T3JLl7Ikzudb8sDwbxt4joBFp9LZfcu4TfWKoOOm3dfgxgIfSm8XXXJl
    mHRKYwzb97fs2lE0zx+K5iMXBUrPbu5mdqG5GMJUBYKsav4QCTj9WRJaNzvXNSpbuTZIZs
    8esEzOzHGM7FCAUchFEf46tkEwfa1bBckehAtR2mFqjrmaWXX0sfW2WmIGsxcJFdkxugdw
    iDhfWGPsFU8rLN2lLgPhv+kjsAN+V+S8zF2SrYLfLAlz+r2aMnm9QYY2+vK7HK2kxRj3Ij
    /mljUH9YGKibCJWvWhPrRpo6Zu9yvfgUARm+c0wydQPSPlLPfaTHpxZLkuL57WTQ4zKdad
    1AqCrQ+e64zbf76AWKNlN6eR/FNJyQ6mSbUnj+xLby9DwxwIvpRjZ/Z00Bj/tBTMte4FGH
    iDG2ZeMVQXERO/JkquY7KS+J33Z7jbeWUj+zv6U1U3oM2jCDGq/9qQ+IJezxTZBgO4g5SR
    vCzBxCcZeV7DKWXQ37GVh6wQYzsyqg0cymGGHeu2EL6KqPiPTLMPK3CaoL4w
X-ME-Proxy: <xmx:QzYVaqdiGOosYNblnFDoKEgadgyn6Wzde8cb8FIxDWa-60FLQZI9ZA>
    <xmx:QzYVarGGWcO-q9xGoAN0ACAnqfajmgFepdm1QKZLBT-qUB4JvYbaZg>
    <xmx:QzYVaofg3k8j6zdHuIHvjWxmQOkxZEMlYycdQE-C8ET-J4qW0MCiXA>
    <xmx:QzYValHt5buFMNcQJktI8PZRoMPMZzRAk0OUaKUdoxY1wT2eF--fPA>
    <xmx:QzYVasHRAgcL1nNMreaNXLXZPbR467UtuPujDlT4BPrnVhRlvAklRF-t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 01:57:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8a06aa1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 May 2026 05:57:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 26 May 2026 07:57:03 +0200
Subject: [PATCH v2 8/8] setup: construct object database in
 `apply_repository_format()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-pks-setup-centralize-odb-creation-v2-8-2fa5b385c13e@pks.im>
References: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
In-Reply-To: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

With the preceding changes we now always construct the repository's
object database before applying the repository format. Remove this
duplication by constructing it in `apply_repository_format()` instead.

Note that we create the object database _after_ having set up the
repository's hash algorithm, but _before_ setting the compat hash
algorithm. This is intentional:

  - Constructing the object database may require knowledge of its
    intended object format.

  - Setting up the compatibility hash requires the object database to be
    initialized already, because we immediately read the loose object
    map.

The first point is sensible, the second maybe a little less so. Ideally,
it should be the responsibility of the object database itself to
initialize any data structures required for the compatibility hash. But
this would require further changes, so this is kept as-is for now.

Further note that this requires us to move handling of the environment
variables GIT_OBJECT_DIRECTORY and GIT_ALTERNATE_OBJECT_DIRECTORIES into
the repository format, as well. This allows the caller more flexibility
around whether or not those environment variables are being honored, as
we want to respect them in "setup.c", but not in "repository.c".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c |  4 +---
 setup.c      | 45 +++++++++++++++++++++------------------------
 setup.h      | 10 ++++++++++
 3 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/repository.c b/repository.c
index 61dfbb8be6..187dd471c4 100644
--- a/repository.c
+++ b/repository.c
@@ -291,13 +291,11 @@ int repo_init(struct repository *repo,
 	if (read_repository_format_from_commondir(&format, repo->commondir))
 		goto error;
 
-	if (apply_repository_format(repo, &format, &err) < 0) {
+	if (apply_repository_format(repo, &format, 0, &err) < 0) {
 		warning("%s", err.buf);
 		goto error;
 	}
 
-	repo->objects = odb_new(repo, NULL, NULL);
-
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
diff --git a/setup.c b/setup.c
index 4a8d6230b1..513fc88749 100644
--- a/setup.c
+++ b/setup.c
@@ -1752,12 +1752,22 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
 
 int apply_repository_format(struct repository *repo,
 			    const struct repository_format *format,
+			    enum apply_repository_format_flags flags,
 			    struct strbuf *err)
 {
+	char *object_directory = NULL, *alternate_object_directories = NULL;
+
 	if (verify_repository_format(format, err) < 0)
 		return -1;
 
+	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV) {
+		object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
+		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
+	}
+
 	repo_set_hash_algo(repo, format->hash_algo);
+	repo->objects = odb_new(repo, object_directory,
+				alternate_object_directories);
 	repo_set_compat_hash_algo(repo, format->compat_hash_algo);
 	repo_set_ref_storage_format(repo,
 				    format->ref_storage_format,
@@ -1773,6 +1783,8 @@ int apply_repository_format(struct repository *repo,
 	repo->repository_format_precious_objects =
 		format->precious_objects;
 
+	free(alternate_object_directories);
+	free(object_directory);
 	return 0;
 }
 
@@ -1785,7 +1797,8 @@ int apply_repository_format(struct repository *repo,
  * If successful and fmt is not NULL, fill fmt with data.
  */
 static void check_and_apply_repository_format(struct repository *repo,
-					      struct repository_format *fmt)
+					      struct repository_format *fmt,
+					      enum apply_repository_format_flags flags)
 {
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 	struct strbuf err = STRBUF_INIT;
@@ -1794,7 +1807,7 @@ static void check_and_apply_repository_format(struct repository *repo,
 		fmt = &repo_fmt;
 
 	check_repository_format_gently(repo_get_git_dir(repo), fmt, NULL);
-	if (apply_repository_format(repo, fmt, &err) < 0)
+	if (apply_repository_format(repo, fmt, flags, &err) < 0)
 		die("%s", err.buf);
 	startup_info->have_repository = 1;
 
@@ -1874,15 +1887,9 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 	}
 
 	if (is_git_directory(".")) {
-		struct strvec to_free = STRVEC_INIT;
-
 		set_git_dir(repo, ".", 0);
-		repo->objects = odb_new(repo,
-					getenv_safe(&to_free, DB_ENVIRONMENT),
-					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
-		check_and_apply_repository_format(repo, NULL);
-
-		strvec_clear(&to_free);
+		check_and_apply_repository_format(repo, NULL,
+						  APPLY_REPOSITORY_FORMAT_HONOR_ENV);
 		return path;
 	}
 
@@ -2034,8 +2041,6 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	    startup_info->have_repository ||
 	    /* GIT_DIR_EXPLICIT */
 	    getenv(GIT_DIR_ENVIRONMENT)) {
-		struct strvec to_free = STRVEC_INIT;
-
 		if (!repo->gitdir) {
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
@@ -2046,17 +2051,13 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 		if (startup_info->have_repository) {
 			struct strbuf err = STRBUF_INIT;
 
-			repo->objects = odb_new(repo,
-						getenv_safe(&to_free, DB_ENVIRONMENT),
-						getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
-			if (apply_repository_format(repo, &repo_fmt, &err) < 0)
+			if (apply_repository_format(repo, &repo_fmt,
+						    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 				die("%s", err.buf);
 
 			clear_repository_format(&repo_fmt);
 			strbuf_release(&err);
 		}
-
-		strvec_clear(&to_free);
 	}
 	/*
 	 * Since precompose_string_if_needed() needs to look at
@@ -2805,7 +2806,6 @@ int init_db(struct repository *repo,
 	int exist_ok = flags & INIT_DB_EXIST_OK;
 	char *original_git_dir = real_pathdup(git_dir, 1);
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
-	struct strvec to_free = STRVEC_INIT;
 
 	if (real_git_dir) {
 		struct stat st;
@@ -2826,16 +2826,14 @@ int init_db(struct repository *repo,
 	}
 	startup_info->have_repository = 1;
 
-	repo->objects = odb_new(repo, getenv_safe(&to_free, DB_ENVIRONMENT),
-				getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
-
 	/*
 	 * Check to see if the repository version is right.
 	 * Note that a newly created repository does not have
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
-	check_and_apply_repository_format(repo, &repo_fmt);
+	check_and_apply_repository_format(repo, &repo_fmt,
+					  APPLY_REPOSITORY_FORMAT_HONOR_ENV);
 
 	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);
 
@@ -2892,7 +2890,6 @@ int init_db(struct repository *repo,
 	}
 
 	clear_repository_format(&repo_fmt);
-	strvec_clear(&to_free);
 	free(original_git_dir);
 	return 0;
 }
diff --git a/setup.h b/setup.h
index 5ed92f53fa..821b55aca0 100644
--- a/setup.h
+++ b/setup.h
@@ -221,6 +221,15 @@ void clear_repository_format(struct repository_format *format);
 int verify_repository_format(const struct repository_format *format,
 			     struct strbuf *err);
 
+enum apply_repository_format_flags {
+	/*
+	 * Honor environment variables when applying the repository format to
+	 * the repository. For now, this only covers environment variables that
+	 * relate to the object database.
+	 */
+	APPLY_REPOSITORY_FORMAT_HONOR_ENV = (1 << 0),
+};
+
 /*
  * Apply the given repository format to the repo. This initializes extensions
  * and basic data structures required for normal operation. Returns 0 on
@@ -228,6 +237,7 @@ int verify_repository_format(const struct repository_format *format,
  */
 int apply_repository_format(struct repository *repo,
 			    const struct repository_format *format,
+			    enum apply_repository_format_flags flags,
 			    struct strbuf *err);
 
 const char *get_template_dir(const char *option_template);

-- 
2.54.0.926.g75ba10bac6.dirty

