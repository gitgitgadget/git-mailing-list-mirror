Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532601FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 00:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751035AbdAMAC2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 19:02:28 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33845 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdAMAC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 19:02:27 -0500
Received: by mail-pf0-f182.google.com with SMTP id 127so20505728pfg.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 16:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pRbBCUOu31OEHqc8PTwJ0x49T7r5VlXpAipFBK7U6/A=;
        b=kaQZBJn+ck07BIGBrXqI1zsdpZtsKyVdWM4rlV4fRXT1VPfyp97zgIi49tehIgFaUk
         jL12eMwyHh+qRZUlCFSGyd54O3l/ehazU8jp1u4bEP30DUlG25t7JWNCK5CaESCZ01NU
         guMKfdQtq+Su6/BSRVVi66seWlUrDRt+RLvSDxJIuDQ7AMUwXyyYEZIYMLLss56cQSxK
         W/hLHXg9C4y59NW/JxRRNVrDIqNo9hnpHpMSRTh8WFGm698BCFPW/h1cPAvn9F7e/B6W
         lcXGLf+HE1sIdMfNlNW1xNY4jn66bP9OsWP/CzR4mOm84/atv5WP1MKYm9jNSNpB4KeD
         79jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pRbBCUOu31OEHqc8PTwJ0x49T7r5VlXpAipFBK7U6/A=;
        b=sVNXzL9W0sOTjj4xIULg4Vx1lusfPPY0Ysx9OA8vVfIStPRq0Nd1wEYICuVYzHP9SB
         Va9ZvHXXf7cPpvH5T+Z22ycWik2vYy3XBBLQXhKG/lAeOgz6QUKtvtTJV+zH06EuZAxF
         eG5M7jZ4Bo1DtY3GLE6/HD6RV8uwemknxpIa+krbK8suzk9ckgLF85iGgEf9aJn790jU
         xiqIGijnYL7Mo/cgAI8RJXrJ4MQ4uj2iWiEva/iQdSgtOCqSfGyeOR16mqAQhdBB5OEa
         YUo2SobVHb8RMYRHs9B5prjCAm1SuItW/XIfxvwBoI+ACpJPNPFN0GCrKzaWX0gV/6bT
         B3PA==
X-Gm-Message-State: AIkVDXJtuLLKTbrO/GXhIlBrDLmLmwTmP3SPICeyCIq83CvY5lV6KfjGg6iCnZV5h2mz2iKv
X-Received: by 10.98.56.196 with SMTP id f187mr19671310pfa.131.1484265247946;
        Thu, 12 Jan 2017 15:54:07 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:07 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 04/27] attr.c: explain the lack of attr-name syntax check in parse_attr()
Date:   Thu, 12 Jan 2017 15:53:31 -0800
Message-Id: <20170112235354.153403-5-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/attr.c b/attr.c
index 007f1a299..6b55a57ef 100644
--- a/attr.c
+++ b/attr.c
@@ -183,6 +183,12 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 			return NULL;
 		}
 	} else {
+		/*
+		 * As this function is always called twice, once with
+		 * e == NULL in the first pass and then e != NULL in
+		 * the second pass, no need for invalid_attr_name()
+		 * check here.
+		 */
 		if (*cp == '-' || *cp == '!') {
 			e->setto = (*cp == '-') ? ATTR__FALSE : ATTR__UNSET;
 			cp++;
-- 
2.11.0.390.gc69c2f50cf-goog

