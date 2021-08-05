Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B22C4320A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 718506112D
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241004AbhHELZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 07:25:47 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44057 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240992AbhHELZp (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Aug 2021 07:25:45 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 846815C0057;
        Thu,  5 Aug 2021 07:25:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 05 Aug 2021 07:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=wIdT187urxsZ+ugFCKm5eRmv8lR
        s/tUi4ybukcDS7F8=; b=QfIB4nWElak8JnxEds+WslvjrkIOd122w9weletMUJm
        5btuMjJOwz8Et9YgSj7LoE+w8Z9YP7sygWZENpF1kdGRapLFx4yWalZvBPxyPhYX
        bWYKhzsizwvGNbyt7ORs+znzyJDn9DgSljjicbvFoTnG9QKqDeWlQfhOEJL+/ESz
        xDXKzkNBLkK5LK9yJlazm9qpC2M4MsuB0mi3l/4lkZHWyOwf3y+wHB7aWsnLWt/Z
        Jh0esty0TRwyCEHCycHDdGye3YeUCrqTeOMbPjd85kLfNlJp/aXTTYDgpiGf3c4K
        E/oAmLRM8vpSCvLPxFsy9eVq2usjHfnK2qqyZRGYXIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=wIdT18
        7urxsZ+ugFCKm5eRmv8lRs/tUi4ybukcDS7F8=; b=IR98Vl0MzLBxcpr2xsDSIF
        FXnAAqRS/omLU5hpg8OzIEE4TxtkNV3+RaqYUq5ihbQkMKzcuooZnQCD6HRDGT3i
        cjy94tLNM1yBCOt7k+3D3OW2toU4j6XqYt54TyHrW8wF5Kw5wXUG2khgZ3DGpL5w
        BYSFPxhPtiLeOEcdOVbiLmaLERCEKiybD9IerYdGQTwXtfP6RqEaxzlVBsd5+VMf
        2s1cPt/iWBvHqhtf1eia1w3uSgLx3RiZeCq/1Ol63cxu9fgQTTWcoe2UlcBcY6Gs
        k8X2Dw/WmsoEAOmhG8d6kO30vJgpWLoQO9VrLLcD/LRQTDEvJGAKqd1j2kdxFoyA
        ==
X-ME-Sender: <xms:q8oLYa4ni9FEVUd8HdiDARU5ey4tqzN2U4gSdZIwyPMui9LSlkPT6g>
    <xme:q8oLYT5VRP7TFWJyK7VCbnoeNMNYDiHhg4JusZShNjmTYmW1I68Q5thch1S6aIhUt
    iigSQzHDBTz3SbMKA>
X-ME-Received: <xmr:q8oLYZdXNvhbpijZgDwS4lclWGIiY0hiSVzIDPr5n453FkxMAYR6wcDUfZcRcWgRj7NntwsOzHbnItHFdilOgUPJbJM9bLcdwoR2nBVlyZ8MYcg64rtMl2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveduueeitefgieevvefgtdeuueevveeggeevgfegvdeuleeivdelleelkeeuvddunecu
    ffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:q8oLYXJh7Hef-8uYBg2gGrZ8z1g8V_pthtKPQBvWDJ89rXsPI6f2GA>
    <xmx:q8oLYeKtjVz-3CbUtD3zncwsh1EpR7BiB0f8jBbswBxovP0iDIsXmA>
    <xmx:q8oLYYyxynvtS4Ks1YjmQ36R61thidxwJZ52CG-D3bARWlzyks-5KQ>
    <xmx:q8oLYW_U6TAGOKYMC_0H4VsiDmtbOv6nN3M1xK0lDvAWBo9kygoFsQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 07:25:30 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a3568f38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Aug 2021 11:25:30 +0000 (UTC)
Date:   Thu, 5 Aug 2021 13:25:28 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 2/6] connected: do not sort input revisions
Message-ID: <9d7f484907e2bd2492e6676238579e9f0c6ed374.1628162156.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1628162156.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jKRFhBum+NdPou5e"
Content-Disposition: inline
In-Reply-To: <cover.1628162156.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jKRFhBum+NdPou5e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to compute whether objects reachable from a set of tips are all
connected, we do a revision walk with these tips as positive references
and `--not --all`. `--not --all` will cause the revision walk to load
all preexisting references as uninteresting, which can be very expensive
in repositories with many references.

Benchmarking the git-rev-list(1) command highlights that by far the most
expensive single phase is initial sorting of the input revisions: after
all references have been loaded, we first sort commits by author date.
In a real-world repository with about 2.2 million references, it makes
up about 40% of the total runtime of git-rev-list(1).

