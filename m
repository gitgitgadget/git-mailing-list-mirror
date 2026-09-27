Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30716379960
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790509502; cv=none; b=Zup1DygTNYAUn4M6UqTStGuR8PSPPUAzSBPILfE3c+eqU1/HefP68vnCWVAAu398Axiw1O0fQwq15k2QEGmaQnecS/3gxRP+MjGE2nQUIvTQy/UEmAEgDxC3uBRqHvhCKb828G4QbRYcm0SkfAamIpMauNTYubTrvTLZjYpczmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790509502; c=relaxed/simple;
	bh=4TXZ1WekAZeJDjQxpBGO4zaSfYo9kaLENE5uEk7wofs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKg+B1s5TS/20UJCLKzBaLUnzGLcbb/z61IIEiyu2X2lxvoueIvpsK+FImkx5an2+crEUEQbHs+f97lrD87GF7EyHsU05k5BubxVOgahdRYcL1PrMyx/mZc5i/ttYLMUFYRNanIEuwaWXc+3x8S+DEQbodj0z7FLiKIBkbayDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtVMrir1; arc=none smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtVMrir1"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-148b5c829e8so320185c88.0
        for <git@vger.kernel.org>; Sun, 27 Sep 2026 04:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790509499; x=1791114299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T7O+UzJJ82DDcGg3yZrGWXqNZY3iFXPMTmcCORGapwY=;
        b=gtVMrir1SMjSuevNusvt/nRMXyNnWSW1Y9Ytfv2+C54BQz7T2p3AQ6t85hvR3a8wAx
         klxPpurn5BKCP7bP40D9s+h+zDTvI+wRm0Idjkxkz7Wwj2AkIsuCDUOQZe+e6jSB99f/
         a7gKXkHuVJNC5c4sfGFkOBKYGZ/nqSNpUyKU8QpuwhOuJ1JBCxru3jjVc+Fi61v5j+W/
         w5w98OZVtn3u3q0rdnP7XW2aSzQfrmRhDfbLz/i9emV43CJ5lTgj0VQP5td32frp1B2z
         OsIEkqegsbY9lS7ygYHoAvkU0NboL5ddzotYPa0ZOTq5EkQb3JLpQtSCe5C+x9w+BDGH
         sFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790509499; x=1791114299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T7O+UzJJ82DDcGg3yZrGWXqNZY3iFXPMTmcCORGapwY=;
        b=W5ykl9B9jNj4iT4Ed0mdGLJrnYBP8Up4dfI6p+XWWyRqGAql/WIdfbzRbGD88Q/ZWP
         /N2MV3OT3ztm5YR46pfXHYCReIuaN+Q5tnRCS1p5ryln++IVqDt9Y6VEp0cKpm/ERF+W
         p3StoO3W0zB5YDR1RpJPU7Uhg/VLVvfAEu7v3+8MpGwrN1Z4hBqWXfVC/yiRnhPA9vUf
         YgZPrBB7SRl7RA6E3KJ0lX2fhDNEnbvi2WXvC5yTbMZIWkcsU0EGSosvc/SjLsbvgkEK
         0VSaB9vRXMYUOJB3ceHw3LUxHCdgYsJKKkjmIfyuJSsyFYG1w0eLcpL1F8bCgJkPXT6S
         IcHg==
X-Gm-Message-State: AFuF++l1q1s8zXD6m3WS+iyDtoi0c/Wwb3X4ZaoesRpXpFIHeaMbHnoC
	DtCK+8vXlFxLxP97ejHSBjiHmCrUIJYvMG9PAr/G1+z8EhR9w++tNF3p
