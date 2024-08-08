Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FD618E02E
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123750; cv=none; b=DP0Ew1jPxYCkT0nbtrvtdhqs6YtEAzE32QVU4DKrunRWXBNW5UYB/AZUYzDSIpT5nxIj3npMMIj8h5xNcdCbggSi5VToN3Ke7FAqqqq7EXWlpgZBZxMS0z+Z5JKMO+D3lwRjd2H2HZtroXrXnYWZVqZrz3EQxUq/+e4eQ71syEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123750; c=relaxed/simple;
	bh=VuposoEshbt0YdhiAW/N+XS66t/d5DT90dgGRQPd/f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dp2CgaTHreEqjPFylOITrlfcb9oFsKaBShXLafmHueHAVyEHYaAi3iFRjga9B4/MJakHQt3b7/nCoo1dXp4e8Wi0D1RVPtMmxAQVE8WN3O8HIpFFu1U7gbxFr1rN8HZwlMryVR6ld5fifnuxL96+EN9UtM+ue2uOnrvTKDOWQK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fJ8FcTwK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Trv8vmdL; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fJ8FcTwK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Trv8vmdL"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 76254138FC92;
	Thu,  8 Aug 2024 09:29:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 08 Aug 2024 09:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723123747; x=1723210147; bh=6TJDrXBUmi
	PTRYrzRkVBBHaHE3TqnpDG1hnR/X0Zb+U=; b=fJ8FcTwKEeUOtDwU+mSQCggNIF
	IaI5QWWY4w0WgUCGBb9OtC8TqqZbVaw2N5gmxvEVdQGK+o5i+Zwl2iM1eRaQd0Tj
	ZqYQ7HdpRCptlRDJhYFEdx0wySrgLyncUWOT+VSqZDLPERzsZmL9rJWZxQIEGbOa
	axw9CyYzxjXDWM8O2bR7+4YyiP8KtK5i1TFLKGOJHPw/0REf0UhAvR0uUJjTJCXG
	6w6vtplKDovNtwKqF9fI9hIaWRc5YhXpDk27oRe/ysNA9Hpj6K09DhpSmC8HYM93
	i6MATBrbCEWwuK/xD9Hq3BDn1YWlHgXIno0ZzdVdz1lxFqOkq4S3HicMTWLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723123747; x=1723210147; bh=6TJDrXBUmiPTRYrzRkVBBHaHE3Tq
	npDG1hnR/X0Zb+U=; b=Trv8vmdL703vpGJzdmX2D1nJCWAc84Bwhhe8C1XZgPl5
	1xa7F7Lbwnr4PU8A5SE0veDLLvXiBjf8PcbOrT9zdvivcEYjrP0kAs/JZ/htxm+o
	8KbS77ncf5HEUlZn7zzKZnOx07v16SslvVb3VmyNfUS/DsPH6OGVmyKBhB2SB4NM
	JNn/6KcliRznURxLnMRej2faW8eYsDu8xIFyTt5sryes2NBqHO17xNN65dv4I24n
	cL+e03cgZAMiEpSTzeOusQe/SlT921DmUNFyqhZplg1Kkgu6maCXe2gRgS+cv9C+
	xX+CLBIxm15geB7yu20dAlpGiw/x10KvVcDftUohCA==
X-ME-Sender: <xms:I8i0ZkhX0KyoiCimov0fDBiYGlRzpBQnY34slh-TNV3JaO-Tjom5rA>
    <xme:I8i0ZtD1dfEZ0YSPff_jQz4hehPVulEzN39ZaYKEBg5EsTMfwurT17Wc4x7Zs6fi2
    OGgCNETNGfov2ckwg>
X-ME-Received: <xmr:I8i0ZsHhMr2tl96mUglonVsT2wNJH5V2sHnGfI2pYPgxmhF1Ri2rxL0MVFT7XYSuMhAdSjVSRpBzcHUvWyek1BtESNXMdPppsZcqITIHcG4zSMZi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:I8i0ZlTxTAb3kzIjJ93ZpJxcoolLll-Bu94pImhx8WaHGEXP6ZIwmg>
    <xmx:I8i0Zhz9R127_G0XfvMbH6V4HGZd--Hx1mi_FrSBQGltaIqsvfy1iQ>
    <xmx:I8i0Zj6JxIO_-TS6xr2uU3IePrdKRSwmfIPVI6jnBjquseWmR_owZw>
    <xmx:I8i0Zuy0wWm6gt9pDXroLpjmlDDhPwQtdyh-uu81ej4BE18TcYmK-w>
    <xmx:I8i0Zjt1ZADuL0ycNQMP_qwdF0u3O_Psbrdc7rQha3zD5hEaLrppMVgi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:29:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 250d32e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:28:58 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:29:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 8/9] reftable/stack: fix corruption on concurrent
 compaction
