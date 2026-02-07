Received: from smtp-good-out-3.t-2.net (smtp-good-out-3.t-2.net [93.103.246.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCBD4086A
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 05:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.103.246.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770441342; cv=none; b=TF7S7nC6can7rYD3Cqr/lTUhkGK8yumj5UgIhZRT0ql7N2bLLoF9yx2rWKXxO826HA5E6Xaaa3LOTvyGjTqU7In/mGvPYhSHsmJn8YwpAXTn9OxJTjc2Am1EcAGl/pShbHl9yqbLOgSa2e9pgCj3THAVug5SWdhsJgEm5bkq6fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770441342; c=relaxed/simple;
	bh=cZSlJm5r+G//6bhoPR3IwsbEvCg0XPhlMrkY/d22ohs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WGb/eXiPW3XwMQM1pXK7kc00+SK0O8c6/vYGlmwtiX++ULdR16xm6zuzULg5K+uQqwq9B8NwjOP5REl5ZisDwHMp2imGqQu+P1vjp+3dm2UjWcyytbbb8t6oX8D2ISXChxKHqqCgVF63JD+sBqigjZr/PoLnkg6b6cepP0xpa3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net; spf=pass smtp.mailfrom=t-2.net; dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b=UpeXrzkH; arc=none smtp.client-ip=93.103.246.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-2.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b="UpeXrzkH"
Received: from smtp-2.t-2.si (smtp-2.t-2.si [IPv6:2a01:260:1:4::1f])
	by smtp-good-out-3.t-2.net (Postfix) with ESMTP id 4f7JpL1fq1z9vhVZ;
	Sat,  7 Feb 2026 06:06:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
	s=smtp-out-2; t=1770440794;
	bh=cZSlJm5r+G//6bhoPR3IwsbEvCg0XPhlMrkY/d22ohs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UpeXrzkHcl71x13W+HM2VjWWYrzU3giXUijtUencPyTB6kdUbcOOK2n1fDKKvNlC5
	 5uVju3PSoOD8tIIei/HRgvBcjx6JsLGUs3MBCtlBEQZ1YTNK6U9Hc6W5WONQowBrA0
	 xTG0wnR58AVKyWkWo5PC6p2R/Rax1M6Nc22y1DEo=
X-Virus-Scanned: amavis at mail.t-2.net
Received: from [IPv6:2a00:1a20:21af:ffcd:1d53:4716:83f4:8209] (unknown [IPv6:2a00:1a20:21af:ffcd:1d53:4716:83f4:8209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: samo_pogacnik@t-2.net)
	by smtp-2.t-2.si (Postfix) with ESMTPSA id 4f7Jp34CCtzMrVGq;
	Sat,  7 Feb 2026 06:06:19 +0100 (CET)
Message-ID: <a60fc6aed8ab7345219118f933ac0eb61140334f.camel@t-2.net>
Subject: Re: [PATCH v2] shallow: set borders which are all reachable after
 clone shallow since
From: Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Date: Sat, 07 Feb 2026 06:06:01 +0100
In-Reply-To: <3253600a3c96144744d3371a7ec2a66cb87d4b60.camel@t-2.net>
References: <pull.2107.git.git.1763807914242.gitgitgadget@gmail.com>
	 <pull.2107.v2.git.git.1763926552033.gitgitgadget@gmail.com>
	 <xmqqh5ujuekq.fsf@gitster.g> <xmqqfr80xanx.fsf@gitster.g>
	 <3253600a3c96144744d3371a7ec2a66cb87d4b60.camel@t-2.net>
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
	protocol="application/pgp-signature"; boundary="=-0RYztxfzct9VwP7EuR8J"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-0RYztxfzct9VwP7EuR8J
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-01-28 at 05:23 +0100, Samo Poga=C4=8Dnik wrote:
> On Tue, 2026-01-20 at 12:59 -0800, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >=20
> > > > ...
> > > > The modified implementation of a generic shallow boundary finder
> > > > based on rev-list ensures that all shallow border commits are reach=
able
> > > > also after being grafted. This is achieved by inspecting all parent=
s
> > > > of each initial border commit candidate. The border commit candidat=
e
> > > > is set border only when all its parents wern't on the initial list =
of
> > > > candidates. Otherwise the border commit candidate is not set as bor=
der
> > > > however its parents that weren't on the list of candidates are set =
as
> > > > borders.
> > >=20
> > > It is a minor point, but there are "boundary" and "border" used more
> > > or less interchangeably in the proposed commit log message, and
> > > would make the readers wonder if there are differences (I do not
> > > think we use the word "border" anywhere in our documentation).=C2=A0 =
It
> > > is minor as we do not have such mixture in the end-user facing part
> > > of the documentation with this patch.
> > >=20
> > > I'll let those (cc'ed) who may be more familiar with, or, at least
> > > have more code than I have in, the shallow infrastructure to comment
> > > on the way the updated code uses the revision machinery.
> >=20
> > After this exchange, the topic has been dormant for almost full two
> > months.=C2=A0 As I do not deal with shallow clones myself, even though =
I
> > understand that some folks rely on it working, I'd really prefer to
> > see somebody who are familiar with the underlying logic to review
> > this patch if we were to move forward with it.
> >=20
>=20
> I=E2=80=99m currently rewriting the patch and the commit message trying t=
o
> address the boundary/border dilemma. I hope to be able to send a new
> version by the end of this week.
>=20

I posted a new version of patch '[PATCH v3] shallow: ensure all boundary co=
mmits
are reachable with --shallow-since' on 31st of January. I hope you've seen =
it.

thanks, Samo

--=-0RYztxfzct9VwP7EuR8J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE0ILCB4OlalynYc8G8CRZRlo64wgFAmmGyDkACgkQ8CRZRlo6
4wgRYQ//RRsQ6+UOyRjYfWOPuAwnKy83hTXAR6yv87fDM1swVcNCMNUyjOXz9yMf
EUqX1aEjAbA1RD1wB0ueX+iPj3aeSx3btm/s1WPl+Pk/nt+JVi27oAXFaGxAnjxN
5CVI3KgqCl3irjXi8D3XhbnuHp3eijOohMPcww5vVpa+6Hv/ehFTaSGCIrkrf+OZ
6mt4FV0l7C+h3iGoh4SgbYhQSUgVMIyzP2OuPfw3ci46Tx+VZhoRRzqzhfI++uz2
Cg8wMYQ/fr9lwHmYjRStHmgy2jaNDhyNm3+E3nQe7KZtcCjtjP+tKUv9VXo8kVJC
+L8cpzO17Z05LjVeDq7+8rV5z2zLrKXVXA9+FcbWay2fYSEZYLA/SIVhm1vbbcq4
OxkoaR0yg52N9WkLwb8NonO8GZ2g80OQQdoQ+q5jkXteWI5m2+PBo9V6ZuJnjBb7
AwhnAovIM/bvbjSv3Sn8y8/UUNTFDYaCmpD4rrCqB05dUtNWPcgcQ/iYU+IeCS1Q
cTGwwuICx6OgxRhRlgFHJxctYQlBJrJDlEyGMMtJ5Tr7w0EPSZDHPiLWnQuo0uXA
0lNhbdcxiH+6O0Ai/M5D6clwvBQCQVU76y4JHElJwb608xi+T49bpqgb8A4WqF0P
Oiask8pMEjpYOpk0SKt+QqRXrUI/YyL8FSdmZeRzq/Kjo6ygQ88=
=toxU
-----END PGP SIGNATURE-----

--=-0RYztxfzct9VwP7EuR8J--
