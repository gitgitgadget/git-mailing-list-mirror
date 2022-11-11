Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A849C43217
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 06:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiKKGuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 01:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiKKGuD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 01:50:03 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8C1B841
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 22:50:01 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A6E3D32008C3;
        Fri, 11 Nov 2022 01:49:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 11 Nov 2022 01:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668149398; x=1668235798; bh=whfiHk7znO
        ZHyYU/R3AhqrePEJ5pYSD4DHMssex4hKg=; b=QB1OqDXyPohRUJ0h3W1kZYWwar
        YCrGeZX3Z9u410cFhN0lQbbnVsX9+83KT5rKhi2cYN6iKFYfaYmHkLJUkMmCksAL
        jca0tvVlr5YH51xO/XqjgO8efq0buzIpgxk4nRnsA2OjH27UkqQToy2CUo3feUYa
        VAMRPYnE7D8uKVoIJmmtyRWkMtCadmCgjlqd2ypRnadw+SuEUSswObrzSFRH+vFk
        AOoJTW06muzKpyGVvT3Slk4Cfo/Ocz6tUZHH0SDZ1C6OxjYtOb1mqXZmkwd3Q/xO
        GU8weI+6jFGnPVab8FrfHPntba9hurBAkPxF5z6jOMe2PySP734ohdZj0itA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668149398; x=1668235798; bh=whfiHk7znOZHyYU/R3AhqrePEJ5p
        YSD4DHMssex4hKg=; b=j/AtYcr1m28jIOPyTjTMzJ7sW2fzCEV3gZXbunE055lW
        x9c3M97lAXzOAXPd6+x6c5ii26rPavh8iAog/EtN6Fpc3771vHpqIZJkyt2Xc2sY
        uPFdEr40Xl8pwu/euCH+F+HUj2FW3M17fJxAP2L+3duoCrW00E2bcd7qBoPxh/Hf
        T2Ej/HAriKNreA+xiPFON0JIV+0ydexNw63weNaOdDxQE0k37//REcjdp9QZLoiJ
        MZeLf3n+FrllqCylXyJg6+gHMAPWXgzFVmTOBWcIQcNHo7y4XdIRt9Io2jN6rl1S
        nFkhqc7nAJZ13ngwb0ab1WhWRGxkBByKYi2SfFweGg==
X-ME-Sender: <xms:lvBtY0m2gQM3IkpHzQeziYwovbgYmsdXjcQotVJyd-nkueE-OSDGvw>
    <xme:lvBtYz1PQqlvbuevfXCHs96_zDvWKOez3aHidzfaGcCVWHnbUAWXdNhPpkEcPvpit
    zGjdjrl2eVJm5bEgQ>
X-ME-Received: <xmr:lvBtYyrjCI5TGToIjtdR2nPBv_GGqAEDZydmpJeLAUzLwbryvkwTjZ8C3hmXrPtbfRSFyDFnEqS7fuT1GTqAPHeNk1fhBfEYbdrIRZL7Y4SEMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeehgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:lvBtYwnhe5FFRNpKq-b_XFb2ZHAU--ZpWDWbYvWHZ_SA26324FsZOg>
    <xmx:lvBtYy2rfLyoz6imjHxykoAAEznwQgUsFhALhb6I7ZjglAsPHNgBAA>
    <xmx:lvBtY3vsQZczG1AoaZCUF6kkglgzEsM4bT1P9_gKAqxv1nuB27-wbg>
    <xmx:lvBtY3xGz-njQQPnyStG8OIZlMLh0JYCxkHEELablGlDSkr-ftp7iw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Nov 2022 01:49:56 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e1efff62 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Nov 2022 06:49:49 +0000 (UTC)
Date:   Fri, 11 Nov 2022 07:49:49 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 0/7] receive-pack: only use visible refs for connectivity
 check
Message-ID: <cover.1668149149.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qUXHoFkcDpGRZlkd"
Content-Disposition: inline
In-Reply-To: <cover.1666967670.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qUXHoFkcDpGRZlkd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fifth version of my patch series that tries to improve
performance of the connectivity check by only considering preexisting
refs as uninteresting that could actually have been advertised to the
client.