X-Gm-Gg: AYBFou3GF7+PvcGsp+HSqZGN43PBl3sxzAaZ8/uiIvil2OeiMoml10jepg20FRHplzT
	arw5G66Rqx81Yb4m14uW90n60vkGxl3dux6AgViK49JKS5UZCzi4r1FOsnjxtzwaBAa4Bqq/LBG
	zu8QKmvZmuKStMcIQMJLD/BSl7XKvKuN2VfpDQOTdNDg3hEbO9hC2dS/xpBvVz4gmdNLZZMl/9f
	mENCH9e/3BQyEhqOfz7RwD0qhsPjD9NqlsJAY/A+SLaVZVHApn03I/rh9P6yw9XIC25r32Lxq0K
	C+FD548DiTzREoX/Hg8YqT6GVF1vxo0B9Vd+70jv2TLunSWaPp7d0EzX4aZalgKYRjiTwJt0z5b
	RonXjChAxtKoZKFOJTKaXaMQQqKe+zTmmGfHXsap5yw12clGmeeL/z9p0uv6ZjITlFOIOx36vJJ
	p7BzkZhj9u0KkDWa5Kot+xgz9Z7VNZ71YBd9UFZP6E3fpXSOz5ikZwkvUwxaIDamx14EERqAYEK
	Ublrb2/A5ZZpR77N6IgVCQfeyWiFqTP2GZOaztHpcO3FarypwOkSR+lZoP6xhDEXH7/vsKklA7b
	5K4liXxsDnFuoLc=
X-Received: by 2002:a05:7022:3705:b0:13f:b41f:bda with SMTP id a92af1059eb24-146ce2a2451mr6760683c88.16.1790509498602;
        Sun, 27 Sep 2026 04:44:58 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm17450424c88.0.2026.09.27.04.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 04:44:57 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v7 0/8] add more path keys to git repo info
Date: Sun, 27 Sep 2026 17:14:12 +0530
Message-ID: <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.56.0-rc2
In-Reply-To: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Series adds keys to git repo info.

Keys output paths of repository components:
* path.toplevel: repository tree.
* path.superproject-root: superproject tree from submodules.
* path.hooks: repository hooks.
* path.index: repository index.
* path.grafts: repository grafts.
* path.git-prefix: prefix offset.
* path.cdup: relative path to top level from subdirectory.

Keys support suffixes for format.
Commits contain documentation and tests.

fix a superproject bug where it now takes repo parameter
instead of just depending on cwd.

changes since v6:
* The superproject bug fix is now a commit of its own.
* The dead code in index is removed, we simply rely on the helper itself
  and not write any new conditions.
* cdup now works even when the worktree is outside the current working directory.


K Jayatheerth (8):
  repo: add path.toplevel with absolute and relative suffix formatting
  submodule: use repository to find superproject
  repo: add path.superproject-root with absolute and relative suffixes
  repo: add path.hooks with absolute and relative suffixes
  repo: add path.index with absolute and relative suffixes
  repo: add path.grafts with absolute and relative suffixes
  repo: add path.git-prefix
  repo: add path.cdup

 Documentation/git-repo.adoc |  62 ++++++++++++
 builtin/repo.c              | 153 ++++++++++++++++++++++++++++
 builtin/rev-parse.c         |   2 +-
 submodule.c                 |  43 ++++----
 submodule.h                 |   2 +-
 t/t1900-repo-info.sh        | 194 +++++++++++++++++++++++++++++++++++-
 t/t7400-submodule-basic.sh  |  19 ++++
 7 files changed, 450 insertions(+), 25 deletions(-)

