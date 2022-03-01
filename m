Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D45EC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 10:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiCAKgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 05:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiCAKgE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 05:36:04 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803C258827
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 02:35:23 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B8A355C023A;
        Tue,  1 Mar 2022 05:35:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 01 Mar 2022 05:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=SMe7Rb1m8pgyqoX6IYMhbdzmcnnfcu219UIVCY
        ONQ68=; b=yqy8xRYSsAmNPkEK7h2FiFpYkdaQENi2MfpPJpO86wxEx3WDNBuTsX
        h+dVgk5vBKRijmFjZbjkCXmj8BKAGi6OdfTp31y1WtOzUs3aX8mvFdM4kgVwOfvZ
        CuU/CnGruQsBhN6M5oB6ZreilL+eTN+S3JUL/mEnEx3na/GoiircR5tSoVud9OGp
        8/mm7pbjDbwNPOFRvfbvM5YH+aGt0ywx085RoADb008Ac6ecUvifTM92iMIwAb5i
        H13veTAEaZoPKgMEHHmRAlgMwXUhNVCVKfvyVTNIOrvXFxANpu8sxKSLSjgRof7e
        /5zY4b2zQGodgR5fPEuwrBF02avrl30g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=SMe7Rb1m8pgyqoX6I
        YMhbdzmcnnfcu219UIVCYONQ68=; b=KGAqgKFjcXQRb9gNI41ccgI+cXIw7DqNm
        vf51thpvc0jnw12IZiidDQJj5NAEZxE06IUKbi42lJrJ1PoUEMl79V/SqJIrwI1L
        Aw40xu7T5iQKsArMWiM28J+AG9ajOd6B2d3sAJHLE2fDqsTvdHj4MPHil11BUg8Z
        B1I1SZltgJQPWC7f0/CDtKNUGdCIZBfezMjzVAf3fxkMiwbCVxZVvZByZd0sdNPf
        8a5y1IZN8Q6Ds29MAdkBmSV50PXbz30yfYsFN1u57STFt9jy1vzJkrb0bg0x/mY5
        5iqBS7jrcgSn+haVK20gXCxZDauIiUKx7GxlOUh+I2DRoKHVkWdag==
X-ME-Sender: <xms:6vYdYqDhaS6mHXY0_Cpzh04nxVg8a9HbXNuFHlotX8P72UeSi8bU5g>
    <xme:6vYdYkjtQOuhedKYI7VWYfRBi9pHYMqR2oZk870VPCYjthxdonqO02aFGVaAL1aog
    pIyxbjqMQjiVjLQfg>
X-ME-Received: <xmr:6vYdYtkPlKWEQyiV_S9489mqdYVq1yRjXS5Ce15LSvY7xVEiwIqOh_AdzwJftzcM88jvAbtP5LDewHi685VyZSse8zKZfJhWdyuQv-GVWCu-Z6Jcn20EMnq6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtvddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeejjedtiefggeekgfejheevveejjeevuedvtdeikeffveelgeelhffggfejjeeffeen
    ucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:6vYdYowhN5VRGzG-Usr1BiyVVTsuxegtBQNxBCLR71u1XbVhuSmVuQ>
    <xmx:6vYdYvTU8KGmsL4wZcx-9E9lofC557YAiaMg_pu-QEtF6A-tnwQhJA>
    <xmx:6vYdYjaAtLxm2Yi-X-l9GNqMGKykWef9rgjELtJkmWPabnPSWz5JCA>
    <xmx:6vYdYtPHscXXaPeYe8mCP_nWhQlQBYOCJ6CJ-E2h63yL6HBmBSGpig>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Mar 2022 05:35:21 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 00f419d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Mar 2022 10:35:19 +0000 (UTC)
Date:   Tue, 1 Mar 2022 11:35:18 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
Message-ID: <Yh325v3RBDMxjFnD@ncase>
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <a3436b92a32f7f6dd02ad61eb2337a4d088d5e9c.1645735117.git.gitgitgadget@gmail.com>
 <YhzkdMxrIGlNutr6@ncase>
 <e29ec01f-3039-6992-8ade-800ad32fcf34@github.com>
 <Yhz/hsDDGNVjt64R@xps>
 <dbb59fe7-4918-50ef-33a6-79eb430445e8@github.com>
 <Yh3rZX6cJpkHmRZc@ncase>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kerTCkaUnnrikZ7g"
Content-Disposition: inline
In-Reply-To: <Yh3rZX6cJpkHmRZc@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kerTCkaUnnrikZ7g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2022 at 10:46:14AM +0100, Patrick Steinhardt wrote:
> On Mon, Feb 28, 2022 at 01:44:01PM -0500, Derrick Stolee wrote:
> > On 2/28/2022 11:59 AM, Patrick Steinhardt wrote:
> > > On Mon, Feb 28, 2022 at 11:23:38AM -0500, Derrick Stolee wrote:
> > >> On 2/28/2022 10:18 AM, Patrick Steinhardt wrote:
> > >>> I haven't yet found the time to dig deeper into why this is happeni=
ng.
> > >>> While the repository is publicly accessible at [1], unfortunately t=
he
> > >>> bug seems to be triggered by a commit that's only kept alive by an
> > >>> internal reference.
> > >>>
> > >>> Patrick
> > >>>
> > >>> [1]: https://gitlab.com/gitlab-com/www-gitlab-com.git
> > >>
> > >> Thanks for including this information. Just to be clear: did you
> > >> include patch 4 in your tests, or not? Patch 4 includes a fix
> > >> related to overflow values, so it would be helpful to know if you
> > >> found a _different_ bug or if it is the same one.
> > >>
> > >> Thanks,
> > >> -Stolee
> > >=20
> > > I initially only applied the first three patches, but after having hit
> > > the fatal error I also applied the rest of this series to have a look=
 at
