Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D7EA1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 22:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfDXWrI (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 18:47:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41153 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfDXWrH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 18:47:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so10110246pgs.8
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 15:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sw448NwAPnuHRAOZn8IVLJkytIV16ZWjwj1QCC6oBng=;
        b=uBFGGac6IZZxpeiZaNAX59rdH5KXpJ7w6xnKvKWdg0ryasIsHjaKoqKvtVD6ijj0lf
         T4Gb6BE8vbEW8HroHR+c3vntpFmZwQzMjWTmAS1P3ErTkUGCzFagSueaHyn6/JYVA1qO
         15FvhN7b0EepmUBLPUgSjo85xIs+4C3TQlw4Nz9nZeGiqs+ZkkRaQMtTDRUoB/NNUrwV
         +uDuLeT9vND6eVN8KAuOaSas0MmVlFISMqhP2nncmvBkS6SrI9AMDcV1iCBeM0a04Us9
         4wXajzjeWcEzn0hJ/cOdzMvpZS7BACgHTAesWVCqwhw9z2WrWjt23nx69KNX/50GV3K7
         nkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sw448NwAPnuHRAOZn8IVLJkytIV16ZWjwj1QCC6oBng=;
        b=ahcPQwhTB2T7sksuKr5c1bhPQuA/FkY7AGkXWgZizZLAjTdpQUHwe+wIM3pNiQLHGc
         W6OiW4ISztwYuFK7aexGwun43UQcaHD3BLQSshF0fyP/omlu5WPAHR3UIHxh4A8Ad7Xg
         RzOWOMHXfuG/tv5OTLWIPMlPSkqoweTp9gqqxXynArAzg64amCnCXF5CDwRfRj4t9uj7
         b7ShXOo/ZU84WxvTuqW2qu9vxlFPpaZsDuDe8gnXJ7Fm3+nfnfLcCehNBt3aNPOBHSr3
         c/O13O5fB2zpn60ttIqEaIXotSGOdOpUapU6xdsZODzOcFkE0w/liVGtgr8N3klIXXKD
         BOBg==
X-Gm-Message-State: APjAAAWITdaWCEiFvOtBS12Aq33pcicv29b3x4Y5Tp3nNN1x7za1S5yi
        NjRQCdHyVDedz/KsEuYC2QzEDn7Z
X-Google-Smtp-Source: APXvYqwXa1wc2SF0E7ExABgcam9X3U8AYJaeRE2Bx1hw1MCmymXAGbMtnW2QWztzvkvF/R3YT++6xA==
X-Received: by 2002:a65:6107:: with SMTP id z7mr32957163pgu.313.1556146026036;
        Wed, 24 Apr 2019 15:47:06 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id g64sm38062305pfg.13.2019.04.24.15.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:47:05 -0700 (PDT)
Date:   Wed, 24 Apr 2019 15:47:04 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/6] difftool: fallback on merge.guitool
Message-ID: <f39b15efbd5c765953737f99aa032230f066c074.1556142510.git.liu.denton@gmail.com>
References: <cover.1556009181.git.liu.denton@gmail.com>
 <cover.1556142510.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556142510.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
2.21.0.1000.g7817e26e80

