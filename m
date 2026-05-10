Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48D733ADB3
	for <git@vger.kernel.org>; Sun, 10 May 2026 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778451680; cv=none; b=komaYNqGC0khb73+c/N7hlg1VoXA0r6kVGfuqMvJFb8a5SzBneSo5y2hF6odHCdwAOltBlPHSCsmKX31GR3i+fTGxUrqU1JnqnRNTml8aWBjDcGGxLnNyU9H4+Utglyclnnc6Qui5ZCJfJRfZYDijFABZ85nRY5hCIDdliLuStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778451680; c=relaxed/simple;
	bh=FKshkDGFhaurjCABpnMS9tHZVfZLSiIggY4iWignLQ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TzRkLurt4mWFogbLnKMppSuMAGHfziFIBy5cIiifTB8GbubNxFe83GcuIzvt1dRsekPMo2oFfU+sIxxGFgIYnNjfx/xMcNE7EzIqUxvumReuOM3aOmxis9snApOmvU9jDl63e7tIYHqRBiHMixjJEOVqxsQ5d0dkdsCl8cksn14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QJExTI35; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SKeRwd8G; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QJExTI35";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SKeRwd8G"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 09E8DEC00A7;
	Sun, 10 May 2026 18:21:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 10 May 2026 18:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778451677;
	 x=1778538077; bh=bOkVaCUlFgu7lXUHR/MRKeCPtjyVGps8lD4fXNPSl+Y=; b=
	QJExTI35xrKAPb74B8HcKaSvZzHotAKmz0TdKMRvY52s5Fbi3IFe8+CWg0dXcqv2
	F5WgNUC0X9xYaZSa3owyI6+lJ6NS5rpbbD9kRREwRVxZ1elfsb6tkCdVDo1abpzQ
	fz2W1UgAuBDd+f40+Bs7VOqU78diwO9Wy0RsUdZIudky7Sor6/2mXzC/fDn3JiTl
	wvdxQOOoEDD12nXc+J6M+QuY1e2jjxIjIDSsUV+NBK0eXOmqwPIuP+n9X6ckCGVb
	08e79/KDqYeoATAdwZU0qvbxZZx6Y5zCCDTymIGha04Etvu3xgT4n35m3AZyZbAZ
	+VeJLsVuqkvTtFu/m1Dr8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778451677; x=
	1778538077; bh=bOkVaCUlFgu7lXUHR/MRKeCPtjyVGps8lD4fXNPSl+Y=; b=S
	KeRwd8GoXMU0NDeTwLfgu/awvBek+ZMpxh65wCahAZ6WPwMI09SsGILxs7L9gBO1
	tqpVQQdZVwg9GZiVtIPcQOTHGm64UtUWXffL1ciuYMsRF9QZLQkIGWW7CLrWihbH
	Y3xXz3GQWaw6AoU1sm0G3du5jAve0qBKWL7rstEzdg0dp/ZuN/eBphopodyp1FcQ
	imOkqOCh75MWH3x8alqubKbin0gFzmG5VyjsEmDQOvRMsheREe840cSMMBVQgcV6
	CVz+uw0fvrOTQEj7/9X9aHJMIu6lHyGmkAjjkLNyqRZ3XhjCb+MD7lYjIX6sj7qF
	SG9c8K4me9uKWmkv98D+A==
X-ME-Sender: <xms:3AQBagNIvjk7bMuP-lZ9nIbfNCzbJhXaogt1rLoQnHwmJdb24MHXog>
    <xme:3AQBauZSTTlnDn3Dmo8NIa-iOWgqpW_nAaQlBSbpemvUx8V4sAe_cSidpjgKmyBza
    6dMFvkyqWUTdb4OWpx4zPOho29dkO0y3nyJNb8QIqCdRXq3TzSneiE>
