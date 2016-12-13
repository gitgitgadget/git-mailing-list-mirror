Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F92320451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbcLMXQk (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:16:40 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33780 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbcLMXQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:16:31 -0500
Received: by mail-pg0-f46.google.com with SMTP id 3so797717pgd.0
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 15:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3/rZLp9yabXz8S/VVmmH9IS+1TfaJcK7mCEebCH0S5g=;
        b=CIB4oNo51V/3eb/lsdYJS1hPWGLbkEhlYvhJEyl+3UG7Q0YV8wb42aQR7KDUxBo4Kl
         LD9D2j8MG+yTcVPddDGNNUrk/AErmbcSjamOkZWdaVhyKY5Pon4Y9DHs84V2fpQ1WuL8
         sQIOjclIqUmJnBU2fMzo/ikF4ECPxyGzgGyLkhi/ZCpc9HVWxd52MpPW+hgGnpye9kGy
         srhTdMODzE9APtL9LahaSx8MmE5Sx4teW856QqMJJ0KOe6QIENmy464yba5YYR4K1UGX
         hfbCbV3YwYCZYWXBbLOT5t/iLJDJRbhNqCFQKMBpbktCsmICR+IHcKyW//sYSRYhneLj
         dGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3/rZLp9yabXz8S/VVmmH9IS+1TfaJcK7mCEebCH0S5g=;
        b=TW/03wihCJtDpvvQ7JesjjRpd08Jz9aVsm2+C0WLxcOdv/BjysCOG2nNMLn88cVV2D
         /CqQfLHwjDlYkEajivW86SyaYMIrySS1uOuO8OEZcZk1EX9u38QP8dzqRLk5InevdRaj
         +buqCAIRfhKd8/JRcB/iy3i/mMB4LJjIsOumFsMDKjznMCNGl6e7YhRS+3kyucpjla/d
         20GDUEVMaNGdUZXwpiPmiB5opsYxFhxNz3dIRXXzmrO4+L8OSizH9OIg74I4/6QdlQ+6
         h4hWLYc0lGyicLRtHjwpZbrd/528+Ry+WJJ6bB9aiGYzkSiCP0EHTOzBb0gLfG7ZnSt+
         HvAA==
X-Gm-Message-State: AKaTC024OmIjqsDDQ/o43f6GPQnpvMcCtukm9MPsRSW0Q+7Ya7s+nPM397PoE22KpFiJ2Re2
X-Received: by 10.99.244.17 with SMTP id g17mr181153379pgi.80.1481670892159;
        Tue, 13 Dec 2016 15:14:52 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id c15sm82308567pfd.36.2016.12.13.15.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 15:14:51 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v3 08/16] pathspec: always show mnemonic and name in unsupported_magic
Date:   Tue, 13 Dec 2016 15:14:22 -0800
Message-Id: <1481670870-66754-9-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481670870-66754-1-git-send-email-bmwill@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481670870-66754-1-git-send-email-bmwill@google.com>
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
 pathspec.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index ec0d590..609c58f 100644
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

