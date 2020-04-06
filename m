Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EAFC2BABC
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7808323BCE
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT+5KPSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgDFRAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:00:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44548 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbgDFRAK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 13:00:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id i16so331196edy.11
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 10:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pg2pmkJfOHr9lfHzYyqsIOuMzCf7SUS5JtSNcQKLUIU=;
        b=fT+5KPSltT6FsVjk+FxWqyxXKVJHOneDR3l0dXeLgVvIslq9DCFk47377bC0o4aY8Z
         rrx5QFY/bGbhE5cQue3Dv3mIgyMFEf1Ujx2HBZdCCDR4Zqodzi905rlfzcpujPLXbHTm
         E2rAT5aNaHuxUTv397kl8Yrz1bSHNYEe7/08O1gO2fkUWpbovfvzGmRCIOW7zAXrV0Dx
         BKTudbv5Wop6X9KUAIIu1gjsuQTyMuZf/1SVidrPU9fzOP/nlKDUc65geOdc5UbN7C7d
         XWfutEVZQtbd6NJ9QlT1ztmnMyjt0YIp5rQSCfcEnLXAnBBOgNQh0uyHTkLTeLSYMDa2
         ckRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pg2pmkJfOHr9lfHzYyqsIOuMzCf7SUS5JtSNcQKLUIU=;
        b=OqqHJxZ0bSsYxXz+naZGXiNmXigCHcAkh4vlZWkKMbc88S3mU10w+ARv2tQY097m+b
         o7a3FgkxfWR+I2mUvFRRdR69joYEezaeFAujjmyp0P1+GC1R0CZkWod11wePvLLO6Vjq
         cvoOVD1Kjtki4e/tuLQ0MwxXJ32Pxx9MDARcpm6qTkGyxnil5MxdV8785A+qK1AUNmnT
         C94SE0et05LmhJGf2mi1DIj/iPxivtt9BSxeT6Co7rtDBDN+zJeknoIbAwJyUdc0UGXV
         bLUenmKzecGvccQ3+NR7iG5OdADmgsX8OM00kuHM0tP69s6SV8aZb0zEldRsBrkuOgse
         xBgg==
X-Gm-Message-State: AGi0PuZ1nnhBorl4SPiKc1vkz4uaI95FRLapik4AOFZZyAqfsp8DrKHg
        mj2u9fEJuSokAIGLyVwOqKFhKq8j
X-Google-Smtp-Source: APiQypLZ6CT/TZay+MXZNxaeHYFtTn63QitOfWWoimMfXViCm2YkwrAcb4xi73QHj8gLu/56M98TPA==
X-Received: by 2002:a50:d987:: with SMTP id w7mr19731582edj.276.1586192405227;
        Mon, 06 Apr 2020 10:00:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4sm2946621eju.57.2020.04.06.10.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 10:00:04 -0700 (PDT)
Message-Id: <c8b86c383abdbbd31ba307eb7e79942ddde1b711.1586192395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
        <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Apr 2020 16:59:51 +0000
Subject: [PATCH v4 11/15] commit-graph: add --changed-paths option to write
 subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Add --changed-paths option to git commit-graph write. This option will
allow users to compute information about the paths that have changed
between a commit and its first parent, and write it into the commit graph
file. If the option is passed to the write subcommand we set the
COMMIT_GRAPH_WRITE_BLOOM_FILTERS flag and pass it down to the
commit-graph logic.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 Documentation/git-commit-graph.txt | 5 +++++
 builtin/commit-graph.c             | 9 +++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 28d1fee5053..f4b13c005b8 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -57,6 +57,11 @@ or `--stdin-packs`.)
 With the `--append` option, include all commits that are present in the
 existing commit-graph file.
 +
+With the `--changed-paths` option, compute and write information about the
+paths changed between a commit and it's first parent. This operation can
+take a while on large repositories. It provides significant performance gains
+for getting history of a directory or a file with `git log -- <path>`.
++
 With the `--split` option, write the commit-graph as a chain of multiple
 commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
 not already in the commit-graph are added in a new "tip" file. This file
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index d1ab6625f63..cacb5d04a80 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -9,7 +9,7 @@
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--changed-paths] [--[no-]progress] <split options>"),
 	NULL
 };
 
@@ -19,7 +19,7 @@ static const char * const builtin_commit_graph_verify_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--changed-paths] [--[no-]progress] <split options>"),
 	NULL
 };
 
@@ -32,6 +32,7 @@ static struct opts_commit_graph {
 	int split;
 	int shallow;
 	int progress;
+	int enable_changed_paths;
 } opts;
 
 static struct object_directory *find_odb(struct repository *r,
@@ -135,6 +136,8 @@ static int graph_write(int argc, const char **argv)
 			N_("start walk at commits listed by stdin")),
 		OPT_BOOL(0, "append", &opts.append,
 			N_("include all commits already in the commit-graph file")),
+		OPT_BOOL(0, "changed-paths", &opts.enable_changed_paths,
+			N_("enable computation for changed paths")),
 		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
 		OPT_BOOL(0, "split", &opts.split,
 			N_("allow writing an incremental commit-graph file")),
@@ -168,6 +171,8 @@ static int graph_write(int argc, const char **argv)
 		flags |= COMMIT_GRAPH_WRITE_SPLIT;
 	if (opts.progress)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
+	if (opts.enable_changed_paths)
+		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
 	read_replace_refs = 0;
 	odb = find_odb(the_repository, opts.obj_dir);
-- 
gitgitgadget

