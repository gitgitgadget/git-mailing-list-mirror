Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A88B44A3F4
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518183; cv=none; b=syONUtn7WhLgO+PCLQXzvH4oqkxJUn7qWTulWkkZ4wpLLO8JwT037hpxS+q7aCB9dlZbAzrNdvZuaJW+qgo2UAe5bmakfo+G0XXnb5FoAOAMQRrLuVqFHTZ6IeQYaErxFc7TUzbhMsMrDACv/PDz0WMiTCWUrAP3bG9PjkmmrPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518183; c=relaxed/simple;
	bh=kMD+xSuqDINLf12Xx751FE4fhoFYuuTCjH4wyhl8Brw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9PCOr3OszMvkAtu7Z8wZgUMjSGm8ZUnk5x23Q1m9LeWI5HwFQqtfcS2lgGrL4AwaeQNQ3O/UtXvRiGHnn7a42fXHShqvHe+1hgsRHNj2BLb+/lDbr/pyoX4rzyIpb2vHh+ujCurX1H4MrLKzodmH3LwoawWpY42aWypQetyUaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t7z3z/1C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q7HQNUDb; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t7z3z/1C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q7HQNUDb"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AC13C7A0138;
	Fri,  4 Sep 2026 06:36:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 04 Sep 2026 06:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788518180;
	 x=1788604580; bh=sJQCnw/aHVUxkHPBD9pgq1NuA7olDTvbwH/5dhVVMm4=; b=
	t7z3z/1CNfbk21+aabDu7vYMv0+sbQLxkf16OVFK6iHp9GWbfpqwRxERVv7zAEoM
	b4K8SEP4+1EGrYg9oUwUlLklZphlf7zU3cbkZ1TpOxtJihTxEJJZXGBZjBwrg058
	tNjsEPzX67YxELG9BuZISrnxSM0TXY/GfjNBGrCYYmJ5XA5/UKzjZHWSYn4TV14T
	SBpz0s8HlWAy7ixHdUhqZ5xvAHkl3WzaylAc8uGVbbFhYobgAV1Dubx8qFG9RrN9
	KTOPDvfm2/S2IVGnoWLpwk27QrSkac/qaqpYlzCZSbuXSt1jvF/E2Mo9zZaGRZgy
	WiomKAXV2gH4op21gpiKqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788518180; x=
	1788604580; bh=sJQCnw/aHVUxkHPBD9pgq1NuA7olDTvbwH/5dhVVMm4=; b=Q
	7HQNUDbMD1RtOE71T8P6aWWC+Tg3AuOOufcODN2d4RmqLihKDRemHDxiFwWtzkqo
	/5e4pjgNBN/UeaLNtdXZRYtWS1BkE2GETTroMOiOKNGugL07+aJQ8WlDnHrOEq8T
	XAXA7j43FG35oHfezh3F8/EzpMkvRqDSnsuk5hSVI+QKGjS5ZLCLUk3GoMNJ7VCV
	fgI+Zq8WQKHij71z3Omx9msuL/Z13IM3FzY+3dmiGXu8Yz2cWPK5fTygP8c7cHRE
	RGca4un5bmjQFaD16qHKChwqgId8tpVzfyiyTeMt2VeFxRVrRP7YO5hDilyd2AUh
	u4MncqpnLZM5xUa7GjTxA==
X-ME-Sender: <xms:I5-aaoH0EKFED7YRLATOAqNjdBNpZ3vGVJNRmF3dMO3LttWC1G9bbw>
    <xme:I5-aanWgY-3y5loFwh9d4gPG9bjspBiPCkh-LtP_NRS_JwI5H6Q9zMx8KCM-nHC4I
    Op__cQBY_iO6YiVC2_aPjTMM5B6Z0UuPbg3bg7I4I1NIR9IN6XQfrM>
