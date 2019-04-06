Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B999D20248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDFLgw (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:36:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37018 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLgw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:36:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id 8so4766901pfr.4
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9UDdC6QudJc1/9WbTZNYgF9nZ77a17Sjj1O8i1ENOk8=;
        b=nHOIFdeNwJDQodpWXJ+ednQ13AM85IRajMsFjrTiXdMQdVfsRxHwu49xAY8OiSH6v5
         Fq2ssGpnNGiMauhr6fZzrsDpTORpxuLSe0aL503eC4+TLyXI9TKwToQfkhPwcIDALqF8
         vhcT3Mg7DgLfRw2yymoF0HVe3g9rBAmzAWzlV9dXgbQBzN0u0EGBhG1fo2zJhrOkkHTf
         ycqlvAq6wUUEkc9tjKgK6cxDSiEbmL7+s4q2I2HNhswEVlWOiNEIjLDlQylmyoxL6NTL
         FbTOVPgshGXKNZdUcrDFlO9gWsMyBFMoKUu8kS/CFY8jO6cj4WVi3Aj423spoOPSMBZb
         39wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9UDdC6QudJc1/9WbTZNYgF9nZ77a17Sjj1O8i1ENOk8=;
        b=YJ9EKZ7radYGjqMiiNKditESHHpCusniHeCImILMTSbQ2WblHQcokdz4IGQ9RoPChx
         e6DqiX5V6jmeKOPmkzh/+CYbhOcwOCS2UQ8nZCcu8VhpTr/Cny5IM2GyKdyRWqrd+1xT
         tAjfEizM67poTLcqfEkwmo1E0AJd8RpkSP1e360Kml0lW8uwFCCKrexyHLbHWZhus3Lc
         2i3OfR788kHyM/vT9znt5dBJFs4bGdXgi1tZX5gqCfFDcDbLndhBBI3lEqNp2Ze3S316
         HL1T2EVVIuUuBH2mcALFy7Se3VAGuh49a3SLIk4Ssfe0nCUVHncOuXGeGst0VDA4XeQ/
         Enug==
X-Gm-Message-State: APjAAAVomPsSWo/L+fIO9p+lY4sW3gkNUFwYQkRpcLiQAIDRIcj/GE49
        2mmH9grBbRPLjkUjkfKUacQ=
X-Google-Smtp-Source: APXvYqzSFHcTrkx8/RDDksv7ES+F7i2niZ7kTtJcqvsqHvLYWDPVW41ymRQvCpO3lbVnvKOJiYJc/g==
X-Received: by 2002:a65:4341:: with SMTP id k1mr17681414pgq.88.1554550611960;
        Sat, 06 Apr 2019 04:36:51 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id j62sm16775714pfg.6.2019.04.06.04.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:36:51 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:36:46 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 18/33] sha1-name.c: remove the_repo from interpret_nth_prior_checkout()
Date:   Sat,  6 Apr 2019 18:34:38 +0700
Message-Id: <20190406113453.5149-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 2643b75b54..af8bf5b351 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -771,7 +771,7 @@ static inline int push_mark(const char *string, int len)
 }
 
 static enum get_oid_result get_oid_1(const char *name, int len, struct object_id *oid, unsigned lookup_flags);
-static int interpret_nth_prior_checkout(const char *name, int namelen, struct strbuf *buf);
+static int interpret_nth_prior_checkout(struct repository *r, const char *name, int namelen, struct strbuf *buf);
 
 static int get_oid_basic(const char *str, int len, struct object_id *oid,
 			  unsigned int flags)
@@ -835,7 +835,7 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 		struct strbuf buf = STRBUF_INIT;
 		int detached;
 
-		if (interpret_nth_prior_checkout(str, len, &buf) > 0) {
+		if (interpret_nth_prior_checkout(the_repository, str, len, &buf) > 0) {
 			detached = (buf.len == the_hash_algo->hexsz && !get_oid_hex(buf.buf, oid));
 			strbuf_release(&buf);
 			if (detached)
@@ -1288,7 +1288,8 @@ static int grab_nth_branch_switch(struct object_id *ooid, struct object_id *noid
  * Parse @{-N} syntax, return the number of characters parsed
  * if successful; otherwise signal an error with negative value.
  */
-static int interpret_nth_prior_checkout(const char *name, int namelen,
+static int interpret_nth_prior_checkout(struct repository *r,
+					const char *name, int namelen,
 					struct strbuf *buf)
 {
 	long nth;
@@ -1312,12 +1313,14 @@ static int interpret_nth_prior_checkout(const char *name, int namelen,
 	cb.remaining = nth;
 	strbuf_init(&cb.buf, 20);
 
-	retval = 0;
-	if (0 < for_each_reflog_ent_reverse("HEAD", grab_nth_branch_switch, &cb)) {
+	retval = refs_for_each_reflog_ent_reverse(get_main_ref_store(r),
+			"HEAD", grab_nth_branch_switch, &cb);
+	if (0 < retval) {
 		strbuf_reset(buf);
 		strbuf_addbuf(buf, &cb.buf);
 		retval = brace - name + 1;
-	}
+	} else
+		retval = 0;
 
 	strbuf_release(&cb.buf);
 	return retval;
@@ -1484,7 +1487,7 @@ int repo_interpret_branch_name(struct repository *r,
 		namelen = strlen(name);
 
 	if (!allowed || (allowed & INTERPRET_BRANCH_LOCAL)) {
-		len = interpret_nth_prior_checkout(name, namelen, buf);
+		len = interpret_nth_prior_checkout(the_repository, name, namelen, buf);
 		if (!len) {
 			return len; /* syntax Ok, not enough switches */
 		} else if (len > 0) {
-- 
2.21.0.479.g47ac719cd3

