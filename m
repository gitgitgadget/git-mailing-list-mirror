Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7692213C67A
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 07:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727594131; cv=none; b=rtHaTUUM+qmMqpsWdjjqXMkvCh0LCJYs3DTmPYqSW/dww7QJ/MNvEB6C6KNWvo7GdjMRzCr+owtjzgacXKZbtSmOpW9eZ7Y8m4DPRd4wGrtla7q5/8XjO2zc7neM9+iNLEUPoNddeSEKLU3H/uDQjM3imA0j/LBackSRvuPlTHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727594131; c=relaxed/simple;
	bh=yJy575HqzJiYdTToT6U3V5n6TQzj+0GlDVx1EUccbXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwgV0btQtj0ldhFyUT73Ac2zQhbnbE585ciVb+Z/dnQgX5UsI7i/3OQsG2JagbuXWjHIWU9HkUtdF5kF7VtpeArMMkiiSVLxT4rceqtO9uAyR8F0Fg/9f+IYgqoWte6ApoIT+NdCLArhHBNvssphGHGe28vMOIzJCq3zyrWnWjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsMBeLeu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsMBeLeu"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e0be1afa85so1990283a91.1
        for <git@vger.kernel.org>; Sun, 29 Sep 2024 00:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727594128; x=1728198928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs3co9Xh5bx28I4SQMHLxDzB2eXrlvaIlCbD7vydN8U=;
        b=KsMBeLeuMhoBNrcO5q3ajDXwRpb/smSQO/2aXLX/tpvdw1Pv++LsfxnCEOpmE3Gmzm
         C/Ls7Vnn20A6wsaA/+X1BhShJUR94iWx1mCitagwVwXISjWg9p1B+wW89hLAim5BQ+hC
         UpvniZbF4dqDLoxRLU/Nb+wFoCePoBHPC1hXNNYwPpaLMo4QvEzfbfI7jX4SA5vm6w4m
         E7MR/uomx1R574/DPnwdwyr7I17ooBxFYhieeMxnnL+VwhzY44QNS5218OKaFRHKNwtA
         LY2rSdH5YBw65LmdTBTerHxA+4x7oGDLiFUduVQoM/II3nNbbaYxv2SPwIHPU7DfwY9Y
         Bd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727594128; x=1728198928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qs3co9Xh5bx28I4SQMHLxDzB2eXrlvaIlCbD7vydN8U=;
        b=L4GevJWCAmOjXpdltY0M35OuusE9iucbfSEc6bJSbegdiwNI8skaBZetBDDqbjNPM1
         I6S5w2fPIM5qREPNkpHVblJ4czu/CvoNMVebLIcslnx0Eufoshnbm+v+5g6QE7/nMIXQ
         Rf2oH3Ky7FOOFUJm3zfdCfmmjNfSzrRMyZO0xi7jVFteDC4HljRMMvL4ogf+/IwC0vDh
         f4vZdrcOa6ieWeteyki3i4sNFKIthSSRbFUU9BbuVjS0jjfABk/mitnXgBZy2zjT7tIG
         Hifmquj/8TJwlVQGaRW40aVLgQ256HMIi4RkcBxGO1/7gAg5IMigWq2mSNFtc9Wjtk/r
         AWWA==
X-Gm-Message-State: AOJu0YyE9fCsYvWl8AhZxKzzj/RusfajRFTovfZNJ7gRUO2S/Ja2zxYO
	fHEJ5ylCdLBxrsRwlITvhKfnOm+v5/gvYjLuLvbHN6sJ5pQCMhyfz+YkgA==
X-Google-Smtp-Source: AGHT+IGcPrIo+cdctA/TzkTqanY3Zd23cClAD5Vqqdow2+M6yT2L3dPTuV6ROefod+eQFaAT7dgPSA==
X-Received: by 2002:a17:90a:bd8d:b0:2d8:f7e2:f03 with SMTP id 98e67ed59e1d1-2e0b8e9282cmr10714261a91.32.1727594128178;
        Sun, 29 Sep 2024 00:15:28 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c7729fsm5307319a91.22.2024.09.29.00.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 00:15:27 -0700 (PDT)
Date: Sun, 29 Sep 2024 15:15:26 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 2/9] builtin/refs: support multiple worktrees check for
 refs.
Message-ID: <Zvj-jkFE9NN30uDl@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvj-DgHqtC30KjJe@ArchLinux>

We have already set up the infrastructure to check the consistency for
refs, but we do not support multiple worktrees. As we decide to add more
checks for ref content, we need to set up support for multiple
worktrees. Use "get_worktrees" and "get_worktree_ref_store" to check
refs under the worktrees.

Because we should only check once for "packed-refs", let's call the fsck
function for packed-backend when in the main worktree. In order to know
which directory we check, we should default print this information
instead of specifying "--verbose".

