Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5460CC43461
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 15:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F5DC2073B
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 15:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="tcbY3FvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbgIDPU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729942AbgIDPU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 11:20:28 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1354C061244
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 08:20:27 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cr8so3160336qvb.10
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xj61HVBFTbPTt4F940+L+ZlepJdeoJZdAOw3Wx5jHNY=;
        b=tcbY3FvY/TA0MHd/u39qLC7Bz0x+r3SAKLhz/Pgbj+wfTQkGB0xI8WRw8v4hWcozjf
         DFt+9WbA1pURlm8u65Gm5ZO7cnbBISHFhYXFgWHTFFlUtFeyeJOf+C/wLpOhpaDmaD1O
         GJAFYFaUufe+bxoKZdJxH2AZsiKUGigA5VHPvY6qWkgYmIRHCUUlS9Tuhk8BAJx4gRS0
         ATW6CfU/qHb/7urOSX4RgTfEd00IkaZ+NQc/cLW7OFCukN04eEG8hMuIpv18WzcukN4j
         OkIyHTLk/rr+DUiBSRnZ/7RkVEen3X9cXsJC2ZxWgOuSqZDAP/DdEFtHv+WnN7nGA+PH
         VLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xj61HVBFTbPTt4F940+L+ZlepJdeoJZdAOw3Wx5jHNY=;
        b=AmWK5DnS9LmyYErIK50I/y3amDbQxwa3exuDFKW2RGzL2xXPxcuSn/va8JHZBHSm7m
         gl8OIHd8dTl9eLhDXf1HfmDw+n21jP+A9uHa/Y/0hxKWa684Y5j/F7LfCd+OwvVuVMQm
         Dc/DfOa9g08C2k4LDR9QBdI704+npis4ZST6HSpAAjWc1Sg0HFGlTnWI63CYT8DvDG7m
         rup5wBySnE8iVQTDnh0lTKmzjAzLCdRst+fm4C9W2MBWCl7a80GHvp7dJOXQwonr0n2c
         y6BK9+bOcX4resj8j7RW0CpFun7wV4vzc4tHg6jKvboup50tum16/LSf7oi+3LswLAiB
         W9IA==
X-Gm-Message-State: AOAM530VKCZSLkJ9SihlkhR9o+mW0aW6jDdUIMUF1wXbe8ulEbiSNot4
        KCfupbRyJfLNCbxYAV1U442XgAMlHhszWZmG
X-Google-Smtp-Source: ABdhPJx+dOZow+Xt+FNBstlsJpdxGeXx2E2P65kFBP/JU1O36f+j2/5FVg41OU35EE0oPENNCZ8y+w==
X-Received: by 2002:ad4:59d0:: with SMTP id el16mr8222150qvb.116.1599232826115;
        Fri, 04 Sep 2020 08:20:26 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a97c:6dae:76a4:c715])
        by smtp.gmail.com with ESMTPSA id b13sm4705216qkl.46.2020.09.04.08.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:20:24 -0700 (PDT)
Date:   Fri, 4 Sep 2020 11:20:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: [PATCH v4 13/14] commit-graph: rename 'split_commit_graph_opts'
Message-ID: <20200904152021.GA15674@nand.local>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1599172907.git.me@ttaylorr.com>
 <ee0bc109f3db7caf59f55736744646a9ee047b01.1599172908.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee0bc109f3db7caf59f55736744646a9ee047b01.1599172908.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 03, 2020 at 06:46:57PM -0400, Taylor Blau wrote:
> In the subsequent commit, additional options will be added to the
> commit-graph API which have nothing to do with splitting.

I have no idea how 'make *** [Makefile' snuck into this, but it
definitely shouldn't be there. Let's use the below version instead.

--- >8 ---

Subject: [PATCH] commit-graph: rename 'split_commit_graph_opts'

In the subsequent commit, additional options will be added to the
commit-graph API which have nothing to do with splitting.

Rename the 'split_commit_graph_opts' structure to the more-generic
'commit_graph_opts' to encompass both. Likewise, rename the 'flags'
member to instead be 'split_flags' to clarify that it only has to do
with the behavior implied by '--split'.

