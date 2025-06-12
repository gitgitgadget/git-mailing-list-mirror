Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50422DECBD
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749767146; cv=none; b=mFrvHUGjQhxu5oa4hOs1kQ7571KE7MPBvqriLTnIHU6Ie6Ndn7Z/UwIHpW2VTzSBqBz/kMF+FrvLggITmb7wyaIt7mPBDY+C7wRy7qLWiFLmOzF4QaRAH/HiZhUc3QcHMSVOuQWzUEotf9pNSl6POuzgyurIuc7sZk5jCjqQCc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749767146; c=relaxed/simple;
	bh=THN8n1UsddVlm5PUmJBw0GYtygs8O4r9KNzPkocTu6Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNVTHS/1bIazcwwNpphBeY3i3VlbhlBQ5WfD8fFtkt2l2erP2Yt1lQqXDtpq+V49rKdJEVwPiq+HtdbypPSSxXxrjnhVp3Cn5JIQAK0e4oCAmk8u4/eD6NqT4ILJvADOnJflyioNTZV5LhXImklVZaIzmamDStmoQApJLjIlprg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fGjVdVEJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M9oB2Wgo; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fGjVdVEJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M9oB2Wgo"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id BE350114023A;
	Thu, 12 Jun 2025 18:25:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 12 Jun 2025 18:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1749767142; x=
	1749853542; bh=SYp8LvAp/dkwIgFbm8yTbn825zTkDzhUN6sCusFl2Wo=; b=f
	GjVdVEJo7iMp0DmSFe/6WGUCnCjunKrw2LESSb5M8T9BxK6Y5861MZI4Rr+J1j+d
	afzz48JrM+F8oXOSCQjKMcumbuPLOCTqsjkUVb8D6kvvMTDmFwEw5F1vFRkm8aYj
	idQJ3l2YP2p1NxgYMTsRJWtbpVQfXBQWDQXyDSEbJdaYgnaZ8QMt1kDxnNwLHZQc
	WaqaVjJs7ZG/wz72btbxcOPNDpUgwKHy+hIQoku1zPgnlIk7wfvLvKamfLb7at7f
	wNt9LWUe/0yEWFHaxogjAu/71uRsLlYox3cKXlgknaw4RD8WYrB42SXNXQVV7ps1
	/5OOmpu4bA6IakRvVyCPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1749767142; x=1749853542; bh=SYp8LvAp/dkwIgFbm8yTbn825zTk
	DzhUN6sCusFl2Wo=; b=M9oB2WgorkXBQwjn1g0l3/BKFtaitujalsKmyMHN6swg
	56FkgDM5gWPfsu45N0ZBdAtKGstlLq0QXnR+N8rwuSFlYhTNGIJoT7QGRK5NbII3
	7ULcFUQBRF92RBeH1XyOmALjgBKiyaIdiJ7He0cQvCodYD5SFQbkpSPIqFzyjmoU
	O9Xly1hiTKqxitei/1dQ0LA2TPyBanFCOPpyNkRoEtqhmcgHbvJz6JLpofM0f/y5
	RemANNEYHKWZLXsjHdPU71LXtq6CFxAV1vpEBFhsSmq8hCQ5Ay/ZUu6EjWzwkCsf
	AbSy9X1bajoeWtdKC6lWTJMNx803mCntrzEY0G3xdg==
X-ME-Sender: <xms:5lNLaIKL1S85r6Cp4bYPpvYdByDYXXFdOXw7MI6928hS1SLtNxZJhQ>
    <xme:5lNLaIJOEdmAvc55LQ2xtYkjbjOvHY3XTMYxdhhGxQLMhr8rYh25HBLnXvXlO3DlM
    X_8GZEgeo5dvol7Hg>
