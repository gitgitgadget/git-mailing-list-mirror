Received: from smtp-good-out-3.t-2.net (smtp-good-out-3.t-2.net [93.103.246.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595526A0D5
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.103.246.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771062067; cv=none; b=IygvIdlBfkkcbw7+mERICskm5dwMpn6BuNPSJPsdvVlgj8ELGZdmyonYea2gv4NhjkKSQQPXj7u5MbS3l5WUK7MeAhlkPizEx1X/h+WPk/Lzb23FjESX+KPqazpkV0GfXZgg0kThn8vUS78oXtiFXmPr0aPk+U3XrI8pM9wkEqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771062067; c=relaxed/simple;
	bh=/ZqPwMLRurs0QzK4akgxgdKSsPXxuG/YnAMMm8Zo+1Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GAFxEU3dNaywBZeTjGG4WqPuUkbSXEN6wVWJ8qXK/uDwqIEq1adrkYLLZe1uJWHe1vUuMkD0Z417xQValRx9skqtSJeD267EAIzXm6J82zcfrM5s+TQH+VfsfspdcKpabSGLpbqOOI+2vBk93OklJZXBRW6QQUZQ4/9CZGiZp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net; spf=pass smtp.mailfrom=t-2.net; dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b=aJIFt0uy; arc=none smtp.client-ip=93.103.246.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-2.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b="aJIFt0uy"
Received: from smtp-2.t-2.si (smtp-2.t-2.si [84.255.208.31])
	by smtp-good-out-3.t-2.net (Postfix) with ESMTP id 4fCkYk2QBDz9vDSZ;
	Sat, 14 Feb 2026 10:40:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
	s=smtp-out-2; t=1771062058;
	bh=/ZqPwMLRurs0QzK4akgxgdKSsPXxuG/YnAMMm8Zo+1Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aJIFt0uyZpT3Qr8m86KgT/ZgKRa5d6X/hPXmcXzoy/1mz76hmlohE1KUKPYTJsgbc
	 kkPMR4mpUKV2BABEt4dFAvei0slGH4+Ejc90TjZ9esvGtHJXpW77qcC2x3PoPzXLnh
	 xn0Uv3dZDmGrRYdBHeUYxpJhBozcvHssxHBGK6ig=
X-Virus-Scanned: amavis at mail.t-2.net
Received: from [IPv6:2a00:1a20:227f:fde1:9423:6695:47ff:f950] (unknown [IPv6:2a00:1a20:227f:fde1:9423:6695:47ff:f950])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: samo_pogacnik@t-2.net)
	by smtp-2.t-2.si (Postfix) with ESMTPSA id 4fCkYW1F0SzMrVJt;
	Sat, 14 Feb 2026 10:40:46 +0100 (CET)
Message-ID: <c55447544d68c3f98532b1d32183465c8f175ff8.camel@t-2.net>
Subject: Re: [PATCH v4 2/2] shallow: handling fetch relative-deepen
From: Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To: Patrick Steinhardt <ps@pks.im>, Samo =?UTF-8?Q?Poga=C4=8Dnik?= via
 GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Date: Sat, 14 Feb 2026 10:40:22 +0100
In-Reply-To: <aYyGTmS6fEb2QfBU@pks.im>
References: <pull.2121.v3.git.git.1768022018.gitgitgadget@gmail.com>
	 <pull.2121.v4.git.git.1768602661.gitgitgadget@gmail.com>
	 <e9b20ae06fd2c7f2c6b73c9f093a23c812227b7e.1768602661.git.gitgitgadget@gmail.com>
	 <aYyGTmS6fEb2QfBU@pks.im>
Autocrypt: addr=samo_pogacnik@t-2.net; prefer-encrypt=mutual;
 keydata=mQINBFwCXogBEAC4B5dfY/m82d0d5VBtFeVAjtUrOOdrLgbYJZFUXsX9pya5x0QdYeTP4
 afUZ73e7zMe0ozH8UMz6iv1niPfPkMorUzNcALDcotZ8Vvf3bMdndV7lHk8jScAMoW2L7VHGn1N+H
 8yJ5WufqF/yNBLqmVqaLqNjHejZN+Ld+/4AaJ/gQzWVqYH6EaJZd/LSqppJWGOHGGURFakFSDp3Bi
 6n8SOQmarOt6mGX5wsiHNwa8NtNX1cEJPT8YCQUR7o5fTHb3AEemLRFJoGjeH2RjzPloyTlwSjLXd
 Egph2uUGqiBKD1dREfIuIWtFAJF+iMRHhIEJSF4hvUYrYAV+7ZTlIo3NnDLIeNn40Qmn++9Uh8FbL
 YdFb14dyBkw8MBBQPQNCCpBflK7aaSFWpHv6nk/Z7fGrkwrD51CHsDut8PGQMtmSYMoSCWRI1wChn
 peoZn4Cq3yG1rj90IVv/rxmvL3oMQfE2oSMAhpyRPi0vK68cG4ILpO65Aulr0wr4JFdZBNmpf8BCF
 4jqpN1HsQJCYUYBMeMeOMkH9Gz3DBWuszvjjs7wmesMkEz5C92UlK6FWGUz6Ioi2bfRGOzx0+AjpZ
 rUaSIQ+5MCPxjWkxl3EQQFL2U3ItxxpaDO46AoRFj4oKKeHoteiwpziY8whIFmDXWfy7nDfp76RiS
 riLtyZiFEuzLwARAQABtCZTYW1vIFBvZ2HEjW5payA8c2Ftb19wb2dhY25pa0B0LTIubmV0PokCTg
 QTAQoAOBYhBNCCwgeDpWpcp2HPBvAkWUZaOuMIBQJcAl6IAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4
 BAheAAAoJEPAkWUZaOuMIKE8QAJ04bxv8nXpY3Tp5nWOIOsBmEHWvVEIdD2kxjC9YCQeKx4gJLADa
 RcuXhFbwi0NQtuSRf1G11ZGqxBM/YHvSd4Rtqbag4P9UY/ZdvMAe1zW4HTO9c2mtoWN3WYxS/gkX+
 wBLVIy+eqrsG5peJmRlq3fTbCxLprgqp6B2IUcTEBa8Iynv7B/1qsG2rd0y8pY+ZHIUtz2ZJHoYz2
 Lx091uYwy9aozibWRot+vZNx4QipOmsoZOm+e5FvTf4yvmFYJ3iR8fUfq9gpCokRNtPG5NvqNLApk
 EwEAlaXH7flAUwF/uRBUASZeyEeKGRtXOUYeGXFyOgykbmIs9IXDms8OLj/TZlSzECeoSX25I0P8M
 QrMb7GChMME4W9i9+ZZc8VWPyYW8W6dyNfBb05lu0XMB62oiYim7cOXiDV49EBYtiXIwUnbfQYVSA
 U8MTvZKS4ek2KGc9OJNLnm8dP2u31jvMUts7AEoU3vxwv8tUBEm4Zpzv8+HvzpAGAnbGc/kiLClaH
 j8E5d/3XIyq0TXlZf7B5Fq+lwa3gXMiLWko7m3PfOFtvbsSWPxplka6r2T2GMt9e51sctckfd7V/F
 unQvSwML0gpE6YicA/OcoFFOwoipilJ4D0YcqLgO8FNQdXukJciq0xeeBWY4t8Oo5M88J4YzAKMr9
 PU/BhjCBDTyCb2b1
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-tsab7BpdRfKW5KZpYgqU"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-tsab7BpdRfKW5KZpYgqU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-02-11 at 14:38 +0100, Patrick Steinhardt wrote:
> On Fri, Jan 16, 2026 at 10:31:01PM +0000, Samo Poga=C4=8Dnik via GitGitGa=
dget
> wrote:
>=20
> > @@ -881,29 +838,14 @@ static void deepen(struct upload_pack_data *data,=
 int
> > depth)
> > =C2=A0			struct object *object =3D data-
> > >shallows.objects[i].item;
> > =C2=A0			object->flags |=3D NOT_SHALLOW;
> > =C2=A0		}
> > -	} else if (data->deepen_relative) {
> > -		struct object_array reachable_shallows =3D OBJECT_ARRAY_INIT;
> > -		struct commit_list *result;
> > -
> > -		/*
> > -		 * Checking for reachable shallows requires that our refs
> > be
> > -		 * marked with OUR_REF.
> > -		 */
> > -
> > 		refs_head_ref_namespaced(get_main_ref_store(the_repository),
> > -					 check_ref, data);
> > -		for_each_namespaced_ref_1(check_ref, data);
> > -
> > -		get_reachable_list(data, &reachable_shallows);
> > -		result =3D get_shallow_commits(&reachable_shallows,
> > -					=C2=A0=C2=A0=C2=A0=C2=A0 depth + 1,
> > -					=C2=A0=C2=A0=C2=A0=C2=A0 SHALLOW, NOT_SHALLOW);
> > -		send_shallow(data, result);
> > -		free_commit_list(result);
> > -		object_array_clear(&reachable_shallows);
> > =C2=A0	} else {
> > =C2=A0		struct commit_list *result;
> > =C2=A0
> > -		result =3D get_shallow_commits(&data->want_obj, depth,
> > +		if (data->deepen_relative)
> > +			get_shallows_depth(data);
>=20
> Okay, so here we now essentially call `get_shallow_commits()` twice. The
> first time we compute `data->deepen_relative`, only to then pass it back
> to `get_shallow_commits()` a second time. That feels quite strange to
> me. Can't we have `get_shallow_commits()` handle this for us directly in
> a single call?
>=20
> > +		result =3D get_shallow_commits(&data->want_obj, NULL, NULL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 data->deepen_relative + depth,
> > =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 SHALLOW, NOT_SHALLOW);
> > =C2=A0		send_shallow(data, result);
> > =C2=A0		free_commit_list(result);
>=20

I have additional dilemma regarding handling this in a single call.
Wouldn't it be generally good/useful to have a separate function in shallow=
.c
just for measuring current absolute depth instead of blending the measureme=
nt
into get_shallow_commits()?

Thanks, Samo

--=-tsab7BpdRfKW5KZpYgqU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE0ILCB4OlalynYc8G8CRZRlo64wgFAmmQQwYACgkQ8CRZRlo6
4wiZ2Q/8DistMaQ6XzRvMVjSMpcGzZE/joPPbOKWz3hvGy9APLOTsKeDSoKHLrSQ
dhwmyDySSFKejG1QA2FbpQlIIk4i221iRptAAWfEGD9WzfdIK4b5INrTZzVdkO9h
xwHcYaVSIWk9d9bQsP7juQCQnUzoThDCjPABPsK+JNw7DEbbyewMwMMcYaIdnq/N
H+xLJXALPRO0KaPJJYdkEOMZ7n+U99EdzAp6ERPws4/S5e/G7KoJYz6LHycRk99s
aKZg3P5m4wlcMWbo0m9svhWLA5w4Rmc6ex8C9JVwkx1trFcGtH/0fUjCE3+QMjgQ
A5jCVATlUrDxTHiqgkxEiApSB2Tunyo9t1hKXXgXuf6P5OLUMlhpUqHUyZ8YF9oS
/2QBs/mbkrtYttvniXaHuKWhZRQO+kkrEz2h1+I8Az6/dS+0dJ4FGHv+VvNNa5zH
A+cvgCwzQXjBeWhqHCvL7KFZf2pHczor6oKWrTdgYlgU0TEIHIOIqpUCZGOGQtDo
RMHC9Dp553CTvkvqu8mmN8xJ/MuDjXeMfITIKUpmimPzcYwoqA76CsSqdY6d8HuO
KUM69HLcPAfbI5BOUhSyKItTUdA4nSUBCr4S9B2LVTIX7w5+K1cVxBabbLbSh4Pu
gFXYpW0lCz3O+6xuWmXxsGOcxkCiBxPWIxMLkCu249iz+ltcdrI=
=j4dD
-----END PGP SIGNATURE-----

--=-tsab7BpdRfKW5KZpYgqU--
