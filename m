Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA9031F424
	for <e@80x24.org>; Fri, 27 Apr 2018 17:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758839AbeD0RFg (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 13:05:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53501 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758554AbeD0RFe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 13:05:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id 66so3703467wmd.3
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=L3pmWgOODhAsEd5i1sBWaHsJ7gbGsqaeoSZa4KdlsBk=;
        b=TuhcYlEHL1VkigeMx4VwO/lB59cEf6QNTdhqm68RH603iJTSqoyAqtLsbLqQp1643T
         HZPCIfuYFjMjCb5iktUrkCNWqI9d8vmS7WNW0z4F9FEv22L0ewxjx/ll4vn/p9OFFhdr
         QNfLD9KFL8nXYPxxXL+2VKpXh+R76222L+DLyVHeUnYSryHtEERnELxF1fNzbm3kmGTC
         36rHmLQc88c7YONLylLEgT7eYXh9w+ZyGSlTLo614FD1Czc+MPlhOs/SDiJHuAh8J8ni
         /EpC5cqLIdfpJTYzRxy/mF1bvpv6JzSddd9nGSG68TW+nMD0/BLEp1nY1FKrTqjFKLBt
         G4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=L3pmWgOODhAsEd5i1sBWaHsJ7gbGsqaeoSZa4KdlsBk=;
        b=GPQ81mki148mWU7IC6PmDSSGMD7JAlusJ6vhGhEA10Xx5m3kR6c1sgANHNqWYiEHAi
         rQyOFbf7Uz+cxQUVX0Lr0UeRSzxIH7/Yav8TBFeW1ioq4LzJLF53+PZQ9LpDl17UwyA0
         ee83x5OD9eXgJzUHrBQRPI6PleGSBHnwZumR64goQjbwYq6Mr8kLrK5nY7tcMbmzpwqO
         3dA2Al+/XrSkoHSOL6aRtrdX6TJDontUsyjG7Az4XehPIFDB9XtjAL1N7tWWLAO5t7TW
         0l/Ro91z9hv2zFHPdufytg4q5jsWWFh/8gWRszLUiV0HlERq00VaoUEebzocs5WoIibb
         rs0w==
X-Gm-Message-State: ALQs6tDkC3kiFVPXbQfXR9KPGDJ2fA/aevKkZfNYNfduBli1vNoi2gaE
        Lpd72iM3hBND1/YJxaYuHlhrMTXy
X-Google-Smtp-Source: AB8JxZpgyMpumrM3oM/4LUfwvlpJPEOSFphSL+JIC8owO7w4A4c8wHoZDwcT24iJjgIdLMGRA5ujqQ==
X-Received: by 10.28.50.197 with SMTP id y188mr1993985wmy.29.1524848732922;
        Fri, 27 Apr 2018 10:05:32 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:dd1e:a7ac:6cfc:1274])
        by smtp.gmail.com with ESMTPSA id o10-v6sm1765745wrg.90.2018.04.27.10.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 10:05:32 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 5/6] git-svn: remove ''--add-author-from' for 'commit-diff'
Date:   Fri, 27 Apr 2018 19:04:39 +0200
Message-Id: <20180427170440.30418-6-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180427170440.30418-1-asheiduk@gmail.com>
References: <20180427170440.30418-1-asheiduk@gmail.com>
In-Reply-To: <20180410183224.10780-1-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The subcommand 'commit-diff' does not support the option
'--add-author-from'.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
Signed-off-by: Eric Wong <e@80x24.org>
---
 Documentation/git-svn.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index d59379ee23..e9615951d2 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -707,7 +707,7 @@ creating the branch or tag.
 config key: svn.useLogAuthor
 
 --add-author-from::
-	When committing to svn from Git (as part of 'commit-diff', 'set-tree' or 'dcommit'
+	When committing to svn from Git (as part of 'set-tree' or 'dcommit'
 	operations), if the existing log message doesn't already have a
 	`From:` or `Signed-off-by:` line, append a `From:` line based on the
 	Git commit's author string.  If you use this, then `--use-log-author`
-- 
2.16.2

