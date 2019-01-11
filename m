Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AFD01F803
	for <e@80x24.org>; Fri, 11 Jan 2019 06:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfAKGa6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 01:30:58 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33177 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfAKGa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 01:30:58 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so6343722plo.0
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 22:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XT2KH+9DrgxUcbKyQtXb8mMlYQDb1dlZHYX8JygkDkA=;
        b=WBEcO0aypwX9ZZ2bxFJOitoU08f5fcBFHjGuZd/67D3x4YZqoyEmj5AzBmRfZuaHxu
         g6Wh2vvJnEkUIWoEV9VQUrrsGZNqxbBDoPOhQV5DPp1PCqje+xsNeqhHyD2KMEDJt48S
         ljryWGxamTj6uParTlIXVc0isiwA+pYW75IDwy1F0bQ8iRSV97OQC2CpDllnjCdZ70en
         5l1D6qv0J91ib9FVCUEpaksXPz88u8vc/T9ZbfoU3MSCe7xYo8W4qMng3WDlLqR7JZSg
         jSpSXoF7S5TRc9hLiIJGqOgdK1hKEVtgTYgdydGeEvdzrStD8RTRiv90XX//x/9Lxlvg
         XBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XT2KH+9DrgxUcbKyQtXb8mMlYQDb1dlZHYX8JygkDkA=;
        b=OT3IPDxqEZDn/Ba2Rpj0E+auwFua0QHGjI8rHMEmx0EDXtICX6ysNtaW54OcKVz0DF
         2pkBd4hFlCMHjt0pY2X9LU+hqQWv82umpnvsjrfI8wPZYxzD57om4v+RWQquGAIXFEVt
         8ZMQeE0SN3nC0MpIvNhsXdHPF89p7qHC/GXesBhYg2aewnIdy8lxFVCdEhlxyovhDxSQ
         SF4U0z4YEiHh5rBk4pLu9joTIW4Epsf6o6PnnsylzzSQ+haqy+uUof7d1saap4HtYvtS
         rHfiBko60I5vT8wTJ/vckt5feWKYEc8cGhL4LnUSEP6au9kzXmTq6aKm39Ic9rdvlW+7
         LjQQ==
X-Gm-Message-State: AJcUukcVyDZz48HyQ1gQphikJa9QmznnW0QWFDpAuJjVByYVh3AdFvY2
        p9TV9kLc8CqtxU9TueKvsgs/94L3lVA=
X-Google-Smtp-Source: ALg8bN45iVTwsSSVbzW4iChsJWyAKEkp/Q7h3M1qQYdiF2TpyE+id6eDq3AX4eEgwSIWDHin4ZYuNA==
X-Received: by 2002:a17:902:b18b:: with SMTP id s11mr13356038plr.56.1547188256080;
        Thu, 10 Jan 2019 22:30:56 -0800 (PST)
Received: from Issacs-MacBook.local.net (c-73-252-238-88.hsd1.ca.comcast.net. [73.252.238.88])
        by smtp.gmail.com with ESMTPSA id p67sm130543539pfg.44.2019.01.10.22.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 22:30:54 -0800 (PST)
From:   issac.trotts@gmail.com
X-Google-Original-From: issactrotts@google.com
To:     git@vger.kernel.org
Cc:     noemi@sourcegraph.com, Issac Trotts <issac.trotts@gmail.com>,
        Issac Trotts <issactrotts@google.com>
Subject: [PATCH] log: add %S option (like --source) to log --format
Date:   Thu, 10 Jan 2019 22:30:46 -0800
Message-Id: <20190111063046.60771-1-issactrotts@google.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Issac Trotts <issac.trotts@gmail.com>

Make it possible to write for example

        git log --format="%H,%S"

where the %S at the end is a new placeholder that prints out the ref
(tag/branch) for each commit.

Using %d might seem like an alternative but it only shows the ref for the last
commit in the branch.

Signed-off-by: Issac Trotts <issactrotts@google.com>

---

This change is based on a question from Stack Overflow:
https://stackoverflow.com/questions/12712775/git-get-source-information-in-format
---
 Documentation/pretty-formats.txt |  2 ++
 builtin/log.c                    |  2 +-
 log-tree.c                       |  1 +
 pretty.c                         | 12 ++++++++
 pretty.h                         |  1 +
 t/t4205-log-pretty-formats.sh    | 50 ++++++++++++++++++++++++++++++++
 t/t6006-rev-list-format.sh       |  4 +++
 7 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 417b638cd..de6953108 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -134,6 +134,8 @@ The placeholders are:
 - '%cI': committer date, strict ISO 8601 format
 - '%d': ref names, like the --decorate option of linkgit:git-log[1]
 - '%D': ref names without the " (", ")" wrapping.
