Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BED8481DD
	for <git@vger.kernel.org>; Sat,  3 May 2025 00:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746233906; cv=none; b=p07w9SmAwsffrIoqy9AVTET8sp1J1T40jD2JoC+HM0O6S0PXVAkeNBW81KuqYxqTV1TN76Lg8UgLtu6yunllt8jA8j7ZDcZ2zJqUgNOx2nc7Nro+RV78/kaSMX96dQDJf2/jGJWQnqvHf4zdmugoh4cJ7B+TvB9KayGGgYPb/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746233906; c=relaxed/simple;
	bh=DTZ8h2KepBEiTyKLK+8V5vuG8dHi21d8/N2/AjmNyUc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WG/A/r/6vGcDngY6nbgsd2h0+KYt34+pS70EW+vOK7s4k3nm8icE9RpWppM2JhTVp4+9KPgdJdU66wFDApumQ++HHsKoHbpTmtylZYyL6h+Gm0elqjMgmmChVPtI31Svrv7VpIzN7qERb0ABJnqyLbFjxhd+rPN1e3cX9oN1tRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iSED9FJ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iqrBXGcN; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iSED9FJ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iqrBXGcN"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3132B1140205;
	Fri,  2 May 2025 20:58:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 02 May 2025 20:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746233903; x=
	1746320303; bh=QgONr+NPBqw396Xq4jA2liJlrK2W6yPZ99UCOs7bbMs=; b=i
	SED9FJ7EHaC04PI5zb9c7nHmnX6sn9YstdcO9cIKHWguelYDo5uZIZ0aZl78WzUb
	nRXtTaa5w0G1Gqx7hgTzySO0Mg9beTMtoF8DKBAe0Y0c6GqEFF282MVMbE798jDX
	h+d8UEVHmMD9tzGV4SlptpCQkb6Bl8Thf67Ls8QQPLJ7K2XtoCvm57g9bOMOqdFr
	/ZB6/HOFCVQh5J8lbOEZraEkrKTGlC7V8cU+gBWfnQR0MTbWrtNIHbBo1QUPkCZM
	Pab6KCyMysDSjFJTgOj7syAoayDm7BNroGz5jg9E8cY3EdbFgL0mHbCWfkbZ87F/
	GbIJJ1F2IG+0UOtxqRQBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746233903; x=1746320303; bh=QgONr+NPBqw396Xq4jA2liJlrK2W
	6yPZ99UCOs7bbMs=; b=iqrBXGcNSM/3aY2tty/9KLJQkKefKmrEUa8MbwCwkpib
	8NkzHBqjpjjAddlAK3/ZeCZ/z9quLk3ZoRIdgEuY6M2H1Swj+dnK7R9lrfcgSlKS
	uzHRbtB26qRX19QDz46wX//bvbcmGodTbacdYsaYw+mj9boONZUSP+HorqLZ7SqG
	gYK4zoqdMVaDMQdSq4hDZaGCq7x3D6STGKP7B/65Zaiv84g35pfFsioAGmWYOjpP
	SuKniqmIu8ZhRmF2f+Z6EEpRsFezSi1tn0nDUbLyluSEUxYybQCQanZakQhjJ3S2
	e5I41hS/mJQs9Hl6obx65OBTgA1J7jzwZ1Gw8WdlCA==
X-ME-Sender: <xms:L2oVaMtWBnKoFZH4nqREyRS-2abCoxTrNyWanAWFb8GPfp124Jks2A>
    <xme:L2oVaJdyx5MPddTN39QSavZOAgArpbB52tBkb3IHh72Iu2KBEWyNLUCiVbtn2u0xl
    uM_6roqDX5Qq5ruwQ>
X-ME-Received: <xmr:L2oVaHzMc6kndZLuEfQheEr_XInEHKcogb5He65aU5gSg79-m7EYfG9VG4G0dGrXaV305nOxE21XJuP0fqE5DTxV380FJmWMVUrF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:L2oVaPPkOH_fPoAp8BlDI385F2pFvV_xsJjmKvY5GoZlYJrvW03cAA>
    <xmx:L2oVaM-RM089JiltAHxtNvrG9GwH8acQ8AlYyvln-33D7-lZEOODoQ>
    <xmx:L2oVaHWrr3vos7p5zwVb3rqR9B0KpNyAEUBl8Xu5yXn0ff85S2JFuA>
    <xmx:L2oVaFewUHYSxtVwxf6SyMQBYVS98ySrMVtX649OoiUZgKvmZUUdJA>
    <xmx:L2oVaIuy3QcPepfswBRyXrqG-1rtCanS8YJ_XZLrjbENsE0TVyBxzmfk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 20:58:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 4/6] whatchanged: require --i-still-use-this
Date: Fri,  2 May 2025 17:58:12 -0700
Message-ID: <20250503005814.3030099-5-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-601-ga5925c3955
In-Reply-To: <20250503005814.3030099-1-gitster@pobox.com>
References: <20250501225958.2947677-1-gitster@pobox.com>
 <20250503005814.3030099-1-gitster@pobox.com>
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

While at it, update the documentation page to use the new [synopsis]
facility to mark-up the SYNOPSIS part.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-whatchanged.adoc |  4 ++--
 builtin/log.c                      | 13 +++++++++++++
 t/t4013-diff-various.sh            | 17 +++++++++++++++--
 t/t4202-log.sh                     | 14 +++++++++-----
 4 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-whatchanged.adoc b/Documentation/git-whatchanged.adoc
index 8e55e0bb1e..d400b68d4b 100644
--- a/Documentation/git-whatchanged.adoc
+++ b/Documentation/git-whatchanged.adoc
@@ -8,8 +8,8 @@ git-whatchanged - Show logs with differences each commit introduces
 
 SYNOPSIS
 --------
-[verse]
-'git whatchanged' <option>...
+[synopsis]
+git whatchanged <option>...
 
 DESCRIPTION
 -----------
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
2.49.0-601-ga5925c3955

