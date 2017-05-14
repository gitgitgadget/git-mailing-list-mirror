Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1301120188
	for <e@80x24.org>; Sun, 14 May 2017 03:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757675AbdENDQI (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:16:08 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35073 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757197AbdENDQH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:07 -0400
Received: by mail-oi0-f67.google.com with SMTP id m17so14323830oik.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GPaxsS6ZMoYAX2gI+S92H3avN/C5GxYyizHsaqhQARQ=;
        b=kLMpYp6Ig23TOff81uMZKz8ytUWdtjFjA4yX6/AopNjPLe9p3Xtn+EADfWKJlfO8UX
         UZ1Mog2pzybO3vI1ibALBNc5RjwsPsSavcc1nKZxsQy7e4/OtZVQEuj36Ry8dBU5WC81
         pZ49hpxTWW6JOdlp1gT+PkOjla+kzM7Xb6x8pIdcOFzzLGz/6KhZA+iYJXw9++1O544Y
         qZzWqhbB6mhPuCzGijyjgOXeE2iKF6BEaQprl/sQs8Ka4CiS3+GZNh3jruL+j2yL8NHY
         V1eLpml2Yde6RE8kABs05hHmhmo0qK7lMV3yoA8QppqrdMb/CRjXd3IGIUmRaVnXsU+I
         atmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GPaxsS6ZMoYAX2gI+S92H3avN/C5GxYyizHsaqhQARQ=;
        b=TFec2UVUpvdByNMtFNJrBDs7UWuXdCUPHPdRrP/vJGqfudP/5OzJoMmy/BI+kk8SUo
         pSYBU9st8GSMklj+k6+TCehIU+s5mQMRRJJkwjKcYdGFCl73yD5RkJbBzAM4G+/+4R1a
         Z2psQKWaEAoKRVQRnOZwn2agjmObu5bX0g1FwRM9TrvtpfVjQIAwoJwMVe5t2cNeMfK6
         6PPTEp7m0Unw6ag5QDO21/i2DUkd44peYbw+niXUpVn8NDEXclJCessVQjgnFQk45zAu
         KLnZIDNuW8wHYI5lbtXSzmWVhRqhBpodHY12EW3Rc6BUPtbMAWgCOmnN6H+KOmRpiyZi
         km2g==
X-Gm-Message-State: AODbwcBC/vPsIxI15YQzUHpktao+Vppf7WcXhOa4JNxyUrjLQYZflDOF
        aUDexFxAa4DFSHROipw=
X-Received: by 10.157.82.136 with SMTP id f8mr5032267oth.135.1494731766799;
        Sat, 13 May 2017 20:16:06 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:05 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 01/22] blame: remove unneeded dependency on blob.h
Date:   Sat, 13 May 2017 22:14:52 -0500
Message-Id: <20170514031513.9042-2-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With commit 21666f1 ("convert object type handling from a string to a
number", 2007-02-26), there was no longer a need for blame.c to include
blob.h but it was not removed.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 07506a3..42c56eb 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -8,7 +8,6 @@
 #include "cache.h"
 #include "refs.h"
 #include "builtin.h"
-#include "blob.h"
 #include "commit.h"
 #include "tag.h"
 #include "tree-walk.h"
-- 
2.9.3

