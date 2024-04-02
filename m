Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00715A48D
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078642; cv=none; b=Cygi3Uk4LFLgOKMTc45aoUNAOuDAZrT2IsccEAEaGqBgv525+VqOalvrtkw3zSzW3QLwyV1NipCrUB5jP3tNmKEduyDNFp3fh82Iphml2QoAKSNnL7o1MQF99YvqcJdPgHpqKnAsAnoowL0/sbTWza64mVMVq1dEdboN5DtoUN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078642; c=relaxed/simple;
	bh=yMeKc+WN4NeeJN7WJeTBT+rYQNX93I+kujp+oZY21yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0apCYVf20g8BsuFMj9XRjDXVsG0K2x/Ul0PlXc7gVAxuY5Q9qmqxOH+BBRqjssIbANbbyA7FyfjN7Hb23TultGfHRkn3PNW2sVcv5qnZNsLmguOlT/J9ER8VTTyT38lEsdn9ao+pLv0FyqDkBmPmb9381soxWJeBad5heyHdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GUTgBZSy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w45qlmDX; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GUTgBZSy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w45qlmDX"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id F345E18000A6;
	Tue,  2 Apr 2024 13:23:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 02 Apr 2024 13:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712078637; x=1712165037; bh=s826KRafaq
	HrII+X/fRRc+FvWFkvBELO93X8otYrUeY=; b=GUTgBZSysSE8KVqu37z//Fnxpa
	cpu4+YFMAtkUtViHQh3XT9nRxPVqq9upfcdHB+L4M1OpxeoIxwir2dUB5cqPOnBu
	BGTouAeOQwOtLejjCGuzL4JdfbFN4d76hwqJ8FA/NPrHn7JsjjXv06CvrFe9t2BC
	Q3nPjxy4ETBnKfjtrXygXLudeMAciHy4bP0b5o+CtiFtMKIkkx3DyyjKY2m3mQ8Z
	McasL5CbPWjUR7/H6B8/YEU3BmwuLVscG//DPznDwGzG6uJgRfzVHBTCNQzIkte9
	9zTwP0ecBfAIdliC0nQUR9GAae6I/eG12fh2A5fX+dWAvC10WKTC8USef3Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712078637; x=1712165037; bh=s826KRafaqHrII+X/fRRc+FvWFkv
	BELO93X8otYrUeY=; b=w45qlmDXpaweOfftpka4O7+At7H0ZUd4Mif/PjEe4tV2
	Z6xvZqeWLICdVPhrfbvpHjssOnUStCTWX67jvzzPolXD1tAijZSrWfVzzMxMMbRu
	IkJP5CCWM73MiEw1geg2Q+1o78iEG3Vn2Hl9J0m4msxo5gT7C4ootoT+nSdzX4PD
	gz8HnbCJ2RkIFf5BYNvmjUKmqEgNZytM6Vt/BwZezjfbLsDH5GV/uDHyp/eP/A51
	rL8wnfc+iXPp862SOOrSM32ph6FED8wxmue3RLkl7ZKZMXo9/3HBwQj7l4gTWj2u
	I2YSh7NiJSQUkD4o78cNEhlz1ZOEnKrnytqDcSMULQ==
X-ME-Sender: <xms:LT8MZpuMdQb5jBokEp969SMErlPrKkgGgKv--02N9E11F5UvIpJlMg>
    <xme:LT8MZic8Oq1u-jbXyqdOytbS4eE3lAGUlMRFKwG2rcXEUXaMq89DRch3Xow1yREQQ
    fBPIOO4Y33V_8Nk-Q>
