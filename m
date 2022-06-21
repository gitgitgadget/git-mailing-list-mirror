Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4653BC43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 05:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345281AbiFUFgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 01:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345514AbiFUFga (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 01:36:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7F121E35
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 22:36:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m1so9511971wrb.2
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 22:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=sxr6spY3x7vn1WRZ2oWaYtd2LKiWFh37hktxncMx67s=;
        b=APxOaIlTEDyKPkJmBGkLAibpH881Uf41oyg36dKDZvs1PsDWQiXbZM2vGu6JSDU52b
         S7+YgVLGN/bo28kg8WNEgNsbmN/SK497FuDMgJzpo/wni0j6Io5lqf4ww61ONAnHHI4t
         mslto7z8wDmyyR5oTB4xcZRrHnn2gf7gg88BGmkzdmd40KhxByi1AAAau5wBa9tyamBZ
         HAWFMSvh9cwHeaQe8OmXPatiB1/CDettxidUcmIYnnXc6sbWFvTZKSsBppwrL2IhCrx2
         ZCWJbiyQWqIqETAa41dDwfryVjfGo6erlaa/n9mqISTIO+J6pAvrbnxYzoAvJbbeT73Q
         768Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=sxr6spY3x7vn1WRZ2oWaYtd2LKiWFh37hktxncMx67s=;
        b=jWgqO9u+POa7gEZrBLBwKSDut/DopIMUhl4dpTBVIQ8m8Kb3vFT8kFwZGwIDB834c8
         iMcJ7mJKvTSKwZiNMJJShU8JAzLu4kz00D1975EMvA0Yr6xFM1guNMP0849cVLzTVaN9
         n+jvXNzXSBZ8UQj1OwfU+asmMSWzFvjvD4LV7lzqyiqP0lZi+kdoyOVUh0JVDGRmOSjd
         qWHGMCG8G5gNSkEbUnEAruTHXqV655KAxV0Ht/OADhd49eCIbReiOpKf0oUynqhs+fK7
         EdhqNdKmQD4olJXc6SwCm4ubKslG31pVK6ClZljHgY/ZQWYdacxQSYZ96qBvsqfFzwbi
         2qqQ==
X-Gm-Message-State: AJIora8pxDm/Thx3DwERyHO2O/IdLwlhz7Lfddb3X0WQXOrBYRM830Wf
        pvhFW//2D16cHaMBvzQiVYxSXJX7GJBCNw==
X-Google-Smtp-Source: AGRyM1vkmZCYxanbuzQqjwMdxlWNWPg40IClEoBw9TWrQ/W58feg8HhHwqtPq+a2+xhTjKZ2+N0Pdw==
X-Received: by 2002:adf:ef52:0:b0:21b:81e8:5d0b with SMTP id c18-20020adfef52000000b0021b81e85d0bmr18860612wrp.502.1655789779866;
        Mon, 20 Jun 2022 22:36:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7-20020adfef87000000b0021b9153f80fsm4055626wro.71.2022.06.20.22.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 22:36:18 -0700 (PDT)
Message-Id: <pull.1278.v2.git.git.1655789777023.gitgitgadget@gmail.com>
In-Reply-To: <pull.1278.git.git.1655740174420.gitgitgadget@gmail.com>
References: <pull.1278.git.git.1655740174420.gitgitgadget@gmail.com>
From:   "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Jun 2022 05:36:16 +0000
Subject: [PATCH v2] grep: add --max-count command line option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "Martin =?UTF-8?Q?=C3=85gren?= [ ]" <martin.agren@gmail.com>,
        "Paul Eggert [ ]" <eggert@cs.ucla.edu>,
        "Carlos L." <00xc@protonmail.com>,
        =?UTF-8?q?Carlos=20L=C3=B3pez?= <00xc@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <00xc@protonmail.com>

This patch adds a command line option analogous to that of GNU
grep(1)'s -m / --max-count, which users might already be used to.
This makes it possible to limit the amount of matches shown in the
output while keeping the functionality of other options such as -C
(show code context) or -p (show containing function), which would be
difficult to do with a shell pipeline (e.g. head(1)).

Signed-off-by: Carlos López 00xc@protonmail.com
---
    grep: add --max-count command line option
    
    This patch adds a command line option analogous to that of GNU grep(1)'s
    -m / --max-count, which users might already be used to. This makes it
    possible to limit the amount of matches shown in the output while
    keeping the functionality of other options such as -C (show code
    context) or -p (show containing function), which would be difficult to
    do with a shell pipeline (e.g. head(1)).
    
    Signed-off-by: Carlos López 00xc@protonmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1278%2F00xc%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1278/00xc/master-v2
Pull-Request: https://github.com/git/git/pull/1278

Range-diff vs v1:

 1:  f89c6e244aa ! 1:  ee7eb298854 grep: add --max-count command line option
     @@ grep.c: static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, i
       		bol = eol + 1;
       		if (!left)
       			break;
     -+		if (opt->max_count != (unsigned)-1 && count == opt->max_count)
     ++		if (opt->max_count != -1 && count == opt->max_count)
      +			break;
       		left--;
       		lno++;
     @@ grep.h: struct grep_opt {
       	int show_hunk_mark;
       	int file_break;
       	int heading;
     -+	unsigned max_count;
     ++	int max_count;
       	void *priv;
       
       	void (*output)(struct grep_opt *opt, const void *data, size_t size);
     @@ grep.h: struct grep_opt {
       	.relative = 1, \
       	.pathname = 1, \
       	.max_depth = -1, \
     -+	.max_count = (unsigned)-1, \
     ++	.max_count = -1, \
       	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
       	.colors = { \
       		[GREP_COLOR_CONTEXT] = "", \


 Documentation/git-grep.txt | 8 ++++++++
 builtin/grep.c             | 9 +++++++++
 grep.c                     | 2 ++
 grep.h                     | 2 ++
 4 files changed, 21 insertions(+)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 3d393fbac1b..19b817d5e58 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -23,6 +23,7 @@ SYNOPSIS
 	   [--break] [--heading] [-p | --show-function]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-W | --function-context]
+	   [(-m | --max-count) <num>]
 	   [--threads <num>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
@@ -238,6 +239,13 @@ providing this option will cause it to die.
 	`git diff` works out patch hunk headers (see 'Defining a
 	custom hunk-header' in linkgit:gitattributes[5]).
 
+-m <num>::
+--max-count <num>::
+	Limit the amount of matches per file. When using the `-v` or
+	`--invert-match` option, the search stops after the specified
+	number of non-matches. A value of -1 will return unlimited
+	results (the default).
+
 --threads <num>::
 	Number of grep worker threads to use.
 	See `grep.threads` in 'CONFIGURATION' for more information.
diff --git a/builtin/grep.c b/builtin/grep.c
index bcb07ea7f75..4ab28995da0 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -961,6 +961,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOL_F(0, "ext-grep", &external_grep_allowed__ignored,
 			   N_("allow calling of grep(1) (ignored by this build)"),
 			   PARSE_OPT_NOCOMPLETE),
+		OPT_INTEGER('m', "max-count", &opt.max_count,
+			N_("maximum number of results per file")),
 		OPT_END()
 	};
 	grep_prefix = prefix;
@@ -1101,6 +1103,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (recurse_submodules && untracked)
 		die(_("--untracked not supported with --recurse-submodules"));
 
+	/*
+	 * Optimize out the case where the amount of matches is limited to zero.
+	 * We do this to keep results consistent with GNU grep(1).
+	 */
+	if (opt.max_count == 0)
+		exit(EXIT_FAILURE);
+
 	if (show_in_pager) {
 		if (num_threads > 1)
 			warning(_("invalid option combination, ignoring --threads"));
diff --git a/grep.c b/grep.c
index 82eb7da1022..b32ab75cb6b 100644
--- a/grep.c
+++ b/grep.c
@@ -1686,6 +1686,8 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		bol = eol + 1;
 		if (!left)
 			break;
+		if (opt->max_count != -1 && count == opt->max_count)
+			break;
 		left--;
 		lno++;
 	}
diff --git a/grep.h b/grep.h
index c722d25ed9d..bdcadce61b8 100644
--- a/grep.h
+++ b/grep.h
@@ -171,6 +171,7 @@ struct grep_opt {
 	int show_hunk_mark;
 	int file_break;
 	int heading;
+	int max_count;
 	void *priv;
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
@@ -181,6 +182,7 @@ struct grep_opt {
 	.relative = 1, \
 	.pathname = 1, \
 	.max_depth = -1, \
+	.max_count = -1, \
 	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
 	.colors = { \
 		[GREP_COLOR_CONTEXT] = "", \

base-commit: 5b71c59bc3b9365075e2a175aa7b6f2b0c84ce44
-- 
gitgitgadget
