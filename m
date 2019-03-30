Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ECF820248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbfC3LVo (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:21:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34258 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730591AbfC3LVn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:21:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so2444412pgq.1
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mk/AggNO03fk2G0u4xF9XXptVhBAQp2iIFzsp49nKTY=;
        b=NT7cxy1Lnzz5L+EZenc9f2Ha5dxCIHP7sDjzczTEx4PLyzR/80j0lQtLSevkVevZ0Y
         7QtbRixarQYTvoyjzTdbmovuVaQjowFF5vNgH1BfCycOocqQo4U2Bdi86ObU9wc8IopD
         P34o1Sxfax9+9gMzD/NNos4SoKiRfQlDmpIqLkRfTi9YN2puF/7Ej/CjUmx+M7SiFRzt
         Q992lqarDeg05L/3Fq8dPQ+CaWdC00dRtkFBQFWzlFqnrugtDtSsC5H+lziJieODM9dL
         3rvrFQrWaW3FOhLYWw20ibsMtRZxmIxAQKEkyOjGYJueUTZchjXs5J9sCa7QfZpPxvY8
         Lx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mk/AggNO03fk2G0u4xF9XXptVhBAQp2iIFzsp49nKTY=;
        b=fDl3uz9++2laDv7goxukHCQ+F2wqNyOwN2RRiiqi6GEg+CpvCDqSUWOoxgiUDOLd1i
         pOnMow7Kd97WGboQoyHom0AAeMqGsJ6yDNx7PLjGn5JWeFgf03Xelmo0dpJUXxXDn+S8
         S/rEEXFphejeX5c6/wCzLC+dtoZbeEyQ++PMd0pXLMWiad7xDkkYKfSSoPH4H1BPzQyS
         J3e1vV/AgosITzj7MEiPMrVcc9NZkWY4/XmmCXYrxRA3S8UjIIJvThIx8RcvFcAtJDCJ
         F3//xXY0R9GC3iTU7voBAQEEFowVcW/w1RA4Q931PGWHr99zomIFUOaX5ttrJCg4N0Lq
         bA+g==
X-Gm-Message-State: APjAAAXBzOAEwi9UexlWNLc5iK6PV2HjPGIfrKVlikX1cGB9csK+NF+y
        kcng3JdNExqsxoNVbwxdOkBRdikd
X-Google-Smtp-Source: APXvYqyXkfem3lyxyEx5894julogs/7kwUsdRHeJJ7Ercw9pPFEU9tCMsqhqNIEDufXRAbzo+UJCXQ==
X-Received: by 2002:aa7:9219:: with SMTP id 25mr53592119pfo.205.1553944902995;
        Sat, 30 Mar 2019 04:21:42 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id y12sm10653409pgq.64.2019.03.30.04.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:21:42 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:21:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/31] sha1-name.c: remove the_repo from get_short_oid()
Date:   Sat, 30 Mar 2019 18:19:11 +0700
Message-Id: <20190330111927.18645-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190330111927.18645-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
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
index cdcf84b826..2643b75b54 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -436,7 +436,8 @@ static void sort_ambiguous_oid_array(struct repository *r, struct oid_array *a)
 	sort_ambiguous_repo = NULL;
 }
 
-static enum get_oid_result get_short_oid(const char *name, int len,
+static enum get_oid_result get_short_oid(struct repository *r,
+					 const char *name, int len,
 					 struct object_id *oid,
 					 unsigned flags)
 {
@@ -444,7 +445,7 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 	struct disambiguate_state ds;
 	int quietly = !!(flags & GET_OID_QUIETLY);
 
-	if (init_object_disambiguation(the_repository, name, len, &ds) < 0)
+	if (init_object_disambiguation(r, name, len, &ds) < 0)
 		return -1;
 
 	if (HAS_MULTI_BITS(flags & GET_OID_DISAMBIGUATORS))
@@ -482,8 +483,8 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 			ds.fn = NULL;
 
 		advise(_("The candidates are:"));
-		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
-		sort_ambiguous_oid_array(the_repository, &collect);
+		repo_for_each_abbrev(r, ds.hex_pfx, collect_ambiguous, &collect);
+		sort_ambiguous_oid_array(r, &collect);
 
 		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
 			BUG("show_ambiguous_object shouldn't return non-zero");
@@ -855,7 +856,8 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 
 	if (warn_ambiguous_refs && !(flags & GET_OID_QUIETLY) &&
 	    (refs_found > 1 ||
-	     !get_short_oid(str, len, &tmp_oid, GET_OID_QUIETLY)))
+	     !get_short_oid(the_repository,
+			    str, len, &tmp_oid, GET_OID_QUIETLY)))
 		warning(warn_msg, len, str);
 
 	if (reflog_len) {
@@ -1109,7 +1111,8 @@ static int get_describe_name(const char *name, int len, struct object_id *oid)
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
-				return get_short_oid(cp, len, oid, flags);
+				return get_short_oid(the_repository,
+						     cp, len, oid, flags);
 			}
 		}
 	}
@@ -1163,7 +1166,7 @@ static enum get_oid_result get_oid_1(const char *name, int len,
 	if (!ret)
 		return FOUND;
 
-	return get_short_oid(name, len, oid, lookup_flags);
+	return get_short_oid(the_repository, name, len, oid, lookup_flags);
 }
 
 /*
-- 
2.21.0.479.g47ac719cd3

