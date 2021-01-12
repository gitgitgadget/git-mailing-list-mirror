Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B85FC43381
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FFBA22BE9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbhALM1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 07:27:51 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:47487 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbhALM1u (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Jan 2021 07:27:50 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 137A216A2;
        Tue, 12 Jan 2021 07:26:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 12 Jan 2021 07:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=G0VEokrPqsU3t99Vk2jaPUISVxe
        JSwDYaDjLjW7bwuQ=; b=qYMFCoaIFTLg12wSPioPBRV0XgBY1AdlNL22mv7ZonL
        EL3TGC6Spfbo4Llu+15Y7/I/8MLTuwXzTnAww7OC/cLIcV7xoRsFqiiOa8yVgJ0I
        u7YcwF52P6vxQkt3tKdS+fVYIv/sVtMoP04rApx1vWRT2cz2BRelFJBCP8Rq7rlQ
        MiM7sHc56JRohmjVybEd8KIGJelulBiFm8RADE4ZYHWfb1pBmQmf/oss0k4Dq9Yr
        fSsNTphTrA6XRfxcYUNlIv3MnacxNXDru33QP0YG5e4y0sIMw36xNCkjVRcnv6fu
        4VndG6gpX6ulDf5AWViivSbHxqbRJn3EH4ulNKIJ23g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=G0VEok
        rPqsU3t99Vk2jaPUISVxeJSwDYaDjLjW7bwuQ=; b=qFK+En90p6VUarEa/F3NDk
        88Ghbq0rzZllSdixtT02FKz2sLJN9ZnaN/1pMRQOIEky5RxEc0Zf1DVnAfgWQWkT
        HQuhMx/dUjKfzBvouCA09zXOlyk32avZw90z1SlR+j6vU14/3xpRAZHr3+3SAQzx
        kgBL9su9yTBTq1/thPKyVuNY3ZKx/vEEtcnC7WAISk05VA9/Nbcc70UkCU8VitME
        8ZvF/z5iIVVbnvb4JRJOhFt3g+eOXs73FkMh8iG+Fx9TJDrU+Kpw6637k4sLE+Ei
        Bv4pSIKPkq+yNGASna1c1qyfgW9r1ZllmwrD+EgiF5qIM50d37qgzUc0xBZ/uLNw
        ==
X-ME-Sender: <xms:g5X9Xzdvz1y7AW_C32Y9EM39AR9aTujeyv_4u_adNi7aJYKat5w6mw>
    <xme:g5X9X5Pg52IJvwpbC58h87tuXJFjq8735tB1k2P_llqIymWVuqo6D2Rbej_3LukX1
    DaNcdlS9-zljgNsdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudefrdehvddrleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:g5X9X8gIY-lj5ptOi34ywPRrQ6WdQYrJYOVKuY2xboJ8f9amBXQhbg>
    <xmx:g5X9X0_ZUSYFB1DusyX6k_ijAbUDY8jTB1XrHqj2fa8EDMMPPgj11w>
    <xmx:g5X9X_tELu1ejegqX-SlJzLMwpw8NxAgpejYsXl5lszToJJr5PGipA>
    <xmx:g5X9X5Kd2aZLCUe_waLGQzgMlilzGFRNYXBAPaMUql_6E9-O48aLrQ>
Received: from vm-mail.pks.im (dynamic-077-013-052-093.77.13.pool.telefonica.de [77.13.52.93])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE665108005C;
        Tue, 12 Jan 2021 07:26:42 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 219c6616 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 12 Jan 2021 12:26:41 +0000 (UTC)
Date:   Tue, 12 Jan 2021 13:26:40 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v8 1/8] git: add `--super-prefix` to usage string
Message-ID: <55fa4d0d11f92c5b3c86c47b91ca5f4ceab2f81a.1610453228.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610453228.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="njympwupQe+TXfkA"
Content-Disposition: inline
In-Reply-To: <cover.1610453228.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--njympwupQe+TXfkA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When the `--super-prefix` option was implmented in 74866d7579 (git: make
super-prefix option, 2016-10-07), its existence was only documented in
the manpage but not in the command's own usage string. Given that the
commit message didn't mention that this was done intentionally and given
that it's documented in the manpage, this seems like an oversight.

Add it to the usage string to fix the inconsistency.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git.c b/git.c
index a00a0a4d94..5a8ff12f87 100644
--- a/git.c
+++ b/git.c
@@ -29,6 +29,7 @@ const char git_usage_string[] =3D
 	   "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--inf=
o-path]\n"
 	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects]=
 [--bare]\n"
 	   "           [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=
=3D<name>]\n"
+	   "           [--super-prefix=3D<path>]\n"
 	   "           <command> [<args>]");
=20
 const char git_more_info_string[] =3D
--=20
2.30.0


--njympwupQe+TXfkA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/9lX8ACgkQVbJhu7ck
PpQKcA//aTvHVE/kIPgtg9FBj/0hr/Iy/lH3EAaCivWNWPWkuytDW5SGHHrk8O74
/lX6LAFOH7UNOxS5+OOwoJqtm0YMxjD3MTx7TGwfPPJyoU3sX0ant6TtE+Y2/r1n
BpU8bBkjdzLZ0Kd3306hY/ew61nwNVm773DZEUwaKNGoV74Sj8a12VswiKQMRpo+
udRhVv3E7OITUKeNUfKvcrnab0T4/NSAfosKKRLFozeUFty1906uCNC5Q1u2DA00
VgJS0o6V1DeW8IxTq+WOw3b2xZe3KBpJnCjgwbJlUvtpjLVvVzdS2emnSEMsCC5i
P49l0vpKOM7E8WL2Mduo02FaB+P0kWlmz8t6dvzojphTX6DAnCfdokV9ywAb0oA9
pToQCD5I4oLOFwWhEFuLMvLYm+Lyt1+gh5LqOkMiVes7wOgmxw9Ry6pgE7kMYSIQ
eDA1NwLXKKpTwm89zcJ6V7CUwOU8Bp4S+SQEyRfZWBLwGtC46WIljbAbtKfkermR
/Ij+0tP3T4Rn+raXUzW6uugv7iS19OXR5MQS1R/Paa73kNUos1cWlBQ2RSYJRZ+9
U6WrGG+GSrD2YVhu/NULC6hYKHl7k2ZGPOr0DmDzPnRB23QD7WuymZFBh1wzEGsa
kAx8xiz1wrFeVUsmwCPPs4EIg3tz/yGwjfa+zrr4I/COWED3Epk=
=TxV5
-----END PGP SIGNATURE-----

--njympwupQe+TXfkA--
