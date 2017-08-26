Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB0B620285
	for <e@80x24.org>; Sat, 26 Aug 2017 08:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754561AbdHZI2o (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 04:28:44 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:49712 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754535AbdHZI2k (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 Aug 2017 04:28:40 -0400
X-AuditID: 1207440f-a5bff70000007960-10-59a13137ccf1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 9C.8D.31072.73131A95; Sat, 26 Aug 2017 04:28:39 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5EB.dip0.t-ipconnect.de [87.188.197.235])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7Q8SHiq004049
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 26 Aug 2017 04:28:37 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/12] get_oid_hex_segment(): don't pad the rest of `oid`
Date:   Sat, 26 Aug 2017 10:28:10 +0200
Message-Id: <ba5c439f990752a7768ed82c04a387aabd75558a.1503734566.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1503734566.git.mhagger@alum.mit.edu>
References: <cover.1503734566.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsUixO6iqGtuuDDS4O0+CYuuK91MFg29V5gt
        5t3dxWTRv7yLzeL2ivnMDqwef99/YPL48DHO49LL72weFy8pe3zeJBfAGsVlk5Kak1mWWqRv
        l8CVcefvd5aC86IVxzefZm1gXC7QxcjJISFgInHg2jf2LkYuDiGBHUwSm/bNZIZwTgE5jc0s
        IFVsAroSi3qamUBsEQE1iYlth1hAipgFljNKdLw9D5YQFvCU2DxtFlA3BweLgKrEw50KIGFe
        gSiJfXOOsUBsk5fY1XaRFcTmFLCQuLH1MxuILSRgLtH3cxHLBEaeBYwMqxjlEnNKc3VzEzNz
        ilOTdYuTE/PyUot0TfRyM0v0UlNKNzFCAod/B2PXeplDjAIcjEo8vBGFCyKFWBPLiitzDzFK
        cjApifI6aCyMFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCu0IJKMebklhZlVqUD5OS5mBREudV
        X6LuJySQnliSmp2aWpBaBJOV4eBQkuDt0AdqFCxKTU+tSMvMKUFIM3FwggznARqeAVLDW1yQ
        mFucmQ6RP8WoKCXO6wCSEABJZJTmwfXCIvsVozjQK8K8UQZAVTzApADX/QpoMBPQYEVBsMEl
        iQgpqQZGz/KUr2vOss46GGUk3NUTY7H16px0jTfXxHTe/RSqSGTM4+XOfvPK46nTxNXC+Wm+
        rE8yX2x6xB8/QV1EPyxk/iflkIezhQJDzn2bnfmwX8a3VUgqmZ9L+03Cw1+B/6u/JB1gaDD5
        asIo9amWW2amevjdWUXbGxdy8zh1/a9n3/fI+YOt/gclluKMREMt5qLiRAB0gzfnxwIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the feature of `get_oid_hex_segment()` that it pads the rest of
the `oid` argument with zeros. Instead, do this at the caller who
needs it.

This makes the functionality of this function more coherent and
removes the need for its `oid_len` argument.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/notes.c b/notes.c
index 534fda007e..ce9ba36179 100644
--- a/notes.c
+++ b/notes.c
@@ -339,15 +339,14 @@ static void note_tree_free(struct int_node *tree)
  * - hex      - Partial SHA1 segment in ASCII hex format
  * - hex_len  - Length of above segment. Must be multiple of 2 between 0 and 40
  * - oid      - Partial SHA1 value is written here
- * - oid_len  - Max #bytes to store in sha1, Must be >= hex_len / 2, and < 20
  * Return 0 on success or -1 on error (invalid arguments or input not
- * in hex format). Pad oid with NULs up to oid_len.
+ * in hex format).
  */
 static int get_oid_hex_segment(const char *hex, unsigned int hex_len,
-		unsigned char *oid, unsigned int oid_len)
+		unsigned char *oid)
 {
 	unsigned int i, len = hex_len >> 1;
-	if (hex_len % 2 != 0 || len > oid_len)
+	if (hex_len % 2 != 0)
 		return -1;
 	for (i = 0; i < len; i++) {
 		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
@@ -356,8 +355,6 @@ static int get_oid_hex_segment(const char *hex, unsigned int hex_len,
 		*oid++ = val;
 		hex += 2;
 	}
-	for (; i < oid_len; i++)
-		*oid++ = 0;
 	return 0;
 }
 
@@ -442,24 +439,29 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 				goto handle_non_note;
 
 			if (get_oid_hex_segment(entry.path, path_len,
-						object_oid.hash + prefix_len,
-						GIT_SHA1_RAWSZ - prefix_len))
+						object_oid.hash + prefix_len))
 				goto handle_non_note; /* entry.path is not a SHA1 */
 
 			type = PTR_TYPE_NOTE;
 		} else if (path_len == 2) {
 			/* This is potentially an internal node */
+			size_t len = prefix_len;
 
 			if (!S_ISDIR(entry.mode))
 				/* internal nodes must be trees */
 				goto handle_non_note;
 
 			if (get_oid_hex_segment(entry.path, 2,
-						object_oid.hash + prefix_len,
-						GIT_SHA1_RAWSZ - prefix_len))
+						object_oid.hash + len++))
 				goto handle_non_note; /* entry.path is not a SHA1 */
 
-			object_oid.hash[KEY_INDEX] = (unsigned char) (prefix_len + 1);
+			/*
+			 * Pad the rest of the SHA-1 with zeros,
+			 * except for the last byte, where we write
+			 * the length:
+			 */
+			memset(object_oid.hash + len, 0, GIT_SHA1_RAWSZ - len - 1);
+			object_oid.hash[KEY_INDEX] = (unsigned char)len;
 
 			type = PTR_TYPE_SUBTREE;
 		} else {
-- 
2.11.0

