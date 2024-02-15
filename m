Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C4953369
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996116; cv=none; b=on1I86quuLii+71x5vauODLz7o6LcEwKxVXAx2pyLWCOIEGTXG60G4z5esvIE9FUUzsx1h53SuVxd9/dslmYuf6Rt252fgsi2kFtfGMEHy4KMRwS9sLGGOVCL4a+H2qrb2R20NaifrAAiR1rl4bXrFBunIwwwVwlUC8uJAFoZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996116; c=relaxed/simple;
	bh=Wmr+8O6sgaCefZWL7vPTbGS+SmOoF1incfOwoaV9iYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL8WzbpRvCynT9mqR5NjPBLue/zZ7cAoyvz6ExtHiPeeCWfcZ39WH0IriwVjEyFMk4C0kBrokb9rH3nfk5xHbX/jYsf24LIpSgjlOkwBDN8JSIj/z2twZRvJSNu2cDpXoWay2V8yrIKj8nO9k22vPqd0eG6VjrAz+0J7ZHCnldo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tdYoihwL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iuI558V1; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tdYoihwL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iuI558V1"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2A49711400B7;
	Thu, 15 Feb 2024 06:21:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 15 Feb 2024 06:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707996113; x=1708082513; bh=Gy1A+lAblb
	9iFz+QcbBa8Q7NiiZ5ciKd+6hKgTG4nLM=; b=tdYoihwL3pBN9+DWiFa9Vm++Lh
	gbYiy/XOOvKq0XSHeoZaofT/NZeyaPX1P93g/em+sCkwaDHUlSzkuIMUhEngaKS0
	ALAKMugubhPlJxens1xK4oXeE1wq8dGaEqHpiq4muk0g9ru9NZeC6HwA9EUNZFf9
	31PvqW3oIzYRFls4aEn7AFc2rFih8W1ttkg866PCWOBHTmoeCR256hRJ7NkzMpGd
	9RQ4gvkS+kmXPPLfMCXD1Go8DqW9ne7GYyDfbLs3Tb5wiUDscDJpUfsuB87OJ5Lm
	3KI0GQxOtKblQrvUG0owjDqE32BUIQQHcvcmt7G9uZJPr245lXgFkDgMaINA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707996113; x=1708082513; bh=Gy1A+lAblb9iFz+QcbBa8Q7NiiZ5
	ciKd+6hKgTG4nLM=; b=iuI558V1A4piOKqasfwfqE0eH15RZa6eeqtQS8HbyKZn
	+oLWAq+waM4BWU8nPCVUY5TvLh9781QyMbLch2vSEq0jV/ehFO2oTKD+R4xnqfyy
	dtP2FL2mO2hc91nHbkm/Z7N476LQqn8vkLxRtPE9QG4FKBiBQV24YMpScTs4h8E+
	OlRcVAHUbV/wBdUFKK/1Rti+9DV5Pceo+2V3y1kPWrRUd92PvnmSWVntbYIrGBsG
	CyLqLBVZ5x48J5jAuk7i/t2hwZKaiSsRFnkzWh9/TRbXTA5en+Hd35vdBmkhWmFb
	FgWlf/BPU1YjTEc3Ti2aduD/rNDRWs7GBbiT734CQg==
X-ME-Sender: <xms:0PPNZWCuhQCtpK-9LphA90_QkHXBU4uZkEfoBpDqfa-zqk2odZQPZw>
    <xme:0PPNZQibC5yge7czaaoBSwj7r-pyBYZpq_wb8V9DvaJ2P_X7odJQV-PeQEXxVcgxh
    sFR1sqz9SuzOFnDYQ>
X-ME-Received: <xmr:0PPNZZmK-rDMk67lA3-YURnhFxhJlNhu4J3oZjLUMdKLQ8ReqFcjIc-TpVz5zr__hFlfxDo0CWZ7kRByIvuUWLAvMExbGiKmU0H2ZcRinXMM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:0PPNZUzlISsemvxJDLzIXk9Gmq96Vnnnb2iUyRwvTqRKKXUnRsxUIg>
    <xmx:0PPNZbStxFfE6sDluc4d2dWOGa2V-SVu0nRt77CNFX9XNicP1ZvZYg>
    <xmx:0PPNZfZJpM0zXF7IOZ2D7G-jTW0Ui3j0QTmr4XeraCp4mKmutkSgBA>
    <xmx:0fPNZaFrO9z1QWdZjwlBUwSYCrL70W4jjJ0vN5IM4prBj_FwUPruUg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 06:21:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d33a749d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 11:17:56 +0000 (UTC)
