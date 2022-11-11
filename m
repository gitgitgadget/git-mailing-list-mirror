Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2231AC4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 06:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiKKGuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 01:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiKKGu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 01:50:26 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1F8729A7
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 22:50:23 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 130313200938;
        Fri, 11 Nov 2022 01:50:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 11 Nov 2022 01:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668149422; x=1668235822; bh=JlPedTWuIA
        YaW+eX9ZtJH414ZCoT6LhOujm+XZlR+CQ=; b=PLdI/oYJolp5AgUCYYaTeGduJ8
        HfkAK+wLI2CBGO0XUhK1BJRCCOTNeLRWVwNS53KEtCpdXD7wlmu+D9+sT6vc4hHR
        aKRQzRNYUxp+imIvTr0+FTxHVxUO43ct7FQprUZiKci7+VEWrYxfktSMRwRAKbo8
        LDHFWYSQgvfZH9vOy5rdjtnKXWI5obdo87vYVACf4/JJh8eMmUkrKPZPs4yNmcoq
        i9hasLbclv7+49bQhhE5ePYsOgyEznKf4BBh9uDUeA12Zl7bQJh7EgkEAvndWrmI
        jxCaT0E6Ln4auZ+DdFOztcNca02sIfYPvUBPeWEuSBNBBvvNQZM/eGU/KHmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668149422; x=1668235822; bh=JlPedTWuIAYaW+eX9ZtJH414ZCoT
        6LhOujm+XZlR+CQ=; b=KPaxP17h0FKQfTrEpwWrDq99c+dKbXWgBz+AObz3svg/
        AcXxrUoyECaFaraoQKoLWCpADgjl8sv/aPrtR7q7UPgb1W08L6X4whaVxB57iS20
        k399TFRJrrta1d8RNy1cEBSR5/mwADIvDCg5zpm+8lhp5y6Byqx+pWwsNHg3U7sq
        50fI4WNbOexd3rweXjoBaKYHxZWxw0XGmgVyIqze+pkYJ8xp6sBsj0H+T3xRXKFW
        mIejlMH9ls3UZfHWV67LwSUM3P1/6656u/xr5RuNJM6ZQU3jD0fwrmQOZXb7SYT+
        Z1f/RbMBSaXUbwqaKnMARgPtqikvOJTf+V//CMmCrw==
X-ME-Sender: <xms:rvBtY6mKx_lqnf5f9SbKhtWcKHBqHPY6tVf1slmXex0m0guQRNDN6w>
    <xme:rvBtYx38S0onV7Y6ynyCud1ZcdhJODSfeG7zSoUieXdzD9JUJIgZDIddGWawfdtR2
    _VNUww5frCbHBhC4w>
X-ME-Received: <xmr:rvBtY4q--G5VXuYMt5fvsio_V-8rWCaYoAA-13ODvaEaQh3FxdjufgFMyIKQkz7sHdLt00h4OBCtIwc1rG4WBHyRUnxH4SkY4r-z9HfLrs5ynA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeehgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetueevhffhudefvdegieeuieelgedthf
    egfedtueevjeejtdfgjeehudejuedtudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:rvBtY-mINFN8z2gyFidu0qDv6GipxuEOFtY9dCRP-mL8XhRvdtimsQ>
    <xmx:rvBtY41lbyHgpWh6lM-m__44W8OcejcjwXh4-SVHOUn6qRKwmOgJEw>
    <xmx:rvBtY1uHjbZGu3hlkGoCSKg_bXsbGvBlHIsKkm-nfWP0R_o0k1KCVQ>
    <xmx:rvBtY1xdH2r6G_mOWxNsHGznJjPoEzewGNCxRKBj3Jog4CblKmajyw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Nov 2022 01:50:21 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 3935c296 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Nov 2022 06:50:18 +0000 (UTC)
Date:   Fri, 11 Nov 2022 07:50:18 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 7/7] receive-pack: only use visible refs for connectivity
 check
Message-ID: <f5f18f3939276e4dd63c66d5fb2a72231f9a7a06.1668149149.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668149149.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="41Ox5Ne90cYIYFao"
Content-Disposition: inline
In-Reply-To: <cover.1668149149.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--41Ox5Ne90cYIYFao
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


--41Ox5Ne90cYIYFao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNt8KoACgkQVbJhu7ck
PpTbcQ/9ERmZc3gEQFOhJk8THDrNHvgmAG7/4ptt6Bav21HFZc8GdSwSB08m326E
HJEp0MA64NuyTZVTQcTdVKIZWIVlXFkg/ZpsEkSmB2+++KDeq85RsSUtVMtuf/Ej
uQTUn/g2TvZ8YmibaoBjtENsdn6gaYmjd7hCvBOuBAjZ0Y7Rn9L5jmVGJHLeTNoJ
mQUTz08Vn00N6X1QnbAbJt+YNDK23TT9x/Jfz9hfgh3PNFfjviuZzbk+u2OIGLlR
xClINjFi5TOlu5KGVhL98cRlMV5MVb/V+z1kBR6CWJ0kKUvsE+9iIXagc2Vmn48K
iPM3HZZHRF7CjNSPIyaFm2HkWhPYUUzjfk2mUC0rA+dsqUP5bn173DseyhklBvlJ
96p73GSybZHUp6OVDLlnUZ8NMi+/NWUkJ1b4J3ujDbaU0icHiI/DEHMl3ZZF10EI
Vqz8gjxsl1Augr1a4CdWDDW+HWKVcLwC7vIWzAPIUWDKzV3uqXWLfp+mzjEw3KvJ
eBIf7zd/fp12MgRiFdn/950e/EgPFADrCPbrdrR2JicuEWuuhzQ6kzotM6ryMze9
sydaQPkqfXDhXOpMJxE0gt9W77e8XFm+WISrnzNkt/U8n6eB+YU9T2M8a3k4aZDF
qYzBeuZpQplhqfH2dETwRQiGiJrWmtXeRKmErYg04hBSZfXBevU=
=/lfS
-----END PGP SIGNATURE-----

--41Ox5Ne90cYIYFao--
