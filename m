Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FEBA20248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDCLgr (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:36:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47061 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCLgq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:36:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id q1so8174141pgv.13
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zgl4uDGQElqhR/nr1PaRxHFgma6jHwWws1kyZLI+8nw=;
        b=KbdUYv8k6zRL7gxjzUy7iAkwZ6+U49TSh/+RGBtwRNrccpDQMIdTybe+O+sYyfK6DR
         9I32qf6dmWxa7pzELoLLvKTZQTsFDx8oRCapA7HVB0GKL5hq1De1Pe4v3zFFKYiI/rma
         WNuqOIfy5ZFJ0a5nDQGRlepJw1YeDF1dnZoU/x67CVv/y3MmrOzAvQnDZpbrpv17Fe2L
         oLnc0bi08qLsaNFXPkm8dX1BNUIlfez5tbb1TTz5XZXdor+NLZJjg5K8rcWSJiGz8E3k
         1laGYzn/wJKwlXQQXUgrXOoF7lIqdNMzOiewjeP5UsLjrxRg+0n7+s45evwIUB+0MV+m
         jX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgl4uDGQElqhR/nr1PaRxHFgma6jHwWws1kyZLI+8nw=;
        b=L2vVMXeuQ5sQ2GW6HZTUXs+pw/JXIjU6Rl+3wHuoybP6q4fKX7Brr6ZAx4F7j5PxnC
         AJPRn4WnnVZzEYgzFAUTXB5Tzc20c+/d6pGh8Xiwg1xlnxJoEMh+nQgkn5qLORsVs1aG
         BVnjraPHZ+cPH18qkVIuXER62gjEWUPPPiwbR9Xwz9vdfYFmrQXyAFpGuz2S2RmK335Z
         /sNBMACyJ1yjGwSEazfQ6Y5P9XmpAzVUiiu6f5CcK/Mg2/AnQbTqNCD3JW0vnaQmzNBr
         oGGzOVhs7l/Pkxg3P0/VzUhEDSabQ9Kh0XzQJsNlAZHzBcpKe91eMbgVCFIDeguYI56f
         usVg==
X-Gm-Message-State: APjAAAUlLUNd6tl0+G7Afh5KWikgZ41CgnG1uCZRSpKVb0Ldh2mP52z0
        f7f4aCV1fU1QTScwegirZjs=
X-Google-Smtp-Source: APXvYqwLtDGc8oPcQt/hRsA25hU+eaqvm98UoIM7YOQKMQNwbRB+J/gsgbzvECw399l1lt+hg5Npkw==
X-Received: by 2002:a63:e051:: with SMTP id n17mr71901948pgj.19.1554291406202;
        Wed, 03 Apr 2019 04:36:46 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id l63sm23382148pfc.89.2019.04.03.04.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:36:45 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:36:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 18/32] sha1-name.c: remove the_repo from interpret_branch_mark()
Date:   Wed,  3 Apr 2019 18:34:43 +0700
Message-Id: <20190403113457.20399-19-pclouds@gmail.com>
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
 sha1-name.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index af8bf5b351..7d9512ac44 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1412,9 +1412,9 @@ static int reinterpret(const char *name, int namelen, int len,
 	return ret - used + len;
 }
 
-static void set_shortened_ref(struct strbuf *buf, const char *ref)
+static void set_shortened_ref(struct repository *r, struct strbuf *buf, const char *ref)
 {
-	char *s = shorten_unambiguous_ref(ref, 0);
+	char *s = refs_shorten_unambiguous_ref(get_main_ref_store(r), ref, 0);
 	strbuf_reset(buf);
 	strbuf_addstr(buf, s);
 	free(s);
@@ -1435,7 +1435,8 @@ static int branch_interpret_allowed(const char *refname, unsigned allowed)
 	return 0;
 }
 
-static int interpret_branch_mark(const char *name, int namelen,
+static int interpret_branch_mark(struct repository *r,
+				 const char *name, int namelen,
 				 int at, struct strbuf *buf,
 				 int (*get_mark)(const char *, int),
 				 const char *(*get_data)(struct branch *,
@@ -1468,7 +1469,7 @@ static int interpret_branch_mark(const char *name, int namelen,
 	if (!branch_interpret_allowed(value, allowed))
 		return -1;
 
-	set_shortened_ref(buf, value);
+	set_shortened_ref(r, buf, value);
 	return len + at;
 }
 
@@ -1509,13 +1510,13 @@ int repo_interpret_branch_name(struct repository *r,
 						   allowed);
 		}
 
-		len = interpret_branch_mark(name, namelen, at - name, buf,
+		len = interpret_branch_mark(the_repository, name, namelen, at - name, buf,
 					    upstream_mark, branch_get_upstream,
 					    allowed);
 		if (len > 0)
 			return len;
 
-		len = interpret_branch_mark(name, namelen, at - name, buf,
+		len = interpret_branch_mark(the_repository, name, namelen, at - name, buf,
 					    push_mark, branch_get_push,
 					    allowed);
 		if (len > 0)
-- 
2.21.0.479.g47ac719cd3

