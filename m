Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A953FD5A
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952409; cv=none; b=gL82MdSJZyvKpBo4F46YBFqorImiljle190zw1uYWw27f3vrMTfq2phlGlnsspBAzovz+dRgKWHMxVpEszLn4RfD/Wnftht2tg0iu2VIFKZgsR9EXZ80tXtorh0ejwAnXyWih0lHOO+bhIFXv9PZUQO4Le60Nrz1Ua1RzZ+cWhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952409; c=relaxed/simple;
	bh=0YfUuBK58siL+iieYgP1Qan46qAKcb2BnIu1tsYAcJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BBvJ55ojy78g2SR7KofSagYlNCnCDlYLbWL9X8wlrzdrjevNpNc/77ovIFaFZiiC5zM1cJM5z3N8pOLpRcReq0qqjYh9cQrrmIZzI3hs8znlu0uSZfhsXxconhnPOH3Ke49byPh9LMuStOHSXFNlnzLOYkkRmLa3zGesgm4m2YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KH/Vx/HX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dhr48JS0; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KH/Vx/HX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dhr48JS0"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED55C140008A;
	Wed,  9 Sep 2026 07:13:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 09 Sep 2026 07:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788952400;
	 x=1789038800; bh=JjgKPTkYo3faaXjpdqFsMy8oZyUUaiTIiyyLeQkIZjQ=; b=
	KH/Vx/HX1eZZPk32yZyMf6uV3CjWnz4QRpVW8/wHN7i1zthoSFse6H90GjEcJva6
	XziZFCTyqDrNjXjWjc8iQJ+Hnatv6Jsoacg36sPqHcpbgF2VKsb3P8lZ5E1HZu/a
	KKV9+6iAQCOtU3phAG3agHpnKxH2FsPfM24wEjtKmCPIYZqmZN7/8/ObVfvmffge
	Gxb18sjyYa6MLfqR3X5bP4xU6O1kHd0hb2eAbLD0HcMT11R+cNwAcj6UWNQU1uZ0
	cjLAL10raB6I35xdQs5QRAbRE1rtqEIlc+IDuGyugELkrQ26uk45up8FGcD8kXWA
	Hh34glw7VRsdUQij0IVUfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788952400; x=
	1789038800; bh=JjgKPTkYo3faaXjpdqFsMy8oZyUUaiTIiyyLeQkIZjQ=; b=D
	hr48JS0B5sd5nRRtnz16R2Dh4tVSwWWh4//9zU9Ms9Vz5CEguyZXF1DZkarSyfh3
	vP0xquKBYd/EDKJ/N7bPYhkxAKV1IdDnl87U+CarOlXQqIJO8tHjK26cJDjum9Sk
	69O1uzPSjouesmTa3LYCUutWkdB6MjFU3W2jN/CkbMdwqWtFqNgq7VMU8vMA8Cty
	d/wllRS7OPBCVGy3a4Y8bip0mjW6q2SXSmlymHfcuLrhFbpHkgCWCGfIWnxsw7nw
	bGftfqZRk/XOYxwgpQGar9GSRmDPVaWbBoss2Km2k+y4X+srO2YqjtWoDbGLmLGf
	T6JSfj6Bstay6Lvkt4x+A==
X-ME-Sender: <xms:UD-hagaI78P5yPqrRKFsh6S8RcYdn160ckdpbk8y3b5ZrOA96wJZtA>
    <xme:UD-haiYP6Z2Eb_0-qvVNPd3J6NtqXS9HAwI-OXS-F7oubl7QrLSimZAS3-JBhRztk
    Pw6TvxiBEvNhUiULH_enQYPkb9S5JCvVL6vJ0oQ-4E2xDs6hchZSA>
