Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C7053D0C7
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952400; cv=none; b=modTXxrLgxoDdLFURzyt6plgjFyYL1KWiXab8Qmdcg3FJYnquyh5unOBcrSfmlhfX5TR2cpZ6lWcg5CqgVMX61QYifhTR3athkzK0jrhMLWixQwmV6OnCRTp8w9lgbjs2gBuFX03aSYy6ompQil/XTxz43eHfOFXtMTFGJ6n5aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952400; c=relaxed/simple;
	bh=O7B2R8m3eS8ucPDxHDySKfqW5YnhDfGGLqV2EWrSLkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c5ytl4LooQKpWfX7KoDIfvKH0t5yyCu4AvSXQtE4vG6Ow6ewBx7FmOFZFq6DaIznZdEkyJOCHf3rLGwWNh2PL/GZvBuNRhAmTLiTXh0jwCjs+HH8VNErnWmzrxMuE/cW+DjGYiJEATZnLhSMtJxR2WkCXqbeYhVftjlKOcDlpB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iRLlosPm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XUq3jUXv; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iRLlosPm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XUq3jUXv"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B0E9D1400086;
	Wed,  9 Sep 2026 07:13:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 09 Sep 2026 07:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788952391;
	 x=1789038791; bh=bgPBxspCiQmIyFT1rZacK8cig3EfF/s0ST57A2FtK50=; b=
	iRLlosPmKhgR1vL65kJsEGo2PZNIFDhq7JFOmQu3OOU8aItcSVp51k6KBse55I5c
	JcNJf7oUq+OstjIe5PT63r2eS28FJF9WMGt2CjRIlCoId/QLJwQk26jOBOv8M4xu
	RDLaSQy40WkPnCWi8jTc/5v1ofmE+dbh7P5fOgD5CXy3ESy84SgUa1uKXsXNRa+J
	gcXlusbeJYrbxDaxSxaCmyYlFQv9HgX2NFa1kqb9Yhkkj4lzbGhQKr2pFyyYx29R
	/fi+KEpOD9wET7hQ/3njfy7YwuiogWOqzFeROcy2IsRNE6Kplmpj2dSSNn0zOSQb
	5HghMW9/K+UsGl+lwDcIyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788952391; x=
	1789038791; bh=bgPBxspCiQmIyFT1rZacK8cig3EfF/s0ST57A2FtK50=; b=X
	Uq3jUXvo68vM4vzdKDmv8TG4iPbQgxQso4D1jSCxz1k9ATde/k8WkIwFmp1a7XqF
	H1Mxy1Rw6twtijdbFHi9oopqSZK9tiLckHh1Z1WAW24lIz7Uv1XwPu5JYXuGOCPa
	RVHEHyVdo2FnNFGqrT/HHOB5opvUocVeFsS79u9P+JjE7jiKq0k8y7EyLHj8vJlv
	yKOkmUjFs1llreNUC5RlCBfgw9tN+g15QmaGkmm+mLX4YsNCW/Z65rFRqCgHIUf2
	i41l2MBDGnRGFjOYXREfgfWvmnm2it6swqK+rRj0nrpeZcVihisn6qfGOMK/e08M
	Fymz1Wfx0NgNTkONYO14g==
X-ME-Sender: <xms:Rz-haiRZ9NOe666sCXXfjU9CFkxXjPMwN5Hl8jI9ccUEydm0KA_Ezw>
    <xme:Rz-hauwMf4_7JU1hCRUx5bJTT5ohvEVhi2mGLfsh8NrACU2vNCzbvnXuXICX0EeY3
    -431-v2_MRWVrrG_75tFq_bpWjDRJ32ZaNpK9U55LuHbVHIh1JUag>
