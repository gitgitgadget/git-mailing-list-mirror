Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FF9A1F45F
	for <e@80x24.org>; Wed,  8 May 2019 21:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfEHVwp (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 17:52:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43379 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbfEHVwn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 17:52:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id w33so169035edb.10
        for <git@vger.kernel.org>; Wed, 08 May 2019 14:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Tu2KeUxgY576gkfhH99kk1/g+nBv0r1E0vIo+/95qvE=;
        b=C32MVFXlqmbq/xNfQ0xS24gYh/iU2LakC/0Hlg84HqoXMzcwr1IJrNSUHP7snGu5/W
         6609u0gdGhb9JZirr4q5bAMsJfWqXERnKrB3AtfcxJ1q1eY/pH2pDgz+j+vPsCvT8bd4
         JKakTp+dIWaYRNWFJZ/nBdm+dnwLNEm7TLIuQL1+3a9kdITWXnKxQX0NYrR7C51Eo9e+
         6xj7mSU8NdAuvQLtx7vvBQvNxlazkREBH1Lz6TC/d95wk00jIf4+RNj7AmTT5PVHiiLv
         gnhkFwPk2tsTLDNHM5WyMYvRk40IMp1uuAgzRoYd/Guf3xyXASSQb8jY1XHa3ehK0clF
         SA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Tu2KeUxgY576gkfhH99kk1/g+nBv0r1E0vIo+/95qvE=;
        b=eoBOgYOttbrLAbp3ucqCYJn5BqHLkCMTdBHkvEi54UBCviq01Yj06gFfjbzmljyTy1
         nm+g+Q28vT/77ERxL5GQbuqJtvpyiz69BbZhLUzk6vFBLQYuvbSobPS0aRU4Ms6UPLhO
         2yuyolDHlyljph2lo16xFYZVKYSsWlrvZm1vi59/awsjiZIWa6COnNY771sVwQqCKECA
         qYnbt8A6i9EJEw20YUUCylLtnga+NJW1liWZjxfD7tKH3VFwOAYXKyKeHInjYP28adhX
         nsiLUS+YmMbwEZgpIoX0lcHJ4LR3xlQX3a7V+kwwqNrC1KNVvJmeUIHr+h3Y6TMB4QlQ
         Hunw==
X-Gm-Message-State: APjAAAVrjwXCj06Y/Sw2i3QrEa6xUnOTzUM2ve5P0gRj/GmTPQ+NA6FK
        i0u/xkQNrTgnkhgI3//dhh5ajqOnQK4=
X-Google-Smtp-Source: APXvYqwRcyKsoFz8VUx8aS+tUBwQDKqQR4sTWSzvwN1dICKor8c6rGOFbASpjIjFRTe9yh7WDo3yFA==
X-Received: by 2002:a50:94a1:: with SMTP id s30mr94948eda.4.1557352361696;
        Wed, 08 May 2019 14:52:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k37sm55522edb.11.2019.05.08.14.52.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 14:52:41 -0700 (PDT)
Date:   Wed, 08 May 2019 14:52:41 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 21:52:39 GMT
Message-Id: <9f2ee5ef0b84b348d07fedc47fced8d4772a9c43.1557352359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.186.git.gitgitgadget@gmail.com>
References: <pull.186.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] difftool --no-index: error out on --dir-diff (and don't
 crash)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In `--no-index` mode, we now no longer require a worktree nor a
repository. But some code paths in `difftool` expect those to be
present.

The most notable such code path is the `--dir-diff` one: we use the
existing checkout machinery to copy the files, and that machinery looks
up replacement refs, looks at alternate ODBs, wants to use the worktree
path, etc.

Rather than running into segmentation faults, let's die with an
informative error message.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/difftool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 4fff1e83f9..5704a76088 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -735,7 +735,8 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 		setup_work_tree();
 		setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
 		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
-	}
+	} else if (dir_diff)
+		die(_("--dir-diff is incompatible with --no-index"));
 
 	if (use_gui_tool && diff_gui_tool && *diff_gui_tool)
 		setenv("GIT_DIFF_TOOL", diff_gui_tool, 1);
-- 
gitgitgadget
