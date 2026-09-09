Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECB1534452
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952389; cv=none; b=OryAT0F1ypZ6n9fDfGlL5G4QwOciuc7hp6p6tZBHEVH8J6dF6CWwraROtP5l1HCy2cp4Dus+uO6AnaAdVGNjqbD5b7g0PPDXOZwYB/vCzJsVWgLUHXA9RmopbJe1GTNYO2UCKa5Z/9r3peB/TCw0CKshT4NtdwqXV/32Xz8b+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952389; c=relaxed/simple;
	bh=ZOoJU3qRzxcOOb4tAMhPSrndTLJtm/c4Jvh4pf0BzDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CgacOc26w7WrR2s015ksSD2qvjVW6+sRnG9mBfKVAm2HPEq8+idevucTg3AyfXK5954xIFd0VwHmr8eWEuJcO9VDSG5zdrYm/qZkjmkwHfwC+uiWPpnvSd42GYjeowxILq/BxdsUk+IH02wz0fbJ/CZq0LT4ViTgbjjUM65CzWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OwjsBkcT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TNI/e2Km; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OwjsBkcT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TNI/e2Km"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 44A2DEC00A6;
	Wed,  9 Sep 2026 07:13:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 09 Sep 2026 07:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788952384;
	 x=1789038784; bh=ASolol6OcxdKY5w39Sx3mloLSHBcTxwoqQEAQN3AK7w=; b=
	OwjsBkcTYkifHpVFWsW8ryrRXxDrqwB6XhNLPsItAbP0ttmpPNlK0ZLeZodzKyf8
	JSsrdRqMslbYMP2Cl87AshvpQiDd+S2g3dMdQly9mt4N7E7ZHI82aLwE0URJ5h3+
	cvJ5Ol1Xduig4o2Jh/1oFjWZwU+JS126UwpVtSHp0ikePkaN+yK9D3dxX4yHm+Dc
	jgO3MHYMsx6YoRijowXRT+SYXGKDXHv5SRvtA2A7+H8VKW3NZml4KUlth8a7J9s7
	KREoulu/WAQxlGKB8GPx6JIBbdkzaaZ7ERsal6uq4HXFple5aeItoLoVspAw1zSM
	b/Qzj3tHRN5/egXrm2DfQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788952384; x=
	1789038784; bh=ASolol6OcxdKY5w39Sx3mloLSHBcTxwoqQEAQN3AK7w=; b=T
	NI/e2KmTImTBH/l7Q5+wB3KLSrxY1AveBusrWfqKuOy/gDmKJetvFvjXsa3hXrtm
	46x49oykWV0uESc0HBquSNAvx+dYZQyCNXA8nO/BlJbr/SEaG8s1YL7RC08dCoxb
	HpBEK7Vqb1wvWhhw2NuMoQ3bIOoaq55Fn8NiW9EMtOCy1iVOm+Jm3CGkZuefrCys
	DSx6XNamI7l0KPBcBskgn2yWPY5lw6YReuvDx2mlgDd5YQZhH7SThoO0Lh/sgBp+
	lrD/AvD5q2ous2w4g9PeNSHX9yLQSJu6BwDlioQDRQ3jrUB8nm9KQdw7Ep2qwSev
	22DQ1yloGlqdv+W77ZOPw==
X-ME-Sender: <xms:QD-hasD8DWF3SfHOeIK7JCSLBR1DlnrOCTbWMPuOg0gb7ZD_lz1JOA>
    <xme:QD-haljeN8gSJ-ms2gy5qsuY7-7UGP3bkDULEAf3tBVqX8-GOZhQ4N7N7wWAlgW9q
    00zsGPc48GB-6FahYLVxHvMGyW-ktSvuKPc3JXKvGQGj889y7zDTaM>
