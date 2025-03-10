Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8981199939
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571467; cv=none; b=mzQq8KcWBk1ebDq3ChPMoJEfPG5X/fHQnhzOa9PwgtzBCShJrXpjrwJMImeLjUSvKSt9k/cF8Ds1qSGM+uw1N5teR3BagK/PvrRPFs8vUYcopZE1Hpm2SOsnloZMABniUwA+MLj5pidcWma0zNkBYOeNlyOgknpaw4QULlD4m6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571467; c=relaxed/simple;
	bh=4AwLyE89BTbtB8276ywJjtRK8FMYKyfFOjqaZLwgxmM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=b68IEYk3xlBlPXEwV6NSjHryJgXv46rHuYtNf4RovCyGVqq3gcfdlotSTlXVgNJ7aI9QDyY1EUTNwZkiBDD30Cxv3VnvJlbxoMRbeAT3EIV2zw3VrtcR7tp8zjPaoASMajEJFEJmyx3bUNsi+haJjobSUDFeMKIBZSO1gbBYaDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxbUrvj9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxbUrvj9"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac25d2b2354so373186366b.1
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 18:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741571462; x=1742176262; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ou91yL31Lp3YEdeTTNqzuv8dZ2PP4OkJpOBU+CP0Icw=;
        b=YxbUrvj9vFd/qy9Tg3kTliG7r1vNVzW+IdpBau61srF7WG5ItjV6d+PbyamBqqPl6m
         VPMTeyrg1VKJ6TXXi1j02xtTpJx7rfMqzFMEiPq80Wcm8x5B2eM6Lu9o8jPfyuvItJWz
         6k25TwUYhvMJc4OfNjXsFciIIBEEB8E77dVcANdaObca4IrFIIETiRMCcB9lCHpbUZnS
         6EtohZ/q9GpNLbo0UDaBcKa0ANhl8axBX5SYC5sH+p4D9W/VDNH6Epc79xFvX3vkgJXa
         ZoWGkdkMMhO91aiWHC2CKBIBBN3IxD13gwwVVMzpd/mumY6zGF2mPeT6JJPF7b6NXV/c
         ENOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741571462; x=1742176262;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ou91yL31Lp3YEdeTTNqzuv8dZ2PP4OkJpOBU+CP0Icw=;
        b=BVyiegynqE35xSK0P3bRxpuLTZhIcoV/BfpbX7IFF2O6GsE1ueKGL8a88lAu1m0F36
         lsm6+5wxjLCIaddy0EyjDSalmaHIwGZuSrgOPeAM/qDRGri4Axc++MqHXrOZr/1dcXh3
         uu83NzYE3eoKdknpPqLBo1FmUa8CTxERm7QX+3tMltALi759AJlIq8qqZYHuohJ7lqZN
         rE78PdAh/NPewGk+i3MPjoLWl6QoypMMtUY75FbtbGeUGkWyGtkRWSI4Ld8V5lVO8EeP
         ZzmfJ3uWAquYwTs+wn0KMIIEFzsXMtmJLoTvdtZeecy+sMoY3j1sN6C+QEcchPPP8eI2
         S32w==
X-Gm-Message-State: AOJu0Yyx7E+PS5XPXdrMPvSaOQIlQqA1uFaicIXgT3atFMW6VVQmcDiq
	dupfQldr0PyAmmuZAySCJEVt9fPUDCznrEAxWA+5KlWFOYn7ASVe4wV7kg==
X-Gm-Gg: ASbGncvE5TyJMqfVL/8Uw3iqXFikCh6d1ijQ9oKGKmT/SmMFgOR6QTEE2mDc6FORTDM
	U2Gx0tCUaBSqVfQVSirgzofvVMrESQQdsh0zrcMjc/W2+kPeKp85TGrQ5W/Qm8As/Ftvxwbvryn
	VyK6JyEViCyvs3K4iljygeTK4qxdf8BGCXtps/Ds4eeNXDYLYepUlh1hWHktVIVOc2AVZzYvWzs
	it6VFveTFGs7AGME7Exrnj9TKZqRPoWHIIaVoYlLr08/n4BdUCGYl/nP+oE5iyWkIzQ1KtKT+9M
	Y6e7I4i+l7TgiWh02TyPmCePeqCsttgxj+0eNHoLG309NA==
