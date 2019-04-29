Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9967F1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 06:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfD2GVY (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 02:21:24 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39561 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfD2GVY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 02:21:24 -0400
Received: by mail-it1-f193.google.com with SMTP id t200so1943856itf.4
        for <git@vger.kernel.org>; Sun, 28 Apr 2019 23:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iukTblG9BC3DzjM64TMQuw/otThZp2vhxk5xe/+N/5U=;
        b=vVo9UXivlMnCBUy1c6Q904lvDxTtRyDcble3TZWZ+KKdRD43ta/DEd2ejpN9XsY8Vt
         uG1bZHmvtMDH+swQFugXRMD9Mulala6rSPZMbL5gzydC0Eo9wS6Rzvlk/KHWiHs4Cnti
         XBqaNpgyWQULy2f1FW4kGFwuU86xWaWjKBf9qk1WMVuGp/R3NgrvqmtsFwYsRuECW8N9
         AbYlfLND14WNy/r3CJGTlj4S2TzCqMQfsWMEkZlTiwhiSLioCwgyYRY6/tzklSWCH14P
         Ta64n0pVSKKnv55EGbzTUVDclzazunlPRkss80n2UMwpxF/C/Kb1Z2r0UKG3WX5dnZwr
         3b6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iukTblG9BC3DzjM64TMQuw/otThZp2vhxk5xe/+N/5U=;
        b=Y40x9SWpkJ68Q9E/bv9F4iFZyZ53RdQ5OhRPVw/WgkTXJrZwXhvLf5E04bHy59bt/P
         2dN0/cP++tPC5gV19vI90y7/lIMg+BI9sB2P21oUFKdVpCWehyf5Rx9ifuuQFz4jLI4T
         aRaFZBSmQgspnVNiUYzqsuscos5rl6reiZGdz0tCtHS9z6PzWkTpBMF/QTmV9ZHW4NBI
         H5vEYjyOic29yyaav/LmxhrZ90S++vOUlmQY9Xk6Bji0qz6aRQnigd9Mwz7sygQE7lyZ
         l/QBdqVxSZxA+ZwXAd8Ksk9YGQToDbuXZqzbokG2ha6BCveub0s/Hpu6SmMUEb2ZimPQ
         h4cQ==
X-Gm-Message-State: APjAAAW4QFJFRflS4RzIGDx6imewe26s/2Hlkq9mgbjudCcPuhG3/h0t
        9z4VvnyOal9//y5HAyb549utDIRO
X-Google-Smtp-Source: APXvYqwrL3PvjnR59RF/tMYLA4/Hkhi0ymb52w9qTIbkVByy99wOVyBOOaZZKUMPWiAd6Pvhz+A9uA==
X-Received: by 2002:a24:d941:: with SMTP id p62mr16644404itg.174.1556518883423;
        Sun, 28 Apr 2019 23:21:23 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id v7sm8142749iop.8.2019.04.28.23.21.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Apr 2019 23:21:22 -0700 (PDT)
Date:   Mon, 29 Apr 2019 02:21:20 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 7/7] difftool: fallback on merge.guitool
Message-ID: <3fd4f46a7cd8fce71b246a60825b04c69bc1b537.1556518203.git.liu.denton@gmail.com>
References: <cover.1556185345.git.liu.denton@gmail.com>
 <cover.1556518203.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556518203.git.liu.denton@gmail.com>
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
index fd4a2a93b6..957ddf5dc6 100755
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
2.21.0.1033.g0e8cc1100c

