Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F7823766
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqDrJqdA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1174C433C7;
	Thu,  9 Nov 2023 17:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699551748;
	bh=dcfFhBefh0j6WXNVruY3/Hx5txWkupsu6raBaekiOnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AqDrJqdAcDiluZsFpXF8nWA4h1OKKFMcIvJ4E5mRhf7gcR8kJod8FXhCdRAgRjqlE
	 7zzusQhtaqIJY+i34KUYGcs0DrYLpanfn9mDY2ZX0/fxerynY06HC5BVC1e/ORDht0
	 ekwmoufEbjesHmjc7mdFug9nwEzxEn5i+jXFn/jwIho6TFvRJv9vIiq1w4XmCEi/FU
	 CPMfnyIpihbsc7AOQFlQbmW5puPYICYcMX3abwakgeAuieG0T3jWkb4L8GNY5jV2vh
	 9POmct/eLWZzF34sakU7IkQnNIc0vyCZFEsNRVNxjbb4EqLYxfUilO4BceNh4os1aX
	 DAqfSn99gIh1A==
Date: Thu, 9 Nov 2023 18:42:19 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)
Message-ID: <ZU0aAQhVj7BQwr0q@debian>
References: <ZUocFhmPHstwKCkZ@devuan>
 <20231107174803.GA507007@coredump.intra.peff.net>
 <ZUqDwnmu9d1dD1tb@devuan>
 <20231107201655.GA507701@coredump.intra.peff.net>
 <ZUv3gjjmuqvCaJEd@debian>
 <20231108212702.GA1586965@coredump.intra.peff.net>
 <ZUz6H3IqRc1YGPZM@debian>
 <vooebygemslmvmi4fzxtcl474wefcvxnigqeestmruzrsj5zsu@5kkq3pveol6c>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M/T9WwGYhN+L1P5i"
Content-Disposition: inline
In-Reply-To: <vooebygemslmvmi4fzxtcl474wefcvxnigqeestmruzrsj5zsu@5kkq3pveol6c>


--M/T9WwGYhN+L1P5i
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 9 Nov 2023 18:42:19 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)

Hi Konstantin,

On Thu, Nov 09, 2023 at 11:08:58AM -0500, Konstantin Ryabitsev wrote:
> On Thu, Nov 09, 2023 at 04:26:23PM +0100, Alejandro Colomar wrote:
> > I used it for sending a couple of patches to linux-man@, and it seems to
> > work.  I don't have much experience with mutt, so maybe I'm missing some
> > corner cases.  Do you expect it to not work for some case?  Otherwise,
> > we might have a winner.  :)
>=20
> Since it's a Linux project, I suggest also checking out b4, which will do=
 the
> mail sending for you as part of the contributor-oriented features:
>=20
> https://b4.docs.kernel.org/en/latest/contributor/overview.html
>=20
> We also provide a web relay for people who can't configure or use SMTP du=
e to
> their company policies.
>=20
> > > > Would you mind adding this as part of git?  Or should we suggest the
> > > > mutt project adding this script?
> > >=20
> > > IMHO it is a little too weird and user-specific to really make sense =
in
> > > either project. It's really glue-ing together two systems. And as it's
> > > not something I use myself, I don't plan it moving it further along. =
But
> > > you are welcome to take what I wrote and do what you will with it,
> > > including submitting it to mutt.
> >=20
> > I'll start by creating a git repository in my own server, and will write
> > something about it to let the public know about it.  I'll also start
> > requiring contributors to linux-man@ to sign their patches, and
> > recommend them using this if they use mutt(1).
>=20
> B4 will also sign your patches for you. ;)

I haven't yet tried b4(1), and considered trying it some time ago, but
really didn't find git-send-email(1) and mutt(1) so difficult to use
that b4(1) would simplify much.  But still, I'll give it a chance.
Maybe I see why afterwards.

But I have tried patatt(1) before, which is what I think b4(1) uses for
signing.  Here are some of my concerns about patatt(4):

It doesn't sign the mail, but just the patch.  There's not much
difference, if any, in authenticability terms, but there's a big
difference in usability terms:

To authenticate a given patch submitted to a mailing list, the receiver
needs to also have patatt(1) configured.  Otherwise, it looks like a
random message.  MUAs normally don't show random headers (patatt(1)
signs by adding the signature header), so unless one is searching for
that header, it will be ignored.  This means, if I contribute to other
projects, I need to tell them my patch is signed via patatt(1) in
order for them to verify.  If instead, I sign the email as usual with my
MUA, every MUA will recognize the signature by default and show it to
the reader.

It also doesn't allow encrypting mail, so let's say I send some patch
fixing a security vulnerability, I'll need a custom tool to send it.  If
instead, I use mutt(1) to send it signed+encrypted to a mailing list
that provides a PGP public key, I can reuse my usual tools.

Also, and I don't know if b4(1) handles this automagically, but AFAIR,
patatt(1) didn't: fo signing a patch, I had to configure per-directory
with `patatt install-hook`.  I have more than a hundred git worktrees
(think of dozens of git repositories, and half a dozen worktrees --see
git-worktree(1)-- per repository).  If I need to configure every one of
those worktrees to sign all of my patches, that's going to be
cumbersome.  Also, I scrape and re-create worktrees for new branches
all the time, so I'd need to be installing hooks for patatt(1) all the
time.  Compare that to having mutt(1) configured once.  It doesn't
scale that well.

Cheers,
Alex

>=20
> -K

--=20
<https://www.alejandro-colomar.es/>

--M/T9WwGYhN+L1P5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmVNGfsACgkQnowa+77/
2zJpig//Q8N+43EnmyhvxMl+ytqcCqRbFF6UJpXTjR265HE7tky2aqyvtJ1gBegK
V+hO8OOIH8oC6mF65xnqZJ9IW+f/vuSfZLuF+83feZY010+JmeU7kE/PJRA7PIqN
JghsP9OsLitlG7sx1ATgYroUQiXZf3K93hrnu6KHPMoX/iUX1g8qpq5yOSV6n3aA
UCi83k9ISf8vWgRVKrwx0XASAwpWtCKj5ijDZBPuhdxo8Ak3jQ8aKnvFObWuvqPD
OxGnmImhmxw1HAE0VPpXTSmXzkHiX6aYmU1AFkh4bqK4cN7I+rajiBCFzEDk9EDl
I9zIhwjNd/6LjIAcIss7KA8x0MzQayBTYykx1RQcBacTunL4wJ/FltYOGqpTetX+
DMXdQuwgTQMp5Cid1xH1e08twUMSxFHRO0azOzkSnsrX5z3os31QAFgBjGHZ3iRT
T1joH1IkRPQoxAVgKktcFcrDj0mSzsvPsaaMBnQSrrt9gUbMeP7sui+PysP9jWjy
d43x5OE6TIylXKGb3cXRjonypRaysgBm28qhhtD40VIo8cOZ3FC/+KALDvKjqaDB
EbjyZWN2WH9wpUjYCAIzf5WkLhLXkyUM4l4fCk7yCYXzzrRoZpRT8fCbyOqaA8iS
tc9+JcRmPrUO5MIPSaDPy5lSEncF00pyegWH9u+WDq2i3hccj/o=
=LlU4
-----END PGP SIGNATURE-----

--M/T9WwGYhN+L1P5i--
