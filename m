Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CFF01F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeBFANE (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:13:04 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40575 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeBFANC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:13:02 -0500
Received: by mail-pg0-f68.google.com with SMTP id g2so146578pgn.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pfT1vEO0aaP/L/syPQ/ApUh2FukovMrCnk4Mig1ixw0=;
        b=k8C6WNZGN8WZ8dei/MaUxrK0igcBUPG8TIQYCnWNmGxzcsflPfYMZpcsEAUuPIH/pr
         EtMdtOjccAFACIP17mdjtc194b2N6SBJrTiSBlhN4V6Kh8Fs9Ar8zA046wAq9H9A3+uM
         GvSzAoZblilSfmdFWrJOaUxjwhDYtDgjLkAYJnn+H2dfm6sMardA1dQo3PO2CO+p+Skk
         83MZ2HEHBaldFBvypOfBMyLlYw19LZH4YZavIXJ6p3g29PUfRByITQVgzLnKtBjihWBM
         pU4b13QW6lRsUw6BT9q5qDBH/V7e/NNpWSQ3bzw7HgbzyctYLbPz6ZEH6g8PSTSD9/T2
         P57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pfT1vEO0aaP/L/syPQ/ApUh2FukovMrCnk4Mig1ixw0=;
        b=Zg0dPNde825Wu2VX7YNitzleHwngDnxILE/s4Cey042q/ruM6iObgAKZqCbIES/KPY
         qAZ1zH6SAjb/cpAGfUCPak9YiVRzMpMfw5Npf8Bt6bDYxS0tMAeymzBoFqsSTZXZ12Z5
         pYzCjjjpz3V4Nfi/n5+DrY848t1vKGwLxmK13oHTSsn/3IpKD7acxKwu9k6FSDciZqZp
         7JhEkwq7yoPtoFURDTyC0DWrC086xxTCYMso+dPsRmLRz4rnGckSSnadAXhjh4/tJM9d
         ITmFX9zMAru9n7E6pg4kfpcMn4NppqRUDr1gZ8mDfF1fa7/+B4NojDsYgChw6iafZOk9
         iSwQ==
X-Gm-Message-State: APf1xPBa3PAGvNd1OljmB1mEtDj8tqTY8quu/uCGRPHldfegCATx8wPn
        Jp8wx1eFpZyFafxflKFLQA7V4S7kvQY=
X-Google-Smtp-Source: AH8x225lz7X/L1QMRFKk+HVMm06kxIvGjuXVVHqYxKa8KaOP/vTJn5TkR/Fg+sv0RlZ5Ucw9P26OCw==
X-Received: by 10.99.180.67 with SMTP id n3mr403591pgu.169.1517875981870;
        Mon, 05 Feb 2018 16:13:01 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id p69sm19955057pfk.7.2018.02.05.16.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:13:01 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 087/194] tag: add repository argument to parse_tag_buffer
Date:   Mon,  5 Feb 2018 15:55:48 -0800
Message-Id: <20180205235735.216710-67-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of parse_tag_buffer
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Add the cocci patch that converted the callers.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/replace.c                      | 2 +-
 contrib/coccinelle/object_parser.cocci | 9 +++++++++
 log-tree.c                             | 2 +-
 object.c                               | 2 +-
 sha1_file.c                            | 2 +-
 tag.c                                  | 4 ++--
 tag.h                                  | 3 ++-
 7 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index b79dd15fdb..d1a939c17b 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -363,7 +363,7 @@ static void check_one_mergetag(struct commit *commit,
 	tag = lookup_tag(the_repository, &tag_oid);
 	if (!tag)
 		die(_("bad mergetag in commit '%s'"), ref);
-	if (parse_tag_buffer(tag, extra->value, extra->len))
+	if (parse_tag_buffer(the_repository, tag, extra->value, extra->len))
 		die(_("malformed mergetag in commit '%s'"), ref);
 
 	/* iterate over new parents */
diff --git a/contrib/coccinelle/object_parser.cocci b/contrib/coccinelle/object_parser.cocci
index 8b9b1c717a..0e2ebdfccb 100644
--- a/contrib/coccinelle/object_parser.cocci
+++ b/contrib/coccinelle/object_parser.cocci
@@ -20,6 +20,15 @@ expression E;
 +the_repository,
  E)
 
+@@
+expression E;
+expression F;
+expression G;
+@@
+ parse_tag_buffer(
++the_repository,
+ E, F, G)
+
 @@
 expression E;
 @@
diff --git a/log-tree.c b/log-tree.c
index ff64a61e57..1137506884 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -507,7 +507,7 @@ static void show_one_mergetag(struct commit *commit,
 		return; /* error message already given */
 
 	strbuf_init(&verify_message, 256);
-	if (parse_tag_buffer(tag, extra->value, extra->len))
+	if (parse_tag_buffer(the_repository, tag, extra->value, extra->len))
 		strbuf_addstr(&verify_message, "malformed mergetag\n");
 	else if (is_common_merge(commit) &&
 		 !oidcmp(&tag->tagged->oid,
diff --git a/object.c b/object.c
index 5ebbb32a92..c9ce89cf37 100644
--- a/object.c
+++ b/object.c
@@ -222,7 +222,7 @@ struct object *parse_object_buffer(const struct object_id *oid, enum object_type
 	} else if (type == OBJ_TAG) {
 		struct tag *tag = lookup_tag(the_repository, oid);
 		if (tag) {
-			if (parse_tag_buffer(tag, buffer, size))
+			if (parse_tag_buffer(the_repository, tag, buffer, size))
 			       return NULL;
 			obj = &tag->object;
 		}
diff --git a/sha1_file.c b/sha1_file.c
index c296b76329..df8bd4c260 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1759,7 +1759,7 @@ static void check_tag(const void *buf, size_t size)
 {
 	struct tag t;
 	memset(&t, 0, sizeof(t));
-	if (parse_tag_buffer(&t, buf, size))
+	if (parse_tag_buffer(the_repository, &t, buf, size))
 		die("corrupt tag");
 }
 
diff --git a/tag.c b/tag.c
index 8935f3c8c9..7ff9943847 100644
--- a/tag.c
+++ b/tag.c
@@ -118,7 +118,7 @@ static timestamp_t parse_tag_date(const char *buf, const char *tail)
 	return parse_timestamp(dateptr, NULL, 10);
 }
 
-int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
+int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size)
 {
 	struct object_id oid;
 	char type[20];
@@ -195,7 +195,7 @@ int parse_tag(struct tag *item)
 		return error("Object %s not a tag",
 			     oid_to_hex(&item->object.oid));
 	}
-	ret = parse_tag_buffer(item, data, size);
+	ret = parse_tag_buffer(the_repository, item, data, size);
 	free(data);
 	return ret;
 }
diff --git a/tag.h b/tag.h
index 97d58ebf7b..31498e788a 100644
--- a/tag.h
+++ b/tag.h
@@ -13,7 +13,8 @@ struct tag {
 };
 #define lookup_tag(r, o) lookup_tag_##r(o)
 extern struct tag *lookup_tag_the_repository(const struct object_id *oid);
-extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long size);
+#define parse_tag_buffer(r, i, d, s) parse_tag_buffer_##r(i, d, s)
+extern int parse_tag_buffer_the_repository(struct tag *item, const void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
-- 
2.15.1.433.g936d1b9894.dirty

