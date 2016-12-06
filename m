Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA4B320259
	for <e@80x24.org>; Tue,  6 Dec 2016 21:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752554AbcLFVxX (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:53:23 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33622 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbcLFVxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:53:13 -0500
Received: by mail-pf0-f182.google.com with SMTP id d2so72484906pfd.0
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EjFlzWZU0pZcON6C3bdNGXSg7d8N5LRcqCDV/ATb1yE=;
        b=aDGL6cyragfweSY4AbigTnhlDUsjliakjYFaRF+k42n1hzQOYA9uQ+eoC/H5DvR5SY
         aaZxtwiiLzPssm6dRqSQyXpj/S5i+CduQ6aVBNXAbcwVBE30GNXJbxsx9Zoarow3X+e9
         m2rWkKx8Ncg8MqAij7xDyjepRAkwOECiJHtmIZje1BgxFKoSOEyrTcM9YsDZBMrJb9yP
         sJVEYW5/nQEyPIM5m6kzxvp0d6ka9F63EbRv7viZd/NMwZTgK++OE+1ycJErLdFHEyBe
         pYInp195YpYKJPFHXlXh1a/YJkzAtySk48k5q1zAWSChqUF9o1kgU6oIctw65GaIdbRQ
         4enQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EjFlzWZU0pZcON6C3bdNGXSg7d8N5LRcqCDV/ATb1yE=;
        b=USUEmJLeoSohY2x7CkF7cNebnccWqq8kJAfv9TV331Rw7xVTv7OACKaZmRrtMUEOTu
         ISpmHyFQyPjCdxHqO8Kq1gigufUJ0SwPiT+MhIvlVqcduoecWxJ7H5uovnM1S8r1DYaZ
         wFPK7vHITCSX1IBuXAk89GHP7KotG6Jh0kIGtUAcQtp6lKfLawxSJs4uoPt5nvVZp5Df
         fZW7KxHnB78Wr6w6fZ0nC86SqTREGvGe8ioTeHO81dYmeT20FR2ysg/W+UPYQTR4GBnw
         yHoACkqe1iYZENb+xFiieOC63nbUjAzDPaPjkfjByqaVj3WmfXy/9q4CP+c+OmOpvxOu
         0OEw==
X-Gm-Message-State: AKaTC00nD6u0a8IGzBs+4Rl5a0JPP3M8QJX9HDcS68TPTnD5T8rBMSWAwVynr/fREDoSh2J3
X-Received: by 10.84.217.70 with SMTP id e6mr139755870plj.161.1481061149048;
        Tue, 06 Dec 2016 13:52:29 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y89sm36940228pfk.83.2016.12.06.13.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 13:52:28 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 09/17] pathspec: always show mnemonic and name in unsupported_magic
Date:   Tue,  6 Dec 2016 13:51:38 -0800
Message-Id: <1481061106-117775-10-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
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
 pathspec.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index ec0d590..159f6db 100644
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
@@ -102,7 +102,6 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
  * string cannot express such a case.
  */
 static unsigned prefix_pathspec(struct pathspec_item *item,
-				unsigned *p_short_magic,
 				unsigned flags,
 				const char *prefix, int prefixlen,
 				const char *elt)
@@ -210,7 +209,6 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	}
 
 	magic |= short_magic;
-	*p_short_magic = short_magic;
 
 	/* --noglob-pathspec adds :(literal) _unless_ :(glob) is specified */
 	if (noglob_global && !(magic & PATHSPEC_GLOB))
@@ -329,8 +327,7 @@ static int pathspec_item_cmp(const void *a_, const void *b_)
 }
 
 static void NORETURN unsupported_magic(const char *pattern,
-				       unsigned magic,
-				       unsigned short_magic)
+				       unsigned magic)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int i;
@@ -340,8 +337,9 @@ static void NORETURN unsupported_magic(const char *pattern,
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
@@ -413,10 +411,9 @@ void parse_pathspec(struct pathspec *pathspec,
 	prefixlen = prefix ? strlen(prefix) : 0;
 
 	for (i = 0; i < n; i++) {
-		unsigned short_magic;
 		entry = argv[i];
 
-		item[i].magic = prefix_pathspec(item + i, &short_magic,
+		item[i].magic = prefix_pathspec(item + i,
 						flags,
 						prefix, prefixlen, entry);
 		if ((flags & PATHSPEC_LITERAL_PATH) &&
@@ -426,8 +423,7 @@ void parse_pathspec(struct pathspec *pathspec,
 			nr_exclude++;
 		if (item[i].magic & magic_mask)
 			unsupported_magic(entry,
-					  item[i].magic & magic_mask,
-					  short_magic);
+					  item[i].magic & magic_mask);
 
 		if ((flags & PATHSPEC_SYMLINK_LEADING_PATH) &&
 		    has_symlink_leading_path(item[i].match, item[i].len)) {
-- 
2.8.0.rc3.226.g39d4020

