Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C38746EF61
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518189; cv=none; b=H1okoyanLQ9uzqAojx5QQLIQYIEJMxYrVtMk6gdEQcrXa1gHXTtJ0rV7dZK0Ffq1s1SIFHpKWEJAjfI6XQRt5woV2vBcUdJGlIInPXupz25m+Q8XMqImSJM2YtDbhvDBeQN1V7+3ne334xT0UWCkpEN0tJCmYDEpizwiRsLDcNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518189; c=relaxed/simple;
	bh=UsrcEKYB68KaeSsK4eZ+eyYuWM/LjnYPUVW2tyCxHQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lcYCLatwMvmkCfxxiy1a0J4bO8vWVCMMkXAWCp2SSNBF+awpRWRzQAIMQwFloSVuS1QshxR4m68liLZ/XfiesGL2wWGTakX41RjQ8t4IuemDCm2Z2fRBHLWKoz+qP4k6HebImjvSsU5m/tXGIkQgf8ZZ8alYyTNCnkrdMnZDWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tu5wZzuO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IcqiISYb; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tu5wZzuO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IcqiISYb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D49BE7A0130;
	Fri,  4 Sep 2026 06:36:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 06:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788518186;
	 x=1788604586; bh=zGPEmmKsQ54WN+lMOpwINd5vjyBYNtfzDNkE/SLGXag=; b=
	tu5wZzuOkXf8lDYhQ8t8S45JlMPCGFhwcbsOkC7EvIpJagJJ85JW5/Jd5MucqGEw
	G+FLxTe7LzJbQxCpUglDq9wu36CEfOesSwODMPR1ZwfKsAltXI60crXTphpiG+NH
	oxSbC3bfSThxi75GdCHGyhcfvnjQRLy8N5bgf9S7xrKZnetfx7K1+6CLMr2cvZ+r
	YIG42+IxOeEoFdTmBXAmaM5jucDmBBZSlbe9EWqWiIMMfcol9c2wVlZyMVKLMC06
	Lyua74BUboKXGsYM5bzvojE36heRHy7tqSg0itOTOBkrw86kvritKFIopCUyCD/q
	+v7govP1h2Uyj+tPqfGtIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788518186; x=
	1788604586; bh=zGPEmmKsQ54WN+lMOpwINd5vjyBYNtfzDNkE/SLGXag=; b=I
	cqiISYbdERbrC8VsK53Lw7u9uuk+/My2X6u/nKhdXOWaiNYSq1OkI2GtQgiYP3wZ
	OEJFeXtwCwHo64m5/YFupR9UIIKWzC1vMDuoTXSG+o8jNuYn/p1KK0X37L5+4/tl
	EOO+SO8u/FnKqUPYm3drUSx+UbJ3f+OGFjSIO59i3iSS6/97SQp9YBYkxegST+pJ
	iCllchDBecf7RueL6YA9parC51l4BAOvK9YXi7Z5YL1IN8G/NiViDE/bAWmBmRGf
	zG9hbNpYwzzamHkCv/CC4PhZ6D3LMr+wMvJ3/ZC9sGzU6EPKedxJAzSMxf+KeN1f
	cCsAmIuN/cev8yF3bJ6BQ==
X-ME-Sender: <xms:Kp-aaqIjUmKh5ekSTaHt15d6X7swnZvMWguaAMhsqVVduERFIWU_BA>
    <xme:Kp-aaoJX6NYNcKCtEdBNDsQydoA-xL-MSkaozR2Nb7b-q88GP7Oel9qxCcVcdOhBO
    -Ncv8Fkw-C9_AuTs-GURtH3UZp4ti87tLi6iAD86rMnKtAwypK_Bv0>
