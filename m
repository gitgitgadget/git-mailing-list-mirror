Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4147FC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbiGMNKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiGMNKr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:10:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FBCC1B
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:10:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o4so15460249wrh.3
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gDN1UsTXBbc6niWwK2JHAx1ZOGrJxR72L51pB+BYc+4=;
        b=c4hIi0Ap1QVqJR0NPDao/HqTRVtUxCzZzxHhUrpOjnyu/T0Ie0FoCF0oC+c7DiJojm
         tYCwPnpVK9HTGFpizu7H4Gop7NAtS3w2Q0E3nPO0o4L4+CqXYZVUIsIrjFZrHMWZOPvn
         ZVb5UKtD6P0mw2pT54kVEhHteUJvVFYhPGcJbFEIKV4gIHs6K5O8Uiayxnco5TJOD/Ai
         xSBdM4qHBxezAifyeHxif/YF3HfNGMhf4+rNe/QZlN/uLbVQuPHjQl7dQFp8BXsDwZ/a
         Rw+j1jKn4ILZtyjLHYq/BhfWy/u+Zd7EdxvOmrTrrmj0ikuVSyn+knIZKFtyGSaOMqGU
         8zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDN1UsTXBbc6niWwK2JHAx1ZOGrJxR72L51pB+BYc+4=;
        b=61cv2PuB2gwlTM4xtQyp4o1fEagDwfv2SyvjjSPZo1I8aYJAIqYhlxO+EbUjhNEITZ
         1wmCxv3QWwQ2sv+GNbX+JM6tjaqQQf2MeV6f9GPUMvq0a/mMGqlmXLORQHF6tbhzVSHp
         JPhGRerJ8MAkuzOs8GoQz+wx96XGYAQ3FrLLT049/D0VIAHogRW15h0MN9iuF6c1h+mC
         7fz8skM4aLu402L0wzBOkJTsnJIzqzSQS/tu7kBt7DCZQIPltOKRcs1rU0JeAtUlK4BC
         lxv4XI1Ut6jnyjMagqQbehzfENDEC2yEHKag+WXFc/6/4Jq3SpLbrzV7+uua/UhVhx4g
         boEA==
X-Gm-Message-State: AJIora9eL11xcxYcdrla02r2gRhJCNK0g+kk4mmV5MgvJULp3hkVkhFo
        icGfgXKCVO/xNPSUf4cMqvTU32OO5t8HKw==
X-Google-Smtp-Source: AGRyM1v4fu3/VhIZCgwb+n2EySn8DJHT78m4DxxoUpF70N20Y6CnQQsEz0NZ+Zkt4bvdqdU2ykJSKw==
X-Received: by 2002:a5d:66c1:0:b0:21d:6c98:7aa4 with SMTP id k1-20020a5d66c1000000b0021d6c987aa4mr3173906wrw.136.1657717843913;
        Wed, 13 Jul 2022 06:10:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d15-20020a05600c34cf00b0039c4d022a44sm2183653wmq.1.2022.07.13.06.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:10:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] log: make the intent of cmd_show()'s "rev.pending" juggling clearer
Date:   Wed, 13 Jul 2022 15:10:32 +0200
Message-Id: <patch-3.6-7f3bf3f0e40-20220713T130511Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust code added in 5d7eeee2ac6 (git-show: grok blobs, trees and
tags, too, 2006-12-14) to use the "memcpy a &blank" idiom introduced
in 5726a6b4012 (*.c *_init(): define in terms of corresponding *_INIT
macro, 2021-07-01).

Now the types in play are guaranteed to correspond, i.e. we used "int"
here for the "count" before, but the corresponding "nr" is an
"unsigned int". By using a "blank" object we almost entirely bypass
that, we'll only need to declare our own "unsigned int i".

There are no functional changes here aside from potential overflow
guard rails, the structure only has these three members ("nr", "alloc"
and "objects"), but now we're obviously future-proof against assuming
that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/log.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 88a5e98875a..e0f40798d45 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -668,10 +668,12 @@ static void show_setup_revisions_tweak(struct rev_info *rev,
 int cmd_show(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
-	struct object_array_entry *objects;
+	struct object_array blank = OBJECT_ARRAY_INIT;
+	struct object_array cp = OBJECT_ARRAY_INIT;
+	unsigned int i;
 	struct setup_revision_opt opt;
 	struct pathspec match_all;
-	int i, count, ret = 0;
+	int ret = 0;
 
 	init_log_defaults();
 	git_config(git_log_config, NULL);
@@ -698,12 +700,11 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	if (!rev.no_walk)
 		return cmd_log_deinit(cmd_log_walk(&rev), &rev);
 
-	count = rev.pending.nr;
-	objects = rev.pending.objects;
+	memcpy(&cp, &rev.pending, sizeof(rev.pending));
 	rev.diffopt.no_free = 1;
-	for (i = 0; i < count && !ret; i++) {
-		struct object *o = objects[i].item;
-		const char *name = objects[i].name;
+	for (i = 0; i < cp.nr && !ret; i++) {
+		struct object *o = cp.objects[i].item;
+		const char *name = cp.objects[i].name;
 		switch (o->type) {
 		case OBJ_BLOB:
 			ret = show_blob_object(&o->oid, &rev, name);
@@ -726,7 +727,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			if (!o)
 				ret = error(_("could not read object %s"),
 					    oid_to_hex(oid));
-			objects[i].item = o;
+			cp.objects[i].item = o;
 			i--;
 			break;
 		}
@@ -743,8 +744,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			rev.shown_one = 1;
 			break;
 		case OBJ_COMMIT:
-			rev.pending.nr = rev.pending.alloc = 0;
-			rev.pending.objects = NULL;
+			memcpy(&rev.pending, &blank, sizeof(rev.pending));
 			add_object_array(o, name, &rev.pending);
 			ret = cmd_log_walk_no_free(&rev);
 			break;
-- 
2.37.0.932.g7b7031e73bc

