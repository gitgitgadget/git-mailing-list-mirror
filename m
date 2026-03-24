Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F52C11D9
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 22:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389850; cv=none; b=bcLfiDhFZC5iapV/tuy4HCl+FHxmwm6bseDsqw4cz7gvjhVnNJ8ZXxZr1ePfNf+Fbe0PWHpQdyaIb1FmCELdm6GTFCV7974yuASqjkQFBficGpZSrlGpilMv21Ml95NFxQN1QN3ya4ixtB1ek9mhEa0smEhzD9XhTCriZuUqktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389850; c=relaxed/simple;
	bh=j0nQncNAyq9JRtaR8AXdn3LRTeWBwhBqlkTidNQWffk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rf5CIIFeFppSZFkPDs6K36eMK6JLmprxnxmNLpSciZxrGArY8HQnExRnv0xprN1u0zBlUNeCKx/jN0nTboa18/K3GTmcoWgXbcPGGOdSa+9A8r2f4V0oejRSa0JBcbYIoh/wFJYUKSZLWh8gxwlTzj/p+P/FAHKcxEQNumZlCbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3dVn+5I; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3dVn+5I"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35a07c4b17dso2168925a91.2
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 15:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774389848; x=1774994648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvDg1nLrTAAKmCvq8A6j/75mn03AuMdBKiABXFVsd3o=;
        b=f3dVn+5IDJxGfxc/xS86OADSwldyMgHMYAOIl6OxZ1P9paSWnIt6xLjegc7qK6Oh5g
         MIoulDoeOSq/1WOb7ETUkp3AA0xU6YndLDzX1fWJzqi/4nk46h1nAy1uj+AEdzByDCfh
         Us55DOZY8TSb0mWW0wA8IpFSF2oceKiL1ZCnTzJF+yPi6NVqO2+KJMqm8QiHh80eT6vY
         YRzfMZSYyIkFvAWCqmo7QE7G4E+c1HAKRHgPExBYMTH7X0xghtvoDtyNeTkM8HaVQXlJ
         h9UyGBBwsx846qZWtiLxBOg/ZCP+bdO6559guCkJQW5Ghr3Xtv87m0zQP/z6CAWOqjbQ
         VHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774389848; x=1774994648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uvDg1nLrTAAKmCvq8A6j/75mn03AuMdBKiABXFVsd3o=;
        b=BbAB1rKgfyY8NCq2w7AUAqIOvhS2i7WUdkxVcWi+R3mBWSLbNrkC+hY1HpFYmmtdzM
         4E70lwCAUBvJxc0eTL1WIsO0bLiysXEFwkftoH+mMtL1rfkE3O/3qJdnjNLJdO7e6fFC
         Fztwheq/b7ZnWeWIIG6S4Y+0y430/ONi5CC5E1Mv6uARnmv1nPxTdW51yb4J/TFkUrF4
         1oFI8hDG+JdX7zxURRYFsxZ3rLBkAgt5DAEaLF/QGpV07LnfdZfE8MDmTWWO1uMArO2/
         VNAz+g6aqn12LABoZRTPB7keDZAdJstBHh7SjPxLOpZR6lngrxXPw36Kob7J9ncbtYpg
         IoSA==
X-Gm-Message-State: AOJu0YwYYtAsrGXU7FVkIJQpEQkbGithDyU4i87pG07e2EANVVpnFZzi
	MS0a9FG1Gdv1NQVtaEo2JPMf157pkowd+sDzi3bDn9hDahMFYFRXpcDdaPjASg==
X-Gm-Gg: ATEYQzzRm417c9cTDvHy0fpKxDydgYKEV3iFi6xbAikMn7uONG7Mj7HK/okLv0WhrnW
	J3mbkuBH5D+3m6mzX9GEVmqdnVtCviWEEc0+qRKKpm/2PNlJ4W9kQzyZl2sAOXbupctTnfo8KVq
	V1AsHjRXTbrKqms2C/NMjf4170Sz+3rOfsjIWTSNwaNYs+gDJhkkLDS0DF+J+TnJdEdTF6THnjA
	b17+Q4rpF91GJNXjgwhb2AkdWLZyvjuDkNuzk0OfeZWhW5PtTebpHWTd0CjCsURlobaPwUwslE5
	NsWe1x2u0av7yT8/JsFT6lDKdG4eKD8AjTSWyJxgjHyXb9F1WdwZ2UdTsIrcO0bCn2SLcb2eqDB
	MqxATuL5KfTm7yCK/KIIOCBlhjDr1Qlei+dLsQuhvZ7LQ++XoLa7b+qgqO40XaUUldbZEX028UC
	PbsQzskL3H+8hfNTHVwgPHaVpMIuDmVABODjvMAHRghNUh7TPOa9TWltcyiQ==
