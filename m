Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC3B41F462
	for <e@80x24.org>; Sun, 28 Jul 2019 20:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfG1UHe (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 16:07:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41507 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfG1UHb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 16:07:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so26896208pff.8
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ROTa+1lHfN7dzqHUHj1cWDiXeUwFs3IdmSKn6hMwvBc=;
        b=fgajXv+A+wZxsUcLKK1HBalLbB40r99PpY5EcoRbI987s9zaMfThloKY8BqotIGRBf
         zM7xJtMAJCgpb4CzkmM+bLrFRo2JhDtC+Z+UIyuG7JbzP8MzkL9wh2uC5Jmonqq1pj2i
         31WDyrEE2QQluhc/+j/Qe2T5lYJF3R/sFn7TQuc7VWYtc7SQN4r+0VHNvdD80daZfHi2
         R4c1pALcT/a/BG50opC6to6WxTKSDnR+iRlTKrp1C0sx0o7V1iGxrueY7KasJLb3WZzX
         0tNq+1mI5bJG/OZG6U3awiWIrx6BFo+0QS/n8OFlfTrnKGuYImqmPbc9iyyzMNs7s4vu
         tFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ROTa+1lHfN7dzqHUHj1cWDiXeUwFs3IdmSKn6hMwvBc=;
        b=RnG8IZ/U3mA+WrPRZsCWe4vIegRAAIUk9PFLQFeZHA932yHORdWLAGBhW525uZ9joQ
         SnH+VBhLngg2wUGXQphosJTjic5sDuWPrlGlv3TXondoPwiX5vuIZi4zfbZNV6GFrFof
         KWySyq+KM0j0N2T7sq1NWwmIKdMmXfYg9J+t00yAMpIUjuDXNHLP/tbGDuiszFXzd+C2
         lkSpBGGbmcKhiUOsxF7f+fgeNR1MQvx0hCOHv1+Po4IcNkY3ethDlEd8AcCvwCas0sbU
         zsdazF3P4MJTJcz3RWTo8StZx5YBo/wXihyRMDL5XpDpqrETA47HISw+QX91h1oGvxBu
         tVzg==
X-Gm-Message-State: APjAAAWUmG2lBfTPNt3m8jPaoNQ7gFbp8iRqJZVKkhm4cnU7uhqyp66R
        BE5dGgD8hlsyOwDzfFrXU/mmsAQ6+/4=
X-Google-Smtp-Source: APXvYqxBnS1DmZSGsDIMYqpXlcFZaAZVow4C0bA2hkCnFS1jBUv9n9ne3CSIWrS1nIslM062HM9aIw==
X-Received: by 2002:a17:90a:bb8a:: with SMTP id v10mr109934210pjr.78.1564344450017;
        Sun, 28 Jul 2019 13:07:30 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id z4sm92603491pfg.166.2019.07.28.13.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jul 2019 13:07:29 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de
Subject: [PATCH v2 3/5] xdiff: drop system includes in xutils.c
Date:   Sun, 28 Jul 2019 13:07:22 -0700
Message-Id: <20190728200724.35630-4-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190728200724.35630-1-carenas@gmail.com>
References: <CAPUEspjp3WkHk376hu5EvvyufGYQCSHKM6cTT3hnQyfNgpnLzg@mail.gmail.com>
 <20190728200724.35630-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After b46054b374 ("xdiff: use git-compat-util", 2019-04-11), two system
headers added with 6942efcfa9 ("xdiff: load full words in the inner loop
of xdl_hash_record", 2012-04-06) to xutils.c are no longer needed and
could conflict as shown below from an OpenIndiana build:

In file included from xdiff/xinclude.h:26:0,
                 from xdiff/xutils.c:25:
./git-compat-util.h:4:0: warning: "_FILE_OFFSET_BITS" redefined
 #define _FILE_OFFSET_BITS 64

In file included from /usr/include/limits.h:37:0,
                 from xdiff/xutils.c:23:
/usr/include/sys/feature_tests.h:231:0: note: this is the location of the previous definition
 #define _FILE_OFFSET_BITS 32

Make sure git-compat-util.h is the first header (through xinclude.h)

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
V2: reword commit with feedback from Johannes

 xdiff/xutils.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 963e1c58b9..cfa6e2220f 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -20,13 +20,9 @@
  *
  */
 
-#include <limits.h>
-#include <assert.h>
 #include "xinclude.h"
 
 
-
-
 long xdl_bogosqrt(long n) {
 	long i;
 
-- 
2.22.0

