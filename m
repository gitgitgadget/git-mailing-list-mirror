Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588D2C77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 11:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243502AbjD0LNQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 07:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243051AbjD0LNO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 07:13:14 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E31B44B9
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 04:13:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 137045C0056;
        Thu, 27 Apr 2023 07:13:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 27 Apr 2023 07:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682593989; x=1682680389; bh=pQ
        4yUq+pOUlaihLqcztFnwjUyCuBhoRTviFqeUkx6y0=; b=MBzgnwMv5wPKQ/cixG
        kZat+W30TRgj0dHVDT+n1C8W/djYhydqCqAHAlUF+7+nWGhNDagSZ/7RPvdwQogi
        M7sfr58cVZwZQ1rAoCF1hoyJ+BE0HMVOA+EyVKRIFNi46SiVyngyEStPLW26TAIv
        qEfuk5mNdChJuoBenALVKf6cdsdnVpi+1/3F9e8+8uwR7B/VI0RkrbOn8LuBTVt8
        GOOwsxXClcYdvMWhcm/c8MEXO2nWLXo/pkPs6Fmp9hVNxYZAOEUD4RQJSumpHkzx
        FzoCMaUbg0iWjEHELfEgfCf6Ne2kPR5o3Mt0d4joMM9tUX8MU58weizTTPL8oSOa
        0gvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682593989; x=1682680389; bh=pQ4yUq+pOUlai
        hLqcztFnwjUyCuBhoRTviFqeUkx6y0=; b=jCLPREExcqGZEggWBApsuBmr4MIEY
        D72lHLeVhXMRa0cKNORn3B4VB+Y80gNo2iUv7qbhRGdGFAyfRbFwVkLSoye3k0FV
        vcKkspoVAk3eW4CAhz7znQDxhpWK/o3uCw8Z+Ih3mfVOyp60omMZvxUBOekM4EbX
        v08/P8XCI4rW3XVaSaB7dCP/TXRKHyrRUDLjkTbDjDSHqkL6sFIArvabJ3cqbz2W
        lrtYuzYLECh58lZAmOLms0+uFL7nZu2P8MNvvuJAZPM57ir8B0lI6xde8KNM6yJe
        z92ytDvNWgr5Ac3OoCkm2Up15vQu+1pUJ14jVQ5e05RWYpaJDMLhab3sg==
X-ME-Sender: <xms:xFhKZFnzw6BuC3Zp_AwpSyS22uitnEZEfPVV3E_7UCfK2fT0UGRq0w>
    <xme:xFhKZA2vEkxw4CvuuyPz_6Jc4qlHl_-Gqddw6hzav0ZxKwyQeWEjknDihMktyf6Pf
    QALtZs_RILq8CF0AQ>
X-ME-Received: <xmr:xFhKZLqOlsoJpJfdVvMWJYqJE7JKnXh-BUbQKzSczP6NGfwTvRjz8F_OaSIEM_t2hYAZMN6zPRxUCsEwlYDd6tuUHNk-gRZNhsze-M6y3Rr9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:xFhKZFlNsar4k6OsiAmSKnhVeik7o6PcKZMaV_ibmHQtNlqxXMutUA>
    <xmx:xFhKZD2pS7HaGG9wTbZRzSMHU9_eOzuInVBi7DmBu5DzSJoBsonuKw>
    <xmx:xFhKZEt5ZuJMPBZEGZ5aaa84z6zD53qckU_HfodR4UA-7ibLLs5IYA>
    <xmx:xVhKZOTgettLx51s-fllVFc64lSFSxU3coYG5hz5zauDjfMrTe1Dqw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 07:13:07 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id ed697a11 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 27 Apr 2023 11:12:37 +0000 (UTC)
Date:   Thu, 27 Apr 2023 13:13:04 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 0/8] fetch: introduce machine-parseable output
Message-ID: <cover.1682593865.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jvAZmEHtjW7TCHuf"
Content-Disposition: inline
In-Reply-To: <cover.1681906948.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jvAZmEHtjW7TCHuf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that introduces a
machine-parseable output.

