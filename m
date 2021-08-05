Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963B7C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7357161108
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241012AbhHELZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 07:25:50 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52783 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241003AbhHELZu (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Aug 2021 07:25:50 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0AEF85C0045;
        Thu,  5 Aug 2021 07:25:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 05 Aug 2021 07:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=z/2OyS59uNq2K07hpBzSlfZPwmz
        kvL+aHGjFrh896Zk=; b=psYi014jsA1/k8iE9e75mVb5JpTcr55O33y7s3ApsW5
        E894eAIvbZ2srIGTYGgJDvt+SjV56ayHe4mlAot/qXFPZLNLY3J5Dp9X12GPY21i
        unux9d0gmCBU9WgUEgW40DcjK6yv5woZdaNiS1K1U9UFLZ85FbZpdkqPypn/NUSP
        B9VMvyOAJVyEM6K6xyE9pwgCzjL7Ol2V4M6RsScL+BmHUv4cFgFNsL+fG4sZyyyQ
        ENGTvbvqMi8iN/k2nVKzNEVZgzLJEz+PF0HttrDUCn0M5Xp2jd+gTSlhE5fThK3m
        mfZ/l8MWtm0b3DSRxlAffI9nT63sZt9u49csBOs1OWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=z/2OyS
        59uNq2K07hpBzSlfZPwmzkvL+aHGjFrh896Zk=; b=u9lgqxdB8Wo1zLkdSz0uyS
        xCMcrPUagvZ6MNBypgIGBCntKVKAmjcg9PuoO4scnKaonae/hdJMy6V/CS5QmyGl
        dWehM/+11TR+3c3FCinppetYZeYDWGPUTAnzIAamradRrvDgQ2Lx98fFwz98lZr9
        TpynksZR1nyL71bI4DArXh4DkqkAcXvAzX+0U0ij/W8SDrEPnnJlKecic5lO0iid
        RUl7Du7y6ajD/FaaiCoFiBSsZZ5Nl+vWWDYOE+N2SeNKPZIKTxnmkNYAHcQm7U2P
        yKFux06PT9IBo/9OgO05kbIiPNWfmEXN7Ta8m4FXhQi5t8eWAy8m7fbRixApkSrw
        ==
X-ME-Sender: <xms:r8oLYZa48wgdOF_w5SF-2SD2c8peZjdlV2VYHn8Q0W7IyacrLYDasw>
    <xme:r8oLYQZ42k0N46su05SQ7bYxOG0hvdXCuHnjBz_pJ3rUnD_IJ6Wkt3MrX5fezaq2q
    4ZMY26YeTaZ7SEDLA>
X-ME-Received: <xmr:r8oLYb_Wwj7BzkWnzvx0Hdd9eKD9MYl43vp6t2SSm-BGcJH_rf6Pn5PBtVSo94B0EH3LTLBianBZQibFOGPAXsaDJs7UT3AQiPZLDkXHGD9UMgiYE35dRdo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:r8oLYXp13KTI5jEB6xfoMrbdiUMfR6Tu6nS_pZuUdZq_Jh8s-L8odg>
    <xmx:r8oLYUplJZgk_6Uzsv6gU_DQiTh5lheTEJ4LYkJ4dd41WEG7rqtm4A>
    <xmx:r8oLYdQ4C27eOcYX2dP54YfsL4pJh9snOOwJ6QtBxD316RsRZ0uvyQ>
    <xmx:sMoLYVdvuLzJmW6I9lYqRNBswQ6bURrd-dGLHAf5euskfi0W4Twl5Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 07:25:34 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a1b37944 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Aug 2021 11:25:34 +0000 (UTC)
Date:   Thu, 5 Aug 2021 13:25:32 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 3/6] revision: stop retrieving reference twice
Message-ID: <d8e63d0943bbe3829a53561a3a1cb4f9e6963337.1628162156.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1628162156.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jnGsTv7E4D0Kq+eh"
Content-Disposition: inline
In-Reply-To: <cover.1628162156.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jnGsTv7E4D0Kq+eh
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
index 793f76a509..0d99413856 100644
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


--jnGsTv7E4D0Kq+eh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmELyqwACgkQVbJhu7ck
PpRt1w/+PeyFsUvXgmddh6HPnGpPhqF02Gv0pavPKwSBsAbZexM8q+41rGUg0n6B
D+SZSpdMUyw3AJh/G3OiMeAKIYA7jwd755zm62VKRXsK3cUadMnDGwUd1j8ACwdR
rz68G+68X5+D36+g33ds/YrNLfEeUA/HFEjXq9A6hvXkI1Nm0rDWhBXwwS7iA6mU
AbLc7l04DGLK0fe7iDYw+XWV4yAf5J2Fv/jtSmtVSTZ6v6yUurGlWHuZrXkEd6SH
3Va6z9KmVToJTlMZl1IfOMLDRfV079vO9oRHvBwpTESMlxP5XYNT1OroZE7quMLs
wbkyMgCrdo5fugb9i7HbFsg6DNxH/OxVAq2G8dEaDm9WAMlqehyk4cwyuzA5kmmY
GUQXcgdGD9q1SGDpQ+Zjfxzbv3Fj1OPxReByYcOfKBg1lSI32VP69dc7fG1tRWUC
2HwCjA2WTxLN+qfeslM7llKmhVSxN5jbe+DfBPRbBKmVhNUJRlKX6DqUn3It6qbu
e7K6+KIFT5eH2+KSmSaDamlY5sGdZmgqKQBQFk8yfP3EInt4vad4yoFkqc7qGet6
84vGHigF+dKxgHGWGiovSA70k2TltSb2+Za/xE2/lvG1a9msU6qXflw5578E8uR9
sRYlRe/gmvMHgZYGRpialh2tPkVtcs9WgHYSAZkNR95BZVy23B0=
=5iLP
-----END PGP SIGNATURE-----

--jnGsTv7E4D0Kq+eh--
