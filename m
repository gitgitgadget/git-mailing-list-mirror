Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5B3822A5
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790509603; cv=none; b=iQtLK2g+q486xqNGNOSNqBdMoy149Zwz4IOWMg/8wk8/8Tx4M86N23D+KjBPbW4giEik1aK+LaN6i3lG7SjDWeFAVqNsPACGSqBHfqcCJH5eNswxaFzYD0cLOZmhJDX2kiHbe/SMgXwThmSI8NoQydSkTPdWcEL7pk89Ys4yGac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790509603; c=relaxed/simple;
	bh=rISTUhZ1pKouZIkrrg6bTCMT4MRz5GgJMw5FluTJMJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSoa6/XD6rys2XjQ8fbywA6+5Uu+iNUfx27SMKksISeOQaixCXiK0ui1O0DQ4Hn3ggF518JhkYLKUE1clTMZEphkgI0UNuLfANzUaGNikEc5TsUgA/F8ASLXBohU6I2gBOIR67tvcBpLEMbH7NBC8Rp2Sq8FERgG20be+Wa72fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTbC6ryz; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTbC6ryz"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-342773d94a7so1022790eec.0
        for <git@vger.kernel.org>; Sun, 27 Sep 2026 04:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790509601; x=1791114401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2H7nwgCOG6FPN2ii30hPl6qeB5xHqOhLFRvH4rDKYV4=;
        b=iTbC6ryzW1w6NUOi0V2VcUa+LEEq5qAt8UTuVICZHEIxkYvCCM12a+1LShlf03YIl5
         PwYSb5pv43QMLMeqRcA3zJMZ9C2mmIEXtuV2fm0frOA4tPxdb+a3pRwVq+84y9SLSr1B
         KeDjqIRckYawVLvqMThLdj01Gpo8SQlJdLuwN9yhjlVpbJ44yKpNJAgGnwuwc7DnOrHm
         fhtAJM4JF/ntfOGD4YmmH0SOLlOoEeF19DewX5PJjN5PpegVHP8pgjZqDwGx8gftr3TJ
         QSKfybbdc67p9ygyeDZrYdqKocJ13Ds6PRV45Xvmq1Vxc+EJa78HRxHPkBK1O+vrHHB3
         qhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790509601; x=1791114401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2H7nwgCOG6FPN2ii30hPl6qeB5xHqOhLFRvH4rDKYV4=;
        b=SeSLahuEXmjiM/PjP9zI0QgZqIv33n2txXnu7OR0vWQoyylsv2EgAsJ5KMf9lVjJGD
         f9h2bG6eqhS79lFpy8F7rjntzAgVMu2XiSdpeTuTwCUudEJ69ZKe8h7R9nHkiEUxb25Y
         okOGYywwaXT6mIILHG8szuNOVTWsQsO/5unpGVIwtQM5SHc9XgHciq+I04AuqpgrQnDc
         7vW5tPQ2gHMTzxjhHweZt4Cj1FzSq/99hCMGJVwtxxOR06UIe/DTwRjOksPQYODKZDry
         yFLAFfDrMcfQgOx1Za6DPqVcbVI7P136eikF+s8DOqbD3PhYlv5/jF033h82r18Pu4/W
         XWPg==
X-Gm-Message-State: AFuF++kZDqI/A2SIW0upqk5bUHY/Hh4mdrCx7oRGIUcKmZIrLpzCz4y2
	s7rWss5P0bd0JpXq4IKbcZOY85slQXxJYJOgDBE3ji0igaD6mAbmeF38
X-Gm-Gg: AYBFou38vrbcY8iUm7fVdd67c3CQ6vyTfqqUgsp6nxEFQFOwID2sM1oCe7jLyuWGRE1
	wFIyHbaX1D1pofumTe1LQHH93zDS+Foc8s3yTrR2HmOHTfAi+35m2O1NRSZS1/YFnRTIpH6XWJV
	PjV25decWhrZZ5t2NDwLJPfiCP66HNP1nvW43WuxRYKRT8KWyiT1G0Cp/VTNtmAh8S/3hzQ/1bH
	zroBdlexqS8UZWhMr/y3aCpOZ4EzlTpAqpWSr7ljGCRYxRh1ocLk2xupRW+6LI4DP4YLS4daLIj
	yIGhqVxH7tzML2QUfcQ+IQdZ7dguOf9e0SMxjHQowQLL1/jTKXC3UE6mMD5oCc+rxq4zIcHtk/D
	PiYUJ04MfWP68/57Tmvh8XMjQOUpmqBVyGUb/WdvzuCqf5b3LhlPxnqRvDbwpIYTfiBCeMct2mU
	dZ/7WF3vLqg4/zlyXBwwG4sURKFR3eoUw6+GAsolF61ad9tGH3ApDDr7Luwi2s/R5lH9sF4Udts
	nKSd8Iz9HwC/+TJwFnsFoD6LJxBvxZrYK25/6KDfJ7OtCKhlmcTiVCSfzWrlVdeEcp2JFiwLGdA
	3JhS
X-Received: by 2002:a05:701b:2042:10b0:143:298e:913b with SMTP id a92af1059eb24-146d096b3b9mr5779179c88.45.1790509601220;
        Sun, 27 Sep 2026 04:46:41 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm17450424c88.0.2026.09.27.04.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 04:46:40 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v7 7/8] repo: add path.git-prefix
Date: Sun, 27 Sep 2026 17:14:19 +0530
Message-ID: <20260927114420.59724-8-jayatheerthkulkarni2005@gmail.com>
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
index 8144b74361..ce78cdc44e 100644
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
@@ -244,6 +254,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "object.format", get_object_format },
 	{ "path.commondir.absolute", get_path_commondir_absolute },
 	{ "path.commondir.relative", get_path_commondir_relative },
+	{ "path.git-prefix", get_path_git_prefix },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "path.grafts.absolute", get_path_grafts_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index adc4a92487..b689445b7a 100755
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
2.56.0-rc2

