Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A92FE95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344481AbjJHGqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344510AbjJHGqI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:46:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0CFF9
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3296b87aa13so1750462f8f.3
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747544; x=1697352344; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPe5M3nXnk0IGpo/zWnEAZqid8ib7GDx47GtaaS6Wh4=;
        b=kpG3YQLsXm/aE63kwDH9Mqb8Wjwwa/YYmUc4az1Hdr2sZNl6JjmEJk5jqWQGnHu6Di
         0xigGZ5bAAxdxWlrii24oBbDtt+22EdPVagbmgXczPwrqJKyJlNoAPf++2SZrACG+2ie
         D15oVPcZYKDUoIrTaGaYk9P3Qk1+nwt3QGg/pxU0yOnj9NiZdzPpqKXJfeNfnovWMKkR
         acCRshYIY58uzHxEstIag5Q9FNrFsPgpqLjjziTzjq2OSq03LHeYawD3AE/YhUkUNbut
         jWHKFUGj2X/ZWOk9yEj8TfmZtrLO1Tubhh+kPFkiZY+6X/yoaQ90PFBv8Gg5ZCW3fQXC
         JyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747544; x=1697352344;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPe5M3nXnk0IGpo/zWnEAZqid8ib7GDx47GtaaS6Wh4=;
        b=VTjDkYciNca0M2bYEzGwtX3PX/mY21Te5SQhF/yPZ15Zb9HN9V7Ju4XGsWd80+fOtl
         GZvofd7YPlpRrLFzBzddPYoYJM9eu4NnHhFxA5+4d3EGfbqJu6fxdE0JG94kNfb55IPR
         A6SPIDv6chClxcSGwOdatHvLlqM5xiYvR1sWUGSLH0r2aShCm9uQNq07GiiVVPtgyTbL
         /c77GmkHyTlUMJsY/aHXvqkwpG+YWhUqDE32A+RS5FqaqkcDDIQNmArSwmbBslXTI4Iu
         vGiJvL7VlCBWJUSOP3GAIqeCSuLHMVGGdBOFsIoNHkA+X/iQP/6f55FNsWLQsVRnZmzL
         Ujgw==
X-Gm-Message-State: AOJu0Yw/w3MO2V4kn4fgDP9qX0WrrTg5Yfbcd+70Z/QyUunHKMX4YbuY
        YJOcUbI4AXhgeCkQFOPPMcBb53n4W2E=
X-Google-Smtp-Source: AGHT+IGbQcxgeOwaH5criCMAY32YHVaFMVEQdKIr2HmU56KQFqjkG+tuIOGNg1JwYSxzQ6BxUv45Mw==
X-Received: by 2002:a5d:60d1:0:b0:319:7656:3863 with SMTP id x17-20020a5d60d1000000b0031976563863mr10947881wrt.47.1696747544368;
        Sat, 07 Oct 2023 23:45:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1-20020a5d4bc1000000b00323287186b2sm6012136wrt.29.2023.10.07.23.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:43 -0700 (PDT)
Message-ID: <6d3142f9672aec59b673741c569dac361f809a5e.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:23 +0000
Subject: [PATCH 21/25] documentation: fix whitespace issues
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Get rid of extraneous whitespace, replace tab-after-fullstop with
space, etc.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-blame.txt        | 2 +-
 Documentation/git-check-ignore.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 6f39147c051..5720d04ffe4 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -170,7 +170,7 @@ which limits the annotation to the body of the `hello` subroutine.
 
 When you are not interested in changes older than version
 v2.6.18, or changes older than 3 weeks, you can use revision
-range specifiers  similar to 'git rev-list':
+range specifiers similar to 'git rev-list':
 
 	git blame v2.6.18.. -- foo
 	git blame --since=3.weeks -- foo
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 2892799e32f..3e3b4e34462 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -50,7 +50,7 @@ linkgit:gitignore[5].
 	with a NUL character instead of a linefeed character.
 
 -n, --non-matching::
-	Show given paths which don't match any pattern.	 This only
+	Show given paths which don't match any pattern.  This only
 	makes sense when `--verbose` is enabled, otherwise it would
 	not be possible to distinguish between paths which match a
 	pattern and those which don't.
-- 
gitgitgadget

