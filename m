Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C1AC2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 10:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A8A20771
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 10:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYAYMI6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgDIKVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 06:21:51 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45827 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIKVv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 06:21:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id m12so12601678edl.12
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 03:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=M/y+b26u2VRbQwNX86hhYErpQNpUW24sR5G1nKgU9Do=;
        b=QYAYMI6alrWZZjyXY4LNtLOKsrHa4Kljj0XXY9BLo4CNZhS7TZOLQezIKABRVOQEYU
         YtDWuvGEFY+fSwQni0wiZX945U0EyY1yOgOuVRbReFfMEsbT1LgDI7VUySCIZfEg4wPS
         Bwl464nEabYwPQV5yW4AzdZfb0mv2s4HTbQ+KlDfOqOe564XPoIyPn5X05ItmUL5psBS
         IH5nAoAV61yIUCJ6NVDU56nOcHVyrzXMJjfyLV0ggolxbo9ewzRrLkchr8vmAOGSDvB9
         QpuyTg7Yl43IQGzx2xYrlCWnlgPGM+EPadZYOr6Lg0Uam+otn+coVaOhaf+mQZlUouNv
         DmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M/y+b26u2VRbQwNX86hhYErpQNpUW24sR5G1nKgU9Do=;
        b=feWwmzga/YmMJQXKPWHnLZwHbW730I/oMPlpEcZb1Fa+0Ob32o7SYyPzZpa6fCf0SD
         QN82BWWHs9JkmYHjyqalzXQvKYweVpchTavjFYiaKtPZlmRN3RZiozlQcqi19AMGOHSi
         XYLXlJsxI+V0slLFwSj5oARseMdBujcF2idrjYBAwR4rE1TaVdCQC5dXNts5CFUNK4UF
         RNfJoT/gGyhJXTgvsMIOoZNSvSjBs2wlxPYhCIyumIqoihRrHoeaO0XcfBgtzQk97CYv
         WDEwf8yN1kvCE+t3C7B8cFslms5o6V5Is12wWO1NMvr5xY4QyA0xuaNNhi7wrum1Am23
         ngdQ==
X-Gm-Message-State: AGi0PubierKqpPHqBZyjvzftIC0Q4R+Lyd1n2NYAZjUMbU/sci/FJ7XQ
        C2mDsby/4m57fthvkXNjRtHn/Ipy
X-Google-Smtp-Source: APiQypJrjpsCSFXJ5rteZXtawgWdY1x0UXl6XWpe9Yyo4lFLi6qurcB9goXtBMNNEgz5l6Sro9rOIg==
X-Received: by 2002:a17:906:2b93:: with SMTP id m19mr10351838ejg.98.1586427708940;
        Thu, 09 Apr 2020 03:21:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s16sm3711212ejd.67.2020.04.09.03.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 03:21:48 -0700 (PDT)
Message-Id: <pull.604.git.1586427707655.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Apr 2020 10:21:47 +0000
Subject: [PATCH] mingw: help debugging by optionally executing bash with
 strace
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

MSYS2's strace facility is very useful for debugging... With this patch,
the bash will be executed through strace if the environment variable
GIT_STRACE_COMMANDS is set, which comes in real handy when investigating
issues in the test suite.

Also support passing a path to a log file via GIT_STRACE_COMMANDS to
force Git to call strace.exe with the `-o <path>` argument, i.e. to log
into a file rather than print the log directly.

That comes in handy when the output would otherwise misinterpreted by a
calling process as part of Git's output.

Note: the values "1", "yes" or "true" are *not* specifying paths, but
tell Git to let strace.exe log directly to the console.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    mingw: help debugging by optionally executing bash with MSYS2's strace
    
    This is another patch that has been carried in Git for Windows for some
    five years. Time to graduate.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-604%2Fdscho%2Fmsys2-strace-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-604/dscho/msys2-strace-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/604

 compat/mingw.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index d14065d60ec..60c0d36764b 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1479,6 +1479,7 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 	const char *(*quote_arg)(const char *arg) =
 		is_msys2_sh(cmd ? cmd : *argv) ?
 		quote_arg_msys2 : quote_arg_msvc;
+	const char *strace_env;
 
 	/* Make sure to override previous errors, if any */
 	errno = 0;
@@ -1562,6 +1563,31 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 			free(quoted);
 	}
 
+	strace_env = getenv("GIT_STRACE_COMMANDS");
+	if (strace_env) {
+		char *p = path_lookup("strace.exe", 1);
+		if (!p)
+			return error("strace not found!");
+		if (xutftowcs_path(wcmd, p) < 0) {
+			free(p);
+			return -1;
+		}
+		free(p);
+		if (!strcmp("1", strace_env) ||
+		    !strcasecmp("yes", strace_env) ||
+		    !strcasecmp("true", strace_env))
+			strbuf_insert(&args, 0, "strace ", 7);
+		else {
+			const char *quoted = quote_arg(strace_env);
+			struct strbuf buf = STRBUF_INIT;
+			strbuf_addf(&buf, "strace -o %s ", quoted);
+			if (quoted != strace_env)
+				free((char *)quoted);
+			strbuf_insert(&args, 0, buf.buf, buf.len);
+			strbuf_release(&buf);
+		}
+	}
+
 	ALLOC_ARRAY(wargs, st_add(st_mult(2, args.len), 1));
 	xutftowcs(wargs, args.buf, 2 * args.len + 1);
 	strbuf_release(&args);

base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
-- 
gitgitgadget
