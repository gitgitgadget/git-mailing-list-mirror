Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB01E2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965795AbcJ1SzZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:55:25 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36843 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966136AbcJ1SzX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:55:23 -0400
Received: by mail-pf0-f177.google.com with SMTP id e6so41411628pfk.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XQRb2/U1fd0YjemKNJL0Ei30kMUJX2UAwjtwXX7C8VM=;
        b=fzNS+vTbDiZDq5aNfIIEeW1MoMmlg3GKtolglbBhMUUlRefR+FuSbAV3DbKGmxan8/
         dbch2JodSxDEHJnwsVecm0Ul484yw05a0uXMx5DKgone9brU9/gA0emUIaG7Ft99tBCk
         bPrIBipihb+1VP97WoS38l1BvujpLs4c+QvTiOdF4Xzb845qLl1i0RFY/Mh7uHbyWPj8
         JCjnDs5gvZZw9ySl2ADEuiRXT8ObTUjMGxn2V4GdCbz7E5zNEF+aBLoGcChfBJIJJWz8
         eRp80/cq7r7l2u4c6BhQvSPInVVzC8RiI+P+xvEeg991VSI88ymcfaUYQs/vmxVhYW4e
         JgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XQRb2/U1fd0YjemKNJL0Ei30kMUJX2UAwjtwXX7C8VM=;
        b=Bk9AUr50WIpBhq1x2YMNFycoJlVDlnFnwoxiPl7cByJyoBJFqznQjSxq7HY6yhN7k2
         YhGBxJpMU7G+oFVXrsG8kRkvUm2JbLoaFGCkjOC2ACy6TjUjP41yIX9BUaUu3VcttrC6
         sshchlNrsnQh1aNAyDOu6w4ZjtMTBufUWC2QFDeTzdO9u1QjvcU7DKijNlQgE20Z7Saq
         CdLUuQQs9v0rYDHUNKlUpI+Duuy3OvJsx7PavwlYXd3mny3eyZEPgflnhjrl0G1pOTKB
         OsgW+cXunaH8XnjpJStELYqYGVEtcBRnrOSPJwNlJRmRY1KbHxQ+neL43XAXy8CK1lBc
         /2Nw==
X-Gm-Message-State: ABUngvda3+5rEhddzYzds137gCeyb3xlwYZ2KWAnHHIHVNcuLxBB0j+bbBKaSD7dv0ZVCDlJ
X-Received: by 10.99.237.17 with SMTP id d17mr22732963pgi.48.1477680922530;
        Fri, 28 Oct 2016 11:55:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id k7sm20629782pan.8.2016.10.28.11.55.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:55:22 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 02/36] attr.c: use strchrnul() to scan for one line
Date:   Fri, 28 Oct 2016 11:54:28 -0700
Message-Id: <20161028185502.8789-3-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 1fcf042b87..04d24334e8 100644
--- a/attr.c
+++ b/attr.c
@@ -402,8 +402,8 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 	for (sp = buf; *sp; ) {
 		char *ep;
 		int more;
-		for (ep = sp; *ep && *ep != '\n'; ep++)
-			;
+
+		ep = strchrnul(sp, '\n');
 		more = (*ep == '\n');
 		*ep = '\0';
 		handle_attr_line(res, sp, path, ++lineno, macro_ok);
-- 
2.10.1.714.ge3da0db

