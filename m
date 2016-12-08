Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 256BE1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 19:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932408AbcLHTCG (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 14:02:06 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34334 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753695AbcLHS7g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:59:36 -0500
Received: by mail-pg0-f51.google.com with SMTP id x23so176764957pgx.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QEFZhg4SkxaSiQHcNUVY5GUl3lR2yb97zOVAmeVenS4=;
        b=Z/ilJoRNIGDFAGmBwMjFniZhSEvux0IOm5GDdkcTm039ey7yQPQKNFBiLPx3IPGpSL
         xuVjNvBcjFAIbC16ZqyM1F+xadpjDRwUrR7HZuxtGeRbgvPQLW2qLV4jF+MBuBRhhe5v
         EyNO7MJ6PZBfrDHNpMS1BLQx/s2u2Se0ElEVJp3CKlxIKwi//4r6tOY9Z5tw5r8f9QdW
         8PZdCwwZx7qjvW1bcsJ8u6QIeqFSwEW1plJYoUkh3Cbtq8ak5M729RTpFp4TNkJQLjxj
         X5a1LD489AmUNyVzgkEfk64Ezxw1cjVMYUb2jqz5zg4TZFnYRXp3EiXaky2ehmWYkUhi
         SP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QEFZhg4SkxaSiQHcNUVY5GUl3lR2yb97zOVAmeVenS4=;
        b=mHTfiMWIDxGE52kkRJqem7qbNd4t4DOlzAr8u94EM7iBiq+Wl6lY6sZwmSh62ixy7I
         KikDJJVd25XONxWV9xJJRpP+5QQ4ziVW6H1H/aV7jRt+uGk0KDBiVG6DMqfbZcMdXUQm
         vHd/WV77D0okKZwOUkPSV0mdFPzicXUvFZml140WXpcG9Ze1Tl+beu65T6vJSRWRaDWc
         nhAivRnCBYiZLliLV6jii1k28EHx4y/ZHMh4r5QT9H2FvuC3gBWjB0ONS008Tm+1gefF
         q3trIzppelLTQ0YVcnpdoOqn0gg0eVcOVYAj6xF0XMHpXu4nf2IM0IJgD/CEf6zNRyK3
         nJwA==
X-Gm-Message-State: AKaTC03Etigq/sRLg8Iw4QuXqRQJPsbSAtJ8vexk4gj2KY3cGDEVnB7cNleD99gUSiBO7rx7
X-Received: by 10.99.247.69 with SMTP id f5mr136276508pgk.81.1481223575865;
        Thu, 08 Dec 2016 10:59:35 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id p64sm51815634pfi.88.2016.12.08.10.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:59:34 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v2 08/16] pathspec: always show mnemonic and name in unsupported_magic
Date:   Thu,  8 Dec 2016 10:59:02 -0800
Message-Id: <1481223550-65277-9-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481223550-65277-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
 <1481223550-65277-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For better clarity, always show the mnemonic and name of the unsupported
magic being used.  This lets users have a more clear understanding of
what magic feature isn't supported.  And if they supplied a mnemonic,
the user will be told what its corresponding name is which will allow
them to more easily search the man pages for that magic type.

This also avoids passing an extra parameter around the pathspec
initialization code.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index ec0d590..a360193 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -68,7 +68,7 @@ static struct pathspec_magic {
 	const char *name;
 } pathspec_magic[] = {
 	{ PATHSPEC_FROMTOP, '/', "top" },
-	{ PATHSPEC_LITERAL,   0, "literal" },
+	{ PATHSPEC_LITERAL,'\0', "literal" },
 	{ PATHSPEC_GLOB,   '\0', "glob" },
 	{ PATHSPEC_ICASE,  '\0', "icase" },
 	{ PATHSPEC_EXCLUDE, '!', "exclude" },
@@ -101,9 +101,7 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
  * the prefix part must always match literally, and a single stupid
  * string cannot express such a case.
  */
-static unsigned prefix_pathspec(struct pathspec_item *item,
-				unsigned *p_short_magic,
-				unsigned flags,
+static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 				const char *prefix, int prefixlen,
 				const char *elt)
 {
@@ -210,7 +208,6 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	}
 
 	magic |= short_magic;
-	*p_short_magic = short_magic;
 
 	/* --noglob-pathspec adds :(literal) _unless_ :(glob) is specified */
 	if (noglob_global && !(magic & PATHSPEC_GLOB))
@@ -329,8 +326,7 @@ static int pathspec_item_cmp(const void *a_, const void *b_)
 }
 
 static void NORETURN unsupported_magic(const char *pattern,
-				       unsigned magic,
-				       unsigned short_magic)
+				       unsigned magic)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int i;
@@ -340,8 +336,9 @@ static void NORETURN unsupported_magic(const char *pattern,
 			continue;
 		if (sb.len)
 			strbuf_addch(&sb, ' ');
-		if (short_magic & m->bit)
-			strbuf_addf(&sb, "'%c'", m->mnemonic);
+
+		if (m->mnemonic)
+			strbuf_addf(&sb, "'(%c)%s'", m->mnemonic, m->name);
 		else
 			strbuf_addf(&sb, "'%s'", m->name);
 	}
@@ -413,11 +410,9 @@ void parse_pathspec(struct pathspec *pathspec,
 	prefixlen = prefix ? strlen(prefix) : 0;
 
 	for (i = 0; i < n; i++) {
-		unsigned short_magic;
 		entry = argv[i];
 
-		item[i].magic = prefix_pathspec(item + i, &short_magic,
-						flags,
+		item[i].magic = prefix_pathspec(item + i, flags,
 						prefix, prefixlen, entry);
 		if ((flags & PATHSPEC_LITERAL_PATH) &&
 		    !(magic_mask & PATHSPEC_LITERAL))
@@ -425,9 +420,7 @@ void parse_pathspec(struct pathspec *pathspec,
 		if (item[i].magic & PATHSPEC_EXCLUDE)
 			nr_exclude++;
 		if (item[i].magic & magic_mask)
-			unsupported_magic(entry,
-					  item[i].magic & magic_mask,
-					  short_magic);
+			unsupported_magic(entry, item[i].magic & magic_mask);
 
 		if ((flags & PATHSPEC_SYMLINK_LEADING_PATH) &&
 		    has_symlink_leading_path(item[i].match, item[i].len)) {
-- 
2.8.0.rc3.226.g39d4020