X-ME-Received: <xmr:QD-haknJlihTpu6W7MU8_ou5yApyCW3iP4byht7eoT-irLZ1RUsp-pvZOb58gpic9h2-_Q>
X-ME-Proxy-Cause: dmFkZTE3Kr1NBd8JgUfl84Cb5cL1nWUdKmaXEokJASImL17FtufGP+r88gnlXAgjOipOth
    P0q/MAO7driC9DWr9Pb2NSvnMboXAXQWKqp8q78rYacR0TIfgyDDisWpv4xgCjkfxpilFV
    de0BOcTzvSAwUjVggAVO3f0pp6fIXUozrRPx2JvGzCsepeV8jO3cLnixaA4fSCdk4cUvuV
    rWLiAxUXVbAEgGiBosN+gythNumpxzm2a6dIrhwBK6rKLm4zyqnAIVm4MkYADQfX4sBmuh
    t+6+cjeSCFtzPIC/cVXe+1M7eMImUQxfOX84m9qkFZENNlkxbbgX53FSMd/vtpKdV6ooa9
    eM4eO6yQNnlirMryPLBPjSHmeKmafn6rDHzphPB5Y9Np9vYraZZjAGPKvh/YDaWaYkxYjp
    2x4M09c4Lu9BO8i6m+BjEvuQC9OPlSRKnnOoIdmMbM3x2Uawy6FtVPhhLJpzJYYsUVVDL2
    nwycYdJZ8nM2aTAhCbkzcRnoNgt9tS16MO5e5FilndbygESZGFSYS4X2KNOF3M5/t8VEsM
    EDUAXfM3zV8l4eit2f1xol3wKWSJKILd7NKgAZzZoEYs2YEKRD+DS3kwlLRYHmtnRfm6mC
    vGYUU3CPBYsp+9bKcPNXZ8XKwvVjAP0mYFBHzl7YgxylsH5Ryl1spuET0ieQ
X-ME-Proxy: <xmx:QD-hahpYd3dNaQ7p13HPtDi3TUpjljRJ7_KXShk3ibt8TdRCh7DHhA>
    <xmx:QD-hatEUMYja4GYMbjUMxCuagJlFeByHkJwz4tNn3pQ-fcZkuQQS9Q>
    <xmx:QD-hatzw29Lt3ZM1a8YlNgFb4fpRNOLEsyUFjC16__bnlLrN2n5fWw>
    <xmx:QD-haipJxrx39wNTYpbygmGHx-7ehOQY9_7wg0G88Vai9BQitDggQQ>
    <xmx:QD-hasEELg-amCzFsX17pcdI4eqMFKanGT1Ww5RIAzqXW6sZpPDfCHEo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 07:13:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c5507c22 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 11:13:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Sep 2026 13:12:49 +0200
Subject: [PATCH v3 03/13] builtin/clone: rename "--ref-format=" to
 "--ref-storage-format="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-b4-pks-unify-ref-storage-format-v3-3-ca041fb40ad8@pks.im>
References: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
In-Reply-To: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

With the same reasoning as for git-init(1), rename "--ref-format=" to
"--ref-storage-format=" and keep the old name as an alias.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-clone.adoc           |  5 ++++-
 builtin/clone.c                        | 13 +++++++------
 t/t0610-reftable-basics.sh             |  4 ++--
 t/t1460-refs-migrate.sh                |  2 +-
 t/t5510-fetch.sh                       |  6 +++---
 t/t5601-clone.sh                       |  4 ++--
 t/t7424-submodule-mixed-ref-formats.sh |  4 ++--
 7 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
index b6e1f8ada2..27e4d13942 100644
--- a/Documentation/git-clone.adoc
+++ b/Documentation/git-clone.adoc
@@ -348,12 +348,15 @@ or `--mirror` is given)
 	The result is Git repository can be separated from working
 	tree.
 
-`--ref-format=<ref-format>`::
+`--ref-storage-format=<format>`::
 
 Specify the given ref storage format for the repository. The valid values are:
 +
 include::ref-storage-format.adoc[]
 
+`--ref-format=<format>`::
+Deprecated alias of `--ref-storage-format=<format>`.
+
 `-j<n>`::
 `--jobs=<n>`::
 	The number of submodules fetched at the same time.
