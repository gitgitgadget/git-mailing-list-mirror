Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E02C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 10:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiKHKDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 05:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbiKHKDl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 05:03:41 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8F7114
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 02:03:40 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 945705C004E;
        Tue,  8 Nov 2022 05:03:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 08 Nov 2022 05:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667901819; x=1667988219; bh=PbxfgvsXrL
        X6U+Zox50Qw57ZAGMbA/lWlCPHUqzDTPQ=; b=mfyg0Wcok/IxJk+YGWZw+T6yKG
        8JiDJ3YlJC1EVTsx2A9aG4YMZYa9GC8oJLwdk6dlCnbKIYMQB+UUeMvhR3R5B7Ef
        Gkf+Pvfax58BVlgj9Jg6lh80uCb7KjpxqmnuUjKTDu4mxVrNf4LkK2mFaZ7gwT5h
        +vhvAGcyrPkimGRJcgFa7wjAmEcUxnIibSQUegG9y71qN4JnEKTbCLkVIjydoq6c
        hJJ+jwgoq/sqRnoj6k+V0lBZ8GYe2xpP2Ij56B2Rin5Wsy+N0vAVnX2jgsa6a2h0
        1Oevd9znl1bl34TZP9An9VtTxh4wqWLl9r9i+HavuhLJ4n/TTrjKSurkAjcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667901819; x=1667988219; bh=PbxfgvsXrLX6U+Zox50Qw57ZAGMb
        A/lWlCPHUqzDTPQ=; b=nqErLZxa8Fj4OpXQhzr2JTlOBjPPU8/HXLT+gWiiweey
        rcFCjU/0zxQijtOPvuGEXB7U6d/IEX9R31Ny8Y3w0UC8ldg7ou8DYoMfFSLN6KRS
        4Qg4a/6LSlx9/H4QZ3v4b43ZolgAEiHLT4v5OQP5iwLfNx7WcCR9N/TjIWkyBepz
        rMrqbxl8Hz4iKt4Hr+F6W9KHDKSIReIjv/8UhuUS2YQmiQ55WTqF4xAYN12lMWqO
        Th33yIhUeO6092ZNlA6FOg+KpkTRr9ZWy1nVQWiQS3hMhUbJpQi8W9paYz27EhMy
        BSwQ35asWphhh8Z+ueM+0VsQG+a3Q2yJ98LaYKVEaA==
X-ME-Sender: <xms:eylqY3EyXpufjusOzKhEv6Dse-KTJa5wiG-3cPwpvmrI5nHLahkyGA>
    <xme:eylqY0Ucj44QCzCE8Gzhdrq-K-1tRQG8jCTTeNfZYbnJEJlAIKW47JoL_7L_yjj3w
    l1C4dvkHWdC3W2g_w>
X-ME-Received: <xmr:eylqY5JfUSPF7qZ6gOYHxveLo_T4mIWl5V2TGcmkrPXZR2xXAyOShtBhGmakM7XyKu1JWlaywlX7c8wJD0pfSuOC2mIocKxAaiHo4hL0fUdT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedtgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:eylqY1FJ_iB8y90ULDI0l_O3l37H4YWWasJ5WvNg4uZ8mjEuKrOGMQ>
    <xmx:eylqY9XBE5OB4zvuop0-VwHRJAZQ357g2TvPma0MVhjN--QJY6KUkA>
    <xmx:eylqYwOC0UZ016PHBx6zaK5wynPCT479w-eZVJu72Oy_mXWilKnB2Q>
    <xmx:eylqYwQF2c3R2KPQVwbFGJ-kzTwdd0iuTKsLgl4W9or4uG8f5jDWCw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Nov 2022 05:03:38 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id a5558bcb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 8 Nov 2022 10:03:31 +0000 (UTC)
Date:   Tue, 8 Nov 2022 11:03:35 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 0/6] receive-pack: only use visible refs for connectivity
 check
Message-ID: <cover.1667901510.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B6GWznbpszh7ppf2"
Content-Disposition: inline
In-Reply-To: <cover.1666967670.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--B6GWznbpszh7ppf2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth version of my patch series that tries to improve
performance of the connectivity check by only considering preexisting
refs as uninteresting that could actually have been advertised to the
client.

