Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E536FC433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 07:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9881920729
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 07:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgLWHrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 02:47:04 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:44663 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727441AbgLWHrE (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 23 Dec 2020 02:47:04 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 947529F7;
        Wed, 23 Dec 2020 02:45:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 23 Dec 2020 02:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=6XBP6lnLcFME7HEK4v7peEfEYi3
        YPsSQ7eZ7f0qpURM=; b=LFHzQCsgp+2XYlI4StVeiR3cAL3qYLmkfng2O7431KK
        9Rw1H50T4imBjGRz1HLAxvy3xW9INIerWSAhIOJNL2kP07lMeNEB5Nw+9hiau/r2
        iUHUcbJNMhnz/90xxdnSDD0JZKW7vY5YkdAR+HN0bf5+nyMz7XYAYGMmoiPH8YoQ
        TLbPLKGsITaylXRRkVtA5p5L8aleqoFY7jiZ8CyIXxgzuqEAu0bsncbA5C/kWsZm
        euLxHW1K9ZMLNw3f3wxtNBH9O/AaZsl5FAvbpvwbNSSGAILZhPU8lKPbr5IoDWdW
        qdp/TBz5GX7te0eKu4rcYJER5OS96dCtvxZD5wBmSpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=6XBP6l
        nLcFME7HEK4v7peEfEYi3YPsSQ7eZ7f0qpURM=; b=kaOKrlzX7t6Rldxw6PXRpS
        CcfVpdSuKzo/5FCe2g1aaS6o+FDh+qkSNcO9vH5iIeG/pljpA8/mkomQoGITjcrj
        aIAXAi0NKwsOB6fEG1uz1schPOA8+C/auSG3LdeKtf1e1I7eT5svdOWQrggcYPPD
        hti8m1r4u7J2cI3Rrik9HBuha5qmSlypoH7l+PpCDKSAVhPgEocUugwgcn/xvCoR
        Svv38cfFe9ADkaz0WQnJbYQ8S2IlowEscWd+vWfhpX3NvkEN7soiYLmFCD+rxrPo
        q1FRPUMyGY5n52lufd1KZxULvtmfqv3Ny4GkHLPZ4EmMoZjMmPYbVk2p80DRnOTQ
        ==
X-ME-Sender: <xms:r_XiX6rLH6nBTQ2ec4JMBHi1VONrIL3s500wGIc5pzIcWgBr1h5ZPg>
    <xme:r_XiX4qPMgio4oGN7_CIRpIZdZzDBLjk9ekBabXGvLq2xhUht8ZziLAt1OJmMwFxB
    ted-5Fdybx2NpiiIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtiedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepieeilefgkedvhffhhfffgfehjeegjedute
    elieffffdtieegfeekvdeggeehieefnecuffhomhgrihhnpehpuhgslhhitgdqihhnsgho
    gidrohhrghenucfkphepjeekrdehgedrjedrgeejnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:r_XiX_NxFeGJWezlD3Ynu2hGgHvj71aTwx4GangqM_ScwbMzNvhcGA>
    <xmx:r_XiX55CaSXF6rTd6NTRT7LJuhAV-5vpNq4kwN7O-zys1wvDTGwkGA>
    <xmx:r_XiX54Vlyn08SKiWjHBS6mo8GIaaGi2FHtEgLlcf07RBdt1lyrsKw>
    <xmx:sPXiX6VpYVpxRxBLO8aCG-H2v4hZ9IxO2seeDNwnhxUlGJ4zgO925Q>
Received: from vm-mail.pks.im (dynamic-078-054-007-047.78.54.pool.telefonica.de [78.54.7.47])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0B6D81080059;
        Wed, 23 Dec 2020 02:45:50 -0500 (EST)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id c53c308e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 23 Dec 2020 07:45:45 +0000 (UTC)
Date:   Wed, 23 Dec 2020 08:46:43 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2020, #04; Tue, 22)
Message-ID: <X+L14/K8OI1Epa20@tanuki>
References: <xmqqo8ilhafa.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PkQgd8x/o2fG2/Dx"
Content-Disposition: inline
In-Reply-To: <xmqqo8ilhafa.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PkQgd8x/o2fG2/Dx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 22, 2020 at 12:07:21PM -0800, Junio C Hamano wrote:
> * jk/disambiguate-equal-in-config-param (2020-12-09) 3 commits
>  - config: store "git -c" variables using more robust format
>  - config: parse more robust format in GIT_CONFIG_PARAMETERS
>  - quote: make sq_dequote_step() a public function
>  (this branch uses ps/config-env-pairs.)
>=20
>  The quoting rules used to pass "git -c var=3Dval" configuration
>  across processes have been updated in a backward compatible way, so
>  that the value read from an environment variable can contain an
>  equal sign when using the "git --config-env var=3Denv" feature.
>=20
>  We may want to make this just a middle part of the
>  ps/config-env-pairs topic with a bit of patch shuffling.

Please note that this has already happened with v5 of my patch series
[1], which I've sent out last week. So you may want to swap out those
two series and use the combined v5 as it also improves documentation.

[1]: https://public-inbox.org/git/cover.1608104755.git.ps@pks.im/

Patrick

> * ps/config-env-pairs (2020-12-09) 6 commits
>  - config: allow specifying config entries via envvar pairs
>  - config: refactor parsing of GIT_CONFIG_PARAMETERS
>  - config: extract function to parse config pairs
>  - environment: make `getenv_safe()` non-static
>  - config: add new way to pass config via `--config-env`
>  - git: add `--super-prefix` to usage string
>  (this branch is used by jk/disambiguate-equal-in-config-param.)
>=20
>  Introduce two new ways to feed configuration variable-value pairs
>  via environment variables.

--PkQgd8x/o2fG2/Dx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/i9eIACgkQVbJhu7ck
PpS9rRAAqU/OtZo45AhDFGeKjpxDPK1386U0AvE/XGYDoyVOqN1ufg1cIWdZcvVM
3e3qDJMC/rag388t2hbo9vqX5r+2kJNJWxbs3qWdYrGlgYV+79+7xoUnfNu1HAwl
T3S92GvLcxqwyW4JinSZ+u7TIhm2wPbP7Zmu4KYMz3cTfxk3Sonsfv/mHb3WbDwQ
6RYaW2JvOCIp99RGg2uZGnHluGbevbU/i/zn7RNOwUPIeJF3CvefiSq4VC2L/bCO
OpsvDU3j6CopQ7dC1VjnSDBMbgt2A8WhSfuRelQtGI1pn4xAbqVPYsIoxAaJ9+7b
ICxhwO76HjSFLa+GsctSsasFPIfFqSsRfj9eOtEbJ5k+SsG36JSHl2f3uPOaWV6Q
z1tzjdWqcudp5eaOL5jrhMhMi7Fcy8dmCcKAcyo1/aA0RO1Us7t3PPLc4GVST2rq
FByCekDa3/FHB4k35iJx5JTCXS7ui1xTkL7SQCGqztfEY82qdec7a7b5xJ9LObai
fskLDOhacS4F1TZjn14aR1FYX78kFH7plbirLCqEGZkMIDDGdgGy+x8ulN3cyrUd
Ts8uyxVMjQZqrAjMCgkX5X8UyHTgbzkq4ciKCKsf2Yx8BkitypPTovE0x7ez5UtI
Gf2r8BH/YCwcfyXJSuGBEan88+rXnpZ26e2j1SVECbKjZLboBhE=
=Re0h
-----END PGP SIGNATURE-----

--PkQgd8x/o2fG2/Dx--
