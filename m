Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1677BC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F335D60FC0
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344273AbhIANKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:10:50 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51381 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244182AbhIANKq (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Sep 2021 09:10:46 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7DED45C01F9;
        Wed,  1 Sep 2021 09:09:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 01 Sep 2021 09:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Z3o9N9TRMo6/gqEm2o0lB/9U1F8
        Sig62K77mujfeFnc=; b=ZI/wTwmU5PZZkQc+39cNJxL3clT1PFXSCTwAFcyohfo
        AHHVygSjC1woAH9r9yFmTq2e30abPHB1YKL3P5wn5fv5KHjwkzAo0uBVsJu6hkrE
        0DJ/2oTJYpyoVJY5Dbg6DeWMmiCrzL+w/3YLQxCA18TfdieXU9VGqzmBIFmt1enf
        F8BsH3rxFFwSmYx0uLny6+o/spwGTH8uKLSxBue5n0Edzyauq2uiser+z0aqShLd
        4+qyMNB2n8OBzElvVz6US5lK3OTAlBTjs689RALHNCP5v2iDaRbbzEp0V6YcEqCR
        bgL/LDyNp+SDs7g1A7Cs0QnMfGSzt2i36x7ILg7FeBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Z3o9N9
        TRMo6/gqEm2o0lB/9U1F8Sig62K77mujfeFnc=; b=wR+C2naQuI17PoZG35Km7v
        Za44EdOdUYz3EwcY3ZZdB3I5PUauIB+n0wShFXCAGL7tMjyTDvP7AoLOUOT/Zm39
        6nfEy0Nq8Isdg20mC27PyG+r8YXm6OHFP52MsN+eccJQksgFrZTSq9OzKwVzSt9Z
        7EkYSOWwBOZncyYmnLPTxQ2LCUQ3uuHPatS50kdx4EfEILQdy1sNhf38erSvGxIy
        uNtod7qsD3QyE30+R0odsIc8sRao9Iv9wzQJjoY2GhAsGS6U9Tt159WxSmpYpvF6
        Kyl7ugNfNwcsRHyfFgJ0mMcQ39t8Phz+0jStqSbEp3eewY/z1/X+qAp0/mze3zeg
        ==
X-ME-Sender: <xms:nHsvYQRN-vqhNG_usRMYkzpCPCQ63Vg3QXUt5qqXEJViWwPHC223gw>
    <xme:nHsvYdx-an3JvVfAhy6CpvrNdSNGcyI3R5YRhrqB4139fKHKNR5w8kTVwtIhJKqvm
    qzWbmBhhlFEBfEjiw>
X-ME-Received: <xmr:nHsvYd0DgsaTeokic-juZ-N2ifl2P8t8yDQWevkza8L6rc1fatfUc1XXyxlRxTAasEDNk-nFS6OH0YWGAV3W-_wjZTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvfedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:nHsvYUCfc8-Bf7w4-tokfBZ5gQS8u_Vwt5ijBMpn2QYwCCfHAiV8cQ>
    <xmx:nHsvYZgSksC0excnK4n7rQlZra4PrMIiJQYFusfmpr0zZi_XVBT4WQ>
    <xmx:nHsvYQoX7a-jfwiru3WSvXopc0RzY6Ws4FXze6gQregZLZks_Z6KrQ>
    <xmx:nXsvYZe8YKqo4xYIbVpYz84QMa_2VbrxJd712aGCr4e8lfPHHgYf7w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 09:09:47 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 50c62e97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 1 Sep 2021 13:09:47 +0000 (UTC)
Date:   Wed, 1 Sep 2021 15:09:45 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 2/7] fetch: avoid unpacking headers in object existence
 check
Message-ID: <991a27cb8286195e8ad928807b96ed17ebe1e5a5.1630501732.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
 <cover.1630501732.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jSjfSJH5vQ/xgD06"
