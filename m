Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B82022068D
	for <git@vger.kernel.org>; Thu, 14 May 2026 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762501; cv=none; b=BNAgbLmTOqkRP+dubqzBSMKWzhpr8Lit5x1mS5E0+6KPcmBzj7SUOuf6O4k+65v0MptWZIrD6lqANeXFJJQDRG3B6XzxX4L8BnB88jWluSxoPz9liex/W5NykXhs8HSjFcK+btIfYwRoq4lT6NelS7xAJBaaorEKMR4sZGY6BgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762501; c=relaxed/simple;
	bh=15pAALGrS/fJ8+RYVzQ8xSFUJIw+WG4qjIUZmu0+spQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fsu2YFq/texwk7gisExdEOPBXQKsB7tAxf1+pByJvFkO7EoOwrp7FPyijQRbzG1bk7pZpVIEpCDgg3kzXExuMYnSGjLuHYYi14FNOj8fVMh2Nx0ypZB3Ki2vshCxqk7xmru89jVqxHblS60CMsMy2m9g1NoSHywv5luEsIFUqiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsC5o3Np; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsC5o3Np"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f3c623322bso13374706eec.0
        for <git@vger.kernel.org>; Thu, 14 May 2026 05:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778762498; x=1779367298; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeOprxRIbbHEOokqjCUyfknhvEUwjAWWD75kn+2NRmk=;
        b=hsC5o3NpyAQLGbHS64mCHLlUmfSUmpOF+YQGL04FHd1ZvjkfAZL5ktnvVg1JO9t5QJ
         u5w2kFgREXO97O/Jv1ley899LDmYWK3LypAdns2vHGYlHIDFTXIRaKC/pkYxFqUT2UxW
         8neNIBKxSZ4TEHKbNEFKDg8lWkjoWnDeTemVGE3pWi+uzeZRcUCe35MKptyppExAiBTu
         dmnOiRlpeqwtXU1nQC5X7pzub/C200ll1vOUlJu9lyZAqNLn/CZl7tVa7TP7V38fX2Wb
         wOFGJgM8DtcZ7UoeMHkElrXOxhivkTfoa2pBwjdS60IOIjCRsc9ry3JhSm7uUEW0Bblz
         Y4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778762498; x=1779367298;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PeOprxRIbbHEOokqjCUyfknhvEUwjAWWD75kn+2NRmk=;
        b=pOuxrTNs4cUh3iHeZt/Tz1DSf/5PgMtZRqnIfVRACaLy94sqx5QCSLyw1dmVikH134
         8PnA0Z2eI11fp9rLelD81G2wTDrZ6h/yvb6mxGFKt4dGL7WfoRp3gBaiLdU6cG5WoVXN
         UkeuBPopaeypQQ8ZNTBsl6mPfgVo8J07VZTH2TswtEDhdhtwGNLC6jW1KKc0PzbLSxKq
         uNU56Gy+thT8ftTledUY+NSACZ7I52IfsDyMZd+woHbbOsO3M7Ihj5QQg7BZvldfHskl
         NfF7RDlXHXoYXr7yZc+qc1OLf++6IKV5KUsGe1WWjiGXgMj8yI4NfJ518QYHHjIxtdlo
         3l0A==
X-Gm-Message-State: AOJu0Yx4oPLHtBEgSMpW/p7g0frAm4VQSt2LM+RBoFqvJ0XXf6OCLWgO
	yl6TFjw8MLFr3MBB7bmEJCXwz/lS4hYZA9nCIZxduvAjuVFLvUiatjm3UAs6vw==
X-Gm-Gg: Acq92OHA8Go/5tCxnX72uHRZKD9XJ1y0jsuGcgI8wsO1kUVpsl9JMXxg90s2pBJcha3
	8BrcekzQVu9Mik7yG0mqLLrLIjK/0AvIebipnOinew4RCecod0gHErnNyf3LjJJ7/hNMjllpdzp
	yk/01OVhmM2e7EqlCostQHThXhquUrCmpRSB4/eM7RI6tWNZ8kP+cnG77l7mioM/1RuquRuOi0l
	txQVTSkYVM2voPRbYtxfZ6Pt9WmcjdVG1VBHB7RI8Ts7hrTN8EY7x5MVRNU9qaEicwgYRd52T2I
	AWGHwKh+ateVMYC7INdy7iV1ie9B8opdgWRfTtAIstk1EplGveD5fFN5HFW+IWeHMxieuOyOTJV
	k6EUWvmDq99f6nxFNiJK/90dRQ55OT5Chfoh6t6/jFD4AyT3btPUKwojMIEtuUqTAh6Id1ryyFY
	5vBpEfpS87InAzrrtujPF5ptIO81rDz7KeNXaJltyikclshtY=
X-Received: by 2002:a05:7300:6428:b0:2f4:3a9c:818c with SMTP id 5a478bee46e88-30155e3173emr4260498eec.29.1778762497383;
        Thu, 14 May 2026 05:41:37 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.45.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcc464sm2894882eec.14.2026.05.14.05.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:41:36 -0700 (PDT)
Message-Id: <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
References: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 May 2026 12:41:27 +0000
Subject: [PATCH v4 0/8] fetch: rework negotiation tip options
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
    ps@pks.im,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Derrick Stolee <stolee@gmail.com>

Fetch negotiation aims to find enough information from haves and wants such
that the server can be reasonably confident that it will send all necessary
objects and not too many "extra" objects that the client already has.
However, this can break down if there are too many references, since Git
truncates the list of haves based on a few factors (a 256 count limit or the
server sending an ACK at the right time).

We already have the --negotiation-tip feature to focus the set of references
that are used in negotiation, but I feel like this is designed backwards.
I'd rather that we have a way to say "this is an important set of refs, but
feel free to add more refs if needed" than "only use these refs for
negotiation".

