Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2E3C77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 17:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjDJRBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 13:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjDJRBw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 13:01:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33211BF8
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 10:01:51 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso6855183wmo.0
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681146110;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91IckjwX+gzGamNsobPr4wYUx7h8O6605eBuYRJb8xA=;
        b=Ogt4ml+V3rybpWM6l+zKxTEOapUaB/Q5lUt5sWo0WlSklgd2YOJ66amp9eRfZ73avf
         nUjQ33nzcsIFA8URoxi/3qF/jFhhMGkIPByNmISRv7rsOsv9EOmPq8guhhI98jgUQXLt
         goj8h5grdhrTvXoaQlN2AJwM4YUJQx+u6IBES52IZx9KlAG29XWzbRrfBHpDDyNNcv67
         tYvEP0YxqIJEJqIzK7p7fU9GWSyHKw9UFOqfSrPZSTG592MhMkxXRpgjZOBqn4y9JkEq
         xi6XgR3y+REVeNdP4zx96hLLoLjROGRRiDyeqm1J9zs5g3Jsl77n/BobOFCt7fssYQWW
         J4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681146110;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91IckjwX+gzGamNsobPr4wYUx7h8O6605eBuYRJb8xA=;
        b=PUOf/V8n2GM+tDTTMUc3JG6LC8sFihtp8EaqIDRPEwRPXWfnq/U7Ppl7qSleWlWUl4
         J6Vrm/bVQuRbcrT0Pov+B/CCkrMQBQsOcZAH6UaxkkdrrNRU1Drvnf+d+/fsy4e6j0Pt
         t6kPZ6HwqWFBH9g3YcKF2MDEHUjKawW1HYtr7aGhZ1SYVVyzUg9AHLcJ28TGf39JTbBW
         ogla1K30sBOmy/9ej2ZYNaiM8yVl08TjEoI+eOTBQw52UAYtEsTclyEy/LXSHMfHXjjv
         xfq0mFT/qgdPrES04jgYxz08p+8zcbn85hcTbQWNKcEoNBs8ZpCXIFEQNAsT6Zznu5ZG
         WdkA==
X-Gm-Message-State: AAQBX9dUJJC4sEeEWtKY9d4crxMLX86MG+9jG+9v0UE3CbMfDD9my1AG
        BVaBLHntYkOoTP9zerNzugdoloXlw6U=
X-Google-Smtp-Source: AKy350af6tMJa9b7ruMTjgXOUxOz15YX36Fl+yIxT9UhoSePzUGebnS5JRkScwebb2zUohcrJ/94hg==
X-Received: by 2002:a05:600c:202:b0:3f0:4e04:bd47 with SMTP id 2-20020a05600c020200b003f04e04bd47mr58589wmi.37.1681146109969;
        Mon, 10 Apr 2023 10:01:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2-20020a05600c4e0200b003f04057bf1bsm17879557wmq.18.2023.04.10.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 10:01:49 -0700 (PDT)
Message-Id: <01d69fc9f12197eb43cf48b3d7eff9a40f04e51b.1681146107.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1490.git.git.1681146107.gitgitgadget@gmail.com>
References: <pull.1490.git.git.1681146107.gitgitgadget@gmail.com>
From:   "Allen Reese via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Apr 2023 17:01:47 +0000
Subject: [PATCH 2/2] contrib/subtree: fix gpg_sign_arg not being passed to git
 merge.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Allen Reese <java.allen@apple.com>,
        Allen Reese <allen_reese@apple.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Allen Reese <allen_reese@apple.com>

Replace immitate -> imitate.

cc: Avery apenwarr@gmail.com

Signed-off-by: Allen Reese <allen_reese@apple.com>
---
 contrib/subtree/git-subtree.sh     | 14 +++++++++++---
 contrib/subtree/t/t7900-subtree.sh |  2 +-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 553b4391deb..18dc7f8a4c2 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -243,8 +243,16 @@ main () {
 			test -n "$allow_addmerge" || die_incompatible_opt "$opt" "$arg_command"
 			arg_addmerge_squash=
 			;;
-		-S*|--gpg-sign=*|--no-gpg-sign)
+		-S|--gpg-sign|--no-gpg-sign)
 			arg_gpgsign="${opt}"
+			case $1 in
+				-*)
+					;;
+				*)
+					arg_gpgsign=${opt}${1}
+					shift
+					;;
+			esac
 			;;
 		--)
 			break
@@ -1053,10 +1061,10 @@ cmd_merge () {
 
 	if test -n "$arg_addmerge_message"
 	then
-		git merge --no-ff -Xsubtree="$arg_prefix" \
+		git merge --no-ff $arg_gpgsign -Xsubtree="$arg_prefix" \
 			--message="$arg_addmerge_message" "$rev"
 	else
-		git merge --no-ff -Xsubtree="$arg_prefix" $rev
+		git merge --no-ff $arg_gpgsign -Xsubtree="$arg_prefix" $rev
 	fi
 }
 
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 341c169eca7..fa5bd9b7af6 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -47,7 +47,7 @@ last_commit_subject () {
 # pre-2.32.0 versions of 'git subtree' would write the hash of the tag
 # (sub1 below), instead of the commit (sub1^{commit}) in the
 # "git-subtree-split" trailer.
-# We immitate this behaviour below using a replace ref.
+# We imitate this behaviour below using a replace ref.
 # This function creates 3 repositories:
 # - $1
 # - $1-sub (added as subtree "sub" in $1)
-- 
gitgitgadget
