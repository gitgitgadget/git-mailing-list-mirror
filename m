Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0261B1F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 08:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfDWIyM (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 04:54:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36952 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWIyM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 04:54:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so7265264pgc.4
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 01:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YZgysgXEhpqkUO8cf301jh4x0JoX/GnOM6QKUIXwyDo=;
        b=gKPWbbmVLRyeK8FnH45uH8qxJORMZ1GKMaqViuDgOsEvaE2AUzrtqW8XYEFPey35nB
         y1WveefYh5yd0Q1H41m0UEzEjwngDUDEZZl/p5NYT48+BoiqO7WDRMwG0Dwg2LpKhADN
         fgkudxQ3qOUNwDZLsLQRDztq9c7X93VfBn9QnvpVf/7Zo/V2WDEXUksxLFFtGsfUUCvD
         +xknqhFWmBOLw3zL4P8m9vIZ4CE4fDgC3K3IOXxw4K5ifPTRMCG9Q5jBzelbS8r7yAtV
         nKbDDBLWfPs907PypG8eInijKf5PYmN5IaETcjz/MrBNLyYf4ry/QtjBHZUgkUVTG+Z7
         AkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YZgysgXEhpqkUO8cf301jh4x0JoX/GnOM6QKUIXwyDo=;
        b=pzjO8snqGEFMLZcPLLsDVrTe6Y8OKsW6XJBQ0iSpxybPLbazBkHhtWInE/tjWzRoKP
         IArpnDVJIReaA2drFNF0BdzTRSqUVCq9zAD4CpJ4k4ykL9oTrsJ+IMoQw+bUA8UzrJzo
         mkYlBs7Y2zG7s1a6V0GuE0Kd7f3t3OyQR8ZjdqLB7GkkybSe3Y+i2DTKMw/C/OZjUEgV
         Ci4ivENfh2/wc+lf+5xJMdX1mwbsV5F0MjKA4O2LPnUul2AxmMucYFgWiqwdZuwM9MCH
         oTwsm/fRpIh6pnY1VOqRG3UXNPt6puQ4DTH/dp4/N0dZzoRj4CgBIxnEfNBIzLmst+Mn
         7ZYQ==
X-Gm-Message-State: APjAAAWiJNIEXVGsMLqbBm8N0Zq28dtgdwQQuEwnLd6V1lq7qoqwIvFI
        EyTzLyvbsyxuy2M2gQftHajIj1tM
X-Google-Smtp-Source: APXvYqxXUS6fPDik2jbdXsJYR84QuELj41eOn/tFWFORVV8VCdgx6eACJ8ymEeRE/xoWYdMqbTE/RA==
X-Received: by 2002:a63:f115:: with SMTP id f21mr23313807pgi.65.1556009651669;
        Tue, 23 Apr 2019 01:54:11 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id s79sm27477370pfa.31.2019.04.23.01.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 01:54:10 -0700 (PDT)
Date:   Tue, 23 Apr 2019 01:54:09 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/5] difftool: fallback on merge.guitool
Message-ID: <5a24772219f405c93a54310d3e81a7c0e71c350e.1556009181.git.liu.denton@gmail.com>
References: <cover.1555880168.git.liu.denton@gmail.com>
 <cover.1556009181.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556009181.git.liu.denton@gmail.com>
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
index 65bba90338..10660639c0 100644
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
@@ -734,8 +728,8 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
 		die(_("--gui, --tool and --extcmd are mutually exclusive"));
 
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
2.21.0.1000.g11cd861522

