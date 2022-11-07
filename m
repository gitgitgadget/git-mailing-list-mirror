Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F6C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 12:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiKGMRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 07:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiKGMRW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 07:17:22 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5FB55A8
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 04:17:21 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E15453200997;
        Mon,  7 Nov 2022 07:16:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 07 Nov 2022 07:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667823406; x=1667909806; bh=a0myhg9ixf
        v3MMs55HXIdrPjUze9f5kr/SI8SroqRbI=; b=EwywDwUO7y3tL/P+lXg/4QRgdd
        hiLDEgXHwcFaSunAfmyupg7nwIWlWKhXrHVGGWsK0IbztkpPaeTYeQ6+zW1WpWja
        l/fOTbGl9jCjtLsGfjFZTk9pRDvi+yCkBkU+5to4Cp+VPgePwd1o+wAXAkA9U0NA
        N7jbezfdKxyg+8XQiuYAAhWWMs6msG+DdUgbamKId89OVabrhsvv/uRJ3BdXOJ1o
        ed1xuqkJos/ahWnLh8lYPg3HwhRcvKsNBvrZuUu2Cgvsq7XbIE3FHMxNR+unK2Sd
        sGz+RPRRfFcoYQzqMKxzmNLp2LSnOIc5j2NqsFR/cQjcmcnri6D1c6fgpk6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667823406; x=1667909806; bh=a0myhg9ixfv3MMs55HXIdrPjUze9
        f5kr/SI8SroqRbI=; b=CyAqm0znPhbzKd64bZyVAUvrcNzYPMTyNba6/AzYB3l5
        XEp5q97MIiVhmNTnbleI1MKrkzKNTF+ghyvsomcKJchAkUgUiLVSAAcUBeekZZB5
        TDIAojRdMJgLM9E/FPWY1YQ6snv62KJWvY8TJ2sS47UisBF1Po9jwrgm66DmuBXx
        HIRk2oP+HYVF1PYoVoyR7YfQliLAbd4Jr0OJCSilRlnPNUu6/9xV97wmir20aWOU
        JSYScBLit7Dfd5d6Hhu5WYBOhtZQH6REeoSvYk54EcM5FX5SCaHO8BJJjJEGUbo/
        mVelgFKYlEB1L1ym8HYBMqXo1xG1Z5QRAdpGFs14GA==
X-ME-Sender: <xms:LvdoYyia9E7Bz6On0cyLCD5mcrlqkwO0IJNNXsk352KK8SCNduf0Qw>
    <xme:LvdoYzCve3X7JVOxbD490CohgqUnIXbObCkDjz1fr5hTSaaxDLDgu-08WAjLusKqE
    59K4TX5F3Z-lwRkAw>
X-ME-Received: <xmr:LvdoY6EPrzwT-RcMi_x2H1wReW7q2jilFn-nJx_XJY9roak_BCAv3X6d1v3YKblLyBGlRJzkvcceMQwduIzldSM-IVepjRFF3algj5Gczkck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdekgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepteeuvefhhfdufedvgeeiueeileegtdfhge
    eftdeuveejjedtgfejhedujeeutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:LvdoY7S542nxTndOKMQ_S3sxFQ69hZmOCSzx-iLbDgPzqQe_kcwCqA>
    <xmx:LvdoY_yNATWwY55tjKqn89EWgMjjY3y-cmtEXMwsjsSYA5PUii6IYQ>
    <xmx:LvdoY554cOQBRDuN2VPebbA4H8UrpJ_UXqZ7U0UxFP7e9OhmBT2aLA>
    <xmx:LvdoY_8T6MO5BsHrexoRXOEKjRpLnqqg22npSFSkvgdEZZoXHT2HuA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 07:16:45 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 96414fd8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 7 Nov 2022 12:16:42 +0000 (UTC)
Date:   Mon, 7 Nov 2022 13:16:43 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 6/6] receive-pack: only use visible refs for connectivity
 check
Message-ID: <9d154495593606532ecec62f29c9c34dc2da8917.1667823042.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667823042.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/wttfbfWcvLybNTB"
Content-Disposition: inline
In-Reply-To: <cover.1667823042.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/wttfbfWcvLybNTB
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
as it is configured in Gitaly leads to a 4.5-fold speedup:

    Benchmark 1: main
      Time (mean =C2=B1 =CF=83):     30.977 s =C2=B1  0.157 s    [User: 30.=
226 s, System: 1.083 s]
      Range (min =E2=80=A6 max):   30.796 s =E2=80=A6 31.071 s    3 runs

    Benchmark 2: pks-connectivity-check-hide-refs
      Time (mean =C2=B1 =CF=83):      6.799 s =C2=B1  0.063 s    [User: 6.8=
03 s, System: 0.354 s]
      Range (min =E2=80=A6 max):    6.729 s =E2=80=A6  6.850 s    3 runs

    Summary
      'pks-connectivity-check-hide-refs' ran
        4.56 =C2=B1 0.05 times faster than 'main'

