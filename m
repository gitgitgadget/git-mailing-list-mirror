Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B52534452
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952405; cv=none; b=P2YcxtEzowBPcTY37DXkmglErnbuFxnleNhXHowg1S1v2Vw/59xCn+A4qJBF0TjHsnLStnED4he2KZRxULEvvsqbRC6KoL4cbEUx3BRkH7h8ctqwNRwlpEvReG2HOzEQJZqH2XL6DB2bCDRm0C9XBnwlBcsO95JvoGYpVAqNWQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952405; c=relaxed/simple;
	bh=UD6Zd8LT0E3n6n6cbKM2Nx67nW7S/088DveGbSp0E+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fp0zc4EVt9F/MOt5HZfgO8N4y+h9kEKfHsMH0hmtEcIaPjXSDidwBDUSqHilNk7S3Ocmb5CpIm3YNyY1z0ZhjXU+qdAGmsFmkdhiecDiNZCEVe7fsRJRoN8x6WOJR/0S9JLCkF63Moys2RJ4jVTWBUvPyd0hcW0pjWgzUAvsm2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hdxdqkmH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y5OiaYa/; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hdxdqkmH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y5OiaYa/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C919214000AE;
	Wed,  9 Sep 2026 07:13:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 09 Sep 2026 07:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788952398;
	 x=1789038798; bh=flwq+hGTdIHjOf6jrWdWtW2sYA977bNbeG1IvRNQXjc=; b=
	hdxdqkmHF0nB3p3qyEP9NeGQXWQw5qKJNQ5rZSeG+ChzrltM/Vgaiv21RrWtiL4Q
	kghrUaXfYk/Z+GZv17rkHQBMertMEpFOho7/iSOebPU/8oUlBfwPBgSIpFtQWnhR
	RnOS+gkoyUEyLfra0+KhybOJssiJ/ApnoKlZO6+LTOD8TVtbFUPum5sqcn12LQvD
	nu/x3bS6nlc4py7ARyW9YHq2hMkt2MX60dG75wED1LpNtZQv+WooV3WaS4MuYOSD
	qnN1CO1mCyDL7XY/ZzqA0k+Y8goPqQH884WaHGifHQ4uxGC96khKy70eut0PI2WI
	JP/vMNnA5j83S3qtV7gpnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788952398; x=
	1789038798; bh=flwq+hGTdIHjOf6jrWdWtW2sYA977bNbeG1IvRNQXjc=; b=Y
	5OiaYa/ruR9eUuwmtqII9uJqOBJJMaPf4CDRzo7Ty6Cx5UqkTH3UyeAwh8eMC/Hc
	Y+zDNSlG0mrMNzA90hpd/jhbW1uYWgm5nX7rNviaDSL9/24iDFvk16iox9eYwtuy
	fBQ2VpVQvBznsrAWuC2uHFS71RY6EigTGoACO3l88bHw3cJkAQI8owashc980DBW
	o3z6pVpG8tBpua0McD4t2gSOarhYKDwRcYw3vJwLuT9EECrys73cUVktqe42VMmv
	lalsSOFJ/q8NbZxrWv/9+uEiU+pbufewKVUE2zE5m6zwMPahLAG6/rbSwcLe1cTn
	J9bZ7B2KYFIeZrQbtl0yw==
X-ME-Sender: <xms:Tj-haiinLVwK2yNYCKRAgPTZgWB0n19GrxpOQ3X2ambdBvjH43vMnQ>
    <xme:Tj-haqDcrG_8AmSRnvKnGEB4hUcWGQyN7q6ou-S4sg705w2XDLayfSRK_6cBufucf
    gL5cMLQPL_xyBifsOwBk4YDMi4hC1iw4CzTFS9-nz85h_dlX3J3Gmg>
X-ME-Received: <xmr:Tj-havG9O2wh8i9sVRqWWJ6lEyorqm4eFbY9X0clQoiN9azTIGHtIHGVfQ8oCP_KzM2YXw>
X-ME-Proxy-Cause: dmFkZTE3Kr1NBd8JgUfl84Cb5cL1nWUdKmaXEokJASImL17FtufGP+r88gnlXAgjOipOth
    P0q/MAO7driC9DWr9Pb2NSvnMboXAXQWKqp8q78rYacR0TIfgyDDisWpv4xgCjkfxpilFV
    de0BOcTzvSAwUjVggAVO3f0pp6fIXUozrRPx2JvGzCsepeV8jO3cLnixaA4fSCdk4cUvuV
    rWLiAxUXVbAEgGiBosN+gythNumpxzm2a6dIrhwBK6rKLm4zyqnAIVm4MkYADQfX4sBmuh
    t+6+cjeSCFtzPIC/cVXe+1M7eMImUQxfOX84m9qkFZENNlkxbbgX53FSMd/vtpKdV6ooid
    bBr4w5oZlDqiZ08Gza3cEEy9b6yNiHZ8bBtES7vN8zSgdWrkCX15nZYsyQXGddgymYb2aY
    dWJgLWVmyqGPOeGf48GdQ8cGFm4UG/1qw+dQMYEvqu9FllUxy1z2hbckwqAWzQwAfA5bu6
    VtoSRnA/Cr5+0OQtUxRxfTndKUkpFrQUGZr0KioKIm4FMZD7KBH8/CXhTIREeCDefATYNs
    Vr8+LS4BMOOxx5sdAaB9loslI9/8feWuVuFc3XaKdeFnoQ+a7hPYDYJvNMlxJ3p05Ej/Xq
    /nbHlgVx9h+HWiT7vwPh/IvRFoAJE6xuRLO5CVAyDpo5BvioNJTCGuHW+xSA
X-ME-Proxy: <xmx:Tj-haqJzYrOEFzgzqyHjF6pUCenyaYZfSNfq5fkxeZx-eOUJQY__Lg>
    <xmx:Tj-harn9Z5f8g2NLF9vqath7h62h2TmQ6La0_Y64p_g_-IWz5bOX7g>
    <xmx:Tj-haqSLXYgxypr7dlmGd9a_U1LCqM_uFSHCuiBv7eyq1RHv3b5Ecw>
    <xmx:Tj-halLgZJbnWBBmvXHbw0kS2FZVRJyGKOr9JrY2gflmZHgrGPG0XA>
    <xmx:Tj-hamlbLEm7cxiMWMpoyk4YmTmAVbe1lj_8QqQEuhN_YTrQ5jpzBx8->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 07:13:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8c3a1981 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 11:13:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 13:12:55 +0200
Subject: [PATCH v3 09/13] setup: refactor how we configure the ref storage
 format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-pks-unify-ref-storage-format-v3-9-ca041fb40ad8@pks.im>
References: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
In-Reply-To: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
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
2.55.0.1074.ge7621b4bad.dirty

