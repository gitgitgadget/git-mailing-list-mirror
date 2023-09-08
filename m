Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037FAEE7FE1
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 12:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbjIHM2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 08:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjIHM2v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 08:28:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5551BF1
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 05:28:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401d10e3e54so21314205e9.2
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 05:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694176125; x=1694780925; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy3szTgVEnt4799yD4tDYwVytfnKrmg/TSbe7G8mKVk=;
        b=L6hraf7u6/GK36Nf1dowXpq4DldoslNcZ/t116404anAQ123C1wSfGTci1OZa+WgfE
         xPnFubZ/lsG/RcFCF9RzLuDKrWyej7L2P+mX8ke4kt7rN67IOY2IugcP9rRu+/xDUe97
         0sQqYX1d4P2aXzpuZWx/bFxrpd2/H1+F6rVvSI63KqjzsRgZ7f8ZyDeAJNKKqHTm9NqI
         tGqZZPvOGs6reX37as3AZagCZjTVvQWd6mMtbyUiPTSERE/QczXgxDEe92ySQBLIkh+a
         Hf4lb0oYKqOVRbJCEjRVz6oEXgtvIweIe8+fDUoqJWLnBQqBoVy7zlmw3e7fjkbZ7SoE
         /a7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694176125; x=1694780925;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dy3szTgVEnt4799yD4tDYwVytfnKrmg/TSbe7G8mKVk=;
        b=jN6a7x/UJ4h5ssw1OglIw9C2U33c7yXyfKpoExcRoY8r1V4WKn6j2wN9sQ7u/NWwpx
         xnpUiM5RJzOPWYudhiG8VP+CtUIojt6g+2rxiySiHScvtQ7vNZDQg1WvMKMGtmWfQ+9M
         YWvAHhLiSrIHL5xhp18Pm6291uApsEPUONzKxsofTIHJoq1SN/q0QllzrOMzzV1ZZXTV
         aVRWfu/iCARIibreveYOPji5cQEAZRooCmj7UEz7TBK34cm0BU5QS+t80yCTJ1NqQ1B1
         AoAFKHy+hPh4XpSectZeUQv4ajP/RRRa+Zh54dndUaIXMA45M7nHAitZGB9TGaHm7UwX
         XDWQ==
X-Gm-Message-State: AOJu0YwlrUmk0y/I4DXVo0KjL6iG9QblrTijHAiPnbvSUjmYW/lH0BgI
        WRo8cUB2+Sk0wlUTNvNR4gHmM8l+4PY=
X-Google-Smtp-Source: AGHT+IHgqWR63RYyPp0nVWGZsDSFCpEv5JNMiIpdhCdqmEp5bVyGrqKftLNLZTnWkJKAN/AzBa1xAA==
X-Received: by 2002:a05:600c:3ba1:b0:3fe:5501:d293 with SMTP id n33-20020a05600c3ba100b003fe5501d293mr1952232wms.30.1694176124944;
        Fri, 08 Sep 2023 05:28:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d43c5000000b003180fdf5589sm2018504wrr.6.2023.09.08.05.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 05:28:44 -0700 (PDT)
Message-ID: <pull.1584.git.1694176123471.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Sep 2023 12:28:43 +0000
Subject: [PATCH] completion(switch/checkout): treat --track and -t the same
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `git switch --track ` is to be completed, only remote refs are
eligible because that is what the `--track` option targets.

And when the short-hand `-t` is used instead, the same _should_ happen.
Let's make it so.

Note that the bug exists both in the completions of `switch` and
`completion`, even if it manifests in slightly different ways: While
the completion of `git switch -t ` will not even look at remote refs,
the completion of `git checkout -t ` will look at both remote _and_
local refs. Both should look only at remote refs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Fix the completion of git switch/git checkout: Treat --track and -t the
    same
    
    Just something that was nagging me for one year too many.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1584%2Fdscho%2Fcomplete-switch-t-properly-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1584/dscho/complete-switch-t-properly-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1584

 contrib/completion/git-completion.bash |  4 ++--
 t/t9902-completion.sh                  | 12 ++++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 133ec92bfae..745dc901fbe 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1607,7 +1607,7 @@ _git_checkout ()
 
 		if [ -n "$(__git_find_on_cmdline "-b -B -d --detach --orphan")" ]; then
 			__git_complete_refs --mode="refs"
-		elif [ -n "$(__git_find_on_cmdline "--track")" ]; then
+		elif [ -n "$(__git_find_on_cmdline "-t --track")" ]; then
 			__git_complete_refs --mode="remote-heads"
 		else
 			__git_complete_refs $dwim_opt --mode="refs"
@@ -2514,7 +2514,7 @@ _git_switch ()
 
 		if [ -n "$(__git_find_on_cmdline "-c -C -d --detach")" ]; then
 			__git_complete_refs --mode="refs"
-		elif [ -n "$(__git_find_on_cmdline "--track")" ]; then
+		elif [ -n "$(__git_find_on_cmdline "-t --track")" ]; then
 			__git_complete_refs --mode="remote-heads"
 		else
 			__git_complete_refs $dwim_opt --mode="heads"
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 8835e16e811..df8bc44c285 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1622,14 +1622,22 @@ test_expect_success 'git checkout - with -d, complete only references' '
 '
 
 test_expect_success 'git switch - with --track, complete only remote branches' '
-	test_completion "git switch --track " <<-\EOF
+:	test_completion "git switch --track " <<-\EOF &&
+	other/branch-in-other Z
+	other/main-in-other Z
+	EOF
+	test_completion "git switch -t " <<-\EOF
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
 '
 
 test_expect_success 'git checkout - with --track, complete only remote branches' '
-	test_completion "git checkout --track " <<-\EOF
+	test_completion "git checkout --track " <<-\EOF &&
+	other/branch-in-other Z
+	other/main-in-other Z
+	EOF
+	test_completion "git checkout -t " <<-\EOF
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF

base-commit: 94e83dcf5b5faaa22e32729305f8fd7090bfdfed
-- 
gitgitgadget
