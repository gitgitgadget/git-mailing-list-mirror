Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74D1EC8726
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 17:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245199AbjIGRnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245193AbjIGRnA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 13:43:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABDFE45
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 10:42:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-402cc6b8bedso13858615e9.1
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694108553; x=1694713353; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WrozABxoZR9TyZUD+DHToCN+syiaf7C6376tLxh13M8=;
        b=AqCHKznsAzC4aTG/5wrMh1yfZNJIYZNsA5iwgyZi/4/lUI1MsUD4u8Ik7miFL8UiXl
         xaXXn6KzFZPTAEQ8x8J6VQ3uHBlZixUmtGX6lSUqugHXOHf4eDrxCbRx9NPTwAP+1j7O
         lBUI5EL56ZzDm011izgkzdQQrl++wz3A0ffLpW3tVN9xeM1UqN5WOLXx8buYZ7o3lQ6q
         yRL110lPKHSUuVYRMRPg9D1AwQDkRWOJHCVFyKD4w4vqdyu895dg/U6frioBZ3HDfH0M
         6Q6ZUQgwVQeJHjTg14qDxr8y+R/s1Iaray3uuniX7NY0ZgElkJbSnb25/0+UH6mV8WOf
         8GwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694108553; x=1694713353;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WrozABxoZR9TyZUD+DHToCN+syiaf7C6376tLxh13M8=;
        b=nImTKew1+rKlJLAhBjEIPZSReD96zUq0etRc2BHeNOeBf2nBQE0MQSkwKtMH1QfmoF
         PDdILee+OrfBn5lDTO1Pn4H/nUgdhmOBITZCxCn7mg+YPVUpRoC21hVYxINSQuXFWhMk
         oSyNdqKHx+Ra4JiMvOb0mazaYo849gSpmzHLLos+gk+on+wmYkFKBLChWvBRYhkY9Vv4
         IDcgoKgiwlkA7h0IfSMdnGSk4T4lhX9XkIeDdd4i00eu8fnsSQ6gzt4KXw7YPNRZvkM7
         ZDKKy64dNem10zXdFigFQizwhb5phAa0RyZWfZutsfr0SZN9pMBIB0OXxGuvfbz8SA+m
         PvTA==
X-Gm-Message-State: AOJu0YwvrvDksAHhChO7dLIpSKBm04ffeLUgg6P5p9ySzCvN1m3htF9a
        8k4n1XwDBjPAUw2bajiBN/c6GlW+RJ4=
X-Google-Smtp-Source: AGHT+IHBC6tLAimHVqf8S4OGJBnNH93LtW9wtIqgti6NkgD117Pp2EIAoONTtt3G6fDDKWWWRQK9Yg==
X-Received: by 2002:a1c:f70f:0:b0:3fe:1548:264f with SMTP id v15-20020a1cf70f000000b003fe1548264fmr315078wmh.22.1694108552867;
        Thu, 07 Sep 2023 10:42:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13-20020a1c4c0d000000b003fe1fe56202sm3087132wmf.33.2023.09.07.10.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 10:42:32 -0700 (PDT)
Message-ID: <pull.1583.git.1694108551683.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Sep 2023 17:42:31 +0000
Subject: [PATCH] completion: commit: complete configured trailer tokens
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Since 2daae3d1d1 (commit: add --trailer option, 2021-03-23), 'git
commit' can add trailers to commit messages. To make that feature more
pleasant to use at the command line, update the Bash completion code to
offer configured trailer tokens.

Add a __git_trailer_tokens function to list the configured trailers
tokens, and use it in _git_commit to suggest the configured tokens,
suffixing the completion words with ':' so that the user only has to add
the trailer value.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    completion: commit: complete configured trailer tokens
    
    Since 2daae3d1d1 (commit: add --trailer option, 2021-03-23), 'git
    commit' can add trailers to commit messages. To make that feature more
    pleasant to use at the command line, update the Bash completion code to
    offer configured trailer tokens.
    
    Add a __git_trailer_tokens function to list the configured trailers
    tokens, and use it in _git_commit to suggest the configured tokens,
    suffixing the completion words with ':' so that the user only has to add
    the trailer value.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1583%2Fphil-blain%2Fcompletion-commit-trailers-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1583/phil-blain/completion-commit-trailers-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1583

 contrib/completion/git-completion.bash | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 133ec92bfae..b5eb75aadc5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1677,6 +1677,11 @@ _git_clone ()
 
 __git_untracked_file_modes="all no normal"
 
+__git_trailer_tokens ()
+{
+	git config --name-only --get-regexp trailer.\*.key | awk -F. '{print $2}'
+}
+
 _git_commit ()
 {
 	case "$prev" in
@@ -1701,6 +1706,10 @@ _git_commit ()
 		__gitcomp "$__git_untracked_file_modes" "" "${cur##--untracked-files=}"
 		return
 		;;
+	--trailer=*)
+		__gitcomp_nl "$(__git_trailer_tokens)" "" "${cur##--trailer=}" ":"
+		return
+		;;
 	--*)
 		__gitcomp_builtin commit
 		return

base-commit: 1fc548b2d6a3596f3e1c1f8b1930d8dbd1e30bf3
-- 
gitgitgadget
