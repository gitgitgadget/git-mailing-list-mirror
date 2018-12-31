Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CB5D1F770
	for <e@80x24.org>; Mon, 31 Dec 2018 21:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbeLaVsz (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Dec 2018 16:48:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46001 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbeLaVsz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Dec 2018 16:48:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so13039711pgc.12
        for <git@vger.kernel.org>; Mon, 31 Dec 2018 13:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RC0x7dU7dHgOpTzhAUJeuo/gEdl09g4qFpyZPmqk91M=;
        b=bNTU6ur4MhQqkYoKPlhF6TuLoaUukW8DM01vSWQrl0niPJM5BQjKQwyoxj49roApJ6
         oaN8wBOQmiZOnilGCD33f5IaPtpub8VUFO0Yj3od1En0I85p2urvqtqYuDko2n7EETcN
         njWJHenPBNW+/iIl8iIZYM2rzPKwuXNWCdv6eCRteQLHH9io0/YRxMZr5MPkv+BbOMpq
         57zlnW4v5UWxS6mRDYDNhpOnaHepN9+l1bWj/k9T+yVMV+gZETCD8dW4+GYnT7Mk3/2B
         uzIE0yCmT2g3IpBdVl1qqRBnJqLgpvWxWjdhw66T2iQPRIcKmbPBVaqZNdjIHu0LdfCy
         fKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RC0x7dU7dHgOpTzhAUJeuo/gEdl09g4qFpyZPmqk91M=;
        b=AyC9uMLdz216VdSEaQFqUvCF8rYR3MsY2waUuv/8p/2IbBsrmbfALzlvOhmW/nH7C7
         xfRgp8ZIEPBPnoKmLX4YAgK3cV4g37/sbb7MjiweKWyT0X2LAeDvwltVWRvtIEd6toWQ
         o3bhS9T36rNbB13FZRJL/0EaKVhqwFHeUJIpf4MBJ3O6KoJmfz4nf9nJ1IYkEonAbCTA
         zaPqSiI/uGmloKxihbIdBFFy99ZOyQLVa8MWgyvd/GnMZ+YYoKGPoVu2rMNeUhH7gt+b
         d+oVM0gmReRkORJnLVWppnP5HN38Wwj4pr2FgE2jgEdE27JrVBwlxe1pz2zwUgKWrWAL
         KKpQ==
X-Gm-Message-State: AJcUukcAQ2fL6LkaqDANUaXeJXz5U+WLMm4lajiH1fcJS4YFjnZM47ec
        PiWdrAbu14IfwvaiGNTOqAacFnXcgKY=
X-Google-Smtp-Source: ALg8bN4bmp/Hf73bIaFFyd9nx56JLFsrwDIke2kOvaW8qGlqVSsvD8/2NJv+l9iwwVZroHovAX/86w==
X-Received: by 2002:a63:2f07:: with SMTP id v7mr8271389pgv.368.1546292933447;
        Mon, 31 Dec 2018 13:48:53 -0800 (PST)
Received: from localhost.localdomain (103-115-211-182.6773d3.mel.nbn.aussiebb.net. [103.115.211.182])
        by smtp.gmail.com with ESMTPSA id v9sm70417781pfg.144.2018.12.31.13.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Dec 2018 13:48:52 -0800 (PST)
From:   issac.trotts@gmail.com
To:     git@vger.kernel.org
Cc:     noemi@sourcegraph.com, Issac Trotts <issac.trotts@gmail.com>,
        Issac Trotts <issactrotts@google.com>
Subject: [PATCH] log: add %S option (like --source) to log --format
Date:   Tue,  1 Jan 2019 08:48:18 +1100
Message-Id: <20181231214818.15294-1-issac.trotts@gmail.com>
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
index e8e51068b..be3025657 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -203,7 +203,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	    rev->diffopt.filter || rev->diffopt.flags.follow_renames)
 		rev->always_show_header = 0;
 
-	if (source) {
+	if (source || (rev->pretty_given && (rev->commit_format == CMIT_FMT_USERFORMAT) && w.source)) {
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