Ultimately, the connectivity check shouldn't really bother about the
order of input revisions at all. We only care whether we can actually
walk all objects until we hit the cut-off point. So sorting the input is
a complete waste of time.

Introduce a new "--unsorted-input" flag to git-rev-list(1) which will
cause it to not sort the commits and adjust the connectivity check to
always pass the flag. This results in the following speedups, executed
in a clone of gitlab-org/gitlab [1]:

    Benchmark #1: git rev-list  --objects --quiet --not --all --not $(cat n=
ewrev)
      Time (mean =C2=B1 =CF=83):      7.639 s =C2=B1  0.065 s    [User: 7.3=
04 s, System: 0.335 s]
      Range (min =E2=80=A6 max):    7.543 s =E2=80=A6  7.742 s    10 runs

    Benchmark #2: git rev-list --unsorted-input --objects --quiet --not --a=
ll --not $newrev
      Time (mean =C2=B1 =CF=83):      4.995 s =C2=B1  0.044 s    [User: 4.6=
57 s, System: 0.337 s]
      Range (min =E2=80=A6 max):    4.909 s =E2=80=A6  5.048 s    10 runs

    Summary
      'git rev-list --unsorted-input --objects --quiet --not --all --not $(=
cat newrev)' ran
        1.53 =C2=B1 0.02 times faster than 'git rev-list  --objects --quiet=
 --not --all --not $newrev'

[1]: https://gitlab.com/gitlab-org/gitlab.git. Note that not all refs
     are visible to clients.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/rev-list-options.txt |  8 ++++++-
 connected.c                        |  1 +
 revision.c                         | 13 ++++++++--
 t/t6000-rev-list-misc.sh           | 38 ++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-op=
tions.txt
index 24569b06d1..b7bd27e171 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -968,6 +968,11 @@ list of the missing objects.  Object IDs are prefixed =
with a ``?'' character.
 	objects.
 endif::git-rev-list[]
=20
+--unsorted-input::
+	Show commits in the order they were given on the command line instead
+	of sorting them in reverse chronological order by commit time. Cannot
+	be combined with `--no-walk` or `--no-walk=3Dsorted`.
+
 --no-walk[=3D(sorted|unsorted)]::
 	Only show the given commits, but do not traverse their ancestors.
 	This has no effect if a range is specified. If the argument
@@ -975,7 +980,8 @@ endif::git-rev-list[]
 	given on the command line. Otherwise (if `sorted` or no argument
 	was given), the commits are shown in reverse chronological order
 	by commit time.
-	Cannot be combined with `--graph`.
+	Cannot be combined with `--graph`. Cannot be combined with
+	`--unsorted-input` if `sorted` or no argument was given.
=20
 --do-walk::
 	Overrides a previous `--no-walk`.
diff --git a/connected.c b/connected.c
index b18299fdf0..b5f9523a5f 100644
--- a/connected.c
+++ b/connected.c
@@ -106,6 +106,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	if (opt->progress)
 		strvec_pushf(&rev_list.args, "--progress=3D%s",
 			     _("Checking connectivity"));
+	strvec_push(&rev_list.args, "--unsorted-input");
=20
 	rev_list.git_cmd =3D 1;
 	rev_list.env =3D opt->env;
