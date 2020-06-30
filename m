Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1261C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8832220724
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvoOuHD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389353AbgF3PQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389334AbgF3PQd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:16:33 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167A5C03E979
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:16:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so17584980wrw.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzOgrjbRcUsF4xE9T76sH+yvBACK3WAB8A0dLrjlbU4=;
        b=DvoOuHD/C/ugXQFWw0dDcT3S9AI1puqdFdHtiYPCJkpXZ5ElL5hk5AC9LRZqc/qN3v
         zf50M95F5v4BYKc/gx2w4Yq4An+wSR4c4WPg49U4K2bSMprnEDjP8vnVZK54yaCKZU/6
         4lF64Re3IzdIyPvEmzvPUAkLeGFBt5p0VoG92Ybsa2YgYoXSoi74yZBm8GVpAfgSPs4A
         bjYyp4atS1Lqs3qVRKxtLWbfhRA31oL25fUqNAV0Rdsowt1N/x2i1vCRbZqmMCcGqrS9
         Z9MvUkXEX8Q2kAyMRXyZOndGqEhrqJe5AQLCY2SKxsC/uo2GACYeY21HnZb2XSzhrewC
         +//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzOgrjbRcUsF4xE9T76sH+yvBACK3WAB8A0dLrjlbU4=;
        b=Ts/Jn0PQp891XwJRkNeoShGiQLJBr2Qye1+z6l44h81PkPmRQ4bB3hXHIZ0xZgJRPN
         NTLh5vbpeIyTM3vqUfVK2UCGvzzy1VIumkYz9PS+JcBtXIdPqxB5SCKlqdSJU1LU1uqp
         6kLOpDG6z1EIdA4kwl7t4//t2QaRh6KGE87KFEUop6YY9QG+3SW65KlvL91OOiFWrZMu
         5O3LJB0Jj1ypH6BMlzAWkTDeypQrAr6kdXW9PN89h9U9bD3b7rTr950tdBjJh7J5up1w
         dI1lblVK4EbLH29gMVMDGqVkMZ4dUuUP2y26F4ybzifSSWUcePYUf2LmmDdPtXjL5qWd
         ru1w==
X-Gm-Message-State: AOAM530+J55eR8aWIk4LCdpOyEBjLaLq+KgGHO5/ZGHAHGrEQAoccMGo
        AIQ/hSDxSa5WuepshmIyyzIEd3ey
X-Google-Smtp-Source: ABdhPJx7oUGDjeJ0f7rR7eXalYNd3qLO8WuCLxG+0mWjyiCQheFJ/L64StVWowYG68jiL4mGdEZxzg==
X-Received: by 2002:a5d:6452:: with SMTP id d18mr22038146wrw.284.1593530190996;
        Tue, 30 Jun 2020 08:16:30 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-323-12.w86-199.abo.wanadoo.fr. [86.199.210.12])
        by smtp.googlemail.com with ESMTPSA id 63sm4263911wra.86.2020.06.30.08.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:16:30 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 5/6] stash: remove the second index in restore_untracked()
Date:   Tue, 30 Jun 2020 17:15:57 +0200
Message-Id: <20200630151558.20975-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630151558.20975-1-alban.gruin@gmail.com>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
 <20200630151558.20975-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes the second index used in restore_untracked().

The call to `read-tree' is replaced by reset_tree() with the appropriate
parameters (no update, no reset).  The environment of `checkout-index'
is no longer modified, and the cache is discarded when it exists.

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