X-ME-Received: <xmr:UD-hav-kyfg1_HvksI57Fnx7rvqZkPfNwH8K8cqFOQO6G8woWFCmiV4Li8WwboCHIRp4zw>
X-ME-Proxy-Cause: dmFkZTGfTV1uyFmJ3+T4jSPE+WnBIxrT4BmO5Y9w99XiuMjp4NbhGyRWkk2PReRvgrSJnT
    I7MmKD9U9YFDxg4PeMzc6pUiMqzwr0w4dSHfR+qxvG+5MmZf05fmIb0CsfYEXQCDrlky7Q
    rm1kV5jEs7f3Rw1GMBl5F8175mziSxf3djVGE8im84FdaP3ZieYODRZLIBpH5EhAM6DWfy
    Y4ceZJx9e7/YpIymb2CuCnZYOX5IBhwqQOrFA71932DEVNyb8jq6NUwR73EfML51bR59Jo
    iJfEAEPYSjAJRbcPAkLfBlBILlFIH3Ah87miBKWv8xVkOGQq57pPpSPLFJTgJqDytKeyM/
    OLutLuaMzPbfpn1AW4jPb1VrdQ2QhYPa77YNroS1kNuh2maRkc4zF8udzpEBL5n+ghSEEd
    XyFhgdmVY1uZ8V68Z13yVHmSZxI2XCmG66n+drUzL1McfAm+qiqci2kW+GFb96m4j2VnQH
    +u3giUYLn2zcUZEOGallz5ynUf5vPvID7RX/8h7Xy6uSbyoS6Y4MJYCxc31louX070k9vh
    y50vq1TlBy+REbdDv+BlGkVk8WBp1hzZSVvN2iGiVgnlnUa64QCzx99ZH8ItRTkJpldtoI
    UmjG2N1s6xj5OdW8zQA/lwzMRf4ydNXZC6jElZTr/wJ9UGppsUsM4Qe93/6Q
X-ME-Proxy: <xmx:UD-haphoTC5B7TzBzWgn2Zj-AG9dJdREkbCa_sz7yGFTAtRxxMEzMw>
    <xmx:UD-handO4kWx6JpBdH9jrvNzGqeOryt4fcXimcmmY_CPU4mQhP0LAw>
    <xmx:UD-haoqgJOpeeQBSTH3FcrWhtjFlqdt6U1Zf6_eg6NeDvkFwyuTPew>
    <xmx:UD-hakBq98xq0ujv6NCXXpMzE8aDV2xvMniiGrTLlJWQ44h74NPxkA>
    <xmx:UD-havdfri8-VFkwtnPCfykP1OUBvA5OTSNF-t9YW5-Qrjs7ezeo2OHA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 07:13:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6660133b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 11:13:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 13:12:56 +0200
Subject: [PATCH v3 10/13] setup: rename ref storage format environment
 variables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-pks-unify-ref-storage-format-v3-10-ca041fb40ad8@pks.im>
References: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
In-Reply-To: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

With the same reasoning as for git-init(1), rename the environment
variables GIT_REFERENCE_BACKEND and GIT_DEFAULT_REF_FORMAT to
GIT_REF_STORAGE_FORMAT and GIT_DEFAULT_REF_STORAGE_FORMAT, respectively.
The old names are kept as an alias to retain compatibility.

While at it, fix indentation for `GIT_REF_STORAGE_FORMAT` docs to use
tabs instead of spaces.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/init.adoc         |  2 +-
 Documentation/git.adoc                 | 16 +++++++----
 environment.h                          |  1 +
 setup.c                                | 28 +++++++++++++++----
 t/t0001-init.sh                        | 50 +++++++++++++++++-----------------
 t/t1419-exclude-refs.sh                | 16 +++++------
 t/t1423-ref-backend.sh                 | 18 ++++++------
 t/t7424-submodule-mixed-ref-formats.sh | 14 +++++-----
 t/test-lib.sh                          |  8 +++---
 9 files changed, 88 insertions(+), 65 deletions(-)

diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
index a048f0bddc..f82fcf25e6 100644
--- a/Documentation/config/init.adoc
+++ b/Documentation/config/init.adoc
@@ -16,7 +16,7 @@ endif::[]
 `init.defaultRefFormat`::
 	Allows overriding the default ref storage format for new repositories.
 	See `--ref-storage-format=` in linkgit:git-init[1]. Both the command line
-	option and the `GIT_DEFAULT_REF_FORMAT` environment variable take
+	option and the `GIT_DEFAULT_REF_STORAGE_FORMAT` environment variable take
 	precedence over this config.
 
 init.defaultSubmodulePathConfig::
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 23ba65656e..cee0da28db 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -590,15 +590,21 @@ double-quotes and respecting backslash escapes. E.g., the value
 	is always used. The default is "sha1".
 	See `--object-format` in linkgit:git-init[1].
 