diff --git a/revision.c b/revision.c
index 86bbcd10d2..793f76a509 100644
--- a/revision.c
+++ b/revision.c
@@ -2256,6 +2256,10 @@ static int handle_revision_opt(struct rev_info *revs=
, int argc, const char **arg
 	} else if (!strcmp(arg, "--author-date-order")) {
 		revs->sort_order =3D REV_SORT_BY_AUTHOR_DATE;
 		revs->topo_order =3D 1;
+	} else if (!strcmp(arg, "--unsorted-input")) {
+		if (revs->no_walk && !revs->unsorted_input)
+			die(_("--unsorted-input is incompatible with --no-walk and --no-walk=3D=
sorted"));
+		revs->unsorted_input =3D 1;
 	} else if (!strcmp(arg, "--early-output")) {
 		revs->early_output =3D 100;
 		revs->topo_order =3D 1;
@@ -2651,6 +2655,8 @@ static int handle_revision_pseudo_opt(const char *sub=
module,
 	} else if (!strcmp(arg, "--not")) {
 		*flags ^=3D UNINTERESTING | BOTTOM;
 	} else if (!strcmp(arg, "--no-walk")) {
+		if (revs->unsorted_input)
+			die(_("--no-walk is incompatible with --no-walk=3Dunsorted and --unsort=
ed-input"));
 		revs->no_walk =3D 1;
 	} else if (skip_prefix(arg, "--no-walk=3D", &optarg)) {
 		/*
@@ -2658,9 +2664,12 @@ static int handle_revision_pseudo_opt(const char *su=
bmodule,
 		 * not allowed, since the argument is optional.
 		 */
 		revs->no_walk =3D 1;
-		if (!strcmp(optarg, "sorted"))
+		if (!strcmp(optarg, "sorted")) {
+			if (revs->unsorted_input)
+				die(_("--no-walk=3Dsorted is incompatible with --no-walk=3Dunsorted "
+				    "and --unsorted-input"));
 			revs->unsorted_input =3D 0;
-		else if (!strcmp(optarg, "unsorted"))
+		} else if (!strcmp(optarg, "unsorted"))
 			revs->unsorted_input =3D 1;
 		else
 			return error("invalid argument to --no-walk");
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 12def7bcbf..8e213eb413 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -169,4 +169,42 @@ test_expect_success 'rev-list --count --objects' '
 	test_line_count =3D $count actual
 '
=20
+test_expect_success 'rev-list --unsorted-input results in different sortin=
g' '
+	git rev-list --unsorted-input HEAD HEAD~ >first &&
+	git rev-list --unsorted-input HEAD~ HEAD >second &&
+	! test_cmp first second &&
+	sort first >first.sorted &&
+	sort second >second.sorted &&
+	test_cmp first.sorted second.sorted
+'
+
+test_expect_success 'rev-list --unsorted-input compatible with --no-walk=
=3Dunsorted' '
+	git rev-list --unsorted-input --no-walk=3Dunsorted HEAD HEAD~ >actual &&
+	git rev-parse HEAD >expect &&
+	git rev-parse HEAD~ >>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-list --unsorted-input incompatible with --no-walk=
=3Dsorted' '
+	cat >expect <<-EOF &&
+		fatal: --no-walk is incompatible with --no-walk=3Dunsorted and --unsorte=
d-input
+	EOF
+	test_must_fail git rev-list --unsorted-input --no-walk HEAD 2>error &&
+	test_cmp expect error &&
+
+	cat >expect <<-EOF &&
+		fatal: --no-walk=3Dsorted is incompatible with --no-walk=3Dunsorted and =
--unsorted-input
+	EOF
+	test_must_fail git rev-list --unsorted-input --no-walk=3Dsorted HEAD 2>er=
ror &&
+	test_cmp expect error &&
+
+	cat >expect <<-EOF &&
+		fatal: --unsorted-input is incompatible with --no-walk and --no-walk=3Ds=
orted
+	EOF
+	test_must_fail git rev-list --no-walk --unsorted-input HEAD 2>error &&
+	test_cmp expect error &&
+	test_must_fail git rev-list --no-walk=3Dsorted --unsorted-input HEAD 2>er=
ror &&
+	test_cmp expect error
+'
+
 test_done
--=20
2.32.0


--jKRFhBum+NdPou5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmELyqcACgkQVbJhu7ck
PpT2CxAAmlSFAkj9NPILs+ZaOhRvnp5YJSGHXRKqevQQkGPo35eADhPyxAr3O+F8
rwgm0fxFX8vC5UKDhW9CJh7Zpvv9ZbmDc5U3gVwhmlQz/I8FJXnCw/UftFAHC63Q
pJ8WCU0mMq37t/JpqZorpSKc0KCoiXEMxpD10Iu/d/LLVpHs+iGYatzZkF+NCUfl
vX10zhqgxFbc6Cc1NPVga8dLGDYFoqqap/37/zWy7tVpkNeJ716HvVQ4UlY3Z0xd
0uca2S03iIAY0hWV2G015u7HB03OeKuO+r3/WWKpflQGn2eGCbVl2NRs//cZA8x+
4nmGBmhG8kjZjZDIi4gVIf8vnhuFVft4pdPW/M9Cc5PeVCUE465SBGo/AluWx4kD
Gd/ewQqZm3xmMQ+KWdrEH+w3l+RS6wKsEbh1kfuXByYaotXsieqGBimMvG7OOosa
DnRLWISyJU7AAmKm20gC33CTxpUutCto+UiWAJ58wOiODw5u2sgoCDwAu3F+R++L
uDp8V8SLJSf7VnlDDdNR1kmqX0h0LqbvGuqp3TecCB/xt7Cy49UxnkbCQUkvkRvn
gmMjeQ8grxXZFUb/kTw1eLkw4pe/WlooVraaZ064y6qvPDCUqtCL8HUiAItoGzR0
j/7jOwS0XRnflDBcOmKdovbW5K4TQp8V+deOh6+InyS+fJQfZ/M=
=qLd1
-----END PGP SIGNATURE-----

--jKRFhBum+NdPou5e--
