Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8788C54EEB
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 09:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2B920777
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 09:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4Y1WViF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgCVJPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 05:15:51 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:45549 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgCVJPu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 05:15:50 -0400
Received: by mail-ed1-f41.google.com with SMTP id u59so12690122edc.12
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 02:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=M5SWJqNaQ0lbTbHcpbVZhDOm7oLaVUeKsxHqr6cb270=;
        b=o4Y1WViFAJwIo/U+yEsAWzjijxxV9xweG+f9D1dMJ1C+FYlMx0KLPFttqMpoqoVJkC
         R9EcrbJnmM8r0aJAiD72687/GTFTYcaE6J5B8F1M9yBD8LWKEFEDAEXAUyZ+LHhJJIBQ
         wDaDXVef4xTKYJpV+pSuG2F42q68ofI5FNyS+u52Q8FIi8vPQRVweBsnnCOeHJ/eCNNN
         BsPjg6CLjeodByLxfdJV0mnspxkdGiP03NNu3josArC43ph1Hw6G999K83MbUydTGik/
         HFFbrCq9sT4t4CS+wl8qFj6mqv+0kIjo8ODJH4nyiv0hiopDBu5CaFeNs4erXjAHztjD
         czhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M5SWJqNaQ0lbTbHcpbVZhDOm7oLaVUeKsxHqr6cb270=;
        b=E8j5pMNskzdZNuv1JjJ2YL+/1FWtr9CY+R2M95BzSnih7ToBjvaFydvkxSQfd7hj6B
         ttWi+Afns5uTqNxYjnkNkoC3auQe1sJZ+5CCNDfSAD9+o8kuKHLA3O7m6YM6P0u+MpU7
         nD0H6h8u0jmJL0BeUFyDYNQ2aBnkTveiXOTxUdONWKoCHL1Fu9SIlhq8789BgJDOzzX7
         wki/8DaQNwRC2edLZRtrMJwaYjIRwZZ6qoE9ymekE+6b+TPlRpDTSjtRc2Sxx6VLwXnh
         dHrJyD/T9zKZcboJWzLwcNg+q37GDFDWKgPw5fbMxJ5s6wgTfJBmlLqhutdmHFW/1lMc
         6XzQ==
X-Gm-Message-State: ANhLgQ1vAvv+EkNX0AkVqOalD6tbo+ZbqRPYGEe48MsYVaUs98hLrRfL
        CUnlBHlCpub+T1JGdJuCTWMmdOjX
X-Google-Smtp-Source: ADFU+vsC1gxCTu6KSWsY5qYpNJtlOnHw9wuIhNJyXDPb5xT7W5RUYkRXwVrBZKiwbvvI4Jb7JEP0zQ==
X-Received: by 2002:a17:906:4d42:: with SMTP id b2mr3991888ejv.22.1584868548566;
        Sun, 22 Mar 2020 02:15:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v3sm638262eju.34.2020.03.22.02.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 02:15:48 -0700 (PDT)
Message-Id: <pull.736.git.git.1584868547682.gitgitgadget@gmail.com>
From:   "Sheikh hamza via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 22 Mar 2020 09:15:47 +0000
Subject: [PATCH] bisect: remove root directory restriction for git bisect
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sheikh hamza <sheikhhamza012@gmail.com>,
        sheikh hamza <sheikhhamza012@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: sheikh hamza <sheikhhamza012@gmail.com>

    according to the open issue #486 the git bisect
    command should be able to run from inside any
    subdirectory and in the same disscusion "dscho"
    gave the directions and those directions lead me
    the fix of adding SUBDIRECTORY_OK=Yes on L#34
    before sourcing git-sh-setup that made it work as
    in git-sh-setup there was a check on SUBDIRECTORY_OK
    that prevents it to run in sub directories if it is not
    set to "ok" as this file was also sourced in other commands
    that are required to only run from root one of such scripts
    is git-filter-branch

Signed-off-by: sheikh hamza <sheikhhamza012@gmail.com>
---
    bisect: remove root directory restriction for git bisect
    
    according to the open issue #486 the git bisect
    command should be able to run from inside any
    subdirectory and in the same disscusion "dscho"
    gave the directions and those directions lead me
    the fix of adding SUBDIRECTORY_OK=Yes on L#34
    before sourcing git-sh-setup that made it work as
    in git-sh-setup there was a check on SUBDIRECTORY_OK
    that prevents it to run in sub directories if it is not
    set to "ok" as this file was also sourced in other commands
    that are required to only run from root one of such scripts
    is git-filter-branch

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-736%2Fsheikhhamza012%2Fbisect_subdirectory_fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-736/sheikhhamza012/bisect_subdirectory_fix-v1
Pull-Request: https://github.com/git/git/pull/736

 git-bisect.sh            | 1 +
 t/perf/bisect_regression | 6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index efee12b8b1e..8c1da200e41 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -31,6 +31,7 @@ git bisect run <cmd>...
 
 Please use "git help bisect" to get the full man page.'
 
+SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 . git-sh-setup
 
diff --git a/t/perf/bisect_regression b/t/perf/bisect_regression
index ce47e1662a9..d6b96f49e46 100755
--- a/t/perf/bisect_regression
+++ b/t/perf/bisect_regression
@@ -57,11 +57,9 @@ tmpdir=$(mktemp -d -t bisect_regression_XXXXXX) || die "Failed to create temp di
 echo "$oldtime" >"$tmpdir/oldtime" || die "Failed to write to '$tmpdir/oldtime'"
 echo "$newtime" >"$tmpdir/newtime" || die "Failed to write to '$tmpdir/newtime'"
 
-# Bisecting must be performed from the top level directory (even with --no-checkout)
-(
-	toplevel_dir=$(git rev-parse --show-toplevel) || die "Failed to find top level directory"
-	cd "$toplevel_dir" || die "Failed to cd into top level directory '$toplevel_dir'"
 
+(
+	 
 	git bisect start --no-checkout "$newrev" "$oldrev" || die "Failed to start bisecting"
 
 	git bisect run t/perf/bisect_run_script "$test_script" "$test_number" "$tmpdir"

base-commit: 98cedd0233ee88e69711f79d1126b6bd772ff5bd
-- 
gitgitgadget
