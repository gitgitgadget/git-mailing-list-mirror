Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F751DFE3A
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396740; cv=none; b=ntw/7j7kkCH+OVX/NgQo9PMsB+QMq10+mBDf1dzzX2qO/rFJK8NoUkm50wZgngCy5OAdA5/pRDFCJfJhn39w2R17y0wUAwCdXn3p9ZXRG3D8lX+aWcw87uVTsGeCYlUYp9yoHf4araV8EuyAg76i3LXqT3+TsrAQyo+4ETdQ/nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396740; c=relaxed/simple;
	bh=w2oLDdI6ObfQA5lE1AadEK+ROWTdtCVPIDRGsOseWH8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XLtvgXu425/6hA8XjLpTY6tyWdRC386Y1ZdtbfbIWxYLqeM/jYNxwUZxqsMCR7Tx+ktt2nhM83rvydB1gbc8n8sSIBiy7CZrqJZIicH6r8XfSWgW5hehNO1lxvU12I+AO4kpwvZBeVheR/+QqvNVUFxA2PqE2UR5L7zrEb+c1bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHmm47Yw; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHmm47Yw"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c918c067a1so281076a12.3
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 07:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728396736; x=1729001536; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2V8zrrz4ZTlOTS6CMVLbGbWPyogZMtXZEspg0S42tk=;
        b=iHmm47YwzTmRR+dYzlm3hW9Durq9zjQfWSmWdHTPYRsE52eMG2CtiSf3w+913e6rk6
         szicPieSM31P7DrHGHnf58nAeM5ZqRabdd9CLoKGD3h7qMb0D+Eqa6EAjL4aQ1Vep5Pi
         /OAq1fZNkOEPK1OhAdcvZkM+3vgZhxzsWpJZzQLaf5MiEsHM1qRzxmAvxVwRsP7N6+YH
         b5kuNDZ0DwwlfEU5hGIbXMf2clD8xKX3gD1QKgIEJsmLjkgHKH/8un2S6Y6GG5ExECQW
         d3vpSI+xP8Rh1YbiKKddNlvB/8jccMrhw2Wo9xa2Hnk8wSrz5zEx7diduMI7q4RxlmIk
         7gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396736; x=1729001536;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2V8zrrz4ZTlOTS6CMVLbGbWPyogZMtXZEspg0S42tk=;
        b=X2zKoR14awp+Ie9O84JWGsCxJBnGKt639hpoY7slA+Ezoxvq2fUJIU3C80LBgadv52
         9o8sJJraIx0GKN1ENqjmwb3unKPjvtHA+SDNa/xypAPhuJ17FLBMl0T55sxgvd7iWRvg
         3xCUBqhAwYBz9elwPyM8LefdFS+WtsduvpD/P4Vadw5GFYYOLvDTI+u9W23L6L7KIZGz
         XoTWzezRmheF59xGuBJktq1Q7T4mYXWywE4clA/e6AxM89XIwSvC2s30ZMFrFcg0QNcp
         4U40pPKsfR45B/Wg3N53SBvpv5bu67Jcl9DtxQ2z4e4PDbWFXeLI8J72oIRgab25uled
         itxQ==
X-Gm-Message-State: AOJu0YzEZN8vgbep6uwHqEmCR9OQ2MIbZdy+rmBShKRBFs2wda9hkTeo
	vMfD/UGSBKW6cj+jwoSFXdxRGg3sDkkpLbP609d9RmAFyLt2NZHyRSazUQ==
X-Google-Smtp-Source: AGHT+IFdmNzK+7sV8ukWQ2soF+3XR0bbvGRJ8xjyE1E+lE+DHBcKh87NJPGPiDcKXRTNw4zufqg82w==
X-Received: by 2002:a17:907:7244:b0:a99:36fa:9575 with SMTP id a640c23a62f3a-a9936faa63bmr1128889066b.32.1728396736052;
        Tue, 08 Oct 2024 07:12:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e78498fsm512061666b.107.2024.10.08.07.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:12:15 -0700 (PDT)
Message-Id: <507ed0f6f90e922162a484ec462e8542be2b6421.1728396724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 14:11:58 +0000
Subject: [PATCH 12/17] repack: add --path-walk option
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
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Since 'git pack-objects' supports a --path-walk option, allow passing it
through in 'git repack'. This presents interesting testing opportunities for
comparing the different repacking strategies against each other.

In my copy of the Git repository, the new tests in p5313 show these
results:

Test                                      this tree
-------------------------------------------------------------
5313.10: repack                           27.88(150.23+2.70)
5313.11: repack size                               228.2M
5313.12: repack with --path-walk          134.59(148.77+0.81)
5313.13: repack size with --path-walk              209.7M

