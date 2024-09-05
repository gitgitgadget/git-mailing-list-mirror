Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C104C19E7EF
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545620; cv=none; b=n/FeHP3AFegJpVu45/yWA1D3+ASDT7ccxmPCUN+Y62R2/voGIBm9UZgRlWmIrjS+jn/VXsbiePMy+e4kBciMe6klISrdoagDNaA9bymXP6nm/erteHPYGEJ34ulkXKPLp2Y49LbImUUmSbD+ExH9Y96MCF5TqTIXE7AkXxbSe8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545620; c=relaxed/simple;
	bh=Nf8i6cgx8pxDAVOpliQAPoyPTJliAbvBMZvPzNyU9bI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Vn+y1WEkl+vbrdp1dA35ma36w+F+5FG0OjMGiizvJfsQ25w5TTLQ17F6xlPg5pocVU/9qxRoyn3Hfl2UqDip5aZ+z+TKMCH67yCN9/oPUbM2hUi/VRolXlg4Zp/nI0zgWOnI7tqeTUdMOyU+3UCVvWxla6zniq1qOfMdxwgWBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecK6hg5M; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecK6hg5M"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so932086a12.2
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 07:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725545616; x=1726150416; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gFh4lAVFQSvo7thBNdDnkUSMNr7IL2TKhRfQorHPVKE=;
        b=ecK6hg5MMfFIGAVIXclvr3vH+VBGWO/5blwp+QgwoWdnu50gwONVXj/ydNchAYDMYD
         uqQsnbx3OR2a22luXqJ6v1fLZZeVsssuU62zcQeZTA9ortHZowZy+WiwlaVGmN26zPKo
         T9Q/YnKoMAQ99jc0p76ws7jG5/BJp21/2lfn+NUC86D2rVs1rOzIDk+0hBWks00e4xsj
         KdNmbLcMDriGhtWhVyVejPmXb9klfHtQ6snJd1I6ZaIR4g0DpoONyXkyaugBEnieb4mm
         z1R4WiGDdxVs6bEsy8+5bhcMZdyR41rJb/miqtoeCu+Y6rzv+re6nwy/g+htK9XSfpFJ
         HDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725545616; x=1726150416;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFh4lAVFQSvo7thBNdDnkUSMNr7IL2TKhRfQorHPVKE=;
        b=LK1qh9U+ZSh7yBi7IV5sK62zQZsCh2D9ed/MoNm4FmumFpg9Na2Pjvk6cHDJy+/r7U
         QeKnBRfaV/cM4udxdzUP3/MgekFN9unObryTDzAwJJ06PXZcnxZ12GGhCllVZYZn3RYE
         pWn/fksQRTmpn9DpH08yRoa3HnlgO7JptXBIb96qIyE4oak/vbMvKWhFBkByzHOANBh2
         SCt7Ris5yfLXVHP4ycioLiiGN7+Sr6jlhca38fcsEbVBw21cIDHNYVaFnnnaTIO9g7RW
         GJhytdawQoVxbrrmAA043kkjnLsQkznaQPHbu8DGa6RA8+YtClvGwgZUqQHzgkDVZzjB
         tlwg==
X-Gm-Message-State: AOJu0YzizUvgDJbmpI1YbH9D9HoHGte+ld6b2pvI9nWZJGHOpMx262qD
	Bhj09H2uvmTv/6ZMPDeuBnWS/bGsva5/nQqr3Av3XE0+ep0Kenyo4zGS3g==
X-Google-Smtp-Source: AGHT+IG8vzRwK1YJk6BebVwLKyhkI0ogt5eAjSdUyahl7UX7K+bsY0/w3PrGL0+8N0bBN/sTC7KHzg==
X-Received: by 2002:a17:907:e6d5:b0:a89:ce18:2f45 with SMTP id a640c23a62f3a-a8a3f52ebccmr525101066b.53.1725545615731;
        Thu, 05 Sep 2024 07:13:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a469esm143940866b.144.2024.09.05.07.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 07:13:35 -0700 (PDT)
Message-Id: <pull.1780.git.1725545614416.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Sep 2024 14:13:34 +0000
Subject: [PATCH] scalar: add --no-tags option
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Some large repositories use tags to track a huge list of release
versions. While this is choice is costly on the ref advertisement, it is
further wasteful for clients who do not need those tags. Allow clients
to optionally skip the tag advertisement.

This behavior is similar to that of 'git clone --no-tags' implemented in
0dab2468ee5 (clone: add a --no-tags option to clone without tags,
2017-04-26), including the modification of the remote.origin.tagOpt
config value to include "--no-tags".

One thing that is opposite of the 'git clone' implementation is that
this allows '--tags' as an assumed option, which can be naturally negated
with '--no-tags'. The clone command does not accept '--tags' but allows
"--no-no-tags" as the negation of its '--no-tags' option.

