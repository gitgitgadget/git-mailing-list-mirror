Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708CA1DF72E
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401384; cv=none; b=KbG/LMHIEyzKWPCmsGXJK/j58kFSsnNnJ/NrW3KDStFd+WsbiEfWLj3Yhy7UCCNEomkqBi/RItU3IsjOn5DYyzV2l1Tms3bVkaoNPs4st1ibIwe7QJ/kvcdoCdPCr9itn9aWiqYJOP3hmcr1d6m09ZXhb3WUkLonE7bXSBne5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401384; c=relaxed/simple;
	bh=lrGVj+FMFYAEL7a2gFvADy56C2IZAsC1//KlgAGz+hI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ATiIi7OfRDorQmivEzyoSRjMe7TQBSP5BCuDerbDkGhMGC93cqjSjJWfC5itFsvdyOX+FtnOi08+xl+pVOas2iMevLBMqQ15MTvv2MV7oMxH9VbBdCq2LfCRY5AZcCCuLQQ9+I9b+3sSSwwWnRb5AqL6QV4FVxlDnzwr3HiyxMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImA2Y1ds; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImA2Y1ds"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-399749152b4so515762f8f.3
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742401380; x=1743006180; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR0wF1MtmZ3p6hfoHZsPkD+RStk7bJWYPEPxFzMgiww=;
        b=ImA2Y1dsePStereaPQFxD6WmxhedSLr2L8KvN9gOfmDgrPVxOEdVDRtUSMFTLC/Ns5
         2Dk+vgZsNyPy7JL22iNXx/LL/NOdtgamnFTaaSLYGY92+MdvuTXY2b/ukJ1pFtvIAgtT
         frvlBifRhmxdxDn7GEB++gwF5LH6MBsxmVQvDfXoqn5m1cgicB6oR3bxgPpxVo3sPX0P
         WxIEFM5NwvXfdZhfhisAJ7VMYOo5CNBRn9eCB3RRy5ONSyf9ObVpcZ9vjiWYVFfbQ+jr
         03fibwvRFq5dgDIXJvt7nKe9tFDLp77grI0Ac57e1/WQk4xYAPGjQ2efifyustMINynD
         BfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742401380; x=1743006180;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PR0wF1MtmZ3p6hfoHZsPkD+RStk7bJWYPEPxFzMgiww=;
        b=JoRNX9H+ov63RLB6KatqEhjXjQsIYGmnsEy978eKDUHdki/7cR800Y9NDhlAWR6Xfk
         jYqITexFXXOzEPfv23ybDzMH4xQ76OsNsD/jMqqDpzEdsNv5xKbBAt1e8uDhxUS+Mq0d
         72hCrSpqzWuFSOpL/rzf0Nmfoe4s8CrArXb9HOb6P/8/YZnp6yOI939uHBqa5GVMlH1t
         Le5uBM4Bk0SWktG+TNX7+87474coT9KxaUSwy0Ycnmf4mPRExRZfGQGeQT6QU01pm7oT
         rCCS3a8TU/dfC/e6rmJpaFT5fWad5+LMUPiEb9XJfcZW1UmdldunbfWwbGQCCz0/UPhA
         UY7Q==
X-Gm-Message-State: AOJu0Yw9xMhNwASmT0ecwUUYrwjHFWfTqDbwjrhWybnZAPtm/6Ej/ej4
	8KwEG2knRAwbRrScMxtS6H+lHPqeXzZhTFtHmztFnSbG/q8C5amR5cD/Ug==
X-Gm-Gg: ASbGncvHLDPXuFX+XGgzUVmeXLXBBHiEVMLyqL8nUU/AUpS3bAUMtsGfK5YIha7WUiC
	8JNUgKyIDqnptwmQhMQHEP+D/Y/9YAr1xpbVS+X2kM0SkWTG67hyJU/Z+rDVu37vrOQBmjM0Xx7
	JdWvWruCEcuVwQyDaD//GLXxJpeVrMSA4RI+1L27OqEdqNB/vLhMJGfxSXTynnSIgr0601qN1D/
	DSIqz1BIdRo+Ka1ug/zhXsw+1ML4IVZvZjtb/sZqfR/6A+Ucg7/VCkwJvsNP0jGTFWDvaGK6Tdj
	R4phvGa+erVxWXDaR+zKDOBSs/rvaslh44r19zU0vEiF8A==
