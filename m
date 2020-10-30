Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3C0C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC9C2098B
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4UYHYyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgJ3Dmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgJ3Dmf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:35 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6830DC0613DF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:58 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m26so4422072otk.11
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KF594PqkhmRWa/EpXPObNxlZdQnyFkhPVXCNbZ3jA4Q=;
        b=c4UYHYyHrSHFm/2bcEEfpckTmeniKzhBwJWRPYT9f3+oV9ERQHq9QW9GgjnO1AZH7X
         +FzUReLEsCYrulEk4V77Xh26cutSEDMLPb5O8qQQQeXXrW+56vkUsdteuiNg3dE5dWrg
         o07eiKYc2VpUrqyuaubOpS8qcERqXfYjefNKDTRIpPkorOSK+xuYHhdgBAPYsbDAJl54
         i07MTNTr7Vi0x3HJNc7kmUVzu2aIwj6QOqebc8I09Olum6KDVvO7A/pcqTnAeHQrQVCy
         RuF/OJk2RXFrL/NpC5ktVNIPIBuUgTcfZ2W7qRoAFXy/L5qWIQNGR90QeC4/chehHyZz
         ay4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KF594PqkhmRWa/EpXPObNxlZdQnyFkhPVXCNbZ3jA4Q=;
        b=OwQ1HjWeMWWW9awQFFWI2gMV996h8+eM2g6DRuW/e+qctZRz4az2ZLD+CO0V5tlGe2
         VH05t9BZUzR1fI4bw4NfP8qeDVd/8/Ld7FEFjqa3F5wMdCSxuJJ8/W8x2gSqhAzKh2u+
         qcoaiimthSE23ZBEEo6ojCXB5Hy/tIG5mHelou+QpMoYL7mHiXkBJfBQzFyjjQLG1pRz
         7yPIzrKwVHxTqMHBVkew9ISP76qBYZk7e7YMSRthrnM6Qe9HlJVrrNHinBPHmizAIAUB
         Ss1dzg967yifhT4THore6NCi2AKOSm90chMpdEW5Lf9a+N2XskooJiLMG5CS/5HTTm+P
         Y+Aw==
X-Gm-Message-State: AOAM531NLaTIKB7eZlieBj8kSISNzmwR3mZrytKxZFtoEZnjYid7Y1fr
        sO+XWijq2obmZjKtoP2qUQCgW100ZtDo3g==
X-Google-Smtp-Source: ABdhPJzVab6h8zLm2vZT538cJnsuKO3klhZAezJ8U6LpEeJ7py56TYS6/kdnrj1ncsvIfNB6l5njzA==
X-Received: by 2002:a9d:828:: with SMTP id 37mr169691oty.147.1604029317644;
        Thu, 29 Oct 2020 20:41:57 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:41:57 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 14/20] merge-ort: step 2 of tree writing -- function to create tree object
Date:   Thu, 29 Oct 2020 20:41:25 -0700
Message-Id: <20201030034131.1479968-15-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new function, write_tree(), which will take a list of
basenames, modes, and oids for a single directory and create a tree
object in the object-store.  We do not yet have just basenames, modes,
and oids for just a single directory (we have a mixture of entries from
all directory levels in the hierarchy) so we still die() before the
current call to write_tree(), but the next patch will rectify that.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 17159df5db..ad34800705 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -19,6 +19,7 @@
 
 #include "diff.h"
 #include "diffcore.h"
+#include "object-store.h"
 #include "strmap.h"
 #include "tree.h"
 #include "xdiff-interface.h"
@@ -355,6 +356,50 @@ struct directory_versions {
 	struct string_list versions;
 };
 
+static void write_tree(struct object_id *result_oid,
+		       struct string_list *versions,
+		       unsigned int offset)
+{
+	size_t maxlen = 0;
+	unsigned int nr = versions->nr - offset;
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list relevant_entries = STRING_LIST_INIT_NODUP;
+	int i;
+
+	/*
+	 * We want to sort the last (versions->nr-offset) entries in versions.
+	 * Do so by abusing the string_list API a bit: make another string_list
+	 * that contains just those entries and then sort them.
+	 *
+	 * We won't use relevant_entries again and will let it just pop off the
+	 * stack, so there won't be allocation worries or anything.
+	 */
+	relevant_entries.items = versions->items + offset;
+	relevant_entries.nr = versions->nr - offset;
+	string_list_sort(&relevant_entries);
+
+	/* Pre-allocate some space in buf */
+	for (i = 0; i < nr; i++) {
+		maxlen += strlen(versions->items[offset+i].string) + 34;
+	}
+	strbuf_reset(&buf);
+	strbuf_grow(&buf, maxlen);
+
+	/* Write each entry out to buf */
+	for (i = 0; i < nr; i++) {
+		struct merged_info *mi = versions->items[offset+i].util;
+		struct version_info *ri = &mi->result;
+		strbuf_addf(&buf, "%o %s%c",
+			    ri->mode,
+			    versions->items[offset+i].string, '\0');
+		strbuf_add(&buf, ri->oid.hash, the_hash_algo->rawsz);
+	}
+
+	/* Write this object file out, and record in result_oid */
+	write_object_file(buf.buf, buf.len, tree_type, result_oid);
+	strbuf_release(&buf);
+}
+
 static void record_entry_for_tree(struct directory_versions *dir_metadata,
 				  const char *path,
 				  struct conflict_info *ci)
@@ -503,9 +548,16 @@ static void process_entries(struct merge_options *opt,
 			process_entry(opt, path, ci, &dir_metadata);
 	}
 
+	/*
+	 * TODO: We can't actually write a tree yet, because dir_metadata just
+	 * contains all basenames of all files throughout the tree with their
+	 * mode and hash.  Not only is that a nonsensical tree, it will have
+	 * lots of duplicates for paths such as "Makefile" or ".gitignore".
+	 */
+	die("Not yet implemented; need to process subtrees separately");
+	write_tree(result_oid, &dir_metadata.versions, 0);
 	string_list_clear(&plist, 0);
 	string_list_clear(&dir_metadata.versions, 0);
-	die("Tree creation not yet implemented");
 }
 
 void merge_switch_to_result(struct merge_options *opt,
-- 
2.29.1.56.ga287c268e6.dirty

