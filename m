Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E1AF1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 21:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeCNVey (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 17:34:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40362 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeCNVex (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 17:34:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id t6so6805754wmt.5
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 14:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3XsTDPa1RFBV7p+PF7YgqMkI+CSXFyX/JSIymuSIPYE=;
        b=vdxe+T6h03g0QJeHz69ApaGtA0WSK1Da0z+PNaHGsWs9N0Gj0nNOfqOldOCu1qDSvs
         qQ0K+UdwFpP6COpV5ut++iTgZDWGUB1bB21L+OOYDA60oHbMS8yZf2/7f/vWKgHOgnAi
         RAKhbOXLRz0GMcnwPyYeL2CMyNv96iCLKwqouQnnCqZMDrx6oa7TqbC7PnQSa9OKm4Fl
         9gfCcc0yAb0va2nARESHZ1qg11CVZbMNonnJgqjWS7hza9dHZl9Bdxb/JntMwWWQ7ygA
         1Xhbzcnfpd93vC7MKksXpZu7pt8Jq0qUbe8B1kuvop85YUO52uRbWEc4L0FnA4dOAqT0
         tsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XsTDPa1RFBV7p+PF7YgqMkI+CSXFyX/JSIymuSIPYE=;
        b=BuQy0opCUltF7o2/bAd5Be3Gc51MQ+DWOtUzQnkvBMm6JIgja7igxtLlqjZBaPNutY
         JBiE6FU2sJU2NMLrAYnZILBMkjTEfxh1AxAqVzENpmnIAyycF40BVTmitkk5Nx3vDfub
         XIigoEFqv9j4HOu4pjDvpzVhq+3ArqDoJ1TErrk/YgmxqrdHOGEPz1HgGKRNsdYEzvoz
         mDf6aer2GqdcZH4ALm0A8xVKYYOJusPMGCj8Bxi+of6sOhvqa6zlQFDGLTCdD4ASZHQp
         xapZV9Cn7KTzUeH+Ijrvr5ZkRv175xeglrBtsXWsykGd+/pRlJ8HH+KOhDSYwxCbAVYm
         ZzEQ==
X-Gm-Message-State: AElRT7EA8s0+MFpi9lnshUdR7LGKTUHHg7XkrI2Oaau+mGg7rXJ/17kv
        z+ez5Q9UnAZkZv1iq4TWw6fuA4Jx
X-Google-Smtp-Source: AG47ELtwrh6P+gLD9UUjYAREVW3pRmsdRlzxH2Hx+JnuaK6Ehxq/3f6bmhXxW/+LLvXru2yDgi4kDw==
X-Received: by 10.28.64.193 with SMTP id n184mr2668945wma.4.1521063292166;
        Wed, 14 Mar 2018 14:34:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id 55sm5049688wrw.87.2018.03.14.14.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Mar 2018 14:34:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] shortlog: add usage-string for stdin-reading
Date:   Wed, 14 Mar 2018 22:34:18 +0100
Message-Id: <cd56d4e5b2ca315d51699984456e50e4c6715f49.1521062188.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1521062188.git.martin.agren@gmail.com>
References: <cover.1520680894.git.martin.agren@gmail.com> <cover.1521062188.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This has been missing since we learned to print usage, way back in
4e27fb06f (add commit count options to git-shortlog, 2006-10-06).

While at it, drop the [] around "<path>...". This matches `git log -h`
and Documentation/git-{short}log.txt. It formally makes it look like we
do not allow `git shortlog --`, but we gain readability and consistency.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/shortlog.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index e29875b843..dc4af03fca 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -11,7 +11,8 @@
 #include "parse-options.h"
 
 static char const * const shortlog_usage[] = {
-	N_("git shortlog [<options>] [<revision-range>] [[--] [<path>...]]"),
+	N_("git shortlog [<options>] [<revision-range>] [[--] <path>...]"),
+	N_("git log --pretty=short | git shortlog [<options>]"),
 	NULL
 };
 
-- 
2.16.2.246.ga4ee44448f

