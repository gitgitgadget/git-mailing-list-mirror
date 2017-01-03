Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19ABC1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 18:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965639AbdACSul (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 13:50:41 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35960 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965542AbdACSug (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 13:50:36 -0500
Received: by mail-pg0-f49.google.com with SMTP id f188so217396722pgc.3
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 10:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VFpBAPAPeNi3NhRsEKGO9l0nu2Z3fs0eGTvHWc6JDyk=;
        b=Fbi6KKvUNNm/FWSpB5itOhp/xV7GSxkH2T1bv4uyKA5ZbLUlLf3HYNMKRs5Mkm2VCJ
         PRJof5oXI0aJK81SlYw7X3Y8g5EBsNSetK/NQjv2Q00aHK38v5Yq0YsW4ZBsvrReXuKe
         gvbaiBR60qj4Pa/LXNjySKvADU8TngIXcgjecQKV0H302OcxF28757m6yU3oc7TufbBp
         K7HkgRQE3jCwP8+CAF5OYa8f10XwC5jEWedZvyMD+tTfPx9HyacN07XwSLvhjP+Fyxjl
         ad9Ppf3aNXY+tfkCmQ0U7l1naiLBfPvfhFFf5rKcjqOkyHdaO4rWnij4OCWGDjnERrni
         0OGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VFpBAPAPeNi3NhRsEKGO9l0nu2Z3fs0eGTvHWc6JDyk=;
        b=L4a066cBpQdSDz0bknJNJsFXOWySXWL/NvScIVDHVVCbEwBfHYOMWjXEKsRnMWuUgv
         VlUHMo/yGnqeKg9vGpKQwjJKFhq22k7waq8zs7xER+oDLWD7a4DU8Y5YhkVRm3Gl5nmz
         pOngtH87+PRSQpT87yeX0u2cD4LmFWS5sb6x98eLlfetPGOIlkA9D7c24g+EHMwBEFPC
         P8g1bGMmiXdLx7w2dj64ezVXtdb1xWW7/7q64DePmeVCmYyXlUOqmj/TEeq95sg2a+gy
         fmOb/Q3o4iGxpCuWu4bYfX7hyUAWB/gK/P2vR+35nWHpPDlONE5EtdXeRdWxbhcqqtaG
         oEng==
X-Gm-Message-State: AIkVDXILbdTzPN/bjOK0Dmt3PYRKQXyJS5f5FsgKXqBEERCw7wGPk5LExSd7nGFPj+C0wbi9
X-Received: by 10.98.26.88 with SMTP id a85mr59039900pfa.57.1483468990466;
        Tue, 03 Jan 2017 10:43:10 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id e5sm141421338pfd.77.2017.01.03.10.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:43:09 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v4 08/16] pathspec: always show mnemonic and name in unsupported_magic
Date:   Tue,  3 Jan 2017 10:42:33 -0800
Message-Id: <20170103184241.128409-9-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103184241.128409-1-bmwill@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com>
 <20170103184241.128409-1-bmwill@google.com>
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
 pathspec.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index b9a3819d6..ee87494c7 100644
--- a/pathspec.c
+++ b/pathspec.c
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
@@ -339,9 +335,11 @@ static void NORETURN unsupported_magic(const char *pattern,
 		if (!(magic & m->bit))
 			continue;
 		if (sb.len)
-			strbuf_addch(&sb, ' ');
-		if (short_magic & m->bit)
-			strbuf_addf(&sb, "'%c'", m->mnemonic);
+			strbuf_addstr(&sb, ", ");
+
+		if (m->mnemonic)
+			strbuf_addf(&sb, "'%s' (mnemonic: '%c')",
+				    m->name, m->mnemonic);
 		else
 			strbuf_addf(&sb, "'%s'", m->name);
 	}
@@ -413,11 +411,9 @@ void parse_pathspec(struct pathspec *pathspec,
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
@@ -425,9 +421,7 @@ void parse_pathspec(struct pathspec *pathspec,
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
2.11.0.390.gc69c2f50cf-goog

