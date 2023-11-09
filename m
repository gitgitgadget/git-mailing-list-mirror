Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344D3374D5
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWoSK9GE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F957C433C7;
	Thu,  9 Nov 2023 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699570819;
	bh=TM+hMrRpOsm+dUSplVN3P2axB3HEAjx2Z/NuDL/T8P8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWoSK9GEXzWAh3JTxZr58HEDDAcC7p+Ms2O1dyg53hFCssyN1Iu2jADQva3bid17s
	 dGGNPOjBtaEWk1zU0hZ5F1YLb+pJKP+sDnUmbQojVGLZfFOuwpgdYEQISfPv6i5lc6
	 sB4BQ2OxiW0tSHRWcH3ltFW6J4tFF3kScic5g2lkdjEHoU1+YmFNcjPGQqlntc0jy6
	 8zkAorOxiCTtnZ1kJeQ2qDDgQWBKPRnFT3jpL2j/On0aShhiQvWZ2o7Qo13Kq4A7fo
	 /23rjAmUwAQNehelbiUpjdOG4Sf3Nl8qgdsb5pzpi+dFIWK/uqZC7qCIL1alU7hmRJ
	 0S9UCGQ4Mu/lg==
Date: Fri, 10 Nov 2023 00:00:16 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)
Message-ID: <ZU1kgO1SppJdNjvY@debian>
References: <ZUocFhmPHstwKCkZ@devuan>
 <20231107174803.GA507007@coredump.intra.peff.net>
 <ZUqDwnmu9d1dD1tb@devuan>
 <20231107201655.GA507701@coredump.intra.peff.net>
 <ZUv3gjjmuqvCaJEd@debian>
 <20231108212702.GA1586965@coredump.intra.peff.net>
 <ZUz6H3IqRc1YGPZM@debian>
 <20231109180308.GA2711684@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0SPfgO+/aOucPYnE"
Content-Disposition: inline
In-Reply-To: <20231109180308.GA2711684@coredump.intra.peff.net>


--0SPfgO+/aOucPYnE
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Nov 2023 00:00:16 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)

Hi Jeff,

On Thu, Nov 09, 2023 at 01:03:08PM -0500, Jeff King wrote:
> On Thu, Nov 09, 2023 at 04:26:23PM +0100, Alejandro Colomar wrote:
>=20
> > I've tried something even simpler:
> >=20
> > ---8<---
> > #!/bin/sh
> >=20
> > mutt -H -;
> > --->8---
> >=20
> > I used it for sending a couple of patches to linux-man@, and it seems to
> > work.  I don't have much experience with mutt, so maybe I'm missing some
> > corner cases.  Do you expect it to not work for some case?  Otherwise,
> > we might have a winner.  :)
>=20
> Wow, I don't know how I missed that when I read the manual. That was
> exactly the feature I was thinking that mutt would need. ;)
>=20
> So yeah, that is obviously better than the "postponed" hackery I showed.
> I notice that "-H" even causes mutt to ignore "-i" (a sendmail flag that
> Git adds to sendemail.sendmailcmd). So you can just invoke it directly
> from your config like:
>=20
>   git config sendemail.sendmailcmd "mutt -H -"

Hmm great then!  Definitely a winner.  :)

>=20
> Annoyingly, "-E" doesn't work when reading over stdin (I guess mutt
> isn't willing to re-open the tty itself). But if you're happy with not
> editing as they go through, then "-H" is then that's enough (in my
> workflow, I do the final proofread via mutt).

Since git-send-email allows editing, I usually edit with that.  Having
-E would be redundant (and in fact it felt like that to me with your
suggested mutt-as-mta.sh) for my use case.

Cheers,
Alex

>=20
> -Peff

--=20
<https://www.alejandro-colomar.es/>

--0SPfgO+/aOucPYnE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmVNZIAACgkQnowa+77/
2zKJ9Q//V/nMSV4EBIDcAz8NMKOodBu3E90Tokye7tiSL7pAIq9cU/hUqxYp1An3
qWaAKAt9aaDmi1JrHx9a8SJCxaW71MjKRKLMuHj0HcceOQDb6S7PNev8sour6nS9
SOxyG8T5QsXz2X2DN+5B9CvSNj3P6xdKbVmfgBJW4H43FLisN3eNN8vc3U2iC7H6
ilR3du8D06IOE4FalG8xkenGPLZyq1zrsqGe/8ntngHx3bRpWVHmbmXDiLR7P9KB
lKPb7OvjrkbyGZ8An/HvPAlVXGdWvGgvN8iPgdyEAdbw/FI5pwqAKG0zTIFq+vsf
7Ar2d6icFCEL94lexFP7G+Rc3FEECBHCXFHnuZBkvXWCAcqXMVps3q5Z3ZLpCQyf
N/MjRkeRxDBHv5vinSnkZ0zQMB9lkDEfKpADLwAca9IhCj9cGFJHBmMzfZL2yhLw
YXsRDDaf6KK+YvqUIq1M4TqTcvAyd3ONydpqlnOB1sOuwLzfZ7+vfK4Odoc3eayp
o3gzkeK7IUFLBn4q+k7vFdyUd/zy+pqQdch0ojzxlw3MSj++FMowyndnBauW9Jb9
fkI2fpTwjbP8kCnpvOJtBwSGSAK5PKPZlG6+wu19k1Cy0etnoh3ntgaG9PmImVmj
tCAdYi/UyLNIIKvH1cObbr42YNh8e4gTfaSY+LNO8PKoxvw6aVw=
=qqc4
-----END PGP SIGNATURE-----

--0SPfgO+/aOucPYnE--
