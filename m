Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B5551F803
	for <e@80x24.org>; Tue,  8 Jan 2019 13:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfAHNVK (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 08:21:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33314 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfAHNVK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 08:21:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so1953345pfb.0
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 05:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VnLB2wCkOX4eYWEruonhDyZVWdPGNIjiRwR82/el4Sk=;
        b=SUgIlDYN2BUpFb6k6GzpakEZIPVTw3SyffCxBXvqX0XG6VZESzsU1kwol4Vl8Kboc3
         W3nQEzm/jzvUC3GocPfsDM/DSOtxPxOTNQpP/t5jqdnxM1Ff7iQS41LFiCSDhQd7iSyt
         FsArnvRBOdNU/Zaml10/CcWgzvDzkOuaaN6T9VTwTE1gV3iH2QQdoYvpA/lE/J9UFha7
         BzVYc6pXZCUZD1O/t7vtmSifrxSHrJUZuHWTtPQDfCSC6n0qSE/KTzd+6fU3bfG7k+CL
         7aeICmF4MZv1/2H2XXkY3DBbcv+hXAciZ/69CdxUH91jsTPubrT/cCQJc46kQtlnaImD
         H68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VnLB2wCkOX4eYWEruonhDyZVWdPGNIjiRwR82/el4Sk=;
        b=jZdYMkFSnB+bjLoQj5xUNzjNB3FE8cqhbLqfjUUtLGZRv4Mah78Eih0KD2RO6BT+cw
         N58NBi+TglM0caaqPkUjNtg5YLS6Gxs7lTD8LOwjlfFAwjZse+om1TLClwdZdcJ0HV4P
         HgftLUJHrCRtIerMov+zGUI5hu0+CzzI6gOLArW6svwH+jDmh1XckrsHDa3NBUM6MoqG
         e8pDjBWm6PmgTN3Seu51A9xlb1VhdxbufV7SNZLQofyu5JfLDX2i0yR9ZLwFQa2x39ek
         454qqv3HCve20bgoY/2moW+uHjc9lUJfcA9svnZu1mh92G3ooU1yN0VO3ufUTqrHukxi
         IuUQ==
X-Gm-Message-State: AJcUukfagzo4q3hgI9Ol06DfI4tq+PDko5BghBJsKDEFH/z5fXCPBHkt
        Iw6VNGT/7UZ+dlsny166eErwCC/cjMM=
X-Google-Smtp-Source: ALg8bN5/JxGczMz/q6Ye/arK6lrJDNC9qYtDr7guHbmViVr7mIfjATuUsS9w4IqLh6lToiqbbLm+dg==
X-Received: by 2002:a63:e051:: with SMTP id n17mr1528245pgj.258.1546953668456;
        Tue, 08 Jan 2019 05:21:08 -0800 (PST)
Received: from localhost.localdomain (103-115-211-182.6773d3.mel.nbn.aussiebb.net. [103.115.211.182])
        by smtp.gmail.com with ESMTPSA id f20sm88537576pfn.177.2019.01.08.05.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Jan 2019 05:21:07 -0800 (PST)
From:   issac.trotts@gmail.com
X-Google-Original-From: issactrotts@google.com
To:     git@vger.kernel.org
Cc:     noemi@sourcegraph.com, Issac Trotts <issac.trotts@gmail.com>,
        Issac Trotts <issactrotts@google.com>
Subject: [PATCH] log: add %S option (like --source) to log --format
Date:   Wed,  9 Jan 2019 00:20:48 +1100
Message-Id: <20190108132048.57142-1-issactrotts@google.com>
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
 pretty.c                         | 14 +++++++++
 pretty.h                         |  1 +
 t/t4205-log-pretty-formats.sh    | 50 ++++++++++++++++++++++++++++++++
 t/t6006-rev-list-format.sh       |  4 +++
 7 files changed, 73 insertions(+), 1 deletion(-)

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
index b83a3ecd2..06075d625 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1084,6 +1084,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	struct commit_list *p;
 	const char *arg;
 	int ch;
+	char **slot;
 
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
@@ -1194,6 +1195,16 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		load_ref_decorations(NULL, DECORATE_SHORT_REFS);
 		format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
 		return 1;
+	case 'S':		/* tag/branch like --source */
+		if (c->pretty_ctx->rev == NULL || c->pretty_ctx->rev->sources == NULL) {
+			return 0;
+		}
+		slot = revision_sources_at(c->pretty_ctx->rev->sources, commit);
+		if (!(slot && *slot)) {
+			return 0;
+		}
+		strbuf_addstr(sb, *slot);
+		return 1;
 	case 'g':		/* reflog info */
 		switch(placeholder[1]) {
 		case 'd':	/* reflog selector */
@@ -1498,6 +1509,9 @@ static size_t userformat_want_item(struct strbuf *sb, const char *placeholder,
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