X-ME-Received: <xmr:Kp-aaoUErduWJpq62fYuO8ejEBPTq-JkvHk2SIS4jUCDnpjVzfpUuVrwozKR4KJfWeC8qg>
X-ME-Proxy-Cause: dmFkZTGz6D4YEbRdDrI6Swe/8q+Lu7kgrJ4joEx/DD4DhnNY9fOvRsdqoyg+mhwVBRG6wg
    ANR+o05wxYgYD0OE9AlLxIBBz+MyJp5OTVWpiY1EiLOW3Shz/hWnIdk2kSS0QkDhli39oN
    +6ZznalTze7BAokCKwPeM9gubUaHIjLuuDil0CZsLyLG34fFQiAUKYcp9j9NW0AegGdYwD
    UA2or6p9scc4e7xkswRC7oCGXib0KoFAcPdcw0/u/UCf/r6CqdDYbccUyBLSfeb0e35Y5O
    M9A+2vK75VDWfPtw23erXdwwYT0euNi7l5eUiSuShz40VSHywMTvBa1qJ8DeiIXQuocPNk
    kg9u5hkiXyZI56aVmU8kAaaEA+HNQUHkIlFIytPlfwcl9rDl9aQLJ1H7+sevpOIRf5zzrI
    XUQ3l8q7VWYCKKlZ2sHLDZtwT6sh2kLfsry4zgoQDByN1MXjMevfufA5oLffgxMqQCJc0b
    IswNAQkRlRx+x/fH02RoyYh1SDganVZk3LLDS52cjSBL8DE7eBONFIoyKDcDGKedqSMQAN
    BLqBKTsy05ZdcoFD0ng4m2UQ1uDYRkThzOkO+n3hXhnCb5USGHdQrtERRXEUnKAJCcZdQC
    zEwGd4LY4vJ8c8znUV6SJNIRcY1JlMHZnhS09isAX+DC7Rb3ydJ9Rlf2PuCw
X-ME-Proxy: <xmx:Kp-aaqizMKNNZq7952UcUch7imYK-yRPwK3jxOOgGf1To9zS_sYozA>
    <xmx:Kp-aaj_sy3XC2xafz3rqviJZHkFnvKdxuFR2uMKOwkG1EcxuwvhrQw>
    <xmx:Kp-aakAcwGdE-3uErv7pJo0LDCsh_NFfXbopwbM_sSXF_Eu450sCCw>
    <xmx:Kp-aagI6wizXn4St37NXAohK4Pte14qcmC5PrL_npj3lTTFDXtF-wA>
    <xmx:Kp-aar4I2zy3UVPpFIwdZurt-GLtdx6LR3yJb6o2hzp9xJOHAeNQaadQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 06:36:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8e190fef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Sep 2026 10:36:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 04 Sep 2026 12:36:06 +0200
Subject: [PATCH 05/11] builtin/rev-parse: rename "--show-ref-format" to
 "--show-ref-storage"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-b4-pks-unify-ref-storage-format-v1-5-08144e5004ff@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
In-Reply-To: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

With the same reasoning as for git-init(1), rename "--show-ref-format"
to "--show-ref-storage" and keep the old name as an alias.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-rev-parse.adoc       |  2 +-
 builtin/rev-parse.c                    |  2 +-
 contrib/completion/git-prompt.sh       |  2 +-
 t/perf/perf-lib.sh                     |  4 ++--
 t/t0001-init.sh                        | 36 +++++++++++++++++-----------------
 t/t0610-reftable-basics.sh             | 16 +++++++--------
 t/t1460-refs-migrate.sh                |  4 ++--
 t/t1500-rev-parse.sh                   |  8 ++++----
 t/t5601-clone.sh                       |  2 +-
 t/t7424-submodule-mixed-ref-formats.sh |  2 +-
 10 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/Documentation/git-rev-parse.adoc b/Documentation/git-rev-parse.adoc
index 5398691f3f..4c9dcc5652 100644
--- a/Documentation/git-rev-parse.adoc
+++ b/Documentation/git-rev-parse.adoc
@@ -331,7 +331,7 @@ The following options are unaffected by `--path-format`:
 	requested and no compatibility algorithm is enabled, prints an empty line. If
 	not specified, the default is "storage".
 
---show-ref-format::
+--show-ref-storage::
 	Show the reference storage format used for the repository.
 
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 43693454d5..9822037884 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -1134,7 +1134,7 @@ int cmd_rev_parse(int argc,
 				}
 				continue;
 			}
