Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F93261594
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829783; cv=none; b=JAT0zDv3UZax6rHpT/iiQySi4yxkbA49MEpvyYTKBaclmF5T0Xs9yrquRAoiGVjszqcXqLseI5k2Jjw2V8TmiT9fjrrj2YLl2XoJ2xfWjjsteHP++K7Vp9MP51gG1xmR1UGk5o0xqOB9WdMNLBW8aVsSQB5H9dEtIeidRAEXx38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829783; c=relaxed/simple;
	bh=4AwLyE89BTbtB8276ywJjtRK8FMYKyfFOjqaZLwgxmM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=adfw0cHr/3qOqh9sRGSXgrdOoRX2z/czs+7bPIlrcCF0Fw5q7jDTsEhvbvwQyPtq5Gxa3ZUl2nzesORJY1cJgnM6d8CJqdvwLRNiFwRUCsDhSAtv9kL0oTjeIPTzTl9O9o2rAHF7260lwWWhjv92DFdvoO+ng6nIxng+Bdlr4L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmQ0f3aO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmQ0f3aO"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf257158fso30396735e9.2
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742829779; x=1743434579; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ou91yL31Lp3YEdeTTNqzuv8dZ2PP4OkJpOBU+CP0Icw=;
        b=JmQ0f3aOMnazKakMvaibAXU9EY8RBncUJP0iTJVnxhtvfqm/3CT2aV//G4G638Ltx8
         UrZEfZhUjGMyzN/AThn4Q2jRMWihZ/pltI879YuCF+miUvZSFkla9QBBdmxHC8W/WjZK
         3smh2tNWBjoWSLnPOTl1Tbr40/ZCxdBDNI5lHFdN5iNiO/huIPitfY8wDhn/phcWW9Ev
         QfUQ9PHaChP4UF3FCVWXEjDZWOspUPcJWc68uGLiCJVzu9KWxP8669Nrxx4L3ulz/pRE
         EBRR9uXPFJHrLsEYqx5TFImOQmp/PMzE/wZwdLog1pzGO5tScdxwo0iOCXpxpqLb5hlz
         Fcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829779; x=1743434579;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ou91yL31Lp3YEdeTTNqzuv8dZ2PP4OkJpOBU+CP0Icw=;
        b=WzopR4eUAcC9X2yali6mVv+t55pyrXVKaAsGR3ClYoDXZcR3+BMN6SRs3OdNDBxjSn
         8ZjA3GN6NnwoQrGI0FbpFG5rPdZeNL7EM/8iF4fe5+gsZLKL94tpjUEaRRrwCYCNf6dR
         pgYJeWfb1k1VBBU74H6KG+k82uwlHK6sGUtoNF4GjlejkabFeYdBKPhSEsnj/SxI69EL
         C3O2W/+iUIBZLLTocplX8J8EGP+vOMo2fq1Es6cK+cGyU1JhYQ/m7xqPUQi0YeFIrD1d
         P3rChOhGsBMy0H1xhuxmUIQezZ6F3tkOPi1M0qK25rREhiXug/5dHwQaMSF+EgGyhL33
         c5JA==
X-Gm-Message-State: AOJu0YxVvQa3sWvXnZoBsc8vqptF/nqYQiwZZu9n6O5p60m6VlVtbM8c
	zKnbO/9wJOhdkKDLQTLyZdP83XFdeSRujy46vFyY6OcrMpoWdCqT+N2u8g==
X-Gm-Gg: ASbGncuyCHm+oatiCwHf6GSsNy7U2pZ2WjpS+maeNvSW5QlrJ/3GKqNpOB8Quz7kj32
	BW60tPpWAONmA5rljKL0McaiBRLcCxne4Y4E7+aCteskoRR599B7HNHg56V7hDBZEYv4N08UhjP
	60NyDcyUA1WID3BDz8XqlTFq1GTXD78AAx+IrwAW3atMlsOs/IIB/+HktTZKcsM5rmIqeuWLFgM
	2R01O+zlFwR9xB57/vrhNkiuKJkuNlmwgf9GigifV1lfo6qM/+wq+mq7wjihK+m3LAuCo06rwEh
	6B40mN4knti9ZVqNIulOHFmsmqgGBemhsvr688xU37gGmA==
X-Google-Smtp-Source: AGHT+IGFbBKuz+8Zb/E0aLVzAoQIc07/tStQNqAfiq3V9gSAj95CJziBt1TtsRVDqaXrPGWfsBEdfA==
X-Received: by 2002:a05:600c:cc6:b0:43d:16a0:d82c with SMTP id 5b1f17b1804b1-43d509e6539mr128281365e9.2.1742829779025;
        Mon, 24 Mar 2025 08:22:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd9df6bsm123015615e9.31.2025.03.24.08.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:22:58 -0700 (PDT)
Message-Id: <11767e7653e5212622ed7f82cad3b1a118621e8c.1742829770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
	<pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Mar 2025 15:22:43 +0000
Subject: [PATCH v2 07/13] repack: add --path-walk option
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

