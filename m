Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1526F366055
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770035229; cv=none; b=fUj6csNEUb9Gk5iWsLl6qj7jtxHA/5tDsq5rq5IrLNYq/WnEXu/3Nm6NsAN1bMHe+70ojy8B2wAu3+MZMpdMSWD54zGWs63xi2t7ZMscI9IwRM4aYy99Qgm8g+0PuqwU9wVaa8q4sS085oS0/KCHmMrwKPyn15qLIOTyXKpF/Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770035229; c=relaxed/simple;
	bh=2M5xXdAkz2fZ7G95EITS2pIOKQFfnueDjViuU4QaRok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dj/t9u1fZ0MYmM95/jZ+RhBuX9WWTmegAUy9Vhw3DMF28gXQ4ogFXpDmI2M0Fv3kxg8XG7hVC+JEAWcZP3yYqEAzWjFvWyF4ubhRHKdUAqohMOPuRojaOA3ezPxOJLsUAFIcuaibpeT2pnCYxJVXwyLtA4mh1sW7M7H4e8VRMWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoT4dV/v; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoT4dV/v"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fbc544b09so4091046f8f.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 04:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770035226; x=1770640026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4HngUgiv+0OX0QXakK2xk69TSbmAmy1UKvcEq/eVp8=;
        b=HoT4dV/vUvo4a7vRDdfU3zt4OaTJPDIjTF4HS9N2LM2Qe0JIdvCqwBTGT5FwktQgfn
         X886MBVf+BWX1KojyH70tGzUdCvyzs7D839bdXXGSUyvddYvHMSq5x4Z4ZnpA5wDV8sG
         GP2Z10xzK9Gj7RRDciq5XoZfu6ARUUmZI+MIwfdY4qcj1TFoCsJU0j9WJXZBX982QskH
         4hLquRrUEbzMfwJIz3nTV9F14H+P80YpyDpB6vO7lsRKqF8eK9MIzVJkTlowKdkV2Xc0
         FW9CsKqg+ZS+yZAlKFX8VD6rrLBijqmpAhPYNIipAQK9MunDyuVwwZyzjx7mG0MWQxWL
         8wBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770035226; x=1770640026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I4HngUgiv+0OX0QXakK2xk69TSbmAmy1UKvcEq/eVp8=;
        b=akdM9uFwh1HLAOQh10WklWqjp1sOkFnpNYGuWi6XiTBoy12NWyoxYhFbJKItGCR6v/
         auJ6jNm6tGiwaRgdnRHFAOfP2NHcfMo60NKzLG8URCq3/wtsuicrF+CAaEefPvaNxt/J
         UTTYLJ9QXGFASQIXtqnZ8E5AavfNag+s/s8uW4NZslqWzm+tf+c9Q0b7omo5SFaXLQbD
         BFJIi+9975Rdavwjt2bt2md1fjyPiziv3LCEmcPznqO62NJWHPHVB9rHyFREa4VlfrvQ
         pD0kY9axQLqAI1t1/0KIlYC3u85bHkiNSKh9elGjYg+xEUqi0t/u8rbyk5PojRTQkoyN
         UVSw==
X-Gm-Message-State: AOJu0YwlutzbmaBQf5Py6O4hWzK3b7I73g4iJMRq5+vbIRUHz/vuyJsY
	4JPH8+Ctiihl2dEOIsGt2DlPOI4XMngiNjkmxRJLINHEfrLbfYa/V8SX
X-Gm-Gg: AZuq6aImhumu54Cs0QcHbEJf2v/3LUs80iYOI4V+9FSxfGpfIMDmmEaTvPAhUmyDm7M
	JbOWdbyEBOkac6IPf55p5Wh2cXyqRrxYyuW7etO/tbWtMetXMSDn4tOsjAd7MSoBRX+IdwKVbGC
	AcEsbhtyxgmg2aTzphApKPZe37wWnni+NhksGK0vnCgNG8NHSKCxhWZ6PQFwowKEZ67SVBpG2OR
	9E811Kq7VaqjHxlpJwFB4UGkKRFFcnTtbDZLNtCgkoYwgxyW6iSWZRGsdT8fO7aYL3cPCwCagJW
	/nk83/0fusvoA2J/gTR2kgJEcVD/Em9mlQI1fC0Uo/fauFbRPt0HYZLteMAJjYZ2S4b3pjWdUCK
	JXHkguJYk0VOFxMac/voKZ3xlQt51pQqXxFuTrubC/XUcjmFSBXXV9v9BBKhycfGdVt8DUizXkS
	88foIjKvnAf/o6tyKezCU=
