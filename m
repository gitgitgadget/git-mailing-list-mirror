Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB95170A32
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508696; cv=none; b=KDLAVlDciUxpTvP4Rj8JXVYz+Z8VEgvou95hvvSFl3cRxgIEg4K7LLhune+qFuUItHl+yb7fjf4D7UdEU210POoG+nXkWDSw2rE6VXm1IDXWb3hynTlJWqgnCWbo6J3mZjHS2nuSOuLSVoxfcoAaBtB1PKcdt8XhqX2uS1FkDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508696; c=relaxed/simple;
	bh=nw7omNajcuDzLpFxZma+JzgZ2bLLm1HYsiBhKO05Ahw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsPeo9lpROvpGSCrtkOVmdpZfTB59Wk4By+/m0XEEGhtroTM17SbxGOf7cZRKB5hco8QukhFv2r5pSD/+HD3rRS+P4AEaelv36n5Bmp/m5wwdvdQ2R27Ud8LwbSOa1jo3wVK4q4Kd1Bb4U9daYSq0E2+U+o2ttItrxP7M5XLfUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BZStbs3+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XCorDLgO; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BZStbs3+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XCorDLgO"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7C0CC114AB0E;
	Thu,  1 Aug 2024 06:38:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 01 Aug 2024 06:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508692; x=1722595092; bh=/4B+VGBrdq
	JsGLOIz4Lc2ohxFBVe9TNfJV2iT+4en6k=; b=BZStbs3+j56HCxzTYpfX3hh9tl
	IRz1iXZRg0PR+rl4hlfljNIeyMC84KJp+y5NQaEs3Y2+1ZYKSXjTGggQFEkoQN5K
	8l2FhK18XsXNb2hb0n/CzNG2w0ENhWvx5X0ILqwEXdb4/y69CoL7K8KjWaxSy5pX
	L/UJQo/a9IfKXJjqDft0exzoeLwJmlubPi5MW/34yj9ru1hKz4knqyls72EdeiMF
	oNS2yUVzx7CCFxpuyy2jj8iI98L+xAWu5nL/wmPnYr8EeL1j0rjtkjROugAO6hKJ
	staNK/gw/b5CwwXDsYbCqXPCMQve8xrOsVwS1k31+rCetT4PTdDip6cnWPbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508692; x=1722595092; bh=/4B+VGBrdqJsGLOIz4Lc2ohxFBVe
	9TNfJV2iT+4en6k=; b=XCorDLgOj2Ad9EkRBHIh41PJcmdK3DTQpVzqi9w098d+
	8d0jySCRYrf8AQGlpHLNqe061DwKMeZ7t987PfdDXJ6WgMqJdqx7jb+Vz46/pm0o
	dOLJ7JQtJLtZQ6FYeycOb/4HBI9f5L5RksbDP486ORH9tq/j7R324sSJcuinOZSE
	YtaDR5Lj36co8X+BUyxLPOJoH7dG8n7GwZmgFrd71wj52H9ZCjOtAYzvfvhQ9xxk
	eJ+QhY46FgLRNp2t+18XI9v2A9cNKBRZyDga4VSANPGT4uVJCKuCzHt9T9pqePdi
	fpH1YMPOhAtS5Zx4Du696yQkmMTU4f9sB975cKXV2w==
X-ME-Sender: <xms:lGWrZhT8xxvdEa6ujWO6IxLIVxGyrT95ni8XdvjyDL4Y8_k24WWj0Q>
    <xme:lGWrZqxoBoPZYLfpqHKA1_R8jkuizsdjc1DOk_x720QnwBNzI2T2N_gg1QXo5yRfb
    Fk6nNm9Yhe7ri9pmQ>
