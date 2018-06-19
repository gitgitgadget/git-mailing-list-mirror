Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 823061F403
	for <e@80x24.org>; Tue, 19 Jun 2018 08:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965173AbeFSIEz (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 04:04:55 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:44370 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756453AbeFSIE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 04:04:26 -0400
Received: by mail-wr0-f169.google.com with SMTP id x4-v6so19471600wro.11
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 01:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w+sH8ZPlUvAeM/BlGQJV8PI9P5fV+tecf8SWfX6U3G0=;
        b=g/ac7qb0y6MFhUT3fLaZXPAkhdB2+rQ9wW7uES7HfdH6WwiS4kizU1S3lXRtaAJoX2
         D7G9+atbR/x9tJvkgPj93wJS7XzNd754bDfO7kEDZPxNSOsaC14JhbpoJhjJqT8yJodz
         mxTWA8/r5Nm6sQFyoJ76uI9js5Q8o+K3vV8js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w+sH8ZPlUvAeM/BlGQJV8PI9P5fV+tecf8SWfX6U3G0=;
        b=WM9FbbYZwIMqgQkOa1V40Y5vnKV/+YW4G6r0mokhRvsPQSfzzmFddG7to+bWY3uShN
         3DOp8owrIDL2TIYBhIlI2KsI1wLqWhdhlI+eJ/S0t2BtgT5CkKjhYMXO/ZLdj6ssN9Kx
         oRdlv4bFJOyPEOqF2uQsd6AGfVzjyU1iGsIU/rrB2fUA5abfc8IO+Y+Nxd3Nee7BP5Ex
         TEb4IkWqhvwvBucXo9LaNZeEr6c61GnUnhcLRmAAMAdZSWF1NWgCt524rMmKxV3NwMin
         T+sXcbE437vVSgeRrLwm9cfqW2iWMgxgPilj69aLcF29on4J9pQW/byEyzla2lCE2onk
         f+0w==
X-Gm-Message-State: APt69E2Tasga7hUaXBG/o0EZNGYKLv2YlGDdoAk5Ydt/7Q2DpwEdiSac
        YKvkUV7qd6YuGLUgKfB1FMskCTGl
X-Google-Smtp-Source: ADUXVKJuv0+ZZcJ98bJbygENW1rOahDiDGQKbZonfldCRsSFlzP1jwVgMzKJq9tYhkODJ1ha0BiGPA==
X-Received: by 2002:adf:8023:: with SMTP id 32-v6mr13505595wrk.243.1529395465133;
        Tue, 19 Jun 2018 01:04:25 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id r2-v6sm12757215wmb.39.2018.06.19.01.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 01:04:24 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Lex Spoon <lex@lexspoon.org>,
        Andrey Mazo <amazo@checkvideo.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 6/6] git-p4: python3: fix octal constants
Date:   Tue, 19 Jun 2018 09:04:11 +0100
Message-Id: <20180619080411.6554-7-luke@diamand.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a
In-Reply-To: <20180619080411.6554-6-luke@diamand.org>
References: <20180619080411.6554-1-luke@diamand.org>
 <20180619080411.6554-2-luke@diamand.org>
 <20180619080411.6554-3-luke@diamand.org>
 <20180619080411.6554-4-luke@diamand.org>
 <20180619080411.6554-5-luke@diamand.org>
 <20180619080411.6554-6-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See PEP3127. Works fine with python2 as well.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 714e442d7c..b449db1cc9 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1841,7 +1841,7 @@ def applyCommit(self, id):
                     filesToDelete.remove(path)
 
                 dst_mode = int(diff['dst_mode'], 8)
-                if dst_mode == 0120000:
+                if dst_mode == 0o120000:
                     symlinks.add(path)
 
             elif modifier == "D":
-- 
2.18.0.rc1.242.g61856ae69a

