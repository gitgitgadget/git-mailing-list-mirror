Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDFC3E469
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="itxoD29F"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66FA9D
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:23:06 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id F086C5B091;
	Tue, 24 Oct 2023 21:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698182586;
	bh=n8cFdYFOhaVhXljFCgPVq/cAYsvbIZF0nej03f/+smM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=itxoD29FtxgGS5NgU44JZF8TkLQE5X8iWkgnXdUkXoFSYOMion5HMAeUzSsheNI2J
	 HWmX+nSqXtwlyOjfxk7dTtUiZwJzP+vJTS/j+EkzwMzmcEcUnlXv7+UbC0bDOSD271
	 C61e3PnKBrfq1Xf2dmgtHDKTzNzAvBy52XU2RhD0B0EbbHfokLkh4hCL7HdQDd3peI
	 +7zUDO4NV0TiI03oqW3Kuu306pK/9alkWbDeXDn45R/hxxKqWzQz8f+pXoSMy+7+K+
	 ebZ7gbCJ31ZWy6quTPFw6gT/jS5FvbxUNhXScRZ6aq1et8yP4rAHKPpwTWIlbKrybq
	 /bylCSkZnXdCY2vZiv9JRj9eocYMQ2hBIThLuHWRa6URv/KlO4Mj4QwrCvh8x9IzG9
	 bAWubhokG2NIjl+wwdq4+aPmktZbKZ9gZyIaZuWya9T62iQ30Czxd0rpgFcOnpG9Vw
	 fmhA4dFT6QcNktFVzglYVngKuGgUAl2DPvPuzTXdPtbokrFEUpY
Date: Tue, 24 Oct 2023 21:23:03 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/1] merge-file: add an option to process object IDs
Message-ID: <ZTg1t33cxzvmvAVK@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
 <20231024195655.2413191-2-sandals@crustytoothpaste.net>
 <CAPig+cT_yq-ke4RTpTdTTLsnJFxCtyGAP2K0mQ_S23jJYtUp=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z7c6CkcE95GBSGVS"
Content-Disposition: inline
In-Reply-To: <CAPig+cT_yq-ke4RTpTdTTLsnJFxCtyGAP2K0mQ_S23jJYtUp=w@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--z7c6CkcE95GBSGVS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-10-24 at 20:12:52, Eric Sunshine wrote:
> On Tue, Oct 24, 2023 at 3:58=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > git merge-file knows how to merge files on the file system already.  It
> > would be helpful, however, to allow it to also merge single blobs.
> > Teach it an `--object-id` option which means that its arguments are
> > object IDs and not files to allow it to do so.
> >
> > Since we obviously won't be writing the data to the first argument,
> > either write to the object store and print the object ID, or honor the
> > -p argument and print it to standard out.
> >
> > We handle the empty blob specially since read_mmblob doesn't read it
> > directly, instead throwing an error, and otherwise users cannot specify
> > an empty ancestor.
> >
> > Signed-off-by: brian m. carlson <bk2204@github.com>
> > ---
> > diff --git a/builtin/merge-file.c b/builtin/merge-file.c
> > @@ -99,20 +116,29 @@ int cmd_merge_file(int argc, const char **argv, co=
nst char *prefix)
> >         if (ret >=3D 0) {
> > -               const char *filename =3D argv[0];
> > -               char *fpath =3D prefix_filename(prefix, argv[0]);
> > -               FILE *f =3D to_stdout ? stdout : fopen(fpath, "wb");
> > +               if (object_id && !to_stdout) {
> > +                       struct object_id oid;
> > +                       if (result.size)
> > +                               write_object_file(result.ptr, result.si=
ze, OBJ_BLOB, &oid);
>=20
> Should this be caring about errors by checking the return value of
> write_object_file()?

Probably so.  I think I saw write_object_file_prepare returned void and
misinterpreted that as write_object_file returning void.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--z7c6CkcE95GBSGVS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZTg1twAKCRB8DEliiIei
gbmsAQDABKWV//nmuYFIJsssqeLau4IKe7WG5H85cnUOKlDqzgD/b8MnZMvg6O9Y
mVOvbM8uTMn5EK2APokxH3IXV2F4MAA=
=n61q
-----END PGP SIGNATURE-----

--z7c6CkcE95GBSGVS--
