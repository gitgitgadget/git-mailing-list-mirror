Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB0FEB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 01:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjGHBGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 21:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGHBGG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 21:06:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB552123
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 18:06:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3141c3a7547so2608172f8f.2
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 18:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688778363; x=1691370363;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtt4l1hDHsSVGpEIG6TobceLJcm3n/47J/3RzNPJiUg=;
        b=KVlHRoVo+CP9OniywIT3R2Cge4pkRepyOX8cFqlFUPkMDmG8V9Mv41CPqCls5U6XPJ
         CAOVyi05di2TQK6J0dJAvhXS+DwkPAsbUWDzcQZjsWxz2JFFG6Qypdmi1swrg2d3esvX
         9CZZcgfuvqwJAsDti1+LGp5fPn8n9pH2O0QstWLapiy/DDHeu14dZIfI6/4ddkLHmDTL
         aw0jXPcP26YJeQEcTICytYEt0WhNm0xaFqcSMDmdvXcbi4BmLncYVydCoauT6H52/Dzy
         fv7Dkw+Se3DqBL3beAb5bm9bIdZ/HZHNpdF/qglBt2PYc+kyUh++EbjXLC5G3Wb/t9jK
         pQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688778363; x=1691370363;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtt4l1hDHsSVGpEIG6TobceLJcm3n/47J/3RzNPJiUg=;
        b=FtJ1tXQhJvSB2LXnYvKZ1PtanFzK/6mYs2H7E0dJX0EgWwrMd41T7uo43xw7HYj0AW
         sFk5u8K1Jv3qcEQDOMyhxvNGt/pMuccZ/G9KbA3wFZoSprGwmikRhbGyQVj56lI+Kie/
         E5v8Y5Nm9awDEpyL6d6oHCCoWGYoEqi4/HUvExKrJcO+DFaZKCtYS2U9FIE7u4IYMpbb
         w6HpQXZXuX/jkBtTkSSGo30GnbRmJCs3cAIr9ncA1rPso/Cw4sBm5/oles+ajSv6ZtPW
         np6D1donvd93ntXpyeK+Hi2LOyjasbLUqzKQjVoaBiszLOhaeWuNgA5m/j8ci6hiin3r
         Z0dw==
X-Gm-Message-State: ABy/qLb/r+fDYSC219ERBIFIx/lv8N7lsUWHm75UvYk2bUmBjvf+oYun
        M+4CKjiZ3qncwAzDoikA4gggKHG2Nfw=
X-Google-Smtp-Source: APBJJlHqGlKgN6WZSQTGgK/w1zOeq21CRtKW/gR9vRSG5hH+p2Wug8sCNo8xxRev0GR1BfIrh/LiHg==
X-Received: by 2002:adf:eb0d:0:b0:30a:e9cb:1a2e with SMTP id s13-20020adfeb0d000000b0030ae9cb1a2emr4666003wrn.65.1688778363311;
        Fri, 07 Jul 2023 18:06:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j23-20020a5d4537000000b003141e629cb6sm5658865wra.101.2023.07.07.18.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 18:06:02 -0700 (PDT)
Message-Id: <203ed19dd1b72a8085af05359d5a226b94fe2c7f.1688778359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Jul 2023 01:05:56 +0000
Subject: [PATCH 2/5] SubmittingPatches: be more explicit
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

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index b89678cedc3..5611580fb4c 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -8,7 +8,7 @@ project. There is also a link:MyFirstContribution.html[step-by-step tutorial]
 available which covers many of these same guidelines.
 
 [[base-branch]]
-=== Decide what to base your work on.
+=== Decide which branch to base your work on.
 
 In general, always base your work on the oldest branch that your
 change is relevant to.
@@ -317,8 +317,8 @@ Please make sure your patch does not add commented out debugging code,
 or include any extra files which do not relate to what your patch
 is trying to achieve. Make sure to review
 your patch after generating it, to ensure accuracy.  Before
-sending out, please make sure it cleanly applies to the base you
-have chosen in the "Decide what to base your work on" section,
+sending out, please make sure it cleanly applies to the branch you
+have chosen in the "Decide which branch to base your work on" section,
 and unless it targets the `master` branch (which is the default),
 mark your patches as such.
 
-- 
gitgitgadget

