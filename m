Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE6D1D5159
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602674; cv=none; b=GpU7P0loPSLV+f7WVDhnc098OUJuj0I2yo1nOSNPwjbG2NMd+eyDlamiW9pMSvgALInpBhD7BWcc/ctl8NIhMyUseKYmjbYu9m5rh1ai8xSA8O81ALjId6mueXjivTilZSfya4ltK8YYdyP3h/Q7m4NbAOa5qGPch5BYAU3PTRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602674; c=relaxed/simple;
	bh=yQ8K39KLmNTSpzWMCDLYG6tEGjGMHYCefEqGh3kS384=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N6N1hDXcm3d4WFnB8RLBEST3nZeqh0g5Y2F6Y9hFy1f2JnCXIZsN85HBMHWdOUagCgWf3neE3/P5BiXf/yfBEwKEJVHf+myoRwNS7o35aln1xI6WV1Rx5fEs/SaTf583XwLlk8qkDZS7p8ORNFoI+Vd0htCqmeXABuZKFLUmuRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fo34QTMR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fo34QTMR"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so769434966b.2
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 09:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738602670; x=1739207470; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDCZ0Bi14VuowCOYNYY0cX8hJcy0lFs6qbiaz5oaMuQ=;
        b=fo34QTMRWp2owZTJltFhiqveB3d24K/RkSklPfaIOrNuALjFzHFTrApxC2b8AYQ7Y7
         znGVsEMGerJxGx88JixgX/OVmFA6ysG/6hHU8y2VyzdlYkhwjp4bYBL9nK9l3lyZUAp/
         g7lLxU2ll/NEcstUT8k85mppuyc9KVuuRP3ENPHIEl5JvxmcYbyVlKj8yg26i77hZnRx
         SQG66ygDMILsji5pa2Vq87HYCNT+nyITW5KLFTX/b8gqMLq6aiZ5zUN168ZNmUqHCzFg
         RKL0iJCL+/85BiVeY09YfQ49Zhvy0pb+7+ypmkZ7w/jEyliHDHZSskUs5SNxYawyo6jz
         eHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738602670; x=1739207470;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDCZ0Bi14VuowCOYNYY0cX8hJcy0lFs6qbiaz5oaMuQ=;
        b=YAWT43bmTaTPLv4cDXqJpIN8pFVMUEzrW5EJmFzAroJImYYwHgAAC5ylWqvONtiGKX
         PJVlC6cTV3YT2J2C0tEBk4AFXKzVX3941Cg2cfsxs9vKJmCdPIWNo+fr9YAV6N39FYXi
         F6okiGuTxMCLjczSsffwmvBmOM5SQOPE3sQzbkHxoiwBj8cYVN6olsBCL7onDqpig0eO
         lUI8Y+8xhZYK41uHyKxFDCL1zElNsQhJkGg37KLt30tBv2ASxDUBW0rq3r7GCwAkoKIz
         p7o5MWel8EA/zG+2BlWW0e6Ypz2Kxo8rpn8XlW/nHvsz/PHMO+LZEqyYoYM8/ZIJD7mv
         QjDA==
X-Gm-Message-State: AOJu0Yw9Xd0O6G2BsPNpjC0DC0EmZT68mkJazlXVA8gqMyxQIeelDy0t
	3YKwnCljaKwD4lzdix+4ZXmkizg34v1PSIftRD//zEyszb+4MuzM2P00fg==
X-Gm-Gg: ASbGncut6+5G4Q3MrJeuyuDWrq6PovFAyuqFogSZKMGt3tfN/Frs59lUuljFTTJQbs3
	s+lhCX1Izf0jcxdlLZNF1+vfSG+sumkzIfJxMTCyY+cjggcs+akbTAe4ll3Ho+cWN9kCNzURGXl
	cKVhHqO2UGJ56kmmI+QvfJTZsTsJGkqwDol5Dgi05/87+p4JVwJw2UiPQIxBC6zU62BelJQmoU1
	62YDeKCKiiHS4+ZbBkqlMouQdxPlJEv6OtP1zJ5PvhJD5Lvx2+yubavuj+W6/TlwuCtS10n2ngp
	y1ILYUJ36KY6Dy63
