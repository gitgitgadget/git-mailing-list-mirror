Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB983EB64DD
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 05:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjHEFFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 01:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjHEFEp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 01:04:45 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC234EDA
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 22:04:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe4a89e7efso9102355e9.3
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 22:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691211883; x=1691816683;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JqhnDTFQwgL25RJZUSWy6/RPTmoNhSBdaCeoROhT58=;
        b=dZz0Sncd7/UvybU8alI2I+d4APbUTvC+2HwDHsSUNv3LUP4WuxE7c3y8PS0zaND2J9
         gicfei3BBCOwEC+VBKeJ4bElb77S8H9CotPwOlSz4WeqemBsw1vrbcPNuM2X8dQ9s+MG
         XUFe6mkUPejOyHAKtFoVseb7E1kVNY4X0PMQehzpegCK/CoHqUuA6RaVRKlgQC61VXqA
         J4aMAwfslKd02dGqb8x+EVa5t5JgyvMdkBTjxFKmK5e13Zr3YATphKnSJDOk9H8O+SBp
         NKXe9uvWmfw+dDwzGsB0pzJyL6OF0BHmQ8q67XhrAInSr/j4qWQY+guHqUU5YB7IJAfU
         MOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691211883; x=1691816683;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JqhnDTFQwgL25RJZUSWy6/RPTmoNhSBdaCeoROhT58=;
        b=KO4Whz/Kj8sk4jaPFLhpzo19GskaUoTa4SA6BWiKokto4no+cVg2iD8CC0s5R0NlaU
         rHCPrf5LQflu/w6tmc2I8exaOi7sZZx1bGR35l525noa8BL1xuQhgNOxymoGFrH03o90
         AXo7y4Jdx2e/8wUXNwtPOoZbyV6r/KO/2R9jegDdqUvZxi+QqVjjRb/I2KjT+QAYENY8
         RjJlXUPe2pMMS1nm4j8IRm8wt/9lQlwRlyOg8UFu3wkJsiBMkOqGJCzRgCxJFN2mN12r
         Zxwp2NR1R+pYliHGuYqz7fk6pwGfM/yBZD8WI6iz4qGR1EBHM5kAQnWICOoYXhirXRbS
         oThQ==
X-Gm-Message-State: AOJu0YwVUnhH/5KjAuROW9kVaXl4EFkANsTntoTcSeeouSFIwBjPR+BV
        5/K1SLLFzNVG96+cgee9sRybbiz9Q8I=
X-Google-Smtp-Source: AGHT+IEUdFlLj+HquwJp2LgC3sT7PbmT/HWO1wiZlvdS1jDr2MU60tGlfpW/Dx6z5X2pL3BzfCMToA==
X-Received: by 2002:a05:600c:ad2:b0:3f8:b6c:84aa with SMTP id c18-20020a05600c0ad200b003f80b6c84aamr2480906wmr.24.1691211883245;
        Fri, 04 Aug 2023 22:04:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c029900b003fba2734f1esm8283046wmk.1.2023.08.04.22.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 22:04:43 -0700 (PDT)
Message-ID: <1fc060041db11b3df881cb2c7bd60630dc011a15.1691211879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Aug 2023 05:04:38 +0000
Subject: [PATCH 4/5] trailer: teach find_patch_start about --no-divider
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

Currently, find_patch_start only finds the start of the patch part of
the input (by looking at the "---" divider) for cases where the
"--no-divider" flag has not been provided. If the user provides this
flag, we do not rely on find_patch_start at all and just call strlen()
directly on the input.

Instead, make find_patch_start aware of "--no-divider" and make it
handle that case as well. This means we no longer need to call strlen at
all and can just rely on the existing code in find_patch_start.

This patch will make unit testing a bit more pleasant in this area in
the future when we adopt a unit testing framework, because we would not
have to test multiple functions to check how finding the start of a
patch part works (we would only need to test find_patch_start).

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/trailer.c b/trailer.c
index 89246a0d395..3b9ce199636 100644
--- a/trailer.c
+++ b/trailer.c
@@ -812,14 +812,14 @@ static ssize_t last_line(const char *buf, size_t len)
  * Return the position of the start of the patch or the length of str if there
  * is no patch in the message.
  */
-static size_t find_patch_start(const char *str)
+static size_t find_patch_start(const char *str, int no_divider)
 {
 	const char *s;
 
 	for (s = str; *s; s = next_line(s)) {
 		const char *v;
 
-		if (skip_prefix(s, "---", &v) && isspace(*v))
+		if (!no_divider && skip_prefix(s, "---", &v) && isspace(*v))
 			return s - str;
 	}
 
@@ -1109,11 +1109,7 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 
 	ensure_configured();
 
-	if (opts->no_divider)
-		patch_start = strlen(str);
-	else
-		patch_start = find_patch_start(str);
-
+	patch_start = find_patch_start(str, opts->no_divider);
 	trailer_end = find_trailer_end(str, patch_start);
 	trailer_start = find_trailer_start(str, trailer_end);
 
-- 
gitgitgadget

