Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A7021F42D
	for <e@80x24.org>; Fri, 25 May 2018 21:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030296AbeEYVBn (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 17:01:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55011 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030292AbeEYVBm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 17:01:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id f6-v6so17537073wmc.4
        for <git@vger.kernel.org>; Fri, 25 May 2018 14:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7YpNUgrv6SjFf5UBzN3d9vI+2L/cI/nrcS8QrOKsMjk=;
        b=hmpfwIVIfxu3bcJo+JeIQYNChApVrOc0n4jXTeF+cehZGSSfNdB1O79qj56vsqi4k1
         Z5SEj5+TKEgUlf1PFXwn9TRk5zUd0vczdrbVwwmCGPJrlXjodnrcLqNfvo6CEf59BdwG
         nAS2YXTmh1huOUkd9y+Y/fKGt0GrfTXnB3PIYTyAvsEdDDt2EQ9rwfWlxgJDOFkIXDt0
         Onkkc6ryXeZSXI9u+DaKrEeOGETjTo5Y93ben8hQVJ276lzeWHzOFCQnNO3ECHQXCiRK
         gF4gQjbGFryFLkcEowfg7JBrYQDXzCHbY3hYymzd2IwAMS2/2GLHeuLvX9SsHTncomsE
         xuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7YpNUgrv6SjFf5UBzN3d9vI+2L/cI/nrcS8QrOKsMjk=;
        b=CPK++GLnJJwQK3/7UTdRvUvi5MbF0opnnaPH3lyr1CXC0hew6rLsjr6GgrxgExiNi3
         yet/Nei6QXMu8RD/xIVpT8hW08goOjKbkAIPsuXy1VW/hTpn7Clx3coa0TsImnB9Z4y8
         lTNHr795g+109wM9AigULgoI2I0FC9mTkQZhQpF/RLaoIRjuAjHUeY+2U3LIO+toL6Om
         o0ICiHtwHLDt6hjpysOwH6/yFniU7WLsB7/vmNyRBzaXzn8teDwgJuIQXT9x9H4Isw57
         DJsLptxdU8KSOWaVx5GUn+ePe9RdTkTScOvtFbin7fXMn6czhMJNxZDgAUB8ETDtcqjT
         iZvQ==
X-Gm-Message-State: ALKqPwcGNWgBlJyziIdVLy7ooUL/W6rl7Sf+N8xeWJLInirv+aY8hfwh
        v/4r8vXt2f88iNI31wSAODVpDXZ5
X-Google-Smtp-Source: ADUXVKIATfJ0eecQuBDI9RETUpY1KF1E0Gm90T4i2QQWzsd4H26QT4W0RKegmfNy915hzIIL7w1jbg==
X-Received: by 2002:a1c:c2d5:: with SMTP id s204-v6mr2711436wmf.40.1527282100811;
        Fri, 25 May 2018 14:01:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id q9-v6sm2520105wmq.45.2018.05.25.14.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 May 2018 14:01:39 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 3/3] usage: translate the "error: "-prefix and others
Date:   Fri, 25 May 2018 23:00:55 +0200
Message-Id: <0a709ff2b1af85d21e96d9e259f2ec9f69d3a94d.1527279322.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.1181.g093e983b05
In-Reply-To: <cover.1527279322.git.martin.agren@gmail.com>
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com> <cover.1527279322.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Translate the "error: ", "fatal: ", "usage: " and "warning: " prefixes
that we use for reporting that kind of information.

Do not translate "BUG: ". We tend to prefer the messages themselves to
be non-translated (and they're not supposed to ever appear anyway) so it
makes sense to let the prefix be nontranslated, too.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
This change breaks several tests under GETTEXT_POISON, e.g. t6030 which
does this:

	git bisect skip > my_bisect_log.txt 2>&1 &&
	grep "warning" my_bisect_log.txt

 usage.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/usage.c b/usage.c
index 6a5669922f..7709cb22e7 100644
--- a/usage.c
+++ b/usage.c
@@ -39,24 +39,24 @@ void vreportf(const char *prefix, const char *err, va_list params)
 
 static NORETURN void usage_builtin(const char *err, va_list params)
 {
-	vreportf("usage: ", err, params);
+	vreportf(_("usage: "), err, params);
 	exit(129);
 }
 
 static NORETURN void die_builtin(const char *err, va_list params)
 {
-	vreportf("fatal: ", err, params);
+	vreportf(_("fatal: "), err, params);
 	exit(128);
 }
 
 static void error_builtin(const char *err, va_list params)
 {
-	vreportf("error: ", err, params);
+	vreportf(_("error: "), err, params);
 }
 
 static void warn_builtin(const char *warn, va_list params)
 {
-	vreportf("warning: ", warn, params);
+	vreportf(_("warning: "), warn, params);
 }
 
 static int die_is_recursing_builtin(void)
-- 
2.17.0.1181.g093e983b05

