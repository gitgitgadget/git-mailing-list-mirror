Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB837C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 05:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbiKQFsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 00:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239205AbiKQFrf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 00:47:35 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AC16EB6A
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 21:47:09 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C953E3201B70;
        Thu, 17 Nov 2022 00:47:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 17 Nov 2022 00:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668664028; x=1668750428; bh=EDuM/JsrFJ
        A6pYBe4dYymfmEH23/brOfzBqpHaee4T8=; b=ChD9CJLmYLjackH1FbbfMHaU3z
        iuqcY7O/8pjF7/buIVpceqlUZRQHSYx1Eadax8MA9PMssy+j1fWD1bXcWkxEDZ89
        qmfPFi0d7bf6OaCIdNvJ6QcMUqr1wtNegYeCYrXDWHvj6rOEOLLja1fApPECeaYN
        PkXGGJQZljUvkwQIlDPFiStCHfVH/aQ00Z1ut2KntlFFqAq0wosyqKo07bZHPJk2
        mB182UsPAL+Ga3zIYwHkLmVkTWeRMTZVAg2ns1BYQu7dYPTjdXjtXC+y14SLCoIJ
        Y3ivD4bX/x4kH3Ofpio2r3LQ8wgFwk5bv6cHWZCTMz8HIJKEPCHZXMW76w4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668664028; x=1668750428; bh=EDuM/JsrFJA6pYBe4dYymfmEH23/
        brOfzBqpHaee4T8=; b=GTJns7BtOJSEjJ5vHto9o+6548Y1G42WIY6J00M4mWBq
        oEp5NEYA5bRpT18U/WqwkCC+U9LI4wag3RylCjeH6+YDYRURpW4FnYQNllQad92n
        xJ/x7bwSoeeI6rGnQtNY4aIZflYxo0apnG1c5UXIsFg8/ScOlJ8nXsWMcAFA0Obj
        C1cFmRHW7/xNO+dyxCklC33GThUHiX+rUdCHOA5bJDbt3ez/KDVA8Db6onABd+2l
        i7ow49J9tri2e9Zfu/dWFZ0LlgC0KGaClcbbbUJSPfBOR1ltMdDbtMix7nEufxDc
        K2PzA31oVPSxRC4d233J/PE4x+Atn3lN8vrly5TSQg==
X-ME-Sender: <xms:3Mp1Y5InlkyQb4blRoDJj7a-DtoGnNG9NGZbPpcv8vFeSf2bcdqY6A>
    <xme:3Mp1Y1IhCuJvFn_2Rtm3lFvSF89faLLKVkGPSn_7MN9UVlfhRzA0giq39t6t352uG
    NMj3jcSgv-L21poWg>
X-ME-Received: <xmr:3Mp1Yxs0OCMWrrQC3Jke9P6nI1LbwPPGeNL6OBgM6chMGV78nw8qzjclmlXM2XNiD5TWu0rjl9DkQW6urL_dGBzhbn-z9Tl98IwybLRZXfe4kwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeejgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepteeuvefhhfdufedvgeeiueeileegtdfhge
    eftdeuveejjedtgfejhedujeeutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:3Mp1Y6bdhTWZR42GYTyrHP8eAQDlFVplNc_jZHdACll7TDSHTBV5Ig>
    <xmx:3Mp1YwZIbpQm0Q3sD2iJtju0v7YPBMy400-Luc2vgwPmnEHST_6wHg>
    <xmx:3Mp1Y-CqGGJhETN0--1xZ4z5wufV0YzxyJrIpD9Jiqqt_vj_JXtpuw>
    <xmx:3Mp1Y4GMV6_Qt6HXp7pTED8HwGyyWS5PGOKtpkBaUEZpSjQIKyTbuA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Nov 2022 00:47:06 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id d5d10c51 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Nov 2022 05:46:52 +0000 (UTC)
Date:   Thu, 17 Nov 2022 06:47:04 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v6 7/7] receive-pack: only use visible refs for connectivity
 check
Message-ID: <a7eae80ff32051b28124727c957b98d6cf5fa9ea.1668663796.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668663795.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hbOsyxvau0jFbTJR"
Content-Disposition: inline
In-Reply-To: <cover.1668663795.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hbOsyxvau0jFbTJR
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
index 1e24b31a0a..a90af30363 100644
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


--hbOsyxvau0jFbTJR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmN1ytcACgkQVbJhu7ck
PpSmNxAAnJf47lzY4xlvL9+wEQnRkkxwWmu1v50zb/CMZGEMXU1svHS3DU4sK3KT
8YwmsuGnFSXG5j/1i8TOUi4cGu5rFzdj33che6L/QhVgnKcitiJXvN+2Hxqyy0ui
sRn/Aabg4vziMDKlHVo8kFiBuZtLN80A7TQyVk5OOG/yWoBW+c2+Rpu+hsxg/ROs
sZwzK0ybXIgkhPJ8uuhWgrdq1wnTReQliNWrEW/tfCoQYB+aaj6yi7KFS/sH/rk5
cLqDbvaiz0qImd/TN7B+sjy7f0SN9KFDj6aVlx07VMnyGwuvePHkScSkOnhF4gkH
lRNXTfCizQ/QyUY2dqMKj86yVDP8D3qh7W3lk3XzlB6PQdAAmZj/otdpqN7lKHsy
yaKaZDC+beJjTDNyM23DztoYOjyot8PCbwGh6FS+nflbKsySKcubAwahnCVgzoHQ
L0VSwMrFIGnMxtB5Yd1FboIqUW9uvAXQDv9oV6OiLq3y+k8c1rGLX1bXQRPN1YFR
QzeH+Kt67WJcI4QjrKDZK9jHjlS3XTCG24WMqg2HChE05pKTaQACtxd/sVeU3CoB
dnr+vvV2lpWDogX/V1b/KUq/124YMThjJQLRc36s1LH0+mADWszSfY+NnlHOB/tY
Uc96XGcRZspQ4BWNseeuF/jMjU0nneceQ+efzuupoebGpJe55Kg=
=XtEu
-----END PGP SIGNATURE-----

--hbOsyxvau0jFbTJR--