X-Google-Smtp-Source: AGHT+IHUFS53o8zNYofSt+yi0fCTjWOIZvEuqxxFN/qwjfzt2n8xufIZAx+v3+lIrA9oxq17xj1yUA==
X-Received: by 2002:a17:907:3f89:b0:ab2:d96d:6362 with SMTP id a640c23a62f3a-ab6cfcb3b7cmr2530841166b.1.1738602669721;
        Mon, 03 Feb 2025 09:11:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab703fbcc0csm561041166b.53.2025.02.03.09.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 09:11:09 -0800 (PST)
Message-Id: <pull.1820.v3.git.1738602667.gitgitgadget@gmail.com>
In-Reply-To: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
References: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 03 Feb 2025 17:11:02 +0000
Subject: [PATCH v3 0/5] PATH WALK III: Add 'git backfill' command
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
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
    Derrick Stolee <stolee@gmail.com>

This is based on 'master' now that ds/path-walk [1] is merged. An earlier
version was part of my initial path-walk RFC [2].

[1]
https://lore.kernel.org/git/pull.1818.v3.git.1733514358.gitgitgadget@gmail.com/

[2]
https://lore.kernel.org/git/pull.1786.git.1725935335.gitgitgadget@gmail.com/

This series adds a new 'git backfill' command that uses the path-walk API to
download missing blobs in a blobless partial clone. Users can specify
interaction with the sparse-checkout using '--[no-]sparse' but the
'--sparse' option is implied by the existence of a sparse-checkout.

The reason to use the path-walk API is to make sure that the missing objects
are grouped by a common path, giving a reasonable process for batching
requests and expecting the server to compress the resulting packfile nicely
together.

I first prototyped this feature in June 2024 as an exploration and created
the path-walk algorithm for this purpose. It was only my intuition that led
me to believe that batching by path would lead to better packfiles. This has
been proven out as a very important feature due to recent investigations to
compressing full repositories by doing a better job of grouping objects by
path. See the --name-hash-version series [3] or the 'git pack-objects
--path-walk' series [4] (currently on hold as it conflicts with the
--name-hash-version series).

[3]
https://lore.kernel.org/git/pull.1823.v2.git.1733181682.gitgitgadget@gmail.com/

[4]
https://lore.kernel.org/git/pull.1813.v2.git.1729431810.gitgitgadget@gmail.com/

This idea can be further demonstrated by the evidence in testing this
feature: by downloading objects in small batch sizes, the client can force
the server to repack things more efficiently than a full repack.

The example repository I have used in multiple places is the
microsoft/fluentui repo [5] as it has many CHANGELOG.md files that cause
name hash collisions that make the full repack inefficient.

[5] https://github.com/microsoft/fluentui

If we create a blobless clone of the fluentui repo, then this downloads 105
MB across two packfiles (the commits and trees pack, followed by the blobs
needed for an initial checkout). Running 'git backfill --batch-size=' for
different sizes leads to some interesting results:

| Batch Size      | Pack Count | Pack Size | Time   |
|-----------------|------------|-----------|--------|
| (Initial clone) | 2          | 105 MB    |        |
| 5K              | 53         | 348 MB    | 2m 26s |
| 10K             | 28         | 365 MB    | 2m 22s |
| 15K             | 19         | 407 MB    | 2m 21s |
| 20K             | 15         | 393 MB    | 2m 28s |
| 25K             | 13         | 417 MB    | 2m 06s |
| 50K             | 8          | 509 MB    | 1m 34s |
| 100K            | 5          | 535 MB    | 1m 56s |
| 250K            | 4          | 698 MB    | 1m 33s |
| 500K            | 3          | 696 MB    | 1m 42s |


The smaller batches cause the server to realize that the existing deltas
cannot be reused and it finds better deltas. This takes some extra time for
the small batches, but halves the size of the repo. Even in the 500K batch
size, we get less data than the 738 MB of a full clone.

Implementing the --sparse feature is best done by augmenting the path-walk
API to be aware of a pattern list. This works for both cone and non-cone
mode sparse-checkouts.

There are future directions we could take this command, especially to run
the command with a user-specified pathspec. The tricky case for that
additional feature is trying to make the path-walk more efficient by
skipping tree paths that would not lead to a match of the pathspec. It would
likely need optimization in a small subset of pathspec features (such as
prefix matches) to work as efficiently as possible. I did prototype a
version that puts the pathspec match in the callback function within
builtin/backfill.c, but I found that uninspiring and unnecessary for now.


Updates in v2
=============

