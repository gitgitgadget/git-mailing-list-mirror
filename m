Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF8311F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfDYJyt (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:54:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37747 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfDYJys (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:54:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id g3so743344pfi.4
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n09q9uk++BnQGLaO7ISBMXJQYpqeJfefi3fy5n5GfUI=;
        b=WIuzBHQXZMOEM+qpSWcZbp+xBDmJEJUUbVL1v6GBoKEZDQQteno/YNWwkIFMm7kA/o
         e8nEfTMlbf7im+yy+KiXrgrF8hMMMvUSpGaTkcRkBcleLE/jC/4T2M2vBB7yRC/4MxVd
         DANK6jF4qzRkUZVRgWri0JkQoBvPL/oFBlYnRlB73f+ZtOXhDyokzv40z6uMwDFxNZeD
         Div3Vs53fKGHyLRaXooW6Dga41sQ3i+6IWj7aidcZB6ORTg/LCqHUz/651tMcr/3FPg7
         Lw5BMXGZ4cQETS/8S1+CZsUZT7WQb54pw7DDdxZcBzO5/ucZkA2jGUpWopStROurLVfs
         rwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n09q9uk++BnQGLaO7ISBMXJQYpqeJfefi3fy5n5GfUI=;
        b=Y86VT0Nkw4R5ZV+IXa9lUBo1N8dMwLQSdCEGXv5StUlhTf9hdkxiYmmsO1wrU5QwFL
         FMWF94DrdBclwYzhZo889jba0Mk1OZ50GmHnW6nDpTP7yW27v+eXDRzEeKRtPJTE0g/r
         L6Ag4zUy5aXZypBMTD+L86C4JSVRlDtDPP/+URZC0c+RRxBwkYs/7xh1hiIdE6MLgPWw
         ZIrS8M3illdKoR96SLz3iTAS9RKSww6/hnpMXzvHt2LWFaQ5rA1m1r/aW0XkiLiueP8C
         XkR74mKClv+Wls24KAcGPaIClwJUJg6tK4JfqwqaB9C1TS3DMDcjhLgbMw7OngZ12msu
         NgcA==
X-Gm-Message-State: APjAAAWGGCOnJD7e1z+ZH8C52b02VsqwapiFi9vdHXm2jYMUDMUzEBzk
        yjh4AfdbdgNRjbYICzcjYEP1Xrl2
X-Google-Smtp-Source: APXvYqwWkh1wmJHMUrg+Jbx0LiSI/a3neXt/mjZZnHZAFSVV/DQksOd44k0bQi7chex6iSRBHlNG/w==
X-Received: by 2002:aa7:8083:: with SMTP id v3mr40253322pff.135.1556186087227;
        Thu, 25 Apr 2019 02:54:47 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id r145sm46805536pgr.84.2019.04.25.02.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 02:54:46 -0700 (PDT)
Date:   Thu, 25 Apr 2019 02:54:44 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 5/6] difftool: make --gui, --tool and --extcmd mutually
 exclusive
Message-ID: <7d7c936cd3dabe95c2b26d46c5b5bb980c26586b.1556185345.git.liu.denton@gmail.com>
References: <cover.1556185345.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556185345.git.liu.denton@gmail.com>
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
 builtin/difftool.c  | 3 +++
 t/t7800-difftool.sh | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index a3ea60ea71..65bba90338 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -731,6 +731,9 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
 	setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
 
+	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
+		die(_("--gui, --tool and --extcmd are mutually exclusive"));
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
2.21.0.1000.g11cd861522

