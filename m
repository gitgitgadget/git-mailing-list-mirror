Received: from smtp-good-out-3.t-2.net (smtp-good-out-3.t-2.net [93.103.246.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C9F81724
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 20:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.103.246.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771015738; cv=none; b=tPsIiKOrZ6hbbkD51N/esAV0Cty7y0vg8aymRGbMR9ZRBUxixisJ6sr8BSvTAHuwjo5P7e/qFB3iVWNwovnqk4GIBae88C0qiFeR4A/o1gfXGRHNzwapMtFwyiW7vyTNRNHIdFVtDkRVK0E93IILsD+qqe4salUrIHcdWqkJlDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771015738; c=relaxed/simple;
	bh=/P/ikCRWcRUk6M6boiU3v4eSKN7l4LxgFnVH6jCa/eI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KeP1EZwP5URBXcjceFWzIO2t5FR+ADf6PEfZxSXdd+xo6VNyKAPlD4p+AXRBcnVDX2OUFm9v0ywP2vI7ZCdS+UNBl/JeWzivm6EH5rJpc09QikPRdRwcOozTh6EzdM5du2ZN19eSsXXG91iEeI2fPIaUEOJvwMXaLJpmnm5phzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net; spf=pass smtp.mailfrom=t-2.net; dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b=j2KcEMeo; arc=none smtp.client-ip=93.103.246.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-2.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b="j2KcEMeo"
Received: from smtp-2.t-2.si (smtp-2.t-2.si [84.255.208.31])
	by smtp-good-out-3.t-2.net (Postfix) with ESMTP id 4fCPQg13pxz9vj4y;
	Fri, 13 Feb 2026 21:48:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
	s=smtp-out-2; t=1771015723;
	bh=/P/ikCRWcRUk6M6boiU3v4eSKN7l4LxgFnVH6jCa/eI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j2KcEMeoMgR8dpoh8yB6w2nLCkkwP4msyWTi/OpR41PdpP5uDtO7Bf9ZIuY/KgbCm
	 JtJEzD2gG5XjFzx+UzCMNRDV7SwxEgMtvZcbMGl0yd1/cEALeurcQdI/bPNAajiFdn
	 F+ZmFFNkK4E9t5J/PZBVN+lc95bi7aFYoznA7g9I=
X-Virus-Scanned: amavis at mail.t-2.net
Received: from [IPv6:2a00:1a20:227f:fde1:5b39:dbdd:da51:b12a] (unknown [IPv6:2a00:1a20:227f:fde1:5b39:dbdd:da51:b12a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: samo_pogacnik@t-2.net)
	by smtp-2.t-2.si (Postfix) with ESMTPSA id 4fCPQR6yvwzMrVHt;
	Fri, 13 Feb 2026 21:48:31 +0100 (CET)
Message-ID: <0331ea3cef47b56ab920756fd66449e572667fee.camel@t-2.net>
Subject: Re: [PATCH v4 2/2] shallow: handling fetch relative-deepen
From: Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To: Patrick Steinhardt <ps@pks.im>, Samo =?UTF-8?Q?Poga=C4=8Dnik?= via
 GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Date: Fri, 13 Feb 2026 21:48:11 +0100
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
	protocol="application/pgp-signature"; boundary="=-RktE4HxQU3lWoAOeSQcV"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-RktE4HxQU3lWoAOeSQcV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-02-11 at 14:38 +0100, Patrick Steinhardt wrote:
> On Fri, Jan 16, 2026 at 10:31:01PM +0000, Samo Poga=C4=8Dnik via GitGitGa=
dget
> wrote:
> > diff --git a/shallow.c b/shallow.c
> > index 497a25836b..1a32808865 100644
> > --- a/shallow.c
> > +++ b/shallow.c
> > @@ -130,11 +130,12 @@ static void free_depth_in_slab(int **ptr)
> > =C2=A0{
> > =C2=A0	FREE_AND_NULL(*ptr);
> > =C2=A0}
> > -struct commit_list *get_shallow_commits(struct object_array *heads, in=
t
> > depth,
> > -		int shallow_flag, int not_shallow_flag)
> > +struct commit_list *get_shallow_commits(struct object_array *heads,
> > +					struct object_array *shallows, int
> > *deepen_relative,
> > +					int depth, int shallow_flag, int
> > not_shallow_flag)
> > =C2=A0{
> > -	size_t i =3D 0;
> > -	int cur_depth =3D 0;
> > +	size_t i =3D 0, j;
>=20
> We can declare `j` in the loop itself, as it's not used anywhere else.

Yes, sure.

>=20
> > @@ -168,16 +169,30 @@ struct commit_list *get_shallow_commits(struct
> > object_array *heads, int depth,
> > =C2=A0		}
> > =C2=A0		parse_commit_or_die(commit);
> > =C2=A0		cur_depth++;
> > -		if ((depth !=3D INFINITE_DEPTH && cur_depth >=3D depth) ||
> > -		=C2=A0=C2=A0=C2=A0 (is_repository_shallow(the_repository) && !commit=
-
> > >parents &&
> > -		=C2=A0=C2=A0=C2=A0=C2=A0 (graft =3D lookup_commit_graft(the_reposito=
ry, &commit-
> > >object.oid)) !=3D NULL &&
> > -		=C2=A0=C2=A0=C2=A0=C2=A0 graft->nr_parent < 0)) {
> > -			commit_list_insert(commit, &result);
> > -			commit->object.flags |=3D shallow_flag;
> > -			commit =3D NULL;
> > -			continue;
> > +		if (shallows) {
> > +			for (j =3D 0; j < shallows->nr; j++)
> > +				if (oideq(&commit->object.oid, &shallows-
> > >objects[j].item->oid))
> > +					if ((!cur_depth_shallow) ||
> > (cur_depth < cur_depth_shallow))
>=20
> The additional braces around the respective conditions are not needed.

Of course.
>=20
> > +						cur_depth_shallow =3D
> > cur_depth;
> > +
> > +			if ((is_repository_shallow(the_repository) &&
> > !commit->parents &&
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 (graft =3D lookup_commit_graft(the_reposit=
ory,
> > &commit->object.oid)) !=3D NULL &&
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 graft->nr_parent < 0)) {
> > +				commit =3D NULL;
> > +				continue;
> > +			}
>=20
> This block here is almost the same as the one below. But there's some
> confusing parts:
>=20
> =C2=A0 - Why don't we update `result` at all?
>=20
> =C2=A0 - Why don't we set the `shallow_flag`?
>=20
> =C2=A0 - Why don't we have to check for the passed-in depth?
>=20
> All of these parts feel somewhat surprising to me, as the function now
> behaves so wildly different depending on whether or not `shallows` was
> passed.
>=20
> I guess this is because we really only care about `cur_depth_shallow`?

Exactly, i merged the two functions with almost the same algorithm producin=
g
different results depending on additional input parameter shallows. When
shallows passed only current maximum absolute depth is returned in the extr=
a
output parameter deepen_relative (if provided) and nothing else is done. Th=
e
passed-in depth is not checked as it is irrelevant for this depth-measuring
scenario.

>=20
> > diff --git a/upload-pack.c b/upload-pack.c
> > index 2d2b70cbf2..4232eef34f 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -704,54 +704,11 @@ error:
> > =C2=A0	return -1;
> > =C2=A0}
> > =C2=A0
> > -static int get_reachable_list(struct upload_pack_data *data,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct object_array *reachable)
> > +static void get_shallows_depth(struct upload_pack_data *data)
>=20
> I think this function is rather pointless, as there is only a single
> caller and we only end up forwarding to `get_shallow_commits()`. Let's
> inline it.

True, i suppose you ment inline the function code instead of function call =
and
not making the function inline?

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

Nicely put, i just wasn't (and still am not) confident enough to change cod=
e in
a way that would potentially affect any other scenarios than fetching relat=
ive-
deepen.

Thank you very much for the review and i'll try to address all your review
points in the next patch version.


Best regards, Samo

--=-RktE4HxQU3lWoAOeSQcV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE0ILCB4OlalynYc8G8CRZRlo64wgFAmmPjgsACgkQ8CRZRlo6
4wiYKQ//dsASmvLaHLGPr6qmYKFjh+t4ZaHXsAHIt86fksp9csOzQcgvknVOfcGB
8J+99zKt5WNEmUTCMUuqawWe8XDt8T/9O68pnjOxkmPda+pa3PQDSzPnWKEPu1tI
9NW+O2hROA0y1dfeHMF+DXgewZMc/ijaUzb6fcfLtAcPDg1bDQpK14KjpOqy1AJE
y0g58sWbKI/V7/wjqL9gouoNkmaaX+qWmfIa3Xtr5NiSmdcex5UQl54zP1UAP5rz
ByCV+myGl2E8p04+a81reOLmakBbx+Q5UX0zt6NvK/Aho3FDu37VRq8Icfoayuyv
+9esWei0ptjHqXsnvnJWRK30cFCpUe7fswGV21zulyNDulVmyQoMIe3PzoOe768y
whJba1b1OuqCrlBQV9GmP6Uoa/jIXBJvCLYVWW4FmoUTQ+QZtAQu5B0jqxgdnQFN
JF7dtlczIw8QHyKKnPWcXSN3R0Tr8l5z8xVot3caRAmuX6B3eIAGZFIzMRiArMIf
92hCK4HNNt8sXAIebjSvYyWAT4NnnrAAq8He1wytmCcsvc0qpczXnwgy45TMaVGd
TwxXgAONJmR1ByjA6NKZ53Af3IROrbVc5cUTV8NGEfIGPCOjw4wsSoXagpHT/Ud3
cwpCrgdYT3kxcGJ/RW+mYP6oxrgw+6eRwWfKgUmnxKV5WVduWls=
=xQ2I
-----END PGP SIGNATURE-----

--=-RktE4HxQU3lWoAOeSQcV--