X-Google-Smtp-Source: AGHT+IFfMfmb/0RP/j1zOfGNq6M3p9YijebDJ2hHk14XRgFADIp6m9594RrfiFu4TLBQa9jbtBb1pQ==
X-Received: by 2002:a05:6000:1acc:b0:397:5de8:6937 with SMTP id ffacd0b85a97d-39973b02974mr2776267f8f.41.1742401380040;
        Wed, 19 Mar 2025 09:23:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c888167bsm21325666f8f.45.2025.03.19.09.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:22:59 -0700 (PDT)
Message-Id: <pull.1881.v3.git.1742401378.gitgitgadget@gmail.com>
In-Reply-To: <pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
References: <pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Mar 2025 16:22:55 +0000
Subject: [PATCH v3 0/3] Add a static analysis job to prevent assertions with side effects
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Elijah Newren <newren@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Elijah Newren <newren@gmail.com>

We have several hundred assert() invocations in our code base. Some have
suggested that we should add a recommendation in our CodingGuidelines to
avoid their use, because there is a risk that someone might include
something with a side-effect in their assertion, which can lead to a very
difficult to debug problem. However, CodingGuidelines are going to be less
effective at preventing that foot-gun than a CI job which can warn of
assertions that possibly have side-effects. So, let's add a CI job instead.

While it is difficult to perfectly determine whether any expression has side
effects, a simple compiler/linker hack can prove that all but 9 of our
several hundred assert() calls are indeed free from them. While I believe
the remaining 9 are also free of side effects, it's easier to just convert
those 9 to a new macro (which will not be compiled out when NDEBUG is
defined), and instruct any future assertion writers to likewise switch to
that alternative macro if they have a slightly more involved assert()
invocation.

See
https://github.com/newren/git/actions/runs/13845548634/job/38743076293#step:4:1938
for an example of it running in CI and reporting possibly problematic
assertions (sample output also included in the commit message of the middle
commit in this series if you don't have access to view the link; I'm not
sure what the rules on that are).

Changes since v1:

 * Tweaked commit message for patch 2 Changes since v2:
 * Rename BUT_IF_NOT() -> ASSERT(). Didn't have a strong opinion on the set
   of alternatives Junio gave, so went with Taylor's small preference. If
   anyone has a strong preference here, I can pick a different alternative.
 * Fixed shell style issues (indentation, multi-line pipes, multiple lines
   with stderr redirects) in patch 2

Elijah Newren (3):
  git-compat-util: introduce ASSERT() macro
  ci: add build checking for side-effects in assert() calls
  treewide: replace assert() with ASSERT() in special cases

 Makefile                      |  4 ++++
 ci/check-unsafe-assertions.sh | 18 ++++++++++++++++++
 ci/run-static-analysis.sh     |  2 ++
 diffcore-rename.c             |  2 +-
 git-compat-util.h             |  8 ++++++++
 merge-ort.c                   |  4 ++--
 merge-recursive.c             |  2 +-
 object-file.c                 |  2 +-
 parallel-checkout.c           |  2 +-
 scalar.c                      |  4 ++--
 sequencer.c                   |  2 +-
 11 files changed, 41 insertions(+), 9 deletions(-)
 create mode 100755 ci/check-unsafe-assertions.sh


base-commit: 4b68faf6b93311254efad80e554780e372deb42f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1881%2Fnewren%2Fassertion-side-effects-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1881/newren/assertion-side-effects-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1881

