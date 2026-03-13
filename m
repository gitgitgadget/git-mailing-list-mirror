Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C192B3932CC
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411607; cv=none; b=RDMSKkzM4XshDjpDlcB4SjcBDWAV1ybDu8co0uTMd+/z/MfIXwcaKN+w9lpCaiE9T6sdtmkXUjZXD+7hvX5UH5yqDGrDnbMur8pQoHQwJ2RV2znggHc3y9y9OHnxGTJuQer+U8WKum5coLzN2J8HHOlWf4dK8AULD0HSG0H0bSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411607; c=relaxed/simple;
	bh=frzaapeFAv8gU+MaIZUOzC0gloaTOdxogXiCzKZXbDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLPnR1I+ih6qfr5BsmO85JLa4ZQ861Gp++ZNfQvU7aUjhVPL/b1+XuIw9eGCGSnPNyoPabxIyIL5Jvo0iOgIZmX89NMOCHx51dPSKN/BqVHaCBlEPv/1Seo2yexAqUfLA6uVaYrBZhE1bqlyhOjIgeW2tMosPYi/JZp06Gd8HYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9+cHQMP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9+cHQMP"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso1790301f8f.1
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 07:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773411604; x=1774016404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oGQlZoMUqO616K9o5ti3oYPnh8TRRW8WdJNw2STC+QY=;
        b=L9+cHQMPECn/nUJj90Z7sz0FcnOi3PNCJ2w05pEVxWLZ5TacsbCdUDtkjcqITCQtu2
         azvTTCvyciAKnGZhXsPuzuqRwchbtdt0RFf5FuabkH/zP3e4JLl1uMxDZgNoKv42Cmu8
         +Q6+xmMEYfvYvTdBkJIGMLr+UVUfr3mmlrR91DqZjz0D7PNdbdrlC/fn0t7vMcUdEzDo
         IkWQdZA1cZ/0ZwjFBSL9Dq/TU9GOZxnQ7+98TXuhIw6PR+aYT8w4seP/MQEBmDixBwi9
         R6q0x015Zsh4+aP3Cr9UWCDUhFYUL6lCATObdjltRGf48HIDhnqfAy/CIOKWAoYyCocO
         +AJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773411604; x=1774016404;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGQlZoMUqO616K9o5ti3oYPnh8TRRW8WdJNw2STC+QY=;
        b=QqFU0p43zt3hWb27UV3JXBFdJRthZegMQ7O3YJEqUHiBhiK4asCsEDAS+NkyWxDWal
         LbL3bT68wcRmgGmha3fissZu+GRNMWmpcKF+6nCpZmCaVsN5l2RY8KUpBZ5T0dEEUmta
         l2TeYkrvHNSr7PT2ENv2D+FDGfQ80pWZghLWBpCrEtbMuQ91qKTO5uXVtbVkTadHJeK0
         J7mWUCj/x+R0vEyW65SFqSEOUAiPyQrXZsBexUHwuaAOhH8LDf/JcxJYdgvHlLLUOXyH
         IZKBrQkTS5ew+jmQO/lnKlgR81jsgJeozwbL8Ean1XjrO/dW3To0LOtWdyEQZhfgfMUR
         a7Ow==
X-Gm-Message-State: AOJu0YxXAIsOiw+RmI5df/nqNSKYOLPLolfw8jCO4ClqCVmuLTlMab6Y
	/nPFHo/EmjUQB8e/jKP0hYSlA3CIoFKQ6G2W9VxHM2cqV+U3xIqwSDYj1lnrjg==
