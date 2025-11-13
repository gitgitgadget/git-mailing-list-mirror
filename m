Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5594D76026
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063931; cv=none; b=tIcFRERwv4tyKLxO0tgEttRrEFjSE1kRdo99z8W06zeaEev+2fPLdtOwF6b0tiCXF18J26eETYGch1aIneKnzTcVh6CcMKzi0O5F2ivqj52VFfAcjBjxnody0yEUhLgl2GeWljK8XUo20702mRNsxpnIP/AXWS6gNcrU53Ammd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063931; c=relaxed/simple;
	bh=FetKzbWiP1QBgnTM/R758RWl0tzQj6i79iBVRYStjJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XbNWcolxG/0SkutU8smLuoopozdWP5raJz8xUypoIHUibs5+wNAiyyEb0edBMmmbXBkNwAxon+1htMymgsLncQAAg17c46vHZrd8FOyE/yMhBEtNIDiHmpbOEuBH19O+Pblezb1b4Be64307rIOQWFrX2ME1F7YWFsZ3nVprvyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I2qU3JtC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mopFpRQA; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I2qU3JtC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mopFpRQA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 579CFEC0214;
	Thu, 13 Nov 2025 14:58:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 13 Nov 2025 14:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763063927; x=1763150327; bh=4hzi/aOrpk
	m69DtLHAiishcKJU2ph2GM+GbRuipR4Do=; b=I2qU3JtCJhR4My1iuvV/LcGZeP
	emnzMZ6a1t0GRQKhIt0d294rfK3KbZ5zoMbfv9Tu5FxwedrtuI5utzzARF6tiff7
	yhB74dkKraP6v1YbX13vDHn8u/hkjGcKF7N56H3wm6JIedAQZ8ucetMWm5bZlFAu
	hKNn70RJEwVEjte8exInrOlO511+gxwp8BVgHCLm55j1E0Y3uLcvLBTIEnGszSuA
	b7qQu9nBWbK6bKth0vXygAnGLWWUvkmQtl2FWF38+3Ogczh9M5u2GQv8e4YQrr3K
	6wnwYbH3AlqCZX/oPOoFZSsCRAlyQVtrBcDAppMWIKk+fWF0BrMHX29cJ2JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763063927; x=1763150327; bh=4hzi/aOrpkm69DtLHAiishcKJU2ph2GM+Gb
	RuipR4Do=; b=mopFpRQAv4v6OhJcd/xOUXCA9O4rPeQcypeNqX/HES5V011YJL7
	79H6qu/tqL6+McIBrHem40J//EcOL4nrMZnYjX6S5lJ2J0uo0bUD6BXiUkgKLHw2
	uKBodca5EELU81uGf8nwAZ80BZ+irKI2hQLG4Iiiu8DINuNmcQKyFy7U7KLpvazZ
	UTzvziDzjL0NYYH6Y2xwRkUa9LXbwv8JBTOmDVjGK5aq2MSW7WMf63AmGEGaGV+U
	PHtz3y8kcy0tKOzug/M9oXCPr6nQSXUqN/AMJ0ZUDEzcdOf07baGP2uELr3r00p6
	tkWfLeQWueI09Me9uknP6cvrkMeBf5jWSkg==
X-ME-Sender: <xms:djgWaXYZ-H-k_REfH5jFG28o712_rIWW6jIdDO8v1UpMANRqonWwUg>
    <xme:djgWadTBd0s7S0fz6v_dJvv7Hex4yzM0mwDyWrOumBk6pkk6ggMy4srj54JSUok8Q
    boviDnp4S1WMJzgfpiRO7Bs3HB9NeVe9dufSYoWDLuoJtqRw0T2NB0>
