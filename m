Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0283D331E
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790509522; cv=none; b=WRQMuAwf97iB++QcPGfD6Plmfj4c8TuVEx64oV9xpy7urTjphtDt8wHnCQxbWXsLatDiM2tvswQ8LAooISsEc/9g21LET0QK0L4xhsQukHG/EmgLI3kWdSjx+J3oPpckems3gFMu2gy+bgu3PJXkqrS6iL547p+7i9pANWaCc8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790509522; c=relaxed/simple;
	bh=aS+7IWol2jM2TUSr6RbXDst0IyOfnp4w1NjRlSRvgpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNO44hqzCNJiA6HCiVw1n+jznVC+CA8aSm1bGYkT0CV1nKl+d8zSFCC/ZdMWmmnBQxLXY/03/NUXbIuRN4YFhnvxSgSGy3U/GiLHTS28kxskbMwI14UY+RNIiCsE+fbeipG7Cx62do4ZbOML1TKqADqQA/Hd7vAXByUx1Saxv+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWkTNIfG; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWkTNIfG"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1450541ab18so2523079c88.0
        for <git@vger.kernel.org>; Sun, 27 Sep 2026 04:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790509520; x=1791114320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IWZ1N1fVFoTw8gQPGChLu7yRZ5cE6qJOAwLKYpSwjkw=;
        b=CWkTNIfG7OgNZ3Scx2VUIR5etnM5rtQAhxE24b8eHFjsDBOZDLBpHZaZFUrxFEzLtH
         E1eQgC2DKwPcFT1EuRqVkik6hLng/mrMbmfKQ2rKUg6kwa5okOENWqvMqdzpVic+dCw/
         OJZJOwLVwNJdvbNzEEdSHIEgLLftkKvKvU91UX2Q0ju7pNTD5N3XW0WAocg+PmIxoj3K
         s8nvgEJxhz1sfPg91pQtbUbAZHKVWiRkdmhdm6cyitnoErarqjptkhgAU25BKhn34E8y
         QamzHEUhD9agR3XCF4mYsLUqcGtG3RNx7+TGj5dpAYDuA5vQUN/AyaIz3LO+4PxI1Iej
         ti5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790509520; x=1791114320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IWZ1N1fVFoTw8gQPGChLu7yRZ5cE6qJOAwLKYpSwjkw=;
        b=0fbSB4b1xLu3LhpgxWCTpGLdMaNjjRNVNOFK27rVmbEVPuvYxdLuKQ1zTjy2C2NJf2
         RmY5rNzU0CnjCD9jSD3eT9FufoE7AZrhxKxGp/7eup9MQcNgpfeUjWFwVM2/o2jNk9WT
         NMOxroifxgWqVo5iWzL8McSaWATr3hs/C8ydK0DTFiFpRS1GJLEpJtfesW69lt+QQVqa
         C7H5AvkkH2+eHm2naHXnaqI6WbgdNRbTtl2bOeWOFMwUnQ1EQvPk7aqhnic34lnZSJcM
         xs67AZanJffurf/D4MaEjF0WOfhkYhoWmOeQO63Hyybj+yFoW48YW5UACMvyetC8uWGb
         3x4A==
X-Gm-Message-State: AFuF++lL3kmVGJv9ZyBO81eHplrd3i1/Jrd7Zm3iU0hcHkWJy1xySaSF
	bIBcLQUof5AAC2XknvfSSe49qaqyxOlXJYzK3RaW7G0MOZEtGsyZsAx/
