Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405BCC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 10:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiBXKJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiBXKJg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 05:09:36 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C855228A13B
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:09:02 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id b5-20020a170902e94500b0014f6d0a417bso845342pll.6
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bqdqXeJL9WT1k5g0viCfj7gJvexmtha42dMO/axoffw=;
        b=Cfp07IxMlWXApZOHJ8chcZo/7veCBBbAslqyaQYHJ9x4tPh7fP2fwp8aBMdJPb7hfo
         w7Etko0YSAM8berrTQuk1Z+oUWW0TkQ62bdO4+H1xyyXdS5JESTaFCkz7qCQeNjJ3o/o
         aoN37vu2zb0sAAabjLKIg2XeOuAwB9irg3Stzfz2TRxMgR3q+vcho23D+xkWH3vOTMqx
         aF8TEqoMtpZ/FzYgpMb1D6L9KryImI0T9fWiH1aRV88DEHSRxdD7WV2gXq3Qa27U9pR5
         D92cyC+uhPDeGqiUbXLnVHRZrUuBd1bU5OGNRoFhqofnJc09Cxx6kzgO9VVmn5hhDH6l
         oUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bqdqXeJL9WT1k5g0viCfj7gJvexmtha42dMO/axoffw=;
        b=jPH00hGkMEicvI/XfEyqZiJ8JtoBGQoQFLv4CdsNGtGlhOmBGvIKzSoYXf9QqhB221
         usMBCbtjx26eo7cr0jSD4O0MUegLa/9O6+4A2P0Vp5U7w/r/QqyM9Ohg96N/OMRPyV8K
         14cdX0SrO3Ryr5yIdIeMCeZePdjFv5lbZqrGDx/Vc8HmDRxiOCJqT7MibjnOSIsivrm1
         OarIyUY+MvIl22f1IJaUUYRtX373vOGEs6ToP8m0gldCBnLcyiCrIFVFqLAqhEsY5Tyi
         WxyPH/KgHKb3Vz506raOYlwtnnDQSmXXgXmvvQj1FFJB3d3uz15g0/riH931T3dy2PA5
         Njlg==
X-Gm-Message-State: AOAM533D5iEjbSBJP9sBaXI9n8FNURUC2joSJl4vklgHjEfZcrKEe6TA
        N2QgLNzto9GxFzAz4rv9OeVEoXw+E50r3bX02agkxvz4q96hbElD43P3gkHNnhi4XvJMfJ+mn50
        QPfa4DkttxIhqMLlep/1zzxY3PCyD1nxD0K0PupsLHzc2Vc2OYmj+LkUmvPWUuJY=
X-Google-Smtp-Source: ABdhPJzU8+e5IvqjaLgXPA2uoR2esfMu/upVx6wi5mCKWGXA7p2hEfzLTHP7KQ6Jh8KndFC45mooP4OpiaCuBw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1d8b:b0:4f1:bd8:811 with SMTP id
 z11-20020a056a001d8b00b004f10bd80811mr2080270pfw.25.1645697342198; Thu, 24
 Feb 2022 02:09:02 -0800 (PST)
Date:   Thu, 24 Feb 2022 18:08:37 +0800
In-Reply-To: <20220224100842.95827-1-chooglen@google.com>
Message-Id: <20220224100842.95827-6-chooglen@google.com>
Mime-Version: 1.0
References: <20220215172318.73533-1-chooglen@google.com> <20220224100842.95827-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3 05/10] submodule: inline submodule_commits() into caller
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When collecting the string_list of changed submodule names, the new
submodules commits are stored in the string_list_item.util as an
oid_array. A subsequent commit will replace the oid_array with a struct
that has more information.

Prepare for this change by inlining submodule_commits() (which inserts
into the string_list and initializes the string_list_item.util) into its
only caller so that the code is easier to refactor later.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 submodule.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/submodule.c b/submodule.c
index 4f3300f2cb..3bc189cf05 100644
--- a/submodule.c
+++ b/submodule.c
@@ -782,19 +782,6 @@ const struct submodule *submodule_from_ce(const struct cache_entry *ce)
 	return submodule_from_path(the_repository, null_oid(), ce->name);
 }
 
-static struct oid_array *submodule_commits(struct string_list *submodules,
-					   const char *name)
-{
-	struct string_list_item *item;
-
-	item = string_list_insert(submodules, name);
-	if (item->util)
-		return (struct oid_array *) item->util;
-
-	/* NEEDSWORK: should we have oid_array_init()? */
-	item->util = xcalloc(1, sizeof(struct oid_array));
-	return (struct oid_array *) item->util;
-}
 
 struct collect_changed_submodules_cb_data {
 	struct repository *repo;
@@ -830,9 +817,9 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
-		struct oid_array *commits;
 		const struct submodule *submodule;
 		const char *name;
+		struct string_list_item *item;
 
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
@@ -859,8 +846,11 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 		if (!name)
 			continue;
 
-		commits = submodule_commits(changed, name);
-		oid_array_append(commits, &p->two->oid);
+		item = string_list_insert(changed, name);
+		if (!item->util)
+			/* NEEDSWORK: should we have oid_array_init()? */
+			item->util = xcalloc(1, sizeof(struct oid_array));
+		oid_array_append(item->util, &p->two->oid);
 	}
 }
 
-- 
2.33.GIT