Suggested-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/commit-graph.c | 20 ++++++++++----------
 commit-graph.c         | 40 ++++++++++++++++++++--------------------
 commit-graph.h         |  8 ++++----
 3 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index ba5584463f..f3243bd982 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -119,7 +119,7 @@ static int graph_verify(int argc, const char **argv)
 }

 extern int read_replace_refs;
-static struct split_commit_graph_opts split_opts;
+static struct commit_graph_opts write_opts;

 static int write_option_parse_split(const struct option *opt, const char *arg,
 				    int unset)
@@ -187,24 +187,24 @@ static int graph_write(int argc, const char **argv)
 		OPT_BOOL(0, "changed-paths", &opts.enable_changed_paths,
 			N_("enable computation for changed paths")),
 		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
-		OPT_CALLBACK_F(0, "split", &split_opts.flags, NULL,
+		OPT_CALLBACK_F(0, "split", &write_opts.split_flags, NULL,
 			N_("allow writing an incremental commit-graph file"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			write_option_parse_split),
-		OPT_INTEGER(0, "max-commits", &split_opts.max_commits,
+		OPT_INTEGER(0, "max-commits", &write_opts.max_commits,
 			N_("maximum number of commits in a non-base split commit-graph")),
-		OPT_INTEGER(0, "size-multiple", &split_opts.size_multiple,
+		OPT_INTEGER(0, "size-multiple", &write_opts.size_multiple,
 			N_("maximum ratio between two levels of a split commit-graph")),
-		OPT_EXPIRY_DATE(0, "expire-time", &split_opts.expire_time,
+		OPT_EXPIRY_DATE(0, "expire-time", &write_opts.expire_time,
 			N_("only expire files older than a given date-time")),
 		OPT_END(),
 	};

 	opts.progress = isatty(2);
 	opts.enable_changed_paths = -1;
-	split_opts.size_multiple = 2;
-	split_opts.max_commits = 0;
-	split_opts.expire_time = 0;
+	write_opts.size_multiple = 2;
+	write_opts.max_commits = 0;
+	write_opts.expire_time = 0;

 	trace2_cmd_mode("write");

@@ -232,7 +232,7 @@ static int graph_write(int argc, const char **argv)
 	odb = find_odb(the_repository, opts.obj_dir);

 	if (opts.reachable) {
-		if (write_commit_graph_reachable(odb, flags, &split_opts))
+		if (write_commit_graph_reachable(odb, flags, &write_opts))
 			return 1;
 		return 0;
 	}
@@ -261,7 +261,7 @@ static int graph_write(int argc, const char **argv)
 			       opts.stdin_packs ? &pack_indexes : NULL,
 			       opts.stdin_commits ? &commits : NULL,
 			       flags,
-			       &split_opts))
+			       &write_opts))
 		result = 1;

 cleanup:
diff --git a/commit-graph.c b/commit-graph.c
index 68ffa6ec35..33fcf01a7a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1012,7 +1012,7 @@ struct write_commit_graph_context {
 		 changed_paths:1,
 		 order_by_pack:1;

-	const struct split_commit_graph_opts *split_opts;
+	const struct commit_graph_opts *opts;
 	size_t total_bloom_filter_data_size;
 	const struct bloom_filter_settings *bloom_settings;

@@ -1353,8 +1353,8 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 {
 	int i;
 	struct commit *commit;
-	enum commit_graph_split_flags flags = ctx->split_opts ?
-		ctx->split_opts->flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
+	enum commit_graph_split_flags flags = ctx->opts ?
+		ctx->opts->split_flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;

 	if (ctx->report_progress)
 		ctx->progress = start_delayed_progress(
@@ -1554,7 +1554,7 @@ static int add_ref_to_set(const char *refname,

 int write_commit_graph_reachable(struct object_directory *odb,
 				 enum commit_graph_write_flags flags,
-				 const struct split_commit_graph_opts *split_opts)
+				 const struct commit_graph_opts *opts)
 {
 	struct oidset commits = OIDSET_INIT;
 	struct refs_cb_data data;
@@ -1571,7 +1571,7 @@ int write_commit_graph_reachable(struct object_directory *odb,
 	stop_progress(&data.progress);

 	result = write_commit_graph(odb, NULL, &commits,
-				    flags, split_opts);
+				    flags, opts);

 	oidset_clear(&commits);
 	return result;
@@ -1686,8 +1686,8 @@ static uint32_t count_distinct_commits(struct write_commit_graph_context *ctx)
 static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 {
 	uint32_t i;
-	enum commit_graph_split_flags flags = ctx->split_opts ?
-		ctx->split_opts->flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
+	enum commit_graph_split_flags flags = ctx->opts ?
+		ctx->opts->split_flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;

 	ctx->num_extra_edges = 0;
 	if (ctx->report_progress)
@@ -1973,13 +1973,13 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 	int max_commits = 0;
 	int size_mult = 2;

-	if (ctx->split_opts) {
-		max_commits = ctx->split_opts->max_commits;
+	if (ctx->opts) {
+		max_commits = ctx->opts->max_commits;

-		if (ctx->split_opts->size_multiple)
-			size_mult = ctx->split_opts->size_multiple;
+		if (ctx->opts->size_multiple)
+			size_mult = ctx->opts->size_multiple;

-		flags = ctx->split_opts->flags;
+		flags = ctx->opts->split_flags;
 	}

 	g = ctx->r->objects->commit_graph;
@@ -2157,8 +2157,8 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	size_t dirnamelen;
 	timestamp_t expire_time = time(NULL);

-	if (ctx->split_opts && ctx->split_opts->expire_time)
-		expire_time = ctx->split_opts->expire_time;
+	if (ctx->opts && ctx->opts->expire_time)
+		expire_time = ctx->opts->expire_time;
 	if (!ctx->split) {
 		char *chain_file_name = get_chain_filename(ctx->odb);
 		unlink(chain_file_name);
@@ -2209,7 +2209,7 @@ int write_commit_graph(struct object_directory *odb,
 		       struct string_list *pack_indexes,
 		       struct oidset *commits,
 		       enum commit_graph_write_flags flags,
-		       const struct split_commit_graph_opts *split_opts)
+		       const struct commit_graph_opts *opts)
 {
 	struct write_commit_graph_context *ctx;
 	uint32_t i, count_distinct = 0;
@@ -2226,7 +2226,7 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0;
 	ctx->report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0;
 	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
-	ctx->split_opts = split_opts;
+	ctx->opts = opts;
 	ctx->total_bloom_filter_data_size = 0;

 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
@@ -2274,15 +2274,15 @@ int write_commit_graph(struct object_directory *odb,
 			}
 		}

-		if (ctx->split_opts)
-			replace = ctx->split_opts->flags & COMMIT_GRAPH_SPLIT_REPLACE;
+		if (ctx->opts)
+			replace = ctx->opts->split_flags & COMMIT_GRAPH_SPLIT_REPLACE;
 	}

 	ctx->approx_nr_objects = approximate_object_count();
 	ctx->oids.alloc = ctx->approx_nr_objects / 32;

-	if (ctx->split && split_opts && ctx->oids.alloc > split_opts->max_commits)
-		ctx->oids.alloc = split_opts->max_commits;
+	if (ctx->split && opts && ctx->oids.alloc > opts->max_commits)
+		ctx->oids.alloc = opts->max_commits;

 	if (ctx->append) {
 		prepare_commit_graph_one(ctx->r, ctx->odb);
diff --git a/commit-graph.h b/commit-graph.h
index 9afb1477d5..fe798a4047 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -115,11 +115,11 @@ enum commit_graph_split_flags {
 	COMMIT_GRAPH_SPLIT_REPLACE          = 2
 };

-struct split_commit_graph_opts {
+struct commit_graph_opts {
 	int size_multiple;
 	int max_commits;
 	timestamp_t expire_time;
-	enum commit_graph_split_flags flags;
+	enum commit_graph_split_flags split_flags;
 };

 /*
@@ -130,12 +130,12 @@ struct split_commit_graph_opts {
  */
 int write_commit_graph_reachable(struct object_directory *odb,
 				 enum commit_graph_write_flags flags,
-				 const struct split_commit_graph_opts *split_opts);
+				 const struct commit_graph_opts *opts);
 int write_commit_graph(struct object_directory *odb,
 		       struct string_list *pack_indexes,
 		       struct oidset *commits,
 		       enum commit_graph_write_flags flags,
-		       const struct split_commit_graph_opts *split_opts);
+		       const struct commit_graph_opts *opts);

 #define COMMIT_GRAPH_VERIFY_SHALLOW	(1 << 0)

--
2.27.0.2918.gc99a27ff8f

