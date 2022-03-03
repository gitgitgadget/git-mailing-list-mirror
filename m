Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BD9C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 06:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiCCGsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 01:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCCGsV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 01:48:21 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9FF65FF
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 22:47:35 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D039C5C027E;
        Thu,  3 Mar 2022 01:47:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Mar 2022 01:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=Zz5NJ8Z/OdTM3Mq1C5sfsJk5gHRe1/vpkqMDSZ
        MZsnw=; b=TlA8EfPvJlWkumRo2NWbggX3+ycNgE9nvOa0VRCms1mKjpDaSwuToe
        vzKMS1Pe3fbh826cBXp2/gLMGUeCPgkq/g2+nA42BbaTzS+kc4DsU1tRgDfIl+ny
        RnkPPNH35xIZXO3GUOdx7fAy9022YITvn8kcmpOVLc84MdxayoVFItgZyvfs8+R7
        KjYSgBAJCYkQ179HWZTuQnk1yc0pLZhLo2tghM21HozjhkAgbuIxsfodQQzzeW8/
        +lPlBGDKFzj4HUECFu0yBYNzOPfn4xPmojvwOlik5vz94vik/d/DAeoo60DcW8C+
        gFu9j6uKtBEqlKvnycJvge8r35rDUE5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Zz5NJ8Z/OdTM3Mq1C
        5sfsJk5gHRe1/vpkqMDSZMZsnw=; b=BdzRdNzTv2sSVHwW0W2VJyVHXo/prWEaw
        aj5ZhoMHInig2gstJGzz1+2dxoha/ZwjIXISyoA6vfXR6nN1ynxxWmGYD2szYziF
        NDlKIpTx4CkvCddbKQNQ8DWRg63GacWh5z4tKK0pLdyMNqsxtAZHTb/9WC0g0Jhv
        VGjse1s7vY2VNEotkqhKmxsyNSxPZYEPPhpC2jzqdhjSPPOS5eXgrDZyHxBcJbz2
        xld+gRblM5cgOwFsqykxZ1wG9GA1pQmwwH6aKtxeahzyOAJ48UvQzsvh3qqSlawv
        xUIccUnPgUEbvV5daBoxvKEnbuKqgjqgX12kjiPITsq0LO8Y9GTqA==
X-ME-Sender: <xms:hmQgYqysXtdQgUKsGYn4IxBES71OUV24fEo9AUIEQchBIKMey1QQHg>
    <xme:hmQgYmQp-GBDa8C2Y1k6Y2uDT-HUCADuf9XVmx8Inl6e9MYa3-YmyqXW6Wek0MNhX
    M1MDEQVbev4stWeCg>
X-ME-Received: <xmr:hmQgYsXPaRbPVqPPmxPBrO_xvnoIRBKLNTS3cwNq5DYWhcCFrKZDNxKGaCtsL5ycKPXN5XRGrheg87I5DnNjd3t1Oqh_m-N8G9sGuV3sFxRTQ19jA9KZsX4mhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddthedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:hmQgYgjhN0BqDW8gZRai3WbbFjF_lTEpUL-cKaJT2j0ZZem564GOOw>
    <xmx:hmQgYsDEmyvK0wQKg1O2PWxD9CUc8wWnTluSV9LA2fwYZX7bPJVxNQ>
    <xmx:hmQgYhLi_eUoscZBKqNirY3DZr2hTCkgGMmEWmnlHmLOsY70tQ0bjA>
    <xmx:hmQgYvO3ZRVUyEI9mtHzonUmpxsatU58cT5608D7Pa-UVhBhwoVIOQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Mar 2022 01:47:33 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ac16f927 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 3 Mar 2022 06:47:32 +0000 (UTC)
Date:   Thu, 3 Mar 2022 07:47:31 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/7] fetch: increase test coverage of fetches
Message-ID: <YiBkg05+ncWDODWe@ncase>
References: <cover.1645102965.git.ps@pks.im>
 <b4ca3f1f3baacde2aea7bae4f583f68c211a557a.1645102965.git.ps@pks.im>
 <xmqqwnhbevbq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/cENWC73foc7ssfS"
Content-Disposition: inline
In-Reply-To: <xmqqwnhbevbq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/cENWC73foc7ssfS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2022 at 04:25:13PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > +test_expect_success 'atomic fetch with failing backfill' '
> > +	git init clone3 &&
> > +
> > +	# We want to test whether a failure when backfilling tags correctly
> > +	# aborts the complete transaction when `--atomic` is passed: we should
> > +	# neither create the branch nor should we create the tag when either
> > +	# one of both fails to update correctly.
> > +	#
> > +	# To trigger failure we simply abort when backfilling a tag.
> > +	write_script clone3/.git/hooks/reference-transaction <<-\EOF &&
> > +		while read oldrev newrev reference
> > +		do
> > +			if test "$reference" =3D refs/tags/tag1
> > +			then
> > +				exit 1
> > +			fi
> > +		done
> > +	EOF
>=20
> Without the extra indentation level, all your <<here-doc would
> become easier to read.  You are consistently doing this in your
> patches, which it is better than random mixes of indentation style,
> though.