Date: Thu, 15 Feb 2024 12:21:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "Eric W. Biederman" <ebiederm@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2 01/30] object-file-convert: stubs for converting from
 one object format to another
Message-ID: <Zc3zyi42slXWGJTC@tanuki>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
 <20231002024034.2611-1-ebiederm@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0d2jsmHzWzUs0dl1"
Content-Disposition: inline
In-Reply-To: <20231002024034.2611-1-ebiederm@gmail.com>


--0d2jsmHzWzUs0dl1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 09:40:05PM -0500, Eric W. Biederman wrote:
> From: "Eric W. Biederman" <ebiederm@xmission.com>
>=20
> Two basic functions are provided:
> - convert_object_file Takes an object file it's type and hash algorithm
>   and converts it into the equivalent object file that would
>   have been generated with hash algorithm "to".
>=20
>   For blob objects there is no conversation to be done and it is an
>   error to use this function on them.
>=20
>   For commit, tree, and tag objects embedded oids are replaced by the
>   oids of the objects they refer to with those objects and their
>   object ids reencoded in with the hash algorithm "to".  Signatures
>   are rearranged so that they remain valid after the object has
>   been reencoded.
>=20
> - repo_oid_to_algop which takes an oid that refers to an object file
>   and returns the oid of the equivalent object file generated
>   with the target hash algorithm.
>=20
> The pair of files object-file-convert.c and object-file-convert.h are
> introduced to hold as much of this logic as possible to keep this
> conversion logic cleanly separated from everything else and in the
> hopes that someday the code will be clean enough git can support
> compiling out support for sha1 and the various conversion functions.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  Makefile              |  1 +
>  object-file-convert.c | 57 +++++++++++++++++++++++++++++++++++++++++++
>  object-file-convert.h | 24 ++++++++++++++++++
>  3 files changed, 82 insertions(+)
>  create mode 100644 object-file-convert.c
>  create mode 100644 object-file-convert.h
>=20
> diff --git a/Makefile b/Makefile
> index 577630936535..f7e824f25cda 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1073,6 +1073,7 @@ LIB_OBJS +=3D notes-cache.o
>  LIB_OBJS +=3D notes-merge.o
>  LIB_OBJS +=3D notes-utils.o
>  LIB_OBJS +=3D notes.o
> +LIB_OBJS +=3D object-file-convert.o
>  LIB_OBJS +=3D object-file.o
>  LIB_OBJS +=3D object-name.o
>  LIB_OBJS +=3D object.o
> diff --git a/object-file-convert.c b/object-file-convert.c
> new file mode 100644
> index 000000000000..4777aba83636
> --- /dev/null
> +++ b/object-file-convert.c
> @@ -0,0 +1,57 @@
> +#include "git-compat-util.h"
> +#include "gettext.h"
> +#include "strbuf.h"
> +#include "repository.h"
> +#include "hash-ll.h"
> +#include "object.h"
> +#include "object-file-convert.h"
> +
> +int repo_oid_to_algop(struct repository *repo, const struct object_id *s=
rc,
> +		      const struct git_hash_algo *to, struct object_id *dest)
> +{
> +	/*
> +	 * If the source algorithm is not set, then we're using the
> +	 * default hash algorithm for that object.
> +	 */
> +	const struct git_hash_algo *from =3D
> +		src->algo ? &hash_algos[src->algo] : repo->hash_algo;
> +
> +	if (from =3D=3D to) {
> +		if (src !=3D dest)
> +			oidcpy(dest, src);
> +		return 0;
> +	}
> +	return -1;
> +}

In it's current form, `repo_oid_to_algop()` basically never does
anything except for copying over the object ID because we do not handle
the case where object hashes are different. I assume this is intended,
as we basically only provide stubs in this commit. But still, it would
help to document this in-code as well with a comment.

