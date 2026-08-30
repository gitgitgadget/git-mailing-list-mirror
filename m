Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC35970808
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788122920; cv=none; b=jcIF4CPMbsvekp/xCQCHAp7vesVeecyjW998Y7ze0HOuThYgIAV2bqFXw08Mh+6Uwh+13lFqlLxdMjyBR/BtE7VDyjHmyG/+b1F4YjI6XYK/CVInM7FDspda3sp/a0YAlD8/hyX5xO759Hs66loi6/Vmd+sAjWmSlsln821naqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788122920; c=relaxed/simple;
	bh=di9TITeetSUYbK3hgGvEjJ13hV089cXniEmyz75Uk18=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8Uf3GXva5dzK7iVt8NKw+1yja/KLhf4H15XyAUKIG91MFdjfUlceBMifr6QSYARQzzb9YH8TrLDe5zTuDLPhivSJNpQeD8k6pORjA67sI612AOSi676n6xaLrO3DtZtdO8FyLPE5xv7SlIo12007HnJOx5LO3Tq4VvhIWbQY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gSGQQP9h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zz+hSi5t; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gSGQQP9h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zz+hSi5t"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D7C6CEC0086;
	Sun, 30 Aug 2026 16:48:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 30 Aug 2026 16:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788122916; x=
	1788209316; bh=1n+By0S01tKvqOxVPmBywwARBVfHublwnhDCSGaAm1E=; b=g
	SGQQP9hRjVeZOT8Uy43AO/uqFQ1/Yu1+nI+fBfI9CZiHgpiUfW6LZ+3gXV+hH8eL
	9wOVaRQj5CT3uwfwoG4A3FWqbkBOHcHvAXqZxc76O8EPc8ctr5q4xH5bb6gTGB7E
	rtJqjU57Ljc/kAitb9bI/C9lFP6kgtRtYqGxE8b9t/9mBM1ghggNO7EAel6up+ZY
	lWLBGBLGPDXeTDTTreEhbZHzqrtK0Y9g9vgrJr0SzWljxVgAClRB7z725uFTh/qh
	wJCgXu8ConXC4u36RHVCNIikEu82F7wIBrm+//hTkeSIoCAceg/ayWUjTKro8TrY
	OgboF9VykFIKPU3QPJcoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1788122916; x=1788209316; bh=1n+By0S01tKvqOxVPmBywwARBVfH
	ublwnhDCSGaAm1E=; b=Zz+hSi5tkFYZ5nONxN6hn8aOi5wT6L/WB/XXRq5wcv0W
	JHwrIctisivRZInK018YnHPCrg7XR1b0bnNtDEI1lXvH+I7hz/2v1XQDarzViczo
	HhN7tFfQqntrPzBwl2b95cwtrKOEBG4SEggXh0UTedVqrNpsNOFbSUsdhOgr14gl
	1yeI3YgwL2SC79sSkwy+qQbB2f6RF0mM208MOvaEhdH6FSEoD7fJiphkT0t2rlHE
	eb1cMEbeURaq08O6BvOXecJ8Zq3y8gTE+RN4M+f/QyZ9cBZyQOfQFnVnjTKpBkDl
	LqSWx+OTMppOOcSQHEZFzbz4QaPWsubm3bLnAe7qkQ==
X-ME-Sender: <xms:JJeUarIVXtrjwDXI0oESKboH6GvPQYFXZwLIuxgnjbphYB7-jW-iJQ>
    <xme:JJeUalLIOLYoQP1Hr3ZLKOBpSB1nXXO6UtVAk4QtbxAhf3IS62gdxrhZoJ5Ec4Ybf
    VGUTF9ZH3bguHFBJxbuSQ12gmlQ-BijuehO-ThMtD58iAEKc5dS>
