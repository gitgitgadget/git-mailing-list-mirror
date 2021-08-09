Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9001DC4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9CD61075
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbhHIIMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 04:12:21 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54403 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233846AbhHIIMS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Aug 2021 04:12:18 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AB3195C009A;
        Mon,  9 Aug 2021 04:11:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 09 Aug 2021 04:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=KPrn4tUcAt7fToHuMAegwtF3/cQ
        YPLTZvZemYqKVsls=; b=Ofv8/yEnYK7LdsT5Sj3ewnVuMUcYLr23LlEoit4dChV
        VyrpuWmUZq+mQedI2EmYURKPx6Xrbi9d7Pok2xPrwrW81LC3z+vnUk7zk2QWnUK1
        pm5XK8mxjmcA2u/uYTpqxE1l4Zje4a+B0UlxdERQ6T5f/+5BKzfvJzRezq45Xapx
        qwuCTOx51yxQ0TvxWBYRlV8Wlp5VevVrzYHvS7NeAkmXNKH5PmSeM/CeCLVSDlJW
        G717mlIrhxhHD7zZf/aBlqaN2mOIzEYXtc3fS+E2DvQtDuq5tvTl31hXhQKyxKfE
        Ry7jhuewLZ++Rk+oCmuqHL2uZ9KV4960G76rPaBTyew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=KPrn4t
        UcAt7fToHuMAegwtF3/cQYPLTZvZemYqKVsls=; b=agD9sc80HzwFCUq6zQhOHw
        0vgPpnhjFyvw+W3aSeeMam1US19DlCf50q0VDalFZZi2IaYQz4diH9R6R6GhPxf4
        S+dYyOawpy+QgpUh1hez6XPXs+XYk8c10bXR5X19RwNxpT0gur5izQCZbtjQlj6m
        DRO/UxtxxoEq7okA3+3/KhNdtk1wG/mPqfsCWMjGnq5IJm8QdBpaOwcY9xVUMYvh
        SW1VCEY+chK441PMZpgel0DVdoWS+kUZu6CM1ZUYF4e1wVIJ79cEOMu0MVhvFHVe
        3KGFbdWGt6L1kUBcccX342bo9nbjFSYwFIFANXbVwvW+mNp4MWElvITR3rCvyGPg
        ==
X-ME-Sender: <xms:TuMQYSTjZMK2j8Bf8AwGcHcOIxfqcOY77x8fCSCZbjvV9Y6u8Yyopg>
    <xme:TuMQYXwqLU65dvvpZ82ZkWOlR4BxvHjaXwOebv09MTOkZD0svLp0XRDXSp1nQVG-W
    wE3chcGJv-Y0HnRVQ>
X-ME-Received: <xmr:TuMQYf3WFod4a6puffgPRZa3xcKvtJsSQCfob9pvGvrtt0BDpJkD_NRxhLRIDwwI8BwXKXtzaio9LAz_RAhiOM1dlCgLpauUijyyrX6-2BPow6akezS0cQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeejgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:TuMQYeBDAOaWpVwwoCnAld5xo--i7fWkGWIEbT147lMZxH91l6IrVg>
    <xmx:TuMQYbjq2zk4t5r7jqfrv_eQ2SNqd6Q0WHwYxlyOCYz3brXw3i_1XA>
    <xmx:TuMQYarcCqoimCjMX-xohmLWzgavxHtsR6TnlEQqDlBskHkpEzrMwg>
    <xmx:TuMQYWVZIT1URWEUyrvO-ojnsnG_-FsymI3FFCdIflRVfREIEvaNAA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Aug 2021 04:11:57 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id abe40834 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 Aug 2021 08:11:56 +0000 (UTC)
