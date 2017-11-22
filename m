Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E78020954
	for <e@80x24.org>; Wed, 22 Nov 2017 22:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752984AbdKVWig (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 17:38:36 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:41928 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbdKVWid (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 17:38:33 -0500
Received: by mail-it0-f67.google.com with SMTP id x28so8058544ita.0
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 14:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=liopgZcch9U7n1uU5Ez4g0Dn+MqGtQtN8fuwUEtckVE=;
        b=fx6FZb/4Sp+NSr5VAq1q5r2m5AxWBhoXbmeX4J9cHIOORcmaB36cKr85O/alKoZ7Br
         OdOtPvMYRlbKRc6PDZdOdWgx/X78ChZEhJ3VsJAfjyPxUG1sT9JnlCqvAWHNl2ddphFd
         wwk4qn7oD1X+MXdRqH9l+XKJCOzs3LrL2DsmlE89pz0RYFGQnABJ9VEqeFKO8HId4vaR
         RxuY89mTFikeqFWon2D2+izdmEs5wCBRPymDhs063SEeq8Ln6ztJ33pVkyYeIO9D0VlE
         l0sGCTJkE1bFj1NdtFPMWBzV5LcVHk2Y18K5DcPatl4KDVsDrGi1Nv9Icor71gJshzLj
         j4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=liopgZcch9U7n1uU5Ez4g0Dn+MqGtQtN8fuwUEtckVE=;
        b=bxZl/QBxi2xGRa54WtEFkHuANhtPzN8x+gGk6qf94HEw9ES7yJ1PQm/4unbiIoFW3W
         u9E/GBvcHfOmO+gZCrI1z50T5FGgR7swtaYDaVYjCNcAzC842cP3dK9C4j0F3QsQkfjW
         pWsW2BWkVK/7So3AYwqeiZTRBK5QAd9BJm8hLgBs2EeYHOPpprwimow4jvQMO9XZnzW7
         1vR7dEDa/YPi2JdSbFB97y9beJfoV8AhBUCnm+mOD36gM0wJ+LmrHEfFPcaPs2K/rrH3
         rcDOGAhyMjx/DUHnxbG3pDtMOt/2iZzMN0RNKYEpeLK0tEg63QVcmZbHs6mojfCxi1Ak
         BDfA==
X-Gm-Message-State: AJaThX6I6RsmM0n0g0hs689prv/U4gUCkeq2lwZ/ojjRCiNjUthnhprk
        O0xje9OZFHQ2a2ilJSD5xt+79AdFXCo=
X-Google-Smtp-Source: AGs4zMary9n3BeRosvzo2HAIboFzxnt6+LWmdLALpPOHAReLeH6LKiCds/HJWVVU3k1nP0nmH0VZtw==
X-Received: by 10.36.12.73 with SMTP id 70mr8628529itn.121.1511390312668;
        Wed, 22 Nov 2017 14:38:32 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id m67sm2575122itm.16.2017.11.22.14.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 14:38:32 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] git-compat: introduce BUG_ON(condition, fmt, ...) macro
Date:   Wed, 22 Nov 2017 14:38:26 -0800
Message-Id: <20171122223827.26773-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.448.gf294e3d99a-goog
In-Reply-To: <20171122223827.26773-1-sbeller@google.com>
References: <20171122223827.26773-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A lot of BUG() invocations are in the form of
    if (condition)
        BUG()
so moving the condition into the same line as the macro will result in
more readable code.  The conversion to use this MACRO will happen in a
later patch.

This macro in name and spirit is borrowed from linux, which defines it as

    #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)

in include/asm-generic/bug.h, however Git prefers to have a more specific
message in BUG() calls that we include as well.

In case the user doesn't have HAVE_VARIADIC_MACROS, I could not come up
with some MACRO trickery to transport the message down to BUG conditionally
such that BUG_ON is a function just like BUG() as well.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-compat-util.h |  4 ++++
 usage.c           | 12 +++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index cedad4d581..4fec462e30 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1092,9 +1092,13 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
 __attribute__((format (printf, 3, 4))) NORETURN
 void BUG_fl(const char *file, int line, const char *fmt, ...);
 #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
+#define BUG_ON(condition, ...) do { if (condition) BUG(__VA_ARGS__); } while (0)
 #else
 __attribute__((format (printf, 1, 2))) NORETURN
 void BUG(const char *fmt, ...);
+
+__attribute__((format (printf, 2, 3)))
+void BUG_ON(int condition, const char *fmt, ...);
 #endif
 
 /*
diff --git a/usage.c b/usage.c
index cdd534c9df..3aed669181 100644
--- a/usage.c
+++ b/usage.c
@@ -240,7 +240,17 @@ NORETURN void BUG(const char *fmt, ...)
 	BUG_vfl(NULL, 0, fmt, ap);
 	va_end(ap);
 }
-#endif
+
+void BUG_ON(int condition, const char *fmt, ...)
+{
+	if (condition) {
+		va_list ap;
+		va_start(ap, fmt);
+		BUG_vfl(NULL, 0, fmt, ap);
+		va_end(ap);
+	}
+}
+#endif /* HAVE_VARIADIC_MACROS */
 
 #ifdef SUPPRESS_ANNOTATED_LEAKS
 void unleak_memory(const void *ptr, size_t len)
-- 
2.15.0.448.gf294e3d99a-goog

