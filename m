Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF4992027B
	for <e@80x24.org>; Thu, 18 May 2017 23:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754236AbdERXWN (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:22:13 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36852 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdERXWL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:11 -0400
Received: by mail-pg0-f41.google.com with SMTP id x64so29452837pgd.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s+n7RB13XiiCFpOGLq8JKQo/qYm/+Ac9PKzFU0YQlx4=;
        b=NdwNyJweuHNFWdENyTOp9wZGROKyI4s+1U7vY1HwgLg+MBpBidRqfJJ3T5uEnsIlCn
         d2tN82zaTJemuzcHVLo2UzEqrUeWRK9OkPg49EeG/eZ+cKSfctQBTWoQRBYl3O50s7/6
         U9k2y08WdmpL1aFNGx+JgIc04qkHuHXO7miIgFjI4tnTVa9d04zTjlaCf5kwnKuqWHv/
         Z+8RvB+XcBjbl9tMW5myx6fx2nJjLG/ja4km1+SIzwFLO1CiOwV3nTqtD4k13sD1F141
         oe2l9DcgpP+GKTJQ7wUBnT7IhNP3TJn8adyu6S1cM7/yTMF9O36pf5+aecsey/mbPqmt
         UM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s+n7RB13XiiCFpOGLq8JKQo/qYm/+Ac9PKzFU0YQlx4=;
        b=UDGqWJHP8ubi0/iMzgs5mAuKY7aHPBwuRbqQbhyzwxq+dY09yDSmfeohsaIHFYPRc9
         LZtm249Pb/CxyBO9pJTHU2W8Llbakg9d4/n93nMcT9DqXGnI+c8CmQhgOeMf/YgiNdPC
         b7RksGKqy2hUkTnH7V/IvDliqFmC/kx00vLQ05Ks3BhTY+6QAs76Uw0b8c1cOF4xlW3U
         fbIP/+8wDPWr/5kKNFWbZd/opH4hKNeuHGgEjBPAc4bD1x1KDJC6L9DlXnaZ5g5LgCLC
         VWFeKCr59kkd9xnh/NIvqVas+uDvqM9Z3w0KrvYXhia2naeQskj0dqzo21MQh/E8toR2
         Er5g==
X-Gm-Message-State: AODbwcA4Oqlx5UKByyOU1Cl+X/juk94vNblq+aTMaewarhyHNRXPnaVZ
        KBuVzJbuFjMLD+Lm
X-Received: by 10.84.134.34 with SMTP id 31mr7584988plg.178.1495149730558;
        Thu, 18 May 2017 16:22:10 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:09 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 02/23] convert: convert crlf_to_git to take an index
Date:   Thu, 18 May 2017 16:21:13 -0700
Message-Id: <20170518232134.163059-3-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 convert.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index b1b90d6e6..f5773cfe1 100644
--- a/convert.c
+++ b/convert.c
@@ -217,13 +217,13 @@ static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
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
@@ -253,7 +253,8 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
 }
 
-static int crlf_to_git(const char *path, const char *src, size_t len,
+static int crlf_to_git(const struct index_state *istate,
+		       const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
 		       enum crlf_action crlf_action, enum safe_crlf checksafe)
 {
@@ -285,7 +286,8 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		 * unless we want to renormalize in a merge or
 		 * cherry-pick.
 		 */
-		if ((checksafe != SAFE_CRLF_RENORMALIZE) && has_cr_in_index(path))
+		if ((checksafe != SAFE_CRLF_RENORMALIZE) &&
+		    has_cr_in_index(istate, path))
 			convert_crlf_into_lf = 0;
 	}
 	if ((checksafe == SAFE_CRLF_WARN ||
@@ -1193,7 +1195,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_git(path, src, len, dst, ca.crlf_action, checksafe);
+	ret |= crlf_to_git(&the_index, path, src, len, dst, ca.crlf_action, checksafe);
 	if (ret && dst) {
 		src = dst->buf;
 		len = dst->len;
@@ -1213,7 +1215,7 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
-	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
+	crlf_to_git(&the_index, path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
 
-- 
2.13.0.303.g4ebf302169-goog