X-ME-Received: <xmr:I5-aavxluSuDe9epN3zPs8JJx-k2-jhXaTkKdtPfNUQqcw5pz3UNh0BChibU8gIz8_HFzw>
X-ME-Proxy-Cause: dmFkZTGz6D4YEbRdDrI6Swe/8q+Lu7kgrJ4joEx/DD4DhnNY9fOvRsdqoyg+mhwVBRG6wg
    ANR+o05wxYgYD0OE9AlLxIBBz+MyJp5OTVWpiY1EiLOW3Shz/hWnIdk2kSS0QkDhli39oN
    +6ZznalTze7BAokCKwPeM9gubUaHIjLuuDil0CZsLyLG34fFQiAUKYcp9j9NW0AegGdYwD
    UA2or6p9scc4e7xkswRC7oCGXib0KoFAcPdcw0/u/UCf/r6CqdDYbccUyBLSfeb0e35Y5O
    M9A+2vK75VDWfPtw23erXdwwYT0euNi7l5eUiSuShz40VSHywMTvBa1qJ8DeiIXQuocPrO
    C/V6PufKaUW80jL+owxbkWEXMWrHqfLXnjrHxGnhRGSo/UKFTMKZ+Z3hM+LkQPNGkps9Dx
    lzclKlsoEOXrtDuYXadLOJ7s4bxgEQ/kjHuoczY+r0GVoxpC+CfnAvDN+mN1OdktJKnw2Q
    34sY4nMX+wEsJp3spBLZWD8+vRE7KmsDt4WlC60Fegv4EatJsAqZjbyK4C0pXY8MBiGI6c
    daJ1MZ6AM/AumiMt0WECMPvp6AH4kLhiswM/XbwhfDGyWmBZgtgbMoQpULov+XWDKJ2KwB
    SSI9Lg7zB3sFjpTqR1SZ8gDtI+QAV9KAGP7UPWdI3XAc3HkghHf4SUqfsLdg
X-ME-Proxy: <xmx:I5-aalMdu-OkdcEZ2YSpCzUHZcmiORFH-5vnehBJbtIJjlhkZ1VlQg>
    <xmx:I5-aag6MTv-irxh1r3nYo_o9XPld9BAbrh0xO7tn4ALEMpj49LVm5Q>
    <xmx:I5-aamMhxiTGX-cLlwKB3Q4uW__vnW9YxKm_rcEHXyVwtl8EE8bRnA>
    <xmx:I5-aaunbMyfh5DvXZ0HlAg0Fjh1ycOjg9iJNpGbe9oUclos82EaxEQ>
    <xmx:I5-aao2PyzX5w3Jb3T_buHJFyiAv7JcEkecRqwlK_bJ9vEq8PLdN74rj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 06:36:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 90fc2082 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Sep 2026 10:36:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 04 Sep 2026 12:36:03 +0200
Subject: [PATCH 02/11] builtin/clone: rename "--ref-format=" to
 "--ref-storage="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-b4-pks-unify-ref-storage-format-v1-2-08144e5004ff@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
In-Reply-To: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

With the same reasoning as for git-init(1), rename "--ref-format=" to
"--ref-storage=" and keep the old name as an alias.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-clone.adoc           |  2 +-
 builtin/clone.c                        | 14 ++++++++------
 t/t0610-reftable-basics.sh             |  4 ++--
 t/t1460-refs-migrate.sh                |  2 +-
 t/t5510-fetch.sh                       |  6 +++---
 t/t5601-clone.sh                       |  4 ++--
 t/t7424-submodule-mixed-ref-formats.sh |  4 ++--
 7 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
index b6e1f8ada2..57e2bda044 100644
--- a/Documentation/git-clone.adoc
+++ b/Documentation/git-clone.adoc
@@ -348,7 +348,7 @@ or `--mirror` is given)
 	The result is Git repository can be separated from working
 	tree.
 
-`--ref-format=<ref-format>`::
+`--ref-storage=<ref-format>`::
 
 Specify the given ref storage format for the repository. The valid values are:
 +
