Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08ED21A06
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HmMsuRvH"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF2518C
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 14:48:10 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 117965B0C4;
	Thu,  2 Nov 2023 21:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698961689;
	bh=H6h0kfGc65ZAU+i9ams7jzWkN0sgWZLHaNtsucsJRzo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=HmMsuRvH4uU1cV18v4o12y8gQGn90ZvDO46NE7SnUYnJUeydcefeAwIbPCsFxD5mP
	 xxIENPQroVxu7B+vSCTjCKckPEyRNUu23IeOlpTb3mYXCrkcXmGEe6mAp0F6xcecCi
	 Jx0zP2RRrad99XA0sBKDQz/T56DH6VxdsG4So+5AZNc/G4yA4nmErIhktXLWNuirF8
	 STDEbtNaAkOrWW/OlKMnMnYb9r5iXnwux6cLtiPGhf+vknDhsUV1hQf7RVP3Jpvxw2
	 BnKCgTSrqwJS2J3pjg8HHYy9Lcn+GIqxurjK9MdqLE8mkydGBRBj8BGBUTDS8rEBdw
	 t/Y/kYf+TSfJ0BsZRVwyK/CJ8UJ/akewHEQP9zydbjpT+5xACJ73IKY4qPIcZBuo5u
	 F0aKOHFjD2sLMLdjHpMgk2JalzhFerEI7Q5TjNxHbJOu2EiqcvJlZI2nuwTOtJO7u0
	 RglJiy/eaLlft5zenGwFBXoMWMjOt/Ru2I4xj1W7aAq5ZwG6HaW
Date: Thu, 2 Nov 2023 21:48:07 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Robin Dos Anjos <robin_1997@hotmail.fr>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: General question about "git range-diff"
Message-ID: <ZUQZF-4CW-FbjfAU@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Robin Dos Anjos <robin_1997@hotmail.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <PR3P195MB087847E68AD2032148EFCA039BA6A@PR3P195MB0878.EURP195.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QhSdzFRzbd4Lma6z"
Content-Disposition: inline
In-Reply-To: <PR3P195MB087847E68AD2032148EFCA039BA6A@PR3P195MB0878.EURP195.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Level: *


--QhSdzFRzbd4Lma6z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-11-02 at 18:56:39, Robin Dos Anjos wrote:
> Hi git community!

Hi,

> I'm a bit intimidated as this is my first message in the mailing list but=
 I'll give it a go!

No reason to be intimidated.  We're very friendly here.

> This is so useful to me that I'm wondering why "git range-diff" does
> not implement this behavior. We could imagine a flag that would make
> it behave as I described. Is this something that was ever considered?
> Are there any technical difficulties that I'm completely missing? Do
> you think this could be helpful to other people?

I'm not the author of range-diff, but I believe it was based on an
earlier tool named git-tbdiff[0], which had similar behaviour and
similar limitations.  My guess as to why nobody implemented a feature to
handle the squashed commits case is that typically the recommended
workflow in Git is to write small independent, logical, well-described,
bisectable commits, and squashing is not recommended because it destroys
all the work that people have put into making nice commits.

Of course, in many situations, people don't write nice commits like
that, and many commits are effectively fixup commits with very short
messages (e.g. "make it work"), sometimes containing profanity directed
at the computer, and in those environments, squashing may be a
legitimate choice.  However, it isn't typically a workflow that gets a
lot of focus because most tooling is focused on the more recommended
approach.

Having said that, I'm sure people would find a feature like you
suggested useful, although I'm not likely to use it myself.  It's
possible that somebody might see your message and implement it, but
usually patches come in from people who feel strongly about a feature
and implement it themselves.  If you feel like you'd like to try such a
change, I'm sure you can find folks to review it and provide feedback.

[0] https://github.com/trast/tbdiff
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--QhSdzFRzbd4Lma6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZUQZFwAKCRB8DEliiIei
gZuwAP9Gb3KR7WVtQVCO4wC/vIFvB9uBuM34IMtQmqN/qgNsHwEAmp47UNoxqX1l
TSA8BCTp3vT+QEn9E/dAYhlpKnJPKgI=
=7VsQ
-----END PGP SIGNATURE-----

--QhSdzFRzbd4Lma6z--