Here's an example that demonstrates the problem. In an internal monorepo,
developers work off of the 'main' branch so there are thousands of user
branches that each add a few commits different from the 'main' branch.
However, there is also a long-lived 'release' branch. This branch has a
first-parent history that is parallel to 'main' and each of those commits is
a merge whose second parent is a commit from 'main' that had a successful CI
run. There are additional changes in the 'release' branch merge commits that
add some changelog data, so there is a nontrivial set of novel blob content
in that branch and not just a different set of commits.

The problem we had was that our georeplication system was regularly fetching
from the origin and trying to get all data from all reachable branches. When
the 'release' branch updated, the client would run out of haves before
advertising its copy of the 'release' branch, but it would still list the
new 'release' tip as a want. The server would then think that the client had
never fetched that branch before and would send all of the changelog data
from the whole history of the repo. (This led to a lot of downstream
problems; we mitigated by setting a refspec that stopped fetching the
'release' branch, but this is not ideal.)

What I'd like is a mechanism to say "always advertise the client's version
of 'main' and 'release' but also opportunistically include some user
branches".

Based on my understanding, the '--negotiation-tip' option is close but not
quite what I want. I could have the client only advertise 'release' and
'main' and never advertise any user branches. But then we'd download all
content from each user branch every time it updates. Perhaps this would
happen even with opportunistic inclusion of more haves, but I'd like to
explore this area more.

There's also an issue that the '--negotiation-tip' feature doesn't seem to
have a config key that enables it without CLI arguments. This is something
that we could consider independently.

This patch series adds a new '--negotiation-include' option that does what I
want: it makes sure that these references are included as 'have's during
negotiation. In order to help clarify the difference between this and
'--negotiation-tip', I first create a synonym called
'--negotiation-restrict'.

Both of these options get 'remote.*.negotiation(Include|Restrict)' config
options that enable their behavior by default.

During development, I had briefly considered only using config values, but
that required some strange changes to care about the remote name in the
transport layer. This was most different in the 'git push' integration. When
I discovered the '--negotiation-tip' feature during the process, that gave
me a clear pattern to follow with the addition of a config on top.


Updates in v2
=============

This version is a near-complete rewrite based on feedback around the names
of the previous option and config. The --negotiation-restrict option is new
and the ability to set it via config is also new.

I did try to be more careful around translatable error messages, too.


Updates in v3
=============

 * --negotiation-tip is now an alias of --negotiation-restrict.
 * More translatable strings use %s to isolate non-translatable options from
   translatable words.
 * The string_list named negotiation_tip is now renamed to
   negotiation_restrict.
 * The config options now allow an empty value to reset the list.
 * The --negotiation-require option is now called --negotiation-include.
 * Similarly, the config option is renamed and all code references.
 * The included haves now mark their commits as COMMON so commits that they
   can reach are not included in the negotiation walk if they are reached
   from the restricted commits.
 * The ref iterators are more careful about failing on bad references (ref
   exists but object doesn't) and ignoring missing references (perhaps
   config is erroneous?).
 * When sending tips during push negotiation, use the --negotiation-restrict
   option instead of -tip.


Updates in v4
=============

Thanks, Matthew, for the detailed review! There are some big changes in this
version.

 * Expanded commit message to cite the commit that introduced the bug
   (3f763ddf28).
 * Renamed --negotiation-tip to --negotiation-restrict throughout docs/code
   (including send-pack.c, transport-helper.c, builtin/pull.c). Added
   OPT_ALIAS in git-pull.
 * Switched config parsing to use parse_transport_option() helper. Removed
   git push from docs (not implemented yet). Restructured --negotiate-only
   validation flow.
 * NEW Patch 5: Added have_sent() interface to negotiators, so included
   haves can be de-duplicated properly by the negotiation algorithm.
 * Replaced COMMON flag hack with negotiator->have_sent() calls. Moved
   ref-pattern resolution into builtin/fetch.c (add_negotiation_tips()) so
   fetch-pack receives pre-resolved oid_array instead of string_list. Added
   test for --negotiation-tip ignoring missing refs. Added
   duplicate-avoidance test for v0. Accepts commit hashes in addition to ref
   names/globs.
 * Use parse_transport_option() for config. Updated docs to mention commit
   hashes. Removed git push from config docs. Fixed test to use correct
   restrict/include combinations.
 * In the last patch, add doc notes that remote config values also apply
   during git push with push.negotiate, now that they are integrated by that
   change.

Thanks, -Stolee

Derrick Stolee (8):
  t5516: fix test order flakiness
  fetch: add --negotiation-restrict option
  transport: rename negotiation_tips
  remote: add remote.*.negotiationRestrict config
  negotiator: add have_sent() interface
  fetch: add --negotiation-include option for negotiation
  remote: add remote.*.negotiationInclude config
  send-pack: pass negotiation config in push

 Documentation/config/fetch.adoc  |   2 +-
 Documentation/config/remote.adoc |  51 +++++++++
 Documentation/fetch-options.adoc |  29 ++++-
 builtin/fetch.c                  |  82 ++++++++++---
 builtin/pull.c                   |   6 +-
 fetch-negotiator.h               |   9 ++
 fetch-pack.c                     |  99 +++++++++++++---
 fetch-pack.h                     |  10 +-
 negotiator/default.c             |   8 ++
 negotiator/noop.c                |   7 ++
 negotiator/skipping.c            |   8 ++
 remote.c                         |  10 ++
 remote.h                         |   2 +
 send-pack.c                      |  39 +++++--
 send-pack.h                      |   2 +
 t/t5510-fetch.sh                 | 191 +++++++++++++++++++++++++++++++
 t/t5516-fetch-push.sh            |  32 +++++-
 t/t5702-protocol-v2.sh           |   4 +-
 transport-helper.c               |   5 +-
 transport.c                      |  20 +++-
 transport.h                      |   7 +-
 21 files changed, 561 insertions(+), 62 deletions(-)


base-commit: 6e8d538aab8fe4dd07ba9fb87b5c7edcfa5706ad
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2085%2Fderrickstolee%2Fmust-have-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2085/derrickstolee/must-have-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2085

