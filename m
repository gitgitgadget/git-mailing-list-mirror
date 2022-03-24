Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5EAC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 04:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345792AbiCXFAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 01:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343621AbiCXFAE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 01:00:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32113286D0
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so6530930wmb.4
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ND2tpn5Fmoo/wXsuMPeg96graaVqxq9HHzoClph6jpc=;
        b=pZS+ysJ2lxJWermu3BqhWniks3navL4V6ZUsqQ+iRnRC/W+8Vpa9zNTS/XCn3i4q/r
         QQ1Ug46PEYPIDChdHKPznaqR24jII5M3ZQd41qm5E4c8j55+fuUjGB7nRRXm1XQJKXRz
         +YNrYqwx409MbK53ABB0GJ1yq7nty3z7+UOWD9k1TDInklP0P48q4jOYgwByGJN01oBI
         TW3OiYER6diCdf4MO1iPg1apiyBZ19Zf93Ay/LsaqvVD3piefg8TXexIuxybJfxErfXK
         qd9He4+DFxUd/fb0HR2Ma1a3JbLKefr0wXBNAu6jgMsHBkTooSs/VZTKWlRLVlNlNoX3
         K06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ND2tpn5Fmoo/wXsuMPeg96graaVqxq9HHzoClph6jpc=;
        b=L2lO1o8JZTe0ohmi/Rd9FsQPliaIK5w0xR/GK+t7NWtwKvW6d+GKjjwoImNzZpN6C3
         G0AEwHzT6ZgXh7XdBtPi5bFHQvYygP1dS7bw1Xxt9hWAqGgMlXEdXQwoNo1V6SKMuR8s
         rCzr9r3/KS9GWywM9001K2jZXF3PUOZHL6kL4M8pYbvoh9yQ56kwwIBRLqVm6bUi6+t6
         s8jJCQLHM5nXIHSBH3bTqCr7KJZvFQLPXlnVJwFNOMJQcpbFdqWCZtVWienWVhKgotkM
         8QrXp16MbuaVQ/jHnuSPscem8WTt2ET/ubDvuY3siFGVIQfIvUx6OZMqDuZ7RZOLsyFu
         UvBg==
X-Gm-Message-State: AOAM530XLz1OvtTVbObJIHtjtMnp8D9EnIHmLlDIwZQh25cfIT76Ut5M
        9QnIdbuALRL2koEXNLnUC9KWVh/L1Xg=
X-Google-Smtp-Source: ABdhPJzwzBixEjJMreuSFwYPbOqEL7yYaG7YS7rF55IUwBk2jkCYDQ4DSlB+l1y2Ix4dIaUWQxf3SA==
X-Received: by 2002:a7b:c541:0:b0:38c:b0ed:31c4 with SMTP id j1-20020a7bc541000000b0038cb0ed31c4mr12563845wmk.141.1648097910555;
        Wed, 23 Mar 2022 21:58:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15-20020a056000168f00b002057a9f9f5csm1776985wrd.31.2022.03.23.21.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 21:58:29 -0700 (PDT)
Message-Id: <53261f0099d53524155464fe79d10f9605fe93aa.1648097906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
        <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 04:58:16 +0000
Subject: [PATCH v3 01/11] bulk-checkin: rebrand plug/unplug APIs as 'odb
 transactions'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Make it clearer in the naming and documentation of the plug_bulk_checkin
and unplug_bulk_checkin APIs that they can be thought of as
a "transaction" to optimize operations on the object database.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/add.c  |  4 ++--
 bulk-checkin.c |  4 ++--
 bulk-checkin.h | 14 ++++++++++++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 3ffb86a4338..9bf37ceae8e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -670,7 +670,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		string_list_clear(&only_match_skip_worktree, 0);
 	}
 
-	plug_bulk_checkin();
+	begin_odb_transaction();
 
 	if (add_renormalize)
 		exit_status |= renormalize_tracked_files(&pathspec, flags);
@@ -682,7 +682,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (chmod_arg && pathspec.nr)
 		exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only);
-	unplug_bulk_checkin();
+	end_odb_transaction();
 
 finish:
 	if (write_locked_index(&the_index, &lock_file,
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6d6c37171c9..a16ae3c629d 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -285,12 +285,12 @@ int index_bulk_checkin(struct object_id *oid,
 	return status;
 }
 
-void plug_bulk_checkin(void)
+void begin_odb_transaction(void)
 {
 	state.plugged = 1;
 }
 
-void unplug_bulk_checkin(void)
+void end_odb_transaction(void)
 {
 	state.plugged = 0;
 	if (state.f)
diff --git a/bulk-checkin.h b/bulk-checkin.h
index b26f3dc3b74..69a94422ac7 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -10,7 +10,17 @@ int index_bulk_checkin(struct object_id *oid,
 		       int fd, size_t size, enum object_type type,
 		       const char *path, unsigned flags);
 
-void plug_bulk_checkin(void);
-void unplug_bulk_checkin(void);
+/*
+ * Tell the object database to optimize for adding
+ * multiple objects. end_odb_transaction must be called
+ * to make new objects visible.
+ */
+void begin_odb_transaction(void);
+
+/*
+ * Tell the object database to make any objects from the
+ * current transaction visible.
+ */
+void end_odb_transaction(void);
 
 #endif
-- 
gitgitgadget

