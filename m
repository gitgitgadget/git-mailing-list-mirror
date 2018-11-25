Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6FD81F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 16:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbeKZDLx (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 22:11:53 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43215 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeKZDLx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 22:11:53 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so14995941qtj.10
        for <git@vger.kernel.org>; Sun, 25 Nov 2018 08:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WBrKHY6Fbe0KXOViJS++UgY4Qf0aXd3sXC4He0+1W7k=;
        b=sz5daa+wuJnyDehor6YlVnY/kOZA+nljRQUZ9jZDHOznz9G1vVXPSo96Bn23l0ON6W
         ScBKt3qaDNY5YOyWSlryrDKfnuMXXkIrqK7EUqgs9Uc+Wp9vKA+5DlnAvWor/PWx1sw9
         MCVa8t+F1bAdb+/KLDWSXITz6ziV1mTaLwkknZ4NMWLgKeLQ+mh3Myk80YL9GP9DXqWY
         lPewsIqSHYWuvZjV0X9guES8Qq5Gv1v4KPmID/Sy4trWWOwOgk499vnWdP77AzWr5+Xo
         WNUu8sFaYGsmb9H3eRY7YWs2xgr7KhVCn5iJs3Vfn4JQxy2ypCa6/t3u4vPN+c7fAycV
         1WyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WBrKHY6Fbe0KXOViJS++UgY4Qf0aXd3sXC4He0+1W7k=;
        b=eOSAziFkqyQjT68WHqcdOjzUJvLJ/SF1oCWuifoL08Ihn7vXTKX15xKjdmTMaOc0GN
         yASDmjs5yfLK1ugWRHiz3cxl76CaGRcAprxBPB9L5dRGOg2vwRD0MylVeQOfrrU7f9Xt
         GnflBMC5kuJCkkOyJJ5VoVPej0+MWQjJV4RrCjG0KPcRDSr9G9+UBlSt1RjYV0SKBsAk
         cVLlgBnezEJ+OD/viCJpVmO5dvfk1xela/zXP01mD9DJd8gaFK0dZvs8vkYwpHYgWIuo
         9zAsfb7jWkVoCdUlRypN+STlewjeVZzI9sdIo7w3T15ycveQ1HcAnFKSzFqlZbhhA5Jy
         D8oA==
X-Gm-Message-State: AA+aEWY/qiHWMsnoePHBt6NuT3gUoS/KKAmHiBMA2hcSO9+h3rtfMm4s
        2RbgfDZxCCfGNjimKBzEXr+YyUeD01E=
X-Google-Smtp-Source: AFSGD/XmooOq/NzBJbW8NUGLLZNe7dZN/Z6nqq/WGXn+XDaloOyXz5KwzHdko0b60bf7kvxNT7Ah1g==
X-Received: by 2002:a0c:d124:: with SMTP id a33mr22388560qvh.19.1543162827939;
        Sun, 25 Nov 2018 08:20:27 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:109:2423:3058:638:ee17:de8f])
        by smtp.gmail.com with ESMTPSA id n67sm23390925qkd.95.2018.11.25.08.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 08:20:27 -0800 (PST)
From:   pedrodelyra@gmail.com
To:     git@vger.kernel.org
Cc:     Pedro de Lyra <pedrodelyra@gmail.com>
Subject: [PATCH] setup.c: remove needless argument passed to open in sanitize_stdfds
Date:   Sun, 25 Nov 2018 14:20:08 -0200
Message-Id: <20181125162008.30065-1-pedrodelyra@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pedro de Lyra <pedrodelyra@gmail.com>

Signed-off-by: Pedro de Lyra <pedrodelyra@gmail.com>
---
According to POSIX manual pages, the open() system call's mode argument specifies the file mode bits to be applied when a new file is created. If neither O_CREAT nor O_TMPFILE is specified, then mode is ignored. So I guess that 0 argument only confuses the reader.
 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 1be5037f1..d4fd14bb7 100644
--- a/setup.c
+++ b/setup.c
@@ -1228,7 +1228,7 @@ const char *resolve_gitdir_gently(const char *suspect, int *return_error_code)
 /* if any standard file descriptor is missing open it to /dev/null */
 void sanitize_stdfds(void)
 {
-	int fd = open("/dev/null", O_RDWR, 0);
+	int fd = open("/dev/null", O_RDWR);
 	while (fd != -1 && fd < 2)
 		fd = dup(fd);
 	if (fd == -1)
-- 
2.17.1