X-ME-Received: <xmr:lGWrZm1xtSmANSTXQziamxPMDzEjYpfya2am7sLHyzPKLLdYh7TaC_BTJZ6O4vql2Y7dP1w2-vJgmF6sjLC_dPfuVhHVENfQzdhis7OLLTRkwUk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:lGWrZpCliCE2e4jns_GDAYPN67Xvlo9uoVS8npmoH6cAMpZx2fSdsw>
    <xmx:lGWrZqii8ch4Ws1eq_XqZtep-7uqAgMM8bOPKuzL9N1_mxkbot6iNw>
    <xmx:lGWrZtrNy8oUKhsIOcCzR0KmPqFSis4R6JDUGjy2r2ffg0qAi_qxmg>
    <xmx:lGWrZlgTTrfMI1J5AGXXqWqIGspIi3ovAWUkDZa6dToudIo3BmUFqQ>
    <xmx:lGWrZsYhxCLkOxnVuEjDb3efoF4oY6ZG22-cox1vqHW9lY5EVdm2hY2I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:38:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cbb7cd69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:36:37 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:38:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 00/24] Memory leak fixes (pt.3)
Message-ID: <cover.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m/F1wt2XwKWRARNr"
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>


--m/F1wt2XwKWRARNr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that plugs another round
of memory leaks in Git. Changes compared to v2:

  - Various typo fixes.

  - Adopted a patch by Rub=C3=A9n that plugs a git-submodule--helper(1) leak
    in a neater way by using an integer to track the clone depth instead
    of using a (possibly allocated) string.

  - Refactored git-ls-remote(1) to use a `struct strvec` to track
    patterns instead of manually populating an array, which makes the
    code easier to reason about while still plugging the memory leak.
    This was suggested by Taylor.

Thanks for all the reviews so far!

Patrick

Patrick Steinhardt (23):
  builtin/replay: plug leaking `advance_name` variable
  builtin/log: fix leaking branch name when creating cover letters
  builtin/describe: fix memory leak with `--contains=3D`
  builtin/describe: fix leaking array when running diff-index
  builtin/describe: fix trivial memory leak when describing blob
  builtin/name-rev: fix various trivial memory leaks
  builtin/submodule--helper: fix leaking buffer in `is_tip_reachable`
  builtin/ls-remote: fix leaking `pattern` strings
  builtin/remote: fix leaking strings in `branch_list`
  builtin/remote: fix various trivial memory leaks
  builtin/stash: fix various trivial memory leaks
  builtin/rev-parse: fix memory leak with `--parseopt`
  builtin/show-branch: fix several memory leaks
  builtin/credential-store: fix leaking credential
  builtin/rerere: fix various trivial memory leaks
  builtin/shortlog: fix various trivial memory leaks
  builtin/worktree: fix leaking derived branch names
  builtin/credential-cache: fix trivial leaks
  t/test-repository: fix leaking repository
  object-name: fix leaking commit list items
  entry: fix leaking pathnames during delayed checkout
  convert: fix leaking config strings
  commit-reach: fix trivial memory leak when computing reachability

