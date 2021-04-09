Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D948C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 10:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7337561165
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 10:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhDIKVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 06:21:14 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54359 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234409AbhDIKUC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Apr 2021 06:20:02 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 97DCB5C00C1;
        Fri,  9 Apr 2021 06:19:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 09 Apr 2021 06:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Pm28zkRU+a3PbncOnvWnAdEB731
        KCoH8rurNE2IgD/M=; b=nCrwd/mhPanoEyIFpTBUpjC/3xQQr7fqx2nUdDqykfb
        FHj/8MX2tuolZHS00i/nCHG6LE9onEn7COtalbbMqeA/dwBAAwtAUHQwwXc2sEly
        JknYGOu+WxFJMHA8ajtlwtmXyrduWrO/jvT2depcZhctp83LIhDexHKIFzC3yuSA
        mWd7MLxN1zYxvIGdJQ9EGMB/SmvnEYR2H0T/c1XQhcKL1pIWYF+Majxe5BgzIgZm
        ATFv84/7cV7bHmejJImtQzg07gRyCSUzb19evNTgGISIo1y6qsvtmuQDvohcZAGN
        QLrKrMjo8ym9Mg9Mr7GmMCKjdOEtzdtIaKuPCPYmnFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Pm28zk
        RU+a3PbncOnvWnAdEB731KCoH8rurNE2IgD/M=; b=ttLETVWlVRqMhYq+K9ZFpu
        5fySWi/YlfC8z6DURr2LeJBpXDHe8ysDDKOJ2bm7DB26BlTBWhkMqECxh1QqDBIF
        bGjlGoPZX84oXiEYXG2q5nC01VMVGRZgqV0A4bvkFvDbvcVQbIhjGp8iKsI2kXfk
        jN6bvWOIWmN2Z61Q3qf0BEozryQxPbgm1pv+ZnMMfee0QjgNhPutvvz+iHtHGj0/
        y88RwhZh9WfCx8sE/aPo6Sf1Bj+5sEmc7v/cPOMcVoTJ03+lbjxbkYEBtcfFKzCR
        nMSfOWl5uI7RBHeLvDr4iX41nfzgpJ/CkMYGSCy3xlLPwBoFNeZSCLSMMk+oGxWQ
        ==
X-ME-Sender: <xms:QypwYMrlyMzELMITeeh47NuMSBS0zi-zLCcO6-qUbXfuNtLjVY0UAQ>
    <xme:QypwYCpvK_plWMnNLoyRaF7C2fVVYNhNsoHS6U75Oz24P9mgO2dzMZeDmDA6rdadO
    oyDaEcMo6alQZLXUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdekrdduieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:QypwYBNpdmgYiqMUqoU0xQIW76TZJu_IpH_ri5Xou2sM7PaL3vpweg>
    <xmx:QypwYD47OXk9whU_hwIX61eeDXHziEu4C2W-gg879m5UhgNQSKL4qw>
    <xmx:QypwYL6xA6ZPHKK4KhffyAYirb9YBd_dcFuoKwyyYpNVOv7HS1K8Zg>
    <xmx:QypwYFQweVlaXDJ706eISFz23nDdTLVbQipst8_HX7oGpsU4Ra0YDA>
