Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28488197543
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328310; cv=none; b=ApdYqulRMxh/qZdVND0CYjQjAtMJk1Y4ZfyK93OF8imejg5PPnEdbwq4HZy6KnNRQjFpKIap+lydiYH1wJWedaWanNrD92WpUcN01Mt9tSegdNA9lwNA8IUT0q8RySCyATGz9RimMQnT8bgJEwxs0O5Z+1/YQMKwk2AKjn24aL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328310; c=relaxed/simple;
	bh=JJrE5yq/EoPM0ROUZjbA8t+/tuqqopzwNPdaHRt6Dg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOPMPNTrlE3CW7uN3Jm7TY8PiXwvvNF0wUef9+H3dKTHBqdyxs9wWIbIUSA24EnOY/LBZJvJfGr0Bm2WdO3W4Sno8rBXfu3QfQCTSAwHz676tc0cvU+b0xgCd/P6A6RLavmjT3tuNYu+7PkJUvGCrwOAIvKNAYAj9Neq2Id2eU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kRYW9Hfo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C91WkpB1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kRYW9Hfo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C91WkpB1"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 749DD13807B6;
	Tue, 30 Jul 2024 04:31:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 30 Jul 2024 04:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722328307; x=1722414707; bh=UdxtoqAu4E
	BZmiOON96KMNRxrH8gtUOMBCvvlD2v1kc=; b=kRYW9HfoCo1olxJZin5r9r2ztm
	DzW77XuzLFueOaAUvoCJUIxC+UCZaUshfroXrJpW5hiAopLN7ST4dWY054DyvoHr
	vppAWqX7HnmWU3id4imT6Q3wTn6r8vo5MI7AtOxbbFCeiREPXJ1XrZPiCpZIfvtM
	skmf6/e1UaIe5prsRupLRwD1dVVTop8wrSeyQHb8FzHQsiOBxXZJf1JzR++OziSS
	oQGv8FDPNPh1xfTRJ+7+Ey9rFNBi/sMwTE5iJRCCRPMeMoT51M4Rysh2h4aZNd9w
	Ru4lsUuBNIbZnI1EgRxFPbzawuzFJSfoDb0LYd661p8O6ULEzWhdQk9fI2EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722328307; x=1722414707; bh=UdxtoqAu4EBZmiOON96KMNRxrH8g
	tUOMBCvvlD2v1kc=; b=C91WkpB1PxvFJmhJ5fSDFN6O+1s/y53GYBZnwKgxTzIr
	uwRCE7yvVfF1y7NwgihyAGabCnRHBLO22ofWRcJrSIpVYDmi3ZpkWHS6XmGYqzVT
	xdC0c5CpKVM8ByOmS0vgnQhC+DN7T+zo4amlxe1PUTpM+Xg71p7hZNw+583HLuSA
	6QjlqdIgGXOMAokf6n3kXzT7Ya/R5vFgvO1yRYwiWYGGO5Uz153pANxM8I9U9S+/
	YlZkSgKqrqBVKSwT0COl7ahd59rrW026xTQKRptQhSOL2c+cNhS22uiva5t5EpYD
	Pl0ZwCzkFYw1NMK4nmNWLt/cD7B8aOK4ZHzwZ7wPMg==
X-ME-Sender: <xms:86SoZg9UQ22jjD_JLdQjWDj4dVWjtRIPOYnz1zuDZVtGPatSIbcqEw>
    <xme:86SoZotg-sp3A7QT6tzGzNkYkX2OXVLeVK1XgkIVQorMYBvJk_FfrE4gxzHUxWuED
    8IKJbTe3qrl7xmJrg>
