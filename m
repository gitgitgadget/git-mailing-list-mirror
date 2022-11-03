Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11187C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 14:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiKCOhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 10:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiKCOhp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 10:37:45 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E9F17E35
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 07:37:41 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 518E83200991;
        Thu,  3 Nov 2022 10:37:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 03 Nov 2022 10:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667486259; x=1667572659; bh=jl4xBXg810
        S4NriE2nsjEIeJ3sDgWe9kEXLwIlVBWPQ=; b=ei6BQ9VJ1xqCAUYgQxVSjKsFcl
        P3YBV6rykxjJ6LW0N+65hgF3SCo6o4TuFow0GoyYBm7TJ3hZVpR+WJkT1pjF7FQM
        h/wTO/JwcfNgjlyStPlmgTWiLImdtzQlCGabRk/e61FzFFvox2fjBNnV4QIYesTe
        K0mEuwLhd4Z+Th1XpK4cI8Wn/91KPh4PyU5w9QIxN78h/+XEwIMDlXSAXnoiM7cn
        70DQb7OKLimTHFeDfo29a1u5oeBkcBYh98H6VyPGC8cCGoLUt2cHn05eSJiU8JFI
        KzVVbZDfsUJMw+WEZNedSDobijyTTJTS0QM1yiTe4d2Nb3c2t8dD6jckEi+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667486259; x=1667572659; bh=jl4xBXg810S4NriE2nsjEIeJ3sDg
        We9kEXLwIlVBWPQ=; b=Accv2bRADqOigjzsYqQ/KiYQC2ENE/pnTbdRn4N31vN0
        kqqJcUjmLMqUm40MEJjHfpbQ3Zz5HF5Tsu1xBz51ZaLT7J4UZ6HZgC6cDHS2FBVI
        21sL+kl+oG0hHLNFSElA8t4ownTQRWXgPUyGHprz3I4GPa1ywaNOcP7B8VF/Pmz0
        zfxYnwbd4faVoDV4BIqznOI5AZzBzF7xSYflaeP/0hOgTpaXvFS5yY2lAgMAf1tu
        UWfbxbE5pGeGE6DbwrTkQ+MV3Ch7bK5zeeFwKwLmB5UuRtyZ+4kVJlw7jKIepv79
        M/Su0gD5KiZm1bBVWsMwW2QfUu/YZnMQZ3Fs3YI6qg==
X-ME-Sender: <xms:M9JjY0IHPU8xU3r19HS06SGypVvTmiifWJwJbIiZguR04lcrIDJAWA>
    <xme:M9JjY0J_T8ZI2BtQWflzq7SfJ3p6eQSFuWRfKUN8OcARPgosMBgkQGueEkl3f5026
    DR6z_CjPzovcBCHqQ>
X-ME-Received: <xmr:M9JjY0vTZmCasBNHRvfJ5YdIsgb7wXAEY5-d7xEvAgzROgrnzAYN7eTXXQM_KHoh43j6xliRhgyzFYM_cfQDPORtWWHVi4SQLinFUBBA2Cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudelgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepteeuvefhhfdufedvgeeiueeileegtdfhge
    eftdeuveejjedtgfejhedujeeutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:M9JjYxbFpIV5gVanItGQoDgAFIeQPeI1aQ2hcsP5waZqR2wnWByCzg>
    <xmx:M9JjY7ZyxfB-sCG5CA829kMpSvkcDJ09C1i0mRXiyUII10oSHW31MQ>
    <xmx:M9JjY9D3z_047xoI2sWv7Y5NoeXtLQFOiQ07_AhoS019BIXPFtX21A>
    <xmx:M9JjY3GHccmFivHyqaoKl1Q3TwIlysUsQBrnQK_snv2BwTirM6tNxQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Nov 2022 10:37:38 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id fd19fb71 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 3 Nov 2022 14:37:19 +0000 (UTC)
Date:   Thu, 3 Nov 2022 15:37:36 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 3/3] receive-pack: only use visible refs for connectivity
 check
Message-ID: <71c3d791aa60d0024793aa72e7d94d59d3e337d6.1667485737.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667485737.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+tWhL/WS4QUBdyFL"
Content-Disposition: inline
In-Reply-To: <cover.1667485737.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+tWhL/WS4QUBdyFL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When serving a push, git-receive-pack(1) needs to verify that the
packfile sent by the client contains all objects that are required by
the updated references. This connectivity check works by marking all
preexisting references as uninteresting and using the new reference tips
as starting point for a graph walk.

Marking all preexisting references as uninteresting can be a problem
when it comes to performance. Git forges tend to do internal bookkeeping
to keep alive sets of objects for internal use or make them easy to find
via certain references. These references are typically hidden away from
the user so that they are neither advertised nor writeable. At GitLab,
we have one particular repository that contains a total of 7 million
references, of which 6.8 million are indeed internal references. With
the current connectivity check we are forced to load all these
references in order to mark them as uninteresting, and this alone takes
around 15 seconds to compute.

We can optimize this by only taking into account the set of visible refs
when marking objects as uninteresting. This means that we may now walk
more objects until we hit any object that is marked as uninteresting.
But it is rather unlikely that clients send objects that make large
parts of objects reachable that have previously only ever been hidden,
whereas the common case is to push incremental changes that build on top
of the visible object graph.