It's not suitable to print these information to the stderr. So, change
to stdout.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/refs.c           | 11 ++++++--
 refs/files-backend.c     | 18 ++++++++----
 t/t0602-reffiles-fsck.sh | 59 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/builtin/refs.c b/builtin/refs.c
index 24978a7b7b..3c492ea922 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -5,6 +5,7 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "strbuf.h"
+#include "worktree.h"
 
 #define REFS_MIGRATE_USAGE \
 	N_("git refs migrate --ref-format=<format> [--dry-run]")
@@ -66,6 +67,7 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
 static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
 {
 	struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
+	struct worktree **worktrees, **p;
 	const char * const verify_usage[] = {
 		REFS_VERIFY_USAGE,
 		NULL,
@@ -75,7 +77,7 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "strict", &fsck_refs_options.strict, N_("enable strict checking")),
 		OPT_END(),
 	};
-	int ret;
+	int ret = 0;
 
 	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
 	if (argc)
@@ -84,9 +86,14 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
 	git_config(git_fsck_config, &fsck_refs_options);
 	prepare_repo_settings(the_repository);
 
-	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
+	worktrees = get_worktrees();
+	for (p = worktrees; *p; p++) {
+		struct worktree *wt = *p;
+		ret += refs_fsck(get_worktree_ref_store(wt), &fsck_refs_options);
+	}
 
 	fsck_options_clear(&fsck_refs_options);
+	free_worktrees(worktrees);
 	return ret;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 03d2503276..57318b4c4e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3558,7 +3558,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 		} else if (S_ISREG(iter->st.st_mode) ||
 			   S_ISLNK(iter->st.st_mode)) {
 			if (o->verbose)
-				fprintf_ln(stderr, "Checking %s/%s",
+				fprintf_ln(stdout, "Checking %s/%s",
 					   refs_check_dir, iter->relative_path);
 			for (size_t i = 0; fsck_refs_fn[i]; i++) {
 				if (fsck_refs_fn[i](ref_store, o, refs_check_dir, iter))
@@ -3589,8 +3589,8 @@ static int files_fsck_refs(struct ref_store *ref_store,
 		NULL,
 	};
 
-	if (o->verbose)
-		fprintf_ln(stderr, _("Checking references consistency"));
+	fprintf_ln(stdout, _("Checking references consistency in %s"),
+		   ref_store->gitdir);
 	return files_fsck_refs_dir(ref_store, o,  "refs", fsck_refs_fn);
 }
 
@@ -3600,8 +3600,16 @@ static int files_fsck(struct ref_store *ref_store,
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_READ, "fsck");
 
-	return files_fsck_refs(ref_store, o) |
-	       refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
+	int ret = files_fsck_refs(ref_store, o);
+
+	/*
+	 * packed-refs should only be checked once because it is shared
+	 * between all worktrees.
+	 */
+	if (!strcmp(ref_store->gitdir, ref_store->repo->gitdir))
+		ret += refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
+
+	return ret;
 }
 
 struct ref_storage_be refs_be_files = {
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 71a4d1a5ae..4c6cd6f7d0 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -89,4 +89,63 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
 	test_must_be_empty err
 '
 
+test_expect_success 'ref name check should work for multiple worktrees' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+
+	cd repo &&
+	test_commit initial &&
+	git checkout -b branch-1 &&
+	test_commit second &&
+	git checkout -b branch-2 &&
+	test_commit third &&
+	git checkout -b branch-3 &&
+	git worktree add ./worktree-1 branch-1 &&
+	git worktree add ./worktree-2 branch-2 &&
+	worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
+	worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
+
+	(
+		cd worktree-1 &&
+		git update-ref refs/worktree/branch-4 refs/heads/branch-3
+	) &&
+	(
+		cd worktree-2 &&
+		git update-ref refs/worktree/branch-4 refs/heads/branch-3
+	) &&
+
+	cp $worktree1_refdir_prefix/branch-4 $worktree1_refdir_prefix/.branch-2 &&
+	cp $worktree2_refdir_prefix/branch-4 $worktree2_refdir_prefix/@ &&
+
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/worktree/.branch-2: badRefName: invalid refname format
+	error: refs/worktree/@: badRefName: invalid refname format
+	EOF
+	sort err >sorted_err &&
+	test_cmp expect sorted_err &&
+
+	(
+		cd worktree-1 &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/worktree/.branch-2: badRefName: invalid refname format
+		error: refs/worktree/@: badRefName: invalid refname format
+		EOF
+		sort err >sorted_err &&
+		test_cmp expect sorted_err
+	) &&
+
+	(
+		cd worktree-2 &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/worktree/.branch-2: badRefName: invalid refname format
+		error: refs/worktree/@: badRefName: invalid refname format
+		EOF
+		sort err >sorted_err &&
+		test_cmp expect sorted_err
+	)
+'
+
 test_done
-- 
2.46.2

