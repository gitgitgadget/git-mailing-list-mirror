Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C1D44DB73
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837862; cv=none; b=PSyQ0vyY2hbDjmw5mt0W1Qd+07ZVkm9wa0SlZQQ9dQ0kKcjT65zflkk2UqHf2mePGKaZf/j/n9cgNmdtCpmBGRT/yyRVyXCam9LxRQjtmpOMgGuTuwnEzxHsR2eQH+TuWN0ltI9KOBg2Ai7lhjsmm06UzencCeaHw3ZE5H/Dod8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837862; c=relaxed/simple;
	bh=ZNOLMYJIvW2U1s4kk9RWNR/F9D+r+hNyqT0JCTmqoZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aro8N/FaFRtFPYTLRTsQT531kP4oSNU07Z2GxphpnHwxpBTzJBwHadFkDFqNhKhTyVodjaeJW7i9o+S2nwcV6kN7Zq952HsrxaMoX7clFq998ZhP7vF3MUttIw4t8mSHRkRWMKAfbritYJg4WxPo3GHpWrLBqYMuLUJoC1UXNo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRiWKojL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRiWKojL"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4956869750eso19612655e9.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 03:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785837858; x=1786442658; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+seQGycH5Y0WiZNT0rrJLjneb6ij2kHGfB9b8ASFEkY=;
        b=ZRiWKojLMADOb6/pF1Sk/NDf36D1H8i5xwAnGFUI1yrKWGXdR3POwNqn3fFnBK0DGh
         13ku2bF+Zzr8MCPf5zpR4Is+PQpLore1tkaHTfq4dz7hkMKE5jQVLhtVbSTnbfjMbKlp
         RKNGf39eqzekPTTiFAxA+SkYnfrCCArQpVFmeVsocIbNyAT/jMNdjUNKjNeLlO7jtJ4+
         zrwgP9Em75DDpI3OQyoomGU8M+MW+IuG39sEMQ6cevBG8m4rjyXCibj4kNloeF1UPkGt
         WBm533u4fVeDlczeD6atWPOcALu1GRiDurYwtY/MrpIpXRBibV7K61N9sZrGOPZXSFBN
         g0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785837858; x=1786442658;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+seQGycH5Y0WiZNT0rrJLjneb6ij2kHGfB9b8ASFEkY=;
        b=jo4NqwKSKpoC6L/jz+dYwJgYCP6cuTMxiJlngLs/ihkZiZlsjk0KdZlH7QyWUoP7FP
         rk0hJAlGOuziPihkusZiOYPb0Exb9RgIYVX+oO63irTKLoNUwyDj3FsOOeNvg02d4pC9
         B9eQP5WqyiEUUjQGgS0YNRx6bsZZ0x/bf2qcEFSVIWgTFIa2tHoONQnHQH33EVCTDXsW
         q0VFaOPtLXCbIWxijSl9OuKe1M2yJrz1W/gXpoh7hwiJ5ZDnqE6NaYpE5yPX7xYwodJL
         EiOFOMPy3uTIfEZZlJgYNFxT/mJ3VQFdN4GkcxgVuckq4rpFzP5ajql9GJWH11uMIeh+
         ajqA==
X-Gm-Message-State: AOJu0Yyy4Bjcmyjv6ngoBuiXSJ90/O9OT0Fdhx26LpH2+r3YRuiTVAnZ
	clmcT8lU5k+tUt3Lr52Ary0GwS3hLS1PIS9GIDn8katvQWSKEirKIOHdOFOjEw==