This time around there are only incremental changes compared to v3, the
overall implementation stays the same. Changes:

    - Fixed a pre-existing memory leak in how hidden refs are parsed so
      that tests now pass with TEST_PASSES_SANITIZE_LEAK=3Dtrue.

    - Improved initialization of `struct ref_exclusions` to reuse the
      `REF_EXCLUSIONS_INIT` macro so we don't have to repeat the logic.

    - Dropped the `--exclude-hidden=3Dtransfer` option. Only `receive` and
      `uploadpack` are supported now.

Patrick

Patrick Steinhardt (6):
  refs: get rid of global list of hidden refs
  revision: move together exclusion-related functions
  revision: introduce struct to handle exclusions
  revision: add new parameter to exclude hidden refs
  rev-parse: add `--exclude-hidden=3D` option
  receive-pack: only use visible refs for connectivity check

 Documentation/git-rev-parse.txt    |   7 ++
 Documentation/rev-list-options.txt |   7 ++
 builtin/receive-pack.c             |  10 ++-
 builtin/rev-list.c                 |   1 +
 builtin/rev-parse.c                |  12 ++-
 connected.c                        |   3 +
 connected.h                        |   7 ++
 ls-refs.c                          |  13 ++-
 refs.c                             |  16 ++--
 refs.h                             |   5 +-
 revision.c                         | 117 +++++++++++++++---------
 revision.h                         |  36 ++++++--
 t/t6018-rev-list-glob.sh           |  11 +++
 t/t6021-rev-list-exclude-hidden.sh | 137 +++++++++++++++++++++++++++++
 upload-pack.c                      |  30 ++++---
 15 files changed, 329 insertions(+), 83 deletions(-)
 create mode 100755 t/t6021-rev-list-exclude-hidden.sh

Range-diff against v3:
1:  3741f0a389 ! 1:  34afe30d60 refs: get rid of global list of hidden refs
    @@ refs.c: int parse_hide_refs_config(const char *var, const char *valu=
e, const cha
     -			CALLOC_ARRAY(hide_refs, 1);
     -			hide_refs->strdup_strings =3D 1;
     -		}
    - 		string_list_append(hide_refs, ref);
    +-		string_list_append(hide_refs, ref);
    ++		string_list_append_nodup(hide_refs, ref);
      	}
      	return 0;
      }
2:  a6dcc99ca9 =3D 2:  b4f21d0a80 revision: move together exclusion-related=
 functions
3:  2a6a67df1d ! 3:  265b292ed5 revision: introduce struct to handle exclus=
ions
    @@ Commit message
         of exclusion.
    =20
         Introduce a new `struct ref_exclusions` that encapsulates all the =
logic
    -    related to excluding refs.
    +    related to excluding refs and move the `struct string_list` that h=
olds
    +    all wildmatch patterns of excluded refs into it. Rename functions =
that
    +    operate on this struct to match its name.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ revision.c: static void add_rev_cmdline_list(struct rev_info *revs,
     -		free(*ref_excludes_p);
     -	}
     -	*ref_excludes_p =3D NULL;
    -+	string_list_init_dup(&exclusions->excluded_refs);
    ++	struct ref_exclusions blank =3D REF_EXCLUSIONS_INIT;
    ++	memcpy(exclusions, &blank, sizeof(*exclusions));
      }
     =20
     -void add_ref_exclusion(struct string_list **ref_excludes_p, const cha=
r *exclude)
    @@ revision.h: struct rev_cmdline_info {
     +	 */
     +	struct string_list excluded_refs;
     +};
    ++
    ++/**
    ++ * Initialize a `struct ref_exclusions` with a macro.
    ++ */
    ++#define REF_EXCLUSIONS_INIT { \
    ++	.excluded_refs =3D STRING_LIST_INIT_DUP, \
    ++}
     +
      struct oidset;
      struct topo_walk_info;
    @@ revision.h: void mark_trees_uninteresting_sparse(struct repository *=
r, struct oi
     -int ref_excluded(struct string_list *, const char *path);
     -void clear_ref_exclusion(struct string_list **);
     -void add_ref_exclusion(struct string_list **, const char *exclude);
    -+#define REF_EXCLUSIONS_INIT { .excluded_refs =3D STRING_LIST_INIT_DUP=
 }
    -+
     +int ref_excluded(const struct ref_exclusions *exclusions, const char =
*path);
     +void init_ref_exclusions(struct ref_exclusions *);
     +void clear_ref_exclusions(struct ref_exclusions *);
