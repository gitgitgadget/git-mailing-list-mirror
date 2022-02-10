Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52159C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 11:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241116AbiBJLuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 06:50:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbiBJLux (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 06:50:53 -0500
X-Greylist: delayed 443 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 03:50:54 PST
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0F2B9D
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 03:50:54 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7AD733201FA0;
        Thu, 10 Feb 2022 06:43:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 10 Feb 2022 06:43:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=uvbmG0lbjXjItm7gnAXYhcf9JzpLcx/pxvEY8k
        xLZ08=; b=me0AhWNrF7foWnis5XWdJpJUWQgv6no93lQ0H2Bpish3fGx2AtIZl7
        c7MA/MkuYTTmoaw4bbv97OKGFUrEa8IW3pNcfhagB+JC580KqIR1wJfMRBh5zTaf
        iEYdy9QA7kAIkybdFbR4TcZvLqEE/BNRRkvDyDwZeJ9X1dGYGGeShv4ZqwVoMPzx
        LeRTAgsqmxEES/NrHCtvJhw0hPwDknlN+GG5TzNQYUvKagh9qwBmkdZzhooN+sBp
        ijFGErr2Jj/mr5hKYmfw23+fw3gsnzxoCs1jhCkMQsnmoIaiCBK+RoXDUtwz3siR
        gazyhJCiQaiajwLE9CfW9eEm2SHcgyhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=uvbmG0lbjXjItm7gn
        AXYhcf9JzpLcx/pxvEY8kxLZ08=; b=iqPCYRtjiEogvStjLbFoUQD+48xd/jcLO
        3Ah0KJORs+fxv8jXMlo+4uxT7yjUdsLpYqKN+WPpYzsm6xP3hX7XRb19loMyTWdt
        y0Yp+nXn0ZFltutPSURct2OYjWUmm7KEmdyTnrZOAnt7wwbKyLQWVqtcA9SbpsBF
        sYLKjh5vdurh9gDqaocpRUrmLbWUleHqhOpZmXiYibhrWgPBAGNRWwDohfh1+ST6
        2tNeg0hG7zaA1Tp44I9RpqH5HosIeZNcIN1Rudr+MCsaAyjWhCWkETWWSk3zfv98
        pQqmbo0D7yhLKsfXghZWpqFrL5sw+shC4FfU9/fP6RNpgxWVAAgKA==
X-ME-Sender: <xms:X_oEYm__KYN1cC13kgDgDtiSEhGSAwV5AnKih3kDhnov9MrL-ajQ5Q>
    <xme:X_oEYmuYqZh4ZLTRN9DCnCMFpUBXKblvLjVSuETkEclPCtmGWcBL7vVePs4_mRp_q
    4rTjc0FUdmOWARLcg>
X-ME-Received: <xmr:X_oEYsBfKqMWsTxSU35nWngbOYtiU1Jr4M0I55R0Q2Mp2QsoNHGzPBBO-BSfLbsfFuZ_uDNRtxhOGIUAkyt2Y6B1iKwG5HIS_a74vN2bC0k7UtKjeF0V0iI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddriedugdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:X_oEYuew9JTsGgQQpwTzHACmd07EfkuzM73NktnSrOasKPxzenDrCA>
    <xmx:X_oEYrOgVuYfNNSjTycx9UziXniylHUiMt6SFW6a1GfS21N_UFgOGg>
    <xmx:X_oEYonaLcehJD8MC8aM1mfsVgheFOKZKjYF3XGamXK9OqkQy273Hw>
    <xmx:YPoEYkbxo6KFAX0UIaoXpT2uE-GDBGlHiWHVog-RcbcnVZkCSuhbUA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Feb 2022 06:43:26 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 86a0d18d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 10 Feb 2022 11:43:22 +0000 (UTC)
Date:   Thu, 10 Feb 2022 12:43:21 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 1/2] fetch-pack: use commit-graph when computing cutoff
Message-ID: <YgT6WWsb1QaKIbsu@ncase>
References: <cover.1643364888.git.ps@pks.im>
 <cover.1643806143.git.ps@pks.im>
 <6fac914f0fe77df4c3058340642bea2a45a850cd.1643806143.git.ps@pks.im>
 <CAP8UFD2H-WfKRpwY7jNf=Dc0g1_Kc1adY4-c2OfkoMg3wHJCrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qHPa9FQCDRROpkX5"