X-ME-Received: <xmr:Rz-hak2WLj7acEOkeV5kKTDSzeFrLgVnXZhiHhQFhfFZSl5xpa5bZzJUjxuIBEqAZ-POsQ>
X-ME-Proxy-Cause: dmFkZTEgs4mPvK/J4KadefVWhuMxnXVkl/Ljr8GuCQd0gcO5l63UJ7EXlC8TLyLpUtEIKR
    oJINO8cAKEKUB+NdWoMBAysV15i9YbwWsP8TaPW5YBjSlD7KzITnOaPqW9YWL+fu4+8nLq
    Y0L+VUQcat6bZ9NpIXFy+ByD9h5RH9yHa6Qa/0THEVS8DVCcr9CEUXeDsgDRabq0kHPwSV
    FOJOK9H1RmwKYbxnkX9ULWp7wMrrWom7VFI/pPBoke88eaoyNT4OqKVGuTkQ6h1ROWpTq/
    c2DO1rMiZoIJM0i9Pgla0k7tRCg4BD86RwtEXctgHfj8Z58H6kf0XTviw0NiU3SYA5aurz
    kHEyNgsIGGzgersbeZuWIdC3Q07beJf+6T4X2zIgWtDY4L9dLlTTlTImF7Y7eifkt/8qH2
    KKCbvxK0BAIHsR8kUKGzPmPMN5hK7O2txWAZTkA/ewYGhxrA/GQJr+yxpb8n4XAuyqO3lC
    ANZy9I3fZ1g/m0t7SJX9ubRfmup7VKinOWwtM3GyofRgEeWlnfxZaVpZeNX5dIePmPtLM0
    QFb8H5g+lFJYkXlJ8vHON9gu6Np1PuDitZJQ+p10SHQBcmaUiWfG2c2k+ZVaz7xOjvA9l5
    TsKKdn1hWHNjh3nqNiRnkMl86gfe4vANY9pAQR8/mVohezem4D8GDw/40N5Q
X-ME-Proxy: <xmx:Rz-has46-4IYfv2Jc-nX3jPHyrQBYlcbWOCjnRgJWmIYCqUZ4ux4Zw>
    <xmx:Rz-hanVT9gI9JJztMqn_PB4yUwgncdBoquO0Kvc4CWurI1SfY4IUsQ>
    <xmx:Rz-harD0TkYbQbf4BESV58LL1axzhjo20jQ1ByGxkOory4seDG_H1A>
    <xmx:Rz-ham5in5mbrubAghzEDn3cvT2yd2fwZkcuCKxBimtp08pXf5R9VQ>
    <xmx:Rz-hasW-IqwVLND-jqMksGHj2G16S2LAPRNMZrwOOYsUmG0GwmLJJcRW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 07:13:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 20c8e210 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 11:13:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 13:12:52 +0200
Subject: [PATCH v3 06/13] builtin/rev-parse: rename "--show-ref-format" to
 "--show-ref-storage-format"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-pks-unify-ref-storage-format-v3-6-ca041fb40ad8@pks.im>
References: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
In-Reply-To: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

With the same reasoning as for git-init(1), rename "--show-ref-format"
to "--show-ref-storage-format" and keep the old name as an alias.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-rev-parse.adoc       |  5 ++++-
 builtin/rev-parse.c                    |  2 +-
 contrib/completion/git-prompt.sh       |  2 +-
 t/perf/perf-lib.sh                     |  4 ++--
 t/t0001-init.sh                        | 36 +++++++++++++++++-----------------
 t/t0610-reftable-basics.sh             | 16 +++++++--------
 t/t1460-refs-migrate.sh                |  4 ++--
 t/t1500-rev-parse.sh                   |  8 ++++----
 t/t5601-clone.sh                       |  2 +-
 t/t7424-submodule-mixed-ref-formats.sh |  2 +-
 10 files changed, 42 insertions(+), 39 deletions(-)

diff --git a/Documentation/git-rev-parse.adoc b/Documentation/git-rev-parse.adoc
index 5398691f3f..14462ce7d9 100644
--- a/Documentation/git-rev-parse.adoc
+++ b/Documentation/git-rev-parse.adoc
@@ -331,9 +331,12 @@ The following options are unaffected by `--path-format`:
 	requested and no compatibility algorithm is enabled, prints an empty line. If
 	not specified, the default is "storage".
 
---show-ref-format::
+--show-ref-storage-format::
 	Show the reference storage format used for the repository.
 
+--show-ref-format::
+	Deprecated alias of `--show-ref-storage-format`.
+
 
 Other Options
 ~~~~~~~~~~~~~
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 43693454d5..ec33c19bdf 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -1134,7 +1134,7 @@ int cmd_rev_parse(int argc,
 				}
 				continue;
 			}
