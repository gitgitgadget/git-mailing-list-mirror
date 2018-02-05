Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C142A1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeBFAMk (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:12:40 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44936 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeBFAMh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:12:37 -0500
Received: by mail-pl0-f67.google.com with SMTP id f8so103344plk.11
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EJrJoIa/7RD8nrr9QGh+rSyBHpD+h7KPX1EWhbjIMGk=;
        b=kpv9wfKEroejMHlk9xhTwMlpjz8MglZoJtnwwP26YiCWPtPevvbmZkKfTJVwZd2vkH
         vw1rVomYB6kUbnyAnHqeTcJ6DY+SBp3WptjMIXyA0ar9pgywNl/x84iDBTP/6Ait7cHu
         o4HVuvQbvYOEhNQoImRHp/uXqc8jTpoPVhoMh970sC5DTdPTf9LfC3mLPuvRA+HeqfRl
         /o4MOLcy7k+vu9HIeV+9fvse1vE3Efy4empH/wX6Bfq/xNwdxFaZpsJRvMHG1anyPtGb
         LlsMiOE7+pJosD+pGK/jsdrkb6SUHyrcW6Lm649wAlSTzqqcsLehIHEIa/lsdRjdLY5z
         Jkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EJrJoIa/7RD8nrr9QGh+rSyBHpD+h7KPX1EWhbjIMGk=;
        b=gfnID68sTTiZfvwUJqmOlXbrl3QooDStETVmy2PH2HJy/U8jyW0oV2B3Yss4z6coBc
         aK/dJ4IxnAVHa9C9BuWksuMh9RBW/2e10nEHuPrh+Z91+3UE8HKUQvC8Jh5m0mWoOYeD
         mRXM3zbkz/aAD8DHcekqnZOW/0rvZfJtB87E7qhbFVBNX9M0aljE5BG42PZpY37a+piU
         xcFpd4WT6F6NcuI2apDF+whI3kSf+4nEa2JDIKhyCGEBZEL0ze9MfmcolNY/0vgYbHOo
         gY8EB3reyykxy1jxyqMMeBRpA9ZQI7oFNm7hoCSjR/6bcDve7qMXxyLSEaRt5M5IrPIV
         SZOA==
X-Gm-Message-State: APf1xPDXZ50gYEp6NbvXy45QUitDxuuZIRsCbkSP8mtGetGAqi3CaEPp
        YF/rEsVkU42TcnYHj1vyiS6vzYn5YeA=
X-Google-Smtp-Source: AH8x225E9qMnF6HbUNL9PKIPEvR9D8ChHYjkAjDDqNInG8wZEJ6N3Lzzmhifq+wqub7ByQ/NqAVP+w==
X-Received: by 2002:a17:902:2e03:: with SMTP id q3-v6mr548572plb.362.1517875955591;
        Mon, 05 Feb 2018 16:12:35 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id r81sm19412453pfe.157.2018.02.05.16.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:12:34 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 086/194] tag: add repository argument to lookup_tag
