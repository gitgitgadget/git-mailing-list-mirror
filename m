Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428CBC433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 08:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD6E6120E
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 08:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbhDMIGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 04:06:40 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39483 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239986AbhDMIGj (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Apr 2021 04:06:39 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id EDBEF5C0064;
        Tue, 13 Apr 2021 04:06:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 13 Apr 2021 04:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=bWAGPEQtn3QO7AViTS6AhLjHy3J
        ME61DI4RmnjeWyqI=; b=pDCT2Drtlrvgg8mHjklJNx2ycBHOXx1WBzoWokGbHN3
        M+ZbZuNaITtLgW4pW71hPpPDUXreiGPp8beIkoeBfS2E3935UrPKt4Fyj10Xe4v8
        p2+CVg2WOCfqNFKhex0pxfrXDXyVxOTHualsc/sULUInMBJR6xxG28lAPUw2xD4v
        DUTGbDEV+CZHnrTogBUnrfnRelcDdXB31XwoI/2ToAjGkNjSQSjKjRs9F7g5h/9C
        zIDz9ZAz0aL2TMsWARSfMsA8WG/o4rLsZN6EId8IknTVVXQfb2UPjpJA8pLxpZ9q
        0TKcSH7PjLqC/qLnPnwoNQUlfw0zK1QeEF4GvqykHSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=bWAGPE
        Qtn3QO7AViTS6AhLjHy3JME61DI4RmnjeWyqI=; b=NLZehPic0k6WpvlcIkItFh
        q/r+Ug1l2PHZr3ybe2kFYIgKjhvAyuMZ7cfhDxR+GuDUd0CXlqCJOnhS4JLxDk4H
        rF+FQ6mtO2GKrUVoa2WVJH8OeTax8X7HA33kAkXqi0xhaKCUKyIb1Qt3klrdVmhP
        oxN9Ocsz7PwEOLmIeWfcCCB8AgIxearORLAfpS8eK9SGgt9C1ApHCgitqhTYy3l9
        fnqL8csckbmptFaEptELsARPHvFmGoFVgxOPzVADvOTY+1jatlz/2RT3hF4nrd1Y
        JW//FbppaEAK9GQeJw1XrRSbbEGiF94PXAGqOaDLivKjYcFdtGjjnuxwWEQZkUVg
        ==
X-ME-Sender: <xms:-lB1YA8rmsuNIKPHVvnDuhzx3ZY69Kde8B--CtlOrO1e3gu-3cL_sg>
    <xme:-lB1YIvrHS9CRWXyEzSkVI-GUFonLSfINWlhRcNQgxGlSdcN8VsQco9AtbDb8ruEe
    KcPp5DZjIu0Cl_xNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekkedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepiedvjeefheeiteekgeejveefffdtvedvudfgvdeuheeffeejfeetudeutdefgfeg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeelrddugedrfeehrddvud
    efnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhs
    sehpkhhsrdhimh
X-ME-Proxy: <xmx:-lB1YGCE4JaRgoIWBjocW_M9WYIpMLKLRRyHk4pXX0Mpb1Dfbt2voQ>
    <xmx:-lB1YAcJ6oF70G5M8YdxqpNubu3lJDrgDIpz0Olz6iDElFBgZ97-IQ>
    <xmx:-lB1YFPmeTUR-nNQwyte3BATDSJXXldcusPy_1HuJaY0Ca1wdYthWA>
    <xmx:-lB1YOZKji7KU4ZtLpXGKRoEIAwKmk9liV6VgQSsp_lqimFEhLQtoA>
Received: from vm-mail.pks.im (dynamic-089-014-035-213.89.14.pool.telefonica.de [89.14.35.213])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7B57724005C;
        Tue, 13 Apr 2021 04:06:17 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d79b6c1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 13 Apr 2021 08:06:14 +0000 (UTC)
Date:   Tue, 13 Apr 2021 10:06:13 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/8] rev-list: implement object type filter
Message-ID: <YHVQ9RPLk8/r+8mS@ncase>
References: <cover.1617967252.git.ps@pks.im>
 <cover.1618234575.git.ps@pks.im>
 <YHVMEdeDv9ZeXRAU@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HMEeKcT8JnYwVmZn"
