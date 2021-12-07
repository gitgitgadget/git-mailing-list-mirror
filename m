Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95786C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 10:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbhLGLAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:00:08 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43525 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229903AbhLGLAH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Dec 2021 06:00:07 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C9D1D5C019E;
        Tue,  7 Dec 2021 05:56:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 07 Dec 2021 05:56:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm2;
         bh=oUvv5sp9xbPSD2LomKpBp3yti5blWCb4UOFY+yDQ8Vs=; b=NrUseoj/22P0
        2R+hAtlYXno9+ZtWWtHaAXkxwxgwRhyRfFLkY+xxk9WgjWPEevJUa7KnLV+gVJM0
        nxS0+RYJcAlhEVeg+X3gLxsWVwZRgptBLakGmC/Se6FaJF17/aHGwJtdrvgeys4W
        bwPfiFMTha7M2jg8hoVb66DF8JM0My/f3s16UbtQTiYJTp5sdaPcleesNBrSuszC
        tGNHh38EgmbmLbN7gvc+Kz1NRhkBR/XqwQEySWjyn3Q+rfz3Nbcb3G0n/A58eS++
        Dl6aNfvJNHVPEtHJyxMN6FnJ3OT7cKiyBNeXDoT17O+KKRSlmJbw5y62Zgb+Afcd
        MGwj3hrejw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=oUvv5sp9xbPSD2LomKpBp3yti5blW
        Cb4UOFY+yDQ8Vs=; b=i+SjY53/ourS/DFUvP1tWzME1fp/MpniEXO1UHPrlMXrK
        d5d01YXJxqOKqH6G2FJYdoetxOVkCVdNtidZ835wyMJ12DV6mKSIkiS6vuEpKqkQ
        CHUTym4+rqgSSBSZX3pq783VZya/966B/A8VUVHUaAvGZW50v4jHxjRTTSXz+bb7
        PKIg1v0EOkNFP6sjY6S272wKZqwPLXAzSOhhOjOiG0TQuRZ/dGQu7Wj+1ypjCMXd
        tC+oZhHyeuRKwzRyn6mwH/UcUk7mn3PYZNDIp1iCRonPS4mumGCOyvW0CTYXn1yB
        qm8G78vmBNcDT9/3wQuITgZqV3Yh807Xeb0IHHddw==
X-ME-Sender: <xms:5D2vYTWjX-0pFgiq9-UYwQzp_KAHYWS-V8Q2g-7L6WDokLdfujO7qw>
    <xme:5D2vYbk3LLEUP9PEpwpNLYvSfWoqTZjhH3GBkyW97Y6vy1PEXG_nYc88xNLCzT1_I
    itMoACQW8kxlxdABQ>
X-ME-Received: <xmr:5D2vYfZH0O1FIZCX0fejo0N4Erkag30d3kreiGDx3XfJ9yB8Lgx2Sw1XF2DmNH3lz_K5ni4vjbclzvVRl_80ojZDOoBGDnsZfwQHuCKHI6LgtBmhkAeUUhkC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepje
    eifedvueelfffgjeduffdvgefhiefgjefgvddvfeduvefffeevfffhgfekieffnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:5D2vYeUTAVLD15RDNssDRht1QPDp2WDP7tWZdHhDU8cqv-Ew5rD2zQ>
    <xmx:5D2vYdn6tAujlkhwC2febGr5IobeeExNdvTUJyzNFGQUNmHNQ9pjHw>
    <xmx:5D2vYbdgYIT-Nk4j4hcZFQjOfklcGlMTLD6-UZ-Yimzq2xnBhLOBsw>
    <xmx:5D2vYSwqSa_zSsX9vVaS7sJXDtM8G4a5Meg1n7QWS1CE1ujNirdehA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Dec 2021 05:56:35 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 85ea01b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 7 Dec 2021 12:26:10 +0000 (UTC)
Date:   Tue, 7 Dec 2021 11:55:52 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: [PATCH 0/6] refs: excessive hook execution with packed refs
Message-ID: <cover.1638874287.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EJchvbCgFh5u+ojq"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EJchvbCgFh5u+ojq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

as reported by Waleed in [1], the reference-transaction hook is being
executed when packing refs. Given that the hook ideally ought to track
logical updates to refs instead of leaking low-level implementation
details of how the files backend works, this is understandably leading
to some confusion.

This patch series aims to fix that by improving how the tandom of loose
and packed refs backends interact such that we skip executing the hook
when the loose backend:

    - repacks references.
    - needs to delete packed refs when deleting a loose ref would
      uncover that packed ref.

Patrick

[1]: <CAKjfCeBcuYC3OXRVtxxDGWRGOxC38Fb7CNuSh_dMmxpGVip_9Q@mail.gmail.com>

Patrick Steinhardt (6):
  refs: open-code deletion of packed refs
  refs: allow passing flags when beginning transactions
  refs: allow skipping the reference-transaction hook
  refs: demonstrate excessive execution of the reference-transaction
    hook
  refs: do not execute reference-transaction hook on packing refs
  refs: skip hooks when deleting uncovered packed refs

 refs.c                           | 11 +++++--
 refs.h                           |  8 ++++-
 refs/files-backend.c             | 25 +++++++++++-----
 refs/packed-backend.c            | 30 ++++++++++++++-----
 refs/packed-backend.h            |  6 ++++
 refs/refs-internal.h             |  1 +
 sequencer.c                      |  2 +-
 t/t1416-ref-transaction-hooks.sh | 50 ++++++++++++++++++++++++++++++++
 8 files changed, 113 insertions(+), 20 deletions(-)

--=20
2.34.1


--EJchvbCgFh5u+ojq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGvPbcACgkQVbJhu7ck
PpSV8w/3YOHhfrIkmXPSUxx+aBoGzX7WD+7E/MMc8M+H4PB8Fx3K+wYOR2r2QOWM
QPZX4MBwgwMMfM3tChlHksTLWsa/DcNftOt5eRHK8bQ7VOeoPkgciRYJKJ6tZZGI
ZncG5j4E/moFNnrBfUhgbWXi9Rs9xcTtL4161eDjQP8FrB6vnr6QhSc1gjGIiq+C
kmA9k/7ww8ZSXjgUGbsCFdk7dEeUoixRIGQ5nHjL7pX6S6/r3TGZcy1tOuEtyQO8
B4sROQqTVQypcqCPRjiHBF1TI9I2inCuFibkeiyaTFaPi7M0jQuvAuC103bgLzBI
60V7Hi+EWsqK0voqwvVQym3vDxBoAmJH+cVwmVa8TEBAM6pw0EVcmMglbs4TYIQ9
Xf1KDNHETJl0fpYcBs6mb2R8m/fUr8Trax4iBWUF3zJNClRKAQrnTONsHjhU42U4
uNULZOMcw41uSBlkXpkbiw7aBuYBf8C852pgR0CPYLaB5SpoQqImjQhtfxm5wQTU
b6CNTuci5qdh8tu553z/HkD6EvIziFTyue+uN9aV5kGkNgPXtaHpFlVExYtG7JnH
x3XPGZHXHtxoXkzFCvXoCOgx4Bi9W5A1iN404YUadGBHfj/hsiWRRcxGuAAauk8z
4JMLVM4KUCjUAty4Vz8OR/ptGvtUKmPCwN9TAeUSlQzwfuILMA==
=bCb/
-----END PGP SIGNATURE-----

--EJchvbCgFh5u+ojq--