X-ME-Received: <xmr:5lNLaIuRHwxwEijc08wLR6NyOVA9dfpWEyQg46Jw3egoihT4Epw-GR35I4N2L8HsHJXmI21JowEwbq6FAlzTahuiPWoOIhN5PZ0h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduiedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeelve
    eifeeiueffueeghfevueeggfefvedvfeelveeuvdefvddufeekhedtfedtgeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5lNLaFZGO4F_1NIIVvonLMn6-uHveZeYE0vV_t0ppCbW7HJsjI_6tA>
    <xmx:5lNLaPb6-e4VnFnL525ighYDMIWqAfes4IPJ13M5_XsJF57vOlPwsg>
    <xmx:5lNLaBB7l4cQKvAtPvTl56ucGvnhFpqB4V52x3Aj1R4uS_Q627ymOg>
    <xmx:5lNLaFZXbZlVOiB7gDxJlHpMCIcefW8xBpSqTEXbw_gTHlwB2ct9kw>
    <xmx:5lNLaMKO0BDnZnLa321b2ErXswrbmU3QOTEnJS1ZwGSHWaPx_Cgfck2b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 18:25:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 1/2] merge/pull: --compact-summary
Date: Thu, 12 Jun 2025 15:25:36 -0700
Message-ID: <20250612222537.2426059-2-gitster@pobox.com>
X-Mailer: git-send-email 2.50.0-rc2-255-gd84100c98d
In-Reply-To: <20250612222537.2426059-1-gitster@pobox.com>
References: <20250612222537.2426059-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, "git merge" and "git pull" shows "git diff --stat @{1}"
to show the extent of the changes.  While it gives a good overview,
one thing that is missing in this output is which paths are created
and/or deleted.

Introduce "--compact-summary" option to these two commands that
tells it to instead show "git diff --compact-summary @{1}", which
gives the same diffstat but notes the created or deleted paths.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-merge.adoc     |  2 +-
 Documentation/merge-options.adoc |  3 +++
 builtin/merge.c                  | 39 ++++++++++++++++++++++++++++----
 builtin/pull.c                   |  3 +++
 t/t7600-merge.sh                 | 28 ++++++++++++++++++++++-
 5 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-merge.adoc b/Documentation/git-merge.adoc
index 12aa859d16..d53923c3b7 100644
--- a/Documentation/git-merge.adoc
+++ b/Documentation/git-merge.adoc
@@ -9,7 +9,7 @@ git-merge - Join two or more development histories together
 SYNOPSIS
 --------
 [synopsis]
