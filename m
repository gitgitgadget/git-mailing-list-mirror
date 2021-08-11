Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C98BC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 12:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21CD460C41
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 12:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhHKMVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 08:21:38 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:32793 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231377AbhHKMVi (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Aug 2021 08:21:38 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2EE965C0091;
        Wed, 11 Aug 2021 08:21:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 11 Aug 2021 08:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Gs/vM5AHMTfZdDb8DoI+gwsDwfy
        Wi6Jz3gk5C3gUACs=; b=GJDv1GXa1YXhe6TAyu71rJNTmZQtKssbdVdXEuHiA+k
        GhVZxrJg+esDkRLOWe4+kEQ8qS9Yl8m1+gDMKCsoDrVrUI48TOFWNiVp5jl+2/S2
        CLNwzARWxN4AsjWy3EVj94mBib3m50LDodww9JUdRSU7yUp+ggVcnORxdwCN1IaC
        WMm/FRiUEo8yJYg94iawCEOr07nFm0l3+yImCl+z8+EDQq3C/rohdoLrUYbqwqMd
        4oxiPnjUG8TlSiYG6iYqPJXk4gj8ucH4b98oG2bMb3eUu7EAR2hUwFbhIqlw/wTQ
        9dCaa9D9+LIKBZuCsidMI4YDSpR+LdkOfmuzu87dUkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Gs/vM5
        AHMTfZdDb8DoI+gwsDwfyWi6Jz3gk5C3gUACs=; b=CYK4onj4iLB6MnO0/3POmF
        rO2WeYstomXuNmRfWmXY7HpXzPiu4UfM1u4F0Udk7nucKTMxbRwhQN2m4l5Lxs8A
        xEw7Wjn1lIPAhNigl9W+HPoifVCmNfzlKKhTv2KhGlU3qISaJvdOpFr+RnkyeM64
        DZLK2sJTk/jP4TfVeU6jo/3Ijwrc1asAA3AB+mLasxvsufcjNSgyi+uOIEB/Kyev
        dXEs9zrezZsiKDt42tlh1NaZEo0C7hMjBhjJqOMErrQnXVkcik/bm+fScLEhzpej
        6lo7+ek1GhHXAOcNwJc9BFp4FWlxKfkTfba8nnVKkd/DdT4i5XYNU431kShuJ3gA
        ==
X-ME-Sender: <xms:uMATYeygfeq93VQozz6FpISY-WMadxpNSlhMQlDECqUwJpnOti75XA>
    <xme:uMATYaSol_9vmLMYn1FO_rq6JjPzHOn6fbtUuBDccI5D5Bwv-JX0qIKGYHNasvxLg
    NFbi3s0s_x7WMhbwQ>
X-ME-Received: <xmr:uMATYQV-pru2AR2vM1OFtqrdqbAN8ONl85_Z1tHJ9U0iAu-TiOHt_CJ_LF6IHjuA1ythjKBXBcdDuXDTy_NRKgJ8xq-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedugdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:uMATYUiSm0KO4jkwfegkNcOkS7ziep98It3WiFfLZAW1qP8nKR5fkg>
    <xmx:uMATYQC9TahkrJcGgjDzUWCBJuZovqkt_DYEGY1INF_6_vzKLuEdcQ>
    <xmx:uMATYVIVzj0z11tDYJ78lxrPm9rvycFhc1L9kbf_5LN-eoIBKYnIHw>
    <xmx:usATYbp2wRJsQOZ37kczlIFbaITCckzAoFhAib2kPyyg4SBV26jN6Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Aug 2021 08:21:12 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f2b8c42c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 11 Aug 2021 12:21:05 +0000 (UTC)
Date:   Wed, 11 Aug 2021 14:21:04 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2021, #04; Tue, 10)
Message-ID: <YRPAsJSfVbNmYh3v@ncase>
References: <xmqqh7fwbx86.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pEygjjn8F1jEDGg3"
Content-Disposition: inline
In-Reply-To: <xmqqh7fwbx86.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pEygjjn8F1jEDGg3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 10, 2021 at 06:12:41PM -0700, Junio C Hamano wrote:
[snip]
> * ps/fetch-pack-load-refs-optim (2021-08-04) 1 commit
>   (merged to 'next' on 2021-08-09 at 4744a01fd5)
>  + fetch-pack: speed up loading of refs via commit graph
>=20
>  Loading of ref tips to prepare for common ancestry negotiation in
>  "git fetch-pack" has been optimized by taking advantage of the
>  commit graph when available.
>=20
>  Will cook in 'next'.
>=20
>=20
> * ps/connectivity-optim (2021-08-09) 5 commits
>  - revision: avoid hitting packfiles when commits are in commit-graph
>  - commit-graph: split out function to search commit position
>  - revision: stop retrieving reference twice
>  - connected: do not sort input revisions
>  - revision: separate walk and unsorted flags
>=20
>  The revision traversal API has been optimized by taking advanrage

These descriptions end up in the release notes, right? If so:

    s/advanrage/advantage/

>  of the commit-graph, when available, to determine if a commit is
>  reachable from any of the existing refs.
>=20
>  Will merge to 'next'.

Thanks for both!

Patrick

--pEygjjn8F1jEDGg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmETwK8ACgkQVbJhu7ck
PpRydA//XA2lHei3crFYceWQwM6Q5bjqymnI59Iu50m0ofj2gNB90/eWzk2nHjtz
k/ThekRum0yuMqp9c4gMjXV17s21Jgtp8l03HTBDC9F13dZfbYhdIXyZmV06OSSr
td2OAgK9LF6tPIKKEn3vuMifKK8r+gKRtc0/7V1ehKgLk3oYZoWb/xD5bLFYKjgS
EpT4YIj+BrNSU0WzEwAG8qNIgNOuUZeYW704fU7d+X9vCZS/bmDiCTT/E+ThEOSF
wtU2aOwVsoy+oE8/R73yzhUxLip+LnYEvXwdFVsrudE1Fnm9mCebG5wTi89ylxf4
FbW4HcYXEJlQAPuC82exhMf5MO93/MVQ7ouKKSjWFHwXBKQY6pDWFbvvgmr8sfWo
oHW32JeoXbWSl1TltccsTa6h/N6ZG3iQZgZqHhGiJ5okIcDP3CiX8UNTIdDAa+XZ
CRQ3bAYRL+JokjHYe83/Q27YbZmZU/cxlMLd41a7o70bAEiYuEEjKpi2w1WEBABB
podFgobrI0Zikl8mZ/IPQ944mpwlRFXwChCdKddikjSeuUJIHraNS6bdHMqaOzU6
sFWfPCrkYeo/kImRpFyOAJ3luEcGYSVx1wDsmVUqPBdAJw2OM+Wmr3anAVBT3J/u
BZal7h+ftm7emwFd5xUt3zKhtlLaL0ls+P8HTt8yFsqfPc/Yt7U=
=Pm1n
-----END PGP SIGNATURE-----

--pEygjjn8F1jEDGg3--
