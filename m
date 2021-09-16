Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FE5C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 04:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AAD60F70
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 04:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbhIPElH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 00:41:07 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:42103 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229521AbhIPElG (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Sep 2021 00:41:06 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id B66143200A9D;
        Thu, 16 Sep 2021 00:39:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 16 Sep 2021 00:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=uXQIvjHn1KetyVXYXq3mLkRnlZQ
        11WAVjqeZa16DGBA=; b=YRvS6+hmMzZLuhYT6HdfCcEOZfGoXMrP9SC2eYaDNHB
        /8D94wJW2i9EHu1c8Kycfub/HYzr0y8h1eB9jk04kRPf4sKjQV5WcsX4Yo3hViUG
        vt/oiWSiKJhA6XWMRRzdA3DdqUx5Z+l02pNFvk0q9Qw7yKEojQg8WYUIOb7uYKRn
        D75Y1HNjWrzgwhDN3gB6eivNBDisjvg77/Vrfga/V5tbhbjbu62H47EW8yxnT5jV
        iycZ32Aun3Cs3K1w2rQJqUQSZC28E9lBA/JRfUTpFwhfJCcWihnDh8wUlxYTHFLv
        Bov3Q/WyU3FQPZlRnUh8LOezUtg9OASkS/B3jgyJzyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=uXQIvj
        Hn1KetyVXYXq3mLkRnlZQ11WAVjqeZa16DGBA=; b=p41DZBKC3egLkNcxTKOv3O
        N4cV/AfKhFzOrlLzWGufBo/dpuh4G2tKSr3/vfBVX0m1pWhlG88ljUVBN6/3lg4F
        DAO/jrTAE29e2mwbzQ8NDZ+VV5cEs26kNpxa1Vmo9Qv+c55jebz5riV7GZJzy5AL
        fS2SmWkcA+9VB9JnfRV+sHBQRc67HFivLY2tRCG7sbTND5mRY/z4OvwUvuwS6Eln
        NJRY9LC4RmtIHpjMvDpF+9NIU/5VG8NBTjftznhSo+2xIq/YqoIfaQmEpRegXSZU
        UrQoMHPByFgM52RKpmdjsEpT0ZdbF3ORLrACoPZ37jpGiZbNa9TaZy3DuL1xoNZg
        ==
X-ME-Sender: <xms:kMpCYVWWGoKUjI4CsPEt1nQZMy-mw6wMUuzWMrW2MiLepsPlwpWCUg>
    <xme:kMpCYVl8tNxTSOhPt4uW6Dg1bkuUVIgQEa8Y4UPpYRX_v9-hXzdHEJbMrglKl8ten
    FHc6a99xtOYwDeV1A>
X-ME-Received: <xmr:kMpCYRZA_ecBP8WtI0qSka9OKAuHBO0js5QRGQOmr9bj1oDsd0AAlAijKgIbx8WzkC2bYrlcKVGtWvAh4QhH9naprmnLGAYqjRf_5Tq8O6WjNjXjb1aa-WU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehfedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtro
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueegleetledthfegffeuhfefieekudejhf
    ekjeeiueehgeeufeejfeffgeffleetnecuffhomhgrihhnpehgihhthhhusgdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:kMpCYYV5k7t-c9GgBp4oHH4CMTghlkmMjOD0ajjTN0wGjsyvjmmF6A>
    <xmx:kMpCYfn_1_VlmSQr7nHcQ0-xdRLQiHUd10nDkWfm3HzSuG5EDBiACw>
    <xmx:kMpCYVdPZCVqQZ66xRUKXpmFXLX-vbXWiI2iMxJUTsKppD14GRfA-w>
    <xmx:kcpCYXtQDA0MT8PfjBU09Z-VhZ1WJAxhJBvLWtHKxupVlsEvbn3QsA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Sep 2021 00:39:44 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2ef22f47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 16 Sep 2021 04:39:39 +0000 (UTC)
Date:   Thu, 16 Sep 2021 06:39:37 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t1400: avoid SIGPIPE race condition on fifo
Message-ID: <YULKiXOpiRmHBNiy@ncase>
References: <1e9e62a2c5f74db91aaded83783076c28b757836.1630659922.git.ps@pks.im>
 <YUIptJNN5DxrkydV@coredump.intra.peff.net>
 <YUIsZCTqm56KfilP@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ag8HdL9hmieMeCfc"
Content-Disposition: inline
In-Reply-To: <YUIsZCTqm56KfilP@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ag8HdL9hmieMeCfc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 15, 2021 at 01:24:52PM -0400, Jeff King wrote:
> On Wed, Sep 15, 2021 at 01:13:25PM -0400, Jeff King wrote:
>=20
> > I think this test may be racy. I saw a strange failure from it in CI:
> >=20
> >   https://github.com/peff/git/runs/3605506649?check_suite_focus=3Dtrue#=
step:5:6734
> >=20
> > I can't reproduce the problem locally with "--stress", but the failure
> > there is on macOS (and likewise, a nearby run failed with a timeout just
> > for macOS, which could be caused by a racy deadlock).
>=20
> Ah, I just wasn't trying hard enough. Using --run=3D1,190 lets it run a
> lot more tightly, and I got a failure pretty quickly. Here's the fix (on
> top of ps/update-ref-batch-flush).
>=20
> -- >8 --
> Subject: [PATCH] t1400: avoid SIGPIPE race condition on fifo
>=20
> t1400.190 sometimes fails or even hangs because of the way it uses
> fifos. Our goal is to interactively read and write lines from
> update-ref, so we have two fifos, in and out. We open a descriptor
> connected to "in" and redirect output to that, so that update-ref does
> not see EOF as it would if we opened and closed it for each "echo" call.
>=20
> But we don't do the same for the output. This leads to a race where our
> "read response <out" has not yet opened the fifo, but update-ref tries
> to write to it and gets SIGPIPE. This can result in the test failing, or
> worse, hanging as we wait forever for somebody to write to the pipe.
>=20
> This is the same proble we fixed in 4783e7ea83 (t0008: avoid SIGPIPE

Type: "proble" -> "problem".

> race condition on fifo, 2013-07-12), and we can fix it the same way, by
> opening a second long-running descriptor.
>=20
> Before this patch, running:
>=20
>   ./t1400-update-ref.sh --run=3D1,190 --stress
>=20
> failed or hung within a few dozen iterations. After it, I ran it for
> several hundred without problems.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t1400-update-ref.sh | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 1e754e258f..0d4f73acaa 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -1603,19 +1603,21 @@ test_expect_success PIPE 'transaction flushes sta=
tus updates' '
>  	(git update-ref --stdin <in >out &) &&
> =20
>  	exec 9>in &&
> +	exec 8<out &&
>  	test_when_finished "exec 9>&-" &&
> +	test_when_finished "exec 8<&-" &&
> =20
>  	echo "start" >&9 &&
>  	echo "start: ok" >expected &&
> -	read line <out &&
> +	read line <&8 &&
>  	echo "$line" >actual &&
>  	test_cmp expected actual &&
> =20
>  	echo "create refs/heads/flush $A" >&9 &&
> =20
>  	echo prepare >&9 &&
>  	echo "prepare: ok" >expected &&
> -	read line <out &&
> +	read line <&8 &&
>  	echo "$line" >actual &&
>  	test_cmp expected actual &&
> =20
> @@ -1625,7 +1627,7 @@ test_expect_success PIPE 'transaction flushes statu=
s updates' '
> =20
>  	echo commit >&9 &&
>  	echo "commit: ok" >expected &&
> -	read line <out &&
> +	read line <&8 &&
>  	echo "$line" >actual &&
>  	test_cmp expected actual
>  '
> --=20
> 2.33.0.917.g33ebf6a5f6
>=20

