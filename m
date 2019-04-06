Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E7F420248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfDFLh1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:37:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39826 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:37:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id i17so1633535pfo.6
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1VrGbTQQ9UY3cc5ZVT/2Jzavz0lrpN5XvZvKzS958UI=;
        b=OedrnUbZGt1lP66wbwW5/6Oc9DGgJirSBm58vKeRSGRtjtvIZ42oPSaIw3ZVEWW/vs
         h6nlpXb+qHiY50lXB9AQmuZH2u01D0ODE4VsnVKmReIScbOCi9blp4YERqWiYJt+M1Il
         XS4tOn8EoNr5r3kX1wiGmtof7jJ8u+0/ZsZ8Zyw77HeS9+uBgW6indaWecEWZ8fpI5Fb
         usjq9mP2zcwTpTYgwTVWEMqF6n8uWDtzxG5I8vadXBcNfOo4th8yjQwN4XbwUEUECyCM
         rfYZ4VDmYuXktUCfXMUZmx7AfQRnXLiUWNDYrGA1RwSaUUN2ZNLhsyRwFpb8AxXIAH4p
         TnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1VrGbTQQ9UY3cc5ZVT/2Jzavz0lrpN5XvZvKzS958UI=;
        b=cNP7sX9EU6MdkA8BZEKdme05w/gW+gGGzxXjauUvowxLiT5XwiIpLfDxlyHrGyqnwE
         YKxLZjI2kPBwdnVdk7UNJ0He1teKjXPR6xR80CeXETL3UU0vnyc8CVOco8mqTLxP/V4q
         lxjr7OloGOA6yB5o714ad0vK5z/ZNS0w98btYV0JTPRqprGLZGAQJCYIpbH+YoFdfjEf
         DPZdSALBo3UK9fiIULPqbeOHuGxqVwhy/pIZL6B4ZQ5RZqLcceJR3fXJYuKpFtSQUHE+
         rNpQNWyXDyv5y55cguVHqltzvU/vDe/NquBPmyTqUesejrdEbDwnBXORPrmmmZ/D8kU1
         dBPA==
X-Gm-Message-State: APjAAAU0G0hZgJQCyiZgF2wFfCtHYjGyMxwwfe0KEUtMPdr5/7qCIMHH
        FZuq4vo2ePHxJjwST0Cj0KE=
X-Google-Smtp-Source: APXvYqwtRJSEPXV901WaYn1OLUYRSdScKIlJMey9tfqS7wgSa5svCEIbzjixrNHiys+FeocUG0TvcA==
X-Received: by 2002:a62:6985:: with SMTP id e127mr18395424pfc.188.1554550645988;
        Sat, 06 Apr 2019 04:37:25 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id e8sm56123013pfc.47.2019.04.06.04.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:37:25 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:37:20 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 24/33] sha1-name.c: remove the_repo from get_oid_1()
Date:   Sat,  6 Apr 2019 18:34:44 +0700
Message-Id: <20190406113453.5149-25-pclouds@gmail.com>
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

There is a cyclic dependency between one of these functions so they
cannot be converted one by one, so all related functions are converted
at once.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h     |  7 +++++--
 sha1-name.c | 59 ++++++++++++++++++++++++++++-------------------------
 2 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/cache.h b/cache.h
index 0cb95c0d4f..2149dc4f56 100644
--- a/cache.h
+++ b/cache.h
@@ -1491,8 +1491,11 @@ extern void *read_object_with_reference(const struct object_id *oid,
 					unsigned long *size,
 					struct object_id *oid_ret);
 
-extern struct object *peel_to_type(const char *name, int namelen,
-				   struct object *o, enum object_type);
+struct object *repo_peel_to_type(struct repository *r,
+				 const char *name, int namelen,
+				 struct object *o, enum object_type);
+#define peel_to_type(name, namelen, obj, type) \
+	repo_peel_to_type(the_repository, name, namelen, obj, type)
 
 enum date_mode_type {
 	DATE_NORMAL = 0,
diff --git a/sha1-name.c b/sha1-name.c
index d4c135aea8..5741a9f821 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -770,7 +770,7 @@ static inline int push_mark(const char *string, int len)
 	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
 }
 
