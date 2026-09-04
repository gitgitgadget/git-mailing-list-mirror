Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19331471278
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518197; cv=none; b=aVHoEE6CCG4JNUu80pgK8bgf/7UE4T7BN1+E8VMWl0SzWjwTufQ/yoBIfgsnrSGKkEfVQeYlyMPAa2p+hbuxygUHA/YCNsfHJg92jGdDKvA/7WouT4HXCz+xF5tzMLt1SjUkNGl7rpZU278uynaOJb/D+6P0K35+VtIzRwFxDTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518197; c=relaxed/simple;
	bh=x4emB+Kr73I+gptSz5teUK06VPF9oKPs5drM/rMpVjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=riHnCDrHEuqz9H3se5v+Hkfyk/cnJl0RlWiY3RFdslNSMKfN/7UuwlHltMklzcjs2yQH3HZXr4dHQEKNG3pB2kJQXuqgRE5PwQdDLX0zjD0w5icdsVFfPyvFfJK8ltg/ZxAGx7C8/VA8Nr0XFjyHZOXwmM3HZYNO2SP8V0U2yNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DURuNogf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tlkZm23d; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DURuNogf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tlkZm23d"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E1FF67A0138;
	Fri,  4 Sep 2026 06:36:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 04 Sep 2026 06:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788518193;
	 x=1788604593; bh=Ywp/wCVJ01CoZSfRqNk1WCVfe7i+vYRfHSYFyKnK3zs=; b=
	DURuNogf3xhODd8VmUP9KfNJ2DoZWQHtzHmEPhUUFCWtqsSVAgSaGvK1pNX2TD24
	ta4tD5tTWGgrH0l488DXPcBuLbw26pFzt6bnjTe5XGvJhDKwBn8wWjSTaLqyWASu
	2vAhIJ2b8I8T5YsL7H/M5N9x8/cuG8dMwx5mzn9U+LAqjBUonkuolLgDMgMszVXI
	jb59JvNKEHTdlGVgNDUPldJ6MAdEWhQ30WeTj8txuZUqomes4GcPQ507LTHBWAV5
	LwtztiQAp1Te02cTgHxPXm+jZYns08pDk/znJD5J46+PoxWypZHU3HDttcW8S7FY
	W8Wb4t/Rg3cYM7NqItUcrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788518193; x=
	1788604593; bh=Ywp/wCVJ01CoZSfRqNk1WCVfe7i+vYRfHSYFyKnK3zs=; b=t
	lkZm23dzqfpXuLeyfmGyEV3oN/zZmUZRTVQYgnHVH1wbzPtlCnIDjOdSgICdtsk/
	EHylADjv84nehDGRuHz91/H2B6bcN+F6xRncP2KfKmmie3A16L7DTNRTSMwcWPek
	4QQ+FbwwvVPkj9fwm6hOILhl8nahFIu0Twlmr5b/Xal+ft1MDEPSvVvnuBz1wIXv
	vcGuN0Sgg/9+klZSPysieEbKA/FtBUdLNzADfwi3Io5tUjlUxf97xCa+r1cH/0B1
	5rVHUWXnvp2akjwJdjIvtKK7jeeHr7moLCaFwRsQ8atSNfhJ/RY8TsHqpo7a69nQ
	9F6oPvhCfI0gaTJ8Odb4w==
X-ME-Sender: <xms:MZ-aamfGLqYXnmuUGN9cWCmEoV8SZRhZrACQxm_K7kYCm3WQavh7xA>
    <xme:MZ-aamOjstkCP9vTIRGosB2_noJhTY9SzbmkVs6eUG1-h7DPfyxcUy7ootjDEDmOk
    Mk1GFTjGIKQzA4j-3gynwhMSHFXCjxJwJCPSsBa5h689B-BeAOIZ2s>
