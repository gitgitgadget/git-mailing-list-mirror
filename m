Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9372CC433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 07:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4242C23131
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 07:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbhATHno (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 02:43:44 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:41741 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729738AbhATHna (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Jan 2021 02:43:30 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id AD8DC141F;
        Wed, 20 Jan 2021 02:42:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 20 Jan 2021 02:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=vFzCBs6OR92ZNmP91szFz1lZmLw
        ScsiI+fzUqV5lhM4=; b=jtl/IIocpL+8pLoK61CSO6a6lUqntjSoAxSNThOpMII
        SaFqYuG0NN3jw26nHW809Mk7cUgbd5x9uZayX6zI+55+jGHrwHP3MEI1eCtrsVZu
        7O1Ng+5hvpysgfayca8LYjKxSMONiDR7OPJjWYjri2lD+ULxCNIyfpXT9buVbxg1
        /riXs02xCh3Uv2kV2NtUEsngIllrevehVSvFN22qaoZWj7R0DLpMo77Ou7CAo2hR
        7HHPQV1C6uLyq6krNZlBMXxNItOdp4Nj3f6c3beXZ68V0giSq6KAcctLGKiTLY/X
        VB2f7X8d8CL3ENSIJsmVuJz537zasbxs17qCzcn0+Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=vFzCBs
        6OR92ZNmP91szFz1lZmLwScsiI+fzUqV5lhM4=; b=Jzz5aHIoYwh5StFjFhSXvs
        dMYv6O91IxJbAO3jRfohPtV9GcmQlSjXRczxSqucukfhus80Jh45vOEXa1YBSOVR
        92Yp9+gn0YNNiuLx12maaJJUwTIhN09nfU8pEdFIaxEWPDHMiQwIlSdkkLj9Fa/v
        XYVAWf/ThXDVlH0W3fbi2wOS5RBKzbMmecvooiRBvXzneZQE60M+zXsckn0kY07C
        TEpiVr7a6iVp9dyEqXJcloM71GkOSusZjnBhxRhT5YXAnfINKLR1TAzaqPVD62Oa
        Hl9Lnvjs5xpEHQXJgYf0L4HRxmdQeZHJZdtR6lHaMV4MkANF1dbQ60wXblAk+kCg
        ==
X-ME-Sender: <xms:3N4HYCpjD1DjZImo7aWYY2yTapQqjZRogvvSvLL-pcVmDI7HQU2YJg>
    <xme:3N4HYAoRUwgcvgijRh-zRRbGhPcMvoJ17rve_8qlnEdRc_kIBUJ6NTe_1_5RN7cII
    IPE4YkWZ9RubXS8CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddugdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrdduvddrfeeirdeitdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:3N4HYHOVRYUbqEQsfG0vN_q3G6q153u2hrKZYRhXvLnmfxQF1d3SJA>
    <xmx:3N4HYB5gzQeQQhSL8gxhm-oibHTJb6Zl2g_nd6Q1FL3j__ICRpcfhw>
    <xmx:3N4HYB6luLKgCMl-02H1XVugK961jVpgRh_z-BTGJMguovLsmdFcew>
    <xmx:3d4HYE166by8sV7Up9ZMWnao9d0Qy1FqLofPARC3QD0xOi8gI2E9ow>
Received: from vm-mail.pks.im (dynamic-089-012-036-060.89.12.pool.telefonica.de [89.12.36.60])
        by mail.messagingengine.com (Postfix) with ESMTPA id 609E0108005B;
        Wed, 20 Jan 2021 02:42:19 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ee0c34e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 20 Jan 2021 07:42:16 +0000 (UTC)
Date:   Wed, 20 Jan 2021 08:42:14 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v8 5/8] config: store "git -c" variables using more
 robust format
Message-ID: <YAfe1laqK+bfHKVm@ncase>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610453228.git.ps@pks.im>
 <36c2a51b13e463a4aa8e5316447336927153d99d.1610453228.git.ps@pks.im>
 <YAHqHmGOUl53mfPa@coredump.intra.peff.net>
 <YAfNrX1KNhHRbHmM@ncase>
 <xmqqk0s8gkqz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AkD5UhggHp9q3JgG"
Content-Disposition: inline
In-Reply-To: <xmqqk0s8gkqz.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AkD5UhggHp9q3JgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 19, 2021 at 10:55:48PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > On Fri, Jan 15, 2021 at 02:16:46PM -0500, Jeff King wrote:
> >> On Tue, Jan 12, 2021 at 01:27:01PM +0100, Patrick Steinhardt wrote:
> >>=20
> >> > The previous commit added a new format for $GIT_CONFIG_PARAMETERS wh=
ich
> >> > is able to robustly handle subsections with "=3D" in them. Let's sta=
rt
> >>=20
> >> It looks like this commit and 6 got flipped from the original ordering
> >> (it's the "previous commit" talked about here). And indeed, running the
> >> tests on the individual commits in this series shows that we fail at
> >> this step (because we are writing the new format, but the reader is too
> >> strict to accept it).
> >>=20
> >> That doesn't matter to the end result, of course, but it hurts later
> >> bisecting. Just flipping patches 5 and 6 makes it all work.
> >>=20
> >> -Peff
> >
> > Oops, yes. That always happens to me when I start using git-am(1). I see
> > that the patch series has been applied to "next" already, so does it
> > make any sense to resend with patches 5 and 6 flipped?
>=20
> I recall saying that I'd "rebase -i" before merging it to "next".
> Did I forget to do so?
>=20
> Disecting 4ed03412 (Merge branch 'ps/config-env-pairs' into next,
> 2021-01-15), we see:
>=20
> $ git log --oneline --reverse master..4ed03412^2 | cat -n
>      1	b0812b6ac0 git: add `--super-prefix` to usage string
>      2	ce81b1da23 config: add new way to pass config via `--config-env`
>      3	13c44953fb quote: make sq_dequote_step() a public function
>      4	b342ae61b3 config: extract function to parse config pairs
>      5	f9dbb64fad config: parse more robust format in GIT_CONFIG_PARAMETE=
RS
>      6	1ff21c05ba config: store "git -c" variables using more robust form=
at
>      7	b9d147fb15 environment: make `getenv_safe()` a public function
>      8	d8d77153ea config: allow specifying config entries via envvar pairs
>=20
> The 5/8 that needs to come after 6/8 has title "store ... using more
> rebust format" and that is the 6th patch in the series merged to
> 'next'.  The 6/8 that needs to come before that one was called
> "parse more robust format" and it now appears as the 5th patch.
>=20
> So it seems all is well?

Indeed, I missed your message about the interactive rebase. Thanks!

Patrick

--AkD5UhggHp9q3JgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmAH3tUACgkQVbJhu7ck
PpSN4xAAmYZNOzdchWvMEBuaWaXPl5kMU8NzTS8s/E1Cu4oU4nHwSZQ8zrZ0esDS
Pss0jJj4Yv5QMCWce7r0uqZo5hg0pQgyF1DcyLbwDaUjNs2bz3NC86S6jmzO3cg7
Zj4IxU6AXT+MhOUDwgrxcKALYi6Rbk3pRJWbEvIZ3j3ylWyfzU19C+5AcfhQWPjj
4dVO4m0pH8jj7WpIX1C8gklrtNzq/h85P9nNmHaRveLwqiujI5gwA3+pUdgPLMzj
V1xJMk2O8QbczlWzphedazvYy8+NtFdzf7rG9mmd6efcE6kVohbUEr8EWCiyzlSz
aQJeOnLV72cjHby9GbA/1Z9DPc+jjpnB3Zlz4bjnivDCqMJCLdhj9IA5cx1u5obd
74jsqJlpGbFEW1xvR+3LviHnsfFyz+8rN2Zgem0pR4BPMketmDexBqfj8IBP52c6
7KhBisUaE9Bd/DO38ajTFfotIR4l/M1aa1IX6QEb9UtX40d31rUA5vO2R1UBfN8g
qc3eXCO1krpTa3IPWrdKq2VNa7wf1HiRMDx31qnwubhozDMINn1ugPiH5H8Xab76
3QHQBYJrE6YNMuQxHFOGSEbaryqusJEtQslbe1N83k/vR+TcbEVRAxBiHHbpBU4o
1dSUiAUTd4fwsdUUP1k5Zaov+sTx4U8pnCoO01R0pPPtpEreUrA=
=J85J
-----END PGP SIGNATURE-----

--AkD5UhggHp9q3JgG--