4:  de7c1aa210 ! 4:  c7fa6698db revision: add new parameter to exclude hidd=
en refs
    @@ Documentation/rev-list-options.txt: respectively, and they must begi=
n with `refs
      or `--all`. If a trailing '/{asterisk}' is intended, it must be given
      explicitly.
     =20
    -+--exclude-hidden=3D[transfer|receive|uploadpack]::
    ++--exclude-hidden=3D[receive|uploadpack]::
     +	Do not include refs that have been hidden via either one of
    -+	`transfer.hideRefs`, `receive.hideRefs` or `uploadpack.hideRefs` that
    -+	the next `--all`, `--branches`, `--tags`, `--remotes` or `--glob` wo=
uld
    -+	otherwise consider.  This option is cleared when seeing one of these
    -+	pseudo-refs.
    ++	`receive.hideRefs` or `uploadpack.hideRefs` (see linkgit:git-config[=
1])
    ++	that the next `--all`, `--branches`, `--tags`, `--remotes` or `--glo=
b`
    ++	would otherwise consider. This option is cleared when seeing one of
    ++	these pseudo-refs.
     +
      --reflog::
      	Pretend as if all objects mentioned by reflogs are listed on the
    @@ builtin/rev-list.c: static const char rev_list_usage[] =3D
      "    --tags\n"
      "    --remotes\n"
      "    --stdin\n"
    -+"    --exclude-hidden=3D[transfer|receive|uploadpack]\n"
    ++"    --exclude-hidden=3D[receive|uploadpack]\n"
      "    --quiet\n"
      "  ordering output:\n"
      "    --topo-order\n"
    @@ revision.c: static void add_rev_cmdline_list(struct rev_info *revs,
      	return 0;
      }
     =20
    - void init_ref_exclusions(struct ref_exclusions *exclusions)
    - {
    - 	string_list_init_dup(&exclusions->excluded_refs);
    -+	string_list_init_dup(&exclusions->hidden_refs);
    - }
    -=20
    +@@ revision.c: void init_ref_exclusions(struct ref_exclusions *exclusi=
ons)
      void clear_ref_exclusions(struct ref_exclusions *exclusions)
      {
      	string_list_clear(&exclusions->excluded_refs, 0);
    -+	string_list_clear(&exclusions->hidden_refs, 1);
    ++	string_list_clear(&exclusions->hidden_refs, 0);
      }
     =20
      void add_ref_exclusion(struct ref_exclusions *exclusions, const char =
*exclude)
    @@ revision.c: void add_ref_exclusion(struct ref_exclusions *exclusions=
, const char
     +{
     +	struct exclude_hidden_refs_cb cb;
     +
    -+	if (strcmp(section, "transfer") && strcmp(section, "receive") &&
    -+	    strcmp(section, "uploadpack"))
    ++	if (strcmp(section, "receive") && strcmp(section, "uploadpack"))
     +		die(_("unsupported section for hidden refs: %s"), section);
     +
     +	if (exclusions->hidden_refs.nr)
    @@ revision.h: struct ref_exclusions {
     +	struct string_list hidden_refs;
      };
     =20
    + /**
    +@@ revision.h: struct ref_exclusions {
    +  */
    + #define REF_EXCLUSIONS_INIT { \
    + 	.excluded_refs =3D STRING_LIST_INIT_DUP, \
    ++	.hidden_refs =3D STRING_LIST_INIT_DUP, \
    + }
    +=20
      struct oidset;
     @@ revision.h: void show_object_with_name(FILE *, struct object *, con=
st char *);
      /**
       * Helpers to check if a reference should be excluded.
       */
    --#define REF_EXCLUSIONS_INIT { .excluded_refs =3D STRING_LIST_INIT_DUP=
 }
    -+#define REF_EXCLUSIONS_INIT { .excluded_refs =3D STRING_LIST_INIT_DUP=
, .hidden_refs =3D STRING_LIST_INIT_DUP }
    -=20
    ++
      int ref_excluded(const struct ref_exclusions *exclusions, const char =
*path);
      void init_ref_exclusions(struct ref_exclusions *);
      void clear_ref_exclusions(struct ref_exclusions *);
    @@ t/t6021-rev-list-exclude-hidden.sh (new)
     +
     +test_description=3D'git rev-list --exclude-hidden test'
     +
    -+TEST_PASSES_SANITIZE_LEAK=3Dtrue
     +. ./test-lib.sh
     +
     +test_expect_success 'setup' '
    @@ t/t6021-rev-list-exclude-hidden.sh (new)
     +	test_cmp expected err
     +'
     +
    -+test_expect_success 'passed multiple times' '
    -+	echo "fatal: --exclude-hidden=3D passed more than once" >expected &&
    -+	test_must_fail git -c transfer.hideRefs=3Drefs/hidden/ rev-list --ex=
clude-hidden=3Dtransfer --exclude-hidden=3Dtransfer 2>err &&
    -+	test_cmp expected err
    -+'
    -+
    -+test_expect_success '--exclude-hidden without hiddenRefs' '
    -+	git rev-list --exclude-hidden=3Dtransfer --all >out &&
    -+	cat >expected <<-EOF &&
    -+	$NAMESPACE
    -+	$HIDDEN
    -+	$TAG
    -+	$COMMIT
    -+	EOF
    -+	test_cmp expected out
    -+'
    -+
    -+test_expect_success 'hidden via transfer.hideRefs' '
    -+	git -c transfer.hideRefs=3Drefs/hidden/ rev-list --exclude-hidden=3D=
transfer --all >out &&
    -+	cat >expected <<-EOF &&
    -+	$NAMESPACE
    -+	$TAG
    -+	$COMMIT
    -+	EOF
    -+	test_cmp expected out
    -+'
    -+
    -+test_expect_success '--all --exclude-hidden=3Dtransfer --not --all wi=
thout hidden refs' '
    -+	git rev-list --all --exclude-hidden=3Dtransfer --not --all >out &&
    -+	test_must_be_empty out
    -+'
    -+
    -+test_expect_success '--all --exclude-hidden=3Dtransfer --not --all wi=
th hidden ref' '
    -+	git -c transfer.hideRefs=3Drefs/hidden/ rev-list --all --exclude-hid=
den=3Dtransfer --not --all >out &&
    -+	cat >expected <<-EOF &&
    -+	$HIDDEN
    -+	EOF
    -+	test_cmp expected out
    -+'
    -+
    -+test_expect_success '--exclude-hidden with --exclude' '
    -+	git -c transfer.hideRefs=3Drefs/hidden/ rev-list --exclude=3Drefs/ta=
gs/* --exclude-hidden=3Dtransfer --all >out &&
    -+	cat >expected <<-EOF &&
    -+	$NAMESPACE
    -+	$COMMIT
    -+	EOF
    -+	test_cmp expected out
    -+'
    -+
    -+test_expect_success '--exclude-hidden is reset' '
    -+	git -c transfer.hideRefs=3Drefs/ rev-list --exclude-hidden=3Dtransfe=
r --all --all >out &&
    -+	cat >expected <<-EOF &&
    -+	$NAMESPACE
    -+	$HIDDEN
    -+	$TAG
    -+	$COMMIT
    -+	EOF
    -+	test_cmp expected out
    -+'
    -+
    -+test_expect_success '--exclude-hidden operates on stripped refs by de=
fault' '
    -+	GIT_NAMESPACE=3Dnamespace git -c transfer.hideRefs=3Drefs/namespaced=
/ rev-list --exclude-hidden=3Dtransfer --all >out &&
    -+	cat >expected <<-EOF &&
    -+	$HIDDEN
    -+	$TAG
    -+	$COMMIT
    -+	EOF
    -+	test_cmp expected out
    -+'
    -+
    -+test_expect_success '--exclude-hidden does not hide namespace by defa=
ult' '
    -+	GIT_NAMESPACE=3Dnamespace git -c transfer.hideRefs=3Drefs/namespaces=
/namespace/ rev-list --exclude-hidden=3Dtransfer --all >out &&
    -+	cat >expected <<-EOF &&
    -+	$NAMESPACE
    -+	$HIDDEN
    -+	$TAG
    -+	$COMMIT
    -+	EOF
    -+	test_cmp expected out
    -+'
    -+
    -+test_expect_success '--exclude-hidden=3D may operate on unstripped re=
fs' '
    -+	GIT_NAMESPACE=3Dnamespace git -c transfer.hideRefs=3D^refs/namespace=
s/namespace/ rev-list --exclude-hidden=3Dtransfer --all >out &&
    -+	cat >expected <<-EOF &&
    -+	$HIDDEN
    -+	$TAG
    -+	$COMMIT
    -+	EOF
    -+	test_cmp expected out
    -+'
    -+
     +for section in receive uploadpack
     +do
    -+	test_expect_success "hidden via $section.hideRefs" '
    -+		git -c $section.hideRefs=3Drefs/hidden/ rev-list --exclude-hidden=
=3D$section --all >out &&
    -+		cat >expected <<-EOF &&
    -+		$NAMESPACE
    -+		$TAG
    -+		$COMMIT
    -+		EOF
    -+		test_cmp expected out
    ++	test_expect_success "$section: passed multiple times" '
    ++		echo "fatal: --exclude-hidden=3D passed more than once" >expected &&
    ++		test_must_fail git -c transfer.hideRefs=3Drefs/hidden/ rev-list --e=
xclude-hidden=3D$section --exclude-hidden=3D$section 2>err &&
    ++		test_cmp expected err
     +	'
     +
    -+	test_expect_success "--exclude-hidden=3D$section respects transfer.h=
ideRefs" '
    -+		git -c transfer.hideRefs=3Drefs/hidden/ rev-list --exclude-hidden=
=3D$section --all >out &&
    -+		cat >expected <<-EOF &&
    -+		$NAMESPACE
    -+		$TAG
    -+		$COMMIT
    -+		EOF
    -+		test_cmp expected out
    -+	'
    -+
    -+	test_expect_success "--exclude-hidden=3Dtransfer ignores $section.hi=
deRefs" '
    -+		git -c $section.hideRefs=3Drefs/hidden/ rev-list --exclude-hidden=
=3Dtransfer --all >out &&
    ++	test_expect_success "$section: without hiddenRefs" '
    ++		git rev-list --exclude-hidden=3D$section --all >out &&
     +		cat >expected <<-EOF &&
     +		$NAMESPACE
     +		$HIDDEN
    @@ t/t6021-rev-list-exclude-hidden.sh (new)
     +		test_cmp expected out
     +	'
     +
    -+	test_expect_success "--exclude-hidden=3D$section respects both trans=
fer.hideRefs and $section.hideRefs" '
    ++	test_expect_success "$section: hidden via transfer.hideRefs" '
    ++		git -c transfer.hideRefs=3Drefs/hidden/ rev-list --exclude-hidden=
=3D$section --all >out &&
    ++		cat >expected <<-EOF &&
    ++		$NAMESPACE
    ++		$TAG
    ++		$COMMIT
    ++		EOF
    ++		test_cmp expected out
    ++	'
    ++
    ++	test_expect_success "$section: hidden via $section.hideRefs" '
    ++		git -c $section.hideRefs=3Drefs/hidden/ rev-list --exclude-hidden=
=3D$section --all >out &&
    ++		cat >expected <<-EOF &&
    ++		$NAMESPACE
    ++		$TAG
    ++		$COMMIT
    ++		EOF
    ++		test_cmp expected out
    ++	'
    ++
    ++	test_expect_success "$section: respects both transfer.hideRefs and $=
section.hideRefs" '
     +		git -c transfer.hideRefs=3Drefs/tags/ -c $section.hideRefs=3Drefs/h=
idden/ rev-list --exclude-hidden=3D$section --all >out &&
     +		cat >expected <<-EOF &&
     +		$NAMESPACE
    @@ t/t6021-rev-list-exclude-hidden.sh (new)
     +		EOF
     +		test_cmp expected out
     +	'
    ++
    ++	test_expect_success "$section: negation without hidden refs marks ev=
erything as uninteresting" '
    ++		git rev-list --all --exclude-hidden=3D$section --not --all >out &&
    ++		test_must_be_empty out
    ++	'
    ++
    ++	test_expect_success "$section: negation with hidden refs marks them =
as interesting" '
    ++		git -c transfer.hideRefs=3Drefs/hidden/ rev-list --all --exclude-hi=
dden=3D$section --not --all >out &&
    ++		cat >expected <<-EOF &&
    ++		$HIDDEN
    ++		EOF
    ++		test_cmp expected out
    ++	'
    ++
    ++	test_expect_success "$section: hidden refs and excludes work togethe=
r" '
    ++		git -c transfer.hideRefs=3Drefs/hidden/ rev-list --exclude=3Drefs/t=
ags/* --exclude-hidden=3D$section --all >out &&
    ++		cat >expected <<-EOF &&
    ++		$NAMESPACE
    ++		$COMMIT
    ++		EOF
    ++		test_cmp expected out
    ++	'
    ++
    ++	test_expect_success "$section: excluded hidden refs get reset" '
    ++		git -c transfer.hideRefs=3Drefs/ rev-list --exclude-hidden=3D$secti=
on --all --all >out &&
    ++		cat >expected <<-EOF &&
    ++		$NAMESPACE
    ++		$HIDDEN
    ++		$TAG
    ++		$COMMIT
    ++		EOF
    ++		test_cmp expected out
    ++	'
    ++
    ++	test_expect_success "$section: operates on stripped refs by default"=
 '
    ++		GIT_NAMESPACE=3Dnamespace git -c transfer.hideRefs=3Drefs/namespace=
d/ rev-list --exclude-hidden=3D$section --all >out &&
    ++		cat >expected <<-EOF &&
    ++		$HIDDEN
    ++		$TAG
    ++		$COMMIT
    ++		EOF
    ++		test_cmp expected out
    ++	'
    ++
    ++	test_expect_success "$section: does not hide namespace by default" '
    ++		GIT_NAMESPACE=3Dnamespace git -c transfer.hideRefs=3Drefs/namespace=
s/namespace/ rev-list --exclude-hidden=3D$section --all >out &&
    ++		cat >expected <<-EOF &&
    ++		$NAMESPACE
    ++		$HIDDEN
    ++		$TAG
    ++		$COMMIT
    ++		EOF
    ++		test_cmp expected out
    ++	'
    ++
    ++	test_expect_success "$section: can operate on unstripped refs" '
    ++		GIT_NAMESPACE=3Dnamespace git -c transfer.hideRefs=3D^refs/namespac=
es/namespace/ rev-list --exclude-hidden=3D$section --all >out &&
    ++		cat >expected <<-EOF &&
    ++		$HIDDEN
    ++		$TAG
    ++		$COMMIT
    ++		EOF
    ++		test_cmp expected out
    ++	'
     +done
     +
     +test_done
5:  68a5e56304 ! 5:  79c5c64a80 revparse: add `--exclude-hidden=3D` option
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    revparse: add `--exclude-hidden=3D` option
    +    rev-parse: add `--exclude-hidden=3D` option
    =20
         Add a new `--exclude-hidden=3D` option that is similar to the one =
we just
    -    added to git-rev-list(1). Given a seciton name `transfer`, `upload=