X-ME-Received: <xmr:djgWaSSSpOTseBI7LKJnPax8nGparL4zP5wa103V2g3vGnBa_FrID2d5y54qFbbaIgKaEZNurHZ2xCxYOXXzziKYZQLN6dfs3Wlt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomhdprhgtphhtthhopegtlhgruhhsrdhstghhnhgvihguvghrsegv
    fhhitghouggvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dzgWaZS7L6zhl7ofmE17FW49quV-oCfZps2nIk8KHuD_qx8KdkIBUA>
    <xmx:dzgWaf6SX6xKXPv6TfXeZCwFOeYy7mB6ZVCB8raPCaZ013nv5o3T5w>
    <xmx:dzgWad0j5gzIk_QkAMjoDSk1zTzMeAUz7odMR2KbwTIMu2-aROkAdA>
    <xmx:dzgWaSAbK06G5bGKOSt1Sl0xFMlYMCSr6f52hV1my3B_x7HTFcujUQ>
    <xmx:dzgWaZnAlkQ06sJhC5XGnixNjsfFFr3GZUIxIFd9EMkFrcESQBxDaVLw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 14:58:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Claus Schneider via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
    Phillip Wood <phillip.wood123@gmail.com>,
    Claus Schneider <claus.schneider@eficode.com>
Subject: Re: [PATCH v2 0/5] git-add : Respect submodule ignore=all and only
 add changes with --force
