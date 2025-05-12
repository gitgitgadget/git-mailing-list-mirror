Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE9297A66
	for <git@vger.kernel.org>; Mon, 12 May 2025 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076604; cv=none; b=Y/VUdMwITkQZ/b3DcHSMLVi8ExCLWkHc0igdLsvrCnFJB8kBz8CteWXc8edUKWlrtPCJzckkjbEGO8s+nvFKK8sXdGA5BgumrrBqoMpVsmDtyjUmLbq6UdcAx4MHomp7P69k50vmuc6h02DMSrb5KT2QmnNkmCHAhpIWRtRf2co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076604; c=relaxed/simple;
	bh=xOWBD8SuIl0TZq00NFNeY6fFUUkbcqfJHzlLQ0x4BEA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtNUcG/LsJalfBXSOAm71VpFNXCL4pF1PFnwA7JcYC2bihZlu6FdRQG3pyGoTO6yn5A2R8NjpO28K3QGdMnGnW6Zm3E7KarpbkWITKmhQ7KeNbpd2Jmw9TZPmRS1q47OXNcfR/YjwUMl2rmCgCgMYd6FDr+En+JejWQmm7Zg6X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KtEbHQxX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=srwnNrWa; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KtEbHQxX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="srwnNrWa"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB8CA1140135;
	Mon, 12 May 2025 15:03:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 12 May 2025 15:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1747076601; x=
	1747163001; bh=Lpu2gOJUv/YFn96QepY80HbdUAa2l0Gumk8+cV0D4w0=; b=K
	tEbHQxX8f88zqudlimhGsSTg4zS66NnHnCW8a9Ho/zLssYhZlmXgFfO26OreeMXe
	N43BpHL1spyUK7+/mGXBXRtV5LoUbV2s8XHv/xpR67Z9ehoACvxEZBB/QWqjUdEv
	ayVLwr90N20JhioeSAbwqClp4uHgXxa9OQV1fbCIaDBLW6eYgE/3NtluSdUWoeUP
	AKv8eAmATaji5zLrrkRBEDj1LEISdwjlKp2MbpVnRfzFDSLZioQunaVHh3yfNKcS
	nE+j4g6M7vjC8007zhwt2Dt3nB05dKG3T/lXh0FNpQ1V5xPczfzIVSCrQQlMAUcE
	zadqyNbRhepGeUnoAndYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1747076601; x=1747163001; bh=Lpu2gOJUv/YFn96QepY80HbdUAa2
	l0Gumk8+cV0D4w0=; b=srwnNrWaPUeBYei2VOty1T+IVv3LZNxhmNONav4mcM5C
	X5p8hUCtHmq/jsvqPuBTvYD2q3PDEbga+2LwYdj9+DYp6Sr6ykUqfwy73GzirxW/
	ROjtbQNTZ5MrN8e7gsiMMFFxPMxyqiiSHy2+/EmlY/goSJ7Zy6ALTxps7LsNS4a4
	PuwHEB6QzzXv2om2Jx+6IJ1LMiXUTRoQ1ftT8pFkDtZj9qt/0riF4DdNtxQ2t4a+
	2fVYAnEIDdqSX35PxO0siAEnkBDZFGVncaRwjb9udNALCz6Ehonrc8BtJt/0q03p
	8en6xlwJZhU0Hw4LJPhTF42higX4I+14+uRTKrsrhw==
X-ME-Sender: <xms:-UUiaKNWSTMiRsec6wdJQLN1cVXC-bcFLXQ5rU53aURx0bBCoZbu_w>
    <xme:-UUiaI9xSjrnGN2lAohXJ-bu1MtrUjQY4KvMd8976SML7cB4K7EdFUQapuzQGwAV2
    C9E28NxHLt4WpcOCQ>