Rub=C3=A9n Justico (1):
  builtin/submodule--helper: fix leaking clone depth parameter

 builtin/credential-cache.c              |  9 ++++-
 builtin/credential-store.c              |  1 +
 builtin/describe.c                      | 25 ++++++++++--
 builtin/log.c                           |  4 +-
 builtin/ls-remote.c                     | 24 +++++-------
 builtin/name-rev.c                      |  6 ++-
 builtin/remote.c                        | 44 ++++++++++++++++-----
 builtin/replay.c                        | 20 +++++++---
 builtin/rerere.c                        |  8 +++-
 builtin/rev-parse.c                     |  5 ++-
 builtin/shortlog.c                      |  1 +
 builtin/show-branch.c                   | 52 +++++++++++++++++--------
 builtin/stash.c                         | 18 ++++++++-
 builtin/submodule--helper.c             | 20 ++++++----
 builtin/worktree.c                      |  7 ++--
 commit-reach.c                          |  1 +
 convert.c                               | 14 +++++--
 entry.c                                 |  4 +-
 object-name.c                           | 26 ++++++++-----
 rerere.c                                |  9 ++++-
 t/helper/test-repository.c              |  4 +-
 t/t0021-conversion.sh                   |  1 +
 t/t0301-credential-cache.sh             |  2 +
 t/t0302-credential-store.sh             |  2 +
 t/t0303-credential-external.sh          |  1 +
 t/t1502-rev-parse-parseopt.sh           |  2 +
 t/t1511-rev-parse-caret.sh              |  1 +
 t/t2030-unresolve-info.sh               |  1 +
 t/t2080-parallel-checkout-basics.sh     |  1 +
 t/t2082-parallel-checkout-attributes.sh |  1 +
 t/t2400-worktree-add.sh                 |  1 +
 t/t2501-cwd-empty.sh                    |  1 +
 t/t3201-branch-contains.sh              |  1 +
 t/t3202-show-branch.sh                  |  1 +
 t/t3206-range-diff.sh                   |  1 +
 t/t3650-replay-basics.sh                |  1 +
 t/t3903-stash.sh                        |  1 +
 t/t3904-stash-patch.sh                  |  2 +
 t/t3905-stash-include-untracked.sh      |  1 +
 t/t4200-rerere.sh                       |  1 +
 t/t4201-shortlog.sh                     |  1 +
 t/t5318-commit-graph.sh                 |  2 +
 t/t5512-ls-remote.sh                    |  1 +
 t/t5514-fetch-multiple.sh               |  1 +
 t/t5520-pull.sh                         |  1 +
 t/t5528-push-default.sh                 |  1 +
 t/t5535-fetch-push-symref.sh            |  1 +
 t/t5543-atomic-push.sh                  |  1 +
 t/t5570-git-daemon.sh                   |  1 +
 t/t6007-rev-list-cherry-pick-file.sh    |  1 +
 t/t6010-merge-base.sh                   |  1 +
 t/t6120-describe.sh                     |  1 +
 t/t6133-pathspec-rev-dwim.sh            |  2 +
 t/t7064-wtstatus-pv2.sh                 |  1 +
 t/t7400-submodule-basic.sh              |  1 +
 t/t9902-completion.sh                   |  1 +
 t/t9903-bash-prompt.sh                  |  1 +
 57 files changed, 256 insertions(+), 88 deletions(-)

Range-diff against v1:
 1:  dd044eacc2 =3D  1:  b5c8a9495a builtin/replay: plug leaking `advance_n=
ame` variable
 2:  4daae88877 !  2:  73a16fff43 builtin/log: fix leaking branch name when=
 creating cover letters
    @@ Metadata
      ## Commit message ##
         builtin/log: fix leaking branch name when creating cover letters
    =20
    -    When calling `make_cover_letter()` without a branch name, then we =
try to
    +    When calling `make_cover_letter()` without a branch name, we try to
         derive the branch name by calling `find_branch_name()`. But while =
this
         function returns an allocated string, we never free the result and=
 thus
         have a memory leak. Fix this.
 -:  ---------- >  3:  65027d13b7 builtin/describe: fix memory leak with `-=
-contains=3D`
 4:  e8d86c01cf !  4:  19ca97e33a builtin/describe: fix leaking array when =
running diff-index
    @@ Commit message
         builtin/describe: fix leaking array when running diff-index
    =20
         When running git-describe(1) with `--dirty`, we will set up a `str=
uct
    -    rev_info` with arguments for git-diff-index(1). The way we assmble=
 the
    +    rev_info` with arguments for git-diff-index(1). The way we assembl=
e the
         arguments it causes two memory leaks though:
    =20
           - We never release the `struct strvec`.
 5:  8aba7434bd =3D  5:  6deacb8667 builtin/describe: fix trivial memory le=
ak when describing blob
 6:  088f730572 =3D  6:  e38e9d1b62 builtin/name-rev: fix various trivial m=
emory leaks
 3:  08a12be13c !  7:  d3eb0372bd builtin/describe: fix memory leak with `-=
