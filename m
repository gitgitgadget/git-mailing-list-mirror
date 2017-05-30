Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D8E2027C
	for <e@80x24.org>; Tue, 30 May 2017 17:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbdE3Rbp (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:31:45 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34454 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbdE3Rbl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:41 -0400
Received: by mail-pf0-f176.google.com with SMTP id 9so78320538pfj.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d0Bz1AUj8khzWpthkjuTTFjodkxPncoKmdZNGAhxzpQ=;
        b=BmJFKIGaOJZfp+Ewzw4Yp+BWyJO4Ja+kIrhrnCCFjZZKyZfA4HCJ6zpmdLlBDTOaMk
         19Z4x60zcLEI/SKhMP3gMnhvBSYqjvJo0ZvWM9SVRYlKZki7wpSUZCUd5SM0hg77oWaJ
         9nYL2bHCWuGVNoh2j9j54FOoI+JcrgcsAEZtkhdTsntVhH6/W9ipexjXCSTBMrBfGtLN
         h7i/DDPRwbmtpJDnhJV7Df/50IbCs5HY1dIBO8pTvi9Tf3vMWK9hmObmYQwUWU1UQ4G1
         4Mhm3qCQ/bFaFpBtaZabH1LkYtFftjQWyP8Tm7MZyvq0T36KVKRmDjrfSm8cXSb+vhqN
         WlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d0Bz1AUj8khzWpthkjuTTFjodkxPncoKmdZNGAhxzpQ=;
        b=FWon04/+j0dAt2KVSgpDqBNdjiPhni+7CwF8/3iiikTVo7YOFyMrWkQ77PZBYuSKX9
         oHsJDXZ9NT7Qd471GR8pu3/Av4EgadL0nqKSsgF+6I/vTbd6JD1XGUQkrwCdAkj1yFmL
         AXFdlCrcn/5sL2Epcey1zM14ntsrK0EaKCFUHE8mfu+2Wd3RxNY4f5oWVp7D5vtob4D7
         mkqSMQdsqdCkBJcAe9Cp5q524/2bdL4f2OJL7wnr3dI80l5T2a711rHmd2aHvYQ2XIgU
         hkoik88bZEvR/Nl8fbHMDvIVD6l7Vfq0nROT/TGuwrRQVtNWaGafkCaJ2D9azBN7BEHC
         r69g==
X-Gm-Message-State: AODbwcBNXrJU25KLKNuSq543KClkg5D0RljGbB2RSAvC7VbTq53r0jAZ
        X5b5Kr2D3oCjBsJxf8mb1Q==
X-Received: by 10.99.123.94 with SMTP id k30mr26524067pgn.91.1496165489905;
        Tue, 30 May 2017 10:31:29 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:29 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 10/33] diff: convert diff_index_show_file to struct object_id
Date:   Tue, 30 May 2017 10:30:46 -0700
Message-Id: <20170530173109.54904-11-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diff-lib.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index a3bc78162..2c838aaf4 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -255,12 +255,12 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 static void diff_index_show_file(struct rev_info *revs,
 				 const char *prefix,
 				 const struct cache_entry *ce,
-				 const unsigned char *sha1, int sha1_valid,
+				 const struct object_id *oid, int oid_valid,
 				 unsigned int mode,
 				 unsigned dirty_submodule)
 {
 	diff_addremove(&revs->diffopt, prefix[0], mode,
-		       sha1, sha1_valid, ce->name, dirty_submodule);
+		       oid->hash, oid_valid, ce->name, dirty_submodule);
 }
 
 static int get_stat_data(const struct cache_entry *ce,
@@ -315,7 +315,7 @@ static void show_new_file(struct rev_info *revs,
 	    &dirty_submodule, &revs->diffopt) < 0)
 		return;
 
-	diff_index_show_file(revs, "+", new, oid->hash, !is_null_oid(oid), mode, dirty_submodule);
+	diff_index_show_file(revs, "+", new, oid, !is_null_oid(oid), mode, dirty_submodule);
 }
 
 static int show_modified(struct rev_info *revs,
@@ -332,7 +332,7 @@ static int show_modified(struct rev_info *revs,
 			  &dirty_submodule, &revs->diffopt) < 0) {
 		if (report_missing)
 			diff_index_show_file(revs, "-", old,
-					     old->oid.hash, 1, old->ce_mode,
+					     &old->oid, 1, old->ce_mode,
 					     0);
 		return -1;
 	}
@@ -426,7 +426,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	 * Something removed from the tree?
 	 */
 	if (!idx) {
-		diff_index_show_file(revs, "-", tree, tree->oid.hash, 1,
+		diff_index_show_file(revs, "-", tree, &tree->oid, 1,
 				     tree->ce_mode, 0);
 		return;
 	}
-- 
2.13.0.219.gdb65acc882-goog