diff --git a/builtin/clone.c b/builtin/clone.c
index 5b25cca510..63bd7b795d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -901,7 +901,7 @@ int cmd_clone(int argc,
 	char *option_origin = NULL;
 	struct string_list option_not = STRING_LIST_INIT_NODUP;
 	const char *real_git_dir = NULL;
-	const char *ref_format = NULL;
+	const char *ref_storage = NULL;
 	const char *option_upload_pack = "git-upload-pack";
 	int option_progress = -1;
 	int option_sparse_checkout = 0;
@@ -981,8 +981,10 @@ int cmd_clone(int argc,
 			 N_("any cloned submodules will be shallow")),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
-		OPT_STRING(0, "ref-format", &ref_format, N_("format"),
-			   N_("specify the reference format to use")),
+		OPT_STRING(0, "ref-storage", &ref_storage, N_("format"),
+			   N_("specify the reference storage format to use")),
+		OPT_STRING_F(0, "ref-format", &ref_storage, N_("format"),
+			   N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
 		OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 				N_("set config inside the new repository")),
 		OPT_STRING_LIST(0, "server-option", &server_options,
@@ -1027,10 +1029,10 @@ int cmd_clone(int argc,
 	if (option_single_branch == -1)
 		option_single_branch = deepen ? 1 : 0;
 
-	if (ref_format) {
-		ref_storage_format = ref_storage_format_by_name(ref_format);
+	if (ref_storage) {
+		ref_storage_format = ref_storage_format_by_name(ref_storage);
 		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
-			die(_("unknown ref storage format '%s'"), ref_format);
+			die(_("unknown ref storage format '%s'"), ref_storage);
 	}
 
 	if (option_mirror) {
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 4a83e1ce56..d367b4b787 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -165,7 +165,7 @@ test_expect_success 'clone: can clone reffiles into reftable repository' '
 	test_when_finished "rm -rf reffiles reftable" &&
 	git init --ref-storage=files reffiles &&
 	test_commit -C reffiles A &&
-	git clone --ref-format=reftable ./reffiles reftable &&
+	git clone --ref-storage=reftable ./reffiles reftable &&
 
 	git -C reffiles rev-parse HEAD >expect &&
 	git -C reftable rev-parse HEAD >actual &&
@@ -184,7 +184,7 @@ test_expect_success 'clone: can clone reftable into reffiles repository' '
 	test_when_finished "rm -rf reffiles reftable" &&
 	git init --ref-storage=reftable reftable &&
 	test_commit -C reftable A &&
-	git clone --ref-format=files ./reftable reffiles &&
+	git clone --ref-storage=files ./reftable reffiles &&
 
 	git -C reftable rev-parse HEAD >expect &&
 	git -C reffiles rev-parse HEAD >actual &&
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index fc04bb7c70..44ad24f16e 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -143,7 +143,7 @@ do
 			test_when_finished "rm -rf repo repo.git" &&
 			git init --ref-storage=$from_format repo &&
 			test_commit -C repo initial &&
-			git clone --ref-format=$from_format --mirror repo repo.git &&
+			git clone --ref-storage=$from_format --mirror repo repo.git &&
 			test_migration repo.git "$to_format"
 		'
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 1b239f4f22..720157e6c5 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -46,19 +46,19 @@ test_expect_success "clone and setup child repos" '
 	) &&
 	git clone . bundle &&
 	git clone . seven &&
-	git clone --ref-format=reftable . case_sensitive &&
+	git clone --ref-storage=reftable . case_sensitive &&
 	(
 		cd case_sensitive &&
 		git branch branch1 &&
 		git branch bRanch1
 	) &&
-	git clone --ref-format=reftable . case_sensitive_fd &&
+	git clone --ref-storage=reftable . case_sensitive_fd &&
 	(
 		cd case_sensitive_fd &&
 		git branch foo/bar &&
 		git branch Foo
 	) &&
-	git clone --ref-format=reftable . case_sensitive_df &&
+	git clone --ref-storage=reftable . case_sensitive_df &&
 	(
 		cd case_sensitive_df &&
 		git branch Foo/bar &&
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index b6167582a1..88f359914f 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -166,7 +166,7 @@ test_expect_success 'clone --mirror does not repeat tags' '
 
 test_expect_success 'clone with files ref format' '
 	test_when_finished "rm -rf ref-storage" &&
-	git clone --ref-format=files --mirror src ref-storage &&
+	git clone --ref-storage=files --mirror src ref-storage &&
 	echo files >expect &&
 	git -C ref-storage rev-parse --show-ref-format >actual &&
 	test_cmp expect actual
@@ -176,7 +176,7 @@ test_expect_success 'clone with garbage ref format' '
 	cat >expect <<-EOF &&
 	fatal: unknown ref storage format ${SQ}garbage${SQ}
 	EOF
-	test_must_fail git clone --ref-format=garbage --mirror src ref-storage 2>err &&
+	test_must_fail git clone --ref-storage=garbage --mirror src ref-storage 2>err &&
 	test_cmp expect err &&
 	test_path_is_missing ref-storage
 '
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mixed-ref-formats.sh
index d6ea84bb90..1adac7baed 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -63,9 +63,9 @@ test_expect_success 'recursive clone propagates ref storage format' '
 	test_ref_format upstream/submodule "$GIT_DEFAULT_REF_FORMAT" &&
 
 	# The cloned repositories should use the other ref format that we have
-	# specified via `--ref-format`. The option should propagate to cloned
+	# specified via `--ref-storage`. The option should propagate to cloned
 	# submodules.
-	git clone --ref-format=$OTHER_FORMAT --recurse-submodules \
+	git clone --ref-storage=$OTHER_FORMAT --recurse-submodules \
 		upstream downstream &&
 	test_ref_format downstream "$OTHER_FORMAT" &&
 	test_ref_format downstream/submodule "$OTHER_FORMAT"

-- 
2.55.0.1007.g17ff1f9808.dirty