-contains=3D`
    @@
      ## Metadata ##
    -Author: Patrick Steinhardt <ps@pks.im>
    +Author: Rub=C3=A9n Justico <rjusto@gmail.com>
    =20
      ## Commit message ##
    -    builtin/describe: fix memory leak with `--contains=3D`
    +    builtin/submodule--helper: fix leaking clone depth parameter
    =20
    -    When calling `git describe --contains=3D`, we end up invoking
    -    `cmd_name_rev()` with some munged argv array. This array may conta=
in
    -    allocated strings and furthermore will likely be modified by the c=
alled
    -    function. This results in two memory leaks:
    +    The submodule helper supports a `--depth` parameter for both its "=
add"
    +    and "clone" subcommands, which in both cases end up being forwarde=
d to
    +    git-clone(1). But while the former subcommand uses an `OPT_INTEGER=
()` to
    +    parse the depth, the latter uses `OPT_STRING()`. Consequently, it =
is
    +    possible to pass non-integer input to "--depth" when calling the "=
clone"
    +    subcommand, where the value will then ultimately cause git-clone(1=
) to
    +    bail out.
    =20
    -      - First, we leak the array that we use to assemble the arguments.
    +    Besides the fact that the parameter verification should happen ear=
lier,
    +    the submodule helper infrastructure also internally tracks the dep=
th via
    +    a string. This requires us to convert the integer in the "add"
    +    subcommand into an allocated string, and this string ultimately le=
aks.
    =20
    -      - Second, we leak the allocated strings that we may have put int=
o the
    -        array.
    -
    -    Fix those leaks by creating a separate copy of the array that we c=
an
    -    hand over to `cmd_name_rev()`. This allows us to free all strings
    -    contained in the `strvec`, as the original vector will not be modi=
fied
    -    anymore.
    -
    -    Furthermore, free both the `strvec` and the copied array to fix the
    -    first memory leak.
    +    Refactor the code to consistently track the clone depth as an inte=
ger.
    +    This plugs the memory leak, simplifies the code and allows us to u=
se
    +    `OPT_INTEGER()` instead of `OPT_STRING()`, validating the input be=
fore
    +    we shell out to git--clone(1).
    =20
    +    Original-patch-by: Rub=C3=A9n Justo <rjusto@gmail.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    - ## builtin/describe.c ##
    -@@ builtin/describe.c: int cmd_describe(int argc, const char **argv, c=
onst char *prefix)
    - 	if (contains) {
    - 		struct string_list_item *item;
    - 		struct strvec args;
    -+		const char **argv_copy;
    -+		int ret;
    + ## builtin/submodule--helper.c ##
    +@@ builtin/submodule--helper.c: struct module_clone_data {
    + 	const char *path;
    + 	const char *name;
    + 	const char *url;
    +-	const char *depth;
    ++	int depth;
    + 	struct list_objects_filter_options *filter_options;
    + 	unsigned int quiet: 1;
    + 	unsigned int progress: 1;
    +@@ builtin/submodule--helper.c: static int clone_submodule(const struc=
t module_clone_data *clone_data,
    + 			strvec_push(&cp.args, "--quiet");
    + 		if (clone_data->progress)
    + 			strvec_push(&cp.args, "--progress");
    +-		if (clone_data->depth && *(clone_data->depth))
    +-			strvec_pushl(&cp.args, "--depth", clone_data->depth, NULL);
    ++		if (clone_data->depth > 0)
    ++			strvec_pushf(&cp.args, "--depth=3D%d", clone_data->depth);
    + 		if (reference->nr) {
    + 			struct string_list_item *item;
     =20
    - 		strvec_init(&args);
    - 		strvec_pushl(&args, "name-rev",
    -@@ builtin/describe.c: int cmd_describe(int argc, const char **argv, c=
onst char *prefix)
    - 			strvec_pushv(&args, argv);
    - 		else
    - 			strvec_push(&args, "HEAD");
    --		return cmd_name_rev(args.nr, args.v, prefix);
    -+
    -+		/*
    -+		 * `cmd_name_rev()` modifies the array, so we'd link its
    -+		 * contained strings if we didn't do a copy here.
    -+		 */
    -+		ALLOC_ARRAY(argv_copy, args.nr + 1);
    -+		for (size_t i =3D 0; i < args.nr; i++)
    -+			argv_copy[i] =3D args.v[i];
    -+		argv_copy[args.nr] =3D NULL;
    -+
    -+		ret =3D cmd_name_rev(args.nr, argv_copy, prefix);
    -+
    -+		strvec_clear(&args);
    -+		free(argv_copy);
    -+		return ret;
    - 	}
    +@@ builtin/submodule--helper.c: static int module_clone(int argc, cons=
t char **argv, const char *prefix)
    + 			   N_("reference repository")),
    + 		OPT_BOOL(0, "dissociate", &dissociate,
    + 			   N_("use --reference only while cloning")),
    +-		OPT_STRING(0, "depth", &clone_data.depth,
    +-			   N_("string"),
    ++		OPT_INTEGER(0, "depth", &clone_data.depth,
    + 			   N_("depth for shallow clones")),
    + 		OPT__QUIET(&quiet, "suppress output for cloning a submodule"),
    + 		OPT_BOOL(0, "progress", &progress,
    +@@ builtin/submodule--helper.c: static int add_submodule(const struct =
add_data *add_data)
    + 		}
    + 		clone_data.dissociate =3D add_data->dissociate;
    + 		if (add_data->depth >=3D 0)
    +-			clone_data.depth =3D xstrfmt("%d", add_data->depth);
    ++			clone_data.depth =3D add_data->depth;
     =20
    - 	hashmap_init(&names, commit_name_neq, NULL, 0);
    + 		if (clone_submodule(&clone_data, &reference))
    + 			goto cleanup;
 7:  5220c91bda !  8:  49c156cebb builtin/submodule--helper: fix various tr=
ivial memory leaks
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    builtin/submodule--helper: fix various trivial memory leaks
    +    builtin/submodule--helper: fix leaking buffer in `is_tip_reachable`
    =20
    -    There are multiple trivial memory leaks in the submodule helper. F=
ix
    -    those.
    +    The `rev` buffer in `is_tip_reachable()` is being populated with t=
he
    +    output of git-rev-list(1) -- if either the command fails or the bu=
ffer
    +    contains any data, then the input commit is not reachable.
    +
    +    The buffer isn't used for anything else, but neither do we free it,
    +    causing a memory leak. Fix this.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ builtin/submodule--helper.c: static int is_tip_reachable(const char =
*path, const
      }
     =20
      static int fetch_in_submodule(const char *module_path, int depth, int=
 quiet,
    -@@ builtin/submodule--helper.c: static void append_fetch_remotes(struc=
t strbuf *msg, const char *git_dir_path)
    - static int add_submodule(const struct add_data *add_data)
    - {
    - 	char *submod_gitdir_path;
    -+	char *depth_to_free =3D NULL;
    - 	struct module_clone_data clone_data =3D MODULE_CLONE_DATA_INIT;
    - 	struct string_list reference =3D STRING_LIST_INIT_NODUP;
    - 	int ret =3D -1;
    -@@ builtin/submodule--helper.c: static int add_submodule(const struct =
add_data *add_data)
    - 		}
    - 		clone_data.dissociate =3D add_data->dissociate;
    - 		if (add_data->depth >=3D 0)
    --			clone_data.depth =3D xstrfmt("%d", add_data->depth);
    -+			clone_data.depth =3D depth_to_free =3D xstrfmt("%d", add_data->dep=
th);
    -=20
    - 		if (clone_submodule(&clone_data, &reference))
    - 			goto cleanup;
     @@ builtin/submodule--helper.c: static int add_submodule(const struct =
add_data *add_data)
      			die(_("unable to checkout submodule '%s'"), add_data->sm_path);
      	}
      	ret =3D 0;
     +
      cleanup:
    -+	free(depth_to_free);
      	string_list_clear(&reference, 1);
      	return ret;
    - }
    =20
      ## t/t7400-submodule-basic.sh ##
     @@ t/t7400-submodule-basic.sh: subcommands of git submodule.
 8:  d42152654b !  9:  4330c80905 builtin/ls-remote: fix leaking `pattern` =
strings
    @@ Commit message
         and prefix them with "*/", but never free either the array nor the
         allocated strings.
    =20
    -    Fix those leaks.
    +    Refactor the code to use a `struct strvec` instead of manually tra=
cking
    +    the strings in an array. Like this, we can easily use `strvec_clea=