pack`
    -    or `receive` as argument, it causes us to exclude all references t=
hat
    -    would be hidden by the respective `$seciton.hideRefs` configuratio=
n.
    +    added to git-rev-list(1). Given a seciton name `uploadpack` or `re=
ceive`
    +    as argument, it causes us to exclude all references that would be =
hidden
    +    by the respective `$section.hideRefs` configuration.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ Documentation/git-rev-parse.txt: respectively, and they must begin w=
ith `refs/`
      or `--all`. If a trailing '/{asterisk}' is intended, it must be given
      explicitly.
     =20
    -+--exclude-hidden=3D[transfer|receive|uploadpack]::
    ++--exclude-hidden=3D[receive|uploadpack]::
     +	Do not include refs that have been hidden via either one of
    -+	`transfer.hideRefs`, `receive.hideRefs` or `uploadpack.hideRefs` that
    -+	the next `--all`, `--branches`, `--tags`, `--remotes` or `--glob` wo=
uld
    -+	otherwise consider.  This option is cleared when seeing one of these
    -+	pseudo-refs.
    ++	`receive.hideRefs` or `uploadpack.hideRefs` (see linkgit:git-config[=
1])
    ++	that the next `--all`, `--branches`, `--tags`, `--remotes` or `--glo=
b`
    ++	would otherwise consider. This option is cleared when seeing one of
    ++	these pseudo-refs.
     +
      --disambiguate=3D<prefix>::
      	Show every object whose name begins with the given prefix.
    @@ t/t6018-rev-list-glob.sh: test_expect_success 'rev-parse --exclude=
=3Dref with --re
      	compare rev-parse "--exclude=3Dupstream/x --remotes=3Dupstream/*" "u=
pstream/one upstream/two"
      '
     =20
    -+test_expect_success 'rev-parse --exclude-hidden=3D with --all' '
    -+	compare "-c transfer.hideRefs=3Drefs/remotes/ rev-parse" "--exclude-=
hidden=3Dtransfer --all" "--branches --tags"
    -+'
    ++for section in receive uploadpack
    ++do
    ++	test_expect_success "rev-parse --exclude-hidden=3D$section with --al=
l" '
    ++		compare "-c transfer.hideRefs=3Drefs/remotes/ rev-parse" "--exclude=
-hidden=3D$section --all" "--branches --tags"
    ++	'
     +
    -+test_expect_success 'rev-parse --exclude-hidden=3D with --all' '
    -+	compare "-c transfer.hideRefs=3Drefs/heads/subspace/ rev-parse" "--e=
xclude-hidden=3Dtransfer --all" "--exclude=3Drefs/heads/subspace/* --all"
    -+'
    ++	test_expect_success "rev-parse --exclude-hidden=3D$section with --al=
l" '
    ++		compare "-c transfer.hideRefs=3Drefs/heads/subspace/ rev-parse" "--=
exclude-hidden=3D$section --all" "--exclude=3Drefs/heads/subspace/* --all"
    ++	'
    ++done
     +
      test_expect_success 'rev-list --exclude=3Dglob with --branches=3Dglob=
' '
      	compare rev-list "--exclude=3Dsubspace-* --branches=3Dsub*" "subspac=
e/one subspace/two"
6:  9d15449559 =3D 6:  39b4741734 receive-pack: only use visible refs for c=
onnectivity check
--=20
2.38.1


--B6GWznbpszh7ppf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNqKXYACgkQVbJhu7ck
PpQXGRAArlYr2tZm/kEc4hC506sn28rTJl6V2DgTHxnV8C29G9joSmhX9SrgiOnu
tvujfYQNENflWl0sVPkSIJvldglEWmFTby1XqEjy7UuUC0OzK7K08/NVeGpAxwLd
lCyIh27IVGT4nGn+7EBxm3xARlo8MX2K2HJTLsQ+ojHVswERIxtPO1H+zQBpcWNC
AmoM2bcdmBUigSo2GBxrA89p85ybyvRQMc2tOJiU1rNm0yncVZv84PoJ+A3mycsu
PqGnQFFNTFB/skah9Swso66kDlD1+8w3R65bt+vlrjvk91TNw4zc1BmN7xVzpFuU
9FV+m6xtbSxJkldRuhtzqBTDwB+XXwP3Y2pnrgXfMm5qMZrABQxo2Ymrl9paaPC0
J+s9d21b+7JIPfzMEixCIfoVl2aFYMf/hoLwgTzfNK+Fc0on/TZyZFF2j3xnXwTF
7IA4QCpMF1pF3oC0BWo4jRuSKuhNPzZK9ZkAESeuN5LmwibzcK5P3Zc9m260+uR8
W5MV79s0uEC28x19FMaJtfrKOdx/NYJocB+26rcxU6d8f6d+Xfak10g2W70LoaQ6
y+48GGbTz/mtQOJq+GQ5yE3CUkoPGs2mPAYJmciJdmw1Gysh34uYmTNMxwENKwx1
CxJtysJdEZzj4j0pwB69MM/HHD3/1cGFZ3B0e3vT9+icKZdlOLE=
=xV+5
-----END PGP SIGNATURE-----

--B6GWznbpszh7ppf2--
