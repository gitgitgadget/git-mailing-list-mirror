Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 504B520229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935773AbcKJUek (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:34:40 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35136 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933893AbcKJUej (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:34:39 -0500
Received: by mail-pf0-f169.google.com with SMTP id i88so151077199pfk.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kdeEN4mkSFWIOnCpI+hdJkCAcCBbX+NBkt/VU9VTyxw=;
        b=fhPIrCudEybGsJNhc49IGfYgA+uKo1Wem3+bf5uGSKSF7B3M1+Jqaz8gaFt6gmm9mI
         4I6slqTJ2/9P+S4bz7R6GAye6oWlVT6p0xl0hixEZLgAQFvxa2CtVMIAKH18hmmg0V7j
         EmIylxwPb9MIBNHI/FeccTL/S26CC7/c7iljX2zmqaO5wIwYPRX3Ek7IMR84DTBG1qiJ
         00uuDXnkiUOWc9vEy0OoAYjHWxIL/6AGFqKbP/tG0Rr8tf+yycm63mksd5KS5x3xevvu
         RfvSTicH4YUDOxlax9adZYpqDZA8589cVNbCBAkJX+oolPnYqvpDi9x/UJgKxrZQrTYR
         Ryqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kdeEN4mkSFWIOnCpI+hdJkCAcCBbX+NBkt/VU9VTyxw=;
        b=A8q6EeeUhddKvmZ5CuD+r5b5F1U7cIDa5ddR3ToN27M8rJ8m0YRFnKgEnD/YgxqO1a
         YOCLIBoj9wrPR27L7KyX/Jmoi1ynys577InBstSst3CoYkGYuCXlL1OJdQgqMTOt16qE
         v2tJ/gKgfumqEfwU2BajtaVeRJhe1SKylLJD+hyCsuP7WMqr7jp1L5wPOiReA8OZG462
         FiwG+bBzNrzi69zO6drmo7kbznI5Zun0w8FCL/tjeAvjbfVnGRNTPYBFp0PFamxSZF4M
         H1CWKsBrWX94luVZnUw7E5IgE9PRMZE+D93wyrTWfdUQBJ08Cx0EB6QN3Pmlr2EFZB32
         YYiw==
X-Gm-Message-State: ABUngvcOMFMcKI5UI49ENUXyxu+260QrQSWmloqUVr9rQcSRG/T59i+LWsAzBTNcgYFRXg/i
X-Received: by 10.98.74.142 with SMTP id c14mr13390150pfj.139.1478810078234;
        Thu, 10 Nov 2016 12:34:38 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id p64sm9252037pfi.88.2016.11.10.12.34.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:34:37 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/35] attr.c: use strchrnul() to scan for one line
Date:   Thu, 10 Nov 2016 12:33:55 -0800
Message-Id: <20161110203428.30512-3-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index eec5d7d..45aec1b 100644
--- a/attr.c
+++ b/attr.c
@@ -402,8 +402,8 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 	for (sp = buf; *sp; ) {
 		char *ep;
 		int more;
-		for (ep = sp; *ep && *ep != '\n'; ep++)
-			;
+
+		ep = strchrnul(sp, '\n');
 		more = (*ep == '\n');
 		*ep = '\0';
 		handle_attr_line(res, sp, path, ++lineno, macro_ok);
-- 
2.10.1.469.g00a8914