X-Gm-Gg: AYBFou0CpJCtjg5kwGYk0abVKcJkGUn2i0Eo0ibtk8EMpBLInPrMdVYM6IAsHynO9l3
	z5iq3gAQWLDDvdL+LlWSfKsCTTY7lcWdGO2P2dZ6hUA5PKPh5zKmoODlsWYeBRDNdxKbXM74biK
	3yfLxKVFSZK3FtxP4p6erJp+od7prsSKrxMAF1ed8ejP4vMUMe8XNsZm/NusfxoLNBv+2Yi+ODA
	mRB80o28lyYoIz6PmEbNx8npnxHpLYO9XnFy+F/kvmzUdWfSA4BX7hjJMciTb5h+9QU92ADdp7H
	b6H6qgtXelRHJ4mkYq432o8jJ/Zy4XyPGaHaKI/W1hriLjdpluTy5c+YeBGMSRfKjGxkrJ49ME2
	CPqJCUXti/KrFeY9s7WkDKOy0I4dZVdzV8akksnY8NxI3tgoCv+g1USyuw6AbkLC6wRKToTAuLK
	ovcL1uTHP4OiLZ9IiZO4mVM0iaDc86l9k1KaaYdB0HmsQBcc8Vn7JGCPiRzOojPGSA/p115zuA/
	YH01v1LMqcrM41V+JBhoHJtu6xtJRg/ZvTbfIORnQXbvtr55b8GG11WyWisuGyGrQVQU5YBJv/G
	erkh
X-Received: by 2002:a05:701b:4305:b0:13b:3bee:1e2e with SMTP id a92af1059eb24-146ce77543dmr7138313c88.18.1790509519869;
        Sun, 27 Sep 2026 04:45:19 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm17450424c88.0.2026.09.27.04.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 04:45:19 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v7 2/8] submodule: use repository to find superproject
Date: Sun, 27 Sep 2026 17:14:14 +0530
Message-ID: <20260927114420.59724-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.56.0-rc2
In-Reply-To: <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`get_superproject_working_tree()` currently uses `xgetcwd()` to
determine the repository whose superproject should be checked.

This is incorrect when `--git-dir` points to a repository different
from the one associated with the current working directory. In that
case, the current working directory may cause the function to return
the wrong superproject or an empty result.