Thanks for the review on v1.

 * Memory leaks should be plugged now due to the introduction of a
   destructor in v4 of the path-walk API and its extension here to clear the
   pattern list.

 * Documentation is expanded to demonstrate that 'git backfill' can also
   approximate incremental/resumable clones of repositories.

 * Method renames to better match style.

 * --batch-size is renamed to --min-batch-size for clarity and future
   extensibility.


Updates in v3
=============

 * Rebased onto 'master' now that the path-walk API is merged.

 * New builtin boilerplate is updated with new standards, including:

 * Doc formatting uses [synopsis] formatting.
 * Add builtin/backfill.c to meson.build.
 * Add Documentation/git-backfill.txt to Documentation/meson.build.
 * Add t/t5620-backfill.sh to t/meson.build.
 * Update handling of -h due to f66d1423f5 (builtin: send usage() help text
   to standard output, 2025-01-16).

 * Doc formatting is updated to use back-ticks on options and mark the
   builtin as experimental.

 * The batch_size member of 'struct backfill_context' is now named
   'min_batch_size' in all patches.

 * Some mentions of '--batch-size' are updated to '--min-batch-size'.

 * An additional test is included for non-cone-mode sparse-checkout patterns
   to further check the return values of path_matches_pattern_list() within
   the path-walk API with sparse mode.

 * A use of oid_object_info_extended() is replaced with has_object().

 * The backfill_context_clear() method is called by the proper owner of the
   struct.

Thanks, -Stolee

Derrick Stolee (5):
  backfill: add builtin boilerplate
  backfill: basic functionality and tests
  backfill: add --min-batch-size=<n> option
  backfill: add --sparse option
  backfill: assume --sparse when sparse-checkout is enabled

 .gitignore                                |   1 +
 Documentation/git-backfill.txt            |  71 ++++++++
 Documentation/meson.build                 |   1 +
 Documentation/technical/api-path-walk.txt |  11 +-
 Makefile                                  |   1 +
 builtin.h                                 |   1 +
 builtin/backfill.c                        | 146 +++++++++++++++
 command-list.txt                          |   1 +
 dir.c                                     |  10 +-
 dir.h                                     |   3 +
 git.c                                     |   1 +
 meson.build                               |   1 +
 path-walk.c                               |  28 ++-
 path-walk.h                               |  11 ++
 t/helper/test-path-walk.c                 |  22 ++-
 t/meson.build                             |   1 +
 t/t5620-backfill.sh                       | 211 ++++++++++++++++++++++
 t/t6601-path-walk.sh                      |  32 ++++
 18 files changed, 539 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/git-backfill.txt
 create mode 100644 builtin/backfill.c
 create mode 100755 t/t5620-backfill.sh


base-commit: 58b5801aa94ad5031978f8e42c1be1230b3d352f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1820%2Fderrickstolee%2Fbackfill-upstream-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1820/derrickstolee/backfill-upstream-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1820