X-Gm-Gg: AR+sD11cxjK0QGUXlZr17yFkIW6bFXnyCv0dUMrER59IOp9q6Hbd7qmksJa7/NZu4SZ
	BPqdwgBdEUkU8uHBz5QUxWanPZ+YqFcvr7Gy+vrdLBX22MoBZS/chHZkjMsWrT5B/0DDWcod2XL
	1JumqLX28X+xr8E2RI6HiqrEob2UQ9XmxBYQtxxbshG88QTnRv4CaXoN5sUw+hnlFVGxTnSIdva
	yWNn4KXgYScYZQMNPKWjfuTNAjZjT9mn48GYZWIPUYbssRTz4NJhFn8XLGa//h0ScSADk+HK2yA
	kRrqbMEzaI5cyWDovT7kEEFBkE0ZQovKjWIOVQ8XvvcqP3FanEagTw2rOWM1tl0TD7Vm4yKYYte
	gH4YXc2T8PPxlQpb3qQKO6jbAtUehDX2CmpMwVFdL+tWuP3KaDg1MBI59W9ASnZNjXJXYOo3Rq5
	MEv5HyIou192+MtYuXI49HwyQpDVoH8ad4GYKAJu62wNKbpunkzoTcwQm0sktLNa8Uo4fgIJGBG
	SHCMgs7hgcmqDVWY8UtRMSWY8pMwXQZSARykRdqRyPfq+MOhPsqvpz+N1YlYXDRU8IVwxJtoLtu
X-Received: by 2002:a05:600c:548d:b0:495:6134:6d61 with SMTP id 5b1f17b1804b1-4980c674de0mr348161915e9.19.1785837858155;
        Tue, 04 Aug 2026 03:04:18 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fec7cdsm72456045e9.13.2026.08.04.03.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:04:17 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 00/12] fast-import: standardize usage string and SYNOPSIS
Date: Tue,  4 Aug 2026 12:03:43 +0200
Message-ID: <20260804100355.1299498-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.492.g44bba30fd7.dirty
In-Reply-To: <20260716165517.433849-1-christian.couder@gmail.com>
References: <20260716165517.433849-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The goal of this series is to improve on `git fast-import`'s usage
string as it is obsolete in many ways.

As it appeared that a good way to reach that goal was to make
`git fast-import` use the parse-options API, this series also achieves
this secondary goal.

Along the way it modernizes "builtin/fast-import.c" mostly by using
`struct option`, by starting to remove global variables and libify
that command, and by introducing a new `OPT_HIDDEN_GROUP` macro.

There are still many global variables left, so it's left to future
work to finish on that direction.

Anyway the usage string is standardized and consistent with the
SYNOPSIS in the docs, so that the command can be removed from
"t/t0450/adoc-help-mismatches".

Using the parse-options API also enabled some code standardization and
simplification.

Overview of the patches
=======================

  - Patch 1/12: Introduces OPT_HIDDEN_GROUP and improves on the hidden
    option tests.

  - Patches 2/12 and 3/12: Improve on the parse-options API docs.

  - Patch 4/12: Cleans up an 'i' loop counter variable in
    cmd_fast_import().

  - Patches 5/12 and 6/12: Prepare for using the parse-option API to
    parse command line options.

  - Patches 7/12 and 8/12: Start libifying "builtin/fast-import.c" by
    introducing a 'struct fast_import_state' and using it to store
    some global variables.

  - Patch 9/12: Improves the usage string and SYNOPSIS by introducing
    `struct option`.

  - Patch 10/12: Further prepares for using the parse-option API to
    actually parse command line options by using OPT_CALLBACK.

  - Patch 11/12: Actually parses the command line options using the
    parse-option API.

  - Patch 12/12: Performs a cleanup of some functions arguments allowed
    by the previous commit.

Changes since v1
================

Thanks to Junio for reviewing the v1.

The series has been rebased on top of recent master at 5b2471720c (The
10th batch, 2026-08-03) to avoid conflicts with recent changes
especially cdaf12f762 (parse-options: exit 0 on -h, 2026-07-08).

The `Signed-off-by:` trailers now use my `christian.couder@gmail.com`
address, which is also the address I send patches from, so that they
match. A separate patch updating the `.mailmap` entry to make that
address my primary one has been sent separately.

  - Patch 1/12 has been changed by removing `test_must_fail` in front
    of `test-tool parse-options` when the latter uses `-h` or
    `--help-all` to adapt this series to the recent changes in master.

  - Patches 5/12 and 6/12 are new and prepare for using the parse-option
    API to parse command line options.

  - Patch 9/12 (previously 7/7) has been changed a lot so that it
    reuses existing variables as much as possible instead of
    introducing a lot of new local variables.

  - Patches 10/12, 11/12 and 12/12 are new and complete the option
    parsing using the parse-option API.

