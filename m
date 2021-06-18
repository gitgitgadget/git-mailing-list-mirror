Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4857C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9054460FDC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbhFRNcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 09:32:51 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37655 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232258AbhFRNcu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 Jun 2021 09:32:50 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 664645C003B;
        Fri, 18 Jun 2021 09:30:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 18 Jun 2021 09:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=KmNTgFw1Z3lryR4P01hQ1bZQd2A
        KlIKXUa38pYw0vqY=; b=X4jFu9kYeBlJ/3ktkPyANxvcmYXW+UcZgUWFVdutcUz
        WFS4RfPTAsA7oBMqgXsg2EC5nQegMPrYs5azHEFL3JLwKTOmGEap8c+8X0JX4A+q
        kaOv/37/V5uKhAX7XsIV20xv9exk1BxQV2n6TZVwE6AWXw0B+V7WL+DCy+NxqINC
        LV8ErtbAs7P3i3/S0srx4EjcZl6GsBOkR/irgrngI98HSBRqjWMyWlfsweS04og5
        XcEaMCfdR8EZX8cHfkpdjVu5M3tT6Od0gv9F4RcUI8tmx+NTYdCCxThTJY2KRYgE
        nCwkV+NE4b8UhQWCiFUXgzDdam91vs6Av9LhdWawF0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=KmNTgF
        w1Z3lryR4P01hQ1bZQd2AKlIKXUa38pYw0vqY=; b=qbqNJqjcEKdsUWa98q3hr5
        3Ec2ra25GR8UJXStRSdpqQvqcjdT+TWvd41ktev20lyQ8eq8kCbFfyL/y72R0hpn
        xFFHlMyzNqx2n9811fzLw8RU5KSrcY1Ygp+kbhUVhvLV+CsXC82r1tV3btake6c6
        i/kDV1rPlfZXX8RtDcAMqzBYmOKtTJVN+skofvPLhmKTdc4snSn/Yyt6Yh6CMNhB
        yF8n2hUNidUJ0LGWIq5CyWcMT0ulmVZEx/sq1w87Ue401RclK+mlr/jfWV6fKCqr
        yimpHNWeS1eFt5NF6VQyq3Z+qUXkmQlIo6VioYTgfUoMl1eQh+LuzYIH8bDTt5wg
        ==
X-ME-Sender: <xms:_p_MYOKhET2fRbiewui0cls9BgalzY1H9E1d9CCgWM072hfdjyNoxA>
    <xme:_p_MYGIVQVgGrOIk8km3y7V0IPQeJSj-__XrXd1j9L1fXyOJec28XI1CXjNk2vK41
    pZIluw3HAdeX_VeUg>
X-ME-Received: <xmr:_p_MYOt-pLaJhXg12mQIYyBDvcB1ZoXgi0CE4aTnTq9QtMwvauarZFVw0gKmsqm657SjcoHGJuy9Jfnj1NW2qJt5AkiN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeffedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:_p_MYDaYmJ1y99yZTpprb-HSOIDmEXQM6yt4RL3cF01Gns1je5ICtg>
    <xmx:_p_MYFYXxZT66h5RDknutbgfmBTifMALbgTALZwJkoe0my8q_oivow>
    <xmx:_p_MYPDPEAO6ZkJcC2t63UpO7eUOjKYr2hJ86Sq8qELTlfRc6huxAg>
    <xmx:_5_MYEw0WryXqzfDoUqk-2JIVwiC5UdCkAtyW-8iiOdRUhNEDY8UCg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jun 2021 09:30:38 -0400 (EDT)
Received: from localhost (xps [10.192.0.12])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 61d5ac9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 18 Jun 2021 13:30:33 +0000 (UTC)
Date:   Fri, 18 Jun 2021 15:35:05 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] bitmaps: don't recurse into trees already in the bitmap
Message-ID: <YMyhCTaHmm6oNFpB@xps>
References: <YMcExxF7DI6k+sZ+@coredump.intra.peff.net>
 <YMdGGL6v8LrbcAJP@coredump.intra.peff.net>
 <471cb9be-bb72-6a37-ede8-f9421d9d3ebe@gmail.com>
 <YMnvCI/jksyn2flD@tanuki>
 <YMyYz6Tavj5l6S8n@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6KX3AWW/DLfPqlgM"