In-Reply-To: <pull.1987.v2.git.1763057433.gitgitgadget@gmail.com> (Claus
	Schneider via GitGitGadget's message of "Thu, 13 Nov 2025 18:10:28
	+0000")
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
	<pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
Date: Thu, 13 Nov 2025 11:58:45 -0800
Message-ID: <xmqqzf8pln62.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Claus Schneider via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The feature of configuring a submodule to "ignore=all" is nicely respected
> in commands "status" and "diff".

"nicely respected" is not very informative for those who do not know
what the setting does.  Saying something like

    "git status" and "git diff" will not report modified submodules
    with submodule.<name>.ignore set to "all".

would not waste significantly more bytes than what you wrote, and is
more helpful.

> However the "add" command does not respect
> the configuration the same way.

Again, "does not respect" and then what?  Running "git add" on a
submodule with submodule.<name>.ignore set to "all" does what?
Complains that it has changes but because .ignore is set it won't
add?  Adds it silently?  Something else?

> The behavior is problematic for the logic
> between status/diff and add.

After this sentence, "because ..." is missing.  Please help readers
understand the issue you perceive as problematic more easily.

I am guessing that you are assuming that an "add", after "diff" or
"status" said there is no change, is expected to be a no-op, but I
cannot be sure if that is what you are referring to here with the
reason left unsaid like the above.

> Secondly it makes it problematic to track
> branches in the submodule configuration as developers unintentionally keeps
> add submodule updates and get conflicts for no intentional reason. Both adds
> unnecessary friction to the usage of submodules.
>
> The patches implement the same logical behavior for ignore=all submodules as
> regular ignored files. The status now does not show any diff - nor will the
> add command update the reference submodule reference. If you add the
> submodule path which is ignore=all then you are presented with a message
> that you need to use the --force option.

I vaguely recall that an earlier discussion between you and Phillip
were concluding against "--force"?  I personally feel it is in line
with "git add foo.o" (when '*.o' is in .gitignore) gets rejected and
"git add -f foo.o" is a way to override it, but in the list of
patches below, I see --include-ignored-submodules (no, our command
line option names do not use underscore for inter-word-gaps), so I
suspect the description in the cover letter around here is stale?


> The branch=, ignore=all (and
> update=none) now works great with update --remote,

Again, "great" is not very informative, and as bad as "nicely
respected".  Avoid using these adjectives loaded with unnecessary
value judgements, and instead trust your readers.  They are
intelligent to judge if the updated behaviour is great or not for
themselves.  Try to use the same bytes on helping readers understand
what actually happens.

> but developers does not

"do not".

> have to consider changes in the updates of the submodule sha1. The
> implementation removes a friction of working with submodules and can be used
> like the repo tool with branches configured. The submodule status report
> could be used for build/release documentation for reproduction of a setup.
>
> A few tests used the adding of submodules without --force, hence they have
> been updated to use the --force option.
>
> Claus Schneider(Eficode) (5):
>   read-cache: update add_files_to_cache take param
>     include_ignored_submodules
>   read-cache: add/read-cache respect submodule ignore=all
>   tests: add new t2206-add-submodule-ignored.sh to test ignore=all
>     scenario
>   tests: fix existing tests when add an ignore=all submodule
>   Documentation: add --include_ignored_submodules + ignore=all config
>
>  .devcontainer/Dockerfile            |  70 +++++++++++++++
>  .devcontainer/Dockerfile.standalone |  76 ++++++++++++++++
>  .devcontainer/devcontainer.json     |  25 ++++++
>  Documentation/config/submodule.adoc |  13 +--
>  Documentation/git-add.adoc          |   5 ++
>  Documentation/gitmodules.adoc       |   5 +-
>  builtin/add.c                       |   4 +-
>  builtin/checkout.c                  |   2 +-
>  builtin/commit.c                    |   2 +-
>  read-cache-ll.h                     |   2 +-
>  read-cache.c                        |  54 ++++++++++-
>  t/lib-submodule-update.sh           |   6 +-
>  t/meson.build                       |   1 +
>  t/t2206-add-submodule-ignored.sh    | 134 ++++++++++++++++++++++++++++
>  t/t7508-status.sh                   |   2 +-
>  15 files changed, 384 insertions(+), 17 deletions(-)
>  create mode 100644 .devcontainer/Dockerfile
>  create mode 100644 .devcontainer/Dockerfile.standalone
>  create mode 100644 .devcontainer/devcontainer.json
>  create mode 100755 t/t2206-add-submodule-ignored.sh
>
>
> base-commit: 81f86aacc4eb74cdb9c2c8082d36d2070c666045
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1987%2FPraqma%2Frespect-submodule-ignore-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1987/Praqma/respect-submodule-ignore-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1987
>
> Range-diff vs v1:
>
>  1:  d98cca698d ! 1:  5796009122 read-cache: update add_files_to_cache to take param ignored_too(--force)
>      @@ Metadata
>       Author: Claus Schneider(Eficode) <claus.schneider@eficode.com>
>       
>        ## Commit message ##
>      -    read-cache: update add_files_to_cache to take param ignored_too(--force)
>      +    read-cache: update add_files_to_cache take param include_ignored_submodules
>       
>      -    The ignored_too parameter is added to the function add_files_to_cache for
>      -    usage of explicit updating the index for the updated submodule using the
>      -    explicit patchspec to the submodule.
>      +    The include_ignored_submodules parameter is added to the function
>      +    add_files_to_cache for usage of explicit updating the index for the updated
>      +    submodule using the explicit patchspec to the submodule.
>       
>           Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
>       
>        ## builtin/add.c ##
>      +@@ builtin/add.c: N_("The following paths are ignored by one of your .gitignore files:\n");
>      + static int verbose, show_only, ignored_too, refresh_only;
>      + static int ignore_add_errors, intent_to_add, ignore_missing;
>      + static int warn_on_embedded_repo = 1;
>      ++static int include_ignored_submodules;
>      + 
>      + #define ADDREMOVE_DEFAULT 1
>      + static int addremove = ADDREMOVE_DEFAULT;
>      +@@ builtin/add.c: static struct option builtin_add_options[] = {
>      + 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
>      + 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
>      + 	OPT_BOOL(0, "sparse", &include_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
>      ++    OPT_BOOL(0, "include-ignored-submodules", &include_ignored_submodules, N_("add submodules even if they has configuration ignore=all")),
>      + 	OPT_STRING(0, "chmod", &chmod_arg, "(+|-)x",
>      + 		   N_("override the executable bit of the listed files")),
>      + 	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
>       @@ builtin/add.c: int cmd_add(int argc,
>        	else
>        		exit_status |= add_files_to_cache(repo, prefix,
>        						  &pathspec, ps_matched,
>       -						  include_sparse, flags);
>      -+						  include_sparse, flags, ignored_too);
>      ++						  include_sparse, flags, include_ignored_submodules);
>        
>        	if (take_worktree_changes && !add_renormalize && !ignore_add_errors &&
>        	    report_path_error(ps_matched, &pathspec))
>      @@ read-cache.c: void overlay_tree_on_index(struct index_state *istate,
>        	int include_sparse;
>        	int flags;
>        	int add_errors;
>      -+	int ignored_too;
>      ++	int include_ignored_submodules;
>        };
>        
>        static int fix_unmerged_status(struct diff_filepair *p,
>       @@ read-cache.c: static void update_callback(struct diff_queue_struct *q,
>      + 		default:
>      + 			die(_("unexpected diff status %c"), p->status);
>      + 		case DIFF_STATUS_MODIFIED:
>      +-		case DIFF_STATUS_TYPE_CHANGED:
>      ++		case DIFF_STATUS_TYPE_CHANGED: {
>      ++			struct stat st;
>      ++			if (!lstat(path, &st) && S_ISDIR(st.st_mode)) { // only consider submodule if it is a directory
>      ++				const struct submodule *sub = submodule_from_path(data->repo, null_oid(the_hash_algo), path);
>      ++				if (sub && sub->name && sub->ignore && !strcmp(sub->ignore, "all")) {
>      ++					int pathspec_matches = 0;
>      ++					char *norm_pathspec = NULL;
>      ++					int ps_i;
>      ++					trace_printf("ignore=all %s\n", path);
>      ++					trace_printf("pathspec %s\n",
>      ++							(data->pathspec && data->pathspec->nr) ? "has pathspec" : "no pathspec");
>      ++					/* Safely scan all pathspec items (q->nr may exceed pathspec->nr). */
>      ++					if (data->pathspec) {
>      ++						for (ps_i = 0; ps_i < data->pathspec->nr; ps_i++) {
>      ++							const char *m = data->pathspec->items[ps_i].match;
>      ++							if (!m)
>      ++								continue;
>      ++							norm_pathspec = xstrdup(m);
>      ++							strip_dir_trailing_slashes(norm_pathspec);
>      ++							if (!strcmp(path, norm_pathspec)) {
>      ++								pathspec_matches = 1;
>      ++								FREE_AND_NULL(norm_pathspec);
>      ++								break;
>      ++							}
>      ++							FREE_AND_NULL(norm_pathspec);
>      ++						}
>      ++					}
>      ++					if (pathspec_matches) {
>      ++						if (data->include_ignored_submodules && data->include_ignored_submodules > 0) {
>      ++							trace_printf("Add ignored=all submodule due to --include_ignored_submodules: %s\n", path);
>      ++						} else {
>      ++							printf(_("Skipping submodule due to ignore=all: %s"), path);
>      ++							printf(_("Use --include_ignored_submodules, if you really want to add them.") );
>      ++							continue;
>      ++						}
>      ++					} else {
>      ++						/* No explicit pathspec match -> skip silently (or with trace). */
>      ++						trace_printf("pathspec does not match %s\n", path);
>      ++						continue;
>      ++					}
>      ++				}
>      ++			}
>      + 			if (add_file_to_index(data->index, path, data->flags)) {
>      + 				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
>      + 					die(_("updating files failed"));
>      +@@ read-cache.c: static void update_callback(struct diff_queue_struct *q,
>        
>        int add_files_to_cache(struct repository *repo, const char *prefix,
>        		       const struct pathspec *pathspec, char *ps_matched,
>       -		       int include_sparse, int flags)
>      -+		       int include_sparse, int flags, int ignored_too )
>      ++		       int include_sparse, int flags, int include_ignored_submodules )
>        {
>        	struct update_callback_data data;
>        	struct rev_info rev;
>      @@ read-cache.c: int add_files_to_cache(struct repository *repo, const char *prefix
>        	data.include_sparse = include_sparse;
>        	data.flags = flags;
>       +	data.repo = repo;
>      -+	data.ignored_too = ignored_too;
>      ++	data.include_ignored_submodules = include_ignored_submodules;
>       +	data.pathspec = (struct pathspec *)pathspec;
>        
>        	repo_init_revisions(repo, &rev, prefix);
>  2:  d1b02617e6 ! 2:  9ec79b9a11 read-cache: let read-cache respect submodule ignore=all and --force
>      @@ Metadata
>       Author: Claus Schneider(Eficode) <claus.schneider@eficode.com>
>       
>        ## Commit message ##
>      -    read-cache: let read-cache respect submodule ignore=all and --force
>      +    read-cache: add/read-cache respect submodule ignore=all
>       
>      -    Given the submdule configuration is ignore=all then only update the
>      -    submdule if the --force option is given and the submodule is explicit
>      -    given in the pathspec.
>      +    Submodules configured with ignore=all are now skipped during add operations
>      +    unless overridden by --include-ignored-submodules and the submodule path is
>      +    explicitly specified.
>       
>           A message is printed (like ignored files) guiding the user to use the
>      -    --force flag if the user has explicitely want to update the submodule
>      -    reference.
>      +    --include-ignored-submodules flag if the user has explicitely want to update
>      +    the submodule reference.
>       
>           The reason for the change is support submodule branch tracking or
>           similar and git status state nothing and git add should not add either.
>      @@ Commit message
>           the submodule is already tracked.
>       
>           The change opens up a lot of possibilities for submodules to be used
>      -    more freely and a like the repo tool. A submodule can be added for many
>      +    more freely and simular to the repo tool. A submodule can be added for many
>           more reason and loosely coupled dependencies to the super repo which often
>           gives the friction of handle the explicit commits and updates without
>           the need for tracking the submodule sha1 by sha1.
>      @@ read-cache.c
>        /* Mask for the name length in ce_flags in the on-disk index */
>        
>       @@ read-cache.c: static void update_callback(struct diff_queue_struct *q,
>      - 		default:
>      - 			die(_("unexpected diff status %c"), p->status);
>      - 		case DIFF_STATUS_MODIFIED:
>      --		case DIFF_STATUS_TYPE_CHANGED:
>      -+		case DIFF_STATUS_TYPE_CHANGED: {
>      -+			struct stat st;
>      -+			if (!lstat(path, &st) && S_ISDIR(st.st_mode)) { // only consider submodule if it is a directory
>      -+				const struct submodule *sub = submodule_from_path(data->repo, null_oid(the_hash_algo), path);
>      -+				if (sub && sub->name && sub->ignore && !strcmp(sub->ignore, "all")) {
>      -+					int pathspec_matches = 0;
>      -+					char *norm_pathspec = NULL;
>      -+					int ps_i;
>      -+					trace_printf("ignore=all %s\n", path);
>      -+					trace_printf("pathspec %s\n",
>      -+							(data->pathspec && data->pathspec->nr) ? "has pathspec" : "no pathspec");
>      -+					/* Safely scan all pathspec items (q->nr may exceed pathspec->nr). */
>      -+					if (data->pathspec) {
>      -+						for (ps_i = 0; ps_i < data->pathspec->nr; ps_i++) {
>      -+							const char *m = data->pathspec->items[ps_i].match;
>      -+							if (!m)
>      -+								continue;
>      -+							norm_pathspec = xstrdup(m);
>      -+							strip_dir_trailing_slashes(norm_pathspec);
>      -+							if (!strcmp(path, norm_pathspec)) {
>      -+								pathspec_matches = 1;
>      -+								FREE_AND_NULL(norm_pathspec);
>      -+								break;
>      -+							}
>      -+							FREE_AND_NULL(norm_pathspec);
>      -+						}
>      -+					}
>      -+					if (pathspec_matches) {
>      -+						if (data->ignored_too && data->ignored_too > 0) {
>      -+							trace_printf("Forcing add of submodule ignored=all due to --force: %s\n", path);
>      -+						} else {
>      -+							printf(_("Skipping submodule due to ignore=all: %s"), path);
>      -+							printf(_("Use -f if you really want to add them.") );
>      -+							continue;
>      -+						}
>      -+					} else {
>      -+						/* No explicit pathspec match -> skip silently (or with trace). */
>      -+						trace_printf("pathspec does not match %s\n", path);
>      -+						continue;
>      -+					}
>      -+				}
>      -+			}
>      - 			if (add_file_to_index(data->index, path, data->flags)) {
>      - 				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
>      - 					die(_("updating files failed"));
>      + 					}
>      + 					if (pathspec_matches) {
>      + 						if (data->include_ignored_submodules && data->include_ignored_submodules > 0) {
>      +-							trace_printf("Add ignored=all submodule due to --include_ignored_submodules: %s\n", path);
>      ++							trace_printf("Add submodule due to --include_ignored_submodules: %s\n", path);
>      + 						} else {
>      + 							printf(_("Skipping submodule due to ignore=all: %s"), path);
>      + 							printf(_("Use --include_ignored_submodules, if you really want to add them.") );
>      +@@ read-cache.c: static void update_callback(struct diff_queue_struct *q,
>      + 						}
>      + 					} else {
>      + 						/* No explicit pathspec match -> skip silently (or with trace). */
>      +-						trace_printf("pathspec does not match %s\n", path);
>      ++						trace_printf("Pathspec to submodule does not match explicitly: %s\n", path);
>      + 						continue;
>      + 					}
>      + 				}
>      +@@ read-cache.c: static void update_callback(struct diff_queue_struct *q,
>        				data->add_errors++;
>        			}
>        			break;
>  3:  8f3d5f7ec1 ! 3:  399a153b95 tests: add new t2206-add-submodule-ignored.sh to test ignore=all scenario
>      @@ Commit message
>           config with ignore=all also behaves as intended with configuration in
>           .gitmodules and configuration given on the command line.
>       
>      -    Testfile is added to meson.build for execution.
>      +    The usage of --include_ignored_submodules is showcased and tested in the
>      +    test suite.
>      +
>      +    The test file is added to meson.build for execution.
>       
>           Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
>       
>      @@ t/t2206-add-submodule-ignored.sh (new)
>       +# This test covers the behavior of "git add", "git status" and "git log" when
>       +# dealing with submodules that have the ignore=all setting in
>       +# .gitmodules. It ensures that changes in such submodules are
>      -+# ignored by default, but can be staged with "git add --force".
>      ++# ignored by default, but can be staged with "git add --include-ignored-submodules".
>       +
>       +# shellcheck disable=SC1091
>       +. ./test-lib.sh
>      @@ t/t2206-add-submodule-ignored.sh (new)
>       +'
>       +
>       +#6
>      -+# check that 'git add --force .' does not stage the change in the submodule
>      ++# check that 'git add --include-ignored-submodules .' does not stage the change in the submodule
>       +# and that 'git status' does not show it as modified
>      -+test_expect_success 'main: check --force add . and status'  '
>      ++test_expect_success 'main: check --include-ignored-submodules add . and status'  '
>       +	cd "${base_path}" &&
>       +	cd main &&
>      -+	GIT_TRACE=1 git add --force . &&
>      ++	GIT_TRACE=1 git add --include-ignored-submodules . &&
>       +	! git status --porcelain | grep "^M  sub$" &&
>       +	echo
>       +'
>      @@ t/t2206-add-submodule-ignored.sh (new)
>       +'
>       +
>       +#8
>      -+# check that 'git add --force sub' does stage the change in the submodule
>      -+# check that 'git add --force ./sub/' does stage the change in the submodule
>      ++# check that 'git add --include-ignored-submodules sub' does stage the change in the submodule
>      ++# check that 'git add --include-ignored-submodules ./sub/' does stage the change in the submodule
>       +# and that 'git status --porcelain' does show it as modified
>       +# commit it..
>       +# check that 'git log --ignore-submodules=none' shows the submodule change
>      @@ t/t2206-add-submodule-ignored.sh (new)
>       +test_expect_success 'main: check force add sub and ./sub/ and status'  '
>       +	cd "${base_path}" &&
>       +	cd main &&
>      -+	echo "Adding with --force should work: git add --force sub" &&
>      -+	GIT_TRACE=1 git add --force sub &&
>      ++	echo "Adding with --include-ignored-submodules should work: git add --include-ignored-submodules sub" &&
>      ++	GIT_TRACE=1 git add --include-ignored-submodules sub &&
>       +	git status --porcelain | grep "^M  sub$" &&
>       +	git restore --staged sub &&
>       +	! git status --porcelain | grep "^M  sub$" &&
>      -+	echo "Adding with --force should work: git add --force ./sub/" &&
>      -+	GIT_TRACE=1 git add --force ./sub/ &&
>      ++	echo "Adding with --include-ignored-submodules should work: git add --include-ignored-submodules ./sub/" &&
>      ++	GIT_TRACE=1 git add --include-ignored-submodules ./sub/ &&
>       +	git status --porcelain | grep "^M  sub$" &&
>       +	git commit -m "update submodule pointer" &&
>       +	! git status --porcelain | grep "^ M sub$" &&
>  4:  58563a7b90 ! 4:  93c95954f1 tests: fix existing tests when add an ignore=all submodule
>      @@ Metadata
>        ## Commit message ##
>           tests: fix existing tests when add an ignore=all submodule
>       
>      -    There are tests that rely on "git add <submodule>" also adds it. A --force
>      -    is needed with this enhancement hence they are added accordingly in these
>      -    tests.
>      +    There are tests that rely on "git add <submodule>" to add updates in the
>      +    parent repository. A new option --include-ignored-submodules is introduced
>      +    as it is now needed with this enhancement.
>       
>           Updated tests:
>           - t1013-read-tree-submodule.sh ( fixed in: t/lib-submodule-update.sh )
>      +    - t2013-checkout-submodule.sh ( fixed in: t/lib-submodule-update.sh )
>           - t7406-submodule-update.sh
>           - t7508-status.sh
>       
>      @@ t/lib-submodule-update.sh: create_lib_submodule_repo () {
>        			git push origin modifications
>        		) &&
>       -		git add sub1 &&
>      -+		git add --force sub1 &&
>      ++		git add --include-ignored-submodules sub1 &&
>        		git commit -m "Modify sub1" &&
>        
>        		git checkout -b add_nested_sub modify_sub1 &&
>      @@ t/lib-submodule-update.sh: create_lib_submodule_repo () {
>        		git -C sub1 submodule add --branch no_submodule ../submodule_update_sub2 sub2 &&
>        		git -C sub1 commit -a -m "add a nested submodule" &&
>       -		git add sub1 &&
>      -+		git add --force sub1 &&
>      ++		git add --include-ignored-submodules sub1 &&
>        		git commit -a -m "update submodule, that updates a nested submodule" &&
>        		git checkout -b modify_sub1_recursively &&
>        		git -C sub1 checkout -b modify_sub1_recursively &&
>      @@ t/lib-submodule-update.sh: create_lib_submodule_repo () {
>        		git -C sub1 add sub2 &&
>        		git -C sub1 commit -m "update nested sub" &&
>       -		git add sub1 &&
>      -+		git add --force sub1 &&
>      ++		git add --include-ignored-submodules sub1 &&
>        		git commit -m "update sub1, that updates nested sub" &&
>        		git -C sub1 push origin modify_sub1_recursively &&
>        		git -C sub1/sub2 push origin modify_sub1_recursively &&
>      @@ t/t7508-status.sh: test_expect_success 'git commit will commit a staged but igno
>        test_expect_success 'git commit --dry-run will show a staged but ignored submodule' '
>        	git reset HEAD^ &&
>       -	git add sm &&
>      -+	git add --force sm &&
>      ++	git add --include-ignored-submodules sm &&
>        	cat >expect << EOF &&
>        On branch main
>        Your branch and '\''upstream'\'' have diverged,
>  5:  416695f439 < -:  ---------- Documentation: update add --force and submodule ignore=all config
>  -:  ---------- > 5:  ee84190cd8 Documentation: add --include_ignored_submodules + ignore=all config