Changes compared to v4:

    - Split out the memory leak fix when parsing hidden refs into a
      separate commit 1/7.

    - Fixed calls to `string_list_clear()` to not free the `util` field
      of `hidden_refs`.

    - Updated the documentation of the new `--exclude-hidden=3D` option to
      hopefully be easier to understand.

    - We now return an error when `--exclude-hidden=3D` is used with
      either one of `--branches`, `--tags` or `--remotes`.

    - Fixed a bug where we didn't bail when `--exclude-hidden=3D` was
      passed multiple times when there are no hidden refs.

    - Extended test coverage.

Patrick

Patrick Steinhardt (7):
  refs: fix memory leak when parsing hideRefs config
  refs: get rid of global list of hidden refs
  revision: move together exclusion-related functions
  revision: introduce struct to handle exclusions
  revision: add new parameter to exclude hidden refs
  rev-parse: add `--exclude-hidden=3D` option
  receive-pack: only use visible refs for connectivity check

 Documentation/git-rev-parse.txt    |   7 ++
 Documentation/rev-list-options.txt |   7 ++
 builtin/receive-pack.c             |  10 +-
 builtin/rev-list.c                 |   1 +
 builtin/rev-parse.c                |  18 +++-
 connected.c                        |   3 +
 connected.h                        |   7 ++
 ls-refs.c                          |  13 ++-
 refs.c                             |  16 +--
 refs.h                             |   5 +-
 revision.c                         | 131 +++++++++++++++--------
 revision.h                         |  43 ++++++--
 t/t6018-rev-list-glob.sh           |  40 +++++++
 t/t6021-rev-list-exclude-hidden.sh | 163 +++++++++++++++++++++++++++++
 upload-pack.c                      |  30 +++---
 15 files changed, 411 insertions(+), 83 deletions(-)
 create mode 100755 t/t6021-rev-list-exclude-hidden.sh

Range-diff against v4:
-:  ---------- > 1:  cfab8ba1a2 refs: fix memory leak when parsing hideRefs=
 config
