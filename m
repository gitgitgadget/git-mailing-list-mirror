Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076DAC432BE
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 10:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E59E16024A
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 10:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbhHTKJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:09:24 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46859 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238748AbhHTKJW (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Aug 2021 06:09:22 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 538045C00D0;
        Fri, 20 Aug 2021 06:08:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 20 Aug 2021 06:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=SpJ+4ony9KZCPhpIoQmxliNKfev
        uC4OHmprV+nP9Q6Y=; b=q0QUdeVANSEJhy2aA289ms4ZjhtbJVIBEsQgtEtgp5g
        7vjp3V+LwfK4q/aVp+r8Brw9n7Kvu7+9H+5xYMeJqlbZQk92L4v3IvUiWV7riWsq
        zi5BEWgCgGPh2q255dqR2ytteLPn04Nlj65kzHjVYOcBjpU/lObJlPoX6Cq3WEl0
        a0I1MmmM3/FJHlEmsQKq8T0J66lWnOwPBb+zVEhnHJR/KMqPOjFL/J1e/8jx/TAH
        Fm4nnh83p/7v+6Fyv0S9zo6lHnItufnV+FN+YKZfO2lSP56iJJJaw2FfdlHryf3c
        c6m2nGUyBx1Zt8UeRdsvYLje9Iqzp5np68nDr/oSPTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=SpJ+4o
        ny9KZCPhpIoQmxliNKfevuC4OHmprV+nP9Q6Y=; b=nWdIpjamcTPCbtbpz7C6Ze
        /SuNGRfm9ZCI1gj2yMIWl6aFAFQ61RdPr+FHNKK8kChDvWB6xp/I36T+xRbZV/d3
        0k83WVqS83QmYkRlRsCYQ0mnCLu0wVXAJFYkcI2mmufiEJvQMr2tA+p/Oe+z0L3T
        nGJ/95zF4vLzJjDRtFzOso1wUEG1SAaBmV5WIgdLYuX8eJ+PRv7nhaOhX+/AtTuN
        4+vxw/gejxTcQCS29vg2T9nYIwurlCHs4bk2pmhwPxy+pTi9NQwVhNQx6e5UUpei
        A8HEiKgRv6XIE6w8M6S1Vft4O9AkU+gG8TUMSGv1PtJwv0WKW1yezpByNchoHUWA
        ==
X-ME-Sender: <xms:K38fYVZ01Q-YdchSFF4Tyb8db0YjjsjUci7Y3nDewkAy-yYmENz12w>
    <xme:K38fYcbopZ8QUgcA6LYGr-e7e3nECbaTjAYuBrSTR1vMkv5uyGBmieiZo_sIz0ead
    pLBwnj1mjZj5HU3Kw>
X-ME-Received: <xmr:K38fYX9YrkrtP-lvIKuvAjoBcJShl07KyZZg8FeFLwbZCMcmjAoy0Odzu15TQSghrtBlm2GPheU14gqQx1cS-njdGjGwaIAuhZHI_YAklHVtT4Q85H3RCDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleelgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgfejueevjeetudehgffffeffvdejfeejie
    dvkeffgfekuefgheevteeufeelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:K38fYTo0tWtszq3tfi85tzs1vM1VeY_IGHR8h_SUVh9dbPRYrAKWtQ>
    <xmx:K38fYQodz1aJsgDvevs4MbEF9xLXGvqkKsQN6EjOs_dTw_Vq3Ba9TQ>
    <xmx:K38fYZT1ZPxfh3c_jtCCNHC3vu8nkGGGpiY1FdfCiJlLbEkZYUOEfQ>
    <xmx:LH8fYX0B-fikSz-XJ4Yk2if8-euG7HSluc9TV2fX4mQ0XwD2gw5RUg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Aug 2021 06:08:43 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a8ef8c86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 20 Aug 2021 10:08:42 +0000 (UTC)
Date:   Fri, 20 Aug 2021 12:08:41 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/6] fetch-pack: optimize loading of refs via commit graph
Message-ID: <67917af7ceeefe41ae0f6edf69cd61e2ee8c0ea3.1629452412.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bIxZegiiSwv1SwTw"
Content-Disposition: inline
In-Reply-To: <cover.1629452412.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bIxZegiiSwv1SwTw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to negotiate a packfile, we need to dereference refs to see
which commits we have in common with the remote. To do so, we first look
up the object's type -- if it's a tag, we peel until we hit a non-tag
object. If we hit a commit eventually, then we return that commit.

