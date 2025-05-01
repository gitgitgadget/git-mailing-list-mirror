Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83A2221F31
	for <git@vger.kernel.org>; Thu,  1 May 2025 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140409; cv=none; b=Pjr4CjTWLsBnIEBVTjAhfBZdVzRTl14f1UqtBBNjpv41/BgczgDSqcpGOl+H1hq/ARu0hM6YQd5MsPuba1GPbg/81C6EKEDEXoOIs6CjfwwDhx4hb5sg7jDrUPZUpfUXzwpGyyCwq8/lIzgxWAC98GBBvhXwgoWzXqlSurSgM3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140409; c=relaxed/simple;
	bh=9JBSMYGb5H3SsjUZrTRctBycUsA3fszUORZ0lEny0As=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgRcA+SeZVKXbY9xOR4j0G1WzCRUjCGHtEBb9p+YmxbqxKaCXXrY3rX4TC32Cd+/zkwJktIZBge0N092Joi8OxGCN8VIDwGfC29p8AEMQhV6XCmD35VEzMaMYE6j7iIyvXi1s7nLx9Jzj3FD3PZ91hzUVmy7el4TA/UTY7Q0eCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fxG5Wl4G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YA2VI7ST; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fxG5Wl4G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YA2VI7ST"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 83C661140259;
	Thu,  1 May 2025 19:00:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 01 May 2025 19:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746140405; x=
	1746226805; bh=cPDQN0o+kCkRJdgbBB0OzOrjKrfigChfJzoecgfda8U=; b=f
	xG5Wl4GXko2PNfFnp+rJ/++cPPanR2FyokaEet2YTfh3IrcsqvEmuFOTkBzhsL28
	IdJ7XpCvnKqvU0cw7hAkkptG2N0H6c1CLsUsydXLrcoMVYT7BXN2A0plu2YdxF1f
	sPjlQTmGsd4s8BT1vzp1lMfOByzCSxEaeB9ong3w3vFBwJQ3Bx+yHC9vReiLRIrE
	dSJaHCm760aAaYet7Msk/8CGOIXU3S7HNI9PUyXsQlLwfAvXt1eeHu7jPMefjwtb
	iR0KesU9gua7ISrJ9WateAT/qFuJTZp7chceezt3psZNc1UZAo+o4+lCSrA9kBSl
	yzJkUAizH9A47REDitl4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746140405; x=1746226805; bh=cPDQN0o+kCkRJdgbBB0OzOrjKrfi
	gChfJzoecgfda8U=; b=YA2VI7STz8x1UQfUbIY0cuSSCPUtXZ6i7oomxpIC8gsA
	bSI+1TVNMDEnlpBA5VIi2xu/nMJN29Y0ckqksJZ2YFABMxEN8K/ILDUMC+eWvvId
	vNg8Rxa1rL6VX1Am9uo/1yWuZjP4wC9II7WY4H/HaYr1Esnfv4Xy4BqLsgp/j9S+
	kl2RNB/b3F4BKAxQdoAOZpMDmHeSDqj9ocnTqhVCq0Y5Zpn+P5VJWgi/BalzkR3u
	QvIFyMpSw+UeRNoUS32HtbPDsaET7aCCNxzYavorHFNAsuSZ6b2pgXRnqMLGft+j
	9gMFZKGuRMMfs5QScZUt8Cnd9jikbAUIOfDEfdCv1A==
X-ME-Sender: <xms:9fwTaDkI2xBH4ohZoaWrHZoYxfiRZ8SSZTshMKOC6bM1cxGOTFPxeQ>
    <xme:9fwTaG3SJ0EnybDy-9vWOU77eH9Iw1dcXtQGYeKP9FXskVuW5_4HpEXOBYC8RyuwC
    7Sos_j0tcTSqX3WFA>
X-ME-Received: <xmr:9fwTaJre3v4p0EjtXcBhqkktwI8KkzgwKxPlkqgcwGtHx7duNvNx3oGGo5ho_Hc_qGtPNdlN7Zov7TNhKiOR1Jhbl-8JP5xLlQsz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9fwTaLmPvscFBK4NUJ-oXU6G0maZozvakDHYT_frKaQ9-_9RbKtoww>
    <xmx:9fwTaB0sE2qKPT5OrwZL2P00cgpOc2Tzo6-ieQ0qVd4BIAoI5SIUyQ>
    <xmx:9fwTaKtybrU-eZhQip6u71kYRO24lSFATv9-lzYIoKcwcraCgtHfyA>
    <xmx:9fwTaFUGTu22n9BONQ01yAp9fnyAxzXQ2SH4GCoogp4fleV6003BWg>
    <xmx:9fwTaPmyvb3cLJBZUVMRelCAe24ST9nt6yrGGQv3AXHp4OWSi0v5ZieI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 19:00:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 2/2] whatchanged: require --i-still-use-this