X-Google-Smtp-Source: AGHT+IEZccJgqPwsbBrZEfEVn8426nil3vfPOnknC/gU1qnVO7MwIfeA22DLASiOf8h06yyE0afBNQ==
X-Received: by 2002:a17:907:1c1f:b0:ac1:e00c:a566 with SMTP id a640c23a62f3a-ac252fa10ffmr1482868066b.45.1741571462338;
        Sun, 09 Mar 2025 18:51:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988bdd8sm676269166b.138.2025.03.09.18.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 18:51:01 -0700 (PDT)
Message-Id: <1e75f0682810da8881e38f489e9a06e78b6a1abf.1741571455.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 10 Mar 2025 01:50:49 +0000
Subject: [PATCH 07/13] repack: add --path-walk option
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Since 'git pack-objects' supports a --path-walk option, allow passing it
through in 'git repack'. This presents interesting testing opportunities for
comparing the different repacking strategies against each other.

Add the --path-walk option to the performance tests in p5313.

For the microsoft/fluentui repo [1] checked out at a specific commit [2],
the --path-walk tests in p5313 look like this:

Test                                                     this tree
-------------------------------------------------------------------------
5313.18: thin pack with --path-walk                      0.08(0.06+0.02)
5313.19: thin pack size with --path-walk                           18.4K
5313.20: big pack with --path-walk                       2.10(7.80+0.26)
5313.21: big pack size with --path-walk                            19.8M
5313.22: shallow fetch pack with --path-walk             1.62(3.38+0.17)
5313.23: shallow pack size with --path-walk                        33.6M
5313.24: repack with --path-walk                         81.29(96.08+0.71)
5313.25: repack size with --path-walk                             142.5M

[1] https://github.com/microsoft/fluentui
[2] e70848ebac1cd720875bccaa3026f4a9ed700e08

Along with the earlier tests in p5313, I'll instead reformat the
comparison as follows:

Repack Method    Pack Size       Time
---------------------------------------
Hash v1             439.4M      87.24s
Hash v2             161.7M      21.51s
Path Walk           142.5M      81.29s

There are a few things to notice here:

 1. The benefits of --name-hash-version=2 over --name-hash-version=1 are
    significant, but --path-walk still compresses better than that
    option.

 2. The --path-walk command is still using --name-hash-version=1 for the
    second pass of delta computation, using the increased name hash
    collisions as a potential method for opportunistic compression on
    top of the path-focused compression.

 3. The --path-walk algorithm is currently sequential and does not use
    multiple threads for delta compression. Threading will be
    implemented in a future change so the computation time will improve
    to better compete in this metric.

There are small benefits in size for my copy of the Git repository:

Repack Method    Pack Size       Time
---------------------------------------
Hash v1             248.8M      30.44s
Hash v2             249.0M      30.15s
Path Walk           213.2M     142.50s

As well as in the nodejs/node repository [3]:

Repack Method    Pack Size       Time
---------------------------------------
Hash v1             739.9M      71.18s
Hash v2             764.6M      67.82s
Path Walk           698.1M     208.10s

[3] https://github.com/nodejs/node

This benefit also repeats in my copy of the Linux kernel repository:

Repack Method    Pack Size       Time
---------------------------------------
Hash v1               2.5G     554.41s
Hash v2               2.5G     549.62s
Path Walk             2.2G    1562.36s

It is important to see that even when the repository shape does not have
many name-hash collisions, there is a slight space boost to be found
using this method.

As this repacking strategy was released in Git for Windows 2.47.0, some
users have reported cases where the --path-walk compression is slightly
worse than the --name-hash-version=2 option. In those cases, it may be
beneficial to combine the two options. However, there has not been a
released version of Git that has both options and I don't have access to
these repos for testing.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-repack.adoc | 14 +++++++++++++-
 builtin/repack.c              |  7 ++++++-
 t/perf/p5313-pack-objects.sh  | 18 ++++++++----------
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index 5852a5c9736..2199eb3b94f 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
 	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
