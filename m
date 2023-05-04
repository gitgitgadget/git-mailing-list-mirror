Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C5EC7EE21
	for <git@archiver.kernel.org>; Thu,  4 May 2023 16:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjEDQea (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 12:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjEDQe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 12:34:27 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E781BD3
        for <git@vger.kernel.org>; Thu,  4 May 2023 09:34:25 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1928860f679so337417fac.0
        for <git@vger.kernel.org>; Thu, 04 May 2023 09:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683218065; x=1685810065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qioAehniHa63jz4adCE5tpBFrfdHOXgsgD8AviecOw=;
        b=oxhQ6D+Nmu7/UqbNSzkS5YfFmTEVa/xpi0DQeYUFTTCEGkBqJ5hebewaWuzW9VJFPV
         0/0ShDzAqml1pQgc49siy6QYFO5L8kDnoLPu7RkkKvMQ2Oy46E77SyxcxvalaI13vbZv
         M28PWW9x+1Zf6nRIwrxbFXxw67QtYX4p9LTo673OL5z0tq7+oNxLXcbXzaCwcXs2Smej
         j4iwgYmRThNtyClIslbVr0+6AK0+WlUAZvWzz5Gq4xAyopExhxcvnMX6vso7NbN3f0Nl
         U+wwAzQhheZFTmGk+/mGQhLbg6YHPhz3r2fx6ndOW0KSnygjE37qEuLC29RV4ZSbrNwd
         2CEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683218065; x=1685810065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qioAehniHa63jz4adCE5tpBFrfdHOXgsgD8AviecOw=;
        b=UFJ7pNdCRe3bmnN4V8co0QZ+2szhhd72lq9u4tbQfb1d3/k4Hltobjf43dpKdr86/G
         6IiTTwtYCsQkJeAHyXCPFmpTUkz01/xIKfKAx0xcmlMFqDMCmL129q5q6Ok7m/WKXk9r
         MrXodBTgPzx99IcG9BuTZp74rYbl+hPYOTnxioYzX5pF74IgSZyrN+9o3wRKUYXaXkms
         KZE9KgZ5QGlEPzl5AA8h+8ePzgBT7ZNJLQgF9K93XHpc66pvUOTwxzK/fBCWK+76sRU8
         uzIwlEhSnFaVU7VaZB/xBHlZ/dNm/bkWh3dP5bHLyQ5sEti0J4FfaD2RZdr4z2lJuYCr
         haOQ==
X-Gm-Message-State: AC+VfDxMk06MA0ZaniyWyR/7KHzUqHnT3eOX21ajm8WGlcQfMchBeoDK
        pHV1dHe3dpMbWKF3HmoI3uP6jjM6rEQ=
X-Google-Smtp-Source: ACHHUZ77MuW51wCBXuC4/7HPOr9745uTVC0f9BYiSTbakBkCoCXoLNms+wtyhDfWEvo1dt+Cmc14rA==
X-Received: by 2002:a05:6870:c796:b0:18e:1d73:102e with SMTP id dy22-20020a056870c79600b0018e1d73102emr1393889oab.25.1683218064953;
        Thu, 04 May 2023 09:34:24 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id s15-20020a056870e6cf00b00192774d5d15sm790080oak.51.2023.05.04.09.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 09:34:24 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] doc: revisions: fix missing escape
Date:   Thu,  4 May 2023 10:34:20 -0600
Message-Id: <20230504163421.100400-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230504163421.100400-1-felipe.contreras@gmail.com>
References: <20230504163421.100400-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In AsciiDoc `{foo}` is an attribute, if one doesn't want the attribute
replaced the left curly brace symbol has to be escaped.

For some reason asciidoc.py skips the whole line otherwise:

  --- a/gitrevisions.7
  +++ b/gitrevisions.7
  @@ -112,8 +112,10 @@ SPECIFYING REVISIONS

          [<branchname>]@{upstream}, e.g. master@{upstream}, @{u}
              A branch B may be set up to build on top of a branch X (configured
  -           with branch.<name>.merge) at a remote R (configured with the branch
  -           X taken from remote R, typically found at refs/remotes/R/X.
  +           with branch.<name>.merge) at a remote R (configured with
  +           branch.<name>.remote). B@{u} refers to the remote-tracking branch
  +           for the branch X taken from remote R, typically found at
  +           refs/remotes/R/X.

          [<branchname>]@{push}, e.g. master@{push}, @{push}
              The suffix @{push} reports the branch "where we would push to" if

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/revisions.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 9aa58052bc..af764de153 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -99,7 +99,7 @@ some output processing may assume ref names in UTF-8.
 '[<branchname>]@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
   A branch B may be set up to build on top of a branch X (configured with
   `branch.<name>.merge`) at a remote R (configured with
-  `branch.<name>.remote`). B@{u} refers to the remote-tracking branch for
+  `branch.<name>.remote`). B@\{u} refers to the remote-tracking branch for
   the branch X taken from remote R, typically found at `refs/remotes/R/X`.
 
 '[<branchname>]@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
-- 
2.40.0+fc1

