Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C746EC84
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780037; cv=none; b=hEKSYJcxM5SWy0QL80KeEbfSlNE9LVKgPZxXBXqcdsQLpLp6rmknoDBTDrYzVpjG3q3/zUqkp2XKr+EjtQCgFNlaOracfEEpIG/p43TMXX68YK2nkWeO+zpPoTWx349CDrQFNBbHIsZZhacrgepyx0WR/9EonNvuUwy6Vg6tJy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780037; c=relaxed/simple;
	bh=DW9CgyNqvYHrxIIomdYo19ivp4NsOmTufLJBsE1IJFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sgDMxunVmEXP+kY0E7tZTg4paaEHLOK/CdUSwh06VFCh6DENBorqDvGnPrLunYSTa5dWj7zf8W3ToLAk1TzkAgPMsEiWj9DNtDfVmYMFmAUVz+NhioCRuvoxxh6V+eDLccif8VkH9WC0qzc52r5wGV1zCQzJDCaULvAvmaUI3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ILIBNjnL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZWRDAeVF; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ILIBNjnL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZWRDAeVF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 849FBEC0230;
	Mon,  7 Sep 2026 07:20:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 07 Sep 2026 07:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788780031;
	 x=1788866431; bh=hvtIOnb6mRLc82aBPSh4D20K2UxiEbVOdPeIBukYc7Y=; b=
	ILIBNjnLQtkB1mwzuFRLpEGYxQ2H62WEyBj0ucfQg8P0wK9COLcCzA74//KqlNa0
	WKNCq19M5zhS2RTa7y8sk72DJlJ8CIHdbHa4ghypJxNcdQbhH2WIUxpk8gUgc9HB
	wqZoc89ibkcTBbRtgjv347irQqJSs655mAEVBu6oWTIS6bI9SwUZKrG/9puVYx+J
	ySsAmRY8eO4bvf+5DNIGvF6quLcKo/Gc7oqDQ/GbqFskHUd44gQuzr/8UryvFLxf
	2iMpYb+9t4D7NgoTUfVg4jHdjc5wC3ABpoykeQRjO+nsTvHKsKLmtVkRn9nNfcA7
	HIpAVZWBBlnJDyFAIqPUFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788780031; x=
	1788866431; bh=hvtIOnb6mRLc82aBPSh4D20K2UxiEbVOdPeIBukYc7Y=; b=Z
	WRDAeVFJfwb1rrslM7B4ljyhaF/hwmGCJa7Egv+3KAM5+CootSbfFkegiZGqZJiv
	+NsEAfo3rFyfrnbbKqlwfz6B3uxpJvo8MfDeTlYq5bXUYkIqfXLPYbCNy2bKfXS9
	G5wK2n2ge/z1JlDEW2wGeJxWKihXPTm4uOOJYtBGXHVs/alGZHUnUDXs6+widVOv
	VrJNMF0qkBSd0EZXeTpo4S8aT0o3H5r35zfZ4BYMtEbaSnYQFMpiJoGhZb4SGgb4
	iBOcvXay3goKqVo5V/2l8hr7Wd4pUu+qmaZepEt7z8r97OYqycN5ETcyaNuBdjOl
	jBH6VXF8vG8BHqnDgXU7Q==
X-ME-Sender: <xms:_52eaoh2PPx0lJJPqaR_vXwrKG2SaZ0ch5hoUNmnaEWOZX-gBxOFwA>
    <xme:_52eaoefbp9V7lpOSM2XdEJwIgAqex2nQ2hHrLv_CrWrAffHQJcDq5m_6Pg2eOVWU
    IfzryJYUXdanS8WdOEpJQ02iJUtJOPnPcgCJISHaqFOovjjrpdYy54>
