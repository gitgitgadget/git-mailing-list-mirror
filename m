Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF47621CFEF
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515801; cv=none; b=CQEdq8p32aHxVC/GFMVEUrFiEP2mn1iFaUzZGrxKGIOmCNMuHIZjkgiy6ormYk16Cs5VwamGrg4QWCT0BFMkccfsVsI9p2rPuK2/Bv+wB36Euwj+l20I84yuXrdZz8z9XaTG4sQtxbB+9uW8PSA9tUJdn3EGrr314DmfOxNR2dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515801; c=relaxed/simple;
	bh=IYCKunSER3IAxSA2wUNnbfq3aDrFP7xGLqQ1YRZHRck=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P34q6t5zxO//cabT1Yupco2BN5lgqS2Nu7fl0dFRShcHkK7NQiVByQyJ6pBE+xdZSORDiNVwtaa5nzQcoiK0JQsAznqLBGM2ohrGKVl9uXxEIJJJcN/0qx1FEetR35msjUCk6u431cq1WKzJf4f8AmkKGttb4IuTV6r38eBUi3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=eqyT71PQ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="eqyT71PQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781515794; x=1782120594;
	i=johannes.schindelin@gmx.de;
	bh=fXh1sOw46+J0DAfVrwu2xIq6Yfu2Q9xhpS/A2psTxaQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eqyT71PQlILheMCOihJeQ6a7n2D8bkBZkMAA9JeIX3Nly173qPC9qwWkckppcmZJ
	 2kfk3NoCIfK7ANMXvFR9TLmkYWW3rio6pBfkaa/AE6arPNhiQvf3H+tjNCuBKsP4p
	 nRTOyyIDDqyb4bggx+fOAYJda6imF0hW8pp62iGCauYdzxHsRC8fL9Eq2nLWbpl8P
	 W7MSiQZ2EN4HMawufw4mDjCDTanCR0sDU48NH497kMpXBAaSGGr5Rgd/TI/Pp4QEf
	 nJv0Spcm2qs4dg3Du/vlAkwCQgHMpYGaI3ot6i6nKUD1N3e3e0j3Le78Nzxj305EZ
	 zjr4KeT5fRhUJkV6Yg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm6L-1wRgzJ2C0R-00FGid; Mon, 15
 Jun 2026 11:29:54 +0200
Date: Mon, 15 Jun 2026 11:29:53 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 7/7] odb: use size_t for object_info.sizep and the size
 APIs
In-Reply-To: <aibJZ8EXoQSD2lsB@pks.im>
Message-ID: <d82abb94-1720-ba15-15b6-e1a9ac28b0aa@gmx.de>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com> <f3aeae983ac8b281d6ba54299961e19d16699c94.1780570273.git.gitgitgadget@gmail.com> <aibJZ8EXoQSD2lsB@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:QE1pKwEhlBBN7IPPn3HjwUt1MzBkma9Yd/yCpXkX8NeKYOR7g86
 VyaOM62j+QR9lTzFL4hq1jCIlRGYT6VVNeLQjMsxGuGdR1lhGGrspHBykNgU2fhnT9/Sqoi
 DAxH8kNFe/LivQfFyB0mWeGiZNBCXtRViWbBkChMrD8Kg4KMqh0ZaP+3WI8SGXzEZwtkcIu
 qQAda/bn7PSPom6+fIO3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JWexDXzDRnw=;3HVSqk+PBZaqFPaIWDkRDx3WO44
 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
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, 15 Jun 2026, Patrick Steinhardt wrote:

