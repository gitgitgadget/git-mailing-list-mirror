Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9555FC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 14:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A8316108D
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 14:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241162AbhHYOLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 10:11:18 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:50293 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240786AbhHYOLR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Aug 2021 10:11:17 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 946C33200B2D
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 10:10:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 25 Aug 2021 10:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm1; bh=OqITXVRECclg+elQi2zaTbs4IiQJC0EQbBfZKwTB
        Wgk=; b=TXdIRl4wH32EncwS6fDzA62JxrmV7IJZNNr6nou+stOyFvQ41do9PGPd
        HRYQafQCnGJw64e8TFXEcDQ+RTbRtvSSkfxNqW+eOYEe1ytWbGcmQhnQS+RZknk6
        spXz3WBixcdbf883UyQ1LYqbY25Q4hs0vPRYcNSodF4+01G3G8V0HBv4jZccepIo
        o+5uUWNqmy5hll2FdBEpGQoAbRCLqRM86pOjtHO14WnB9vqMEyQcgzfWFL4IEA7M
        Ao0w7FDGwsVeCJDbQuSeg4TsnPRJ+YwE6j5CrWp9ugm9hSXRawjlTCJAGUYGFJC4
        MEc8X2RBy+4Y47wEEIWU2tk8NhgIGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=OqITXV
        RECclg+elQi2zaTbs4IiQJC0EQbBfZKwTBWgk=; b=gVLfug8ik+8XREjGuIGbXn
        Ohph0F6GdTCZYS4okXHk86nQfNlmesHGIbFUSBFSOFVoTj0EL4xRCYOrhx19QWAV
        3zs2Xh0dQoBlA9EKXwAqFruImBiCqhZfnW0yindg8/7Id4ixrcwsot011fZJXnVj
        j2/j8kPMe4dm6r9t6upBccm0bKz+HO07bL/sSoJ3qwov5KikZo3AqIrSL/jslJ+Z
        4aa5UzpjJ3HRK2r+g1JVDaA9sGvBfm6goaOmg91EwbH/8RqK9Msv4c9m5PKgvtPx
        vidRlbUczdkO0X6rqR+Wc0Gtwp8IH60pt70JndDNqOhAw8R2H1tCcPK8M3hQ8TCw
        ==
X-ME-Sender: <xms:Vk8mYcd39E5hOOGhNRr0c5cKGYA_COTPzP37akJs2HeBHDTeKWaHaw>
    <xme:Vk8mYePlHYdkJ7mJwCvmWi-2yszU-lexHtNx7PbU-iNkdjxQGpyZy1WHIoUwXRXPV
    n-cwq7DIdQAhdeJoA>
X-ME-Received: <xmr:Vk8mYdgr6SLJyw91F3XwlqFZ1wT_IoCpTWiw2yQIUmxFL-sR4wg9paM-wc9ShYNM0mqLrFc6CGAYJtqogaO74aU4J4nPbDedAP8DRK2tizwBZ5VaEz5XHu0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtledgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefgjeeuveejteduhefgffefffdvjeefje
    eivdekfffgkeeugfehveetueefleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Vk8mYR8nr1qEBgfWPD8-PGfsvZsAudwM7t-0qqOc_4dFsc8Iju-3GA>
    <xmx:Vk8mYYtGkShKS-3DA9dq20oKQFtUaU2eeoxl7DomKh1QNbYagU_X7g>
    <xmx:Vk8mYYGHRt6icTNksVLqax1wMLbHjSImkIqbrdkDpoL3_3Raf_AfcQ>
    <xmx:V08mYR7SNaNAXcm3bdiBXNNgUjO2fIUwQ-SSiqe2UlhcTfyS1dKDDA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 25 Aug 2021 10:10:30 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 5a367396 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 25 Aug 2021 14:10:26 +0000 (UTC)
