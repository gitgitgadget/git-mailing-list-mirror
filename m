Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF944C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 09:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiCAJrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiCAJrB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 04:47:01 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41176580C
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 01:46:20 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 774105C0227;
        Tue,  1 Mar 2022 04:46:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 01 Mar 2022 04:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=G0wbgdUOcgrsA3zuF0YK25IoT+slQxR2rW7zfl
        u1SCA=; b=DCoFibj5Mki+dcT3jRz2ag/usEd6u/0D24VecOzUrPJTW4ms5NFtXw
        ZJoWiIkXchx2ziGu5iZxXZANt4UuMpdVX8gZA4An+q6Ft9rr72QAKcFO1/rMaYKY
        GfssNPcv/tLH60darKM7v9n+/bMe15opeQ5hiXpeF7ovfzM+7ZIsblcoxk5a9Blr
        XVEwkF2nzhdFLnH3ZrNe/bcAdKNX5/CPeF5miLNzzYFAZOc4I1gZkNGa10lYZyqp
        zZWcVYsVIJpmzsxXWVEoZ83ZffyYLFcuqSXR/CVDGlbKwfgUEy8bbDevItqNzd/I
        aXAssE42XKEZnr47Aj5SjNU0RVldV/FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=G0wbgdUOcgrsA3zuF
        0YK25IoT+slQxR2rW7zflu1SCA=; b=PM3r9HjKAGZKbqPa1qriDB8fJT+fpbDFx
        gxfWlx2hjXCzK/g6XFbaNETAsR8G42V/P4j2+89D5d3dE1yB4Z63+7YnSB3yIMiN
        NKw5JC3Sg8s4yl249xKjRvnqX/YJBb+35hJcs+3uGu0tRfse6bwoie9duvxEG0dU
        qYvX43aLUEpwvuOuV2U3E4T6yC580jASuwp+mowE3bTdn+cat+r1ALNMKmzlm/nc
        J7zAj8vsePNNomGoSFlD676o/k/Vo1YIEjvBiEk405jIQmnghnMWzcjAQllcg6M5
        nGGaqT6r3xOJK4w2ytzo3JfcEiLUXzroHx3c6Nfy9W5vvuyyWKEWw==
X-ME-Sender: <xms:ausdYrvkuOY3qqnKmBD807E27vpLocIeb3xTtltKWGJuvRVEGGpdsg>
    <xme:ausdYseBk6gxn7RMnpf8jS8J9e8qMMJturu6UHvKPOE-oXE896umwulBXJbd56OrQ
    KFpMOB8Iis0LHbWpw>
X-ME-Received: <xmr:ausdYuxjO3r9BAQ4ri3IC-XbDwMLDEFWT7rNem175SKVpDtBHpb66cLLatmbsWKkiIj6jeAuI7DdlQFN9gkVXr3W0Ch-M7pDu5ZEZVjzKJv1nV1NeNA_Jyvm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtvddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeejjedtiefggeekgfejheevveejjeevuedvtdeikeffveelgeelhffggfejjeeffeen
    ucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ausdYqP_gnEDbEKNTATz-nIwPKP9Uc5iCs-ReiEsVzv6aHgJGKOI-Q>
    <xmx:ausdYr8O-0Y3ZvD-rlGVim_oNAahIP8tKSH7Tb4fLAZR9akRx0DEiw>
    <xmx:ausdYqV9H4P9wgXjlvhIcNfnhzaN2miO-A4-F5KnKL4E5jt74OWqmw>
    <xmx:ausdYnZPMPoKUgLGtS_ARKAaH-jXyikcNjKAtzf0GonyeHAJ7sRg7A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Mar 2022 04:46:17 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8d2b4bb9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Mar 2022 09:46:14 +0000 (UTC)
Date:   Tue, 1 Mar 2022 10:46:13 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
Message-ID: <Yh3rZX6cJpkHmRZc@ncase>
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <a3436b92a32f7f6dd02ad61eb2337a4d088d5e9c.1645735117.git.gitgitgadget@gmail.com>
 <YhzkdMxrIGlNutr6@ncase>
 <e29ec01f-3039-6992-8ade-800ad32fcf34@github.com>
 <Yhz/hsDDGNVjt64R@xps>
 <dbb59fe7-4918-50ef-33a6-79eb430445e8@github.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ptE215n1Z9iey96r"
