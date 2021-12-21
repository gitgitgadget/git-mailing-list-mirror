Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B18C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 18:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240876AbhLUSGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 13:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240819AbhLUSF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 13:05:58 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02699C061756
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:58 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d9so9068940wrb.0
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 10:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1KZlym63hsEmgZKhgF68sGOhw4+6yJaaNBmMEKsLv5I=;
        b=kVPhNG9hpkysK0X4P1+nh/8UbNa9IZGhITugJr/DHRy8DWxL2k/z4D7JMOxs0KbNUt
         UpF5HuT+ZnMG3W6RX1VwRXJCx+mQSLw1eKd8RZV6il+7fR6Ds2XPc5zEob+oI0j3v7lq
         81irC0ctzW68dIgVoszdQbHejC/01NkgJAqcZSKB+BPqjy7G24DasGea7aFegQOzeY6E
         LRvEITpxldqS11wCkMYB9RTDoz2MClpMgqOnTXchFpDJxiTgkJ6xVs8pMcg1Tb05TJq7
         Zy91GpHkHWfuB3CGQnnfQAtWraovqq2PvRiue2gobjwby9RqjFi+sX9mbLzwZK4TNGU9
         LoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1KZlym63hsEmgZKhgF68sGOhw4+6yJaaNBmMEKsLv5I=;
        b=n9jkOz2wjtS7gjp+xUudRoClvxnpg54VwhCQWbhGQmJRgiMlztOFDalw6M/13jE82h
         6tu4XEgKvU73oaB6k4roD5XZbwH2qXHZ3nH+HEnn5l33PrsO44XlNoVe32TvgLAeWz0T
         /dnj3idQpOrZ84ECjqO4Vx8N3We4Zqd5EcZDcwvuArWj2hAnxWs45ZWxGvj2+aYbm61X
         lFN4L1oVLpSGpF1UutGzMAf3SjVcGYjEm7BLxB0lAvUcK5z30WCXzf/vSwZB2d6ysYWt
         lE+3+hP9bTWltb4UZAfiMPkiUKseLQ4SMghUJdw2aRV/m928V4zHmBazj+vGtJ99En8q
         gaFA==
X-Gm-Message-State: AOAM533JjAfm0V9KuWm/ZCFsfHUCJbaDswk9WDU0UYu8CsAKx0yY52v8
        WK42QmNaWXDIyy/JY70Wq757ekk0coo=
X-Google-Smtp-Source: ABdhPJwFdy3gN6HkERuW4cPOeveFlwyTt/hEgKyLds93rdP3byrrbMC7p62KeBeL3EnW0XAlVvYjXA==
X-Received: by 2002:a05:6000:1a8e:: with SMTP id f14mr3412370wry.635.1640109956440;
        Tue, 21 Dec 2021 10:05:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13sm3400973wms.1.2021.12.21.10.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:05:56 -0800 (PST)
Message-Id: <4f21969e35724ffac6938beb9e089a970f90c41a.1640109949.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 18:05:48 +0000
Subject: [PATCH 9/9] doc/diff-options: explain the new --remerge-diff option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/diff-options.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c89d530d3d1..b05f1c9f1c9 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -64,6 +64,14 @@ ifdef::git-log[]
 	each of the parents. Separate log entry and diff is generated
 	for each parent.
 +
+--diff-merges=remerge:::
+--diff-merges=r:::
+--remerge-diff:::
+	With this option, two-parent merge commits are remerged to
+	create a temporary tree object -- potentially containing files
+	with conflict markers and such.  A diff is then shown between
+	that temporary tree and the actual merge commit.
++
 --diff-merges=combined:::
 --diff-merges=c:::
 -c:::
-- 
gitgitgadget
