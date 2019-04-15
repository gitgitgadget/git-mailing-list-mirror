Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D497C20248
	for <e@80x24.org>; Mon, 15 Apr 2019 18:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfDOSZC (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 14:25:02 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:32980 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfDOSZB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 14:25:01 -0400
Received: by mail-pg1-f178.google.com with SMTP id k19so8999994pgh.0
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eiUr6JG6nsK8Q3H7CeTrBcSC+ILAqF0BdYazJrYxwPw=;
        b=XnenxeKmgtnvhwIGtR4RMLZ4CiN8tUL9bPe2MYBdJeDHvScQSV5Xp4bmTm0X7eL+4t
         7SAJOBuPb+rpt734yfY7m/MJapPOVb2dcnCFyIeur15QVEBaGGzx0ZWB4v7zUwKinDZU
         pT56IEFQqBx80BVp8q/bDSlAuhTD8x7muUV/82kyT30r/aXTgDA3IGTAIj2VpuJlKPwl
         RE6kIJh4SWg0wtrM1pYec7DrCc10Wk5XcdEzMtlYPqz8i6k4hyG4rNI7f0ann4BA9KGS
         mBZfTjcVmbsDUDtjCsqTK9En71DDBXVZ5N7sHB3BcgEWpv/t0VLcQl33o41LLC1xFKYD
         t+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eiUr6JG6nsK8Q3H7CeTrBcSC+ILAqF0BdYazJrYxwPw=;
        b=TdVSEXyORG4yReQsQX66jiItQMJiPaKq9A6jkp03y+nj3bn9TbuVfs2ICXa8fgFn8v
         MHSnxTStx4bgMsk2PWRomBpH82ABQD0pZb3WiJL9uI+NSNM5yIvfYboreo81Vx16+Tbr
         0Q7IlJsWV4QUdQKq8kpfXRKQr4TVQYwWuYMbiQFxdQQ0/hmIWIx7P+6sg4R4NmUlmiN4
         TPBFzDZkdTDTN4DHA4eRKoC9ntHc2NAdrSuofw+ZIvOc9CVhnBFgQYOEt9wOZEC9aNqc
         OSnq6a6lLIRd2VP8F9I1wNMgRLJF89IlApm/RYJbEb7zuLAxCB+JYw9zDg6eSm87A6pJ
         oKTw==
X-Gm-Message-State: APjAAAVVXIUZgw+4BhxVPVOM/zrWE+waSZ1dzLNg2Yr+F1ameiHPh95/
        ABsH++GakGSKE5v7PogRtPJhjOw5
X-Google-Smtp-Source: APXvYqzuXCCdLzdNqOOt+/JPXV/yXaUG5GTKk5ogLeg8MX4aANEpiJsAGLCQMVzH7mrvfa7lVL8Ucg==
X-Received: by 2002:a63:945:: with SMTP id 66mr68621800pgj.128.1555352700702;
        Mon, 15 Apr 2019 11:25:00 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id p2sm153656443pfi.73.2019.04.15.11.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 11:25:00 -0700 (PDT)
Date:   Mon, 15 Apr 2019 11:24:59 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v2 3/3] cocci: prevent extern function declarations
Message-ID: <b2787f98146c20764ca528b181202f843d22f08b.1555352526.git.liu.denton@gmail.com>
References: <3e3b9d6c8e54b326809b95adabd3be39d2d0770f.1555111963.git.liu.denton@gmail.com>
 <cover.1555352526.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555352526.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since function declarations already implicitly imply extern, create a
Coccinelle rule which removes the redundant extern.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/coccinelle/noextern.cocci | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 contrib/coccinelle/noextern.cocci

diff --git a/contrib/coccinelle/noextern.cocci b/contrib/coccinelle/noextern.cocci
new file mode 100644
index 0000000000..8cb39ac947
--- /dev/null
+++ b/contrib/coccinelle/noextern.cocci
@@ -0,0 +1,6 @@
+@@
+type T;
+identifier f;
+@@
+- extern
+  T f(...);
-- 
2.21.0.921.gb27c68c4e9

