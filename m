Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A38B4908DE
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785062757; cv=none; b=ZP80ZYtISReSOj0gKHNhLr3T4cpDtqZpeS6PTgUhrEci3Iu21pkpSprgN6bjrC+H4CWsA9XZ736B/2WAV0uWWa4jA5WP5xL9FB2/zLtINCAzurn+fYjfydNeQPI0Q1Gv8soYUon8k94QcIw2xe4aNR9pRHdItfmPppWiT3tdb4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785062757; c=relaxed/simple;
	bh=HW7s/iKJcFiYpIJ/oBWNUp5EVNoxeA8WOGBGzw+yC1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkk7xa8TYXcT65TVPkXR5P5KVrSLVCbXph8I94kq1iflAhVc/VOwGPtqxQwk1txNTNsBWHgjGv80D+QzCDEKLeoEQaU82s6gQgvYMzLyYyboVej58Fa/LecQ6mrUq0ADirPI4NlxFgcohTur0p3owa725fPEj+np9etQkgs+/ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNP7ALjB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNP7ALjB"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso1426976a12.3
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 03:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785062756; x=1785667556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SqLtY1pIMDFxHEBpyrjnsIsRQiasQFf0PmrhcaXPWv8=;
        b=VNP7ALjBz2QN9oVlx0ZhFs++2zx533uzXzJ+qBvrabI/Z/20tzFdptHMcP3YWsC0Nx
         o4DUcvwp8q2ZfmPw7FZaU2n9Kx6RDUhHGanbVs09ENVZXs4GaE0F1MkrP1KZhkmxTAYP
         PiliQL5Jme5Y8RQQwyfqkJvuT2tfWQgvkUXfN6nwbtWc2U4H5dBei0hlPqLXkASa75je
         NK7vQvxjUShQTDCVP3OuPeG57eCfSb0AeeYjFbRoNiHBOK3Tx/wwmppn+h0cG8zRXuN7
         OXNxG1FLapH3x9uvRcl9dHwJapGyttA4a5bKQDg6Mw/jo7Ya5XFj2TIXQDmdMGK7D9Ff
         EmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785062756; x=1785667556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SqLtY1pIMDFxHEBpyrjnsIsRQiasQFf0PmrhcaXPWv8=;
        b=A+67GQ5GnHax4YNpmApEpzKNym98re94gqjqzkeHscxcQLiRBd9/gRgvUXKzFvitCR
         416Oaq7lzQcghKn0uZGLu106RHDh/fFO5fzsaAhz+I2O4pHV7eu7rZTCvrQYNq3nv80A
         WFGaItoetnWfy94AG/X6a9Qvkr/UJinKOcwwl58OMTMeDmM/Wh5QpIWyY6GBhAADiB8z
         Taytuz4JBnevDv6mqjj3bZOVe1t6HpWEwd2qboG8CzDmsBaHc6strFJI65fHSfFGkN9K
         k8EvQINXrHsVzEjLGc4hHvZWRk4idx4MA1na9dwv2gHyMCit2S8hnqQtMWFPhVz9CRlm
         pVTg==
X-Gm-Message-State: AOJu0YylTNIztQtjDDmZ1CcugyefjBYhZ5RzFukzQkhX5IBx6FPaEPzN
	moQI5UybsK/T18wPG2s3QHooW8jrC6qFrqxSbvB4O2mW6UYkxLDRmFi0
X-Gm-Gg: AR+sD11s6vL4AVw+DJ4bgyNfSjl0pG/3JbNLc/IwjMThGHBfE9QP4xCoXaRJHZ4J4KP
	n6DNNTTvYi21j49UMYQKPDlkg8QWvpgpoR653AEIRVCtZJ19Z/xEvJpHB25gSgGRwCUY3pn+wbT
	OC/CXgpHMOZTBrxxeqjMVlbiNA4WC4ofymcncShqDnMSbWUfRbc0uHEFCfJZjisOVkUUgg/082+
	LfsTQ3+EsLit7eUmqFRHzVt6uhbSUcRO/giP2/rDF+aJ7+9Yx8aoFolqvuK3kNamqe7a6tFQBsX
	rA4NWJkc6DF28PQwLdLcaINMbI8PfMDNuL/UiuGvtjPtbBt+Q+UZDaVlpME0r/VLNcItBXzH4DZ
	CwlsY1TXtdIn6mv2A0g9VlKSrdSxKrgYQg5miN7NPAZL0FREM0yYuvO/OlZfHU4LP+rwWN8Dkqd
	AwbumbHB3VZ3jIj/jEoBhOoBdR70fZ8P5/W7PP5ZOSOFfcRU4mAquUTJTE1mWo1HMtNzWWEIPr7
	whCKpSo6qhfenDUKx/d7cg=
X-Received: by 2002:a05:6a21:9992:b0:3c3:69d0:c573 with SMTP id adf61e73a8af0-3c67e02574emr4816703637.68.1785062755630;
        Sun, 26 Jul 2026 03:45:55 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1255sm30371438eec.4.2026.07.26.03.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 03:45:55 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [PATCH v3 1/7] repo: add path.toplevel with absolute and relative suffix formatting
Date: Sun, 26 Jul 2026 16:13:37 +0530
Message-ID: <20260726104343.16933-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts frequently need to find the root directory of a repository's
working tree. Currently, this requires using `git rev-parse --show-toplevel`
or inferring it from other path components.

Introduce `path.toplevel.absolute` and `path.toplevel.relative` keys
to `git repo info`. This allows scripts to retrieve the top-level
working tree path in a predictable, strictly formatted manner without
relying on `rev-parse`.

If requested in a bare repository where no working tree exists, the
command returns an empty string.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 10 ++++++++++
 builtin/repo.c              | 28 ++++++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 30 ++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index ed7d80c690..e34abe5fea 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,16 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.toplevel.absolute`::
+	The canonical absolute path to the top-level directory of the
+	repository's working tree. Outputs an empty string if the repository
+	is bare.
+
+`path.toplevel.relative`::
+	The path to the top-level directory of the repository's working
+	tree relative to the current working directory. Outputs an empty
+	string if the repository is bare.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 042d6de558..194757eb18 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -121,6 +121,32 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *work_tree = repo_get_work_tree(repo);
+
+	if (!work_tree) {
+		strbuf_addstr(buf, "");
+		return 0;
+	}
+
+	format_path(buf, work_tree, startup_info->prefix, PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_toplevel_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *work_tree = repo_get_work_tree(repo);
+
+	if (!work_tree) {
+		strbuf_addstr(buf, "");
+		return 0;
+	}
+
+	format_path(buf, work_tree, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -137,6 +163,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.toplevel.absolute", get_path_toplevel_absolute },
+	{ "path.toplevel.relative", get_path_toplevel_relative },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index ae8c22c817..fbb9063ee5 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,4 +213,34 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.toplevel absolute and relative' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		mkdir -p repo/sub &&
+		cd repo/sub &&
+
+		ROOT="$(test-tool path-utils real_path ..)" &&
+
+		echo "path.toplevel.absolute=$ROOT" >expect.abs &&
+		git repo info path.toplevel.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.toplevel.relative=../" >expect.rel &&
+		git repo info path.toplevel.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
+test_expect_success 'path.toplevel returns empty in a bare repository' '
+	test_when_finished "rm -rf bare.git" &&
+	git init --bare bare.git &&
+	(
+		cd bare.git &&
+		echo "path.toplevel.absolute=" >expect &&
+		git repo info path.toplevel.absolute >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.55.GIT