This provides a huge boost to performance in the mentioned repository,
where the vast majority of its refs hidden. Pushing a new commit into
this repo with `transfer.hideRefs` set up to hide 6.8 million of 7 refs
as it is configured in Gitaly leads to an almost 4.5-fold speedup:

    Benchmark 1: main
      Time (mean =C2=B1 =CF=83):     29.475 s =C2=B1  0.248 s    [User: 28.=
812 s, System: 1.006 s]
      Range (min =E2=80=A6 max):   29.189 s =E2=80=A6 29.636 s    3 runs

    Benchmark 2: pks-connectivity-check-hide-refs
      Time (mean =C2=B1 =CF=83):      6.657 s =C2=B1  0.027 s    [User: 6.6=
64 s, System: 0.355 s]
      Range (min =E2=80=A6 max):    6.629 s =E2=80=A6  6.682 s    3 runs

    Summary
      'pks-connectivity-check-hide-refs' ran
        4.43 =C2=B1 0.04 times faster than 'main'

As we mostly go through the same codepaths even in the case where there
are no hidden refs at all compared to the code before there is no change
in performance when no refs are hidden:

    Benchmark 1: main
      Time (mean =C2=B1 =CF=83):     48.688 s =C2=B1  1.535 s    [User: 49.=
579 s, System: 5.058 s]
      Range (min =E2=80=A6 max):   47.518 s =E2=80=A6 50.425 s    3 runs

    Benchmark 2: pks-connectivity-check-hide-refs
      Time (mean =C2=B1 =CF=83):     48.147 s =C2=B1  0.716 s    [User: 48.=
800 s, System: 5.297 s]
      Range (min =E2=80=A6 max):   47.694 s =E2=80=A6 48.973 s    3 runs

    Summary
      'pks-connectivity-check-hide-refs' ran
        1.01 =C2=B1 0.04 times faster than 'main'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/receive-pack.c | 2 ++
 connected.c            | 5 ++++-
 connected.h            | 6 ++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1f3efc58fb..be1c1d2702 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1929,6 +1929,8 @@ static void execute_commands(struct command *commands,
 	opt.err_fd =3D err_fd;
 	opt.progress =3D err_fd && !quiet;
 	opt.env =3D tmp_objdir_env(tmp_objdir);
+	opt.visible_refs_section =3D "receive";
+
 	if (check_connected(iterate_receive_command_list, &data, &opt))
 		set_connectivity_errors(commands, si);
=20
diff --git a/connected.c b/connected.c
index 74a20cb32e..c64501f755 100644
--- a/connected.c
+++ b/connected.c
@@ -100,7 +100,10 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		strvec_push(&rev_list.args, "--exclude-promisor-objects");
 	if (!opt->is_deepening_fetch) {
 		strvec_push(&rev_list.args, "--not");
-		strvec_push(&rev_list.args, "--all");
+		if (opt->visible_refs_section)
+			strvec_pushf(&rev_list.args, "--visible-refs=3D%s", opt->visible_refs_s=
ection);
+		else
+			strvec_push(&rev_list.args, "--all");
 	}
 	strvec_push(&rev_list.args, "--quiet");
 	strvec_push(&rev_list.args, "--alternate-refs");
diff --git a/connected.h b/connected.h
index 6e59c92aa3..d8396e5d55 100644
--- a/connected.h
+++ b/connected.h
@@ -46,6 +46,12 @@ struct check_connected_options {
 	 * during a fetch.
 	 */
 	unsigned is_deepening_fetch : 1;
+
+	/*
+	 * If not NULL, use `--visible-refs=3D$section` instead of `--not --all`
+	 * as the set of already-reachable references.
+	 */
+	const char *visible_refs_section;
 };
=20
 #define CHECK_CONNECTED_INIT { 0 }
--=20
2.38.1


--+tWhL/WS4QUBdyFL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNj0jAACgkQVbJhu7ck
PpRXAg//U9kQoqaWZqpPuuOHCV2YrXqjgXHbZ7cDAIqHxXRrJtPATbBT8bPxh8WZ
tn43zsmdIkujhKZ2oZCy6em+2OxNGrcWuO6UD9XgJk3+s4m9XD7uC2V7jWrTXfTk
vKawbTSq2wbj+x9dOfyPkxTqZVoOpGInSbCg7621Z5297DdRcNpJ+2KYwtrMxK1p
OujLxHsavPS8OQUwhrVfW4C1zr9b5BmKeHltep6xSs6cn0KE0rLlqnPOhqZzbiCe
VXxU6/KxTdxjOqgFZ83ZfDiTrijpe3T09+oAedzEPkZvUKnDHaiEgeGkGGp+OeuH
POPhhXb7tEmydneiNtZcQeSy6TBYk4ylCe65mQRh+TV8PfUeriJPTsJ8qGvVT6sJ
ApJ0n05oeguMi7WW8BrdBVc2NfeEcU6YVfrseYgJYgzORXu7y5/heumuF892dN2D
cbnu/ohW2PT6PN6Ne+WvFmAOBZNjD4PYDYt4A5HoAUY5I9a3kOuqXlIQyuD7uKcY
hUTiSHiPT1XCTC9/Nqf2RZyqWt5yYcWg8PIkL8isdjCengkUe/VVIQXT2ECnvGDZ
hcadLSUC+f6W69KzoZeuyQzYdiSG7amOehI8RxKrJtkMiNvPHjw990RzPyFcscgq
b8T/3sXyHo5icnOKTdN5CyemFszsPRTEiQBzbn8dQ/AcA/h2p/s=
=ndrc
-----END PGP SIGNATURE-----

--+tWhL/WS4QUBdyFL--
