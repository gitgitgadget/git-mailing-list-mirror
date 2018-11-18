Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814031F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 16:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeKSDI7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 22:08:59 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32928 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeKSDI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 22:08:58 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so24148761ljd.0
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 08:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gMKpUTg10dKg+EeDEHAEajMPeLULnw2KiKkw6xtSAIA=;
        b=GdC5ZVS1j/Rc5I6IkfyNAgXNK3DY/BwQu0Ykd4wDhfC/E8AXGjvPANlegL2g6c4dBX
         CjoI12YfCjctFRQHoc1cR4eV7MQRHX1n2oDtRbLM3qE/d5LPZQ7o+28GHBcixEUXW3mb
         2azsAj6V6EMMdBawBwC4YKvdCKu2TglXKO8vL41ziCqtpx9cRsnO1G+usrdAtnDzdJSY
         qyWFnGmH4GnjvTZiLv4iNn36D84L9Z5hCXSB09v2OEqE51o1wTp4gFIT9SIUE3mSpqI0
         YBxdTKIu2InHd0TjZOh3PKXfHIDcS12S6HZv3LQyivpZRx4QQ0cMdQc3KJ79a6C8QNyn
         NO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMKpUTg10dKg+EeDEHAEajMPeLULnw2KiKkw6xtSAIA=;
        b=ZBBR02TpEwUhw7AF4jryAdenPhe7qAi9GStz1VI47WdUQxHdWve2zH5OeuUKHGihP4
         lZmIcjlwr1xljaGecA601ip3UU5ejckptwhwDULEilQ8PnhLJYDK7GDehr45Xd428cth
         P29fGm1KAzXeKVJJefiOjImjNu6Q+bV4TqZdQ+GtBs/Gkcs65h+ZU5FKJ22UBOG5eXjZ
         11AyFIA7G34zFx6g2d2+pU3h+qnQejNkR0lIMkcYA4Ggkos3Ab8rSik3PbCoJqX+8OPi
         AaXp+pVvzIOqFQIzrwweVq3KAFJeFYdWbLfU/xMFf6u6DXd9HkFiqECQhbjC/0GiAy/U
         eynA==
X-Gm-Message-State: AGRZ1gIxsCzZyWcj4680k7a1aKkBcKpKk1X47nVTWcOtvnpyfGklJEdD
        Mb4jDkImHb6vkl9VlAABSedGU5kg
X-Google-Smtp-Source: AJdET5en6ChzA4Dh3ibhyXurYl1N7jMd+HYjmRKbxqYmO7sONIgMzjhnCCaURJ4upnbGggKDHJnH4g==
X-Received: by 2002:a2e:9017:: with SMTP id h23-v6mr8402969ljg.71.1542559691262;
        Sun, 18 Nov 2018 08:48:11 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f29sm4461603lfa.46.2018.11.18.08.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 08:48:10 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 4/5] dir.c: move, rename and export match_attrs()
Date:   Sun, 18 Nov 2018 17:47:59 +0100
Message-Id: <20181118164800.32759-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
In-Reply-To: <20181118164800.32759-1-pclouds@gmail.com>
References: <20181118164800.32759-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function will be reused for matching attributes in pathspec when
walking trees (currently it's used for matching pathspec when walking
a list). pathspec.c would be a more neutral place for this.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 dir.c      | 41 ++---------------------------------------
 pathspec.c | 38 ++++++++++++++++++++++++++++++++++++++
 pathspec.h |  3 +++
 3 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/dir.c b/dir.c
index ab6477d777..2128448219 100644
--- a/dir.c
+++ b/dir.c
@@ -276,44 +276,6 @@ static int do_read_blob(const struct object_id *oid, struct oid_stat *oid_stat,
 #define DO_MATCH_DIRECTORY (1<<1)
 #define DO_MATCH_SUBMODULE (1<<2)
 
-static int match_attrs(const struct index_state *istate,
-		       const char *name, int namelen,
-		       const struct pathspec_item *item)
-{
-	int i;
-	char *to_free = NULL;
-
-	if (name[namelen])
-		name = to_free = xmemdupz(name, namelen);
-
-	git_check_attr(istate, name, item->attr_check);
-
-	free(to_free);
-
-	for (i = 0; i < item->attr_match_nr; i++) {
-		const char *value;
-		int matched;
-		enum attr_match_mode match_mode;
-
-		value = item->attr_check->items[i].value;
-		match_mode = item->attr_match[i].match_mode;
-
-		if (ATTR_TRUE(value))
-			matched = (match_mode == MATCH_SET);
-		else if (ATTR_FALSE(value))
-			matched = (match_mode == MATCH_UNSET);
-		else if (ATTR_UNSET(value))
-			matched = (match_mode == MATCH_UNSPECIFIED);
-		else
-			matched = (match_mode == MATCH_VALUE &&
-				   !strcmp(item->attr_match[i].value, value));
-		if (!matched)
-			return 0;
-	}
-
-	return 1;
-}
-
 /*
  * Does 'match' match the given name?
  * A match is found if
@@ -367,7 +329,8 @@ static int match_pathspec_item(const struct index_state *istate,
 	    strncmp(item->match, name - prefix, item->prefix))
 		return 0;
 
-	if (item->attr_match_nr && !match_attrs(istate, name, namelen, item))
+	if (item->attr_match_nr &&
+	    !match_pathspec_attrs(istate, name, namelen, item))
 		return 0;
 
 	/* If the match was just the prefix, we matched */
diff --git a/pathspec.c b/pathspec.c
index 6f005996fd..e85298f68c 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -659,3 +659,41 @@ void clear_pathspec(struct pathspec *pathspec)
 	FREE_AND_NULL(pathspec->items);
 	pathspec->nr = 0;
 }
+
+int match_pathspec_attrs(const struct index_state *istate,
+			 const char *name, int namelen,
+			 const struct pathspec_item *item)
+{
+	int i;
+	char *to_free = NULL;
+
+	if (name[namelen])
+		name = to_free = xmemdupz(name, namelen);
+
+	git_check_attr(istate, name, item->attr_check);
+
+	free(to_free);
+
+	for (i = 0; i < item->attr_match_nr; i++) {
+		const char *value;
+		int matched;
+		enum attr_match_mode match_mode;
+
+		value = item->attr_check->items[i].value;
+		match_mode = item->attr_match[i].match_mode;
+
+		if (ATTR_TRUE(value))
+			matched = (match_mode == MATCH_SET);
+		else if (ATTR_FALSE(value))
+			matched = (match_mode == MATCH_UNSET);
+		else if (ATTR_UNSET(value))
+			matched = (match_mode == MATCH_UNSPECIFIED);
+		else
+			matched = (match_mode == MATCH_VALUE &&
+				   !strcmp(item->attr_match[i].value, value));
+		if (!matched)
+			return 0;
+	}
+
+	return 1;
+}
diff --git a/pathspec.h b/pathspec.h
index 5fd781d695..1c18a2c90c 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -111,5 +111,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 					char *seen);
 char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
 					    const struct index_state *istate);
+int match_pathspec_attrs(const struct index_state *istate,
+			 const char *name, int namelen,
+			 const struct pathspec_item *item);
 
 #endif /* PATHSPEC_H */
-- 
2.19.1.1327.g328c130451.dirty