X-ME-Received: <xmr:3AQBakr47PIxQidWQtiaE_Nf3UoEgPRGmL5rztqiCUpuE3R9v4mjChu-B4PrBpPjKm-v9dBNOoZQNsKpXRl811cQY62j0OvOGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlghho
    nhgvlhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3AQBaia3-k6_MNkzyW7nxjZTOhjvdExGOra21PH615sNdheG3n6GZA>
    <xmx:3AQBasSatRY6W0a5lCV4dsniPtrUIM2m_QUqgom5u2PD8Duz1psGAg>
    <xmx:3AQBap5-oIMGqvbc2FTih-YN2e4IkTf0ScJD3badqhyOgjx6omuslw>
    <xmx:3AQBahznkmi9JHN0Xo0ih4rESrE9RZsj55SB6vbSyp7XvjythAsfTg>
    <xmx:3QQBaqZYo4N4e8nlKOiouPIQ3Z9W3PFNS7JG-wEisbRKFQuG62yXECSb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 18:21:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: fix typos via codespell
In-Reply-To: <20260506101631.18127-1-algonell@gmail.com> (Andrew Kreimer's
	message of "Wed, 6 May 2026 13:15:44 +0300")
References: <20260506101631.18127-1-algonell@gmail.com>
Date: Mon, 11 May 2026 07:21:15 +0900
Message-ID: <xmqqa4u6aotg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Andrew Kreimer <algonell@gmail.com> writes:

> There are some typos in the documentation, comments, etc.
> Fix them via codespell.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---

A few observations.

 * It is a bit too much to be in a single patch to review.

 * The fixes would apply to different vintages of the codebase.
   especially the files in git-gui/ and po/ come from trees
   maintained differently and patches to them need to be separate.

The spellos in *.po files stem from 96c0caf5 (Fix spelling errors in
messages shown to users, 2019-11-05) and .po files for other
languages have been updated to match the updated text in the code
since then, but not these two languages---if they are not maintained
since 2019, we need to wonder if they are worth keeping.

>  Documentation/SubmittingPatches            |  2 +-
>  Documentation/git-sparse-checkout.adoc     |  2 +-
>  Documentation/technical/build-systems.adoc |  6 +++---
>  builtin/pack-objects.c                     |  2 +-
>  commit-graph.h                             |  2 +-
>  compat/precompose_utf8.c                   |  2 +-
>  git-gui/git-gui.sh                         |  2 +-
>  git-gui/lib/choose_repository.tcl          |  2 +-
>  git-gui/lib/themed.tcl                     |  2 +-
>  hook.h                                     |  2 +-
>  meson_options.txt                          |  2 +-
>  midx-write.c                               |  4 ++--
>  odb/source.h                               |  2 +-
>  packfile.h                                 |  2 +-
>  path.h                                     |  2 +-
>  po/el.po                                   |  2 +-
>  po/ko.po                                   |  2 +-

I've read through the patch to above files before I ran out of time
and concentration.  Hopefully somebody else can do the remainder.

Thanks.

