Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59AB21F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfBQKKN (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:10:13 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:36661 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKKM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:10:12 -0500
Received: by mail-pl1-f170.google.com with SMTP id g9so7279180plo.3
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xNBHZsu7kan+IxdDE8BpjuwLhFOKFTENVGrXmeEEO8I=;
        b=V37ImD55/czvufqIhQeM8EcGrfoNei7NVKThEYhaaJFf9CaFOXFauYLiXqpLerKxE2
         ZxYdyKYN2ixJxDSAKb3HqxIEgx4P8jRvpES0SSvS7OlNLQ4aUoBvim2ROSes1JlDwmN5
         UKEXHmxdFU4wES7GwebPlm5GgwgjwZmbos5Z2bxvYVzBWoDO9FksS7GOFzdW5A4m5Crl
         ce3BrjBZUNCF8T880HKA77TwptCQXm0WxF3sXBgfe+qYajjvlFXf6ofjLqoAoR8iKXtz
         9yY2P2xRrebkA3Aa/q46eX/C9V1L7mqM2b4S0kcTOKLEvzNztj6OdETikyi6VaTXHJzG
         41yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xNBHZsu7kan+IxdDE8BpjuwLhFOKFTENVGrXmeEEO8I=;
        b=TjmBdbFM+8e63oNCVF1M2I8wMPGC7VTsBoTTF4N0rSeP2bubiD9NHtu/o7iLQ6FtHB
         rMzLqS7t/Nli2SGYQCKf952DLy5FOAxXM5U+AhEwh1LO9jRzB0hc15nAiOwjf1VTuM9Q
         hM1xmFICq3Oq9sPK3lTF1QOmDlK1HiZMpfo2i+KRAN+hFrAgsEUM5+UMW49kPabu2fee
         ft40fg7fhrKcr3ZBV6U7iW5uYeRkPsBsBqxY3Ws7me9U8cgyiD2y+clEpxud8vL6Gx/R
         zGIa7VAdod2EgALBmx90X0KBUm4hhD/0K7PELDwNJY7SHBsfv1leh4kyUdknqKpkM0O8
         BQVA==
X-Gm-Message-State: AHQUAuZAUPCjRUZcLcddXZ1+fajBR5LWQIVolbxPargCeAm/E0WQIcmw
        VXeE0NW7DAEzSEbmZZSsSqpOxSVQ
X-Google-Smtp-Source: AHgI3IZrg+WLXHZ+fNZ1b6v1ehtB1tmh1TSgf4ounsRybHcgFSONb4oEu2ZSlk+mC+yaqvly8JEzBQ==
X-Received: by 2002:a17:902:12e:: with SMTP id 43mr19544053plb.31.1550398212165;
        Sun, 17 Feb 2019 02:10:12 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id j9sm13968702pfi.86.2019.02.17.02.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:10:11 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:10:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/31] sha1-name.c: add repo_find_unique_abbrev_r()
Date:   Sun, 17 Feb 2019 17:08:54 +0700
Message-Id: <20190217100913.4127-13-pclouds@gmail.com>
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
 cache.h     |  6 ++++--
 sha1-name.c | 15 +++++++++------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index aa52850d84..524a44110a 100644
--- a/cache.h
+++ b/cache.h
@@ -1019,8 +1019,10 @@ extern void check_repository_format(void);
  * Note that while this version avoids the static buffer, it is not fully
  * reentrant, as it calls into other non-reentrant git code.
  */
-extern const char *find_unique_abbrev(const struct object_id *oid, int len);
-extern int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len);
+const char *repo_find_unique_abbrev(struct repository *r, const struct object_id *oid, int len);
+#define find_unique_abbrev(oid, len) repo_find_unique_abbrev(the_repository, oid, len)
+int repo_find_unique_abbrev_r(struct repository *r, char *hex, const struct object_id *oid, int len);
+#define find_unique_abbrev_r(hex, oid, len) repo_find_unique_abbrev_r(the_repository, hex, oid, len)
 
 extern const unsigned char null_sha1[GIT_MAX_RAWSZ];
 extern const struct object_id null_oid;
diff --git a/sha1-name.c b/sha1-name.c
index b9381aaba6..9b57787b76 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -626,15 +626,16 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 		find_abbrev_len_for_pack(p, mad);
 }
 
-int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
+int repo_find_unique_abbrev_r(struct repository *r, char *hex,
+			      const struct object_id *oid, int len)
 {
 	struct disambiguate_state ds;
 	struct min_abbrev_data mad;
 	struct object_id oid_ret;
-	const unsigned hexsz = the_hash_algo->hexsz;
+	const unsigned hexsz = r->hash_algo->hexsz;
 
 	if (len < 0) {
-		unsigned long count = approximate_object_count();
+		unsigned long count = repo_approximate_object_count(r);
 		/*
 		 * Add one because the MSB only tells us the highest bit set,
 		 * not including the value of all the _other_ bits (so "15"
@@ -659,7 +660,7 @@ int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 	if (len == hexsz || !len)
 		return hexsz;
 
-	mad.repo = the_repository;
+	mad.repo = r;
 	mad.init_len = len;
 	mad.cur_len = len;
 	mad.hex = hex;
@@ -681,13 +682,15 @@ int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 	return mad.cur_len;
 }
 
-const char *find_unique_abbrev(const struct object_id *oid, int len)
+const char *repo_find_unique_abbrev(struct repository *r,
+				    const struct object_id *oid,
+				    int len)
 {
 	static int bufno;
 	static char hexbuffer[4][GIT_MAX_HEXSZ + 1];
 	char *hex = hexbuffer[bufno];
 	bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);
-	find_unique_abbrev_r(hex, oid, len);
+	repo_find_unique_abbrev_r(r, hex, oid, len);
 	return hex;
 }
 
-- 
2.21.0.rc0.328.g0e39304f8d

