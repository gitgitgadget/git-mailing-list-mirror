Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9884F470121
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780027; cv=none; b=b4VnXs+S+or70Do1jkcGrLHYa8VhcaI22677NkGTEx17VHclXQWfTEqbvpWa9nxKwn0PaxjsJ+jknSSX+P2P8YraMsx7UHlHMGZ2TnMXasaN9rbvkoG5Y5rGaVm9eNtkjDhNrvW9VbbPMhIxYpzswKf9Dxp7T4g+BSNp7/VNcUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780027; c=relaxed/simple;
	bh=dNvViGomOt2XdztsZ1vdN9fBGUat+VZb0GhsXfOo1O8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eICY0E6XmhJLYoADxHyI7Fkxlqvd02h9ZSkquGgPMxJigolIMkmyv4ncSO68D83Hg9To1UWfSNHA6MZKRCbKqT98PXjZmcklDJ7lysdqvE1rQWUy943aK5lhkz0TDVVSCAAMvNISnZvTUpg3Lfon/ZEbs9oPBjJUiUcJAT/uUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QzSfZwLF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N9afeJkw; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QzSfZwLF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N9afeJkw"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id BFA8EEC0230;
	Mon,  7 Sep 2026 07:20:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 07 Sep 2026 07:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788780023;
	 x=1788866423; bh=A5lCkl65+tjvWSl9KAIMNipe22xeI1u1PWYNFnuhUu8=; b=
	QzSfZwLFXvWMJeIi1cu520pbo658RMx9bv+/7cS67wU9AfOhZa0bFdFZ4Keonl9i
	648Ixo3XFNcGPcmklHpNfMOCQG6f4zs2gl1veFYA2ZS2hQWmYtaHpq+7rBDjmkV4
	S5aGsVXPN+W7ArSQCCgpG0zIQhz/hfZZn7q/2c6ug/JQz+fU8ZWeZa7e7+Itr+Kw
	1YrpeqCy0r7mFqDHEm6CjOMhSXX4NwLEpsDPILFkkceOJsrv3HDW5oscKF62imyT
	pOzodQZqf+VaoNVPiq/PWpj4AhsNvN0RRjwpo/7DvVMW1jNhwgoV+r4iGQ9TFI46
	HTkqfyP/4JoFe6tk3WUNvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788780023; x=
	1788866423; bh=A5lCkl65+tjvWSl9KAIMNipe22xeI1u1PWYNFnuhUu8=; b=N
	9afeJkwFaIjkG0lGPLJIAPawuFarz4ur3+kXp7dh70K+ZQlECccD7Vdf2JdMt+xZ
	vUMuBf4v19porY/BB6ziPEmGWPKrtPxcwny4sJ9fKWiweMI+Va4qOfePUrNCYUv8
	cs1yTJXGEY1C4TtP04B4Y+7DQHci3pFhmyR6F9jb2ksTPjYqpmAJE+kFZa88539V
	dZ/fvh4NPnQE8SqadlXg286nGvSEPbW25VzACw+vmSzmNNZhzgJaQCsQxzgY2Ya6
	JnMRMz9xbsWNDV5+zuTUw4EODne2aChv0RzvKaPtcQsaozUb7xUNA/v+FBDUdpdr
	t1jiOOf47b+kdwiGciZTg==
X-ME-Sender: <xms:952eakxF9t8PtZo2eCRRmXe1uUCrvHBOh_DUAVLAkuTibu38jVHc1A>
    <xme:952eavvA_xm-9Geh4oRJGdsArAUWduE92UKqiZL4b2J0bn9YdjnE34DMiod8I-v2v
    vPkC-OQp2GzBLKC7yeYqVSWXD90EoAgHQusTREQ2GAHneRgOtPDDUo>
X-ME-Received: <xmr:952eaju1KJ_7LZRQhaNNfJ5xxGTyaTBGV5L1Ra-wTnOjt6K9HIJrXA>
X-ME-Proxy-Cause: dmFkZTEODmYfhcE6MkClXmAzaz/u/B/AKDElneu4mL0qUxdd8dsBrCmOKXS1tHl60eVFV2
    SymYRFYzuiLUqyPPFAGooBAERtLvf0X1LhcjqzMnX7gdc7DtqXstRRoihdSALfCxoWFzJG
    BbbIbG0MP1m8AhEq/eZrNtPsqwDGfS6kNpj3lzhC6fPFYomNFvg9RKzjO2WnGUQd1KA2IH
    sWYk5pONmMX+mdXpmpfGC22NTMapciJwOTHnIl8o4jd+7ZhCw8vFlPa824pJltjvaD3N4A
    MUB/oyFdCvhdQMSVTPOi3Wa2Ehbr/+fSxb1kUGZO2C7ytEHmk7HxP5nm8sCCeE5hTY4Uk+
    FkhTyO3Akp2Sv1kwRyrtA48mf+haQJlJuYztjEbqW/XKzsDM9MoR8ylVIerGAtsJybgd4E
    c2MMCyWc3P29CJuZbfK+C9r+c1jWHYv2zMI9/fngLRk6WXpff2czeopNRECZOrJOzl0HG6
    2jo2hwQWpQhWxdNUENFcODomWlJHwi4BXiwpPQfA2DU1G3l7K9OllbVJmeN2WJcUSJM7mZ
    9AIusWkxCaPrJ9wb+OZrKoC9kudsfVoTQl2BQL+i7Kuk8jlp288uwwydk1d4j6Nl4HHSQ9
    2w2f8LICic6tvfehMZiwQJia3xIeVM7X9NhxkDVRD5opCy3ausBGEfd4rRMg
X-ME-Proxy: <xmx:952easOvVnwNAULX6itnM5TKm6V5P0gogBVxyaMFatJi-U19hofIOw>
    <xmx:952eap2D917PY97wXdKC8N3wdC19J5ckF1Jromh43nxwxOjcejIhTQ>
    <xmx:952eagOZ71R2OcKdAd2M3ZhlseuFNZmM0I01CCQWSv7hPDjk0TDgxA>
    <xmx:952eah3iE4SV_ypW6gSyldBKyUtMRnk359U3VARYZ-Y5Q-xIp4j-lA>
    <xmx:952eavtSLw3CQgaoDciBX8JcA4Ss8JF4mmqFAf5lmRbYq3yf8hOTKuwS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 07:20:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a8f0ce74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 11:20:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 13:18:39 +0200
Subject: [PATCH v2 05/11] builtin/rev-parse: rename "--show-ref-format" to
 "--show-ref-storage-format"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-b4-pks-unify-ref-storage-format-v2-5-6733c90ca5b0@pks.im>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
In-Reply-To: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

With the same reasoning as for git-init(1), rename "--show-ref-format"
to "--show-ref-storage-format" and keep the old name as an alias.

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
index 5398691f3f..f794ceef22 100644
--- a/Documentation/git-rev-parse.adoc
+++ b/Documentation/git-rev-parse.adoc
@@ -331,7 +331,7 @@ The following options are unaffected by `--path-format`:
 	requested and no compatibility algorithm is enabled, prints an empty line. If
 	not specified, the default is "storage".
 
---show-ref-format::
+--show-ref-storage-format::
 	Show the reference storage format used for the repository.
 
 
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
2.55.0.1007.g17ff1f9808.dirty