Note that the 'git pack-objects --path-walk' feature is not integrated
with threads. Look forward to a future change that will introduce
threading to improve the time performance of this feature with
equivalent space performance.

For the microsoft/fluentui repo [1] had some interesting aspects for the
previous tests in p5313, so here are the repack results:

Test                                      this tree
-------------------------------------------------------------
5313.10: repack                           91.76(680.94+2.48)
5313.11: repack size                               439.1M
5313.12: repack with --path-walk          110.35(130.46+0.74)
5313.13: repack size with --path-walk              155.3M

[1] https://github.com/microsoft/fluentui

Here, we see the significant improvement of a full repack using this
strategy. The name-hash collisions in this repo cause the space
problems. Those collisions also cause the repack command to spend a lot
of cycles trying to find delta bases among files that are not actually
very similar, so the lack of threading with the --path-walk feature is
less pronounced in the process time.

For the Linux kernel repository, we have these stats:

Test                                      this tree
---------------------------------------------------------------
5313.10: repack                           553.61(1929.41+30.31)
5313.11: repack size                                 2.5G
5313.12: repack with --path-walk          1777.63(2044.16+7.47)
5313.13: repack size with --path-walk                2.5G

This demonstrates that the --path-walk feature does not always present
measurable improvements, especially in cases where the name-hash has
very few collisions.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-repack.txt | 17 ++++++++++++++++-
 builtin/repack.c             |  9 ++++++++-
 t/perf/p5313-pack-objects.sh | 18 ++++++++++++++++++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index c902512a9e8..4ec59cd27b1 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,9 @@ git-repack - Pack unpacked objects in a repository
 SYNOPSIS
 --------
 [verse]
-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>] [--write-midx]
+'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
+	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
+	[--write-midx] [--path-walk]
 
 DESCRIPTION
 -----------
@@ -249,6 +251,19 @@ linkgit:git-multi-pack-index[1]).
 	Write a multi-pack index (see linkgit:git-multi-pack-index[1])
 	containing the non-redundant packs.
 
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
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/repack.c b/builtin/repack.c
index cb4420f0856..af3f218ced7 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -39,7 +39,9 @@ static int run_update_server_info = 1;
 static char *packdir, *packtmp_name, *packtmp;
 
 static const char *const git_repack_usage[] = {
-	N_("git repack [<options>]"),
+	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
+	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
+	   "[--write-midx] [--full-path-walk]"),
 	NULL
 };
 
@@ -58,6 +60,7 @@ struct pack_objects_args {
 	int no_reuse_object;
 	int quiet;
 	int local;
+	int path_walk;
 	struct list_objects_filter_options filter_options;
 };
 
@@ -289,6 +292,8 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_pushf(&cmd->args, "--no-reuse-delta");
 	if (args->no_reuse_object)
 		strvec_pushf(&cmd->args, "--no-reuse-object");
+	if (args->path_walk)
+		strvec_pushf(&cmd->args, "--path-walk");
 	if (args->local)
 		strvec_push(&cmd->args,  "--local");
 	if (args->quiet)
@@ -1182,6 +1187,8 @@ int cmd_repack(int argc,
 				N_("pass --no-reuse-delta to git-pack-objects")),
 		OPT_BOOL('F', NULL, &po_args.no_reuse_object,
 				N_("pass --no-reuse-object to git-pack-objects")),
+		OPT_BOOL(0, "path-walk", &po_args.path_walk,
+				N_("pass --path-walk to git-pack-objects")),
 		OPT_NEGBIT('n', NULL, &run_update_server_info,
 				N_("do not run git-update-server-info"), 1),
 		OPT__QUIET(&po_args.quiet, N_("be quiet")),
diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
index 840075f5691..b588066ddb0 100755
--- a/t/perf/p5313-pack-objects.sh
+++ b/t/perf/p5313-pack-objects.sh
@@ -56,4 +56,22 @@ test_size 'big pack size with --path-walk' '
 	test_file_size out
 '
 
+test_perf 'repack' '
+	git repack -adf
+'
+
+test_size 'repack size' '
+	pack=$(ls .git/objects/pack/pack-*.pack) &&
+	test_file_size "$pack"
+'
+
+test_perf 'repack with --path-walk' '
+	git repack -adf --path-walk
+'
+
+test_size 'repack size with --path-walk' '
+	pack=$(ls .git/objects/pack/pack-*.pack) &&
+	test_file_size "$pack"
+'
+
 test_done
-- 
gitgitgadget

