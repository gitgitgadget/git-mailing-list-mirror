Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28B7120248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfDFLhc (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:37:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43709 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLhb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:37:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so4756582pfd.10
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J/RUO8ACXrqeLwgRI/QX11nIxHpfBgPfHg/OeHAlD+4=;
        b=ucDL9TuqhQDZZvCC/c9pH84eZZQ92AtxZdBKklZf1Ol+raFRmie5YdwAfehp23Szdy
         YuWH6hy5GBgshJWtSZCjgabWQyBzCKwpTJE+gQfa39dlBIWCNDpQmDA8ezST24UA+btP
         CwNI5eIDzydvCxiNU7w2pF/5NTBUxrc9S3+GQtUgBmak1frxEA8SASAHbh7ld5TiGLz5
         jOI3hz/oFy73aH44q0dJCStEt2IzKMKmr0bbafG4ZT2awiLvXHkOFkHMAh/5Re+FnAbR
         1XISQsVCLQU5/fTDV6goRU46pmL7NEjIvLWA+7/cRWX4gaJH3tQNSRbqyr8CAOCo935i
         NriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J/RUO8ACXrqeLwgRI/QX11nIxHpfBgPfHg/OeHAlD+4=;
        b=cX0XQWyb8tH6ROeTWpGSLYrzcdtv0wNtiNeYi+1sFqRmBrYA+P1X+jt5EuYaThfz0w
         TGWa/wcoU6npuj0lChcBOAjtWJkBkLNuDN6g6UVa/aPyaECOm9WLZOgbiM3NZNp6OWfq
         daExBxr8yP9esdTaVwKnyNcEkVzFA+tHKibMMpT9niLWqdP4NbHc9y2ja+t6ikTc3I5a
         PX2EFTFjW+gr9UHhZGxG7BHjIpotO5RRf9x9RxjhCehQCN5RFkjKUJ9OHUc3Yx28pRxb
         /rmmVnbaocbvQgs8qCyZJmD+pdfUHzZVJlgtyD9LzQ3agp67bzlkHgKpnRqRPtkrQSHh
         l47Q==
X-Gm-Message-State: APjAAAXfHfo0fPVvIJp35/XJIggYRpLtLCfygOOhFyLr/0/ik8B4NaXF
        sYDJIGIpCDNVPeJlOE+S3S0=
X-Google-Smtp-Source: APXvYqwEAkJByykX4P7qw1dsEs0dWVxNds/rwaP7iNspbZqEklns02lbkbM94cKkOsZ4rF6+G13gDA==
X-Received: by 2002:a65:63d5:: with SMTP id n21mr8610267pgv.330.1554550651198;
        Sat, 06 Apr 2019 04:37:31 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id u26sm33712429pfn.5.2019.04.06.04.37.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:37:30 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:37:26 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 25/33] sha1-name.c: remove the_repo from handle_one_ref()
Date:   Sat,  6 Apr 2019 18:34:45 +0700
Message-Id: <20190406113453.5149-26-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
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
2.21.0.479.g47ac719cd3