-			if (!strcmp(arg, "--show-ref-format")) {
+			if (!strcmp(arg, "--show-ref-format") || !strcmp(arg, "--show-ref-storage")) {
 				puts(ref_storage_format_to_name(the_repository->ref_storage_format));
 				continue;
 			}
diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 6186c474ba..e8107e8325 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -466,7 +466,7 @@ __git_ps1 ()
 
 	local repo_info rev_parse_exit_code
 	repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
-		--is-bare-repository --is-inside-work-tree --show-ref-format \
+		--is-bare-repository --is-inside-work-tree --show-ref-storage \
 		--short HEAD 2>/dev/null)"
 	rev_parse_exit_code="$?"
 
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 50a35545a1..b2826bc696 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -135,7 +135,7 @@ test_perf_create_repo_from () {
 	source_git="$("$MODERN_GIT" -C "$source" rev-parse --git-dir)"
 	objects_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-path objects)"
 	common_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-common-dir)"
-	refformat="$("$MODERN_GIT" -C "$source" rev-parse --show-ref-format)"
+	refstorage="$("$MODERN_GIT" -C "$source" rev-parse --show-ref-storage)"
 	objectformat="$("$MODERN_GIT" -C "$source" rev-parse --show-object-format)"
 	mkdir -p "$repo/.git"
 	(
@@ -153,7 +153,7 @@ test_perf_create_repo_from () {
 	) &&
 	(
 		cd "$repo" &&
-		"$MODERN_GIT" init -q --ref-storage="$refformat" --object-format="$objectformat" &&
+		"$MODERN_GIT" init -q --ref-storage="$refstorage" --object-format="$objectformat" &&
 		test_perf_do_repo_symlink_config_ &&
 		mv .git/hooks .git/hooks-disabled 2>/dev/null &&
 		if test -f .git/index.lock
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index bb3ec31097..26bd8c6822 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -657,7 +657,7 @@ test_expect_success 'init warns about invalid init.defaultRefFormat' '
 	git init repo 2>err &&
 	test_cmp expect err &&
 
-	git -C repo rev-parse --show-ref-format >actual &&
+	git -C repo rev-parse --show-ref-storage >actual &&
 	echo $GIT_DEFAULT_REF_FORMAT >expected &&
 	test_cmp expected actual
 '
@@ -669,7 +669,7 @@ test_expect_success 'default ref format' '
 		git init refformat
 	) &&
 	git version --build-options | sed -ne "s/^default-ref-format: //p" >expect &&
-	git -C refformat rev-parse --show-ref-format >actual &&
+	git -C refformat rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
 '
 
@@ -692,7 +692,7 @@ do
 		test_cmp expect actual &&
 
 		echo $format >expect &&
-		git -C refformat rev-parse --show-ref-format >actual &&
+		git -C refformat rev-parse --show-ref-storage >actual &&
 		test_cmp expect actual
 	'
 
@@ -700,7 +700,7 @@ do
 		test_when_finished "rm -rf refformat" &&
 		git init --ref-storage=$format refformat &&
 		echo $format >expect &&
-		git -C refformat rev-parse --show-ref-format >actual &&
+		git -C refformat rev-parse --show-ref-storage >actual &&
 		test_cmp expect actual
 	'
 
@@ -713,7 +713,7 @@ do
 		) &&
 
 		echo $format >expect &&
-		git -C refformat rev-parse --show-ref-format >actual &&
+		git -C refformat rev-parse --show-ref-storage >actual &&
 		test_cmp expect actual
 	'
 
@@ -721,16 +721,16 @@ do
 		test_when_finished "rm -rf refformat" &&
 		GIT_DEFAULT_REF_FORMAT=garbage git init --ref-storage=$format refformat &&
 		echo $format >expect &&
-		git -C refformat rev-parse --show-ref-format >actual &&
+		git -C refformat rev-parse --show-ref-storage >actual &&
 		test_cmp expect actual
 	'
 
 	test_expect_success "reinit repository with GIT_DEFAULT_REF_FORMAT=$format does not change format" '
 		test_when_finished "rm -rf refformat" &&
 		git init refformat &&
-		git -C refformat rev-parse --show-ref-format >expect &&
+		git -C refformat rev-parse --show-ref-storage >expect &&
 		GIT_DEFAULT_REF_FORMAT=$format git init refformat &&
-		git -C refformat rev-parse --show-ref-format >actual &&
+		git -C refformat rev-parse --show-ref-storage >actual &&
 		test_cmp expect actual
 	'
 done