-			if (!strcmp(arg, "--show-ref-format")) {
+			if (!strcmp(arg, "--show-ref-format") || !strcmp(arg, "--show-ref-storage-format")) {
 				puts(ref_storage_format_to_name(the_repository->ref_storage_format));
 				continue;
 			}
diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 6186c474ba..754a5edc9a 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -466,7 +466,7 @@ __git_ps1 ()
 
 	local repo_info rev_parse_exit_code
 	repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
-		--is-bare-repository --is-inside-work-tree --show-ref-format \
+		--is-bare-repository --is-inside-work-tree --show-ref-storage-format \
 		--short HEAD 2>/dev/null)"
 	rev_parse_exit_code="$?"
 
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 3ce49fd423..846ecc35c3 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -135,7 +135,7 @@ test_perf_create_repo_from () {
 	source_git="$("$MODERN_GIT" -C "$source" rev-parse --git-dir)"
 	objects_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-path objects)"
 	common_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-common-dir)"
-	refformat="$("$MODERN_GIT" -C "$source" rev-parse --show-ref-format)"
+	ref_storage_format="$("$MODERN_GIT" -C "$source" rev-parse --show-ref-storage-format)"
 	objectformat="$("$MODERN_GIT" -C "$source" rev-parse --show-object-format)"
 	mkdir -p "$repo/.git"
 	(
@@ -153,7 +153,7 @@ test_perf_create_repo_from () {
 	) &&
 	(
 		cd "$repo" &&
-		"$MODERN_GIT" init -q --ref-storage-format="$refformat" --object-format="$objectformat" &&
+		"$MODERN_GIT" init -q --ref-storage-format="$ref_storage_format" --object-format="$objectformat" &&
 		test_perf_do_repo_symlink_config_ &&
 		mv .git/hooks .git/hooks-disabled 2>/dev/null &&
 		if test -f .git/index.lock
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index df9a2ff2da..b4f19d8077 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -657,7 +657,7 @@ test_expect_success 'init warns about invalid init.defaultRefFormat' '
 	git init repo 2>err &&
 	test_cmp expect err &&
 
-	git -C repo rev-parse --show-ref-format >actual &&
+	git -C repo rev-parse --show-ref-storage-format >actual &&
 	echo $GIT_DEFAULT_REF_FORMAT >expected &&
 	test_cmp expected actual
 '
@@ -669,7 +669,7 @@ test_expect_success 'default ref format' '
 		git init refformat
 	) &&
 	git version --build-options | sed -ne "s/^default-ref-format: //p" >expect &&
-	git -C refformat rev-parse --show-ref-format >actual &&
+	git -C refformat rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '
 
@@ -692,7 +692,7 @@ do
 		test_cmp expect actual &&
 
 		echo $format >expect &&
-		git -C refformat rev-parse --show-ref-format >actual &&
+		git -C refformat rev-parse --show-ref-storage-format >actual &&
 		test_cmp expect actual
 	'
 
@@ -700,7 +700,7 @@ do
 		test_when_finished "rm -rf refformat" &&
 		git init --ref-storage-format=$format refformat &&
 		echo $format >expect &&
-		git -C refformat rev-parse --show-ref-format >actual &&
+		git -C refformat rev-parse --show-ref-storage-format >actual &&
 		test_cmp expect actual
 	'
 
@@ -713,7 +713,7 @@ do
 		) &&
 
 		echo $format >expect &&
-		git -C refformat rev-parse --show-ref-format >actual &&
+		git -C refformat rev-parse --show-ref-storage-format >actual &&
 		test_cmp expect actual
 	'
 
@@ -721,16 +721,16 @@ do
 		test_when_finished "rm -rf refformat" &&
 		GIT_DEFAULT_REF_FORMAT=garbage git init --ref-storage-format=$format refformat &&
 		echo $format >expect &&
-		git -C refformat rev-parse --show-ref-format >actual &&
+		git -C refformat rev-parse --show-ref-storage-format >actual &&
 		test_cmp expect actual
 	'
 
 	test_expect_success "reinit repository with GIT_DEFAULT_REF_FORMAT=$format does not change format" '
 		test_when_finished "rm -rf refformat" &&
 		git init refformat &&
-		git -C refformat rev-parse --show-ref-format >expect &&
+		git -C refformat rev-parse --show-ref-storage-format >expect &&
 		GIT_DEFAULT_REF_FORMAT=$format git init refformat &&
-		git -C refformat rev-parse --show-ref-format >actual &&
+		git -C refformat rev-parse --show-ref-storage-format >actual &&
 		test_cmp expect actual
 	'
 done
