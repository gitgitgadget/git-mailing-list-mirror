Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA7E53ED01
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952413; cv=none; b=makCvd6fb0UeML0fwgtkDH9LGf025Ccjd3zQeKhDmFfEQkZpc4BRNbo0pZ/W3s8VcOzA5J29ww0F6zFxa0eW8xzsk2vvthX51YTuBYHVmu3GZLk1DVPDwcpmRtxgRlwsumD6NACCM0LWExIvJ6mXk17aMIYh8Su3wsf+HLgBUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952413; c=relaxed/simple;
	bh=UMOpgdG3RdJbmvr93JAJA0vUMk258XGmycFbUvs0BWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=prY1uK1okB8L06bdvgBvSiy6KSjEOKIwIl0qtB1lnENne8HoTJ0nfUgAXr8b5hYgwRKaNyElph165dP0V+KQ0f7d8erSso0eou73HkwCr09GBGKo8Dd3xfIoCd65w0FpWmHMXCcQng9B/OW4QH5eGV+9jDWXVeFK7MNDAI1U/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZORh83zz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ITJtgtdz; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZORh83zz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ITJtgtdz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FAD1EC00A6;
	Wed,  9 Sep 2026 07:13:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 09 Sep 2026 07:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788952406;
	 x=1789038806; bh=BD036ZZtC9FDlrlQG1RrLOli5CEIxa+Z6w5aziEfuYs=; b=
	ZORh83zzjiVkGOowy44zGY+puwu9BZauyGgQtth+A20DGXcyhIp8g10XoDRzuGdA
	7D5f2gCjtzVcrhQsnhqyjzufufTnQU7R2xREjA8/5jJ5KULzdwGRUpCSW11DiAIa
	JsKPppJearZz9pTSTZ0804t3/e21qrcsqzRaC0mPKiRSNik9ALLZWJiFPGUe2uCM
	kBdEpwTMNtZYTehe9q1solqIMs8WN13ixQAaMow/nK00lgUoQxxFD1hirDZSvESA
	1FCt5dzTzf2oJ69d29SGO2opvo9bGfg4hlCeLtJqlS33Z8+ixSwn8fFLRGfBpqzq
	3gAgo1qbDCmvg3PeTOuTfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788952406; x=
	1789038806; bh=BD036ZZtC9FDlrlQG1RrLOli5CEIxa+Z6w5aziEfuYs=; b=I
	TJtgtdzRQu0Se2U+FrK5GUIIIrtt+681PoEmHBo2+08T2/7Y1wLOkvAglP2gXvAv
	mzzBZa7agi7f2X7Fnbia3H9yQ/y8VH2cr0Xvob1esgg0fj2zI76d9NRnYdbAj6dk
	k7L5h6Q+n1kM90N3m8RCoH0oEb9GwU+OZcLBZSQPtHPYxvW6aRA1UF0kMPEx/U7H
	l14iNxdo80jaQlktH0Vr7oSIOM9FY68c0piJVzjPkYWrjIpZEk1mjb1EMnBPdWFe
	EQpUm6yqYD9FGPQPKmWqFH/1lzk0HK5F1iXpy5RAyIDt4mMvaNSg3Q30K7WYUZEa
	4OUe49UkDokgtWhYhxzVQ==
X-ME-Sender: <xms:Vj-hahSh6AqTdPl1-_dUWEecoHSjcivQYLTUX5-a7Q8asm3FTChfwg>
    <xme:Vj-hahxOY98SA4kikGdftkl_wS0XX97lFSYsNG6z-Ir08FFo0cpuTdDtjB1S0_lky
    YvbIDV3rw571AXKsk-Wmdzqhi9tH2OwAUreGtyYu_Vjf7KbpfC1hCA>
