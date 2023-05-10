Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BC8C7EE23
	for <git@archiver.kernel.org>; Wed, 10 May 2023 12:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbjEJMeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 08:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbjEJMeK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 08:34:10 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7FC49F7
        for <git@vger.kernel.org>; Wed, 10 May 2023 05:34:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8D6AF3200926;
        Wed, 10 May 2023 08:34:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 10 May 2023 08:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683722045; x=1683808445; bh=bG
        9g2UAXX68JCX6PtlIm9h4ttFmtEnxpnFvVWDvyPoA=; b=RFbvr4Ua4w2dKFwdOV
        9yhxhHqVy2tUqcfgfg3FPSAQwY2jR5lKUi+F7BN/Xdml6+upJ91ekh0bChmOLQ6u
        7dtdF0fxXuvvqp87+h7s6mSGPOwuj6wv5Mt9Q7ZH3LbdLN4rd8L1iwMZzDMKL9tv
        hYJHOLZBP+nlHAShuq9FV1pEnsn4FbDQaIFeAUKIdzjroZPq6apGOq7djYNg0aeX
        ZkF0Xb1SYaK6QSMfd+kT80Wl0T9Wd7PRi0nTmrOaHyqjo7WlWg54054c179oRT+T
        j2Qgdn/9aCmS29kk2zvsTkvbv0GCCAk6ZxmymJpliyKKMmBOrs2o/0zXlhZtgODI
        2+wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683722045; x=1683808445; bh=bG9g2UAXX68JC
        X6PtlIm9h4ttFmtEnxpnFvVWDvyPoA=; b=GfQDz9aGARImPdUDC27ysqZQKr7qR
        /SoC4fZ/OCaxVf4xlUBuIDXzIbQOsYdiO7JTt/rtFGOJnBLmuYk+ZjCE788ygmb1
        Lt0HZcCbgln9+ukQZTPy5ysN7z2wumlXqMOadewu4dKUr+DLEL1In0SLHh51e/lL
        B7tNpEN38Vai2vLdrZIHLh1JzdXRE7vqZ/3Lq8STwmMHDFVgdOwzL5yXf+n3Deqo
        osMtfqpPzri9jqms8A0dLFl8bIWE1bk4XkhVhkr+QbcrcKwN+LSKJKN6zpI8vpBH
        nIue8b3RsXIE4+hc3n4LFrTuzETGZNk0bIqGlfBsLp1em2Z25knZDhdCw==
X-ME-Sender: <xms:PI9bZFRiiuTqWdcSDgAiqZFf3ucPdpd3M1ScnEMoBWw5b59Q0Foeuw>
    <xme:PI9bZOxxqWjCMiTiL6dw8CJLWijspEnuE5coCP9LxWxsr2RJBFrGLwK1yWBtsWyBy
    mbfkuStnRFI6gfRPA>
X-ME-Received: <xmr:PI9bZK3hb3ErVOeepRaci_CN4Wxn8joZ5bVUyhY23TaFqRbP-Uicbp_sVrJpQwmoZ0u-lJeg2mZ1DAiQ8IWjayoVB9fzTm3eZd_aV6YlMgHb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:PI9bZNDwwyeO37Ox4iPcXtoLDa3hwaFQ-L-Dy7_r74Ag_LaguOZigQ>
    <xmx:PI9bZOgszJRcs_WEJ1e-K5k3ifrKJ0-8tiEO-IbpPm_oEgfCwc_nsQ>
    <xmx:PI9bZBorDuJFMezIahLYEfazPb6hASVpbc53hIIIR4HR0KdFT_68oA>
    <xmx:PY9bZGcxoavbkAj1dSgRF9uR7y6zE2tqyFp1AOmhDrcPmrQxJebhaQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 08:34:03 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 807c7731 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 May 2023 12:33:51 +0000 (UTC)
