Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 793551F424
	for <e@80x24.org>; Mon, 22 Jan 2018 11:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbeAVLEy (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 06:04:54 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38213 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbeAVLEv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 06:04:51 -0500
Received: by mail-wm0-f68.google.com with SMTP id 141so15891132wme.3
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 03:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=jxFZnz7v4UjOo3fQlEkx1N17KsOdUYWAtqjEBdFMLI8=;
        b=n5A88eqgU952OCBhGIK1vABHKuW6rmq5J+eD4OBS5rFgGlwESaZgJc1am1QjiWe/aC
         AwJi5l/1x1VCOV58ebCyYI8IDM5uvDtS3N9gAT2Wt5USKi1Fa4Y8L4RPnQKS46MbAqJA
         HU1zWkT+FAISuZNBNNE4iCdOJ/MJFIV18W5BHCqPoHQYlm7RplWiOBio+hZIbmjRUMJv
         +fx8YOkTlvnjlhmFEfaqqW1Lohgg4S+dQs9flDTtjDIpF9fhEbazXCENv9RScFN7PVx4
         RoqqBmE0ouhfHZsosSwYOd559rlOV5q0c9TswVDMxDf+ZltXiSV+KCrOLurL+cvPCnOe
         tdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jxFZnz7v4UjOo3fQlEkx1N17KsOdUYWAtqjEBdFMLI8=;
        b=LRrS/TxeuaJ0KlTrwEBLsc5QBZfOtQxKWhaLYS5dx9gyFwQYC7KgN4D/fFt70raEF3
         Hbsg2heFLVDDCojFUCyhIlu7fRav5KHbcgFj1tdBJMBvrsqykTSngQ+uUUy73d0LQ3Ih
         7v6VcKqNwngMY9gK+oPleVtQbbTIyxkh2a9Lybgja9ZPN4UXM25DaB1EtpIXgw+RYBtb
         UK1RAKLbvR7wJGwHskNi7PAoiby4a4OL+lcymW44GlnCFZHqEntYyuf6pRFDDqAoECKv
         XhpV4LYFvhDKfmNHOYMt5ln/bNmfPVVXzTmesATFfypiRJz4UtfYPRpC1N1lrTYK5XOU
         N+hA==
X-Gm-Message-State: AKwxytdv32hOLxl90uRiCUP3ZvfNvPeyXFcnPy9hxDg24oIFECWV4WfF
        BTPdrwn5Es4dcGy9wx3Trl409GPv
X-Google-Smtp-Source: AH8x2257c7yi2+V/ufqmrFraaU1Fd7W2RZ/puLENGagEQ2+YCvl4AY434rbipyo+s45D6l1B/ExbiQ==
X-Received: by 10.80.138.208 with SMTP id k16mr13184932edk.181.1516619089469;
        Mon, 22 Jan 2018 03:04:49 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id e12sm10833591edm.42.2018.01.22.03.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 03:04:48 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.ath.cx,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 07/14] match-trees: convert splice_tree to object_id
Date:   Mon, 22 Jan 2018 12:04:30 +0100
Message-Id: <b5782b135fb68b645ffea711028bd6024176005a.1516617960.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
 <cover.1516617960.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the definition of static recursive splice_tree function to use
struct object_id and adjust single caller.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 match-trees.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 396b7338df..0f899a7212 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -161,19 +161,17 @@ static void match_trees(const struct object_id *hash1,
  * A tree "hash1" has a subdirectory at "prefix".  Come up with a
  * tree object by replacing it with another tree "hash2".
  */
-static int splice_tree(const unsigned char *hash1,
-		       const char *prefix,
-		       const unsigned char *hash2,
-		       unsigned char *result)
+static int splice_tree(const struct object_id *hash1, const char *prefix,
+		       const struct object_id *hash2, struct object_id *result)
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
+	buf = read_sha1_file(hash1->hash, &type, &sz);
 	if (!buf)
-		die("cannot read tree %s", sha1_to_hex(hash1));
+		die("cannot read tree %s", oid_to_hex(hash1));
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
+				    oid_to_hex(hash1));
+			rewrite_here = (struct object_id *)oid;
 			break;
 		}
 		update_tree_entry(&desc);
 	}
 	if (!rewrite_here)
-		die("entry %.*s not found in tree %s",
-		    toplen, prefix, sha1_to_hex(hash1));
+		die("entry %.*s not found in tree %s", toplen, prefix,
+		    oid_to_hex(hash1));
 	if (*subpath) {
-		status = splice_tree(rewrite_here, subpath, hash2, subtree);
+		status = splice_tree(rewrite_here, subpath, hash2, &subtree);
 		if (status)
 			return status;
-		rewrite_with = subtree;
-	}
-	else
+		rewrite_with = &subtree;
+	} else {
 		rewrite_with = hash2;
-	hashcpy(rewrite_here, rewrite_with);
-	status = write_sha1_file(buf, sz, tree_type, result);
+	}
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

