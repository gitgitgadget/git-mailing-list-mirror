Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DDEC433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 13:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244673AbiFCNiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 09:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244662AbiFCNh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 09:37:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651641276B
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 06:37:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q7so10453108wrg.5
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 06:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GZXWE3ow9ADaKIj0DAE4htB4Ma746HVMJhy/AKVLrMg=;
        b=e//ND44HNBhyMeCqb9e67+f+0zQ5jK9bfjfatYRsnXIomigcD6ZbRMLviA/iNHfh/B
         Vfbm/VPA+V5vrGhlu/xDsaoOs80JTCjWZba9iyUPzS51SVVYZ2KBWT3+QcU3vrf2MaLs
         +xAG6eloO1YIdEpwL01iW+Ho7ZobK7AkBhdBs+4Mt2ePHDxaM90RgN3ImjgEwKlU9VF6
         jUFG+9DnTr5yWLa+fGkRud66qB+UHn6gR5MAjGu8rnsVsovEQ2Zce2Z1lIlCcPaXXNWg
         GZzDmDkb33RPBIZPp7l7ZSnsL4jXx0UyZeORM/PZ225WyCisM90wtwEtxhVubPYG9t9r
         579g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GZXWE3ow9ADaKIj0DAE4htB4Ma746HVMJhy/AKVLrMg=;
        b=UCMtgsVu1SI8gqdfonj4kYkpr7UBwbRvWy+RJRT+DztLgk4+mWQeWa0itcldCQ2/4h
         PLTrrBAAe18nx/6v2NxiH9L2qWZgFUTa8Rr0ZfP/uOggTA31GbRWQPm7eVoccHeyfegD
         O10Cg80nLKWcjLha3lyiuGZtV+EBaFe3yuNV4QSinudUSZ0vh3ZubMSIym9PtlFfJH2S
         iq4ZnQ5LogQsIjLhbW+l3zquzVW2pq4sRJJfLvDOs1MBBOkUrYm2bYBAFEgxx211GRrQ
         FMQ4nggeFjVdQi3x44pAZjWpL19GrDNkArkxXPVTxNWJjwvwpcL/C15N5CO1KTxYG8Hq
         wPug==
X-Gm-Message-State: AOAM5304alfmyu26H98tTwWfPPQ2cL0LDvRW6CH18YxPokNYrTggaWvd
        xF7hOQ01v4iO7EwRlBgc9q4vOPVVxRkQ6ZDT
X-Google-Smtp-Source: ABdhPJwU9X9NZ3NjPnNF+k7cZb7JMOnGuv1OpeJvUCtrdLR4bxNYsA6s2dZisHVztwv5iygSVhov1g==
X-Received: by 2002:a5d:5903:0:b0:210:316f:7f40 with SMTP id v3-20020a5d5903000000b00210316f7f40mr8329157wrd.624.1654263476663;
        Fri, 03 Jun 2022 06:37:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k14-20020a5d518e000000b0021350f7b22esm4522458wrv.109.2022.06.03.06.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:37:56 -0700 (PDT)
Message-Id: <5f54766e1032ebf3a331516a6dd696b997bdfdd8.1654263472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Jun 2022 13:37:50 +0000
Subject: [PATCH 2/4] branch: add branch_checked_out() helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The validate_new_branchname() method contains a check to see if a branch
is checked out in any non-bare worktree. This is intended to prevent a
force push that will mess up an existing checkout. This helper is not
suitable to performing just that check, because the method will die()
when the branch is checked out instead of returning an error code.

Extract branch_checked_out() and use it within
validate_new_branchname(). Another caller will be added in a coming
change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 branch.c | 24 ++++++++++++++++--------
 branch.h |  8 ++++++++
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/branch.c b/branch.c
index 2d6569b0c62..2e6419cdfa5 100644
--- a/branch.c
+++ b/branch.c
@@ -369,6 +369,19 @@ int validate_branchname(const char *name, struct strbuf *ref)
 	return ref_exists(ref->buf);
 }
 
+int branch_checked_out(const char *refname, char **path)
+{
+	struct worktree **worktrees = get_worktrees();
+	const struct worktree *wt = find_shared_symref(worktrees, "HEAD", refname);
+	int result = wt && !wt->is_bare;
+
+	if (result && path)
+		*path = xstrdup(wt->path);
+
+	free_worktrees(worktrees);
+	return result;
+}
+
 /*
  * Check if a branch 'name' can be created as a new branch; die otherwise.
  * 'force' can be used when it is OK for the named branch already exists.
@@ -377,9 +390,7 @@ int validate_branchname(const char *name, struct strbuf *ref)
  */
 int validate_new_branchname(const char *name, struct strbuf *ref, int force)
 {
-	struct worktree **worktrees;
-	const struct worktree *wt;
-
+	char *path;
 	if (!validate_branchname(name, ref))
 		return 0;
 
@@ -387,13 +398,10 @@ int validate_new_branchname(const char *name, struct strbuf *ref, int force)
 		die(_("a branch named '%s' already exists"),
 		    ref->buf + strlen("refs/heads/"));
 
-	worktrees = get_worktrees();
-	wt = find_shared_symref(worktrees, "HEAD", ref->buf);
-	if (wt && !wt->is_bare)
+	if (branch_checked_out(ref->buf, &path))
 		die(_("cannot force update the branch '%s' "
 		      "checked out at '%s'"),
-		    ref->buf + strlen("refs/heads/"), wt->path);
-	free_worktrees(worktrees);
+		    ref->buf + strlen("refs/heads/"), path);
 
 	return 1;
 }
diff --git a/branch.h b/branch.h
index 560b6b96a8f..5ea93d217b1 100644
--- a/branch.h
+++ b/branch.h
@@ -101,6 +101,14 @@ void create_branches_recursively(struct repository *r, const char *name,
 				 const char *tracking_name, int force,
 				 int reflog, int quiet, enum branch_track track,
 				 int dry_run);
+
+/*
+ * Returns true if the branch at 'refname' is checked out at any
+ * non-bare worktree. The path of the worktree is stored in the
+ * given 'path', if provided.
+ */
+int branch_checked_out(const char *refname, char **path);
+
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
  * Return 1 if the named branch already exists; return 0 otherwise.
-- 
gitgitgadget

