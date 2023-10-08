Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C527DE95A82
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344517AbjJHGpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344482AbjJHGpj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E539FB
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso32943845e9.2
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747536; x=1697352336; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0FH8AxA2nm4f7B1VVFbwpbLLx5hPRzdkMQZs6Xoxkg=;
        b=X2wAq0mleA7A502jrSB0jEpqmMldtFvT3YwM1m/BHOx5+3m08kVCoSsUGxhtAxkYRu
         hTKHy0iOT1EUhJtLSDTFOB10wSjbpswJlu9RVmaYiH8YtAdsS7wNHlY/Edu3vdSYkNvp
         KtLIxiZm28NmhaJPeFjtpgUEzEj9ENW7D1Qxav0KvnGsNx/m1WHDmHXi+lo8Qa/25ozW
         qrg1XONmbIcgpqZ24khQf2Ks4GP3r3xkxH7IkLLo3WRr5Qk395VAn2SZtIwZ+BGyd8Fb
         P/wBbvageCxdI4lujTxam9YNb8WaXJ4LxlPVetcdFBa4gfdt/rDyTivV5PiX9n/Ys5TL
         jF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747536; x=1697352336;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0FH8AxA2nm4f7B1VVFbwpbLLx5hPRzdkMQZs6Xoxkg=;
        b=J12Ykn+3OSokUXESjNOB2fBk0D1Ydhu5DJK+aBHLzDrTTuhPhQEK6Ngq5M/tVoB01C
         NQRw2bAoFjvvJkPoYDM9sIS4W9VC2b6PHAN4f7iuv4I3Vvnjt7iHY3TjketQzUFEtbuF
         RL/EHJqVH7HTi/hG82H5IeBQqToFgqlK4uiBsg/dW2xQW94GIJ+MSbr4omsqq1s264Ty
         zkg8BUBQpCnxJ8wEU2hURN9T449whetOXIOK5zX3ri9yxyD6a9DPfKVPEDq+qxk7HKRy
         3PeIyw/r59OqnFWw7iVvIWkrtyadpVzHijR/+VmDx+hhYUwfQg08l/mFb5/C+FbMoWlS
         ucTA==
X-Gm-Message-State: AOJu0Yy13jLiGr98n/Xuuq13r3NlOerM84VKsHGrRjpvGl91fOini2oS
        +VJCSirwRjvn8DAJmZIG2ZkCAqQes48=
X-Google-Smtp-Source: AGHT+IESXC0BLuaIdKfREAPCqutdFgRmUBO0UAHNg12JfdN3saakktlQnnvDkUOLWXJHAys/1lzrOw==
X-Received: by 2002:a7b:c8c8:0:b0:404:7462:1f6f with SMTP id f8-20020a7bc8c8000000b0040474621f6fmr10821144wml.8.1696747535577;
        Sat, 07 Oct 2023 23:45:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay20-20020a05600c1e1400b0040640073d25sm7876591wmb.16.2023.10.07.23.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:35 -0700 (PDT)
Message-ID: <6b30cc92f103459c8f40ccb2f8943da4db9d6ef7.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:10 +0000
Subject: [PATCH 08/25] documentation: employ consistent verb tense for a list
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Diff best viewed with --color-diff.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/push.txt    | 2 +-
 Documentation/config/receive.txt | 2 +-
 Documentation/git-rev-parse.txt  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index 43338b65e84..dbaf930f01b 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -35,7 +35,7 @@ push.default::
 
 * `tracking` - This is a deprecated synonym for `upstream`.
 
-* `simple` - pushes the current branch with the same name on the remote.
+* `simple` - push the current branch with the same name on the remote.
 +
 If you are working on a centralized workflow (pushing to the same repository you
 pull from, which is typically `origin`), then you need to configure an upstream
diff --git a/Documentation/config/receive.txt b/Documentation/config/receive.txt
index ae526cbf584..c77e55b1cdd 100644
--- a/Documentation/config/receive.txt
+++ b/Documentation/config/receive.txt
@@ -14,7 +14,7 @@ receive.autogc::
 
 receive.certNonceSeed::
 	By setting this variable to a string, `git receive-pack`
-	will accept a `git push --signed` and verifies it by using
+	will accept a `git push --signed` and verify it by using
 	a "nonce" protected by HMAC using this string as a secret
 	key.
 
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 2294e9a519a..7b3ce3012e3 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -156,7 +156,7 @@ for another option.
 	are not refs (i.e. branch or tag names; or more
 	explicitly disambiguating "heads/master" form, when you
 	want to name the "master" branch when there is an
-	unfortunately named tag "master"), and show them as full
+	unfortunately named tag "master"), and shows them as full
 	refnames (e.g. "refs/heads/master").
 
 Options for Objects
-- 
gitgitgadget