X-Received: by 2002:a05:6000:2dc7:b0:432:dc23:368 with SMTP id ffacd0b85a97d-435f3aac762mr15360305f8f.49.1770035226077;
        Mon, 02 Feb 2026 04:27:06 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:4339:aac1:fb26:43f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4757sm45245735f8f.5.2026.02.02.04.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 04:27:05 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 02 Feb 2026 13:26:33 +0100
Subject: [PATCH v4 4/4] refs: add GIT_REFERENCE_BACKEND to specify
 reference backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260202-kn-alternate-ref-dir-v4-4-3b30430411e3@gmail.com>
References: <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
In-Reply-To: <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, 
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10121;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=2M5xXdAkz2fZ7G95EITS2pIOKQFfnueDjViuU4QaRok=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmAmBU+yRvF13chtM2JywtNs4D1gIE+1VP4C
 XsRKFz6ThVYbYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpgJgVAAoJED7VnySO
 Rox/OH4L/AgONmaLWzyE/nJ+bvItniF5QLD9T3PXg4lpzojD2to+iU4klPPKwdsfC6qpFiJeklR
 7Wd6iS51rObHzA4oGqvsBBNMIrgLpWBu/lzxrCteJ0813oscr/Gx4IfYV9rgqPgAWyui/KaQAZV
 SVqC9aXecLBCQym960/JCclO7ZRQoFD0tskHaP4CfXxpLns9pxmWXIeyxes5GjMCouhgzgXwQOy
 ZnhWksd43/YfYUQoseJuJ+14dUrJg4M31yUU9GboaGknxf9Gq0ljj9ddNgpsoW9Oz2dj1XU2/zK
 ka3JXIWMge50Ek0Hsfg8uOCPYyU4y7/XOTwFc9R2qajJKptXvMu4wUGoi/2rnAqyvvVVAiLKXIK
 PrvyU+70r0fgzc6jdqUc8SmBO2r02/+PfFT7cC/f4in+ZgfXZY8Sq1S1pqEC7o8q19WA15jhvzp
 hGhXfoc+MrWQ8o1Ev5GpiUQNdGIYese7QxUa0d/gfqFW7qpW/TRrJCl0O1403QKfUBQvQe7bd27
 YI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Git allows setting a different object directory via
'GIT_OBJECT_DIRECTORY', but provides no equivalent for references. In
the previous commit we extended the 'extensions.refStorage' config to
also support an URI input for reference backend with location.

Let's also add a new environment variable 'GIT_REFERENCE_BACKEND' that
takes in the same input as the config variable. Having an environment
variable allows us to modify the reference backend and location on the
fly for individual git commands.

Helped-by: Jean-Noël Avila <jn.avila@free.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git.adoc |  5 +++
 environment.h          |  1 +
 setup.c                | 20 +++++++++++
 t/t1423-ref-backend.sh | 96 ++++++++++++++++++++++++++++++++------------------
 4 files changed, 88 insertions(+), 34 deletions(-)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index ce099e78b8..ed3191e8f6 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -584,6 +584,11 @@ double-quotes and respecting backslash escapes. E.g., the value
 	repositories will be set to this value. The default is "files".
 	See `--ref-format` in linkgit:git-init[1].
 
+`GIT_REFERENCE_BACKEND`::
+    Specify which reference backend to be used along with its URI.
+    See `extensions.refStorage` option in linkgit:git-config[1] for more
+    description. Overrides the config variable when used.
+
 Git Commits
 ~~~~~~~~~~~
 `GIT_AUTHOR_NAME`::
diff --git a/environment.h b/environment.h
index 27f657af04..540e0a7f6d 100644
--- a/environment.h
+++ b/environment.h
@@ -42,6 +42,7 @@
 #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
 #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
 #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