Message-ID: <ZrTIH4AW2opEFJoR@tanuki>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1722862822.git.ps@pks.im>
 <ff17414d261065d9eff01335040f5aca3a048059.1722862822.git.ps@pks.im>
 <CAOLa=ZSF_8axZ2EP6q5ac6oQiYzcQTuscLfQj=p82k=9KuyTgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GfET/DpN3FcOtJK7"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSF_8axZ2EP6q5ac6oQiYzcQTuscLfQj=p82k=9KuyTgg@mail.gmail.com>


--GfET/DpN3FcOtJK7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2024 at 07:14:15AM -0500, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > +			/*
> > +			 * We have found the first entry. Verify that all the
> > +			 * subsequent tables we have compacted still exist in
> > +			 * the modified stack in the exact same order as we
> > +			 * have compacted them.
> > +			 */
> > +			for (size_t j =3D 1; j < last - first + 1; j++) {
> > +				const char *old =3D first + j < st->merged->stack_len ?
> > +					st->readers[first + j]->name : NULL;
> > +				const char *new =3D names[i + j];
> > +
> > +				/*
> > +				 * If some entries are missing or in case the tables
> > +				 * have changed then we need to bail out. Again, this
> > +				 * shouldn't ever happen because we have locked the
> > +				 * tables we are compacting.
> > +				 */
>=20
> Okay, this is exactly what I was saying above. It still does makes sense
> to keep this check to ensure future versions don't break it.

Yeah, exactly. It's mostly about defense in depth, but should in theory
never be needed.

> > +				if (!old || !new || strcmp(old, new)) {
> > +					err =3D REFTABLE_OUTDATED_ERROR;
> > +					goto done;
> > +				}
> > +			}
> > +
> > +			new_offset =3D i;
> > +			break;
> > +		}
> > +
> > +		/*
> > +		 * In case we didn't find our compacted tables in the stack we
> > +		 * need to bail out. In theory, this should have never happened
> > +		 * because we locked the tables we are compacting.
> > +		 */
> > +		if (new_offset < 0) {
> > +			err =3D REFTABLE_OUTDATED_ERROR;
> > +			goto done;
> > +		}
> > +
> > +		/*
> > +		 * We have found the new range that we want to replace, so
> > +		 * let's update the range of tables that we want to replace.
> > +		 */
> > +		last_to_replace =3D last + (new_offset - first);
> > +		first_to_replace =3D new_offset;
>=20
> Nit: might be easier to read as
>=20
>   first_to_replace =3D new_offset;
>   last_to_replace =3D first_to_replace + (last - first);

True. Initially I didn't have the `first_to_replace` variables, but now
that I do it certainly makes it easier to order it naturally.

Patrick

--GfET/DpN3FcOtJK7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0yB4ACgkQVbJhu7ck
PpSI2xAAgcvlOKQPEw2ulzrXs2Z3sPUqjTI6meRw1acweu8qYEJoXO9qp/iu6+Ox
WZiA+CxF8YG/y/JwChgjB3/cfuw/OZGzo4XRpb5izOHml613ptaZG+0vvzq2a/m3
N54HbXxgxiyJRzjmNRebR10ZNIUohwJfSXOITRPS7huoV2xnkSHKbmG5uh367wFu
8MVraXgWGW8sWB+lO/RW3TheIaec0toA49PwCWZ/Y380ZLe7DXqCHv3DitQcLm7s
bith1hKlSy9AXYcHn/dy6fwNLNBRC1cad29JjtxU5h5TEn6RQBCRTrxf0r/99SvC
ej3MYCKsgQ3MzBBT3zbpGoWYeM+fRkyekVJOu0UvgHeYaMAvRQUuVUcMFuYN9yxR
TPwNOnDLfMwCWD/G/2UX3nnwlQfn9nhxc8nULNzKHPv8NsFnGoyxaJ8SWq0eYnqM
8D4aRPbHf41CjBETuhDPqed0KZq48T9azAHSBp+oMUSrGv5SejR9Gs35HZChmbWU
m35VtRIQiLSuVn8WOZChDRVzdd24yw1Oanc9XPUgcdwu4K/2Di7uXpIUbp8JvdXA
t0ICXcEbgOGDMLFp2I00FpF8C2mzpSTz66rI6PIkwnNLFJP+/0WpYMRPRfAVNkgg
fU8Z1A0fnY9Vf05QKpRR4+8xzNU7OO31SZYURx4k6PdgYv9Cy4g=
=DDdY
-----END PGP SIGNATURE-----

--GfET/DpN3FcOtJK7--
