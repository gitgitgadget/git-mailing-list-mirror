Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8A6C77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 11:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjECLV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 07:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjECLVX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 07:21:23 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91881B0
        for <git@vger.kernel.org>; Wed,  3 May 2023 04:21:21 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 717BB5C0045;
        Wed,  3 May 2023 07:21:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 03 May 2023 07:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683112879; x=1683199279; bh=fW
        8wgsvHIF2bGFjOwkzaXcYhzYMwbX/efkogGmSLKaA=; b=MrdcK8TsvlgF806MAe
        XO+txncBNgSijao0X3/qrI+rzWhrSf9E9sp8+4/xjlkKGt620bGz8xQ4gJ8x2FF3
        jFLkNX/DVq6H0jIs5a1hNy3XcQqz7JVBzNFcCGQxg+/xCvzY6JgnWXn54Wl/rcE7
        oWwriykwNFyUYwURacayE1of7GuaRGr9En0LAcSbCuviyZGSgexFDM0aaE6gAkJo
        6p8rbVqcmoUfUwlq0xIpFwwM19vfj4S3VHCFTQOH17CI6JNyd6oQBDJXxNIaa3ht
        IkNCm3ZSZ+lnlG/JiuQh+UxnQvIJA20y9fyaj4Kek5yk6u5uRBMRejLmr/VjbJrf
        Ef3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683112879; x=1683199279; bh=fW8wgsvHIF2bG
        FjOwkzaXcYhzYMwbX/efkogGmSLKaA=; b=UF9ec9ox1AG1/rSIL+vAd+/SwIdDa
        nyagE+L/eT8C11npn28b/CSbAUN5WEHrXsaxOrYw+Ze6X7OWQarArZf0Opath03a
        n02kbKmOquy6QDIcz+oAk8k1G8lNXdRX6B+NEJY1hiGuEhMov7PxarZ70cHBU6Ub
        wwmV5lYVZP31VpMJ4jb9aHzf5l1QYmggSxIsx/CZOsPGnXExa9m6ex0uRBLHpkte
        XNcDMyE+tLLqY7HJMmc6uwpnqCGIJOnIxd9so1lQPvXZUuyZYpMCLbEcSCO9mhNc
        L9PZ9/9Scljl3toT89VgnD2krXkXhckLwGlkzXr0eGbZenj/dxyDYP2Nw==
X-ME-Sender: <xms:rkNSZDBnXVARxaFnK4GPOBSjhSfCww55DWnbUpmsa84jEnt2TdNQ9A>
    <xme:rkNSZJgrsCrNmNqBsKOF74LQ929A5BFsj243jP9PYxV1fIqjksBHjFDG97CppTRfT
    H9-XLp2yiCroQflNw>
X-ME-Received: <xmr:rkNSZOl3rWuwAOOE9zPbBmRxXKUl5fhNJuZusYjKbxxfyPZpYPIO2qdVFe9m9nAlF8OyHTH3c0MHIIv5XveID6SE674Q9hS9iuDllZ5hzitd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtudenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvdekfeegheetheetjeejjeegteelgeelgfehhfejtdfhfffhfeefhfevvefgjeek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:rkNSZFzQRpCHy_2GKYluvv6MDq-rx4cfzMod_G1eHZNeciuhiwNHQg>
    <xmx:rkNSZIQjbSb1i5PPvWp42rvS4h7WQUdeRurpEuZtrqtJ3JXpHP6UhQ>
    <xmx:rkNSZIZT9yDX7u_gHyhka22OnHb9-ZB6Do381ZPvEqaaLlbe2lCa7Q>
    <xmx:r0NSZNISkNTAEhtlECfb0R1fEjeT9xjZrKObPjuNqDbSKvSWu9GV_g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 May 2023 07:21:17 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 497d070b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 3 May 2023 11:20:34 +0000 (UTC)
Date:   Wed, 3 May 2023 13:21:13 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 1/8] fetch: split out tests for output format
Message-ID: <ZFJDqXnonTKIejAt@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1682593865.git.ps@pks.im>
 <0d0d50d14c557f8313747e7d0e104c2c0819dab9.1682593865.git.ps@pks.im>
 <20230429173448.GD3271@szeder.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N5HWpA/MdNt1oC9R"
