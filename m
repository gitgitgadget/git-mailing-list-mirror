Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2312220370
	for <e@80x24.org>; Thu,  5 Oct 2017 20:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbdJEUcm (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:32:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:57297 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbdJEUck (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:32:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id l68so4384470wmd.5
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B+lKnVyk8nRPPgMdh+gmIaM1hrCqPruuulsaXaAkc9A=;
        b=Baj5idw14fNdHSE/3XSs0TBr1++z90JGXDqnbFAM8Kz27ml0uhG2t38wfoIw6Q4g7R
         6l2orFDStBjH4GJLDtoKzUPQzrg632pzRZ3aPqfofqKY5NbkA1YsmvB99ylsyJUM6of0
         16mZXbN0P+4MfCCP8IHpc69p1HBjygXu9KrwPfbN8VzQaV4xFZLxy4hj0XBF9vp4NGBq
         W2dQpNKRMxsnZs0/DNtDP1iZ9zdz1xiqiDybZOeb4VXRjuXYiVHHUXVfLN9KJInFjSdL
         A/dLBg0kEiQfDuUG+/Y7g3VUAkEdqofuRaxwkZk2sPtBV0g0HQL5hVk6PZ0qti95Wyeg
         XVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+lKnVyk8nRPPgMdh+gmIaM1hrCqPruuulsaXaAkc9A=;
        b=NLNy4mT5nH60VswRwzDxtSLywyMig1N3xHxCVGzs3ZuleM+ESN8u/05ZJnk9+7ydB0
         opPTxksnxdJYkZ/v1nDDjrF45bQ8R0So2/gYdLdc3ceT2mdljp3FCK9X/3gx/ud7sUFR
         Rgb4F6yF1qroFBcJT9O1UhyhFN0TPc3mF/rd3IxfbW5CAqHKY4rFi7II9gCdsymNXYRq
         /ioh9e+R48hJ0OEc6K8IpKBWBJ+u3hyX/JWW3oTopiuFyU8tvvimmNkBgpt76z4F5f4+
         DxXeAkrG5fWbz9hVq2nvDZpt+a9b6s16uJ+LA7FJuW1a5jXP8xn/fsCOadssEl7dUbg2
         pK4Q==
X-Gm-Message-State: AMCzsaVJYNswJghNW6rvIHEyEqDm3f5YaBhdr8sySHO8KSOj2QN1zN4U
        VKP41dm7aDnXzy7adz8TrFLOqhQg
X-Google-Smtp-Source: AOwi7QARk01W1Rep0IT/YItLYQxK4Ok7Tcu5ToQ9Vyz7gE3zs6LYn/qUoxBxvJMnnTbVyTKMBPLVgQ==
X-Received: by 10.28.67.133 with SMTP id q127mr262229wma.71.1507235559480;
        Thu, 05 Oct 2017 13:32:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id i76sm698424wmd.2.2017.10.05.13.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 13:32:38 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/12] lockfile: fix documentation on `close_lock_file_gently()`
Date:   Thu,  5 Oct 2017 22:32:05 +0200
Message-Id: <bbb578e7d1367353d464d5196e0bbfe0a27af6ac.1507228170.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.2.666.gea220ee40
In-Reply-To: <cover.1507228170.git.martin.agren@gmail.com>
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com> <cover.1507228170.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 83a3069a3 (lockfile: do not rollback lock on failed close,
2017-09-05) forgot to update the documentation by the function definition
to reflect that the lock is not rolled back in case closing fails.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
v2: Identical.

 lockfile.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lockfile.h b/lockfile.h
index 7c1c484d7..f401c979f 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -240,8 +240,8 @@ extern char *get_locked_file_path(struct lock_file *lk);
  * If the lockfile is still open, close it (and the file pointer if it
  * has been opened using `fdopen_lock_file()`) without renaming the
  * lockfile over the file being locked. Return 0 upon success. On
- * failure to `close(2)`, return a negative value and roll back the
- * lock file. Usually `commit_lock_file()`, `commit_lock_file_to()`,
+ * failure to `close(2)`, return a negative value (the lockfile is not
+ * rolled back). Usually `commit_lock_file()`, `commit_lock_file_to()`,
  * or `rollback_lock_file()` should eventually be called.
  */
 static inline int close_lock_file_gently(struct lock_file *lk)
-- 
2.14.2.666.gea220ee40