r()`
    +    to release both the vector and the contained string for us, pluggi=
ng the
    +    leak.
    =20
    +    Helped-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/ls-remote.c ##
    +@@ builtin/ls-remote.c: static const char * const ls_remote_usage[] =
=3D {
    +  * Is there one among the list of patterns that match the tail part
    +  * of the path?
    +  */
    +-static int tail_match(const char **pattern, const char *path)
    ++static int tail_match(const struct strvec *pattern, const char *path)
    + {
    +-	const char *p;
    + 	char *pathbuf;
    +=20
    +-	if (!pattern)
    ++	if (!pattern->nr)
    + 		return 1; /* no restriction */
    +=20
    + 	pathbuf =3D xstrfmt("/%s", path);
    +-	while ((p =3D *(pattern++)) !=3D NULL) {
    +-		if (!wildmatch(p, pathbuf, 0)) {
    ++	for (size_t i =3D 0; i < pattern->nr; i++) {
    ++		if (!wildmatch(pattern->v[i], pathbuf, 0)) {
    + 			free(pathbuf);
    + 			return 1;
    + 		}
     @@ builtin/ls-remote.c: int cmd_ls_remote(int argc, const char **argv,=
 const char *prefix)
      	int status =3D 0;
      	int show_symref_target =3D 0;
      	const char *uploadpack =3D NULL;
     -	const char **pattern =3D NULL;
    -+	char **pattern =3D NULL;
    ++	struct strvec pattern =3D STRVEC_INIT;
      	struct transport_ls_refs_options transport_options =3D
      		TRANSPORT_LS_REFS_OPTIONS_INIT;
      	int i;
     @@ builtin/ls-remote.c: int cmd_ls_remote(int argc, const char **argv,=
 const char *prefix)
    - 	if (argc > 1) {
    - 		int i;
    - 		CALLOC_ARRAY(pattern, argc);
    +=20
    + 	packet_trace_identity("ls-remote");
    +=20
    +-	if (argc > 1) {
    +-		int i;
    +-		CALLOC_ARRAY(pattern, argc);
     -		for (i =3D 1; i < argc; i++) {
    -+		for (i =3D 1; i < argc; i++)
    - 			pattern[i - 1] =3D xstrfmt("*/%s", argv[i]);
    +-			pattern[i - 1] =3D xstrfmt("*/%s", argv[i]);
     -		}
    - 	}
    +-	}
    ++	for (int i =3D 1; i < argc; i++)
    ++		strvec_pushf(&pattern, "*/%s", argv[i]);
     =20
      	if (flags & REF_TAGS)
    + 		strvec_push(&transport_options.ref_prefixes, "refs/tags/");
     @@ builtin/ls-remote.c: int cmd_ls_remote(int argc, const char **argv,=
 const char *prefix)
      		struct ref_array_item *item;
      		if (!check_ref_type(ref, flags))
      			continue;
     -		if (!tail_match(pattern, ref->name))
    -+		if (!tail_match((const char **) pattern, ref->name))
    ++		if (!tail_match(&pattern, ref->name))
      			continue;
      		item =3D ref_array_push(&ref_array, ref->name, &ref->old_oid);
      		item->symref =3D xstrdup_or_null(ref->symref);
    @@ builtin/ls-remote.c: int cmd_ls_remote(int argc, const char **argv, =
const char *
      		status =3D 1;
      	transport_ls_refs_options_release(&transport_options);
     +
    -+	for (i =3D 1; i < argc; i++)
    -+		free(pattern[i - 1]);
    -+	free(pattern);
    ++	strvec_clear(&pattern);
      	return status;
      }
    =20
 9:  6952fb2ff2 =3D 10:  2e3f76b428 builtin/remote: fix leaking strings in =
`branch_list`
10:  8bedcfdad8 =3D 11:  384203c34b builtin/remote: fix various trivial mem=
ory leaks
11:  a4b3ca49c9 =3D 12:  b7c0671797 builtin/stash: fix various trivial memo=
ry leaks
12:  e277222bd2 ! 13:  034c416d46 builtin/rev-parse: fix memory leak with `=
--parseopt`
    @@ Commit message
         which is of course wrong.
    =20
         Fix this by freeing all option's help fields as well as their `arg=