X-ME-Received: <xmr:Vj-har13Lw3demOb68Cb22cqMRk0ANZabaykPScUU4eAPqzNP0YWdo2Tlf8ySldVKjKW0A>
X-ME-Proxy-Cause: dmFkZTESDl1uHydgc7lboX2Dp93aLtdmIT/9v9muEBEjsTAS+Xw/EY73d5uyu676Gjg9TD
    P3ojVcTa6V0wUPZTM3BHhNvFB+yQ6mBZPquc4lGm73tedAYGNQEbYS8FnSQHj7AxwKVOKC
    iOtFxSWsMMlGwLssJ8yasksbChGeoiqmv9phJWxx+76QnIeGDVp4xhX/kKid369u0vOq9l
    O4oI+DbuxB9BFGMlVsF+S2A0o1Kscd3dxCGHBhxeHi8MS7ch9rjWmzm5BV076G95sz+7yd
    ETUKpd6BPvPSH/akA2zEvlfccPzP0BXRQrWPTI/yMQV/rQq/pJo45FYJyQJaGKz2pZu3BR
    +6/FA1ntiKbo+oFmVYjlBWtkDqBMt9ma1iG0b1lv075Da+i3JlFU4AUPWs4mUb36dk09Yz
    yyrtus0UdUCZZ2slAj2OaVxdhIIoyXesIUGB6QnlCqBImVZRdk6yk2xdF8D4QGAAeK07t/
    rn7+e4u3Qa9WwRU1AlAlNTNakdHF8ifKHFA0XRPOIcv1UQx6B1CIuYk1Qo1t42Ojal4yNv
    hbDjiFdGKK4+tuEHKv6Hymc46DblCOczLLG2wV/Gab1KIhQojgZiET+wwQ/WMpEmAo6jKe
    NEzY0OjxBL9jjCo4/zyIVSbGZFHLwTiiFpy87OxyX87tCXQqw3DtxogB+iLg
X-ME-Proxy: <xmx:Vj-han7XJWRPCtc2Tg3lsHi5CodBRdiBQA20boIW06Ah0gOjtcW4Bg>
    <xmx:Vj-hamUqIT3NL8i6Af3uhTeQQeuVmebHrKnlOCAb4AOtETCv3qmlLg>
    <xmx:Vj-hauAY6Mw9lX9ApMewKGNzpVmrszOlbQMsIGtaKPalVAN0tfER6Q>
    <xmx:Vj-hat7qlntilI7hYfK0ZntwK2VrfXeddO2xpVlCEUN0wSB8DnXfhw>
    <xmx:Vj-hajXMEUkcdBpxWhRrb2-P3kd3qhWTv3QhVfzuIz4uBHLZq1kPiqz1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 07:13:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 251979f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 11:13:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 13:12:58 +0200
Subject: [PATCH v3 12/13] setup: rename "init.defaultRefFormat" to
 "init.defaultRefStorageFormat"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-pks-unify-ref-storage-format-v3-12-ca041fb40ad8@pks.im>
References: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
In-Reply-To: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

With the same reasoning as for git-init(1), rename the
"init.defaultRefFormat" config option to "init.defaultRefStorageFormat"
and keep the old name as an alias.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.adoc |  2 +-
 Documentation/config/feature.adoc  |  2 +-
 Documentation/config/init.adoc     |  4 +++-
 setup.c                            |  8 +++++---
 t/t0001-init.sh                    | 16 ++++++++--------
 5 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index 73bb939359..c2cef3f528 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -156,7 +156,7 @@ Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
      "packed-refs" file.
 +
 Users that get immediate benefit from the "reftable" backend could continue to
-opt-in to the "reftable" format manually by setting the "init.defaultRefFormat"
+opt-in to the "reftable" format manually by setting the "init.defaultRefStorageFormat"
 config. But defaults matter, and we think that overall users will have a better
 experience with less platform-specific quirks when they use the new backend by
 default.
diff --git a/Documentation/config/feature.adoc b/Documentation/config/feature.adoc
index 924f5ff4e3..e258770591 100644
--- a/Documentation/config/feature.adoc
+++ b/Documentation/config/feature.adoc
@@ -25,7 +25,7 @@ reusing objects from multiple packs instead of just one.
 significantly smaller in the presence of certain filename collisions with Git's
 default name-hash.
 +
-* `init.defaultRefFormat=reftable` causes newly initialized repositories to use
+* `init.defaultRefStorageFormat=reftable` causes newly initialized repositories to use
 the reftable format for storing references. This new format solves issues with
 case-insensitive filesystems, compresses better and performs significantly
 better with many use cases. Refer to Documentation/technical/reftable.adoc for
diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
index f82fcf25e6..e45bd692db 100644
--- a/Documentation/config/init.adoc
+++ b/Documentation/config/init.adoc
@@ -13,11 +13,13 @@ endif::[]
 	`--object-format=` in linkgit:git-init[1]. Both the command line option
 	and the `GIT_DEFAULT_HASH` environment variable take precedence over
 	this config.
