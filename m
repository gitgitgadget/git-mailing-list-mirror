Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A79C4167E
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 10:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiKHKE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 05:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbiKHKEH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 05:04:07 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93626FC1
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 02:04:06 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id DC2695C012C;
        Tue,  8 Nov 2022 05:04:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 08 Nov 2022 05:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667901845; x=1667988245; bh=afgLqkpVyJ
        Unex8zNJFP9kSC/im9/2FFgJKthaDLQKM=; b=ihoIDpEeTW1pswfIA2e7HYVTfZ
        ApJG47X/mhWrnyAk8rDRe8mN8xM85tLiSC4TgAjqNnPUZoOPoB3M9yFkPntETnBG
        //1NDNvWR6vfJLM3tJ7pwpks6bKyEIl2Wf7kerwG00h83JdSaDc81UKDjwckSOr4
        2CHtuFRBkRUqieTLUX9v4wDSpDMFkTY2GXi4QjLIvZIMvxgAmgIxKqdwuBXXMeKv
        yjZi0Vs5aWKTRSn6xal1j3tWx1jwi/kuiZEmanoVNB/BrgV71sLrti6xOYHxduGl
        YQJRPnnGwpT6O56dcVpWI5v3B2McfVkt1a/lm9gNEmd0lMs4ExrJe6ErSEUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667901845; x=1667988245; bh=afgLqkpVyJUnex8zNJFP9kSC/im9
        /2FFgJKthaDLQKM=; b=ebHSNDqVQozuCJb9ikNtYi/r+Xct5+/IUvtyhRBnZ3FK
        0crMAwUAuF95DoTw70fCCJPKTpVngU+J+Zj4zsIa+/DTAhLghxh2YOppzOuKIgV6
        Y8ODGYeAyXHDVVkQKumVEDARS2ex/OTgNAF7autVwDxSacocgr91Q5rIiMZL7ab6
        z3sKtY22Cab5k5q/+g8790icPKiUSpRawhUeXaZ9k5MGzobr8LW1cQ5nQ2OXjwhn
        GK+QN+1/wiLqSbu6oO0/qVhyLEVzkml54Ul5cHJ3neEifxWVBsJV9lIqCU00ta42
        bYWtkNYeYyo0n4W7jV+kyWdMEmX/zvYYBlTttT6AOQ==
X-ME-Sender: <xms:lSlqY0hqz1KFcztIUy4teqWkuOinGttyCHlZBjy07eV4O5SCsgDhdQ>
    <xme:lSlqY9AMI07wSvXj9-sQ2dZj5Uj0wPtjHEwokeuYrX1R6Rn73eg_4Nt59NDTG9yW9
    XjQE4mGm33PKMX_Hg>
X-ME-Received: <xmr:lSlqY8Gsj-k2BT52mrsVt9ZNwx3Zo3Gss_5wiNf0wal3yW4WsAGCm4sTyBPANlzAaQNcDLJtj-DLxC00_DU5blDT4Tof4hBcrjlLS18V9u56>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedtgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepteeuvefhhfdufedvgeeiueeileegtdfhge
    eftdeuveejjedtgfejhedujeeutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:lSlqY1RgMWwGSVeJ9qU24rHpxqaoVBVGeFexs1W83Ebkv9VmMpnLKw>
    <xmx:lSlqYxxARU-oirFf__hUOYwZunceAVNuWDEKvSOODTTLB8_KzOwgDA>
    <xmx:lSlqYz4QzNqX2xXsLUuW6kdc56YZ1DUh7zwTHjZndAToV-GJ7f9aRw>
    <xmx:lSlqY5__ArMREuUxJHpfG-YuLb0J_llyEzcknzq_3zRLGuiWrjEQlg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Nov 2022 05:04:04 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 74e065b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 8 Nov 2022 10:03:59 +0000 (UTC)
Date:   Tue, 8 Nov 2022 11:04:02 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 6/6] receive-pack: only use visible refs for connectivity
 check
Message-ID: <39b4741734f9b968430a57a9d7168fb5df398f73.1667901510.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667901510.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GAH/2ppdkuuAdf59"
Content-Disposition: inline
In-Reply-To: <cover.1667901510.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GAH/2ppdkuuAdf59
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


--GAH/2ppdkuuAdf59
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNqKZEACgkQVbJhu7ck
PpSELxAAk1KfoS7VPfKOdxF4JGmc6fjSODLVE96YCVZUExPfNwCzyuhq0HUp40ae
fNAvhDR1Kv28Ed1ednW7EHG2jnPyCMkPZwio1KD5un7y3IU59eR/2KCLy9qajSn2
RXBA1XHTTi2zzAlXO93j2msso0/mwaHsbHTkEtMXvz9Rg5+8RRI52bCY6EKSraTU
rdR7yOtsOBoy3DW4wg74NSrfns5keg1mKnY2/qqS8kgj7xwFPeC/Q96B5kYB9/37
dMBJOCDrpgOmr807kAu19Tk78L8aYtRAuEy6cGx3nWaiBySTe+df/OlEx/OkUP3p
efbjsp1nF4F0DBUU47vqKbviIRC28WmxJ66m2A5EIkenAplNiyZDIlm4ZFj4OIbl
XdPNQ6d6Gevi+EKYDScR23c5kui/gIpdX28t7rLSiBGYLdKyzJveZNQyXaroNcOc
jXNTjsq6eihpYNcmIHZwEOTBjA9rEkTBbhxqUIpFMmXPjbykMf1XPQQG37Q6/+LB
ncCoYcpByLFbKCgw5II/vxlrqjJ38siLIR2mnQ7d+nSrhgS5MBN6ukL7GUaNCzqi
eVmaVQ6ydxjJel6ZNdF8LDzJJ5PbOfXPVsQJqy8AWiDLvGx7G4+JLzaG+s3FiUDQ
4FzssPsCp5bOC5v2mTu/tNotaa7Lrx6PUHHRu5mOdbHxap8cU+U=
=jm3G
-----END PGP SIGNATURE-----

--GAH/2ppdkuuAdf59--