Date:   Wed, 10 May 2023 14:33:58 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v5 0/9] fetch: introduce machine-parseable output
Message-ID: <cover.1683721293.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="akIsRpSUSFGDMQNM"
Content-Disposition: inline
In-Reply-To: <cover.1681906948.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--akIsRpSUSFGDMQNM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth version of my patch series to introduce a
machine-parseable output format for git-fetch(1). It applies on top of
e9dffbc7f1 (Merge branch 'ps/fetch-ref-update-reporting', 2023-04-06).

Changes compared to v4:

    - Patch 1/9: Simplified the test as proposed by Junio and Glen.

    - Patch 3/9: Added a test to verify that `git fetch -c fetch.output`
      without a value set fails as expected. Also dropped the tests that
      checked whether stdout was empty.

    - Patch 4/9: Reformulated the commit message to treat the missing
      left-hand side of displayed references as an inconsistency instead
      of a bug. I've also added a testcase to verify that direct OID
      fetches continue to work as expected.

    - Patch 5/9: New patch that makes calculation of the table width for
      displayed reference updates self-contained in `refcol_width()`.
      This is a preparatory refactoring that should make patch 6/9
      easier to review.

    - Patch 7/9: Refactored the code to parse the "fetch.output" config
      variable inside of `git_fetch_config()` before we parse command
      line options. Also fixed that the commit message was still
      referring to `--output-format=3Dporcelain` instead of the new
      `--porcelain` switch.

    - Patch 9/9: The `--porcelain` option is now a simple `OPT_BOOL()`
      that can be negated. Added a test that `--no-porcelain` works as
      expected.

Thanks for your feedback, Junio and Glen!

Patrick

Patrick Steinhardt (9):
  fetch: fix `--no-recurse-submodules` with multi-remote fetches
  fetch: split out tests for output format
  fetch: add a test to exercise invalid output formats
  fetch: print left-hand side when fetching HEAD:foo
  fetch: refactor calculation of the display table width
  fetch: introduce `display_format` enum
  fetch: lift up parsing of "fetch.output" config variable
  fetch: move option related variables into main function
  fetch: introduce machine-parseable "porcelain" output format

 Documentation/fetch-options.txt |   7 +
 Documentation/git-fetch.txt     |   9 +
 builtin/fetch.c                 | 490 +++++++++++++++++++-------------
 t/t5510-fetch.sh                |  53 ----
 t/t5526-fetch-submodules.sh     |  13 +
 t/t5574-fetch-output.sh         | 293 +++++++++++++++++++
 6 files changed, 611 insertions(+), 254 deletions(-)
 create mode 100755 t/t5574-fetch-output.sh

Range-diff against v4:
 1:  d82b42ed34 !  1:  02ee4fab7e fetch: fix `--no-recurse-submodules` with=
 multi-remote fetches
    @@ t/t5526-fetch-submodules.sh: test_expect_success 'fetch --all with -=
-recurse-sub
     +		cd src_clone &&
     +		git remote add secondary ../src &&
     +		git config submodule.recurse true &&
    -+		git config fetch.parallel 0 &&
    -+		git fetch --all --no-recurse-submodules 2>../actual
    ++		git fetch --all --no-recurse-submodules 2>../fetch-log
     +	) &&
    -+
    -+	cat >expect <<-EOF &&
    -+	From ../src
    -+	 * [new branch]      master     -> secondary/master
    -+	EOF
    -+	test_cmp expect actual
    ++	! grep "Fetching submodule" fetch-log
     +'
     +
      test_done
 2:  33112dc51a =3D  2:  e459d8a1ec fetch: split out tests for output format
 3:  006ea93afb !  3:  d503c425fe fetch: add a test to exercise invalid out=
put formats
    @@ t/t5574-fetch-output.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     +	test_when_finished "rm -rf clone" &&
     +	git clone . clone &&
     +
    -+	test_must_fail git -C clone -c fetch.output=3D fetch origin >actual.=
out 2>actual.err &&
    ++	test_must_fail git -C clone -c fetch.output fetch origin 2>actual.er=
r &&
    ++	cat >expect <<-EOF &&
    ++	error: missing value for ${SQ}fetch.output${SQ}
    ++	fatal: unable to parse ${SQ}fetch.output${SQ} from command-line conf=
