Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F1CC1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 20:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbfITU1N (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 16:27:13 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:61466 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728821AbfITU1N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 16:27:13 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iBPRa-0002yW-8T; Fri, 20 Sep 2019 21:23:56 +0100
Subject: Re: [PATCH v2 0/6] multi-pack-index: add --no-progress
To:     William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, stolee@gmail.com,
        jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>
References: <pull.337.git.gitgitgadget@gmail.com>
 <pull.337.v2.git.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <1c94eaf5-fd62-cca3-2aeb-37512e8e41e6@iee.email>
Date:   Fri, 20 Sep 2019 21:23:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <pull.337.v2.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi William, welcome.

On 20/09/2019 17:53, William Baker via GitGitGadget wrote:
> Hello Git contributors!
>
> My name is William Baker and I work at Microsoft. Over the past few years
> I've worked closely with the Microsoft team contributing to the git
> ecosystem and I'm excited to start working with the community.
>
> Derrick Stolee helped me pick out my first task, and it's to add support for
> opting out of the multi-pack-index progress output. The progress feature was
> introduced in 144d7033 ("multi-pack-index: report progress during 'verify'",
> 2018-09-13) but it did not include the ability to opt-out. This patch adds
> the --[no-]progress option to allow callers control whether progress is
> reported.
>
> This path is very similar to Garima Singh's series for progress reporting in
> the commit-graph [1].
>
> [1] https://public-inbox.org/git/pull.315.git.gitgitgadget@gmail.com/
>
> I'm looking forward to your review. Thanks! William Baker
>
> William Baker (6):
>    midx: add MIDX_PROGRESS flag Add the MIDX_PROGRESS flag and update the
>      write|verify|expire|repack functions in midx.h to accept a flags
>      parameter.  The MIDX_PROGRESS flag indicates whether the caller of
>      the function would like progress information to be displayed. This
>      patch only changes the method prototypes and does not change the
>      functionality. The functionality change will be handled by a later
>      patch.
>    midx: add progress to write_midx_file Add progress to write_midx_file.
>       Progress is displayed when the MIDX_PROGRESS flag is set.
>    midx: add progress to expire_midx_packs Add progress to
>      expire_midx_packs.  Progress is displayed when the MIDX_PROGRESS
>      flag is set.
>    midx: honor the MIDX_PROGRESS flag in verify_midx_file Update
>      verify_midx_file to only display progress when the MIDX_PROGRESS
>      flag is set.
>    midx: honor the MIDX_PROGRESS flag in midx_repack Update midx_repack
>      to only display progress when the MIDX_PROGRESS flag is set.
>    multi-pack-index: add [--[no-]progress] option. Add the
>      --[no-]progress option to git multi-pack-index. Pass the
>      MIDX_PROGRESS flag to the subcommand functions when progress should
>      be displayed by multi-pack-index. The progress feature was added to
>      'verify' in 144d703 ("multi-pack-index: report progress during
>      'verify'", 2018-09-13) but some subcommands were not updated to
>      display progress, and the ability to opt-out was overlooked.
These subject lines are a bit long. Has there been some white space 
damage during preparation, such that the end of line, and following 
blank line, for a short subject line been compromised?

Normally the 'git log --oneline' should fit within the line, so ~50 chars.

Philip

>   Documentation/git-multi-pack-index.txt |  6 ++-
>   builtin/multi-pack-index.c             | 18 +++++--
>   builtin/repack.c                       |  2 +-
>   midx.c                                 | 71 ++++++++++++++++++++------
>   midx.h                                 | 10 ++--
>   t/t5319-multi-pack-index.sh            | 69 +++++++++++++++++++++++++
>   6 files changed, 149 insertions(+), 27 deletions(-)
>
>
> base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-337%2Fwilbaker%2Fmulti-pack-index-progress-toggle-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-337/wilbaker/multi-pack-index-progress-toggle-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/337
>
> Range-diff vs v1:
>
>   -:  ---------- > 1:  6badd9ceaf midx: add MIDX_PROGRESS flag Add the MIDX_PROGRESS flag and update the write|verify|expire|repack functions in midx.h to accept a flags parameter.  The MIDX_PROGRESS flag indicates whether the caller of the function would like progress information to be displayed. This patch only changes the method prototypes and does not change the functionality. The functionality change will be handled by a later patch.
>   -:  ---------- > 2:  3bc8677ea7 midx: add progress to write_midx_file Add progress to write_midx_file.  Progress is displayed when the MIDX_PROGRESS flag is set.
>   -:  ---------- > 3:  3374574001 midx: add progress to expire_midx_packs Add progress to expire_midx_packs.  Progress is displayed when the MIDX_PROGRESS flag is set.
>   -:  ---------- > 4:  29d03771c0 midx: honor the MIDX_PROGRESS flag in verify_midx_file Update verify_midx_file to only display progress when the MIDX_PROGRESS flag is set.
>   -:  ---------- > 5:  57f6742f09 midx: honor the MIDX_PROGRESS flag in midx_repack Update midx_repack to only display progress when the MIDX_PROGRESS flag is set.
>   1:  0821a8073a ! 6:  5b933ab744 multi-pack-index: add --no-progress Add --no-progress option to git multi-pack-index. The progress feature was added in 144d703 ("multi-pack-index: report progress during 'verify'", 2018-09-13) but the ability to opt-out was overlooked.
>       @@ -1,10 +1,13 @@
>        Author: William Baker <William.Baker@microsoft.com>
>        
>       -    multi-pack-index: add --no-progress
>       -    Add --no-progress option to git multi-pack-index.
>       -    The progress feature was added in 144d703
>       +    multi-pack-index: add [--[no-]progress] option.
>       +    Add the --[no-]progress option to git multi-pack-index.
>       +    Pass the MIDX_PROGRESS flag to the subcommand functions
>       +    when progress should be displayed by multi-pack-index.
>       +    The progress feature was added to 'verify' in 144d703
>            ("multi-pack-index: report progress during 'verify'", 2018-09-13)
>       -    but the ability to opt-out was overlooked.
>       +    but some subcommands were not updated to display progress, and
>       +    the ability to opt-out was overlooked.
>        
>            Signed-off-by: William Baker <William.Baker@microsoft.com>
>        
>       @@ -16,7 +19,7 @@
>         --------
>         [verse]
>        -'git multi-pack-index' [--object-dir=<dir>] <subcommand>
>       -+'git multi-pack-index' [--object-dir=<dir>] <subcommand> [--[no-]progress]
>       ++'git multi-pack-index' [--object-dir=<dir>] [--[no-]progress] <subcommand>
>         
>         DESCRIPTION
>         -----------
>       @@ -40,7 +43,7 @@
>         
>         static char const * const builtin_multi_pack_index_usage[] = {
>        -	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire|repack --batch-size=<size>)"),
>       -+	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire|repack --batch-size=<size>) [--[no-]progress]"),
>       ++	N_("git multi-pack-index [<options>] (write|verify|expire|repack --batch-size=<size>)"),
>         	NULL
>         };
>         
>       @@ -58,11 +61,11 @@
>         	static struct option builtin_multi_pack_index_options[] = {
>         		OPT_FILENAME(0, "object-dir", &opts.object_dir,
>         		  N_("object directory containing set of packfile and pack-index pairs")),
>       ++		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
>         		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
>         		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
>       -+		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
>         		OPT_END(),
>       - 	};
>       +@@
>         
>         	git_config(git_default_config, NULL);
>         
>       @@ -82,131 +85,50 @@
>         	trace2_cmd_mode(argv[0]);
>         
>         	if (!strcmp(argv[0], "repack"))
>       --		return midx_repack(the_repository, opts.object_dir, (size_t)opts.batch_size);
>       +-		return midx_repack(the_repository, opts.object_dir, (size_t)opts.batch_size, 0);
>        +		return midx_repack(the_repository, opts.object_dir,
>        +			(size_t)opts.batch_size, flags);
>         	if (opts.batch_size)
>         		die(_("--batch-size option is only for 'repack' subcommand"));
>         
>         	if (!strcmp(argv[0], "write"))
>       - 		return write_midx_file(opts.object_dir);
>       +-		return write_midx_file(opts.object_dir, 0);
>       ++		return write_midx_file(opts.object_dir, flags);
>         	if (!strcmp(argv[0], "verify"))
>       --		return verify_midx_file(the_repository, opts.object_dir);
>       +-		return verify_midx_file(the_repository, opts.object_dir, 0);
>        +		return verify_midx_file(the_repository, opts.object_dir, flags);
>         	if (!strcmp(argv[0], "expire"))
>       - 		return expire_midx_packs(the_repository, opts.object_dir);
>       +-		return expire_midx_packs(the_repository, opts.object_dir, 0);
>       ++		return expire_midx_packs(the_repository, opts.object_dir, flags);
>         
>       + 	die(_("unrecognized subcommand: %s"), argv[0]);
>       + }
>        
>       - diff --git a/midx.c b/midx.c
>       - --- a/midx.c
>       - +++ b/midx.c
>       -@@
>       - 			display_progress(progress, _n); \
>       - 	} while (0)
>       -
>       --int verify_midx_file(struct repository *r, const char *object_dir)
>       -+int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags)
>       - {
>       - 	struct pair_pos_vs_id *pairs = NULL;
>       - 	uint32_t i;
>       --	struct progress *progress;
>       -+	struct progress *progress = NULL;
>       - 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
>       - 	verify_midx_error = 0;
>       -
>       - 	if (!m)
>       - 		return 0;
>       -
>       --	progress = start_progress(_("Looking for referenced packfiles"),
>       --				  m->num_packs);
>       -+	if (flags & MIDX_PROGRESS)
>       -+		progress = start_progress(_("Looking for referenced packfiles"),
>       -+				 	 m->num_packs);
>       - 	for (i = 0; i < m->num_packs; i++) {
>       - 		if (prepare_midx_pack(r, m, i))
>       - 			midx_report("failed to load pack in position %d", i);
>       + diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
>       + --- a/t/t5319-multi-pack-index.sh
>       + +++ b/t/t5319-multi-pack-index.sh
>        @@
>       - 				    i, oid_fanout1, oid_fanout2, i + 1);
>       - 	}
>       -
>       --	progress = start_sparse_progress(_("Verifying OID order in MIDX"),
>       --					 m->num_objects - 1);
>       -+	if (flags & MIDX_PROGRESS)
>       -+		progress = start_sparse_progress(_("Verifying OID order in MIDX"),
>       -+						 m->num_objects - 1);
>       - 	for (i = 0; i < m->num_objects - 1; i++) {
>       - 		struct object_id oid1, oid2;
>         
>       -@@
>       - 		pairs[i].pack_int_id = nth_midxed_pack_int_id(m, i);
>       - 	}
>       -
>       --	progress = start_sparse_progress(_("Sorting objects by packfile"),
>       --					 m->num_objects);
>       -+	if (flags & MIDX_PROGRESS)
>       -+		progress = start_sparse_progress(_("Sorting objects by packfile"),
>       -+						 m->num_objects);
>       - 	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
>       - 	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
>       - 	stop_progress(&progress);
>       -
>       --	progress = start_sparse_progress(_("Verifying object offsets"), m->num_objects);
>       -+	if (flags & MIDX_PROGRESS)
>       -+		progress = start_sparse_progress(_("Verifying object offsets"), m->num_objects);
>       - 	for (i = 0; i < m->num_objects; i++) {
>       - 		struct object_id oid;
>       - 		struct pack_entry e;
>       -@@
>       - 	return 0;
>       - }
>       + compare_results_with_midx "two packs"
>         
>       --int midx_repack(struct repository *r, const char *object_dir, size_t batch_size)
>       -+int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags)
>       - {
>       - 	int result = 0;
>       - 	uint32_t i;
>       -@@
>       - 	strbuf_addstr(&base_name, object_dir);
>       - 	strbuf_addstr(&base_name, "/pack/pack");
>       - 	argv_array_push(&cmd.args, base_name.buf);
>       ++test_expect_success 'write progress off for redirected stderr' '
>       ++	git multi-pack-index --object-dir=$objdir write 2>err &&
>       ++	test_line_count = 0 err
>       ++'
>        +
>       -+	if (flags & MIDX_PROGRESS)
>       -+		argv_array_push(&cmd.args, "--progress");
>       -+	else
>       -+		argv_array_push(&cmd.args, "-q");
>       ++test_expect_success 'write force progress on for stderr' '
>       ++	git multi-pack-index --object-dir=$objdir --progress write 2>err &&
>       ++	test_file_not_empty err
>       ++'
>        +
>       - 	strbuf_release(&base_name);
>       -
>       - 	cmd.git_cmd = 1;
>       -
>       - diff --git a/midx.h b/midx.h
>       - --- a/midx.h
>       - +++ b/midx.h
>       -@@
>       - 	char object_dir[FLEX_ARRAY];
>       - };
>       -
>       -+#define MIDX_PROGRESS     (1 << 0)
>       ++test_expect_success 'write with the --no-progress option' '
>       ++	git multi-pack-index --object-dir=$objdir --no-progress write 2>err &&
>       ++	test_line_count = 0 err
>       ++'
>        +
>       - struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
>       - int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
>       - int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);
>       -@@
>       -
>       - int write_midx_file(const char *object_dir);
>       - void clear_midx_file(struct repository *r);
>       --int verify_midx_file(struct repository *r, const char *object_dir);
>       -+int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags);
>       - int expire_midx_packs(struct repository *r, const char *object_dir);
>       --int midx_repack(struct repository *r, const char *object_dir, size_t batch_size);
>       -+int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags);
>       -
>       - void close_midx(struct multi_pack_index *m);
>       -
>       -
>       - diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
>       - --- a/t/t5319-multi-pack-index.sh
>       - +++ b/t/t5319-multi-pack-index.sh
>       + test_expect_success 'add more packs' '
>       + 	for j in $(test_seq 11 20)
>       + 	do
>        @@
>         	git multi-pack-index verify --object-dir=$objdir
>         '
>       @@ -234,20 +156,51 @@
>         '
>         
>        +test_expect_success 'repack progress off for redirected stderr' '
>       -+	git multi-pack-index repack --object-dir=$objdir 2>err &&
>       ++	git multi-pack-index --object-dir=$objdir repack 2>err &&
>        +	test_line_count = 0 err
>        +'
>        +
>        +test_expect_success 'repack force progress on for stderr' '
>       -+	git multi-pack-index repack --object-dir=$objdir --progress 2>err &&
>       ++	git multi-pack-index --object-dir=$objdir --progress repack 2>err &&
>        +	test_file_not_empty err
>        +'
>        +
>        +test_expect_success 'repack with the --no-progress option' '
>       -+	git multi-pack-index repack --object-dir=$objdir --no-progress 2>err &&
>       ++	git multi-pack-index --object-dir=$objdir --no-progress repack 2>err &&
>        +	test_line_count = 0 err
>        +'
>        +
>         test_expect_success 'repack removes multi-pack-index' '
>         	test_path_is_file $objdir/pack/multi-pack-index &&
>         	GIT_TEST_MULTI_PACK_INDEX=0 git repack -adf &&
>       +@@
>       + 	)
>       + '
>       +
>       ++test_expect_success 'expire progress off for redirected stderr' '
>       ++	(
>       ++		cd dup &&
>       ++		git multi-pack-index expire 2>err &&
>       ++		test_line_count = 0 err
>       ++	)
>       ++'
>       ++
>       ++test_expect_success 'expire force progress on for stderr' '
>       ++	(
>       ++		cd dup &&
>       ++		git multi-pack-index --progress expire 2>err &&
>       ++		test_file_not_empty err
>       ++	)
>       ++'
>       ++
>       ++test_expect_success 'expire with the --no-progress option' '
>       ++	(
>       ++		cd dup &&
>       ++		git multi-pack-index --no-progress expire 2>err &&
>       ++		test_line_count = 0 err
>       ++	)
>       ++'
>       ++
>       + test_expect_success 'expire removes unreferenced packs' '
>       + 	(
>       + 		cd dup &&
>

