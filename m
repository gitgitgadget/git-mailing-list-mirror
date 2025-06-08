Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4612B8F54
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749398747; cv=none; b=jSjx8ftZ/y0jScy3prFSNwHgJVxs13o9f0MXF+97+VbPsXGcEecnlu7ZTxlElEvnG0sSjZxfCGNKU+9QCX5IXGjxKWL3PKuUuicDa6zyCQW7PKwauMDqdOpRHyD/+x0q4spNKYVDTMFU0Sm5w2dD7s9bYMGu567RdVZhLYCcNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749398747; c=relaxed/simple;
	bh=GHArSQtDx7wPWLZX1ps3cACcvJr7R6aHdbDWk76yDlQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ek8G3UN9xZFGGkJ7uYNE1WJLb0gZxWrTi2g7BJ38hY2LqAoQNJXv0xdwXTgKqg1tlz5EPh3vXCYy7ZqvOMtlUdVHWP1MMqeMfNfCtEvbvKpDY5Dm2NSyikHIAQb1sPR6hoHmo5Ae3U7y4kk6SUgir1cdoaIwtgio/eCGa0swmGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e7Tbktmg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BnNcxPo8; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e7Tbktmg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BnNcxPo8"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4910F25400A8;
	Sun,  8 Jun 2025 12:05:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 08 Jun 2025 12:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1749398743; x=1749485143; bh=JpjnClNIofnLi5+KHRj90R8y/sLzt88H
	JVIVyEcKag8=; b=e7TbktmgFkx1xWg68JtvFBad4cTj+PIRuJuMxObb0mJ3Zi0f
	ZWm6I4stm164WmnLNhua72e2LvXq8voWAzvL3gIKVNLiXBKeNHwdkHkKVyWxWy4x
	Ky9KVGtMof1QeTpDU09S68dck+kHk2KPDbehjjy75AG074sjhHKUjiMA/XysYUEk
	PhoQs17GagRQIu3jhgerwIC9Olr60dBWfTdFQuTqGy9A49wX7OxBVJy0/9ekWF6Q
	1pEc96/9T9J27URmBqIKZ1s4RH0dlde9Orq+EjgiEpcCVoPWa7jhzvejQHdcDQLq
	4HzkUVlEPXZMHnPVYmWVII33QVvMf19yAUMbTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749398743; x=
	1749485143; bh=JpjnClNIofnLi5+KHRj90R8y/sLzt88HJVIVyEcKag8=; b=B
	nNcxPo8t8yypyj+p5uC7uaMH802o5P1x2K63BoeuKwH7A5Kq2INxHZ58zR3Wdr8K
	9asaZMgRAs1uHCdxn8aXuc2lFPGF+sswE+sw1xFEohmoU1EtsSFmMNsKSjNfXMXH
	+WE/sFSaThbDCrJ4i6OyMPu4KK+zefQDYp5KJKAf40D7O0EFpMJgTKRdZRg7nkVo
	uKciW6rfnPAojMAVY7d8Svh0/M7uPEFWef4lng650cnNCtpSJ0qctvR53iCNoHZe
	msS/PPlSL/kaFD8uOU41Weh6ahWB1oPqJn7pS0AzrJh0U62WPp/rBQiNLllAGttW
	Wyx6vuaK5Cdm3T0/q9Sxg==
X-ME-Sender: <xms:1rRFaPfJGknIgRAMjjE8s6DZhnFcfX_yTOt8Igb8JJFTjNFqRCMy1Q>
    <xme:1rRFaFMEhtt_JZVb38Rf48W7nILWNRcGMUSgVSJb7SzIU3vRgmf9S8AtYZ2MW5ITC
    R68ONm7Qmkzme3r7Q>
X-ME-Received: <xmr:1rRFaIjB1s0MJW3LPBTmTajTkQGAko5sDrBjV8BriZ2FqGT7sHsMUw7msFEvc1L5gYIo5F8S5MmQqd1EMuH-7jrHaO8d3EBvHWnZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdektdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceo
    ghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepledvfedtfe
    dtkeefueevlefgleetieeuffffkefhgfekveehkefhgfetjefhffegnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosg
    hogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1rRFaA8DlDRZEsEtyRIRbwSbSJka38mW6S6f2Qvau3CJ_jhzMI_sZw>
    <xmx:1rRFaLuL3G3VrkuAW6uJzwRj2UnieYKr3WI9eU6QfidtU7syQuBSlA>
    <xmx:1rRFaPEcvGfC35nkdiZpolUPCiHulTEsu0541APbWAhxw5mUaM_m1Q>
    <xmx:1rRFaCNq4ktTWegAozL_zhibBNDDQH9zjh46N4NJAvZMMcrMIS5KyA>
    <xmx:17RFaLcr51loWBGeXHZKQiSBLl4Yhxn39Pt2GDfoH6yo9aTOUoc2wWfo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Jun 2025 12:05:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] merge/pull: --compact-summary
Date: Sun, 08 Jun 2025 09:05:41 -0700
Message-ID: <xmqq5xh6xlpm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

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
index 2a8df29219..ce666efbcc 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -185,8 +185,19 @@ test_expect_success 'reject non-strategy with a git-merge-foo name' '
 test_expect_success 'merge c0 with c1' '
 	echo "OBJID HEAD@{0}: merge c1: Fast-forward" >reflog.expected &&
 
+	cat >expect <<-EOF &&
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
+	cat >expect <<-EOF &&
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
2.50.0-rc1-276-gda78c2366e