+#define GIT_REFERENCE_BACKEND_ENVIRONMENT "GIT_REFERENCE_BACKEND"
 
 /*
  * Environment variable used to propagate the --no-advice global option to the
diff --git a/setup.c b/setup.c
index 44e393c251..b4a7b82cca 100644
--- a/setup.c
+++ b/setup.c
@@ -1838,6 +1838,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	static struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT, report = STRBUF_INIT;
 	const char *prefix = NULL;
+	const char *ref_backend_uri;
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 
 	/*
@@ -1995,6 +1996,25 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
 	}
 
+	/*
+	 * The env variable should override the repository config
+	 * for 'extensions.refStorage'.
+	 */
+	ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
+	if (ref_backend_uri) {
+		char *backend, *location;
+		enum ref_storage_format format;
+
+		parse_reference_uri(ref_backend_uri, &backend, &location);
+		format = ref_storage_format_by_name(backend);
+		if (format == REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown ref storage format: '%s'"), backend);
+		repo_set_ref_storage_format(the_repository, format, location);
+
+		free(backend);
+		free(location);
+	}
+
 	setup_original_cwd();
 
 	strbuf_release(&dir);
diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
index 9c777b79f3..10a9bb1a9b 100755
--- a/t/t1423-ref-backend.sh
+++ b/t/t1423-ref-backend.sh
@@ -11,16 +11,25 @@ test_description='Test reference backend URIs'
 #   <backend> is the original ref storage of the repo.
 #   <uri> is the new URI to be set for the ref storage.
 #   <cmd> is the git subcommand to be run in the repository.
+#   <via> if 'config', set the backend via the 'extensions.refStorage' config.
+#         if 'env', set the backend via the 'GIT_REFERENCE_BACKEND' env.
 run_with_uri() {
 	repo=$1 &&
 	backend=$2 &&
 	uri=$3 &&
 	cmd=$4 &&
+	via=$5 &&
 
-	git -C "$repo" config set core.repositoryformatversion 1
-	git -C "$repo" config set extensions.refStorage "$uri" &&
-	git -C "$repo" $cmd &&
-	git -C "$repo" config set extensions.refStorage "$backend"
+	git -C "$repo" config set core.repositoryformatversion 1 &&
+	if test "$via" = "env"
+	then
+		test_env GIT_REFERENCE_BACKEND="$uri" git -C "$repo" $cmd
+	elif test "$via" = "config"
+	then
+		git -C "$repo" config set extensions.refStorage "$uri" &&
+		git -C "$repo" $cmd &&
+		git -C "$repo" config set extensions.refStorage "$backend"
+	fi
 }
 
 # Test a repository with a given reference storage by running and comparing
@@ -30,44 +39,57 @@ run_with_uri() {
 #   <repo> is the relative path to the repo to run the command in.
 #   <backend> is the original ref storage of the repo.
 #   <uri> is the new URI to be set for the ref storage.
+#   <via> if 'config', set the backend via the 'extensions.refStorage' config.
+#         if 'env', set the backend via the 'GIT_REFERENCE_BACKEND' env.
 #   <err_msg> (optional) if set, check if 'git-refs(1)' failed with the provided msg.
 test_refs_backend() {
 	repo=$1 &&
 	backend=$2 &&
 	uri=$3 &&
-	err_msg=$4 &&
+	via=$4 &&
+	err_msg=$5 &&
+
 
-	git -C "$repo" config set core.repositoryformatversion 1 &&
 	if test -n "$err_msg";
 	then
-		git -C "$repo" config set extensions.refStorage "$uri" &&
-		test_must_fail git -C "$repo" refs list 2>err &&
-		test_grep "$err_msg" err
+		if test "$via" = "env"
+		then
+			test_env GIT_REFERENCE_BACKEND="$uri" test_must_fail git -C "$repo" refs list 2>err
+		elif test "$via" = "config"
+		then
+			git -C "$repo" config set extensions.refStorage "$uri" &&
+			test_must_fail git -C "$repo" refs list 2>err &&
+			test_grep "$err_msg" err
+		fi
 	else
 		git -C "$repo" refs list >expect &&
-		run_with_uri "$repo" "$backend" "$uri" "refs list" >actual &&
+		run_with_uri "$repo" "$backend" "$uri" "refs list" "$via">actual &&
 		test_cmp expect actual
 	fi
 }
 
-test_expect_success 'URI is invalid' '
+methods="config"
+for method in $methods
+do
+
+test_expect_success "$method: URI is invalid" '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-	test_refs_backend repo files "reftable@/home/reftable" \
+	test_refs_backend repo files "reftable@/home/reftable" "$method" \
 		"invalid value for ${SQ}extensions.refstorage${SQ}"
 '
 
-test_expect_success 'URI ends with colon' '
+test_expect_success "$method: URI ends with colon" '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-	test_refs_backend repo files "reftable:" \
+	test_refs_backend repo files "reftable:" "$method" \
 		"invalid value for ${SQ}extensions.refstorage${SQ}"
 '
 
-test_expect_success 'unknown reference backend' '
+test_expect_success "$method: unknown reference backend" '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-	test_refs_backend repo files "db://.git" \
+	test_refs_backend repo files "db://.git" "$method" \
 		"invalid value for ${SQ}extensions.refstorage${SQ}"
 '
 
@@ -86,7 +108,7 @@ do
 	for dir in "$(pwd)/repo/.git" "./"
 	do
 
-		test_expect_success "$read from $to_format backend, $dir dir" '
+		test_expect_success "$method: $read from $to_format backend, $dir dir" '
 			test_when_finished "rm -rf repo" &&
 			git init --ref-format=$from_format repo &&
 			(
@@ -101,7 +123,7 @@ do
 			)
 		'
 
-		test_expect_success "$write to $to_format backend, $dir dir" '
+		test_expect_success "$method: $write to $to_format backend, $dir dir" '
 			test_when_finished "rm -rf repo" &&
 			git init --ref-format=$from_format repo &&
 			(
@@ -113,20 +135,22 @@ do
 				git refs migrate --dry-run --ref-format=$to_format >out &&
 				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
 
-				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" &&
+				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" "$method" &&
 
 				git refs list >expect &&
-				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" "tag -d 1" &&
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
+					"tag -d 1" "$method" &&
 				git refs list >actual &&
 				test_cmp expect actual &&
 
 				git refs list | grep -v "refs/tags/1" >expect &&
-				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" "refs list" >actual &&
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
+					"refs list" "$method" >actual &&
 				test_cmp expect actual
 			)
 		'
 
-		test_expect_success "with worktree and $to_format backend, $dir dir" '
+		test_expect_success "$method: with worktree and $to_format backend, $dir dir" '
 			test_when_finished "rm -rf repo wt" &&
 			git init --ref-format=$from_format repo &&
 			(
@@ -138,22 +162,26 @@ do
 				git refs migrate --dry-run --ref-format=$to_format >out &&
 				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
 
-				git config set core.repositoryformatversion 1 &&
-				git config set extensions.refStorage "$to_format://$BACKEND_PATH" &&
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
+					"worktree add ../wt 2" "$method" &&
 
-				git worktree add ../wt 2
-			) &&
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
+					"for-each-ref --include-root-refs" "$method" >actual &&
+				run_with_uri ../wt "$from_format" "$to_format://$BACKEND_PATH" \
+					"for-each-ref --include-root-refs" "$method" >expect &&
+				! test_cmp expect actual &&
 
-			git -C repo for-each-ref --include-root-refs >expect &&
-			git -C wt for-each-ref --include-root-refs >expect &&
-			! test_cmp expect actual &&
-
-			git -C wt rev-parse 2 >expect &&
-			git -C wt rev-parse HEAD >actual &&
-			test_cmp expect actual
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
+					"rev-parse 2" "$method" >actual &&
+				run_with_uri ../wt "$from_format" "$to_format://$BACKEND_PATH" \
+					"rev-parse HEAD" "$method" >expect &&
+				test_cmp expect actual
+			)
 		'
 	done # closes dir
 done # closes to_format
-done # closes from_format
+done # closes to_format
+
+done # closes method
 
 test_done

-- 
2.52.0