Content-Disposition: inline
In-Reply-To: <YHVMEdeDv9ZeXRAU@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HMEeKcT8JnYwVmZn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 13, 2021 at 03:45:21AM -0400, Jeff King wrote:
> On Mon, Apr 12, 2021 at 03:37:14PM +0200, Patrick Steinhardt wrote:
>=20
> > this is the fourth version of my patch series which implements a new
> > `object:type` filter for git-rev-list(1) and git-upload-pack(1) and
> > extends support for bitmap indices to work with combined filters.
> >=20
> > Changes compared to v3:
> >=20
> >     - Small style fix to not pass an empty string and `0`, but instead
> >       simply pass two `NULL` pointers to
> >       `list_objects_filter__filter_object, pointed out by Junio.
> >=20
> >     - I've changed patch 7/8 as proposed by Peff: support of combined
> >       filters is now determined directly in `filter_bitmap()`, without
> >       having to mirror all filter types in the new `filter_supported()`
> >       function.
> >=20
> >     - Renamed `--filter-provided-revisions` to
> >       `--filter-provided-objects` as proposed by Peff and addressed both
> >       commit message and tests as pointed out by Philip.
>=20
> Thanks. I have no more nits to pick. The only question left for me is
> the big one of "do we like this with --filter, or should it be some kind
> of rev-list option", as discussed in:
>=20
>   https://lore.kernel.org/git/YHB7R8hVRt+V+i2W@coredump.intra.peff.net/
>=20
> As I said elsewhere, I'm OK going with this route. I just wanted to call
> attention to that earlier response in case you had any final thoughts
> (I'm guessing your final thoughts are "jeez, I already wrote it with
> --filter, so let's just go with that" which is perfectly reasonable to
> me. ;) ).

I don't think it would help usability to add new `--show-blobs` and
`--show-trees` options. The user interface to show this kind of
information exists already with `--objects`, and by adding another way
of asking a similar query would raise the question of how these two ways
interact with each other:

    - Does `--show-blobs` have effect if `--objects` is not set?

    - Is `--objects` redundant if we have `--show-blobs`, or would
      `--objects --show-blobs` list all objects regardless of whether
      they're blobs or not?

    - What would happen if the user says `--show-blobs --no-objects`?

    - Are these options mutually exclusive?

We avoid all these questions by just adding it as a filter.

Furthermore, the filter also allows future iterations which build on top
of this. If we had a combined OR filter in addition to the existing
combined AND filter, the user could say "Give me all blobs which aren't
bigger than a specific size PLUS all trees with a depth smaller than 5
PLUS all commits and tags". It's not like I'd know of a specific usecase
for this right now, but I think the potential of having such filters in
the future is a plus.

Patrick

--HMEeKcT8JnYwVmZn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB1UPQACgkQVbJhu7ck
PpRN4g//ZoZvD1hN/4B1Tpqg9pvCIniSr11SLzySoRxCHy+eKUrMIE1woXgF/8M/
0wpDAK0hkA1i54E3zz0OutwqRHL1+2NbRT9sXvmvpTtBeHPhioUobA12v3i9uCnK
2itHjYADlUE3eoHRLGlxyjOAYebCxSLF2Xp4WJueYjTKom9VNwoTJ7PK8lWGv5tN
k/7FM1kYlTc/kHjlHzRuw0U9mA6Nm0+iv/1Hbh/rctp4MfSylENFwEGHaaMMaiQE
bvo96561XWy1L/Xu2kCzY3uw8hlh2bTELTMsoKcQT38qKs3c4cdR4net0vXwhVLC
vUSGCX6bQ5KAr+LJG3bwTksPkK1DnqPZ2PkGDFCrGw9G+uHUahs+ZloX/WqqKnPI
5qyMKtMxxQVDa4qRgX+bHe0YqCovajlfWK8QLMltr65Qn0wTYxtfCJwBKcOPH12t
qaiOtQullbnO939wBkRczSD1iUJLj3RS01GA+tRj4DBu6E3NEwGVF0hStTtGIoda
+J5XDDGWSqccfXIf7zXabQQoyqlHvZSFKZ6Bx+j/mU0Ddc2FA4STXo1LSbj+d4KM
/cgY0rp6MvrCgNYiKDfElq12IOOobMC5hFbUdLBCyvJN1MflrHp1QBLAchBgcLal
Kxa+7C3NgMoV8f+7MuJoq0UeZ0Za36/vOc5z+THjw08pVCP2ApQ=
=/Gzz
-----END PGP SIGNATURE-----

--HMEeKcT8JnYwVmZn--
