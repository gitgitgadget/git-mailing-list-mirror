Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714DD2DB7BE
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790509529; cv=none; b=FS3kIpmo1ohfWcLy/qOB9kuo4P4eSg92jr1c/i9CwitS1Llo+kOKipXDU9QxZrbnqZKOGB6PPget9skdmPMo0YFufY3V+oa8CMbDGzW4nIGPHAPfvLTmQDeYWJZmADdh4/bTwI4GMujksIFi76BgwAMxQA5sNwvc38CdeMK05ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790509529; c=relaxed/simple;
	bh=hWL6dd0PCT6sn/2E/xbLFOKRgbBL3GJkXQToz0xecJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUPYeXO/zsPAqv+dslSZjAeI9UGEDwVuB3BioCVduSqX4Qn5P+4FX8bbLvWeUCAAmX5Hd/spsw82fpg0ntcxFF7OrhtzhAdbt6hoTcuh1f87xxRvMix3daaViRWIkJmYGXiMS+c9ySwp642zJaKwrH4/nh3cTzZ5q3BZ5kz+AVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3ZR8dxu; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3ZR8dxu"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-3468ec309afso144956eec.3
        for <git@vger.kernel.org>; Sun, 27 Sep 2026 04:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790509527; x=1791114327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mpfPC132R6aZtVzOsG1KxOhgyDJiWKnllpHeL0xA+Qk=;
        b=R3ZR8dxubcwB3uXrfh9LiZHptXhd9VmOT9u5ALkshE22GjFqpDrSkOPEsO95AF0Kjw
         aELzTi5MabYhyekq4SK4GF/zoB/QLbfdrQaCLt7UcqqUWS0O01Eekqd5R+Rw7r/YPq7K
         V8xBss9fEtmA5Tt3i8uqFlWmZr8IajK0EY787bbeuc2fW8jVBDVzGWRV4IzKt36MOL+N
         QdV2U533Ygn34UhWqW3UOfq58OtF0O/QuSAuI5T6Q15Z/wC1tDCCXOHHSGsg+e4Slf0z
         jT/guRHizmRi+B1bTMAjDCWTOGXXS7qfHU8zYvrynD/LZf0kgQC+Kfrt9LJINzfGLSaq
         kL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790509527; x=1791114327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mpfPC132R6aZtVzOsG1KxOhgyDJiWKnllpHeL0xA+Qk=;
        b=taBpso1V9nV3e1wd56W0+rzYC8PS4M25Wz1tTLo+mMI2J2Uy7S98sbCDI2zBAY4b2e
         atMSeMzV+lb+Y0EjyrIhxHP1jU2X3SxNph7WVr41MsZQZD2eYahzIJvVgKbMjCOUrABy
         lsw2ayAKxHVidvsNQY0dO52bhD+Mis/fSvFLIs204sI64mHuhGnM96SlCViET6MVb+Oy
         znv1BJIYDCKONk4kFpuDZRXYAOTJqOO5PnOfm8xVIhykKuRT4UqtHTIZd4GyKxnrRdtv
         1kA5nYDvMQhcO3rli/b5VguUxSao1JcVLq3j3BZVrh3W/NNLre2dnsmO5gM/eCvXO0wq
         Fw7A==
X-Gm-Message-State: AFuF++klKfR+siYHOuFpbkVq4c3RuMF48dMkH47ajpRY6gZVJaOb2q5T
	kaSieQeuOtgR8uF2V1+Lezhemq8dqvs0GwUNJZVCuwTLjZtowkugmLYB
X-Gm-Gg: AYBFou0ypwd+wkq4whj+WPtGyT6Q+VLcltPDCtonx33sjaMUrmzmTsWxHLLKZU5RpHD
	dL2HEHThxW4r9tntDqntJx04TCzLlLkQr0Cr+OBFEV60tOkh6fJiWepgxaMRnKdMD0EbwZlvgHJ
	6toTd8RjCBC5ehgdq5bJMMM6fRj+02H7Z18JXfE5XKjHPlxvoYoWVTSPTgBWGwPQXjAPnEKCMSw
	WmagPznMKIlHJnDmn9wnclDFjRUW6bOYrjquVu3Urts8BvbLxsXh2XIUYO4PpJS1+fob5NGrufZ
	ODx7YOzjvEq94lQzLjVLg4+rFrLB/b/rxvUaH/r4WnoeRfcJ6KsBgnj2c9ithM0pi9aE1CTEN+w
	msUMjHFjgjWKlGKLZVaTDsJE8kHQ+kaEy/Y6RkUrN4IJ5Q3kjGTlyioZvcJ7/MuM2Uc0rBoJrax
	FE5exmeEZ72HW6FWqLKUxXoRCFM/n4XXU0TpZ5bVS3W/LgiBQN0ew9QSXvlYgw3LA62aGvraMt8
	EfdXsz74i7jsRLkUI5u5ThFFCTabipGHz31igYlJqRN4sKgnIDY5DLMyG3Nj4gP0CLsxF8aEB1Q
	zrWz
