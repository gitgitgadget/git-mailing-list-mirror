Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E827420248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDCLgg (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:36:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35229 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCLgf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:36:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so1511509plp.2
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mk/AggNO03fk2G0u4xF9XXptVhBAQp2iIFzsp49nKTY=;
        b=fDDhqgQOqpkN+tEIBiysroGDC/2PQrup/QWBa8YgumquoqEhJhSysyiyOkfGJ/x3+N
         EuVqQcNhVpSzr/8yf92jCxkiWCIQxrwmi/HIEuxEcdb5idzRRnwDwopraWjYv2dVFsFK
         ytHgyNPbXIL2mGgCbUe6BtqEFWnD2wvegSEHakZ+pv5rLKI8DNGzyqwAaSJNhZ3CMYux
         y1r7XqrbhS+gsXsLQmgWIiSVa6Zllj7Fx1HvEhvcQYUiwgpTkeFSproX3RVHn40pesFx
         PaNttCeLdxUv+viLYJ+199CvObCO2yrzLHaMNQ+d1r7X5Ds+JdPR0ACSJtSxDa3BEUGS
         Vyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mk/AggNO03fk2G0u4xF9XXptVhBAQp2iIFzsp49nKTY=;
        b=ZUG64T65QusH71McZDUXrJCuzQ5LI7X6+uS7gv9xbGB3pXMhjF6E+xCsVFKOuPUXKx
         q+NqompQyyY1GSbgTZmyiyNpNcsL+kqxbv6MCsDSrBUs+Xz/igDJD1l+yHF3iagUs7Te
         UwwObMx00jd8kRAfI+l0GY32/fbNOcq4yg13BKWvXUGBiD7YLj8x/Em8Hilpt265m9qR
         sbZcAqv1wMCB9Kb/q1mPp3qpmSHnomURcQZn9+a4z6PsY1delSLp2NNhLvjk5JzoRmrz
         6CQzPplaAFQh1gKLvlgBTBEnYrUcyodpZXRGRfpRW1w/grMUKbUXzf05TVcKhjJ/V7Ts
         WsiQ==
X-Gm-Message-State: APjAAAV+RgCt5iM916BTaouL9LQBPLByyxn4wpcxW55MqSaRqYhLagSY
        xeMcdUYdiW+7CTlRYBxGYYM=
X-Google-Smtp-Source: APXvYqzZlgS1LuCwmxHOaPiUgrqaB3IgDiptnRt/3p/MCIttcT1Z6LwWLmn7jeVhCAhbVwNFlLzUiQ==
X-Received: by 2002:a17:902:8a4:: with SMTP id 33mr75258921pll.7.1554291395202;
        Wed, 03 Apr 2019 04:36:35 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id x28sm8850002pgl.38.2019.04.03.04.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:36:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:36:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 16/32] sha1-name.c: remove the_repo from get_short_oid()
Date:   Wed,  3 Apr 2019 18:34:41 +0700
Message-Id: <20190403113457.20399-17-pclouds@gmail.com>
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

