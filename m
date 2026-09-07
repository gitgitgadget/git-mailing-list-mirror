Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4A146DFF7
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780017; cv=none; b=sf9S12CaLuoSwEKvon/+mzI+JMU5bN21c4psRHky2QnXZWLbdtJb/uinInjXVuTKN1h+Uy1WmKr6hUjYT5DxWyDVVmpQkbG9Kb/B4K6vpHCi7gLgymcbOcXgDPeIeFNeNDWjq1ozXHja7ExTLtrlUpQayf0TTqYnJtDYnWBBNHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780017; c=relaxed/simple;
	bh=ThWMNiVDHC1l67T52har05+Mj0b54+3HXzVv4oRCG8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E/EC1hTr/mEQ4xvAvqQo0TLGZ5Fzu2rOOUeWBe0TPHCh4/gQJOrPTBn+LRrZVFxIxJ3IrYZ4w9LNw8X/Bu/imt0PH9/Usmumn6gv9z2qCQ2UOaDUg5J+PLzje0ZRpAZp8G80N9/e+FuPs2cUNzvTKCZievCx0DK8RzxE+9OfaPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RIfpVN/2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iAa8iIN5; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RIfpVN/2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iAa8iIN5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EF22414001CA;
	Mon,  7 Sep 2026 07:20:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 07 Sep 2026 07:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788780014;
	 x=1788866414; bh=fmiI2YrZyDzXJYfmivJeZD9I9URxyzyoNZzZTMHPB/s=; b=
	RIfpVN/2NIliwgyx1UXJIkuQZvryDV7QAuyb9ok8tthfwRmFMrnkwuXxoF+I3gFW
	hhxitvIDcgMo9iKcXdJmt5rw9s6pKob+T/NMIBcfBszCgRC7SE4wt7msJ6bN4/oY
	DDTNdxGcta/wVjDJcBTNrqUPHUUb/6aTcf4R82WG3Cug7xq4J0BNZ+XsZADJWx+J
	OQn7/J/LbgZkOEW7cmYZHwek5+DCZYduv1bqDsR8I0cACYZO2G9r5RNBMjP01LYA
	ipEYm+DJnZPo04kb0M+8urOk3P98nQGnoeKFOqXB+ynqbGRSRgU3GhyNSQLIyiua
	rkoU8HTNNRykWLgdcIbkDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788780014; x=
	1788866414; bh=fmiI2YrZyDzXJYfmivJeZD9I9URxyzyoNZzZTMHPB/s=; b=i
	Aa8iIN5un3HjS+dKxPZ2UeAKSAdzp1qdhTfic4Sx9Jg0ihxm1c2+7+SJpEQ2RKXN
	dZqlw7d0Hg4I6AgMTngVcO3KbeQo/Bepas9qg6/qWVP3O+X9VWWy9E1UYo5e5E1h
	3xOfoRb8u6TmxAzdc/i/rJnjujYe9xbhUDS/Nk8gpFkkxqx31hnQ0JQLrbsD4wdO
	2cI51JkOZUwEgLfFVix2xW7yYR87QVXBaYhWPqT6lzI50x+zhQ1kqYGBrxsEegXw
	ptqBD+ycO7PKyWDDbHqkMnx7Wi6iG8TCHls8XhCF+rkmGtcHEEFvFOH3NrvxjoBA
	fI1mZFiZII88kcUYSo2/Q==
X-ME-Sender: <xms:7p2easprEDbhteXLmwBpQLQM7tIgFf5D9izxkbD4AMU9AhFSOI4Nvg>
    <xme:7p2eaqFY3wFtmXkUb03ngChiVk7KXS1Ag0my-qtSgnsPThl_TPRNfZlkW5opxaXRA
    75FteeA3ipDnkOu2RXl_BoZpTqg1wQKqdHGo8uK2JdnUF0WCDfpbA>
