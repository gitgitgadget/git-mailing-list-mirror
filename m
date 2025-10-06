Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC9A259C83
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759749977; cv=pass; b=C20FIaLKTletuJXGMic5SbCuN0Y/slhc1+wz1/y62yiKXWFU5tI+U8k1CgYISrXm1H7QmWWPObbv0a/MQwf6cmsFh02MqLAaMXPEiSPlv7fA7PjOb89QNkFzqTandF0JnRAZcyHg5quM52plRBASBeo7U5V+suW7bCzHBpv0RVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759749977; c=relaxed/simple;
	bh=nZsIScKYK7QkurZDG/JdDDrXp6GhdNxuHr1MBIVdGhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJm4jFBB/4PglUCyEQ6VeMyQbzoUgJvdK1u7aExitRBk8z1n4BQHy2K3KZjlmrB+r7BCmnZqBlla+NcezT8wMbILZydsIgzge3gKUtsIm/Ml7zkYHxfW4jtRNsx7+5qrjfdxrFrvRiONGKVLgBpaIlwyVK5dnxb6nvkxKeyCIcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=X/RCWNTJ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="X/RCWNTJ"
ARC-Seal: i=1; a=rsa-sha256; t=1759749958; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D6pWnqlY2fv9YzVEPejX39lcxO4T3lW22Kz8MCq/IQwiE0x6UXGQGJrbjepUMj4/M0bXw2MsEQ9yw5Ihn8jhyB3ITvCL5m6cb5wU1wKo25Lzfr+JUpHs5OXLAFtpyf3LgugdObpXyvRPaItASrKecCrmb2r5qRNlm1lTLWc+Zss=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759749958; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MbH3znI2OKkRMtnmpcpsQbLfjzvjAc5k/Hl8cBLG8mo=; 
	b=VCo9vxMtx2oIp0Xzbw88esTYV5khJYkxsGBmGeFyYd5qbWlaLJPEPH/HhiydADxOkJWHu3QG1gvXB1Mw8RbJXwOMduOO8O7FowquysvOfSvbj4k+w3RUOhC5Nev70QDPHnh8gqXkCDOOL/tdqpQZpdXrCBsLXIyOh62AaozrZ3k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759749958;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MbH3znI2OKkRMtnmpcpsQbLfjzvjAc5k/Hl8cBLG8mo=;
	b=X/RCWNTJLNtxGDAqqowuSQq3T2IHUkJDFOdDEqP33qbeJSt0CYA2yeyfCMKe0NRa
	zxvP4J27pj2erWPtYuXZVbRk3UfxWoLU9j1XPGVrgbQcUvIid6Xzkb315urgLYfTXkA
	xw1BSJkFjvkagtbUG74IBTN1chqBDs3MRdoN+BHI=
Received: by mx.zohomail.com with SMTPS id 175974995590721.182036347566736;
	Mon, 6 Oct 2025 04:25:55 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 4/5] submodule: encode gitdir paths to avoid conflicts
Date: Mon,  6 Oct 2025 14:25:17 +0300
Message-ID: <20251006112518.3764240-5-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251006112518.3764240-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This adds a new submoduleEncoding extension which encodes gitdir names
to avoid collisions due to nested gitdirs or case insensitive filesystems.

A custom encoding can become unnecessarily complex, while url-encoding is
relatively well-known, however it needs some extending to support case
insensitive filesystems, hence why A is encoded as _a, B as _b and so on.

Unfortunately encoding A -> _a (...) is not enough to fix the reserved
Windows file names (e.g. COM1) because worktrees still use names like COM1
even if the gitdirs paths are encoded, so future work is needed to fully
address Windows reserved names.

For now url-encoding is the only option, however in the future we may
add alternatives (other encodings, hashes or even hash_name).

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/extensions.adoc |   9 ++
 Documentation/config/submodule.adoc  |   3 +
 repository.h                         |   1 +
 setup.c                              |   7 ++
 setup.h                              |   1 +
 submodule.c                          |  56 ++++++----
 t/meson.build                        |   1 +
 t/t7425-submodule-encoding.sh        | 146 +++++++++++++++++++++++++++
 8 files changed, 204 insertions(+), 20 deletions(-)
 create mode 100755 t/t7425-submodule-encoding.sh

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index 829f2523fc..c6ab268328 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -73,6 +73,15 @@ relativeWorktrees::
 	repaired with either the `--relative-paths` option or with the
 	`worktree.useRelativePaths` config set to `true`.
 