ig
    ++	EOF
    ++	test_cmp expect actual.err &&
    ++
    ++	test_must_fail git -C clone -c fetch.output=3D fetch origin 2>actual=
=2Eerr &&
     +	cat >expect <<-EOF &&
     +	fatal: invalid value for ${SQ}fetch.output${SQ}: ${SQ}${SQ}
     +	EOF
    -+	test_must_be_empty actual.out &&
     +	test_cmp expect actual.err &&
     +
    -+	test_must_fail git -C clone -c fetch.output=3Dgarbage fetch origin >=
actual.out 2>actual.err &&
    ++	test_must_fail git -C clone -c fetch.output=3Dgarbage fetch origin 2=
>actual.err &&
     +	cat >expect <<-EOF &&
     +	fatal: invalid value for ${SQ}fetch.output${SQ}: ${SQ}garbage${SQ}
     +	EOF
    -+	test_must_be_empty actual.out &&
     +	test_cmp expect actual.err
     +'
     +
 4:  e599ea6d33 !  4:  2cc7318697 fetch: fix missing from-reference when fe=
tching HEAD:foo
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    fetch: fix missing from-reference when fetching HEAD:foo
    +    fetch: print left-hand side when fetching HEAD:foo
    =20
         `store_updated_refs()` parses the remote reference for two purpose=
s:
    =20
    @@ Commit message
         name and can thus be used for both cases. But if the remote refere=
nce is
         HEAD, the parsed remote reference becomes empty. This is intended =
when
         we write the FETCH_HEAD, where we skip writing the note in that ca=
se.
    -    But it is not intended when displaying the updated references and =
would
    -    cause us to miss the left-hand side of the displayed reference upd=
ate:
    +    But when displaying the updated references this leads to inconsist=
ent
    +    output where the left-hand side of reference updates is missing in=
 some
    +    cases:
    =20
         ```
    -    $ git fetch origin HEAD:foo
    -    From https://github.com/git/git
    -     * [new ref]                          -> foo
    -    ```
    -
    -    The HEAD string is clearly missing from the left-hand side of the =
arrow,
    -    which is further stressed by the point that the following commands=
 show
    -    the left-hand side as expected:
    -
    -    ```
    -    $ git fetch origin HEAD
    +    $ git fetch origin HEAD HEAD:explicit-head :implicit-head main
         From https://github.com/git/git
          * branch                  HEAD       -> FETCH_HEAD
    -
    -    $ git fetch origin master
    -    From https://github.com/git/git
    -     * branch                  master     -> FETCH_HEAD
    -     * branch                  master     -> origin/master
    +     * [new ref]                          -> explicit-head
    +     * [new ref]                          -> implicit-head
    +     * branch                  main       -> FETCH_HEAD
         ```
    =20
    +    This behaviour has existed ever since the table-based output has b=
een
    +    introduced for git-fetch(1) via 165f390250 (git-fetch: more terse =
fetch
    +    output, 2007-11-03) and was never explicitly documented either in =
the
    +    commit message or in any of our tests. So while it may not be a bu=
g per
    +    se, it feels like a weird inconsistency and not like it was a conc=
ious
    +    design decision.
    +
         The logic of how we compute the remote reference name that we ulti=
mately
         pass to `display_ref_update()` is not easy to follow. There are th=
ree
         different cases here:
    =20
             - When the remote reference name is "HEAD" we set the remote
               reference name to the empty string. This is the case that ca=
uses
    -          the bug to occur, where we would indeed want to print "HEAD"
    -          instead of the empty string. This is what `prettify_refname(=
)`
    -          would return.
    +          the left-hand side to go missing, where we would indeed want=
 to
    +          print "HEAD" instead of the empty string. This is what
    +          `prettify_refname()` would return.
    =20
             - When the remote reference name has a well-known prefix then =
we
               strip this prefix. This matches what `prettify_refname()` do=
es.
    @@ Commit message
               matches what `prettify_refname()` does.
    =20
         As the return value of `prettify_refname()` would do the correct t=
hing
    -    for us in all three cases, we can fix the bug by passing through t=