As we mostly go through the same codepaths even in the case where there
are no hidden refs at all compared to the code before there is no change
in performance when no refs are hidden:

    Benchmark 1: main
      Time (mean =C2=B1 =CF=83):     48.188 s =C2=B1  0.432 s    [User: 49.=
326 s, System: 5.009 s]
      Range (min =E2=80=A6 max):   47.706 s =E2=80=A6 48.539 s    3 runs

    Benchmark 2: pks-connectivity-check-hide-refs
      Time (mean =C2=B1 =CF=83):     48.027 s =C2=B1  0.500 s    [User: 48.=
934 s, System: 5.025 s]
      Range (min =E2=80=A6 max):   47.504 s =E2=80=A6 48.500 s    3 runs

    Summary
      'pks-connectivity-check-hide-refs' ran
        1.00 =C2=B1 0.01 times faster than 'main'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/receive-pack.c | 2 ++
 connected.c            | 3 +++
 connected.h            | 7 +++++++
 3 files changed, 12 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1f3efc58fb..77ab40f123 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1929,6 +1929,8 @@ static void execute_commands(struct command *commands,
 	opt.err_fd =3D err_fd;
 	opt.progress =3D err_fd && !quiet;
 	opt.env =3D tmp_objdir_env(tmp_objdir);
+	opt.exclude_hidden_refs_section =3D "receive";
+
 	if (check_connected(iterate_receive_command_list, &data, &opt))
 		set_connectivity_errors(commands, si);
=20
diff --git a/connected.c b/connected.c
index 74a20cb32e..4f6388eed7 100644
--- a/connected.c
+++ b/connected.c
@@ -100,6 +100,9 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		strvec_push(&rev_list.args, "--exclude-promisor-objects");
 	if (!opt->is_deepening_fetch) {
 		strvec_push(&rev_list.args, "--not");
+		if (opt->exclude_hidden_refs_section)
+			strvec_pushf(&rev_list.args, "--exclude-hidden=3D%s",
+				     opt->exclude_hidden_refs_section);
 		strvec_push(&rev_list.args, "--all");
 	}
 	strvec_push(&rev_list.args, "--quiet");
diff --git a/connected.h b/connected.h
index 6e59c92aa3..16b2c84f2e 100644
--- a/connected.h
+++ b/connected.h
@@ -46,6 +46,13 @@ struct check_connected_options {
 	 * during a fetch.
 	 */
 	unsigned is_deepening_fetch : 1;
+
+	/*
+	 * If not NULL, use `--exclude-hidden=3D$section` to exclude all refs
+	 * hidden via the `$section.hideRefs` config from the set of
+	 * already-reachable refs.
+	 */
+	const char *exclude_hidden_refs_section;
 };
=20
 #define CHECK_CONNECTED_INIT { 0 }
--=20
2.38.1


--/wttfbfWcvLybNTB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNo9yoACgkQVbJhu7ck
PpSjJhAAkYIdB7YVyoY610ZjCZBMwBqJYq8K5lOlYPp8yCOq650QFEp8K941xtc2
VAmLIgcOGilOHy7wo5KbGAbS/M+mHfefjthwCjwEqrQXTfmyDfukLdyMofdB341l
UEyMNDlFM3u0IfEkFOyQTNfwMFQlh5zomjfL1NibUQsTolnaBXfkS+lzsLH8TL5g
YD71trUXi5q0FZ8Ef8WpraSoqxTF/htBEZZr0CObOH41qi4gqsVoz5VVPEDNPfq1
Gzo7/8WYR/XyBENbcLem3RGDyTUiXo5+Il0nzTLOuGm//DTP3sqb92BFHUPQqdD8
STLwjZ6N0RbDgvrivz4pXYowE9DUVmIyDgL64fDSBvTceZoaincQTnx9MrN67NGK
1dVltxWo7PuWN13r471QtxX1hPoFacbqVyAv5PF7PHWPEy6Vewlt9hEI2+nfXaaS
T1ooHDwl874e3QDofMbdEYfDVhRLz5ofUda2bjTrr/NlimgZT86mNLSUVYLzEPul
wfdFdLdFUfCkXyMn9wytLcuPgDs/B/D/OsBk6SZ2XbOO0b5ojxOgYk+5QchRP0N1
7pGNYRuzWvt+cBvcTPyZPdhW39O0AxyiIyUIiQkfJu3oCWmPo72IcaprT20PC+5W
iZIwp+iNDEU5W2kdd8dX3xpVbPSYT8Q/8eQJh8vJXcF/Rflb4es=
=mj0l
-----END PGP SIGNATURE-----

--/wttfbfWcvLybNTB--