-`init.defaultRefFormat`::
+`init.defaultRefStorageFormat`::
 	Allows overriding the default ref storage format for new repositories.
 	See `--ref-storage-format=` in linkgit:git-init[1]. Both the command line
 	option and the `GIT_DEFAULT_REF_STORAGE_FORMAT` environment variable take
 	precedence over this config.
+`init.defaultRefFormat`::
+	Deprecated alias of `init.defaultRefStorageFormat`.
 
 init.defaultSubmodulePathConfig::
 	A boolean that specifies if `git init` and `git clone` should
diff --git a/setup.c b/setup.c
index 621cf87c9c..df8cbf196d 100644
--- a/setup.c
+++ b/setup.c
@@ -2697,7 +2697,8 @@ static int read_default_format_config(const char *key, const char *value,
 		goto out;
 	}
 
-	if (!strcmp(key, "init.defaultrefformat")) {
+	if (!strcmp(key, "init.defaultrefstorageformat") ||
+	    !strcmp(key, "init.defaultrefformat")) {
 		ret = git_config_string(&str, key, value);
 		if (ret)
 			goto out;
@@ -2709,7 +2710,7 @@ static int read_default_format_config(const char *key, const char *value,
 
 	/*
 	 * Enable the reftable format when "features.experimental" is enabled.
-	 * "init.defaultRefFormat" takes precedence over this setting.
+	 * "init.defaultRefStorageFormat" takes precedence over this setting.
 	 */
 	if (!strcmp(key, "feature.experimental") &&
 	    cfg->ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN &&
@@ -2784,7 +2785,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	 *   5. Its deprecated equivalent "GIT_DEFAULT_REF_FORMAT".
 	 *
 	 *   6. The default ref storage format for new repositories as
-	 *      configured via "init.defaultRefFormat"
+	 *      configured via "init.defaultRefStorageFormat" or its deprecated
+	 *      equivalent "init.defaultRefFormat".
 	 *
 	 *   7. Otherwise, we fall back to the default ref storage format
 	 *      compiled into Git.
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index af9a7ba958..fe5bc3d3e1 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -659,9 +659,9 @@ test_expect_success 'GIT_REF_STORAGE_FORMAT refuses to reinitialize with differe
 	test_cmp expect err
 '
 
-test_expect_success 'init warns about invalid init.defaultRefFormat' '
+test_expect_success 'init warns about invalid init.defaultRefStorageFormat' '
 	test_when_finished "rm -rf repo" &&
-	test_config_global init.defaultRefFormat garbage &&
+	test_config_global init.defaultRefStorageFormat garbage &&
 
 	echo "warning: unknown ref storage format ${SQ}garbage${SQ}" >expect &&
 	git init repo 2>err &&
@@ -714,9 +714,9 @@ do
 		test_cmp expect actual
 	'
 
-	test_expect_success "init with init.defaultRefFormat=$format" '
+	test_expect_success "init with init.defaultRefStorageFormat=$format" '
 		test_when_finished "rm -rf refformat" &&
-		test_config_global init.defaultRefFormat $format &&
+		test_config_global init.defaultRefStorageFormat $format &&
 		(
 			sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
 			git init refformat
@@ -753,9 +753,9 @@ test_expect_success "--ref-storage-format= overrides GIT_DEFAULT_REF_STORAGE_FOM
 	test_cmp expect actual
 '
 
-test_expect_success "GIT_DEFAULT_REF_STORAGE_FORMAT= overrides init.defaultRefFormat" '
+test_expect_success "GIT_DEFAULT_REF_STORAGE_FORMAT= overrides init.defaultRefStorageFormat" '
 	test_when_finished "rm -rf refformat" &&
-	test_config_global init.defaultRefFormat files &&
+	test_config_global init.defaultRefStorageFormat files &&
 
 	GIT_DEFAULT_REF_STORAGE_FORMAT=reftable git init refformat &&
 	echo reftable >expect &&
@@ -775,10 +775,10 @@ test_expect_success "init with feature.experimental=true" '
 	test_cmp expect actual
 '
 
-test_expect_success "init.defaultRefFormat overrides feature.experimental=true" '
+test_expect_success "init.defaultRefStorageFormat overrides feature.experimental=true" '
 	test_when_finished "rm -rf refformat" &&
 	test_config_global feature.experimental true &&
-	test_config_global init.defaultRefFormat files &&
+	test_config_global init.defaultRefStorageFormat files &&
 	(
 		sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
 		git init refformat

-- 
2.55.0.1074.ge7621b4bad.dirty

