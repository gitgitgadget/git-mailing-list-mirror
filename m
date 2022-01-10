Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784D3C433FE
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 12:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiAJMzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 07:55:05 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36237 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245723AbiAJMyY (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Jan 2022 07:54:24 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id AD1D15C017F;
        Mon, 10 Jan 2022 07:54:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 10 Jan 2022 07:54:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=OgtBPArRdsyeZoAxHqBqBA8e/Mv
        mAclMvZ3RTn/lO1E=; b=Y/yTiJlBumDxnh+0HV1iy4q7LEMTndnX9Pf+fW7lpD2
        qibGZjx7TT9d1PR/Vt+0MRyWaI8xuAX2h5z3CAyOzG0ERuxDGn9Ntp3IY0cx4KlK
        bznShcYn32SIEaCjo3aV8bp1/J4tn+lIJKpdCOVuP1iJj+jB/3r2OBdbAckzXLN8
        cc+f567e+3zVDS4OBHd9diC52DXCft3L22kTCasQnaOso1t5Yol5igANFMezZZ13
        7SdQpJeCDP8U9UytkwfuhMgSH3uH7o5wClAiThjTl1K1PStQxmPUSW3fn2oGMZ3Q
        yQbsJkWE2UHlfu7ntAxJVw5VUFZShuPxFIUkzX6FWog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OgtBPA
        rRdsyeZoAxHqBqBA8e/MvmAclMvZ3RTn/lO1E=; b=bcwzxOy61g1e7hGVbC57kt
        UU+xUOhvT/2/LQYhpKS4q56z4nHm4z+oGTQKzUXLOmW7KtUHB/78oVSCdZu64PHo
        /ry5FZxj+rnWKKd4jQ40IvhP54vw3Ko+FfQydPTR8F1DdMzOhqJYuGNNYlh32xrk
        xCvbbMqgipUDL7tFL7xjiLesOivvTbuwkgTTkq+UzfQrK4ywrbB2aE3T0pnveJ53
        iQ4BH85ia8IAXuIgOSyUMqEUL2ZMYGrl6FVNi5gZRpUoEZBAkQOkGCV3zqw1PDUn
        7nWWhzPn6cAnWrsyt79eGrntCqNXjPPy/3I+V3IMKdVaHUma5gZPITz/+5RYI+Jw
        ==
X-ME-Sender: <xms:fSzcYX7ovEjvQpLdA1ppaN7OXVUGoT6-9QmFYs27Noo97ojKAxjlww>
    <xme:fSzcYc5NbpEmICFcMsYRlrymVCO22moxn8JbjQUu63c6YqGl9HeD_y4cu7ntDNa1W
    vsNdo5NYmwCQIR6tw>
X-ME-Received: <xmr:fSzcYeeMJlvhr_wRSQFy89D-IY1ILquZOpogrmCsDrIfoJvOch6CJON4mKQEVv7bvUcRAlq0ifIPYMuqQtK399uJ9zY3ewiVQSRlzboQLKasI3oZFdRgV_iT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehuddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:fSzcYYL02O0NUgd2rq231lzCD8HNsycPErgs6rP2knDzXjak1NU0jw>
    <xmx:fSzcYbKrKJG-5XsCSYzhc2Pyimn2QYKxvd2adYNbDvDDUwbZuu7N4g>
    <xmx:fSzcYRyjkX3b1fTvEKKb4ICwPyqNRJL8QB0DS23crpxXcVoPvRmcoA>
    <xmx:fSzcYT3QyIAT91_BeCUJ-63z6ffh0XGs9BOWSHdHNBV2U6Og_23dng>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jan 2022 07:54:20 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0f344753 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 10 Jan 2022 12:54:17 +0000 (UTC)
Date:   Mon, 10 Jan 2022 13:54:03 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: Re: [PATCH v2 4/6] refs: demonstrate excessive execution of the
 reference-transaction hook
Message-ID: <Ydwsa0LiVfj+YP7N@ncase>
References: <cover.1638874287.git.ps@pks.im>
 <cover.1641556319.git.ps@pks.im>
 <b52e59cdac75e6c4530cb39f7dcb41bb327f50e2.1641556319.git.ps@pks.im>
 <xmqqiluv3tev.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CsWtxC29xp4olmN7"
Content-Disposition: inline
In-Reply-To: <xmqqiluv3tev.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CsWtxC29xp4olmN7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 07, 2022 at 05:31:04PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Add tests which demonstate which demonstrates that we're executing the
>=20
> You demonstrate too often, which may be the point of the test, but
> looks wrong.
>=20
> I actually think this should be done as part of the fix to the code
> itself, which presumably is a single-liner to tell the "skip when
> running delete in packed-refs backend".  IOW, just fix the code and
> test how the externally observable behaviour of the code should be
> in new tests, in the same commit.

The reason why I chose to split this out into a separate commit is that
it makes it easier to see what behaviour exactly is changing. If it was
a single step, then a reader would only see the post-image behaviour but
cannot reason about the pre-image behaviour without puzzling everything
together.

So personally I'd prefer to keep it as a separate step, but I'm not
opposed to merging them if you still disagree with my reasoning above.

Patrick

> > diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction=
-hooks.sh
> > index 6c941027a8..0567fbdf0b 100755
> > --- a/t/t1416-ref-transaction-hooks.sh
> > +++ b/t/t1416-ref-transaction-hooks.sh
> > @@ -136,4 +136,68 @@ test_expect_success 'interleaving hook calls succe=
ed' '
> >  	test_cmp expect target-repo.git/actual
> >  '
> > =20
> > +test_expect_success 'hook does not get called on packing refs' '
> > +	# Pack references first such that we are in a known state.
> > +	git pack-refs --all &&
> > +
> > +	write_script .git/hooks/reference-transaction <<-\EOF &&
> > +		echo "$@" >>actual
> > +		cat >>actual
> > +	EOF
> > +	rm -f actual &&
> > +
> > +	git update-ref refs/heads/unpacked-ref $POST_OID &&
> > +	git pack-refs --all &&
> > +
> > +	# We only expect a single hook invocation, which is the call to
> > +	# git-update-ref(1). But currently, packing refs will also trigger the
> > +	# hook.
> > +	cat >expect <<-EOF &&
> > +		prepared
> > +		$ZERO_OID $POST_OID refs/heads/unpacked-ref
> > +		committed
> > +		$ZERO_OID $POST_OID refs/heads/unpacked-ref
> > +		prepared
> > +		$ZERO_OID $POST_OID refs/heads/unpacked-ref
> > +		committed
> > +		$ZERO_OID $POST_OID refs/heads/unpacked-ref
> > +		prepared
> > +		$POST_OID $ZERO_OID refs/heads/unpacked-ref
> > +		committed
> > +		$POST_OID $ZERO_OID refs/heads/unpacked-ref
> > +	EOF
> > +
> > +	test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'deleting packed ref calls hook once' '
> > +	# Create a reference and pack it.
> > +	git update-ref refs/heads/to-be-deleted $POST_OID &&
> > +	git pack-refs --all &&
> > +
> > +	write_script .git/hooks/reference-transaction <<-\EOF &&
> > +		echo "$@" >>actual
> > +		cat >>actual
> > +	EOF
> > +	rm -f actual &&
> > +
> > +	git update-ref -d refs/heads/to-be-deleted $POST_OID &&
> > +
> > +	# We only expect a single hook invocation, which is the logical
> > +	# deletion. But currently, we see two interleaving transactions, once
> > +	# for deleting the loose refs and once for deleting the packed ref.
> > +	cat >expect <<-EOF &&
> > +		prepared
> > +		$ZERO_OID $ZERO_OID refs/heads/to-be-deleted
> > +		prepared
> > +		$POST_OID $ZERO_OID refs/heads/to-be-deleted
> > +		committed
> > +		$ZERO_OID $ZERO_OID refs/heads/to-be-deleted
> > +		committed
> > +		$POST_OID $ZERO_OID refs/heads/to-be-deleted
> > +	EOF
> > +
> > +	test_cmp expect actual
> > +'
> > +
> >  test_done

--CsWtxC29xp4olmN7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHcLGoACgkQVbJhu7ck
PpRxXQ/+ICRvgD54+nS0G20qMJEHnCsGgRR2zgCifvqiL2guo8thWXQSOjmhg9Sr
HFyEeXuhGg82KjyGFNVpePbbgw/oCXyNgSoPm5tsOywlsXrkJQberOC8+IDjANf/
twHhXWhcEJ26CPEM6Mo913OT8l3pklmYxg3clc9BHn8L89ZUDiNqoMG9T2THRVw0
sibgWdtmCAaLEsrZnp0IRThSK6aNHC2hN3nPrFO/FhdPnEAFHZ540uTwOdsI5eMv
vBFJzAZNkku3linQG13qGwzPKwoAG/YNrQ4OM9D9bES0nJq3jVK/Tcs91gCGChRW
tu9JyOb5cxtXGQ8y6X9pt+GJd9+osta3D8O5MSGVsDN3YmpVMBGVewnj77BLlrCx
DJhDeRbYRrC8BGCP0nHTB4QBoLC3HXrNY96DPnxifOOplKJfBHfY68d8Gx54tQz1
Ju2ynxpr9ej/u0Pwz1EEnjeV7hcQXuBlSxf+ZB1rktyYMJKYR57VXaL22LPzYZDl
1dKZTc2BG0ycBCageJ4e4CXw1elW4C7OUSEHBOuhF7gszPAvb7ybPk9ZxU8124Rd
6UubkJwupQuDHhbi2CSR4maKok0heIcY+yy51e7m2gAVJeDXf58zizL9XM+Mkodw
xVdVAoc0JaKdf+IbHK3L/eQdO5ohe+pJxwt2K6TyapENuZsZJtk=
=YyDN
-----END PGP SIGNATURE-----

--CsWtxC29xp4olmN7--