Date: Thu,  1 May 2025 15:59:58 -0700
Message-ID: <20250501225958.2947677-3-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-599-gc9a5c860a0
In-Reply-To: <20250501225958.2947677-1-gitster@pobox.com>
References: <20250501213452.370729-1-gitster@pobox.com>
 <20250501225958.2947677-1-gitster@pobox.com>
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
on the command line.

While at it, update the documentation page to use the new [synopsis]
facility to mark-up the SYNOPSIS part.

Two test scripts on fast-import run "git whatchanged" without even
checking the output from it.  It might still help manual debugging
so I've replaced these calls with "git log --raw", but we probably
are better off removing such useless git operations that do not
contribute to the tests.  Such a clean-up is left outside the scope
of this patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-whatchanged.adoc | 10 ++++++++--
 builtin/log.c                      | 13 +++++++++++++
 t/t4013-diff-various.sh            | 17 +++++++++++++++--
 t/t4202-log.sh                     | 14 +++++++++-----
 t/t9300-fast-import.sh             | 12 ++++++------
 t/t9301-fast-import-notes.sh       |  2 +-
 6 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-whatchanged.adoc b/Documentation/git-whatchanged.adoc
index 8e55e0bb1e..d21484026f 100644
--- a/Documentation/git-whatchanged.adoc
+++ b/Documentation/git-whatchanged.adoc
@@ -8,8 +8,14 @@ git-whatchanged - Show logs with differences each commit introduces
 
 SYNOPSIS
 --------
-[verse]
-'git whatchanged' <option>...
+[synopsis]
+git whatchanged <option>...
+
+WARNING
+-------
+`git whatchanged` has been deprecated and is scheduled for removal in
+a future version of Git, as it is merely `git log` with different
+default; `whatchanged` is not even shorter to type than `log --raw`.
 
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
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index b258dbf1df..4dc3d645bf 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -120,7 +120,7 @@ test_expect_success 'A: create pack from stdin' '
 
 	INPUT_END
 	git fast-import --export-marks=marks.out <input &&
-	git whatchanged main
+	git log --raw main
 '
 
 test_expect_success 'A: verify pack' '
@@ -279,7 +279,7 @@ test_expect_success 'A: verify marks import does not crash' '
 	INPUT_END
 
 	git fast-import --import-marks=marks.out <input &&
-	git whatchanged verify--import-marks
+	git log --raw verify--import-marks
 '
 
 test_expect_success 'A: verify pack' '
@@ -652,7 +652,7 @@ test_expect_success 'C: incremental import create pack from stdin' '
 	INPUT_END
 
 	git fast-import <input &&
-	git whatchanged branch
+	git log --raw branch
 '
 
 test_expect_success 'C: verify pack' '
@@ -715,7 +715,7 @@ test_expect_success 'D: inline data in commit' '
 	INPUT_END
 
 	git fast-import <input &&
-	git whatchanged branch
+	git log --raw branch
 '
 
 test_expect_success 'D: verify pack' '
@@ -882,7 +882,7 @@ test_expect_success 'H: deletall, add 1' '
 
 	INPUT_END
 	git fast-import <input &&
-	git whatchanged H
+	git log --raw H
 '
 
 test_expect_success 'H: verify pack' '
@@ -2066,7 +2066,7 @@ test_expect_success 'Q: commit notes' '
 	INPUT_END
 
 	git fast-import <input &&
-	git whatchanged notes-test
+	git log --raw notes-test
 '
 
 test_expect_success 'Q: verify pack' '
diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index 1ae4d7c0d3..e62173cf1f 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -76,7 +76,7 @@ INPUT_END
 test_expect_success 'set up main branch' '
 
 	git fast-import <input &&
-	git whatchanged main
+	git log --raw main
 '
 
 commit4=$(git rev-parse refs/heads/main)
-- 
2.49.0-599-gc9a5c860a0