Changes compared to v1:

    - Patch 3/8: I've reworded the commit message to hopefully be more
      straight-forward. I've also amended tests so that we don't only
      test with `--dry-run`, but also without.

    - Patch 6/8: I've also moved the `all` and `multiple` variables from
      their global scope into `cmd__fetch`.

    - Patch 7/8: Fixed a bug where `--output-format=3D` wasn't honored for
      child processes when doing multi-remote fetches. Furthermore, I've
      unified parsing of the actual format so that we don't have to
      repeat it thrice.

    - Patch 8/8: Added a note to the commit message that tries to argue
      why I didn't add remote information to the interface. I'm still
      open to change this if you disagree with my reasoning here.

Thanks a bunch for all the feedback received so far, really appreciate
it!

Patrick

Patrick Steinhardt (8):
  fetch: split out tests for output format
  fetch: add a test to exercise invalid output formats
  fetch: fix missing from-reference when fetching HEAD:foo
  fetch: introduce `display_format` enum
  fetch: move display format parsing into main function
  fetch: move option related variables into main function
  fetch: introduce new `--output-format` option
  fetch: introduce machine-parseable "porcelain" output format

 Documentation/config/fetch.txt  |   4 +-
 Documentation/fetch-options.txt |   5 +
 Documentation/git-fetch.txt     |  17 +-
 builtin/fetch.c                 | 427 ++++++++++++++++++++------------
 t/t5510-fetch.sh                |  53 ----
 t/t5574-fetch-output.sh         | 237 ++++++++++++++++++
 6 files changed, 521 insertions(+), 222 deletions(-)
 create mode 100755 t/t5574-fetch-output.sh

Range-diff against v1:
1:  0d0d50d14c =3D 1:  0d0d50d14c fetch: split out tests for output format
2:  29d2c58914 =3D 2:  29d2c58914 fetch: add a test to exercise invalid out=
put formats
3:  596e12f03a ! 3:  d1fb6eeae7 fetch: fix missing from-reference when fetc=
hing HEAD:foo
    @@ Metadata
      ## Commit message ##
         fetch: fix missing from-reference when fetching HEAD:foo
    =20
    -    When displaying reference updates, we print a line that looks simi=
lar to
    -    the following:
    +    `store_updated_refs()` parses the remote reference for two purpose=
s:
    +
    +        - It gets used as a note when writing FETCH_HEAD.
    +
    +        - It is passed through to `display_ref_update()` to display
    +          updated references in the following format:
    +
    +          ```
    +           * branch               master          -> master
    +          ```
    +
    +    In most cases, the parsed remote reference is the prettified refer=
ence
    +    name and can thus be used for both cases. But if the remote refere=
nce is
    +    HEAD, the parsed remote reference becomes empty. This is intended =
when
    +    we write the FETCH_HEAD, where we skip writing the note in that ca=
se.
    +    But it is not intended when displaying the updated references and =
would
    +    cause us to miss the left-hand side of the displayed reference upd=
ate:
    =20
         ```
    -     * branch               master          -> master
    -    ```
    -
    -    The "branch" bit changes depending on what kind of reference we're
    -    updating, while both of the right-hand references are computed by
    -    stripping well-known prefixes like "refs/heads/" or "refs/tags".
    -
    -    The logic is kind of intertwined though and not easy to follow: we
    -    precompute both the kind (e.g. "branch") and the what, which is the
    -    abbreviated remote reference name, in `store_updated_refs()` and t=
hen
    -    pass it down the call chain to `display_ref_update()`.
    -
    -    There is a set of different cases here:
    -
    -        - When the remote reference name is "HEAD" we assume no kind a=
nd
    -          will thus instead print "[new ref]". We keep what at the emp=
ty
    -          string.
    -
    -        - When the remote reference name has a well-known prefix then =
the
    -          kind would be "branch", "tag" or "remote-tracking branch". T=
he
    -          what is the reference with the well-known prefix stripped an=
d in
    -          fact matches the output that `prettify_refname()` would retu=
rn.
    -
    -        - Otherwise, we'll again assume no kind and keep the what set =
