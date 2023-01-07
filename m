Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187C5C54EBC
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 19:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjAGTjb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 14:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjAGTjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 14:39:25 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C74540C23
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 11:39:24 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso5895220wms.5
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 11:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5aPED1uDz8pjLLfA3pRQirKJaCrHhp0HaOqnh1rWgA=;
        b=jTvt+U/5bt8pOIf5tBm6LN0vdAbGsG/znVXrALGLGqqolvrHzWUSmzFEHBAawGydtF
         3bG8gPckufRSM9bno8kZVmkloG8vVkxH3V+1mYy/lceTSKo4yak6VPETeWaBGgnlBD6W
         wfZoKmLq5K9JayULzFyqW0ga/7douJe505O7GJ+jg09rPlyYSrdM5ldBQdVDRMVxd7IE
         iItr2Ign+2aIYjgI2v9ZqJUsQqgmsb2oI/6dwNO8yG0RDx9SbIaTgZqiop+8wqCc1ART
         0dVBGLyaKTvPyKSqUoJ3W94mlqgDB6V75zKkPO1waICM8QbpqJz9OTVptqRu6Kw6XWPD
         ormQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5aPED1uDz8pjLLfA3pRQirKJaCrHhp0HaOqnh1rWgA=;
        b=C83dOeWDMDLk9t1nbxn4r/KGk4dNBV9P12ZubxbxQc4WxqKCipUjhO6P3PG1FT3Wlc
         JcUTL21msI/eeMAhpAxjYi6iCwdsRlSjFMpOZWyFqH6dRydXTKIFb8ZWTtUOTjZkheia
         iNsfZaI/rHXJ5CIIYy8QtZKXNs7vzLt5jLNzxZHJX/CWDnQuSjPz5OoVLYRm0Mm0h+lY
         c57dxZPkYpmRm3TIBkiyRJPl7FhkAQmy3Gp+dNv9P0qzZuCsTpEWiqwg5ahJx+Ji2Ll9
         6lYNxW8NSMADE/g46VCNp5qh/ogF3JlYU9X8XLOY7yLawXU5x/WmFJe9aeHHTvLhtgH0
         idcw==
X-Gm-Message-State: AFqh2kqzr4RqcnH6Zt2wAaMCgvR/gdlZieqsu0My+TKWcfSm53F5T/dR
        hMmCxijhHn5l5PTRa1wjHEmf0IeFClE=
X-Google-Smtp-Source: AMrXdXuaS7Tww9i0i+ZjJXnbV1YuCQxsBRxfj6qYG+qt7++qItu7HErsn4j7W6cC0uwyoYrNw5jSfQ==
X-Received: by 2002:a05:600c:378c:b0:3d2:1f10:3318 with SMTP id o12-20020a05600c378c00b003d21f103318mr46642441wmr.31.1673120362594;
        Sat, 07 Jan 2023 11:39:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg24-20020a05600c3c9800b003cfa3a12660sm21382269wmb.1.2023.01.07.11.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:39:22 -0800 (PST)
Message-Id: <e488ad3ce1d2e227f5440fc04d0f6aeb6347a82a.1673120359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Jan 2023 19:39:17 +0000
Subject: [PATCH 3/5] git-merge.txt: mention 'ORIG_HEAD' in the Description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The fact that 'git merge' writes 'ORIG_HEAD' before performing the merge
is missing from the documentation of the command.

Mention it in the 'Description' section.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-merge.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 2d6a1391c89..0aeff572a59 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -37,7 +37,8 @@ Then "`git merge topic`" will replay the changes made on the
 `topic` branch since it diverged from `master` (i.e., `E`) until
 its current commit (`C`) on top of `master`, and record the result
 in a new commit along with the names of the two parent commits and
-a log message from the user describing the changes.
+a log message from the user describing the changes. Before the operation,
+`ORIG_HEAD` is set to the tip of the current branch (`C`).
 
 ------------
 	  A---B---C topic
-- 
gitgitgadget

