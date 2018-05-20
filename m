Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 020711F42D
	for <e@80x24.org>; Sun, 20 May 2018 10:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751094AbeETKSd (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 06:18:33 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40740 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeETKSc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 06:18:32 -0400
Received: by mail-wr0-f195.google.com with SMTP id v60-v6so13176648wrc.7
        for <git@vger.kernel.org>; Sun, 20 May 2018 03:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jtxNFsIbD5zn4RpbCZ/XdFrWVFJW2UCfw9i5Uatoj+Y=;
        b=VbTaX8eYB8eDHUaIdwegcZzOVXK7FhhrDW3GoFA7eGYI0YSmfHdTek3jLq5nm9crCs
         fJiA3pQ821Q07FoWzLHAPv94pJxnMUtA/kbhZuwFHecmbMV/A6e3mlUYZrnjJoKnhxe6
         h70rQRLhhOrOigni2S3UbLZ3OmKaWLWVaXSyw19z9LVJMunSlDcWp+xeoCKAHo5qH76p
         OWohxd+kxtOZ7XN/W7Bc7gfiXdYPsCVO4Of87/4e6aRcX8efBCUGWvSdQnXzG2b2p46K
         WpXF4oKqsMU1xnf1NTli3R+GQHf+JkeCMld8RSIG60b8rNWoUrOJLdHnTq3KsDlO5sCs
         WPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jtxNFsIbD5zn4RpbCZ/XdFrWVFJW2UCfw9i5Uatoj+Y=;
        b=uDkhLk5SuKrbpGdnPzRrZMwYKiAoHJBsNqAcGrDsBWK7M/T1fhgiu0s6nIxWov/bCI
         Sp8OoPfGSulNnRKIr8QyWKrQPzeUZKRr4H8PPe20/SGcXNmaLKpViCODG5N8m8bvvn8/
         V63a6Xg0KmNqfoJTw2a+YLtB/JEm7ebcj4l3Vz6pzAwR+qbQX8asCIgR1nawaqAv0IM+
         BJu6LQnoq+dIL2g3xOftS1IAlFj17RYps5Cw4hz7wHY/MmycNEDJdnDP6n/dbOg6SOKW
         4OfHsmUqqDrhvp2eXow4QtHcIcCgyn4pv7UK6i/Ucc5WcQkWgAycsa+/Kp9MFTUgVi5S
         K1Fg==
X-Gm-Message-State: ALKqPweJ/NAlVttlREvHSutgHvTELVwq9rGtTT5mqgxT77OoKnu4+v8K
        qt8qftr/kF8S6FQ+CpMk1EUt24iCaTE=
X-Google-Smtp-Source: AB8JxZoHF8OFvEPI8PBgQjrDDiKuvcB5jj90J17QQhQXxPGPuTh1Wa+pQq0udzuz0LM57AznXWiC3w==
X-Received: by 2002:adf:9cc2:: with SMTP id h2-v6mr12167881wre.11.1526811511204;
        Sun, 20 May 2018 03:18:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id t189-v6sm10210374wmf.22.2018.05.20.03.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 May 2018 03:18:30 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/4] merge-recursive: provide pair of `unpack_trees_{start,finish}()`
Date:   Sun, 20 May 2018 12:17:35 +0200
Message-Id: <e837222c8031e2186876a51559589fdb0022c8aa.1526810549.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.840.g5d83f92caf
In-Reply-To: <cover.1526810549.git.martin.agren@gmail.com>
References: <CAN0heSp7DqxOy-UeLgj8t_T_4f-fNthMpGNS8oUbcs7+NvS-zw@mail.gmail.com> <cover.1526810549.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Rename `git_merge_trees()` to `unpack_trees_start()` and extract the
call to `discard_index()` into a new function `unpack_trees_finish()`.
As a result, these are called early resp. late in `merge_trees()`,
making the resource handling clearer. A later commit will expand on
that, teaching `..._finish()` to free more memory. (So rather than
moving the FIXME-comment, just drop it, since it will be addressed soon
enough.)

Also call `..._finish()` when `merge_trees()` returns early.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 merge-recursive.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 680e01226b..ddb0fa7369 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -337,10 +337,10 @@ static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
 	init_tree_desc(desc, tree->buffer, tree->size);
 }
 
-static int git_merge_trees(struct merge_options *o,
-			   struct tree *common,
-			   struct tree *head,
-			   struct tree *merge)
+static int unpack_trees_start(struct merge_options *o,
+			      struct tree *common,
+			      struct tree *head,
+			      struct tree *merge)
 {
 	int rc;
 	struct tree_desc t[3];
@@ -379,6 +379,11 @@ static int git_merge_trees(struct merge_options *o,
 	return rc;
 }
 
+static void unpack_trees_finish(struct merge_options *o)
+{
+	discard_index(&o->orig_index);
+}
+
 struct tree *write_tree_from_memory(struct merge_options *o)
 {
 	struct tree *result = NULL;
@@ -3088,13 +3093,14 @@ int merge_trees(struct merge_options *o,
 		return 1;
 	}
 
-	code = git_merge_trees(o, common, head, merge);
+	code = unpack_trees_start(o, common, head, merge);
 
 	if (code != 0) {
 		if (show(o, 4) || o->call_depth)
 			err(o, _("merging of trees %s and %s failed"),
 			    oid_to_hex(&head->object.oid),
 			    oid_to_hex(&merge->object.oid));
+		unpack_trees_finish(o);
 		return -1;
 	}
 
@@ -3147,20 +3153,15 @@ int merge_trees(struct merge_options *o,
 
 		hashmap_free(&o->current_file_dir_set, 1);
 
-		if (clean < 0)
+		if (clean < 0) {
+			unpack_trees_finish(o);
 			return clean;
+		}
 	}
 	else
 		clean = 1;
 
-	/* Free the extra index left from git_merge_trees() */
-	/*
-	 * FIXME: Need to also free data allocated by
-	 * setup_unpack_trees_porcelain() tucked away in o->unpack_opts.msgs,
-	 * but the problem is that only half of it refers to dynamically
-	 * allocated data, while the other half points at static strings.
-	 */
-	discard_index(&o->orig_index);
+	unpack_trees_finish(o);
 
 	if (o->call_depth && !(*result = write_tree_from_memory(o)))
 		return -1;
-- 
2.17.0.840.g5d83f92caf