X-ME-Received: <xmr:_52eatc-X5zl54mhddIDsfMUShYBbZXX3quGwzSTVuO9Skb_QyB0fA>
X-ME-Proxy-Cause: dmFkZTEODmYfhcE6MkClXmAzaz/u/B/AKDElneu4mL0qUxdd8dsBrCmOKXS1tHl60eVFV2
    SymYRFYzuiLUqyPPFAGooBAERtLvf0X1LhcjqzMnX7gdc7DtqXstRRoihdSALfCxoWFzJG
    BbbIbG0MP1m8AhEq/eZrNtPsqwDGfS6kNpj3lzhC6fPFYomNFvg9RKzjO2WnGUQd1KA2IH
    sWYk5pONmMX+mdXpmpfGC22NTMapciJwOTHnIl8o4jd+7ZhCw8vFlPa824pJltjvaD3N4A
    MUB/oyFdCvhdQMSVTPOi3Wa2Ehbr/+fSxb1kUGZO2C7ytEHmk7HxP5nm8sCCeE5hTY4Ukh
    rIIpin37w35mXfRWH14+Rl8xWHP0kgoiREMnBtagGGqAq7sR5F/pBCuQqZII2rzKrYdP+/
    rcbxe72ZauhLPBt24wz6tZk9iYJ18KTXJ2Vlj+73Bico8j0kD0Z5X4Ss+Rab8cdTMoTrzB
    GXLjpJZX8sBhxS4j/ECULKiC7XJlE6rOhLDA0Kg9+DJvgsPBe/ObY1A3I/aNIiFOQXRLTb
    /nvdIdw2o+3tFxAGnEQpit43kHT+kJJkx0mrdFz8aNP3KnvRpBivFue5/RKZ0naqL58Fiw
    XN+gtBxfe1aD4B3nUyoNsIQAgJjO7fnUIhn12zd8R/p3WwDVyscfAfKqvGBg
X-ME-Proxy: <xmx:_52eai9vAXBD_UaFe5JF-fQEipCEfIQKgt4hA1nPHqmEH9YcsFGKtA>
    <xmx:_52eapkMNqZ5vcepZ_bq_U5K9ygE8-992eGpSW48lRP2L-mxJY5zaw>
    <xmx:_52eak9U8qmEIGhhbwGFFsnUChUmSNmITmBvmn3D7l8DywYuwJHj3A>
    <xmx:_52eannpk7z-wvpTupIbC2y09-KAx7-ot8uUkjzzJ_-G1QnVioD60w>
    <xmx:_52eaodYZZCWV5DMvqIvqirFzNjDGwdHBeHExUFA74wDLnsLS5qi3KMG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 07:20:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c59776f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 11:20:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 13:18:42 +0200
Subject: [PATCH v2 08/11] setup: refactor how we configure the ref storage
 format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-b4-pks-unify-ref-storage-format-v2-8-6733c90ca5b0@pks.im>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
In-Reply-To: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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
that "GIT_REFERENCE_BACKEND" is now overridden by the
"--ref-storage-format=" command line option. This matches our usual
precedence order, where explicit command line arguments override
environment variables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c         | 103 +++++++++++++++++++++++++++++++++++---------------------
 t/t0001-init.sh |  12 ++++++-
 2 files changed, 75 insertions(+), 40 deletions(-)

diff --git a/setup.c b/setup.c
index 3be7dac452..38fa5e854c 100644
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
+	 *      --ref-storage-format=`.
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
+			die(_("unknown ref storage format specified via %s: '%s'"),
+			    GIT_REFERENCE_BACKEND_ENVIRONMENT, env);
+	} else if (repo_fmt->version >= 0) {
+		ref_storage_format = repo_fmt->ref_storage_format;
+		ref_storage_payload = xstrdup_or_null(repo_fmt->ref_storage_payload);
+	} else if ((env = getenv("GIT_DEFAULT_REF_FORMAT"))) {
+		ref_storage_format = ref_storage_format_by_name(env);
+		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown ref storage format specified via %s: '%s'"),
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
index 6f4431bed7..ca44dfc1ce 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -643,12 +643,22 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.refStorage with unknown back
 test_expect_success 'init with GIT_DEFAULT_REF_FORMAT=garbage' '
 	test_when_finished "rm -rf refformat" &&
 	cat >expect <<-EOF &&
-	fatal: unknown ref storage format ${SQ}garbage${SQ}
+	fatal: unknown ref storage format specified via GIT_DEFAULT_REF_FORMAT: ${SQ}garbage${SQ}
 	EOF
 	test_must_fail env GIT_DEFAULT_REF_FORMAT=garbage git init refformat 2>err &&
 	test_cmp expect err
 '
 
+test_expect_success 'GIT_REFERENCE_BACKEND refuses to reinitialize with different storage format' '
+	test_when_finished "rm -rf refbackend" &&
+	git init --ref-storage-format=files refbackend &&
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