diff --git a/builtin/clone.c b/builtin/clone.c
index 5b25cca510..42cae9e0f6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -901,7 +901,7 @@ int cmd_clone(int argc,
 	char *option_origin = NULL;
 	struct string_list option_not = STRING_LIST_INIT_NODUP;
 	const char *real_git_dir = NULL;
-	const char *ref_format = NULL;
+	const char *ref_storage_format_str = NULL;
 	const char *option_upload_pack = "git-upload-pack";
 	int option_progress = -1;
 	int option_sparse_checkout = 0;
@@ -981,8 +981,9 @@ int cmd_clone(int argc,
 			 N_("any cloned submodules will be shallow")),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
-		OPT_STRING(0, "ref-format", &ref_format, N_("format"),
-			   N_("specify the reference format to use")),
+		OPT_STRING(0, "ref-storage-format", &ref_storage_format_str, N_("format"),
+			   N_("specify the reference storage format to use")),
+		OPT_ALIAS_F(0, "ref-format", "ref-storage-format", PARSE_OPT_HIDDEN),
 		OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 				N_("set config inside the new repository")),
 		OPT_STRING_LIST(0, "server-option", &server_options,
@@ -1027,10 +1028,10 @@ int cmd_clone(int argc,
 	if (option_single_branch == -1)
 		option_single_branch = deepen ? 1 : 0;
 
-	if (ref_format) {
-		ref_storage_format = ref_storage_format_by_name(ref_format);
+	if (ref_storage_format_str) {
+		ref_storage_format = ref_storage_format_by_name(ref_storage_format_str);
 		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
-			die(_("unknown ref storage format '%s'"), ref_format);
+			die(_("unknown ref storage format '%s'"), ref_storage_format_str);
 	}
 
 	if (option_mirror) {
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 1cf96ce2c5..d325f17a14 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -165,7 +165,7 @@ test_expect_success 'clone: can clone reffiles into reftable repository' '
 	test_when_finished "rm -rf reffiles reftable" &&
 	git init --ref-storage-format=files reffiles &&
 	test_commit -C reffiles A &&
-	git clone --ref-format=reftable ./reffiles reftable &&
+	git clone --ref-storage-format=reftable ./reffiles reftable &&
 
 	git -C reffiles rev-parse HEAD >expect &&
 	git -C reftable rev-parse HEAD >actual &&
@@ -184,7 +184,7 @@ test_expect_success 'clone: can clone reftable into reffiles repository' '
 	test_when_finished "rm -rf reffiles reftable" &&
 	git init --ref-storage-format=reftable reftable &&
 	test_commit -C reftable A &&
-	git clone --ref-format=files ./reftable reffiles &&
+	git clone --ref-storage-format=files ./reftable reffiles &&
 
 	git -C reftable rev-parse HEAD >expect &&
 	git -C reffiles rev-parse HEAD >actual &&
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index bb2507f571..8aded6597e 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -143,7 +143,7 @@ do
 			test_when_finished "rm -rf repo repo.git" &&
 			git init --ref-storage-format=$from_format repo &&
 			test_commit -C repo initial &&
-			git clone --ref-format=$from_format --mirror repo repo.git &&
+			git clone --ref-storage-format=$from_format --mirror repo repo.git &&
 			test_migration repo.git "$to_format"
 		'
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 359c3cf99b..300bd5396d 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -46,19 +46,19 @@ test_expect_success "clone and setup child repos" '
 	) &&
 	git clone . bundle &&
 	git clone . seven &&
-	git clone --ref-format=reftable . case_sensitive &&
+	git clone --ref-storage-format=reftable . case_sensitive &&
 	(
 		cd case_sensitive &&
 		git branch branch1 &&
 		git branch bRanch1
 	) &&
-	git clone --ref-format=reftable . case_sensitive_fd &&
+	git clone --ref-storage-format=reftable . case_sensitive_fd &&
 	(
 		cd case_sensitive_fd &&
 		git branch foo/bar &&
 		git branch Foo
 	) &&
-	git clone --ref-format=reftable . case_sensitive_df &&
+	git clone --ref-storage-format=reftable . case_sensitive_df &&
 	(
 		cd case_sensitive_df &&
 		git branch Foo/bar &&
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index b6167582a1..202d86bc83 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -166,7 +166,7 @@ test_expect_success 'clone --mirror does not repeat tags' '
 
 test_expect_success 'clone with files ref format' '
 	test_when_finished "rm -rf ref-storage" &&
-	git clone --ref-format=files --mirror src ref-storage &&
+	git clone --ref-storage-format=files --mirror src ref-storage &&
 	echo files >expect &&
 	git -C ref-storage rev-parse --show-ref-format >actual &&
 	test_cmp expect actual
@@ -176,7 +176,7 @@ test_expect_success 'clone with garbage ref format' '
 	cat >expect <<-EOF &&
 	fatal: unknown ref storage format ${SQ}garbage${SQ}
 	EOF
-	test_must_fail git clone --ref-format=garbage --mirror src ref-storage 2>err &&
+	test_must_fail git clone --ref-storage-format=garbage --mirror src ref-storage 2>err &&
 	test_cmp expect err &&
 	test_path_is_missing ref-storage
 '
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mixed-ref-formats.sh
index 1ca245c732..5f31d233e9 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -63,9 +63,9 @@ test_expect_success 'recursive clone propagates ref storage format' '
 	test_ref_format upstream/submodule "$GIT_DEFAULT_REF_FORMAT" &&
 
 	# The cloned repositories should use the other ref format that we have
-	# specified via `--ref-format`. The option should propagate to cloned
+	# specified via `--ref-storage-format`. The option should propagate to cloned
 	# submodules.
-	git clone --ref-format=$OTHER_FORMAT --recurse-submodules \
+	git clone --ref-storage-format=$OTHER_FORMAT --recurse-submodules \
 		upstream downstream &&
 	test_ref_format downstream "$OTHER_FORMAT" &&
 	test_ref_format downstream/submodule "$OTHER_FORMAT"

-- 
2.55.0.1074.ge7621b4bad.dirty

