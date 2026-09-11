Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C55369D6F
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138074; cv=none; b=n73dNE39A4xem0q/2aDgMcklprJo7KDaeq5xYU754xIVPqUnQjNqqm8Jd40ySgn3Jyz7H4M/QljdVlRdMeQfuv3SXM6XO4OXmTRg0Rq3iT9HJjlZaSK60jyY8mtpYLMR8OsLtN4iAsp4tvu9HO/RKG8+nj7KbHwLvTBgAmI90Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138074; c=relaxed/simple;
	bh=Neh+PPDGRnoSH/Lc1YC7eIW3YE4c2KRpefN06RbpkBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnR2rKezjLdR2jjNxLFOVGBdxAgCLC4BkWA6uaXhv0pWPXjWKDwLEeTnBD5f6KcLWIL5prwFIBm4lz9HL8WftjKIS5ojlmbNv3tv8b7Z0Y450hYJA3kzAmIL+66pmK+Vtb4RfGBpQc8b/yLs7iL5tEikLodtviPwCNwl4YvktjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4vYdTXO; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4vYdTXO"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so1507669a12.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 07:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789138072; x=1789742872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z2+wI08q8GU3MHbQ7rqU3DVNDch25VSyhMXcqfYM3PA=;
        b=H4vYdTXOPZVbBXaWRaplo8b9j0vkIr3z7ZPxsH/Da93iFa9mExuf9WzrQsAsWXJQ2R
         n+386sxb6e8GG8dqgW9ldPw1DXX4ghntle/yqb4xAJE3wOQ87xV7+ircZe+ydaf6KbQo
         iLLXILdOGTopwYLi3XZv4DBlT6Edm/xeS23rGGwkPLcGisNaNVC30pobqg22avKJqgRm
         FPj5fj+23ZXC4EYH6KU+0oZgqqUHOu6SGZb1hjsJFKK0XhxcPW8Ov1l6nxG5K345iqLv
         Bj3N31AW4aiH5SGwJyDuTi8QYfCnc9udRJMorzTlC/rX3fFRfNWNbPk0iaDsB3Bi9Akf
         KBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138072; x=1789742872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z2+wI08q8GU3MHbQ7rqU3DVNDch25VSyhMXcqfYM3PA=;
        b=eDSxcafXylOOjMNcCMQqjnwPxIXqqNVywvjIGICOzlWPy7C71oOY81c8sBLiD7GXpj
         ZcBwYqs/74O3pWd6jrHGIZ0C3agGt9uwnM76MW9CqX0vvTPseZyj07WHhXhMNVEFRro0
         Ip+C0G62uAWfnMidv6kYJK0fUUCELfNthhBmjwAmfrq6W9VLOdAbP7dgqB+JGG3M8VqC
         issIyWglOWml9i1aWzYdjL9v/vKHnRxSDFnbej7uOQoopfTSo0UoWbOIZxyAcEaWW9Fk
         5AqG7wua+Py2vKqzIsDEh4fsXOKIM4WfXQVhAc1kuR7VN/FohWxzdM/d0WGfpkj/svbL
         482w==
X-Gm-Message-State: AFuF++nIwF8drG03wmmdnac5VvRA1Tx0DOeGqdRjUPO5i8hbZKafCyOL
	JHeiAXzlcSuH8drbVtEtuO5ZzspxeKBWuM+RfPPuthiwrunKjrC1rKgB+HQsLA==
