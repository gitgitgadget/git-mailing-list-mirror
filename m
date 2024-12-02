Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E251DFD80
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 23:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733181692; cv=none; b=T7D8u1VCosUWGIL9CasXVTY73g/8Vz55lBFh7rLUeuXc5E9ut8Wtk2Mff+Law6m7j1EAPUolReBt5lpw35wGRW2lmr4JVubUZiuHRKTMIYty33YGrM9upmdXe8sz/f+heUJ4UdzjctuuML+x4bAJE5rOW8/qDwqG0gZvu95Xx+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733181692; c=relaxed/simple;
	bh=BrlnqgMjnTNUACb0FECzCWdV1EpwTgb6w9eH52XiIgo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=a+q/5K/VGPNf9/pOdTBQRi9ycWKYFXU6jcbrpf3JKlKK7+18j6evKigq9tKOAeghuvBVWZ/N5R0qe7tCcJ6GozMVtzxnESRSYDEO9n+leG3K6dv1LnjCjn5bxdw7AK2/IKGsZjbQRY1ompHMjuY36m89B/4ttKVmjXlJPx14B/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOn3PC+s; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOn3PC+s"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385e27c75f4so1886737f8f.2
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 15:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733181688; x=1733786488; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQUcOGJBL+73pSbN6WTcr3D7S252yvT0WTXBCGsg4W0=;
        b=kOn3PC+sCsSwh8OBrz6udHeey9XT3x/sVC67YlCC0ElF2cqkr7MBXqpj4sXRO5/OuA
         lxU3ICA6Aamad3MDbiXvHqHzplSLnBdbb9OBnqBM9oNQTtq+eVLFqdzjssTXTT3rnyrZ
         FANsv2DN/HoNe97YjnYsC2ONJflYfNDC/ZCC64GoJ18JPGrn6V7YVhCEkCO+gaI1SfCh
         wY+XeokUM/TKliwUBggaKq4UYYr75UVgi1dKITbCajkUBRAa+x9OFZM1v5a5ibtRM9M1
         K+vyUFk6oG9g+TCp+3r2qpmO3KFjnDm/fFsV43ke1GOuF4cDpYvgROLi8QGhmpsmNMIt
         K/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733181688; x=1733786488;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQUcOGJBL+73pSbN6WTcr3D7S252yvT0WTXBCGsg4W0=;
        b=KFKDlPw3qY7xE7ChG0QQvZs6QRhSbhmrP4AnQgP27lMtLKMwJk9rbli8WIi08mGgq+
         QNUPbcheWEVm0vefwzLmvMOufACXBjy3p0qg3wo+YEZhKUkJyp8S81m3F48LxlxB3ozs
         EcKOvZSPRxsDUqU5S8gkjCauXsc2OQAcVsNO6619Yw6zQ8bpVTibmrwCSfNUBOpnvFpt
         npXTm0iRK2Fx+XpWgyRWHvk5/hCvLZaMIjDH1KiXfZWsNH549NBkhEImbFoaPpLi+3UN
         +nuYg4kmkgExSZqTDg6ROSplcgo2n+Hmoic/6Rbdq2+Rb17nI2sHTjXAJJ6lEn9tsvzb
         jn0g==
X-Gm-Message-State: AOJu0Ywon9dX/0azgViSmkZnt1TNrCuVeieL5XMDkwRgZJLkteE+8cPR
	wfHcK57/shDFBCK7DIMvlode6rSR2pk0Y6gRrgUSiWHtrV7ZwnWmMzxj/w==
X-Gm-Gg: ASbGncvIjhLkKcwoQiEb5GWhTs70PYG5mJSHfYqIiadeXqGQGzQVVWZMR/XbRQIEbrb
	439jBSGuaZL11Z4/izjxk8Fm2yXkbgQ7aUchhrxqa9tbssrdapi1xFEu2HdSkrfIROrahAgrkj9
	j10Q2UBw9SAmBM641OYC6mYzG7LFi3fJsrTDCx8OCnPJjWH3bnyBsKu5i5vmcG3G0oF3+dxp6Lu
	rjwo4y+BrmPGK2/E36xSVoFywuDPJFnYDEwiQaFMkbzZ7sT0nc=
X-Google-Smtp-Source: AGHT+IHuyuoDG+WIXarhUXRr7+FUvt8Ofj+xZfo2ttPH3o5P4T1g4Yiga/4nRQpvuxrdyDbzF6foKw==
X-Received: by 2002:a5d:648f:0:b0:385:e13c:5409 with SMTP id ffacd0b85a97d-385fd3c68d2mr222063f8f.5.1733181688049;
        Mon, 02 Dec 2024 15:21:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0dffa88c9sm2447409a12.49.2024.12.02.15.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 15:21:27 -0800 (PST)
Message-Id: <1947d1bf448d71ccd4a44ef25751bab50784a73e.1733181682.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
	<pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Dec 2024 23:21:17 +0000
Subject: [PATCH v2 3/8] repack: add --name-hash-version option
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
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    jonathantanmy@google.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The new '--name-hash-version' option for 'git repack' is a simple
pass-through to the underlying 'git pack-objects' subcommand. However,
this subcommand may have other options and a temporary filename as part
of the subcommand execution that may not be predictable or could change
over time.

The existing test_subcommand method requires an exact list of arguments
for the subcommand. This is too rigid for our needs here, so create a
new method, test_subcommand_flex. Use it to check that the
--name-hash-version option is passing through.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-repack.txt | 34 +++++++++++++++++++++++++++++++++-
 builtin/repack.c             | 10 ++++++++--
 t/t0450/txt-help-mismatches  |  1 -
 t/t7700-repack.sh            |  6 ++++++
 t/test-lib-functions.sh      | 26 ++++++++++++++++++++++++++
 5 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index c902512a9e8..ea69fbe1891 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,9 @@ git-repack - Pack unpacked objects in a repository
 SYNOPSIS
 --------
 [verse]