@@ -739,7 +739,7 @@ test_expect_success "--ref-storage= overrides GIT_DEFAULT_REF_FORMAT" '
 	test_when_finished "rm -rf refformat" &&
 	GIT_DEFAULT_REF_FORMAT=files git init --ref-storage=reftable refformat &&
 	echo reftable >expect &&
-	git -C refformat rev-parse --show-ref-format >actual &&
+	git -C refformat rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
 '
 
@@ -749,7 +749,7 @@ test_expect_success "GIT_DEFAULT_REF_FORMAT= overrides init.defaultRefFormat" '
 
 	GIT_DEFAULT_REF_FORMAT=reftable git init refformat &&
 	echo reftable >expect &&
-	git -C refformat rev-parse --show-ref-format >actual &&
+	git -C refformat rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
 '
 
@@ -761,7 +761,7 @@ test_expect_success "init with feature.experimental=true" '
 		git init refformat
 	) &&
 	echo reftable >expect &&
-	git -C refformat rev-parse --show-ref-format >actual &&
+	git -C refformat rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
 '
 
@@ -774,7 +774,7 @@ test_expect_success "init.defaultRefFormat overrides feature.experimental=true"
 		git init refformat
 	) &&
 	echo files >expect &&
-	git -C refformat rev-parse --show-ref-format >actual &&
+	git -C refformat rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
 '
 
@@ -783,7 +783,7 @@ test_expect_success "GIT_DEFAULT_REF_FORMAT= overrides feature.experimental=true
 	test_config_global feature.experimental true &&
 	GIT_DEFAULT_REF_FORMAT=files git init refformat &&
 	echo files >expect &&
-	git -C refformat rev-parse --show-ref-format >actual &&
+	git -C refformat rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
 '
 
@@ -794,7 +794,7 @@ do
 		git init --ref-storage=$from_format refformat &&
 		git init --ref-storage=$from_format refformat &&
 		echo $from_format >expect &&
-		git -C refformat rev-parse --show-ref-format >actual &&
+		git -C refformat rev-parse --show-ref-storage >actual &&
 		test_cmp expect actual
 	'
 
@@ -814,7 +814,7 @@ do
 			test_must_fail git init --ref-storage=$to_format refformat 2>err &&
 			test_cmp expect err &&
 			echo $from_format >expect &&
-			git -C refformat rev-parse --show-ref-format >actual &&
+			git -C refformat rev-parse --show-ref-storage >actual &&
 			test_cmp expect actual
 		'
 	done
@@ -933,7 +933,7 @@ test_expect_success 'init with includeIf.onbranch condition' '
 	test_when_finished "rm -rf repo" &&
 	git -c includeIf.onbranch:main.path=nonexistent init repo &&
 	echo $GIT_DEFAULT_REF_FORMAT >expect &&
-	git -C repo rev-parse --show-ref-format >actual &&
+	git -C repo rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
 '
 
@@ -942,7 +942,7 @@ test_expect_success 'init with includeIf.onbranch condition with existing direct
 	mkdir repo &&
 	git -c includeIf.onbranch:nonexistent.path=/does/not/exist init repo &&
 	echo $GIT_DEFAULT_REF_FORMAT >expect &&
-	git -C repo rev-parse --show-ref-format >actual &&
+	git -C repo rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
 '
 
@@ -951,7 +951,7 @@ test_expect_success 're-init with includeIf.onbranch condition' '
 	git init repo &&
 	git -c includeIf.onbranch:nonexistent.path=/does/not/exist init repo &&
 	echo $GIT_DEFAULT_REF_FORMAT >expect &&
-	git -C repo rev-parse --show-ref-format >actual &&
+	git -C repo rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index d367b4b787..8588904c3f 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -27,7 +27,7 @@ test_expect_success 'init: creates basic reftable structures' '
 	test_path_is_dir repo/.git/reftable &&
 	test_path_is_file repo/.git/reftable/tables.list &&
 	echo reftable >expect &&
-	git -C repo rev-parse --show-ref-format >actual &&
+	git -C repo rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
 '
 
@@ -38,7 +38,7 @@ test_expect_success 'init: sha256 object format via environment variable' '
 	sha256
 	reftable
 	EOF
-	git -C repo rev-parse --show-object-format --show-ref-format >actual &&
+	git -C repo rev-parse --show-object-format --show-ref-storage >actual &&
 	test_cmp expect actual
 '
 