X-ME-Received: <xmr:86SoZmBV3ODmLQJawPVBPuZR08AbdAYfWWoi0UPF9LMDHg8VHkxi8W7qrlXvjFEVP05HQaV43XneTtMBjQga0T0Cb-Wou_ypHOkGYYSgWGSrL2M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:86SoZgcG6Ot-4vsy9uG36q4iResqdbO09kVxRh23-w1Ye7_sHaZSqw>
    <xmx:86SoZlOf7MOy4woaiEkoWBSwTbc4xMA889oQEUdO4JrmbfWrttb6mg>
    <xmx:86SoZqkET17W3Rcuz-DjKNl5QWUpbbh7H0puGW_KoQPfXrmtV8GE5w>
    <xmx:86SoZntjPnJ3sQKEoPNu3mDLaNFEKJNFXdhxT00qoc3rdOVZkeMBuQ>
    <xmx:86SoZhDb-abDrwnBoQjx0fy2GB8xoSaR8aztGqrrKT9DhbapVXRbStaG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 04:31:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d73e37c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 08:30:18 +0000 (UTC)
Date: Tue, 30 Jul 2024 10:31:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 08/10] files-backend: add unified interface for
 refs scanning
Message-ID: <Zqik73qynJvOLctw@tanuki>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
 <ZqeYw-k-MzhPTNRf@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6LegSG2z4i3lZFm1"
Content-Disposition: inline
In-Reply-To: <ZqeYw-k-MzhPTNRf@ArchLinux>


--6LegSG2z4i3lZFm1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 09:27:31PM +0800, shejialuo wrote:
> For refs and reflogs, we need to scan its corresponding directories to
> check every regular file or symbolic link which shares the same pattern.
> Introduce a unified interface for scanning directories for
> files-backend.
>=20
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  refs/files-backend.c | 74 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 73 insertions(+), 1 deletion(-)
>=20
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 4630eb1f80..cb184953c1 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -6,6 +6,7 @@
>  #include "../gettext.h"
>  #include "../hash.h"
>  #include "../hex.h"
> +#include "../fsck.h"
>  #include "../refs.h"
>  #include "refs-internal.h"
>  #include "ref-cache.h"
> @@ -3408,13 +3409,84 @@ static int files_ref_store_remove_on_disk(struct =
ref_store *ref_store,
>  	return ret;
>  }
> =20
> +/*
> + * For refs and reflogs, they share a unified interface when scanning
> + * the whole directory. This function is used as the callback for each
> + * regular file or symlink in the directory.
> + */
> +typedef int (*files_fsck_refs_fn)(struct fsck_options *o,
> +				  const char *gitdir,
> +				  const char *refs_check_dir,
> +				  struct dir_iterator *iter);
> +
> +static int files_fsck_refs_dir(struct ref_store *ref_store,
> +			       struct fsck_options *o,
> +			       const char *refs_check_dir,
> +			       files_fsck_refs_fn *fsck_refs_fns)
> +{
> +	const char *gitdir =3D ref_store->gitdir;
> +	struct strbuf sb =3D STRBUF_INIT;
> +	struct dir_iterator *iter;
> +	int iter_status;
> +	int ret =3D 0;
> +
> +	strbuf_addf(&sb, "%s/%s", gitdir, refs_check_dir);
> +
> +	iter =3D dir_iterator_begin(sb.buf, 0);
> +
> +	if (!iter) {
> +		ret =3D error_errno("cannot open directory %s", sb.buf);
> +		goto out;
> +	}

The error message should probably be marked as translatable. Also, I'd
personally remove the newline between `iter =3D ...` and the error check
as those are a logical unit.

> +	while ((iter_status =3D dir_iterator_advance(iter)) =3D=3D ITER_OK) {
> +		if (S_ISDIR(iter->st.st_mode)) {
> +			continue;
> +		} else if (S_ISREG(iter->st.st_mode) ||
> +			   S_ISLNK(iter->st.st_mode)) {
> +			if (o->verbose)
> +				fprintf_ln(stderr, "Checking %s/%s",
> +					   refs_check_dir, iter->relative_path);

Okay, we do end up using the `verbose` flag :)

> +			for (size_t i =3D 0; fsck_refs_fns[i]; i++) {
> +				if (fsck_refs_fns[i](o, gitdir, refs_check_dir, iter))
> +					ret =3D -1;
> +			}
> +		} else {
> +			ret =3D error(_("unexpected file type for '%s'"),
> +				    iter->basename);

Instead of printing this as an error directly, shouldn't we report it
via the `fsck_refs_report` interface?

> +		}
> +	}