X-Received: by 2002:a17:90b:274a:b0:35b:91e1:e110 with SMTP id 98e67ed59e1d1-35c0ddb21e3mr768828a91.20.1774389847374;
        Tue, 24 Mar 2026 15:04:07 -0700 (PDT)
Received: from localhost ([2409:40e3:30ab:6862:7ceb:99d5:377f:7f66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c031494f3sm5168676a91.8.2026.03.24.15.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:04:06 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	newren@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	karthik.188@gmail.com,
	johannes.schindelin@gmx.de,
	toon@iotcl.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v5 0/2] replay: add --revert mode to reverse commit changes
Date: Wed, 25 Mar 2026 03:33:59 +0530
Message-ID: <20260324220401.47040-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313054035.26605-1-siddharthasthana31@gmail.com>
References: <20260313054035.26605-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

git replay currently supports cherry-picking (--advance) and rebasing
(--onto), but not reverting. We need this at GitLab for Gitaly to
reverse commits directly on bare repositories without a checkout.

The approach is the same as sequencer.c -- cherry-pick and revert are
just the same three-way merge with swapped arguments. We swap the base
and pickme trees passed to merge_incore_nonrecursive() to reverse the
diff direction.

Patch 1 extracts the full revert message formatting logic into a new
sequencer_format_revert_message() function that handles everything in
one shared function rather than just the header. refer_to_commit() is
updated to take a struct repository and a bool instead of replay_opts
so it works outside the sequencer.

Patch 2 adds --revert <branch> as a standalone mode. Reverts are
processed newest-first (matching git revert) to reduce conflicts by
peeling off changes from the top.

The series is based on top of d181b9354c (The 13th batch, 2026-03-07).

Changes in v5:
- Made sequencer_format_revert_message() header comment more concise,
  using single quotes to avoid nested escaped double quotes
- Moved desired_reverse declaration up and removed the bare braces, so
  the same named variable is used when setting and checking
  revs.reverse
- Used die_for_incompatible_opt2() for --advance/--contained and
  --revert/--contained instead of die("--contained requires --onto")
- Dropped the erroneously re-added ellipsis from <revision-range>...
  in the SYNOPSIS
- Restored #define the_repository DO_NOT_USE_THE_REPOSITORY guard in
  replay.c
- Used ${SQ} instead of '"'"' for single-quote escaping in tests
- Link to v4: https://lore.kernel.org/git/20260313054035.26605-1-siddharthasthana31@gmail.com/
- Link to v3: https://public-inbox.org/git/20260218234215.89326-1-siddharthasthana31@gmail.com/
- Link to v2: https://public-inbox.org/git/20251202201611.22137-1-siddharthasthana31@gmail.com/
- Link to v1: https://public-inbox.org/git/20251125170056.34489-1-siddharthasthana31@gmail.com/

Thanks,
Siddharth

---
Siddharth Asthana (2):
  sequencer: extract revert message formatting into shared function
  replay: add --revert mode to reverse commit changes

 Documentation/git-replay.adoc |  43 ++++++++-
 builtin/replay.c              |  35 ++++++--
 replay.c                      | 161 +++++++++++++++++++++++++---------
 replay.h                      |  11 ++-
 sequencer.c                   |  78 +++++++++-------
 sequencer.h                   |  13 +++
 t/t3650-replay-basics.sh      | 111 +++++++++++++++++++++--
 7 files changed, 355 insertions(+), 97 deletions(-)

Range-diff versus v4:

1:  bdc710b265 ! 1:  6bd2ce4515 sequencer: extract revert message formatting into shared function
    @@ sequencer.h: int sequencer_determine_whence(struct repository *r, enum commit_wh
      int sequencer_get_update_refs_state(const char *wt_dir, struct string_list *refs);
      
     +/*
    -+ * Formats a complete revert commit message following standard Git conventions.
    -+ * Handles regular reverts ("Revert \"<subject>\""), revert of revert cases
    -+ * ("Reapply \"<subject>\""), and the --reference style. Appends "This reverts
    -+ * commit <ref>." using either the abbreviated or full commit reference
    -+ * depending on use_commit_reference. Also handles merge-parent references.
    ++ * Format a revert commit message with appropriate 'Revert "<subject>"' or
    ++ * 'Reapply "<subject>"' prefix and 'This reverts commit <ref>.' body.
    ++ * When use_commit_reference is set, <ref> is an abbreviated hash with
    ++ * subject and date; otherwise the full hex hash is used.
     + */
     +void sequencer_format_revert_message(struct repository *r,
     +				     const char *subject,
2:  bea6229575 ! 2:  9fd92497b9 replay: add --revert mode to reverse commit changes
    @@ Documentation/git-replay.adoc: git-replay - EXPERIMENTAL: Replay commits on a ne
      --------
      [verse]
     -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--ref-action[=<mode>]] <revision-range>
    -+(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) [--ref-action[=<mode>]] <revision-range>...
    ++(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) [--ref-action[=<mode>]] <revision-range>
      
      DESCRIPTION
      -----------
    @@ builtin/replay.c: int cmd_replay(int argc,
      	const char *const replay_usage[] = {
      		N_("(EXPERIMENTAL!) git replay "
     -		   "([--contained] --onto <newbase> | --advance <branch>) "
    --		   "[--ref-action[=<mode>]] <revision-range>"),
     +		   "([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) "
    -+		   "[--ref-action[=<mode>]] <revision-range>..."),
    + 		   "[--ref-action[=<mode>]] <revision-range>"),
      		NULL
      	};
    - 	struct option replay_options[] = {
     @@ builtin/replay.c: int cmd_replay(int argc,
      			   N_("replay onto given commit")),
      		OPT_BOOL(0, "contained", &opts.contained,
    @@ builtin/replay.c: int cmd_replay(int argc,
      		usage_with_options(replay_usage, replay_options);
      	}
      
    --	die_for_incompatible_opt2(!!opts.advance, "--advance",
    --				  opts.contained, "--contained");
    --	die_for_incompatible_opt2(!!opts.advance, "--advance",
    --				  !!opts.onto, "--onto");
     +	die_for_incompatible_opt3(!!opts.onto, "--onto",
     +				  !!opts.advance, "--advance",
     +				  !!opts.revert, "--revert");
    -+	if (opts.contained && !opts.onto)
    -+		die(_("--contained requires --onto"));
    + 	die_for_incompatible_opt2(!!opts.advance, "--advance",
    + 				  opts.contained, "--contained");
    +-	die_for_incompatible_opt2(!!opts.advance, "--advance",
    +-				  !!opts.onto, "--onto");
    ++	die_for_incompatible_opt2(!!opts.revert, "--revert",
    ++				  opts.contained, "--contained");
      
      	/* Parse ref action mode from command line or config */
      	ref_mode = get_ref_action_mode(repo, ref_action);
    -@@ builtin/replay.c: int cmd_replay(int argc,
    - 	 * some options changing these values if we think they could
    - 	 * be useful.
    - 	 */
    --	revs.reverse = 1;
    + 
     +	/*
     +	 * Cherry-pick/rebase need oldest-first ordering so that each
     +	 * replayed commit can build on its already-replayed parent.
     +	 * Revert needs newest-first ordering (like git revert) to
     +	 * reduce conflicts by peeling off changes from the top.
     +	 */
    -+	revs.reverse = opts.revert ? 0 : 1;
    ++	int desired_reverse = !opts.revert;
    ++
    + 	repo_init_revisions(repo, &revs, prefix);
    + 
    + 	/*
    +@@ builtin/replay.c: int cmd_replay(int argc,
    + 	 * some options changing these values if we think they could
    + 	 * be useful.
    + 	 */
    +-	revs.reverse = 1;
    ++	revs.reverse = desired_reverse;
      	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
      	revs.topo_order = 1;
      	revs.simplify_history = 0;
    @@ builtin/replay.c: int cmd_replay(int argc,
      	 * walking options.
      	 */
     -	if (revs.reverse != 1) {
    --		warning(_("some rev walking options will be overridden as "
    --			  "'%s' bit in 'struct rev_info' will be forced"),
    --			"reverse");
    ++	if (revs.reverse != desired_reverse) {
    + 		warning(_("some rev walking options will be overridden as "
    + 			  "'%s' bit in 'struct rev_info' will be forced"),
    + 			"reverse");
     -		revs.reverse = 1;
    -+	{
    -+		int desired_reverse = opts.revert ? 0 : 1;
    -+		if (revs.reverse != desired_reverse) {
    -+			warning(_("some rev walking options will be overridden as "
    -+				  "'%s' bit in 'struct rev_info' will be forced"),
    -+				"reverse");
    -+			revs.reverse = desired_reverse;
    -+		}
    ++		revs.reverse = desired_reverse;
      	}
      	if (revs.sort_order != REV_SORT_IN_GRAPH_ORDER) {
      		warning(_("some rev walking options will be overridden as "
    @@ replay.c
      #include "strmap.h"
      #include "tree.h"
      
    --/*
    -- * We technically need USE_THE_REPOSITORY_VARIABLE for DEFAULT_ABBREV, but
    -- * do not want to use the_repository.
    -- */
    --#define the_repository DO_NOT_USE_THE_REPOSITORY
    +@@
    +  */
    + #define the_repository DO_NOT_USE_THE_REPOSITORY
    + 
     +enum replay_mode {
     +	REPLAY_MODE_PICK,
     +	REPLAY_MODE_REVERT,
     +};
    - 
    ++
      static const char *short_commit_name(struct repository *repo,
      				     struct commit *commit)
    + {
     @@ replay.c: static char *get_author(const char *message)
      	return NULL;
      }
    @@ t/t3650-replay-basics.sh: test_expect_success 'no base or negative ref gives no-
     -test_expect_success 'options --advance and --contained cannot be used together' '
     -	printf "fatal: options ${SQ}--advance${SQ} " >expect &&
     -	printf "and ${SQ}--contained${SQ} cannot be used together\n" >>expect &&
    -+test_expect_success '--contained requires --onto' '
    -+	echo "fatal: --contained requires --onto" >expect &&
    ++test_expect_success '--advance and --contained cannot be used together' '
      	test_must_fail git replay --advance=main --contained \
      		topic1..topic2 2>actual &&
    - 	test_cmp expect actual
    +-	test_cmp expect actual
    ++	test_grep "cannot be used together" actual
      '
      
      test_expect_success 'cannot advance target ... ordering would be ill-defined' '
     -	echo "fatal: cannot advance target with multiple sources because ordering would be ill-defined" >expect &&
    -+	cat >expect <<-\EOF &&
    -+	fatal: '"'"'--advance'"'"' cannot be used with multiple revision ranges because the ordering would be ill-defined
    -+	EOF
    ++	echo "fatal: ${SQ}--advance${SQ} cannot be used with multiple revision ranges because the ordering would be ill-defined" >expect &&
      	test_must_fail git replay --advance=main main topic1 topic2 2>actual &&
      	test_cmp expect actual
      '
    @@ t/t3650-replay-basics.sh: test_expect_success 'invalid replay.refAction value' '
     +'
     +
     +test_expect_success 'cannot revert with multiple sources' '
    -+	cat >expect <<-\EOF &&
    -+	fatal: '"'"'--revert'"'"' cannot be used with multiple revision ranges because the ordering would be ill-defined
    -+	EOF
    ++	echo "fatal: ${SQ}--revert${SQ} cannot be used with multiple revision ranges because the ordering would be ill-defined" >expect &&
     +	test_must_fail git replay --revert main main topic1 topic2 2>actual &&
     +	test_cmp expect actual
     +'
    @@ t/t3650-replay-basics.sh: test_expect_success 'invalid replay.refAction value' '
     +
     +test_expect_success 'git replay --revert incompatible with --contained' '
     +	test_must_fail git replay --revert topic4 --contained topic4~1..topic4 2>error &&
    -+	test_grep "requires --onto" error
    ++	test_grep "cannot be used together" error
     +'
     +
     +test_expect_success 'git replay --revert incompatible with --onto' '

base-commit: d181b9354cf85b44455ce3ca9e6af0b9559e0ae2
-- 
2.51.0

