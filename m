Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F127055D
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772993057; cv=none; b=EIue/2rFdsnZB8ya95xf3TPuWUVfI1V6oEljFwZKKjck2vHDNG5hXXTAjiStaAq4Sj51KnZW1lzS4qZhxLucUJLDPsMckXFZE7Q8PsRAW4sBaCGS0nk7kwB1HnaO3AliggrFWKgQekb+JAzTDzF6GrZcxU64zAPpXZqwg4Xe728=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772993057; c=relaxed/simple;
	bh=IOkxyRhuRssOpYp+F14VnK36YiVUPDMR7XOb+WkSYLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoHP22pNFC8kIdoTsckoehEBtTyYo9rC+5tHHe0hkkYOxKovRIq9+O6kU7et/eaz1+tGcEtkYdsNaNePPzPo1AmLv3dEVdXNJ8NSFJgt2hN2B26IOtPRn4v2PMgBIHWX+mbLxvaEEC8d83uQLDtr8bghVjgvzZkoqOz/bxYNvpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPGPUsz0; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPGPUsz0"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c7393536e53so1282990a12.2
        for <git@vger.kernel.org>; Sun, 08 Mar 2026 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772993055; x=1773597855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLbHhcS5eLvd5bqFsY5fOnnEMAZB49VLmJU9ddEf3Cs=;
        b=lPGPUsz0lFuVqU2V0uQIe4qpmq/bPGepjA9zain6Ikj3cNlI+YK3/nZaF6+AmRrF/e
         89s5fimNT76OM1QLMSuUnaHmBwJJimQ3fgrURvENfyUz3FdzPMl0ahY8O9Ky3rnB8iyK
         wQ9AKtJaxqSPwqr9TC8c1K9KHCrK4YDCMNQBJFfSj5ict6YJVfqijiqduUJ1tXNn8wm2
         Y1xNu4Fc1Phv+Jnm7dfRgy3+59SnO+9tvtBNbqRtIAmbRYYwOnDhWXMMrJKGOUZfR86B
         zqhECM32iwPYZ9HmCoGJAEXVJhHf/chX3vULh5mM3JcKNjOrM6pGUnTa3t0BQXk+zG1Y
         4rcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772993055; x=1773597855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QLbHhcS5eLvd5bqFsY5fOnnEMAZB49VLmJU9ddEf3Cs=;
        b=on4bd2RpY6oiKrrt0OcntKYP4E8lx953QBvJRqc/BOg3agThmxtal3Hpl1n3SpLcVZ
         CaCtyDGcETT/ehjCEkdXrIv0FqRf/EiYGU6AEadeYFRRjcnKU048jj/sIlB80nyfzilr
         RW9aYs8NMADPDS+Ou9N/0Hp936NJpP2jXQQyMyY/DCiuXnzWkl2/JZbSDmwxpH1rrzr7
         i5w7HpDPmJhJXO2BrGQuMaKjsIIuvfKVUdSUT+6EAKH5+MJ6h91jIV6atx1HER37JPLy
         g9VwlUyCWF63oGbSfEUVjIEcsnm1bnAdWHBXU78NJggj7H9ZMY8dVxt83KSLonnbq/xT
         u9Gg==
X-Gm-Message-State: AOJu0YyzkLMZ4D+6r++fQ+2oXidKnN6wRZ8ap3Dlc2KHov4hGZo1Lwcr
	1d72djR1e6XD4/O1HJHEBjQFdZrdfe/jXVbQ7hsF0RIlo2RctYp7XJLDpk4A0A==
X-Gm-Gg: ATEYQzxsEzD/22/bWHqrfbn+1zGE0cuK7QRD8LzqG/B1eCtUwWhw7YxLTpv+DvnlmP2
	yBMSJtj//A2XYrt78OFzZeKyeX54tPSIWQ0/K6MIz2GoD6Ag3PGhWqwa82nkQlaOdMfENDY7+f9
	yYXqhQaEZmIBQZIsDBwqsQLNS7M1/uJF6Ebqhr8KXDvmeArHxTTlzCFS0GeUYlGyOPeoKFVPWuV
	rady5wfWQhy1agcllSQZGa9kgyJt5COBZl+TR0WZAQDnpGyJXYRa+sLvv3Rh7V3MTvOYXVAu3y3
	Lh74iVoe4L8rvWKKL+lFxlEn4evs3hMBPNkz95ncjSUxAIr0gYReZbIL6eHIasEpuI4ojP0Gb9a
	WygonyZ9IS0uBMZIpLKr2JD8ZxYx9zfP/SleovmnYN84XETwh8O4kv4nVCSv7MiwBVfMK7wLhlK
	xTqKkyoYqcUZtcXeDR3IBEkTogowgaaD64tLdY8Zeh5YeB
X-Received: by 2002:a05:6a21:3296:b0:394:2fbb:bc6b with SMTP id adf61e73a8af0-39859087660mr8549994637.46.1772993055332;
        Sun, 08 Mar 2026 11:04:15 -0700 (PDT)
Received: from d ([49.43.41.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4636a92sm7835541b3a.1.2026.03.08.11.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 11:04:14 -0700 (PDT)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH v1 1/2] worktree: do not pass strbuf by value
Date: Sun,  8 Mar 2026 18:03:58 +0000
Message-ID: <20260308180359.31188-2-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260308180359.31188-1-deveshigurgaon@gmail.com>
References: <20260308180359.31188-1-deveshigurgaon@gmail.com>
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

