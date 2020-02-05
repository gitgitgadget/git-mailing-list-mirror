Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345F1C352A4
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08018214AF
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 22:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fP6tFvBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgBEW4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:56:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42727 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgBEW4k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 17:56:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id k11so4808413wrd.9
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 14:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0m7JmD3qD9y/6dalshL8f5sBFl8nBnSeGaQzpkIootI=;
        b=fP6tFvBh/AekOzoQYsLqA6F/8/LE2qye30yvKW0DXUM3AeHnXdDPzRUBV9MCcDX7VP
         jp4QcRK+EvHB+YIRmuBQVPeTR0lCSc/Wp5InimU6cG3j85tUO6TC2X4uvlH6aNYmIZ0I
         zYpZoaaRe3SmGaLmn6h/26q1JU2HiKSpwcgiwqT5GUe62VYbIxnYNgvsd8DP2MaeT86v
         xyjsfoKZFCkPHQxHCztwFmLsH7ZVS7pDw6azwYMMNg19bLC+KYqxzRLZ+kciP7mEI4EZ
         tO0MGoXjl9nbebV2AsbowPIwLAPiRUNE4jfKNhGXEP4kFrcYXQuNkupj3Yba4LGZUfW7
         tbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0m7JmD3qD9y/6dalshL8f5sBFl8nBnSeGaQzpkIootI=;
        b=UdF8AEtC1SrylM3vg9sl83cRljG+aatBCpxQS98Xh9CCUG5BX0OPgRhR9QdMLGIfnK
         NTqGUNgLlOWV9uXhOR3G+CAB61WsE+nFLCM36RFaNXFggmlz+oENSpTa6nSYEotSYHb/
         TttnHu6KzqK1vD+ls/t9+Z8IDrk8xwZ8NPXlHt5FUK/f9OTyhL4aziijg2eZ+ur/grUP
         1RDrF/Y4hGTRbh2xQWANN6ot7QqJzp8DgFOME0E0Ca4Rr67DRoC+h584lRrZnr4CQEi9
         aFkHPyaelc9PqSkz0vkSQO2OpbNq2Tixs+1ArMkLtbJr0cNEICSeHsmypZz9lV6ydO92
         UyzQ==
X-Gm-Message-State: APjAAAV4n1m7t0j1xG035nhAx3LyMi2cJbEUsv0zcvnS07FFctyZWK7H
        DrMhV6vTrjrZ5WlSO1km3PNcgiqP
X-Google-Smtp-Source: APXvYqw0wEUo8RNuKUYImWyFNd/MXocZ554JVI4hZx2F/bcw+/EfIsWsDiAAPYWymXTB9Z2i8zkJDg==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr185254wru.422.1580943398264;
        Wed, 05 Feb 2020 14:56:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y12sm1243471wmj.6.2020.02.05.14.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:56:37 -0800 (PST)
Message-Id: <3d7ee0c96955dc15c87d04982d8cdec8b62750b2.1580943390.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Feb 2020 22:56:28 +0000
Subject: [PATCH v2 09/11] commit-graph: add --changed-paths option to write
 subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        garimasigit@gmail.com, jnareb@gmail.com,
        christian.couder@gmail.com, emilyshaffer@gmail.com,
        gitster@pobox.com, Garima Singh <garima.singh@microsoft.com>,
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
index bcd85c1976..907d703b30 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -54,6 +54,11 @@ or `--stdin-packs`.)
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
index e0c6fc4bbf..261dcce091 100644
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
 
 static int graph_verify(int argc, const char **argv)
@@ -110,6 +111,8 @@ static int graph_write(int argc, const char **argv)
 			N_("start walk at commits listed by stdin")),
 		OPT_BOOL(0, "append", &opts.append,
 			N_("include all commits already in the commit-graph file")),
+		OPT_BOOL(0, "changed-paths", &opts.enable_changed_paths,
+			N_("enable computation for changed paths")),
 		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
 		OPT_BOOL(0, "split", &opts.split,
 			N_("allow writing an incremental commit-graph file")),
@@ -143,6 +146,8 @@ static int graph_write(int argc, const char **argv)
 		flags |= COMMIT_GRAPH_WRITE_SPLIT;
 	if (opts.progress)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
+	if (opts.enable_changed_paths)
+		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
 	read_replace_refs = 0;
 
-- 
gitgitgadget

