Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C23861F453
	for <e@80x24.org>; Mon, 29 Apr 2019 06:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfD2GVV (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 02:21:21 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40844 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfD2GVV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 02:21:21 -0400
Received: by mail-it1-f195.google.com with SMTP id k64so7164411itb.5
        for <git@vger.kernel.org>; Sun, 28 Apr 2019 23:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BaCYuxcCXPHPmO0EVxeDjh/HLg67x/u8MboMobGV+kA=;
        b=GAngeAVv/9rTvpM/HMQfNBhq1DYsKP5Oy0MS+SJbVHza2mBRHeQCPnO99pOfOX4qPr
         Ea7KlpXmG2iv22F1QkLrrNSAt7MwV6ZzQDN41+BYblbtvPICeCOxX4wOBvrPWnvjZyvK
         ygPR0UIS4MR0B/hR3/ZySI4up3XEFEKlWPXYGvqVDPpaWqB7ZiL8Df5Sr17bPsRpW+RF
         hyWKjHWLdCaRLO0FaQGpmN1tZwhEY9sXcMSwbeeXsRW/QClM6laVrlgixo96tb/NHXfm
         7rc6mT9oln515BKN7md1NDW4Lp2zxZcIZXHIR2kwXijd0F7atdeyqQWEyJEJRS1cgG9x
         Q3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BaCYuxcCXPHPmO0EVxeDjh/HLg67x/u8MboMobGV+kA=;
        b=J+rqrqpk8RePRBSTdt0A3Vffd+He3YDt6HMZuJjQ1RWE+KLx/yGO3+/mKT3aNjvcdy
         0q+VjpoPpbpBmwwxJGAFuYKwN4HNwP3zT5VpMfdIKcmw4dNPH/5d06nBRfBOUpXGzjo0
         adga3a3R4rGk1HM+WjHf7dVqnn/A7azWhiCJ8mm8OZIyIxdUGihq+aJjYu3ZUrPVnUiG
         dncyrQifTeR7yac4/frK+pAoaAJ3TLZq2pTHtuqR7quUZlcG5btP/YUcpBnau71SVJHP
         68mgbnm6NQhvPlkogz/d5vHfAP4TWKrLMjrJZe8/VIetKVCjMHyoAsdipSnYXpUTSBqe
         5LNQ==
X-Gm-Message-State: APjAAAUSJIpxmmR4W6FZbGmYqF41nbN0ITWP+9Qstg9tiVfrY79ToZMB
        ZuMei5IkIm6p2Gy3ZAnoh07pAVvz
X-Google-Smtp-Source: APXvYqw6grslJSNN1LrwnbEL2HAhoSZ0u78J4ScgXdxcH3NQcrL2XK04IMXLL7vowPkY63pd6pF+Ow==
X-Received: by 2002:a24:2458:: with SMTP id f85mr17151363ita.83.1556518880372;
        Sun, 28 Apr 2019 23:21:20 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id f14sm12139272ion.46.2019.04.28.23.21.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Apr 2019 23:21:19 -0700 (PDT)
Date:   Mon, 29 Apr 2019 02:21:17 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 6/7] difftool: make --gui, --tool and --extcmd mutually
 exclusive
Message-ID: <c70789b689937f31bcde333f3d7cbe9099e53a0e.1556518203.git.liu.denton@gmail.com>
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
index bb9a7f4ff9..fd4a2a93b6 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -705,4 +705,12 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 	test_cmp expect actual
 '
 
+test_expect_success 'difftool --gui, --tool and --extcmd are mutually exclusive' '
+	difftool_test_setup &&
+	test_must_fail git difftool --gui --tool=test-tool &&
+	test_must_fail git difftool --gui --extcmd=cat &&
+	test_must_fail git difftool --tool=test-tool --extcmd=cat &&
+	test_must_fail git difftool --gui --tool=test-tool --extcmd=cat
+'
+
 test_done
-- 
2.21.0.1033.g0e8cc1100c

