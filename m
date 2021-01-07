Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAD5C433E9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 13:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558F122AB9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 13:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbhAGNwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 08:52:46 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55863 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728445AbhAGNwq (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Jan 2021 08:52:46 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A39675C0158
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 08:51:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 07 Jan 2021 08:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:mime-version:content-type; s=fm3;
         bh=SVPKhVY7AfYV82bqxXgDBSNulD9ZZd53YXIo2FrsVWU=; b=Eeh12ipyEI+X
        7EWjfthLiKZt/4V/p6GWNlJKfdCtyNf8cRDWStvrXS9IARSOI2EO3eI/OkfL3cm2
        1nflaufNV0bNlSwnQkqIGMV6iNrYzUSYf+R8MeWR/Eu3WaGzii7t1feakayq5kEc
        7itBtsAa7RLl2cQV1M0Bnvez25X5YB5jJytq2GtmWBqCs5tC8JM571oN2kJK0pYx
        XNFqoyX1DLdypWuLbeKGkFEqCB8FSlWalHCeLsC7iGc92SohTuT6o5IY9goPMzfI
        vZdenKqd1AXbpKQUesntzyKOzbR1QzO6hPTb6HW8psxX4mYrnZK2XbVTfj2BvrfL
        yS7dG1MW8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=SVPKhVY7AfYV82bqxXgDBSNulD9ZZ
        d53YXIo2FrsVWU=; b=ElRRl5fButKeJqXCwote/ZwO1WfZ8aEIzHgCUX1nv3unA
        9WR6EVvanv4a5OjFRY7tDsO/Z9O5Wgm+nTMg1qxlWYlwxhPlPguf20i+1BAvqHFl
        Jmq/NHRzw89UrHN1SpDv6SCjaifIdZQsmDN/bXXOkmSaljWErVjOLTforVG+taPc
        sn6ETP6PbTf9R4Z0iVjN/Zu50KFyD9tDPKEBIolguMzGkFh30rmhHB0i2sI1baDq
        LL3wb0qLPeMQhLskvtRvOLCkfSJ39PhQAsL3hW7wktUUuObK1jgzGMKpXGi086gk
        QzLIGMYDZGAV00VqHd9rIjPDfk+xMs1FucRUeOzZg==
X-ME-Sender: <xms:6hH3XwtfoYkN93IRFDzTGlKH5rmVfn_7iVb5pjOHaK0V6Fz7o5CNMA>
    <xme:6hH3X9d1MwXlyDEg2AVaC5LtCTt4oLeZZr2m7QEkexusQN2uIpMAhjaCNcFf-SbSI
    fDHpaLFuA0Ijcr6fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdegvddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecukfhppeejjedrudefrdefgedrvdefvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hm
X-ME-Proxy: <xmx:6xH3X7yuXH6_VCsenVK6iMzGlGCwDwNNqzeoCbPoRzHOTCSDCp9-EA>
    <xmx:6xH3XzO6pnQ614esJt_7uv3rYOESBwPuTNLRN07e1zZMOgpBHMxdZQ>
    <xmx:6xH3Xw_ejpNs77fhOjcXe0e-vsvLUtsK1JGP_yd2fVwg4s6ztkKvoA>
    <xmx:6xH3XzKAvBXaPWcgyTNrs8W29kWPIZFE4vvjc4heJxSFsNTToS1EsQ>
Received: from vm-mail.pks.im (dynamic-077-013-034-232.77.13.pool.telefonica.de [77.13.34.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id A7B3F1080057
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 08:51:38 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0c2d113c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Thu, 7 Jan 2021 13:51:36 +0000 (UTC)
Date:   Thu, 7 Jan 2021 14:51:35 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] fetch: implement support for atomic reference updates
Message-ID: <cover.1610027375.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3s4WtNM4aCsWCIyQ"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3s4WtNM4aCsWCIyQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is a short patch series to implement support for atomic reference
updates for git-fetch(1). It's similar to `git push --atomic`, only that
it applies to the local side. That is the fetch will either succeed and
update all remote references or it will fail and update none.

Patrick

Patrick Steinhardt (2):
  fetch: allow passing a transaction to `s_update_ref()`
  fetch: implement support for atomic reference updates

 Documentation/fetch-options.txt |   4 +
 builtin/fetch.c                 |  72 ++++++++++++-----
 t/t5510-fetch.sh                | 139 ++++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 18 deletions(-)

--=20
2.30.0


--3s4WtNM4aCsWCIyQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/3EeYACgkQVbJhu7ck
PpSuQhAApPBlpx7/+mmjX/+ze9+SAyE7WAeIRTlTLWPPOBovJIbPNjjXJvFgMZa2
Ska+Mhv7iE64ukVLbhVhmuTp4wEq8n9iS948hFip+tosm1WjiISvL1OM/ys61Eo1
Ij+eWtZuU39reklTVJDy6umdkuYNz120jMydT7t8wH3ASudbI4a4iDeWDIfFIcjW
k6VcFHMSOkssjw3in36UzFOc/6Z4ytPcsbGC9BpH7pKrjZbQE8KDzWJsYqALMwI+
Ek0qXRttzriM3sAB1BOHSTiAnacxXEvphH5491TfXr0mGQI15r92q0yigBnBTIgw
jdgkASThsOXyT+UjxxKmgYpBQSAFDmo4NE2P7eXuL/NxrFggDs7knE4it149U73f
tJVCnESNVSihKxk/bfnC/FGi0CryXwzB5O3x83Pn+top654dHcmkCTIGH6fz7FTG
WY7PRVtSm/I4hh9G8gWZiKUXEQ7Ng2n7UpGPUs5UvuqJUQZygSvMBlaqFO1N4voh
Q7HuqfCIAQUMRZ3HxQdwY1Dn0hCDKP87wBv1Wq1Iy0IP7wlTPuJSyaY/M2Uq8bri
VsAsYoPMaG1l0Ip9s87NDo4eunOBmKv+ZR4go3RG7OtfoBuidKrgstAEsBwfYY8F
9H/y+5LN9RfOO4W6PkoReTNBOZaopU42+Lf/E3RzMNjzd6JC+C8=
=wtaT
-----END PGP SIGNATURE-----

--3s4WtNM4aCsWCIyQ--
