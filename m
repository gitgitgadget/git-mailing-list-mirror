Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D15C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7132C6113C
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhGTK7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 06:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbhGTK7M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 06:59:12 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6BAC061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:39:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso1414806wme.0
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ToRZ7VQgaz/vK3l2y35gEkpwbkuakOVUgrR5ikqSYMU=;
        b=G9JLMon9kxfzywD1RaXw8G8tGQq5dtQTdE8y56xKPJIaeWHlWGJkKg4uF2bpBcAkDJ
         0ZUrVw4CJ9Tes4zuwXl8geQ1Z3FqkA+rpWxvThDDhh/LeM6rSg2boL3xpWaRIh48wH7M
         d7oBv9+qKHefijPEhr2uCsLvqiFqEGyHOsfHrEpmxPy2p9wFvEae2Q78sWZd+Kp13bwT
         z04RT+F+Wx1StqeQJZeX+65v+Vv5oeBCcSrUvTFQqmckki2uKAESHtVtPFkLeCDWXNRI
         8U5wUbevIGsJwyVLs1gins6NL7aE8C2eWGZR6qEXVvi3tDLFEN++GXy/jh0OxjhcW18/
         RMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ToRZ7VQgaz/vK3l2y35gEkpwbkuakOVUgrR5ikqSYMU=;
        b=m2A2mK7Nv4g9WFPjjcOnyU2Z0JuL1Na/VCXhxUAu3oGvUemejackme5ATfhliIUeoG
         mZzfiO04zjXlBRQuRXxiFvcVKmYC3+AYu+5Q4g/vpXXQiWeJv4oqvM1jD3mtIZxmnPZN
         Fs3M4jbAmwcBUFfSoVYYFxSmi1t+TOm9s02Qz9cp4+hT8bvwxi33PgLoDPw2otmjcWHJ
         3D9sXcnmh9rl1uVZl5k8kxWS4ITPXcLQhpquF504H8HCkZ44qKhoZ9jOYntcZ7BdCT5H
         ae4pfKvBsBehIhaL3Qs1eKVDw8VmeoWlv9Z1RCMS3bbArKmo0W5NWoRxqWD4O75m4q+P
         HLgA==
X-Gm-Message-State: AOAM533MRN1HdFIUGYyYVutwwGQDqwx96ZDTlJliXwkt1fpLBKGvCjr0
        586TTMtZd/fytyBCilr5744Cuhv6DPIsPw==
X-Google-Smtp-Source: ABdhPJyIKVAerRzeAuAzVV/kqGzmZ+4WwYnfIm/BaxLHT7qsAAJuQuFlN+DDuFgCOfJhiSuPbQr7BA==
X-Received: by 2002:a1c:f203:: with SMTP id s3mr36061217wmc.138.1626781188386;
        Tue, 20 Jul 2021 04:39:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y66sm19683595wmy.39.2021.07.20.04.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 04:39:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/6] commit-graph: usage fixes
Date:   Tue, 20 Jul 2021 13:39:39 +0200
Message-Id: <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes hopefully all the comments on v2[1], thanks Andrei and Taylor.

There's now a small mid-series digression before to also refactor the
"early exit to "usage" on !argc" for the multi-pack-index.

Taylor suggested using braces for the "else" so maybe he won't like it
:)

I figured having the two similar commands use the same pattern was
worth the digression.

1. http://lore.kernel.org/git/cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com

Ævar Arnfjörð Bjarmason (6):
  commit-graph: define common usage with a macro
  commit-graph: remove redundant handling of -h
  commit-graph: use parse_options_concat()
  multi-pack-index: refactor "goto usage" pattern
  commit-graph: early exit to "usage" on !argc
  commit-graph: show usage on "commit-graph [write|verify] garbage"

 builtin/commit-graph.c     | 95 +++++++++++++++++++++-----------------
 builtin/multi-pack-index.c | 11 ++---
 t/t5318-commit-graph.sh    |  5 ++
 3 files changed, 63 insertions(+), 48 deletions(-)

