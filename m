Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D5A2F4A
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340172; cv=pass; b=bbIqm7/QfZDz6JcwDolTn/NvIPq65Ng2W6lD5+7Q5gckdUGziXdM4/mFmM8FLLNWs/bt9UvkryLXs3SPAIFLxm3bxGhQLIbnTYzV8N7w94totr2x6xlFPFLYmnLFaFPnMwVoczd6AS8Nj5lVvVcrnu08TBZ9Cn1zBBQE3GqH2c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340172; c=relaxed/simple;
	bh=422bf4SJ49zJNJCSAct+nGF+8Q5ouWeUxXK6AjPtNd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZpq/V3MDmHrIgXvgT+doRr9KMwoXeSJdDLVbm3Fta6o1KWWz4tO/U41f8sOmCHGd/h3tATotCwQ1rhSExT/CDpg1lj6ECBquiQ/YT8FVrKSyBx4AGWsMMtFJJ9f+Dzda7LsAOp9czHYsHBEBxgYgZTK+ZARlaopNpwvKzoIrio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=U4iZllKf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="U4iZllKf"
ARC-Seal: i=1; a=rsa-sha256; t=1757340144; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jIPbTnjr7Iykk95m8Bn/0L/Yeh9AVxm55bPSaFEmr9IYVn6Aj3RsRtQH+05Sw7kFFTOxqNySh1il+QB96OVzVPv/oA+jk1lucr9hPYwasTvkt9+lzchoXZPDZkdmh9E1jHIYJlMvYwAN0H423HMbw7RI9GKUNLLSeUJReFuFvRU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757340144; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=r3S+SflumjWYEKz2dOfv4X6uMg8v5S9A23OmPgbemt8=; 
	b=e8RxB1H2KlS8m1BoiJUpHNy8G30/JnHkVygG1fxHsPpIi8CY5h5H86nx+K8F0pT2HlfW86LRPSResigcPBvdjc+T/IAeyzaQgZ5hC3ZhJF2o9XRi95WvF1vsbffrC8ykPiNCuIfDW/iPAT0vUETgS6oXbV4Yh0TgktCgwJcSnGk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757340144;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=r3S+SflumjWYEKz2dOfv4X6uMg8v5S9A23OmPgbemt8=;
	b=U4iZllKfbC/847lpHuw5NCIuzawObQc2F+tz6OQhh8wYJeHVF2wzyiHVk/4itc/M
	/Hs85XC/ShMcu1B5hyGYIPdWq5kAPUdF0peJnEbFW3U3hY+HTEQ/G/P64pgtXadapOI
	SvlNF07yhyn2WfOTGGWhkQIdUNz0AAqy5AD1+C9s=
Received: by mx.zohomail.com with SMTPS id 17573401395971017.5699638414357;
	Mon, 8 Sep 2025 07:02:19 -0700 (PDT)
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
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 06/10] submodule: encode gitdir paths to avoid conflicts
Date: Mon,  8 Sep 2025 17:01:13 +0300
Message-ID: <20250908140117.262205-7-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.GIT
In-Reply-To: <20250908140117.262205-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Based on previous work by Brandon & all [1].

This encodes submodule gitdir names to avoid colisions like nested gitdirs
due to names like "foo" and "foo/bar".

A custom encoding can become unnecesarily complex, while url-encoding is
relatively well-known, however it needs some extending to support case
insensitive filesystems and quirks like Windows reserving "COM1" names.
Hence why I opted to encode A as _a, B as _b and so on.

Unfortunately encoding A -> _a (...) is not enough to fix the reserved
Windows file names (eg COM1) because workdirs still use the name COM1
even though gitdirs paths encoded, so future work will be needed to
fully address that case (or just use a different name).

This affected tests are fixed and a TODO is added to cleanup a hack /
short-circuit in validate_submodule_git_dir().

A further commit will add more tests to exercise these codepaths.

Link: https://lore.kernel.org/git/20180807230637.247200-1-bmwill@google.com/ [1]
Based-on-patch-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 submodule.c                  | 55 +++++++++++++++++++++---------------
 t/t7400-submodule-basic.sh   |  2 +-
 t/t7406-submodule-update.sh  | 10 +++----
 t/t7450-bad-git-dotfiles.sh  | 39 +++++++++++++------------
 t/t7527-builtin-fsmonitor.sh |  2 +-
 5 files changed, 60 insertions(+), 48 deletions(-)

