Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2246129713E
	for <git@vger.kernel.org>; Mon, 12 May 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076603; cv=none; b=HascO71HMXHNsZqI58dVR5AEgQngR46klvERC0to327D0guC47I/7M5WHM7cS+R8gr1qDnz1kEELXA+VR9iPA3rk0Zwq5zN1uWzmyWsovyQkuZ+en/JetA83MXZ5QvVtCkOc0jy3H17QTzg3Oo7zK+C5tMUmc1uGBl5qJuRoikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076603; c=relaxed/simple;
	bh=5qhUBd7KZWtsOpPTc/LB0tOFulrRzPBTCQtgeqc6Xyg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfA6n+cJ616Vv8lgnUCtRg/urome9qxaXeXIxiUCY1WmVwi3DqAH+8APkXSyEhOdO6WHApMFoS+LTbvt9B5dtnyukuMHonGdvZe8nPbLL7rvukXm5n+1f4hM3Sa4+A747K8G0msiJNcr3rUybxJF2//ZwqIbrewWweVu6Aiea/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CD4qzOtK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HpcWEIga; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CD4qzOtK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HpcWEIga"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 38DAF1140130;
	Mon, 12 May 2025 15:03:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 12 May 2025 15:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1747076600; x=
	1747163000; bh=IdMO0AxIfWsQR50MTDBxWP58VRrfNQif0gfnEvwvBFE=; b=C
	D4qzOtKxYpwu2s3p2ENzPgfYG4WXSUVNggkZVC6lbVPUOnH4HoEpvpjwTxRemGun
	ZGulxQyLztMHN59H+qnZyLjZyvptTwKu/ApspKI4DDNsPHFTDcGzsY87bYEi4B2/
	zM92Yhvizo2ZdBjGk6vdIsvLYZwWbDj08KtUFTR1SZHZMVHQ/MgYv31hiMQvkOGb
	EyD/0ia2W+CjLzSUNFuB4d3wNLdIWOW24QxlpK6BkfHVMwl7CeesnJy3kA3XP2nA
	vEtsTdiQNhRniLc/SU2HpV2V8d5MO+WwQnRQdbZMFXN06ir8felR24KHWVCpP0HA
	FuE8naV8wXKBKnx9yt/Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1747076600; x=1747163000; bh=IdMO0AxIfWsQR50MTDBxWP58VRrf
	NQif0gfnEvwvBFE=; b=HpcWEIgaUFQIdVMPM14swqRGrss/Cdv0Fbtl6/BXuB3D
	F1peKfKHovJOtMFSDoYfxIyDOPnS7Jig04gUx4ceG+/YTauhzigSsSSO+LljTMn2
	wysXnadQt7DetQfFGI3I6ExniCeO0fMeoL7LgD09KNP21A9Ro71YXM8guFPvo8uH
	/eZmA2C2OIiTmReP41EkoIOSm3Ja9cVMsEI0iqau+CkREjL/kPcfIQ2qXY+BNhOH
	a+KCf7DcabnuJBwxhu4RjI43u/fow9BOC3R0tNE1f392l6/d6tFeuLblx9wzQlTI
	AND0G40vYWK8P6Q+M8r9Dg1WR1WP3APDHF2lji8MuQ==
X-ME-Sender: <xms:-EUiaENWFew_DtWtTUqmmKymXdNKfvKMzYozGfizk7NQH1igIwrfpg>
    <xme:-EUiaK8IUJjNpebFmPI7Zqd1mhfZDvrMRDotZXYSyVrxg8DZQoc5J7cbMhuY5m9nQ
    8VyRbe8sudKXVL9Dg>
X-ME-Received: <xmr:-EUiaLRElXzV4_BTfSehk77W94FqqjqsIU6wXq7w5VlWlbEdKtRNJzlNpgd5-Ocz82uxJ3yr2v_qcP9lv8Xmy-txssO3agcNMaKY0OU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddvtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-EUiaMtkG9qocZ0H6NOat9KxuuZL1BaEuh3zJoZSWdFhRdq3Uh6i7g>
    <xmx:-EUiaMcQoKs1Pv4mdCYoBXCMA0yTLkANe1MkwV2UbemV3v_4sOkJsw>
    <xmx:-EUiaA2LlGwudytjrj3Qiw7o3ZV-wRlqOOk2ktPd3LTbgBz1mH3eGw>
    <xmx:-EUiaA90xpj86n5sWjOr2SIGyanOm6k1uk7ty-jSoZorevuheM2U1A>
    <xmx:-EUiaAPOeedVQBw7H9_dJpZqpy5wOp17Rdl8WdzhWE_Uu5ApBIaVAsiQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 15:03:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 4/6] whatchanged: require --i-still-use-this
Date: Mon, 12 May 2025 12:03:09 -0700
Message-ID: <20250512190311.1451556-5-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-674-gc1e4f99c0b
In-Reply-To: <20250512190311.1451556-1-gitster@pobox.com>
References: <20250503005814.3030099-1-gitster@pobox.com>
 <20250512190311.1451556-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation of "git whatchanged" is pretty explicit that this