> > > whether it is indeed fixed already by one of your later patches. The
> > > error remains the same though.
> >=20
> > Thanks for this extra context. Is this a commit-graph that you wrote
> > with the first three patches and then you get an error when reading it?
> >=20
> > Do you get the same error when deleting that file and rewriting it with
> > all patches included?
> >=20
> > Thanks,
> > -Stolee
>=20
> Yes, I do. I've applied all four patches from v2 on top of 715d08a9e5
> (The eighth batch, 2022-02-25) and still get the same results:
>=20
>     $ find objects/info/commit-graphs/
>     objects/info/commit-graphs/
>     objects/info/commit-graphs/graph-607e641165f3e83a82d5b14af4e611bf2a68=
8f35.graph
>     objects/info/commit-graphs/commit-graph-chain
>     objects/info/commit-graphs/graph-5f357c7573c0075d42d82b28e660bc3eac01=
bfe8.graph
>     objects/info/commit-graphs/graph-e0c12ead1b61c7c30720ae372e8a9f98d95d=
fb2d.graph
>     objects/info/commit-graphs/graph-c96723b133c2d81106a01ecd7a8773bb2ef6=
c2e1.graph
>=20
>      $ git commit-graph verify
>     fatal: commit-graph requires overflow generation data but has none
>=20
>      $ git commit-graph write
>     Finding commits for commit graph among packed objects: 100% (10235119=
/10235119), done.
>     Expanding reachable commits in commit graph: 2197197, done.
>     Finding extra edges in commit graph: 100% (2197197/2197197), done.
>     fatal: commit-graph requires overflow generation data but has none
>=20
>      $ rm -rf objects/info/commit-graphs/
>=20
>      $ git commit-graph write
>     Finding commits for commit graph among packed objects: 100% (10235119=
/10235119), done.
>     Expanding reachable commits in commit graph: 2197197, done.
>     Finding extra edges in commit graph: 100% (2197197/2197197), done.
>     fatal: commit-graph requires overflow generation data but has none)
>=20
> So even generating them completely anew doesn't seem to generate the
> overflow generation data.
>=20
> Patrick

I stand corrected. I forgot that the repository at hand was connected to
another one via `objects/info/alternates`. If I prune commit-graphs from
that alternate, too, then it works alright with your patches.

This makes me wonder how such a bugfix should be handled though. As this
series is right now, users will be faced with repository corruption as
soon as they upgrade their Git version to one that contains this patch
series. This corruption needs manual action: they have to go into the
repository, delete the commit-graphs and then optionally create new
ones.

This is not a good user experience, and it's worse on the server-side
where we now have a timeframe where all commit-graphs are potentially
corrupt. This effectively leads to us being unable to serve those repos
at all until we have rewritten the commit-graphs because all commands
which make use of the commit-graph will now die:

    $ git log
    fatal: commit-graph requires overflow generation data but has none

So the question is whether this is a change that needs to be rolled out
over multiple releases. First we'd get in the bug fix such that we write
correct commit-graphs, and after this fix has been released we can also
release the fix that starts to actually parse the generation. This
ensures there's a grace period during which we can hopefully correct the
data on-disk such that users are not faced with failures.

The better alternative would probably be to just gracefully handle
commit-graphs which are corrupted in such a way. Can we maybe just
continue to not parse generations in case we find that the commit-graph
doesn't have overflow generation data?

This is more of a general issue though: commit-graphs are an auxiliary
cache that is not required for proper operation at all. If we fail to
parse it, then Git shouldn't die but instead fail gracefully just ignore
it. Furthermore, if we notice that graphs are corrupt when we try to
write new ones, we may just delete the corrupt versions automatically
and generate completely new ones.

Patrick

--kerTCkaUnnrikZ7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmId9uUACgkQVbJhu7ck
PpQd2g//S3b95q+OVWRQbAqi/PWbyYmW5TA27agomgTNs34iHsRaxKtDtLR7h7Iq
2zDhpC0CjX+Wqyfx9xO41+uGSDhCio7ejvSf9ZaCM8PQnhFGVQeMmeKS++yKc9nj
CZQQ3Zu/KQ65CIyi0MqFsbfBafdbOMiXq7axDui+/c8EhSwn8ts8YdaYQVV/+7ib
wSuIXFzYC0I2cFaO4Z5tZf80ukBaaFmtHTiyjouo2g6zPXtAKCin40Q0uqJhAlW7
aLiPOkoY6C5nMYuV8FHoUJK4dpmHGPPXZ8IjByPPJRYv4Dm+2j8vQ0YymaT8MmUV
uNSJS1yBZp8euK8yw5/kWyisGdQrdCprmjnKbP5qSN0+ChOa2EsVgAKozaEZdoN9
H9fIQD4j1e9ZRYcvJAh4LK7bs82kbjrNurNNLLi6KrV5FR7FIt5BVXQ9fxQGJ0eQ
8zvw7LeUviP+9qt+dkQ76dNNZ1dvahk0eDQPub7IfcILB0JKD4tXGYgmCsc3rLWr
At1B49MF6M0nK6GpPy2P2BW+kgwMDPXdTdZlX1nvXlg1cbT6b49mOWrWSq2Ioasy
aGku38odZO5WYgrLHS31B4bTRFejsvh/9m8/seh6PUizLs5rz+l2o6pAp6yKEwjt
29N5i6EwUVv3Dd5WcuCTaPia63gXxmoemVaBuOzslxo34n9Ys8g=
=HiYw
-----END PGP SIGNATURE-----

--kerTCkaUnnrikZ7g--