Note that patch 11/12 changes the behavior of a few undocumented
command line options: `--alias`, `--get-mark`, `--cat-blob`, `--ls`
and `--notes` are not accepted on the command line anymore. See its
commit message for details.

CI tests
========

They all pass, except one (Win+Meson test (0) where tests don't want
to start, so likely unrelated), see:

https://github.com/chriscool/git/actions/runs/30894348053


Christian Couder (12):
  parse-options: introduce OPT_HIDDEN_GROUP
  api-parse-options.adoc: document per-option flags
  api-parse-options.adoc: document hidden and OPT_*_F option macros
  fast-import: localize 'i' into the 'for' loops using it
  fast-import: use int for some bool flags
  fast-import: factor out option_*() functions
  fast-import: introduce 'struct fast_import_state'
  fast-import: move command state globals into 'struct
    fast_import_state'
  fast-import: use struct option for usage string
  fast-import: use callbacks to parse some options
  fast-import: use parse_options() for command line options
  fast-import: remove useless from_stream argument

 Documentation/git-fast-import.adoc            |   2 +-
 .../technical/api-parse-options.adoc          |  79 +++
 builtin/fast-import.c                         | 577 ++++++++++++------
 parse-options.c                               |   4 +-
 parse-options.h                               |   5 +
 t/helper/test-parse-options.c                 |   4 +
 t/t0040-parse-options.sh                      |  25 +-
 t/t0450/adoc-help-mismatches                  |   1 -
 t/t9300-fast-import.sh                        |   7 +
 9 files changed, 517 insertions(+), 187 deletions(-)

