Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CA0C433E1
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F389822B40
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 16:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA9J6wTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbgGaQwS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732474AbgGaQwR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 12:52:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8710DC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:52:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so28543488wrj.13
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 09:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nmk/a46wDPiuPdytJXRv0WBj/NMxzrSWV7Y0q1I+K3Q=;
        b=BA9J6wTCqymiAF3jFZfJdOsaOsHf0Cvp8EdZ5p7lQVezEKP31Chkz7IzVcpuM9Ta59
         ffr4QiQT06X9UebYct/5Xt6ArVI5enbLWMTyS0D1fZfNMbatdpDBn+moCjcIqzQjYRFO
         LEoEBWkKHqwb98EgjkE8ciLzuqgiYuM8ITCKZFoX9elQ+y7ajUR7Yk1Kp8srdAMsLGOb
         ElxlrIu2DJp2lqFgT/ametR98/5vgf1rY6trhY8odVtfXehZBdXGPLiiqGIjoUZurOI2
         XTXMhkaDtZ40fz/OSvlOTOjAN3pEeP0F1x+PYXMXQ/DVd0i+gNR3oMAEKjnG88v77BqN
         KH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nmk/a46wDPiuPdytJXRv0WBj/NMxzrSWV7Y0q1I+K3Q=;
        b=Attw6D0bUYD3Ho7e2av1yvIoe3Tfwjmc0EqYcm24BTOCZW2jweVPFq4LiM6sfszXsg
         YwKRD5avb2PjP2x0Vu6iriiGiqO7K2isZtRxnEwHAk5F57E9it3G/nRyts+NwsM9/RKW
         xRA13ueEHNBuiuWwic76Qk6LyDYU2WCNlVbhVYXiLTQ/9H36q4A55k0lC+X+PTKUOVBq
         qYzpThkCyFUtqO5p4hfcQbVGlstEJ2QQmkI9uPisM7MsFFoeaOVMxH4DBGguwvK9bv1W
         D6z603MTeexgEir13VqwUEsZrfeWf2/nPrQ15HlZaaHaqoF+MZswqc++m0QH0g5PMCA5
         RxlQ==
X-Gm-Message-State: AOAM531ps21+Upz1hD9rVh5gVgro8tS6MlJ3c0Y+1EglwGUu7lLj3aCL
        Hmx4p3E6GPK7PLu1Zfu0LLR+W9lb
X-Google-Smtp-Source: ABdhPJygSFIfvzVAPJVNjrkj3EUGD5SEXgPAK0/DBHYFMT9I0WzOWKytKNCb7qDCqNYljleYSaD+ww==
X-Received: by 2002:adf:df06:: with SMTP id y6mr4113292wrl.89.1596214335983;
        Fri, 31 Jul 2020 09:52:15 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-421-163.w2-6.abo.wanadoo.fr. [2.6.84.163])
        by smtp.googlemail.com with ESMTPSA id t14sm15169134wrg.38.2020.07.31.09.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:52:15 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3 5/6] stash: remove the second index in restore_untracked()
Date:   Fri, 31 Jul 2020 18:51:39 +0200
Message-Id: <20200731165140.29197-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200731165140.29197-1-alban.gruin@gmail.com>
References: <20200630151558.20975-1-alban.gruin@gmail.com>
 <20200731165140.29197-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes the second index used in restore_untracked().

The call to `read-tree' is replaced by reset_tree() with the appropriate
parameters (no update, no reset).  The environment of `checkout-index'
is no longer modified, and the cache is discarded when it exits.

In do_apply_stash(), the changes are a bit more involved: to avoid
conflicts with the merged index, restore_untracked() is moved after
merge_recursive_generic().

This introduces another problem: the files that were untracked once are
now added to the index, and update_index() would add back those files in
the index.  To avoid this, get_newly_staged() is moved before
restore_untracked().

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/stash.c | 47 +++++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index cbe37cd24b..d5077a27d9 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -359,29 +359,15 @@ static int restore_untracked(struct object_id *u_tree)
 	int res;
 	struct child_process cp = CHILD_PROCESS_INIT;
 
-	/*
-	 * We need to run restore files from a given index, but without
-	 * affecting the current index, so we use GIT_INDEX_FILE with
-	 * run_command to fork processes that will not interfere.
-	 */
-	cp.git_cmd = 1;
-	argv_array_push(&cp.args, "read-tree");
-	argv_array_push(&cp.args, oid_to_hex(u_tree));
-	argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
-	if (run_command(&cp)) {
-		remove_path(stash_index_path.buf);
+	if (reset_tree(u_tree, 0, 0))
 		return -1;
-	}
 
-	child_process_init(&cp);
 	cp.git_cmd = 1;
 	argv_array_pushl(&cp.args, "checkout-index", "--all", NULL);
-	argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
-			 stash_index_path.buf);
 
 	res = run_command(&cp);
-	remove_path(stash_index_path.buf);
+	discard_cache();
+
 	return res;
 }
 
@@ -395,6 +381,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	struct object_id index_tree;
 	struct commit *result;
 	const struct object_id *bases[1];
+	struct strbuf newly_staged = STRBUF_INIT;
 
 	read_cache_preload(NULL);
 	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
@@ -433,9 +420,6 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		}
 	}
 
-	if (info->has_u && restore_untracked(&info->u_tree))
-		return error(_("could not restore untracked files from stash"));
-
 	init_merge_options(&o, the_repository);
 
 	o.branch1 = "Updated upstream";
@@ -463,24 +447,27 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		return ret;
 	}
 
+	if (!has_index && get_newly_staged(&newly_staged, &c_tree)) {
+		strbuf_release(&newly_staged);
+		return -1;
+	}
+
+	if (info->has_u && restore_untracked(&info->u_tree)) {
+		strbuf_release(&newly_staged);
+		return error(_("could not restore untracked files from stash"));
+	}
+
 	if (has_index) {
 		if (reset_tree(&index_tree, 0, 0))
 			return -1;
 	} else {
-		struct strbuf out = STRBUF_INIT;
-
-		if (get_newly_staged(&out, &c_tree)) {
-			strbuf_release(&out);
-			return -1;
-		}
-
 		if (reset_tree(&c_tree, 0, 1)) {
-			strbuf_release(&out);
+			strbuf_release(&newly_staged);
 			return -1;
 		}
 
-		ret = update_index(&out);
-		strbuf_release(&out);
+		ret = update_index(&newly_staged);
+		strbuf_release(&newly_staged);
 		if (ret)
 			return -1;
 
-- 
2.20.1