Range-diff against v2:
1:  ee6630b7c0d ! 1:  1b9b4703ce2 commit-graph: define common usage with a macro
    @@ builtin/commit-graph.c
     -	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
     -	   "[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress] "
     -	   "<split options>"),
    -+static const char * builtin_commit_graph_verify_usage[] = {
     +#define BUILTIN_COMMIT_GRAPH_VERIFY_USAGE \
     +	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]")
    ++
    ++#define BUILTIN_COMMIT_GRAPH_WRITE_USAGE \
    ++	N_("git commit-graph write [--object-dir <objdir>] [--append] " \
    ++	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] " \
    ++	   "[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress] " \
    ++	   "<split options>")
    ++
    ++static const char * builtin_commit_graph_verify_usage[] = {
     +	BUILTIN_COMMIT_GRAPH_VERIFY_USAGE,
      	NULL
      };
    @@ builtin/commit-graph.c
     -static const char * const builtin_commit_graph_verify_usage[] = {
     -	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
     +static const char * builtin_commit_graph_write_usage[] = {
    -+#define BUILTIN_COMMIT_GRAPH_WRITE_USAGE \
    -+	N_("git commit-graph write [--object-dir <objdir>] [--append] " \
    -+	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] " \
    -+	   "[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress] " \
    -+	   "<split options>")
     +	BUILTIN_COMMIT_GRAPH_WRITE_USAGE,
      	NULL
      };
2:  03581d85781 ! 2:  8f50750ae5e commit-graph: remove redundant handling of -h
    @@ Commit message
         parse_options() did this at the time, and the commit-graph code never
         used PARSE_OPT_NO_INTERNAL_HELP.
     
    +    We don't need a test for this, it's tested by the t0012-help.sh test
    +    added in d691551192a (t0012: test "-h" with builtins, 2017-05-30).
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/commit-graph.c ##
    @@ builtin/commit-graph.c: int cmd_commit_graph(int argc, const char **argv, const
      	git_config(git_default_config, NULL);
      	argc = parse_options(argc, argv, prefix,
      			     builtin_commit_graph_options,
    -
    - ## t/t5318-commit-graph.sh ##
    -@@ t/t5318-commit-graph.sh: test_description='commit graph'
    - 
    - GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
    - 
    -+test_expect_success 'usage' '
    -+	test_expect_code 129 git commit-graph -h 2>err &&
    -+	! grep error: err
    -+'
    -+
    - test_expect_success 'setup full repo' '
    - 	mkdir full &&
    - 	cd "$TRASH_DIRECTORY/full" &&
3:  8e909cd9c23 ! 3:  f02da994363 commit-graph: use parse_options_concat()
    @@ Commit message
         commit-graph: use parse_options_concat()
     
         Make use of the parse_options_concat() so we don't need to copy/paste
    -    common options like --object-dir. This is inspired by a similar change
    -    to "checkout" in 2087182272
    -    (checkout: split options[] array in three pieces, 2019-03-29).
    +    common options like --object-dir.
    +
    +    This is inspired by a similar change to "checkout" in 2087182272
    +    (checkout: split options[] array in three pieces, 2019-03-29), and the
    +    same pattern in the multi-pack-index command, see
    +    60ca94769ce (builtin/multi-pack-index.c: split sub-commands,
    +    2021-03-30).
     
         A minor behavior change here is that now we're going to list both
         --object-dir and --progress first, before we'd list --progress along
         with other options.
     
    +    Co-authored-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/commit-graph.c ##
    @@ builtin/commit-graph.c: static struct opts_commit_graph {
      	int enable_changed_paths;
      } opts;
      
    -+static struct option *add_common_options(struct option *prevopts)
    ++static struct option common_opts[] = {
    ++	OPT_STRING(0, "object-dir", &opts.obj_dir,
    ++		   N_("dir"),
    ++		   N_("the object directory to store the graph")),
    ++	OPT_BOOL(0, "progress", &opts.progress,
    ++		 N_("force progress reporting")),
    ++	OPT_END()
    ++};
    ++
    ++static struct option *add_common_options(struct option *to)
     +{
    -+	struct option options[] = {
    -+		OPT_STRING(0, "object-dir", &opts.obj_dir,
    -+			   N_("dir"),
    -+			   N_("the object directory to store the graph")),
    -+		OPT_BOOL(0, "progress", &opts.progress,
    -+			 N_("force progress reporting")),
    -+		OPT_END()
    -+	};
    -+	struct option *newopts = parse_options_concat(options, prevopts);
    -+	free(prevopts);
    -+	return newopts;
    ++	return parse_options_concat(common_opts, to);
     +}
     +
      static struct object_directory *find_odb(struct repository *r,
    @@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv)
     -		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
      		OPT_END(),
      	};
    -+	struct option *options = parse_options_dup(builtin_commit_graph_verify_options);
    -+	options = add_common_options(options);
    ++	struct option *options = add_common_options(builtin_commit_graph_verify_options);
      
      	trace2_cmd_mode("verify");
      
    @@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv)
      			     builtin_commit_graph_verify_usage, 0);
      
      	if (!opts.obj_dir)
    +@@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv)
    + 		die_errno(_("Could not open commit-graph '%s'"), graph_name);
    + 
    + 	FREE_AND_NULL(graph_name);
    ++	FREE_AND_NULL(options);
    + 
    + 	if (open_ok)
    + 		graph = load_commit_graph_one_fd_st(the_repository, fd, &st, odb);
     @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
      	struct progress *progress = NULL;
      
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
      			0, write_option_max_new_filters),
      		OPT_END(),
      	};
    -+	struct option *options = parse_options_dup(builtin_commit_graph_write_options);
    -+	options = add_common_options(options);
    ++	struct option *options = add_common_options(builtin_commit_graph_write_options);
      
      	opts.progress = isatty(2);
      	opts.enable_changed_paths = -1;
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
      
      	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
     @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
    + 		result = 1;
    + 
    + cleanup:
    ++	FREE_AND_NULL(options);
    + 	string_list_clear(&pack_indexes, 0);
    + 	strbuf_release(&buf);
    + 	return result;
    +@@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
      
      int cmd_commit_graph(int argc, const char **argv, const char *prefix)
      {
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
     -			N_("the object directory to store the graph")),
     -		OPT_END(),
     -	};
    -+	struct option *no_options = parse_options_dup(NULL);
    -+	struct option *builtin_commit_graph_options = add_common_options(no_options);
    ++	struct option *builtin_commit_graph_options = common_opts;
      
      	git_config(git_default_config, NULL);
      	argc = parse_options(argc, argv, prefix,
-:  ----------- > 4:  6e9bd877866 multi-pack-index: refactor "goto usage" pattern
4:  6801fb18faa = 5:  7acb4bd75ce commit-graph: early exit to "usage" on !argc
5:  5c96699496b ! 6:  5c1694e071e commit-graph: show usage on "commit-graph [write|verify] garbage"
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
      		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs"));
     
      ## t/t5318-commit-graph.sh ##
    -@@ t/t5318-commit-graph.sh: GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
    +@@ t/t5318-commit-graph.sh: test_description='commit graph'
      
    - test_expect_success 'usage' '
    - 	test_expect_code 129 git commit-graph -h 2>err &&
    --	! grep error: err
    -+	! grep error: err &&
    + GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
    + 
    ++test_expect_success 'usage' '
     +	test_expect_code 129 git commit-graph write blah &&
     +	test_expect_code 129 git commit-graph write verify
    - '
    - 
    ++'
    ++
      test_expect_success 'setup full repo' '
    + 	mkdir full &&
    + 	cd "$TRASH_DIRECTORY/full" &&
-- 
2.32.0.874.ge7a9d58bfcf