X-ME-Received: <xmr:7p2eaulqo_wMgiA-xYmKTUbGGKveUVcm1XEv055mxlZ6knBNrzXokQ>
X-ME-Proxy-Cause: dmFkZTEODmYfhcE6MkClXmAzaz/u/B/AKDElneu4mL0qUxdd8dsBrCmOKXS1tHl60eVFV2
    SymYRFYzuiLUqyPPFAGooBAERtLvf0X1LhcjqzMnX7gdc7DtqXstRRoihdSALfCxoWFzJG
    BbbIbG0MP1m8AhEq/eZrNtPsqwDGfS6kNpj3lzhC6fPFYomNFvg9RKzjO2WnGUQd1KA2IH
    sWYk5pONmMX+mdXpmpfGC22NTMapciJwOTHnIl8o4jd+7ZhCw8vFlPa824pJltjvaD3N4A
    MUB/oyFdCvhdQMSVTPOi3Wa2Ehbr/+fSxb1kUGZO2C7ytEHmk7HxP5nm8sCCeE5hTY4Uqp
    TeCk6fVc9CzdQU9k1dc+3c4PcMmibKbEjuokuBkZ5VSB2uYbt7eTzULMU8HZ6IrXKp7wZt
    acbE3bX8LSmVx+Ox+6aKIp7k3hDJM+KWdtz37o/lP4kvwydrKPfB8sfwMqXAL1s4OwApVb
    bbxW7KtY6WNaTUktHqPh3AvjRT+U8YsqQwJ3ky7hZaiZP+avwH34fVAaDXZxh7JDhGmP42
    xcPjgpW6Zl56K4F9KluUjq75XjJqK9H6rUuA+Xo77W/zIR4SZqXz9Xkqv5DrMaQ2egsh6+
    N6kpxezL7jrZD7hbH6DP6y4WqbDJGlcQAGNwkrc89WzTh1yG2CfbRC3Xd/qw
X-ME-Proxy: <xmx:7p2eatleOOltIHkcKv1_923toBptkaHFuBk8HhWDLyluKbs3fetURA>
    <xmx:7p2eavvTpPpiwjwlK_xSHLEMwtLHbPZVcqDfVgAmQH7Wo_GLdG0glQ>
    <xmx:7p2eaglFl-5aohSp1unIBhim69LHQ4GPQTaxoVtF1dOzRcKdiTElTA>
    <xmx:7p2eaquEjV6IRQhBEqc0ruwmgEw78tNbvKeEgh9BKMEmVBDdGiD_sQ>
    <xmx:7p2eaiG2NMRq7ICpzCwyS-D55ghswGkGpkrpqC8RhbwK0jf3_4NBWEMS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 07:20:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 45bf03ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 11:20:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 13:18:36 +0200
Subject: [PATCH v2 02/11] builtin/clone: rename "--ref-format=" to
 "--ref-storage-format="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-b4-pks-unify-ref-storage-format-v2-2-6733c90ca5b0@pks.im>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
In-Reply-To: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

With the same reasoning as for git-init(1), rename "--ref-format=" to
"--ref-storage-format=" and keep the old name as an alias.

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
index b6e1f8ada2..f5d88d2aae 100644
--- a/Documentation/git-clone.adoc
+++ b/Documentation/git-clone.adoc
@@ -348,7 +348,7 @@ or `--mirror` is given)
 	The result is Git repository can be separated from working
 	tree.
 
-`--ref-format=<ref-format>`::
+`--ref-storage-format=<format>`::
 
 Specify the given ref storage format for the repository. The valid values are:
 +
diff --git a/builtin/clone.c b/builtin/clone.c
index 5b25cca510..511fff9562 100644
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
@@ -981,8 +981,10 @@ int cmd_clone(int argc,
 			 N_("any cloned submodules will be shallow")),
 		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 			   N_("separate git dir from working tree")),
-		OPT_STRING(0, "ref-format", &ref_format, N_("format"),
-			   N_("specify the reference format to use")),
+		OPT_STRING(0, "ref-storage-format", &ref_storage_format_str, N_("format"),
+			   N_("specify the reference storage format to use")),
+		OPT_STRING_F(0, "ref-format", &ref_storage_format_str, N_("format"),
+			   N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
 		OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 				N_("set config inside the new repository")),
 		OPT_STRING_LIST(0, "server-option", &server_options,
@@ -1027,10 +1029,10 @@ int cmd_clone(int argc,
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
index 1ca245c732..5eaf689d74 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -63,9 +63,9 @@ test_expect_success 'recursive clone propagates ref storage format' '
 	test_ref_format upstream/submodule "$GIT_DEFAULT_REF_FORMAT" &&
 
 	# The cloned repositories should use the other ref format that we have
-	# specified via `--ref-format`. The option should propagate to cloned
+	# specified via `--ref-storage`. The option should propagate to cloned
 	# submodules.
-	git clone --ref-format=$OTHER_FORMAT --recurse-submodules \
+	git clone --ref-storage-format=$OTHER_FORMAT --recurse-submodules \
 		upstream downstream &&
 	test_ref_format downstream "$OTHER_FORMAT" &&
 	test_ref_format downstream/submodule "$OTHER_FORMAT"

-- 
2.55.0.1007.g17ff1f9808.dirty