Range-diff vs v2:

 1:  ac86510417a ! 1:  1612ad92455 backfill: add builtin boilerplate
     @@ Commit message
          backfill: add builtin boilerplate
      
          In anticipation of implementing 'git backfill', populate the necessary files
     -    with the boilerplate of a new builtin.
     +    with the boilerplate of a new builtin. Mark the builtin as experimental at
     +    this time, allowing breaking changes in the near future, if necessary.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     @@ Documentation/git-backfill.txt (new)
      +
      +SYNOPSIS
      +--------
     -+[verse]
     -+'git backfill' [<options>]
     ++[synopsis]
     ++git backfill [<options>]
      +
      +DESCRIPTION
      +-----------
      +
     ++THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR MAY CHANGE IN THE FUTURE.
     ++
      +SEE ALSO
      +--------
      +linkgit:git-clone[1].
     @@ Documentation/git-backfill.txt (new)
      +---
      +Part of the linkgit:git[1] suite
      
     + ## Documentation/meson.build ##
     +@@ Documentation/meson.build: manpages = {
     +   'git-apply.txt' : 1,
     +   'git-archimport.txt' : 1,
     +   'git-archive.txt' : 1,
     ++  'git-backfill.txt' : 1,
     +   'git-bisect.txt' : 1,
     +   'git-blame.txt' : 1,
     +   'git-branch.txt' : 1,
     +
       ## Makefile ##
      @@ Makefile: BUILTIN_OBJS += builtin/am.o
       BUILTIN_OBJS += builtin/annotate.o
     @@ builtin/backfill.c (new)
      +		OPT_END(),
      +	};
      +
     -+	if (argc == 2 && !strcmp(argv[1], "-h"))
     -+		usage_with_options(builtin_backfill_usage, options);
     ++	show_usage_if_asked(argc, argv, builtin_backfill_usage[0]);
      +
      +	argc = parse_options(argc, argv, prefix, options, builtin_backfill_usage,
      +			     0);
     @@ git.c: static struct cmd_struct commands[] = {
       	{ "bisect", cmd_bisect, RUN_SETUP },
       	{ "blame", cmd_blame, RUN_SETUP },
       	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
     +
     + ## meson.build ##
     +@@ meson.build: builtin_sources = [
     +   'builtin/annotate.c',
     +   'builtin/apply.c',
     +   'builtin/archive.c',
     ++  'builtin/backfill.c',
     +   'builtin/bisect.c',
     +   'builtin/blame.c',
     +   'builtin/branch.c',
 2:  e4e88794cae ! 2:  d0cb9cb9af5 backfill: basic functionality and tests
     @@ Commit message
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/git-backfill.txt ##
     -@@ Documentation/git-backfill.txt: SYNOPSIS
     +@@ Documentation/git-backfill.txt: git backfill [<options>]
       DESCRIPTION
       -----------
       
     @@ Documentation/git-backfill.txt: SYNOPSIS
      +By default, `git backfill` downloads all blobs reachable from the `HEAD`
      +commit. This set can be restricted or expanded using various options.
      +
     + THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR MAY CHANGE IN THE FUTURE.
     + 
       SEE ALSO
     - --------
     - linkgit:git-clone[1].
      
       ## Documentation/technical/api-path-walk.txt ##
      @@ Documentation/technical/api-path-walk.txt: Examples
     @@ builtin/backfill.c
      +struct backfill_context {
      +	struct repository *repo;
      +	struct oid_array current_batch;
     -+	size_t batch_size;
     ++	size_t min_batch_size;
      +};
      +
      +static void backfill_context_clear(struct backfill_context *ctx)
     @@ builtin/backfill.c
      +		return 0;
      +
      +	for (size_t i = 0; i < list->nr; i++) {
     -+		off_t size = 0;
     -+		struct object_info info = OBJECT_INFO_INIT;
     -+		info.disk_sizep = &size;
     -+		if (oid_object_info_extended(ctx->repo,
     -+					     &list->oid[i],
     -+					     &info,
     -+					     OBJECT_INFO_FOR_PREFETCH) ||
     -+		    !size)
     ++		if (!has_object(ctx->repo, &list->oid[i],
     ++				OBJECT_INFO_FOR_PREFETCH))
      +			oid_array_append(&ctx->current_batch, &list->oid[i]);
      +	}
      +
     -+	if (ctx->current_batch.nr >= ctx->batch_size)
     ++	if (ctx->current_batch.nr >= ctx->min_batch_size)
      +		download_batch(ctx);
      +
      +	return 0;
     @@ builtin/backfill.c
      +	if (!ret)
      +		download_batch(ctx);
      +
     -+	backfill_context_clear(ctx);
      +	path_walk_info_clear(&info);
      +	release_revisions(&revs);
      +	return ret;
     @@ builtin/backfill.c
      +
       int cmd_backfill(int argc, const char **argv, const char *prefix, struct repository *repo)
       {
     ++	int result;
      +	struct backfill_context ctx = {
      +		.repo = repo,
      +		.current_batch = OID_ARRAY_INIT,
     -+		.batch_size = 50000,
     ++		.min_batch_size = 50000,
      +	};
       	struct option options[] = {
       		OPT_END(),
     @@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *pr
      -	die(_("not implemented"));
      -
      -	return 0;
     -+	return do_backfill(&ctx);
     ++	result = do_backfill(&ctx);
     ++	backfill_context_clear(&ctx);
     ++	return result;
       }
      
     + ## t/meson.build ##
     +@@ t/meson.build: integration_tests = [
     +   't5617-clone-submodules-remote.sh',
     +   't5618-alternate-refs.sh',
     +   't5619-clone-local-ambiguous-transport.sh',
     ++  't5620-backfill.sh',
     +   't5700-protocol-v1.sh',
     +   't5701-git-serve.sh',
     +   't5702-protocol-v2.sh',
     +
       ## t/t5620-backfill.sh (new) ##
      @@
      +#!/bin/sh
 3:  3fa32822dab ! 3:  b35c2f06b59 backfill: add --min-batch-size=<n> option
     @@ Commit message
          future. For now, we let the path-walk API batches determine the
          boundaries.
      
     -    To get a feeling for the value of specifying the --batch-size parameter,
     +    To get a feeling for the value of specifying the --min-batch-size parameter,
          I tested a number of open source repositories available on GitHub. The
          procedure was generally:
      
     @@ Documentation/git-backfill.txt
      @@ Documentation/git-backfill.txt: git-backfill - Download missing objects in a partial clone
       SYNOPSIS
       --------
     - [verse]
     --'git backfill' [<options>]
     -+'git backfill' [--batch-size=<n>]
     + [synopsis]
     +-git backfill [<options>]
     ++git backfill [--min-batch-size=<n>]
       
       DESCRIPTION
       -----------
     -@@ Documentation/git-backfill.txt: time.
     - By default, `git backfill` downloads all blobs reachable from the `HEAD`
     - commit. This set can be restricted or expanded using various options.
     +@@ Documentation/git-backfill.txt: commit. This set can be restricted or expanded using various options.
       
     + THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR MAY CHANGE IN THE FUTURE.
     + 
     ++
      +OPTIONS
      +-------
      +
     -+--min-batch-size=<n>::
     ++`--min-batch-size=<n>`::
      +	Specify a minimum size for a batch of missing objects to request
      +	from the server. This size may be exceeded by the last set of
      +	blobs seen at a given path. The default minimum batch size is
     @@ builtin/backfill.c
       
       static const char * const builtin_backfill_usage[] = {
      -	N_("git backfill [<options>]"),
     -+	N_("git backfill [--batch-size=<n>]"),
     ++	N_("git backfill [--min-batch-size=<n>]"),
       	NULL
       };
       
     - struct backfill_context {
     - 	struct repository *repo;
     - 	struct oid_array current_batch;
     --	size_t batch_size;
     -+	size_t min_batch_size;
     - };
     - 
     - static void backfill_context_clear(struct backfill_context *ctx)
     -@@ builtin/backfill.c: static int fill_missing_blobs(const char *path UNUSED,
     - 			oid_array_append(&ctx->current_batch, &list->oid[i]);
     - 	}
     - 
     --	if (ctx->current_batch.nr >= ctx->batch_size)
     -+	if (ctx->current_batch.nr >= ctx->min_batch_size)
     - 		download_batch(ctx);
     - 
     - 	return 0;
      @@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
     - 	struct backfill_context ctx = {
     - 		.repo = repo,
     - 		.current_batch = OID_ARRAY_INIT,
     --		.batch_size = 50000,
     -+		.min_batch_size = 50000,
     + 		.min_batch_size = 50000,
       	};
       	struct option options[] = {
      +		OPT_INTEGER(0, "min-batch-size", &ctx.min_batch_size,
 4:  2723143afb3 ! 4:  f1c5a5c5fde backfill: add --sparse option
     @@ Commit message
      
          Be sure to test this in both cone mode and not cone mode. Cone mode has the
          benefit that the path-walk can skip certain paths once they would expand
     -    beyond the sparse-checkout.
     +    beyond the sparse-checkout. Non-cone mode can describe the included files
     +    using both positive and negative patterns, which changes the possible return
     +    values of path_matches_pattern_list(). Test both kinds of matches for
     +    increased coverage.
      
          To test this, we can create a blobless sparse clone, expand the
          sparse-checkout slightly, and then run 'git backfill --sparse' to see
     @@ Documentation/git-backfill.txt
      @@ Documentation/git-backfill.txt: git-backfill - Download missing objects in a partial clone
       SYNOPSIS
       --------
     - [verse]
     --'git backfill' [--batch-size=<n>]
     -+'git backfill' [--batch-size=<n>] [--[no-]sparse]
     + [synopsis]
     +-git backfill [--min-batch-size=<n>]
     ++git backfill [--min-batch-size=<n>] [--[no-]sparse]
       
       DESCRIPTION
       -----------
     @@ Documentation/git-backfill.txt: OPTIONS
       	blobs seen at a given path. The default minimum batch size is
       	50,000.
       
     -+--[no-]sparse::
     ++`--[no-]sparse`::
      +	Only download objects if they appear at a path that matches the
      +	current sparse-checkout.
      +
     @@ builtin/backfill.c
       #include "path-walk.h"
       
       static const char * const builtin_backfill_usage[] = {
     --	N_("git backfill [--batch-size=<n>]"),
     -+	N_("git backfill [--batch-size=<n>] [--[no-]sparse]"),
     +-	N_("git backfill [--min-batch-size=<n>]"),
     ++	N_("git backfill [--min-batch-size=<n>] [--[no-]sparse]"),
       	NULL
       };
       
     @@ t/t5620-backfill.sh: test_expect_success 'do partial clone 2, backfill min batch
      +	test_line_count = 24 missing
      +'
      +
     -+test_expect_success 'backfill --sparse without cone mode' '
     ++test_expect_success 'backfill --sparse without cone mode (positive)' '
      +	git clone --no-checkout --filter=blob:none		\
      +		--single-branch --branch=main 		\
      +		"file://$(pwd)/srv.bare" backfill4 &&
     @@ t/t5620-backfill.sh: test_expect_success 'do partial clone 2, backfill min batch
      +	git -C backfill4 sparse-checkout set --no-cone "**/file.1.txt" &&
      +	git -C backfill4 checkout main &&
      +
     ++	# Track new blob count
     ++	git -C backfill4 rev-list --quiet --objects --missing=print HEAD >missing &&
     ++	test_line_count = 42 missing &&
     ++
      +	GIT_TRACE2_EVENT="$(pwd)/no-cone-trace1" git \
      +		-C backfill4 backfill --sparse &&
      +	test_trace2_data promisor fetch_count 6 <no-cone-trace1 &&
     @@ t/t5620-backfill.sh: test_expect_success 'do partial clone 2, backfill min batch
      +	git -C backfill4 rev-list --quiet --objects --missing=print HEAD >missing &&
      +	test_line_count = 36 missing
      +'
     ++
     ++test_expect_success 'backfill --sparse without cone mode (negative)' '
     ++	git clone --no-checkout --filter=blob:none		\
     ++		--single-branch --branch=main 		\
     ++		"file://$(pwd)/srv.bare" backfill5 &&
     ++
     ++	# No blobs yet
     ++	git -C backfill5 rev-list --quiet --objects --missing=print HEAD >missing &&
     ++	test_line_count = 48 missing &&
     ++
     ++	# Define sparse-checkout by filename regardless of parent directory.
     ++	# This downloads 18 blobs to satisfy the checkout
     ++	git -C backfill5 sparse-checkout set --no-cone "**/file*" "!**/file.1.txt" &&
     ++	git -C backfill5 checkout main &&
     ++
     ++	# Track new blob count
     ++	git -C backfill5 rev-list --quiet --objects --missing=print HEAD >missing &&
     ++	test_line_count = 30 missing &&
     ++
     ++	GIT_TRACE2_EVENT="$(pwd)/no-cone-trace2" git \
     ++		-C backfill5 backfill --sparse &&
     ++	test_trace2_data promisor fetch_count 18 <no-cone-trace2 &&
     ++
     ++	# This walk needed to visit all directories to search for these paths, plus
     ++	# 12 extra "file.?.txt" paths than the previous test.
     ++	test_trace2_data path-walk paths 24 <no-cone-trace2 &&
     ++	git -C backfill5 rev-list --quiet --objects --missing=print HEAD >missing &&
     ++	test_line_count = 12 missing
     ++'
      +
       . "$TEST_DIRECTORY"/lib-httpd.sh
       start_httpd
 5:  1f765409eaf ! 5:  f22cf8b3485 backfill: assume --sparse when sparse-checkout is enabled
     @@ Commit message
       ## Documentation/git-backfill.txt ##
      @@ Documentation/git-backfill.txt: OPTIONS
       
     - --[no-]sparse::
     + `--[no-]sparse`::
       	Only download objects if they appear at a path that matches the
      -	current sparse-checkout.
      +	current sparse-checkout. If the sparse-checkout feature is enabled,
     @@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *pr
      +	if (ctx.sparse < 0)
      +		ctx.sparse = core_apply_sparse_checkout;
      +
     - 	return do_backfill(&ctx);
     - }
     + 	result = do_backfill(&ctx);
     + 	backfill_context_clear(&ctx);
     + 	return result;
      
       ## t/t5620-backfill.sh ##
      @@ t/t5620-backfill.sh: test_expect_success 'do partial clone 2, backfill min batch size' '
     @@ t/t5620-backfill.sh: test_expect_success 'backfill --sparse' '
      +	test_line_count = 0 missing
       '
       
     - test_expect_success 'backfill --sparse without cone mode' '
     + test_expect_success 'backfill --sparse without cone mode (positive)' '

-- 
gitgitgadget