X-Gm-Gg: ATEYQzxagC0KbwIS743EqDBO16HHQmgP6Z4TNlczcU9Aulm+3XKbq2oqJBcmpPQUWmo
	ugUfH1uw/5OJVtgIO63JbwVUUkFcUUu2lZs1f28bMEpReWAZlG+QmNDwB02GAM5DEz90xjyox1I
	H8Tit83c0uD1Zd4NZC5qVas0dABw7QlHiAafwwDXrbMN5exiTzBv62xd2joWMO51zEXEYWKz4gR
	5cvDSeX2finzAvn9W1Akq34plnDq7glbfxdzk3AQ4rkoak7tnEmJXRBQHEUk9dCxjOuN1DDOrLU
	1w/xTPvGp/NSWXS8ubcoAkm85r1Ba8pZVq48A86ZaSa/gsb3wYMUPW94iEGDAlVGY676WdaZiwR
	e8YoLtkXqhfDUuqA/9DvlTaGj6R8SCmAPIYNKKC4NeiZrkSEaiENpU5t3vgGMYlLxT8YN47Mm2Z
	CSEauH3TCPJvdUOk9Ctw3ag7KYQqI85bkCZCYUWw==
X-Received: by 2002:adf:fe8d:0:b0:43a:514:34fb with SMTP id ffacd0b85a97d-43a0514357dmr4811443f8f.18.1773411603880;
        Fri, 13 Mar 2026 07:20:03 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a78cesm17215509f8f.11.2026.03.13.07.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:20:03 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/3] worktree: remove "the_repository" from is_current_worktree()
Date: Fri, 13 Mar 2026 14:19:48 +0000
Message-ID: <075700a22568913988c9fa8e1ff49db1a1a5b606.1773411586.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

is_current_worktree() compares the gitdir of the worktree to the gitdir
of "the_repository" and returns true when they match. To get the gitdir
of the worktree it calls get_workree_git_dir() which also depends on
"the_repository". This has the effect that even if "wt->path" matches
"wt->repo->worktree" is_current_worktree(wt) will return false when
"wt->repo" is not "the_repository" which is confusing.

The use of "the_repository" in is_current_wortree() comes from
replacing get_git_dir() with repo_get_git_dir() in 246deeac951
(environment: make `get_git_dir()` accept a repository, 2024-09-12). In
get_worktree_git_dir() it comes from replacing git_common_path() with
repo_common_path() in 07242c2a5af (path: drop `git_common_path()`
in favor of `repo_common_path()`, 2025-02-07). In both cases we have
a repository instance available so use that instead. This means
that a worktree "wt" is always considered current when "wt->path"
matches "wt->repo->worktree" and so the worktree returned by
get_worktree_from_repository() is always considered current.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 worktree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/worktree.c b/worktree.c
index e9ff6e6ef2e..344ad0c031b 100644
--- a/worktree.c
+++ b/worktree.c
@@ -58,7 +58,7 @@ static void add_head_info(struct worktree *wt)
 
 static int is_current_worktree(struct worktree *wt)
 {
-	char *git_dir = absolute_pathdup(repo_get_git_dir(the_repository));
+	char *git_dir = absolute_pathdup(repo_get_git_dir(wt->repo));
 	char *wt_git_dir = get_worktree_git_dir(wt);
 	int is_current = !fspathcmp(git_dir, absolute_path(wt_git_dir));
 	free(wt_git_dir);
@@ -78,7 +78,7 @@ struct worktree *get_worktree_from_repository(struct repository *repo)
 	wt->is_bare = !repo->worktree;
 	if (fspathcmp(gitdir, commondir))
 		wt->id = xstrdup(find_last_dir_sep(gitdir) + 1);
-	wt->is_current = is_current_worktree(wt);
+	wt->is_current = true;
 	add_head_info(wt);
 
 	free(gitdir);
@@ -229,9 +229,9 @@ char *get_worktree_git_dir(const struct worktree *wt)
 	if (!wt)
 		return xstrdup(repo_get_git_dir(the_repository));
 	else if (!wt->id)
-		return xstrdup(repo_get_common_dir(the_repository));
+		return xstrdup(repo_get_common_dir(wt->repo));
 	else
-		return repo_common_path(the_repository, "worktrees/%s", wt->id);
+		return repo_common_path(wt->repo, "worktrees/%s", wt->id);
 }
 
 static struct worktree *find_worktree_by_suffix(struct worktree **list,
-- 
2.52.0.362.g884e03848a9

