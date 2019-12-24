Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8FBC2D0D0
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67862206CB
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Et0gIS+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLXTzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:55:13 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34795 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfLXTzL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 14:55:11 -0500
Received: by mail-ed1-f66.google.com with SMTP id l8so18682236edw.1
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 11:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+RYvTrbrY2Vje09F3fIO6N2bOPnlcbiySWaMlI4TgVY=;
        b=Et0gIS+6kh3cXlHyharE8G/Q8C18R1ZOSfRq3PFViIiQkQDxB+mlLMJdXTtdVkwzrz
         Xl8YzA6k2sC7gR1+VoEfBLHGO0Aisd7n5OAyns3BQDB5n8zsovM88sizZrldGmbWmbbW
         /BjojqRp3/emPjlsds+D+WrPQ/x0juqSKguRh/2efIjZcke5sQDD9KPHQVOgk3G+//q9
         MtB8A9/QqYTBpBTklDlgO15UgmG+Aoj8vKF8nbfrVDYvZ05eNa1/14KtbtTZJzSEvVjx
         9gmWmbX1vvn7FJ0AjB9R5n1ryR+ntMliwaPw3CHcQxB3EQEZEFCJwGs1XJeKPzflx43L
         kI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+RYvTrbrY2Vje09F3fIO6N2bOPnlcbiySWaMlI4TgVY=;
        b=gPbJ4hxwVPauMsS78NNI1RmDQh8E9QRbE/RTSPB748n4C6CDYP1YxkDWv1/BXAotGV
         eDesriLHMfx2r5LPLZYF10fmZd9/fhhn3LF9PcIQNHmhIXnffoIezCipYdjOA3zbsEMZ
         dEnThE5pwAs1Fb298Q2qNEUfEyOt7Yh3u1ZAlROQfNgS0PUgh1FEdMz/NxS0lkfscWfS
         PiRPCGuMBg9Rdb39Cs64hibAa+LXwtnQCUjeXgYpdYKjWO938rZC4kJyKvQ5xWi0ZIhE
         rsJUQtd6NmI9lzghCsb1A8zldA25up/5WLjJNmN0H8rJeEeLAmfww+XftQHObhXqerWy
         6WIA==
X-Gm-Message-State: APjAAAUAytv/R01bIE0Qj7foscEbGvSqxxeaAUwTLnuzE2xpZ7sNOYU1
        53aH7oC92913QMMBj1oDzN9hAK9K
X-Google-Smtp-Source: APXvYqyOJmujG93M57pYuEJ199YbuNqq8Pt60vxi3ReKDUpd58caGD3rGNnoQci3NhpG/HEMD64mYw==
X-Received: by 2002:a17:906:bcd5:: with SMTP id lw21mr38351090ejb.144.1577217308955;
        Tue, 24 Dec 2019 11:55:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u21sm2882726edv.43.2019.12.24.11.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 11:55:08 -0800 (PST)
Message-Id: <1df11f0b5105b1f602fdd723e0f74565e436faba.1577217299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
        <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Dec 2019 19:54:54 +0000
Subject: [PATCH v3 10/15] rebase: add an --am option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
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
index f1ace07c38..cf1ac2e359 100644
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
 	How to handle commits that become empty (because they contain a
 	subset of already upstream changes) or start empty.  With drop
@@ -372,7 +379,7 @@ See also INCOMPATIBLE OPTIONS below.
 	Ensure at least <n> lines of surrounding context match before
 	and after each change.  When fewer lines of surrounding
 	context exist they all must match.  By default no context is
-	ever ignored.
+	ever ignored.  Implies --am.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -417,6 +424,7 @@ with `--keep-base` in order to drop those commits from your branch.
 --whitespace=<option>::
 	This flag is passed to the 'git apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
+	Implies --am.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -567,6 +575,7 @@ INCOMPATIBLE OPTIONS
 
 The following options:
 
+ * --am
  * --whitespace
  * -C
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index d2b99e9908..b7915fc0cb 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1361,6 +1361,18 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
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
@@ -1546,6 +1558,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1906,7 +1922,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (isatty(2) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
 
-	if (options.git_am_opts.argc) {
+	if (options.git_am_opts.argc || options.type == REBASE_AM) {
 		/* all am options except -q are compatible only with --am */
 		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
 			if (strcmp(options.git_am_opts.argv[i], "-q"))
-- 
gitgitgadget