> +int convert_object_file(struct strbuf *outbuf,
> +			const struct git_hash_algo *from,
> +			const struct git_hash_algo *to,
> +			const void *buf, size_t len,
> +			enum object_type type,
> +			int gentle)
> +{
> +	int ret;
> +
> +	/* Don't call this function when no conversion is necessary */
> +	if ((from =3D=3D to) || (type =3D=3D OBJ_BLOB))
> +		BUG("Refusing noop object file conversion");

The extra braces around comparisons are unneeded and to the best of my
knowledge not customary in our code base. Also, error messages should
start with a lower-case letter.

> +	switch (type) {
> +	case OBJ_COMMIT:
> +	case OBJ_TREE:
> +	case OBJ_TAG:
> +	default:
> +		/* Not implemented yet, so fail. */
> +		ret =3D -1;
> +		break;
> +	}

It's a bit weird that we handle all object types except for blobs
separately, and then still have a `default` statement. I would've
thought that we should handle the object types specifically and set `ret
=3D -1` for all of them, and then the `default` case would instead call
`BUG()` due to an unknown object type.

> +	if (!ret)
> +		return 0;
> +	if (gentle) {
> +		strbuf_release(outbuf);
> +		return ret;
> +	}

Do you really intend to call `strbuf_release()` on the caller provided
buffer, or should this rather be `strbuf_reset()`? Memory management of
such an in/out parameter should typically be handled by the caller, not
the callee.

> +	die(_("Failed to convert object from %s to %s"),
> +		from->name, to->name);
> +}

The error message should start with a lower-case letter.

> diff --git a/object-file-convert.h b/object-file-convert.h
> new file mode 100644
> index 000000000000..a4f802aa8eea
> --- /dev/null
> +++ b/object-file-convert.h
> @@ -0,0 +1,24 @@
> +#ifndef OBJECT_CONVERT_H
> +#define OBJECT_CONVERT_H
> +
> +struct repository;
> +struct object_id;
> +struct git_hash_algo;
> +struct strbuf;
> +#include "object.h"
> +
> +int repo_oid_to_algop(struct repository *repo, const struct object_id *s=
rc,
> +		      const struct git_hash_algo *to, struct object_id *dest);
> +
> +/*
> + * Convert an object file from one hash algorithm to another algorithm.
> + * Return -1 on failure, 0 on success.
> + */
> +int convert_object_file(struct strbuf *outbuf,
> +			const struct git_hash_algo *from,
> +			const struct git_hash_algo *to,
> +			const void *buf, size_t len,
> +			enum object_type type,
> +			int gentle);

It would be nice to document what `gentle` does.

Patrick

> +#endif /* OBJECT_CONVERT_H */
> --=20
> 2.41.0
>=20

--0d2jsmHzWzUs0dl1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXN88kACgkQVbJhu7ck
PpQ0xw/7BgkaiZO0akew+EkRrzz3wlXk7Pobm1nAzYZTvlaZA/d+BnahUBcEqaCD
0Abcoo1f67TXFBjm8S98/GmgDiGD2WfkUSXdJ7JciKyjih29ScqqaIX7w0e6exNV
0PYTm52m+VXONdvujuwbn922HQOLWRwwMBdc/rBBmi4GCmAmlEM2n/097+sJyjEB
N4BrtX0+GrX1XYPkfilo1tGgi0mDwgUd1M6SpWOqg3eXYxNZlLvczDtWE3Y0/w3G
JeMA7QH/8vN8buhCgz3LymbgzGBetKZc8azLm0+QiZlnaBnCBQuUrHjV7cwNJUcp
1kw9lZ4fgLIfuaaBUkX16FAf0kmc6lv+ynpKTXKAtooRrCcaUtF3n2v1SHoCgjTp
Ao3MxY+QmVt57E4G4nwDNfCR6OnY4rgBRTrvREyoTWuOwhJuiGroEerVMxErWRCz
nDuypygwLmzRsOVt+eMFZfe/5flfZwn8N/dPBsDaVFEibNH/sJuh94HcuhaRKc5K
V4Nh6LT1DsAH6P+gIm3o3mjQ6Nd0H4XYBEsnaHdlHzl9LpACAIHyMwlK1BaGb3Zv
Epm6jyV38QBJUAQOdhT8pPdUuiHV/idqt2riJgO9cmvaL2I+kdlHIZAaDiR6ka4P
fNsfN4/ojXlFr8H9UcH5mL0e3cDtfbGIRZ0py1dXHZIHWCTleyo=
=RZdl
-----END PGP SIGNATURE-----

--0d2jsmHzWzUs0dl1--
