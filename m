Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4B1C33CB7
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A24207E0
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gatxg3v0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgAPGPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:15:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38750 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbgAPGOs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so17894314wrh.5
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AQrJZiOtQpeYBVGvI+Fa9iDK0sg5zqap2ewkepptwbY=;
        b=gatxg3v0ZBckrV8v7+cjEFcZsJHw6Nc4vc49ycIiMM5Bxo9IdDtCmoUUgxVibHSvJ+
         tXEJLms85T58maN9ZY48lzka8cpmugvO5ho7+Gdf28x1qFSms7l1L3vm1HBS8GJBLnHX
         CKsgZ4F0v/Abvz/5/HDnHoQapDB4zHjccJrVgczisb/eEYZp6grbONTA9ld6Zv4En+sq
         5tqxNoH6/7ChLqp2DGmzeAxr4LzV4xjIvr5mtIh9Fz3OpDU39m9lZHZHU9ZL+iMYtFhf
         IX/ykpFCKgfy2v+hY1pDq2+TIfHGirOFoMFJ8JviA43wy3gtDwi9r96mbUaZslliK7pe
         VLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AQrJZiOtQpeYBVGvI+Fa9iDK0sg5zqap2ewkepptwbY=;
        b=XeWHKOzshaHHK4iQVFOZf0p0BhD3QffVw36quQ6LeAsu5XGh6IRrDj7ROAPsa1PY8Y
         6a67d1aWu4q1f0wWTYLnADah52LMkiwSlp+cctRE/Z5g0RIOx4lW3XmdxaeZhhGBeoA6
         dJZK3EHkIkGbaIEh5SPrp8fCftXWch7FQEoz5Ndqe2ORN3zfNVNqaZN+mux2UeU8cchd
         2CN7YnGsTO1dRlq1zLpB6u7mRUEKgqWbNoFXt82k0qq2rWHw3wDq22lyjFhP7xE/5yNH
         p5LRwImzyVxDc+1vTjyfI9GAcxrlVSajyAxUVhis88CEZGMfHIyLWGu4wqzTwK0DDshW
         FN8g==
X-Gm-Message-State: APjAAAVkwuUgHXQ/ojoNgcaI2i+pFaNCjTNhvyDW9JFpi+8zHUlWadPB
        fY92Ty5TG94dyltd55ZUbTjC6p0a
X-Google-Smtp-Source: APXvYqzO/+3vBkwqFF6MwDoO7OOac99IrvKMnOh5EG9rnbdVWqC4dmxOBWCfWn9OHy+hxrqPU6I6TQ==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr1240637wrq.331.1579155285349;
        Wed, 15 Jan 2020 22:14:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s1sm3017162wmc.23.2020.01.15.22.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:44 -0800 (PST)
Message-Id: <5478c730acad0423399de018f2099c07fefbb190.1579155273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:27 +0000
Subject: [PATCH v4 13/19] rebase: add an --am option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Currently, this option doesn't do anything except error out if any
options requiring the interactive-backend are also passed.  However,
when we make the default backend configurable later in this series, this
flag will provide a way to override the config setting.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 11 ++++++++++-
 builtin/rebase.c             | 18 +++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index df02d76e2d..5230084be9 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -258,6 +258,13 @@ See also INCOMPATIBLE OPTIONS below.
 	original branch. The index and working tree are also left
 	unchanged as a result.
 
+--am:
+	Use git-am internally to rebase.  This option may become a
+	no-op in the future once the interactive backend handles
+	everything the am one does.
++
+See also INCOMPATIBLE OPTIONS below.
+
 --empty={drop,keep,ask}::
 	How to handle commits that are not empty to start and are not
 	clean cherry-picks of any upstream commit, but which become
@@ -376,7 +383,7 @@ See also INCOMPATIBLE OPTIONS below.
 	Ensure at least <n> lines of surrounding context match before
 	and after each change.  When fewer lines of surrounding
 	context exist they all must match.  By default no context is
-	ever ignored.
+	ever ignored.  Implies --am.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -416,6 +423,7 @@ with `--keep-base` in order to drop those commits from your branch.
 --whitespace=<option>::
 	These flags are passed to the 'git apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
+	Implies --am.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -559,6 +567,7 @@ INCOMPATIBLE OPTIONS
 
 The following options:
 
+ * --am
  * --committer-date-is-author-date
  * --ignore-date
  * --ignore-whitespace
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 55a0b2a288..6884590258 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1335,6 +1335,18 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
 	return res && is_linear_history(onto, head);
 }
 
+static int parse_opt_am(const struct option *opt, const char *arg, int unset)
+{
+	struct rebase_options *opts = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+
+	opts->type = REBASE_AM;
+
+	return 0;
+}
+
 /* -i followed by -m is still -i */
 static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
 {
@@ -1519,6 +1531,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "show-current-patch", &action,
 			    N_("show the patch file being applied or merged"),
 			    ACTION_SHOW_CURRENT_PATCH),
+		{ OPTION_CALLBACK, 0, "am", &options, NULL,
+			N_("use apply-mail strategies to rebase"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			parse_opt_am },
 		{ OPTION_CALLBACK, 'm', "merge", &options, NULL,
 			N_("use merging strategies to rebase"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
@@ -1878,7 +1894,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (isatty(2) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
 
-	if (options.git_am_opts.argc) {
+	if (options.git_am_opts.argc || options.type == REBASE_AM) {
 		/* all am options except -q are compatible only with --am */
 		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
 			if (strcmp(options.git_am_opts.argv[i], "-q"))
-- 
gitgitgadget

