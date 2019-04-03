Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43D0D20248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfDCLg5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:36:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37930 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCLg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:36:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id g37so7901475plb.5
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hvY2S7a8efdubnqZ497rHTpt8jwV5naQZUHDCe65xZU=;
        b=iLHaeJNRy8jkVVzfq4/eBi2/KrCAc8jL9wfmLOEP9gK8rPGu7ZkWN/8Zj3PZsvDE9j
         Us8ZhIY+ww9xuDNh3fqDVgmBzEMvR5pfa/jYO/u7i9M62V+UgKDM1te32JnPqyrXoXBa
         9IwZhB/R15mB4HqOnRqhcpmsyUYOWZwqgx00tz8zHF8ygIzRkQhAX1cVsFpYp0HHVVvP
         M7SyPb67uh84aRBfB8FWmdi1PnQp7QyH32TkdU1OI1Q1+ji99KssioNuFRZ2yxFShrFb
         29dquJ2fxhfhUVhzlUmDhnhBZuXt+uNETy8WSDL18Jiwu3svqfIs+cA80UGi+ohdKoyl
         c8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvY2S7a8efdubnqZ497rHTpt8jwV5naQZUHDCe65xZU=;
        b=o4YpPlDpyamrUTuJhD/7ntzrGMRtIsS8YCzmik/hU9pRQ+ahGaB10hOOqPZ17UtKPq
         SokVE4p8WkZ4JFDBIvYhMWHI0BvjrKzP03TG8FKm2YGllw4vX6ccR2VId6lp8aPdTPaf
         jGr7f3Miexe1Wf9G+W3cWAwAbPlfZEjnWStWINr1R42c8ddUVbP4//51ATD8vWeuOeN/
         3xCXSSAjVcUoMT1gFOiplbIkPb8W8ngdUzSZqJjRWLWxCHEWOGnPLwuAef6NLS+nj3v6
         wDzZQw28IXlSGRuFEG6UtJ+LCfIo4phC/Wn1BgiPq1IoVPM5h2wFSeWHeyXwQwCw/sHk
         TKfQ==
X-Gm-Message-State: APjAAAWdZocGccQPoWVBMwSWrT5ifVaUOyPo8Orvmj3RuIJaUI1irvO+
        +ffyXh7QXFOC7EFf+H7Al5k=
X-Google-Smtp-Source: APXvYqz5tIFd5wlHJH+ZGZmRSdWbCGw7RL2I6ivbuaK+Z2198xdomBEHaUlHM1lXWAQjbeQplfk+KA==
X-Received: by 2002:a17:902:523:: with SMTP id 32mr74674991plf.249.1554291416360;
        Wed, 03 Apr 2019 04:36:56 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id b9sm9580969pfd.32.2019.04.03.04.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:36:55 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:36:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 20/32] sha1-name.c: remove the_repo from get_oid_oneline()
Date:   Wed,  3 Apr 2019 18:34:45 +0700
Message-Id: <20190403113457.20399-21-pclouds@gmail.com>
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
2.21.0.479.g47ac719cd3