Range-diff against v6:
-:  ---------- > 1:  27b9811163 repo: add path.toplevel with absolute and relative suffix formatting
1:  d4f3253256 ! 2:  7c90603a1b repo: add path.superproject-root with absolute and relative suffixes
    @@ Metadata
     Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
      ## Commit message ##
    -    repo: add path.superproject-root with absolute and relative suffixes
    +    submodule: use repository to find superproject
     
    -    Scripts working in multi-repository setups often need to identify the
    -    top-level working tree of a superproject from within a submodule.
    -    Currently, this is only exposed via `git rev-parse
    -    --show-superproject-working-tree`.
    +    `get_superproject_working_tree()` currently uses `xgetcwd()` to
    +    determine the repository whose superproject should be checked.
     
    -    Introduce `path.superproject-root.absolute` and
    -    `path.superproject-root.relative` keys to `git repo info`.
    -    This exposes the core submodule context via a scriptable config-like key
    -    using standard format rules.
    +    This is incorrect when `--git-dir` points to a repository different
    +    from the one associated with the current working directory. In that
    +    case, the current working directory may cause the function to return
    +    the wrong superproject or an empty result.
     
    -    If requested when not inside a submodule, the command returns an empty
    -    string.
    +    Pass the `repository` to `get_superproject_working_tree()` so that the
    +    superproject is determined from the repository being inspected rather
    +    than the current working directory.
     
         Mentored-by: Justin Tobler <jltobler@gmail.com>
         Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
         Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
    - ## Documentation/git-repo.adoc ##
    -@@ Documentation/git-repo.adoc: values that they return:
    - `path.gitdir.relative`::
    - 	The path to the Git repository directory relative to the current working directory.
    - 
    -+`path.superproject-root.absolute`::
    -+	The canonical absolute path to the working tree root of the superproject
    -+	if the current repository is an initialized submodule. Outputs an empty
    -+	string if not in a submodule.
    -+
    -+`path.superproject-root.relative`::
    -+	The path to the working tree root of the superproject relative to the
    -+	current working directory if the current repository is an initialized
    -+	submodule. Outputs an empty string if not in a submodule.
    -+
    - `path.toplevel.absolute`::
    - 	The canonical absolute path to the top-level directory of the
    - 	repository's working tree. Outputs an empty string if the repository
    -
    - ## builtin/repo.c ##
    -@@
    - #include "strbuf.h"
    - #include "string-list.h"
    - #include "shallow.h"
    -+#include "submodule.h"
    - #include "tree.h"
    - #include "tree-walk.h"
    - #include "utf8.h"
    -@@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
    - 	return 0;
    - }
    - 
    -+static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
    -+{
    -+	struct strbuf superproject = STRBUF_INIT;
    -+
    -+	if (!get_superproject_working_tree(repo, &superproject)) {
    -+		strbuf_release(&superproject);
    -+		return 0;
    -+	}
    -+
    -+	format_path(buf, superproject.buf, "", PATH_FORMAT_CANONICAL);
    -+	strbuf_release(&superproject);
    -+	return 0;
    -+}
    -+
    -+static int get_path_superproject_relative(struct repository *repo, struct strbuf *buf)
    -+{
    -+	struct strbuf superproject = STRBUF_INIT;
    -+
    -+	if (!get_superproject_working_tree(repo, &superproject)) {
    -+		strbuf_release(&superproject);
    -+		return 0;
    -+	}
    -+
    -+	format_path(buf, superproject.buf, repo->prefix, PATH_FORMAT_RELATIVE);
    -+	strbuf_release(&superproject);
    -+	return 0;
    -+}
    -+
    - static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
    - {
    - 	const char *work_tree = repo_get_work_tree(repo);
    -@@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
    - 	{ "path.commondir.relative", get_path_commondir_relative },
    - 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
    - 	{ "path.gitdir.relative", get_path_gitdir_relative },
    -+	{ "path.superproject-root.absolute", get_path_superproject_absolute },
    -+	{ "path.superproject-root.relative", get_path_superproject_relative },
    - 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
    - 	{ "path.toplevel.relative", get_path_toplevel_relative },
    - 	{ "references.format", get_references_format },
    -
      ## builtin/rev-parse.c ##
     @@ builtin/rev-parse.c: int cmd_rev_parse(int argc,
      			}
    @@ submodule.h: void absorb_git_dir_into_superproject(const char *path,
      
      #endif
     
    - ## t/t1900-repo-info.sh ##
    -@@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
    - 	'.git' \
    - 	'GIT_DIR="../.git" && export GIT_DIR'
    - 
    -+test_expect_success 'path.superproject-root absolute and relative' '
    -+	test_when_finished "rm -rf sub super" &&
    -+	git init sub &&
    -+	test_commit -C sub initial &&
    -+	git init super &&
    -+	(
    -+		cd super &&
    -+		git -c protocol.file.allow=always submodule add "../sub" sub &&
    -+		git commit -m "add submodule" &&
    -+
    -+		cd sub &&
    -+		ROOT="$(test-tool path-utils real_path ..)" &&
    -+
    -+		echo "path.superproject-root.absolute=$ROOT" >expect.abs &&
    -+		git repo info path.superproject-root.absolute >actual.abs &&
    -+		test_cmp expect.abs actual.abs &&
    -+
    -+		echo "path.superproject-root.relative=../" >expect.rel &&
    -+		git repo info path.superproject-root.relative >actual.rel &&
    -+		test_cmp expect.rel actual.rel
    -+	)
    -+'
    -+
    -+test_expect_success 'path.superproject-root returns empty when not in a submodule' '
    -+	test_when_finished "rm -rf repo" &&
    -+	git init repo &&
    -+	(
    -+		cd repo &&
    -+
    -+		echo "path.superproject-root.absolute=" >expect.abs &&
    -+		git repo info path.superproject-root.absolute >actual.abs &&
    -+		test_cmp expect.abs actual.abs &&
    -+
    -+		echo "path.superproject-root.relative=" >expect.rel &&
    -+		git repo info path.superproject-root.relative >actual.rel &&
    -+		test_cmp expect.rel actual.rel
    -+	)
    -+'
    -+
    - test_expect_success 'path.toplevel absolute and relative' '
    - 	test_when_finished "rm -rf repo" &&
    - 	git init repo &&
    -@@ t/t1900-repo-info.sh: test_expect_success 'path.toplevel absolute and relative in a bare repository' '
    + ## t/t7400-submodule-basic.sh ##
    +@@ t/t7400-submodule-basic.sh: test_expect_success 'submodule add fails when name is reused' '
      	)
      '
      
    @@ t/t1900-repo-info.sh: test_expect_success 'path.toplevel absolute and relative i
     +		test_cmp expect actual
     +	)
     +'
    ++
      test_done