-`GIT_DEFAULT_REF_FORMAT`::
-	If this variable is set, the default reference backend format for new
+`GIT_DEFAULT_REF_STORAGE_FORMAT`::
+	If this variable is set, the default ref storage format for new
 	repositories will be set to this value. The default is "files".
 	See `--ref-storage-format` in linkgit:git-init[1].
 
+`GIT_DEFAULT_REF_FORMAT`::
+	Deprecated alias of `GIT_DEFAULT_REF_STORAGE_FORMAT`.
+
+`GIT_REF_STORAGE_FORMAT`::
+	Specify which ref storage format to use along with its URI.
+	See `extensions.refStorage` option in linkgit:git-config[1] for more
+	details. Overrides the config variable when used.
+
 `GIT_REFERENCE_BACKEND`::
-    Specify which reference backend to be used along with its URI.
-    See `extensions.refStorage` option in linkgit:git-config[1] for more
-    details. Overrides the config variable when used.
+	Deprecated alias of `GIT_REF_STORAGE_FORMAT`.
 
 Git Commits
 ~~~~~~~~~~~
diff --git a/environment.h b/environment.h
index e7ec5b0437..4bd8f08dee 100644
--- a/environment.h
+++ b/environment.h
@@ -44,6 +44,7 @@
 #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
 #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
 #define GIT_REFERENCE_BACKEND_ENVIRONMENT "GIT_REFERENCE_BACKEND"
+#define GIT_REF_STORAGE_FORMAT_ENVIRONMENT "GIT_REF_STORAGE_FORMAT"
 
 /*
  * Environment variable used to propagate the --no-advice global option to the
diff --git a/setup.c b/setup.c
index 38fa5e854c..621cf87c9c 100644
--- a/setup.c
+++ b/setup.c
@@ -2049,7 +2049,9 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 			 * The env variable should override the repository config
 			 * for 'extensions.refStorage'.
 			 */
