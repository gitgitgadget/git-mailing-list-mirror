Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E491C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBAA022240
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tgLu7d69";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c+gp/z0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgKMMQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:16:21 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:47585 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbgKMMQU (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Nov 2020 07:16:20 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 08A2DCB3
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 07:16:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 13 Nov 2020 07:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:mime-version:content-type; s=fm2;
         bh=wbw+wm/iIIe53Q77C8EB1A46QWKFxgdTOCeUo/hxJzE=; b=tgLu7d69t3VI
        k7SpAMnNNX5DuxxbI1BicLBFjulZzu7cL4sj6RVaARVziF0AWZk0zXWRHZmo/4bg
        AjkPR5V1dTHbTgnYwZ5CFUUXAsuL4IIvPGwOb+kUgrauf9JbfClzfQzeFyqUVHC+
        7BZF4xI4DxfaI61dEw3WQsneV3Y67YbFFSAWCMXhPPYtpNWl2pcWPmI2eUPJ4Olh
        ACLBLvv49wZkKKsp0IQcDmzzCUcyVB5NfQ0jLtg4GQXBNsiPGSdHc4zOxkmRAD5X
        XjEepD4hAJaQdwk10Ah5gSziWATn/mpoklKHad1MzJaoeuBVBt93ZLjESDMQfC7J
        81Bu40uHaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=wbw+wm/iIIe53Q77C8EB1A46QWKFx
        gdTOCeUo/hxJzE=; b=c+gp/z0VZcwaAU5SiYZqgGvsQJg4undztpKbzKU7BmZSU
        I96V3V2TPirAzQF75p9RR8Kr/YfJIdt/binOtAEZBk/jmX3kj1xZAR6h6ADEEPi1
        e4b7DdAMRlzJsKcG8f3J3NRxTDvXyhYD1FFr/uuhr1ppL8obfOAa2YbSb+EzKg0R
        K6dgPRXkcColcVM0Bb7DEmgc+0K79o8Aep42RH2e56OaMqSI+Q+AVy3NyOZ3zvKx
        PRx+mgUkikKJbhzmxRcSA/Dkqm2S6WYKsiW3nFqpnpzAU/HAOu7RmBt6Ymxqovhj
        noxxegU9kh5zFcf6UDLcbwZUVe4NCnLAPpAohqfzg==
X-ME-Sender: <xms:EnmuXzYxefMvdeoETwV1-vZm-NZB4A_iZDlMGz_iWsPmYVqIl1UvRQ>
    <xme:EnmuXyaUjgZXprgOV31iBHlxksD--UIvOlfoJa9lh1qeFwELqniJFAyW9A6JXIJ_B
    phDu0T-LY2u5XLP1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvhedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecukfhppeekledruddvrdefuddrvdefheenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hm
X-ME-Proxy: <xmx:EnmuX1-QN2IuIGMfkA-YwqVLTbT2mCdCqJSENMv1bLYNhHCgeqW2PQ>
    <xmx:EnmuX5o-1XvayBZcqCW0E7RYyLC5MUZQNrkIHa1hc9OAj9yxecBQXA>
    <xmx:EnmuX-rHRc4zRSfHJ9YwMxf3MbbLxqhtYKxhtjdkaRkPBn-EUbDT6w>
    <xmx:EnmuX71MTtviixvCyOGD44uoQ0kiC4F0fptmOPbFKqYaKRRy9xxPYA>
Received: from vm-mail.pks.im (dynamic-089-012-031-235.89.12.pool.telefonica.de [89.12.31.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 14D523064AAA
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 07:16:17 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e28368a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 13 Nov 2020 12:16:12 +0000 (UTC)
Date:   Fri, 13 Nov 2020 13:16:13 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] config: allow specifying config entries via envvar pairs
Message-ID: <cover.1605269465.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yA6s6Gg27gIgz0F1"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yA6s6Gg27gIgz0F1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series adds a way to specify config entries via separate
envvars `GIT_CONFIG_KEY_$n` and `GIT_CONFIG_VALUE_$n`. There's two main
motivations:

    1. `GIT_CONFIG_PARAMETERS` is undocumented and requires parsing of
       the key-value pairs. This requires the user to properly escape
       all potentially harmful characters, which may be hard if the
       value is controlled by a third party.

    2. `git -c key=3Dval` is not really suited to contain sensitive
       information, as command line arguments trivially show up in e.g.
       ps(1).

This new way of passing envvars tries to fix both of those shortcomings.

Patrick

Patrick Steinhardt (2):
  config: extract function to parse config pairs
  config: allow specifying config entries via envvar pairs

 Documentation/git-config.txt |  6 ++++
 config.c                     | 65 ++++++++++++++++++++++++++----------
 t/t1300-config.sh            | 23 +++++++++++++
 3 files changed, 76 insertions(+), 18 deletions(-)

--=20
2.29.2


--yA6s6Gg27gIgz0F1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+ueQwACgkQVbJhu7ck
PpQs8Q//b8N5RPsB5bzLh8XaWbHcY3oDD1L6i6ZNF2OC3XcPP8RRooBypfaGsX76
YtQWeyb/IqIfNmodgcl6KmAeU5wXNY2QN89bwTjlMS93K0YYeF1ZEuxg4dWobVTw
7Mnz9B0QSdGBPy9WpOqztbMdVVK7vquVDyVHkTJpvw5pHAMYzZ6mzaAfaeyIk7v7
LoT1LU2Sfv39yYmCgsFCpunGhI21Bwyj1oAXEdDd41Z2FANvx1VzaldmPjEnB+gK
MqC12Eci+Y4RtWOG3fj/YFcv6JtKw+2Lh14gZhdHocBYzSao+M+ZL1TsZa1Ew1sS
aXeSKba2XLyYWaDCkr6PVynbwpiqpm3LlqLJ/FVftsiQ8tVjj9vyAH0wYZgvBydg
lQlSZx6r9CvWxJAe96q0FZIv8tm05MUXGROaTx99P32GdvodPFrpkbn6xrH11Kcj
stPgFyAPEZod5IdesTdWiuKPBak8uIIfuKFK35QCwPgQ7cG9f+oK9wDkvou6Uk+r
YIp/Zehb342glRjmiYZ8K23zXq9vxIrWGjphP3U91Vo54FO+gEYaW34K4x3u+lR+
XEggNyzEUyxwYwVWajoBFovMsANT1LZPzmGio4G2JYvfw2MXQU3L/WoyICC/Rnq4
CFMJgN/PRzDzakM5xEoMvJs2k/XRzy8tF13mMS+QZPBixB6vRVE=
=NJr4
-----END PGP SIGNATURE-----

--yA6s6Gg27gIgz0F1--