Date:   Wed, 25 Aug 2021 16:10:25 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: Re: [PATCH] ls-refs: reuse buffer when sending refs
Message-ID: <YSZPUYk5J10DID+7@ncase>
References: <ccd03e685af0f5cf25c68272a758fc88d115e37a.1629899211.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xrO/rHFoatNvAIu7"
Content-Disposition: inline
In-Reply-To: <ccd03e685af0f5cf25c68272a758fc88d115e37a.1629899211.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xrO/rHFoatNvAIu7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 25, 2021 at 03:49:51PM +0200, Patrick Steinhardt wrote:
> In the initial reference advertisement, the Git server will first
> announce all of its references to the client. The logic is handled in
> `send_ref()`, which will allocate a new buffer for each refline it is
> about to send. This is quite wasteful: instead of allocating a new
> buffer each time, we can just reuse a buffer.
>=20
> Improve this by passing in a buffer via the `ls_refs_data` struct which
> is then reused on each reference. In a repository with about 2.3M refs,
> this speeds up local mirror fetches by about 2%:
>=20
>     Benchmark #1: HEAD~: git-fetch
>       Time (mean =C2=B1 =CF=83):     25.415 s =C2=B1  0.131 s    [User: 2=
2.722 s, System: 4.740 s]
>       Range (min =E2=80=A6 max):   25.240 s =E2=80=A6 25.543 s    5 runs
>=20
>     Benchmark #2: HEAD: git-fetch
>       Time (mean =C2=B1 =CF=83):     24.922 s =C2=B1  0.110 s    [User: 2=
2.404 s, System: 4.476 s]
>       Range (min =E2=80=A6 max):   24.825 s =E2=80=A6 25.081 s    5 runs
>=20
>     Summary
>       'HEAD: git-fetch' ran
>         1.02 =C2=B1 0.01 times faster than 'HEAD~: git-fetch'
>=20
> Signed-off-by: Patrick Steinhardt <ps@kps.im>

I accidentally mis-typed my mail here. Really shows I should be using
`--signoff` instead of manually signing things. Anyway, I'll fix this in
case I'll need to re-roll.

Patrick

--xrO/rHFoatNvAIu7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEmT1AACgkQVbJhu7ck
PpSWkBAAp6s4sGhlnDECqd2KTOEzEUU5n43O5y4g2ZTBgjZGHpEaWKrrGH+QQIgh
nK4Oa9PQJ1umjKCXgocFEL6I8D/bKvEsibziCzQVzOEtD9bvUzYzKvRtIPgQSKyY
ZbINjxvOKwpjM++1p86fDgPIEhVILbq5zTh4yL7kPSxLINdenfIM5dbP9fQVDAb+
7bU3wIzL5+GfSYAHPQEQkdAg8TYfv5y88TAOYdYuIr9hDZkjMW815XvNqcnJ8eHw
wEKBGu+to2ip7pvF3UWqhcBADOF+Eqd3pkHubd35Aj4mFaNp389zYTtPSV2KufWH
wOsKy5aOfOm11Lv2+OTMxyT4UrByNY+emxz7/j2EiK/LzWNs4GvtZSlgpZMtn8Ro
u+vCGc3X1YZ1G/RfFZq0H/388jyH2draUOmEfsHyM3pOuVwqTCzLta1llANjktE5
SRSq+yHNEbE0tphTbC5xMMfVKayeVhPvzhTvU/R2fa1oe7pQl0kjzdttqOBb6lZF
ziKZ/aW1v4zo3hYqqIcKx/eg5pR0dF6FMsSD42uqh4UBKZMGW+1+zy6ZVmlltX6B
ZTg20b0HAFj0gxnKgY2olgSrDJfyA3hI4sUa+6AtXiGVUKLHoPLrGlG+0mvYbnXG
0YPn3EX4V4jjczKHLRoLt0pphAT0zfREGhwHE6FK3Ntgh0MNAhM=
=QysP
-----END PGP SIGNATURE-----

--xrO/rHFoatNvAIu7--