Pass the `repository` to `get_superproject_working_tree()` so that the
superproject is determined from the repository being inspected rather
than the current working directory.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/rev-parse.c        |  2 +-
 submodule.c                | 43 +++++++++++++++++++-------------------
 submodule.h                |  2 +-
 t/t7400-submodule-basic.sh | 19 +++++++++++++++++
 4 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 43693454d5..e1a6da0076 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -997,7 +997,7 @@ int cmd_rev_parse(int argc,
 			}
 			if (!strcmp(arg, "--show-superproject-working-tree")) {
 				struct strbuf superproject = STRBUF_INIT;
-				if (get_superproject_working_tree(&superproject))
+				if (get_superproject_working_tree(the_repository, &superproject))
 					print_path(superproject.buf, prefix, format, DEFAULT_UNMODIFIED);
 				strbuf_release(&superproject);
 				continue;
diff --git a/submodule.c b/submodule.c
index 6fcb606f7e..4db90ef9b0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2610,34 +2610,35 @@ void absorb_git_dir_into_superproject(const char *path,
 	absorb_git_dir_into_superproject_recurse(path, super_prefix);
 }
 
-int get_superproject_working_tree(struct strbuf *buf)
+int get_superproject_working_tree(struct repository *r, struct strbuf *buf)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf one_up = STRBUF_INIT;
-	char *cwd = xgetcwd();
+	struct strbuf target_wt = STRBUF_INIT;
+	const char *worktree;
 	int ret = 0;
 	const char *subpath;
 	int code;
 	ssize_t len;
 
-	if (!is_inside_work_tree(the_repository))
-		/*
-		 * FIXME:
-		 * We might have a superproject, but it is harder
-		 * to determine.
-		 */
+	worktree = repo_get_work_tree(r);
+	if (!worktree)
+		goto out;
+
+	if (!strbuf_realpath(&target_wt, worktree, 0))
 		goto out;
 
-	if (!strbuf_realpath(&one_up, "../", 0))
+	strbuf_addf(&one_up, "%s/..", target_wt.buf);
+	if (!strbuf_realpath(&one_up, one_up.buf, 0))
 		goto out;
 
-	subpath = relative_path(cwd, one_up.buf, &sb);
+	subpath = relative_path(target_wt.buf, one_up.buf, &sb);
 
 	prepare_submodule_repo_env(&cp.env);
 	strvec_pop(&cp.env);
 
-	strvec_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
+	strvec_pushl(&cp.args, "--literal-pathspecs", "-C", one_up.buf,
 		     "ls-files", "-z", "--stage", "--full-name", "--",
 		     subpath, NULL);
 	strbuf_reset(&sb);
@@ -2648,14 +2649,14 @@ int get_superproject_working_tree(struct strbuf *buf)
 	cp.git_cmd = 1;
 
 	if (start_command(&cp))
-		die(_("could not start ls-files in .."));
+		die(_("could not start ls-files in %s"), one_up.buf);
 
 	len = strbuf_read(&sb, cp.out, PATH_MAX);
 	close(cp.out);
 
 	if (starts_with(sb.buf, "160000")) {
 		int super_sub_len;
-		int cwd_len = strlen(cwd);
+		int wt_len = target_wt.len;
 		char *super_sub, *super_wt;
 
 		/*
@@ -2666,12 +2667,12 @@ int get_superproject_working_tree(struct strbuf *buf)
 		super_sub = strchr(sb.buf, '\t') + 1;
 		super_sub_len = strlen(super_sub);
 
-		if (super_sub_len > cwd_len ||
-		    strcmp(&cwd[cwd_len - super_sub_len], super_sub))
-			BUG("returned path string doesn't match cwd?");
+		if (super_sub_len > wt_len ||
+		    strcmp(&target_wt.buf[wt_len - super_sub_len], super_sub))
+			BUG("returned path string doesn't match worktree?");
 
-		super_wt = xstrdup(cwd);
-		super_wt[cwd_len - super_sub_len] = '\0';
+		super_wt = xstrdup(target_wt.buf);
+		super_wt[wt_len - super_sub_len] = '\0';
 
 		strbuf_realpath(buf, super_wt, 1);
 		ret = 1;
@@ -2681,10 +2682,10 @@ int get_superproject_working_tree(struct strbuf *buf)
 	code = finish_command(&cp);
 
 	if (code == 128)
-		/* '../' is not a git repository */
+		/* parent directory is not a git repository */
 		ret = 0;
 	else if (code == 0 && len == 0)
-		/* There is an unrelated git repository at '../' */
+		/* There is an unrelated git repository at parent directory */
 		ret = 0;
 	else if (code)
 		die(_("ls-tree returned unexpected return code %d"), code);
@@ -2692,7 +2693,7 @@ int get_superproject_working_tree(struct strbuf *buf)
 out:
 	strbuf_release(&sb);
 	strbuf_release(&one_up);
-	free(cwd);
+	strbuf_release(&target_wt);
 	return ret;
 }
 
diff --git a/submodule.h b/submodule.h
index b10e16e6c0..1a465a1208 100644
--- a/submodule.h
+++ b/submodule.h
@@ -170,6 +170,6 @@ void absorb_git_dir_into_superproject(const char *path,
  * project is a submodule of. If this repository is not a submodule of
  * another repository, return 0.
  */
-int get_superproject_working_tree(struct strbuf *buf);
+int get_superproject_working_tree(struct repository *r, struct strbuf *buf);
 
 #endif
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index eefdecb0bd..5c3d9f2829 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1549,4 +1549,23 @@ test_expect_success 'submodule add fails when name is reused' '
 	)
 '
 
+test_expect_success 'path.superproject-root works with --git-dir' '
+	test_when_finished "rm -rf sub super" &&
+	git init sub &&
+	test_commit -C sub initial &&
+	git init super &&
+	(
+		cd super &&
+		git -c protocol.file.allow=always submodule add "../sub" sub &&
+		git commit -m "add submodule" &&
+
+		SUPER_ROOT="$(test-tool path-utils real_path .)" &&
+		MODULE_DIR="$SUPER_ROOT/.git/modules/sub" &&
+
+		echo "path.superproject-root.absolute=$SUPER_ROOT" >expect &&
+		git --git-dir="$MODULE_DIR" repo info path.superproject-root.absolute >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.56.0-rc2