Date:   Mon,  5 Feb 2018 15:55:47 -0800
Message-Id: <20180205235735.216710-66-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of lookup_tag
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Add the cocci patch that converted the callers.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/describe.c                     | 6 +++---
 builtin/pack-objects.c                 | 2 +-
 builtin/replace.c                      | 2 +-
 contrib/coccinelle/object_parser.cocci | 7 +++++++
 log-tree.c                             | 2 +-
 object.c                               | 2 +-
 sha1_name.c                            | 2 +-
 tag.c                                  | 4 ++--
 tag.h                                  | 4 ++--
 9 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 2add1e8d83..2589872322 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -88,13 +88,13 @@ static int replace_name(struct commit_name *e,
 		struct tag *t;
 
 		if (!e->tag) {
-			t = lookup_tag(&e->oid);
+			t = lookup_tag(the_repository, &e->oid);
 			if (!t || parse_tag(t))
 				return 1;
 			e->tag = t;
 		}
 
-		t = lookup_tag(oid);
+		t = lookup_tag(the_repository, oid);
 		if (!t || parse_tag(t))
 			return 0;
 		*tag = t;
@@ -262,7 +262,7 @@ static unsigned long finish_depth_computation(
 static void append_name(struct commit_name *n, struct strbuf *dst)
 {
 	if (n->prio == 2 && !n->tag) {
-		n->tag = lookup_tag(&n->oid);
+		n->tag = lookup_tag(the_repository, &n->oid);
 		if (!n->tag || parse_tag(n->tag))
 			die(_("annotated tag %s not available"), n->path);
 	}
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4e59e496dc..6348a5e721 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2371,7 +2371,7 @@ static void add_tag_chain(const struct object_id *oid)
 	if (packlist_find(&to_pack, oid->hash, NULL))
 		return;
 
-	tag = lookup_tag(oid);
+	tag = lookup_tag(the_repository, oid);
 	while (1) {
 		if (!tag || parse_tag(tag) || !tag->tagged)
 			die("unable to pack objects reachable from tag %s",
diff --git a/builtin/replace.c b/builtin/replace.c
index 25322d2f73..b79dd15fdb 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -360,7 +360,7 @@ static void check_one_mergetag(struct commit *commit,
 	int i;
 
 	hash_sha1_file(extra->value, extra->len, typename(OBJ_TAG), tag_oid.hash);
-	tag = lookup_tag(&tag_oid);
+	tag = lookup_tag(the_repository, &tag_oid);
 	if (!tag)
 		die(_("bad mergetag in commit '%s'"), ref);
 	if (parse_tag_buffer(tag, extra->value, extra->len))
diff --git a/contrib/coccinelle/object_parser.cocci b/contrib/coccinelle/object_parser.cocci
index e5ce73fe13..8b9b1c717a 100644
--- a/contrib/coccinelle/object_parser.cocci
+++ b/contrib/coccinelle/object_parser.cocci
@@ -13,6 +13,13 @@ expression E;
  E)
 
 
+@@
+expression E;
+@@
+ lookup_tag(
++the_repository,
+ E)
+
 @@
 expression E;
 @@
diff --git a/log-tree.c b/log-tree.c
index 57d5e5f56d..ff64a61e57 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -502,7 +502,7 @@ static void show_one_mergetag(struct commit *commit,
 	size_t payload_size, gpg_message_offset;
 
 	hash_sha1_file(extra->value, extra->len, typename(OBJ_TAG), oid.hash);
-	tag = lookup_tag(&oid);
+	tag = lookup_tag(the_repository, &oid);
 	if (!tag)
 		return; /* error message already given */
 
diff --git a/object.c b/object.c
index 5ddbe91a38..5ebbb32a92 100644
--- a/object.c
+++ b/object.c
@@ -220,7 +220,7 @@ struct object *parse_object_buffer(const struct object_id *oid, enum object_type
 			obj = &commit->object;
 		}
 	} else if (type == OBJ_TAG) {
-		struct tag *tag = lookup_tag(oid);
+		struct tag *tag = lookup_tag(the_repository, oid);
 		if (tag) {
 			if (parse_tag_buffer(tag, buffer, size))
 			       return NULL;
diff --git a/sha1_name.c b/sha1_name.c
index 0139b480a3..717b31359a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -379,7 +379,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 			format_commit_message(commit, " %ad - %s", &desc, &pp);
 		}
 	} else if (type == OBJ_TAG) {
-		struct tag *tag = lookup_tag(oid);
+		struct tag *tag = lookup_tag(the_repository, oid);
 		if (!parse_tag(tag) && tag->tag)
 			strbuf_addf(&desc, " %s", tag->tag);
 	}
diff --git a/tag.c b/tag.c
index ba1df1c695..8935f3c8c9 100644
--- a/tag.c
+++ b/tag.c
@@ -92,7 +92,7 @@ struct object *deref_tag_noverify(struct object *o)
 	return o;
 }
 
-struct tag *lookup_tag(const struct object_id *oid)
+struct tag *lookup_tag_the_repository(const struct object_id *oid)
 {
 	struct object *obj = lookup_object(the_repository, oid->hash);
 	if (!obj)
@@ -152,7 +152,7 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 	} else if (!strcmp(type, commit_type)) {
 		item->tagged = (struct object *)lookup_commit(&oid);
 	} else if (!strcmp(type, tag_type)) {
-		item->tagged = (struct object *)lookup_tag(&oid);
+		item->tagged = (struct object *)lookup_tag(the_repository, &oid);
 	} else {
 		error("Unknown type %s", type);
 		item->tagged = NULL;
diff --git a/tag.h b/tag.h
index d469534e82..97d58ebf7b 100644
--- a/tag.h
+++ b/tag.h
@@ -11,8 +11,8 @@ struct tag {
 	char *tag;
 	timestamp_t date;
 };
-
-extern struct tag *lookup_tag(const struct object_id *oid);
+#define lookup_tag(r, o) lookup_tag_##r(o)
+extern struct tag *lookup_tag_the_repository(const struct object_id *oid);
 extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
-- 
2.15.1.433.g936d1b9894.dirty