1:  34afe30d60 ! 2:  d8118c6dd8 refs: get rid of global list of hidden refs
    @@ builtin/receive-pack.c: int cmd_receive_pack(int argc, const char **=
argv, const
      		packet_flush(1);
      	oid_array_clear(&shallow);
      	oid_array_clear(&ref);
    -+	string_list_clear(&hidden_refs, 1);
    ++	string_list_clear(&hidden_refs, 0);
      	free((void *)push_cert_nonce);
      	return 0;
      }
    @@ ls-refs.c: int ls_refs(struct repository *r, struct packet_reader *r=
equest)
      	packet_fflush(stdout);
      	strvec_clear(&data.prefixes);
      	strbuf_release(&data.buf);
    -+	string_list_clear(&data.hidden_refs, 1);
    ++	string_list_clear(&data.hidden_refs, 0);
      	return 0;
      }
     =20
    @@ refs.c: int parse_hide_refs_config(const char *var, const char *valu=
e, const cha
     -			CALLOC_ARRAY(hide_refs, 1);
     -			hide_refs->strdup_strings =3D 1;
     -		}
    --		string_list_append(hide_refs, ref);
    -+		string_list_append_nodup(hide_refs, ref);
    + 		string_list_append_nodup(hide_refs, ref);
      	}
      	return 0;
      }
    @@ upload-pack.c: static void upload_pack_data_clear(struct upload_pack=
_data *data)
      {
      	string_list_clear(&data->symref, 1);
      	string_list_clear(&data->wanted_refs, 1);
    -+	string_list_clear(&data->hidden_refs, 1);
    ++	string_list_clear(&data->hidden_refs, 0);
      	object_array_clear(&data->want_obj);
      	object_array_clear(&data->have_obj);
      	oid_array_clear(&data->haves);
2:  b4f21d0a80 =3D 3:  93a627fb7f revision: move together exclusion-related=
 functions
3:  265b292ed5 =3D 4:  ad41ade332 revision: introduce struct to handle excl=
usions
4:  c7fa6698db ! 5:  b5a4ce432a revision: add new parameter to exclude hidd=
en refs
    @@ Documentation/rev-list-options.txt: respectively, and they must begi=
n with `refs
      explicitly.
     =20
     +--exclude-hidden=3D[receive|uploadpack]::
    -+	Do not include refs that have been hidden via either one of
    -+	`receive.hideRefs` or `uploadpack.hideRefs` (see linkgit:git-config[=
1])
    -+	that the next `--all`, `--branches`, `--tags`, `--remotes` or `--glo=
b`
    -+	would otherwise consider. This option is cleared when seeing one of
    -+	these pseudo-refs.
    ++	Do not include refs that would be hidden by `git-receive-pack` or
    ++	`git-upload-pack` by consulting the appropriate `receive.hideRefs` or
    ++	`uploadpack.hideRefs` configuration along with `transfer.hideRefs` (=
see
    ++	linkgit:git-config[1]). This option affects the next pseudo-ref opti=
on
    ++	`--all` or `--glob` and is cleared after processing them.
     +
      --reflog::
      	Pretend as if all objects mentioned by reflogs are listed on the
    @@ revision.c: void init_ref_exclusions(struct ref_exclusions *exclusio=
ns)
      {
      	string_list_clear(&exclusions->excluded_refs, 0);
     +	string_list_clear(&exclusions->hidden_refs, 0);
    ++	exclusions->hidden_refs_configured =3D 0;
      }
     =20
      void add_ref_exclusion(struct ref_exclusions *exclusions, const char =
*exclude)
    @@ revision.c: void add_ref_exclusion(struct ref_exclusions *exclusions=
, const char
     +static int hide_refs_config(const char *var, const char *value, void =
*cb_data)
     +{
     +	struct exclude_hidden_refs_cb *cb =3D cb_data;
    ++	cb->exclusions->hidden_refs_configured =3D 1;
     +	return parse_hide_refs_config(var, value, cb->section,
     +				      &cb->exclusions->hidden_refs);
     +}
    @@ revision.c: void add_ref_exclusion(struct ref_exclusions *exclusions=
, const char
     +	if (strcmp(section, "receive") && strcmp(section, "uploadpack"))
     +		die(_("unsupported section for hidden refs: %s"), section);
     +
    -+	if (exclusions->hidden_refs.nr)
    ++	if (exclusions->hidden_refs_configured)
     +		die(_("--exclude-hidden=3D passed more than once"));
     +
     +	cb.exclusions =3D exclusions;
    @@ revision.c: static int handle_revision_opt(struct rev_info *revs, in=
t argc, cons
      	    starts_with(arg, "--branches=3D") || starts_with(arg, "--tags=3D=
") ||
      	    starts_with(arg, "--remotes=3D") || starts_with(arg, "--no-walk=
=3D"))
      	{
    +@@ revision.c: static int handle_revision_pseudo_opt(struct rev_info *=
revs,
    + 		}
    + 		clear_ref_exclusions(&revs->ref_excludes);
    + 	} else if (!strcmp(arg, "--branches")) {
    ++		if (revs->ref_excludes.hidden_refs_configured)
    ++			return error(_("--exclude-hidden cannot be used together with --br=
anches"));
    + 		handle_refs(refs, revs, *flags, refs_for_each_branch_ref);
    + 		clear_ref_exclusions(&revs->ref_excludes);
    + 	} else if (!strcmp(arg, "--bisect")) {
    +@@ revision.c: static int handle_revision_pseudo_opt(struct rev_info *=
revs,
    + 			    for_each_good_bisect_ref);
    + 		revs->bisect =3D 1;
    + 	} else if (!strcmp(arg, "--tags")) {
    ++		if (revs->ref_excludes.hidden_refs_configured)
    ++			return error(_("--exclude-hidden cannot be used together with --ta=
gs"));
    + 		handle_refs(refs, revs, *flags, refs_for_each_tag_ref);
    + 		clear_ref_exclusions(&revs->ref_excludes);
    + 	} else if (!strcmp(arg, "--remotes")) {
    ++		if (revs->ref_excludes.hidden_refs_configured)
    ++			return error(_("--exclude-hidden cannot be used together with --re=
motes"));
    + 		handle_refs(refs, revs, *flags, refs_for_each_remote_ref);
    + 		clear_ref_exclusions(&revs->ref_excludes);
    + 	} else if ((argcount =3D parse_long_opt("glob", argv, &optarg))) {
     @@ revision.c: static int handle_revision_pseudo_opt(struct rev_info *=
revs,
      	} else if ((argcount =3D parse_long_opt("exclude", argv, &optarg))) {
      		add_ref_exclusion(&revs->ref_excludes, optarg);
    @@ revision.c: static int handle_revision_pseudo_opt(struct rev_info *r=
evs,
     +		return argcount;
      	} else if (skip_prefix(arg, "--branches=3D", &optarg)) {
      		struct all_refs_cb cb;
    ++		if (revs->ref_excludes.hidden_refs_configured)
    ++			return error(_("--exclude-hidden cannot be used together with --br=
anches"));
      		init_all_refs_cb(&cb, revs, *flags);
    + 		for_each_glob_ref_in(handle_one_ref, optarg, "refs/heads/", &cb);
    + 		clear_ref_exclusions(&revs->ref_excludes);
    + 	} else if (skip_prefix(arg, "--tags=3D", &optarg)) {
    + 		struct all_refs_cb cb;
    ++		if (revs->ref_excludes.hidden_refs_configured)
    ++			return error(_("--exclude-hidden cannot be used together with --ta=
gs"));
    + 		init_all_refs_cb(&cb, revs, *flags);
    + 		for_each_glob_ref_in(handle_one_ref, optarg, "refs/tags/", &cb);
    + 		clear_ref_exclusions(&revs->ref_excludes);
    + 	} else if (skip_prefix(arg, "--remotes=3D", &optarg)) {
    + 		struct all_refs_cb cb;
    ++		if (revs->ref_excludes.hidden_refs_configured)
    ++			return error(_("--exclude-hidden cannot be used together with --re=
motes"));
    + 		init_all_refs_cb(&cb, revs, *flags);
    + 		for_each_glob_ref_in(handle_one_ref, optarg, "refs/remotes/", &cb);
    + 		clear_ref_exclusions(&revs->ref_excludes);
    =20
      ## revision.h ##
     @@ revision.h: struct ref_exclusions {
    @@ revision.h: struct ref_exclusions {
     +	 * `ref_is_hidden()`.
     +	 */
     +	struct string_list hidden_refs;
    ++
    ++	/*
    ++	 * Indicates whether hidden refs have been configured. This is to
    ++	 * distinguish between no hidden refs existing and hidden refs not
    ++	 * being parsed.
    ++	 */
    ++	char hidden_refs_configured;
      };
     =20
      /**
    @@ t/t6021-rev-list-exclude-hidden.sh (new)
     +do
     +	test_expect_success "$section: passed multiple times" '
     +		echo "fatal: --exclude-hidden=3D passed more than once" >expected &&
    -+		test_must_fail git -c transfer.hideRefs=3Drefs/hidden/ rev-list --e=
xclude-hidden=3D$section --exclude-hidden=3D$section 2>err &&
    ++		test_must_fail git rev-list --exclude-hidden=3D$section --exclude-h=
idden=3D$section 2>err &&
     +		test_cmp expected err
     +	'
     +
    @@ t/t6021-rev-list-exclude-hidden.sh (new)
     +		test_cmp expected out
     +	'
     +
    ++	test_expect_success "$section: excluded hidden refs can be used with=
 multiple pseudo-refs" '
    ++		git -c transfer.hideRefs=3Drefs/ rev-list --exclude-hidden=3D$secti=
on --all --exclude-hidden=3D$section --all >out &&
    ++		test_must_be_empty out
    ++	'
    ++
    ++	test_expect_success "$section: works with --glob" '
    ++		git -c transfer.hideRefs=3Drefs/hidden/ rev-list --exclude-hidden=
=3D$section --glob=3Drefs/h* >out &&
    ++		cat >expected <<-EOF &&
    ++		$COMMIT
    ++		EOF
    ++		test_cmp expected out
    ++	'
    ++
     +	test_expect_success "$section: operates on stripped refs by default"=
 '
     +		GIT_NAMESPACE=3Dnamespace git -c transfer.hideRefs=3Drefs/namespace=
d/ rev-list --exclude-hidden=3D$section --all >out &&
     +		cat >expected <<-EOF &&
    @@ t/t6021-rev-list-exclude-hidden.sh (new)
     +		EOF
     +		test_cmp expected out
     +	'
    ++
    ++	for pseudoopt in remotes branches tags
    ++	do
    ++		test_expect_success "$section: fails with --$pseudoopt" '
    ++			test_must_fail git rev-list --exclude-hidden=3D$section --$pseudoo=
pt 2>err &&
    ++			test_i18ngrep "error: --exclude-hidden cannot be used together wit=
h --$pseudoopt" err
    ++		'
    ++
    ++		test_expect_success "$section: fails with --$pseudoopt=3Dpattern" '
    ++			test_must_fail git rev-list --exclude-hidden=3D$section --$pseudoo=
pt=3Dpattern 2>err &&
    ++			test_i18ngrep "error: --exclude-hidden cannot be used together wit=
h --$pseudoopt" err
    ++		'
    ++	done
     +done
     +
     +test_done
5:  79c5c64a80 ! 6:  2eeb25eef0 rev-parse: add `--exclude-hidden=3D` option
    @@ Documentation/git-rev-parse.txt: respectively, and they must begin w=
ith `refs/`
      explicitly.
     =20
     +--exclude-hidden=3D[receive|uploadpack]::
    -+	Do not include refs that have been hidden via either one of
    -+	`receive.hideRefs` or `uploadpack.hideRefs` (see linkgit:git-config[=
1])
    -+	that the next `--all`, `--branches`, `--tags`, `--remotes` or `--glo=
b`
    -+	would otherwise consider. This option is cleared when seeing one of
    -+	these pseudo-refs.
    ++	Do not include refs that would be hidden by `git-receive-pack` or
    ++	`git-upload-pack` by consulting the appropriate `receive.hideRefs` or
    ++	`uploadpack.hideRefs` configuration along with `transfer.hideRefs` (=
see
    ++	linkgit:git-config[1]). This option affects the next pseudo-ref opti=
on
    ++	`--all` or `--glob` and is cleared after processing them.
     +
      --disambiguate=3D<prefix>::
      	Show every object whose name begins with the given prefix.
      	The <prefix> must be at least 4 hexadecimal digits long to
    =20
      ## builtin/rev-parse.c ##
    +@@ builtin/rev-parse.c: int cmd_rev_parse(int argc, const char **argv,=
 const char *prefix)
    + 				continue;
    + 			}
    + 			if (opt_with_value(arg, "--branches", &arg)) {
    ++				if (ref_excludes.hidden_refs_configured)
    ++					return error(_("--exclude-hidden cannot be used together with --=
branches"));
    + 				handle_ref_opt(arg, "refs/heads/");
    + 				continue;
    + 			}
    + 			if (opt_with_value(arg, "--tags", &arg)) {
    ++				if (ref_excludes.hidden_refs_configured)
    ++					return error(_("--exclude-hidden cannot be used together with --=
tags"));
    + 				handle_ref_opt(arg, "refs/tags/");
    + 				continue;
    + 			}
    +@@ builtin/rev-parse.c: int cmd_rev_parse(int argc, const char **argv,=
 const char *prefix)
    + 				continue;
    + 			}
    + 			if (opt_with_value(arg, "--remotes", &arg)) {
    ++				if (ref_excludes.hidden_refs_configured)
    ++					return error(_("--exclude-hidden cannot be used together with --=
remotes"));
    + 				handle_ref_opt(arg, "refs/remotes/");
    + 				continue;
    + 			}
     @@ builtin/rev-parse.c: int cmd_rev_parse(int argc, const char **argv,=
 const char *prefix)
      				add_ref_exclusion(&ref_excludes, arg);
      				continue;
    @@ t/t6018-rev-list-glob.sh: test_expect_success 'rev-parse --exclude=
=3Dref with --re
     +for section in receive uploadpack
     +do
     +	test_expect_success "rev-parse --exclude-hidden=3D$section with --al=
l" '
    -+		compare "-c transfer.hideRefs=3Drefs/remotes/ rev-parse" "--exclude=
-hidden=3D$section --all" "--branches --tags"
    ++		compare "-c transfer.hideRefs=3Drefs/remotes/ rev-parse" "--branche=
s --tags" "--exclude-hidden=3D$section --all"
     +	'
     +
     +	test_expect_success "rev-parse --exclude-hidden=3D$section with --al=
l" '
    -+		compare "-c transfer.hideRefs=3Drefs/heads/subspace/ rev-parse" "--=
exclude-hidden=3D$section --all" "--exclude=3Drefs/heads/subspace/* --all"
    ++		compare "-c transfer.hideRefs=3Drefs/heads/subspace/ rev-parse" "--=
exclude=3Drefs/heads/subspace/* --all" "--exclude-hidden=3D$section --all"
     +	'
    ++
    ++	test_expect_success "rev-parse --exclude-hidden=3D$section with --gl=
ob" '
    ++		compare "-c transfer.hideRefs=3Drefs/heads/subspace/ rev-parse" "--=
exclude=3Drefs/heads/subspace/* --glob=3Drefs/heads/*" "--exclude-hidden=3D=
$section --glob=3Drefs/heads/*"
    ++	'
    ++
    ++	test_expect_success "rev-parse --exclude-hidden=3D$section can be pa=
ssed once per pseudo-ref" '
    ++		compare "-c transfer.hideRefs=3Drefs/remotes/ rev-parse" "--branche=
s --tags --branches --tags" "--exclude-hidden=3D$section --all --exclude-hi=
dden=3D$section --all"
    ++	'
    ++
    ++	test_expect_success "rev-parse --exclude-hidden=3D$section can only =
be passed once per pseudo-ref" '
    ++		echo "fatal: --exclude-hidden=3D passed more than once" >expected &&
    ++		test_must_fail git rev-parse --exclude-hidden=3D$section --exclude-=
hidden=3D$section 2>err &&
    ++		test_cmp expected err
    ++	'
    ++
    ++	for pseudoopt in branches tags remotes
    ++	do
    ++		test_expect_success "rev-parse --exclude-hidden=3D$section fails wi=
th --$pseudoopt" '
    ++			echo "error: --exclude-hidden cannot be used together with --$pseu=
doopt" >expected &&
    ++			test_must_fail git rev-parse --exclude-hidden=3D$section --$pseudo=
opt 2>err &&
    ++			test_cmp expected err
    ++		'
    ++
    ++		test_expect_success "rev-parse --exclude-hidden=3D$section fails wi=
th --$pseudoopt=3Dpattern" '
    ++			echo "error: --exclude-hidden cannot be used together with --$pseu=
doopt" >expected &&
    ++			test_must_fail git rev-parse --exclude-hidden=3D$section --$pseudo=
opt=3Dpattern 2>err &&
    ++			test_cmp expected err
    ++		'
    ++	done
     +done
     +
      test_expect_success 'rev-list --exclude=3Dglob with --branches=3Dglob=
' '
6:  39b4741734 =3D 7:  f5f18f3939 receive-pack: only use visible refs for c=
onnectivity check
--=20
2.38.1


--qUXHoFkcDpGRZlkd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNt8I0ACgkQVbJhu7ck
PpRdXg/7BCBg/+07WUD3kIzV6iMOXQVIwQnew6cv0Un1gWHm1H8z0iibH/K9U0G+
I7hM+6OmPSnNJn3zHvYvOjtlcf2pKtFuup+9gWvkv/P3pPJIOCX6Fn6k0ILP+rK8
Kp9Yg/vxHx6v/oqPenKVdDK4elDH/RiOvqANe8Ui4xl3ScGZK8RB8yJ4gJ8GL7AI
qnI0Fev68uHA2OPl3QyztkyDy15fM8Et3MxIBxbgWo24Qn8BxUNWy0x7uCbQ5yYw
3JjJUPv2HHj91L+LVqGftqMI6yce0RiQuZX1XiGFuT0I71bvIchJ5S8jUpPyQPSj
Ax+ITi5BTs+W4HUB/CD/9fwJpxRMhk15yHuxgt2qJoJy+Y7AzZy/m+ZF4eFtfa0z
F4X5SmkmI3m/jQ0+FO0TojTP0xZ1FYyHIkWxUP0eTfx7AubvLcWTz5c4k3HVhAGx
yd8fl60HFePeElmrBlR3V6PGBivwr0khyTMHUXlFWBN1MHPqrD9n41qAhGVuq+4S
Ux4DDweZX2aA2oAA/T/9cSeR/IN0j1ji1EMT9U52TUU5VY7h+HyIqLGclI7txiXF
9uuWjurjmUDVLapPTm5x7MNd90LkPJfEPcNjCWsq/C0zf9Kl14hNqtkC0yRJt5pU
Mb3Qw2pyHu1YXj0qdgn3PULfcJ+1fCIYMYZknS3+dcxZWKdlkPI=
=yld9
-----END PGP SIGNATURE-----

--qUXHoFkcDpGRZlkd--
