Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B0AC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 13:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiJUNp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 09:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiJUNp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 09:45:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ECE10327F
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 06:45:21 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id t4so2192149wmj.5
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 06:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrWS7G+32cHSNgoXfv7mVhlIW6Op1rh5dxpBtEEDcoI=;
        b=n/b1+FXWpi/oILDXnP68VjKuf/Jn+x68+U8tblido1SGrwJZHgZu9w8YvNqHasRKqw
         ircDwpr8+RN0vp1QCW/cn2LRoOt/pqLsxkn41W3x7wnMqzw/TgUFOMbALQFrTJHoStb3
         7ZUPfCpGOM8tiwYz/mqVRzSGamGgzekMh1TpR6r3iIBBVA0rjMfNzA5wwSLEx0fl5/2k
         WAYZzzXw040e1nc+6Tet/dEEUvKOqwOE1T4tham9mv+cLOOKuHBWeNX7IuUtgIalu11e
         ElFRQAXeyla0ABZrQXhzW5gwZuR0byQjUXx0AsIqX9I/CYnsLhwUIOy+OmSE1WDmUn2H
         2gNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrWS7G+32cHSNgoXfv7mVhlIW6Op1rh5dxpBtEEDcoI=;
        b=xRQn3ACQKGw7MT4pGj5nnH1Ulfm748jKaG3WWZf6LcVKC8Bw0Yg6QTCQBu2jmEYgyK
         PxEJDIWK5+QcfyIpevqOLQH1CgfSZPKQO35a8QEYPgD1sE+J7N4+fAk/bcVTfHiqjLXh
         hgX+VnMBwLOOtVXggbvWu8pgDZC8JzmLw72NEvWUeJwXxaHVNuJeIbNW/s/vCN4HBsHW
         eIw/vKptKiN0hL7obBdnOr4h4W2YljsBJXspLErPyPeOc0vnAezrRu93ZElCbdFb4C4U
         rgLEHqn4LwCnVfOkTBCRUWlI7yduDFeazfJUq1symHYw7cLgkmX9ndlDAmgdNm4274vi
         LWmA==
X-Gm-Message-State: ACrzQf0RHsMQ2VOEBQmHlYGRM4OdMYdjMHBOHiYZ6EoBEKbXpdstgB39
        XZspUO41Iyob6VAx8sR/2xsp2+IGtvs=
X-Google-Smtp-Source: AMsMyM7grgeA8tjOwbQa004oFgN/Rp47nEz9CS3bvSKyPvYPrZFNV91Dp1KGpQp4TRdkGY0m+JGn/g==
X-Received: by 2002:a7b:c341:0:b0:3c4:552d:2ea7 with SMTP id l1-20020a7bc341000000b003c4552d2ea7mr13457248wmj.82.1666359919926;
        Fri, 21 Oct 2022 06:45:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c2ccd00b003c6f1732f65sm3056918wmc.38.2022.10.21.06.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:45:18 -0700 (PDT)
Message-Id: <9c8440e5e82777311c6217cb4a9ddcd5cb8ce689.1666359915.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 13:45:12 +0000
Subject: [PATCH 1/3] git_parse_unsigned: reject negative values
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

git_parse_unsigned() relies on strtoumax() which unfortunately parses
negative values as large positive integers. Fix this by rejecting any
string that contains '-' as we do in strtoul_ui(). I've chosen to treat
negative numbers as invalid input and set errno to EINVAL rather than
ERANGE one the basis that they are never acceptable if we're looking for
a unsigned integer.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 config.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/config.c b/config.c
index cbb5a3bab74..d5069d4f01d 100644
--- a/config.c
+++ b/config.c
@@ -1193,6 +1193,11 @@ static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
 		uintmax_t val;
 		uintmax_t factor;
 
+		/* negative values would be accepted by strtoumax */
+		if (strchr(value, '-')) {
+			errno = EINVAL;
+			return 0;
+		}
 		errno = 0;
 		val = strtoumax(value, &end, 0);
 		if (errno == ERANGE)
-- 
gitgitgadget