-			ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
+			ref_backend_uri = getenv(GIT_REF_STORAGE_FORMAT_ENVIRONMENT);
+			if (!ref_backend_uri)
+				ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
 			if (ref_backend_uri) {
 				FREE_AND_NULL(discovery.format.ref_storage_payload);
 				discovery.format.ref_storage_format =
@@ -2769,22 +2771,31 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	 *      --ref-storage-format=`.
 	 *
 	 *   2. Explicit override via the environment with
-	 *      GIT_REFERENCE_BACKEND.
+	 *      "GIT_REF_STORAGE_FORMAT".
 	 *
-	 *   3. Existing repository format. All the subsequent sources only
+	 *   3. Its deprecated equivalent "GIT_REFERENCE_BACKEND".
+	 *
+	 *   4. Existing repository format. All the subsequent sources only
 	 *      kick in when there is no repository yet.
 	 *
 	 *   4. The default ref storage format for new repositories as
-	 *      configured via "GIT_DEFAULT_REF_FORMAT".
+	 *      configured via "GIT_DEFAULT_REF_STORAGE_FORMAT".
+	 *
+	 *   5. Its deprecated equivalent "GIT_DEFAULT_REF_FORMAT".
 	 *
-	 *   5. The default ref storage format for new repositories as
+	 *   6. The default ref storage format for new repositories as
 	 *      configured via "init.defaultRefFormat"
 	 *
-	 *   6. Otherwise, we fall back to the default ref storage format
+	 *   7. Otherwise, we fall back to the default ref storage format
 	 *      compiled into Git.
 	 */
 	if (ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN) {
 		/* nothing to do */
+	} else if ((env = getenv(GIT_REF_STORAGE_FORMAT_ENVIRONMENT))) {
+		ref_storage_format = ref_storage_format_by_uri(env, &ref_storage_payload);
+		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown ref storage format specified via %s: '%s'"),
+			    GIT_REF_STORAGE_FORMAT_ENVIRONMENT, env);
 	} else if ((env = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT))) {
 		ref_storage_format = ref_storage_format_by_uri(env, &ref_storage_payload);
 		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
@@ -2793,6 +2804,11 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	} else if (repo_fmt->version >= 0) {
 		ref_storage_format = repo_fmt->ref_storage_format;
 		ref_storage_payload = xstrdup_or_null(repo_fmt->ref_storage_payload);
+	} else if ((env = getenv("GIT_DEFAULT_REF_STORAGE_FORMAT"))) {
+		ref_storage_format = ref_storage_format_by_name(env);
+		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown ref storage format specified via %s: '%s'"),
+			    "GIT_DEFAULT_REF_STORAGE_FORMAT", env);
 	} else if ((env = getenv("GIT_DEFAULT_REF_FORMAT"))) {
 		ref_storage_format = ref_storage_format_by_name(env);
 		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index ca44dfc1ce..af9a7ba958 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -640,22 +640,22 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.refStorage with unknown back
 	test_grep "invalid value for ${SQ}extensions.refstorage${SQ}: ${SQ}garbage${SQ}" err
 '
 
-test_expect_success 'init with GIT_DEFAULT_REF_FORMAT=garbage' '
+test_expect_success 'init with GIT_DEFAULT_REF_STORAGE_FORMAT=garbage' '
 	test_when_finished "rm -rf refformat" &&
 	cat >expect <<-EOF &&
-	fatal: unknown ref storage format specified via GIT_DEFAULT_REF_FORMAT: ${SQ}garbage${SQ}
+	fatal: unknown ref storage format specified via GIT_DEFAULT_REF_STORAGE_FORMAT: ${SQ}garbage${SQ}
 	EOF
-	test_must_fail env GIT_DEFAULT_REF_FORMAT=garbage git init refformat 2>err &&
+	test_must_fail env GIT_DEFAULT_REF_STORAGE_FORMAT=garbage git init refformat 2>err &&
 	test_cmp expect err
 '
 
-test_expect_success 'GIT_REFERENCE_BACKEND refuses to reinitialize with different storage format' '
+test_expect_success 'GIT_REF_STORAGE_FORMAT refuses to reinitialize with different storage format' '
 	test_when_finished "rm -rf refbackend" &&
 	git init --ref-storage-format=files refbackend &&
 	cat >expect <<-EOF &&
 	fatal: attempt to reinitialize repository with different reference storage format
 	EOF
-	test_must_fail env GIT_REFERENCE_BACKEND=reftable git init refbackend 2>err &&
+	test_must_fail env GIT_REF_STORAGE_FORMAT=reftable git init refbackend 2>err &&
 	test_cmp expect err
 '
 
@@ -668,14 +668,14 @@ test_expect_success 'init warns about invalid init.defaultRefFormat' '
 	test_cmp expect err &&
 
 	git -C repo rev-parse --show-ref-storage-format >actual &&
-	echo $GIT_DEFAULT_REF_FORMAT >expected &&
+	echo $GIT_DEFAULT_REF_STORAGE_FORMAT >expected &&
 	test_cmp expected actual
 '
 
 test_expect_success 'default ref format' '
 	test_when_finished "rm -rf refformat" &&
 	(
-		sane_unset GIT_DEFAULT_REF_FORMAT &&
+		sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
 		git init refformat
 	) &&
 	git version --build-options | sed -ne "s/^default-ref-storage-format: //p" >expect &&
@@ -686,9 +686,9 @@ test_expect_success 'default ref format' '
 backends="files reftable"
 for format in $backends
 do
-	test_expect_success DEFAULT_REPO_FORMAT "init with GIT_DEFAULT_REF_FORMAT=$format" '
+	test_expect_success DEFAULT_REPO_FORMAT "init with GIT_DEFAULT_REF_STORAGE_FORMAT=$format" '
 		test_when_finished "rm -rf refformat" &&
-		GIT_DEFAULT_REF_FORMAT=$format git init refformat &&
+		GIT_DEFAULT_REF_STORAGE_FORMAT=$format git init refformat &&
 
 		if test $format = files
 		then
@@ -718,7 +718,7 @@ do
 		test_when_finished "rm -rf refformat" &&
 		test_config_global init.defaultRefFormat $format &&
 		(
-			sane_unset GIT_DEFAULT_REF_FORMAT &&
+			sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
 			git init refformat
 		) &&
 
@@ -727,37 +727,37 @@ do
 		test_cmp expect actual
 	'
 
-	test_expect_success "--ref-storage-format=$format overrides GIT_DEFAULT_REF_FORMAT" '
+	test_expect_success "--ref-storage-format=$format overrides GIT_DEFAULT_REF_STORAGE_FORMAT" '
 		test_when_finished "rm -rf refformat" &&
-		GIT_DEFAULT_REF_FORMAT=garbage git init --ref-storage-format=$format refformat &&
+		GIT_DEFAULT_REF_STORAGE_FORMAT=garbage git init --ref-storage-format=$format refformat &&
 		echo $format >expect &&
 		git -C refformat rev-parse --show-ref-storage-format >actual &&
 		test_cmp expect actual
 	'
 
-	test_expect_success "reinit repository with GIT_DEFAULT_REF_FORMAT=$format does not change format" '
+	test_expect_success "reinit repository with GIT_DEFAULT_REF_STORAGE_FORMAT=$format does not change format" '
 		test_when_finished "rm -rf refformat" &&
 		git init refformat &&
 		git -C refformat rev-parse --show-ref-storage-format >expect &&
-		GIT_DEFAULT_REF_FORMAT=$format git init refformat &&
+		GIT_DEFAULT_REF_STORAGE_FORMAT=$format git init refformat &&
 		git -C refformat rev-parse --show-ref-storage-format >actual &&
 		test_cmp expect actual
 	'
 done
 
-test_expect_success "--ref-storage-format= overrides GIT_DEFAULT_REF_FORMAT" '
+test_expect_success "--ref-storage-format= overrides GIT_DEFAULT_REF_STORAGE_FOMAT" '
 	test_when_finished "rm -rf refformat" &&
-	GIT_DEFAULT_REF_FORMAT=files git init --ref-storage-format=reftable refformat &&
+	GIT_DEFAULT_REF_STORAGE_FORMAT=files git init --ref-storage-format=reftable refformat &&
 	echo reftable >expect &&
 	git -C refformat rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success "GIT_DEFAULT_REF_FORMAT= overrides init.defaultRefFormat" '
+test_expect_success "GIT_DEFAULT_REF_STORAGE_FORMAT= overrides init.defaultRefFormat" '
 	test_when_finished "rm -rf refformat" &&
 	test_config_global init.defaultRefFormat files &&
 
-	GIT_DEFAULT_REF_FORMAT=reftable git init refformat &&
+	GIT_DEFAULT_REF_STORAGE_FORMAT=reftable git init refformat &&
 	echo reftable >expect &&
 	git -C refformat rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
@@ -767,7 +767,7 @@ test_expect_success "init with feature.experimental=true" '
 	test_when_finished "rm -rf refformat" &&
 	test_config_global feature.experimental true &&
 	(
-		sane_unset GIT_DEFAULT_REF_FORMAT &&
+		sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
 		git init refformat
 	) &&
 	echo reftable >expect &&
@@ -780,7 +780,7 @@ test_expect_success "init.defaultRefFormat overrides feature.experimental=true"
 	test_config_global feature.experimental true &&
 	test_config_global init.defaultRefFormat files &&
 	(
-		sane_unset GIT_DEFAULT_REF_FORMAT &&
+		sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
 		git init refformat
 	) &&
 	echo files >expect &&
@@ -788,10 +788,10 @@ test_expect_success "init.defaultRefFormat overrides feature.experimental=true"
 	test_cmp expect actual
 '
 
-test_expect_success "GIT_DEFAULT_REF_FORMAT= overrides feature.experimental=true" '
+test_expect_success "GIT_DEFAULT_REF_STORAGE_FORMAT= overrides feature.experimental=true" '
 	test_when_finished "rm -rf refformat" &&
 	test_config_global feature.experimental true &&
-	GIT_DEFAULT_REF_FORMAT=files git init refformat &&
+	GIT_DEFAULT_REF_STORAGE_FORMAT=files git init refformat &&
 	echo files >expect &&
 	git -C refformat rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
@@ -942,7 +942,7 @@ test_expect_success 'branch -m with the initial branch' '
 test_expect_success 'init with includeIf.onbranch condition' '
 	test_when_finished "rm -rf repo" &&
 	git -c includeIf.onbranch:main.path=nonexistent init repo &&
-	echo $GIT_DEFAULT_REF_FORMAT >expect &&
+	echo $GIT_DEFAULT_REF_STORAGE_FORMAT >expect &&
 	git -C repo rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '
@@ -951,7 +951,7 @@ test_expect_success 'init with includeIf.onbranch condition with existing direct
 	test_when_finished "rm -rf repo" &&
 	mkdir repo &&
 	git -c includeIf.onbranch:nonexistent.path=/does/not/exist init repo &&
-	echo $GIT_DEFAULT_REF_FORMAT >expect &&
+	echo $GIT_DEFAULT_REF_STORAGE_FORMAT >expect &&
 	git -C repo rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '
@@ -960,7 +960,7 @@ test_expect_success 're-init with includeIf.onbranch condition' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	git -c includeIf.onbranch:nonexistent.path=/does/not/exist init repo &&
-	echo $GIT_DEFAULT_REF_FORMAT >expect &&
+	echo $GIT_DEFAULT_REF_STORAGE_FORMAT >expect &&
 	git -C repo rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
index 04797aee59..50237a5aeb 100755
--- a/t/t1419-exclude-refs.sh
+++ b/t/t1419-exclude-refs.sh
@@ -21,13 +21,13 @@ assert_jumps () {
 	local nr="$1"
 	local trace="$2"
 
-	case "$GIT_DEFAULT_REF_FORMAT" in
+	case "$GIT_DEFAULT_REF_STORAGE_FORMAT" in
 	files)
 		grep -q "name:jumps_made value:$nr$" $trace;;
 	reftable)
 		grep -q "name:reseeks_made value:$nr$" $trace;;
 	*)
-		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
+		BUG "unhandled ref storage format $GIT_DEFAULT_REF_STORAGE_FORMAT";;
 	esac
 }
 
@@ -93,13 +93,13 @@ test_expect_success 'adjacent, non-overlapping excluded regions' '
 	for_each_ref refs/heads/foo refs/heads/quux >expect &&
 
 	test_cmp expect actual &&
-	case "$GIT_DEFAULT_REF_FORMAT" in
+	case "$GIT_DEFAULT_REF_STORAGE_FORMAT" in
 	files)
 		assert_jumps 1 perf;;
 	reftable)
 		assert_jumps 2 perf;;
 	*)
-		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
+		BUG "unhandled ref storage format $GIT_DEFAULT_REF_STORAGE_FORMAT";;
 	esac
 '
 
@@ -125,13 +125,13 @@ test_expect_success 'several overlapping excluded regions' '
 	for_each_ref refs/heads/quux >expect &&
 
 	test_cmp expect actual &&
-	case "$GIT_DEFAULT_REF_FORMAT" in
+	case "$GIT_DEFAULT_REF_STORAGE_FORMAT" in
 	files)
 		assert_jumps 1 perf;;
 	reftable)
 		assert_jumps 3 perf;;
 	*)
-		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
+		BUG "unhandled ref storage format $GIT_DEFAULT_REF_STORAGE_FORMAT";;
 	esac
 '
 
@@ -141,13 +141,13 @@ test_expect_success 'unordered excludes' '
 	for_each_ref refs/heads/bar refs/heads/quux >expect &&
 
 	test_cmp expect actual &&
-	case "$GIT_DEFAULT_REF_FORMAT" in
+	case "$GIT_DEFAULT_REF_STORAGE_FORMAT" in
 	files)
 		assert_jumps 1 perf;;
 	reftable)
 		assert_jumps 2 perf;;
 	*)
-		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
+		BUG "unhandled ref storage format $GIT_DEFAULT_REF_STORAGE_FORMAT";;
 	esac
 '
 
diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
index ab119a6568..525b2a19b4 100755
--- a/t/t1423-ref-backend.sh
+++ b/t/t1423-ref-backend.sh
@@ -12,7 +12,7 @@ test_description='Test reference backend URIs'
 #   <uri> is the new URI to be set for the ref storage.
 #   <cmd> is the git subcommand to be run in the repository.
 #   <via> if 'config', set the backend via the 'extensions.refStorage' config.
-#         if 'env', set the backend via the 'GIT_REFERENCE_BACKEND' env.
+#         if 'env', set the backend via the 'GIT_REF_STORAGE_FORMAT' env.
 run_with_uri () {
 	repo=$1 &&
 	backend=$2 &&
@@ -23,7 +23,7 @@ run_with_uri () {
 	git -C "$repo" config set core.repositoryformatversion 1 &&
 	if test "$via" = "env"
 	then
-		test_env GIT_REFERENCE_BACKEND="$uri" git -C "$repo" $cmd
+		test_env GIT_REF_STORAGE_FORMAT="$uri" git -C "$repo" $cmd
 	elif test "$via" = "config"
 	then
 		git -C "$repo" config set extensions.refStorage "$uri" &&
@@ -40,7 +40,7 @@ run_with_uri () {
 #   <backend> is the original ref storage of the repo.
 #   <uri> is the new URI to be set for the ref storage.
 #   <via> if 'config', set the backend via the 'extensions.refStorage' config.
-#         if 'env', set the backend via the 'GIT_REFERENCE_BACKEND' env.
+#         if 'env', set the backend via the 'GIT_REF_STORAGE_FORMAT' env.
 #   <err_msg> (optional) if set, check if 'git-refs(1)' failed with the provided msg.
 test_refs_backend () {
 	repo=$1 &&
@@ -54,7 +54,7 @@ test_refs_backend () {
 	then
 		if test "$via" = "env"
 		then
-			test_env GIT_REFERENCE_BACKEND="$uri" test_must_fail git -C "$repo" refs list 2>err
+			test_env GIT_REF_STORAGE_FORMAT="$uri" test_must_fail git -C "$repo" refs list 2>err
 		elif test "$via" = "config"
 		then
 			git -C "$repo" config set extensions.refStorage "$uri" &&
@@ -83,7 +83,7 @@ verify_files_exist () {
 	test_cmp expect $gitdir/HEAD
 
 	# verify that backend specific files exist.
-	case "$GIT_DEFAULT_REF_FORMAT" in
+	case "$GIT_DEFAULT_REF_STORAGE_FORMAT" in
 	files)
 		test_path_is_dir $refdir/refs/heads &&
 		test_path_is_file $refdir/HEAD;;
@@ -91,7 +91,7 @@ verify_files_exist () {
 		test_path_is_dir $refdir/reftable &&
 		test_path_is_file $refdir/reftable/tables.list;;
 	*)
-		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
+		BUG "unhandled ref storage format $GIT_DEFAULT_REF_STORAGE_FORMAT";;
 	esac
 }
 
@@ -210,7 +210,7 @@ do
 	test_expect_success "migrating repository to $to_format with alternate refs directory" '
 		test_when_finished "rm -rf repo refdir" &&
 		mkdir refdir &&
-		GIT_REFERENCE_BACKEND="${from_format}://$(pwd)/refdir" git init repo &&
+		GIT_REF_STORAGE_FORMAT="${from_format}://$(pwd)/refdir" git init repo &&
 		(
 			cd repo &&
 
@@ -235,7 +235,7 @@ test_expect_success 'initializing repository with alt ref directory' '
 	test_when_finished "rm -rf repo refdir" &&
 	mkdir refdir &&
 	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
-	GIT_REFERENCE_BACKEND=$BACKEND git init repo &&
+	GIT_REF_STORAGE_FORMAT=$BACKEND git init repo &&
 	verify_files_exist repo/.git refdir &&
 	(
 		cd repo &&
@@ -264,7 +264,7 @@ test_expect_success 'cloning repository with alt ref directory' '
 	test_commit -C source 3 &&
 
 	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
-	GIT_REFERENCE_BACKEND=$BACKEND git clone source repo &&
+	GIT_REF_STORAGE_FORMAT=$BACKEND git clone source repo &&
 
 	git -C repo config get extensions.refstorage >actual &&
 	echo $BACKEND >expect &&
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mixed-ref-formats.sh
index 9707744644..197c02bcf0 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -12,7 +12,7 @@ test_ref_format () {
 
 for OTHER_FORMAT in files reftable
 do
-	if test "$OTHER_FORMAT" = "$GIT_DEFAULT_REF_FORMAT"
+	if test "$OTHER_FORMAT" = "$GIT_DEFAULT_REF_STORAGE_FORMAT"
 	then
 		continue
 	fi
@@ -43,7 +43,7 @@ test_expect_success 'add submodules with different ref storage format' '
 	git init submodule &&
 	test_commit -C submodule submodule-initial &&
 	git init upstream &&
-	test_ref_format upstream "$GIT_DEFAULT_REF_FORMAT" &&
+	test_ref_format upstream "$GIT_DEFAULT_REF_STORAGE_FORMAT" &&
 	git -C upstream submodule add --ref-storage-format="$OTHER_FORMAT" "file://$(pwd)/submodule" &&
 	test_ref_format upstream/submodule "$OTHER_FORMAT"
 '
@@ -59,8 +59,8 @@ test_expect_success 'recursive clone propagates ref storage format' '
 
 	# The upstream repository and its submodule should be using the default
 	# ref format.
-	test_ref_format upstream "$GIT_DEFAULT_REF_FORMAT" &&
-	test_ref_format upstream/submodule "$GIT_DEFAULT_REF_FORMAT" &&
+	test_ref_format upstream "$GIT_DEFAULT_REF_STORAGE_FORMAT" &&
+	test_ref_format upstream/submodule "$GIT_DEFAULT_REF_STORAGE_FORMAT" &&
 
 	# The cloned repositories should use the other ref format that we have
 	# specified via `--ref-storage-format`. The option should propagate to cloned
@@ -81,7 +81,7 @@ test_expect_success 'clone submodules with different ref storage format' '
 	git -C upstream commit -m "upstream submodule" &&
 
 	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
-	test_ref_format downstream "$GIT_DEFAULT_REF_FORMAT" &&
+	test_ref_format downstream "$GIT_DEFAULT_REF_STORAGE_FORMAT" &&
 	git -C downstream submodule update --init --ref-storage-format=$OTHER_FORMAT &&
 	test_ref_format downstream/submodule "$OTHER_FORMAT"
 '
@@ -98,7 +98,7 @@ test_expect_success 'status with mixed submodule ref storages' '
 
 	# The main repository should use the default ref format now, whereas
 	# the submodule should use the other format.
-	test_ref_format main "$GIT_DEFAULT_REF_FORMAT" &&
+	test_ref_format main "$GIT_DEFAULT_REF_STORAGE_FORMAT" &&
 	test_ref_format main/submodule "$OTHER_FORMAT" &&
 
 	cat >expect <<-EOF &&
@@ -123,7 +123,7 @@ test_expect_success 'recursive pull with mixed formats' '
 	# submodules have different formats.
 	git clone --no-recurse-submodules "file://$(pwd)/upstream" downstream &&
 	git -C downstream submodule update --init --ref-storage-format=$OTHER_FORMAT &&
-	test_ref_format downstream "$GIT_DEFAULT_REF_FORMAT" &&
+	test_ref_format downstream "$GIT_DEFAULT_REF_STORAGE_FORMAT" &&
 	test_ref_format downstream/submodule "$OTHER_FORMAT" &&
 
 	# Update the upstream submodule as well as the owning repository such
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1f0505e412..60a2179a0a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -575,8 +575,8 @@ export EDITOR
 GIT_TEST_BUILTIN_HASH=$("$GIT_BINARY" version --build-options | sed -ne 's/^default-hash: //p')
 GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}"
 export GIT_DEFAULT_HASH
-GIT_DEFAULT_REF_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
-export GIT_DEFAULT_REF_FORMAT
+GIT_DEFAULT_REF_STORAGE_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
+export GIT_DEFAULT_REF_STORAGE_FORMAT
 
 # Tests using GIT_TRACE typically don't want <timestamp> <file>:<line> output
 GIT_TRACE_BARE=1
@@ -1752,13 +1752,13 @@ parisc* | hppa*)
 	;;
 esac
 
-case "$GIT_DEFAULT_REF_FORMAT" in
+case "$GIT_DEFAULT_REF_STORAGE_FORMAT" in
 files)
 	test_set_prereq REFFILES;;
 reftable)
 	test_set_prereq REFTABLE;;
 *)
-	echo 2>&1 "error: unknown ref format $GIT_DEFAULT_REF_FORMAT"
+	echo 2>&1 "error: unknown ref storage format $GIT_DEFAULT_REF_STORAGE_FORMAT"
 	exit 1
 	;;
 esac

-- 
2.55.0.1074.ge7621b4bad.dirty