X-Received: by 2002:a05:701b:2919:b0:13d:992:ffa with SMTP id a92af1059eb24-146cdebd327mr4496172c88.6.1790509527270;
        Sun, 27 Sep 2026 04:45:27 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm17450424c88.0.2026.09.27.04.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 04:45:26 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v7 3/8] repo: add path.superproject-root with absolute and relative suffixes
Date: Sun, 27 Sep 2026 17:14:15 +0530
Message-ID: <20260927114420.59724-4-jayatheerthkulkarni2005@gmail.com>
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

Scripts working in multi-repository setups often need to identify the
top-level working tree of a superproject from within a submodule.
Currently, this is only exposed via `git rev-parse
--show-superproject-working-tree`.

Introduce `path.superproject-root.absolute` and
`path.superproject-root.relative` keys to `git repo info`.
This exposes the core submodule context via a scriptable config-like key
using standard format rules.

If requested when not inside a submodule, the command returns an empty
string.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 10 ++++++++++
 builtin/repo.c              | 31 +++++++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 39 +++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index e34abe5fea..e524a07f53 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,16 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.superproject-root.absolute`::
+	The canonical absolute path to the working tree root of the superproject
+	if the current repository is an initialized submodule. Outputs an empty
+	string if not in a submodule.
+
+`path.superproject-root.relative`::
+	The path to the working tree root of the superproject relative to the
+	current working directory if the current repository is an initialized
+	submodule. Outputs an empty string if not in a submodule.
+
 `path.toplevel.absolute`::
 	The canonical absolute path to the top-level directory of the
 	repository's working tree. Outputs an empty string if the repository
diff --git a/builtin/repo.c b/builtin/repo.c
index c31e9cfa70..27ebb7a1c9 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -18,6 +18,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "shallow.h"
+#include "submodule.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "utf8.h"
@@ -121,6 +122,34 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (!get_superproject_working_tree(repo, &superproject)) {
+		strbuf_release(&superproject);
+		return 0;
+	}
+
+	format_path(buf, superproject.buf, "", PATH_FORMAT_CANONICAL);
+	strbuf_release(&superproject);
+	return 0;
+}
+
+static int get_path_superproject_relative(struct repository *repo, struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (!get_superproject_working_tree(repo, &superproject)) {
+		strbuf_release(&superproject);
+		return 0;
+	}
+
+	format_path(buf, superproject.buf, repo->prefix, PATH_FORMAT_RELATIVE);
+	strbuf_release(&superproject);
+	return 0;
+}
+
 static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *work_tree = repo_get_work_tree(repo);
@@ -159,6 +188,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.superproject-root.absolute", get_path_superproject_absolute },
+	{ "path.superproject-root.relative", get_path_superproject_relative },
 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
 	{ "path.toplevel.relative", get_path_toplevel_relative },
 	{ "references.format", get_references_format },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 9417d1ab65..eec576a1d9 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,6 +213,45 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.superproject-root absolute and relative' '
+	test_when_finished "rm -rf sub super" &&
+	git init sub &&
+	test_commit -C sub initial &&
+	git init super &&
+	(
+		cd super &&
+		git -c protocol.file.allow=always submodule add "../sub" sub &&
+		git commit -m "add submodule" &&
+
+		cd sub &&
+		ROOT="$(test-tool path-utils real_path ..)" &&
+
+		echo "path.superproject-root.absolute=$ROOT" >expect.abs &&
+		git repo info path.superproject-root.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.superproject-root.relative=../" >expect.rel &&
+		git repo info path.superproject-root.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
+test_expect_success 'path.superproject-root returns empty when not in a submodule' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "path.superproject-root.absolute=" >expect.abs &&
+		git repo info path.superproject-root.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.superproject-root.relative=" >expect.rel &&
+		git repo info path.superproject-root.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
 test_expect_success 'path.toplevel absolute and relative' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.56.0-rc2