X-ME-Received: <xmr:-UUiaBQs7VwL-xijh88qMEiAnz4gkISzdDHFD7w1aWb30fW6IOjEihuqR5GdFJMcxZfzHWTJgYzipmps54A5Hj3WnPPSb8UkFn27puE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-UUiaKso6eWgxCwOLOGJgykyVmTShjb7PLG8298nKV45eMUjug5muw>
    <xmx:-UUiaCe3t2L8Bk3jEW9Ggq7_ACzAYnVXqJFgfmrP4WE55din5PRvAg>
    <xmx:-UUiaO2hoEGuZjm44k5Gdq5duZv-grRBP8vFGcbPRYEMlOS8O3JRvg>
    <xmx:-UUiaG9x-YER9mr1C1CJEIwfehQRDjzU-QW4iosR4qbMoPltHHiZHg>
    <xmx:-UUiaGN-lfEy_iu3r7M7BX0edon2sSQBzPPtn2U1GCqgD8HEoXfNDFfh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 15:03:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 5/6] whatchanged: remove when built with WITH_BREAKING_CHANGES
Date: Mon, 12 May 2025 12:03:10 -0700
Message-ID: <20250512190311.1451556-6-gitster@pobox.com>
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

As we made "git whatchanged" require "--i-still-use-this" and asked
the users to report if they still want to use it, the logical next
step is to allow us build Git without "whatchanged" to prepare for
its eventual removal.

If we were to follow the pattern established in 8ccc75c2 (remote:
announce removal of "branches/" and "remotes/", 2025-01-22), we can
do this together with the documentation update to officially list
that the command will be removed in the BreakingChanges document,
but let's just keep the changes separate just in case we want to
proceed a bit slower.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/format.adoc             |  6 +++++
 Documentation/config/log.adoc                | 11 ++++++--
 Documentation/pretty-options.adoc            |  5 ++++
 Documentation/rev-list-options.adoc          |  9 +++++--
 Documentation/technical/sparse-checkout.adoc |  2 +-
 builtin/log.c                                |  6 +++++
 git.c                                        |  2 ++
 t/t4013-diff-various.sh                      | 12 +++++++--
 t/t4202-log.sh                               | 28 ++++++++++++++------
 9 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/format.adoc b/Documentation/config/format.adoc
index 7410e930e5..ab0710e86a 100644
--- a/Documentation/config/format.adoc
+++ b/Documentation/config/format.adoc
@@ -68,9 +68,15 @@ format.encodeEmailHeaders::
 	Defaults to true.
 
 format.pretty::
+ifndef::with-breaking-changes[]
 	The default pretty format for log/show/whatchanged command.
 	See linkgit:git-log[1], linkgit:git-show[1],
 	linkgit:git-whatchanged[1].
+endif::with-breaking-changes[]
+ifdef::with-breaking-changes[]
+	The default pretty format for log/show command.
+	See linkgit:git-log[1], linkgit:git-show[1].
+endif::with-breaking-changes[]
 
 format.thread::
 	The default threading style for 'git format-patch'.  Can be
diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
index 9003a82191..a9b160e7de 100644
--- a/Documentation/config/log.adoc
+++ b/Documentation/config/log.adoc
@@ -1,6 +1,13 @@
 log.abbrevCommit::
-	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
-	linkgit:git-whatchanged[1] assume `--abbrev-commit`. You may
+	If true, makes
+ifndef::with-breaking-changes[]
+	linkgit:git-log[1], linkgit:git-show[1], and
+	linkgit:git-whatchanged[1]
+endif::with-breaking-changes[]
+ifdef::with-breaking-changes[]
+	linkgit:git-log[1] and linkgit:git-show[1]
+endif::with-breaking-changes[]
+	assume `--abbrev-commit`. You may
 	override this option with `--no-abbrev-commit`.
 
 log.date::
diff --git a/Documentation/pretty-options.adoc b/Documentation/pretty-options.adoc
index 23888cd612..b36e96abe2 100644
--- a/Documentation/pretty-options.adoc
+++ b/Documentation/pretty-options.adoc
@@ -62,7 +62,12 @@ ifndef::git-rev-list[]
 --notes[=<ref>]::
 	Show the notes (see linkgit:git-notes[1]) that annotate the
 	commit, when showing the commit log message.  This is the default
