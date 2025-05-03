Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78852629D
	for <git@vger.kernel.org>; Sat,  3 May 2025 00:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746233907; cv=none; b=Fcc+S7fNbOrAP4arHt54u1hLYY4SItJc6Y3LgT1vTu40Fx2F+AKHxPMNj5+1Mfb9tkWCFkMiSQxwe3RH9B9mbWi2JH4GyKym3rGXO1vNMYuXHIQifd/4A2A1rNnje8mjVR6HzUigsrYeqtNGe6dijfmAeIK8iD1rExZoiUr6eQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746233907; c=relaxed/simple;
	bh=JgSpET6Jc5AetX+x6n2dWtTxXEUzWSUj7k4T9/9o0TE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3je07hqWF2wM+W55eqoXX6pxchu8ZuD8TVaU6gnOcAVFFv0y6WqlMtSYGvvK6S8B2V0J8GVWrIXg8IHar9cSvaUcjsGTmrWx0Tx64QLO8TCKOB6wHb5v6mJAGaSfELzLzn4UobM5WGwb6Ouu7ijCIRp2AFB9rlhuDa8B5PQUas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z8SarRKw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AaBN5pkL; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z8SarRKw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AaBN5pkL"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C753211401E7;
	Fri,  2 May 2025 20:58:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 02 May 2025 20:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746233904; x=
	1746320304; bh=OqywBLXMEK7I/xiFUj51Krqqbpf0OOIpdPcLjsaKK50=; b=Z
	8SarRKwMpHCQ4W7AoI9twNgd1+l61Z8tsKEW6QhoHwF3AmCRNfi72/ZFke7zc5fK
	toe5Vqd7zw9mP/4HHoMsiLiJmwNXL1iNV4r2IXAwFg6zvpvVG7HA76ggUJZ/EtGv
	3EEUm04oWADjJfaCGoMdAWbQNCgPGPwp2Z2LXh+hDxOojhxHEfLriS/dlnO6wYky
	IsdJ52Epv6vxgiMQBI3TiLKRkCW0riTrbjCUxa3bVYfUbykhBIXr6jxuv5GY6+/a
	4P3EI9lz9SId6pnyvMIWHt6l7xXbiiKiWPggAWGEThFgLJR9SzPlUWbFFnef5rOQ
	uYRPNTfzX43xzr2m39Rjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746233904; x=1746320304; bh=OqywBLXMEK7I/xiFUj51Krqqbpf0
	OOIpdPcLjsaKK50=; b=AaBN5pkLr/8DkeYeex9d57OGAa/zFmdbGyk19PdOgIHD
	nJhzwK+BjkWF1nvoOzP7+WKz/ycl/0VxTRwCUyfJa/coSco465AC5x92se8m5N/M
	CC3YzI/LPPwZUXtQtlWqqcv0ymm7WpXFhVGJmu+J1qWA5DpeTClOTN+YEfwxMcz3
	aIpEeWvaAk6mRAf+jaSPx+zrX0Umw05Icswg8FZpwZgdTRSsCGo4RhSU9ww6nBsI
	9t5PLK5zyLQc/XpEWrFzddbBFvDdWaCCcci2PXdCJ7JabVQ4o8aNZ1LFQkyWguPP
	JaexUFv9cSdPvmBdjLEovQQeRWEY7IcK8xdTY+4kXg==
X-ME-Sender: <xms:MGoVaPU99zS4pEaF7krvYizK7leKCq7906vb_Hpqb4gleIsqpbiLoA>
    <xme:MGoVaHmbwYq_ezPbDTbifswdD5lFxB43doTK1dB290n5OvuUV0aSdogpfJA0BIMmy
    2E3PBi8TTl6tj_XdQ>
X-ME-Received: <xmr:MGoVaLZACj9WSvo7sll4yCi1RxXDK6szTes8fYFQo53tApVyZrk-bdyFw--ceTkSUenCRuxKBO42Qt2DrnhACIK4D78hKJs-4Sf3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MGoVaKV9LM74zOSaTklhOR2t5nDPlRlgvhlHySClXKlExqG0j5Il6A>
    <xmx:MGoVaJmBM-hc9WdcQKIQIU-4AqKUHRqHhfIVVK5kM0z6G7wWtiyw1Q>
    <xmx:MGoVaHdAUMwBy8QD7eQgQ-UpHkxqwcFT65IkMPUMH4ioMgT-gmeoUw>
    <xmx:MGoVaDHuZyoNGcp1YvIRHGRKkKdvqUrLgqUAno2Ty50vVaJ1IZnabw>
    <xmx:MGoVaLV2MzuL29JFqIlMa3XJO_jfYW52DKNTNX4tXs3L6l3bJheCNy49>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 20:58:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 5/6] whatchanged: remove when built with WITH_BREAKING_CHANGES
Date: Fri,  2 May 2025 17:58:13 -0700
Message-ID: <20250503005814.3030099-6-gitster@pobox.com>
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
2.49.0-601-ga5925c3955

