Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B14931FF7F
	for <e@80x24.org>; Thu,  8 Dec 2016 01:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933965AbcLHBq4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 20:46:56 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35362 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbcLHBqr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 20:46:47 -0500
Received: by mail-pf0-f181.google.com with SMTP id i88so79990472pfk.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 17:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GVKDjSPQfQJbQ5Gnel3Kguk7MGIy+D1I0i5G2q2TpZo=;
        b=aJpu4A54gXskD1wKmalevKEjfDZjj/auKM3Lo+u94Gw75vU/2kXyXjrZ6eC7MxFiMV
         RJTJgGuuwfBB9wtBM6FiSv1Qcadqc6elAPi7Q7FtWrY04rwT8NAcU2gNBWYVEL4lvm55
         U0mw+up3uqgcZUsJ4jeG4YAFQIH5mnVbA30PlvQN5uqx2D63y8XpriFG1CcaHl7M60tN
         KSyTjSR99HyGyHdNuURXYkBZ+pBEINjiIaiDY3+jG+bCnLyJiTh7lZoGDjCZZM+KCFK1
         iEW4UncacS+ptKOaPeyL5aWQAJ7uybWh/IkPsTLLGp4HYtf5a3B2z0HHC38B6NURnurF
         N5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GVKDjSPQfQJbQ5Gnel3Kguk7MGIy+D1I0i5G2q2TpZo=;
        b=cFdl5R3uqqJPKOaiKOGg+SpPlQvP3NpO2NLbFmghk1Koe7jH1B4NcsTzSyG8WE5/HF
         +XhRf/0M+VB5ikyxfpGe3Km6GkoUzvKy03URKLlXSeAJ7b4UA2yzXsUgHvj3osvvwNVn
         siZUmCHZKOQ7J9WN2h4FDxirCzyEyrnkcL0ktc2dCDfX7Z7hpIuvKFmj7E8iTO5t0Osi
         Yszej39ERzCDvdYCoq48rSlquxe67BwJC05yuiFHOdHAqi6//qibSqTSxkK9rRKdwra2
         Js07y6LStkWJg2XLU2KFqwlHQVZKwYa7r5nboD7WSJK4wt2k3e/ohotqoVrXWWFWt7Zx
         frRQ==
X-Gm-Message-State: AKaTC03oFyv5BBAkyKFz1VtTJ9GwJbqjuHnDknhxwXO7m7HDTDJ9V2rfFzrvi/k/72JFST7F
X-Received: by 10.84.167.168 with SMTP id d37mr151584387plb.71.1481161606597;
        Wed, 07 Dec 2016 17:46:46 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2441:4f9a:ad0f:a8d7])
        by smtp.gmail.com with ESMTPSA id p64sm45255061pfi.88.2016.12.07.17.46.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 17:46:46 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 5/7] worktree: add function to check if worktrees are in use
Date:   Wed,  7 Dec 2016 17:46:21 -0800
Message-Id: <20161208014623.7588-6-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.gc512cbd.dirty
In-Reply-To: <20161208014623.7588-1-sbeller@google.com>
References: <20161208014623.7588-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 worktree.c | 24 ++++++++++++++++++++++++
 worktree.h |  7 +++++++
 2 files changed, 31 insertions(+)

diff --git a/worktree.c b/worktree.c
index 75db689672..2559f33846 100644
--- a/worktree.c
+++ b/worktree.c
@@ -406,3 +406,27 @@ const struct worktree *find_shared_symref(const char *symref,
 
 	return existing;
 }
+
+static int uses_worktree_internal(struct worktree **worktrees)
+{
+	int i;
+	for (i = 0; worktrees[i]; i++)
+		; /* nothing */
+
+	free_worktrees(worktrees);
+	return i > 1;
+}
+
+int uses_worktrees(void)
+{
+	return uses_worktree_internal(get_worktrees(0));
+}
+
+int submodule_uses_worktrees(const char *path)
+{
+	struct worktree **worktrees = get_submodule_worktrees(path, 0);
+	if (!worktrees)
+		return 0;
+
+	return uses_worktree_internal(worktrees);
+}
diff --git a/worktree.h b/worktree.h
index 157fbc4a66..76027b1fd2 100644
--- a/worktree.h
+++ b/worktree.h
@@ -33,6 +33,13 @@ extern struct worktree **get_worktrees(unsigned flags);
 extern struct worktree **get_submodule_worktrees(const char *path,
 						 unsigned flags);
 
+/*
+ * Returns 1 if more than one worktree exists.
+ * Returns 0 if only the main worktree exists.
+ */
+extern int uses_worktrees(void);
+extern int submodule_uses_worktrees(const char *path);
+
 /*
  * Return git dir of the worktree. Note that the path may be relative.
  * If wt is NULL, git dir of current worktree is returned.
-- 
2.11.0.rc2.30.gc512cbd.dirty

