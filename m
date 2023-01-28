Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CC2C38142
	for <git@archiver.kernel.org>; Sat, 28 Jan 2023 20:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbjA1UJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Jan 2023 15:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA1UJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2023 15:09:27 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F63DBBB6
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 12:09:26 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so145784wms.1
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 12:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDr/QbcL9ZLk1HtJMKHPVr6Zj5Q9la7KM4DubyxLCnA=;
        b=atOKxeLTuKj/s3BR5YpMzD1pmh9u55q3CEkuCinJ2fktkhGUx1gcBVFwpw4/ODA2Cu
         NRDhs/WDf79INpPEFQuW3elp/DvxbIJQLyybiRdUB2iA3vc5Bd182duQZbSBDMjdrYfI
         ceU7F0P6eP3GelQhKvqMo0TL1cFs0A1LEqq4H8CV1A6x+K5c2afkw+QltbQIf7CKMmrG
         5GXn8F1axtqCYWjKzl6M1rzo0iLihUlZJZKZj+U4DqWXu8Ohd81SZ0/1suVYz7TSwr7B
         HYdoDQQbGR3nHLAMlVXLhJpad6TTMNw43dWWoG/4Fpais0Z6b4DUTCjUKRDo05Tvma9J
         jwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDr/QbcL9ZLk1HtJMKHPVr6Zj5Q9la7KM4DubyxLCnA=;
        b=atxCHBFQrDZjPiIQEdcVGr/urb16mLhE5jVBH9LcMoVeBvW3tVgmlLtM/pYKSSperI
         Tnq7djaNkBpwD7A7+RtCxA0kXYZwAEEvt6Koav8myfx1/UT/Y9FJUoJBAIbhzc8PnhOV
         t49B3/aLn+ZKnCnuQGf9aCumi8oGsMzN7qdOggHu+coU1bc3XalVKFnZLPpi34V9MqNs
         WZlOz8vDTlVofrVV/CpJl2RPEYQxbtM37YLcOXOQxtZGKnXMjPDekwKeX6eF1ou3e4vo
         A2Kfetb0O1K6TSAjTAfetAPQqGz4MCrRhm+RsmFaSP51d8fIcdPNS7sMuUTob/Wapnd2
         ax4A==
X-Gm-Message-State: AFqh2ko3OKMNx79cL37Jbu0SBRR0b7wjtUUyUi2hFoMbEevSuazKmqyh
        0voFr5hm+lFh6aiuJhIzQyENf79XQZQ=
X-Google-Smtp-Source: AMrXdXtnD1/1hNpYiKduYEmOYgFYS5HZfm2KfGFaYY8NBNnZM+/FQZTms4KK+IQ0+EIJCwU1zTenWA==
X-Received: by 2002:a05:600c:255:b0:3da:f9b7:74c7 with SMTP id 21-20020a05600c025500b003daf9b774c7mr43278688wmj.13.1674936564743;
        Sat, 28 Jan 2023 12:09:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c1-20020a05600c0a4100b003d9fba3c7a4sm12407903wmq.16.2023.01.28.12.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 12:09:24 -0800 (PST)
Message-Id: <pull.1447.v2.git.1674936563549.gitgitgadget@gmail.com>
In-Reply-To: <pull.1447.git.1671610994375.gitgitgadget@gmail.com>
References: <pull.1447.git.1671610994375.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 28 Jan 2023 20:09:23 +0000
Subject: [PATCH v2] Documentation: clarify that cache forgets credentials if
 the system restarts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    Documentation: clarify that cache forgets credentials if the system
    restarts
    
    Make it obvious to readers unfamiliar with Unix sockets.
    
    Signed-off-by: M Hickford mirth.hickford@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1447%2Fhickford%2Fpatch-2-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1447/hickford/patch-2-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1447

Range-diff vs v1:

 1:  5032ddf99da ! 1:  e84d069cf19 Documentation: clarify that cache forgets credentials if the system restarts
     @@ Metadata
       ## Commit message ##
          Documentation: clarify that cache forgets credentials if the system restarts
      
     -    Make it obvious to readers unfamiliar with Unix sockets.
     -
          Signed-off-by: M Hickford <mirth.hickford@gmail.com>
      
       ## Documentation/git-credential-cache.txt ##
     -@@ Documentation/git-credential-cache.txt: DESCRIPTION
     +@@ Documentation/git-credential-cache.txt: git config credential.helper 'cache [<options>]'
     + DESCRIPTION
     + -----------
       
     - This command caches credentials in memory for use by future Git
     - programs. The stored credentials never touch the disk, and are forgotten
     +-This command caches credentials in memory for use by future Git
     +-programs. The stored credentials never touch the disk, and are forgotten
      -after a configurable timeout.  The cache is accessible over a Unix
     -+after a configurable timeout.  Credentials are forgotten sooner if you
     -+log out or the system restarts.  The cache is accessible over a Unix
     - domain socket, restricted to the current user by filesystem permissions.
     +-domain socket, restricted to the current user by filesystem permissions.
     ++This command caches credentials for use by future Git programs.
     ++The stored credentials are kept in memory of the cache-daemon
     ++process (instead of written to a file) and are forgotten after a
     ++configurable timeout. Credentials are forgotten sooner if the
     ++cache-daemon dies, for example if the system restarts. The cached
     ++is accessible over a Unix domain socket, restricted to the current
     ++user by filesystem permissions.
       
       You probably don't want to invoke this command directly; it is meant to
     + be used as a credential helper by other parts of Git. See


 Documentation/git-credential-cache.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index 432e159d952..9eef5d2cc10 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -14,10 +14,13 @@ git config credential.helper 'cache [<options>]'
 DESCRIPTION
 -----------
 
-This command caches credentials in memory for use by future Git
-programs. The stored credentials never touch the disk, and are forgotten
-after a configurable timeout.  The cache is accessible over a Unix
-domain socket, restricted to the current user by filesystem permissions.
+This command caches credentials for use by future Git programs.
+The stored credentials are kept in memory of the cache-daemon
+process (instead of written to a file) and are forgotten after a
+configurable timeout. Credentials are forgotten sooner if the
+cache-daemon dies, for example if the system restarts. The cached
+is accessible over a Unix domain socket, restricted to the current
+user by filesystem permissions.
 
 You probably don't want to invoke this command directly; it is meant to
 be used as a credential helper by other parts of Git. See

base-commit: 5cc9858f1b470844dea5c5d3e936af183fdf2c68
-- 
gitgitgadget