+- '%S': ref name given on the command line by which the commit was reached
+  (like `git log --source`), only works with `git log`
 - '%e': encoding
 - '%s': subject
 - '%f': sanitized subject line, suitable for a filename
diff --git a/builtin/log.c b/builtin/log.c
index e8e51068b..9deff32b8 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -203,7 +203,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	    rev->diffopt.filter || rev->diffopt.flags.follow_renames)
 		rev->always_show_header = 0;
 
-	if (source) {
+	if (source || w.source) {
 		init_revision_sources(&revision_sources);
 		rev->sources = &revision_sources;
 	}
diff --git a/log-tree.c b/log-tree.c
index 10680c139..3cb14256e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -700,6 +700,7 @@ void show_log(struct rev_info *opt)
 	ctx.color = opt->diffopt.use_color;
 	ctx.expand_tabs_in_log = opt->expand_tabs_in_log;
 	ctx.output_encoding = get_log_output_encoding();
+	ctx.rev = opt;
 	if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
 		ctx.from_ident = &opt->from_ident;
 	if (opt->graph)
diff --git a/pretty.c b/pretty.c
index b83a3ecd2..1b453fbb5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1084,6 +1084,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	struct commit_list *p;
 	const char *arg;
 	int ch;
+	char **slot;
 
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
@@ -1194,6 +1195,14 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		load_ref_decorations(NULL, DECORATE_SHORT_REFS);
 		format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
 		return 1;
+	case 'S':		/* tag/branch like --source */
+		if (!(c->pretty_ctx->rev && c->pretty_ctx->rev->sources))
+			return 0;
+		slot = revision_sources_at(c->pretty_ctx->rev->sources, commit);
+		if (!(slot && *slot))
+			return 0;
+		strbuf_addstr(sb, *slot);
+		return 1;
 	case 'g':		/* reflog info */
 		switch(placeholder[1]) {
 		case 'd':	/* reflog selector */
@@ -1498,6 +1507,9 @@ static size_t userformat_want_item(struct strbuf *sb, const char *placeholder,
 	case 'N':
 		w->notes = 1;
 		break;
+	case 'S':
+		w->source = 1;
+		break;
 	}
 	return 0;
 }
diff --git a/pretty.h b/pretty.h
index 7359d318a..87ca5dfcb 100644
--- a/pretty.h
+++ b/pretty.h
@@ -60,6 +60,7 @@ static inline int cmit_fmt_is_mail(enum cmit_fmt fmt)
 
 struct userformat_want {
 	unsigned notes:1;
+	unsigned source:1;
 };
 
 /* Set the flag "w->notes" if there is placeholder %N in "fmt". */
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 978a8a66f..7df8c3d4e 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -621,4 +621,54 @@ test_expect_success 'trailer parsing not fooled by --- line' '
 	test_cmp expect actual
 '
 
+test_expect_success 'set up %S tests' '
+	git checkout --orphan source-a &&
+	test_commit one &&
+	test_commit two &&
+	git checkout -b source-b HEAD^ &&
+	test_commit three
+'
+
+test_expect_success 'log --format=%S paints branch names' '
+	cat >expect <<-\EOF &&
+	source-b
+	source-a
+	source-b
+	EOF
+	git log --format=%S source-a source-b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --format=%S paints tag names' '
+	git tag -m tagged source-tag &&
+	cat >expect <<-\EOF &&
+	source-tag
+	source-a
+	source-tag
+	EOF
+	git log --format=%S source-tag source-a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --format=%S paints symmetric ranges' '
+	cat >expect <<-\EOF &&
+	source-b
+	source-a
+	EOF
+	git log --format=%S source-a...source-b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '%S in git log --format works with other placeholders (part 1)' '
+	git log --format="source-b %h" source-b >expect &&
+	git log --format="%S %h" source-b >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '%S in git log --format works with other placeholders (part 2)' '
+	git log --format="%h source-b" source-b >expect &&
+	git log --format="%h %S" source-b >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index ec42c2f77..da113d975 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -185,6 +185,10 @@ test_expect_success 'basic colors' '
 	test_cmp expect actual
 '
 
+test_expect_success '%S is not a placeholder for rev-list yet' '
+	git rev-list --format="%S" -1 master | grep "%S"
+'
+
 test_expect_success 'advanced colors' '
 	cat >expect <<-EOF &&
 	commit $head2
-- 
2.19.1

