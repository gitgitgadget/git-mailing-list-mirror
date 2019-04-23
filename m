Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 718BE1F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 08:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfDWIyK (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 04:54:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41017 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWIyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 04:54:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so7126265pfd.8
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 01:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n09q9uk++BnQGLaO7ISBMXJQYpqeJfefi3fy5n5GfUI=;
        b=pjcS+rqPQdBORUYqZy73YiMGscqlYamdNvzVavZ8/oloHXfEoBQPFdpFnrtTbPWU2e
         fPNHn2zif5RiDUCiobhyDhfywjywFf5ioaW5AQ0avfniq7fC9IyBWy5fkdhyw+SmCXAu
         yqJmNCgclZfFt9vEWlVGj4uNsOnMGVJTmEVCXycmWZaw9uOiOhZhqKguY2jVNsmHfvex
         5ETo+pvq6CywxABPbbOfLbQBdY8lI3uqRYrw/qti76q6z0R8sn2BUVYSwkeHPKnW3lED
         21nH/nd8AWXLOT2Tj+7u+dC8kgf2LOV/qU63MktbdkmoqKbfgKu/vWA85MHFqEubkfCy
         3TiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n09q9uk++BnQGLaO7ISBMXJQYpqeJfefi3fy5n5GfUI=;
        b=dBbfpRQiSMsCniI3JjRwOjRxXFY5Xk+mLyJAO3eh2dG7R/OkCxs7QJfdgBO7ewj7X8
         U+pClFYmFuvxgc57VlZQCxFh3Omil6RUHt43unMvI5hx6v28cSsEEiRvgRPdkuScw+ng
         E8v1jVUklOsfuSI2BHPj5Uk9AIqYt/UiQXiN4tgzvmo0BSiQjN8vVnACpuw4u7gxNvb4
         B6aBKOERtZYxCfLZ/s7HD6bIBq8Yi+CK0ndg0qQkb6/+SozlsU0SBq2JydESGxY4Ej4E
         HBFk7+qZy23Q3H51FPWAa/6aPzO927CnCrgBKtl6XT6jyFaS9jTu0q/TMH/kh1gnvCxS
         o4Sg==
X-Gm-Message-State: APjAAAXi7U9TmRm1Ocpo4Zh+kIaiDi41I5el5xyYRvb32mSYelYbJwtE
        LRgqPai6kf6tVkLnX/9VGKrFtYFR
X-Google-Smtp-Source: APXvYqwwjZ4M2KecKlASXM+QgL5QNaBVn2vOZs/IYaUnTLgQwe6LQd6xnof24QN/LQAPa0X2gzv+bw==
X-Received: by 2002:a63:1055:: with SMTP id 21mr4848928pgq.200.1556009649012;
        Tue, 23 Apr 2019 01:54:09 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id w3sm28344296pfn.179.2019.04.23.01.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 01:54:08 -0700 (PDT)
Date:   Tue, 23 Apr 2019 01:54:06 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/5] difftool: make --gui, --tool and --extcmd mutually
 exclusive
Message-ID: <6f65b5c9134639eabd1abaf32af95c228a58e465.1556009181.git.liu.denton@gmail.com>
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

