Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB1E1AC45D
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785062797; cv=none; b=i0psm4gCf63CE5U1JXaq9b8a1yrZaNMY4nHE/o2XX/AjBsxCseqtl5KI8nJfFJNRbi2vqwZ4195K8oJtJkXO14i2HQFBezokU+n9i7P1yumUnmY9AolNV7mIq7QFu9UgSjSDi0nw0G80MANb4x4Q9HRntN8LFa/3UqWrRfLES8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785062797; c=relaxed/simple;
	bh=gBxtLgBnRe2rTIgqqA2+IWzU+wP4Hwbj6sOoyBQRxk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDNUA22RMvKMAn4Yp/BAkQjTEjEJ7g7Pnf74kyOOk/tfHLkLbeCmX6IwmUkpCm3CoZ3P4Ki1wzSusLDZsKQwV31tcl/sIz0JUWkPqWFVY/Ip+KZC6OA2hn27hzViVubMDIl50QJoUiMiruDs81GT1/Vb8kqiNY6XboxfRwwNjHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtlpC8qB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtlpC8qB"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cad8076b01so20657685ad.2
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 03:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785062795; x=1785667595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/DrLJmQCDQj+bZw2nSj+aKcT6URRBo7QKSnOEGF4g0M=;
        b=GtlpC8qBTNadPx+5ZfkrIlgiUYC9F9vmFBXPLDuSjW0Won894n/wKZZnkCq29NPaoj
         R35AMIFZ6R1AMbZ+2FcaB21Q+KKHWDun6mKv+M6TNYSwOhJJw6uWEgum69gFfuhFftOt
         pBJZkESXCUBAI1IqnL2vKwRYUlTV1Xz8ZgVCK4hOIQVS/j63s8+i2P6jgyHsQnWY8D2d
         4ENDV3IKUGkcEQph/QPI+Dw+VWiLoxslnHpaedwFxWtIYqw1GQ5ZNl3bGhfhsdr4qwGF
         SGu0WPn7FBLO94VdfZcFaRysgMJRbkzWkLlGFCNSdkQqO+VEolNAVV3MscJ+KAX+kl8d
         56/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785062795; x=1785667595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/DrLJmQCDQj+bZw2nSj+aKcT6URRBo7QKSnOEGF4g0M=;
        b=QC/++Yr5ym4b+G1Ouim6BK0AAc/+bBEVlXTaRLhUyt53qd5+N5EYvIw2drD44X1BEK
         67sh5t2JoaZJ2/L2RTpCUeI1oY/icdmYWoiJ3fcEPShyF/u/cjQuvNKgiMUn5Bb0Urfb
         WnDj0P4dhILBbQysdutn4lN3WM19B5NPGoyg6xhcTotSeE9dwQT/jShYSFRXycu4ASAX
         3iHIIn2+GJ/pnx9Mpzi0/ixid+RbuP3P7k/QwmuKCyAtKzr9o/I67p6MOPWTECU7DvtQ
         gcGF4fawlWsIzZkIleTtV8YwagffmVOEk3TZQnOYvTZ6u9Z50NKNilDSMOKZPOLJx31b
         Qp/g==
X-Gm-Message-State: AOJu0Yyp+3QjUTzmvZJx+lGEwmaLlGFYdUCC4UsXtZ7RrNfWhOqk8LoG
	Y17i5zFV3AyISY4JF/MdJZ5W5LYtYVqfi9fyBqW4l56NCXhZWMgEfE3Q
X-Gm-Gg: AR+sD13Sly1qqSI4GCULfw+kFrb4xqI2G5A6VBS/mYg9S4efenzC6bTrMDO8fqLbDWH
	Hj6YROSh5ftHqnIMn0Kydp9C2fJPwOYiCc5C7MxhaJX9ofmSJQacjL/lJmF4Nkb0mdwaujKugxE
	REPQR8E2TkbUH//GCOlkPQ5e+1FyLaVswb8eQaKnJmGcUC9oVQvvH2oxzJ6jHWUhK28S0d8SPSF
	VRv4N/SgIgjpIGgsYe9jGUQt6x+/EYXC7ytU2ZSOusEXwQbxP4NFN2WTPf2XyABONQsRxYlc3kR
	2vYJYwcK88ZRBF8ckv1e4Cj8h6P8BH6nbnJNrAaEFivDY0VK3i+1uiictIIVoEynNGdrHcKa9CK
	J+4Ge9tytcieU95LvsefmHgartYb/c40STtT9E+5YElp1eTP9/FUOMvGmbTKMMYioq3t4/6FnfD
	q+SsfSMBg5+1GaLUpIJ4rd46Z8+JHLWrsoOyIHVw2kC8gPfh4pkkGCxwsBGSwmnAMALgA1NCZYL
	JppirveT/of