@@ -739,7 +739,7 @@ test_expect_success "--ref-storage-format= overrides GIT_DEFAULT_REF_FORMAT" '
 	test_when_finished "rm -rf refformat" &&
 	GIT_DEFAULT_REF_FORMAT=files git init --ref-storage-format=reftable refformat &&
 	echo reftable >expect &&
-	git -C refformat rev-parse --show-ref-format >actual &&
+	git -C refformat rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '
 
@@ -749,7 +749,7 @@ test_expect_success "GIT_DEFAULT_REF_FORMAT= overrides init.defaultRefFormat" '
 
 	GIT_DEFAULT_REF_FORMAT=reftable git init refformat &&
 	echo reftable >expect &&
-	git -C refformat rev-parse --show-ref-format >actual &&
+	git -C refformat rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '
 
@@ -761,7 +761,7 @@ test_expect_success "init with feature.experimental=true" '
 		git init refformat
 	) &&
 	echo reftable >expect &&
-	git -C refformat rev-parse --show-ref-format >actual &&
+	git -C refformat rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '
 
@@ -774,7 +774,7 @@ test_expect_success "init.defaultRefFormat overrides feature.experimental=true"
 		git init refformat
 	) &&
 	echo files >expect &&
-	git -C refformat rev-parse --show-ref-format >actual &&
+	git -C refformat rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '
 
@@ -783,7 +783,7 @@ test_expect_success "GIT_DEFAULT_REF_FORMAT= overrides feature.experimental=true
 	test_config_global feature.experimental true &&
 	GIT_DEFAULT_REF_FORMAT=files git init refformat &&
 	echo files >expect &&
-	git -C refformat rev-parse --show-ref-format >actual &&
+	git -C refformat rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '
 
@@ -794,7 +794,7 @@ do
 		git init --ref-storage-format=$from_format refformat &&
 		git init --ref-storage-format=$from_format refformat &&
 		echo $from_format >expect &&
-		git -C refformat rev-parse --show-ref-format >actual &&
+		git -C refformat rev-parse --show-ref-storage-format >actual &&
 		test_cmp expect actual
 	'
 
@@ -814,7 +814,7 @@ do
 			test_must_fail git init --ref-storage-format=$to_format refformat 2>err &&
 			test_cmp expect err &&
 			echo $from_format >expect &&
-			git -C refformat rev-parse --show-ref-format >actual &&
+			git -C refformat rev-parse --show-ref-storage-format >actual &&
 			test_cmp expect actual
 		'
 	done
@@ -933,7 +933,7 @@ test_expect_success 'init with includeIf.onbranch condition' '
 	test_when_finished "rm -rf repo" &&
 	git -c includeIf.onbranch:main.path=nonexistent init repo &&
 	echo $GIT_DEFAULT_REF_FORMAT >expect &&
-	git -C repo rev-parse --show-ref-format >actual &&
+	git -C repo rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '
 
@@ -942,7 +942,7 @@ test_expect_success 'init with includeIf.onbranch condition with existing direct
 	mkdir repo &&
 	git -c includeIf.onbranch:nonexistent.path=/does/not/exist init repo &&
 	echo $GIT_DEFAULT_REF_FORMAT >expect &&
-	git -C repo rev-parse --show-ref-format >actual &&
+	git -C repo rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '
 
@@ -951,7 +951,7 @@ test_expect_success 're-init with includeIf.onbranch condition' '
 	git init repo &&
 	git -c includeIf.onbranch:nonexistent.path=/does/not/exist init repo &&
 	echo $GIT_DEFAULT_REF_FORMAT >expect &&
-	git -C repo rev-parse --show-ref-format >actual &&
+	git -C repo rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index d325f17a14..b6db54430a 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -27,7 +27,7 @@ test_expect_success 'init: creates basic reftable structures' '
 	test_path_is_dir repo/.git/reftable &&
 	test_path_is_file repo/.git/reftable/tables.list &&
 	echo reftable >expect &&
-	git -C repo rev-parse --show-ref-format >actual &&
+	git -C repo rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '
 
@@ -38,7 +38,7 @@ test_expect_success 'init: sha256 object format via environment variable' '
 	sha256
 	reftable
 	EOF
-	git -C repo rev-parse --show-object-format --show-ref-format >actual &&
+	git -C repo rev-parse --show-object-format --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '
 
