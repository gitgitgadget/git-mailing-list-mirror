Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92E901FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 20:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759371AbcLBUbd (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 15:31:33 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38659 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759276AbcLBUbb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 15:31:31 -0500
Received: by mail-wm0-f47.google.com with SMTP id f82so25842530wmf.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 12:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TTGL6k++qqLlfsiE+/JNCh0ibRlZtJnZU5geTe+Bfz0=;
        b=BzwOAfIjXSmo2p9A9zvs/hQsajKPb4XL3b5XbJbQ9uHb0Vwg+Ga3fWCVc0aLZNolq8
         6aLkKUk01F/2Qp1gtcrUsD+m8IFE0cI8w+e9F+IaLy1mmunQXmnJzdTYxd1lf4ETpUQg
         lxzl0xBM+zcPYkjSeUdjkfeAcAYwhhrQ5ZXw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TTGL6k++qqLlfsiE+/JNCh0ibRlZtJnZU5geTe+Bfz0=;
        b=MzVPqfqfvHsWYyMmKo42lBza+pgIU/HZOeqpbiaQ4gx1jbf9qakMrslqPxRtb4TEA+
         cIkldkk13/+oaBIFIDQIOm5tDAXuc2SS4iClXsJ3tBVDmR4klJzpU+ObeQF7rEGy1hjp
         8lc4ZC1wyMWF2rAPRtjwceIjv/Ao1GXf64HZLn0P2cxtU+YWJjlX8LQchWB0pDcc10aM
         1K5mlrOKjypFzUKI+ywfLNWVSolLLxCpk2HyOEbIKPt/+S5yBC7QWxLhhuWS/W1hnIuG
         0+ZUMzzlHT67KnYqPjMN0NMYoFE9ILTNdPZxIC2imPA32ZTGxrs/t1N4knN7JSwwgtBf
         V1Uw==
X-Gm-Message-State: AKaTC03/TbSAANlVqlz8i7c6KcPu2pH+hPNyVIUCjGG7s6KdJ703fyOeynWD8238JhE30Q==
X-Received: by 10.28.45.142 with SMTP id t136mr5016725wmt.110.1480710689526;
        Fri, 02 Dec 2016 12:31:29 -0800 (PST)
Received: from lvps87-230-87-209.dedicated.hosteurope.de (wildmoose.dk. [87.230.87.209])
        by smtp.gmail.com with ESMTPSA id w79sm4938178wmw.0.2016.12.02.12.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 12:31:29 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 4/4] shallow.c: remove useless test
Date:   Fri,  2 Dec 2016 21:31:04 +0100
Message-Id: <1480710664-26290-4-git-send-email-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
References: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems to be odd to do x=y if x==y. Maybe there's a bug somewhere near
this, but as is this is somewhat confusing.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 shallow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/shallow.c b/shallow.c
index 5aec5a5..7c28239 100644
--- a/shallow.c
+++ b/shallow.c
@@ -513,7 +513,7 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
 							  p->item);
 			if (p->item->object.flags & SEEN)
 				continue;
-			if (*p_refs == NULL || *p_refs == *refs)
+			if (*p_refs == NULL)
 				*p_refs = *refs;
 			commit_list_insert(p->item, &head);
 		}
-- 
2.1.4

