Received: from smtp-good-out-3.t-2.net (smtp-good-out-3.t-2.net [93.103.246.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1410C2DF6F6
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.103.246.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977338; cv=none; b=Lz6Yq0x6A8nZ8b4OLkoGH2cqcqlUPnHGFf2mJXzLuTHPK3F2who7gVoCyuO9Uyv6dd7PMiKq6+yf0Qg5GCd2TIAKQzcK/YpEU2iAh7l+nxNswoWHBAYXY9/VfewshN4jHfPX4wCH/pKPw7ipJ49LLIVPhGlzu5gi5RQJ70T6U2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977338; c=relaxed/simple;
	bh=bqgeWTibBgnC2lH24BW1W/OxIJzTCYGgwD/Ogiv1JK4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l9T41aTR9rBz7FUgznzoSUhbRdMuYKnkESfwpmGzatXwZA5Y2hLGKdvQKR+M0O7bGbAtDYtdsd5GdD0OrpznHxgoztIz5Bp9qtfsGbsh+OeQw9xy7MQIL1+fbVAeWsZmJ6EZc3DCTmkIDsz0o+TzpEN/vxyezrXBPDdc6hRvOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net; spf=pass smtp.mailfrom=t-2.net; dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b=PBUePiJ1; arc=none smtp.client-ip=93.103.246.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-2.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b="PBUePiJ1"
Received: from smtp-2.t-2.si (smtp-2.t-2.si [84.255.208.31])
	by smtp-good-out-3.t-2.net (Postfix) with ESMTP id 4dnnm41tGnz9vhW7;
	Fri,  9 Jan 2026 17:48:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
	s=smtp-out-2; t=1767977332;
	bh=bqgeWTibBgnC2lH24BW1W/OxIJzTCYGgwD/Ogiv1JK4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PBUePiJ13U1l6k5+4CWs2sKTkwAws1m7sG1xw25XTU2TD56NKLjMIZe7PWb05X6Qj
	 5xu6qZgTlzRstm1LLCiIn59I0lv6K29M114l/NvQHQI1jUJQSEpRZQwOqv9dmF3Zwf
	 zKqQQVfSFf7NCBz6H2R1PzjlIIrSD5iAWmboQA6Y=
X-Virus-Scanned: amavis at mail.t-2.net
Received: from [IPv6:2a00:1a20:223f:fac3:4f3f:95f4:6690:3b60] (unknown [IPv6:2a00:1a20:223f:fac3:4f3f:95f4:6690:3b60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: samo_pogacnik@t-2.net)
	by smtp-2.t-2.si (Postfix) with ESMTPSA id 4dnnlw53DrzMrVGx;
	Fri,  9 Jan 2026 17:48:44 +0100 (CET)
Message-ID: <d2cb7351419002ec3be6423f39091e9d0d0e3877.camel@t-2.net>
Subject: Re: [PATCH 2/2] shallow: handling fetch relative-deepen
From: Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To: Patrick Steinhardt <ps@pks.im>, Samo =?UTF-8?Q?Poga=C4=8Dnik?= via
 GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Date: Fri, 09 Jan 2026 17:48:19 +0100
In-Reply-To: <aVy9a9f1AZzTbBQa@pks.im>
References: <pull.2121.git.git.1765303880.gitgitgadget@gmail.com>
	 <b352a33c90ca67f4ad68df08c0fd155ceeeb167c.1765303880.git.gitgitgadget@gmail.com>
	 <aVy9a9f1AZzTbBQa@pks.im>
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
	protocol="application/pgp-signature"; boundary="=-9+YzrHR5C81dgKtEoK9R"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-9+YzrHR5C81dgKtEoK9R
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


On Tue, 2026-01-06 at 08:44 +0100, Patrick Steinhardt wrote:
> On Tue, Dec 09, 2025 at 06:11:20PM +0000, Samo Poga=C4=8Dnik via GitGitGa=
dget
> wrote:
> > From: =3D?UTF-8?q?Samo=3D20Poga=3DC4=3D8Dnik?=3D <samo_pogacnik@t-2.net=
>
> >=20
> > When a shallowed repository gets deepened beyond the beginning of a
> > merged branch, we may endup with some shallows, that are behind the
>=20
> s/endup/end up/
> s/shallows, that/shallows that/
>=20
> > reachable ones.
>=20
> Hm, which reachable ones? Sorry, I can't quite follow, it would help the
> reviewer to add a bit more context.
>=20
> > Added test 'fetching deepen beyond merged branch' exposes that
> > behaviour.
> >=20
> > On the other hand, it seems that equivalent absolute depth driven
> > fetches result in all the correct shallows. That led to this proposal,
> > which unifies absolute and relative deepening in a way that the same
> > get_shallow_commits() call is used in both cases. The difference is
> > only that depth is adapted for relative deepening by measuring
> > equivalent depth of current local shallow commits in the current remote
> > repo. Thus a new function get_shallows_depth() has been added and the
> > function get_reachable_list() became redundant / removed.
> >=20
> > The get_shallows_depth() function also shares the logic of the
> > get_shallow_commits() function, but it focuses on counting depth of
> > each existing shallow commit. The minimum result is stored as
> > 'data->deepen_relative', which is set not to be zero for relative
> > deepening anyway. That way we can allways summ 'data->deepen_relative'
> > and 'depth' values, because 'data->deepen_relative' is always 0 in
> > absolute deepening.
>=20
> I think the commit message needs some polishing. I myself am not that
> familiar with our shallow logic, so I'm a bit lost here to be honest.
>=20
> Typically, a commit message should be self-explanatory and guide the
> reader through the problem space as well as the solution. It should, in
> the following order:
>=20
> =C2=A0 - Explain what the actual issue is as observed by the user. I'm no=
t
> =C2=A0=C2=A0=C2=A0 really sure about this part, only that it's something =
related to
> =C2=A0=C2=A0=C2=A0 shallow clones, deepening and merge commits.
>=20
> =C2=A0 - Explain what the root cause of the issue is.
>=20
> =C2=A0 - Explain how the root cause is being fixed. Ideally, it should al=
so
> =C2=A0=C2=A0=C2=A0 explain why that is the correct fix, potentially refer=
encing other
> =C2=A0=C2=A0=C2=A0 code like you do.
>=20
> Your commit message on the other hand explains more of the "what" and
> less of the "why", which makes it hard to follow. Also, an ASCII commit
> graph would probably go a long way in explaining the issue :)
>=20
> > diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> > index 2677cd5faa..d05c45e32b 100755
> > --- a/t/t5500-fetch-pack.sh
> > +++ b/t/t5500-fetch-pack.sh
> > @@ -955,6 +955,30 @@ test_expect_success 'fetching deepen' '
> > =C2=A0	)
> > =C2=A0'
> > =C2=A0
> > +test_expect_success 'fetching deepen beyond merged branch' '
> > +	test_create_repo shallow-deepen-merged &&
> > +	(
> > +		cd shallow-deepen-merged &&
> > +		git commit --allow-empty -m one &&
> > +		git commit --allow-empty -m two &&
> > +		git commit --allow-empty -m three &&
> > +		git switch -c branch &&
> > +		git commit --allow-empty -m four &&
> > +		git commit --allow-empty -m five &&
> > +		git switch main &&
> > +		git merge --no-ff branch &&
> > +		cd - &&
> > +		git clone --bare --depth 3 "file://$(pwd)/shallow-deepen-
> > merged" deepen.git &&
> > +		git -C deepen.git fetch origin --deepen=3D1 &&
> > +		echo "Shallow:" && cat deepen.git/shallow &&
> > +		git -C deepen.git rev-list --all >actual &&
> > +		echo "All rev-lis:" && cat actual &&
>=20
> This statement and the one two lines further up look like debug code to
> me.
>=20
> > +		for commit in $(sed "/^$/d" deepen.git/shallow); do
>=20
> Nit: loops should be formatted like this:
>=20
> =C2=A0=C2=A0=C2=A0 for commit in ...
> =C2=A0=C2=A0=C2=A0 do
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0 done
>=20
> > diff --git a/upload-pack.c b/upload-pack.c
> > index 2d2b70cbf2..ecd3e7f5ef 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -704,54 +705,82 @@ error:
> > =C2=A0	return -1;
> > =C2=A0}
> > =C2=A0
> > -static int get_reachable_list(struct upload_pack_data *data,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct object_array *reachable)
> > +define_commit_slab(commit_depth, int *);
> > +static void free_depth_in_slab(int **ptr)
> > =C2=A0{
> > -	struct child_process cmd =3D CHILD_PROCESS_INIT;
> > -	int i;
> > -	struct object *o;
> > -	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + hash + LF */
> > -	const unsigned hexsz =3D the_hash_algo->hexsz;
> > -	int ret;
> > -
> > -	if (do_reachable_revlist(&cmd, &data->shallows, reachable,
> > -				 data->allow_uor) < 0) {
> > -		ret =3D -1;
> > -		goto out;
> > -	}
> > -
> > -	while ((i =3D read_in_full(cmd.out, namebuf, hexsz + 1)) =3D=3D hexsz=
 +
> > 1) {
> > -		struct object_id oid;
> > -		const char *p;
> > -
> > -		if (parse_oid_hex(namebuf, &oid, &p) || *p !=3D '\n')
> > -			break;
> > -
> > -		o =3D lookup_object(the_repository, &oid);
> > -		if (o && o->type =3D=3D OBJ_COMMIT) {
> > -			o->flags &=3D ~TMP_MARK;
> > +	FREE_AND_NULL(*ptr);
> > +}
> > +static void get_shallows_depth(struct upload_pack_data *data)
>=20
> This function looks very similar to `get_shallow_commits()`. Is it
> possible to deduplicate the logic?

Thank you for the valuable reply. I'll try to address all the raised points
including mentioning in commit 1/2 that added test from 2/2 fail without 1/=
2 as
quickly as time allows me to.

Thanks!

Samo

--=-9+YzrHR5C81dgKtEoK9R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE0ILCB4OlalynYc8G8CRZRlo64wgFAmlhMVMACgkQ8CRZRlo6
4wh+qA/8DTvxEKScil36fLDPccTUAMsDsvLKy/xgS0FR+PwYHc0uejnworFFvsvH
R8R90O5bOkdT0wDPBX3LEBEV+Hw7DFPkk17r+V0+/6xOU1JDXa3JF3ttvpbjcZ2D
sZHpMN0U2fdt8Cmqtql9AOesSziJyARULuE5GTSKNhzqkpssxoNtFUj0CxbDnNO3
FatvEtV1aZn5+8zg1za38yJV6S1Sebd8X8YlRXGQqwX7P3DipLdnqN9NAIkNtTr0
6+pfL82tqdVJiobySETIq/nKktwDeSulZYX4nUSwa16WCnAVKiyTzg+XdcUT7it6
GeGv0Nx0dtzHpBmdY00ZVrGYAxZq7MxH0kgIMG+p2in4slNPbSXPB/2ZFTqX5Elu
5hoTkCndqORr6dvRF46EhLPheVMpJ6K2sUYPXhm/LcuVN83mZLUDNIrVXO9hqHPd
OELy77efrb1Hx1ugCf+xzLOiWEZgUMMLMEhP1uM20vWwkREEfFWb9eBgX2BiwVh9
jlXv4DOnNRLDJylQb+feg6+GdXCO/g03z7KWHF57r4vH6eY1wE8MbcZb5LFOAc31
e4U2LHoPbjxwlx93whrt853rKC8pas7i/DE8stwJSjY3WTvl72ZMUBdMDquG2MTX
el3TcwBW/23oJx7sZ1KaVXMua4ku9P068JP7g6+62mOfnNB0vEI=
=VIRe
-----END PGP SIGNATURE-----

--=-9+YzrHR5C81dgKtEoK9R--