@@ -49,7 +49,7 @@ test_expect_success 'init: sha256 object format via option' '
 	sha256
 	reftable
 	EOF
-	git -C repo rev-parse --show-object-format --show-ref-format >actual &&
+	git -C repo rev-parse --show-object-format --show-ref-storage >actual &&
 	test_cmp expect actual
 '
 
@@ -156,7 +156,7 @@ test_expect_success 'clone: can clone reftable repository' '
 
 	git clone repo cloned &&
 	echo reftable >expect &&
-	git -C cloned rev-parse --show-ref-format >actual &&
+	git -C cloned rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual &&
 	test_path_is_file cloned/file1
 '
@@ -171,11 +171,11 @@ test_expect_success 'clone: can clone reffiles into reftable repository' '
 	git -C reftable rev-parse HEAD >actual &&
 	test_cmp expect actual &&
 
-	git -C reftable rev-parse --show-ref-format >actual &&
+	git -C reftable rev-parse --show-ref-storage >actual &&
 	echo reftable >expect &&
 	test_cmp expect actual &&
 
-	git -C reffiles rev-parse --show-ref-format >actual &&
+	git -C reffiles rev-parse --show-ref-storage >actual &&
 	echo files >expect &&
 	test_cmp expect actual
 '
@@ -190,11 +190,11 @@ test_expect_success 'clone: can clone reftable into reffiles repository' '
 	git -C reffiles rev-parse HEAD >actual &&
 	test_cmp expect actual &&
 
-	git -C reftable rev-parse --show-ref-format >actual &&
+	git -C reftable rev-parse --show-ref-storage >actual &&
 	echo reftable >expect &&
 	test_cmp expect actual &&
 
-	git -C reffiles rev-parse --show-ref-format >actual &&
+	git -C reffiles rev-parse --show-ref-storage >actual &&
 	echo files >expect &&
 	test_cmp expect actual
 '
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index 4f2ff725ce..2d73537de6 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -53,7 +53,7 @@ test_migration () {
 		test_cmp expect_logs actual_logs
 	fi &&
 
-	git -C "$repo" rev-parse --show-ref-format >actual &&
+	git -C "$repo" rev-parse --show-ref-storage >actual &&
 	echo "$format" >expect &&
 	test_cmp expect actual
 }
@@ -215,7 +215,7 @@ do
 			test_grep "Finished dry-run migration of refs" output &&
 			test_path_is_dir repo/.git/ref_migration.* &&
 			echo $from_format >expect &&
-			git -C repo rev-parse --show-ref-format >actual &&
+			git -C repo rev-parse --show-ref-storage >actual &&
 			test_cmp expect actual
 		'
 
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 4174ca40c3..72fe262484 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -241,19 +241,19 @@ test_expect_success RUST 'rev-parse --show-object-format in repo with compat mod
 	)
 '
 
-test_expect_success 'rev-parse --show-ref-format' '
+test_expect_success 'rev-parse --show-ref-storage' '
 	test_detect_ref_format >expect &&
-	git rev-parse --show-ref-format >actual &&
+	git rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'rev-parse --show-ref-format with invalid storage' '
+test_expect_success 'rev-parse --show-ref-storage with invalid storage' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
 		cd repo &&
 		git config extensions.refstorage broken &&
-		test_must_fail git rev-parse --show-ref-format 2>err &&
+		test_must_fail git rev-parse --show-ref-storage 2>err &&
 		test_grep "error: invalid value for ${SQ}extensions.refstorage${SQ}: ${SQ}broken${SQ}" err
 	)
 '
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 88f359914f..c0c17cf75a 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -168,7 +168,7 @@ test_expect_success 'clone with files ref format' '
 	test_when_finished "rm -rf ref-storage" &&
 	git clone --ref-storage=files --mirror src ref-storage &&
 	echo files >expect &&
-	git -C ref-storage rev-parse --show-ref-format >actual &&
+	git -C ref-storage rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mixed-ref-formats.sh
index c20d981ef2..4d03b71243 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -6,7 +6,7 @@ test_description='submodules handle mixed ref storage formats'
 
 test_ref_format () {
 	echo "$2" >expect &&
-	git -C "$1" rev-parse --show-ref-format >actual &&
+	git -C "$1" rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
 }
 

-- 
2.55.0.1007.g17ff1f9808.dirty