X-Gm-Gg: AYBFou2cL1rfoTnXw6J9KF8zynteQmSgiYHJhERRYYgJ3twNdSAR0g72aAEnzuVnGtL
	A5srhuZ22prktfXYHfyQhuIk1fz8Q6U3o9zSzrKxr8TgFyeRQfnqfNbqM32IY2NtRPzabJxmLsj
	eGcehJdiY/XFjjQIfIHJUvY5QuMwtOLLJYxv3TGDLJ+PTbSVHICC3IZcHg9IJYo7sSMYl8iiCDt
	ms+7AdMeSugbyyANB2lzshi2WFhcw36EtnEZCSF3O5VrtaSITPJnC/dKYumhO+ToCzLKkVSrGv9
	ci5R5lXgv19kHR1jQKXOMff6JEoG/05kuCV7H+EHUpMM2mmgcjLAXbWO4orUl1Wg8JwVkXfNaTR
	F4wVfXlWyCKRU8aGMnPyYYgDlWObEO2S+V0OmL7y6u129/VBuwGACJoA/SMA/mYHWt+2uC+tCxb
	Zu5f2I/BmjK9yDWtYytx71HfLcZ4olGcoTPeLtsVvEHyzPYVT5e+kfrKdVdSPt9E44jbfg9P2ZV
	DcmQRVR116qAnSwYU2yY9kUOBn8BFGI1G360OQ+Hu8EawXJEICY75a8RRh6+WaHT7xwYMyUTmGX
	0wsP/A==
X-Received: by 2002:a17:90a:fc4f:b0:396:669c:b5f6 with SMTP id 98e67ed59e1d1-39d7796cf16mr13030542a91.12.1789138072140;
        Fri, 11 Sep 2026 07:47:52 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b759d0sm7843335c88.7.2026.09.11.07.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:47:51 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v6 6/7] repo: add path.git-prefix
Date: Fri, 11 Sep 2026 20:15:18 +0530
Message-ID: <20260911144519.1011780-7-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts sometimes need the path from the repository's working tree root
to the current working directory. While this information can be derived
through existing Git commands, `git repo info` does not currently expose
it as a scriptable key.

Introduce the `path.git-prefix` key to `git repo info`. The key returns
the path from the working tree root to the current working directory,
returning the empty string when invoked from the working tree root.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc |  5 +++++
 builtin/repo.c              | 11 +++++++++++
 t/t1900-repo-info.sh        | 23 +++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 868ab0ed9f..fb5aceae8f 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -113,6 +113,11 @@ values that they return:
 	The path to the Git repository's common directory relative to
 	the current working directory.
 
+`path.git-prefix`::
+	The path from the root of the working tree to the current working
+	directory. Returns the empty string when the current working directory
+	is the root of the working tree.
+
 `path.gitdir.absolute`::
 	The canonical absolute path to the Git repository directory (the `.git` directory).
 
diff --git a/builtin/repo.c b/builtin/repo.c
index 33f97b03af..b5e1567809 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -100,6 +100,16 @@ static int get_path_commondir_relative(struct repository *repo, struct strbuf *b
 	return 0;
 }
 
+static int get_path_git_prefix(struct repository *repo, struct strbuf *buf)
+{
+	/*
+	 * repo->prefix is NULL when the current working directory is
+	 * the worktree root.
+	 */
+	strbuf_addstr(buf, repo->prefix ? repo->prefix : "");
+	return 0;
+}
+
 static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *git_dir = repo_get_git_dir(repo);
@@ -250,6 +260,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "object.format", get_object_format },
 	{ "path.commondir.absolute", get_path_commondir_absolute },
 	{ "path.commondir.relative", get_path_commondir_relative },
+	{ "path.git-prefix", get_path_git_prefix },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "path.grafts.absolute", get_path_grafts_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 7b0bb0ed42..10bbec8139 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -215,6 +215,29 @@ test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.git-prefix at repository root' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo "path.git-prefix=" >expect &&
+		git repo info path.git-prefix >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'path.git-prefix in subdirectory' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	mkdir -p repo/sub/dir &&
+	(
+		cd repo/sub/dir &&
+		echo "path.git-prefix=sub/dir/" >expect &&
+		git repo info path.git-prefix >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_repo_info_path 'gitdir standard' 'gitdir' '.git'
 
 test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
-- 
2.55.GIT