he
    -    full remote reference name to `display_ref_update()`, which learns=
 to
    -    call `prettify_refname()`. At the same time, this also simplifies =
the
    -    code a bit.
    +    for us in all three cases, we can thus fix the inconsistency by pa=
ssing
    +    through the full remote reference name to `display_ref_update()`, =
which
    +    learns to call `prettify_refname()`. At the same time, this also
    +    simplifies the code a bit.
    =20
         Note that this patch also changes formatting of the block that com=
putes
    -    the "kind" and "what" variables. This is done on purpose so that i=
t is
    -    part of the diff, hopefully making the change easier to comprehend.
    +    the "kind" (which is the category like "branch" or "tag") and "wha=
t"
    +    (which is the prettified reference name like "master" or "v1.0")
    +    variables. This is done on purpose so that it is part of the diff,
    +    hopefully making the change easier to comprehend.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ t/t5574-fetch-output.sh: test_expect_success 'fetch compact output' '
     +	test_must_be_empty actual.out &&
     +	test_cmp expect actual.err
     +'
    ++
    ++test_expect_success 'fetch output with object ID' '
    ++	test_when_finished "rm -rf object-id" &&
    ++	git clone . object-id &&
    ++	commit=3D$(git rev-parse HEAD) &&
    ++
    ++	git -C object-id fetch --dry-run origin $commit:object-id >actual.ou=
t 2>actual.err &&
    ++	cat >expect <<-EOF &&
    ++	From $(test-tool path-utils real_path .)/.
    ++	 * [new ref]         $commit -> object-id
    ++	EOF
    ++	test_must_be_empty actual.out &&
    ++	test_cmp expect actual.err &&
    ++
    ++	git -C object-id fetch origin $commit:object-id >actual.out 2>actual=
=2Eerr &&
    ++	test_must_be_empty actual.out &&
    ++	test_cmp expect actual.err
    ++'
     +
      test_expect_success '--no-show-forced-updates' '
      	mkdir forced-updates &&
 -:  ---------- >  5:  bb1a591c2f fetch: refactor calculation of the displa=