+ifndef::with-breaking-changes[]
 	for `git log`, `git show` and `git whatchanged` commands when
+endif::with-breaking-changes[]
+ifdef::with-breaking-changes[]
+	for `git log` and `git show` commands when
+endif::with-breaking-changes[]
 	there is no `--pretty`, `--format`, or `--oneline` option given
 	on the command line.
 +
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 785c0786e0..ee5c5c9489 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1074,8 +1074,13 @@ Commit Formatting
 
 ifdef::git-rev-list[]
 Using these options, linkgit:git-rev-list[1] will act similar to the
-more specialized family of commit log tools: linkgit:git-log[1],
-linkgit:git-show[1], and linkgit:git-whatchanged[1]
+more specialized family of commit log tools:
+ifndef::with-breaking-changes[]
+linkgit:git-log[1], linkgit:git-show[1], and linkgit:git-whatchanged[1].
+endif::with-breaking-changes[]
+ifdef::with-breaking-changes[]
+linkgit:git-log[1] and linkgit:git-show[1].
+endif::with-breaking-changes[]
 endif::git-rev-list[]
 
 include::pretty-options.adoc[]
diff --git a/Documentation/technical/sparse-checkout.adoc b/Documentation/technical/sparse-checkout.adoc
index d968659354..67134bb768 100644
--- a/Documentation/technical/sparse-checkout.adoc
+++ b/Documentation/technical/sparse-checkout.adoc
@@ -442,7 +442,7 @@ understanding these differences can be beneficial.
       * blame (only matters when one or more -C flags are passed)
 	* and annotate
       * log
-      * whatchanged
+      * whatchanged (may not exist anymore)
       * ls-files
       * diff-index
       * diff-tree
diff --git a/builtin/log.c b/builtin/log.c
index 0f98ac8a34..1d0ae645ab 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -114,12 +114,14 @@ struct log_config {
 	char *fmt_pretty;
 	char *default_date_mode;
 
+#ifndef WITH_BREAKING_CHANGES
 	/*
 	 * Note: git_log_config() does not touch this member and that
 	 * is very deliberate.  This member is only to be used to
 	 * resurrect whatchanged that is deprecated.
 	 */
 	int i_still_use_this;
+#endif
 };
 
 static void log_config_init(struct log_config *cfg)
@@ -274,8 +276,10 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		OPT__QUIET(&quiet, N_("suppress diff output")),
 		OPT_BOOL(0, "source", &source, N_("show source")),
 		OPT_BOOL(0, "use-mailmap", &mailmap, N_("use mail map file")),
+#ifndef WITH_BREAKING_CHANGES
 		OPT_HIDDEN_BOOL(0, "i-still-use-this", &cfg->i_still_use_this,
 				"<use this deprecated command>"),
