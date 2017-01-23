Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74AA720A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbdAWUfp (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:35:45 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33312 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751513AbdAWUfn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:35:43 -0500
Received: by mail-pf0-f172.google.com with SMTP id y143so43744639pfb.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D+vEmF75eT9Ais22yscP8QVp1k3bwesgcYspdacfbh4=;
        b=LCctAQy6n0HvJzS2/41BuXAg7f8xUNa6li+fY5P8y0D+Vmj6c11WGq+0eAGOB330a/
         5JFSHgDm6iC2L0jt510dcn20YGo/VzNzk9OQojKmWJ6bh+W9xUVrvqWD2hn9mY5jfJPq
         YNboR1KpX5PedH7n9qJBudA4juUmxSBz+YiJ3Lhdv4J6wWM1vsAUd5I62ksBE+hmgDVL
         OkQQ4b3hHtpmtGkitVpLnnpEeiR3Bnr6ME9KZZuOr/IlQ7B6KrE8JrVfe3T1/1Yq2acF
         S5EXgi0lFbjnUZEVOyICe74T28gf00n4HVfiJtbOzjDTLrlDVh8VPkRxP43eAwk9yB8L
         tjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D+vEmF75eT9Ais22yscP8QVp1k3bwesgcYspdacfbh4=;
        b=hmj7zh5j7bgtVto9dxCK8wrXa75JyL1cWN5V6BveabVIKM5cWrcB6QuUOhetlb4fPy
         J9Vtd/6huwrrlc1lMxpx8/hPDiUzoz/O+YmbFRDwrNb/7j7rSv9bO3BzzCIpv54MIf+4
         nunTVDhODI80agqD9S2CJ5ekV23z98zijdJFMRQKIECS047KPAIyLOUHG78PzicRDzO4
         9CWlOwDsF9Wyx1c5s7n1Rj7u8jQqeCWf41fOXfWDZdIXBiw0ob68KdXbJ9vI3RNk7/jD
         7kvci+KeIyY7ChqRzGp535CT1idrtH4aBkAaVkArrtRDhMfla1dz3Yc9AiJek2hKPpcc
         2BkQ==
X-Gm-Message-State: AIkVDXKMr+2Ylaq2r/g6lVMenz499k5EMAzMYILXR5WI3FSK+luV7+kewuN0ROhrxN7+ghde
X-Received: by 10.84.167.2 with SMTP id c2mr45033039plb.56.1485203743173;
        Mon, 23 Jan 2017 12:35:43 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:35:42 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 04/27] attr.c: explain the lack of attr-name syntax check in parse_attr()
Date:   Mon, 23 Jan 2017 12:35:02 -0800
Message-Id: <20170123203525.185058-5-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
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
2.11.0.483.g087da7b7c-goog