> On Thu, Jun 04, 2026 at 10:51:12AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index fa45f774d7..fa6e396ddc 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -120,7 +120,7 @@ static int cat_one_file(int opt, const char *exp_t=
ype, const char *obj_name)
> >  	struct object_id oid;
> >  	enum object_type type;
> >  	char *buf;
> > -	unsigned long size;
> > +	size_t size;
> >  	struct object_context obj_context =3D {0};
> >  	struct object_info oi =3D OBJECT_INFO_INIT;
> >  	unsigned flags =3D OBJECT_INFO_LOOKUP_REPLACE;
> > @@ -166,7 +166,7 @@ static int cat_one_file(int opt, const char *exp_t=
ype, const char *obj_name)
> >  		if (use_mailmap && (type =3D=3D OBJ_COMMIT || type =3D=3D OBJ_TAG))=
 {
> >  			size_t s =3D size;
> >  			buf =3D replace_idents_using_mailmap(buf, &s);
> > -			size =3D cast_size_t_to_ulong(s);
> > +			size =3D s;
> >  		}
> > =20
> >  		printf("%"PRIuMAX"\n", (uintmax_t)size);
>=20
> Can't we drop this local variable completely and instead supply `&size`
> directly?

Well spotted!

> > @@ -219,7 +225,7 @@ static int cat_one_file(int opt, const char *exp_t=
ype, const char *obj_name)
> >  		if (use_mailmap) {
> >  			size_t s =3D size;
> >  			buf =3D replace_idents_using_mailmap(buf, &s);
> > -			size =3D cast_size_t_to_ulong(s);
> > +			size =3D s;
> >  		}
> > =20
> >  		/* otherwise just spit out the data */
> > @@ -266,7 +272,7 @@ static int cat_one_file(int opt, const char *exp_t=
ype, const char *obj_name)
> >  		if (use_mailmap) {
> >  			size_t s =3D size;
> >  			buf =3D replace_idents_using_mailmap(buf, &s);
> > -			size =3D cast_size_t_to_ulong(s);
> > +			size =3D s;
> >  		}
> >  		break;
> >  	}
> > @@ -446,7 +455,7 @@ static void print_object_or_die(struct batch_optio=
ns *opt, struct expand_data *d
> >  		if (use_mailmap) {
> >  			size_t s =3D size;
> >  			contents =3D replace_idents_using_mailmap(contents, &s);
> > -			size =3D cast_size_t_to_ulong(s);
> > +			size =3D s;
> >  		}
> > =20
> >  		if (type !=3D data->type)
>=20
> Likewise for these three instances.

I totally agree.

> > @@ -555,7 +564,7 @@ static void batch_object_write(const char *obj_nam=
e,
> >  			if (!buf)
> >  				die(_("unable to read %s"), oid_to_hex(&data->oid));
> >  			buf =3D replace_idents_using_mailmap(buf, &s);
> > -			data->size =3D cast_size_t_to_ulong(s);
> > +			data->size =3D s;
> > =20
> >  			free(buf);
> >  		}
>=20
> And I think this site here can be adapted, as well.

Indeed!

> > diff --git a/diff.c b/diff.c
> > index 5a584fa1d5..816b89dc6c 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -4594,8 +4594,9 @@ int diff_populate_filespec(struct repository *r,
> >  		}
> >  	}
> >  	else {
> > +		size_t size_st =3D 0;
> >  		struct object_info info =3D {
> > -			.sizep =3D &s->size
> > +			.sizep =3D &size_st
> >  		};
> > =20
> >  		if (!(size_only || check_binary))
> > @@ -4617,6 +4618,7 @@ int diff_populate_filespec(struct repository *r,
> >  			die("unable to read %s", oid_to_hex(&s->oid));
> > =20
> >  object_read:
> > +		s->size =3D cast_size_t_to_ulong(size_st);
> >  		if (size_only || check_binary) {
> >  			if (size_only)
> >  				return 0;
> > @@ -4631,6 +4633,7 @@ object_read:
> >  			if (odb_read_object_info_extended(r->objects, &s->oid, &info,
> >  							  OBJECT_INFO_LOOKUP_REPLACE))
> >  				die("unable to read %s", oid_to_hex(&s->oid));
> > +			s->size =3D cast_size_t_to_ulong(size_st);
> >  		}
> >  		s->should_free =3D 1;
> >  	}
>=20
> The flow in this function is quite weird if you ask me, but that's a
> preexisting issue. This does look correct to me, even if it's awkward.

Yes, on all four accounts.

Ciao,
Johannes
