Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E53801F404
	for <e@80x24.org>; Sun, 28 Jan 2018 00:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeA1ANg (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 19:13:36 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37742 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752380AbeA1ANc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 19:13:32 -0500
Received: by mail-lf0-f68.google.com with SMTP id 63so5046724lfv.4
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 16:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=h3bmnLy1TpLcZnJgQq5WrClr6s8o9JofBu1CKx0nRV8=;
        b=MscxtzXLF0bBzch3Cr9/JdlCwe0cQwnrnOPXy015k68mniM6eoXOQ+MFWQ4CydHr2i
         HLjUGdOizJMIzNSG0bZkWOEEDZaL92mWzGJWQ40jYE6vzpegUBfKCqWbHaaqrunXvL2g
         dLI6lZ45ggVx8DUGFGE182p/ZUFd3Urj36pf35UaVkwBSZVCPuLh/Xh0uSq+6eQKZhC+
         lVFK7AvWOa78ZilAYkFAFKoCqrZRUi2ifDYgRF0+tkMcFPMZSoQwaCsAaJ2DuRaNQQh8
         YHAF7B9S5U6YY4Wxyc/192lDmr9B4CoAD6A9lYzcCesnZF7lTJ14SO2z1aHsu6AZgmBO
         rPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=h3bmnLy1TpLcZnJgQq5WrClr6s8o9JofBu1CKx0nRV8=;
        b=XMu6a/LcgxLKbszX1Zea0U1c/0FjCZ41dcN/LtYjRjqSiqeChPQWTQOEfaAoIHplB1
         NR/3bLsfeVJSLXeHnzOl5Gfqk1OQHSDs4g9nnb1wiQ/+8d9cLil7htmyOU0/y8R7ogPy
         B/ZOLDvtL8suf1abyU4lxV08cqLuNT4cvZrqaBzwfFOHXy/tRDNJKPj5vTvorpWmidOp
         BZ090vIYPjPEAurvIvGlitTISmy4cA311CBeVtIFjVqxGFXVdKBYZkT6tV74sg5mug4v
         yH6RLo17zpuKegjN3MFBRZ7svmD2YqJCIDsuaZqsW6r1e0sQgEiUVqwFdvhbGktH5Q0X
         2Vpw==
X-Gm-Message-State: AKwxytfYzw1i/pk+4Uug2Cp6JE1RnRTMfg+Puoo2HBcYUXkkqptE6xAt
        +VG+5pUQCf44ZEVryCBL4zyxTsg2
X-Google-Smtp-Source: AH8x225jYqkZqeTiEi9c7U3Y+RJwjZd37Nuyjygoic6tGrFdfpU49VvpBKo9q/iUyV9vY4ccn4O75A==
X-Received: by 10.25.78.155 with SMTP id u27mr12045660lfk.86.1517098411175;
        Sat, 27 Jan 2018 16:13:31 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id y26sm2144695lfk.30.2018.01.27.16.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jan 2018 16:13:30 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 05/12] match-trees: convert splice_tree to object_id
Date:   Sun, 28 Jan 2018 01:13:15 +0100
Message-Id: <43779db73a7300aaa235ee62b4ad443ecdefcf02.1517097306.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1517097306.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
 <cover.1517097306.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1517097306.git.patryk.obara@gmail.com>
References: <cover.1517097306.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the definition of static recursive splice_tree function to use
struct object_id and adjust single caller.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 match-trees.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 396b7338df..afb771c4f5 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -158,22 +158,20 @@ static void match_trees(const struct object_id *hash1,
 }
 
 /*
- * A tree "hash1" has a subdirectory at "prefix".  Come up with a
- * tree object by replacing it with another tree "hash2".
+ * A tree "oid1" has a subdirectory at "prefix".  Come up with a tree object by
+ * replacing it with another tree "oid2".
  */
-static int splice_tree(const unsigned char *hash1,
-		       const char *prefix,
-		       const unsigned char *hash2,
-		       unsigned char *result)
+static int splice_tree(const struct object_id *oid1, const char *prefix,
+		       const struct object_id *oid2, struct object_id *result)
 {
 	char *subpath;
 	int toplen;
 	char *buf;
 	unsigned long sz;
 	struct tree_desc desc;
-	unsigned char *rewrite_here;
-	const unsigned char *rewrite_with;
-	unsigned char subtree[20];
+	struct object_id *rewrite_here;
+	const struct object_id *rewrite_with;
+	struct object_id subtree;
 	enum object_type type;
 	int status;
 
@@ -182,9 +180,9 @@ static int splice_tree(const unsigned char *hash1,
 	if (*subpath)
 		subpath++;
 
-	buf = read_sha1_file(hash1, &type, &sz);
+	buf = read_sha1_file(oid1->hash, &type, &sz);
 	if (!buf)
-		die("cannot read tree %s", sha1_to_hex(hash1));
+		die("cannot read tree %s", oid_to_hex(oid1));
 	init_tree_desc(&desc, buf, sz);
 
 	rewrite_here = NULL;
@@ -197,26 +195,26 @@ static int splice_tree(const unsigned char *hash1,
 		if (strlen(name) == toplen &&
 		    !memcmp(name, prefix, toplen)) {
 			if (!S_ISDIR(mode))
-				die("entry %s in tree %s is not a tree",
-				    name, sha1_to_hex(hash1));
-			rewrite_here = (unsigned char *) oid->hash;
+				die("entry %s in tree %s is not a tree", name,
+				    oid_to_hex(oid1));
+			rewrite_here = (struct object_id *)oid;
 			break;
 		}
 		update_tree_entry(&desc);
 	}
 	if (!rewrite_here)
-		die("entry %.*s not found in tree %s",
-		    toplen, prefix, sha1_to_hex(hash1));
+		die("entry %.*s not found in tree %s", toplen, prefix,
+		    oid_to_hex(oid1));
 	if (*subpath) {
-		status = splice_tree(rewrite_here, subpath, hash2, subtree);
+		status = splice_tree(rewrite_here, subpath, oid2, &subtree);
 		if (status)
 			return status;
-		rewrite_with = subtree;
+		rewrite_with = &subtree;
+	} else {
+		rewrite_with = oid2;
 	}
-	else
-		rewrite_with = hash2;
-	hashcpy(rewrite_here, rewrite_with);
-	status = write_sha1_file(buf, sz, tree_type, result);
+	oidcpy(rewrite_here, rewrite_with);
+	status = write_sha1_file(buf, sz, tree_type, result->hash);
 	free(buf);
 	return status;
 }
@@ -280,7 +278,7 @@ void shift_tree(const struct object_id *hash1,
 	if (!*add_prefix)
 		return;
 
-	splice_tree(hash1->hash, add_prefix, hash2->hash, shifted->hash);
+	splice_tree(hash1, add_prefix, hash2, shifted);
 }
 
 /*
@@ -334,7 +332,7 @@ void shift_tree_by(const struct object_id *hash1,
 		 * shift tree2 down by adding shift_prefix above it
 		 * to match tree1.
 		 */
-		splice_tree(hash1->hash, shift_prefix, hash2->hash, shifted->hash);
+		splice_tree(hash1, shift_prefix, hash2, shifted);
 	else
 		/*
 		 * shift tree2 up by removing shift_prefix from it
-- 
2.14.3

