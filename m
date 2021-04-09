Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AF0C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6E461105
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhDILSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:18:25 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37333 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234139AbhDILSP (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Apr 2021 07:18:15 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4DADD5C00AD;
        Fri,  9 Apr 2021 07:18:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 09 Apr 2021 07:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=EwrJY9C6qsFScE5OoS6k4+Q7hbn
        NMpqIOGDjcL1QRgU=; b=QvqeqYLW9dcIQ6s9EEV9ggKBddv7ZKsaZ4YN9x8c6uj
        OSjeFnJ+wNQXrDBA7+AQ/ZjY0PMgZMO5+5YOWrcE1E+d1UIO9M6BEKfd4xE7VBVN
        yx/H03bgoE1RkLiMtuyqQTsL7F34A+izC5ThT8pEVEPB1H0JTbfdvIfPjS/y2Vdd
        p1ybMzILhzfz/OwSFBMerGdkwiH/DX489FiRJbiYfp2r/pB6E2BBTFDmbrYLUVPJ
        FgLNtYA48S/D8ppz0QUfawdMHX1WICLBibAAxA0+qxw9ryUrvjfzNTrHfX58lRsv
        o9KElUy2e0Y50MY1l0v3ZXG2WggUjJMrFNzkwvV4z2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=EwrJY9
        C6qsFScE5OoS6k4+Q7hbnNMpqIOGDjcL1QRgU=; b=TfrjnyRlTcw9NbLzav0rRz
        UlcB+kG97CYoW2zq7liTV0QrFdiZQU/DCZQQgYVs81E+8kurpIxFL/aQCSXojp6V
        VnqZddVUxq7XO9lrL77rlHid+eYaqXRoWnf4hXjO+FPCxkPKB2a+uO9LV/QqLWyu
        3J6MDL7JJknwe/UVCvxlDfYwtXAbO31HXuX5VhHt5+qqhmHw2Y84KlmxUScUTD50
        COC0z5r4EgcWd75Q3FJwRP8UTvKo5A1A3NlNgLtJz2u7LNrSLKO+kuWMx4pMusYD
        z9uD4zZwqr6FXzZRNLvnL48UI6OW/6U3aPB7Nh3HF5eBRQbJ6RXekUf0RLqBwm2w
        ==
X-ME-Sender: <xms:6jdwYHQkSdY4a5VrfOtvvyTqKR4q5Dwc-ztw1LuK7XAG4h11nyDGog>
    <xme:6jdwYH_Yn_ZmoZ-BrGHBNKM4oNMbUJG4K98BG7w-eI2F5ZRqw0YlYHRdXXQ3Eleik
    B-SdzB1x3xaeHoaGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdekrdduieelnecuvehluhhsthgvrhfuihiivgepudenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:6jdwYPiy1hIA6ldfTHX0Zfn4ogf1ZqoUrnYVpCmJmAKHxfpNizAy_Q>
    <xmx:6jdwYAY9Jr8M06tJNLiW25YJJqxV1-TUroo5BT-LDNID6f7lvlF3tQ>
    <xmx:6jdwYM-cUWbzlyedWPAhzOl5UDJ4LEDv39ZYFTE-N6TU15RLVZ1wcQ>
    <xmx:6jdwYKpsDh9WB6ZjZiXiEEaAmtcQ-oweA-9NqkTNPz055RV29bRRTg>
Received: from vm-mail.pks.im (x4dbf08a9.dyn.telefonica.de [77.191.8.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id 66685240065;
        Fri,  9 Apr 2021 07:18:01 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b98790e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 9 Apr 2021 11:18:00 +0000 (UTC)
Date:   Fri, 9 Apr 2021 13:17:59 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 7/8] pack-bitmap: implement combined filter
Message-ID: <YHA359zqnw7MV8Bp@ncase>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
 <fac3477d979058da0430b974a34f7c7f866bf456.1615813673.git.ps@pks.im>
 <YGygV1mesbJzdPr5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xaYskd+/Yej+j6ch"
Content-Disposition: inline
In-Reply-To: <YGygV1mesbJzdPr5@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xaYskd+/Yej+j6ch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 01:54:31PM -0400, Jeff King wrote:
> On Mon, Mar 15, 2021 at 02:14:59PM +0100, Patrick Steinhardt wrote:
>=20
> > When the user has multiple objects filters specified, then this is
> > internally represented by having a "combined" filter. These combined
> > filters aren't yet supported by bitmap indices and can thus not be
> > accelerated.
> >=20
> > Fix this by implementing support for these combined filters. The
> > implementation is quite trivial: when there's a combined filter, we
> > simply recurse into `filter_bitmap()` for all of the sub-filters.
>=20
> The goal makes sense.
>=20
> Before this patch, I think your test:
>=20
> > +test_expect_success 'combine filter' '
> > +	git rev-list --objects --filter=3Dblob:limit=3D1000 --filter=3Dobject=
:type=3Dblob tag >expect &&
> > +	git rev-list --use-bitmap-index \
> > +		     --objects --filter=3Dblob:limit=3D1000 --filter=3Dobject:type=
=3Dblob tag >actual &&
> > +	test_bitmap_traversal expect actual
> > +'
>=20
> would pass anyway, because we'd just skip using bitmaps. Is there a way
> we can tell that the bitmap code actually kicked in? Maybe a perf test
> would make it clear (those aren't always run, but hopefully we'd
> eventually notice a regression there).

I think that's not actually true. Note that we're using
`test_bitmap_traversal`:

    test_bitmap_traversal () {
        if test "$1" =3D "--no-confirm-bitmaps"
        then
            shift
        elif cmp "$1" "$2"
        then
            echo >&2 "identical raw outputs; are you sure bitmaps were used=
?"
            return 1
        fi &&
        cut -d' ' -f1 "$1" | sort >"$1.normalized" &&
        sort "$2" >"$2.normalized" &&
        test_cmp "$1.normalized" "$2.normalized" &&
        rm -f "$1.normalized" "$2.normalized"
    }

The output is different when using bitmap indices, which is why the
function knows to fail in case output is the same in both cases. So we
know that it cannot be the same here and thus we also know that the
bitmap case kicked in.

Patrick

--xaYskd+/Yej+j6ch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBwN+YACgkQVbJhu7ck
PpQCyw/9EGpSjhZ9LlmP/xHLqCXfMZrsqlhtmKZXd0F4og4kGimkFk09UfUy47M9
LxdkokA+EhN2jH0XlJDPqgNLwc9vbadJitlR3YBwT0pNIJarSjjNMC1LKbwmJjw9
mPQKlvqxIO/H0hofaGqirW+mK91lg7SO9d5BISpzi4hdxbj3C0IJSC2XoPPV/D/Y
ukG49RW7JDqATFcL9WvyxJ2+aL7nr8tJdSrrRTawwKxSY7tgJGrG8kvmQtkThEyD
SHWaTQYT0Il4DVM496Jd9yYXE/HUIi98CTkmgRhl+CqrHo+yIP44Gs4NNXGOdPwt
NlI3bLdN0SnM4hfQNvYnWeByuKBqIMWn5az6e1XiSkD9vlX9TBTdqqwnHoP/j2vF
MtSIDmFKrjbzza6iLKBlWUYF6OmJMlyVEy05pxtmaXonU8gSaZaJ47U24n31J7YC
n0LBbrgaLn7p7MV9wuW02rM4mqIG1cu7lL09VsfgBrzr7gliZy4LqjgFSNKAxhJ7
9CA4iZzRORansuTp20x44BPT7/9VPDcPjya5tYPKysAG3xXdVilTyOcaMF1bS8yy
2x5ifjouUiz+DiZ+yr3ediEApRsXhEEdYxsTla3zb2mA3naS3FbLHId7pivxTk1A
k45hXEgc1zGf8XFuG3wI/RUx3Cx7rRg67iMoDky9fXjwuvZNaLI=
=6F6X
-----END PGP SIGNATURE-----

--xaYskd+/Yej+j6ch--
