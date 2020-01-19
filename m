Return-Path: <SRS0=wBnH=3I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A77FC33CAF
	for <git@archiver.kernel.org>; Sun, 19 Jan 2020 22:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB73820678
	for <git@archiver.kernel.org>; Sun, 19 Jan 2020 22:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqixE0Zh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgASWxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jan 2020 17:53:36 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:35694 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbgASWxg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jan 2020 17:53:36 -0500
Received: by mail-wr1-f53.google.com with SMTP id g17so27655636wro.2
        for <git@vger.kernel.org>; Sun, 19 Jan 2020 14:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=jR94/OWYPUCThNo3Ex9wlOGd2y/WQZQdNzrY1rIpR+U=;
        b=dqixE0Zhga/jUfBV9+8RsAP2Zs7hLp34e/q+pHlwL95k825HxbZGmp0dcxm/QhiDri
         u5s5MD1D8d4VJh2EhJwt6MkppTF8sSqbkON40UX6TjroKxKio3vDZo7fhZDBzBPoK2Jn
         MRthM2E1pVjqm1p//t8MqUqN0u3VT1/hWbeO/6+geSkqLdWNQnxDmimlOxQlEcNUvA/B
         zNqDsA6AoYRLLo4TZkjd52BU2sXRMGdtpEdultV5cKZTti9PmqPL7eXOzAj3ydH3hW9Z
         c54K8V11gVjL+AXvOgtv6KTkDf71wS3vqTl3IHXEG0DoLtO3xirufSC4WyvJWD7YOZcm
         J5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jR94/OWYPUCThNo3Ex9wlOGd2y/WQZQdNzrY1rIpR+U=;
        b=cC22dCXVYbXXqn5oWRQO9trjmqYH9oB5gGx98kokkXd8qcoUKuu1mZVLlMASAqOajN
         w+x0aJnf8rwUNyLNPB2RxJ8Ur1N1zfZzREDxYGgzvmZiuCEAvnGjYm8H3yWRcWbNsBtf
         atx/FEI/8n1tQwkgwB6+SGdiTsekGAHYGjRt1/s9KAwNIQEPL89xBuB9Lx60r7nmq5cc
         2R8GzlZxb3oLA3mcItNssQQ1FxzzuKbxgQj065bqizVvoBbsV6d10ODj+UHx86SIxe8e
         dMPfKOTthpqPXNqNCCy2j7j32itPFR+sGn/s/Ht3sFb9NeE+X4JDTyc31xtEXsltrwj/
         i0zA==
X-Gm-Message-State: APjAAAWGYUFN5Vou38KH9uGOELBvqIU3lOvd1i9PehkmwEKSHPS3Ye3B
        yiP+GoW5Z71dY2uW7xM1LejQ0bZN
X-Google-Smtp-Source: APXvYqxyKs7iaOIYzulqNVNdkOmrgfkoONLrRggKu0VwUrfUMbAnsQhMqqe3wO6vTbTxhNHJ1dZh4A==
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr14156413wrv.291.1579474414030;
        Sun, 19 Jan 2020 14:53:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12sm320759wmf.28.2020.01.19.14.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 14:53:33 -0800 (PST)
Message-Id: <pull.522.git.1579474412847.gitgitgadget@gmail.com>
From:   "Lucius Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Jan 2020 22:53:32 +0000
Subject: [PATCH] templates: fix deprecated type option `--bool`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Lucius Hu <orctarorga@gmail.com>, Lucius Hu <orctarorga@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lucius Hu <orctarorga@gmail.com>

The `--bool` option to `git-config` is marked as historical, and users are
recommended to use `--type=bool` instead. This commit replaces all occurrences
of `--bool` in the templates.

Also note that, no other deprecated type options are found, including `--int`,
`--bool-or-int`, `--path`, or `--expiry-date`.

Signed-off-by: Lucius Hu <orctarorga@gmail.com>
---
    templates: Fix depracated type option --bool
    
    The --bool option to git-config is marked as historical, and users are
    recommended to use --type=bool instead. This commit replaces all
    occurrences of --bool in the templates.
    
    Also note that, no other depracated type options are found, including 
    --int,--bool-or-int, --path, or --expiry-date.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-522%2Flebensterben%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-522/lebensterben/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/522

 templates/hooks--pre-commit.sample |  2 +-
 templates/hooks--update.sample     | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 6a75641638..e144712c85 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -16,7 +16,7 @@ else
 fi
 
 # If you want to allow non-ASCII filenames set this variable to true.
-allownonascii=$(git config --bool hooks.allownonascii)
+allownonascii=$(git config --type=bool hooks.allownonascii)
 
 # Redirect output to stderr.
 exec 1>&2
diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
index 80ba94135c..5014c4b31c 100755
--- a/templates/hooks--update.sample
+++ b/templates/hooks--update.sample
@@ -43,11 +43,11 @@ if [ -z "$refname" -o -z "$oldrev" -o -z "$newrev" ]; then
 fi
 
 # --- Config
-allowunannotated=$(git config --bool hooks.allowunannotated)
-allowdeletebranch=$(git config --bool hooks.allowdeletebranch)
-denycreatebranch=$(git config --bool hooks.denycreatebranch)
-allowdeletetag=$(git config --bool hooks.allowdeletetag)
-allowmodifytag=$(git config --bool hooks.allowmodifytag)
+allowunannotated=$(git config --type=bool hooks.allowunannotated)
+allowdeletebranch=$(git config --type=bool hooks.allowdeletebranch)
+denycreatebranch=$(git config --type=bool hooks.denycreatebranch)
+allowdeletetag=$(git config --type=bool hooks.allowdeletetag)
+allowmodifytag=$(git config --type=bool hooks.allowmodifytag)
 
 # check for no description
 projectdesc=$(sed -e '1q' "$GIT_DIR/description")

base-commit: 7a6a90c6ec48fc78c83d7090d6c1b95d8f3739c0
-- 
gitgitgadget
