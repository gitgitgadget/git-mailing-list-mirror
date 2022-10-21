Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD5DC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 13:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiJUNpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 09:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiJUNp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 09:45:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E018714D8CE
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 06:45:24 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l14-20020a05600c1d0e00b003c6ecc94285so3957942wms.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y96WTLTQB8sPyIOHRLNnyiH0HgZNjZ9qEdCSi4fIzj8=;
        b=Kfk1c/fbiGo2bhkCd7O6UT1onp1N0oyW4AayI29gb1UBZKYz7zIL7W/wRbMjMOMUqE
         2kIx4a5OPL9DoOwSpBCm0dd4EKWSqnveRpI3nD9BEBlzuh4Hg6HcXS8PJUyWdlDFiALc
         U/RWlWdEynku1rjzWqO1m1yLk5LWRKfd/CKyUsMDR92fydOZz8JIsxaknwYaDkzQOppC
         MrvEfYjyk3wuNj12DCL1fcgKLeUpGThD0KT8PmyU5O1xJHbFIAZb88fYxUIBr4mT6PBU
         tYytlMyvCycK/htPrQ6Rhyn3VB8DCE1Zu0/XgDTNnSTCzMXMV+hDY+J9h+lj+4L5iVck
         MClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y96WTLTQB8sPyIOHRLNnyiH0HgZNjZ9qEdCSi4fIzj8=;
        b=lgTDwTWI5U95F+yL0eNvCPbxEwmklmn1m6VyY1Va3LkIZLxIs4TYd5hHk1V4+lm/Bd
         aAQEFZLiE0TKTpD0ewcZDhTeYhFPYcZ/zLlmGFZsv3pZSRKlYnpRlOFNFggDnwgtVhgo
         ONZ0yPU64zhfZbkHAXhNlzi7pEt+K7tTUXRP3JcWQC+tR31vUbMLdvF09aKkf/fX1sy8
         leygPHF7BlmIUqzZ0+a7yTmXrJX8FNa69BPB2/jkwjLX9jwXtd5klzfCw5j9y0w49cV2
         W7xDKEfbBq+zuS6oDSVdorxErC6jDEtgqTyxpSxpD3m5P+Cm67cY1O+XbmABKZ4RJwTN
         qWBQ==
X-Gm-Message-State: ACrzQf3d9zo3Xb1DgUW5/NoNLcZdUTOaL0ip3vhUqtC80y66OnV47vhs
        iTk461VoDeKGNhVg1qhmFZqBUh3TIUM=
X-Google-Smtp-Source: AMsMyM6dYVR70YSnunqBbsh6iAICCqrRZS621JU7pIV6p5FoL7iHBKw/ugXZh9qm68JjocD8JxpGqg==
X-Received: by 2002:a05:600c:34d2:b0:3b4:a617:f3b9 with SMTP id d18-20020a05600c34d200b003b4a617f3b9mr12782771wmq.204.1666359922559;
        Fri, 21 Oct 2022 06:45:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m126-20020a1ca384000000b003b476cabf1csm2520362wme.26.2022.10.21.06.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:45:21 -0700 (PDT)
Message-Id: <f058f391c3821b341a15fda9ae9fd20dda6a0494.1666359915.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 13:45:14 +0000
Subject: [PATCH 3/3] git_parse_signed(): avoid integer overflow
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

git_parse_signed() checks that the absolute value of the parsed string
is less than or equal to a caller supplied maximum value. When
calculating the absolute value there is a integer overflow if `val ==
INTMAX_MIN`. To fix this avoid negating `val` when it is negative by
having separate overflow checks for positive and negative values.

An alternative would be to special case INTMAX_MIN before negating `val`
as it is always out of range. That would enable us to keep the existing
code but I'm not sure that the current two-stage check is any clearer
than the new version.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 config.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index b7fb68026d8..aad3e00341d 100644
--- a/config.c
+++ b/config.c
@@ -1160,8 +1160,10 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 	if (value && *value) {
 		char *end;
 		intmax_t val;
-		uintmax_t uval;
-		uintmax_t factor;
+		intmax_t factor;
+
+		if (max < 0)
+			BUG("max must be a positive integer");
 
 		errno = 0;
 		val = strtoimax(value, &end, 0);
@@ -1176,9 +1178,8 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 			errno = EINVAL;
 			return 0;
 		}
-		uval = val < 0 ? -val : val;
-		if (unsigned_mult_overflows(factor, uval) ||
-		    factor * uval > max) {
+		if ((val < 0 && -max / factor > val) ||
+		    (val > 0 && max / factor < val)) {
 			errno = ERANGE;
 			return 0;
 		}
-- 
gitgitgadget
