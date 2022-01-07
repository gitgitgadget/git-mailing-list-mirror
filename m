Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5C8C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 11:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347291AbiAGLzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 06:55:38 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48737 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347271AbiAGLzh (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Jan 2022 06:55:37 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C5C8D5C01A5;
        Fri,  7 Jan 2022 06:55:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 07 Jan 2022 06:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=2qT5Zp+rGRwrHue0EbiyVJH7Chh
        0Xd8NjbZ2WaTLpU8=; b=Tu8ZRMfNLw6JCdIh0+om4ix/s3GNLk/H2lpA8blFv3r
        cN5JsbbKue9+QNIPhqHvjKC6UOh8iZLm3Dl3moDJgpMcfqM1TjGuKjOWheLDJuRS
        lefSb5BnRXBukE+ZealhpQ2FLlOq6BfS8NXb0qrTP3UXn2HTavZvyzkrPhOFO39T
        9KGPGMXpo/FsLwf2AUsGOZdsIK3oR4FekluiMoT/F1+wf64m/gC5Dotu2qFVkWT9
        IGu7UvFUtYlHWtbiT6oZx/qmfqkTnO51FgPlS1SJuFzKxPwq0VBmWK9HgsUyi2wM
        y1k2jE4FSqDcieq105Gnwa95BOGeaV9vaY0BQlGqdYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=2qT5Zp
        +rGRwrHue0EbiyVJH7Chh0Xd8NjbZ2WaTLpU8=; b=IrO8yjaHF5YGSNfnkNe98+
        G5sIWHXiwhsMHsdSDw0v54BnddQUdreaqrwCM9+ashIFaFAZXHzqN7MbizDXA9YD
        Iym9sdoWrBKgZMFr71ynenEeNlewLzId65qErtS7IA6tPGMWmIvtvXnrAHlV4iZO
        fnWWUQPUyy7ENZufT0gUFlh+T3X7p0wbvqy+3DHw9RDrP96k2uwU6buDCbYmep7G
        Glp1601CMHZ3iJkUigtTEmImd/uzAp9EKaT9I/JwjbeYCVAppuon8SbdTKFIQNTK
        BfpHl9D/8TzbLJlBY9TV8y9ZpuyBnfDfBqeO1CBIVBcXB3WXlnyLbflQzYIKqR5A
        ==
X-ME-Sender: <xms:OCrYYZxkJiWweBceru6fdy6x0SzzUBghQlw_nulWDoPB4wGaQts32A>
    <xme:OCrYYZQag58aaDyMk4FZ0KimzCqubJYY8zMsOxLcFM5JSz84o2IBof9Dw0xRvZ8hp
    G4QyusEK40TXEVSLQ>
X-ME-Received: <xmr:OCrYYTWhg4TFXTEW8N6mT9eHg7v8Vnwv8EpnJHDJZG_PxeAC_AWo98OO94_9b3XPCUgumiQk4Ltlof0V-Tp46bCoX40Y9__vZMnXHgbKWfzuSpWyBMVUmBey>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegvddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:OCrYYbitoIablSQWnRBGfCaYL2r6dSanicPCyUVjHKxwjslo8peyPg>
    <xmx:OCrYYbALYaDtC6XqUgK6wMWyqcAXWBZCuIh537BxFgnyU115Er_NIw>
    <xmx:OCrYYUK2-GCfICsmO92gUM8583WigTT5SWBD25dXex-bWgr6G6hOVg>
    <xmx:OCrYYePe_6942Hq-8UM2TfrOnonaRX9JbgDwBAlOCHXcfK4nnQvYDg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jan 2022 06:55:35 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b6292f03 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 7 Jan 2022 11:55:32 +0000 (UTC)
Date:   Fri, 7 Jan 2022 12:55:09 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: [PATCH v2 0/6] refs: excessive hook execution with packed refs
Message-ID: <cover.1641556319.git.ps@pks.im>
References: <cover.1638874287.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Vkn6U+OHGpJPhkFc"
Content-Disposition: inline
In-Reply-To: <cover.1638874287.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Vkn6U+OHGpJPhkFc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is a resend of version 1 of this patch series to hopefully entice
some reviews. The only change is that v2 is rebased onto the current
main branch at commit e83ba647f7 (The seventh batch, 2022-01-05). The
following was from the orignial cover letter:

As reported by Waleed in [1], the reference-transaction hook is being
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


--Vkn6U+OHGpJPhkFc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHYKhwACgkQVbJhu7ck
PpSPShAAhDOj6zu8MeFn2+ma0a4uOJxUnHLIJpZzUwtZHGqrGDaJtd8JXOSPzsl9
vJ0GFLkssGe1eyh+TF6Hy7h2ydZqDso7YzZYnXkXDXwyU9xhvyDZGjOMrXn3iSdR
6R8mwHQFuQ3zq0gKYPYqLBD1yMHEatuEb8eDyxyvy9/9xXcMtn3Ub+N8KWtLsyVh
McCwItXvwFKuURwUr/9Ni81wP3ihCYaTfA6uWYOJBxPD2kY1LQsy585Z2rSh+nY+
JkbTm6N+fp7cMXAfidSJIuv+hlmQEBcSOHDdUYijPtoUr79NlrAOTzKFWdyyfQoO
l1QSNJXOKoiXq5SYpmgYJVcgj/Lz7OvT+RBxTHPsZP9KC2q3PfDx4/lvnEqxRL57
pdeL1f2kZvmuMcE++rLi9tBJ+BWmBF+TgGEGUJUxcWcRjyL2gZLaf/b4v8P07cY4
vGcDOd3DFm5QI1dw/SH3PBvxgQs7IVYjW+w/J2UbL8YtCBQKYdNpXTDKo44+ekoq
cBfC42n3QQwpx8LXN2N/h6O9NdsAvLZXBvLYe0GS+rRXQSMPEX22W//eiZEz62em
mp4iaXIs3IqiRFDPTwHGKYo2Q3M2nuFHVBQQovY9+2SdRMocE7397FyFD14DSpnb
rZFuQHyzdq3m3DROvr8vhiZ+HRHVW9zSN1igIOVKvBJe/lSNmgw=
=q9mp
-----END PGP SIGNATURE-----

--Vkn6U+OHGpJPhkFc--