+submoduleEncoding::
+	If enabled, submodule gitdir paths are encoded to avoid filesystem
+	conflicts due to nested gitdirs or case insensitivity. For now, only
+	url-encoding (rfc3986) is available, with a small addition to encode
+	uppercase to lowercase letters (`A  -> _a`, `B -> _b` and so on).
+	Other encoding or hashing methods may be added in the future.
+	Any preexisting non-encoded submodule gitdirs are used as-is, to
+	ease migration and reduce risk of gitdirs not being recognized.
+
 worktreeConfig::
 	If enabled, then worktrees will load config settings from the
 	`$GIT_DIR/config.worktree` file in addition to the
diff --git a/Documentation/config/submodule.adoc b/Documentation/config/submodule.adoc
index 8f64adfbe3..cd7fd5da5b 100644
--- a/Documentation/config/submodule.adoc
+++ b/Documentation/config/submodule.adoc
@@ -55,6 +55,9 @@ submodule.<name>.active::
 submodule.<name>.gitdir::
 	This option sets the gitdir path for submodule <name>, allowing users
 	to override the default path or change the default path name encoding.
+	Submodule gitdir encoding is enabled via `extensions.submoduleEncoding`
+	(see linkgit:git-config[1]). This config works both with the extension
+	enabled or disabled.
 
 submodule.active::
 	A repeated field which contains a pathspec used to match against a
diff --git a/repository.h b/repository.h
index 5808a5d610..7e39b2acf7 100644
--- a/repository.h
+++ b/repository.h
@@ -158,6 +158,7 @@ struct repository {
 	int repository_format_worktree_config;
 	int repository_format_relative_worktrees;
 	int repository_format_precious_objects;
+	int repository_format_submodule_encoding;
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
 	unsigned different_commondir:1;
diff --git a/setup.c b/setup.c
index 7086741e6c..bf6e815105 100644
--- a/setup.c
+++ b/setup.c
@@ -687,6 +687,9 @@ static enum extension_result handle_extension(const char *var,
 	} else if (!strcmp(ext, "relativeworktrees")) {
 		data->relative_worktrees = git_config_bool(var, value);
 		return EXTENSION_OK;
+	} else if (!strcmp(ext, "submoduleencoding")) {
+		data->submodule_encoding = git_config_bool(var, value);
+		return EXTENSION_OK;
 	}
 	return EXTENSION_UNKNOWN;
 }
@@ -1865,6 +1868,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				repo_fmt.worktree_config;
 			the_repository->repository_format_relative_worktrees =
 				repo_fmt.relative_worktrees;
+			the_repository->repository_format_submodule_encoding =
+				repo_fmt.submodule_encoding;
 			/* take ownership of repo_fmt.partial_clone */
 			the_repository->repository_format_partial_clone =
 				repo_fmt.partial_clone;
@@ -1963,6 +1968,8 @@ void check_repository_format(struct repository_format *fmt)
 				    fmt->ref_storage_format);
 	the_repository->repository_format_worktree_config =
 		fmt->worktree_config;
+	the_repository->repository_format_submodule_encoding =
+		fmt->submodule_encoding;
 	the_repository->repository_format_relative_worktrees =
 		fmt->relative_worktrees;
 	the_repository->repository_format_partial_clone =