Okay. It does make sense to do our own directory walk as that will allow
us to check files which would otherwise not be reported by the normal
refs interfaces.

> +	if (iter_status !=3D ITER_DONE)
> +		ret =3D error(_("failed to iterate over '%s'"), sb.buf);

Reporting this as an error feels sensible though as we have no ref to
tie this error to, and it feels like a generic error.

> +out:
> +	strbuf_release(&sb);
> +	return ret;
> +}
> +
> +static int files_fsck_refs(struct ref_store *ref_store,
> +			   struct fsck_options *o)
> +{
> +	files_fsck_refs_fn fsck_refs_fns[]=3D {
> +		NULL

The last member should also end with a comma.

> +	};
> +
> +	if (o->verbose)
> +		fprintf_ln(stderr, "Checking references consistency");
> +
> +	return files_fsck_refs_dir(ref_store, o,  "refs", fsck_refs_fns);
> +

This newline should be removed.

> +}
> +
>  static int files_fsck(struct ref_store *ref_store,
>  		      struct fsck_options *o)
>  {
>  	struct files_ref_store *refs =3D
>  		files_downcast(ref_store, REF_STORE_READ, "fsck");
> =20
> -	return refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
> +	return refs->packed_ref_store->be->fsck(refs->packed_ref_store, o) |
> +	       files_fsck_refs(ref_store, o);

I'd think we should first check loose files and then continue to check
the packed ref store. That's really only a gut feeling though, and I
cannot exactly say why that feels more natural.

Patrick

--6LegSG2z4i3lZFm1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaopO4ACgkQVbJhu7ck
PpRpKA//aSS2B+117pAu/6qpbOK5FSdlwBSwO8jSduXPxwdZGf+nh44ej2wvov2f
DvZLLeRl7xOq3kjLtSQ1+g9v3TYHp2q9OIuCtGU1HJUb/Fx0WuPcqJsPqSRwAycs
k6UsUTjgiOKUJvESMhxzWfWK8dLR2I/Yy8Z2auMsr3pX017hx2FaX7vTNj5N3vzS
3SzUyz7m3UDAFy6Oey5dkwUVpwNGwDTsMs5Z+zkYcQ1wooxQ5Rx0gWGb+dCCR0Hv
TxzxT8ZwO4WBVhIXXtusy/nu4T9bzpRzKApW8gt1x3dVBoJNca+/nrDNIsZBk8SC
gW/iG/8nOHhi6BhaslEbqXRzgi+gjE+mBfp0+PFZ/ngXFYbBcmhwGUxqVEbFk+2B
kMeYCpQRlPFnRK49t10PPpHMWtN+bWf9VfvIgYBXUYe9Iw8HRfkEmhYCxpeUtXE4
SBqY2Fh38zohpi7b9aobFsGk1VRiEbmHm9rP3QI+TJj2cXDq228hCSzgouAh/7/s
+1SmAWrUkEMn2s3PFIOZ3WI2Mqh2MNXY873BCaOiih7ItF3NQKkNkPuTepLwofKc
QuvYt/YFRjZlWrIaEq2X4dmm64p/DQ8DJp8v/CsX/s9mxWoA59/Kj38Bj97vccy0
wfv877LTwwhdyv/bX3Fj9CVMP9Z1pjr3s1FiZzVOh27Ux10kXTE=
=KHDA
-----END PGP SIGNATURE-----

--6LegSG2z4i3lZFm1--
