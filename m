Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FD43208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 12:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752935AbdHOMxf (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 08:53:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37250 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752916AbdHOMxc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 08:53:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id t138so1357356wmt.4
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oGWog2b4mk6qWLMBEk++X8mfhG+++WoBJuqde43SbiM=;
        b=F4E9SLo1hj+4ILuJU1VsqyRuCtO8P0Sb0DN5NvAGL6oBkPUcMeVcyVlxG/k0OyCuZT
         WcJYol2vK/a9iCEeZJoJ3xDFIy7RvwAK92LlrpNHXAeTIa4743DHUOBbO2iEsu31aiIJ
         pc6KhAacr09fpeYXEyWr2dY1QKDsiN3Lr+0JwWwbLv5t1AHciHzLKu4TYa/uTJjKew5S
         YDtTQOZVZs2lQ9HDRx7qqZFnCzACxBWg2c0RU1NB0jaBSpJB0omehlr4iTgI/KxEgVUZ
         bEgNqN4e1obx5WmaUXst67vTcNT0MMcnVTYgGauUJJHlY30lyIGLoaw01p/gPyLqSC36
         j4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oGWog2b4mk6qWLMBEk++X8mfhG+++WoBJuqde43SbiM=;
        b=bsschcbNHeGhLZRjkQ971y0wSqf90GgivRHzOAz8Gs1pvMWbywDcIoSSWCfXj2XQYB
         yI8f8lO6IYFSJhEWCSicZQIOG2wsb/oZuoK18Gcs6aDCUj8b5aQ8EtjynKNMLF8LaOxN
         +JrYZFLfDRkv1JTzA/u7lSzplMIbEC/UgCFkG36lnCLB/Y09wbew7f0L5xdtNcoTuGHJ
         0KgNAAXtQI2LF283RovpFjf+RyZv/YuIh76hbVh6gdLCxHORxBoqPj4yw4abJIW1Ow5z
         9PsURxCLBmZWpN6z+6uH9DjASnBfUgMcHjvKVTd1HKeS8trVYVIkhN9mlncQl6JBPmqF
         LiRA==
X-Gm-Message-State: AHYfb5j26xfVfkK5+C45MSmNuYyh3h6Lrbce42dqIRO+uWVxIIKp2dg9
        aBO48AiRzaJLHbLg
X-Received: by 10.28.99.196 with SMTP id x187mr1225161wmb.125.1502801610188;
        Tue, 15 Aug 2017 05:53:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id k14sm4006617wrg.11.2017.08.15.05.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 05:53:29 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 1/5] convert: initialize attr_action in convert_attrs
Date:   Tue, 15 Aug 2017 14:53:01 +0200
Message-Id: <0fd7f3184d285df8867ea44dd1adf418ebfc5ef3.1502780344.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.gdfeca7a7e
In-Reply-To: <cover.1502780343.git.martin.agren@gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

convert_attrs populates a struct conv_attrs. The field attr_action is
not set in all code paths, but still one caller unconditionally reads
it. Since git_check_attr always returns the same value, we'll always end
up in the same code path and there is no problem right now. But
convert_attrs is obviously trying not to rely on such an
implementation-detail of another component.

Initialize attr_action to CRLF_UNDEFINED in the dead code path.

Actually, in the code path that /is/ taken, the variable is assigned to
twice and the first assignment has no effect. That's not wrong, but
let's remove that first assignment while we're here.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
I hit a warning about attr_action possibly being uninitialized when
building with SANITIZE=thread. I guess it's some random interaction
between code added by tsan, the optimizer (-O3) and the warning
machinery. (This was with gcc 5.4.0.)

 convert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index 1012462e3..943d957b4 100644
--- a/convert.c
+++ b/convert.c
@@ -1040,7 +1040,6 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 		ca->crlf_action = git_path_check_crlf(ccheck + 4);
 		if (ca->crlf_action == CRLF_UNDEFINED)
 			ca->crlf_action = git_path_check_crlf(ccheck + 0);
-		ca->attr_action = ca->crlf_action;
 		ca->ident = git_path_check_ident(ccheck + 1);
 		ca->drv = git_path_check_convert(ccheck + 2);
 		if (ca->crlf_action != CRLF_BINARY) {
@@ -1058,6 +1057,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 	} else {
 		ca->drv = NULL;
 		ca->crlf_action = CRLF_UNDEFINED;
+		ca->attr_action = CRLF_UNDEFINED;
 		ca->ident = 0;
 	}
 	if (ca->crlf_action == CRLF_TEXT)
-- 
2.14.1.151.gdfeca7a7e