-git merge [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
+git merge [-n] [--stat] [--compact-summary] [--no-commit] [--squash] [--[no-]edit]
 	[--no-verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
 	[--[no-]allow-unrelated-histories]
 	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>]
diff --git a/Documentation/merge-options.adoc b/Documentation/merge-options.adoc
index 078f4f6157..95ef491be1 100644
--- a/Documentation/merge-options.adoc
+++ b/Documentation/merge-options.adoc
@@ -113,6 +113,9 @@ include::signoff-option.adoc[]
 With `-n` or `--no-stat` do not show a diffstat at the end of the
 merge.
 
+`--compact-summary`::
+	Show a compact-summary at the end of the merge.
+
 `--squash`::
 `--no-squash`::
 	Produce the working tree and index state as if a real merge
diff --git a/builtin/merge.c b/builtin/merge.c
index ce90e52fe4..736739d3a9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -69,7 +69,10 @@ static const char * const builtin_merge_usage[] = {
 	NULL
 };
 
-static int show_diffstat = 1, shortlog_len = -1, squash;
+#define MERGE_SHOW_DIFFSTAT 1
+#define MERGE_SHOW_COMPACTSUMMARY 2
+
+static int show_diffstat = MERGE_SHOW_DIFFSTAT, shortlog_len = -1, squash;
 static int option_commit = -1;
 static int option_edit = -1;
 static int allow_trivial = 1, have_message, verify_signatures;
@@ -243,12 +246,28 @@ static int option_parse_strategy(const struct option *opt UNUSED,
 	return 0;
 }
 
+static int option_parse_compact_summary(const struct option *opt,
+					const char *name UNUSED, int unset)
+{
+	int *setting = opt->value;
+
+	if (unset)
+		*setting = 0;
+	else
+		*setting = MERGE_SHOW_COMPACTSUMMARY;
+	return 0;
+}
+
 static struct option builtin_merge_options[] = {
 	OPT_SET_INT('n', NULL, &show_diffstat,
 		N_("do not show a diffstat at the end of the merge"), 0),
 	OPT_BOOL(0, "stat", &show_diffstat,
 		N_("show a diffstat at the end of the merge")),
 	OPT_BOOL(0, "summary", &show_diffstat, N_("(synonym to --stat)")),
+	OPT_CALLBACK_F(0, "compact-summary", &show_diffstat, N_("compact-summary"),
+		       N_("show a compactstat at the end of the merge"),
+		       PARSE_OPT_NOARG,
+		       option_parse_compact_summary),
 	{
 		.type = OPTION_INTEGER,
 		.long_name = "log",
@@ -494,8 +513,19 @@ static void finish(struct commit *head_commit,
 		struct diff_options opts;
 		repo_diff_setup(the_repository, &opts);
 		init_diffstat_widths(&opts);
-		opts.output_format |=
-			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
+
+		switch (show_diffstat) {
+		case MERGE_SHOW_DIFFSTAT: /* 1 */
+			opts.output_format |=
+				DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
+			break;
+		case MERGE_SHOW_COMPACTSUMMARY: /* 2 */
+			opts.output_format |= DIFF_FORMAT_DIFFSTAT;
+			opts.flags.stat_with_summary = 1;
+			break;
+		default:
+			break;
+		}
 		opts.detect_rename = DIFF_DETECT_RENAME;
 		diff_setup_done(&opts);
 		diff_tree_oid(head, new_head, "", &opts);
@@ -643,7 +673,8 @@ static int git_merge_config(const char *k, const char *v,
 	}
 
 	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat")) {
-		show_diffstat = git_config_bool(k, v);
+		show_diffstat = git_config_bool(k, v)
+			? MERGE_SHOW_DIFFSTAT : 0;
 	} else if (!strcmp(k, "merge.verifysignatures")) {
 		verify_signatures = git_config_bool(k, v);
 	} else if (!strcmp(k, "pull.twohead")) {
diff --git a/builtin/pull.c b/builtin/pull.c
index a1ebc6ad33..6e72a2e9a4 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -143,6 +143,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "summary", &opt_diffstat, NULL,
 		N_("(synonym to --stat)"),
 		PARSE_OPT_NOARG | PARSE_OPT_HIDDEN),
+	OPT_PASSTHRU(0, "compact-summary", &opt_diffstat, NULL,
+		N_("show a compact-summary at the end of the merge"),
+		PARSE_OPT_NOARG),
 	OPT_PASSTHRU(0, "log", &opt_log, N_("n"),
 		N_("add (at most <n>) entries from shortlog to merge commit message"),
 		PARSE_OPT_OPTARG),
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 2a8df29219..2972922b6a 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -185,8 +185,19 @@ test_expect_success 'reject non-strategy with a git-merge-foo name' '
 test_expect_success 'merge c0 with c1' '
 	echo "OBJID HEAD@{0}: merge c1: Fast-forward" >reflog.expected &&
 
+	cat >expect <<-\EOF &&
+	Updating FROM..TO
+	Fast-forward
+	 file  | 2 +-
+	 other | 9 +++++++++
+	 2 files changed, 10 insertions(+), 1 deletion(-)
+	 create mode 100644 other
+	EOF
+
 	git reset --hard c0 &&
-	git merge c1 &&
+	git merge c1 >out &&
+	sed -e "1s/^Updating [0-9a-f.]*/Updating FROM..TO/" out >actual &&
+	test_cmp expect actual &&
 	verify_merge file result.1 &&
 	verify_head "$c1" &&
 
@@ -205,6 +216,21 @@ test_expect_success 'merge c0 with c1 with --ff-only' '
 	verify_head "$c1"
 '
 
+test_expect_success 'the same merge with compact summary' '
+	cat >expect <<-\EOF &&
+	Updating FROM..TO
+	Fast-forward
+	 file        | 2 +-
+	 other (new) | 9 +++++++++
+	 2 files changed, 10 insertions(+), 1 deletion(-)
+	EOF
+
+	git reset --hard c0 &&
+	git merge --compact-summary c1 >out &&
+	sed -e "1s/^Updating [0-9a-f.]*/Updating FROM..TO/" out >actual &&
+	test_cmp expect actual
+'
+
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge from unborn branch' '
-- 
2.50.0-rc2-255-gd84100c98d

