Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49A381F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 05:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfDVFH5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 01:07:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34346 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfDVFHy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 01:07:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so5271421plt.1
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 22:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0KTpRHTjr7oYFFL0SWVcKqRFgrLeuwKMknb41hpuZqQ=;
        b=PM5KUcIqWShRc9lvmd4BPfP7iBHHUB2VIMnx2XjswuazVWqHfkhDEqt2hrkz00Ym0g
         QQl9GT1j0ikFWghuhaM4ny/L5rKxEjwl2KF0Hxk4SVqCAKNE0ARUPPwgOgIZYCQjRBxi
         5e3e3IW2j5UGZd46PF4Y+0BMRtaGSpSZQpoLGsT2P/YiGM8jmciuPYjvWpSCRbqebzX0
         4+9VIQAK4cqKKkqSuhnht8bxbOUDriDCCAnXkZLTDp5LH98btcefwl33O5h5ZLNQ+vS/
         Mpuha2iT/A8CWDuLn0lHO/C4StxCmC7nZhWuHo2prAoyF9ozPzY/slBM2zoYEuj+Ppbo
         /yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0KTpRHTjr7oYFFL0SWVcKqRFgrLeuwKMknb41hpuZqQ=;
        b=Jgtfc3kmJs5r0I86JbS/Nea7Fe6Spx+4hySHqpl1BnrVBOPDlPgZSyZ53Bj836uVxZ
         r4VWJ/2DvrczMDTHQ5GMG3z4m+9gfNSC4G+sMa+UGEZNT2zkOgjOqCoL7Fhjm1/oZO5K
         ta7/ZmFVGWPZgCDJy1GGZ9lZa8RB7ISRncLOgAXz86UT7JlqHTemMXtrVCQBGKAbEJdV
         iouiFHfwyiittV8UTKvSxl5ebs2TqXsZPzHYaZxFJLvEWeLyiei5l2xRh2mLhoSqw8J1
         VXuyvlprpenZUmuTEdKyFY6HqXWiu4jLocTr9H/Fy03npDm30TEzr5jZWKtRUOpF3cBn
         gCag==
X-Gm-Message-State: APjAAAVTs8OtoXYkx5Uhvnn4j7f6wbRtIcSouvzAEkjdAHoz11Vx+CFr
        SA8QeVkGY1ocTVRV4PTw5V1Hwv75
X-Google-Smtp-Source: APXvYqwUKy5G4UDABtg0UeDLI0JWAhsBGUuN6xLMlcW7Vin2oMkWuEg2cEqiwZDwslZq+4y/42iW2w==
X-Received: by 2002:a17:902:6bc2:: with SMTP id m2mr18236825plt.194.1555909673032;
        Sun, 21 Apr 2019 22:07:53 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id b16sm16013449pfo.168.2019.04.21.22.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 22:07:52 -0700 (PDT)
Date:   Sun, 21 Apr 2019 22:07:50 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH 5/5] difftool: fallback on merge.guitool
Message-ID: <fb7ac11439cbfd52d9181b78fdc8f8034a6b1064.1555880168.git.liu.denton@gmail.com>
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

In git-difftool.txt, it says

	'git difftool' falls back to 'git mergetool' config variables when the
	difftool equivalents have not been defined.

However, when `diff.guitool` is missing, it doesn't fallback to
anything. Make git-difftool fallback to `merge.guitool` when `diff.guitool` is
missing.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-difftool.txt |  4 +++-
 builtin/difftool.c             | 10 ++--------
 t/t7800-difftool.sh            | 16 ++++++++++++++++
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 96c26e6aa8..484c485fd0 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -90,7 +90,9 @@ instead.  `--no-symlinks` is the default on Windows.
 	When 'git-difftool' is invoked with the `-g` or `--gui` option
 	the default diff tool will be read from the configured
 	`diff.guitool` variable instead of `diff.tool`. The `--no-gui`
-	option can be used to override this setting.
+	option can be used to override this setting. If `diff.guitool`
+	is not set, we will fallback in the order of `merge.guitool`,
+	`diff.tool`, `merge.tool` until a tool is found.
 
 --[no-]trust-exit-code::
 	'git-difftool' invokes a diff tool individually on each file.
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 5ad39c9172..67f26502c5 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -24,7 +24,6 @@
 #include "object-store.h"
 #include "dir.h"
 
-static char *diff_gui_tool;
 static int trust_exit_code;
 
 static const char *const builtin_difftool_usage[] = {
@@ -34,11 +33,6 @@ static const char *const builtin_difftool_usage[] = {
 
 static int difftool_config(const char *var, const char *value, void *cb)
 {
-	if (!strcmp(var, "diff.guitool")) {
-		diff_gui_tool = xstrdup(value);
-		return 0;
-	}
-
 	if (!strcmp(var, "difftool.trustexitcode")) {
 		trust_exit_code = git_config_bool(var, value);
 		return 0;
@@ -740,8 +734,8 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	if (count > 1)
 		die(_("--gui, --tool and --extcmd are exclusive"));
 
-	if (use_gui_tool && diff_gui_tool && *diff_gui_tool)
-		setenv("GIT_DIFF_TOOL", diff_gui_tool, 1);
+	if (use_gui_tool)
+		setenv("GIT_MERGETOOL_GUI", "true", 1);
 	else if (difftool_cmd) {
 		if (*difftool_cmd)
 			setenv("GIT_DIFF_TOOL", difftool_cmd, 1);
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 107f31213d..ae90701a12 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -279,11 +279,27 @@ test_expect_success 'difftool + mergetool config variables' '
 	echo branch >expect &&
 	git difftool --no-prompt branch >actual &&
 	test_cmp expect actual &&
+	git difftool --gui --no-prompt branch >actual &&
+	test_cmp expect actual &&
 
 	# set merge.tool to something bogus, diff.tool to test-tool
 	test_config merge.tool bogus-tool &&
 	test_config diff.tool test-tool &&
 	git difftool --no-prompt branch >actual &&
+	test_cmp expect actual &&
+	git difftool --gui --no-prompt branch >actual &&
+	test_cmp expect actual &&
+
+	# set merge.tool, diff.tool to something bogus, merge.guitool to test-tool
+	test_config diff.tool bogus-tool &&
+	test_config merge.guitool test-tool &&
+	git difftool --gui --no-prompt branch >actual &&
+	test_cmp expect actual &&
+
+	# set merge.tool, diff.tool, merge.guitool to something bogus, diff.guitool to test-tool
+	test_config merge.guitool bogus-tool &&
+	test_config diff.guitool test-tool &&
+	git difftool --gui --no-prompt branch >actual &&
 	test_cmp expect actual
 '
 
-- 
2.21.0.967.gf85e14fd49

