Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7421C4332B
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D92C233EA
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbhAHJ1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 04:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbhAHJ1I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 04:27:08 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9B2C0612FC
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 01:26:28 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id p12so3328102pju.5
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 01:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v06s6aZ+KsNyeYsi4lspk3/ZKiIaKcsSjXUrM9gZ5v8=;
        b=aLKR8ZqzdbcPfh1tMpgY7RxEAtcQfE22468G2R9UAmXpbHngV5ZD/QN68M1XwaPLBy
         TTlwjav5LC6Hnc7rnXC/JVtgHIdxVrwvHAVgqrJWEggdbQhSkZEwivIs1PTo4ypa4H+t
         32QfkqnW0WiL1DQyJuAGGq+1CNxlIXCJHc1Hn40BZx+eO7ilBSzYc/XcT7ZasK+WXpLC
         oAAWiy/IgvdjGYR7Qsdw6lWi9qxZ4GwFDd+V3O4Ikb0kmBz4aailqEme1ohI4G8ysUWX
         V1OBjEpSbAwZlfZWakdocYX8mpOZtGfP/6vkEAk4KvR4kUC8P2te57pLkkGiVBaYe2D2
         btNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v06s6aZ+KsNyeYsi4lspk3/ZKiIaKcsSjXUrM9gZ5v8=;
        b=bwGATiMk+NW/xAdvq0cqp2aldYlYDPaHgZ/tjHRZ/GLHkgZTQIuLVRFqVEjXWk9Q/l
         AgmMQSCC+O8OAWqQJxcPL7U+dNhpKhyGPIHTdfdmq4O28Mnt4Yw/i+UonAOFBc46mvhM
         H0r55BrMHrD/5AcWNoONGUs7DhzaDMAHIrSIsEEeM65aCMF0oFrFhwZeSWoySYGsCjZA
         uMqYqy6tvxwyMrEw4pdQImTX5GRSVp1zTmwGX42h2IdT1c6hQ2mqh9YvjvIpw1KfXrf6
         d3AlbA597tjypsY79t2R2BeK0TetMe34V803YS5shkm9n941TqFBIQttm9nnQhNUjBN/
         qQcQ==
X-Gm-Message-State: AOAM532gqnTxt4upsWPgxX3r5PohJi7pkJY3ioClcMKtt57ydR6r1qIC
        b+7mtJZGmiknP5TUUgwGSyD4CrJdI27gyA==
X-Google-Smtp-Source: ABdhPJwctOrv3UoiDvvU7T8WFJYgGJd27OBm3HTcsiGbC7K8QzdnZiO1hFN+TcBqDU9ZQIMp9LSftA==
X-Received: by 2002:a17:90a:dc18:: with SMTP id i24mr2890617pjv.118.1610097987802;
        Fri, 08 Jan 2021 01:26:27 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:e06:7e2e:2d21:e266:30b:8fc])
        by smtp.googlemail.com with ESMTPSA id 6sm8384234pfj.216.2021.01.08.01.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 01:26:27 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood@dunelm.org.uk,
        Johannes.Schindelin@gmx.de,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC PATCH 9/9] doc/git-rebase: add documentation for fixup [-C|-c] options
Date:   Fri,  8 Jan 2021 14:53:47 +0530
Message-Id: <20210108092345.2178-10-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210108092345.2178-1-charvi077@gmail.com>
References: <20210108092345.2178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 Documentation/git-rebase.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a0487b5cc5..776507e0cc 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -887,9 +887,15 @@ If you want to fold two or more commits into one, replace the command
 "pick" for the second and subsequent commits with "squash" or "fixup".
 If the commits had different authors, the folded commit will be
 attributed to the author of the first commit.  The suggested commit
-message for the folded commit is the concatenation of the commit
-messages of the first commit and of those with the "squash" command,
-but omits the commit messages of commits with the "fixup" command.
+message for the folded commit is created as follows:
+
+ - It is made using the commit message of a commit with the "fixup -C"
+   or "fixup -c" command. In the later case an editor is opened to edit
+   the commit message.
+ - Otherwise it's the concatenation of the commit messages of the first
+   commit and of those with the "squash" command.
+ - It omits the commit messages of commits with the "fixup"
+   (without -C or -c) command.
 
 'git rebase' will stop when "pick" has been replaced with "edit" or
 when a command fails due to merge errors. When you are done editing
-- 
2.29.0.rc1

