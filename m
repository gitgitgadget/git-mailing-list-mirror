Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930D443A819
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 10:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011895; cv=none; b=Ht1xorVGk0VMhn9GfGoobGvxosNUWEwvS4RNweSWMB5QxaiNCUzJ1ZoiWW0PqiqIATWkof+33N6VRS/MGzsZHRyx2mbOAtfh214BIIz3s4zX954cgGtp6m+lmhOL8vWM5ip1yu1zwsCwGLY2csv/ha5/aIVpxE8n1p5KlVwHENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011895; c=relaxed/simple;
	bh=eINptiEh0HEgBrHo5vogclRzSwd9RuBh7zwDy4QeSe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhLn7hz9Mc119gAIfR5ymwWr1jIbb0qoYZQdyCVFLWV661IqLEaUezQpMD1J/kNiNIHpbM7XwR5/MCZiY/VLhaN+SMxEZ5QWJc4DiyUs5IBH2ZImzoTRz+q3NN3zL8XWYFe9nJUqvJPLpg1vwFcDerP4G2yDITfBC3GxzskGZ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsPwppuA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsPwppuA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso21535455ad.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 03:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786011893; x=1786616693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SxSJKRRZHo38ev0TfyUAZr4zl6AYoUU8UwlROA5fxPY=;
        b=IsPwppuA6S+Lo8v9T5LF+3LbPFXcVNSkx8I6RuuSlnlSHLA4/XiVFFGXrdha5nwGa1
         x/l2ewVSMHO+rdF2L1nctzlxjQpgEwq5RGjmP8CA4jvSroNNWMJiEUjHT0B31j2x0o8y
         UwEhMZLjPcJEMksvvzoBwTxgPi3irKZVZwhANaZgVIjKiqUpu5flibGoGFBjhJI8JwuT
         79D5dWlgf/oroPrrJeHIIKhXJA8GmKPmThJjf2hCljnk1+1dDRhiASCY0eeabTj5cR32
         19uo09XxwcWUAZuYDoMl9cRIpwtM0dOZiXvP390e0GaTG2/+XJftrZcVckxB7mzjzAbw
         /spA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011893; x=1786616693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SxSJKRRZHo38ev0TfyUAZr4zl6AYoUU8UwlROA5fxPY=;
        b=nhm7Gpygvg4CjRYmGJn81f0QImI925weJua3r0Z+mWN245FvB+tnVpOd2AMSidDtJB
         x9Wztst8cOTF9Rk9aMyJbPkywQKXfJSsbHcI+yx2fcpStlLClUTwa3mKUzml5YUhnWqF
         Q5AwLGsk6Djizq+jPXIekVzirFr7IHrNw4bAxco1hWyTqfn1jQjTq2cL2NaDThmrJb0b
         xg3Zg6UF9ZXEdRRMrzzufMNEITN4EGlwtmPM9cvaD7s9NqY0cEJzADmB4tlWWdkavrJS
         NXN1q9wXcKfl1bwmUBUrTZ7304122ksnePze1pjNrK44C7TpGtbKO0lZDbi60+VxLG5p
         SU/w==
X-Gm-Message-State: AOJu0YxLOxbagXCMmzJ9sHajgdrvGrDXA0gFIwU+d5AQYs+AQ1I9O8Gu
	U8iR8sHFsZJIZkwOxSxWmAfDtAGwFBJDYufIaXYYUf7Foq321MoTSEai
X-Gm-Gg: AR+sD10vX04v7G3nNbu+edMv2139kQbD1Gc1zN5Iy6jXIURHd2dJfNKRHgiUl2rMxzQ
	pqOqUy7FVOdBdRYGpuMcbdJpHiKW9QYiqghPAcz23x8EVlLIgH8tr1D3ICYouSlJVWaFm5o0cyj
	CgDcE9dEfjlSsNbFmFF5bw2xjpE+9erk97vxbXFhim7aEVoQOJwx8ptRpjQFx2ZOLwxzs+6UBkm
	mREUCjydyRu6ye7t5hVW3Glr854OiUjswcct8Wh8SkvYo6eBIMrg6lB4B/4yH2p+nIa5MV9N7m+
	Hs8Z8t6vf5a69UtApLajJI8NW2yWfssrPcqTLQDTB55elrC5NWJYtxByztqB9tGbZiuML2/Ih/4
	kzo9qVxD7+ZPztgeFg7P/OCQ+88YhvtliV+8UpRujo55PglmcB9dwKw41ZMueKE/zms1i9yfZUe
	DJjwBc554snehse3xjrwIQJ7tBq/wGNKCuTkVWyvHH9beVBmBjIE2YBQDiHj2sJLHKJ1/kGgn49
	k5VrFa3Pe9Qu1W0A7rqLJ7ekWwpdZgPJVLSY8abPPYx3HHa+q0tHErAnA/xndxrKiFI+5k=
