Received: from smtp-good-out-3.t-2.net (smtp-good-out-3.t-2.net [93.103.246.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7B13D6475
	for <git@vger.kernel.org>; Tue,  5 May 2026 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.103.246.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009779; cv=none; b=RmWk90CZ2tabIPi2a6AlRySfnFUQL/moeDAC7wrApDd1i/Nq87CSvUCBIBeFhdOG2r2Jy3j943UmQ16voMZEz3xvdL9V3B/k/aqpwP1tcvFaTAdbTI4G/uUYyTT0LzE2tPMteeZyTEymsGrTBIU4ov9oFp7jW2TbFLPhrWDx9to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009779; c=relaxed/simple;
	bh=kY6obrxFjjM1cAK6meOKOP+Zz9ajwAQVx2EKT+yZzII=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JCxSg+edNXeQLrgGutX8A4BgUuSZ3YMDn3VglHxWIkUGvODLoaiABHa4VPn7PzCuiZWPRqfUhWtBuTeNVMNZCCoRiuUU7WqVNbmfbmRmW85b3zL9hBRKVrel0tM80OIOyBzai33o29368OtRVCGmbJTzKmuD/CDyARd2WuzAohU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net; spf=pass smtp.mailfrom=t-2.net; dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b=rxGI7JTZ; arc=none smtp.client-ip=93.103.246.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-2.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b="rxGI7JTZ"
Received: from smtp-2.t-2.si (smtp-2.t-2.si [IPv6:2a01:260:1:4::1f])
	by smtp-good-out-3.t-2.net (Postfix) with ESMTP id 4g97pG5Wqgz9w0nq;
	Tue,  5 May 2026 21:28:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
	s=smtp-out-2; t=1778009286;
	bh=kY6obrxFjjM1cAK6meOKOP+Zz9ajwAQVx2EKT+yZzII=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=rxGI7JTZ4e9+6wPB379SdfZBYsJV6c32bDETPydBNkKIRcrB3kgFYY9aww/rZ6PzH
	 JrhX/eO/DxN8g5XtSDeyT9qY6mmDnhq9BK3EWFv7ZZbM6oDcphkcp7o7l6CVNPKZ2t
	 SmQEh3cBy/OJGAZB++xldAAJaUpdrwRZpgvBe4YU=
X-Virus-Scanned: amavis at mail.t-2.net
Received: from hpfur15.u2up.net (89-212-91-172.static.t-2.net [89.212.91.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: samo_pogacnik@t-2.net)
	by smtp-2.t-2.si (Postfix) with ESMTPSA id 4g97p53KlMzMrW1R;
	Tue,  5 May 2026 21:27:57 +0200 (CEST)
Message-ID: <2afd4a28a9a542f8baeab488cb0801d6b98adb0a.camel@t-2.net>
Subject: Re: [Bug] fetch --deepen truncates history in v2.54.0
From: Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>, Owen Stephens
	 <owen@owenstephens.co.uk>, git@vger.kernel.org
Date: Tue, 05 May 2026 21:27:52 +0200
In-Reply-To: <e39f6770-fcc4-49a2-b3ba-5ac2ec9e047b@web.de>
References: 
	<CANOh7gEEw+6146NN3JV8EYxQarj0KkyA7r3RZ6v-DxeqQZLrCA@mail.gmail.com>
	 <a5fd970d-fd78-41bc-98f8-a6a87a7f39cc@web.de>
	 <e39f6770-fcc4-49a2-b3ba-5ac2ec9e047b@web.de>
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
	protocol="application/pgp-signature"; boundary="=-UV76PAoOJBkOSAzFL5Yk"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-UV76PAoOJBkOSAzFL5Yk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-05-02 at 22:26 +0200, Ren=C3=A9 Scharfe wrote:
> On 5/2/26 11:22 AM, Ren=C3=83=C2=A9 Scharfe wrote:
> > On 4/29/26 1:27 PM, Owen Stephens wrote:
> > > > What did you do before the bug happened? (Steps to reproduce your i=
ssue)
> > >=20
> > > Repeatedy called `git fetch --deepen 2` inside a shallow repo that wa=
s a
> > > file:// clone of another repo. Once all commits had been fetched, a
> > > subsequent
> > > `fetch --deepen` appears to "reset" the repo back to being shallow wi=
th a
> > > depth
> > > of 2. A reproduction script is included below. This issue appears to =
have
> > > been
> > > introduced in v2.54.0.
> > >=20
> > > > What did you expect to happen? (Expected behavior)
> > >=20
> > > I expected `git fetch --deepen` in a non-shallow repo with no upstrea=
m
> > > commits
> > > to be a no-op.
> > >=20
> > > > What happened instead? (Actual behavior)
> > >=20
> > > `git log` history is truncated to two commits, and repo is considered
> > > shallow
> > > by `git rev-parse --is-shallow-repository`.
> > >=20
> > > > What's different between what you expected and what actually happen=
ed?
> > >=20
> > > The previously-present commits in `git log` are missing, and the repo=
 is
> > > again
> > > considered shallow.
> > >=20
> > > > Anything else you want to add:
> > >=20
> > > Commit 3ef68ff seems relevant.
> >=20
> > Indeed, bisect identifies 3ef68ff40e (shallow: handling fetch relative-
> > deepen,
> > 2026-02-15) and reverting it fixes the issue.=C2=A0 Copying its author.
>=20
> Here's a simple fix, but it feels like cheating.=C2=A0 A proper one shoul=
d
> live in shallow.c, no?
>=20
>=20
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index a22c319467..310099b96d 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -2664,7 +2664,8 @@ int cmd_fetch(int argc,
> =C2=A0			die(_("negative depth in --deepen is not
> supported"));
> =C2=A0		if (depth)
> =C2=A0			die(_("options '%s' and '%s' cannot be used
> together"), "--deepen", "--depth");
> -		depth =3D xstrfmt("%d", deepen_relative);
> +		if (is_repository_shallow(the_repository))
> +			depth =3D xstrfmt("%d", deepen_relative);
> =C2=A0	}
> =C2=A0	if (unshallow) {
> =C2=A0		if (depth)
>=20

Hi, thanks for pointing out this edge case. Would you care to check the
following change (the provided test is also a bit modified):

diff --git a/shallow.c b/shallow.c
index a156006d88..ec95653132 100644
--- a/shallow.c
+++ b/shallow.c
@@ -245,7 +245,11 @@ struct commit_list *get_shallow_commits(struct object_=
array
*heads,
                                        int depth, int shallow_flag, int
not_shallow_flag)
 {
        if (shallows && deepen_relative) {
-               depth +=3D get_shallows_depth(heads, shallows);
+               int cur_shallow_depth =3D get_shallows_depth(heads, shallow=
s);
+               if (cur_shallow_depth)
+                       depth +=3D cur_shallow_depth;
+               else
+                       return NULL;
        }
        return get_shallows_or_depth(heads, NULL, NULL,
                                     depth, shallow_flag, not_shallow_flag)=
;
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 6588ce6226..9982dd2aa6 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -251,6 +251,16 @@ test_expect_success '.git/shallow is edited by repack'=
 '
                origin "+refs/heads/*:refs/remotes/origin/*"
 '
=20
+test_expect_success 'fetch --deepen does not truncate' '
+       git clone --no-local .git full-clone &&
+       git -C full-clone rev-parse --is-shallow-repository >expect &&
+       git -C full-clone log --oneline >>expect &&
+       git -C full-clone fetch --deepen=3D1 &&
+       git -C full-clone rev-parse --is-shallow-repository >actual &&
+       git -C full-clone log --oneline >>actual &&
+       test_cmp expect actual
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd


--=-UV76PAoOJBkOSAzFL5Yk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE0ILCB4OlalynYc8G8CRZRlo64wgFAmn6RLgACgkQ8CRZRlo6
4whAlw/9FY73rHKvJYE1juwblbaqPRrid9tsnNri/W483AUkfQ0gxF4Am7EWKkZ/
JRm6UUrAh445SkMjHCBYUPOEUU6wAqqH8AEtLMV1QQoFmDQPImyu1ms4Mya/OtrB
iLEe3yC2Rg0OVEa98u5OQpcnUrlfzX56gPSPGUWW/L8lXzGOe98H6o0/aX9TQPT4
1WfwKFkhWqM3TSE49aC9hJ4ZbPyhMEaaWtMKUC/PfbNq69SCIuS9mPehwwwC/Kf3
lRqaQoLKscUzomROcL36+DyNOXOHKe41pcostYQfjdhEQ6SlZMQp8alvKj/EBqYp
A4DIu7/OLcGe6pDskC41ayRJdrk/EhJId5QOb6atyCjm6LD9RpYU3qR+2JxSgBr5
MGjbY/qwGOIWmZY1Awckew8jRNZN/OaClOKU2HeXuIskC1TdpLFj7wt7uOWeENdB
GIIqJx5k1c7kHOiliWj1M4Z2nGAlFYQ9cnCBk6s4PwdKnR1Qc1rkHGba0OyRdxnz
zuus8YuPmfDBA9ZGSzElOlXRthrkKJHsRpAxFLtzVbvmv1e1cTAyj5xwJf3lhrzJ
dm6On/kbKJtRI/qB4GT7X7z+UCOsxc1HzKRj229g3Pg76w3LZ1FfE12zbzZp80K5
aoXRxneOuNNfCCjl9gX4to/aUQju6LqfhlvtklvXi2ZgIVyg0gk=
=AZZJ
-----END PGP SIGNATURE-----

--=-UV76PAoOJBkOSAzFL5Yk--
