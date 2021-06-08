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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C17DC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 20:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562D761108
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 20:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhFHUuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 16:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFHUuz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 16:50:55 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3B5C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 13:48:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l1so34810277ejb.6
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 13:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LTUIJwXrx01MRgciybUuqNFduhxt90GX80yWMZZ0qDk=;
        b=ke8GRXXHcPddlz6tS1zFoydDI3VErbnTNM3Nqz04VKTYbd/VadRpPAKIrsLNBO/CyX
         eQ0TOBgO6u0xKdCFqmLPclm8kq7JRUQlOdQ3Cvb8bXqy/llf+qgmlqgx8mUMQHUr4rZI
         EICFQdVxDR4BQZa2B4M9C2sS1uk97GwKWybSAQfMdjU2T92BzBYW5dYZYZY8l4gZfPx8
         EBqKqR50HeKMYPxFawKpc9CR4pyOT+SEtBrhh9oB/am/6R0nuvZfWvwjJMscRPAhninP
         FwKqna2JXRD8vt+Bs9VF5jOIfD2spXR2QtfDa260QfjuVmPJQQKIBaHCq2C2viemY8IU
         VaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LTUIJwXrx01MRgciybUuqNFduhxt90GX80yWMZZ0qDk=;
        b=j4zrP7stWyWrr0cNoxZ/mHFJ/tsRmeu0YtuM3PLdtPygRI/qhgBOSPg2dfy5ZotD0c
         2Qx11rdfFTrzjuTHwMBZcaprhaSePM5cUdfNcV46bgp2tjoZeOjYu3QdZYYxx1obDlEN
         XG5oThSUssJQGQ9vnauYiTTdi2l5gviCLF2MWbn1+r+b8+gCYi2ay3+06u41w+0bFX9t
         euKhgrV4ElrnH025cVCqnTXstqUcys5+thoV45Ww43Os+WB96ac4+M6flERh5Cugwu+y
         rOhOYP7ST8/kmtrRyYToJfQnOPjCdtNo4NkiIDoJC8+Ey9ZgcZfzvn4hansltLVQIV34
         JmQw==
X-Gm-Message-State: AOAM533YHroL0oG3bPwzTH7Kgzn5N6zh9+Zwdw9cBQC8ETYNJJH7EfLO
        yieaTDUOFt7ik/79JwntwevgOUCjgEs=
X-Google-Smtp-Source: ABdhPJzCQKtDuExmdge/ymzOwdpPb64b3N0N3bkSWXNi4Hyu8xZwvS7Dbfhstf8pMSi+Wi45rM1OYw==
X-Received: by 2002:a17:906:b754:: with SMTP id fx20mr23956774ejb.201.1623185325043;
        Tue, 08 Jun 2021 13:48:45 -0700 (PDT)
Received: from localhost.localdomain ([212.102.57.83])
        by smtp.gmail.com with ESMTPSA id dy19sm299133edb.68.2021.06.08.13.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 13:48:44 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH] mailinfo: use starts_with() when checking scissors
Date:   Tue,  8 Jun 2021 22:48:41 +0200
Message-Id: <20210608204841.2793591-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20190401215334.18678-1-rybak.a.v@gmail.com>
References: <20190401215334.18678-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Existing checks for scissors characters using memcmp(3) never read past
the end of the line, because all substrings we are interested in are two
characters long, and the outer loop guarantees we have at least one
character.  So at most we will look at the NUL.

However, this is too subtle and may lead to bugs in code which copies
this behavior without realizing substring length requirement.  So use
starts_with() instead, which will stop at NUL regardless of the length
of the prefix.  Remove extra pair of parentheses while we are here.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 mailinfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

This patch was originally part of:
https://public-inbox.org/git/20190401215334.18678-1-rybak.a.v@gmail.com/
I've finally gotten around to sending it on its own.

diff --git a/mailinfo.c b/mailinfo.c
index ccc6beb27e..8013e5c566 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -705,8 +705,8 @@ static int is_scissors_line(const char *line)
 			perforation++;
 			continue;
 		}
-		if ((!memcmp(c, ">8", 2) || !memcmp(c, "8<", 2) ||
-		     !memcmp(c, ">%", 2) || !memcmp(c, "%<", 2))) {
+		if (starts_with(c, ">8") || starts_with(c, "8<") ||
+		    starts_with(c, ">%") || starts_with(c, "%<")) {
 			in_perforation = 1;
 			perforation += 2;
 			scissors += 2;
-- 
2.31.1