Personally I think it's easier to read this way, but grepping through
the codebase shows that what you're proposing is used consistently.
I'll change it.

> > +	test_must_fail git -C clone3 fetch --atomic .. $B:refs/heads/somethin=
g &&
> > +
> > +	# Creation of the tag has failed, so ideally refs/heads/something
> > +	# should not exist. The fact that it does demonstrates that there is
> > +	# a bug in the `--atomic` flag.
> > +	test $B =3D "$(git -C clone3 rev-parse --verify refs/heads/something)"
> > +'
>=20
> Makes sense.
>=20
> > +test_expect_success 'atomic fetch with backfill should use single tran=
saction' '
> > +	git init clone4 &&
> > +
> > +	# Fetching with the `--atomic` flag should update all references in a
> > +	# single transaction, including backfilled tags. We thus expect to see
> > +	# a single reference transaction for the created branch and tags.
> > +	cat >expected <<-EOF &&
> > +		prepared
> > +		$ZERO_OID $B refs/heads/something
> > +		$ZERO_OID $S refs/tags/tag2
> > +		committed
> > +		$ZERO_OID $B refs/heads/something
> > +		$ZERO_OID $S refs/tags/tag2
> > +		prepared
> > +		$ZERO_OID $T refs/tags/tag1
> > +		committed
> > +		$ZERO_OID $T refs/tags/tag1
> > +	EOF
>=20
> I think we see two transactions here, even though the comment says
> otherwise.  Is this expecting a known breakage?

Yes, it is. I've added a comment in this patch to document the breakage,
which is then removed when the bug is fixed.

> > +	write_script clone4/.git/hooks/reference-transaction <<-\EOF &&
> > +		( echo "$*" && cat ) >>actual
> > +	EOF
> > +
> > +	git -C clone4 fetch --atomic .. $B:refs/heads/something &&
> > +	test_cmp expected clone4/actual
>=20
> Nice way to make sure what is and is not in each transaction.  I
> feels a bit too rigid (e.g. in the first transaction, there is no
> inherent reason to expect that the update to head/something is
> mentioned before the update to tags/tag2, for example).
>=20
> > +'
> > +
> > +test_expect_success 'backfill failure causes command to fail' '
> > +	git init clone5 &&
> > +
> > +	write_script clone5/.git/hooks/reference-transaction <<-EOF &&
> > +		while read oldrev newrev reference
> > +		do
> > +			if test "\$reference" =3D refs/tags/tag1
> > +			then
> > +				# Create a nested tag below the actual tag we
> > +				# wanted to write, which causes a D/F conflict
> > +				# later when we want to commit refs/tags/tag1.
> > +				# We cannot just `exit 1` here given that this
> > +				# would cause us to die immediately.
>=20
> > +				git update-ref refs/tags/tag1/nested $B
>=20
> I have been wondering if we need to do this from the hook?  If we
> have this ref before we start "fetch", would it have the same
> effect, or "fetch" notices that this interfering ref exists and
> removes it to make room for storing refs/tags/tag1, making the whole
> thing fail to fail?

No, it indeed is not, thanks!

Patrick

> > +				exit \$!
>=20
> In any case, "exit 0" or "exit \$?" would be understandable, but
> exit with "$!", which is ...?  The process ID of the most recent
> background command?  Puzzled.
>=20
> > +			fi
> > +		done
> > +	EOF

--/cENWC73foc7ssfS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIgZIIACgkQVbJhu7ck
PpSSCA/9ET8ee41FOnncSKj024eHFbXLbxB1NpkB6n0SOdalayNOfZgaF98lZ2zh
h9cxicP1jrO3oHzLJLrJsO1xMSb+W/CzuyWyCu6SsfxVyQQo+y3r9T+dskYHLqYl
ofig2XaJLT+d20Pg08XdJc0SHS9cGVnk4XLzCUvF2P8AfP7/9wrcihOqequDhNXY
fIq4W6YX8MphPr0gf41uthyTE6exurU0kbfkBZbgtWR+I1fkXspJHNE5+di38558
6UfUAylXbtpbrtptTWZwxFDupSZaCK7vsJnz0tAR2f8ESw26rOlRo7Gsn/aLf0YH
IzJ7Goxr3/yb9GYADILuUu0GVJ9XBof0MFwOAh4zoCOQUu20S4b2f7Z981c+0Asi
B48pC/aGBAZ/vY8e7WbZ32amH8vTRUimBezafrnlrFw7HxoeKya3MajwpTNJkFzm
UNa3CDq9vynXRKJeDHI+lMS6UkOohCCy5QEfoYDLrbhAq9lgHbtxKtoMOyKq0nEc
gb0/iY3IW0i5jkyoTrfKu81IZ1o/uHi3vX1qgj3iXk2nlT2I5dHIwl4k7rVbRTje
V8CoRLSffl96zgpcpen/6qEWoE3GS6igxwAi1kpRou4i3FOn2KaGGHU5FZXV+WSb
OQ9I48iq/udbKZOmjk1F1Ll9wMX4VlgZJbjTAthW6FtiFkQFPbk=
=2jVW
-----END PGP SIGNATURE-----

--/cENWC73foc7ssfS--
