Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9836C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D160561246
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbhDSLDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:03:10 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:56837 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238515AbhDSLDD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 07:03:03 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 989FDD28;
        Mon, 19 Apr 2021 07:02:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 07:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=FsXR7hZe8YDbIuT+vSagiEPnW9D
        0PH7nmqoeotjXMnQ=; b=kUnayF3VTWFuMX9WyCDeMacEjjb6b2TqQVHHhg7cuNv
        CTOmQPzGb0tw9Xu0MSdmBL/Vw/aNcb1t0oSKE3KN+XqMIZ+XS4gV26bHlN99Rl8c
        +LqrygM7Wr8jgHZ2DIvSHRc50K0U6hqQpliflzgeH3AmQYdTKh4C+14CYVTf+YnG
        K5qrxGoFIZYUgwXcdV4YXWqjyCYmOTw+YeReUtnHlNC8z0I3YwwFRSII5vUhHkgb
        RPsun5u4lJ50idt/LSk9QHGm3ko6IHqhzt7qgmj/yeFaRPuBRKfMGABypubkN4cH
        e9eF83kKqpfnXYu9Tgmqy266epqidLtFWnoSt5Qnb8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=FsXR7h
        Ze8YDbIuT+vSagiEPnW9D0PH7nmqoeotjXMnQ=; b=bIX1F8/lci+u6okDnG3jxz
        Zg+Iv9qOvv9cvcgJ+Kl+6AiSDiRvqtxUw5h1HdsmeF2RaIoOtW0R+mh9sEoq4O1c
        CBCIt3OO1wA6TmJoQTg+2tQwkwsjaS5j1MAOOXU+FKX2pBCrGhczRKazs6cH2e30
        E0c230v038sQl3+yAVeS5lEih5Gn098YRZv/HBvZSlasPHY6QFW0JJ9QxEBrBPli
        TPkxYsU7LOzTxjThFlJv6U9XIuam/vYBbDa7AFAmoksouzDW8yffVtbTcB/3Yke6
        9Q90RLB8+C5qdovCJUZuqJ7ujINxkrsMNjSNmYuT3rRvgb9rPaMIz9GQ6XD1ZJqQ
        ==
X-ME-Sender: <xms:RmN9YJ28uQ7gFQdySDWUfWwiT2mvYuS8wPHPFpIOTf-5gnEyRICOyg>
    <xme:RmN9YAF5PHOwNxbOiohHKiMzRESPYPuhXtQDumlQ2OCKdWXn1ukJkhkpUCIwme149
    ikvKeRQIY1E0DH1pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtffejieduudelhedvgfetieefleehjeetvdetudeitdetvddtfffffefhvdfggfen
    ucfkphepjeejrdduledurdeikedrkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:RmN9YJ7DwsfHQ_fuMKXrPStgim8K5n0iLgwaQC-eGvW9IbDvK1T5BA>
    <xmx:RmN9YG2qOKjt5O5xS2r-iJhvyrUM3NIcUIqc6Oy4JySNIVusdfAh_Q>
    <xmx:RmN9YMFC_mcY7pqf2KGXmax2ETyUedH5gIYkIG6d8NcwSalELL5CEg>
    <xmx:R2N9YACFgNd-etAyop9bsMZPByslz4FszVW5oVZfxtuFKrztsRa5Zw>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5B28B108005B;
        Mon, 19 Apr 2021 07:02:29 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ef8deaa5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 11:02:26 +0000 (UTC)
Date:   Mon, 19 Apr 2021 13:03:56 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/3] config: rename `git_etc_config()`
Message-ID: <YH1jnIhuF4UjXVNW@tanuki>
References: <cover.1618238567.git.ps@pks.im>
 <cover.1618297711.git.ps@pks.im>
 <34bdbc27d618d7467d2caf6844d8c06bdcb8545b.1618297711.git.ps@pks.im>
 <20210416211451.GP2947267@szeder.dev>
 <YHqf9zjSzpYl7IAW@coredump.intra.peff.net>
 <xmqq7dl0d23g.fsf@gitster.g>
 <YHvGE5/LRPN9obZi@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jf/PmI7MrXZa4WRZ"
