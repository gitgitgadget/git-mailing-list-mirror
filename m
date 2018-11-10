Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 144771F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbeKJPd1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:27 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34798 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbeKJPd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:26 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so2837330lfc.1
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=khoL39CpPqcK8x61+FKKJNTZkXWHAIxTuhLVjgclfWI=;
        b=FHB2g96IrgZHE1fgM9jwW86ba4p74lOdUS2EvfYUzlApA7Tx984VoYAGAi/hqpW9YC
         dazL8SuZPyZTdzCZVgSNoEuUGnQyjKTNoZt92Mj8f5+Y0PGbyxEa+iMGXA4x/wpX3kC1
         +Fd2zNY8SWHWN1QIGVH9F5tIbD/Wh8nP90yDb8ASiczZsyeJSB+HBJW26oredG5pYM6r
         tSesaxFiXt6IBnHGDy9E1P4+ZYedjA7/oOBQW8WCjYyWCAbftmjsWO5MjSIvvfUqBbjk
         GtR7JQmIZoEy45iDYcLwxaNPLuXqgLu61t+t7lEzD4Yat+6K9MwIdtSsQnqG/5kRf7Tm
         jhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=khoL39CpPqcK8x61+FKKJNTZkXWHAIxTuhLVjgclfWI=;
        b=WdQEgnygo1VD1t6/fIeIbh+C6reGUCC0wlfceeCUjI5XiwDSttqhtRC9u8W5Jbt/vx
         eYCXjUF4GQCfnsGIG7ndBStGOKEPMClQGNuxsCfNZsfOwDCKV1QDLyX3PRMEWQqbWR2n
         mcDuXOpfG57yzOB1RC9UufcgCdXloXTVvNiNG6OsocxHPfrIvEcnsoIbi7dn1tZ3dxwK
         gg4DZ6oDxz08xxepTab79ZttFtTyUoMSsWz2RRKNtkp16Z2nhZLrQAzbhUCgz87RH/Sl
         CxahsSwMI9cePEnws5j/mCyVFJE7pOg+eCwP4MFUC4BcItds8yJ3pUA844tHH7aj0S1W
         gLGg==
X-Gm-Message-State: AGRZ1gIHUPnZFxZuPlNpWhMlwZbDr+Z+i1S9N++iZgtSSg+tcBixsPvu
        WyLBnuGTzX9aFJwujjV/VKr1wvE6
X-Google-Smtp-Source: AJdET5dySwnvLccTkoeKCKZ1B7gQo8fYv0SakruthBYmuFFFLcRTAUvPGrzuYSHGuJL2dCjDZHjxZA==
X-Received: by 2002:a19:a84e:: with SMTP id r75mr7189163lfe.45.1541828978331;
        Fri, 09 Nov 2018 21:49:38 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:37 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 18/22] notes-cache.c: remove the_repository references
Date:   Sat, 10 Nov 2018 06:49:06 +0100
Message-Id: <20181110054910.10568-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com>
References: <20181110054910.10568-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 combine-diff.c     |  2 +-
 diff.c             | 12 ++++++------
 diff.h             |  2 +-
 diffcore-pickaxe.c |  4 ++--
 grep.c             |  2 +-
 notes-cache.c      | 12 +++++++-----
 notes-cache.h      |  6 ++++--
 userdiff.c         |  5 +++--
 userdiff.h         |  4 +++-
 9 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 10155e0ec8..3d796af3ca 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -991,7 +991,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	if (!userdiff)
 		userdiff = userdiff_find_by_name("default");
 	if (opt->flags.allow_textconv)
-		textconv = userdiff_get_textconv(userdiff);
+		textconv = userdiff_get_textconv(opt->repo, userdiff);
 
 	/* Read the result of merge first */
 	if (!working_tree_file)
diff --git a/diff.c b/diff.c
index 8647db3d30..1135377a7f 100644
--- a/diff.c
+++ b/diff.c
@@ -3312,14 +3312,14 @@ void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const
 		options->b_prefix = b;
 }
 
