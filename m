Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D45548F2
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711614089; cv=none; b=Gea3NODTG34pEhgYKWyWk2rTTeRL7lvuTUt4pr3QuLPqYJXI/gi+ywx7pWfPsTMwXZFiGIWOpLmTC7o7lDSD13UZ9S017Di6koxuxipTNDddqsTBnMFrAocHHa14c8rHKSf4KjPFGvK+rDUCzPS6wMRIfWuPUMRUegfeIsXMsgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711614089; c=relaxed/simple;
	bh=zcEMjNHh1g7erba6SSTOFXodgTJXrG44smdR8JWzizM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lb789gp8oRHc9Th5uVeCdjsre3XDyD9KcGaNeVWVJ1/osf64YJyiTWF5fDgAs1cpIjM73eQ8ikkMZZXUgkdQCNpyBsZFi9ld9oSnZLFkLFTUp/OwY7Y0RnTBPd6n9sGl0jtn6AEZb6kpiEU4tXBQ3snM8byvDk3ih7RGaJnujdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AdXuHiJ6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CL9YBhgE; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AdXuHiJ6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CL9YBhgE"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8EAB51800082;
	Thu, 28 Mar 2024 04:21:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 28 Mar 2024 04:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711614086; x=1711700486; bh=uh4IsyFddU
	O2gqdcqsaCs/mTRL+3uoysYpUxylGWmC0=; b=AdXuHiJ6UeyKbVKtxFfJ4vXaKM
	VO8DcNNs/N/4LBDgiDuB2/c3Zhwh0WRcq7hSc4WT1oOf83Qk1GVNL3j8VqdgvNzG
	bF3xRe5DK6WPlX/K15/jeYKFFosIL8HRRYHywi2c1337h2r/KFnmNawjKRq8TS6X
	l0C/+fnLduTaMOIo0Rd+i8M3ab62iZ1to0l/Pld+CpfMgN7ZLNa7/k9AFfxNTVLS
	vofbOug2c7UqvkQ98ukb6/k9IjYAgQyyDtvISXzNcGrJvgMhwOibaZalQeEMUorj
	oMYw45vR6WKECtU3IPZPepQYIh9LGWTBMzScbNo+NETlv72rjTfkcAhF4XQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711614086; x=1711700486; bh=uh4IsyFddUO2gqdcqsaCs/mTRL+3
	uoysYpUxylGWmC0=; b=CL9YBhgEtvQ5bqobYb6j6ZsE92MpK94v4cklwJudxQ47
	IWaCXt7X+lIrNgnii3HZnUythd5NrGgq60eMNYigBKCIZtfJ2QbOiLz84lGqoEDb
	fy2Ym/glcjkCKCn33RgGGK7WJ/ud1Hhd/dKKdS8OU/nkcyc57S2H6PXKU3yR1zHA
	/Rd0WDmo6bOMKciyDM/2IfFJU8lpJrWTjE6AY0KY/8XOCWbwYcZUrIPWFeCA0w1V
	UaOGIVg0nJXQ4142s6O9R0Pmdx9kHwfbgDr1mMSPo04AV3mYPYy0dk6axhwDubN9
	rYV8PZsV0HZPIy8vK4BDENt+Mixh5B+deHbr3A8CYw==
X-ME-Sender: <xms:hSgFZvb62RdHmn73Nq8KoYDqVkYimBH6pj6xK6I4pNDmIprSZ0ofhA>
    <xme:hSgFZub6Bva0kEPC_d3WY3SM4CH6LsWAIeNPJL4-ZjFGSUov6iHKJRc5TiPKy0zwP
    vwQgimMM0fCj0CH6Q>
X-ME-Received: <xmr:hSgFZh_Qy72-l7OS1ZeE1D1t9ZaaPEmwohIhkqcL8oCk8yttYs23LFc4nkzWUGjoeih5Nl4G4ZNPitMCdAroPj3gPZxwsbZSW2A_xDk26bzLRZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddukedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:hSgFZlrjOvCe_Ck2qo5mFniQnglmu2oW1jjyVCABzzG6oSbKW_rYiQ>
    <xmx:hSgFZqptkRAO8-fqfk-QjoydUtU2exeUk5C4RzV8Spyfp4DxmwzegA>
    <xmx:hSgFZrQJEbzCAOZn7TS36yFp4nmsY_WtEoqumapQAqrNlEWc747ONA>
    <xmx:hSgFZiprht5_lf4hGKmdFf0Wudw9DXw8FG_AMN4YhvGRCbwZVYjzrQ>
    <xmx:higFZjl15hN6LD7AO9xOzfHahiNbNCyK4Khycgz0W2cH0JX3az2rY3DGvpU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Mar 2024 04:21:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 28e6578a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Mar 2024 08:21:23 +0000 (UTC)
