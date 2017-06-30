Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347BE202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbdF3AHh (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:07:37 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34268 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbdF3AHa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:30 -0400
Received: by mail-pg0-f48.google.com with SMTP id t186so55414442pgb.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pmtV7V2W9b0dcdFM/2i4iMM6gNB2LQA/soS6ZhgafWg=;
        b=d+xm3BlqHDFEXZwz+6B1srS3y3wb1911sd0/xgCbr1QnP74r2EQdFribzgohqjZ7NY
         Ql0RmZgi0eyg4q5Bk0zLBn/ohbyP9Wf+vgiBJPofm/QATscQYTgD5Stf1oLs00pGyAj0
         JEnHlpV+miPA1bgawIpPv+kBFshhyQaJ7Bs0RCmib4klQdPRA13lnYNe0AV0NEGEXJ11
         haJKZ+Qplt/nOQFqB//WQTF7eUhfRMCuXa4pVZGg5DJeY1UtmSOjW23FmXnIEoivd1OA
         h8Daeq5uZ19XWW+fmgXI32oiYWtVFVNBtdHSIloLxNxvadyltEww/D2pO4omktymCc0j
         9JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pmtV7V2W9b0dcdFM/2i4iMM6gNB2LQA/soS6ZhgafWg=;
        b=ID/4GIEHMCM8d28nKRKYL7XhZfyL411gCTvKGSYq44BUleD/77Nrv+Bla5CKCK86vc
         DpKAOLui1u6yLNxVLiMXr0jf/RcSyy6FEBIIwIV3YGsVKEJ8RoKGn5X+qDlam54/QQ4N
         yuyTt48/6SF4zbuGSVQvmlRuy5RIkW3qFPif8Ccgzr9Z2gIK6nZDBMydT2FPwA+rriIk
         NdoeX/IvCM8TAmHaUefx8lXZrI/i9uMLPPK12Wj7XdOFB/ramVCy1xk6Q69pTlLXq06A
         QhI3nI7m06jjN8/KGgYlFMnRZUVGJOt0e3IFCch2VXOsSXO9iZhBg35teWE96YoCeSMp
         C2yA==
X-Gm-Message-State: AKS2vOzKFJG0jyTS+1j9CpLcKDDwvNvFn7V9uTQlVmCRBkRU2tTBGqRf
        ngjffBKc6b0KGwKO
X-Received: by 10.98.71.84 with SMTP id u81mr19288359pfa.102.1498781244425;
        Thu, 29 Jun 2017 17:07:24 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id t26sm15953522pfe.88.2017.06.29.17.07.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:23 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/25] diff.c: readability fix
Date:   Thu, 29 Jun 2017 17:06:46 -0700
Message-Id: <20170630000710.10601-2-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630000710.10601-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already have dereferenced 'p->two' into a local variable 'two'.
Use that.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 00b4c86698..2874dfc6fc 100644
--- a/diff.c
+++ b/diff.c
@@ -3282,8 +3282,8 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 	const char *other;
 	const char *attr_path;
 
-	name  = p->one->path;
-	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
+	name  = one->path;
+	other = (strcmp(name, two->path) ? two->path : NULL);
 	attr_path = name;
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
-- 
2.13.0.31.g9b732c453e

