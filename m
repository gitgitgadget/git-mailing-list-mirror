Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B14D35A930
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250434; cv=none; b=rfq4o3b7gL+xOKDXdHCWgdPE+G+Obo9Lyuc64BtU06dlVWNGwKH6FnGKPJBHs0Z8vuyayUioEDSO9W+RRn0CoWr8Z2ul4T+Ya4+WwduNV03eWdvLwIUtXAE5JaxegjYa+n7Bp8NrjQ+0bKHtiSrJIj6K2MmP3dBfbJt2rGAD0v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250434; c=relaxed/simple;
	bh=IOkxyRhuRssOpYp+F14VnK36YiVUPDMR7XOb+WkSYLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqDI6VSwMGXThILM+hJTSi653gPOXQLzi8OWhmS5zSBFifQXaNCggAr95kna/wtu0XysMdhERA+hC5jW4suCrKMBIwsxe58EYSdXqG8a/J7s/G2UGoYiIGs0LcarWw915L4KVhLY0Q4cPf5Dt4MAcCSI0MJ7YjNrGn9CL/KP+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddAaGsc8; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddAaGsc8"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-358ed696623so42184a91.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773250430; x=1773855230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLbHhcS5eLvd5bqFsY5fOnnEMAZB49VLmJU9ddEf3Cs=;
        b=ddAaGsc8/0C5U/iqHMNlxbqhUm1vKdO3EnUaSg8utlK9LX3WFqtt5FIj1NJa4tYHrm
         1bQ/FyvNRo/PZLQdugMCym9K2YToVjeIeZgnzfdr3azccOIdx8sbbxqBtnKxw+PC3aBu
         BnKWp2LI04QtC2q+tlvF1vqrHjoIIqtC5PVd+FqBMr1nsfTANvWq3AIvC5lDyTPMa3zK
         ncuToVaGYKzn55UHmifD1j7CN/1yQlZD8aIN9pvrsUG6WoyaDQd+8xVMJN9ZKeY+OJQD
         c+svACuuj5Uv9g0oBLP6UC2jbOq1v2RyQeb1QiPo7ukKnO+XTEiFP6n2DyPqLiCc3tH5
         e3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773250430; x=1773855230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QLbHhcS5eLvd5bqFsY5fOnnEMAZB49VLmJU9ddEf3Cs=;
        b=wx1I/ENaCU2VkiOeEMcsjfpNQ/1U5Ib0fnvRwWFBXuajVWhgPDbxcQ9YftKS4HIQ4O
         joBdNPGdOeYHHVmEBpAOPs3H2mGBXNr6vjd95bR/Qd7WByumGPDVMKr2ORzoJsLKeYlJ
         ggM7+Juhbqf588rTw7a4h8I1jO0MVHkgSm/Is+RtQnu2laEjanzZLkKCHbzgBXEeSa8m
         QCIy4HipJvOtXmcxN3ya7A6i4aD2z3U9igbxiO3XWWmVs7WWqGGliRsT7tNuID+LRJXw
         Xl1Mg/dG+zClWJX/9QgjEb2WfC3o8WMq8ZcPWtd2uGKP/VrROI/Xo919WMYdo+RpDHNw
         HXAg==
X-Gm-Message-State: AOJu0Yxc3FAEa/DZVuKOox4k9RnCoHBg2V/Pun6x/kHIcGD/gVB7rmnd
	c3v8upoQufAPC5he0F9Sm2ipY725r6KPz3SguaR04UnzzvQNKE7nsNdyBr+5mQ==
X-Gm-Gg: ATEYQzwO0mS47FVHiYO5ONLLbGu5MDbIZgpitQXH1NB8fLd2Jrxbt01sxpPVOQGsm3G
	rnlnKM7XmRAZcRZtq6Sly3OWeWLQYWnlQXQ8WGWo73Lp5ociqqu+wDiWLIZM2V5iL8wrERn+rZk
	MaAyfRms5YtNUHODfCXXcjkXq2hAHWXn1dxmOnitebV/wR5LyZoushqi1Qm2b5Zu9PdXp9HLOqY
	omdAKzUrPJL7/rLZ1rAlrr0CDXKdsDD+Scm4s5tgm1nEKPoVS+1oIj8n5pnmwr5zptG4koyWzr7
	OBybdf1ZLnEg3EH2BI7prHfZW4CFNScqKgQLex0ixJPBOiTY7BQYlUJ4e2WWR3zWAqc8fD61ApK
	HiM2r3wD/Qt/yY79xWX+qQFV8BYoP2CCh2rsFi8eyovt3gua3i2B9CjrDB41GgsQgIolBGuqDKi
	hkR4BApX5V3PVxMCczJdDuqomdSLboiScxy8Ujh0tG845x8Dcsmue04uzPP4eSkYJInQ==
X-Received: by 2002:a17:90b:3f4b:b0:359:8c21:ef46 with SMTP id 98e67ed59e1d1-35a0126923fmr2843463a91.13.1773250429782;
        Wed, 11 Mar 2026 10:33:49 -0700 (PDT)
Received: from d.iiitdmj.ac.in ([14.139.241.214])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a0f6d190csm749973a91.14.2026.03.11.10.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:33:49 -0700 (PDT)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH v3 1/2] worktree: do not pass strbuf by value
Date: Wed, 11 Mar 2026 17:33:35 +0000
Message-ID: <20260311173336.8395-2-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260311173336.8395-1-deveshigurgaon@gmail.com>
References: <20260311132041.12044-1-deveshigurgaon@gmail.com>
 <20260311173336.8395-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

