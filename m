Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E49FA3745
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 14:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJ1Om5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 10:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJ1Omc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 10:42:32 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAA81F0402
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 07:42:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 002F05C00C2
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 10:42:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 28 Oct 2022 10:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1666968144; x=1667054544; bh=zhL45LP3r0TUJHVk4G5cEpB9ZXmLTpUysO+
        ODJMiqjc=; b=H/K/iedqUhOZmfgbeikwMf9wvzC1bi9kB0e0Clh+UnuvVqUamKX
        Ad7+gpc9pInFRevWItb/t2WyColx6fBOlKy2wW1CzmycWQvgjX618417e0keI43m
        qrHlUNqGlUIsqt5ZRjfhlG3T0Jm0a7pRFN4q/KPRWWhbF1VPKYRNZmcIj0fcpAXe
        0o34RIRvSKwCUTB09ummxsCCVMrXnnNjqAl5WJAtO1MMsVxU9c4k8k/fD7Fc/j2e
        EABrLSLk+rWDfwpNyvcIpx32+OhT8ClGA+xzcLrGjA2lilB+/FfohaX8+v1t2/Pb
        ZAogCENHfPDXMkGztpBkrATy6ic5H/brOhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666968144; x=
        1667054544; bh=zhL45LP3r0TUJHVk4G5cEpB9ZXmLTpUysO+ODJMiqjc=; b=f
        TEqmYXFVG1YCQ+nEEiAouEKjHM10sf9NIj33/nFOjAnIYvur1CrO6zYFQZlFioGD
        DUmJZKz12rK0N2fh01J+uajG5NAQ8Xa0ddK1ZBEEOmnPAJ8fbPROlOtrr6u3Hz4T
        pK+aM/WdOeOkoqndFLBIW5r20wBZlfHuRa3EHWl507uY9OSCXbkdvDN5k+qf2TJ5
        saC4/Oczs5MFvorAE2qan3vpcUlvtfY4vtJSo7cTutZesvSJP8pMXdsCM99Pvuu2
        s548RLGbBsc5X+Nqvy1PnvN83vCuca48zhzgFrQOU8ikve0E1upr35lQUwtp9o4q
        uaMZNKKYSJ1gJ4TFpqalw==
X-ME-Sender: <xms:UOpbYyuxH8D7eMZgGwYEyqbFTgaarMds1veD1skOfF_GHjOzHuNePg>
    <xme:UOpbY3ctRSxMveIqNv5Y6xsdmoL_kiJsKxZ96DINQWoGnJqK9n2qx8KUVyocLnPlP
    _l7gnjAR7hNsqdzNQ>
X-ME-Received: <xmr:UOpbY9ydYRPq-h2iNo_YXrxO4CfZpWZrwpUBp1-BjG-6Mq59wb0WrWE88KaAa6oDdfKdaa-7URUeItSF7sEJ4dRpBqcVr7Jny3Y8_23JsLv-0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeigdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgfdvvd
    efudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:UOpbY9NKF4g2qkS_PBWHHxpBvPwqpXJDlLBZLeqEXRfdrqEy0oBLVA>
    <xmx:UOpbYy8y7A83WAss7SwOTAnwPwg1Ajv5SABeqDE1Xy1_H8bjje-mAQ>
    <xmx:UOpbY1U04oIwApy1PcjZ5lTbJRdFvAovT6JfRd2sDL9my1E6r-M9QQ>
    <xmx:UOpbYzL4HpcWW3rpWq1gnwcR03QhQnOrSoaNZs5ZdCKduuoSXt6RFA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 28 Oct 2022 10:42:24 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 70bb9aa8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 28 Oct 2022 14:42:14 +0000 (UTC)
Date:   Fri, 28 Oct 2022 16:42:19 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] receive-pack: use advertised reference tips to inform
 connectivity check
Message-ID: <cover.1666967670.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2YtZw0Tfs3ybVKNC"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2YtZw0Tfs3ybVKNC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series improves the connectivity check done by stateful
git-receive-pack(1) to only consider references as reachable that have
been advertised to the client. This has two advantages:

    - A client shouldn't assume objects to exist that have not been part
      of the reference advertisement. But if it excluded an object from
      the packfile that is reachable via any ref that is excluded from
      the reference advertisement due to `transfer.hideRefs` we'd have
      accepted the push anyway. I'd argue that this is a bug in the
      current implementation.

    - Second, by using advertised refs as inputs instead of `git
      rev-list --not --all` we avoid looking up all refs that are
      irrelevant to the current push. This can be a huge performance
      improvement in repos that have a huge amount of internal, hidden
      refs. In one of our repos with 7m refs, of which 6.8m are hidden,
      this speeds up pushes from ~30s to ~4.5s.

One downside is that we need to pass in the object IDs that were part of
the reference advertisement via the standard input, which is seemingly
slower than reading them from the refdb. I'm discussing this in the
second commit.

Patrick

Patrick Steinhardt (2):
  connected: allow supplying different view of reachable objects
  receive-pack: use advertised reference tips to inform connectivity
    check

 builtin/receive-pack.c | 31 ++++++++++++++++++++++---------
 connected.c            |  9 ++++++++-
 connected.h            |  7 +++++++
 3 files changed, 37 insertions(+), 10 deletions(-)

--=20
2.38.1


--2YtZw0Tfs3ybVKNC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNb6koACgkQVbJhu7ck
PpS2xQ//SgC3a0L3rVmlY85PC9sSqycB3QR7mWWbf4+lK4uHl6jrxivKFxcP8T7H
wofUpCIfkB23XpBdcXKFmzMWcITHWCJ3IrkPF1PjbEVzrdxXJV3VWqPLwvcpIqkw
IU1HaUtRj1L8DRDzpLZEHQykIeTipRhfmB7ZG0WuQdx2SuEcL/5xT785TYWrptUy
HItMXsiSRfWluB1HFTfA7mSBhGddw4CltlsEFCiRHntltG5HyfU3Vzkc5/FAEOCD
tPowAXTNsiaGxCxrwbyQEXOMOAis6qPpW2yVEycaZVKpUL8CAfqYAbxNEr2hZBZJ
rQx3fEfDbdMK9eFDwylTkMagJuYpciEcCnTmPMw1wvgER+jFkFw768r4S4nxYnJt
cbKDA82uR/chyRSZKbESq9ffyvq21lfnggnxA8urlmEZcgnQ2bPf9+AxXkA2pN5S
OFS81DHs6jSrgvzyzxgV+ntSlyEbZ5Nkczwp4bFdDFWrdKrLdQxQBfik3pHCBLpy
NnWLldJEtNEr+C8n4g8oJm4u3+hK/JEGUpZ1h1M6vKRToDnsgUYG4DklhOVkjMBY
sUuJh5iU+soGZ1Acj1lj+f45V9Y8A7wJHxSa6TK5GHDwYs51AhAnb/8ZvIjHx5m3
bU5bVWRVPgLCP435qRd7oZPbVxhDYL8z9eVvnhe5wCyQhiQYZG0=
=A+Ft
-----END PGP SIGNATURE-----

--2YtZw0Tfs3ybVKNC--
