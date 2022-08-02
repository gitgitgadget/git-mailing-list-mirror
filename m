Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C97C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiHBPds (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHBPd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:33:29 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24430B7EF
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:33:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l4so18373754wrm.13
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vRKFSWx66jGvweskqoE6j5/KE9aG6a2HzZ9aoqrNIj4=;
        b=pl8yLNkc/+QXUyjOyoTL6jO6k1zex+6CPjtmXH7lKZnS/IkFd7t7muXMadvuMoUqgT
         YUhCawa47xTSKBKd6llm1tlHjJsfeUEHhvvoE6EHkCS5JhAM472XsLkmUNC+T64wOt/W
         EMBN2zEiE9GRWswk4OODtWJ7z8Y41nWl3f4Io/vAiFVUBvYswCi3YVn+eUtILXfVWWnu
         /X8C0dFpGESj/NDGcnEvj+0qpVDFa2fjSFZbJvwzRAKpmuol5mRwGio8raepMgOnU2CN
         6dXWsVvp8aU3XQph2irsdMC9zpDyfQwo83H/9FIX72+0zuVepQqP46w9t7fm5nHpSr5+
         kYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vRKFSWx66jGvweskqoE6j5/KE9aG6a2HzZ9aoqrNIj4=;
        b=aT2eL5BtSuKR1sSsjKqUYM00QAL5Z2b7KO0KryJc2AwHcvErAL9et2C8cqymFNKtJA
         s2am2hl6PdrmBW8G/8R63hSDnogG7vyP4qQLC0k+lahta+AO8jahDacvBW7Vzv/zdEbE
         /W2Iz58edqWlqRyRLSejysOt23NVNE9u5ruaqJ33G6my3zULw2dGBRGhewkvXU6oRYNM
         dJETnTkFfjWAc3/VrEa+G2QELcWD4olkMGUqg9hlCW2YzLOAQw0SexaMlL4MyDTylRIc
         bqO/YajgEnGHS5G3SABiJg/Y45nciX1AK52/27YPrU6gaztvbGDKMtD6aBL2X4G1CSL0
         ubRw==
X-Gm-Message-State: ACgBeo0MTFSismbjjLwWeH37SGuXb6/1YWOBO7CyzHfonqZlOGqpwT4x
        h1UnmXYVX7bP189kYQbXIxER3x/4/68xyA==
X-Google-Smtp-Source: AA6agR5jddtVE5WPY9mkRrHWT8046uhuFcRWnrOgq52n50L9ax8T9O3+AjeJNOsuELM8BvCYz4TNtA==
X-Received: by 2002:a5d:66d1:0:b0:21f:410:74f4 with SMTP id k17-20020a5d66d1000000b0021f041074f4mr14302173wrw.710.1659454406202;
        Tue, 02 Aug 2022 08:33:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y7-20020adffa47000000b0021e9396b135sm15332531wrr.37.2022.08.02.08.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:33:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/6] log: refactor "rev.pending" code in cmd_show()
Date:   Tue,  2 Aug 2022 17:33:14 +0200
Message-Id: <patch-v3-4.6-fd474666e7c-20220802T152925Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the juggling of "rev.pending" and our replacement for it
amended in the preceding commit so that:

 * We use an "unsigned int" instead of an "int" for "i", this matches
   the types of "struct rev_info" itself.

 * We don't need the "count" and "objects" variables introduced in
   5d7eeee2ac6 (git-show: grok blobs, trees and tags, too, 2006-12-14).

   They were originally added since we'd clobber rev.pending in the
   loop without restoring it. Since the preceding commit we are
   restoring it when we handle OBJ_COMMIT, so the main for-loop can
   refer to "rev.pending" didrectly.

 * We use the "memcpy a &blank" idiom introduced in
   5726a6b4012 (*.c *_init(): define in terms of corresponding *_INIT
   macro, 2021-07-01).

   This is more obvious than relying on us enumerating all of the
   relevant members of the "struct object_array" that we need to
   clear.

 * We comment on why we don't need an object_array_clear() here, see
   the analysis in [1].

1. https://lore.kernel.org/git/YuQtJ2DxNKX%2Fy70N@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Jeff King <peff@peff.net>
---
 builtin/log.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index b4b1d974617..9b937d59b83 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -668,10 +668,10 @@ static void show_setup_revisions_tweak(struct rev_info *rev,
 int cmd_show(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
-	struct object_array_entry *objects;
+	unsigned int i;
 	struct setup_revision_opt opt;
 	struct pathspec match_all;
-	int i, count, ret = 0;
+	int ret = 0;
 
 	init_log_defaults();
 	git_config(git_log_config, NULL);
@@ -698,12 +698,10 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	if (!rev.no_walk)
 		return cmd_log_deinit(cmd_log_walk(&rev), &rev);
 
-	count = rev.pending.nr;
-	objects = rev.pending.objects;
 	rev.diffopt.no_free = 1;
-	for (i = 0; i < count && !ret; i++) {
-		struct object *o = objects[i].item;
-		const char *name = objects[i].name;
+	for (i = 0; i < rev.pending.nr && !ret; i++) {
+		struct object *o = rev.pending.objects[i].item;
+		const char *name = rev.pending.objects[i].name;
 		switch (o->type) {
 		case OBJ_BLOB:
 			ret = show_blob_object(&o->oid, &rev, name);
@@ -726,7 +724,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			if (!o)
 				ret = error(_("could not read object %s"),
 					    oid_to_hex(oid));
-			objects[i].item = o;
+			rev.pending.objects[i].item = o;
 			i--;
 			break;
 		}
@@ -745,12 +743,19 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		case OBJ_COMMIT:
 		{
 			struct object_array old;
+			struct object_array blank = OBJECT_ARRAY_INIT;
 
 			memcpy(&old, &rev.pending, sizeof(old));
-			rev.pending.nr = rev.pending.alloc = 0;
-			rev.pending.objects = NULL;
+			memcpy(&rev.pending, &blank, sizeof(rev.pending));
+
 			add_object_array(o, name, &rev.pending);
 			ret = cmd_log_walk_no_free(&rev);
+
+			/*
+			 * No need for
+			 * object_array_clear(&pending). It was
+			 * cleared already in prepare_revision_walk()
+			 */
 			memcpy(&rev.pending, &old, sizeof(rev.pending));
 			break;
 		}
-- 
2.37.1.1233.ge8b09efaedc