Content-Disposition: inline
In-Reply-To: <20230429173448.GD3271@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--N5HWpA/MdNt1oC9R
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 29, 2023 at 07:34:48PM +0200, SZEDER G=E1bor wrote:
> On Thu, Apr 27, 2023 at 01:13:08PM +0200, Patrick Steinhardt wrote:
> > We're about to introduce a new porcelain mode for the output of
> > git-fetch(1). As part of that we'll be introducing a set of new tests
> > that only relate to the output of this command.
> >=20
> > Split out tests that exercise the output format of git-fetch(1) so that
> > it becomes easier to verify this functionality as a standalone unit. As
> > the tests assume that the default branch is called "main" we set up the
> > corresponding GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME environment variable
> > accordingly.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/t5510-fetch.sh        | 53 ----------------------------------
> >  t/t5574-fetch-output.sh | 63 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 63 insertions(+), 53 deletions(-)
> >  create mode 100755 t/t5574-fetch-output.sh
>=20
>=20
> > diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
> > new file mode 100755
> > index 0000000000..f91b654d38
> > --- /dev/null
> > +++ b/t/t5574-fetch-output.sh
> > @@ -0,0 +1,63 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'git fetch output format'
> > +
> > +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> > +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'fetch aligned output' '
> > +	git clone . full-output &&
> > +	test_commit looooooooooooong-tag &&
> > +	(
> > +		cd full-output &&
> > +		git -c fetch.output=3Dfull fetch origin >actual 2>&1 &&
>=20
> Why is that 2>&1 redirection used here?
> If the output the test case is interested in goes to the command's
> standard output, then it's unnecessary.  However, if it goes to
> standard error, then why is standard output redirected as well?
>=20
> I understand that this patch just moves existing test cases around
> as-is, so this is not something you introduced, but I point it out
> here, because later patches of this series add several new test cases
> following this anti-pattern.
>=20
> Since this series creates a new test script, perhaps this might be the
> right time to clean this up.

I feel like this patch series is big enough on its own already, so for
now I'd like to refrain from touching up the old tests. But you've got a
good point here, and I'll make sure that any new tests don't followw the
same pattern.

That being said, I think we should keep on testing both stdout and
stderr. The tests here are explicitly about the output format, so it
does make sense to verify that both of them match what we expect. We
should treat them as separate things though.

Patrick

--N5HWpA/MdNt1oC9R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRSQ6gACgkQVbJhu7ck
PpQilg//QR9/xBZvs6JvchEic/c3uT/dvgy7/4YJyVoXB9OVThI6Fe7pYUyVILIF
RjSzUnU7/WpexGl2B+r3OEedupzj2IXj8a1xjUYctiWNCA86JEygShM0EuADnC4G
lTHL8b1u1eHERuTJhkgCEtPVj0addfZh5UtmY77Qrrx5x6AnF1G+o9EBpPuzji12
lBeav/ENeOzeFnPYnV3ZuMgqsXwQfvNhQ4lrTUdak5Nns7MZmWEq2F8C3ajP41HJ
OhBY7QvAgvzuH9PscqI3RdA2a14Te/EuTw1AexXn6xf5n2S1IAqRW5eYj8rn5lEb
282uKQUKOLY4k16eVfqwy0zxzmgGyVc31EqMz44PRQ1QDmJ+ojytJ0LqojuayDlv
JxZczzuczcsmiAsIk4rdiEbZvusau/+07ToCVsx8s2oAfchuDhWXxiBtb2iPoehT
KVwi4GV01HMB8KrFVaKPTCID2lYY8/wXmgjFOgimms3BoJCm6c30MjZ5IO8i6ERD
Dac2mVW2JNdoRXTESnnnY6A1LqVxzwjHRz1x5SglPjj+kHTW1VvTFlWBnES/gf6I
ras2dZUkghYJFvf4L0pcW3KkMn0xoqkCHQ+3mER0S4zrjl4zX1nk5IcZtSnRxV3C
kqp0Sz6rJ92uUYEgExJBrVD3IqKsOjg9FiktyOg7HEeBlsZoeLk=
=Pj79
-----END PGP SIGNATURE-----

--N5HWpA/MdNt1oC9R--
