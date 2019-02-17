Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43CA21F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfBQKKb (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:10:31 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40378 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKKa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:10:30 -0500
Received: by mail-pg1-f195.google.com with SMTP id u9so3468323pgo.7
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AIX1utwjZ4XmPj07TzD2/xpds0E1boUeoo3mdY8VyGA=;
        b=DcdUzm/TXlUrDKTTGRfn3ihiBmdwhNuctzrFK6ACfOqHs8kjybJwNCwoMT2Akm1Q15
         3jRMwj70zeQxJ6Pz0H0tLN/bu3TxQtU/EOt6yTrohNhu9p1Ceauqhnx70YvZ5g4Txnus
         0xpu6zKIgIQKYktypOvNI2i4lVXkMTz/UHJbJA0+ARWun09qKxKheFgHo/OxW3zdWbWv
         2T1eUmZfXlP8qJy+kNnaBsxkynp04p1787MCVQMDI5/4ffE5Fo94sfuvvuvgSw5aJ6Sh
         2KwB8Oz3XhKz3XVVDhllw+cNNGU7O+heN1HkRa0cu2+aBYIedbfy15+AaGjobRV4t1LY
         eT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AIX1utwjZ4XmPj07TzD2/xpds0E1boUeoo3mdY8VyGA=;
        b=moEzQwCgXWCgyaGCEWDopWTn48tiGEFEnQyJjwmkd4rud7IyCbsM0sL5mH33obgaD9
         24XsTZqj7Zt6j2mjc8GeG1CXomBM9RI4yIxu3XlzTxBUXQ0hkOelJ9zLtEJptnpr6iKQ
         /QEMbkdRy/g0v2JWrtIGK+MhNmqkJvepHvgd96xChG4r4KCFRr/NhZYCuRXBgmhEblLU
         ApYlZdysT3su03Yw9RCqV9XWlwQUJGYprRdbPIYU37mz/GfXSV3bP/EhXM7roQj/axAw
         i4DP0R8XeOuHLQHlbpwuyoBFY2hSxkZMiuNTtGi/hVkPbcWBV8xuR0t6kVCtsrh/DceS
         uPMA==
X-Gm-Message-State: AHQUAuaE3URMAidHhWaohTTbwLTGgp5fKPnUPeXjlVZrWsAjeS8Bihk9
        EV2Gb/XbiOlNjWCPjlkVXPBfu+/3
X-Google-Smtp-Source: AHgI3IZKnzuOqMicL9mV2kBcLgby5skdIm+c2CZmrgOqUceFn9QjfLVsYEHOaA+jWjiH3QxL4Unw3w==
X-Received: by 2002:a63:2682:: with SMTP id m124mr12601387pgm.35.1550398229619;
        Sun, 17 Feb 2019 02:10:29 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id s21sm20173065pfk.133.2019.02.17.02.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:10:28 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:10:25 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 16/31] sha1-name.c: remove the_repo from interpret_nth_prior_checkout()
Date:   Sun, 17 Feb 2019 17:08:58 +0700
Message-Id: <20190217100913.4127-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
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
2.21.0.rc0.328.g0e39304f8d