diff --git a/submodule.c b/submodule.c
index bf78636195..8e0fd077db 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2271,8 +2271,13 @@ int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
 
 	if (len <= suffix_len || (p = git_dir + len - suffix_len)[-1] != '/' ||
 	    strcmp(p, submodule_name))
-		BUG("submodule name '%s' not a suffix of git dir '%s'",
-		    submodule_name, git_dir);
+		/*
+		 * TODO: revisit and cleanup this test short-circuit, because
+		 * submodules with encoded names are expected to take this path.
+		 * Likely just move the invariants to submodule_name_to_gitdir()
+		 * and delete this entire function in a future commit.
+		 */
+		return 0;
 
 	/*
 	 * We prevent the contents of sibling submodules' git directories to
@@ -2588,30 +2593,26 @@ int submodule_to_gitdir(struct repository *repo,
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
+	struct strbuf encoded_sub_name = STRBUF_INIT, tmp = STRBUF_INIT;
+	size_t base_len, encoded_len;
 	char *gitdir_path, *key;
+	long name_max;
 
 	/* Allow config override. */
 	key = xstrfmt("submodule.%s.gitdirpath", submodule_name);
@@ -2632,5 +2633,13 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 	/* New style (encoded) paths go under submodules/<encoded>. */
 	strbuf_reset(buf);
 	repo_git_path_append(r, buf, "submodules/");
-	strbuf_addstr(buf, submodule_name);
+	base_len = buf->len;
+
+	/* URL-encode then case case-encode A to _a, B to _b and so on */
+	strbuf_addstr_urlencode(&tmp, submodule_name, is_rfc3986_unreserved);
+	strbuf_addstr_case_encode(&encoded_sub_name, tmp.buf);
+	strbuf_release(&tmp);
+	strbuf_addbuf(buf, &encoded_sub_name);
+
+	strbuf_release(&encoded_sub_name);
 }
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a632f47b73..fe772fa244 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1047,7 +1047,7 @@ test_expect_success 'recursive relative submodules stay relative' '
 		cd clone2 &&
 		git submodule update --init --recursive &&
 		echo "gitdir: ../.git/submodules/sub3" >./sub3/.git_expect &&
-		echo "gitdir: ../../../.git/submodules/sub3/submodules/dirdir/subsub" >./sub3/dirdir/subsub/.git_expect
+		echo "gitdir: ../../../.git/submodules/sub3/submodules/dirdir%2fsubsub" >./sub3/dirdir/subsub/.git_expect
 	) &&
 	test_cmp clone2/sub3/.git_expect clone2/sub3/.git &&
 	test_cmp clone2/sub3/dirdir/subsub/.git_expect clone2/sub3/dirdir/subsub/.git
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index f0c4da1ffa..c44a7e9513 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -864,8 +864,8 @@ test_expect_success 'submodule add places git-dir in superprojects git-dir' '
 	 (cd deeper/submodule &&
 	  git log > ../../expected
 	 ) &&
-	 (cd .git/submodules/deeper/submodule &&
-	  git log > ../../../../actual
+	 (cd .git/submodules/deeper%2fsubmodule &&
+	  git log > ../../../actual
 	 ) &&
 	 test_cmp expected actual
 	)
@@ -882,8 +882,8 @@ test_expect_success 'submodule update places git-dir in superprojects git-dir' '
 	 (cd deeper/submodule &&
 	  git log > ../../expected
 	 ) &&
-	 (cd .git/submodules/deeper/submodule &&
-	  git log > ../../../../actual
+	 (cd .git/submodules/deeper%2fsubmodule &&
+	  git log > ../../../actual
 	 ) &&
 	 test_cmp expected actual
 	)
@@ -899,7 +899,7 @@ test_expect_success 'submodule add places git-dir in superprojects git-dir recur
 	  git commit -m "added subsubmodule" &&
 	  git push origin :
 	 ) &&