X-Received: by 2002:a17:902:d4c6:b0:2cc:f4d4:299c with SMTP id d9443c01a7336-2cfde84b842mr41475275ad.25.1785062795479;
        Sun, 26 Jul 2026 03:46:35 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1255sm30371438eec.4.2026.07.26.03.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 03:46:34 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [PATCH v3 2/7] repo: add path.superproject-working-tree with absolute and relative suffixes
Date: Sun, 26 Jul 2026 16:13:38 +0530
Message-ID: <20260726104343.16933-3-jayatheerthkulkarni2005@gmail.com>
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

Scripts working in multi-repository setups often need to identify the
top-level working tree of a superproject from within a submodule.
Currently, this is only exposed via `git rev-parse
--show-superproject-working-tree`.

Introduce `path.superproject-working-tree.absolute` and
`path.superproject-working-tree.relative` keys to `git repo info`.
This exposes the core submodule context via a scriptable config-like key
using standard format rules.

If requested when not inside a submodule, the command returns an empty
string.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/git-repo.adoc | 10 ++++++++++
 builtin/repo.c              | 33 +++++++++++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index e34abe5fea..03aa57942f 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,6 +119,16 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
+`path.superproject-working-tree.absolute`::
+	The canonical absolute path to the working tree root of the superproject
+	if the current repository is an initialized submodule. Outputs an empty
+	string if not in a submodule.
+
+`path.superproject-working-tree.relative`::
+	The path to the working tree root of the superproject relative to the
+	current working directory if the current repository is an initialized
+	submodule. Outputs an empty string if not in a submodule.
+
 `path.toplevel.absolute`::
 	The canonical absolute path to the top-level directory of the
 	repository's working tree. Outputs an empty string if the repository
diff --git a/builtin/repo.c b/builtin/repo.c
index 194757eb18..82359473e9 100644
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
@@ -121,6 +122,36 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_superproject_absolute(struct repository *repo UNUSED, struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (!get_superproject_working_tree(&superproject)) {
+		strbuf_release(&superproject);
+		strbuf_addstr(buf, "");
+		return 0;
+	}
+
+	format_path(buf, superproject.buf, startup_info->prefix, PATH_FORMAT_CANONICAL);
+	strbuf_release(&superproject);
+	return 0;
+}
+
+static int get_path_superproject_relative(struct repository *repo UNUSED, struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (!get_superproject_working_tree(&superproject)) {
+		strbuf_release(&superproject);
+		strbuf_addstr(buf, "");
+		return 0;
+	}
+
+	format_path(buf, superproject.buf, startup_info->prefix, PATH_FORMAT_RELATIVE);
+	strbuf_release(&superproject);
+	return 0;
+}
+
 static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
 {
 	const char *work_tree = repo_get_work_tree(repo);
@@ -163,6 +194,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
+	{ "path.superproject-working-tree.absolute", get_path_superproject_absolute },
+	{ "path.superproject-working-tree.relative", get_path_superproject_relative },
 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
 	{ "path.toplevel.relative", get_path_toplevel_relative },
 	{ "references.format", get_references_format },
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index fbb9063ee5..220b3d4d3d 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -213,6 +213,40 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
 	'.git' \
 	'GIT_DIR="../.git" && export GIT_DIR'
 
+test_expect_success 'path.superproject-working-tree absolute and relative' '
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
+		echo "path.superproject-working-tree.absolute=$ROOT" >expect.abs &&
+		git repo info path.superproject-working-tree.absolute >actual.abs &&
+		test_cmp expect.abs actual.abs &&
+
+		echo "path.superproject-working-tree.relative=../" >expect.rel &&
+		git repo info path.superproject-working-tree.relative >actual.rel &&
+		test_cmp expect.rel actual.rel
+	)
+'
+
+test_expect_success 'path.superproject-working-tree returns empty when not in a submodule' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo "path.superproject-working-tree.absolute=" >expect &&
+		git repo info path.superproject-working-tree.absolute >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'path.toplevel absolute and relative' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.55.GIT