to the
    -          fully qualified reference name.
    -
    -    Now there is a bug with the first case here, where the remote refe=
rence
    -    name is "HEAD". As noted, "what" will be set to the empty string. =
And
    -    that seems to be intentional because we also use this information =
to
    -    update the FETCH_HEAD, and in case we're updating HEAD we seemingly
    -    don't want to append that to our FETCH_HEAD value.
    -
    -    But as mentioned, we also use this value to display reference upda=
tes.
    -    And while the call to `display_ref_update()` correctly figures out=
 that
    -    we meant "HEAD" when `what` is empty, the call to `update_local_re=
f()`
    -    doesn't. `update_local_ref()` will then call `display_ref_update()=
` with
    -    the empty string and cause the following broken output:
    -
    -    ```
    -    $ git fetch --dry-run origin HEAD:foo
    +    $ git fetch origin HEAD:foo
         From https://github.com/git/git
          * [new ref]                          -> foo
         ```
    =20
         The HEAD string is clearly missing from the left-hand side of the =
arrow,
    -    which is further stressed by the point that the following commands=
 work
    -    as expected:
    +    which is further stressed by the point that the following commands=
 show
    +    the left-hand side as expected:
    =20
         ```
    -    $ git fetch --dry-run origin HEAD
    +    $ git fetch origin HEAD
         From https://github.com/git/git
          * branch                  HEAD       -> FETCH_HEAD
    =20
    -    $ git fetch --dry-run origin master
    +    $ git fetch origin master
         From https://github.com/git/git
          * branch                  master     -> FETCH_HEAD
          * branch                  master     -> origin/master
         ```
    =20
    -    Fix this bug by instead unconditionally passing the full reference=
 name
    -    to `display_ref_update()` which learns to call `prettify_refname()=