3:  1860d19d01 ! 3:  1bfb0c8c1d repo: add path.index with absolute and relative suffixes
    @@ Metadata
     Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
      ## Commit message ##
    -    repo: add path.index with absolute and relative suffixes
    +    repo: add path.superproject-root with absolute and relative suffixes
     
    -    The repository index is a fundamental component used by Git and related
    -    tooling to track the working tree state. Scripts that interact with the
    -    index currently retrieve its location by invoking
    -    `git rev-parse --git-path index`.
    +    Scripts working in multi-repository setups often need to identify the
    +    top-level working tree of a superproject from within a submodule.
    +    Currently, this is only exposed via `git rev-parse
    +    --show-superproject-working-tree`.
     
    -    Introduce `path.index.absolute` and `path.index.relative` keys to
    -    `git repo info`. This exposes the index file location as a scriptable
    -    config-like key using standard format rules, allowing scripts to
    -    retrieve it through the same interface as other repository path
    -    information.
    +    Introduce `path.superproject-root.absolute` and
    +    `path.superproject-root.relative` keys to `git repo info`.
    +    This exposes the core submodule context via a scriptable config-like key
    +    using standard format rules.
    +
    +    If requested when not inside a submodule, the command returns an empty
    +    string.
     
         Mentored-by: Justin Tobler <jltobler@gmail.com>
         Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
    @@ Commit message
     
      ## Documentation/git-repo.adoc ##
     @@ Documentation/git-repo.adoc: values that they return:
    - 	The path to the repository's hooks directory relative to the current
    - 	working directory. Respects the `core.hooksPath` configuration.
    + `path.gitdir.relative`::
    + 	The path to the Git repository directory relative to the current working directory.
      
    -+`path.index.absolute`::
    -+	The canonical absolute path to the repository's current index file.
    -+	Respects the `GIT_INDEX_FILE` environment override. Returns the
    -+	configured index path even if the repository is bare or the file does
    -+	not exist.
    ++`path.superproject-root.absolute`::
    ++	The canonical absolute path to the working tree root of the superproject
    ++	if the current repository is an initialized submodule. Outputs an empty
    ++	string if not in a submodule.
     +
    -+`path.index.relative`::
    -+	The path to the repository's current index file relative to the current
    -+	working directory. Respects the `GIT_INDEX_FILE` environment override.
    -+	Returns the configured index path even if the repository is bare or the
    -+	file does not exist.
    ++`path.superproject-root.relative`::
    ++	The path to the working tree root of the superproject relative to the
    ++	current working directory if the current repository is an initialized
    ++	submodule. Outputs an empty string if not in a submodule.
     +
    - `path.superproject-root.absolute`::
    - 	The canonical absolute path to the working tree root of the superproject
    - 	if the current repository is an initialized submodule. Outputs an empty
    + `path.toplevel.absolute`::
    + 	The canonical absolute path to the top-level directory of the
    + 	repository's working tree. Outputs an empty string if the repository
     
      ## builtin/repo.c ##
    -@@ builtin/repo.c: static int get_path_hooks_relative(struct repository *repo, struct strbuf *buf)
    +@@
    + #include "strbuf.h"
    + #include "string-list.h"
    + #include "shallow.h"
    ++#include "submodule.h"
    + #include "tree.h"
    + #include "tree-walk.h"
    + #include "utf8.h"
    +@@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
      	return 0;
      }
      
    -+static int get_path_index_absolute(struct repository *repo, struct strbuf *buf)
    ++static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
     +{
    -+	const char *index_file = repo_get_index_file(repo);
    ++	struct strbuf superproject = STRBUF_INIT;
     +
    -+	if (!index_file)
    -+		return error(_("unable to get index file"));
    ++	if (!get_superproject_working_tree(repo, &superproject)) {
    ++		strbuf_release(&superproject);
    ++		return 0;
    ++	}
     +
    -+	format_path(buf, index_file, "", PATH_FORMAT_CANONICAL);
    ++	format_path(buf, superproject.buf, "", PATH_FORMAT_CANONICAL);
    ++	strbuf_release(&superproject);
     +	return 0;
     +}
     +
    -+static int get_path_index_relative(struct repository *repo, struct strbuf *buf)
    ++static int get_path_superproject_relative(struct repository *repo, struct strbuf *buf)
     +{
    -+	const char *index_file = repo_get_index_file(repo);
    ++	struct strbuf superproject = STRBUF_INIT;
     +
    -+	if (!index_file)
    -+		return error(_("unable to get index file"));
    ++	if (!get_superproject_working_tree(repo, &superproject)) {
    ++		strbuf_release(&superproject);
    ++		return 0;
    ++	}
     +
    -+	format_path(buf, index_file, repo->prefix, PATH_FORMAT_RELATIVE);
    ++	format_path(buf, superproject.buf, repo->prefix, PATH_FORMAT_RELATIVE);
    ++	strbuf_release(&superproject);
     +	return 0;
     +}
     +
    - static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
    + static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
      {
    - 	struct strbuf superproject = STRBUF_INIT;
    + 	const char *work_tree = repo_get_work_tree(repo);
     @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
    + 	{ "path.commondir.relative", get_path_commondir_relative },
    + 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
      	{ "path.gitdir.relative", get_path_gitdir_relative },
    - 	{ "path.hooks.absolute", get_path_hooks_absolute },
    - 	{ "path.hooks.relative", get_path_hooks_relative },
    -+	{ "path.index.absolute", get_path_index_absolute },
    -+	{ "path.index.relative", get_path_index_relative },
    - 	{ "path.superproject-root.absolute", get_path_superproject_absolute },
    - 	{ "path.superproject-root.relative", get_path_superproject_relative },
    ++	{ "path.superproject-root.absolute", get_path_superproject_absolute },
    ++	{ "path.superproject-root.relative", get_path_superproject_relative },
      	{ "path.toplevel.absolute", get_path_toplevel_absolute },
    + 	{ "path.toplevel.relative", get_path_toplevel_relative },
    + 	{ "references.format", get_references_format },
     
      ## t/t1900-repo-info.sh ##
    -@@ t/t1900-repo-info.sh: then
    - 		'git config core.hooksPath /dev/null'
    - fi
    +@@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
    + 	'.git' \
    + 	'GIT_DIR="../.git" && export GIT_DIR'
      
    -+test_repo_info_path 'index standard' 'index' '.git/index'
    ++test_expect_success 'path.superproject-root absolute and relative' '
    ++	test_when_finished "rm -rf sub super" &&
    ++	git init sub &&
    ++	test_commit -C sub initial &&
    ++	git init super &&
    ++	(
    ++		cd super &&
    ++		git -c protocol.file.allow=always submodule add "../sub" sub &&
    ++		git commit -m "add submodule" &&
    ++
    ++		cd sub &&
    ++		ROOT="$(test-tool path-utils real_path ..)" &&
    ++
    ++		echo "path.superproject-root.absolute=$ROOT" >expect.abs &&
    ++		git repo info path.superproject-root.absolute >actual.abs &&
    ++		test_cmp expect.abs actual.abs &&
     +
    -+test_repo_info_path 'index with GIT_INDEX_FILE override' 'index' \
    -+	'custom-index-file' \
    -+	'GIT_INDEX_FILE="$ROOT/custom-index-file" && export GIT_INDEX_FILE'
    ++		echo "path.superproject-root.relative=../" >expect.rel &&
    ++		git repo info path.superproject-root.relative >actual.rel &&
    ++		test_cmp expect.rel actual.rel
    ++	)
    ++'
     +
    -+test_expect_success 'path.index in a bare repository returns default index location' '
    -+	test_when_finished "rm -rf bare.git" &&
    -+	git init --bare bare.git &&
    ++test_expect_success 'path.superproject-root returns empty when not in a submodule' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
     +	(
    -+		cd bare.git &&
    -+		ROOT="$(test-tool path-utils real_path .)" &&
    ++		cd repo &&
     +
    -+		echo "path.index.absolute=$ROOT/index" >expect.abs &&
    -+		git repo info path.index.absolute >actual.abs &&
    ++		echo "path.superproject-root.absolute=" >expect.abs &&
    ++		git repo info path.superproject-root.absolute >actual.abs &&
     +		test_cmp expect.abs actual.abs &&
     +
    -+		echo "path.index.relative=index" >expect.rel &&
    -+		git repo info path.index.relative >actual.rel &&
    ++		echo "path.superproject-root.relative=" >expect.rel &&
    ++		git repo info path.superproject-root.relative >actual.rel &&
     +		test_cmp expect.rel actual.rel
     +	)
     +'
     +
    - test_expect_success 'path.superproject-root absolute and relative' '
    - 	test_when_finished "rm -rf sub super" &&
    - 	git init sub &&
    + test_expect_success 'path.toplevel absolute and relative' '
    + 	test_when_finished "rm -rf repo" &&
    + 	git init repo &&
2:  dcbaf1cb96 = 4:  09d2937fcd repo: add path.hooks with absolute and relative suffixes
-:  ---------- > 5:  d0c186f150 repo: add path.index with absolute and relative suffixes
4:  ced5b0cb8b = 6:  351b4b7de7 repo: add path.grafts with absolute and relative suffixes
5:  ac766e49e3 = 7:  ef69d4aa8c repo: add path.git-prefix
6:  0a0c3dd924 ! 8:  3e61728dba repo: add path.cdup
    @@ Documentation/git-repo.adoc: values that they return:
      	The object format (hash algorithm) used in the repository.
      
     +`path.cdup`::
    -+	The path to the root of the working tree relative to the current
    -+	working directory. Returns the empty string when the current
    -+	working directory is the root of the working tree.
    ++	When the command is invoked from a subdirectory, show the
    ++	path of the top-level directory relative to the current
    ++	directory (typically a sequence of "../", or an empty string).
     +
      `path.commondir.absolute`::
      	The canonical absolute path to the Git repository's common
    @@ builtin/repo.c: static int get_object_format(struct repository *repo, struct str
     +{
     +	const char *pfx = repo->prefix;
     +
    ++	if (!is_inside_work_tree(repo)) {
    ++		const char *worktree = repo_get_work_tree(repo);
    ++
    ++		if (worktree) {
    ++			strbuf_addstr(buf, worktree);
    ++		}
    ++	}
    ++
     +	while (pfx) {
     +		pfx = strchr(pfx, '/');
     +		if (pfx) {
    @@ t/t1900-repo-info.sh: test_repo_info_path 'commondir with only GIT_DIR' 'commond
     +		test_cmp expect actual
     +	)
     +'
    ++
    ++test_expect_success 'path.cdup cwd outside the working tree' '
    ++	test_when_finished "rm -rf repo" &&
    ++	mkdir -p repo/tmp/x &&
    ++	cd repo &&
    ++	git init test &&
    ++	(
    ++		echo path.cdup=$(pwd)/tmp/x >./test/expect &&
    ++		cd test &&
    ++		GIT_WORK_TREE=../tmp/x &&
    ++		export GIT_WORK_TREE &&
    ++		GIT_DIR=$(pwd)/.git &&
    ++		export GIT_DIR &&
    ++		git repo info path.cdup >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
     +
      test_expect_success 'path.git-prefix at repository root' '
      	test_when_finished "rm -rf repo" &&
-- 
2.56.0-rc2