Range-diff vs v2:

 1:  109060ccb86 ! 1:  d22ff3e3f97 git-compat-util: introduce BUG_IF_NOT() macro
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    git-compat-util: introduce BUG_IF_NOT() macro
     +    git-compat-util: introduce ASSERT() macro
      
     -    Create a BUG_IF_NOT() macro which is similar to assert(), but will not be
     +    Create a ASSERT() macro which is similar to assert(), but will not be
          compiled out when NDEBUG is defined, and is thus safe to use even if its
          argument has side-effects.
      
          We will use this new macro in a subsequent commit to convert a few
     -    existing assert() invocations to BUG_IF_NOT().  In particular, we'll
     +    existing assert() invocations to ASSERT().  In particular, we'll
          convert the handful of invocations which cannot be proven to be free of
          side effects with a simple compiler/linker hack.
      
     @@ git-compat-util.h: extern int bug_called_must_BUG;
       __attribute__((format (printf, 3, 4))) NORETURN
       void BUG_fl(const char *file, int line, const char *fmt, ...);
       #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
     -+#define BUG_IF_NOT(a) if (!(a)) BUG("Assertion `" #a "' failed.")
     ++/* ASSERT: like assert(), but won't be compiled out with NDEBUG */
     ++#define ASSERT(a) if (!(a)) BUG("Assertion `" #a "' failed.")
       __attribute__((format (printf, 3, 4)))
       void bug_fl(const char *file, int line, const char *fmt, ...);
       #define bug(...) bug_fl(__FILE__, __LINE__, __VA_ARGS__)
 2:  58cb8f6a160 ! 2:  223d8c0ca2a ci: add build checking for side-effects in assert() calls
     @@ Commit message
          to figure that since each assertion involves some kind of function call.
          Add a CI job which will find and report these possibly problematic
          assertions, and have the job suggest to the user that they replace these
     -    with BUG_IF_NOT() calls.
     +    with ASSERT() calls.
      
          Example output from running:
      
          ```
          ERROR: The compiler could not verify the following assert()
                 calls are free of side-effects.  Please replace with
     -           BUG_IF_NOT() calls.
     +           ASSERT() calls.
          /home/newren/floss/git/diffcore-rename.c:1409
                  assert(!dir_rename_count || strmap_empty(dir_rename_count));
          /home/newren/floss/git/merge-ort.c:1645
     @@ ci/check-unsafe-assertions.sh (new)
      +make CHECK_ASSERTION_SIDE_EFFECTS=1 >compiler_output 2>compiler_error
      +if test $? != 0
      +then
     -+    echo "ERROR: The compiler could not verify the following assert()" >&2
     -+    echo "       calls are free of side-effects.  Please replace with" >&2
     -+    echo "       BUG_IF_NOT() calls." >&2
     -+    grep undefined.reference.to..not_supposed_to_survive compiler_error \
     -+      | sed -e s/:[^:]*$// | sort | uniq | tr ':' ' ' \
     -+      | while read f l
     -+      do
     -+	printf "${f}:${l}\n  "
     -+	awk -v start="$l" 'NR >= start { print; if (/\);/) exit }' $f
     -+      done
     -+    exit 1
     ++	echo >&2 "ERROR: The compiler could not verify the following assert()"
     ++	echo >&2 "       calls are free of side-effects.  Please replace with"
     ++	echo >&2 "       ASSERT() calls."
     ++	grep undefined.reference.to..not_supposed_to_survive compiler_error |
     ++		sed -e s/:[^:]*$// | sort | uniq | tr ':' ' ' |
     ++		while read f l
     ++		do
     ++			printf "${f}:${l}\n  "
     ++			awk -v start="$l" 'NR >= start { print; if (/\);/) exit }' $f
     ++		done
     ++	exit 1
      +fi
      +rm compiler_output compiler_error
      
 3:  20c763f2951 ! 3:  82b7344e966 treewide: replace assert() with BUG_IF_NOT() in special cases
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    treewide: replace assert() with BUG_IF_NOT() in special cases
     +    treewide: replace assert() with ASSERT() in special cases
      
          When the compiler/linker cannot verify that an assert() invocation is
          free of side effects for us (e.g. because the assertion includes some
     -    kind of function call), replace the use of assert() with BUG_IF_NOT().
     +    kind of function call), replace the use of assert() with ASSERT().
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ diffcore-rename.c: void diffcore_rename_extended(struct diff_options *options,
       	trace2_region_enter("diff", "setup", options->repo);
       	info.setup = 0;
      -	assert(!dir_rename_count || strmap_empty(dir_rename_count));
     -+	BUG_IF_NOT(!dir_rename_count || strmap_empty(dir_rename_count));
     ++	ASSERT(!dir_rename_count || strmap_empty(dir_rename_count));
       	want_copies = (detect_rename == DIFF_DETECT_COPY);
       	if (dirs_removed && (break_idx || want_copies))
       		BUG("dirs_removed incompatible with break/copy detection");
     @@ merge-ort.c: static void path_msg(struct merge_options *opt,
       
       	/* Sanity checks */
      -	assert(omittable_hint ==
     -+	BUG_IF_NOT(omittable_hint ==
     ++	ASSERT(omittable_hint ==
       	       (!starts_with(type_short_descriptions[type], "CONFLICT") &&
       		!starts_with(type_short_descriptions[type], "ERROR")) ||
       	       type == CONFLICT_DIR_RENAME_SUGGESTED);
     @@ merge-ort.c: static int handle_deferred_entries(struct merge_options *opt,
       			VERIFY_CI(ci);
       
      -			assert(renames->deferred[side].trivial_merges_okay &&
     -+			BUG_IF_NOT(renames->deferred[side].trivial_merges_okay &&
     ++			ASSERT(renames->deferred[side].trivial_merges_okay &&
       			       !strset_contains(&renames->deferred[side].target_dirs,
       						path));
       			resolve_trivial_directory_merge(ci, side);
     @@ merge-recursive.c: static void print_commit(struct repository *repo, struct comm
       	ctx.date_mode.type = DATE_NORMAL;
       	/* FIXME: Merge this with output_commit_title() */
      -	assert(!merge_remote_util(commit));
     -+	BUG_IF_NOT(!merge_remote_util(commit));
     ++	ASSERT(!merge_remote_util(commit));
       	repo_format_commit_message(repo, commit, " %h: %m %s", &sb, &ctx);
       	fprintf(stderr, "%s\n", sb.buf);
       	strbuf_release(&sb);
     @@ object-file.c: static int index_stream_convert_blob(struct index_state *istate,
       
       	assert(path);
      -	assert(would_convert_to_git_filter_fd(istate, path));
     -+	BUG_IF_NOT(would_convert_to_git_filter_fd(istate, path));
     ++	ASSERT(would_convert_to_git_filter_fd(istate, path));
       
       	convert_to_git_filter_fd(istate, path, fd, &sbuf,
       				 get_conv_flags(flags));
     @@ parallel-checkout.c: static int write_pc_item_to_fd(struct parallel_checkout_ite
       
       	/* Sanity check */
      -	assert(is_eligible_for_parallel_checkout(pc_item->ce, &pc_item->ca));
     -+	BUG_IF_NOT(is_eligible_for_parallel_checkout(pc_item->ce, &pc_item->ca));
     ++	ASSERT(is_eligible_for_parallel_checkout(pc_item->ce, &pc_item->ca));
       
       	filter = get_stream_filter_ca(&pc_item->ca, &pc_item->ce->oid);
       	if (filter) {
     @@ scalar.c: static int add_or_remove_enlistment(int add)
       static int start_fsmonitor_daemon(void)
       {
      -	assert(have_fsmonitor_support());
     -+	BUG_IF_NOT(have_fsmonitor_support());
     ++	ASSERT(have_fsmonitor_support());
       
       	if (fsmonitor_ipc__get_state() != IPC_STATE__LISTENING)
       		return run_git("fsmonitor--daemon", "start", NULL);
     @@ scalar.c: static int start_fsmonitor_daemon(void)
       static int stop_fsmonitor_daemon(void)
       {
      -	assert(have_fsmonitor_support());
     -+	BUG_IF_NOT(have_fsmonitor_support());
     ++	ASSERT(have_fsmonitor_support());
       
       	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
       		return run_git("fsmonitor--daemon", "stop", NULL);
     @@ sequencer.c: static int pick_commits(struct repository *r,
       	ctx->reflog_message = sequencer_reflog_action(opts);
       	if (opts->allow_ff)
      -		assert(!(opts->signoff || opts->no_commit ||
     -+		BUG_IF_NOT(!(opts->signoff || opts->no_commit ||
     ++		ASSERT(!(opts->signoff || opts->no_commit ||
       			 opts->record_origin || should_edit(opts) ||
       			 opts->committer_date_is_author_date ||
       			 opts->ignore_date));

-- 
gitgitgadget