Content-Disposition: inline
In-Reply-To: <dbb59fe7-4918-50ef-33a6-79eb430445e8@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ptE215n1Z9iey96r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 28, 2022 at 01:44:01PM -0500, Derrick Stolee wrote:
> On 2/28/2022 11:59 AM, Patrick Steinhardt wrote:
> > On Mon, Feb 28, 2022 at 11:23:38AM -0500, Derrick Stolee wrote:
> >> On 2/28/2022 10:18 AM, Patrick Steinhardt wrote:
> >>> I haven't yet found the time to dig deeper into why this is happening.
> >>> While the repository is publicly accessible at [1], unfortunately the
> >>> bug seems to be triggered by a commit that's only kept alive by an
> >>> internal reference.
> >>>
> >>> Patrick
> >>>
> >>> [1]: https://gitlab.com/gitlab-com/www-gitlab-com.git
> >>
> >> Thanks for including this information. Just to be clear: did you
> >> include patch 4 in your tests, or not? Patch 4 includes a fix
> >> related to overflow values, so it would be helpful to know if you
> >> found a _different_ bug or if it is the same one.
> >>
> >> Thanks,
> >> -Stolee
> >=20
> > I initially only applied the first three patches, but after having hit
> > the fatal error I also applied the rest of this series to have a look at
> > whether it is indeed fixed already by one of your later patches. The
> > error remains the same though.
>=20
> Thanks for this extra context. Is this a commit-graph that you wrote
> with the first three patches and then you get an error when reading it?
>=20
> Do you get the same error when deleting that file and rewriting it with
> all patches included?
>=20
> Thanks,
> -Stolee

Yes, I do. I've applied all four patches from v2 on top of 715d08a9e5
(The eighth batch, 2022-02-25) and still get the same results:

    $ find objects/info/commit-graphs/
    objects/info/commit-graphs/
    objects/info/commit-graphs/graph-607e641165f3e83a82d5b14af4e611bf2a688f=
35.graph
    objects/info/commit-graphs/commit-graph-chain
    objects/info/commit-graphs/graph-5f357c7573c0075d42d82b28e660bc3eac01bf=
e8.graph
    objects/info/commit-graphs/graph-e0c12ead1b61c7c30720ae372e8a9f98d95dfb=
2d.graph
    objects/info/commit-graphs/graph-c96723b133c2d81106a01ecd7a8773bb2ef6c2=
e1.graph

     $ git commit-graph verify
    fatal: commit-graph requires overflow generation data but has none

     $ git commit-graph write
    Finding commits for commit graph among packed objects: 100% (10235119/1=
0235119), done.
    Expanding reachable commits in commit graph: 2197197, done.
    Finding extra edges in commit graph: 100% (2197197/2197197), done.
    fatal: commit-graph requires overflow generation data but has none

     $ rm -rf objects/info/commit-graphs/

     $ git commit-graph write
    Finding commits for commit graph among packed objects: 100% (10235119/1=
0235119), done.
    Expanding reachable commits in commit graph: 2197197, done.
    Finding extra edges in commit graph: 100% (2197197/2197197), done.
    fatal: commit-graph requires overflow generation data but has none)

So even generating them completely anew doesn't seem to generate the
overflow generation data.

Patrick

--ptE215n1Z9iey96r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmId62QACgkQVbJhu7ck
PpRDKRAAp7Hi8+bqxmCxDI8dWHU18QaVK9LcEen/6+5IMqT0+ClqqbVzOPNBDynR
2uY4liDA1Zomgfc6PrUpJeghPKESSmOjhwXwB1O6cTvkTmln1PLxuiFpDOx4q2BX
2BesGqmnEyH4W8SB7Soaq5Gai8kudsYNIVjPSIjZmvlM5+4KU+ABrV6IIJMu1qp/
zULCZbpcpcirev4Eg3x2Q9ni88o2DtB2nA3GJhloLabA2D8DdJQXTpp1MXrTUaJh
a/ZvLnBoY0FI64heY0SqxAJHRwiu/2J57v8eSg34cFh0h6gmLxqmlOKxs0OLsmhn
XxRWByT3YRQIGImv+8olWVKVGqeOrTaO/6D57MFISTjpFPJR5oy6BIoEWFEbL8YK
cm3sXcdDWJ/umz20ToSJELxJ9oW3R7sz9AdEluCcN97Y3iQueBMALagy4ax3DWso
nbBd8bY0tF9LdThHCqAYVvTWePxe5ik1DsidzLvY0hBzHr9vQ4qnSDZcioq4s8mQ
8sAkmnERDKDDLgwWzHao/SN0RyBQbHR+5qQRvksKZhHdMDkeBVJq+ED+R2GAIwie
EiMiTrjZNdhkkT6Wv7mrgbi2FIC00ZuwVcSJ5vl7LRbro6caoC2wqlEIGJdIvU3o
jtUqNtMTKCzxeNOGr6EaeJ3rTdYmH6BMeeEDsvB/MCXXWjnKoWw=
=q29R
-----END PGP SIGNATURE-----

--ptE215n1Z9iey96r--
