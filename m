Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6BD820A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 00:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeLLAZ3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 19:25:29 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:51112 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLAZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 19:25:28 -0500
Received: by mail-qk1-f202.google.com with SMTP id x125so14393763qka.17
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 16:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2x58x6yuU6ZBuCHZiT/ubltWWWoUqLERpmLZzgA35P0=;
        b=A9dDnmHGfPndvl2RrTJKWvOjZPfUNq+3WR8q9kmi4kQOR4JrVmKau4CuKQ7n9jU1GS
         3HoMROV3gBCwAm8TkRAW1yPyTsO3i64len4Or7iBkSHZvd2zwlFUwwMEsFhS4uLzKojf
         va6EapEL6oCCdw1MnjbEWKCYB53w1orF3Qu/i9rjgsoR0ARCrfoNKJZInLu7LjlVvkVa
         wzhH3sQoGAsbPE+9ziH2wvw5R45WK7tw8pL+Cg3TiqYhrQcpwOIg2OQZ1ASrJ5lTYcQI
         9MOQP+W2ksXuG7iy1OrN8EpOgX4v3pvGPlDwggw9DpS0yjRoFmd/o6YU9cu/ykFb3Ilw
         Hxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2x58x6yuU6ZBuCHZiT/ubltWWWoUqLERpmLZzgA35P0=;
        b=D+iJwJhCGRWhw32EJ7Sm76/dhdcbtCoU7uNnv8URhuQV7X/7W+nVPhbmZ757W19Spz
         BAFlFy3Sexs61CouR8Zfj50WZg0kdwVN9cyEITajuPI1Ba3ysR+9gsnadhxDUGc0tsMQ
         opyT4DkaAypPeNM+5Om5eHohcG0V2kh2D+Dcsq11MzCiQqELNg9U9zU+dBYTH7jqsRAL
         eEPQ6GGFdMC8JGshPI1E0l3ntOfJnxMAvZAou8l+By51Ofxqik3ukhJnGLk4Es5c7yHX
         geq5sOrhuhbhuUU2Rt6jkTaHAXhlBOPcTi/9xlRQPTAdhPemxeduAAYX5LFh9beSBJrF
         CeUQ==
X-Gm-Message-State: AA+aEWYlM/0oBLpCCgnxGhSWyjRqIME6BmnBHPc+D7LzS0Xi64Ous0rf
        QiOR1KWVUlMMZl0vKGmNCUaiMYUABvbk6LNv17wxk+tDmRsjkrU+rLIrHqYeYdbOyWblPUuJvvp
        f8ZkCGrAP6+LIlCvuMXwuQRG08A/en+CZeH1/MVG78lqxqxAzhhMwpcp/rHVGQhg=
X-Google-Smtp-Source: AFSGD/VdFny2pqPJ7Kp1nzYwqzwDNWqLo7ITlBrAvTgGAhmnJa+LnBRRqbvFNvH1s+uG64yFseEq1rur+CGEKw==
X-Received: by 2002:a0c:bd2d:: with SMTP id m45mr14050669qvg.20.1544574327715;
 Tue, 11 Dec 2018 16:25:27 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:25:17 -0800
In-Reply-To: <cover.1544572142.git.steadmon@google.com>
Message-Id: <dc995b3d17cd62dfc19964dd8a95811fe928aa57.1544572142.git.steadmon@google.com>
Mime-Version: 1.0
References: <20181116084427.GA31493@sigill.intra.peff.net> <cover.1544572142.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH v3 3/4] remote-curl: tighten "version 2" check for smart-http
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, masayasuzuki@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In a v2 smart-http conversation, the server should reply to our initial
request with a pkt-line saying "version 2" (this is the start of the
"capabilities advertisement"). We check for the string using
starts_with(), but that's overly permissive (it would match "version
20", for example).

Let's tighten this check to use strcmp(). Note that we don't need to
worry about a trailing newline here, because the ptk-line code will have
chomped it for us already.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 remote-curl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 38f51dffb8..b77b173f33 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -375,7 +375,7 @@ static void check_smart_http(struct discovery *d, const char *service,
 		d->len = src_len;
 		d->proto_git = 1;
 
-	} else if (starts_with(line, "version 2")) {
+	} else if (!strcmp(line, "version 2")) {
 		/*
 		 * v2 smart http; do not consume version packet, which will
 		 * be handled elsewhere.
-- 
2.20.0.rc2.403.gdbc3b29805-goog