has retained for historical reasons to help those whose fingers
cannot be retrained.  Let's see if they still are finding it hard to
type "git log --raw" instead of "git whatchanged" by marking the
command as "nominated for removal", and require "--i-still-use-this"
on the command line.  Adjust the tests so that the option is passed
when we invoke the command.  In addition, we test that the command
fails when "--i-still-use-this" is not given.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c           | 13 +++++++++++++
 t/t4013-diff-various.sh | 17 +++++++++++++++--
 t/t4202-log.sh          | 14 +++++++++-----
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 04a6ef97bc..0f98ac8a34 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -113,6 +113,13 @@ struct log_config {
 	int fmt_patch_name_max;
 	char *fmt_pretty;
 	char *default_date_mode;
+
+	/*
+	 * Note: git_log_config() does not touch this member and that
+	 * is very deliberate.  This member is only to be used to
+	 * resurrect whatchanged that is deprecated.
+	 */
+	int i_still_use_this;
 };
 
 static void log_config_init(struct log_config *cfg)
@@ -267,6 +274,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		OPT__QUIET(&quiet, N_("suppress diff output")),
 		OPT_BOOL(0, "source", &source, N_("show source")),
 		OPT_BOOL(0, "use-mailmap", &mailmap, N_("use mail map file")),
+		OPT_HIDDEN_BOOL(0, "i-still-use-this", &cfg->i_still_use_this,
+				"<use this deprecated command>"),
 		OPT_ALIAS(0, "mailmap", "use-mailmap"),
 		OPT_CALLBACK_F(0, "clear-decorations", NULL, NULL,
 			       N_("clear all previously-defined decoration filters"),
@@ -656,6 +665,10 @@ int cmd_whatchanged(int argc,
 	opt.def = "HEAD";
 	opt.revarg_opt = REVARG_COMMITTISH;
 	cmd_log_init(argc, argv, prefix, &rev, &opt, &cfg);
+
+	if (!cfg.i_still_use_this)
+		you_still_use_that("git whatchanged");
+
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 3855d68dbc..8caab2ee38 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -203,11 +203,19 @@ do
 	test_expect_success "git $cmd # magic is ${magic:-(not used)}" '
 		{
 			echo "$ git $cmd"
+
+			case "$cmd" in
+			whatchanged | whatchanged" "*)
+				run="whatchanged --i-still-use-this"
+				run="$run ${cmd#whatchanged}" ;;
+			*)
+				run=$cmd ;;
+			esac &&
 			case "$magic" in
 			"")
-				GIT_PRINT_SHA1_ELLIPSIS=yes git $cmd ;;
+				GIT_PRINT_SHA1_ELLIPSIS=yes git $run ;;
 			noellipses)
-				git $cmd ;;
+				git $run ;;
 			esac |
 			sed -e "s/^\\(-*\\)$V\\(-*\\)\$/\\1g-i-t--v-e-r-s-i-o-n\2/" \
 			    -e "s/^\\(.*mixed; boundary=\"-*\\)$V\\(-*\\)\"\$/\\1g-i-t--v-e-r-s-i-o-n\2\"/"
@@ -454,6 +462,11 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
+test_expect_success 'whatchanged needs --i-still-use-this' '
+	test_must_fail git whatchanged >message 2>&1 &&
+	test_grep "nominated for removal" message
+'
+
 test_expect_success 'log -m matches pure log' '
 	git log master >result &&
 	process_diffs result >expected &&
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 51f7beb59f..ce4c7ab2af 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -490,6 +490,7 @@ for cmd in show whatchanged reflog format-patch
 do
 	case "$cmd" in
 	format-patch) myarg="HEAD~.." ;;
+	whatchanged) myarg=--i-still-use-this ;;
 	*) myarg= ;;
 	esac
 
@@ -1202,19 +1203,22 @@ test_expect_success 'reflog is expected format' '
 '
 
 test_expect_success 'whatchanged is expected format' '
+	whatchanged="whatchanged --i-still-use-this" &&
 	git log --no-merges --raw >expect &&
-	git whatchanged >actual &&
+	git $whatchanged >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'log.abbrevCommit configuration' '
+	whatchanged="whatchanged --i-still-use-this" &&
+
 	git log --abbrev-commit >expect.log.abbrev &&
 	git log --no-abbrev-commit >expect.log.full &&
 	git log --pretty=raw >expect.log.raw &&
 	git reflog --abbrev-commit >expect.reflog.abbrev &&
 	git reflog --no-abbrev-commit >expect.reflog.full &&
-	git whatchanged --abbrev-commit >expect.whatchanged.abbrev &&
-	git whatchanged --no-abbrev-commit >expect.whatchanged.full &&
+	git $whatchanged --abbrev-commit >expect.whatchanged.abbrev &&
+	git $whatchanged --no-abbrev-commit >expect.whatchanged.full &&
 
 	test_config log.abbrevCommit true &&
 
@@ -1231,9 +1235,9 @@ test_expect_success 'log.abbrevCommit configuration' '
 	git reflog --no-abbrev-commit >actual &&
 	test_cmp expect.reflog.full actual &&
 
-	git whatchanged >actual &&
+	git $whatchanged >actual &&
 	test_cmp expect.whatchanged.abbrev actual &&
-	git whatchanged --no-abbrev-commit >actual &&
+	git $whatchanged --no-abbrev-commit >actual &&
 	test_cmp expect.whatchanged.full actual
 '
 
-- 
2.49.0-674-gc1e4f99c0b

