Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817A48CD5E
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680765; cv=none; b=tM2r2F5YOxxsqSilLuF9alv62MRDu9EMxdTspgw9cp5HmIn+1IKcQNSYgLfeNf8K8ODvSpBbRsxoRqVGl0E4+9y11N7ttRUxchngbH3FLzAQdbS1yn/mi3mA4/3trUzr7SYohvz9qe+7OsxsZidpJK+zcsNFd0FHekmrgXJuMKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680765; c=relaxed/simple;
	bh=nwt9nxEHqU9siYKFuvTALlYu2uI+3pKvoICYWEgsZN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojTVvfjUisxL/DFLli3I/dbFUHO5mHz14BRAMU72zVTjBxJHDO/YDx8mCRVJaTx3zOGO9VD6BzdpYWJuQaLT25cp0juHA/BBXHp6+/IerBdScO656KwD1F0nMkUTPJkRRn7yqasFl9uhRNocrPSR+wAXEhOjrq/SoV4uiQjmtPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtIiOGML; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtIiOGML"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e041ea211so186986a91.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787680763; x=1788285563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ByEN84H5JRQiUNGbtgZOocffYahQ1w251ssolj35yI=;
        b=BtIiOGMLz5oBDt3IZaONAnDI5MNBRiJ2CucStPC1LmsdMFG2BJ++jYmgLfojneIq5Q
         xwZdJFMuCYvvlvbHCvwX52u0Cmf53chJJg5yITYWilKJmX9eLbE8QJELv/MuOP02UE/j
         CewADfWAiOa4rRPkl4xdFr3+H7stq76E7aZtVQO7YOArr8WV/6m8qcoaowwIfeAWlCB+
         3wbJ2YkdnVTldEIx4fVAAuj4ehQfvk0f8bRyo0OlXh145MayDp+rW1disqAv3m4rsq5w
         Gf9ZNrXWM/3mRg5n9LEpPgbwuOb1BsgJFHtSg5OpIF6OoREgtdRPBh2WCxsjbwgIVkNK
         p/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787680763; x=1788285563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ByEN84H5JRQiUNGbtgZOocffYahQ1w251ssolj35yI=;
        b=iwQs81AAgWdAvJqw2j50u2hiE20XN25UxFz1ib2yMnxuBuhdx+cABpwGrJ07Tdb5eY
         MQzmWY7C8yW7zPcbp2SuaXmt4NPQmClZbU2dnA/ZVa+PkmbhLIiOrAQQMy8ZIQ5k97rQ
         N5ZA0Q0XBNEp18p29DNNQCMB9hIgXIxOIjhGOOcO4Fx23gYN4k43AQZOd/ULxufNTnuw
         PDai+advmdTDyy/H4zVLSdnfSDrIX0j3ehu1uxG1wSWWFtssQCgWjr5vjkxBRy1m3mO8
         DZJ4StYUidbMf5ccm8pqjtCtq0MbxjCB/9NURBiqQdBBDyhfsALanKX9mOjsTmU07FKN
         y2aQ==
X-Gm-Message-State: AFuF++m0u+kAxikV+irfs5/QHGFzqZ9xzXJ3iElp3o61Vb+yI9qbPsFT
	BoYCVqM4z8MsMOQG/jaABnFFqbih/IvjPaNVcsTqmBxz898eDMcFUFb0
X-Gm-Gg: AR+sD11fsdpe9SXdwao4sXtLAgu06Zbf1f3xq4igK0NFosWC/RoOM0nnw7v4E239Cy+
	nqca5TGvyqXzzCrGoyL2xwdfZeffXmIvqYnF2im128PNAXDYJzmIRzaoOpmoIsH1O8pSVqnGu7h
	rYa0cLU65gPO68PgLoMANLLojjrx8VYqGnhIIQ6yI19kd5q0KeFPLLvX0Ov9WjMuVbHIF34217Z
	+f4mVJ5RFvKz88yO8u2slmKirbMsJxb6ltlzPctZvyeMTbqhrHcRPkqbWB1evDB9U6vrayLtgDs
	OEoFgg+gW4zl2i9YBVb5/dVLxa0iNty5Tv4fEO+NOcRRJL1/mNVHEJyOJs6pMfSuqkzZNuxtdk7
	YApDtCSdKqcJRmxqExVJp7D4iHYf7zUKxnjCsyx+pbmnJE8Z3XEJAhmZzJLvt9oDkun4fbxK9SC
	7gDE3z0OX4+puEesxy7fnKAHOxd3i4FY0HgbmjpWHX68naHmer0u90h5oRd/4FyJ3XjLhZASDuX
	Or2dSaIMzDLocbKGE9ACl/1AUTJhbGLCbDltaEdrafqMJ7pJHqQ6DdIBgI7GXkqxaUG7m6MN3Y+
	fEUSvw==
X-Received: by 2002:a17:90b:5291:b0:38e:e9b:ffa4 with SMTP id 98e67ed59e1d1-3966d45a53dmr1839765a91.6.1787680763084;
        Tue, 25 Aug 2026 10:59:23 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8e118fasm954417c88.0.2026.08.25.10.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:59:22 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v5 2/7] repo: add path.superproject-root with absolute and relative suffixes
Date: Tue, 25 Aug 2026 23:28:13 +0530
Message-ID: <20260825175818.645579-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260825175818.645579-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260825175818.645579-1-jayatheerthkulkarni2005@gmail.com>
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
index c31e9cfa70..47c4fce293 100644
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
 
+static int get_path_superproject_absolute(struct repository *repo UNUSED, struct strbuf *buf)
+{
+	struct strbuf superproject = STRBUF_INIT;
+
+	if (!get_superproject_working_tree(&superproject)) {
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
+	if (!get_superproject_working_tree(&superproject)) {
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
2.55.GIT

