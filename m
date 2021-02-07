Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968DBC433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6784964E31
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBGSTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 13:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBGSTr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 13:19:47 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8EAC061788
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 10:19:07 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id q20so8260725pfu.8
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 10:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZB4Ln2OLvjtq6Jp681f+oNIDyxCPIeKrnZ+6qU7VShE=;
        b=IsLgqDtdgDHg0R8lbpoA5IDDnkofD2inthnohTgOBY9IQousmoogY6/y+Qi8UvOEGC
         8AOfqqxXtO/9IDtu/TRL6ss0ZXC2fcCxeWKHw5lpYbBFUZ8N3FZzZhxdENdvwBHLRaMq
         O5/Hf1xNXAn1FpmSGlcFs3Lt94AFinh6OIOd2t8U7BGP+QR4EHhhYcL5FzUN+MQfFE8W
         3WJjwICNmzwhWI4BhmRNY/0iGbrmmsQ8aqgcT7V6jCx3PxEkx9qfMaGQdQxCd/ON89lM
         4ElWAOmYfnHjSznXJObkFvcltxzi8Xb4RPhRINrKOqBJkShTZAV9WPKWTy9Sx9t9RmnX
         6P4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZB4Ln2OLvjtq6Jp681f+oNIDyxCPIeKrnZ+6qU7VShE=;
        b=IjuMY8EvXO++hW6A8sEuOJ6yrlZRPFDoH8Te93FqfIvP2TUE7MxI0VpUv+ywYeZ9Hm
         PWu9feH739sWheZgwAVAMldx3iFLYQLfhNARqDUQiO500hHnCtl4ap+k0iyUGQueFJnq
         QJw32N0dysvqqbD1Hi0h8F62Tr6Ivf4QpdnT8vt37zN5OOj2yDF5eiV1+uAKAoYv3pEX
         nQwqXkxDaCK0355A/4uiYcuF1fMFq32eJK+axL0KRxW8CvLdKta4sEfSS6YZ3ujjf5SA
         eNljwJMQkpAOZHZVWXnhinNXTsdnWmJM2QbDUjeid9zU+6dpJ5mOlE1HmomXCroHYwbH
         IlxA==
X-Gm-Message-State: AOAM531wshSJX/EJ0uLYmH0lE3lvjMUB8F42Mtrn3y/L0tYiux8huk2D
        vYZ3DhgJxvLZ0cdjXiykVGgDXWwjdMTTGw==
X-Google-Smtp-Source: ABdhPJwF/NOv3LmTNv+mLaSXsJr0jOqwI4fASb5+KKqcAJPQrDEfwpof3y0Ri+x1TbUdK7b/JXnHsg==
X-Received: by 2002:a62:8c05:0:b029:1d8:7f36:bcd8 with SMTP id m5-20020a628c050000b02901d87f36bcd8mr11470966pfd.43.1612721946689;
        Sun, 07 Feb 2021 10:19:06 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:4438:7fbe:1d1f:8bc])
        by smtp.googlemail.com with ESMTPSA id n7sm16375194pfn.141.2021.02.07.10.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 10:19:06 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 3/7] rebase -i: clarify and fix 'fixup -c' rebase-todo help
Date:   Sun,  7 Feb 2021 23:44:36 +0530
Message-Id: <20210207181439.1178-4-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `-c` says "edit the commit message" it's not clear what will be
edited. The original's commit message or the replacement's message or a
combination of the two. Word it such that it states more precisely what
exactly will be edited and also remove the use of a period and
capitalized word in the to-do help text.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 rebase-interactive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index c3bd02adee..e85994beb6 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -45,8 +45,8 @@ void append_todo_help(int command_count,
 "e, edit <commit> = use commit, but stop for amending\n"
 "s, squash <commit> = use commit, but meld into previous commit\n"
 "f, fixup [-C | -c] <commit> = like \"squash\", but discard this\n"
-"                   commit's log message. Use -C to replace with this\n"
-"                   commit message or -c to edit the commit message\n"
+"                   commit's log message; use -C to replace with this\n"
+"                   commit message or -c to edit this commit message\n"
 "x, exec <command> = run command (the rest of the line) using shell\n"
 "b, break = stop here (continue rebase later with 'git rebase --continue')\n"
 "d, drop <commit> = remove commit\n"
@@ -55,7 +55,7 @@ void append_todo_help(int command_count,
 "m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]\n"
 ".       create a merge commit using the original merge commit's\n"
 ".       message (or the oneline, if no original merge commit was\n"
-".       specified). Use -c <commit> to reword the commit message.\n"
+".       specified); use -c <commit> to reword the commit message\n"
 "\n"
 "These lines can be re-ordered; they are executed from top to bottom.\n");
 	unsigned edit_todo = !(shortrevisions && shortonto);
-- 
2.29.0.rc1

