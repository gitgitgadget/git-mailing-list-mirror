Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FA3C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 01:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347820AbiFHBUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443900AbiFHBBC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 21:01:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD451EEBA0
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:42:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso4333994wms.2
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GZXWE3ow9ADaKIj0DAE4htB4Ma746HVMJhy/AKVLrMg=;
        b=YrYSKjhh7hE2nbU0QmFWgb62Q/XfUU9v1aVXY5i1g6H4GlsZ2DlA+WcDrFmWKlb9D/
         XOUf3J6zN8ZX1MvoGm1WSYA9Qh3aUco4o3r9ndRvh+74WXI/o0kbBxWKT3aahahT1ty6
         Wbp6/FgW4CGEpD3tTr73uf9B6/IxdrjvZ+CcqnkgDgblQljhFgDuSRaOuXpWPyl8BR7Y
         yquA93i2qPgXNLnYvDsFDQHB5cBdiyYmPpdqQp7Y6q0MSlUnnFBNNWkJ6i2giym3CCKM
         jjJKCh9dt5ddRqFH4OFeokLVhePUuHN8/uRTPv3zNAloOQNZ4hny+Z40nFhDes2iACWe
         0TvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GZXWE3ow9ADaKIj0DAE4htB4Ma746HVMJhy/AKVLrMg=;
        b=nORoYJdnGEGgIsfstpPIB+q6PNDJjKX8Ybgi0CUGJsaXZROf2WPUJerpeIVQcYO1hn
         88ORDJbg34eT4PDp8bURRdW+I5PV321Z0joUoPNUw6JOT9/avAgGyy4UdFoP0p3WsPfh
         n/U5b09dPWOn1Ol5SuLwo9e9KOCU1tGsDD9gdhrlHTj62QIegd8sLoAmpMO8jb8cWCnQ
         Aj6RNRMu+KY8Jz5W3BXVBpaLSi/czB8DSyP1NSeKdagA1DYZTmnLiQ6CVek2/wWLv/Ol
         5OCl/6zVbeWHm8Glh5EBEOtvB3BI552D9yNejwf9EWMLsYWbVWq6HwQ954560KmK5v9Z
         cvlQ==
X-Gm-Message-State: AOAM5307wHanq7aKMJsYowoUnYr9wk460+85+6lyODAEEe19JTnmYG2x
        Xu/lSkRFB1z2lMXrgMB/JQAsxHXPjqTCP9+c
X-Google-Smtp-Source: ABdhPJx8PKhhItJj/KVDkdzfZXVSE7pA0/BxRJWQlMZuKGv9u1AIxWTmEAnILGjADrlzeSVK3dhEbw==
X-Received: by 2002:a05:600c:4e94:b0:397:62ab:f88f with SMTP id f20-20020a05600c4e9400b0039762abf88fmr59818247wmq.63.1654634573744;
        Tue, 07 Jun 2022 13:42:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d58cc000000b0020c6b78eb5asm19257060wrf.68.2022.06.07.13.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:42:53 -0700 (PDT)
Message-Id: <5f54766e1032ebf3a331516a6dd696b997bdfdd8.1654634569.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
        <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 20:42:44 +0000
Subject: [PATCH v2 2/7] branch: add branch_checked_out() helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
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