-static enum get_oid_result get_oid_1(const char *name, int len, struct object_id *oid, unsigned lookup_flags);
+static enum get_oid_result get_oid_1(struct repository *r, const char *name, int len, struct object_id *oid, unsigned lookup_flags);
 static int interpret_nth_prior_checkout(struct repository *r, const char *name, int namelen, struct strbuf *buf);
 
 static int get_oid_basic(struct repository *r, const char *str, int len,
@@ -921,18 +921,19 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	return 0;
 }
 
-static enum get_oid_result get_parent(const char *name, int len,
+static enum get_oid_result get_parent(struct repository *r,
+				      const char *name, int len,
 				      struct object_id *result, int idx)
 {
 	struct object_id oid;
-	enum get_oid_result ret = get_oid_1(name, len, &oid,
+	enum get_oid_result ret = get_oid_1(r, name, len, &oid,
 					    GET_OID_COMMITTISH);
 	struct commit *commit;
 	struct commit_list *p;
 
 	if (ret)
 		return ret;
-	commit = lookup_commit_reference(the_repository, &oid);
+	commit = lookup_commit_reference(r, &oid);
 	if (parse_commit(commit))
 		return MISSING_OBJECT;
 	if (!idx) {
@@ -950,7 +951,8 @@ static enum get_oid_result get_parent(const char *name, int len,
 	return MISSING_OBJECT;
 }
 
-static enum get_oid_result get_nth_ancestor(const char *name, int len,
+static enum get_oid_result get_nth_ancestor(struct repository *r,
+					    const char *name, int len,
 					    struct object_id *result,
 					    int generation)
 {
@@ -958,10 +960,10 @@ static enum get_oid_result get_nth_ancestor(const char *name, int len,
 	struct commit *commit;
 	int ret;
 
-	ret = get_oid_1(name, len, &oid, GET_OID_COMMITTISH);
+	ret = get_oid_1(r, name, len, &oid, GET_OID_COMMITTISH);
 	if (ret)
 		return ret;
-	commit = lookup_commit_reference(the_repository, &oid);
+	commit = lookup_commit_reference(r, &oid);
 	if (!commit)
 		return MISSING_OBJECT;
 
@@ -974,20 +976,20 @@ static enum get_oid_result get_nth_ancestor(const char *name, int len,
 	return FOUND;
 }
 
-struct object *peel_to_type(const char *name, int namelen,
-			    struct object *o, enum object_type expected_type)
+struct object *repo_peel_to_type(struct repository *r, const char *name, int namelen,
+				 struct object *o, enum object_type expected_type)
 {
 	if (name && !namelen)
 		namelen = strlen(name);
 	while (1) {
-		if (!o || (!o->parsed && !parse_object(the_repository, &o->oid)))
+		if (!o || (!o->parsed && !parse_object(r, &o->oid)))
 			return NULL;
 		if (expected_type == OBJ_ANY || o->type == expected_type)
 			return o;
 		if (o->type == OBJ_TAG)
 			o = ((struct tag*) o)->tagged;
 		else if (o->type == OBJ_COMMIT)
-			o = &(get_commit_tree(((struct commit *)o))->object);
+			o = &(repo_get_commit_tree(r, ((struct commit *)o))->object);
 		else {
 			if (name)
 				error("%.*s: expected %s type, but the object "
@@ -999,8 +1001,8 @@ struct object *peel_to_type(const char *name, int namelen,
 	}
 }
 
-static int peel_onion(const char *name, int len, struct object_id *oid,
-		      unsigned lookup_flags)
+static int peel_onion(struct repository *r, const char *name, int len,
+		      struct object_id *oid, unsigned lookup_flags)
 {
 	struct object_id outer;
 	const char *sp;
@@ -1050,15 +1052,15 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 	else if (expected_type == OBJ_TREE)
 		lookup_flags |= GET_OID_TREEISH;
 
-	if (get_oid_1(name, sp - name - 2, &outer, lookup_flags))
+	if (get_oid_1(r, name, sp - name - 2, &outer, lookup_flags))
 		return -1;
 
-	o = parse_object(the_repository, &outer);
+	o = parse_object(r, &outer);
 	if (!o)
 		return -1;
 	if (!expected_type) {
-		o = deref_tag(the_repository, o, name, sp - name - 2);
-		if (!o || (!o->parsed && !parse_object(the_repository, &o->oid)))
+		o = deref_tag(r, o, name, sp - name - 2);
+		if (!o || (!o->parsed && !parse_object(r, &o->oid)))
 			return -1;
 		oidcpy(oid, &o->oid);
 		return 0;
@@ -1069,7 +1071,7 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 	 * if we do not get the needed object, we should
 	 * barf.
 	 */
-	o = peel_to_type(name, len, o, expected_type);
+	o = repo_peel_to_type(r, name, len, o, expected_type);
 	if (!o)
 		return -1;
 
@@ -1089,7 +1091,7 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 
 		prefix = xstrndup(sp + 1, name + len - 1 - (sp + 1));
 		commit_list_insert((struct commit *)o, &list);
-		ret = get_oid_oneline(the_repository, prefix, oid, list);
+		ret = get_oid_oneline(r, prefix, oid, list);
 		free(prefix);
 		return ret;
 	}
@@ -1120,7 +1122,8 @@ static int get_describe_name(struct repository *r,
 	return -1;
 }
 
-static enum get_oid_result get_oid_1(const char *name, int len,
+static enum get_oid_result get_oid_1(struct repository *r,
+				     const char *name, int len,
 				     struct object_id *oid,
 				     unsigned lookup_flags)
 {
@@ -1149,25 +1152,25 @@ static enum get_oid_result get_oid_1(const char *name, int len,
 		if (!num && len1 == len - 1)
 			num = 1;
 		if (has_suffix == '^')
-			return get_parent(name, len1, oid, num);
+			return get_parent(r, name, len1, oid, num);
 		/* else if (has_suffix == '~') -- goes without saying */
-		return get_nth_ancestor(name, len1, oid, num);
+		return get_nth_ancestor(r, name, len1, oid, num);
 	}
 
-	ret = peel_onion(name, len, oid, lookup_flags);
+	ret = peel_onion(r, name, len, oid, lookup_flags);
 	if (!ret)
 		return FOUND;
 
-	ret = get_oid_basic(the_repository, name, len, oid, lookup_flags);
+	ret = get_oid_basic(r, name, len, oid, lookup_flags);
 	if (!ret)
 		return FOUND;
 
 	/* It could be describe output that is "SOMETHING-gXXXX" */
-	ret = get_describe_name(the_repository, name, len, oid);
+	ret = get_describe_name(r, name, len, oid);
 	if (!ret)
 		return FOUND;
 
-	return get_short_oid(the_repository, name, len, oid, lookup_flags);
+	return get_short_oid(r, name, len, oid, lookup_flags);
 }
 
 /*
@@ -1741,7 +1744,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 	memset(oc, 0, sizeof(*oc));
 	oc->mode = S_IFINVALID;
 	strbuf_init(&oc->symlink_path, 0);
-	ret = get_oid_1(name, namelen, oid, flags);
+	ret = get_oid_1(repo, name, namelen, oid, flags);
 	if (!ret)
 		return ret;
 	/*
@@ -1822,7 +1825,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 		sub_flags &= ~GET_OID_DISAMBIGUATORS;
 		sub_flags |= GET_OID_TREEISH;
 
-		if (!get_oid_1(name, len, &tree_oid, sub_flags)) {
+		if (!get_oid_1(repo, name, len, &tree_oid, sub_flags)) {
 			const char *filename = cp+1;
 			char *new_filename = NULL;
 
-- 
2.21.0.479.g47ac719cd3