X-ME-Received: <xmr:MZ-aalJ5Z93WbQx53wk16iis8ooqx25xeColAniXzYCbUBxRFvDAWcfTEC4F9LaPVbeImg>
X-ME-Proxy-Cause: dmFkZTFg1zscDUhtkaa+SI4qnDKQNEnWpKaUkOf//4Gdbjj4+KbD6Qow8JDrxXD0Cy7WKo
    KnQLBlPLaNQwUpMLrMET8fHJ+Gk6+fVemrxr2V7ZvtqNNCZD/d42I1b6z0LanFEucaouOl
    MbC5U6kOWiKD4sN1WXfKtFwKXenssc16OmBlVcDWVTa8I2jf2yhPErDVvb2/T5SdQKIIsc
    gLseWZ6VHb/8ldkPjB6PO0Sh/V4d5WZbP8xXbu0lk/K8NCgYlmocQTQhDAXOB1asQQriHl
    uZfD8rFzpY3/Q4P3uNHrPsVd+io30P8Lu+JkWdEgYzcF0I6/ckMHnOzzzucim5bg3fh7G+
    SEToTJkVVIoseoYwhZUsKjpizKE/JsZSEp/UjuaCS9YCC2r17yQ06Q4Y8dlNwbRx2Z9h18
    KoYD7YQSblkHOweL6x9UYbyP1/y/XCQWv7/vxHOiu4yhdXHLgQ55YW45cGOqEIRoAToCSY
    ISot9MEPdkc0DhxzXEagILSruagqKDb2tUR6BKM3lrweosIVtr667RGCsA6fEL/0mqUjoU
    KRK5FEa1PK9O8PnqbSnJu2Hbw3QcFzayvmn+jA1rEuAskJ05t224ls+dLp/JK8T/lkcI9I
    FhiKiINGb4WN42NeP0HUOCFDmZKuNXXYzsRo/ru+f/nH3y0vAocJImgej2Pw
X-ME-Proxy: <xmx:MZ-aavGcgFc4-nFIy3QL07xth12NSo7EWcmXq4H7-l19LNkNwgLrgA>
    <xmx:MZ-aalTWtWRn2x5jGa4Z7nXpx-G351_rNcsB936F3oY-mCRO-Mbx0g>
    <xmx:MZ-aajGlA0tp_SnK4iSNf7drSyajIFS0lV17wyLM0Xb1RgXOU-dbtQ>
    <xmx:MZ-aap8OuNnwqh4seFriL2pL3GwfEQJa-ZmHfnORDACaYMoixekiHQ>
    <xmx:MZ-aatOPHc9BAb5WVHlgQfhn9xtFORI97pRoYWg_wB2ZosaK_wdcjCOi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 06:36:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id df780108 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Sep 2026 10:36:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 04 Sep 2026 12:36:09 +0200
Subject: [PATCH 08/11] setup: refactor how we configure the ref storage
 format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-b4-pks-unify-ref-storage-format-v1-8-08144e5004ff@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
In-Reply-To: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

When (re)initializing a repository we need to figure out the ref storage
format that the repository ought to use. This logic is surprisingly
complex, as we have grown a lot of different mechanisms over time to
configure the format. Unfortunately, as a result of this organic growth,
the logic that configures the storage format has grown very complex.

The biggest culprit here is that we're mixing the logic that determines
the desired storage format with the logic that validates whether the end
result is sane. This leads to some repetitive code, and makes it very
easy to forget validation for some of the branches.

In fact, the way we handle GIT_REFERENCE_BACKEND shows exactly one such
edge case where we don't properly validate. When initializing a
repository with one storage format and then reinitializing it with the
environment variable set to a different format then we'd corrupt the
repository because we silently change the format:

    $ git init repo
    $ git -C repo commit --allow-empty -m message
    $ GIT_REFERENCE_BACKEND=reftable git -C repo init
    fatal: could not open '.../refs/heads' for writing: Is a directory
    $ git -C repo log
    fatal: your current branch appears to be broken

Refactor the code so that we clearly distinguish between these two
different concerns. This lets us clearly spell out the precedence order
and makes the whole logic significantly easier to extend going forward.

Note that the new logic intentionally changes the precedence order so
that "GIT_REFERENCE_BACKEND" is now overridden by the "--ref-storage="
command line option. This matches our usual precedence order, where
explicit command line arguments override environment variables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c         | 103 +++++++++++++++++++++++++++++++++++---------------------
 t/t0001-init.sh |  12 ++++++-
 2 files changed, 75 insertions(+), 40 deletions(-)