Thanks a lot for digging and fixing my test. The patch looks good to me.

Patrick

--Ag8HdL9hmieMeCfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmFCyogACgkQVbJhu7ck
PpRznhAAiAeTBJh1AdK/34WzMx+rFQRn+dDcHVkoukN71b4s9cK4VcXMLziCoJDp
l1WOF3hEioPev4I5xaMu86FNWdiLhsmnbGICH+b7gDoHwIsyIckPxDGetvaiPLAD
SNSZ4DUGWyCAm8Voeu9g76ggSPYwbL5AJZW5kbJ2oVu16O8o+n9SvF5whcU47T/s
RVIVFuE4baXUIDTDRAE13OrO406zRDQ1s2VDofmdsc3RV1RtuDEBaZlHqsSJMSwM
k4vNO3GrnxyCPKyudLcEBb5uyMT+w+ZbIA1/ByE7NijiMluWcMrKWO1DA36RLW8S
K/Q3f2t65WcI2ZURoN6I0XykkCEL8iHil/47CkpP8I+E4Nolzsu3RnA62MEBpA4y
Ix7o3zNS/3/xaBBFK18D/baNhTVm8BdXN0WLxkAzqLcrpFzRZyQG2TD2HHR/TRPF
eRPLXKPnJ7BcYYVu9EbBiLyKhDz/qQmAWTosfMtgO5BgtPPTGpzDwNeQht7C8hld
6r4P1SD4H9JaQ+LvmiC8/8Zee3odkSDJ2tGze4RqMMF/G+Ckh1BEN4KxovsRZIL6
4200ax1RnjgBMTiTfWI1LmrsAPby8Db02IfjJK/pSp3uh1zXeXTevAHF7fC4yJUG
xtXbip60iysYZXbDj2w1/Yec2OsnL558cx08KPuueZkGPhMZeJU=
=XuXM
-----END PGP SIGNATURE-----

--Ag8HdL9hmieMeCfc--