While testing this option, combine the test with the previously untested
'--no-src' option introduced in 4527db8ff8c (scalar: add --[no-]src
option, 2023-08-28).

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    scalar: add --no-tags option
    
    The need for this was discovered due to the release behavior of an
    internal monorepo. The use of Azure DevOps' limited refs feature does
    not apply to tags, so the number of tags was causing some pain for
    users.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1780%2Fderrickstolee%2Fscalar-no-tags-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1780/derrickstolee/scalar-no-tags-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1780

 Documentation/scalar.txt |  6 ++++++
 scalar.c                 | 15 ++++++++++++---
 t/t9210-scalar.sh        | 18 ++++++++++++++++++
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/scalar.txt b/Documentation/scalar.txt
index 361f51a6473..507ed2ae669 100644
--- a/Documentation/scalar.txt
+++ b/Documentation/scalar.txt
@@ -86,6 +86,12 @@ cloning. If the HEAD at the remote did not point at any branch when
 	`<entlistment>/src` directory. Use `--no-src` to place the cloned
 	repository directly in the `<enlistment>` directory.
 
+--[no-]tags::
+	By default, `scalar clone` will fetch the tag objects advertised by
+	the remote and future `git fetch` commands will do the same. Use
+	`--no-tags` to avoid fetching tags in `scalar clone` and to configure
+	the repository to avoid fetching tags in the future.
+
 --[no-]full-clone::
 	A sparse-checkout is initialized by default. This behavior can be
 	turned off via `--full-clone`.
diff --git a/scalar.c b/scalar.c
index 6166a8dd4c8..c6dd746b5b2 100644
--- a/scalar.c
+++ b/scalar.c
@@ -410,7 +410,7 @@ static int cmd_clone(int argc, const char **argv)
 {
 	const char *branch = NULL;
 	int full_clone = 0, single_branch = 0, show_progress = isatty(2);
-	int src = 1;
+	int src = 1, tags = 1;
 	struct option clone_options[] = {
 		OPT_STRING('b', "branch", &branch, N_("<branch>"),
 			   N_("branch to checkout after clone")),
@@ -421,11 +421,13 @@ static int cmd_clone(int argc, const char **argv)
 			    "be checked out")),
 		OPT_BOOL(0, "src", &src,
 			 N_("create repository within 'src' directory")),
+		OPT_BOOL(0, "tags", &tags,
+			 N_("specify if tags should be fetched during clone")),
 		OPT_END(),
 	};
 	const char * const clone_usage[] = {
 		N_("scalar clone [--single-branch] [--branch <main-branch>] [--full-clone]\n"
-		   "\t[--[no-]src] <url> [<enlistment>]"),
+		   "\t[--[no-]src] [--[no-]tags] <url> [<enlistment>]"),
 		NULL
 	};
 	const char *url;
@@ -504,6 +506,11 @@ static int cmd_clone(int argc, const char **argv)
 		goto cleanup;
 	}
 
+	if (!tags && set_config("remote.origin.tagOpt=--no-tags")) {
+		res = error(_("could not disable tags in '%s'"), dir);
+		goto cleanup;
+	}
+
 	if (!full_clone &&
 	    (res = run_git("sparse-checkout", "init", "--cone", NULL)))
 		goto cleanup;
@@ -513,7 +520,9 @@ static int cmd_clone(int argc, const char **argv)
 
 	if ((res = run_git("fetch", "--quiet",
 				show_progress ? "--progress" : "--no-progress",
-				"origin", NULL))) {
+				"origin",
+				(!tags ? "--no-tags" : NULL),
+				NULL))) {
 		warning(_("partial clone failed; attempting full clone"));
 
 		if (set_config("remote.origin.promisor") ||
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index a41b4fcc085..e8613990e13 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -169,6 +169,24 @@ test_expect_success 'scalar clone' '
 	)
 '
 
+test_expect_success 'scalar clone --no-... opts' '
+	# Note: redirect stderr always to avoid having a verbose test
+	# run result in a difference in the --[no-]progress option.
+	GIT_TRACE2_EVENT="$(pwd)/no-opt-trace" scalar clone \
+		--no-tags --no-src \
+		"file://$(pwd)" no-opts --single-branch 2>/dev/null &&
+
+	test_subcommand git fetch --quiet --no-progress \
+			origin --no-tags <no-opt-trace &&
+	(
+		cd no-opts &&
+
+		test_cmp_config --no-tags remote.origin.tagopt &&
+		git for-each-ref --format="%(refname)" refs/tags/ >tags &&
+		test_line_count = 0 tags
+	)
+'
+
 test_expect_success 'scalar reconfigure' '
 	git init one/src &&
 	scalar register one &&

base-commit: 2e7b89e038c0c888acf61f1b4ee5a43d4dd5e94c
-- 
gitgitgadget
