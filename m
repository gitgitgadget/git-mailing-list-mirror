Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E2EC38142
	for <git@archiver.kernel.org>; Sat, 28 Jan 2023 20:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjA1UNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Jan 2023 15:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA1UNj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2023 15:13:39 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94131FF03
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 12:13:38 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so5728389wmq.0
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 12:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sdp0h5bSVcxARWY0TeuG2YnT7T+dtMrZGp28x5/3S0k=;
        b=RJaxeRAXs0ikKQdxiZ7Z8r3PDcZjVocLUDjbFjdqF9GMQ1Sobk+K3fn0u44oszMv+b
         HGn8QPKLEPNaa4UvvvRzzWEF5ua+we+vtCpuirnZU+aXqXkIpn/AXJyJ1Vs1N8qYn8sX
         Bn4MHwbysPmDXpGBI17/2GDfyxDrzg49XY6U4ZAZ9sv8Z7YS2RwlIbI/lFifxOTQ6qZ6
         COWjFxdErQmRH6RHFSc/B9SelOmi2QUXBIXmeyH02fFj6E08OOCse6xhs78GlgbqW0Le
         8G6DdCN3vRWWPqKFu99JkmOCoN2IXexfIC5wUqQ6TlYDVuCF0XKyjcV75Z/xbm1oR5Gm
         2DrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sdp0h5bSVcxARWY0TeuG2YnT7T+dtMrZGp28x5/3S0k=;
        b=2CtfnGdWvh92ss5hzTtHBPvJYf3IEenGS93JQFUciYYByFVBKHt/JLAy0MNbdrBY26
         EyqTiSM0xMn4PpoRNjEgH/xK4A1lP7jaeVTEYSRlUV2n0F8q0V9K0kfw8bqG4WMLruSK
         +eyRSPkZxWHj8jCMTZOTjGrVJi3G84R60jlgT7LIzWvOKpj3HyRo49zybgqdXpTQVO0A
         QSQKTky92GDwirUUabWiTAi7GWWDM4cOmCqFmEkdNgJmu4GanzVQzPIZJg8uw4XbUYEX
         v8GI2A/H6e+GS4zrwRjzZy91izsegMrZf0cr5RkqKOFnshl3dktF/Btoejv31V99ZsTd
         E0yw==
X-Gm-Message-State: AFqh2ko/LvCCABwwnLjxO6mA6ukURNioQCmBHH0m+dSx9iB5i9XtaaYC
        Irm72WHyWOcaHNsec5S9ziR0Fp9g1OY=
X-Google-Smtp-Source: AMrXdXtlBNoHpY+4HIHO/dkT+KMeu5j8m74Sa8fMz9SfUZ1ZVAzkTuyFmRui5Umn1WF8LWeOTruPHA==
X-Received: by 2002:a7b:cb88:0:b0:3d9:f801:73bf with SMTP id m8-20020a7bcb88000000b003d9f80173bfmr43191734wmi.12.1674936816851;
        Sat, 28 Jan 2023 12:13:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c30d200b003c21ba7d7d6sm7874325wmn.44.2023.01.28.12.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 12:13:36 -0800 (PST)
Message-Id: <pull.1447.v3.git.1674936815117.gitgitgadget@gmail.com>
In-Reply-To: <pull.1447.v2.git.1674936563549.gitgitgadget@gmail.com>
References: <pull.1447.v2.git.1674936563549.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 28 Jan 2023 20:13:34 +0000
Subject: [PATCH v3] Documentation: clarify that cache forgets credentials if
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1447%2Fhickford%2Fpatch-2-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1447/hickford/patch-2-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1447

Range-diff vs v2:

 1:  e84d069cf19 ! 1:  09f4afae70c Documentation: clarify that cache forgets credentials if the system restarts
     @@ Documentation/git-credential-cache.txt: git config credential.helper 'cache [<op
      +The stored credentials are kept in memory of the cache-daemon
      +process (instead of written to a file) and are forgotten after a
      +configurable timeout. Credentials are forgotten sooner if the
     -+cache-daemon dies, for example if the system restarts. The cached
     ++cache-daemon dies, for example if the system restarts. The cache
      +is accessible over a Unix domain socket, restricted to the current
      +user by filesystem permissions.
       


 Documentation/git-credential-cache.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index 432e159d952..f473994a864 100644
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
+cache-daemon dies, for example if the system restarts. The cache
+is accessible over a Unix domain socket, restricted to the current
+user by filesystem permissions.
 
 You probably don't want to invoke this command directly; it is meant to
 be used as a credential helper by other parts of Git. See

base-commit: 5cc9858f1b470844dea5c5d3e936af183fdf2c68
-- 
gitgitgadget