Range-diff against v1:
 1:  ba4821276c !  1:  b09d727e71 parse-options: introduce OPT_HIDDEN_GROUP
    @@ Commit message
         To test this new macro, let's also improve `test-tool parse-options`
         and test its output with `--help-all`.
     
    -    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## parse-options.c ##
     @@ parse-options.c: static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
    @@ t/t0040-parse-options.sh: Alias
     +
      test_expect_success 'test help' '
     +	cat expect-part1 expect-part2 >expect &&
    - 	test_must_fail test-tool parse-options -h >output 2>output.err &&
    + 	test-tool parse-options -h >output 2>output.err &&
      	test_must_be_empty output.err &&
      	test_cmp expect output
      '
      
     +test_expect_success 'test --help-all shows hidden group and options' '
     +	cat expect-part1 expect-noop expect-part2 expect-hidden >expect-help-all &&
    -+	test_must_fail test-tool parse-options --help-all >output 2>output.err &&
    ++	test-tool parse-options --help-all >output 2>output.err &&
     +	test_must_be_empty output.err &&
     +	test_cmp expect-help-all output
     +'
 2:  2690812694 !  2:  fe21471420 api-parse-options.adoc: document per-option flags
    @@ Commit message
         parse_options() flags described earlier, and let's describe the `-h`
         versus `--help-all` behavior for `PARSE_OPT_HIDDEN`.
     
    -    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## Documentation/technical/api-parse-options.adoc ##
     @@ Documentation/technical/api-parse-options.adoc: Data Structure
 3:  cf4b276019 !  3:  f43d4cefa4 api-parse-options.adoc: document hidden and OPT_*_F option macros
    @@ Commit message
     
           - Document `OPT_HIDDEN_BOOL()` right after `OPT_BOOL()`.
     
    -    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## Documentation/technical/api-parse-options.adoc ##
     @@ Documentation/technical/api-parse-options.adoc: Macros
 4:  9b051efd9f !  4:  3eb8106ed6 fast-import: localize 'i' into the 'for' loops using it
    @@ Commit message
         To give each loop counter the type matching its bound
         (int/unsigned/size_t), let's localize 'i' into each loop that uses it.
     
    -    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## builtin/fast-import.c ##
     @@ builtin/fast-import.c: int cmd_fast_import(int argc,
 -:  ---------- >  5:  34514eb2ac fast-import: use int for some bool flags
 -:  ---------- >  6:  336395c70a fast-import: factor out option_*() functions
 5:  2ca7ccafc6 !  7:  45cc2107e2 fast-import: introduce 'struct fast_import_state'
    @@ Commit message
         This is a mostly mechanical refactoring with no intended behavior
         change.
     
    -    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## builtin/fast-import.c ##
     @@ builtin/fast-import.c: static int failure;
      static FILE *pack_edges;
    - static unsigned int show_stats = 1;
    - static unsigned int quiet;
    + static int show_stats = 1;
    + static int quiet;
     -static int global_argc;
     -static const char **global_argv;
     -static const char *global_prefix;
    @@ builtin/fast-import.c: static void option_rewrite_submodules(const char *arg, st
      	fp = fopen(f, "r");
      	if (!fp)
      		die_errno(_("cannot read '%s'"), f);
    -@@ builtin/fast-import.c: static void option_rewrite_submodules(const char *arg, struct string_list *list)
    - 	free(s);
    +@@ builtin/fast-import.c: static void option_quiet(void)
    + 	quiet = 1;
      }
      
     -static int parse_one_option(const char *option)
     +static int parse_one_option(struct fast_import_state *state, const char *option)
      {
      	if (skip_prefix(option, "max-pack-size=", &option)) {
    - 		unsigned long v;
    + 		option_max_pack_size(option);
     @@ builtin/fast-import.c: static int parse_one_option(const char *option)
      	} else if (skip_prefix(option, "active-branches=", &option)) {
      		option_active_branches(option);
    @@ builtin/fast-import.c: static int parse_one_option(const char *option)
     -		option_export_pack_edges(option);
     +		option_export_pack_edges(state, option);
      	} else if (skip_prefix(option, "signed-commits=", &option)) {
    - 		if (parse_sign_mode(option, &signed_commit_mode, &signed_commit_keyid))
    - 			usagef(_("unknown --signed-commits mode '%s'"), option);
    + 		option_signed_commits(option);
    + 	} else if (skip_prefix(option, "signed-tags=", &option)) {
     @@ builtin/fast-import.c: static int parse_one_option(const char *option)
      	return 1;
      }
 6:  bf25bb3253 !  8:  7f068facc2 fast-import: move command state globals into 'struct fast_import_state'
    @@ Commit message
     
         This is a mechanical refactoring with no intended behavior change.
     
    -    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## builtin/fast-import.c ##
     @@ builtin/fast-import.c: static struct recent_command *rc_free;
 7:  9120d2b5c0 !  9:  3d6ab86518 fast-import: use struct option for usage string
    @@ Commit message
         This deliberately leaves it to future work to also use the
         parse-options API to actually parse the options.
     
    -    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
      ## Documentation/git-fast-import.adoc ##
     @@ Documentation/git-fast-import.adoc: git-fast-import - Backend for fast Git data importers
    @@ builtin/fast-import.c: int cmd_fast_import(int argc,
      	struct fast_import_state state;
      
     -	show_usage_if_asked(argc, argv, fast_import_usage);
    -+	unsigned long pack_size_limit, big_file_threshold, depth, active_branches;
    -+	char *edges, *signed_commits, *signed_tags, *date_format, *import_marks;
    -+	char *import_marks_if_exists, *export_marks, *submodules_from, *submodules_to;
    -+	int opt_quiet, opt_show_stats, opt_relative_marks, opt_force, opt_done;
    -+	int opt_allow_unsafe;
    -+	int cat_blob;
    ++	unsigned long pack_size_limit, big_file_threshold;
    ++	char *edges, *signed_commits, *signed_tags, *date_format;
    ++	char *import_marks_if_exists, *submodules_from, *submodules_to;
      
     -	fast_import_state_init(&state, argc, argv, prefix);
     +	/*
    @@ builtin/fast-import.c: int cmd_fast_import(int argc,
     +		OPT_GROUP(N_("Common")),
     +		OPT_STRING_F(0, "date-format", &date_format, N_("fmt"),
     +			   N_("format of the commit/tag dates"), PARSE_OPT_NONEG),
    -+		OPT_BOOL_F(0, "stats", &opt_show_stats,
    ++		OPT_BOOL_F(0, "stats", &show_stats,
     +			   N_("display some basic statistics (objects, packfiles and memory)"),
     +			   PARSE_OPT_NONEG),
    -+		OPT_BOOL_F(0, "quiet", &opt_quiet,
    ++		OPT_BOOL_F(0, "quiet", &quiet,
     +			   N_("disable the output shown by --stats"), PARSE_OPT_NONEG),
    -+		OPT_BOOL_F(0, "force", &opt_force,
    ++		OPT_BOOL_F(0, "force", &force_update,
     +			   N_("force updating modified existing branches"), PARSE_OPT_NONEG),
    -+		OPT_BOOL_F(0, "done", &opt_done,
    ++		OPT_BOOL_F(0, "done", &require_explicit_termination,
     +			   N_("require a terminating 'done' command"), PARSE_OPT_NONEG),
     +		OPT_UNSIGNED(0, "max-pack-size", &pack_size_limit,
     +			     N_("maximum size of each output pack file")),
     +		OPT_UNSIGNED(0, "big-file-threshold", &big_file_threshold,
     +			     N_("maximum size of a blob that will be deltified")),
    -+		OPT_UNSIGNED(0, "depth", &depth,
    ++		OPT_UNSIGNED(0, "depth", &max_depth,
     +			     N_("maximum delta depth")),
    -+		OPT_UNSIGNED(0, "active-branches", &active_branches,
    ++		OPT_UNSIGNED(0, "active-branches", &max_active_branches,
     +			     N_("maximum number of branches to maintain active")),
     +		OPT_GROUP(N_("Marks")),
    -+		OPT_STRING_F(0, "import-marks", &import_marks, N_("file"),
    ++		OPT_STRING_F(0, "import-marks", &import_marks_file, N_("file"),
     +			     N_("import marks from <file>"), PARSE_OPT_NONEG),
     +		OPT_STRING_F(0, "import-marks-if-exists", &import_marks_if_exists, N_("file"),
     +			     N_("import marks from <file> if it exists"), PARSE_OPT_NONEG),
    -+		OPT_STRING_F(0, "export-marks", &export_marks, N_("file"),
    ++		OPT_STRING_F(0, "export-marks", &export_marks_file, N_("file"),
     +			     N_("dump marks to <file>"), PARSE_OPT_NONEG),
    -+		OPT_BOOL(0, "relative-marks", &opt_relative_marks,
    ++		OPT_BOOL(0, "relative-marks", &relative_marks_paths,
     +			 N_("are --(import|export)-marks= paths relative to '.git/info/fast-import'?")),
     +		OPT_GROUP(N_("Submodule rewrite")),
     +		OPT_STRING_F(0, "rewrite-submodules-from", &submodules_from, N_("name:filename"),
    @@ builtin/fast-import.c: int cmd_fast_import(int argc,
     +			     N_("how to handle signed tags"),
     +			     PARSE_OPT_NONEG),
     +		OPT_HIDDEN_GROUP(N_("Advanced")),
    -+		OPT_BOOL_F(0, "allow-unsafe-features", &opt_allow_unsafe,
    ++		OPT_BOOL_F(0, "allow-unsafe-features", &state.allow_unsafe_features,
     +			   N_("allow unsafe mark commands from the stream"),
     +			   PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
     +		OPT_STRING_F(0, "export-pack-edges", &edges, N_("file"),
     +			     N_("dump edge commits to <file>"),
     +			     PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
    -+		OPT_INTEGER_F(0, "cat-blob-fd", &cat_blob,
    ++		OPT_INTEGER_F(0, "cat-blob-fd", &cat_blob_fd,
     +			    N_("write some responses to <fd> instead of stdout"),
     +			      PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
     +		OPT_END()
    @@ builtin/fast-import.c: int cmd_fast_import(int argc,
      	git_pack_config();
     
      ## t/t0450/adoc-help-mismatches ##
    -@@ t/t0450/adoc-help-mismatches: credential
    +@@ t/t0450/adoc-help-mismatches: column
    + credential
      credential-cache
      credential-store
    - fast-export
     -fast-import
      fetch-pack
      fmt-merge-msg
 -:  ---------- > 10:  3208937f13 fast-import: use callbacks to parse some options
 -:  ---------- > 11:  202a50beec fast-import: use parse_options() for command line options
 -:  ---------- > 12:  99ff791a62 fast-import: remove useless from_stream argument
-- 
2.55.0.492.g44bba30fd7.dirty

