Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F66A20248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDCLhC (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:37:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43438 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCLhC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:37:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so8013938pfd.10
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHO0+//mUhxK1MPr5Z2K783mNYx8bk2aaztVe1lrmyQ=;
        b=CRE4XDqDRBy0MogF7cZ1THiUp9U+iswV1lqbUnVXxWhl9DxQPjiffiUBUJkMzhoTN7
         Z3WcdOQ7k4ejffHe1lkAExhfSYh1G9I7emWt52FnW6eesrPUCz5I4Nq462HXRpox/KKo
         L6pwxE7XtJ+hNMsYij5aB8GJ1Fezqy7DdBbw45up5R5YmxI8Xa2GBqsHAM3sYxUfrzMp
         IL7E1ZPU0TQ6GLVcfMkL8V9efTIjolhUm957FaVJR7X+kszTddmePs+KSwFZMBMj5ND1
         n+MIkg8NQ8lRLqq0XozZjrtLWK6dtFcnQ/DH9D0Hnk+JBTVKf2V9RDlB2hyE4tg3xmSX
         G56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHO0+//mUhxK1MPr5Z2K783mNYx8bk2aaztVe1lrmyQ=;
        b=jrYrrBd5Xwk//iBh0VpjAa4leCnkLhL3q25NubVxNslW0HJWm7EFAAs8mV9nhU9kok
         IUj4EVFFPfAo1oGapzQm64peQPoG5bLboXYZIZ7+bnUfDjALSSA6JxhuLSHips4k2Uio
         wLWxEbIit5joZ3f0nr550SDgdQiLxPOjIwXh43c6BI/ECphGkYaZ1H9D6VJYpJxoGC/1
         SP+BucdNdy9OyUuoy/GeyOjBbVW63GuSbLGewidGJt5FSiPjcfaNZufw0Nyq7JOI1tuU
         gFJCy+wx134+vHFujTVtEHwfke0Gn6oRMPY061WEEnWmyRyLdgL7jLi2xmGONjituaX/
         x2vA==
X-Gm-Message-State: APjAAAWo8i/2Jy0QTmvUB0OSx3uczqrrU2DFh/VvhlAz93jxAOtJc2LF
        nK5eXQAOjhD7DN1o8MnVTqs=
X-Google-Smtp-Source: APXvYqyNPa/LC12DKVOMqND40cIp+5PrPXx7mhtB0FdlHfSbcaPBhVFOzsFkMVjeFcHxV8h4c8m3nA==
X-Received: by 2002:a63:360e:: with SMTP id d14mr58975289pga.188.1554291421612;
        Wed, 03 Apr 2019 04:37:01 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id k6sm8513439pfj.173.2019.04.03.04.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:37:01 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:36:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 21/32] sha1-name.c: remove the_repo from get_describe_name()
Date:   Wed,  3 Apr 2019 18:34:46 +0700
Message-Id: <20190403113457.20399-22-pclouds@gmail.com>
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
 sha1-name.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index fb80306f1a..1cda854f02 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1097,7 +1097,9 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 	return 0;
 }
 
-static int get_describe_name(const char *name, int len, struct object_id *oid)
+static int get_describe_name(struct repository *r,
+			     const char *name, int len,
+			     struct object_id *oid)
 {
 	const char *cp;
 	unsigned flags = GET_OID_QUIETLY | GET_OID_COMMIT;
@@ -1111,7 +1113,7 @@ static int get_describe_name(const char *name, int len, struct object_id *oid)
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
-				return get_short_oid(the_repository,
+				return get_short_oid(r,
 						     cp, len, oid, flags);
 			}
 		}
@@ -1162,7 +1164,7 @@ static enum get_oid_result get_oid_1(const char *name, int len,
 		return FOUND;
 
 	/* It could be describe output that is "SOMETHING-gXXXX" */
-	ret = get_describe_name(name, len, oid);
+	ret = get_describe_name(the_repository, name, len, oid);
 	if (!ret)
 		return FOUND;
 
-- 
2.21.0.479.g47ac719cd3