X-Received: by 2002:a05:6a20:9c98:b0:3bf:7ab7:98a4 with SMTP id adf61e73a8af0-3cbadc97c0amr836890637.27.1786011892952;
        Thu, 06 Aug 2026 03:24:52 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b76cfsm25525901eec.4.2026.08.06.03.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:24:52 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC PATCH v4 4/7] repo: add path.index with absolute and relative suffixes
Date: Thu,  6 Aug 2026 15:45:53 +0530
Message-ID: <20260806101556.162940-5-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260806101556.162940-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260806101556.162940-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The repository index is a fundamental component used by Git and related
tooling to track the working tree state. Scripts that interact with the
index currently retrieve its location by invoking
`git rev-parse --git-path index`.

Introduce `path.index.absolute` and `path.index.relative` keys to
`git repo info`. This exposes the index file location as a scriptable
config-like key using standard format rules, allowing scripts to
retrieve it through the same interface as other repository path
information.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 12 ++++++++++++
 builtin/repo.c              | 24 ++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 23 +++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 20836cf8f6..08ef47750c 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -128,6 +128,18 @@ values that they return:
 	The path to the repository's hooks directory relative to the current
 	working directory. Respects the `core.hooksPath` configuration.
 
+`path.index.absolute`::
+	The canonical absolute path to the repository's current index file.
+	Respects the `GIT_INDEX_FILE` environment override. Returns the
+	configured index path even if the repository is bare or the file does
+	not exist.
+
+`path.index.relative`::
+	The path to the repository's current index file relative to the current
+	working directory. Respects the `GIT_INDEX_FILE` environment override.
+	Returns the configured index path even if the repository is bare or the
+	file does not exist.
+
 `path.superproject-root.absolute`::
 	The canonical absolute path to the working tree root of the superproject
 	if the current repository is an initialized submodule. Outputs an empty
diff --git a/builtin/repo.c b/builtin/repo.c
index d7c451a771..2a15327094 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -142,6 +142,28 @@ static int get_path_hooks_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_index_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *index_file = repo_get_index_file(repo);
+
+	if (!index_file)
+		return error(_("unable to get index file"));
+
+	format_path(buf, index_file, "", PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_index_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *index_file = repo_get_index_file(repo);
+
+	if (!index_file)
+		return error(_("unable to get index file"));
+
+	format_path(buf, index_file, repo->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_path_superproject_absolute(struct repository *repo UNUSED, struct strbuf *buf)
 {
 	struct strbuf superproject = STRBUF_INIT;
@@ -210,6 +232,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "path.hooks.absolute", get_path_hooks_absolute },
 	{ "path.hooks.relative", get_path_hooks_relative },
+	{ "path.index.absolute", get_path_index_absolute },
+	{ "path.index.relative", get_path_index_relative },
 	{ "path.superproject-root.absolute", get_path_superproject_absolute },
 	{ "path.superproject-root.relative", get_path_superproject_relative },
 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 1da5db4942..431a4842d4 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -237,6 +237,29 @@ then
 		'git config core.hooksPath /dev/null'
 fi
 
+test_repo_info_path 'index standard' 'index' '.git/index'
+
+test_repo_info_path 'index with GIT_INDEX_FILE override' 'index' \
+	'custom-index-file' \
+	'GIT_INDEX_FILE="$ROOT/custom-index-file" && export GIT_INDEX_FILE'
+
+test_expect_success 'path.index in a bare repository returns default index location' '
+	test_when_finished "rm -rf bare.git" &&
+	git init --bare bare.git &&
+	(
+		cd bare.git &&
+		ROOT="$(test-tool path-utils real_path .)" &&
+
+		echo "path.index.absolute=$ROOT/index" >expect.abs &&
+		git repo info path.index.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.index.relative=index" >expect.rel &&
+		git repo info path.index.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
 test_expect_success 'path.superproject-root absolute and relative' '
 	test_when_finished "rm -rf sub super" &&
 	git init sub &&
-- 
2.55.GIT

