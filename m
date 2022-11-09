Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46A8C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 10:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiKIKTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 05:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiKIKTt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 05:19:49 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F4223BD6
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 02:19:44 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i5-20020a1c3b05000000b003cfa97c05cdso922068wma.4
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 02:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VOvrhK5wtHrZKUt7JkRrjQqg0Wyzc/LR1VMplx9/MnU=;
        b=LwthZPhI6XMAsl2fr5sczWYdmA+zAfBeVks+GtgK1oy9jg5a6wCGxfzW9EHv+6MihF
         z5iiwM8Hr9quM1JFTfCNV/rWd7KkQST0YoZMF5buEm0QS0BZV9vgRJV+h/UAGViCEhXg
         51MECYeOVSxd9YGxuPJbG0ouSb/ATZXd3ne1DEJnVOo3knyt3vsLI/x5jceXT8CNMyQb
         WmdLuK552axiNT/F/gJyvH361++TXzNpKT5kWaOQXYxKmxawdxZYPI/wPX2LdKkVK/RE
         iS2wkxdYBs3jEqmqjVo0k2ptO72V9BDBjWRR5W+IqiNatJ0M0RxtQpZK9zAniR+39mtn
         8+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOvrhK5wtHrZKUt7JkRrjQqg0Wyzc/LR1VMplx9/MnU=;
        b=qGcExYI9hyDc/OP4q3pi2E6P1cnbRNjsVQgah7uInRs7kIOfyM77arkHgmePtebzqS
         /ekVUqNRMG4koq354Aw7YhL3360AvuZ7wySQq7yfWV0cscaexbzSItcMq2hyJO9/jkxE
         /xO3oD/aZarVn7C6VBiAv8fl0bWHuLZeflOay2VJdSNsiQyX/ezkLVy1Xh1t5T4CgJis
         DSwj9yZxTpPll0KpI15rutF4bQw2v8791d5x+g9GdIIEI55VAjw3Z0KpMW7o4Anhuui8
         t9TlZySYM9D4GK1X/r7UFMo91U1Ut+Ut3mSODBk+F6g3gHYWrqqmE18ThoyS+5LpZ42X
         IabA==
X-Gm-Message-State: ACrzQf3fhewjH9zW9njEE85pqd2PFTi67ei9Ze5f3H9BETtGu/VNDP7W
        6v+elUH1gtnIAmR0BAXXq7gWPSmbK0s=
X-Google-Smtp-Source: AMsMyM5kzPp5VoAVdibFNp/lOVegajJOcNKFaai6GtUREIezTREfOZJCgvAk9VyiZyqdHod+kjalWQ==
X-Received: by 2002:a05:600c:818:b0:3cf:7385:7609 with SMTP id k24-20020a05600c081800b003cf73857609mr33984114wmp.186.1667989182908;
        Wed, 09 Nov 2022 02:19:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c46cc00b003b4ac05a8a4sm1447340wmo.27.2022.11.09.02.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 02:19:42 -0800 (PST)
Message-Id: <pull.1412.git.1667989181611.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Nov 2022 10:19:41 +0000
Subject: [PATCH] Documentation: increase example cache timeout to 1 hour
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

Previously, the example *decreased* the cache timeout compared to the
default, nudging users to make cache less usable.

Instead, nudge users to make cache more usable. Currently many users
choose store over cache for usability. See
https://lore.kernel.org/git/Y2p4rhiOphuOM0VQ@coredump.intra.peff.net/

The default timeout remains 15 minutes. A stronger nudge would
be to increase that.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    Documentation: Increase example cache timeout to 1 hour
    
    Previously, the example decreased the cache timeout compared to the
    default, nudging users to make cache less usable.
    
    Instead, nudge users to make cache more usable. Currently many users
    choose store over cache for usability. See
    https://lore.kernel.org/git/Y2p4rhiOphuOM0VQ@coredump.intra.peff.net/
    
    The default timeout remains 15 minutes. A stronger nudge would be to
    increase that.
    
    Signed-off-by: M Hickford mirth.hickford@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1412%2Fhickford%2Fnudge-cache-longer-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1412/hickford/nudge-cache-longer-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1412

 Documentation/git-credential-cache.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index 0216c18ef80..432e159d952 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -69,10 +69,10 @@ $ git push http://example.com/repo.git
 ------------------------------------
 
 You can provide options via the credential.helper configuration
-variable (this example drops the cache time to 5 minutes):
+variable (this example increases the cache time to 1 hour):
 
 -------------------------------------------------------
-$ git config credential.helper 'cache --timeout=300'
+$ git config credential.helper 'cache --timeout=3600'
 -------------------------------------------------------
 
 GIT

base-commit: 319605f8f00e402f3ea758a02c63534ff800a711
-- 
gitgitgadget