Range-diff vs v3:

 1:  466c56abe0 ! 1:  7409a479d6 t5516: fix test order flakiness
     @@ Commit message
          t5516: fix test order flakiness
      
          The 'fetch follows tags by default' test sorts using 'sort -k 4', but
     -    for-each-ref output only has 3 columns. This relies on sort treating
     -    records with fewer fields as having an empty fourth field, which may
     -    produce unstable results depending on locale. Use 'sort -k 3' to match
     -    the actual number of columns in the output.
     +    for-each-ref output only has 3 columns. This relies on sort treating records
     +    with fewer fields as having an empty fourth field, which may produce
     +    unstable results depending on locale. This appears to be an accident added
     +    in 3f763ddf28 (fetch: set remote/HEAD if it does not exist, 2024-11-22).
     +
     +    Use 'sort -k 3' to match the actual number of columns in the output.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
 2:  fe875399a8 ! 2:  7836a2d6a5 fetch: add --negotiation-restrict option
     @@ Commit message
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     + ## Documentation/config/fetch.adoc ##
     +@@
     + 	default is `skipping`.  Unknown values will cause `git fetch` to
     + 	error out.
     + +
     +-See also the `--negotiate-only` and `--negotiation-tip` options to
     ++See also the `--negotiate-only` and `--negotiation-restrict` options to
     + linkgit:git-fetch[1].
     + 
     + `fetch.showForcedUpdates`::
     +
       ## Documentation/fetch-options.adoc ##
      @@ Documentation/fetch-options.adoc: the current repository has the same history as the source repository.
       	`.git/shallow`. This option updates `.git/shallow` and accepts such
     @@ Documentation/fetch-options.adoc: the current repository has the same history as
       This option may be specified more than once; if so, Git will report
       commits reachable from any of the given commits.
       +
     +@@ Documentation/fetch-options.adoc: configuration variables documented in linkgit:git-config[1], and the
     + 
     + `--negotiate-only`::
     + 	Do not fetch anything from the server, and instead print the
     +-	ancestors of the provided `--negotiation-tip=` arguments,
     ++	ancestors of the provided `--negotiation-restrict=` arguments,
     + 	which we have in common with the server.
     + +
     + This is incompatible with `--recurse-submodules=(yes|on-demand)`.
      
       ## builtin/fetch.c ##
      @@ builtin/fetch.c: static void add_negotiation_tips(struct git_transport_options *smart_options)
     @@ builtin/fetch.c: int cmd_fetch(int argc,
      
       ## builtin/pull.c ##
      @@ builtin/pull.c: int cmd_pull(int argc,
     - 		OPT_PASSTHRU_ARGV(0, "negotiation-tip", &opt_fetch, N_("revision"),
     + 		OPT_PASSTHRU('6',  "ipv6", &opt_ipv6, NULL,
     + 			N_("use IPv6 addresses only"),
     + 			PARSE_OPT_NOARG),
     +-		OPT_PASSTHRU_ARGV(0, "negotiation-tip", &opt_fetch, N_("revision"),
     ++		OPT_PASSTHRU_ARGV(0, "negotiation-restrict", &opt_fetch, N_("revision"),
       			N_("report that we have only objects reachable from this object"),
       			0),
     -+		OPT_PASSTHRU_ARGV(0, "negotiation-restrict", &opt_fetch, N_("revision"),
     -+			N_("report that we have only objects reachable from this object"),
     -+			0),
     ++		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
       		OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
       			 N_("check for forced-updates on all updated branches")),
       		OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,
      
     + ## send-pack.c ##
     +@@ send-pack.c: static void get_commons_through_negotiation(struct repository *r,
     + 	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
     + 	for (ref = remote_refs; ref; ref = ref->next) {
     + 		if (!is_null_oid(&ref->new_oid)) {
     +-			strvec_pushf(&child.args, "--negotiation-tip=%s",
     ++			strvec_pushf(&child.args, "--negotiation-restrict=%s",
     + 				     oid_to_hex(&ref->new_oid));
     + 			nr_negotiation_tip++;
     + 		}
     +
       ## t/t5510-fetch.sh ##
      @@ t/t5510-fetch.sh: EOF
       	test_cmp fatal-expect fatal-actual
     @@ t/t5702-protocol-v2.sh: setup_negotiate_only () {
       	EOF
       
       	test_must_fail git -c protocol.version=2 -C client fetch \
     +
     + ## transport-helper.c ##
     +@@ transport-helper.c: static int fetch_refs(struct transport *transport,
     + 	}
     + 
     + 	if (data->transport_options.negotiation_tips)
     +-		warning("Ignoring --negotiation-tip because the protocol does not support it.");
     ++		warning(_("ignoring %s because the protocol does not support it."),
     ++			"--negotiation-restrict");
     + 
     + 	if (data->fetch)
     + 		return fetch_with_fetch(transport, nr_heads, to_fetch);
 3:  4332cbf266 ! 3:  401bdaff7c transport: rename negotiation_tips
     @@ Commit message
          transport: rename negotiation_tips
      
          The previous change added the --negotiation-restrict synonym for the
     -    --negotiation-tips option for 'git fetch'. In anticipation of adding a
     -    new option that behaves similarly but with distinct changes to its
     -    behavior, rename the internal representation of this data from
     -    'negotiation_tips' to 'negotiation_restrict_tips'.
     +    --negotiation-tip option for 'git fetch'. In anticipation of adding a new
     +    option that behaves similarly but with distinct changes to its behavior,
     +    rename the internal representation of this data from 'negotiation_tips' to
     +    'negotiation_restrict_tips'.
      
     -    The 'tips' part is kept because this is an oid_array in the transport
     -    layer. This requires the builtin to handle parsing refs into collections
     -    of oids so the transport layer can handle this cleaner form of the data.
     +    The 'tips' part is kept because this is an oid_array in the transport layer.
     +    This requires the builtin to handle parsing refs into collections of oids so
     +    the transport layer can handle this cleaner form of the data.
      
          Also update the string_list used to store the inputs from command-line
          options.
     @@ transport-helper.c: static int fetch_refs(struct transport *transport,
       
      -	if (data->transport_options.negotiation_tips)
      +	if (data->transport_options.negotiation_restrict_tips)
     - 		warning("Ignoring --negotiation-tip because the protocol does not support it.");
     + 		warning(_("ignoring %s because the protocol does not support it."),
     + 			"--negotiation-restrict");
       
     - 	if (data->fetch)
      
       ## transport.c ##
      @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
 4:  d2f48b78b5 ! 4:  a14c568a1f remote: add remote.*.negotiationRestrict config
     @@ Metadata
       ## Commit message ##
          remote: add remote.*.negotiationRestrict config
      
     -    In a previous change, the --negotiation-restrict command-line option of
     -    'git fetch' was added as a synonym of --negotiation-tips. Both of these
     -    options restrict the set of 'haves' the client can send as part of
     -    negotiation.
     +    In a previous change, the --negotiation-restrict command-line option of 'git
     +    fetch' was added as a synonym of --negotiation-tip. Both of these options
     +    restrict the set of 'haves' the client can send as part of negotiation.
      
          This was previously not available via a configuration option. Add a new
     -    'remote.<name>.negotiationRestrict' multi-valued config option that
     -    updates 'git fetch <name>' to use these restrictions by default.
     +    'remote.<name>.negotiationRestrict' multi-valued config option that updates
     +    'git fetch <name>' to use these restrictions by default.
      
          If the user provides even one --negotiation-restrict argument, then the
          config is ignored.
     @@ Documentation/config/remote.adoc: priority configuration file (e.g. `.git/config
       `$HOME/.gitconfig`).
       
      +remote.<name>.negotiationRestrict::
     -+	When negotiating with this remote during `git fetch` and `git push`,
     -+	restrict the commits advertised as "have" lines to only those
     -+	reachable from refs matching the given patterns.  This multi-valued
     -+	config option behaves like `--negotiation-restrict` on the command
     -+	line.
     ++	When negotiating with this remote during `git fetch`, restrict the
     ++	commits advertised as "have" lines to only those reachable from refs
     ++	matching the given patterns.  This multi-valued config option behaves
     ++	like `--negotiation-restrict` on the command line.
      ++
      +Each value is either an exact ref name (e.g. `refs/heads/release`) or a
      +glob pattern (e.g. `refs/heads/release/*`).  The pattern syntax is the
     @@ builtin/fetch.c: int cmd_fetch(int argc,
       		if (!remote)
       			die(_("must supply remote when using --negotiate-only"));
       		gtransport = prepare_transport(remote, 1, &filter_options);
     -+		if (!gtransport->smart_options ||
     -+		    !gtransport->smart_options->negotiation_restrict_tips)
     +-		if (gtransport->smart_options) {
     +-			gtransport->smart_options->acked_commits = &acked_commits;
     +-		} else {
     ++
     ++		if (!gtransport->smart_options) {
     + 			warning(_("protocol does not support --negotiate-only, exiting"));
     + 			result = 1;
     + 			trace2_region_leave("fetch", "negotiate-only", the_repository);
     + 			goto cleanup;
     + 		}
     ++		if (!gtransport->smart_options->negotiation_restrict_tips)
      +			die(_("%s needs one or more %s"), "--negotiate-only",
      +			    "--negotiation-restrict=*");
     - 		if (gtransport->smart_options) {
     - 			gtransport->smart_options->acked_commits = &acked_commits;
     - 		} else {
     ++
     ++		gtransport->smart_options->acked_commits = &acked_commits;
     ++
     + 		if (server_options.nr)
     + 			gtransport->server_options = &server_options;
     + 		result = transport_fetch_refs(gtransport, NULL);
      
       ## remote.c ##
      @@ remote.c: static struct remote *make_remote(struct remote_state *remote_state,
     @@ remote.c: static int handle_config(const char *key, const char *value,
       		return parse_transport_option(key, value,
       					      &remote->server_options);
      +	} else if (!strcmp(subkey, "negotiationrestrict")) {
     -+		/* reset list on empty value. */
     -+		if (!value || !*value)
     -+			string_list_clear(&remote->negotiation_restrict, 0);
     -+		else
     -+			string_list_append(&remote->negotiation_restrict, value);
     ++		return parse_transport_option(key, value,
     ++					      &remote->negotiation_restrict);
       	} else if (!strcmp(subkey, "followremotehead")) {
       		const char *no_warn_branch;
       		if (!strcmp(value, "never"))
 -:  ---------- > 5:  94b79784fe negotiator: add have_sent() interface
 5:  ae81ef36a1 ! 6:  b4cd458fe0 fetch: add --negotiation-include option for negotiation
     @@ Commit message
          negotiation ref set to a specific list. In the earlier example, using
          --negotiation-restrict to focus the negotiation to 'dev' and 'release'
          would avoid those problematic downloads, but would still not allow
     -    advertising potentially-relevant user brances. In this way, the
     +    advertising potentially-relevant user branches. In this way, the
          'include' version solves the problem I mention while allowing
          negotiation to pick other references opportunistically. The two options
          can also be combined to allow the best of both worlds.
     @@ Commit message
          logic for the related --negotiation-restrict option to match.
      
          The implementation outputs the requested objects as haves before the
     -    negotiation algorithm kicks in and performs a priority-queue walk from the
     -    tip commits. In order to avoid duplicates, we mark the requested objects as
     -    COMMON so they (and their descendants) are not output by the negotiator. The
     -    negotiator still outputs at least one have before a round is flushed, when
     -    the server could ACK to stop the negotiation.
     +    negotiator performs its own algorithm to choose the next haves. Use the new
     +    have_sent() interface to signal these have commits were sent before engaging
     +    with the negotiator's next() iterator.
      
          Also add --negotiation-include to 'git pull' passthrough options.
      
     @@ Documentation/fetch-options.adoc: See also the `fetch.negotiationAlgorithm` and
       configuration variables documented in linkgit:git-config[1], and the
       `--negotiate-only` option below.
       
     -+`--negotiation-include=<revision>`::
     -+	Ensure that the given ref tip is always sent as a "have" line
     -+	during fetch negotiation, regardless of what the negotiation
     ++`--negotiation-include=(<commit>|<glob>)`::
     ++	Ensure that the commits at the given tips are always sent as "have"
     ++	lines during fetch negotiation, regardless of what the negotiation
      +	algorithm selects.  This is useful to guarantee that common
      +	history reachable from specific refs is always considered, even
      +	when `--negotiation-restrict` restricts the set of tips or when
      +	the negotiation algorithm would otherwise skip them.
      ++
     -+This option may be specified more than once; if so, each ref is sent
     ++This option may be specified more than once; if so, each commit is sent
      +unconditionally.
      ++
     -+The argument may be an exact ref name (e.g. `refs/heads/release`) or a
     -+glob pattern (e.g. `refs/heads/release/{asterisk}`).  The pattern syntax
     -+is the same as for `--negotiation-restrict`.
     ++The argument may be an exact ref name (e.g. `refs/heads/release`), an
     ++object hash, or a glob pattern (e.g. `refs/heads/release/{asterisk}`).
     ++The pattern syntax is the same as for `--negotiation-restrict`.
      ++
      +If `--negotiation-restrict` is used, the have set is first restricted by
      +that option and then increased to include the tips specified by
     @@ Documentation/fetch-options.adoc: See also the `fetch.negotiationAlgorithm` and
      +
       `--negotiate-only`::
       	Do not fetch anything from the server, and instead print the
     - 	ancestors of the provided `--negotiation-tip=` arguments,
     + 	ancestors of the provided `--negotiation-restrict=` arguments,
      
       ## builtin/fetch.c ##
      @@ builtin/fetch.c: static struct transport *gsecondary;
     @@ builtin/fetch.c: static struct transport *gsecondary;
       
       struct fetch_config {
       	enum display_format display_format;
     -@@ builtin/fetch.c: static void add_negotiation_restrict_tips(struct git_transport_options *smart_op
     +@@ builtin/fetch.c: static int add_oid(const struct reference *ref, void *cb_data)
     + 	return 0;
     + }
     + 
     +-static void add_negotiation_restrict_tips(struct git_transport_options *smart_options)
     ++static void add_negotiation_tips(struct string_list *input_list,
     ++				 struct oid_array **output_list)
     + {
     + 	struct oid_array *oids = xcalloc(1, sizeof(*oids));
     + 	int i;
     + 
     +-	for (i = 0; i < negotiation_restrict.nr; i++) {
     +-		const char *s = negotiation_restrict.items[i].string;
     ++	for (i = 0; i < input_list->nr; i++) {
     ++		const char *s = input_list->items[i].string;
     + 		struct refs_for_each_ref_options opts = {
     + 			.pattern = s,
     + 		};
       		int old_nr;
       		if (!has_glob_specials(s)) {
       			struct object_id oid;
     @@ builtin/fetch.c: static void add_negotiation_restrict_tips(struct git_transport_
       			oid_array_append(oids, &oid);
       			continue;
       		}
     +@@ builtin/fetch.c: static void add_negotiation_restrict_tips(struct git_transport_options *smart_op
     + 			warning(_("ignoring %s=%s because it does not match any refs"),
     + 				"--negotiation-restrict", s);
     + 	}
     +-	smart_options->negotiation_restrict_tips = oids;
     ++	*output_list = oids;
     + }
     + 
     + static struct transport *prepare_transport(struct remote *remote, int deepen,
     +@@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remote, int deepen,
     + 	}
     + 	if (negotiation_restrict.nr) {
     + 		if (transport->smart_options)
     +-			add_negotiation_restrict_tips(transport->smart_options);
     ++			add_negotiation_tips(&negotiation_restrict,
     ++					     &transport->smart_options->negotiation_restrict_tips);
     + 		else
     + 			warning(_("ignoring %s because the protocol does not support it"),
     + 				"--negotiation-restrict");
     +@@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remote, int deepen,
     + 		for_each_string_list_item(item, &remote->negotiation_restrict)
     + 			string_list_append(&negotiation_restrict, item->string);
     + 		if (transport->smart_options)
     +-			add_negotiation_restrict_tips(transport->smart_options);
     ++			add_negotiation_tips(&negotiation_restrict,
     ++					     &transport->smart_options->negotiation_restrict_tips);
     + 		else {
     + 			struct strbuf config_name = STRBUF_INIT;
     + 			strbuf_addf(&config_name, "remote.%s.negotiationRestrict", remote->name);
      @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remote, int deepen,
       			strbuf_release(&config_name);
       		}
       	}
      +	if (negotiation_include.nr) {
      +		if (transport->smart_options)
     -+			transport->smart_options->negotiation_include = &negotiation_include;
     ++			add_negotiation_tips(&negotiation_include,
     ++					     &transport->smart_options->negotiation_include_tips);
      +		else
      +			warning(_("ignoring %s because the protocol does not support it"),
      +				"--negotiation-include");
     @@ builtin/fetch.c: int cmd_fetch(int argc,
      
       ## builtin/pull.c ##
      @@ builtin/pull.c: int cmd_pull(int argc,
     - 		OPT_PASSTHRU_ARGV(0, "negotiation-restrict", &opt_fetch, N_("revision"),
       			N_("report that we have only objects reachable from this object"),
       			0),
     + 		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
      +		OPT_PASSTHRU_ARGV(0, "negotiation-include", &opt_fetch, N_("revision"),
      +			N_("ensure this ref is always sent as a negotiation have"),
      +			0),
     @@ fetch-pack.c: static void send_filter(struct fetch_pack_args *args,
       	}
       }
       
     -+static int add_oid_to_oidset(const struct reference *ref, void *cb_data)
     ++static void add_oids_to_set(const struct oid_array *array,
     ++			    struct oidset *set)
      +{
     -+	struct oidset *set = cb_data;
     -+	if (!odb_has_object(the_repository->objects, ref->oid, 0))
     -+		die(_("the object %s does not exist"), oid_to_hex(ref->oid));
     -+	oidset_insert(set, ref->oid);
     -+	return 0;
     -+}
     -+
     -+static void resolve_negotiation_include(const struct string_list *negotiation_include,
     -+					struct oidset *result)
     -+{
     -+	struct string_list_item *item;
     -+
     -+	if (!negotiation_include || !negotiation_include->nr)
     ++	if (!array)
      +		return;
      +
     -+	for_each_string_list_item(item, negotiation_include) {
     -+		if (!has_glob_specials(item->string)) {
     -+			struct object_id oid;
     ++	for (size_t i = 0; i < array->nr; i++) {
     ++		struct object_id *oid = &array->oid[i];
     ++		if (!odb_has_object(the_repository->objects, oid, 0))
     ++			die(_("the object %s does not exist"), oid_to_hex(oid));
      +
     -+			/* Ignore missing reference. */
     -+			if (repo_get_oid(the_repository, item->string, &oid))
     -+				continue;
     -+
     -+			/* Fail on missing object pointed by ref. */
     -+			if (!odb_has_object(the_repository->objects, &oid, 0))
     -+				die(_("the object %s does not exist"),
     -+				    item->string);
     -+
     -+			oidset_insert(result, &oid);
     -+		} else {
     -+			struct refs_for_each_ref_options opts = {
     -+				.pattern = item->string,
     -+			};
     -+			refs_for_each_ref_ext(
     -+				get_main_ref_store(the_repository),
     -+				add_oid_to_oidset, result, &opts);
     -+		}
     ++		oidset_insert(set, oid);
      +	}
      +}
      +
     @@ fetch-pack.c: static int find_common(struct fetch_negotiator *negotiator,
       	retval = -1;
      +
      +	/* Send unconditional haves from --negotiation-include */
     -+	resolve_negotiation_include(args->negotiation_include,
     -+				    &negotiation_include_oids);
     ++	add_oids_to_set(args->negotiation_include_tips,
     ++			&negotiation_include_oids);
      +	if (oidset_size(&negotiation_include_oids)) {
      +		struct oidset_iter iter;
      +		oidset_iter_init(&negotiation_include_oids, &iter);
     @@ fetch-pack.c: static int find_common(struct fetch_negotiator *negotiator,
      +			print_verbose(args, "have %s", oid_to_hex(oid));
      +			count++;
      +
     -+			/*
     -+			 * If this is a commit, then mark as COMMON to
     -+			 * avoid the negotiator also outputting it as
     -+			 * a have.
     -+			 */
      +			commit = lookup_commit(the_repository, oid);
     -+			if (commit &&
     -+			    !repo_parse_commit(the_repository, commit))
     -+				commit->object.flags |= COMMON;
     ++			if (commit)
     ++				negotiator->have_sent(negotiator, commit);
      +		}
      +	}
      +
     @@ fetch-pack.c: static void add_common(struct strbuf *req_buf, struct oidset *comm
      +		struct oidset_iter iter;
      +		oidset_iter_init(negotiation_include_oids, &iter);
      +
     -+		while ((oid = oidset_iter_next(&iter)))
     -+			packet_buf_write(req_buf, "have %s\n",
     -+					 oid_to_hex(oid));
     ++		while ((oid = oidset_iter_next(&iter))) {
     ++			struct commit *commit = lookup_commit(the_repository, oid);
     ++			if (commit) {
     ++				packet_buf_write(req_buf, "have %s\n",
     ++						 oid_to_hex(oid));
     ++				negotiator->have_sent(negotiator, commit);
     ++			}
     ++		}
      +	}
      +
       	while ((oid = negotiator->next(negotiator))) {
     -+		if (negotiation_include_oids &&
     -+		    oidset_contains(negotiation_include_oids, oid))
     -+			continue;
       		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
       		if (++haves_added >= *haves_to_send)
     - 			break;
      @@ fetch-pack.c: static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
       			      struct fetch_pack_args *args,
       			      const struct ref *wants, struct oidset *common,
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
       				state = FETCH_SEND_REQUEST;
       
       			mark_tips(negotiator, args->negotiation_restrict_tips);
     -+			resolve_negotiation_include(args->negotiation_include,
     -+						    &negotiation_include_oids);
     ++			add_oids_to_set(args->negotiation_include_tips,
     ++					&negotiation_include_oids);
       			for_each_cached_alternate(negotiator,
       						  insert_one_alternate_object);
       			break;
     @@ fetch-pack.c: void negotiate_using_fetch(const struct oid_array *negotiation_res
       			   int fd[],
      -			   struct oidset *acked_commits)
      +			   struct oidset *acked_commits,
     -+			   const struct string_list *negotiation_include)
     ++			   const struct oid_array *negotiation_include_tips)
       {
       	struct fetch_negotiator negotiator;
       	struct packet_reader reader;
     @@ fetch-pack.c: void negotiate_using_fetch(const struct oid_array *negotiation_res
       	fetch_negotiator_init(the_repository, &negotiator);
       	mark_tips(&negotiator, negotiation_restrict_tips);
       
     -+	resolve_negotiation_include(negotiation_include,
     -+				    &negotiation_include_oids);
     ++	add_oids_to_set(negotiation_include_tips,
     ++			&negotiation_include_oids);
      +
       	packet_reader_init(&reader, fd[0], NULL, 0,
       			   PACKET_READ_CHOMP_NEWLINE |
     @@ fetch-pack.c: void negotiate_using_fetch(const struct oid_array *negotiation_res
      
       ## fetch-pack.h ##
      @@ fetch-pack.h: struct fetch_pack_args {
     + 
     + 	/*
     + 	 * If not NULL, during packfile negotiation, fetch-pack will send "have"
     +-	 * lines only with these tips and their ancestors.
     ++	 * lines for all _include_ tips and then a subset of the _restrict_ tips.
       	 */
       	const struct oid_array *negotiation_restrict_tips;
     ++	const struct oid_array *negotiation_include_tips;
       
     -+	/*
     -+	 * If non-empty, ref patterns whose tips should always be sent
     -+	 * as "have" lines during negotiation, regardless of what the
     -+	 * negotiation algorithm selects.
     -+	 */
     -+	const struct string_list *negotiation_include;
     -+
       	unsigned deepen_relative:1;
       	unsigned quiet:1;
     - 	unsigned keep_pack:1;
      @@ fetch-pack.h: void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
       			   const struct string_list *server_options,
       			   int stateless_rpc,
       			   int fd[],
      -			   struct oidset *acked_commits);
      +			   struct oidset *acked_commits,
     -+			   const struct string_list *negotiation_include);
     ++			   const struct oid_array *negotiation_include_tips);
       
       /*
        * Print an appropriate error message for each sought ref that wasn't
      
       ## t/t5510-fetch.sh ##
     +@@ t/t5510-fetch.sh: EOF
     + 	test_cmp fatal-expect fatal-actual
     + '
     + 
     ++test_expect_success '--negotiation-tip ignores missing refs and invalid hashes' '
     ++	setup_negotiation_tip server server 0 &&
     ++	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
     ++		--negotiation-tip=alpha_1 --negotiation-tip=beta_1 \
     ++		--negotiation-tip=no-such-ref \
     ++		--negotiation-tip=invalid-hash \
     ++		origin alpha_s beta_s &&
     ++	check_negotiation_tip
     ++'
     ++
     + test_expect_success '--negotiation-restrict limits "have" lines sent' '
     + 	setup_negotiation_tip server server 0 &&
     + 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
      @@ t/t5510-fetch.sh: test_expect_success 'CLI --negotiation-restrict overrides remote config' '
       	test_grep ! "fetch> have $BETA_1" trace
       '
     @@ t/t5510-fetch.sh: test_expect_success 'CLI --negotiation-restrict overrides remo
      +	test_grep "fetch> have $ALPHA_1" trace >matches &&
      +	test_line_count = 1 matches
      +'
     ++
     ++test_expect_success '--negotiation-include avoids duplicates with v0' '
     ++	test_when_finished rm -f trace &&
     ++	setup_negotiation_tip server server 0 &&
     ++
     ++	ALPHA_1=$(git -C client rev-parse alpha_1) &&
     ++	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
     ++		-c protocol.version=0 fetch \
     ++		--negotiation-restrict=alpha_1 \
     ++		--negotiation-include=refs/tags/alpha_1 \
     ++		origin alpha_s beta_s &&
     ++
     ++	test_grep "fetch> have $ALPHA_1" trace >matches &&
     ++	test_line_count = 1 matches
     ++'
      +
       test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
       	git init df-conflict &&
     @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
       	args.stateless_rpc = transport->stateless_rpc;
       	args.server_options = transport->server_options;
       	args.negotiation_restrict_tips = data->options.negotiation_restrict_tips;
     -+	args.negotiation_include = data->options.negotiation_include;
     ++	args.negotiation_include_tips = data->options.negotiation_include_tips;
       	args.reject_shallow_remote = transport->smart_options->reject_shallow;
       
       	if (!data->finished_handshake) {
     @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
       					      data->fd,
      -					      data->options.acked_commits);
      +					      data->options.acked_commits,
     -+					      data->options.negotiation_include);
     ++					      data->options.negotiation_include_tips);
       			ret = 0;
       		}
       		goto cleanup;
     +@@ transport.c: static int disconnect_git(struct transport *transport)
     + 		oid_array_clear(data->options.negotiation_restrict_tips);
     + 		free(data->options.negotiation_restrict_tips);
     + 	}
     ++	if (data->options.negotiation_include_tips) {
     ++		oid_array_clear(data->options.negotiation_include_tips);
     ++		free(data->options.negotiation_include_tips);
     ++	}
     + 	list_objects_filter_release(&data->options.filter_options);
     + 	oid_array_clear(&data->extra_have);
     + 	oid_array_clear(&data->shallow);
      
       ## transport.h ##
      @@ transport.h: struct git_transport_options {
     + 
     + 	/*
     + 	 * This is only used during fetch. See the documentation of
     +-	 * negotiation_restrict_tips in struct fetch_pack_args.
     ++	 * these member names in struct fetch_pack_args.
     + 	 *
     +-	 * This field is only supported by transports that support connect or
     ++	 * These fields are only supported by transports that support connect or
     + 	 * stateless_connect. Set this field directly instead of using
     + 	 * transport_set_option().
       	 */
       	struct oid_array *negotiation_restrict_tips;
     ++	struct oid_array *negotiation_include_tips;
       
     -+	/*
     -+	 * If non-empty, ref patterns whose tips should always be sent
     -+	 * as "have" lines during negotiation.
     -+	 */
     -+	const struct string_list *negotiation_include;
     -+
       	/*
       	 * If allocated, whenever transport_fetch_refs() is called, add known
     - 	 * common commits to this oidset instead of fetching any packfiles.
 6:  a2d15fa12a ! 7:  7bd70a970b remote: add remote.*.negotiationInclude config
     @@ Documentation/config/remote.adoc: values are not used.
       the list from broader config scenarios.
       
      +remote.<name>.negotiationInclude::
     -+	When negotiating with this remote during `git fetch` and `git push`,
     -+	the client advertises a list of commits that exist locally.  In
     -+	repos with many references, this list of "haves" can be truncated.
     -+	Depending on data shape, dropping certain references may be
     -+	expensive.  This multi-valued config option specifies ref patterns
     -+	whose tips should always be sent as "have" commits during fetch
     -+	negotiation with this remote.
     ++	When negotiating with this remote during `git fetch`, the client
     ++	advertises a list of commits that exist locally.  In repos with
     ++	many references, this list of "haves" can be truncated. Depending
     ++	on data shape, dropping certain references may be expensive. This
     ++	multi-valued config option specifies references, commit hashes,
     ++	or ref pattern globs whose tips should always be sent as "have"
     ++	commits during fetch negotiation with this remote.
      ++
     -+Each value is either an exact ref name (e.g. `refs/heads/release`) or a
     -+glob pattern (e.g. `refs/heads/release/*`).  The pattern syntax is the same
     -+as for `--negotiation-restrict`.
     ++Each value is either an exact ref name (e.g. `refs/heads/release`), a
     ++commit hash, or a glob pattern (e.g. `refs/heads/release/*`).  The
     ++pattern syntax is the same as for `--negotiation-include`.
      ++
      +These config values are used as defaults for the `--negotiation-include`
      +command-line option.  If `--negotiation-include` is specified on the
     @@ Documentation/config/remote.adoc: values are not used.
       	when fetching using the configured refspecs of a remote.
      
       ## Documentation/fetch-options.adoc ##
     -@@ Documentation/fetch-options.adoc: is the same as for `--negotiation-restrict`.
     +@@ Documentation/fetch-options.adoc: The pattern syntax is the same as for `--negotiation-restrict`.
       If `--negotiation-restrict` is used, the have set is first restricted by
       that option and then increased to include the tips specified by
       `--negotiation-include`.
     @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remot
       				"--negotiation-include");
      +	} else if (remote->negotiation_include.nr) {
      +		if (transport->smart_options) {
     -+			transport->smart_options->negotiation_include = &remote->negotiation_include;
     ++			add_negotiation_tips(&remote->negotiation_include,
     ++					     &transport->smart_options->negotiation_include_tips);
      +		} else {
      +			struct strbuf config_name = STRBUF_INIT;
      +			strbuf_addf(&config_name, "remote.%s.negotiationInclude", remote->name);
     @@ remote.c: static void remote_clear(struct remote *remote)
       
       static void add_merge(struct branch *branch, const char *name)
      @@ remote.c: static int handle_config(const char *key, const char *value,
     - 			string_list_clear(&remote->negotiation_restrict, 0);
     - 		else
     - 			string_list_append(&remote->negotiation_restrict, value);
     + 	} else if (!strcmp(subkey, "negotiationrestrict")) {
     + 		return parse_transport_option(key, value,
     + 					      &remote->negotiation_restrict);
      +	} else if (!strcmp(subkey, "negotiationinclude")) {
     -+		/* reset list on empty value. */
     -+		if (!value || !*value)
     -+			string_list_clear(&remote->negotiation_include, 0);
     -+		else
     -+			string_list_append(&remote->negotiation_include, value);
     ++		return parse_transport_option(key, value,
     ++					      &remote->negotiation_include);
       	} else if (!strcmp(subkey, "followremotehead")) {
       		const char *no_warn_branch;
       		if (!strcmp(value, "never"))
     @@ t/t5510-fetch.sh: test_expect_success '--negotiation-include avoids duplicates w
      +	git -C client config --add remote.origin.negotiationInclude "" &&
      +	git -C client config --add remote.origin.negotiationInclude refs/tags/beta_1 &&
      +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
     -+		--negotiation-restrict=alpha_1 \
     ++		--negotiation-restrict=beta_2 \
      +		origin alpha_s beta_s &&
      +
      +	ALPHA_1=$(git -C client rev-parse alpha_1) &&
     -+	test_grep "fetch> have $ALPHA_1" trace &&
     ++	test_grep ! "fetch> have $ALPHA_1" trace &&
      +	BETA_1=$(git -C client rev-parse beta_1) &&
      +	test_grep "fetch> have $BETA_1" trace
      +'
     @@ t/t5510-fetch.sh: test_expect_success '--negotiation-include avoids duplicates w
      +	test_grep ! "fetch> have $BETA_2" trace
      +'
      +
     - test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
     - 	git init df-conflict &&
     - 	(
     + test_expect_success '--negotiation-include avoids duplicates with v0' '
     + 	test_when_finished rm -f trace &&
     + 	setup_negotiation_tip server server 0 &&
 7:  e6c79f0661 ! 8:  5b968245eb send-pack: pass negotiation config in push
     @@ Commit message
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     + ## Documentation/config/remote.adoc ##
     +@@ Documentation/config/remote.adoc: command-line option.  If `--negotiation-restrict` (or its synonym
     + `--negotiation-tip`) is specified on the command line, then the config
     + values are not used.
     + +
     ++These values also influence negotiation during `git push` if
     ++`push.negotiate` is enabled.
     +++
     + Blank values signal to ignore all previous values, allowing a reset of
     + the list from broader config scenarios.
     + 
     +@@ Documentation/config/remote.adoc: unconditionally on top of those heuristically selected commits.  This
     + option is also used during push negotiation when `push.negotiate` is
     + enabled.
     + +
     ++These values also influence negotiation during `git push` if
     ++`push.negotiate` is enabled.
     +++
     + Blank values signal to ignore all previous values, allowing a reset of
     + the list from broader config scenarios.
     + 
     +
       ## send-pack.c ##
      @@ send-pack.c: static void reject_invalid_nonce(const char *nonce, int len)
       
     @@ send-pack.c: static void reject_invalid_nonce(const char *nonce, int len)
       	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
      -	for (ref = remote_refs; ref; ref = ref->next) {
      -		if (!is_null_oid(&ref->new_oid)) {
     --			strvec_pushf(&child.args, "--negotiation-tip=%s",
     --				     oid_to_hex(&ref->new_oid));
     --			nr_negotiation_tip++;
      +
      +	if (negotiation_restrict && negotiation_restrict->nr) {
      +		struct string_list_item *item;
      +		for_each_string_list_item(item, negotiation_restrict)
     -+			strvec_pushf(&child.args, "--negotiation-restrict=%s",
     + 			strvec_pushf(&child.args, "--negotiation-restrict=%s",
     +-				     oid_to_hex(&ref->new_oid));
     +-			nr_negotiation_tip++;
      +				     item->string);
      +		nr_negotiation = negotiation_restrict->nr;
      +	} else {

-- 
gitgitgadget
