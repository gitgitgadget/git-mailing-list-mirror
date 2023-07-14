Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52378EB64DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 06:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbjGNGBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 02:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbjGNGBm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 02:01:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAB92D45
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 23:01:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31441dfbf97so1725882f8f.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 23:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689314500; x=1691906500;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5fOw66Oz/l74QmvF25VG2PF3rAhwtQYaMAuXKwfkGw=;
        b=M0CgdJnP8BkiAaulQWz7QV6xT3eU9317PAN3uoxoi8qbdkFIzepZH8NvAaOxX6xEEi
         X/uoplFhIT8d2CH7wmQQj4Zv6WYWlCRXn6iAP1vhRhGowQN6j/yZyZZW6EromXrrK2fS
         cz7FWZ7m6a+z6UUIaShxIaNJBXpCNOCJrOXEnEVh7Ry/XfbukxHWcVWUeoQjJqQ5AX30
         hZMhA9U7EJMAG3OGLjDSjz/S4LSW74hDFrJPQ7EGJbTXzmKusjkZ21XCeOTCdJmshoG6
         BXQCti9KLqnbQcye5/6K9jYT3ZCGe2Vox7z2++odSzJOpWIbl3m3YPw12BLpZDPlRo6j
         Hk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689314500; x=1691906500;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5fOw66Oz/l74QmvF25VG2PF3rAhwtQYaMAuXKwfkGw=;
        b=fo+dw4DIAV80BKVGVFhlyOubSfI4sbVrnikSceFhxSjW1f2mffshitrpFs86ywV27Y
         Thx0C+2weSf06Kzmiocsnd/+rQHXzJwNXbE9M48QGclkCdU5FOnxRS4znSGUbPDrB3iu
         Xwrko8+pKytFjZ3YYQzlxg/sXWaNfO06Ii0UJ8/A1DrQ9g4e4Cz0C7aU4dytExig9jxt
         V49l9YMx8eZhQIv73C+p0787gleBIjwOYX/NKZspVxpCWdnPnmBMDY5eFI4sPi0DLSwq
         FHgLGbs6rEWShLC120MOMSMvY09yIHSu8TwWetJ7MrAGdjTaTlZFuVQc7EcVp/BKddTw
         24Vw==
X-Gm-Message-State: ABy/qLY6ezgy9SAQWihAC+7A8oafV767CL/koXXmb/dmFCF2bPnUAoCT
        WhD31xXdBwqTS3MwohbtZJh1Vk0EyJc=
X-Google-Smtp-Source: APBJJlFkfA0ogaIWA0QsRE4tV2EiHH7Gq3Aqg7Jdo65vHyHmKUtoTNl9FLSMKFGcElwrowyc/9sVLg==
X-Received: by 2002:a05:6000:18d:b0:314:4ba7:b024 with SMTP id p13-20020a056000018d00b003144ba7b024mr3765334wrx.9.1689314499847;
        Thu, 13 Jul 2023 23:01:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d6790000000b003112ab916cdsm9937434wru.73.2023.07.13.23.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 23:01:39 -0700 (PDT)
Message-ID: <69fef8afe64156a1f54e9e1b7bbcc73d2867695c.1689314493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
        <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Jul 2023 06:01:31 +0000
Subject: [PATCH v2 3/5] SubmittingPatches: de-emphasize branches as starting
 points
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

It could be that a suitable branch does not exist, so instead just use
the phrase "starting point". Technically speaking the starting point
would be a commit (not a branch) anyway.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 7919a362e31..f1d1446764b 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -7,8 +7,8 @@ Here are some guidelines for contributing back to this
 project. There is also a link:MyFirstContribution.html[step-by-step tutorial]
 available which covers many of these same guidelines.
 
-[[base-branch]]
-=== Decide what to base your work on.
+[[choose-starting-point]]
+=== Choose a starting point.
 
 In general, always base your work on the oldest branch that your
 change is relevant to.
@@ -317,8 +317,8 @@ Please make sure your patch does not add commented out debugging code,
 or include any extra files which do not relate to what your patch
 is trying to achieve. Make sure to review
 your patch after generating it, to ensure accuracy.  Before
-sending out, please make sure it cleanly applies to the base you
-have chosen in the "Decide what to base your work on" section,
+sending out, please make sure it cleanly applies to the starting point you
+have chosen in the "Choose a starting point" section,
 and unless it targets the `master` branch (which is the default),
 mark your patches as such.
 
-- 
gitgitgadget

