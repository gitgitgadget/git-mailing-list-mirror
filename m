Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9E5F20248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfDCLgl (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:36:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43407 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCLgl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:36:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so8013570pfd.10
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9UDdC6QudJc1/9WbTZNYgF9nZ77a17Sjj1O8i1ENOk8=;
        b=nFbdjKc2MTLF9mImY1V1yIj0msIW91BKY7G4bufT097YhfSBsFHQrXlFNySoamJI0m
         0lezgwasXKF1D2kDJFehF9cjBaw5hGGvheCZnkiuu1OCbmNhz72AjSf4nUxDcRYLWX9e
         AL2Uep5e9dixrTSW73wDNb7BKdxQEB7r4vyRXh3SuZl04da1JtFwZKCRCPA2U3WZXWem
         l2PWiF8G7+/G0VAt5yiIyN727Tzbk0Ysb4pMvgKtuVwe/e8cCjsItPdGU+wSP6UbYqFR
         s1Md2L0XjTbGoSwqdtQQLlU0UOf0ICpDrQHjQdYBxuwpi7Da9V6AEM4UvDqn14VD50gY
         9zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9UDdC6QudJc1/9WbTZNYgF9nZ77a17Sjj1O8i1ENOk8=;
        b=gkGt5CkWpPvmZDM65WH0Drw8J1RTYr21Uigosus78omasro7COtcv3l/i5EGOppARg
         PSiGOTpjGk4uM3FMTHfYmUWh5qnFmY1TdfA/iy83pjmctf0JUbOWrzAK8dzAEfSWqLw5
         3bhA7ZbS+LuGz7LMCn6JwnBcId/u8VmBTeVd8t6WwKUA4tGWzAFOtx0J5vxFvp6SCspR
         q6n15bxY8M0Ku2XTaAAx/l/nH/Xbk9Zlic+mK89jFBatwZ/ZSweJdeOyFuIl1Nla0WUz
         BL0thSBkXg/TXfctsosz2iQuNZ1/xwJUr8w1IMQ+0MTlJeCkVwTmwxYX4ktc+aAQYrNo
         +XHg==
X-Gm-Message-State: APjAAAWyCojcfm5Hu1X3PXqMr/k+tFoSZeqiRCzlVLCgVjZ5HAumsZ2q
        vXZ2hiI1+Yu7uR5n6AmBhMmr6G/k
X-Google-Smtp-Source: APXvYqzDdf/52ahXao0Ezae7udlAZHcvZwgrBj9/K8usEIo7pp2EITvrojQLRdqKYYy7RQjKx3q4Lg==
X-Received: by 2002:aa7:8289:: with SMTP id s9mr61355515pfm.208.1554291400864;
        Wed, 03 Apr 2019 04:36:40 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id h11sm18330409pgq.57.2019.04.03.04.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:36:39 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:36:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 17/32] sha1-name.c: remove the_repo from interpret_nth_prior_checkout()
Date:   Wed,  3 Apr 2019 18:34:42 +0700
Message-Id: <20190403113457.20399-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190403113457.20399-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
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