` on
    -    it. This does fix the above bug and is otherwise functionally the =
same
    -    as `prettify_refname()` would only ever strip the well-known prefi=
xes
    -    just as intended. So at the same time, this also simplifies the co=
de a
    -    bit.
    +    The logic of how we compute the remote reference name that we ulti=
mately
    +    pass to `display_ref_update()` is not easy to follow. There are th=
ree
    +    different cases here:
    +
    +        - When the remote reference name is "HEAD" we set the remote
    +          reference name to the empty string. This is the case that ca=
uses
    +          the bug to occur, where we would indeed want to print "HEAD"
    +          instead of the empty string. This is what `prettify_refname(=
)`
    +          would return.
    +
    +        - When the remote reference name has a well-known prefix then =
we
    +          strip this prefix. This matches what `prettify_refname()` do=
es.
    +
    +        - Otherwise, we keep the fully qualified reference name. This =
also
    +          matches what `prettify_refname()` does.
    +
    +    As the return value of `prettify_refname()` would do the correct t=
hing
    +    for us in all three cases, we can fix the bug by passing through t=
he
    +    full remote reference name to `display_ref_update()`, which learns=
 to
    +    call `prettify_refname()`. At the same time, this also simplifies =
the
    +    code a bit.
    =20
         Note that this patch also changes formatting of the block that com=
putes
         the "kind" and "what" variables. This is done on purpose so that i=
t is
    @@ t/t5574-fetch-output.sh: test_expect_success 'fetch compact output' '
     +	EOF
     +	test_cmp expect actual &&
     +
    ++	git -C head fetch origin HEAD >actual 2>&1 &&
    ++	test_cmp expect actual &&
    ++
     +	git -C head fetch --dry-run origin HEAD:foo >actual 2>&1 &&
     +	cat >expect <<-EOF &&
     +	From $(test-tool path-utils real_path .)/.
     +	 * [new ref]         HEAD       -> foo
     +	EOF
    ++	test_cmp expect actual &&
    ++
    ++	git -C head fetch origin HEAD:foo >actual 2>&1 &&
     +	test_cmp expect actual
     +'
     +
4:  8571363be1 =3D 4:  b545bf8bb9 fetch: introduce `display_format` enum
5:  d98c3ee0ce =3D 5:  4990d35998 fetch: move display format parsing into m=
ain function
6:  640a8840e1 ! 6:  cfe84129ab fetch: move option related variables into m=
ain function
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/fetch.c ##
    -@@ builtin/fetch.c: static int all, append, dry_run, force, keep, mult=
iple, update_head_ok;
    +@@ builtin/fetch.c: static int fetch_prune_tags_config =3D -1; /* unsp=
ecified */
    + static int prune_tags =3D -1; /* unspecified */
    + #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
    +=20
    +-static int all, append, dry_run, force, keep, multiple, update_head_o=
k;
    ++static int append, dry_run, force, keep, update_head_ok;
      static int write_fetch_head =3D 1;
      static int verbosity, deepen_relative, set_upstream, refetch;
      static int progress =3D -1;
    @@ builtin/fetch.c: static int fetch_one(struct remote *remote, int arg=
c, const cha
      	enum display_format display_format =3D DISPLAY_FORMAT_UNKNOWN;
      	struct string_list list =3D STRING_LIST_INIT_DUP;
      	struct remote *remote =3D NULL;
    ++	int all =3D 0, multiple =3D 0;
      	int result =3D 0;
      	int prune_tags_ok =3D 1;
     +	int enable_auto_gc =3D 1;
7:  3b2cad066a ! 7:  0335e5eeb4 fetch: introduce new `--output-format` opti=
on
    @@ Commit message
         current mechanism feels a little bit indirect and rigid.
    =20
         Introduce a new `--output-format` option that allows the user to c=
hange
    -    the desired output format more directly.
    +    the desired format more directly.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ Documentation/fetch-options.txt: linkgit:git-config[1].
      	Write the list of remote refs fetched in the `FETCH_HEAD`
    =20
      ## builtin/fetch.c ##
    +@@ builtin/fetch.c: enum display_format {
    + 	DISPLAY_FORMAT_UNKNOWN =3D 0,
    + 	DISPLAY_FORMAT_FULL,
    + 	DISPLAY_FORMAT_COMPACT,
    ++	DISPLAY_FORMAT_MAX,
    ++};
    ++
    ++static const char * const display_formats[DISPLAY_FORMAT_MAX] =3D {
    ++	NULL,
    ++	"full",
    ++	"compact",
    + };
    +=20
    + struct display_state {
    +@@ builtin/fetch.c: static int fetch_finished(int result, struct strbu=
f *out,
    + 	return 0;
    + }
    +=20
    +-static int fetch_multiple(struct string_list *list, int max_children)
    ++static int fetch_multiple(struct string_list *list, int max_children,
    ++			  enum display_format format)
    + {
    + 	int i, result =3D 0;
    + 	struct strvec argv =3D STRVEC_INIT;
    +@@ builtin/fetch.c: static int fetch_multiple(struct string_list *list=
, int max_children)
    + 		     "--no-write-commit-graph", NULL);
    + 	add_options_to_argv(&argv);
    +=20
    ++	if (format !=3D DISPLAY_FORMAT_UNKNOWN)
    ++		strvec_pushf(&argv, "--output-format=3D%s", display_formats[format]=
);
    ++
    + 	if (max_children !=3D 1 && list->nr !=3D 1) {
    + 		struct parallel_fetch_state state =3D { argv.v, list, 0, 0 };
    + 		const struct run_process_parallel_opts opts =3D {
     @@ builtin/fetch.c: static int fetch_one(struct remote *remote, int ar=
gc, const char **argv,
      	return exit_code;
      }
     =20
    ++static enum display_format parse_display_format(const char *format)
    ++{
    ++	for (int i =3D 0; i < ARRAY_SIZE(display_formats); i++)
    ++		if (display_formats[i] && !strcmp(display_formats[i], format))
    ++			return i;
    ++	return DISPLAY_FORMAT_UNKNOWN;
    ++}
    ++
     +static int opt_parse_output_format(const struct option *opt, const ch=
ar *arg, int unset)
     +{
    -+	enum display_format *format =3D opt->value;
    ++	enum display_format *format =3D opt->value, parsed;
    ++
     +	if (unset || !arg)
     +		return 1;
    -+	else if (!strcmp(arg, "full"))
    -+		*format =3D DISPLAY_FORMAT_FULL;
    -+	else if (!strcmp(arg, "compact"))
    -+		*format =3D DISPLAY_FORMAT_COMPACT;
    -+	else
    ++
    ++	parsed =3D parse_display_format(arg);
    ++	if (parsed =3D=3D DISPLAY_FORMAT_UNKNOWN)
     +		return error(_("unsupported output format '%s'"), arg);
    ++	*format =3D parsed;
     +
     +	return 0;
     +}
    @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const ch=
ar *prefix)
      		OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
      			 N_("write fetched references to the FETCH_HEAD file")),
      		OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
    +@@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
    + 		const char *format =3D "full";
    +=20
    + 		git_config_get_string_tmp("fetch.output", &format);
    +-		if (!strcasecmp(format, "full"))
    +-			display_format =3D DISPLAY_FORMAT_FULL;
    +-		else if (!strcasecmp(format, "compact"))
    +-			display_format =3D DISPLAY_FORMAT_COMPACT;
    +-		else
    ++
    ++		display_format =3D parse_display_format(format);
    ++		if (display_format =3D=3D DISPLAY_FORMAT_UNKNOWN)
    + 			die(_("invalid value for '%s': '%s'"),
    + 			    "fetch.output", format);
    + 	}
    +@@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
    + 			max_children =3D fetch_parallel_config;
    +=20
    + 		/* TODO should this also die if we have a previous partial-clone? */
    +-		result =3D fetch_multiple(&list, max_children);
    ++		result =3D fetch_multiple(&list, max_children, display_format);
    + 	}
    +=20
    +=20
    =20
      ## t/t5574-fetch-output.sh ##
     @@ t/t5574-fetch-output.sh: test_expect_success 'fetch with invalid ou=
tput format configuration' '
    @@ t/t5574-fetch-output.sh: test_expect_success 'fetch aligned output' '
      	cat >expect <<-\EOF &&
      	main       -> origin/*
      	extraaa    -> *
    +@@ t/t5574-fetch-output.sh: test_expect_success 'fetch compact output'=
 '
    + 	test_cmp expect actual
    + '
    +=20
    ++test_expect_success 'fetch compact output with multiple remotes' '
    ++	test_when_finished "rm -rf compact-cfg compact-cli" &&
    ++
    ++	git clone . compact-cli &&
    ++	git -C compact-cli remote add second-remote "$PWD" &&
    ++	git clone . compact-cfg &&
    ++	git -C compact-cfg remote add second-remote "$PWD" &&
    ++	test_commit multi-commit &&
    ++
    ++	git -C compact-cfg -c fetch.output=3Dcompact fetch --all >actual-cfg=
 2>&1 &&
    ++	git -C compact-cli fetch --output-format=3Dcompact --all >actual-cli=
 2>&1 &&
    ++	test_cmp actual-cfg actual-cli &&
    ++
    ++	grep -e "->" actual-cfg | cut -c 22- >actual &&
    ++	cat >expect <<-\EOF &&
    ++	main         -> origin/*
    ++	multi-commit -> *
    ++	main       -> second-remote/*
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    + test_expect_success 'fetch output with HEAD and --dry-run' '
    + 	test_when_finished "rm -rf head" &&
    + 	git clone . head &&
8:  301138da03 ! 8:  d7c1bc1a80 fetch: introduce machine-parseable "porcela=
in" output format
    @@ Commit message
         so that other data printed to stderr, like error messages or progr=
ess
         meters, don't interfere with the parseable data.
    =20
    +    A notable ommission here is that the output format does not includ=
e the
    +    remote from which a reference was fetched, which might be important
    +    information especially in the context of multi-remote fetches. But=
 as
    +    such a format would require us to print the remote for every single
    +    reference update due to parallelizable fetches it feels wasteful f=
or the
    +    most likely usecase, which is when fetching from a single remote. =
If
    +    usecases come up for this in the future though it is easy enough t=
o add
    +    a new "porcelain-v2" format that adds this information.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## Documentation/config/fetch.txt ##
    @@ builtin/fetch.c: enum display_format {
      	DISPLAY_FORMAT_FULL,
      	DISPLAY_FORMAT_COMPACT,
     +	DISPLAY_FORMAT_PORCELAIN,
    + 	DISPLAY_FORMAT_MAX,
    + };
    +=20
    +@@ builtin/fetch.c: static const char * const display_formats[DISPLAY_=
FORMAT_MAX] =3D {
    + 	NULL,
    + 	"full",
    + 	"compact",
    ++	"porcelain",
      };
     =20
      struct display_state {
    @@ builtin/fetch.c: static int prune_refs(struct display_state *display=
_state,
      					   summary_width);
      			warn_dangling_symref(stderr, dangling_msg, ref->name);
      		}
    -@@ builtin/fetch.c: static int opt_parse_output_format(const struct op=
tion *opt, const char *arg, in
    - 		*format =3D DISPLAY_FORMAT_FULL;
    - 	else if (!strcmp(arg, "compact"))
    - 		*format =3D DISPLAY_FORMAT_COMPACT;
    -+	else if (!strcmp(arg, "porcelain"))
    -+		*format =3D DISPLAY_FORMAT_PORCELAIN;
    - 	else
    - 		return error(_("unsupported output format '%s'"), arg);
    -=20
    -@@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
    - 			display_format =3D DISPLAY_FORMAT_FULL;
    - 		else if (!strcasecmp(format, "compact"))
    - 			display_format =3D DISPLAY_FORMAT_COMPACT;
    -+		else if (!strcasecmp(format, "porcelain"))
    -+			display_format =3D DISPLAY_FORMAT_PORCELAIN;
    - 		else
    - 			die(_("invalid value for '%s': '%s'"),
    - 			    "fetch.output", format);
    =20
      ## t/t5574-fetch-output.sh ##
    -@@ t/t5574-fetch-output.sh: test_expect_success 'fetch compact output'=
 '
    +@@ t/t5574-fetch-output.sh: test_expect_success 'fetch compact output =
with multiple remotes' '
      	test_cmp expect actual
      '
     =20
--=20
2.40.1


--jvAZmEHtjW7TCHuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRKWL8ACgkQVbJhu7ck
PpQ4kA//c05nllPwhkPUOIlyoDjgNKsx4ILGIzw48vvlwDjhKDsXvUozDZZWhL4d
EAwa+bOuvCOk++iXAmC4eHMU3xBDtL8Le6OXLtvroct+oks638n0bqKR7/RpKsuY
7JE9weW/3Jp1CNlpOiG8FFLmdEzWL2qHUMCt37PiLuKKVr9T8aXp0lHdZU4IRi9Z
Sni6zG0l5l10GlFOCcRJmkFmc99P7ZOeGqFcKFXPK8yAUpAREtXN4OuuF37LCX8H
NEHupigpH5mCY4Dm6bzgHO4wRX1z+S17RdIznct6Haf8nhfjKTkVRK1W3OrKP9N7
vA/pbbU7NmQTBLP3cwUTcjQjmpEVhCD0iF192Q3plUQSxdj90U008AGwTCQ22ojY
7LkSQAH/kHo7VeNMiu5oLlOEpshyp5apbqsx070bqHh6fgxCeUwwe/+OaFh6XNCS
3sfNEttb7l62aNpwR+yOogEHVYpZjm/8oYTr8ES3ZcMGj6C0JwpRa7WdlvHZyzik
D/oflkiPRjI8Z5mwxC6YSgMAnpQ6heiWcYCgmPCSzY+c1FUeskRcBNoRuxzFduyV
P1GhXrEzzSqERNQ3SITxQqlkvwbecJcNea7Foc1B0YNzmDLfWQa9Dig6OyduvXDZ
yNLpGNAnvSHKBYrWRTFwDMeIpXHh+nyUQx5CGav3vRAF8K35V0Y=
=auu6
-----END PGP SIGNATURE-----

--jvAZmEHtjW7TCHuf--
