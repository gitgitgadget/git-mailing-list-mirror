Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1735B631
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677105; cv=none; b=RmvfknEO5mexrgHRCQa/oHxPwr06KF/DkJHW2Jjjjs/0WHFPDAmmsUUEsXlNA6QypiCmQeIstA3CmaWLuFMaIN8SZ9y7coXOKEPqCajCzlhVFIScC3nG4B7RvVCaOpZbd0q8yx33OW7FviWL2BRS1lavy/gD/GgDaQNX0qC0bao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677105; c=relaxed/simple;
	bh=3wh0jdVaVByGY11+ColrpqfgN6WXfqPrbM9i2dgpmZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rc7OcfpbFyI6Q7/2+YJgx4Xm7zpHY2CN2UrZ9MeX3sDXEvdIiNdKcSr4K366dv5x4d5IsqT20y2lbqwtlOCqRusGpF/lAtEEene3iAeA9uxcKGqYT1Yju0rmB2yTHj3fCPzbhJdmQ99Y2l/HTx5O+baWDPv2p6xGtywvYKLsyf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHkULc42; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHkULc42"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf1f074a12so21984205ad.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780677098; x=1781281898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2hs5XaNJzSwWRt1I/4zp6+L8/9W4Ac2938qY8D4dmU=;
        b=FHkULc42VzO8jeQKV/ocuQ49YIe262LrVGd8t9yPCL4yX6w8B5Z0s2SmFnepSrr8Mc
         jVzD8bs+zNV9gF5dXY3AUL5Erd4KS96Ba0vnMMwjfzENJDtRQZ9h+Ti7y5QyyNU6BTwP
         P3HlwrF+kXVj4d4cZq6GAeFnPGLUAoa7U+OjdDf1HtXRKBkIUtpeg0SRptug8NY66KEZ
         s8Cf+4w+R4ZjooZ/x6U1r26keSRm6PMU0Fs96TD8+xjYoGHwGj0jBYE0ZpdRQkpNZYx/
         q5ZzdOjPsoS6oS3f6ssgS0Kdd0SvJGo3ijRL9wm+7D2NBJTOYgIRK9LkRGQE6AwkWWky
         21eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677098; x=1781281898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g2hs5XaNJzSwWRt1I/4zp6+L8/9W4Ac2938qY8D4dmU=;
        b=It1HzF86r8M2wp1IkUE+40cFbQyp/NNpmQJmdaBRSEsNWb0DI5ViX44Adwxc8/g6RS
         fXYSf6V+W1RsWlmMePSVoRpiRY2bTgSeDwGkVVtZgaBhURLfQUOx/lX3q2X9buvk5/tT
         WNZg8moonydAEC4E51sj1VZZUPKIqKNFWPLMvcOG8my0bmdIIlLXwsq3kfPnUF2CMylQ
         huLfOXz2dqV8ACJnaWH2DYOrNjlS5nW20KKYkvOWv+HmP4OpQmCBqkomPpWcoQbhLZtd
         WnZmI1txk3ccPBc7IsjdV+9+B8EZi3JUVM75VjMaKGt7VWR1iFhM7VYEWgyc7/I1uvLT
         DNeA==
X-Gm-Message-State: AOJu0YzuDArJySq6UosWiJC8q9+TawZN5fY6CpEuJsYQoIuR/BgX3cVh
	6VGj+BbKINb0AEjPncT+oTj8poZ5azQd16zqqxylBEdfjNSBpWxmZM12XjnKXw==
X-Gm-Gg: Acq92OFbUMrI5hdbtk8xeJJgnSdXoZfrn0iNEG7BZ1n0CvWBS+02Pymnm7RkZmbPeNu
	0vRknyjxoJEMmziLsxvtOuwer5X4DEI0p3KJRC6oe5LyWragsftgPtU8v1trV7LkU8ZX9ZleGKz
	bwr0viH5fmuHAagTnBoF03uJWTglxO8LVDtAsVisdZkhWQ6i5hI9MiJF/buvS/Bwdm7Sy1huUrd
	dSUotm8cL/vVPuzbEXIyjH5FkOA43tUGxm+fS8Hcz1470NRDH30VSYTe9xckDnWzqNGhit6Wd1L
	L3o0Dt7GpI0lFQq0uHX5LYA/a2GwQhmqBdALZSz2hmIR3JZkpSWyjeTSsJO5dbxlCMoAC/aa7oO
	TUKhul+JghFZBxlaV/7LNU9UMvs8Pd9uKoB0IEHTn2ErvxiiUMG9cs8XkZM4mkgKHy/AXavaNQc
	IxcTZ6jvenAgDTtd5E8ryxYifcB3tjPGn7bw9s3MW4Jp9qT4HUOCHjUNWjOiqnmC2oIiXAwqN/I
	QY+1NLAatC2qxfbb0GlapuysTtPawsniP+Wra4IMkhZ