-	[--write-midx] [--name-hash-version=<n>]
+	[--write-midx] [--name-hash-version=<n>] [--path-walk]
 
 DESCRIPTION
 -----------
@@ -255,6 +255,18 @@ linkgit:git-multi-pack-index[1]).
 	Provide this argument to the underlying `git pack-objects` process.
 	See linkgit:git-pack-objects[1] for full details.
 
+--path-walk::
+	This option passes the `--path-walk` option to the underlying
+	`git pack-options` process (see linkgit:git-pack-objects[1]).
+	By default, `git pack-objects` walks objects in an order that
+	presents trees and blobs in an order unrelated to the path they
+	appear relative to a commit's root tree. The `--path-walk` option
+	enables a different walking algorithm that organizes trees and
+	blobs by path. This has the potential to improve delta compression
+	especially in the presence of filenames that cause collisions in
+	Git's default name-hash algorithm. Due to changing how the objects
+	are walked, this option is not compatible with `--delta-islands`
+	or `--filter`.
 
 CONFIGURATION
 -------------
diff --git a/builtin/repack.c b/builtin/repack.c
index 75e3752353a..d7f798280c0 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -43,7 +43,7 @@ static char *packdir, *packtmp_name, *packtmp;
 static const char *const git_repack_usage[] = {
 	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
 	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
-	   "[--write-midx] [--name-hash-version=<n>]"),
+	   "[--write-midx] [--name-hash-version=<n>] [--path-walk]"),
 	NULL
 };
 
@@ -63,6 +63,7 @@ struct pack_objects_args {
 	int quiet;
 	int local;
 	int name_hash_version;
+	int path_walk;
 	struct list_objects_filter_options filter_options;
 };
 
@@ -313,6 +314,8 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_pushf(&cmd->args, "--no-reuse-object");
 	if (args->name_hash_version)
 		strvec_pushf(&cmd->args, "--name-hash-version=%d", args->name_hash_version);
+	if (args->path_walk)
+		strvec_pushf(&cmd->args, "--path-walk");
 	if (args->local)
 		strvec_push(&cmd->args,  "--local");
 	if (args->quiet)
@@ -1212,6 +1215,8 @@ int cmd_repack(int argc,
 				N_("pass --no-reuse-object to git-pack-objects")),
 		OPT_INTEGER(0, "name-hash-version", &po_args.name_hash_version,
 				N_("specify the name hash version to use for grouping similar objects by path")),
+		OPT_BOOL(0, "path-walk", &po_args.path_walk,
+				N_("pass --path-walk to git-pack-objects")),
 		OPT_NEGBIT('n', NULL, &run_update_server_info,
 				N_("do not run git-update-server-info"), 1),
 		OPT__QUIET(&po_args.quiet, N_("be quiet")),
diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
index cd6dd3abb71..98748b0e203 100755
--- a/t/perf/p5313-pack-objects.sh
+++ b/t/perf/p5313-pack-objects.sh
@@ -55,23 +55,21 @@ test_all_with_args () {
 	test_size "shallow pack size with $parameter" '
 		test_file_size out
 	'
-}
-
-for version in 1 2
-do
-	export version
-
-	test_all_with_args --name-hash-version=$version
 
-	test_perf "repack with --name-hash-version=$version" '
-		git repack -adf --name-hash-version=$version
+	test_perf "repack with $parameter" '
+		git repack -adf $parameter
 	'
 
-	test_size "repack size with --name-hash-version=$version" '
+	test_size "repack size with $parameter" '
 		gitdir=$(git rev-parse --git-dir) &&
 		pack=$(ls $gitdir/objects/pack/pack-*.pack) &&
 		test_file_size "$pack"
 	'
+}
+
+for version in 1 2
+do
+	test_all_with_args --name-hash-version=$version
 done
 
 test_all_with_args --path-walk
-- 
gitgitgadget