Content-Disposition: inline
In-Reply-To: <YMyYz6Tavj5l6S8n@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6KX3AWW/DLfPqlgM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 18, 2021 at 08:59:59AM -0400, Jeff King wrote:
> On Wed, Jun 16, 2021 at 02:31:04PM +0200, Patrick Steinhardt wrote:
>=20
> > > These many-refs scenarios make sense as something that is difficult to
> > > verify using a single fork of an open-source project, but is common in
> > > many closed-source projects that do not use forking to reduce the ref
> > > count per repo.
> >=20
> > Agreed. What I typically do to emulate this is to use some version of
> > following command to create refs for "$n" commits.
> >=20
> >     git log --all --format=3D"tformat:create refs/commit/%h %H" |
> >         shuf | head -n "$n" | git update-ref --stdin
> >=20
> > It's obviously not ideal given that resulting refs are distributed at
> > random. But combined with a sufficiently large repo, it's still helped
> > me at times to reproduce adverse performance at times.
>=20
> Yeah, I've done something similar. But I'd caution people into reading
> too much into performance tests from something like that. What I've
> found over the years is that traversal and bitmap performance can be
> somewhat sensitive to tree shape and bitmap placement (which in turn is
> often influenced by ref placement, if you are using delta islands or the
> recently added pack.preferBitmapTips).
>=20
> More than once I've spent many head-scratching hours trying to determine
> why some real-world repo performs better or worse than expected. :)

I couldn't agree more. I've also had my fair share of weird performance
characteristics in completely unexpected ways. Unfortunately, it has
made me become quite cautious about bitmaps given that they've already
caused their fair share of perfomance regressions.

But your work here actually encourages me to give it another try soonish
and see what kind of repo shapes make them explode this time.

Patrick

--6KX3AWW/DLfPqlgM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmDMoQgACgkQVbJhu7ck
PpRE2Q/3U113o2rfohWgFsJmluPECAaZQNPpPPfBZlLwEJpYCWbltq5veY1cbNTv
NmMUp5EOr7CJM+yblzz2tqED+J3I8zRfSYriQU/P/VJZrBqzl+yG2Q4GLpMYfjBf
eQKZ3pLC0zzEaVedD2qyyWtepyvUa7OlwraisUyliC2UACO+Xz9Q2xQtfq3jLkCh
DiyATmhoDSe9VKrgtNTvXPWrXlMK/ZeoO606emwwfGY+YUx4Qf4K68jdGtqYukHv
65b7jJc3ncl09/fy75rkZ7g3oTxUDcSdRaOwjD+eqUhUpN54GgLxJMQzlR6hNnr9
ZhTY0CTqb64SYQ2V8pnNG5VLE7eqG0Ozp3qvLfbYnkAkr3Uto7KgjXVyBekGqjBD
bAZ0uKgMpGzf8LnJ8YRvJhND6MpqTE6keWYMt9NzW2dyeyb/BX+kxYAFFBtkq+oh
nhhQt0HSM22uyC8HkyEhdNDQdFEOMd86mEFSaRKFIyR057Fe4sJnHvpKQsdrowPa
Xm4dsIiA1bJFCIEDrzo/t/hL/RjQqCJrolQyKLgo5r//3Ee0elZDoDfjpUEEze/p
j5ekR/FUyeyM4ZnDZuN0TZWe4hyOWjPF7v3jhHChKWJnhF8rVJpeML2ewQIjAIYo
UpHd3ykpQA5g5q/j8aAQMlMluJMwxlok9VQ4GXn7mZINvAHy4Q==
=QCez
-----END PGP SIGNATURE-----

--6KX3AWW/DLfPqlgM--