Content-Disposition: inline
In-Reply-To: <CAP8UFD2H-WfKRpwY7jNf=Dc0g1_Kc1adY4-c2OfkoMg3wHJCrA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qHPa9FQCDRROpkX5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 09, 2022 at 07:01:54PM +0100, Christian Couder wrote:
> On Mon, Feb 7, 2022 at 7:03 AM Patrick Steinhardt <ps@pks.im> wrote:
>=20
> > Benchmarks in a repository with about 2,1 million refs and an up-to-date
> > commit-graph show a 20% speedup when mirror-fetching:
> >
> >     Benchmark 1: git fetch --atomic +refs/*:refs/* (v2.35.0)
> >       Time (mean =C2=B1 =CF=83):     75.264 s =C2=B1  1.115 s    [User:=
 68.199 s, System: 10.094 s]
> >       Range (min =E2=80=A6 max):   74.145 s =E2=80=A6 76.862 s    5 runs
> >
> >     Benchmark 2: git fetch --atomic +refs/*:refs/* (HEAD)
> >       Time (mean =C2=B1 =CF=83):     62.350 s =C2=B1  0.854 s    [User:=
 55.412 s, System: 9.976 s]
> >       Range (min =E2=80=A6 max):   61.224 s =E2=80=A6 63.216 s    5 runs
> >
> >     Summary
> >       'git fetch --atomic +refs/*:refs/* (HEAD)' ran
> >         1.21 =C2=B1 0.02 times faster than 'git fetch --atomic +refs/*:=
refs/* (v2.35.0)'
>=20
> The commit message and code make sense to me, but I wonder if there is
> a reason why --atomic is used when fetching.

The repository that I was mirror-fetching into needs to update a big
bunch of references, and doing that via `--atomic` is more efficient
than doing it without, and this shows in the benchmark. I did another
benchmarking run without `--atomic`, and it is indeed about 30 seconds
slower for both cases. But interestingly the relative performance
improvement is still roughly the same:

    Benchmark 1: git fetch +refs/*:refs/* (v2.35.0)
      Time (mean =C2=B1 =CF=83):     115.587 s =C2=B1  2.009 s    [User: 10=
9.874 s, System: 11.305 s]
      Range (min =E2=80=A6 max):   113.584 s =E2=80=A6 118.820 s    5 runs

    Benchmark 2: git fetch +refs/*:refs/* (pks-fetch-pack-optim-v1~)
      Time (mean =C2=B1 =CF=83):     96.859 s =C2=B1  0.624 s    [User: 91.=
948 s, System: 10.980 s]
      Range (min =E2=80=A6 max):   96.180 s =E2=80=A6 97.875 s    5 runs

    Summary
      'git fetch +refs/*:refs/* (pks-fetch-pack-optim-v1~)' ran
        1.19 =C2=B1 0.02 times faster than 'git fetch +refs/*:refs/* (v2.35=
=2E0)'

I'll update the commit message to just use this new benchmark so that
the `--atomic` flag doesn't cause any questions.

Patrick

--qHPa9FQCDRROpkX5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIE+lgACgkQVbJhu7ck
PpQvkQ/4n7WUqVLnTF5dwUtYnmwk1kz3svlaGy/CSToycnH0K898YNsyUMnZ5Ezl
9JjpO2+dtgdsgqY9kj7gYiMDaZZQYSWblvl+McjP1CUuj4QnJSwKKzu+1liS25VJ
e3KKHB9YGnQTxsBrM4S8zN6PlixPhmr2/fev0r7uafJkR80AykMrI7cHDYCGpVx+
Ge2qa3XYXbDzrijrD6RYkkoivf7C7XjXDgN+P3EpvZDtnEJZkD0MxgR98MpL2jd5
+d8/X1R7bvk7+MdNq46NOtXD6O8VUB+g5ms8Dnpd6GcqvSNSObc/maVK+nb8KV4q
rvf+eanQiClnmD6fhpjdt8hSMtBxG8nei6ydokOXizKlkeOTgN37KBr2ZVut1tKC
DiOtpo9R14mwNzdcc4k3e/Y1iYXd+z19udpg/uUXXFgMOVtrmjwYxqkrd7i/9R63
Mz2NE84tsbn8rhxfoFI5yPQ1CdnvV3XcxHX9zIqccCOVT/RQj2i4bNisYBQ2XmL9
Zg4aYZAdQep37QRQGp1HZSjz1RQ+HkKsW/AF+7/j5iCm6bx4qCks3ZLlcKa5cAp7
mlsbkYVWIuU7w0tpklDi6EckhGcTYaxmUfp0L0c47YBby6y4oGjXcJ5P3txjRgwS
gNgz407odVIdMtC5wfVif42y/F9Ohy9HNxWli302vji4z4/r5w==
=Zny/
-----END PGP SIGNATURE-----

--qHPa9FQCDRROpkX5--