y table width
 5:  80ac00b0c4 !  6:  3cac552f5f fetch: introduce `display_format` enum
    @@ builtin/fetch.c: enum {
     =20
      	char *url;
      	int url_len, shown_url;
    -@@ builtin/fetch.c: static int refcol_width(const struct ref *ref, int=
 compact_format)
    - static void display_state_init(struct display_state *display_state, s=
truct ref *ref_map,
    - 			       const char *raw_url)
    - {
    --	struct ref *rm;
    - 	const char *format =3D "full";
    - 	int i;
    -=20
     @@ builtin/fetch.c: static void display_state_init(struct display_stat=
e *display_state, struct ref *
     =20
      	git_config_get_string_tmp("fetch.output", &format);
    @@ builtin/fetch.c: static void display_state_init(struct display_state=
 *display_st
      		die(_("invalid value for '%s': '%s'"),
      		    "fetch.output", format);
     =20
    --	display_state->refcol_width =3D 10;
    --	for (rm =3D ref_map; rm; rm =3D rm->next) {
    --		int width;
    +-	display_state->refcol_width =3D refcol_width(ref_map, display_state-=
>compact_format);
     +	switch (display_state->format) {
     +	case DISPLAY_FORMAT_FULL:
    -+	case DISPLAY_FORMAT_COMPACT: {
    -+		struct ref *rm;
    -=20
    --		if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW ||
    --		    !rm->peer_ref ||
    --		    !strcmp(rm->name, "HEAD"))
    --			continue;
    -+		display_state->refcol_width =3D 10;
    -+		for (rm =3D ref_map; rm; rm =3D rm->next) {
    -+			int width;
    -=20
    --		width =3D refcol_width(rm, display_state->compact_format);
    -+			if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW ||
    -+			    !rm->peer_ref ||
    -+			    !strcmp(rm->name, "HEAD"))
    -+				continue;
    -=20
    --		/*
    --		 * Not precise calculation for compact mode because '*' can
    --		 * appear on the left hand side of '->' and shrink the column
    --		 * back.
    --		 */
    --		if (display_state->refcol_width < width)
    --			display_state->refcol_width =3D width;
    -+			width =3D refcol_width(rm, display_state->format =3D=3D DISPLAY_FO=
RMAT_COMPACT);
    -+
    -+			/*
    -+			 * Not precise calculation for compact mode because '*' can
    -+			 * appear on the left hand side of '->' and shrink the column
    -+			 * back.
    -+			 */
    -+			if (display_state->refcol_width < width)
    -+				display_state->refcol_width =3D width;
    -+		}
    -+
    ++	case DISPLAY_FORMAT_COMPACT:
    ++		display_state->refcol_width =3D refcol_width(ref_map,
    ++							   display_state->format =3D=3D DISPLAY_FORMAT_COMPACT);
     +		break;
    -+	}
     +	default:
     +		BUG("unexpected display format %d", display_state->format);
    - 	}
    ++	}
      }
     =20
    + static void display_state_release(struct display_state *display_state)
     @@ builtin/fetch.c: static void display_ref_update(struct display_stat=
e *display_state, char code,
      			       const char *remote, const char *local,
      			       int summary_width)
 6:  826b8b7bc0 !  7:  0c3dbcd09f fetch: move display format parsing into m=
ain function
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    fetch: move display format parsing into main function
    +    fetch: lift up parsing of "fetch.output" config variable
    =20
         Parsing the display format happens inside of `display_state_init()=
`. As
         we only need to check for a simple config entry, this is a natural
         location to put this code as it means that display-state logic is =
neatly
         contained in a single location.
    =20
    -    We're about to introduce a output format though that is intended t=
o be
    -    parseable by machines, for example inside of a script. In that cas=
e it
    -    becomes a bit awkward of an interface if you have to call git-fetc=
h(1)
    -    with the `fetch.output` config key set. We're thus going to introd=
uce a
    -    new `--output-format` switch for git-fetch(1) so that the output f=
ormat
    -    can be configured more directly.
    -
    -    This means we'll have to hook parsing of the display format into t=
he
    -    command line options parser. Having the code to determine the actu=
al
    -    output format scattered across two different sites is hard to reas=
on
    -    about though.
    +    We're about to introduce a new "porcelain" output format though th=
at is
    +    intended to be parseable by machines, for example inside of a scri=
pt.
    +    This format can be enabled by passing the `--porcelain` switch to
    +    git-fetch(1). As a consequence, we'll have to add a second callsit=
e that
    +    influences the output format, which will become awkward to handle.
    =20
         Refactor the code such that callers are expected to pass the displ=
ay
         format that is to be used into `display_state_init()`. This allows=
 us to
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/fetch.c ##
    -@@ builtin/fetch.c: static int refcol_width(const struct ref *ref, int=
 compact_format)
    +@@ builtin/fetch.c: static int fetch_write_commit_graph =3D -1;
    + static int stdin_refspecs =3D 0;
    + static int negotiate_only;
    +=20
    ++struct fetch_config {
    ++	enum display_format display_format;
    ++};
    ++
    + static int git_fetch_config(const char *k, const char *v, void *cb)
    + {
    ++	struct fetch_config *fetch_config =3D cb;
    ++
    + 	if (!strcmp(k, "fetch.prune")) {
    + 		fetch_prune_config =3D git_config_bool(k, v);
    + 		return 0;
    +@@ builtin/fetch.c: static int git_fetch_config(const char *k, const c=
har *v, void *cb)
    + 		return 0;
    + 	}
    +=20
    ++	if (!strcmp(k, "fetch.output")) {
    ++		if (!v)
    ++			return config_error_nonbool(k);
    ++		else if (!strcasecmp(v, "full"))
    ++			fetch_config->display_format =3D DISPLAY_FORMAT_FULL;
    ++		else if (!strcasecmp(v, "compact"))
    ++			fetch_config->display_format =3D DISPLAY_FORMAT_COMPACT;
    ++		else
    ++			die(_("invalid value for '%s': '%s'"),
    ++			    "fetch.output", v);
    ++	}
    ++
    + 	return git_default_config(k, v, cb);
    + }
    +=20
    +@@ builtin/fetch.c: static int refcol_width(const struct ref *ref_map,=
 int compact_format)
      }
     =20
      static void display_state_init(struct display_state *display_state, s=
truct ref *ref_map,
    @@ builtin/fetch.c: static void display_state_init(struct display_state=
 *display_st
     -
      	switch (display_state->format) {
      	case DISPLAY_FORMAT_FULL:
    - 	case DISPLAY_FORMAT_COMPACT: {
    + 	case DISPLAY_FORMAT_COMPACT:
     @@ builtin/fetch.c: static int backfill_tags(struct display_state *dis=
play_state,
      }
     =20
    @@ builtin/fetch.c: static int fetch_one(struct remote *remote, int arg=
c, const cha
      	sigchain_pop(SIGPIPE);
      	refspec_clear(&rs);
      	transport_disconnect(gtransport);
    -@@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
    +@@ builtin/fetch.c: static int fetch_one(struct remote *remote, int ar=
gc, const char **argv,
    +=20
    + int cmd_fetch(int argc, const char **argv, const char *prefix)
      {
    ++	struct fetch_config config =3D {
    ++		.display_format =3D DISPLAY_FORMAT_FULL,
    ++	};
      	int i;
      	const char *bundle_uri;
    -+	enum display_format display_format =3D DISPLAY_FORMAT_UNKNOWN;
      	struct string_list list =3D STRING_LIST_INIT_DUP;
    - 	struct remote *remote =3D NULL;
    - 	int result =3D 0;
     @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
    - 	argc =3D parse_options(argc, argv, prefix,
    - 			     builtin_fetch_options, builtin_fetch_usage, 0);
    -=20
    -+	if (display_format =3D=3D DISPLAY_FORMAT_UNKNOWN) {
    -+		const char *format =3D "full";
    -+
    -+		git_config_get_string_tmp("fetch.output", &format);
    -+		if (!strcasecmp(format, "full"))
    -+			display_format =3D DISPLAY_FORMAT_FULL;
    -+		else if (!strcasecmp(format, "compact"))
    -+			display_format =3D DISPLAY_FORMAT_COMPACT;
    -+		else
    -+			die(_("invalid value for '%s': '%s'"),
    -+			    "fetch.output", format);
    -+	}
    -+
    - 	if (recurse_submodules_cli !=3D RECURSE_SUBMODULES_DEFAULT)
    - 		recurse_submodules =3D recurse_submodules_cli;
    + 		free(anon);
    + 	}
     =20
    +-	git_config(git_fetch_config, NULL);
    ++	git_config(git_fetch_config, &config);
    + 	if (the_repository->gitdir) {
    + 		prepare_repo_settings(the_repository);
    + 		the_repository->settings.command_requires_full_index =3D 0;
     @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
      	} else if (remote) {
      		if (filter_options.choice || has_promisor_remote())
      			fetch_one_setup_partial(remote);
     -		result =3D fetch_one(remote, argc, argv, prune_tags_ok, stdin_refsp=
ecs);
     +		result =3D fetch_one(remote, argc, argv, prune_tags_ok, stdin_refsp=
ecs,
    -+				   display_format);
    ++				   config.display_format);
      	} else {
      		int max_children =3D max_jobs;
     =20
 7:  20f2e061d6 !  8:  8e33a08c35 fetch: move option related variables into=
 main function
    @@ builtin/fetch.c: static struct string_list deepen_not =3D STRING_LIS=
T_INIT_NODUP;
     -static int stdin_refspecs =3D 0;
     -static int negotiate_only;
     =20
    - static int git_fetch_config(const char *k, const char *v, void *cb)
    - {
    + struct fetch_config {
    + 	enum display_format display_format;
     @@ builtin/fetch.c: static int parse_refmap_arg(const struct option *o=
pt, const char *arg, int unset
      	return 0;
      }
    @@ builtin/fetch.c: static int parse_refmap_arg(const struct option *op=
t, const cha
      static void unlock_pack(unsigned int flags)
      {
      	if (gtransport)
    -@@ builtin/fetch.c: static int fetch_one(struct remote *remote, int ar=
gc, const char **argv,
    -=20
    - int cmd_fetch(int argc, const char **argv, const char *prefix)
    - {
    +@@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
    + 	struct fetch_config config =3D {
    + 		.display_format =3D DISPLAY_FORMAT_FULL,
    + 	};
     -	int i;
    - 	const char *bundle_uri;
     +	const char *submodule_prefix =3D "";
    - 	enum display_format display_format =3D DISPLAY_FORMAT_UNKNOWN;
    + 	const char *bundle_uri;
      	struct string_list list =3D STRING_LIST_INIT_DUP;
      	struct remote *remote =3D NULL;
     +	int all =3D 0, multiple =3D 0;
 8:  24ae381950 !  9:  d49152c220 fetch: introduce machine-parseable "porce=
lain" output format
    @@ builtin/fetch.c: enum display_format {
     =20
      struct display_state {
     @@ builtin/fetch.c: static void display_state_init(struct display_stat=
e *display_state, struct ref *
    -=20
    + 		display_state->refcol_width =3D refcol_width(ref_map,
    + 							   display_state->format =3D=3D DISPLAY_FORMAT_COMPACT);
      		break;
    - 	}
     +	case DISPLAY_FORMAT_PORCELAIN:
     +		/* We don't need to precompute anything here. */
     +		break;
    @@ builtin/fetch.c: static int fetch_multiple(struct string_list *list,=
 int max_chi
      				printf(_("Fetching %s\n"), name);
      			cmd.git_cmd =3D 1;
      			if (run_command(&cmd)) {
    -@@ builtin/fetch.c: static int fetch_one(struct remote *remote, int ar=
gc, const char **argv,
    - 	return exit_code;
    - }
    +@@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
    + 	int fetch_write_commit_graph =3D -1;
    + 	int stdin_refspecs =3D 0;
    + 	int negotiate_only =3D 0;
    ++	int porcelain =3D 0;
    + 	int i;
     =20
    -+static int opt_parse_porcelain(const struct option *opt, const char *=
arg, int unset)
    -+{
    -+	enum display_format *format =3D opt->value;
    -+	*format =3D DISPLAY_FORMAT_PORCELAIN;
    -+	return 0;
    -+}
    -+
    - int cmd_fetch(int argc, const char **argv, const char *prefix)
    - {
    - 	const char *bundle_uri;
    + 	struct option builtin_fetch_options[] =3D {
     @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
      			    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
      		OPT_BOOL(0, "dry-run", &dry_run,
      			 N_("dry run")),
    -+		OPT_CALLBACK_F(0, "porcelain", &display_format, NULL, N_("machine-r=
eadable output"),
    -+			       PARSE_OPT_NOARG|PARSE_OPT_NONEG, opt_parse_porcelain),
    ++		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
      		OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
      			 N_("write fetched references to the FETCH_HEAD file")),
      		OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
    @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const ch=
ar *prefix)
      		fetch_config_from_gitmodules(sfjc, rs);
      	}
     =20
    -+	if (display_format =3D=3D DISPLAY_FORMAT_PORCELAIN) {
    ++
    ++	if (porcelain) {
     +		switch (recurse_submodules_cli) {
     +		case RECURSE_SUBMODULES_OFF:
     +		case RECURSE_SUBMODULES_DEFAULT:
    @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const ch=
ar *prefix)
     +			die(_("options '%s' and '%s' cannot be used together"),
     +			    "--porcelain", "--recurse-submodules");
     +		}
    ++
    ++		config.display_format =3D DISPLAY_FORMAT_PORCELAIN;
     +	}
     +
      	if (negotiate_only && !negotiation_tip.nr)
    @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const ch=
ar *prefix)
     =20
      		/* TODO should this also die if we have a previous partial-clone? */
     -		result =3D fetch_multiple(&list, max_children);
    -+		result =3D fetch_multiple(&list, max_children, display_format);
    ++		result =3D fetch_multiple(&list, max_children, config.display_forma=
t);
      	}
     =20
    -=20
    +-
    + 	/*
    + 	 * This is only needed after fetch_one(), which does not fetch
    + 	 * submodules by itself.
     @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
      		if (max_children < 0)
      			max_children =3D fetch_parallel_config;
     =20
     -		add_options_to_argv(&options);
    -+		add_options_to_argv(&options, display_format);
    ++		add_options_to_argv(&options, config.display_format);
      		result =3D fetch_submodules(the_repository,
      					  &options,
      					  submodule_prefix,
    @@ t/t5574-fetch-output.sh: test_expect_success 'fetch compact output' '
     +	test_must_be_empty stderr &&
     +	test_cmp expect stdout
     +'
    ++
    ++test_expect_success 'fetch --no-porcelain overrides previous --porcel=
ain' '
    ++	test_when_finished "rm -rf no-porcelain" &&
    ++
    ++	git switch --create no-porcelain &&
    ++	git clone . no-porcelain &&
    ++	test_commit --no-tag no-porcelain &&
    ++	old_commit=3D$(git rev-parse --short HEAD~) &&
    ++	new_commit=3D$(git rev-parse --short HEAD) &&
    ++
    ++	cat >expect <<-EOF &&
    ++	From $(test-tool path-utils real_path .)/.
    ++	   $old_commit..$new_commit  no-porcelain -> origin/no-porcelain
    ++	EOF
    ++
    ++	git -C no-porcelain fetch --porcelain --no-porcelain >stdout 2>stder=
r &&
    ++	test_cmp expect stderr &&
    ++	test_must_be_empty stdout
    ++'
     +
      test_expect_success 'fetch output with HEAD' '
      	test_when_finished "rm -rf head" &&
    @@ t/t5574-fetch-output.sh: test_expect_success 'fetch output with HEAD=
' '
     +	test_cmp expect actual
     +'
     +
    - test_expect_success '--no-show-forced-updates' '
    - 	mkdir forced-updates &&
    - 	(
    + test_expect_success 'fetch output with object ID' '
    + 	test_when_finished "rm -rf object-id" &&
    + 	git clone . object-id &&
--=20
2.40.1


--akIsRpSUSFGDMQNM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRbjzUACgkQVbJhu7ck
PpRD6A//ZRGjutSKGrhw9qUene8IOBhSrzJ57dlImoD33HkONbFsne59WgLdlf2K
LHvyh9cpBzl4plgNdDIurgxbJz+BtVTTZ4XzlRhFyvJM4kmsBYGyiEiVIM4u73JT
QekrFCyYVp4QVeizz8fbje/gZBGaGfcQY+PFeVOD9WU9M5pCNzIU3nFcg8sEVt8J
x0Pdk12MsGFPp/RC9SqObLD36SGFS3yexp1CQlHiF538xdOaDPv1iprtOvCp6yUu
95PvPyCas0Z40IFNMLP7tXxX6yBRwA34VGOmx0NiTQjag0vIyH9SFwfQZvIJGH7k
WRgw8GzyPTUiIp7bFIGhtnkaOFI1iWR9aTSWi9B81b8FDUo4NwdOgGdoD36lX1gs
SA5GAY1ctQco6MazFRZy13NsIu2Z5RSkE6ecfPeF44oSBZXKb9UVvv06oT4PcAM/
AmFdgLeUzBsziO8WpNwIBNHBrxHLHgd4mP1gCm0CbcW5CCYSW94IR3RNvTOmSxiW
R4aWEBOPQzIq/9r7GBjpH7bNsp/kRiMSbgqqObHKU1O0H9UegMx1hNPyiNujqYOd
DXaRbnzGr/k3Dg3A0EE7i9clcCvP8GyRXcgJGMKW0i5XJZFvKG3ZDutdXU6NTllz
CeJTBzt8mTE9VzHLumg33J2P1bw7y+z4zRVOie/ntkCK+llCMTc=
=3YT6
-----END PGP SIGNATURE-----

--akIsRpSUSFGDMQNM--