X-ME-Received: <xmr:JJeUahXtB5YAiojc4Gh5-fkguO0CPRtqn0ZgC3NIuR74fjd_x0AQn8QA0kVBqyQrPZx-goHDC7p21qhG5_9I9JWGz6AZc5aFsQ>
X-ME-Proxy-Cause: dmFkZTFH0SWV64oE57eKLfEAqUR6Z5Jm6o8yqdhy5NXFVNj6hZvUsGZbPa3M+AJVuBHilv
    s3SAfDZNXt6yfzs+SuPElN3WmfHe2mwKfCtvacnowdHWj6+E+sr68Fxvq4wmgpFfc1kDOW
    FtAT1qTXxtHN1iReqGYoxlP5IXsKg6JG6h3zBOqogOaglPT3RwlGlMjpjVWKOD7ZlGJH/6
    XDWklzTlwkOAK5aAhI7SG57XoOr+asWx92cRfFj+2Ym8+3UA9UE+6AC1PGStOLyT4Lykk4
    BT+DWart6/JyRJZhWScTnU3psNqqGkK5TNYkDdF+nhvuoHJw4f5vYfTgWkokvhtMueTbtr
    zEwoH/O83ZjsvEwK3r8ZvkZvdNSPD0aXUr2SRDK9GowSA70XuwtFwQYmN2frtcwAFlN3Hz
    6q6i1wdKzbV0dH8Jq69Ug7obBAc4tzJntsvj1Q9cxavG8QwmMqOEAyKxCkCaemEAfZeIag
    UfIOtavW4onMDk/KGxCCYXTjUBXXQ5Xjj6UUF0HCF0j6FOfu5p2k50AN9B328iXbvLbtRt
    RMfJ0fuh9yCa7BLdxA0m+vkTgqnZj4NOEPuEmVM0dNlDYDgUFs6fefZNoSyv2BdgQ0GEyq
    Nr/0C+SNekSxYAW9MaLQeuZy5mhqwd76s8KA7kZ23S/Z2C5Hw33DiSG3Xd/Q
X-ME-Proxy: <xmx:JJeUavgYl-3jd67UKuRtHJW5zaBEJ0RfJKOi0AbjKx65D_pTUlXBFg>
    <xmx:JJeUak_vKuhxebSJQHIEVwjXWoyzTtBuuleKk2DeDSzIKNpZzQiSdg>
    <xmx:JJeUahDKtCn5X-6x0shb4P8gYsIJrNu1NjadOyVYLB1vkmm2koNaQg>
    <xmx:JJeUapIb2TElONzw29c5Gq0TL2FRtYpWohm0S0jn34V0lwuPkh0mWg>
    <xmx:JJeUavtU3ncNj7W-HTKfQxZbKJY-r1bVo5Wwu3rnLp551mni90eKixy5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Aug 2026 16:48:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 0/8] More sensible checkout/switch/restore code refactoring
Date: Sun, 30 Aug 2026 13:48:27 -0700
Message-ID: <20260830204835.1040408-1-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-884-g76cf8659c2
In-Reply-To: <20260828225206.310500-1-gitster@pobox.com>
References: <20260828225206.310500-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the beginning, there was only 'git checkout'.  We then introduced
'git switch' and 'git restore', borrowing as much original code as
possible from the implementation of 'git checkout'.

Unfortunately, this has left the code in a strange shape.  Had we
started from separate implementations for 'switch' and 'restore'
then later merged them into 'checkout', we would not have arrived at
a design where three front-end routines, cmd_checkout(),
cmd_switch(), and cmd_restore(), funnel into a single monolithic
choke point in checkout_main(), which then determines whether we are
checking out a branch or paths, and dispatches to checkout_branch()
or checkout_paths().

This series is an attempt to repartition the code into a better
shape.  Because checkout_branch() and checkout_paths() already exist
as two reusable helper functions, with sufficient refactoring of
checkout_main(), the two newer entry points, cmd_switch() and
cmd_restore(), can parse command-line arguments and configuration
settings and jump straight into checkout_branch() or
checkout_paths() respectively, without worrying about the other path.

Of course, cmd_checkout() still needs to decide whether to check out
a branch or a set of paths and dispatch between these two backends.

The series begins with three fairly isolated cleanups that are worth
making on their own, even if we do not follow through with the rest
of the series.  Patches 4 and 5 then refactor various utility
functions out of existing code paths, and patch 6 uses them to
rewrite the three top-level command entry points to call these
functions without going through checkout_main().  Patch 7 is a
style-only fix done after the dust settles, which was deliberately
kept separate to simplify review.

The final step moves one helper utility out of builtin/checkout.c to
top-level checkout.c as an illustration of the libification discussed
in our recent threads.