In case the object ID points to a commit directly, we can avoid the
initial lookup of the object type by opportunistically looking up the
commit via the commit-graph, if available, which gives us a slight speed
bump of about 2% in a huge repository with about 2.3M refs:

    Benchmark #1: HEAD~: git-fetch
      Time (mean =C2=B1 =CF=83):     31.634 s =C2=B1  0.258 s    [User: 28.=
400 s, System: 5.090 s]
      Range (min =E2=80=A6 max):   31.280 s =E2=80=A6 31.896 s    5 runs

    Benchmark #2: HEAD: git-fetch
      Time (mean =C2=B1 =CF=83):     31.129 s =C2=B1  0.543 s    [User: 27.=
976 s, System: 5.056 s]
      Range (min =E2=80=A6 max):   30.172 s =E2=80=A6 31.479 s    5 runs

    Summary
      'HEAD: git-fetch' ran
        1.02 =C2=B1 0.02 times faster than 'HEAD~: git-fetch'

In case this fails, we fall back to the old code which peels the
objects to a commit.
---
 fetch-pack.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 1a6242cd71..c57faf278f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -119,6 +119,11 @@ static struct commit *deref_without_lazy_fetch(const s=
truct object_id *oid,
 {
 	enum object_type type;
 	struct object_info info =3D { .typep =3D &type };
+	struct commit *commit;
+
+	commit =3D lookup_commit_in_graph(the_repository, oid);
+	if (commit)
+		return commit;
=20
 	while (1) {
 		if (oid_object_info_extended(the_repository, oid, &info,
@@ -139,7 +144,7 @@ static struct commit *deref_without_lazy_fetch(const st=
ruct object_id *oid,
 	}
=20
 	if (type =3D=3D OBJ_COMMIT) {
-		struct commit *commit =3D lookup_commit(the_repository, oid);
+		commit =3D lookup_commit(the_repository, oid);
 		if (!commit || repo_parse_commit(the_repository, commit))
 			return NULL;
 		return commit;
--=20
2.33.0


--bIxZegiiSwv1SwTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEffygACgkQVbJhu7ck
PpQADQ/9E14aTS6vW7vZWbySXN+i71txyn/kMVOkGJdwyXKAepmdNhfBCOURBOCi
+INDB9+yUJsN2hkZK+Wd+iFw2hnFYiXgC4XMpo0B93CjJ2Kq1pEGf5b2MdnsiISV
5obhFKNLGCcZDNOkDzN9/S4wpVyQA38guTL9r4o9dqbfDZKbZD27w2mOwAX+8V24
dwjeG2iaJEpTAXxXyRGuJDk4qer1VKNAOzJGX09WkPiGWiGfVw+NkggDXlFGFfOx
D+p5jD+FfRgfvHkIEK6ITbtHB3xcpPQR0mpdEhlvW9/YzDlBStgjjatnx6E+FBjQ
cCA/lWfjgsJdwJCj960yFf3pd3Lh3Pel5SPXRV1uYPGyEFzKn2lnHW8Txdj1SSiY
bZherExU3vsuoVSOkU8vcpJZZxHMgDRoa7+ZYQ4AdUfrsaV3viXRLmp0SjxWuvFZ
cMr1tRr0SYTPD3KTHnDgodB05BrJUEUvCg61/f7KwRwLWOQ4tYTz7z4cisVfMj2q
zGUnNTo8BL2LabUiJtpEcpBDjylodAif45RQgmehW0oIwcGU3lDRbgitCXtPCxjJ
1i7BNxR4HnmddEIzqBsgupyEFMfTnOxuB1xbX9WbKTXz9gRbD9vkt6xIKnKfOZka
zG8lVawlilYdFBy7PV0irmLyovM5gqUn5DI5HWBebMCMUgm03Mg=
=O8Nl
-----END PGP SIGNATURE-----

--bIxZegiiSwv1SwTw--