Content-Disposition: inline
In-Reply-To: <cover.1630501732.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jSjfSJH5vQ/xgD06
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When updating local refs after the fetch has transferred all objects, we
do an object existence test as a safety guard to avoid updating a ref to
an object which we don't have. We do so via `oid_object_info()`: if it
returns an error, then we know the object does not exist.

One side effect of `oid_object_info()` is that it parses the object's
type, and to do so it must unpack the object header. This is completely
pointless: we don't care for the type, but only want to assert that the
object exists.

Refactor the code to use `repo_has_object_file()`, which both makes the
code's intent clearer and is also faster because it does not unpack
object headers. In a real-world repo with 2.3M refs, this results in a
small speedup when doing a mirror-fetch:

    Benchmark #1: HEAD~: git-fetch
      Time (mean =C2=B1 =CF=83):     33.686 s =C2=B1  0.176 s    [User: 30.=
119 s, System: 5.262 s]
      Range (min =E2=80=A6 max):   33.512 s =E2=80=A6 33.944 s    5 runs

    Benchmark #2: HEAD: git-fetch
      Time (mean =C2=B1 =CF=83):     31.247 s =C2=B1  0.195 s    [User: 28.=
135 s, System: 5.066 s]
      Range (min =E2=80=A6 max):   30.948 s =E2=80=A6 31.472 s    5 runs

    Summary
      'HEAD: git-fetch' ran
        1.08 =C2=B1 0.01 times faster than 'HEAD~: git-fetch'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bd7c0da232..0b18c47732 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -846,13 +846,11 @@ static int update_local_ref(struct ref *ref,
 			    int summary_width)
 {
 	struct commit *current =3D NULL, *updated;
-	enum object_type type;
 	struct branch *current_branch =3D branch_get(NULL);
 	const char *pretty_ref =3D prettify_refname(ref->name);
 	int fast_forward =3D 0;
=20
-	type =3D oid_object_info(the_repository, &ref->new_oid, NULL);
-	if (type < 0)
+	if (!repo_has_object_file(the_repository, &ref->new_oid))
 		die(_("object %s not found"), oid_to_hex(&ref->new_oid));
=20
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
--=20
2.33.0


--jSjfSJH5vQ/xgD06
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEve5kACgkQVbJhu7ck
PpSjyA//SQZWa9eGH/A2PBFUN2x1J7bbKJ3rDYEGwrcyKCNBiNHFgu1RSH43H2Rl
YIYKLSb8zyUfG2AYFyTj4H3aGVO5HRTomKR8KCEyIY9b0HW5HjrYmS4UqAKMRk5o
U+s44fw4vfLhsnM4uB4pIDQXcjC3znUG1BwI2IbSNsWOYfoa+sTS2DOpvPcfWUfT
ZjIzJk8I8C/iWbGswMhlTV2u86M693+69ZWTJxawv5PJOxZwmw5TYquR87dfRHJO
DmnxMCD2G77wDIC//x3kUQkv/sq8JHblT5fCTvhcqUyU0dxUgRLPCrH5vzBzSOXW
FFBe/+0xdpxBdI9MMnuC9eWBGGdqV1SrwDvqubwuee2lJGRvOO0W9JPkWCVMb+lw
1XklcTvZQKhA+jdKsRpPdgaQOkNhenwGkZ+afAECLZiveOrmpD5QV32dF+VM6oOa
Y/jX/XPt2pvaySnEP850WutapgdQS1EtvGLodirM/989SV59M+lfy40FJhFWRy2p
QVS0yvjXdutgJQMtzH0UfRIQXGKZwnnmzvFa9YPBBP+N462FRZNEMK6ceXVmu4XM
c/xebvqYCxJWuApQQjKtPO5XykExub3rcmBj/aqzlpIjwV4HMbr8PuACFFR78RaR
1te+cEgPZm0Ca9r7uQ6IjCXOc66XYaZH8iuGLNAobpDGzBGBqwk=
=SCUL
-----END PGP SIGNATURE-----

--jSjfSJH5vQ/xgD06--