Received: from vm-mail.pks.im (x4dbf08a9.dyn.telefonica.de [77.191.8.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id 89C3024005C;
        Fri,  9 Apr 2021 06:19:46 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id dfdba3e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 9 Apr 2021 10:19:39 +0000 (UTC)
Date:   Fri, 9 Apr 2021 12:19:38 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/8] revision: mark commit parents as NOT_USER_GIVEN
Message-ID: <YHAqOj+vboM+9f7d@ncase>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
 <ddbec7598664bceee50213a41fefa248d249435e.1615813673.git.ps@pks.im>
 <YGya0XY969HlyPWl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JPGwkoYrZLSicn9K"
Content-Disposition: inline
In-Reply-To: <YGya0XY969HlyPWl@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JPGwkoYrZLSicn9K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 01:30:57PM -0400, Jeff King wrote:
> On Mon, Mar 15, 2021 at 02:14:36PM +0100, Patrick Steinhardt wrote:
>=20
> > The NOT_USER_GIVEN flag of an object marks whether a flag was explicitly
> > provided by the user or not. The most important use case for this is
> > when filtering objects: only objects that were not explicitly requested
> > will get filtered.
> >=20
> > The flag is currently only set for blobs and trees, which has been fine
> > given that there are no filters for tags or commits currently. We're
> > about to extend filtering capabilities to add object type filter though,
> > which requires us to set up the NOT_USER_GIVEN flag correctly -- if it's
> > not set, the object wouldn't get filtered at all.
> >=20
> > Mark unseen commit parents as NOT_USER_GIVEN when processing parents.
> > Like this, explicitly provided parents stay user-given and thus
> > unfiltered, while parents which get loaded as part of the graph walk
> > can be filtered.
> >=20
> > This commit shouldn't have any user-visible impact yet as there is no
> > logic to filter commits yet.
>=20
> I'm still scratching my head a bit to understand how NOT_USER_GIVEN can
> possibly be correct (as opposed to USER_GIVEN). If we visit the commit
> in a not-user-given context and add the flag, how do we know it wasn't
> _also_ visited in a user-given context?
>=20
> Just guessing, but perhaps the SEEN flag is saving us here? If we visit
> the user-given commit itself first, then we give it the SEEN flag. Then
> if we try to visit it again via parent traversal, we've already
> processed it and don't add the NOT_USER_GIVEN flag here.

Yes, I think that's mostly it.

> That seems the opposite of the order we'd usually traverse, but I think
> we set SEEN on each commit in prepare_revision_walk(), before we do any
> traversing.
>=20
> So I _think_ it all works even with your changes here, but I have to say
> this NOT_USER_GIVEN thing seems really fragile to me. Not new in your
> series, of course, but something we may want to look at.
>=20
> Just grepping around, "rev-list -g" will happily remove SEEN flags, so I
> suspect it interacts badly with --filter. Just trying "rev-list -g
> --objects --filter=3Dobject:type=3Dblob HEAD" shows that it produces quit=
e a
> lot of commits (which I think is a more fundamental problem: it is not
> walking the parent chain at all to assign these NOT_USER_GIVEN flags).

I totally agree that this feels fragile, and developing this series with
NOT_USER_GIVEN wasn't the most enjoyable experience either. I wouldn't
love to be doing the conversion back to USER_GIVEN as part of this
series, but I wouldn't oppose doing that job either. Right now I don't
feel like I'm sufficiently sure that it's working for all cases, and
indeed your example with "rev-list -g" already shows one case where it's
breaking.

So let me know whether I should add the conversion as preparatory step.

Patrick

--JPGwkoYrZLSicn9K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBwKjkACgkQVbJhu7ck
PpSWtw//Rr1M0n0ZAOfLkGYTlM1ICq6vAV70jY2uW+dsqNkj9autKsjliHx5z4CI
ooDnIPbvb15x7i7XiMO8GyxG2tMZkLc0K1On4Us7jAWhZ4iG5NUnzGsRm459dgUp
N5wy09/Ot2L/D0VFEre4rTbzNlkruSTcVsnL3lUGztSvsf59MbvHo2rT5+7J5CUw
Sf+SHR5bjk/JUlyot7nsIPsthgAFhApgepipi7j1Vcx0mZ0Wyo5N+bmwXcYR8CJb
lCvCiNpaS3ndGpgUa+Q35meQYAlp3x/gAhnSXzyBhASK8u+a/OCTu5nJphU5wxhX
nZDWcV5oD+1zFO5Khg/ZNTcW+ShqcEchh5iYf8ubXpQL23Yn6CYWO8hXwvdXb0ip
vzbnyppX3e7+/6GcBSKkujUKu6QS5t1JruyLSAvtGXFeodb3rxx5nOAVC7NWTILQ
Yo4RObz5y0WBwkE8YEO73jmvNNa/PSB1JILOVx8Vow1ukxrXXPWYUcIeevAJCTDx
nKhTr6sDOB8wVq859OJ2OB19lkuXrawf95e4AmeaqvtlSL4WRdroxNLpOBdB3nBK
tCWcf4zuf12VUdcY4hIylMWBXwVsIJDA8O8AoRfL3obtD5ddEZ3on3SuWWcRq9fW
d1egrF9xu84PrcUtimUvYa1d3XomB1N2GZNoZcEVIzgLeI+Xks8=
=+/ei
-----END PGP SIGNATURE-----

--JPGwkoYrZLSicn9K--
