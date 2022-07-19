Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46849C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbiGSSp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGSSp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:45:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDE755099
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:45:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r2so21912035wrs.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2EJabEl5RK0eROvj+DJNsSQ2oxiXqi8xQEi3x4gQiGY=;
        b=RRAZDmj4a+i6eDWeYxymu//WIRkNBRkQ+QtSFugBYtc5Cu00v2mOYKE/8AtJAClOLA
         yzF/jimoFLHrqlHXyL2AiFNZZ+sIal9v8TovcSkxTXY7txR9Rbe5HAnAhWNXHAzzdgfs
         XXBVpD3r++deyTG7vDCSHciqdiS9fiuMkzxsZk/GdxohJZCefsITYFwkBSrngEO0lz0k
         41r+4I44F0jtp9B3Lzt28tCVlq94b+yoqFfomy1gcRPux1sDwCRz18vyYOLlrQuMWi3s
         Cu4kl+VSPRNohTrG1mpf8DOvBSm9XyUPQKQXkSqmo/Fxez5qQNTh64+Y1r6TxuWYjUe0
         rVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2EJabEl5RK0eROvj+DJNsSQ2oxiXqi8xQEi3x4gQiGY=;
        b=P/Umrc86CHFDbvGEVEKIVMEdlZGHONBMoHUqp92kcePa9CC+vFrGhtvh8oKNZNeCdO
         lpSSdIUJUkTITihIAZhQsbH8d39KRoyb2aPaJ6DeOEnc4R/SgMgjuhlPvJQG43mtGOcM
         uGY0P2YPnLcCLyavdE+iceeFqu/VgsGf6faYb8SWsLFw6jumlF8oVt5QkQ9RMPerb6FB
         vNn4lYCypf/R083DwVViYdcrVrWkfgiAZOMP8Z9XdNJZnS9+/ZETmOQYLrkpBcu2XPQ7
         DRZMwlNGMiHRhc1/XmZgcPDNcBnJtx3UVlJXpPW0vQ9FBxM5vOATjtIcVGUSs2DvMJhj
         J6xA==
X-Gm-Message-State: AJIora/quto+R99T8+CYe3W+eROfv0U9y2ot7HuJzUrLl0q0BA1O4rWa
        2JtMbf7gAK0nujJGI8VOAhQhxXT2JHw=
X-Google-Smtp-Source: AGRyM1uYoeYQO9N/+RE4OAKNgiGsXazeG3cFCe4Z6Fiy5AZVw1iWDNo/NHYdh1qfdf+djX5Ek9FhrQ==
X-Received: by 2002:a5d:64eb:0:b0:21d:75bb:a2f3 with SMTP id g11-20020a5d64eb000000b0021d75bba2f3mr27366609wri.118.1658256355857;
        Tue, 19 Jul 2022 11:45:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z16-20020adff1d0000000b0021d65675583sm13960758wro.52.2022.07.19.11.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:45:55 -0700 (PDT)
Message-Id: <pull.1294.git.1658256354725.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 18:45:54 +0000
Subject: [PATCH] compat/win32: correct for incorrect compiler warning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'win build' job of our CI build is failing with the following error:

compat/win32/syslog.c: In function 'syslog':
compat/win32/syslog.c:53:17: error: pointer 'pos' may be used after \
				    'realloc' [-Werror=use-after-free]
   53 |                 memmove(pos + 2, pos + 1, strlen(pos));
    CC compat/poll/poll.o
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compat/win32/syslog.c:47:23: note: call to 'realloc' here
   47 |                 str = realloc(str, st_add(++str_len, 1));
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

However, between this realloc() and the use we have a line that resets
the value of 'pos'. Thus, this error is incorrect. It is likely due to a
new version of the compiler on the CI machines.

Instead of waiting for a new compiler, create a new variable to avoid
this error.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    Fix error in response to compiler bug
    
    See [1] for an example of this error in the wild.
    
    [1]
    https://github.com/gitgitgadget/git/runs/7413762368?check_suite_focus=true#step:4:297
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1294%2Fderrickstolee%2Frealloc-error-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1294/derrickstolee/realloc-error-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1294

 compat/win32/syslog.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index 1f8d8934cc9..0af18d88825 100644
--- a/compat/win32/syslog.c
+++ b/compat/win32/syslog.c
@@ -44,6 +44,7 @@ void syslog(int priority, const char *fmt, ...)
 
 	while ((pos = strstr(str, "%1")) != NULL) {
 		size_t offset = pos - str;
+		char *new_pos;
 		char *oldstr = str;
 		str = realloc(str, st_add(++str_len, 1));
 		if (!str) {
@@ -51,9 +52,9 @@ void syslog(int priority, const char *fmt, ...)
 			warning_errno("realloc failed");
 			return;
 		}
-		pos = str + offset;
-		memmove(pos + 2, pos + 1, strlen(pos));
-		pos[1] = ' ';
+		new_pos = str + offset;
+		memmove(new_pos + 2, new_pos + 1, strlen(new_pos));
+		new_pos[1] = ' ';
 	}
 
 	switch (priority) {

base-commit: 71a8fab31b70c417e8f5b5f716581f89955a7082
-- 
gitgitgadget