>  reftable/system.h                          |  2 +-
>  t/README                                   |  2 +-
>  t/chainlint.pl                             |  2 +-
>  t/chainlint/chain-break-false.expect       |  2 +-
>  t/chainlint/chain-break-false.test         |  2 +-
>  t/t1700-split-index.sh                     |  2 +-
>  t/t3909-stash-pathspec-file.sh             |  6 +++---
>  t/t4052-stat-output.sh                     |  2 +-
>  t/t4067-diff-partial-clone.sh              |  2 +-
>  t/t9150/svk-merge.dump                     | 10 +++++-----
>  t/t9151/svn-mergeinfo.dump                 | 18 +++++++++---------
>  t/unit-tests/clar/README.md                |  2 +-
>  29 files changed, 46 insertions(+), 46 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index d570184ec8..35b4952c8a 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -92,7 +92,7 @@ input and avoids unnecessary churn from many rapid iterations.
>    topic are appropriate, so such an incremental updates are limited to
>    small corrections and polishing.  After a topic cooks for some time
>    (like 7 calendar days) in 'next' without needing further tweaks on
> -  top, it gets merged to the 'master' branch and wait to become part
> +  top, it gets merged to the 'master' branch and waits to become part
>    of the next major release.
>  
>  In the following sections, many techniques and conventions are listed
> diff --git a/Documentation/git-sparse-checkout.adoc b/Documentation/git-sparse-checkout.adoc
> index 0d1618f161..e286584c67 100644
> --- a/Documentation/git-sparse-checkout.adoc
> +++ b/Documentation/git-sparse-checkout.adoc
> @@ -134,7 +134,7 @@ the `clean.requireForce` config option is set to `false`.
>  +
>  The `--dry-run` option will list the directories that would be removed
>  without deleting them. Running in this mode can be helpful to predict the
> -behavior of the clean comand or to determine which kinds of files are left
> +behavior of the clean command or to determine which kinds of files are left
>  in the sparse directories.
>  +
>  The `--verbose` option will list every file within the directories that
> diff --git a/Documentation/technical/build-systems.adoc b/Documentation/technical/build-systems.adoc
> index 3c5237b9fd..ca5b5d96f1 100644
> --- a/Documentation/technical/build-systems.adoc
> +++ b/Documentation/technical/build-systems.adoc
> @@ -47,7 +47,7 @@ Auto-detection of the following items is considered to be important:
>  
>    - Check for the existence of headers.
>    - Check for the existence of libraries.
> -  - Check for the existence of exectuables.
> +  - Check for the existence of executables.
>    - Check for the runtime behavior of specific functions.
>    - Check for specific link order requirements when multiple libraries are
>      involved.
> @@ -106,7 +106,7 @@ by the build system:
>  
>    - C: the primary compiled language used by Git, must be supported. Relevant
>      toolchains are GCC, Clang and MSVC.
> -  - Rust: candidate as a second compiled lanugage, should be supported. Relevant
> +  - Rust: candidate as a second compiled language, should be supported. Relevant
>      toolchains is the LLVM-based rustc.
>  
>  Built-in support for the respective languages is preferred over support that
> @@ -142,7 +142,7 @@ The following list of build systems are considered:
>  
>  === GNU Make
>  
> -- Platform support: ubitquitous on all platforms, but not well-integrated into Windows.
> +- Platform support: ubiquitous on all platforms, but not well-integrated into Windows.
>  - Auto-detection: no built-in support for auto-detection of features.
>  - Ease of use: easy to use, but discovering available options is hard. Makefile
>    rules can quickly get out of hand once reaching a certain scope.
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index dd2480a73d..806068907e 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1341,7 +1341,7 @@ static void write_pack_file(void)
>  			 * length of them as buffer length.
>  			 *
>  			 * Note that we need to subtract one though to
> -			 * accomodate for the sideband byte.
> +			 * accommodate for the sideband byte.
>  			 */
>  			struct hashfd_options opts = {
>  				.progress = progress_state,
> diff --git a/commit-graph.h b/commit-graph.h
> index f6a5433641..13ca4ff010 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -18,7 +18,7 @@
>   * This method is only used to enhance coverage of the commit-graph
>   * feature in the test suite with the GIT_TEST_COMMIT_GRAPH and
>   * GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS environment variables. Do not
> - * call this method oustide of a builtin, and only if you know what
> + * call this method outside of a builtin, and only if you know what
>   * you are doing!
>   */
>  void git_test_write_commit_graph_or_die(struct odb_source *source);
> diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
> index 43b3be0114..6e709bd138 100644
> --- a/compat/precompose_utf8.c
> +++ b/compat/precompose_utf8.c
> @@ -85,7 +85,7 @@ const char *precompose_string_if_needed(const char *in)
>  		out = reencode_string_iconv(in, inlen, ic_prec, 0, &outlen);
>  		if (out) {
>  			if (outlen == inlen && !memcmp(in, out, outlen))
> -				free(out); /* no need to return indentical */
> +				free(out); /* no need to return identical */
>  			else
>  				in = out;
>  		}
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 23fe76e498..40e95bccb4 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -109,7 +109,7 @@ foreach p [split $env(PATH) $_path_sep] {
>  	if {[file pathtype $p] ne {absolute}} {
>  		continue
>  	}
> -	# Keep only the first occurence of any duplicates.
> +	# Keep only the first occurrence of any duplicates.
>  	set norm_p [file normalize $p]
>  	dict set _path_seen $norm_p 1
>  }
> diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
> index 7e1462a20c..a4703af028 100644
> --- a/git-gui/lib/choose_repository.tcl
> +++ b/git-gui/lib/choose_repository.tcl
> @@ -15,7 +15,7 @@ field w_recentlist ; # Listbox containing recent repositories
>  field w_localpath  ; # Entry widget bound to local_path
>  
>  field done              0 ; # Finished picking the repository?
> -field clone_ok      false ; # clone succeeeded
> +field clone_ok      false ; # clone succeeded
>  field local_path       {} ; # Where this repository is locally
>  field origin_url       {} ; # Where we are cloning from
>  field origin_name  origin ; # What we shall call 'origin'
> diff --git a/git-gui/lib/themed.tcl b/git-gui/lib/themed.tcl
> index c18e201d85..f4cffeac66 100644
> --- a/git-gui/lib/themed.tcl
> +++ b/git-gui/lib/themed.tcl
> @@ -4,7 +4,7 @@
>  
>  namespace eval color {
>  	# Variable colors
> -	# Preffered way to set widget colors is using add_option.
> +	# Preferred way to set widget colors is using add_option.
>  	# In some cases, like with tags in_diff/in_sel, we use these colors.
>  	variable select_bg				lightgray
>  	variable select_fg				black
> diff --git a/hook.h b/hook.h
> index 5c5628dd1f..5f0c3f19bb 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -116,7 +116,7 @@ struct run_hooks_opt {
>  	 * While the callback allows piecemeal writing, it can also be
>  	 * used for smaller inputs, where it gets called only once.
>  	 *
> -	 * Add hook callback initalization context to `feed_pipe_ctx`.
> +	 * Add hook callback initialization context to `feed_pipe_ctx`.
>  	 * Add hook callback internal state to `feed_pipe_cb_data`.
>  	 *
>  	 */
> diff --git a/meson_options.txt b/meson_options.txt
> index 659cbb218f..1ed228d42a 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -106,7 +106,7 @@ option('highlight_bin', type: 'string', value: 'highlight')
>  
>  # Documentation.
>  option('docs', type: 'array', choices: ['man', 'html'], value: [],
> -  description: 'Which documenattion formats to build and install.')
> +  description: 'Which documentation formats to build and install.')
>  option('default_help_format', type: 'combo', choices: ['man', 'html', 'platform'], value: 'platform',
>    description: 'Default format used when executing git-help(1).')
>  option('docs_backend', type: 'combo', choices: ['asciidoc', 'asciidoctor', 'auto'], value: 'auto',
> diff --git a/midx-write.c b/midx-write.c
> index a25cab75ab..6d6d29c6cd 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1152,7 +1152,7 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
>  
>  	/*
>  	 * Ensure that we have a valid checksum before consulting the
> -	 * exisiting MIDX in order to determine if we can avoid an
> +	 * existing MIDX in order to determine if we can avoid an
>  	 * update.
>  	 *
>  	 * This is necessary because the given MIDX is loaded directly
> @@ -1438,7 +1438,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  
>  		/*
>  		 * Attempt opening the pack index to populate num_objects.
> -		 * Ignore failiures as they can be expected and are not
> +		 * Ignore failures as they can be expected and are not
>  		 * fatal during this selection time.
>  		 */
>  		open_pack_index(oldest);
> diff --git a/odb/source.h b/odb/source.h
> index f706e0608a..4958a503cf 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -338,7 +338,7 @@ static inline int odb_source_read_object_stream(struct odb_read_stream **out,
>   * are only iterated over once.
>   *
>   * The optional `request` structure serves as a template for retrieving the
> - * object info for each indvidual iterated object and will be populated as if
> + * object info for each individual iterated object and will be populated as if
>   * `odb_source_read_object_info()` was called on the object. It will not be
>   * modified, the callback will instead be invoked with a separate `struct
>   * object_info` for every object. Object info will not be read when passing a
> diff --git a/packfile.h b/packfile.h
> index 9b647da7dd..6dea707ba4 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -124,7 +124,7 @@ struct packfile_store {
>  	 * that packs that contain a lot of accessed objects will be located
>  	 * towards the front.
>  	 *
> -	 * This is usually desireable, but there are exceptions. One exception
> +	 * This is usually desirable, but there are exceptions. One exception
>  	 * is when the looking up multiple objects in a loop for each packfile.
>  	 * In that case, we may easily end up with an infinite loop as the
>  	 * packfiles get reordered to the front repeatedly.
> diff --git a/path.h b/path.h
> index 0434ba5e07..4c2958a903 100644
> --- a/path.h
> +++ b/path.h
> @@ -217,7 +217,7 @@ void safe_create_dir(struct repository *repo, const char *dir, int share);
>   *
>   *   - It always adjusts shared permissions.
>   *
> - * Returns a negative erorr code on error, 0 on success.
> + * Returns a negative error code on error, 0 on success.
>   */
>  int safe_create_dir_in_gitdir(struct repository *repo, const char *path);
>  
> diff --git a/po/el.po b/po/el.po
> index 703f46d0c7..c45560c996 100644
> --- a/po/el.po
> +++ b/po/el.po
> @@ -2748,7 +2748,7 @@ msgid "Low-level Commands / Interrogators"
>  msgstr "Εντολές Χαμηλού Επιπέδου / Ερωτημάτων"
>  
>  #: help.c:37
> -msgid "Low-level Commands / Synching Repositories"
> +msgid "Low-level Commands / Syncing Repositories"
>  msgstr "Εντολές Χαμηλού Επιπέδου / Συγχρονισμού Αποθετηρίων"
>  
>  #: help.c:38
> diff --git a/po/ko.po b/po/ko.po
> index 7a6847f023..6bc20a43e3 100644
> --- a/po/ko.po
> +++ b/po/ko.po
> @@ -2062,7 +2062,7 @@ msgid "Low-level Commands / Interrogators"
>  msgstr "보조 명령 / 정보 획득 기능"
>  
>  #: help.c:37
> -msgid "Low-level Commands / Synching Repositories"
> +msgid "Low-level Commands / Syncing Repositories"
>  msgstr "보조 명령 / 저장소 동기화 기능"
>  
>  #: help.c:38
> diff --git a/reftable/system.h b/reftable/system.h
> index c0e2cbe0ff..628232a46f 100644
> --- a/reftable/system.h
> +++ b/reftable/system.h
> @@ -84,7 +84,7 @@ struct reftable_flock {
>   * to acquire the lock. If `timeout_ms` is 0 we don't wait, if it is negative
>   * we block indefinitely.
>   *
> - * Retrun 0 on success, a reftable error code on error. Specifically,
> + * Return 0 on success, a reftable error code on error. Specifically,
>   * `REFTABLE_LOCK_ERROR` should be returned in case the target path is already
>   * locked.
>   */
> diff --git a/t/README b/t/README
> index adbbd9acf4..085921be4b 100644
> --- a/t/README
> +++ b/t/README
> @@ -972,7 +972,7 @@ see test-lib-functions.sh for the full list and their options.
>   - test_lazy_prereq <prereq> <script>
>  
>     Declare the way to determine if a test prerequisite <prereq> is
> -   satisified or not, but delay the actual determination until the
> +   satisfied or not, but delay the actual determination until the
>     prerequisite is actually used by "test_have_prereq" or the
>     three-arg form of the test_expect_* functions.  For example, this
>     is how the SYMLINKS prerequisite is declared to see if the platform
> diff --git a/t/chainlint.pl b/t/chainlint.pl
> index f0598e3934..2d07a99700 100755
> --- a/t/chainlint.pl
> +++ b/t/chainlint.pl
> @@ -35,7 +35,7 @@
>  #
>  # In other languages, `1+2` would typically be scanned as three tokens
>  # (`1`, `+`, and `2`), but in shell it is a single token. However, the similar
> -# `1 + 2`, which embeds whitepace, is scanned as three token in shell, as well.
> +# `1 + 2`, which embeds whitespace, is scanned as three token in shell, as well.
>  # In shell, several characters with special meaning lose that meaning when not
>  # surrounded by whitespace. For instance, the negation operator `!` is special
>  # when standing alone surrounded by whitespace; whereas in `foo!uucp` it is
> diff --git a/t/chainlint/chain-break-false.expect b/t/chainlint/chain-break-false.expect
> index f6a0a301e9..db6f8b12a4 100644
> --- a/t/chainlint/chain-break-false.expect
> +++ b/t/chainlint/chain-break-false.expect
> @@ -1,4 +1,4 @@
> -2 if condition not satisified
> +2 if condition not satisfied
>  3 then
>  4 	echo it did not work...
>  5 	echo failed!
> diff --git a/t/chainlint/chain-break-false.test b/t/chainlint/chain-break-false.test
> index f78ad911fc..924c9627c0 100644
> --- a/t/chainlint/chain-break-false.test
> +++ b/t/chainlint/chain-break-false.test
> @@ -1,6 +1,6 @@
>  test_expect_success 'chain-break-false' '
>  # LINT: broken &&-chain okay if explicit "false" signals failure
> -if condition not satisified
> +if condition not satisfied
>  then
>  	echo it did not work...
>  	echo failed!
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index ac4a5b2734..869fb4a14e 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -502,7 +502,7 @@ test_expect_success 'do not refresh null base index' '
>  		git checkout main &&
>  		git update-index --split-index &&
>  		test_commit more &&
> -		# must not write a new shareindex, or we wont catch the problem
> +		# must not write a new shareindex, or we won't catch the problem
>  		git -c splitIndex.maxPercentChange=100 merge --no-edit side-branch 2>err &&
>  		# i.e. do not expect warnings like
>  		# could not freshen shared index .../shareindex.00000...
> diff --git a/t/t3909-stash-pathspec-file.sh b/t/t3909-stash-pathspec-file.sh
> index 73f2dbdeb0..3afa6bff3d 100755
> --- a/t/t3909-stash-pathspec-file.sh
> +++ b/t/t3909-stash-pathspec-file.sh
> @@ -29,7 +29,7 @@ verify_expect () {
>  test_expect_success 'simplest' '
>  	restore_checkpoint &&
>  
> -	# More files are written to make sure that git didnt ignore
> +	# More files are written to make sure that git didn't ignore
>  	# --pathspec-from-file, stashing everything
>  	echo A >fileA.t &&
>  	echo B >fileB.t &&
> @@ -47,7 +47,7 @@ test_expect_success 'simplest' '
>  test_expect_success '--pathspec-file-nul' '
>  	restore_checkpoint &&
>  
> -	# More files are written to make sure that git didnt ignore
> +	# More files are written to make sure that git didn't ignore
>  	# --pathspec-from-file, stashing everything
>  	echo A >fileA.t &&
>  	echo B >fileB.t &&
> @@ -66,7 +66,7 @@ test_expect_success '--pathspec-file-nul' '
>  test_expect_success 'only touches what was listed' '
>  	restore_checkpoint &&
>  
> -	# More files are written to make sure that git didnt ignore
> +	# More files are written to make sure that git didn't ignore
>  	# --pathspec-from-file, stashing everything
>  	echo A >fileA.t &&
>  	echo B >fileB.t &&
> diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
> index 7c749062e2..df4999b326 100755
> --- a/t/t4052-stat-output.sh
> +++ b/t/t4052-stat-output.sh
> @@ -420,7 +420,7 @@ test_expect_success 'merge --stat respects COLUMNS with long name' '
>  # enough terminal display width, will contain the following line:
>  #     "<RED>|<RESET>  ${FILENAME} | 0"
>  # where "<RED>" and "<RESET>" are ANSI escape codes to color the text.
> -# To calculate the minimium terminal display width MIN_TERM_WIDTH so that the
> +# To calculate the minimum terminal display width MIN_TERM_WIDTH so that the
>  # FILENAME in the diffstat will not be shortened, we take the FILENAME length
>  # and add 9 to it.
>  # To check if the diffstat width, when the line_prefix (the "<RED>|<RESET>" of
> diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
> index 30813109ac..a9dec84c30 100755
> --- a/t/t4067-diff-partial-clone.sh
> +++ b/t/t4067-diff-partial-clone.sh
> @@ -159,7 +159,7 @@ test_expect_success 'diff succeeds even if prefetch triggered by break-rewrites'
>  	# We need baz to trigger break-rewrites detection.
>  	git -C client reset --hard HEAD &&
>  
> -	# break-rewrites detction in reset.
> +	# break-rewrites detection in reset.
>  	git -C client reset HEAD~1
>  '
>  
> diff --git a/t/t9150/svk-merge.dump b/t/t9150/svk-merge.dump
> index 42f70dbec7..6a8ac81b11 100644
> --- a/t/t9150/svk-merge.dump
> +++ b/t/t9150/svk-merge.dump
> @@ -77,7 +77,7 @@ Content-length: 2411
>  PROPS-END
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not give you
> -# enough guarantees about no collisions between objects ever hapenning.
> +# enough guarantees about no collisions between objects ever happening.
>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and it will
> @@ -206,7 +206,7 @@ Content-length: 2465
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not give you
> -# enough guarantees about no collisions between objects ever hapenning.
> +# enough guarantees about no collisions between objects ever happening.
>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and it will
> @@ -310,7 +310,7 @@ Content-length: 2521
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not give you
> -# enough guarantees about no collisions between objects ever hapenning.
> +# enough guarantees about no collisions between objects ever happening.
>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and it will
> @@ -417,7 +417,7 @@ Content-length: 2593
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not give you
> -# enough guarantees about no collisions between objects ever hapenning.
> +# enough guarantees about no collisions between objects ever happening.
>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and it will
> @@ -534,7 +534,7 @@ Content-length: 2713
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not give you
> -# enough guarantees about no collisions between objects ever hapenning.
> +# enough guarantees about no collisions between objects ever happening.
>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and it will
> diff --git a/t/t9151/svn-mergeinfo.dump b/t/t9151/svn-mergeinfo.dump
> index 47cafcf528..d5e1695637 100644
> --- a/t/t9151/svn-mergeinfo.dump
> +++ b/t/t9151/svn-mergeinfo.dump
> @@ -87,7 +87,7 @@ Content-length: 2411
>  PROPS-END
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not give you
> -# enough guarantees about no collisions between objects ever hapenning.
> +# enough guarantees about no collisions between objects ever happening.
>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and it will
> @@ -260,7 +260,7 @@ Content-length: 2465
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not give you
> -# enough guarantees about no collisions between objects ever hapenning.
> +# enough guarantees about no collisions between objects ever happening.
>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and it will
> @@ -365,7 +365,7 @@ Content-length: 2521
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not give you
> -# enough guarantees about no collisions between objects ever hapenning.
> +# enough guarantees about no collisions between objects ever happening.
>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and it will
> @@ -473,7 +473,7 @@ Content-length: 2529
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not give you
> -# enough guarantees about no collisions between objects ever hapenning.
> +# enough guarantees about no collisions between objects ever happening.
>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and it will
> @@ -578,7 +578,7 @@ Content-length: 2593
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not give you
> -# enough guarantees about no collisions between objects ever hapenning.
> +# enough guarantees about no collisions between objects ever happening.
>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and it will
> @@ -767,7 +767,7 @@ Content-length: 2593
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not give you
> -# enough guarantees about no collisions between objects ever hapenning.
> +# enough guarantees about no collisions between objects ever happening.
>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and it will
> @@ -948,7 +948,7 @@ Content-length: 2713
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not give you
> -# enough guarantees about no collisions between objects ever hapenning.
> +# enough guarantees about no collisions between objects ever happening.
>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and it will
> @@ -1172,7 +1172,7 @@ Content-length: 2713
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not give you
> -# enough guarantees about no collisions between objects ever hapenning.
> +# enough guarantees about no collisions between objects ever happening.
>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and it will
> @@ -1414,7 +1414,7 @@ Content-length: 2713
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
>  # 1461501637330902918203684832716283019655932542976 hashes do not give you
> -# enough guarantees about no collisions between objects ever hapenning.
> +# enough guarantees about no collisions between objects ever happening.
>  #
>  # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
>  # Note that you need some new glibc (at least >2.2.4) for this, and it will
> diff --git a/t/unit-tests/clar/README.md b/t/unit-tests/clar/README.md
> index 41595989ca..a45b9c8e5d 100644
> --- a/t/unit-tests/clar/README.md
> +++ b/t/unit-tests/clar/README.md
> @@ -138,7 +138,7 @@ raise errors during test execution.
>  __Caution:__ If you use assertions inside of `test_suitename__initialize`,
>  make sure that you do not rely on `__initialize` being completely run
>  inside your `test_suitename__cleanup` function. Otherwise you might
> -encounter ressource cleanup twice.
> +encounter resource cleanup twice.
>  
>  ## How does Clar work?