Date: Thu, 28 Mar 2024 09:21:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/6] fast-import: document C-style escapes for paths
Message-ID: <ZgUog3UFu3WIc0L0@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev>
 <20240322000304.76810-6-thalia@archibald.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vhTAkfzQ4Z89/lsd"
Content-Disposition: inline
In-Reply-To: <20240322000304.76810-6-thalia@archibald.dev>


--vhTAkfzQ4Z89/lsd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 12:03:47AM +0000, Thalia Archibald wrote:
> Simply saying =E2=80=9CC-style=E2=80=9D string quoting is imprecise, as o=
nly a subset of
> C escapes are supported. Document the exact escapes.
>=20
> Signed-off-by: Thalia Archibald <thalia@archibald.dev>
> ---
>  Documentation/git-fast-import.txt | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-i=
mport.txt
> index 271bd63a10..4aa8ccbefd 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -630,18 +630,23 @@ in octal.  Git only supports the following modes:
>  In both formats `<path>` is the complete path of the file to be added
>  (if not already existing) or modified (if already existing).
> =20
> -A `<path>` string must use UNIX-style directory separators (forward
> -slash `/`), may contain any byte other than `LF`, and must not
> -start with double quote (`"`).
> +A `<path>` string may contain any byte other than `LF`, and must not
> +start with double quote (`"`). It is interpreted as literal bytes
> +without escaping.

Paths also mustn't start with a space in many cases, right?

Patrick

>  A path can use C-style string quoting; this is accepted in all cases
>  and mandatory if the filename starts with double quote or contains
> -`LF`. In C-style quoting, the complete name should be surrounded with
> -double quotes, and any `LF`, backslash, or double quote characters
> -must be escaped by preceding them with a backslash (e.g.,
> -`"path/with\n, \\ and \" in it"`).
> +`LF`. In C-style quoting, the complete name is surrounded with
> +double quotes (`"`) and certain characters must be escaped by preceding
> +them with a backslash: `LF` is written as `\n`, backslash as `\\`, and
> +double quote as `\"`. Additionally, some characters may may optionally
> +be written with escape sequences: `\a` for bell, `\b` for backspace,
> +`\f` for form feed, `\n` for line feed, `\r` for carriage return, `\t`
> +for horizontal tab, and `\v` for vertical tab. Any byte can be written
> +with 3-digit octal codes (e.g., `\033`).
> =20
> -The value of `<path>` must be in canonical form. That is it must not:
> +A `<path>` must use UNIX-style directory separators (forward slash `/`)
> +and must be in canonical form. That is it must not:
> =20
>  * contain an empty directory component (e.g. `foo//bar` is invalid),
>  * end with a directory separator (e.g. `foo/` is invalid),
> --=20
> 2.44.0
>=20
>=20
>=20

--vhTAkfzQ4Z89/lsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYFKIIACgkQVbJhu7ck
PpTfew/8D4Fw8J41iZJI4UWbyDAWuaTjKzcvecPHB6Nv0sQ69+rwB9etr6pz1xbB
ZTeWeWgWl6H7rplvm5JPmoY+kthw1OjZLnyYPv4QNKSDsZAIR/v8OAIuZt2A28PJ
RH4VdU7yPS9IHBW9hVpplX2hFXkQPeXTuYXhko9tmUV176u8cFrdzxcG3/ZUr4Qt
RNxFRYMLoB6DDt1CpxO45+NpkockuTP8KhLmwCa3janPiiht0SJc6FeyeSeptQZD
+Ce7+1t7uyJ4jI95hR4W0VDRkOt2euC27hKLNxRnnOzXXgR+XhsbYp1hcOBUzA9Y
jAlozJnrX5/qS1icliIvTxY8fstCH2GmH+16DffouXG3r6m/NM1PpTBMXR8WCEfZ
V+jonfGpqa6Ffx11Gl5MMIll+fOXiaccWRHf0DAoxdg6Tar0TK1rZd8HQdkhHXRj
f2gNfHh4UjOKa/+qb9+W2wy6bx85m9s86l0e819CXHNwBsHjK0EvBINlYbggNEKz
Yctax/+pY0JoWY0nE5++UA6SLK3manmuY1Z0AadFMnV0Yn2F5UXMJrfXNGW4N/lD
3k54tgXcnWBwZpZnkY97BT2aPLGnHA6uMqBUrs4LNUVYSeUQ9ykVy6nfvmtudJIO
YdGm7RHbRHmz1JBTbNkgOhLUKFw+ILac1nle6am07U6Qe+9gEDM=
=gsG1
-----END PGP SIGNATURE-----

--vhTAkfzQ4Z89/lsd--
