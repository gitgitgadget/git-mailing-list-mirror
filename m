Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D4BB201A7
	for <e@80x24.org>; Fri, 12 May 2017 22:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932166AbdELWHK (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 18:07:10 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39462 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751574AbdELWHJ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 12 May 2017 18:07:09 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 41636280AD;
        Fri, 12 May 2017 22:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494626828;
        bh=u8N3AxLRVpmxhgPok7r6ryD2605MMTmvB46vJX1Svgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1XL2/goMzOeWNqE4zflkJ2kS6o7ZsquwrrldoDt3kKPwIKEiP2l2f0Rj5JbwF5scc
         T6OJpIfkiaT+9wdEc3orbv5sxI6eqB60JS+Bu2GUj5he8Z4c6ybNaYgDZZay6/uhkL
         52hq32yFlVeAPC+mBtxLIUj7DDrgt75gWa3DXPUbbccPTRiAhlJ31PgXO6w/i6QbXv
         mCkSiB5IhtGwG2e84tp4oogct6vzKZjL5MJtvHE1DkgVTNblDB8Q79XmRxNQcvjPr9
         JpB4jdlMJlrbkWVKtfVyrAjU6dvubDP08uRSRbX9sUpPseaKkACM9BSM/2sDcVJ4iP
         1FhIGM0t31aje/60pS6x3yyA0/DAMVXCD8GqBjw589chSKbIvuN4GpLwPz4Qk8ps5R
         GhJ/SvivwNlUP1AAryGZLK9MXPGbC2VdL77FFkYWSEYLxuGcwsu7EvRRV5ivxyJkmh
         BWE0Er7v+R++LIB/zCZ9vLdmGVx/UnjVShhd8O6AlTUD9KWlat8
Date:   Fri, 12 May 2017 22:07:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/log: honor log.decorate
Message-ID: <20170512220704.txmdk45s66aqhexi@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20170512213407.46251-1-sandals@crustytoothpaste.net>
 <CAMMLpeTYvK+yow8R83Yf-kOFOZngFEfYsoQeXuTOL0tZOE3XTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tlcgckjpxu3oxzi4"
Content-Disposition: inline
In-Reply-To: <CAMMLpeTYvK+yow8R83Yf-kOFOZngFEfYsoQeXuTOL0tZOE3XTA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tlcgckjpxu3oxzi4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2017 at 04:03:04PM -0600, Alex Henrie wrote:
> > diff --git a/builtin/log.c b/builtin/log.c
> > index b3b10cc1e..304923836 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -34,7 +34,7 @@ static int default_abbrev_commit;
> >  static int default_show_root =3D 1;
> >  static int default_follow;
> >  static int default_show_signature;
> > -static int decoration_style;
> > +static int decoration_style =3D -1;
> >  static int decoration_given;
> >  static int use_mailmap_config;
> >  static const char *fmt_patch_subject_prefix =3D "PATCH";
> > @@ -410,7 +410,7 @@ static int git_log_config(const char *var, const ch=
ar *value, void *cb)
> >                 if (decoration_style < 0)
> >                         decoration_style =3D 0; /* maybe warn? */
> >                 return 0;
> > -       } else {
> > +       } else if (decoration_style =3D=3D -1) {
> >                 decoration_style =3D auto_decoration_style();
> >         }
> >         if (!strcmp(var, "log.showroot")) {
>=20
> Sorry for the mistake. On second thought, I think we should set
> decoration_style =3D auto_decoration_style() in init_log_defaults.

I can do that.  Patch forthcoming shortly.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--tlcgckjpxu3oxzi4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.20 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlkWMgcACgkQv1NdgR9S
9ovLfxAAiOJnt/Zn26t6bzMVVPjkmGNG9pL7tqvJtKOX6ljdx2dE1N0qnALn6BkQ
wurKplhS5NJWMcl45rxLdPpRIDeliEjW/EDTNEttjHn5QGuRtS5lie6DfKFqMItJ
36Sy/uFnQ4fSIgclF8Ujofg2fHWdzpOfqMd2KVA9VDe8mqFI7q+3R/Q84D460psN
5Tnw0KQlStEP6AFQVlho5oL6a8hSDmzP6wubyWX/JrwdfS7/hwauWzjrie4ykK/e
UYBQ/WXqRgew3ScoF7TUnxxl1G68HWWg2bec/pQoQ5rROpOhUmj8nP1BZ4OboFqc
bfocTUA373H7PR18iZhZRxfuRgjNwuDmHBh7keFe2sHhtHXZ1a0+quMAcVzajYNO
bltzs8Es0Zbbo4w8c+ThcCwwlNw1yzeUZdRni/63PzHQGXhjA7IJCguYJZ7Q/gND
Mvkv2/p+HWBnncxGOqMG9mBpCbXJlKXh4/LSUTRVLrKN4Kt0MOTxxBjKkJ+h7Czv
rMxzGO94TtZg6gFVe8x5RS4BQjfygDNhk81LpmGRCzDsLLq/lfmpRfXK8CUtU92A
932kXt7zickZg54Z5bb9Lj0ifXw7kVi56j8XNhFjc2NACjj7gfQsqpVRJsQiQWX7
2NtSdp2nPCBPG0G8BDZklj/X3u+rEQ6v0/FXaGANUUploDB04OM=
=qvHO
-----END PGP SIGNATURE-----

--tlcgckjpxu3oxzi4--
