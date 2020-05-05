Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B1DC47259
	for <git@archiver.kernel.org>; Tue,  5 May 2020 10:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42900206A5
	for <git@archiver.kernel.org>; Tue,  5 May 2020 10:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7cteGlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgEEKxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 06:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728726AbgEEKxh (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 06:53:37 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0808DC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 03:53:37 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u16so1794746wmc.5
        for <git@vger.kernel.org>; Tue, 05 May 2020 03:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RH8qv6j34E5vdC+HweW68ColNcj5rnJOIlhX4BQ62P4=;
        b=a7cteGlWj2LF5ru3vJPxM6rQibBw87iw96Ve2Zx7OJJbTUmEmvYMtLiJx28xv5ChtU
         Hvkj1hrfyHqJsKW5b8QoX5XGkL9+3WPpr3nJAg5FnKg4o1sd+tM0+EijZVUbFcOFchCq
         MTlZ8swlGKV3LKSks0CSpiz4JLDgdxh/dktiB33YYwVBjtyE0n7kr5CdKJMiloTT+6jK
         FW8DHOQ3JoNw+tX0A1P62XK+roD0+fnvMC0Sjv3Q8YTuSjGkXi8tD/FbOtFdzhyCjmZU
         PhPj7kRqFCALaKcetCI3iq8CgDGrZGhc6QIMLrFZrNh3LQu2k82O599fQ4stcczrcang
         g6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RH8qv6j34E5vdC+HweW68ColNcj5rnJOIlhX4BQ62P4=;
        b=h9NHC6jEaqCLECmBmltBlxr9dDwLhtuAink+D9o6kHV8ti7a9XGaZ7rHoOhFg7dDBc
         Z6x9leWnUXesqUeQT4mob34awjUMNIAq5k8IZIugn5Azl1fIz/DIJ8LxcvfCFg4n9Od9
         DztRS2iTKuj69tgC/cy35lYBALw4ZLdbJoDvHp56BKUalk8SghFnI9zvKjIqXzF3+hzJ
         kbQ1veR40BSwQfkRf7HvY7erZwWj2aOKoyKrUNLe4oxBO+EQhy7GiAfh+KKnBdo36wje
         zM4kBuF14eFb3SZx7agR8W9YugfauOaEYgSGpZNfy4wNz1xArafxHvoGbUJ4jp4utTGk
         QMYA==
X-Gm-Message-State: AGi0PuZlvXiY6LPb+z7uGQyARM99ge+HQ3Tw6NxkemQ+HJcb1b2cn/Cz
        +MmoW0EswClHK38EGa5cMopoIvdY
X-Google-Smtp-Source: APiQypJN4bB8+pH0cr0RJNebPSSv6eommwCHMMgCGRKTlrecnDIv4tRZc+VWjkEd+aLCiqRHoaeVAA==
X-Received: by 2002:a1c:9d8c:: with SMTP id g134mr2917676wme.79.1588676015513;
        Tue, 05 May 2020 03:53:35 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-654-1-289-61.w86-199.abo.wanadoo.fr. [86.199.72.61])
        by smtp.googlemail.com with ESMTPSA id b85sm3170326wmb.21.2020.05.05.03.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 03:53:35 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 5/6] stash: remove the second index in restore_untracked()
Date:   Tue,  5 May 2020 12:48:48 +0200
Message-Id: <20200505104849.13602-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505104849.13602-1-alban.gruin@gmail.com>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
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
 builtin/stash.c | 46 +++++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index cbe37cd24b..1eafc1fe8d 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -359,29 +359,16 @@ static int restore_untracked(struct object_id *u_tree)
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
 
 	child_process_init(&cp);
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
 
@@ -395,6 +382,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	struct object_id index_tree;
 	struct commit *result;
 	const struct object_id *bases[1];
+	struct strbuf newly_staged = STRBUF_INIT;
 
 	read_cache_preload(NULL);
 	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
@@ -433,9 +421,6 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		}
 	}
 
-	if (info->has_u && restore_untracked(&info->u_tree))
-		return error(_("could not restore untracked files from stash"));
-
 	init_merge_options(&o, the_repository);
 
 	o.branch1 = "Updated upstream";
@@ -463,24 +448,27 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
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
2.26.2

