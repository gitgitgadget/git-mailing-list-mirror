Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DA611F454
	for <e@80x24.org>; Thu,  7 Nov 2019 02:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733005AbfKGC4l (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 21:56:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36539 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732951AbfKGC4l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 21:56:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id v19so1233688pfm.3
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 18:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sPwxgMFZsnNCCpqtGpHp7xTb3U1N7gEpS+lFfXjpOTA=;
        b=fOCrA1g6BgP0C7y6IiQMgO/hou81I4jumjIwtE8jPH9X2lJNDrjVhpX/wG+6G4L4BT
         j3l59kYe5LyePIMwbszoWIfiPUOkxYwcvBOkgw5cW5jjpQgTmwVMai3fkswzf5YeT9F/
         i06sac/6zJJ8tZ7vivHsaNX3a/eVCvC2BNgR+0ZxiN95yIkYQ0CWlBhrho8OG6+NPiUq
         zSHIIEc0qTVjl4UHZRJhcZO867o1mlmi/z0RJWrJuTWl7zAwEkL3yAHIZI23KoHfhHMq
         CXYvsOWy2rHVxtbZGkhXUnePpeZBmR6gGuHY+GSYxGHHVOOnLesulRsmn4qUoT7EBsrw
         YQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sPwxgMFZsnNCCpqtGpHp7xTb3U1N7gEpS+lFfXjpOTA=;
        b=jE5UtTN3DWOZw390bIinQ/TnfGhgt9KBPYn20e2E5Vb1pCIcVsED+tn3nskeGa+cZL
         YLX/c4UK9hhzGcdWWFG7w5y0AR3xzdYTsKb7gFgILLxUs3ChcGZAZzMoV83B6wEI/TB2
         EFVM7KxKuDM3Da1nRPrDm/AzZQU2jvrvnJj894bDQncIYrpahxZ3lWtLVTdhemdGchRn
         FiHDs0d/K++xnin4rB3YnxY8ZBO4WhNKtaa99TRWc5bSBu0x/3PbCvSLFzRtt9gcyIpM
         8jFdC55KHCDHnXOpjkfCf4Zk8FbzkEMBxGFo4BBME5pWjmikqgW8Ul77KyPSrPYJ8sVg
         WyMA==
X-Gm-Message-State: APjAAAXKYaicvbIb79JrAe9F198DYUpm5tSbP/8HCCGx/kxszZCqQIWv
        6t3HyvYdn83qRlmzN4FXVvHUML5t
X-Google-Smtp-Source: APXvYqyhGScqMOvZDYwizt8YGG9wkbc2erXwBmggn54np37LlbVCv9pofxN6EvcMcz77cNkdR2d3Xg==
X-Received: by 2002:a65:628d:: with SMTP id f13mr1484547pgv.241.1573095400346;
        Wed, 06 Nov 2019 18:56:40 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id n15sm393767pfq.146.2019.11.06.18.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:56:39 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v4 7/8] sequencer: reencode old merge-commit message
Date:   Thu,  7 Nov 2019 09:56:18 +0700
Message-Id: <f295d32d7b1c1090aafeb5bdae03473e35db170a.1573094789.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.8.g36796e2b67
In-Reply-To: <cover.1573094789.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573094789.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During rebasing, old merge's message (encoded in old encoding)
will be used as message for new merge commit (created by rebase).

In case of the value of i18n.commitencoding has been changed after the
old merge time. We will receive an unusable message for this new merge.

Correct it.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 833a928929..d735d09f98 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3374,7 +3374,8 @@ static int do_merge(struct repository *r,
 	}
 
 	if (commit) {
-		const char *message = get_commit_buffer(commit, NULL);
+		const char *encoding = get_commit_output_encoding();
+		const char *message = logmsg_reencode(commit, NULL, encoding);
 		const char *body;
 		int len;
 
-- 
2.24.0.8.g36796e2b67

