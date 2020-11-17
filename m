Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D9BC6379D
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 06:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BCA02468B
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 06:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EOikl9io";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ACxIInOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgKQGkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 01:40:45 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54853 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbgKQGkp (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Nov 2020 01:40:45 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7CFFA5C01EF;
        Tue, 17 Nov 2020 01:40:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 17 Nov 2020 01:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Sdx47JjQ9VHcCLocWmJLgug9ppW
        nR2DVePM3dcFt3+Y=; b=EOikl9ioumo8zUmC0pw2WdE8QBnRySe/Dl+9jPb4Dd8
        LtRXbtaK5dm7cGomBBIU5RMsbFwhuefIUzx7v8CzATONv/Fo6RP5tDmZcRP67C8m
        PIVdTZVW6BaebiQWAWCsoJ3sgKvx35Av5i8zEycOVPCt6F0Acl2FCU8oipqKfuPW
        57MHMPToTSV79bJleB+bXu7p/A5eOgchQ4112QD1EDnDlHfK4XoWTxUsZrM6hcIq
        LGWOoweopdl63q6U9cWoCfp+Qhzu7FkMAfSjZvQ35JQE83x/uUUFfLHov8XR13eu
        JJUuQCk9i4JX7EkljQiYE8fH8bKd3eAWPdUpC+Ri3tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Sdx47J
        jQ9VHcCLocWmJLgug9ppWnR2DVePM3dcFt3+Y=; b=ACxIInOmn5f1Whlq+AR0ce
        IrWmOv1/srCu3CnoDmBzWqc3Q+t3SQSEH3eVEctZMe9WgQm7mZ90cbnOdHvo6Oyb
        SbOO+DZe9St+6myRFABRxC4t+VquZ7PDJHopmYrA6PaPoxUFffBWBdoG2Ra045Xp
        DpiDcq/DnOgDhshdsEPOdCXg4R81O/srei/GKwRcUrGw3sQlMYBSyqvBtbGiFS8p
        X97oAuBOainWPZlq6mRMqH0yeO68tD/qbFMsRUbmhkMtKaiH4sflVkj6d/NQQ9Sw
        xJTTG87dSiE+437YAR93CSXzFSAjD/KmG0WC2So9q/iMSdX6QRgt8YbalP+8LQiA
        ==
X-ME-Sender: <xms:a3CzX9OnoNwGFDWK6JbpSj6NjPNyAdGhGmAvLE0lTVC8Q0vkkX3GvA>
    <xme:a3CzX_8iqT_qBkumJrVpMRIx5LVFjE3RNW8S6gUeMMTH0JY4aw4nZGxH2GXxzck2X
    XBezdX7WpDNjkV9bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefvddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtffejieduudelhedvgfetieefleehjeetvdetudeitdetvddtfffffefhvdfggfen
    ucfkphepkeelrddugedrfedurdefheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:a3CzX8RY6Wxm9hIaqAamW9ZFhEYkJtsEmEwdHhmXnNIHIrZN_ZSlvQ>
    <xmx:a3CzX5tPrhYvZtN-cCGTO8yY1wyCdPMg952W5qC3oKNrMqWaaeGWZA>
    <xmx:a3CzX1fr5EyXiRI0kjgagIFF61JVVZAnQ907Vg2S_EsnnA-rd0xVGg>
    <xmx:bHCzX7oWKSGH-T5TKpI-mSXamX67sAZJWgXuL9U-5VRyb_V7mn0P9g>
Received: from vm-mail.pks.im (dynamic-089-014-031-035.89.14.pool.telefonica.de [89.14.31.35])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6FC2F3064AB0;
        Tue, 17 Nov 2020 01:40:43 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a7b13ce9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 17 Nov 2020 06:40:42 +0000 (UTC)
Date:   Tue, 17 Nov 2020 07:40:41 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar
 pairs
Message-ID: <X7NwaVNhUFMZzO3W@ncase>
References: <cover.1605269465.git.ps@pks.im>
 <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
 <32a5617e-49b8-c6e9-4b1e-09e77bcae8fa@iee.email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HNrz26owVwfjkdLb"
Content-Disposition: inline
In-Reply-To: <32a5617e-49b8-c6e9-4b1e-09e77bcae8fa@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HNrz26owVwfjkdLb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 04:37:33PM +0000, Philip Oakley wrote:
> On 13/11/2020 12:16, Patrick Steinhardt wrote:
> > This commit thus adds a new way of adding config entries via the
> > environment which doesn't require splitting of keys and values. The user
> > can specify an config entry's key via `GIT_CONFIG_KEY_$n` and a value
> > via `GIT_CONFIG_VALUE_$n`, where `n` is any number starting with 1. It
> > is possible to add multiple entries via consecutively numbered envvars
> > `GIT_CONFIG_KEY_1`, `GIT_CONFIG_KEY_2`, etc, where each of the keys may
> > have a matching value.=20
>=20
> > When no matching value exists, it's assumed to be
> > the empty value.
> Is this a good choice of default in the face of potential mistyping when
> entering commands, or cut&paste editing of scripts. It's easy to see
> cases of mismatched KEY_2 VALUE_1 entries.
>=20
> Wouldn't it be better to warn about un-matched key/value pairs?

Good point. I'll change this on the next iteration.

> > +GIT_CONFIG_KEY_1,GIT_CONFIG_VALUE_1::
>=20
> Shouldn't the man page entry indicate that it's '<n>'=A0 ?

I wasn't quite sure how to document it, but using `<n>` would indicate
better that this can be multiple envvars.

Patrick

> Philip

--HNrz26owVwfjkdLb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+zcGgACgkQVbJhu7ck
PpRGzA/7B1/nNSEd7npNJAXiJg7gRsEl7cRDvp67AiVsSPxFq1dZ6JFKgr6GNNNw
Lf13hDcxODg0B0+W0FtTAA8PCV29l/+im69J/XryrBXi5FloESdkkVNfjDOSNitC
HV8jh1ruSzITGxlVAZjZlLoGaUa92RnLqrYMgtxp3qc2ErUX+QPOP/AHs0lKAN+Z
UUbB7oy5fH/RzLo9zPu3PYTorgqBL/SSgh5rXyJ5cUeweJDtfmGElBmCoKbcPvPT
pUX5D+OepiLKkkpKRvs5kuX0Y+hqqf9etmtrl5o0o78MoHUg/io8dOsetXpiN7W+
udZlaCRWJZEc4HDSBK+qQCgp0RW6GRYH2+ev1zWyOVixlPGCrQlhsHolSUM/IfRA
SpkfiaXYNAy3IowQHzxFAZtc0Cwn4sCrn/tk6SwpmNhA1PehpTdKtf9t9BgjyDca
b0ZrJuWbwQFSpcAP3FHLEaiOBXZgNDboEPLh0pXT4vpHKGruC8ewRb5XA9yePBAH
f8o1QeuoLbu6RxaE9luFuAZXiNL5cu4NTdNiII/F74dBf0PXFvb84nmkvXKt+H9r
E1dXVI4icd/jZnAWOlzx3eu8YSQuC7C1v6oQW925kpQp3u6/YXCYl6jcSPj+OL8c
0HOihH6tETG6ktd9dWsWHxcr+o4p8UY4a3MOhDP3RYWFzlJjXQc=
=EhbW
-----END PGP SIGNATURE-----

--HNrz26owVwfjkdLb--