Note that I consider this a fairly early and rough draft for
illustration only.  There may be a few topics that touch 'git
checkout', and a refactoring of this scale might adversely impact
them, so I will not even merge these patches to 'seen'.

 1/8: checkout: pass cb_option explicitly to branch name parsers
 2/8: checkout: validate new branch name in checkout_branch()
 3/8: checkout: validate stage and merge option compatibility in
        checkout_paths()
 4/8: checkout: extract option validation and pathspec helpers
 5/8: checkout: extract branch setup and tracking helpers
 6/8: checkout: restructure switch, restore, and checkout
        entrypoints
 7/8: checkout: wrap overly long lines
 8/8: checkout: move post_checkout_hook() to checkout.c

Changes since the initial version are:

* [7/8] corrects the arguments to die_for_incompatible_optN() to
  preserve similarity to the original as well as the output
  message.

* [8/8] corrects the function signature of post_checkout_hook() to
  make it independent of 'the_repository'.


 builtin/checkout.c | 557 +++++++++++++++++++++++----------------------
 checkout.c         |  28 +++
 checkout.h         |  10 +
 3 files changed, 328 insertions(+), 267 deletions(-)

Range-diff against v1:
1:  346f98225a = 1:  346f98225a checkout: pass cb_option explicitly to branch name parsers
2:  51320f57c9 = 2:  51320f57c9 checkout: validate new branch name in checkout_branch()
3:  6c321a88d6 = 3:  6c321a88d6 checkout: validate stage and merge option compatibility in checkout_paths()
4:  4eefe85ca7 = 4:  4eefe85ca7 checkout: extract option validation and pathspec helpers
5:  0154ed2547 = 5:  0154ed2547 checkout: extract branch setup and tracking helpers
6:  c431b36468 = 6:  c431b36468 checkout: restructure switch, restore, and checkout entrypoints
7:  9fdd854d1b ! 7:  c8869d0b6a checkout: wrap overly long lines
    @@ builtin/checkout.c: static void validate_path_options(struct checkout_opts *opts
      
     -	if (opts->overlay_mode == 1 && opts->patch_mode)
     -		die(_("options '%s' and '%s' cannot be used together"), "-p", "--overlay");
    -+	die_for_incompatible_opt2(opts->overlay_mode == 1, "--overlay",
    -+				  opts->patch_mode, "-p");
    ++	die_for_incompatible_opt2(opts->patch_mode, "-p",
    ++				  opts->overlay_mode == 1, "--overlay");
      
      	if (opts->checkout_index >= 0 || opts->checkout_worktree >= 0) {
      		if (opts->checkout_index < 0)
    @@ builtin/checkout.c: static void parse_pathspec_from_file_options(struct checkout
      	if (opts->pathspec_from_file) {
      		if (opts->pathspec.nr)
     -			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
    -+			die(_("'%s' and pathspec arguments cannot be used together"),
    -+			    "--pathspec-from-file");
    - 
    +-
     -		if (opts->force_detach)
     -			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--detach");
    -+		die_for_incompatible_opt2(opts->force_detach, "--detach",
    -+					  1, "--pathspec-from-file");
    - 
    +-
     -		if (opts->patch_mode)
     -			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
     -
     -		parse_pathspec_file(&opts->pathspec, 0,
     -				    0,
     -				    prefix, opts->pathspec_from_file, opts->pathspec_file_nul);
    -+		die_for_incompatible_opt2(opts->patch_mode, "--patch",
    -+					  1, "--pathspec-from-file");
    ++			die(_("'%s' and pathspec arguments cannot be used together"),
    ++			    "--pathspec-from-file");
    ++
    ++		die_for_incompatible_opt2(!!opts->pathspec_from_file,
    ++					  "--pathspec-from-file",
    ++					  opts->force_detach,
    ++					  "--detach");
    ++
    ++		die_for_incompatible_opt2(!!opts->pathspec_from_file,
    ++					  "--pathspec-from-file",
    ++					  opts->patch_mode,
    ++					  "--patch");
    ++
     +		parse_pathspec_file(&opts->pathspec, 0, 0,
     +				    prefix, opts->pathspec_from_file,
     +				    opts->pathspec_file_nul);
    @@ builtin/checkout.c: static void parse_pathspec_from_file_options(struct checkout
     +	new_branch_opt[1] = cb_option;
     +	new_branch_force_opt[1] = toupper(cb_option);
     +
    -+	die_for_incompatible_opt3(opts->new_branch,
    ++	die_for_incompatible_opt3(!!opts->new_branch,
     +				  new_branch_opt,
    -+				  opts->new_new_branch_force,
    ++				  !!opts->new_branch_force,
     +				  new_branch_force_opt,
    -+				  opts->new_orphan_branch, "--orphan");
    ++				  !!opts->new_orphan_branch, "--orphan");
      
      	if (opts->new_branch_force)
      		opts->new_branch = opts->new_branch_force;
8:  295188d521 ! 8:  b5b31c33ae checkout: move post_checkout_hook() to checkout.c
    @@ Commit message
         so that other subsystems can invoke the post-checkout hook without
         depending on builtin/checkout.c.
     
    +    Remove the dependency on 'the_repository'.  While OK when the helper
    +    was in builtin/checkout.c as an integral part of 'git checkout' (and
    +    'git restore'), this is no longer true for a common utility
    +    function.  Have it take a pointer to 'struct repository' and use its
    +    associated hash algorithm.
    +
         This step in the series is entirely optional and is here primarily
         for illustration.  We may later want to teach 'git worktree' to
         trigger the 'post-checkout' hook, for example, in which case such
    @@ builtin/checkout.c: static void branch_info_release(struct branch_info *info)
      /*
       * Handle a tree object and determine if we need to recurse into the
       * tree (READ_TREE_RECURSIVE) or skip it (0).
    +@@ builtin/checkout.c: static int checkout_paths(const struct checkout_opts *opts,
    + 			   &rev, NULL);
    + 	head = lookup_commit_reference_gently(the_repository, &rev, 1);
    + 
    +-	errs |= post_checkout_hook(head, head, 0);
    ++	errs |= post_checkout_hook(the_repository, head, head, 0);
    + 	return errs;
    + }
    + 
    +@@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
    + 		}
    + 	}
    + 
    +-	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
    ++	ret = post_checkout_hook(the_repository,
    ++				 old_branch_info.commit, new_branch_info->commit, 1);
    + 	branch_info_release(&old_branch_info);
    + 	strbuf_release(&old_commit_shortname);
    + 	strbuf_release(&autostash_msg);
     
      ## checkout.c ##
     @@
    @@ checkout.c: char *unique_tracking_name(const char *name, struct object_id *oid,
      	return NULL;
      }
     +
    -+int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
    ++int post_checkout_hook(struct repository *repo,
    ++		       struct commit *old_commit, struct commit *new_commit,
     +		       int changed)
     +{
     +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
    ++	const struct git_hash_algo *hash_algo = repo->hash_algo;
     +
     +	/*
     +	 * "new_commit" can be NULL when checking out from the index before
     +	 * a commit exists.
     +	 */
     +	strvec_pushl(&opt.args,
    -+		     oid_to_hex(old_commit ? &old_commit->object.oid : null_oid(the_hash_algo)),
    -+		     oid_to_hex(new_commit ? &new_commit->object.oid : null_oid(the_hash_algo)),
    ++		     oid_to_hex(old_commit
    ++				? &old_commit->object.oid
    ++				: null_oid(hash_algo)),
    ++		     oid_to_hex(new_commit ?
    ++				&new_commit->object.oid
    ++				: null_oid(hash_algo)),
     +		     changed ? "1" : "0",
     +		     NULL);
     +
    -+	return run_hooks_opt(the_repository, "post-checkout", &opt);
    ++	return run_hooks_opt(repo, "post-checkout", &opt);
     +}
     
      ## checkout.h ##
    @@ checkout.h
      #include "hash.h"
      
     +struct commit;
    ++struct repository;
     +
      /*
       * Check if the branch name uniquely matches a branch name on a remote
    @@ checkout.h: char *unique_tracking_name(const char *name,
     +/*
     + * Run the post-checkout hook.
     + */
    -+int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
    ++int post_checkout_hook(struct repository *,
    ++		       struct commit *old_commit, struct commit *new_commit,
     +		       int changed);
     +
      #endif /* CHECKOUT_H */
-- 
2.55.0-884-g76cf8659c2

