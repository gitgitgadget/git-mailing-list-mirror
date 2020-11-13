Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1148C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 08:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4828E208D5
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 08:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fgFcRpnI";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gsfjUsAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKMIMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 03:12:32 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60293 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgKMIMb (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Nov 2020 03:12:31 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C863B5C00C5;
        Fri, 13 Nov 2020 03:12:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 13 Nov 2020 03:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=mJc3vLLoyZXRGcOMuHmiUujsB52
        SU79ji4FLJWzaoh4=; b=fgFcRpnIPIv6PhUr5jye2Q8xGl3lVreD2TBZ4naIeuL
        UeAj1of41dHo5HCZ3pLMv9zW8sFkmxgVXJ5IjhJFRp748kNb6rRsAlg4PDZhUklc
        kXyZtZhOEQpwetPlC8x86+jOJalqcr3ADkjfZyG00Okvxc6Fv6lj86JW7kzkKT1a
        fdcgvCii8XaRwDWO28/rfAbzUW8BD+OjvuKzgi8hJkgSLlaHmDWqytn3P1lWRjxL
        /k2TKmMvf5ZYv5eWWY5u9uT7CtgGaXQex8bQysXaMOzTxLhHnCl95VjGuKi9N/Kc
        bQ3dGxh3N+3C3ghuRudvyphLN+ixDaqul1aK7aOD67Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=mJc3vL
        LoyZXRGcOMuHmiUujsB52SU79ji4FLJWzaoh4=; b=gsfjUsAwF0SJLyHxrN8UQB
        8mJc684dmsje7E9evHAhN1tdq0L6VbmlVghCuAZW5DtHkQZdya23r2niamgMdEyY
        yg+sGgfDEGeGx3Gd4Jue+oh8KP+u33G6bcJvDtOtZaUokufItRKmzXZa+Il+eVBZ
        ENjPAm8H8zAsmlKi6zYckwzuboqsqaiRwVXAFkAEguvVBYfefWsXVCQnk9o7DHbz
        IvzKChiaXFs0I1vTK0IHLGAEEt8K81E0TexCx6DsRn3ORhqrun+OrImNGzjkve2D
        c33pJhTSh9eUUqo34xHXweyRn0EueeIWhJU17xwG31NpBS+tcbooOz1jvBBbi+Mg
        ==
X-ME-Sender: <xms:7j-uXwkJ46gr5N7PoOR55gFn-iY68l539AULuycW3KWDl5iAnq2Z-g>
    <xme:7j-uX_0KC00xTSY9mgDn2SJoztEHzHxmtdBUVa9F29hSYGW9A2DoPNribQ9yvIQoA
    0WJqnC-wjcxLw8nUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvgedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepkeelrdduvddrfedurddvfeehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:7j-uX-pTLzgMywf2Y-EdG5s1s8lJzsfiBEz4g8_JZ5qmrSU6AM2knA>
    <xmx:7j-uX8liJv4CnOnKNxoHKp4y9fsJzGkp6rDPIf_uTVLb1mgHbbnggA>
    <xmx:7j-uX-1pqE5gwPqI1rz2Qe-98z0XT3nAFumSzyMhzK3Op9FExNzC8A>
    <xmx:7j-uXz-esdPgahhIvMiXYEDgbFJtnjQmDTXOJTYEXm0-5e6uSr5cHw>
Received: from vm-mail.pks.im (dynamic-089-012-031-235.89.12.pool.telefonica.de [89.12.31.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 902873064AAE;
        Fri, 13 Nov 2020 03:12:29 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ec3f1ab1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 13 Nov 2020 08:12:26 +0000 (UTC)
Date:   Fri, 13 Nov 2020 09:12:26 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v4 0/4] update-ref: allow creation of multiple transactions
Message-ID: <cover.1605254957.git.ps@pks.im>
References: <cover.1604501265.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zp2l8JtJlTdSQTi1"
Content-Disposition: inline
In-Reply-To: <cover.1604501265.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zp2l8JtJlTdSQTi1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth version of this patch series implementing support for
creation of multiple reference transactions in a single git-update-ref
process.

All changes are only in the first patch updating t1400:

    - A stale 'rm -f' was removed.

    - The workaround around broken repos was removed as we no longer
      delete HEAD.

    - Tests have been improved to verify that deleting a symref won't
      delete their target.

Patrick


Patrick Steinhardt (4):
  t1400: avoid touching refs on filesystem
  update-ref: allow creation of multiple transactions
  p1400: use `git-update-ref --stdin` to test multiple transactions
  update-ref: disallow "start" for ongoing transactions

 Documentation/git-update-ref.txt |   3 +-
 builtin/update-ref.c             |  15 +++-
 t/perf/p1400-update-ref.sh       |  20 ++---
 t/t1400-update-ref.sh            | 138 +++++++++++++++++++++++--------
 4 files changed, 126 insertions(+), 50 deletions(-)

--=20
2.29.2


--zp2l8JtJlTdSQTi1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+uP+kACgkQVbJhu7ck
PpR9+RAArDNbLt7TsWfIeWIyghFPTTs69KSqL+zegqm5OA2jSOmJQZFvPZJxlI4o
BqV3A1EsHibqf7knPqsikA/YCJ3GMXo/+vMj+cJUCxBXselyrwSLFT6e5xz8Y7ZE
UZJld+Ctn728EJp/JSe4IuHylN5uRyABuaJbMTT5QAamAyWYJh6uwSMhuu7CSYYh
v1BGfVCuOZ0cEqCJ69yuret56R5FuaIiLOdf2FjWT87DeOAHBUnpTt2bx+vuIbGj
kA8CDK/U7bI+h5uv1mEPSODvqop9pUEQWgbQmDQ0W/kbbx12nyDMAL2kcckdP+Dy
IaX7NV8WI9886GLwAIvGr+CwkWF3qztcXEx+UAElbaYUkFgY35gtYOMfRQgqJQDu
MlWsGyFEkHf5m20ZC/Pk7scSZzBtOqw1+vc1eAG6Vz+FjE9jUrQ5siqtphSfUCWH
O6cwpM3/KH6SqVnFsQWm2DJ963o1gLbGf11+Dgi1vIM9nHe8W5WAFYG7C6heptnd
Fp6mgm+BlJurHQ4VtIRBMsPdiTdMcj6YRjG+snOZNfogOZ7XZ3GGSCqda+BsUr2L
2PLP7lQk9HeBCyrSS6YzyEy/z5bkYdLCKr9CGg3oU7OmmJfPtfKtsZPJHEPxxAZr
SulzJhglfi2q918OcNNfkZUdKAQ6CCk2+CcrKeIeInMZUipotIE=
=Ot3r
-----END PGP SIGNATURE-----

--zp2l8JtJlTdSQTi1--
