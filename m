Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3CEF1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfBQKKn (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:10:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42049 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKKn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:10:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id s1so7255314plp.9
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yVF33FHcbjQJZVeB3GisAdmdab6jMRiBps6JZEhvUzo=;
        b=WPW3XngNPxLF5jFhW2G373/hmx5gk0AL6eU/3XQuZ4LNviI7GVKGGLw7ZY5lyWwjry
         rFpWvOsd8errTDH1zTtc4dC2qZZMwMC2eyPprqi12g7W+VqRTItNmGlnnbH0lCjyQeOl
         ZK54mj4/N9dWnVBoLs7x2YLKGJY3iYHXQOepnt889VMc+ZUf+2SALjGjDOB8vzqT/RvC
         m/ehqF58ITiydfS33zcHcm32rYeOVwI0FXu8Kbfxvw8vcFTJQiNTihI0k8QChtubm7l0
         WFCIcrQMDqiqYiyGgD3cCfCfhXsJ5EXHxGB1MwgKolfNS/UIK9jAZVn/lJxJ6d09pK/j
         RB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yVF33FHcbjQJZVeB3GisAdmdab6jMRiBps6JZEhvUzo=;
        b=lmfEzFWx1D6Qo5+y+MC+mkPDIkZ38gtpfNWp8O8wzVPUMCawE0/XB9G4M1+GwwbZEh
         02RcMzxAB1pQNGPMFPqNTT06ce6p/Hc/Lnn5QlDM788tEx8DjKy7YBrcE7NOsE9Gv+2F
         55IFIYKzCcfUqlQwHXggwQoUIocuqTQatO9Mq7gWLmGXV6m8RQvd+1RPMo9H1In4YpYm
         k1sCdCyUakiUBYAb1zlUkN2px81vdkUJpznBLgylRR+jDtUkcTiICe5qhX/CKiGF8qkJ
         SAVo2aOPtuqLaPxblWqTsatV/GjtRHYZfUHGzzVaFAn5SHZR7KMKghW/YW/9DftPEVPk
         70JQ==
X-Gm-Message-State: AHQUAuYf4GXW1cctCtPtG10QutlSbKPaKV4I4wwKk5ld24m8j01Mh13y
        JYwH4Ygd9piJclLFJC9U93txoJ/1
X-Google-Smtp-Source: AHgI3IbnsjhMuy+sLM9WPEX+FDEryM9+KsGskFE1PRnCHscOQtG8iGoNWwd6Hi0FHIXxycP7Fc8Faw==
X-Received: by 2002:a17:902:b70b:: with SMTP id d11mr1794217pls.178.1550398242805;
        Sun, 17 Feb 2019 02:10:42 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id p20sm14761494pfj.112.2019.02.17.02.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:10:42 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:10:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 19/31] sha1-name.c: remove the_repo from get_oid_oneline()
Date:   Sun, 17 Feb 2019 17:09:01 +0700
Message-Id: <20190217100913.4127-20-pclouds@gmail.com>
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
 sha1-name.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 49c62d5254..fb80306f1a 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -15,7 +15,7 @@
 #include "midx.h"
 #include "commit-reach.h"
 
-static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
+static int get_oid_oneline(struct repository *r, const char *, struct object_id *, struct commit_list *);
 
 typedef int (*disambiguate_hint_fn)(struct repository *, const struct object_id *, void *);
 
@@ -1090,7 +1090,7 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 
 		prefix = xstrndup(sp + 1, name + len - 1 - (sp + 1));
 		commit_list_insert((struct commit *)o, &list);
-		ret = get_oid_oneline(prefix, oid, list);
+		ret = get_oid_oneline(the_repository, prefix, oid, list);
 		free(prefix);
 		return ret;
 	}
@@ -1204,8 +1204,9 @@ static int handle_one_ref(const char *path, const struct object_id *oid,
 	return 0;
 }
 
-static int get_oid_oneline(const char *prefix, struct object_id *oid,
-			    struct commit_list *list)
+static int get_oid_oneline(struct repository *r,
+			   const char *prefix, struct object_id *oid,
+			   struct commit_list *list)
 {
 	struct commit_list *backup = NULL, *l;
 	int found = 0;
@@ -1236,7 +1237,7 @@ static int get_oid_oneline(const char *prefix, struct object_id *oid,
 		int matches;
 
 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
-		if (!parse_object(the_repository, &commit->object.oid))
+		if (!parse_object(r, &commit->object.oid))
 			continue;
 		buf = get_commit_buffer(commit, NULL);
 		p = strstr(buf, "\n\n");
@@ -1760,7 +1761,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			for_each_ref(handle_one_ref, &list);
 			head_ref(handle_one_ref, &list);
 			commit_list_sort_by_date(&list);
-			return get_oid_oneline(name + 2, oid, list);
+			return get_oid_oneline(repo, name + 2, oid, list);
 		}
 		if (namelen < 3 ||
 		    name[2] != ':' ||
-- 
2.21.0.rc0.328.g0e39304f8d