diff --git a/setup.h b/setup.h
index 8522fa8575..66ec1ceba5 100644
--- a/setup.h
+++ b/setup.h
@@ -130,6 +130,7 @@ struct repository_format {
 	char *partial_clone; /* value of extensions.partialclone */
 	int worktree_config;
 	int relative_worktrees;
+	int submodule_encoding;
 	int is_bare;
 	int hash_algo;
 	int compat_hash_algo;
diff --git a/submodule.c b/submodule.c
index 7a2d7cd592..23b79c9192 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2262,6 +2262,13 @@ int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
 	char *p;
 	int ret = 0;
 
+	/*
+	 * Skip these checks when extensions.submoduleEncoding is enabled because
+	 * it fixes the nesting issues and the suffixes will not match by design.
+	 */
+	if (the_repository->repository_format_submodule_encoding)
+		return 0;
+
 	if (len <= suffix_len || (p = git_dir + len - suffix_len)[-1] != '/' ||
 	    strcmp(p, submodule_name))
 		BUG("submodule name '%s' not a suffix of git dir '%s'",
@@ -2581,29 +2588,22 @@ int submodule_to_gitdir(struct repository *repo,
 	return ret;
 }
 
+static void strbuf_addstr_case_encode(struct strbuf *dst, const char *src)
+{
+	for (; *src; src++) {
+		unsigned char c = *src;
+		if (c >= 'A' && c <= 'Z') {
+			strbuf_addch(dst, '_');
+			strbuf_addch(dst, c - 'A' + 'a');
+		} else {
+			strbuf_addch(dst, c);
+		}
+	}
+}
+
 void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 			      const char *submodule_name)
 {
-	/*
-	 * NEEDSWORK: The current way of mapping a submodule's name to
-	 * its location in .git/modules/ has problems with some naming
-	 * schemes. For example, if a submodule is named "foo" and
-	 * another is named "foo/bar" (whether present in the same
-	 * superproject commit or not - the problem will arise if both
-	 * superproject commits have been checked out at any point in
-	 * time), or if two submodule names only have different cases in
-	 * a case-insensitive filesystem.
-	 *
-	 * There are several solutions, including encoding the path in
-	 * some way, introducing a submodule.<name>.gitdir config in
-	 * .git/config (not .gitmodules) that allows overriding what the
-	 * gitdir of a submodule would be (and teach Git, upon noticing
-	 * a clash, to automatically determine a non-clashing name and
-	 * to write such a config), or introducing a
-	 * submodule.<name>.gitdir config in .gitmodules that repo
-	 * administrators can explicitly set. Nothing has been decided,
-	 * so for now, just append the name at the end of the path.
-	 */
 	char *gitdir_path, *key;
 
 	/* Allow config override. */
@@ -2618,4 +2618,20 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 
 	repo_git_path_append(r, buf, "modules/");
 	strbuf_addstr(buf, submodule_name);
+
+	/* Existing legacy non-encoded names are used as-is */
+	if (is_git_directory(buf->buf))
+		return;
+
+	if (the_repository->repository_format_submodule_encoding) {
+		struct strbuf tmp = STRBUF_INIT;
+
+		strbuf_reset(buf);
+		repo_git_path_append(r, buf, "modules/");
+
+		strbuf_addstr_urlencode(&tmp, submodule_name, is_rfc3986_unreserved);
+		strbuf_addstr_case_encode(buf, tmp.buf);
+
+		strbuf_release(&tmp);
+	}
 }
diff --git a/t/meson.build b/t/meson.build
index 11376b9e25..de277227a2 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -882,6 +882,7 @@ integration_tests = [
   't7422-submodule-output.sh',
   't7423-submodule-symlinks.sh',
   't7424-submodule-mixed-ref-formats.sh',
+  't7425-submodule-encoding.sh',
   't7450-bad-git-dotfiles.sh',
   't7500-commit-template-squash-signoff.sh',
   't7501-commit-basic-functionality.sh',
diff --git a/t/t7425-submodule-encoding.sh b/t/t7425-submodule-encoding.sh
new file mode 100755
index 0000000000..4ea385d882
--- /dev/null
+++ b/t/t7425-submodule-encoding.sh
@@ -0,0 +1,146 @@
+#!/bin/sh
+
+test_description='submodules handle mixed legacy and new (encoded) style gitdir paths'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-verify-submodule-gitdir-path.sh
+
+test_expect_success 'setup: allow file protocol' '
+	git config --global protocol.file.allow always
+'
+
+test_expect_success 'create repo with mixed encoded and non-encoded submodules' '
+	git init -b main legacy-sub &&
+	test_commit -C legacy-sub legacy-initial &&
+	legacy_rev=$(git -C legacy-sub rev-parse HEAD) &&
+
+	git init -b main new-sub &&
+	test_commit -C new-sub new-initial &&
+	new_rev=$(git -C new-sub rev-parse HEAD) &&
+
+	git init -b main main &&
+	(
+		cd main &&
+		git submodule add ../legacy-sub legacy &&
+		test_commit legacy-sub &&
+
+		git config core.repositoryformatversion 1 &&
+		git config extensions.submoduleEncoding true &&
+
+		git submodule add ../new-sub "New Sub" &&
+		test_commit new
+	)
+'
+
+test_expect_success 'verify submodule name is properly encoded' '
+	verify_submodule_gitdir_path main legacy modules/legacy &&
+	verify_submodule_gitdir_path main "New Sub" modules/_new%20_sub
+'
+
+test_expect_success 'clone from repo with both legacy and new-style submodules' '
+	git clone --recurse-submodules main cloned-non-encoding &&
+	(
+		cd cloned-non-encoding &&
+
+		test_path_is_dir .git/modules/legacy &&
+		test_path_is_dir .git/modules/"New Sub" &&
+
+		git submodule status >list &&
+		test_grep "$legacy_rev legacy" list &&
+		test_grep "$new_rev New Sub" list
+	) &&
+
+	git clone -c extensions.submoduleEncoding=true --recurse-submodules main cloned-encoding &&
+	(
+		cd cloned-encoding &&
+
+		test_path_is_dir .git/modules/legacy &&
+		test_path_is_dir .git/modules/_new%20_sub &&
+
+		git submodule status >list &&
+		test_grep "$legacy_rev legacy" list &&
+		test_grep "$new_rev New Sub" list
+	)
+'
+
+test_expect_success 'commit and push changes to encoded submodules' '
+	git -C legacy-sub config receive.denyCurrentBranch updateInstead &&
+	git -C new-sub config receive.denyCurrentBranch updateInstead &&
+	git -C main config receive.denyCurrentBranch updateInstead &&
+	(
+		cd cloned-encoding &&
+
+		git -C legacy switch --track -C main origin/main  &&
+		test_commit -C legacy second-commit &&
+		git -C legacy push &&
+
+		git -C "New Sub" switch --track -C main origin/main &&
+		test_commit -C "New Sub" second-commit &&
+		git -C "New Sub" push &&
+
+		# Stage and commit submodule changes in superproject
+		git switch --track -C main origin/main  &&
+		git add legacy "New Sub" &&
+		git commit -m "update submodules" &&
+
+		# push superproject commit to main repo
+		git push
+	) &&
+
+	# update expected legacy & new submodule checksums
+	legacy_rev=$(git -C legacy-sub rev-parse HEAD) &&
+	new_rev=$(git -C new-sub rev-parse HEAD)
+'
+
+test_expect_success 'fetch mixed submodule changes and verify updates' '
+	(
+		cd main &&
+
+		# only update submodules because superproject was
+		# pushed into at the end of last test
+		git submodule update --init --recursive &&
+
+		test_path_is_dir .git/modules/legacy &&
+		test_path_is_dir .git/modules/_new%20_sub &&
+
+		# Verify both submodules are at the expected commits
+		git submodule status >list &&
+		test_grep "$legacy_rev legacy" list &&
+		test_grep "$new_rev New Sub" list
+	)
+'
+
+test_expect_success 'setup submodules with nested git dirs' '
+	git init nested &&
+	test_commit -C nested nested &&
+	(
+		cd nested &&
+		cat >.gitmodules <<-EOF &&
+		[submodule "hippo"]
+			url = .
+			path = thing1
+		[submodule "hippo/hooks"]
+			url = .
+			path = thing2
+		EOF
+		git clone . thing1 &&
+		git clone . thing2 &&
+		git add .gitmodules thing1 thing2 &&
+		test_tick &&
+		git commit -m nested
+	)
+'
+
+test_expect_success 'git dirs of encoded sibling submodules must not be nested' '
+	git clone -c extensions.submoduleEncoding=true --recurse-submodules nested clone_nested &&
+	verify_submodule_gitdir_path clone_nested hippo modules/hippo &&
+	verify_submodule_gitdir_path clone_nested hippo/hooks modules/hippo%2fhooks
+'
+
+test_expect_success 'submodule git dir nesting detection must work with parallel cloning' '
+	git clone -c extensions.submoduleEncoding=true --recurse-submodules --jobs=2 nested clone_parallel &&
+	verify_submodule_gitdir_path clone_parallel hippo modules/hippo &&
+	verify_submodule_gitdir_path clone_parallel hippo/hooks modules/hippo%2fhooks
+'
+
+test_done
-- 
2.49.1