diff --git a/setup.c b/setup.c
index 3be7dac452..d6e28dd675 100644
--- a/setup.c
+++ b/setup.c
@@ -2674,7 +2674,7 @@ static void separate_git_dir(struct repository *repo,
 
 struct default_format_config {
 	int hash;
-	enum ref_storage_format ref_format;
+	enum ref_storage_format ref_storage_format;
 };
 
 static int read_default_format_config(const char *key, const char *value,
@@ -2699,8 +2699,8 @@ static int read_default_format_config(const char *key, const char *value,
 		ret = git_config_string(&str, key, value);
 		if (ret)
 			goto out;
-		cfg->ref_format = ref_storage_format_by_name(str);
-		if (cfg->ref_format == REF_STORAGE_FORMAT_UNKNOWN)
+		cfg->ref_storage_format = ref_storage_format_by_name(str);
+		if (cfg->ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
 			warning(_("unknown ref storage format '%s'"), str);
 		goto out;
 	}
@@ -2710,9 +2710,9 @@ static int read_default_format_config(const char *key, const char *value,
 	 * "init.defaultRefFormat" takes precedence over this setting.
 	 */
 	if (!strcmp(key, "feature.experimental") &&
-	    cfg->ref_format == REF_STORAGE_FORMAT_UNKNOWN &&
+	    cfg->ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN &&
 	    git_config_bool(key, value)) {
-		cfg->ref_format = REF_STORAGE_FORMAT_REFTABLE;
+		cfg->ref_storage_format = REF_STORAGE_FORMAT_REFTABLE;
 		ret = 0;
 		goto out;
 	}
@@ -2724,18 +2724,18 @@ static int read_default_format_config(const char *key, const char *value,
 }
 
 static void repository_format_configure(struct repository_format *repo_fmt,
-					int hash, enum ref_storage_format ref_format)
+					int hash, enum ref_storage_format ref_storage_format)
 {
 	struct default_format_config cfg = {
 		.hash = GIT_HASH_UNKNOWN,
-		.ref_format = REF_STORAGE_FORMAT_UNKNOWN,
+		.ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN,
 	};
 	struct config_options opts = {
 		.respect_includes = 1,
 		.ignore_repo = 1,
 		.ignore_worktree = 1,
 	};
-	const char *ref_backend_uri;
+	char *ref_storage_payload = NULL;
 	const char *env;
 
 	config_with_options(read_default_format_config, &cfg, NULL, NULL, &opts);
@@ -2761,40 +2761,65 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		repo_fmt->hash_algo = cfg.hash;
 	}
 
-	env = getenv("GIT_DEFAULT_REF_FORMAT");
-	if (repo_fmt->version >= 0 &&
-	    ref_format != REF_STORAGE_FORMAT_UNKNOWN &&
-	    ref_format != repo_fmt->ref_storage_format) {
-		die(_("attempt to reinitialize repository with different reference storage format"));
-	} else if (ref_format != REF_STORAGE_FORMAT_UNKNOWN) {
-		repo_fmt->ref_storage_format = ref_format;
-	} else if (env) {
-		ref_format = ref_storage_format_by_name(env);
-		if (ref_format == REF_STORAGE_FORMAT_UNKNOWN)
-			die(_("unknown ref storage format '%s'"), env);
-		if (repo_fmt->version < 0 ||
-		    repo_fmt->ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
-			repo_fmt->ref_storage_format = ref_format;
-	} else if (cfg.ref_format != REF_STORAGE_FORMAT_UNKNOWN) {
-		repo_fmt->ref_storage_format = cfg.ref_format;
+	/*
+	 * We have the following order of preference when configuring the ref
+	 * storage format:
+	 *
+	 *   1. Explicit override via the command line, like in `git init
+	 *      --ref-storage=`.
+	 *
+	 *   2. Explicit override via the environment with
+	 *      GIT_REFERENCE_BACKEND.
+	 *
+	 *   3. Existing repository format. All the subsequent sources only
+	 *      kick in when there is no repository yet.
+	 *
+	 *   4. The default ref storage format for new repositories as
+	 *      configured via "GIT_DEFAULT_REF_FORMAT".
+	 *
+	 *   5. The default ref storage format for new repositories as
+	 *      configured via "init.defaultRefFormat"
+	 *
+	 *   6. Otherwise, we fall back to the default ref storage format
+	 *      compiled into Git.
+	 */
+	if (ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN) {
+		/* nothing to do */
+	} else if ((env = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT))) {
+		ref_storage_format = ref_storage_format_by_uri(env, &ref_storage_payload);
+		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown reference storage format specified via %s: '%s'"),
+			    GIT_REFERENCE_BACKEND_ENVIRONMENT, env);
+	} else if (repo_fmt->version >= 0) {
+		ref_storage_format = repo_fmt->ref_storage_format;
+		ref_storage_payload = xstrdup_or_null(repo_fmt->ref_storage_payload);
+	} else if ((env = getenv("GIT_DEFAULT_REF_FORMAT"))) {
+		ref_storage_format = ref_storage_format_by_name(env);
+		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown reference storage format specified via %s: '%s'"),
+			    "GIT_DEFAULT_REF_FORMAT", env);
+	} else if (cfg.ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN) {
+		ref_storage_format = cfg.ref_storage_format;
 	} else {
-		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_DEFAULT;
+		ref_storage_format = REF_STORAGE_FORMAT_DEFAULT;
 	}
 
-
-	ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
-	if (ref_backend_uri) {
-		enum ref_storage_format format;
-		char *payload;
-
-		format = ref_storage_format_by_uri(ref_backend_uri, &payload);
-		if (format == REF_STORAGE_FORMAT_UNKNOWN)
-			die(_("unknown ref storage format: '%s'"), ref_backend_uri);
-
-		repo_fmt->ref_storage_format = format;
-		free(repo_fmt->ref_storage_payload);
-		repo_fmt->ref_storage_payload = payload;
-	}
+	/*
+	 * If we have a preexisting repository we need to verify that its
+	 * current ref storage format does not change.
+	 */
+	if (repo_fmt->version >= 0) {
+		if (ref_storage_format != repo_fmt->ref_storage_format)
+			die(_("attempt to reinitialize repository with different reference storage format"));
+		if ((ref_storage_payload || repo_fmt->ref_storage_payload) &&
+		    strcmp(ref_storage_payload ? ref_storage_payload : "",
+			   repo_fmt->ref_storage_payload ? repo_fmt->ref_storage_payload : ""))
+			die(_("attempt to reinitialize repository with different reference storage payload"));
+	}
+
+	free(repo_fmt->ref_storage_payload);
+	repo_fmt->ref_storage_format = ref_storage_format;
+	repo_fmt->ref_storage_payload = ref_storage_payload;
 }
 
 int init_db(struct repository *repo,
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 24590ce908..d7e592d8a5 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -643,12 +643,22 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.refStorage with unknown back
 test_expect_success 'init with GIT_DEFAULT_REF_FORMAT=garbage' '
 	test_when_finished "rm -rf refformat" &&
 	cat >expect <<-EOF &&
-	fatal: unknown ref storage format ${SQ}garbage${SQ}
+	fatal: unknown reference storage format specified via GIT_DEFAULT_REF_FORMAT: ${SQ}garbage${SQ}
 	EOF
 	test_must_fail env GIT_DEFAULT_REF_FORMAT=garbage git init refformat 2>err &&
 	test_cmp expect err
 '
 
+test_expect_success 'GIT_REFERENCE_BACKEND refuses to reinitialize with different storage format' '
+	test_when_finished "rm -rf refbackend" &&
+	git init --ref-storage=files refbackend &&
+	cat >expect <<-EOF &&
+	fatal: attempt to reinitialize repository with different reference storage format
+	EOF
+	test_must_fail env GIT_REFERENCE_BACKEND=reftable git init refbackend 2>err &&
+	test_cmp expect err
+'
+
 test_expect_success 'init warns about invalid init.defaultRefFormat' '
 	test_when_finished "rm -rf repo" &&
 	test_config_global init.defaultRefFormat garbage &&

-- 
2.55.0.1007.g17ff1f9808.dirty

