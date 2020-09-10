Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5B8C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 07:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F01A20795
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 07:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSlaYCZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgIJHdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbgIJHcp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 03:32:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EF1C0613ED
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 00:32:45 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id e4so493783pln.10
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 00:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S/QifQe57MOrI7Xj9erN8l7NhwVR7X9un0ZWB+8/n3Q=;
        b=mSlaYCZIRxrEpkX85W72soK9gpahUaOEIygTOXkX2WX1U8euzBmYM6VCKg8qO1n1Wd
         XFCE1nS2j0FtgWbTGnVsFzKiCFhMb0I9zmOlLMYDuQmeXIiEzXzDqwTHK7lnGw8YhWZi
         2X/RVy10zXqy6OnQJs8Q80xX4cWNvpeCSTNN8PHn4X81mIu1qJv7dOm/uR3mREFePxEN
         4Tvd1EzlVBqeu11wgzwCj9UOmih6MJngfQosIEeeIfmNZgoGb9ghh5kk0kmBhnWPlv5D
         yp76TnA9YqNzNT1nfCVAYgppgnFW2aX6PwDQaSo0Ub7VtgTokKxDjGqHgtI5/izDgd+U
         Bn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S/QifQe57MOrI7Xj9erN8l7NhwVR7X9un0ZWB+8/n3Q=;
        b=m/esgKsGJMh0XUcS1zreUBTvHPQMLmnsk13qk1II03PPzoCaugSGpBqQmg7H5yk0JT
         0oNbtjsJlzs5SVsOc/LDwR0wZy8Gl1VluJZulOUE07m2R4jvUzcWM+pzfM3BpmW2LcZG
         8LAGrt6DP5Mmems0+C6IHaJdYS55KYKcMj5qt62MbpvgGEPbe1qxbawnExK9uuCh35Zw
         Ca3EVv7jpxS3lsXBaQ/bkzjUDGwZTChpmpxnzHNPyChjEsgWbPQli/MSfiIcE14k9tsF
         oq+Am/7T5Wv3+rkDfNZczZQ5Wi4j1+E8WzIMudojZbmIIuLY2FxjijwZQWqZFbhdzae3
         +ApQ==
X-Gm-Message-State: AOAM531U02PsAR1JmwooQbsAfBFwz6a63I0IGgs9JE7XM/Tk0MlekU+h
        YGUMJ/aq5yMHy1bxlHfsv0TYBE5lovU=
X-Google-Smtp-Source: ABdhPJxv2ZjfHCBpo3czQh8KPfwDgS/BCis0g5Mz1bLW3e2G2ZGxQiiPkV2krf0a2IFAbCwJ3Y5ptg==
X-Received: by 2002:a17:902:b105:b029:d0:cbe1:e7b1 with SMTP id q5-20020a170902b105b02900d0cbe1e7b1mr4392183plr.34.1599723164300;
        Thu, 10 Sep 2020 00:32:44 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:5900:d670::1ab5])
        by smtp.gmail.com with ESMTPSA id q127sm4990550pfb.61.2020.09.10.00.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 00:32:43 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] builtin/diff: parse --no-index using parse_options()
Date:   Thu, 10 Sep 2020 00:32:19 -0700
Message-Id: <ea6717e7b3a8b89fc3750505678321803cde78dc.1599723087.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1599723087.git.liu.denton@gmail.com>
References: <cover.1599332861.git.liu.denton@gmail.com> <cover.1599723087.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of parsing the `--no-index` option with a plain strcmp, use
parse_options() to parse options. This allows us to easily add more
options in a future commit.

As a result of this change, `--no-index` is removed from `argv` so, as a
result, we no longer need to handle it in diff_no_index().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/diff.c  | 33 ++++++++++++++++++++++-----------
 diff-no-index.c | 15 +++------------
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index cb98811c21..0e086ed7c4 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -373,6 +373,13 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	int nongit = 0, no_index = 0;
 	int result = 0;
 	struct symdiff sdiff;
+	struct option options[] = {
+		OPT_SET_INT_F(0, "no-index", &no_index,
+			   N_("compare the given paths on the filesystem"),
+			   DIFF_NO_INDEX_EXPLICIT,
+			   PARSE_OPT_NONEG),
+		OPT_END(),
+	};
 
 	/*
 	 * We could get N tree-ish in the rev.pending_objects list.
@@ -406,21 +413,25 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	 * Other cases are errors.
 	 */
 
-	/* Were we asked to do --no-index explicitly? */
-	for (i = 1; i < argc; i++) {
-		if (!strcmp(argv[i], "--")) {
-			i++;
-			break;
-		}
-		if (!strcmp(argv[i], "--no-index"))
-			no_index = DIFF_NO_INDEX_EXPLICIT;
-		if (argv[i][0] != '-')
-			break;
-	}
+	argc = parse_options(argc, argv, prefix, options, NULL,
+			     PARSE_OPT_KEEP_DASHDASH |
+			     PARSE_OPT_KEEP_ARGV0 |
+			     PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_NO_INTERNAL_HELP);
 
 	prefix = setup_git_directory_gently(&nongit);
 
 	if (!no_index) {
+		int i;
+		for (i = 1; i < argc; i++) {
+			if (!strcmp(argv[i], "--")) {
+				i++;
+				break;
+			}
+			if (argv[i][0] != '-')
+				break;
+		}
+
 		/*
 		 * Treat git diff with at least one path outside of the
 		 * repo the same as if the command would have been executed
diff --git a/diff-no-index.c b/diff-no-index.c
index 7814eabfe0..da82e2d090 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -243,28 +243,19 @@ int diff_no_index(struct rev_info *revs,
 		  int implicit_no_index,
 		  int argc, const char **argv)
 {
-	int i, no_index;
+	int i;
 	const char *paths[2];
 	struct strbuf replacement = STRBUF_INIT;
 	const char *prefix = revs->prefix;
-	struct option no_index_options[] = {
-		OPT_BOOL_F(0, "no-index", &no_index, "",
-			   PARSE_OPT_NONEG | PARSE_OPT_HIDDEN),
-		OPT_END(),
-	};
-	struct option *options;
 
-	options = parse_options_concat(no_index_options,
-				       revs->diffopt.parseopts);
-	argc = parse_options(argc, argv, revs->prefix, options,
+	argc = parse_options(argc, argv, revs->prefix, revs->diffopt.parseopts,
 			     diff_no_index_usage, 0);
 	if (argc != 2) {
 		if (implicit_no_index)
 			warning(_("Not a git repository. Use --no-index to "
 				  "compare two paths outside a working tree"));
-		usage_with_options(diff_no_index_usage, options);
+		usage_with_options(diff_no_index_usage, revs->diffopt.parseopts);
 	}
-	FREE_AND_NULL(options);
 	for (i = 0; i < 2; i++) {
 		const char *p = argv[argc - 2 + i];
 		if (!strcmp(p, "-"))
-- 
2.28.0.618.gf4bc123cb7