-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>] [--write-midx]
+'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
+	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
+	[--write-midx] [--name-hash-version=<n>]
 
 DESCRIPTION
 -----------
@@ -249,6 +251,36 @@ linkgit:git-multi-pack-index[1]).
 	Write a multi-pack index (see linkgit:git-multi-pack-index[1])
 	containing the non-redundant packs.
 
+--name-hash-version=<n>::
+	While performing delta compression, Git groups objects that may be
+	similar based on heuristics using the path to that object. While
+	grouping objects by an exact path match is good for paths with
+	many versions, there are benefits for finding delta pairs across
+	different full paths. Git collects objects by type and then by a
+	"name hash" of the path and then by size, hoping to group objects
+	that will compress well together.
++
+The default name hash version is `1`, which prioritizes hash locality by
+considering the final bytes of the path as providing the maximum magnitude
+to the hash function. This version excels at distinguishing short paths
+and finding renames across directories. However, the hash function depends
+primarily on the final 16 bytes of the path. If there are many paths in
+the repo that have the same final 16 bytes and differ only by parent
+directory, then this name-hash may lead to too many collisions and cause
+poor results. At the moment, this version is required when writing
+reachability bitmap files with `--write-bitmap-index`.
++
+The name hash version `2` has similar locality features as version `1`,
+except it considers each path component separately and overlays the hashes
+with a shift. This still prioritizes the final bytes of the path, but also
+"salts" the lower bits of the hash using the parent directory names. This
+method allows for some of the locality benefits of version `1` while
+breaking most of the collisions from a similarly-named file appearing in
+many different directories. At the moment, this version is not allowed
+when writing reachability bitmap files with `--write-bitmap-index` and it
+will be automatically changed to version `1`.
+
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/repack.c b/builtin/repack.c
index 05e13adb87f..5e7ff919c1a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -39,7 +39,9 @@ static int run_update_server_info = 1;
 static char *packdir, *packtmp_name, *packtmp;
 
 static const char *const git_repack_usage[] = {
-	N_("git repack [<options>]"),
+	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
+	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
+	   "[--write-midx] [--name-hash-version=<n>]"),
 	NULL
 };
 
@@ -58,7 +60,7 @@ struct pack_objects_args {
 	int no_reuse_object;
 	int quiet;
 	int local;
-	int full_name_hash;
+	int name_hash_version;
 	struct list_objects_filter_options filter_options;
 };
 
@@ -307,6 +309,8 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_pushf(&cmd->args, "--no-reuse-delta");
 	if (args->no_reuse_object)
 		strvec_pushf(&cmd->args, "--no-reuse-object");
+	if (args->name_hash_version)
+		strvec_pushf(&cmd->args, "--name-hash-version=%d", args->name_hash_version);
 	if (args->local)
 		strvec_push(&cmd->args,  "--local");
 	if (args->quiet)
@@ -1204,6 +1208,8 @@ int cmd_repack(int argc,
 				N_("pass --no-reuse-delta to git-pack-objects")),
 		OPT_BOOL('F', NULL, &po_args.no_reuse_object,
 				N_("pass --no-reuse-object to git-pack-objects")),
+		OPT_INTEGER(0, "name-hash-version", &po_args.name_hash_version,
+				N_("specify the name hash version to use for grouping similar objects by path")),
 		OPT_NEGBIT('n', NULL, &run_update_server_info,
 				N_("do not run git-update-server-info"), 1),
 		OPT__QUIET(&po_args.quiet, N_("be quiet")),
diff --git a/t/t0450/txt-help-mismatches b/t/t0450/txt-help-mismatches
index 28003f18c92..c4a15fd0cb8 100644
--- a/t/t0450/txt-help-mismatches
+++ b/t/t0450/txt-help-mismatches
@@ -45,7 +45,6 @@ rebase
 remote
 remote-ext
 remote-fd
-repack
 reset
 restore
 rev-parse
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index c4c3d1a15d9..b9a5759e01d 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -777,6 +777,12 @@ test_expect_success 'repack -ad cleans up old .tmp-* packs' '
 	test_must_be_empty tmpfiles
 '
 
+test_expect_success '--name-hash-version option passes through to pack-objects' '
+	GIT_TRACE2_EVENT="$(pwd)/hash-trace.txt" \
+		git repack -a --name-hash-version=2 &&
+	test_subcommand_flex git pack-objects --name-hash-version=2 <hash-trace.txt
+'
+
 test_expect_success 'setup for update-server-info' '
 	git init update-server-info &&
 	test_commit -C update-server-info message
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 78e054ab503..af47247f25f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1886,6 +1886,32 @@ test_subcommand () {
 	fi
 }
 
+# Check that the given subcommand was run with the given set of
+# arguments in order (but with possible extra arguments).
+#
+#	test_subcommand_flex [!] <command> <args>... < <trace>
+#
+# If the first parameter passed is !, this instead checks that
+# the given command was not called.
+#
+test_subcommand_flex () {
+	local negate=
+	if test "$1" = "!"
+	then
+		negate=t
+		shift
+	fi
+
+	local expr="$(printf '"%s".*' "$@")"
+
+	if test -n "$negate"
+	then
+		! grep "\[$expr\]"
+	else
+		grep "\[$expr\]"
+	fi
+}
+
 # Check that the given command was invoked as part of the
 # trace2-format trace on stdin.
 #
-- 
gitgitgadget