write_worktree_linking_files() takes two struct strbuf parameters by
value, even though it only reads path strings from them.

Passing a strbuf by value is misleading and dangerous. The structure
carries a pointer to its underlying character array; caller and callee
end up sharing that storage.  If the callee ever causes the strbuf to
be reallocated, the caller's copy becomes a dangling pointer, which
results in a double-free when the caller does strbuf_release().

The function only needs the string values, not the strbuf machinery.
Switch it to take const char * and update all callers to pass .buf.

Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
---
 builtin/worktree.c |  2 +-
 worktree.c         | 22 +++++++++++-----------
 worktree.h         |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index bc2d0d645b..4035b1cb06 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -539,7 +539,7 @@ static int add_worktree(const char *path, const char *refname,
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
-	write_worktree_linking_files(sb_git, sb, opts->relative_paths);
+	write_worktree_linking_files(sb_git.buf, sb.buf, opts->relative_paths);
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
diff --git a/worktree.c b/worktree.c
index 6e2f0f7828..7eba12c6ed 100644
--- a/worktree.c
+++ b/worktree.c
@@ -445,7 +445,7 @@ void update_worktree_location(struct worktree *wt, const char *path_,
 	strbuf_realpath(&path, path_, 1);
 	strbuf_addf(&dotgit, "%s/.git", path.buf);
 	if (fspathcmp(wt->path, path.buf)) {
-		write_worktree_linking_files(dotgit, gitdir, use_relative_paths);
+		write_worktree_linking_files(dotgit.buf, gitdir.buf, use_relative_paths);
 
 		free(wt->path);
 		wt->path = strbuf_detach(&path, NULL);
@@ -684,7 +684,7 @@ static void repair_gitfile(struct worktree *wt,
 
 	if (repair) {
 		fn(0, wt->path, repair, cb_data);
-		write_worktree_linking_files(dotgit, gitdir, use_relative_paths);
+		write_worktree_linking_files(dotgit.buf, gitdir.buf, use_relative_paths);
 	}
 
 done:
@@ -742,7 +742,7 @@ void repair_worktree_after_gitdir_move(struct worktree *wt, const char *old_path
 	if (!file_exists(dotgit.buf))
 		goto done;
 
-	write_worktree_linking_files(dotgit, gitdir, is_relative_path);
+	write_worktree_linking_files(dotgit.buf, gitdir.buf, is_relative_path);
 done:
 	strbuf_release(&gitdir);
 	strbuf_release(&dotgit);
@@ -913,7 +913,7 @@ void repair_worktree_at_path(const char *path,
 
 	if (repair) {
 		fn(0, gitdir.buf, repair, cb_data);
-		write_worktree_linking_files(dotgit, gitdir, use_relative_paths);
+		write_worktree_linking_files(dotgit.buf, gitdir.buf, use_relative_paths);
 	}
 done:
 	free(dotgit_contents);
@@ -1087,17 +1087,17 @@ int init_worktree_config(struct repository *r)
 	return res;
 }
 
-void write_worktree_linking_files(struct strbuf dotgit, struct strbuf gitdir,
+void write_worktree_linking_files(const char *dotgit, const char *gitdir,
 				  int use_relative_paths)
 {
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf repo = STRBUF_INIT;
 	struct strbuf tmp = STRBUF_INIT;
 
-	strbuf_addbuf(&path, &dotgit);
+	strbuf_addstr(&path, dotgit);
 	strbuf_strip_suffix(&path, "/.git");
 	strbuf_realpath(&path, path.buf, 1);
-	strbuf_addbuf(&repo, &gitdir);
+	strbuf_addstr(&repo, gitdir);
 	strbuf_strip_suffix(&repo, "/gitdir");
 	strbuf_realpath(&repo, repo.buf, 1);
 
@@ -1110,11 +1110,11 @@ void write_worktree_linking_files(struct strbuf dotgit, struct strbuf gitdir,
 	}
 
 	if (use_relative_paths) {
-		write_file(gitdir.buf, "%s/.git", relative_path(path.buf, repo.buf, &tmp));
-		write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, path.buf, &tmp));
+		write_file(gitdir, "%s/.git", relative_path(path.buf, repo.buf, &tmp));
+		write_file(dotgit, "gitdir: %s", relative_path(repo.buf, path.buf, &tmp));
 	} else {
-		write_file(gitdir.buf, "%s/.git", path.buf);
-		write_file(dotgit.buf, "gitdir: %s", repo.buf);
+		write_file(gitdir, "%s/.git", path.buf);
+		write_file(dotgit, "gitdir: %s", repo.buf);
 	}
 
 	strbuf_release(&path);
diff --git a/worktree.h b/worktree.h
index 06efe26b83..f4e46be385 100644
--- a/worktree.h
+++ b/worktree.h
@@ -240,7 +240,7 @@ int init_worktree_config(struct repository *r);
  *  dotgit: "/path/to/foo/.git"
  *  gitdir: "/path/to/repo/worktrees/foo/gitdir"
  */
-void write_worktree_linking_files(struct strbuf dotgit, struct strbuf gitdir,
+void write_worktree_linking_files(const char *dotgit, const char *gitdir,
 				  int use_relative_paths);
 
 #endif
-- 
2.52.0.230.gd8af7cadaa

