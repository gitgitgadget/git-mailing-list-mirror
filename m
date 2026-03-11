Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF3317161
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235259; cv=none; b=CUJI0cuJxicCMMX0ON0yXYXC7tR38Ki34IQKubM7B/LVF/5LuOtkTor23qY0F8tSYj5Qqr46WSGa3TsvhmitT4hjuQPduZ3d3yCMkPE71hYPz8+LMdDetkrKapPz3LVmLmmSEcUsf64Qb+uSL2L3PVCct0OPD/71qpgxjJANZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235259; c=relaxed/simple;
	bh=IOkxyRhuRssOpYp+F14VnK36YiVUPDMR7XOb+WkSYLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qk+xNZRJkoYZra8B6sC4qG2bRrRobP/joL9HOk6rh53uMhYK8odpaMZS59LAVYeGQmus5IpLYyxOwAozuEfvNxp/C5FanNSDNRu0WlJer5itPlEqvfyWDyaZgLuDv5FUn/BakiQihNiRwKs424SBWuwjR8vPcoKhAq49UHyMdwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnJlowBN; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnJlowBN"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso5355299a12.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773235257; x=1773840057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLbHhcS5eLvd5bqFsY5fOnnEMAZB49VLmJU9ddEf3Cs=;
        b=RnJlowBNoxiQn6xXEaNKXaXdzd+Ou8FJi6QKwnZ/5kZw30H1A/jdw4zb3DyBvxLXrn
         G3TOs2WdXI2TG7NuK5jMbsSoNUZrZR7zBNt6MRsBlUee/xkl+dpzwB16zYSBcfNZPqk2
         d/txhBAN5mvIeS9WCrlMK6aSew3Qgt8U/+nEBzJMOgfTV2WUww6R2DUnqpNgnl95I+zG
         hwroI/7IPhp2aodJQYm4W3F8Ounhl9nnD+2N5ZiQ6J/dxQuWAxYxU7dIjrt2fks8gzYB
         jUlkVdsjPjpfKnGj7bJqotIBocMSyTKYeLclEi4A6VpLDZk/CJF/A5tc73fp3QsIsSbM
         VTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235257; x=1773840057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QLbHhcS5eLvd5bqFsY5fOnnEMAZB49VLmJU9ddEf3Cs=;
        b=TmzsBtWe3hIdDDFLo9aUT+Mn2IvIi9ZzFeRume7ZKXeSPBpfglWSMTYr0Y+dHgmS76
         mwNMuslDPqYX5wfaULOfcU0kGB8VjvD87hDv/Af5YFtX98mYLnz8Jn7sq7ATZFMf0PAu
         fVlQwve0dur+vnwhTgpbsH4sT+sjJOKBKudkA/GUc80EdffeLBhcOdZpVt9OJ2wV4sKV
         BWqOKZA5+Nv0saDnMkdehzFSfbo+Fywx+9xZHfjJ+/XKNahC4Ht5txUKqA8Qa2nOJWrn
         p8ym747Ow7a9ZWO/UcALHhNTaDFFUS9EzQJQJ5ozajnAm0LU+Vxdi9FpTFp1gIBhgQ5K
         d38g==
X-Gm-Message-State: AOJu0YwVpHaKSAo5VfvABZf3zfhL2IT39m9YlkHk/cCsDJ8VUtMm2c9j
	j4bBC7jJj1MdGZHP6ccwGuk+3soZ3Bn8d1C2qk+ec+JAy/AIjn3kZyUG5zJRlQ==
X-Gm-Gg: ATEYQzwP+V1KA+GI7hx1dd4bsl2vYLj1JP0942OKM1wPE3nfx6Ykn5aTsdGUP/rTeAC
	yD66k8OSaCbv2ubX64VgWi6l6dEVM2LsqBBapD+Y62Sg2Ou4+NsYaWDXr/i2Tj8yCqRH8wen2h2
	BW8sbhfR0Zl0VhADPQoQh9JPUMG9SRSvpe2xrQwzeHEqBjyQJEPKKjTYJe8yVySedqnH+rD3Brb
	0wGoqQfbrtoHvx2Va64fwZ//SqVrVUM+e1J9jjAsG3Ryzem41CxBuz4GsAuU9zopvYDLQMj4S/y
	eu2cGo+4+3rQGBfZV1wU7kKtlnKItTFDEtt+dbar2+fWIkGqG+sRLcJTa7eWJZM4WIG8dAq+nRy
	w98WHz/CNQ6N6mDRpg8AW2CP5ofnD+hvE07BCL+lBr4KpfyaxYGX8GEAhvowaQP1rL7mqbVV6Pu
	0a/jYmf/sjOYu+owU3fQYAbiq1SiNs/lqXLicnyACVsww+I9VlLezcvoXuMO777llVzWuo3Jtyf
	W+e
X-Received: by 2002:a05:6a20:1f28:b0:398:c1d8:f58c with SMTP id adf61e73a8af0-398c6170cf8mr2321117637.71.1773235256843;
        Wed, 11 Mar 2026 06:20:56 -0700 (PDT)
Received: from d.iiitdmj.ac.in ([14.139.241.214])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf92fe7sm2281441a12.21.2026.03.11.06.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 06:20:56 -0700 (PDT)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH v2 1/2] worktree: do not pass strbuf by value
Date: Wed, 11 Mar 2026 13:20:40 +0000
Message-ID: <20260311132041.12044-2-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260311132041.12044-1-deveshigurgaon@gmail.com>
References: <20260311132041.12044-1-deveshigurgaon@gmail.com>
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