h`
    -    fielids to plug this memory leak.
    +    fields to plug this memory leak.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
13:  fd857efa9f =3D 14:  20a40e2fd4 builtin/show-branch: fix several memory=
 leaks
14:  ba4a883ae1 =3D 15:  b553f1ffb9 builtin/credential-store: fix leaking c=
redential
15:  6d49645c0f =3D 16:  76d81c8ae1 builtin/rerere: fix various trivial mem=
ory leaks
16:  778e87221a =3D 17:  d52ac1a550 builtin/shortlog: fix various trivial m=
emory leaks
17:  8a649bf7ed =3D 18:  dccaf695a9 builtin/worktree: fix leaking derived b=
ranch names
18:  2c7a369490 =3D 19:  788f0bee7b builtin/credential-cache: fix trivial l=
eaks
19:  7564911d2a =3D 20:  eb58826b14 t/test-repository: fix leaking reposito=
ry
20:  e3dbf9116b =3D 21:  fa95a67ccd object-name: fix leaking commit list it=
ems
21:  e426fd7ec5 =3D 22:  8cae4c44f4 entry: fix leaking pathnames during del=
ayed checkout
22:  8c2a19994f =3D 23:  5d2bf0f0f3 convert: fix leaking config strings
23:  60aef16aef =3D 24:  6db1829c79 commit-reach: fix trivial memory leak w=
hen computing reachability

base-commit: d19b6cd2dd72dc811f19df4b32c7ed223256c3ee
--=20
2.46.0.dirty


--m/F1wt2XwKWRARNr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZYkACgkQVbJhu7ck
PpQ+mA/8CgSvRPyB8M9pB6dCsUDf3FP0z5WPsGiLwd3XpBdKMkXd/WfIbAAe+u78
awjCHe/fgiiIheexT8tBrP0hFJar6uIsJsgtbRUQQ8zeLj9LdsxERkh5poRNm1P1
14X9aLOgcwX/LrniLfLdbobqIoVlx1iffvhPN60kQOQtHIqMwFlrustM25uNHANo
7Wi9tB36a02Xq03M+MSlTqoNdemZSVdpiWwDzTxSMklC/qF1A8HVizTrVJD/Waf4
R2bTJg1vS0GKCJMj867sbsoOleV8f1+SVfAo35wqZQQ5XlSX5czNZnKLn2CVS8rD
snjUymt0xSa+i9goGFdc77HrQzVn3LzDMgMB8kj3ZBb0nq4Z2E0uQ0TouV+tDW4/
SUddWSvhpBU4xB9c0k2XrWtwax9wRNRh6pyMSxfSJ5uPYsh6ID9Vz0eiaNRQ4R8R
TWlg1eg58qlCCus6T5dIsDDmwiOdBmuV/zxIpysb2rriLZlkvOcOaLHJqZWbock7
feesCx7ZPM7WbW25hWxo4dTHeRPgydZr2MV1/GB6h54Kvp7WidZXVfgIVcTz+dLH
Cx8fUikTb+7wQslNEfMdFYcfnlqwcEYriTdAzrcZa4l/ymXLbWxafCCeA+S5vAUv
IkziL6AtV7/43uo80BPumUV+XKbdWKWQZjNcjjd73hY0axvJqXo=
=ZZqR
-----END PGP SIGNATURE-----

--m/F1wt2XwKWRARNr--