X-ME-Received: <xmr:LT8MZsz-KlGyWmXhWYDbc553zKrD5bjZTOqw5J8SlFKkzxAzl54Mip7xYw6rTsDEEZKKVyli3S6u25QT3DALiYE1fQxyau4xyAaGn-gE0Hi6x7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:LT8MZgMxLUH61hY6lgv7pQ9_2lFo7bnByVYFFggU8QcQvU5PND1tsQ>
    <xmx:LT8MZp9UTl9W1yo1bX3kcSCGfOUGJsVtK4pXSupzI2cNCfEobyJQOw>
    <xmx:LT8MZgV-21lo-ZRKfGoQCnr5cnueOxCDBTLi9TkmSgYhLy_M4-Sx8g>
    <xmx:LT8MZqe35mqMqvcegNAlu-xIiLlmdoUMLj_iyIZEAP9l9oO01jHacg>
    <xmx:LT8MZlb04qy88He7te058VkavNdkV8v8FjCCL3czfsQMGeY8C7GxEbtX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 13:23:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 24a4d8b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 17:23:46 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:23:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Aishwarya Narayanan <aishnana.03@gmail.com>, git@vger.kernel.org
Subject: Re: GSoC 2024 [PATCH v2] Fix Git command exit code suppression in
 test script t2104-update-index-skip-worktree.sh
Message-ID: <Zgw_KJ3wO-x2LXI0@tanuki>
References: <CAHCXyj1hUVNNuCOgsNv4GJUi79_o9iWZDvV8Ocz3DodreYoL7g@mail.gmail.com>
 <ZgvmoSOPs6FG4jGZ@tanuki>
 <CAPig+cRtzbv57=k7ti0YcsRR05gz4v_gExgwi6qCtT6f0i2oKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4H1pdUzryxYQ7A58"
Content-Disposition: inline
In-Reply-To: <CAPig+cRtzbv57=k7ti0YcsRR05gz4v_gExgwi6qCtT6f0i2oKA@mail.gmail.com>


--4H1pdUzryxYQ7A58
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 01:20:53PM -0400, Eric Sunshine wrote:
> On Tue, Apr 2, 2024 at 7:06=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> > I assume two things happened:
> >
> >   - Your patch may have changed line endings. Please make sure that your
> >     editor writes Unix-style line endings ("\n"), only.
> >
> >   - You seem to have changed indentation from four spaces to two spaces.
>=20
> Micro correction: Documentation/CodingGuidelines says this:
>=20
>     We use tabs to indent, and interpret tabs as taking up
>     to 8 spaces.

Huh, that's even weirder. The diff changes indentation from four spaces
to two spaces for me.

Patrick

--4H1pdUzryxYQ7A58
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMPycACgkQVbJhu7ck
PpRPWBAAmI41k9eqP8V/0RnGbrXtJ3xdsab0sStfXrBimtYyRIByCgDBdxkHx3pb
HvgdM/xXiir5IXBNX8yx93ldNr5nEfomLZ0JSZFob72wbKNkQImXqEF9UQ5UKUvt
g7tkn7TNtnk6Z+egt+ONN9DqmFfC0kOgy/odWP7WvnRlZ0NwZN5GhfNmzSKcIiGd
+ohj4WH3NNqZ9HXiFh710WulfPdsaRvVhLOAtMBMpecnVwMd7GmxCJpKI8NbIRco
3sphNPYhw+24yNnZUTS+JSvaPan4OiLaIaJq5zk0PWmM6N1nJ+QOfjwIiw+1A8Ew
7SxA5FzOiAsa9MTpE/35/uHwodxuUpEduYlRNty6E0AugDQ3jj0WZzdYEQHoty2O
5Fuqkxj5BYR4mcVSQWYc+kHbxKZ6zpseAB38tJgFJO5/ewrzovv2zGEsZNSOR4Xk
ggXYtLJGKUsosZAkivnWyT6qZKGPW2La7aFuvzk0MmiUzGgD+eKr8ZnHmWfz1eK0
ysUxWsAzveOqNNnokiBGaeiuq83znKviXl3+TKnNRQFBU7tkdl+owrB31DPXYDFm
RPP6Z79JBfaPIuBCuoJ/vyR2JcHuNwUuultiss51Rs0966OQsenSRfA24+n3wp1w
FhodT+WZdetXI0/9Al8tEW/6bVUfF2tqP6IM0OHTA8LoDt/ZxIU=
=OAv5
-----END PGP SIGNATURE-----

--4H1pdUzryxYQ7A58--