X-Received: by 2002:a17:902:f60d:b0:2ba:4e84:966 with SMTP id d9443c01a7336-2c1e85e0896mr44132845ad.36.1780677098387;
        Fri, 05 Jun 2026 09:31:38 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f85de1sm95883955ad.20.2026.06.05.09.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 09:31:37 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jayatheerthkulkarni2005@gmail.com,
	a3205153416@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net
Subject: [GSoC PATCH v2 3/4] repo: add path.gitdir with absolute and relative suffix formatting
Date: Fri,  5 Jun 2026 22:00:11 +0530
Message-ID: <20260605163012.181089-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scripts often need to locate the `.git` directory. While `git rev-parse`
provides this, it relies on command-line flags to dictate path formatting.

Introduce `path.gitdir.absolute` and `path.gitdir.relative` keys to
`git repo info`. Exposing separate format-specific keys instead of a base
`path.gitdir` key avoids default fallbacks and requires callers to state
their format requirements explicitly. Both keys use `format_path()` to
resolve paths.

To test these keys, introduce the `test_repo_info_path` helper in
`t/t1900-repo-info.sh`. The helper evaluates paths dynamically and accepts
environment variable prefixes. This prepares the test suite for future path
keys that depend on environment overrides, such as `commondir`.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc |  6 ++++++
 builtin/repo.c              | 26 ++++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 42262c1983..a0dca7ce88 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -104,6 +104,12 @@ values that they return:
 `object.format`::
 	The object format (hash algorithm) used in the repository.
 
+`path.gitdir.absolute`::
+	The canonical absolute path to the Git repository directory (the `.git` directory).
+
+`path.gitdir.relative`::
+	The path to the Git repository directory relative to the current working directory.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 71a5c1c29c..6e97f6a0e4 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -7,12 +7,14 @@
 #include "hex.h"
 #include "odb.h"
 #include "parse-options.h"
+#include "path.h"
 #include "path-walk.h"
 #include "progress.h"
 #include "quote.h"
 #include "ref-filter.h"
 #include "refs.h"
 #include "revision.h"
+#include "setup.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "shallow.h"
@@ -75,6 +77,28 @@ static int get_object_format(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *git_dir = repo_get_git_dir(repo);
+
+	if (!git_dir)
+		return error(_("unable to get git directory"));
+
+	format_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
+	return 0;
+}
+
+static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *git_dir = repo_get_git_dir(repo);
+
+	if (!git_dir)
+		return error(_("unable to get git directory"));
+
+	format_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -87,6 +111,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "path.gitdir.absolute", get_path_gitdir_absolute },
+	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 39bb77dda0..0660b00bbc 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -155,4 +155,37 @@ test_expect_success 'git repo info -h shows only repo info usage' '
 	test_grep ! "git repo structure" actual
 '
 
+test_repo_info_path () {
+	field_name=$1
+	expect_absolute_eval=$2
+	expect_relative=$3
+	env_prefix=$4
+
+	test_expect_success "query individual key: path.$field_name.absolute${env_prefix:+ ($env_prefix)}" '
+		(
+			cd test-repo/sub &&
+			expect_absolute=$(eval "$expect_absolute_eval") &&
+			echo "path.$field_name.absolute=$expect_absolute" >expect &&
+			eval "${env_prefix:+$env_prefix }git repo info \"path.$field_name.absolute\"" >actual &&
+			test_cmp expect actual
+		)
+	'
+
+	test_expect_success "query individual key: path.$field_name.relative${env_prefix:+ ($env_prefix)}" '
+		(
+			cd test-repo/sub &&
+			echo "path.$field_name.relative=$expect_relative" >expect &&
+			eval "${env_prefix:+$env_prefix }git repo info \"path.$field_name.relative\"" >actual &&
+			test_cmp expect actual
+		)
+	'
+}
+
+test_expect_success 'setup test repository layout for path fields' '
+	git init test-repo &&
+	mkdir -p test-repo/sub
+'
+
+test_repo_info_path 'gitdir' 'echo "$(cd .. && pwd)/.git"' '../.git'
+
 test_done
-- 
2.54.0

