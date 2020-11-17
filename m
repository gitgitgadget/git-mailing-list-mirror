Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB1AC2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 06:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C497C223BD
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 06:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LQ6FpRMO";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EY9x94u5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgKQG26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 01:28:58 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54927 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbgKQG26 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Nov 2020 01:28:58 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D01065C018C;
        Tue, 17 Nov 2020 01:28:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 17 Nov 2020 01:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=/JThfRUOlbyA/aua52WXacuOEG0
        jyD0HGUAZq+NfG4Y=; b=LQ6FpRMOH4e6FC7glOqU9VGl4zvoEbPdWirqa/5chFJ
        AvN83fa2QfPEm4pHsVxE+1GkFkusc6LK0+2dL5Pt+zN/FTSRB/09/FLRgrxPhesK
        YK5uL93VIo7h7HB9ELUWnvgO5HmwoLDrNXRgJuBhNSo8HJLK3Sxt+vfn4Avr4EBa
        lK/agbrxbzEkOQ037mwdhv3DTCEu20qg5VylfaIolsziZHAWLWwY+kzBTc72IaEs
        z4IRhVcE5oZ8saqpChGWxPqT+q94EB9sf8NjM7+3Oi8bgO9popzYxzeqQY9JCUXd
        S7VMBRYrdtcRcj0/SrMC8v9l9YOexyicBNJVDQNGJsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/JThfR
        UOlbyA/aua52WXacuOEG0jyD0HGUAZq+NfG4Y=; b=EY9x94u5DNuVjdkUvuj1pd
        1hrqwFrG01fuNTThxpXDJCy+Q/eCwSi4CkREzo3NouQdvkwhR8MFH4fjIHuELjjy
        oCjOAz/tkLUJYr36E738oWoexetvdQxj8VBvVTJN5fMoQWSamCfVpgd60t06VqFe
        4jdm4Wok9DTGAs47bAmZHNGxk6WSE723KsxJLyQZMfx7yWdsnUhHY32bHSWYmteU
        gCse2Gf1HCJs1lQwKulsB74CQsnPSu+aUmZCHev6ujyEORWuga21YUnDA/zYGtas
        zorxBUbbxi63DTc3TyJK57demIwOEblWvcYQSl0Uv3/2Wbf49t5aji7CbT4Ry52w
        ==
X-ME-Sender: <xms:qG2zX6MRqmeuOsLmtXd86Rc1J6OU8azhORlNtrh59k3xuG-QE8pj1w>
    <xme:qG2zX48QfNM-LW1NpLtxcu2rE7zbNh418RenYUDZaNeRYNP3SwWsj-OENaKcbx4zO
    tPIqHMKQGb5JwaYmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefvddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnheptdffjeeiudduleehvdfgteeifeelheejte
    dvteduiedttedvtdffffefhfdvgffgnecukfhppeekledrudegrdefuddrfeehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:qG2zXxTf57__BsIqe0YOvSM9WL1-DAYHxfsDor-xjuWc7Y8yhF50Jw>
    <xmx:qG2zX6tfeUtGeYYZKhbm92MOBCykDJp9ldcUcoAPAU7trLVAANV4EA>
    <xmx:qG2zXyciieZPL45Oioybj_wj84BWE2hLzruyJ3Krf8SBrMCnNCkb1w>
    <xmx:qG2zX6lKopJoQ3hBtq4_a_PhFQRj0Nx7S-GHQbJIuBAR98dpOxKXmg>
Received: from vm-mail.pks.im (dynamic-089-014-031-035.89.14.pool.telefonica.de [89.14.31.35])
        by mail.messagingengine.com (Postfix) with ESMTPA id CD5643064AB2;
        Tue, 17 Nov 2020 01:28:55 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 658cc1ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 17 Nov 2020 06:28:51 +0000 (UTC)
Date:   Tue, 17 Nov 2020 07:28:50 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar
 pairs
Message-ID: <X7NtovvfE7IjWzie@ncase>
References: <cover.1605269465.git.ps@pks.im>
 <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
 <87mtzlflw7.fsf@evledraar.gmail.com>
 <xmqqy2j1851k.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uVD24gFqNncOZ4l0"
Content-Disposition: inline
In-Reply-To: <xmqqy2j1851k.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uVD24gFqNncOZ4l0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2020 at 11:39:35AM -0800, Junio C Hamano wrote:
> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>=20
> > On Fri, Nov 13 2020, Patrick Steinhardt wrote:
> >
> >> While not document, it is currently possible to specify config entries
> >
> > "While not documented..."
> >
> >> +		strbuf_addf(&envvar, "GIT_CONFIG_KEY_%d", i);
> >> +		if ((key =3D getenv(envvar.buf)) =3D=3D NULL)
> >> +			break;
> >
> > The convention in git.git is to avoid explicit NULL checks. So maybe
> > something like this, which also avoids the assignment inside an "if"
> >
> >     key =3D getenv(envvar.buf);
> >     if (!key)
> >         break;
>=20
> All good suggestions, but...
>=20
> "While not documented" yes, for sure, but we do not document it for
> a good reason---it is a pure implementation detail between Git
> process that runs another one as its internal implementation detail.

Agreed

> I especially do not think we want to read from unbounded number of
> GIT_CONFIG_KEY_<N> variables like this patch does.  How would a
> script cleanse its environment to protect itself from stray such
> environment variable pair?  Count up from 1 to forever?  Run "env"
> and grep for "GIT_CONFIG_KEY_[0-9]*=3D" (the answer is No.  What if
> some environment variables have newline in its values?)

You only have to unset `GIT_CONFIG_KEY_1` as the parser will stop
iterating on the first missing key. More generally, if you set `n` keys,
it's sufficient to unset key `n+1`.

Patrick

--uVD24gFqNncOZ4l0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+zbaEACgkQVbJhu7ck
PpTYuQ//R4NphXKc3SDlIAXk3LAXopexmX64ei5/Y2URKI8m4Wq6TRA1Qqq8MnAn
wLQJ9mn6Eiq8aZemUW+yVDSO6/9zR5CjuibUOTz3vRzjplG8Y51pq429CRGg5hVI
Mniv0JXUCV+wbTdQDufmLme6iAZRNvrfyixkl1GNu37CM2izWv0tQsPk+NJAcjsu
szaroYEv8B6WP4JyjoyM9s5Zuh0YkpMbtwBV/2RxH+uSCLB5CgU2mspA7vtfviYm
KACb/PqT2FuUIKDb8m5HCQyfff687i8APvqTpZZpiYAe0T1hmRX+CDb+vFxUMi7B
1Ugi4Kkcn4SS8KM/yIhZOMM2mGe+YHTMMQ3jotM9MRZXtevWymExwNRSunVBJXw6
kxbE2q4K+R7VFxpDwKSthK3/IINm3qaDOqXmWf+9U9yn9WEr6WlI0iSNThpuC6Oh
7MsbKYwYLGKfzIvBhlvGeHjutFmeUNxPwD+rIyfgZ4Ol7Ff12bRtoig8XtE0+CyK
gJtrbCQnrYutqisNE/sKxg5SRPjmSdH3Ob1CiKR8rn++wNdZDzB3Se8KwA39Dkij
YbYQx0M7a3dEfuw0LL1a2jOvQxVmQR4bglcvYDvT4t6BeWLXUT7tpiLJutae32ji
0UwXKduzzkN5OuJv75tKZi9oGtBGcTtvbA9Y5g4AwvgFVKM+3BI=
=XuZd
-----END PGP SIGNATURE-----

--uVD24gFqNncOZ4l0--