Content-Disposition: inline
In-Reply-To: <YHvGE5/LRPN9obZi@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jf/PmI7MrXZa4WRZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 18, 2021 at 01:39:31AM -0400, Jeff King wrote:
> On Sat, Apr 17, 2021 at 02:37:39PM -0700, Junio C Hamano wrote:
>=20
> > Jeff King <peff@peff.net> writes:
> >=20
> > > On Fri, Apr 16, 2021 at 11:14:51PM +0200, SZEDER G=E1bor wrote:
> > >
> > >> > @@ -1883,6 +1880,7 @@ static int do_git_config_sequence(const stru=
ct config_options *opts,
> > >> >  				  config_fn_t fn, void *data)
> > >> >  {
> > >> >  	int ret =3D 0;
> > >> > +	char *system_config =3D git_system_config();
> > >> >  	char *xdg_config =3D xdg_config_home("config");
> > >> >  	char *user_config =3D expand_user_path("~/.gitconfig", 0);
> > >> >  	char *repo_config;
> > >> > @@ -1896,11 +1894,10 @@ static int do_git_config_sequence(const st=
ruct config_options *opts,
> > >> >  		repo_config =3D NULL;
> > >> > =20
> > >> >  	current_parsing_scope =3D CONFIG_SCOPE_SYSTEM;
> > >> > -	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R=
_OK,
> > >>=20
> > >> Removing git_config_system() from the condition breaks
> > >> GIT_CONFIG_NOSYSTEM:
> > >
> > > Good catch. My gut feeling is that the new git_system_config() should
> > > check NOSYSTEM and return NULL if it's set, and then we can get rid of
> > > git_config_system() entirely.
> >=20
> > NULL -> /dev/null I guess?
>=20
> I was thinking NULL to catch this line from the post-image of Patrick's
> series:
>=20
>           if (system_config && !access_or_die(system_config, R_OK,
>                                               opts->system_gently ?
>                                               ACCESS_EACCES_OK : 0))
>                   ret +=3D git_config_from_file(fn, system_config, data);
>=20
> which would see that we have no file at all. But that may be unexpected
> for other callers (right now git_etc_gitconfig() can never return NULL,
> and I'm not sure what would happen with "git config --system"; I suspect
> it would do the regular config sequence instead, which is wrong).
>=20
> So yeah, probably returning /dev/null is more sensible (and makes it a
> true alias for GIT_CONFIG_SYSTEM=3D/dev/null).
>=20
> -Peff

It's only by accident that I dropped the call to `git_config_system()`,
must've happened when resolving conflicts somewhere. The issue with just
returning `/dev/null` from `git_system_config()` is that git-config(1)
would be broken, as you hint at. We do not honor GIT_CONFIG_NOSYSTEM
there if the "--system" flag was given.

So yes, we could change it to return `/dev/null`, but that would change
semantics of GIT_CONFIG_NOSYSTEM. I'm not sure doing this in the same
series is a good idea. Even more so because with returning `/dev/null`,
the conversion would be silent: whereas previous versions simply wrote
to or read from the system-level config, we now pretend to have read or
written something even though we didn't.

Patrick

--jf/PmI7MrXZa4WRZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9Y5sACgkQVbJhu7ck
PpTudxAAoROwUwT1tNO4LaUFN3Rt8ZTLcz/Hf+05jJivTWLWVdFwBe5QqpvmyP9J
YQhEIbR+6pJPDEOQZIxZTyr/wsxwSBtDjrS5l/WIkJoJg/1ZkrrgGtruQV/Ej8+5
aPzXkkLIPdcMQHf1PuyotqkdhLGB8tDWjD4J8DqmrpQndjqrGE4qG+oAVu5ZYaRQ
4TrRKjtqDYqrNnFroa4r2e3m18xXSC6tIqW2iMvq40p52+r06kAWfConSQKJhdlG
jZSKr/j9vEQh+dcLjFjpk3yqNh95w6/cSEuAAaGmJ8mDiXSnVuNHdvo5cT9Tpo37
S7ub09UGsyh1CxGUenKK60OzgSw++sea3p0m5ad38kHwwbeCntzRc8eN4SlruwDO
fShEUT5O9TmaX/6Bu1F6CATlUeO1Yog66Z0/h7iEh2M1QKA6ATIzYC4xMzJo/+DY
wI6uplW7ump77hGnLMoq29D1sfMHp6Cz5k/54GuxQLMpQt6CsB+tqAazzuGkoCmJ
m8kFon/EDofgrNL/Ov+CYihzQXeenGGnQ4Yj04SYGelZ6zz+/MKDz4gcsDxg4wLP
xyJpO3At7PiyU4tLc6z4ErTDtgBj3ggN84VgEj/9kYrXGp7ggR+46bnfFekLUX4A
0obxdzloePBRY7xyvBzVi49yLjMtOCZcCf6NRo8rRHZKQ1VI5xw=
=UMXG
-----END PGP SIGNATURE-----

--jf/PmI7MrXZa4WRZ--
