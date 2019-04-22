Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 048FB1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 05:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfDVFHw (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 01:07:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44152 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfDVFHv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 01:07:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id y13so5134745pfm.11
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 22:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=41QDcfV9AIzS7+Sm1DXrVVTEzboK2sceEoUxTAMYkRs=;
        b=ci0JH7M4bWScJQE2oqOfc3ijOSTWIg+JzSl1niLuj7fbFp9CJcPU2c4Yh1DB6juNWI
         J7m6uJPTCB9/C4kcn5zD3KLL1erRYipkMmfGCCwwhXEWt1U7JVk7e6KwRga8nzkkhurR
         CYyDPBINud086gZJkl+OJTSep6jkHvz/lP4qTMoeBDo3ghHedbBymWSAZaMwXy5rs2nk
         jMZZjdWDxLFH7g5yPScla14G5B+uHSJ9An/Og2H0hMUWllTV/+tmFjPjsyN6SjkeQAFL
         C4D7m7t5G59SOnYItVMZSmR7K/UViNBwjSsoyY1tt3+xa8gHBTcVylAW6fo9wGu8vk0k
         77zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=41QDcfV9AIzS7+Sm1DXrVVTEzboK2sceEoUxTAMYkRs=;
        b=lN0bMlGB4RNDJcGGF/EF4nuwpqeFBFNJsK8s7SF54mTecBWZjj0Spoec/wHy36JCf3
         +xkS0mjCw+R/0lWTc3pepLFNtW3fdYY4LRCK7xBaEzF8My7EUhdy0Vej012X/pFqHZSh
         l6i3sC7o2dfldxzVfGQkC8cDzUgxAS5A3jQP28TtN0WS3dikKuyx/z/mqb+eoBrZAcUW
         aarLD9LLy1igECl2ngOaB/LHRxswQijsjHkjiTqY2O8e31euWly6XAQv0rHW0P/K96us
         fxl3eJ3CHmFjE9kaP5m/ljcVMn827G2EExKWuTkhR8jtJRaIuQ7HJf77opP6likO5Sd6
         JF4w==
X-Gm-Message-State: APjAAAVC/vdrNEcfM/ip/2z5CAOD/YX3SwCNN95W7MGHhG6070+ByY4k
        cKNqaeBUy0MYAeSHEbgmzH4ms7T0
X-Google-Smtp-Source: APXvYqz+rpUw5Sw92kEee1GS0CmhETAQnLBjtSmE7fUNyvVTlgT+nJDNX5e3Ab5nep5/SxZIY9i2vQ==
X-Received: by 2002:a62:6985:: with SMTP id e127mr18239166pfc.188.1555909670550;
        Sun, 21 Apr 2019 22:07:50 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id p128sm21728216pfp.30.2019.04.21.22.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 22:07:50 -0700 (PDT)
Date:   Sun, 21 Apr 2019 22:07:48 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH 4/5] difftool: make --gui, --tool and --extcmd exclusive
Message-ID: <c019926b32016369e9f497d8e227107fdf192440.1555880168.git.liu.denton@gmail.com>
References: <cover.1555880168.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555880168.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-difftool, these options specify which tool to ultimately run. As
a result, they are logically conflicting. Explicitly disallow these
options from being used together.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/difftool.c  | 11 ++++++++++-
 t/t7800-difftool.sh |  8 ++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index a3ea60ea71..5ad39c9172 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -690,7 +690,7 @@ static int run_file_diff(int prompt, const char *prefix,
 int cmd_difftool(int argc, const char **argv, const char *prefix)
 {
 	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
-	    tool_help = 0;
+	    tool_help = 0, count = 0;
 	static char *difftool_cmd = NULL, *extcmd = NULL;
 	struct option builtin_difftool_options[] = {
 		OPT_BOOL('g', "gui", &use_gui_tool,
@@ -731,6 +731,15 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
 	setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
 
+	if (use_gui_tool)
+		count++;
+	if (difftool_cmd)
+		count++;
+	if (extcmd)
+		count++;
+	if (count > 1)
+		die(_("--gui, --tool and --extcmd are exclusive"));
+
 	if (use_gui_tool && diff_gui_tool && *diff_gui_tool)
 		setenv("GIT_DIFF_TOOL", diff_gui_tool, 1);
 	else if (difftool_cmd) {
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index bb9a7f4ff9..107f31213d 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -705,4 +705,12 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 	test_cmp expect actual
 '
 
+test_expect_success 'difftool --gui, --tool and --extcmd are exclusive' '
+	difftool_test_setup &&
+	test_must_fail git difftool --gui --tool=test-tool &&
+	test_must_fail git difftool --gui --extcmd=cat &&
+	test_must_fail git difftool --tool=test-tool --extcmd=cat &&
+	test_must_fail git difftool --gui --tool=test-tool --extcmd=cat
+'
+
 test_done
-- 
2.21.0.967.gf85e14fd49