@@ -49,7 +49,7 @@ test_expect_success 'init: sha256 object format via option' '
 	sha256
 	reftable
 	EOF
-	git -C repo rev-parse --show-object-format --show-ref-format >actual &&
+	git -C repo rev-parse --show-object-format --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '
 
@@ -156,7 +156,7 @@ test_expect_success 'clone: can clone reftable repository' '
 
 	git clone repo cloned &&
 	echo reftable >expect &&
-	git -C cloned rev-parse --show-ref-format >actual &&
+	git -C cloned rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual &&
 	test_path_is_file cloned/file1
 '
@@ -171,11 +171,11 @@ test_expect_success 'clone: can clone reffiles into reftable repository' '
 	git -C reftable rev-parse HEAD >actual &&
 	test_cmp expect actual &&
 
-	git -C reftable rev-parse --show-ref-format >actual &&
+	git -C reftable rev-parse --show-ref-storage-format >actual &&
 	echo reftable >expect &&
 	test_cmp expect actual &&
 
-	git -C reffiles rev-parse --show-ref-format >actual &&
+	git -C reffiles rev-parse --show-ref-storage-format >actual &&
 	echo files >expect &&
 	test_cmp expect actual
 '
@@ -190,11 +190,11 @@ test_expect_success 'clone: can clone reftable into reffiles repository' '
 	git -C reffiles rev-parse HEAD >actual &&
 	test_cmp expect actual &&
 
-	git -C reftable rev-parse --show-ref-format >actual &&
+	git -C reftable rev-parse --show-ref-storage-format >actual &&
 	echo reftable >expect &&
 	test_cmp expect actual &&
 
-	git -C reffiles rev-parse --show-ref-format >actual &&
+	git -C reffiles rev-parse --show-ref-storage-format >actual &&
 	echo files >expect &&
 	test_cmp expect actual
 '
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index 204dd79b41..ecf6411288 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -53,7 +53,7 @@ test_migration () {
 		test_cmp expect_logs actual_logs
 	fi &&
 
-	git -C "$repo" rev-parse --show-ref-format >actual &&
+	git -C "$repo" rev-parse --show-ref-storage-format >actual &&
 	echo "$format" >expect &&
 	test_cmp expect actual
 }
@@ -215,7 +215,7 @@ do
 			test_grep "Finished dry-run migration of refs" output &&
 			test_path_is_dir repo/.git/ref_migration.* &&
 			echo $from_format >expect &&
-			git -C repo rev-parse --show-ref-format >actual &&
+			git -C repo rev-parse --show-ref-storage-format >actual &&
 			test_cmp expect actual
 		'
 
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 4174ca40c3..30bf8a4d0a 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -241,19 +241,19 @@ test_expect_success RUST 'rev-parse --show-object-format in repo with compat mod
 	)
 '
 
-test_expect_success 'rev-parse --show-ref-format' '
+test_expect_success 'rev-parse --show-ref-storage-format' '
 	test_detect_ref_format >expect &&
-	git rev-parse --show-ref-format >actual &&
+	git rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'rev-parse --show-ref-format with invalid storage' '
+test_expect_success 'rev-parse --show-ref-storage-format with invalid storage' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
 		cd repo &&
 		git config extensions.refstorage broken &&
-		test_must_fail git rev-parse --show-ref-format 2>err &&
+		test_must_fail git rev-parse --show-ref-storage-format 2>err &&
 		test_grep "error: invalid value for ${SQ}extensions.refstorage${SQ}: ${SQ}broken${SQ}" err
 	)
 '
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 202d86bc83..06f6121f82 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -168,7 +168,7 @@ test_expect_success 'clone with files ref format' '
 	test_when_finished "rm -rf ref-storage" &&
 	git clone --ref-storage-format=files --mirror src ref-storage &&
 	echo files >expect &&
-	git -C ref-storage rev-parse --show-ref-format >actual &&
+	git -C ref-storage rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mixed-ref-formats.sh
index 2ef85289b3..9707744644 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -6,7 +6,7 @@ test_description='submodules handle mixed ref storage formats'
 
 test_ref_format () {
 	echo "$2" >expect &&
-	git -C "$1" rev-parse --show-ref-format >actual &&
+	git -C "$1" rev-parse --show-ref-storage-format >actual &&
 	test_cmp expect actual
 }
 

-- 
2.55.0.1074.ge7621b4bad.dirty