Date:   Mon, 9 Aug 2021 10:11:54 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v5 3/5] revision: stop retrieving reference twice
Message-ID: <c9a630927b9386bce8766940e5cabd8debe6e0a4.1628496539.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1628496538.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R372p2ZNc53wjkzE"
Content-Disposition: inline
In-Reply-To: <cover.1628496538.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--R372p2ZNc53wjkzE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When queueing up references for the revision walk, `handle_one_ref()`
will resolve the reference's object ID via `get_reference()` and then
queue the ID as pending object via `add_pending_oid()`. But given that
`add_pending_oid()` is only a thin wrapper around `add_pending_object()`
which fist calls `get_reference()`, we effectively resolve the reference
twice and thus duplicate some of the work.

Fix the issue by instead calling `add_pending_object()` directly, which
takes the already-resolved object as input. In a repository with lots of
refs, this translates into a near 10% speedup:

    Benchmark #1: HEAD~: rev-list --unsorted-input --objects --quiet --not =
--all --not $newrev
      Time (mean =C2=B1 =CF=83):      5.015 s =C2=B1  0.038 s    [User: 4.6=
98 s, System: 0.316 s]
      Range (min =E2=80=A6 max):    4.970 s =E2=80=A6  5.089 s    10 runs

    Benchmark #2: HEAD: rev-list --unsorted-input --objects --quiet --not -=
-all --not $newrev
      Time (mean =C2=B1 =CF=83):      4.606 s =C2=B1  0.029 s    [User: 4.2=
60 s, System: 0.345 s]
      Range (min =E2=80=A6 max):    4.565 s =E2=80=A6  4.657 s    10 runs

    Summary
      'HEAD: rev-list --unsorted-input --objects --quiet --not --all --not =
$newrev' ran
        1.09 =C2=B1 0.01 times faster than 'HEAD~: rev-list --unsorted-inpu=
t --objects --quiet --not --all --not $newrev'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 47541407d2..80a59896b9 100644
--- a/revision.c
+++ b/revision.c
@@ -1534,7 +1534,7 @@ static int handle_one_ref(const char *path, const str=
uct object_id *oid,
=20
 	object =3D get_reference(cb->all_revs, path, oid, cb->all_flags);
 	add_rev_cmdline(cb->all_revs, object, path, REV_CMD_REF, cb->all_flags);
-	add_pending_oid(cb->all_revs, path, oid, cb->all_flags);
+	add_pending_object(cb->all_revs, object, path);
 	return 0;
 }
=20
--=20
2.32.0


--R372p2ZNc53wjkzE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEQ40oACgkQVbJhu7ck
PpRCeRAAmXpr+quC0+Jv29DV29u69QFR+lqptvtcUWAszcIgVEiIa2Z9B7Vdvtmr
3Kb6HwyXj4i92+QliMVE4/F1bPMqd2GOL/V3Lis9EVDTTe9aQI1kId0o/1Q6WZ6v
1C3OrsMOzL5VDsH1DqClqcRRe7pmo+RDaGik4Sc31i5RUhDSoJsi9K7ss2J8jzJq
Myo1s8mAnAmOM8WvEKJWwV0GgcGa6qy3qo9jvFN333YD/QgUEExNaxhjVZGj4FJo
iGPTaRU8psB7Tv2ztiXjOmbD7+ZRdTTW1F4Rq9qP5JvbGlafK6hCqueUlF9JMLhp
KzlDSTWAIXVvgfalV3wNOTk4/+vry0wNN3WWxnPWwCpAxAMCzlpy4b9dafmxeAR6
y0CdtEt5nJTuQBq3tZdObSXzbf8753PqYOLl75sQAYU+HgrZBuIVRw9K+6GrP2O9
OOOV780lnTIwWP1nzUXKGx/k8IbgJyozSuoZ830CoBb29W2YnUeT7jGL2J1Wf1l4
Fubdgcq6MwvbtfXmzPfr9SU9Tcx0SAt3sUgqa2PLYtJcak14pXn0h8gEuG2509An
HfTbXyJV7sE0Q7wBaizPriX5s5QYOH97KuuZsQbiloNkDADVA6KixVVGWMF3F2JG
9//TP96Kznw2uO9eYCb7fk6fg+0sOWs8A29H9zQyLlawqgIM2jc=
=wyiH
-----END PGP SIGNATURE-----

--R372p2ZNc53wjkzE--
