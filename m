Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5802AC33CAA
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 15:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4E22253D
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 15:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAjoA79t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgAUPBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:01:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56082 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbgAUPBX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 10:01:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so3272174wmj.5
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 07:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Dlsx8iXLF5pKxwgptuefJTONOCiej6Xp/ugi+EwU+HI=;
        b=VAjoA79tyMMVK6TSuf6ktLAtJ75oLaS7FR64gJ/PdKLtBzNz/VeRv3pFnhiJlse9gG
         JklTMD6qliSvsAYHq9Iw00UwGp8lVF49u/IbNH3VaaIwGks4NWUxDB35TlAnQleeVbMQ
         l+uDhmk3QFu7E4t9wN+5yGgTONT7ojIpzgCHgDNZMC4zHfWI+aSJYZNL8jSB9ByVt0zW
         iuWwyedNIhZE3tppYNHfMMOM5eACmqkdQBHrftKQpf4rSjelj1OquaJdId/yEltD97Sf
         tzV4P8mDusWsfS8hHX9g4gmS0pu96UM7hD+RzFrgZpGWvG1Gv19JQbDOHu1FDr0qdIAi
         c3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Dlsx8iXLF5pKxwgptuefJTONOCiej6Xp/ugi+EwU+HI=;
        b=nyTnSM3oCg136dkvuVhWNk5pEHcKx5oRVEdkONbPC32DCgAs5MsFHERoaqfggfY3/u
         BU4BIzsSaOKJQ6VMvv1f5CHyji+L1qvdQHbhchshjWeZNmhlyf6wj6CZUcrwhg6+bVRX
         QmVT5AuzRJXxFP78D/nh6xLWhDfO/q3L9uNvpwkmxWuTHzmhdOaZKkGZtSQ9BR5oTfTb
         UTR4qR9zOrj0hxfLcAPkYZYb81wJUM5Y8gRWCb6uaPOuWe8n9XVU2eo8NWWQuWO5gNsq
         dXzMDbgi4G3bWTRFop3+TTY8P38AZMQHQAECnbez25SUcbM/S+DSyg+SqHA9X4TouqMt
         +zWA==
X-Gm-Message-State: APjAAAUMmaFm0oXVxSFdiLtSk333Txu+HF925ngZndHP3hFjOPSaOtrN
        ZTka8/gkeAmuQFrbo1l8yZfrrXWz
X-Google-Smtp-Source: APXvYqyeklv6VFIK6SXrGt5/ADQTPP3CaMUPNOPEU3KPt5LPlPph9hx6BnDaACkmrJvXtFeZIeangg==
X-Received: by 2002:a1c:62c1:: with SMTP id w184mr4817422wmb.150.1579618880714;
        Tue, 21 Jan 2020 07:01:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y20sm4093152wmi.25.2020.01.21.07.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 07:01:20 -0800 (PST)
Message-Id: <f06d2c4aa5dc739d42ec502a3c77617aae417611.1579618877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.523.v2.git.1579618877.gitgitgadget@gmail.com>
References: <pull.523.git.1579263809.gitgitgadget@gmail.com>
        <pull.523.v2.git.1579618877.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Jan 2020 15:01:15 +0000
Subject: [PATCH v2 2/4] t2405: use git -C and test_commit -C instead of
 subshells
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The subshells used in the setup phase of this test are unnecessary.

Remove them by using 'git -C' and 'test_commit -C'.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/t2405-worktree-submodule.sh | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
index f2eee328cc..c4e555776a 100755
--- a/t/t2405-worktree-submodule.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -6,32 +6,16 @@ test_description='Combination of submodules and multiple worktrees'
 
 base_path=$(pwd -P)
 
-test_expect_success 'setup: make origin'  '
-	mkdir -p origin/sub &&
-	(
-		cd origin/sub && git init &&
-		echo file1 >file1 &&
-		git add file1 &&
-		git commit -m file1
-	) &&
-	mkdir -p origin/main &&
-	(
-		cd origin/main && git init &&
-		git submodule add ../sub &&
-		git commit -m "add sub"
-	) &&
-	(
-		cd origin/sub &&
-		echo file1updated >file1 &&
-		git add file1 &&
-		git commit -m "file1 updated"
-	) &&
+test_expect_success 'setup: create origin repos'  '
+	git init origin/sub &&
+	test_commit -C origin/sub file1 &&
+	git init origin/main &&
+	git -C origin/main submodule add ../sub &&
+	git -C origin/main commit -m "add sub" &&
+	test_commit -C origin/sub "file1 updated" file1 file1updated file1updated &&
 	git -C origin/main/sub pull &&
-	(
-		cd origin/main &&
-		git add sub &&
-		git commit -m "sub updated"
-	)
+	git -C origin/main add sub &&
+	git -C origin/main commit -m "sub updated"
 '
 
 test_expect_success 'setup: clone' '
-- 
gitgitgadget

