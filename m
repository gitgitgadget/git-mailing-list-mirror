Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1E5C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 11:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346577AbiCULM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 07:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245549AbiCULMY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 07:12:24 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E22A393E7
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 04:10:56 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F3245C01CE;
        Mon, 21 Mar 2022 07:10:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 21 Mar 2022 07:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=d9nxMmZ0OJ9kgmhRDKVfFRx6hB65e7uBeBAB6r
        7aLzU=; b=ZDWb9raq6sRNaESBSJOhDanuRXJU9y3LPJxAQezmS9vlEIG9Tghrum
        RhS1q12Wn45FlxovTep4pJ+o78pHAvj11lqYz4LkBQHIdPF8rpFbGRl8jhNDMd18
        +U+nwN+YLosow7+L7mhGvWVCt3eYtSOcXaOYsEm/vTCyolt4cn1xeRC81uRh19Q9
        RJOUl2aDf91Ph7XNNDlx/BnttQ4Y17ABsYvpG2q+sb7aoLHC6OC8ro1o3G1pW8NR
        YWEigB0Otn70Dkb5nLx4W7st1Z8SFVFoqoPWdD3WwOTIXSIdOHBqyYwwCxQ73AC+
        tBQJafrwHPg0PzgHm8+iy3a2pmMribHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=d9nxMmZ0OJ9kgmhRD
        KVfFRx6hB65e7uBeBAB6r7aLzU=; b=UIcefNZAyIhQTE28bDkFvm/qlbzJ/6eqf
        /RLx0PosmMlGaGgqVYCWk5wEYKInM0uQHqZ5XA6YuTiUuKFgC3kM4Hv12+gP9Qnc
        X2OEhVSwe2x5NjqpbLp/YeyRZbDtBUc9mCj7vhstkvtEGkxMzarttOSUxsyLg/Fl
        /0TFlnlf+Wj0TvlwSiXJ+NqCDPxE4XVXelLXeTXl3WXHGicWy8JP7p/OE1FCXvAv
        IRN7HQbKIcHFF9Hca3Ek1Boj/UKK/+FcBRqJExV81TwLAuZVuo//2OR12RbZep4w
        XbS2bhPvZMlSNSTv2JU8k0vZXHp7/vjQMXdOeUGFSHgwzfqf7S4Kg==
X-ME-Sender: <xms:PV04YikPmz2EV2FhRFDOx2MBgUgVQErERsAvlvRTC9VA1XKsEHdx8g>
    <xme:PV04Yp1mZloy071w8dx5EK8h5ZCDX-uqqU09TPyG9bT0jIgvNpS0hEBdIEKMgbHpD
    urSwPlyaBbNoY0r4g>
X-ME-Received: <xmr:PV04YgoX5zPI8JdTVziXyqLbuYlXV1wHpaF5_hbT7Cmv0STNtdQfmWpnqqRoEXUSE1S28bHvgXl8ViVXU8-IpL47jrqlB84DJcKcGBbSavfosTGdzn9GwOJz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtffejieduudelhedvgfetieefleehjeetvdetudeitdetvddtfffffefhvdfggfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Pl04Ymk3M-YIhOUNtvC8SzfC74XcEMgxdFvT9E0ciMKSBVbkio7oWA>
    <xmx:Pl04Yg2ypmagdD_WIXwa4r0pHju3aalBh11vDQBDUhSIY9YiTcrxUA>
    <xmx:Pl04YtsZ1GPC5IRxKYIUk5TRF0Oq0E75Y35a5SZzygwHTu9TlpNTkA>
    <xmx:Pl04YuATv09dbLAN04swNryVKwyFxwzE8TmA6gWK300XhXQke07wyQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 07:10:53 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 7eb56ef2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 21 Mar 2022 11:10:50 +0000 (UTC)
Date:   Mon, 21 Mar 2022 12:10:49 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] refs: designated init & missing debug in
 ps/fetch-mirror-optim
Message-ID: <YjhdOUEG1RbWDApX@ncase>
References: <cover-0.5-00000000000-20220317T171618Z-avarab@gmail.com>
 <CAFQ2z_M7-D4ZCJbj8JituTbR3d7ocRHd=ObdZUnmE=WD7qW0cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3QWIhuXuFwJcfkcy"
Content-Disposition: inline
In-Reply-To: <CAFQ2z_M7-D4ZCJbj8JituTbR3d7ocRHd=ObdZUnmE=WD7qW0cg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3QWIhuXuFwJcfkcy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 17, 2022 at 06:45:13PM +0100, Han-Wen Nienhuys wrote:
> On Thu, Mar 17, 2022 at 6:27 PM =C6var Arnfj=F6r=F0 Bjarmason
> <avarab@gmail.com> wrote:
> > Aside: It seems that the GIT_TRACE_REFS facility has been broken since
> > it was added, i.e. running the test site with e.g.:
> >
> >     GIT_TRACE_REFS=3D/tmp/log.txt make test
>=20
> I wasn't aware that this is even possible. I've only used it with
> GIT_TRACE_REFS=3D1
>=20
> I looked over your patches and they LGTM.

Seconded, the patches look good to me.

Patrick

--3QWIhuXuFwJcfkcy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmI4XTgACgkQVbJhu7ck
PpTjgg//eDM7G6a0RnXZN3tPzN4g9p/wo01xACvYuSv3FRPOs2h2u/gvjmlWnA3l
J2NAyefA7wZgdwAr9+68KUSPAnlxWr7l+RsV4W/se3+JxC9jzRwsZ/W0mxi/PK8V
U7I13/UhtV7xZtnkn41bm5LNOSpm9VMSO+hS7WyuuFdVx3PyRwUxJkyufj5kWhsM
kXvx28ausmnZuihwOoDymC0b8v6m/mKjcBadf5+IN2wjupHgcSu4QSJwL8AtsV/c
FYfBQ2ASp+p/VRIYwfTlkCRP1cQtN1MT1JRlX49sdMqgGdIIU+xsdZwH8c6n9tqe
2Mti28tyIWnMBZJHEkPNDBPXWEkmW96++hAzVOZoX1V3wAISJ5bt5Fm1WHtDW+96
mAH7nVTiQxiCFr5t6Khor4xPs2rD5Ha0Llwai1XnACzm5GPbvlhsCQHMyl5JiMZw
iBsgYLv1KBodIn7xhP9OqjFMHakK86D+7Bu9c5irX2kC1ppHtCuwXVQdZZDgPnl0
PZg5fpDlFbK6BPKFuS3W2OlgvAeORf2UNNQEGLMDSe9fG1lAlEB0p2lgix0rxXcS
coqHZxbGQQN+XEvk4QjMLx9SHireB2Dd4jpuXrMN/tF5QiPSnRkDR6mSJYmIQ7fp
52dHip4ZJMnryAUEEdynEES8+VJVjwFiSDdZLC5Vd7w/RGl3TKE=
=++FM
-----END PGP SIGNATURE-----

--3QWIhuXuFwJcfkcy--