+#endif
 		OPT_ALIAS(0, "mailmap", "use-mailmap"),
 		OPT_CALLBACK_F(0, "clear-decorations", NULL, NULL,
 			       N_("clear all previously-defined decoration filters"),
@@ -642,6 +646,7 @@ static int git_log_config(const char *var, const char *value,
 	return git_diff_ui_config(var, value, ctx, cb);
 }
 
+#ifndef WITH_BREAKING_CHANGES
 int cmd_whatchanged(int argc,
 		    const char **argv,
 		    const char *prefix,
@@ -678,6 +683,7 @@ int cmd_whatchanged(int argc,
 	log_config_release(&cfg);
 	return ret;
 }
+#endif
 
 static void show_tagger(const char *buf, struct rev_info *rev)
 {
diff --git a/git.c b/git.c
index 450d6aaa86..b84db92cb5 100644
--- a/git.c
+++ b/git.c
@@ -645,7 +645,9 @@ static struct cmd_struct commands[] = {
 	{ "verify-pack", cmd_verify_pack },
 	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 	{ "version", cmd_version },
+#ifndef WITH_BREAKING_CHANGES
 	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
+#endif
 	{ "worktree", cmd_worktree, RUN_SETUP },
 	{ "write-tree", cmd_write_tree, RUN_SETUP },
 };
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 8caab2ee38..8e38df1685 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -200,7 +200,15 @@ do
 	expect="$TEST_DIRECTORY/t4013/diff.$test"
 	actual="$pfx-diff.$test"
 
-	test_expect_success "git $cmd # magic is ${magic:-(not used)}" '
+	case "$cmd" in
+	whatchanged | whatchanged" "*)
+		prereq=WITHOUT_BREAKING_CHANGES
+		;;
+	*)
+		prereq=;;
+	esac
+
+	test_expect_success $prereq "git $cmd # magic is ${magic:-(not used)}" '
 		{
 			echo "$ git $cmd"
 
@@ -462,7 +470,7 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
-test_expect_success 'whatchanged needs --i-still-use-this' '
+test_expect_success WITHOUT_BREAKING_CHANGES 'whatchanged needs --i-still-use-this' '
 	test_must_fail git whatchanged >message 2>&1 &&
 	test_grep "nominated for removal" message
 '
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index ce4c7ab2af..ad05f6772f 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -486,7 +486,12 @@ test_expect_success !FAIL_PREREQS 'log with various grep.patternType configurati
 	)
 '
 
-for cmd in show whatchanged reflog format-patch
+cmds="show reflog format-patch"
+if test_have_prereq WITHOUT_BREAKING_CHANGES
+then
+	cmds="$cmds whatchanged"
+fi
+for cmd in $cmds
 do
 	case "$cmd" in
 	format-patch) myarg="HEAD~.." ;;
@@ -1202,7 +1207,7 @@ test_expect_success 'reflog is expected format' '
 	test_cmp expect actual
 '
 
-test_expect_success 'whatchanged is expected format' '
+test_expect_success WITHOUT_BREAKING_CHANGES 'whatchanged is expected format' '
 	whatchanged="whatchanged --i-still-use-this" &&
 	git log --no-merges --raw >expect &&
 	git $whatchanged >actual &&
@@ -1217,8 +1222,12 @@ test_expect_success 'log.abbrevCommit configuration' '
 	git log --pretty=raw >expect.log.raw &&
 	git reflog --abbrev-commit >expect.reflog.abbrev &&
 	git reflog --no-abbrev-commit >expect.reflog.full &&
-	git $whatchanged --abbrev-commit >expect.whatchanged.abbrev &&
-	git $whatchanged --no-abbrev-commit >expect.whatchanged.full &&
+
+	if test_have_prereq WITHOUT_BREAKING_CHANGES
+	then
+		git $whatchanged --abbrev-commit >expect.whatchanged.abbrev &&
+		git $whatchanged --no-abbrev-commit >expect.whatchanged.full
+	fi &&
 
 	test_config log.abbrevCommit true &&
 
@@ -1235,10 +1244,13 @@ test_expect_success 'log.abbrevCommit configuration' '
 	git reflog --no-abbrev-commit >actual &&
 	test_cmp expect.reflog.full actual &&
 
-	git $whatchanged >actual &&
-	test_cmp expect.whatchanged.abbrev actual &&
-	git $whatchanged --no-abbrev-commit >actual &&
-	test_cmp expect.whatchanged.full actual
+	if test_have_prereq WITHOUT_BREAKING_CHANGES
+	then
+		git $whatchanged >actual &&
+		test_cmp expect.whatchanged.abbrev actual &&
+		git $whatchanged --no-abbrev-commit >actual &&
+		test_cmp expect.whatchanged.full actual
+	fi
 '
 
 test_expect_success '--abbrev-commit with core.abbrev=false' '
-- 
2.49.0-674-gc1e4f99c0b

