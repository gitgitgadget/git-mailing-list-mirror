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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5902C1F462
	for <e@80x24.org>; Sun, 28 Jul 2019 20:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfG1UHd (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 16:07:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36232 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfG1UHc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 16:07:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so26889437pfl.3
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ztZo2hDwDHahwo6mTy3+v5OLTRu8D1ZyOdlSegjUgI=;
        b=R+ixqYw6gXnoMq0sEuot41I3nVaYSb85dJiysI0DnXVZxXSpceokxfQO7+OrMVjW5B
         5pzx+hGwuUo6dBdgI6UhNNcMuj8GnKqLYob7gBSh/xMSwe1cqilbWu5RTMUg99f8eZS8
         7j2vExcjgMgqHLxoeAOW8TqFBTlAB2YZvJ6q4LVdOQJ4fCREGHYU0QCmbVKWCKjD4d9i
         oeLtHMIYAFn9NyzHY3pTbpn3CnC+Rp7of2X8NX/5UixZhH/QHjO/P/FXLz+liZ5hUimb
         MtOWiGQxKOgfWgRbiUhlFteERU5yE2j8rYCmvKmRnGFwVKzOBWG58W0+AbKWYPqGCiUu
         3Q/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ztZo2hDwDHahwo6mTy3+v5OLTRu8D1ZyOdlSegjUgI=;
        b=egZ98umj35X7dgcMgZjjPNH4IDn63lZwjU9bYnsjqwEpt2rpDZT8sGoPkqzfsA1VFo
         Xv7P4LUYNECFDDycUWv4xUiJ5KxiED84Tc6REKAeqYm6ygK/OfkAI7X1cXooPi5kbhEf
         TF6CSfrPSr2JTFQ/wdcDmSlRMWM0uVkXnEW6m/bzRVPyzUbUr2bO8H9USf/Nw274TAm0
         oB//ZaNiHqQ7xeoC7XPQDt5iJzN2fLvRfWSPWsfqxdjqGEB5Qeb/8Mv2jvMmXp8nXKlj
         ceuJYSDTDRfhhxPJMoScV8SiWS7CDOUZY5b4RivG/Q5tugFRerw19B0rkFZjMpXQpQb+
         nQfg==
X-Gm-Message-State: APjAAAUAxsPK16OFzRntNn1dWb+rn6h7g92xAEfRaxxHUdcHLx4yi7+c
        kOaxdCRJ26hc1W4C5U5qbPGetmkI+Hc=
X-Google-Smtp-Source: APXvYqwZzKzBWFQQ79/QvoeCsRUYkzGco7pTeGfymwuKmxTxXR7Em8mj92YUAmDgrRsFnH86Idh8Ew==
X-Received: by 2002:a17:90a:8d86:: with SMTP id d6mr108084118pjo.94.1564344451740;
        Sun, 28 Jul 2019 13:07:31 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id z4sm92603491pfg.166.2019.07.28.13.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jul 2019 13:07:31 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de
Subject: [PATCH v2 5/5] xdiff: remove duplicate headers from xpatience.c
Date:   Sun, 28 Jul 2019 13:07:24 -0700
Message-Id: <20190728200724.35630-6-carenas@gmail.com>
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

92b7de93fb (Implement the patience diff algorithm, 2009-01-07) added them
but were already part of xinclude.h

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 xdiff/xpatience.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index f3573d9f00..3c5601b602 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -20,8 +20,6 @@
  *
  */
 #include "xinclude.h"
-#include "xtypes.h"
-#include "xdiff.h"
 
 /*
  * The basic idea of patience diff is to find lines that are unique in
-- 
2.22.0

