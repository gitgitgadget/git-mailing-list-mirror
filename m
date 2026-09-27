Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8362E36A34F
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790509563; cv=none; b=YerjktjYkLv7hQDSfrhQN1zxVRAjilhclyQUEkX/HHUlWux/YPSfzKjqWlLf2DZgMIci1Bep5djeK0oIDWhKmgmqM0QG5++bGNE9uX/IuUQ98YWA2ow/fIkv91l5rgTY82wtJVOed+6aLpZVlkg83bmB6z5oGD/2do6Fz9oTwC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790509563; c=relaxed/simple;
	bh=/T74tvpUHwFMCft8CpCJZsUV8JKyswU67I/BYWxQYDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNHN++YGYm4MV4ZOGyp6T9jbdhgilglTSYyopjdocs+ZixjdeufbTjXHr45CC7U5jXC+KeF1gEZ2j49/mzf2G9BF7KhIHe3aYRhntQ2RTTNcxHDWjiXgQN1QnqqtYQYeOA25mi4OB47+yp1lqE0jyJFAHtIW/4SmKnXwA4bZ0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkfA0a3W; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkfA0a3W"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04edb5so3474628c88.2
        for <git@vger.kernel.org>; Sun, 27 Sep 2026 04:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790509561; x=1791114361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jL6HP26fsqS0RhDUEnkTsfUVlB7BdgyIAT26sOiKYgg=;
        b=nkfA0a3WZ/jybQ1OLA+PsVRTddfFt8pZAhesyFbFeiA75veJLXKlBWlfbWLeE9xOvd
         S1jT5LjHJnve0rYJDIpHHcICmbeGvlC9eKpff3umauP+AasitwK9Bjh3/tgxwChMm8bc
         jIllNkLtf4yY7/doAGqfcZhIiGzLFQtCyIs3I/ztETy3a4g9Hm3VCgVYcuSVrg87C0Si
         ESqjkQ62R2BPoD+azi2bjpeSAWqEdg1JxiHaijrbirKFf6DAHwcrQILaVDOVvRXobZU0
         f2oN14/xA3QJc3rH0GaXp/uCkYHqvg2STTVPBHwtKtuImIblBcp3ADleqkHY8OyG+Vcq
         sR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790509561; x=1791114361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jL6HP26fsqS0RhDUEnkTsfUVlB7BdgyIAT26sOiKYgg=;
        b=V4n4cU0EuXAgUr0uUiFVT3wQJzmsJsE+kmvhJ68/zXiUvyHVf6rduas9Un+kHgqH9o
         YFHWcC8L9mWaDIzSe9naIkAZM4bmHvQXkBOVF894xZrCutC0p1dYbh97Ns0xK0vdl0kE
         rqvWl77JUhs+GuwHzdNvGkm8Q3SH8cfSEmFTN/XEJbqs1vTuUZCii7Y3c2zy5CRSxxFB
         xRSGgX4iKnJfVQuMLlZ4x4YNDY20p7vdrwXHwDtflSmpjdFebZFPLNzco3pF32MjqTG2
         vU30FPb6JR6cEWn5/urt8QqC14xw9v3jpCNiPzySVpfJ+MNljZbYcPQYzmZ+z6PKaCqu
         vvqw==
X-Gm-Message-State: AFuF++lob7YGybkpuw4h4bqP6CYeelALSV0kI/H6nmBvgRWedvKz2iEn
	FKijtAn3grCFxJiFuArXoKbORWVZt8Jffm+Km+TWKf+NSMU8YkPjjZ+C
X-Gm-Gg: AYBFou2rwM2Q/0JRJZoVqXmsN4ngR4vHCTrjVRANjVcoSkuRZ8x7DNfEtHd8ioweA0/
	g97xetgO8WzJjXOsExeWuBPZFZQ3cX39JkQUMdrBQ8/sLPNL2i8p3+nZQcf78AJPbogAf5rAj0w
	kKk5XeaClJHzYLa6Y+no6YGRXnKOFYT7gxI3Ar7SyNRKM/faG4EfnpoRtu0RRWPtptc/1K9fYuj
	3n/yEKWyjq0SDgQEtHsq2nYOMnZCBMjwfkVIxpGQHBOoEhBLPeoypU183ZkZC3wpErlqsGtI9Lm
	KytCVtffpjABAIcLi9Ik+zTreh/7iV2CoMIEop0jzfX6s1AkTQmI3iRnag8TnjDBlIm9TrbvCK9
	QuYCn0yrU8JSy5xOThp13IcBZFBP0TTzhwk5Sl1Mfj7Ig5R8/05pJKwSEz1v1452BcZRWrBP0Ne
	dQpiEDN7ucZAvtW0iX53mmzQ+/aSLM+XpVzq161WV0dlc/QGCn1Amq0Ulet5MZjqQeyiUS9YeyS
	76JPU74T9Ox+1Sh8CJFWNvCyOOooVRVMzwCmpWZETYOudF1VpvJl4Cb9B25wrePMmfiQEn5TTON
	CC02
X-Received: by 2002:a05:701b:4659:b0:143:868a:20c1 with SMTP id a92af1059eb24-146d0c4ff29mr6158539c88.46.1790509560535;
        Sun, 27 Sep 2026 04:46:00 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm17450424c88.0.2026.09.27.04.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 04:46:00 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v7 5/8] repo: add path.index with absolute and relative suffixes
Date: Sun, 27 Sep 2026 17:14:17 +0530
Message-ID: <20260927114420.59724-6-jayatheerthkulkarni2005@gmail.com>
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
 builtin/repo.c              | 18 ++++++++++++++++++
 t/t1900-repo-info.sh        | 23 +++++++++++++++++++++++
 3 files changed, 53 insertions(+)

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
index 01666dc17c..a4ea2022eb 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -142,6 +142,22 @@ static int get_path_hooks_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_index_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *index_file = repo_get_index_file(repo);
+
+	format_path(buf, index_file, "", PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_index_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *index_file = repo_get_index_file(repo);
+
+	format_path(buf, index_file, repo->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
 {
 	struct strbuf superproject = STRBUF_INIT;
@@ -210,6 +226,8 @@ static const struct repo_info_field repo_info_field[] = {
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
2.56.0-rc2