-	 (cd .git/submodules/deeper/submodule/submodules/subsubmodule &&
+	 (cd .git/submodules/deeper%2fsubmodule/submodules/subsubmodule &&
 	  git log > ../../../../../actual
 	 ) &&
 	 git add deeper/submodule &&
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 4e2ced3636..27254300f8 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -15,6 +15,7 @@ Such as:
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
+. "$TEST_DIRECTORY"/lib-verify-submodule-gitdir-path.sh
 
 test_expect_success 'setup' '
 	git config --global protocol.file.allow always
@@ -319,6 +320,8 @@ test_expect_success WINDOWS 'prevent git~1 squatting on Windows' '
 	fi
 '
 
+# TODO: move these nested gitdir tests to another location in a later commit because
+# they are not pathological cases anymore: by encoding the gitdir paths do not conflict.
 test_expect_success 'setup submodules with nested git dirs' '
 	git init nested &&
 	test_commit -C nested nested &&
@@ -341,35 +344,35 @@ test_expect_success 'setup submodules with nested git dirs' '
 '
 
 test_expect_success 'git dirs of sibling submodules must not be nested' '
-	test_must_fail git clone --recurse-submodules nested clone 2>err &&
-	test_grep "is inside git dir" err
+	git clone --recurse-submodules nested clone_nested &&
+	verify_submodule_gitdir_path clone_nested hippo submodules/hippo &&
+	verify_submodule_gitdir_path clone_nested hippo/hooks submodules/hippo%2fhooks
 '
 
 test_expect_success 'submodule git dir nesting detection must work with parallel cloning' '
-	test_must_fail git clone --recurse-submodules --jobs=2 nested clone_parallel 2>err &&
-	cat err &&
-	grep -E "(already exists|is inside git dir|not a git repository)" err &&
-	{
-		test_path_is_missing .git/submodules/hippo/HEAD ||
-		test_path_is_missing .git/submodules/hippo/hooks/HEAD
-	}
+	git clone --recurse-submodules --jobs=2 nested clone_parallel &&
+	verify_submodule_gitdir_path clone_nested hippo submodules/hippo &&
+	verify_submodule_gitdir_path clone_nested hippo/hooks submodules/hippo%2fhooks
 '
 
-test_expect_success 'checkout -f --recurse-submodules must not use a nested gitdir' '
-	git clone nested nested_checkout &&
+test_expect_success 'checkout -f --recurse-submodules must corectly handle nested gitdirs' '
+	git clone nested clone_recursive_checkout &&
 	(
-		cd nested_checkout &&
+		cd clone_recursive_checkout &&
+
 		git submodule init &&
-		git submodule update thing1 &&
+		git submodule update thing1 thing2 &&
+
+		# simulate a malicious nested alternate which git should not follow
 		mkdir -p .git/submodules/hippo/hooks/refs &&
 		mkdir -p .git/submodules/hippo/hooks/objects/info &&
 		echo "../../../../objects" >.git/submodules/hippo/hooks/objects/info/alternates &&
-		echo "ref: refs/heads/master" >.git/submodules/hippo/hooks/HEAD
+		echo "ref: refs/heads/master" >.git/submodules/hippo/hooks/HEAD &&
+
+		git checkout -f --recurse-submodules HEAD
 	) &&
-	test_must_fail git -C nested_checkout checkout -f --recurse-submodules HEAD 2>err &&
-	cat err &&
-	grep "is inside git dir" err &&
-	test_path_is_missing nested_checkout/thing2/.git
+	verify_submodule_gitdir_path clone_nested hippo submodules/hippo &&
+	verify_submodule_gitdir_path clone_nested hippo/hooks submodules/hippo%2fhooks
 '
 
 test_expect_success SYMLINKS,!WINDOWS,!MINGW 'submodule must not checkout into different directory' '
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index ded482fdf2..15e44a6979 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -895,7 +895,7 @@ test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
 	cat >expect <<-EOF &&
 	Migrating git directory of '\''dir_1/dir_2/sub'\'' from
 	'\''$cwd/dir_1/dir_2/sub/.git'\'' to
-	'\''$cwd/.git/submodules/dir_1/dir_2/sub'\''
+	'\''$cwd/.git/submodules/dir_1%2fdir_2%2fsub'\''
 	EOF
 	GIT_TRACE2_EVENT="$PWD/super-sub.trace" \
 		git -C super submodule absorbgitdirs >out 2>actual &&
-- 
2.51.GIT

