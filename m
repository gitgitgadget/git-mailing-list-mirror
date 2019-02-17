Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 718011F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfBQKLB (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:11:01 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:46104 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKLA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:11:00 -0500
Received: by mail-pf1-f173.google.com with SMTP id g6so7057520pfh.13
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FWtW8F+aTvlCIWgx9l8lCP+h+/ENvBp0MjAgoCZB/Es=;
        b=Jkmf30ZmMvCksVqz5g7HNdRdo1gXJSAwvsxkwjze/1IzwLsQCUbBkMOmtRyf17YGGP
         AKOs92j5C2ZsSmEj7R2rqlrv5awivs2z4YIqAofoF+vQeVCgjosB7F5wi8q6SJVJsXW3
         6iyI7za7gRvtDsWJvD1gq+70AqaBA73tWpep5PEyfio6tU42s6s9Uk/9WbyivubPA82T
         zQxrjvl9HP5So3wzyK2SVn2B4NA3m9+L/MSwyNo+kLrdi80FDUppXo7ya8mQ9Z4XVpHF
         j71tn6MmmWSA0ST4t1OZHCzKqGgQEJoAsx9DcVjN8u0JWeX4j3WwAsjeWXarbunh1k0N
         uGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FWtW8F+aTvlCIWgx9l8lCP+h+/ENvBp0MjAgoCZB/Es=;
        b=D5lS+HOOwiFdOnwCpQG7uGLypcLTyQxsxdAVzfOIigdyI6Ih4k8Ufoe342BLe+WxIn
         e+7Iyoq5V8RpuX17IdC5zfAeZH//q9hn1mGvP6jbRNJ2SJHbpdstfGdUB3QXu9Yq0Nde
         JYJQ4lfsnarTkirLFOF4WllBJywDTDiFnLb0RcGMeX7Cx0OguwwK5D2dtypozo0mwJm7
         zWsXSgeHVfeLKGf6mPLM6CvYrZ0ODdrOZ+J/nao8igrGnNCRfJeS/4f6EwIK4qXBWWYs
         NHjTu106ERODu3Yv9BvOnX/4GNn5QLuunTJsLvkX6sBF1XiTb+8gAmcGDnqsjyMCgWbY
         vSyg==
X-Gm-Message-State: AHQUAuYgadrz5V0u6kFxcjfQS6hM0ShEU1D4OQsg2rmHie6p0tsqLV6Z
        5kvQGge53NZKpuDoIPIBC3m+wSzu
X-Google-Smtp-Source: AHgI3IbsgvqvyDG+rStK6cuwaeAb8ioQpGFiOJ1jXQaGrSQqk9Y3l4hmtIyyUCjAbF1vZqjNEmqjfg==
X-Received: by 2002:a62:964d:: with SMTP id c74mr18483805pfe.213.1550398259835;
        Sun, 17 Feb 2019 02:10:59 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id s1sm15702150pfe.163.2019.02.17.02.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:10:59 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:10:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 23/31] sha1-name.c: remove the_repo from handle_one_ref()
Date:   Sun, 17 Feb 2019 17:09:05 +0700
Message-Id: <20190217100913.4127-24-pclouds@gmail.com>
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
 sha1-name.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 5741a9f821..d9050776dd 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1189,15 +1189,21 @@ static enum get_oid_result get_oid_1(struct repository *r,
 /* Remember to update object flag allocation in object.h */
 #define ONELINE_SEEN (1u<<20)
 
+struct handle_one_ref_cb {
+	struct repository *repo;
+	struct commit_list **list;
+};
+
 static int handle_one_ref(const char *path, const struct object_id *oid,
 			  int flag, void *cb_data)
 {
-	struct commit_list **list = cb_data;
-	struct object *object = parse_object(the_repository, oid);
+	struct handle_one_ref_cb *cb = cb_data;
+	struct commit_list **list = cb->list;
+	struct object *object = parse_object(cb->repo, oid);
 	if (!object)
 		return 0;
 	if (object->type == OBJ_TAG) {
-		object = deref_tag(the_repository, object, path,
+		object = deref_tag(cb->repo, object, path,
 				   strlen(path));
 		if (!object)
 			return 0;
@@ -1760,10 +1766,13 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 		char *new_path = NULL;
 		int pos;
 		if (!only_to_die && namelen > 2 && name[1] == '/') {
+			struct handle_one_ref_cb cb;
 			struct commit_list *list = NULL;
 
-			for_each_ref(handle_one_ref, &list);
-			head_ref(handle_one_ref, &list);
+			cb.repo = repo;
+			cb.list = &list;
+			refs_for_each_ref(repo->refs, handle_one_ref, &cb);
+			refs_head_ref(repo->refs, handle_one_ref, &cb);
 			commit_list_sort_by_date(&list);
 			return get_oid_oneline(repo, name + 2, oid, list);
 		}
-- 
2.21.0.rc0.328.g0e39304f8d

