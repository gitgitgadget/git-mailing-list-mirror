Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FAF81FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbdEaVpG (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:45:06 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33498 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdEaVpD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:45:03 -0400
Received: by mail-pf0-f175.google.com with SMTP id e193so18622233pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y52h/Mi2Vw3iG5V8M+Daxydqu+Zkthxh5+zcSWmzkcw=;
        b=SZlrekKkqO0RDxAIxE7YhHsvJaPScj+tR6WmnCyaj52y1Xhyx/1LPdquan59GKmf8X
         zvdUK5o/GoiMwn6oTy6OisSMLSCpXfqjiafOwKJ8ylYIJ22upoPXwAKBNI4EvKmimaJ6
         HMZCgdRSu7AFZP+QTw97ceAjJ4wj5khUrTUnAk7ZlSPtAg9HbXrcR2rmjTNRXHb64wI8
         41TAIO+D49rHUXwkk3LrzXn6rEgRnQeoDxbOlVyX1XjcTtmhMo0cGDL8Xn3kxq99YrV+
         yrYIuVgFqJAiTWtVMCrCU/bOcV99LKbJwsdKe2cCpEjhbLl3LaGk1WsoB1ZRJq9JNyEJ
         Eyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y52h/Mi2Vw3iG5V8M+Daxydqu+Zkthxh5+zcSWmzkcw=;
        b=F1ZFa27RytBcUjDBLKTrqmHeg2rPj9/TXOGxQgCO0+yPUZ0eKQZAbmD86VuZcTJ2Sq
         X4pEd6ThFsp0NkpaFbOR1bNId6h8Ts3PWtPoNNSNdh0iiIQw/0W3AX7QtieeQ/sgP75l
         /Ox5bauPwAe/jMNRWoYWq/cxqx/+x0ETXHjuPKORJq49wmZPClc3nCmTQ5Zn9tWQ8g2j
         a73QV9ESUj/4vtFAJeCVPop4RknId8Ur6Myf1CDGJs5QIbC6emf9OJD9u/4Ir+fmbGgs
         NwBnjjAMzud+bUywh5Lbd/734m2IqPVWrm51SkyPi4xIBC7JUaZ32S5dSV0ZMK4RG0vF
         tWAw==
X-Gm-Message-State: AODbwcDxKaAwe6r7HMZ5SXUy6hpyrh5gSYXygMswG1JDWYf1VZcokldf
        8WPmEIp0XNzrQh2Glw9rhQ==
X-Received: by 10.101.76.201 with SMTP id n9mr410363pgt.40.1496267097652;
        Wed, 31 May 2017 14:44:57 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:44:56 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 16/31] convert: convert crlf_to_git to take an index
Date:   Wed, 31 May 2017 14:44:02 -0700
Message-Id: <20170531214417.38857-17-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 convert.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index 574003023..ff3e72657 100644
--- a/convert.c
+++ b/convert.c
@@ -219,13 +219,13 @@ static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
 	}
 }
 
-static int has_cr_in_index(const char *path)
+static int has_cr_in_index(const struct index_state *istate, const char *path)
 {
 	unsigned long sz;
 	void *data;
 	int has_cr;
 
-	data = read_blob_data_from_cache(path, &sz);
+	data = read_blob_data_from_index(istate, path, &sz);
 	if (!data)
 		return 0;
 	has_cr = memchr(data, '\r', sz) != NULL;
@@ -255,7 +255,8 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
 }
 
-static int crlf_to_git(const char *path, const char *src, size_t len,
+static int crlf_to_git(const struct index_state *istate,
+		       const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
 		       enum crlf_action crlf_action, enum safe_crlf checksafe)
 {
@@ -287,7 +288,8 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		 * unless we want to renormalize in a merge or
 		 * cherry-pick.
 		 */
-		if ((checksafe != SAFE_CRLF_RENORMALIZE) && has_cr_in_index(path))
+		if ((checksafe != SAFE_CRLF_RENORMALIZE) &&
+		    has_cr_in_index(istate, path))
 			convert_crlf_into_lf = 0;
 	}
 	if ((checksafe == SAFE_CRLF_WARN ||
@@ -1099,7 +1101,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_git(path, src, len, dst, ca.crlf_action, checksafe);
+	ret |= crlf_to_git(&the_index, path, src, len, dst, ca.crlf_action, checksafe);
 	if (ret && dst) {
 		src = dst->buf;
 		len = dst->len;
@@ -1119,7 +1121,7 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
-	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
+	crlf_to_git(&the_index, path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
 
-- 
2.13.0.506.g27d5fe0cd-goog

