Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3298AC2D0C0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61CA20643
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIUIZjl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfLWSuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 13:50:04 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:32917 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfLWSuE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 13:50:04 -0500
Received: by mail-ed1-f42.google.com with SMTP id r21so16130331edq.0
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 10:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3muzs1s8jPipA1T8GQk7Xh/VUjMuS5qZYkTINqYuvjk=;
        b=bIUIZjl9N9mUTNHE+pDW/g+LNisdpKRsWKS+TGoNtpIUR/DWiVDxd9GENSxpgFW1Gf
         VtTMdO1TYfax/JomWBXR625Xvw9jY3kFm9U+hSQ/4lYcKOxvBKllqaMjiVWbgrOBptAf
         o5BmSxUaMTVcbHYXJJP7pdzS3dZ61oY/iWy0WhkICH0kgB4WkkIoYIDmgGXmk8rT8Wg8
         IqfNhKTNQPdSj5jrwjg0LNVTeEXZUSHe4kYe3X+fJfha+faJxQLcTZBNYP7om8ZZClVw
         UbU7VMPSrV1IjYYlTeg+duVhJt5p0zFL9YTITvtPIx61+yw/xiraekAPwbZqDnFzrdXa
         BePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3muzs1s8jPipA1T8GQk7Xh/VUjMuS5qZYkTINqYuvjk=;
        b=HUDItbvYsMfMlSBd9MP2/EH+NP8pfydOkht4tFEbC9MQVLk6n+H8dV5IedlLlYq02X
         K8gP1fEDIx2OYCby36p9Am6vLEMIJ82BTgTZdjshkoHua+QswulpouK4RIrIcDzyICoo
         0G6tFdp6GVq7mQOoPB36piIrwJL9wd4wdiSE6VIM2wJ7FbZ/hfPzMI310F+4SVO3irnz
         ludEAVQ7FG48hszQfIJGCHZIs6EQE4USA2ceKyZkSWBtEXLzUJgLOYVViqK9t00KzGV/
         s9hh8zmeph2g1mDDFia6VyBS36UGt3RjXBr6VjhvqQAbidTytFLljAv1vC61AZ9//ccO
         +A0Q==
X-Gm-Message-State: APjAAAWjJ9apna74EMhgsMFbY6KD6/dh025STNvxi2vbZx1tL6fMe5cR
        s9uiwOzpglMjZ1nhGF0iSYLe8Eue
X-Google-Smtp-Source: APXvYqxmUh4a1h/IhEvoyf4zZxIez/p4hVZPCPeKw/KAqOvv4A57QdPpI0IGVdI48MBinBQ5SBy8gQ==
X-Received: by 2002:a50:fb96:: with SMTP id e22mr34411843edq.18.1577127002734;
        Mon, 23 Dec 2019 10:50:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm2375773ejp.50.2019.12.23.10.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 10:50:02 -0800 (PST)
Message-Id: <bd3c5ec155325d78f89afcbe910810cc18c0aaeb.1577127000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
        <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Dec 2019 18:49:46 +0000
Subject: [PATCH v2 02/15] t3406: simplify an already simple test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When the merge backend was re-implemented on top of the interactive
backend, the output of rebase --merge changed a little.  This change
allowed this test to be simplified, though it wasn't noticed until now.
Simplify the testcase a little.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3406-rebase-message.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index b393e1e9fe..0c2c569f95 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -18,11 +18,8 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'rebase -m' '
-	git rebase -m master >report &&
-	>expect &&
-	sed -n -e "/^Already applied: /p" \
-		-e "/^Committed: /p" report >actual &&
-	test_cmp expect actual
+	git rebase -m master >actual &&
+	test_must_be_empty actual
 '
 
 test_expect_success 'rebase against master twice' '
-- 
gitgitgadget