-struct userdiff_driver *get_textconv(struct index_state *istate,
+struct userdiff_driver *get_textconv(struct repository *r,
 				     struct diff_filespec *one)
 {
 	if (!DIFF_FILE_VALID(one))
 		return NULL;
 
-	diff_filespec_load_driver(one, istate);
-	return userdiff_get_textconv(one->driver);
+	diff_filespec_load_driver(one, r->index);
+	return userdiff_get_textconv(r, one->driver);
 }
 
 static void builtin_diff(const char *name_a,
@@ -3368,8 +3368,8 @@ static void builtin_diff(const char *name_a,
 	}
 
 	if (o->flags.allow_textconv) {
-		textconv_one = get_textconv(o->repo->index, one);
-		textconv_two = get_textconv(o->repo->index, two);
+		textconv_one = get_textconv(o->repo, one);
+		textconv_two = get_textconv(o->repo, two);
 	}
 
 	/* Never use a non-valid filename anywhere if at all possible */
@@ -6436,7 +6436,7 @@ int textconv_object(struct repository *r,
 
 	df = alloc_filespec(path);
 	fill_filespec(df, oid, oid_valid, mode);
-	textconv = get_textconv(r->index, df);
+	textconv = get_textconv(r, df);
 	if (!textconv) {
 		free_filespec(df);
 		return 0;
diff --git a/diff.h b/diff.h
index 3197a976a4..412138ba08 100644
--- a/diff.h
+++ b/diff.h
@@ -461,7 +461,7 @@ size_t fill_textconv(struct repository *r,
  * and only if it has textconv enabled (otherwise return NULL). The result
  * can be passed to fill_textconv().
  */
-struct userdiff_driver *get_textconv(struct index_state *istate,
+struct userdiff_driver *get_textconv(struct repository *r,
 				     struct diff_filespec *one);
 
 /*
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index d2361e06a1..b815f1c449 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -139,8 +139,8 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 		return 0;
 
 	if (o->flags.allow_textconv) {
-		textconv_one = get_textconv(o->repo->index, p->one);
-		textconv_two = get_textconv(o->repo->index, p->two);
+		textconv_one = get_textconv(o->repo, p->one);
+		textconv_two = get_textconv(o->repo, p->two);
 	}
 
 	/*
diff --git a/grep.c b/grep.c
index f6bd89e40b..b05b2e61bb 100644
--- a/grep.c
+++ b/grep.c
@@ -1811,7 +1811,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		 * is not thread-safe.
 		 */
 		grep_attr_lock();
-		textconv = userdiff_get_textconv(gs->driver);
+		textconv = userdiff_get_textconv(opt->repo, gs->driver);
 		grep_attr_unlock();
 	}
 
diff --git a/notes-cache.c b/notes-cache.c
index d87e7ca91c..2473314d68 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -5,7 +5,9 @@
 #include "commit.h"
 #include "refs.h"
 
-static int notes_cache_match_validity(const char *ref, const char *validity)
+static int notes_cache_match_validity(struct repository *r,
+				      const char *ref,
+				      const char *validity)
 {
 	struct object_id oid;
 	struct commit *commit;
@@ -16,7 +18,7 @@ static int notes_cache_match_validity(const char *ref, const char *validity)
 	if (read_ref(ref, &oid) < 0)
 		return 0;
 
-	commit = lookup_commit_reference_gently(the_repository, &oid, 1);
+	commit = lookup_commit_reference_gently(r, &oid, 1);
 	if (!commit)
 		return 0;
 
@@ -30,8 +32,8 @@ static int notes_cache_match_validity(const char *ref, const char *validity)
 	return ret;
 }
 
-void notes_cache_init(struct notes_cache *c, const char *name,
-		     const char *validity)
+void notes_cache_init(struct repository *r, struct notes_cache *c,
+		      const char *name, const char *validity)
 {
 	struct strbuf ref = STRBUF_INIT;
 	int flags = NOTES_INIT_WRITABLE;
@@ -40,7 +42,7 @@ void notes_cache_init(struct notes_cache *c, const char *name,
 	c->validity = xstrdup(validity);
 
 	strbuf_addf(&ref, "refs/notes/%s", name);
-	if (!notes_cache_match_validity(ref.buf, validity))
+	if (!notes_cache_match_validity(r, ref.buf, validity))
 		flags |= NOTES_INIT_EMPTY;
 	init_notes(&c->tree, ref.buf, combine_notes_overwrite, flags);
 	strbuf_release(&ref);
diff --git a/notes-cache.h b/notes-cache.h
index aeeee8409d..56f8c98e24 100644
--- a/notes-cache.h
+++ b/notes-cache.h
@@ -3,13 +3,15 @@
 
 #include "notes.h"
 
+struct repository;
+
 struct notes_cache {
 	struct notes_tree tree;
 	char *validity;
 };
 
-void notes_cache_init(struct notes_cache *c, const char *name,
-		     const char *validity);
+void notes_cache_init(struct repository *r, struct notes_cache *c,
+		      const char *name, const char *validity);
 int notes_cache_write(struct notes_cache *c);
 
 char *notes_cache_get(struct notes_cache *c, struct object_id *oid, size_t
diff --git a/userdiff.c b/userdiff.c
index 46d34cc2a4..97007abe5b 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -290,7 +290,8 @@ struct userdiff_driver *userdiff_find_by_path(struct index_state *istate,
 	return userdiff_find_by_name(check->items[0].value);
 }
 
-struct userdiff_driver *userdiff_get_textconv(struct userdiff_driver *driver)
+struct userdiff_driver *userdiff_get_textconv(struct repository *r,
+					      struct userdiff_driver *driver)
 {
 	if (!driver->textconv)
 		return NULL;
@@ -300,7 +301,7 @@ struct userdiff_driver *userdiff_get_textconv(struct userdiff_driver *driver)
 		struct strbuf name = STRBUF_INIT;
 
 		strbuf_addf(&name, "textconv/%s", driver->name);
-		notes_cache_init(c, name.buf, driver->textconv);
+		notes_cache_init(r, c, name.buf, driver->textconv);
 		driver->textconv_cache = c;
 		strbuf_release(&name);
 	}
diff --git a/userdiff.h b/userdiff.h
index b072bfe89a..203057e13e 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -4,6 +4,7 @@
 #include "notes-cache.h"
 
 struct index_state;
+struct repository;
 
 struct userdiff_funcname {
 	const char *pattern;
@@ -30,6 +31,7 @@ struct userdiff_driver *userdiff_find_by_path(struct index_state *istate,
  * Initialize any textconv-related fields in the driver and return it, or NULL
  * if it does not have textconv enabled at all.
  */
-struct userdiff_driver *userdiff_get_textconv(struct userdiff_driver *driver);
+struct userdiff_driver *userdiff_get_textconv(struct repository *r,
+					      struct userdiff_driver *driver);
 
 #endif /* USERDIFF */
-- 
2.19.1.1231.g84aef82467

