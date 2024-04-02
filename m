Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6030218E29
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 06:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039313; cv=none; b=jkL8rezYyQZq3va5hF95erp0IyQOmfn1dvzPWowFvMkxKFxAszrAF08emUYW6lenQP/j5ud0fbq0btSqNPxXXNeP4PhT6M24NIjEMS7JGe+yfmeeH8QAZ8apbOQ0bdVgfahO5X3Km8GIf+32XxJyaGR2VimnP30zz9sXetpofu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039313; c=relaxed/simple;
	bh=R7scrnjkRT5F3ql3DcKpLVaKGgO680Z74P90rnkBBpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjm2WZLjy/xPJtgzPC7IDAB2bjDcQaoVXbt4LoDFJYTzA/LlvvrhiSzPsU84B8gaMpwLpMd3+9ZYoW5ziB2o2wpxbm6ghjzfaNEzEedzEXj9cbxsdSzF1RYEm/U1ckgwzFWOmSv9/Q9SM2aBgUU2DixAnKgz69PtKX9gjymqhDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MhFGZUdE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=La8HB5IR; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MhFGZUdE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="La8HB5IR"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 1A6F732002D8;
	Tue,  2 Apr 2024 02:28:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 02 Apr 2024 02:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712039308; x=1712125708; bh=yHjcAqlmcv
	6z6GFQVH/l351xTtufG7SabjCq5cjSclA=; b=MhFGZUdEO72AtnN0YjfRQkBZ/j
	DIjdK75fkvxFe94NOHNP5qYYbnm9EocQOzblrDWqJ8ueJ4xkdHKo+rfZ0KoEk3qT
	xzz9UIK/yp4PFG2o2WgHf3q3zFw4Zrb6Gv5l/821ODoEatwAJZFIUVIXvrq040te
	ZumH7sxvwqcF5C4bpRAuR+jzsTzEQ2LezuxhM65VH5pm1mD0+GEjQZCWNiv9nmn0
	McP5l95bKKHADjjDqm6nQzOeej6gvMFMhfV5Fg9fCv8Z1aNGP2Xsbuup+6qrN0Cq
	/BIHIsvWfkKTal77NxBzZMaPikHtsFLFwDO/oa7LSC0SPTXfF5cwNJyyxeNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712039308; x=1712125708; bh=yHjcAqlmcv6z6GFQVH/l351xTtuf
	G7SabjCq5cjSclA=; b=La8HB5IRC4AQwSm04zo3CdfQ2vUDC5vxsIKmY68XFA9o
	gOx4ptIzuPIZyXy/Rkf5kUT1zSiIBi7P6SzreJdjGY8Z0646E4r+9WhPvVM5kBWo
	ILUghtbyqXjj9kNg4NkySKWQOthRIKjEUyAFYsI64GTMGrbcyIsJu/QCmHTrr4JS
	u3eMhkh6062i0rK92yADtA6tPQcv6stMblfPvMXPrTL2DgEcSAcYqnAHK3AVf4j3
	FRWq5camPZDYe5XcdZbF9XZRbTh1WvEDelL5T+iROCe5StVm553fdTyLCJqtHsHo
	+bx1wfk1NQK4d8Ez8Jl0luV3IU014U25/031ysRqKw==
X-ME-Sender: <xms:i6ULZnu5-fmLGQGDmReBhQSh9BFKHoccjvz4O9MF00_UmlY4yGf4XQ>
    <xme:i6ULZoeXUrvSPSjb5b5Iok8BSHv6d2vKLTUOeOmV8hya6eRCHKcApnL0rVygNFrU2
    oCu8jpJXNPualc_ow>
X-ME-Received: <xmr:i6ULZqwmIrDtXYPTqjPknLyZ0Mz220QF3RC-F4zpaek2RI_R9jWrbLR_7tr-nHn6dZyN297XOgyO9IzIclihHlOtTaX1Zjq9E_8QPx5tlUpmTjU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeljeetffevheeggeetkeetieduieeiieegieegtdffheegkefhjeehfeekhfev
    leenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:i6ULZmNrvMAQKL6kU1E1JBhIqdCEhss1dCcnJ6uMluUqWvr6mBQcCQ>
    <xmx:jKULZn9vPG6RKirlF70q_qUqtYSB4lAp1Jb8_KmhhlWaz4YCzvJABw>
    <xmx:jKULZmUv4qf7R7ydR1-7ChBTsfREHxl936q6pQLzm6K45jXiyYJAZw>
    <xmx:jKULZod9nGta28tAq2wqykG5m9Om9k6MnuVYoXDzZSS5_Gz_nYirSg>
    <xmx:jKULZqXtjrOXAdT-eZl58oYRiZfhmfCdOVI6rmgzmvLUT26OkzyF611zkiF6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 02:28:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1aa178b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 06:28:17 +0000 (UTC)
Date: Tue, 2 Apr 2024 08:28:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Tan <jonathantanmy@google.com>,
	Emily Shaffer <nasamuffin@google.com>,
	Pablo CHABANNE <pablo.chabanne@etu.univ-lyon1.fr>,
	Nathan BERBEZIER <nathan.berbezier@etu.univ-lyon1.fr>,
	Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>,
	Matthieu MOY <matthieu.moy@univ-lyon1.fr>,
	Linus Arver <linusa@google.com>
Subject: Re: [PATCH] docs: recommend using contrib/contacts/git-contacts
Message-ID: <Zgulh1rxl9Af-iQK@tanuki>
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rbRfhJYT9E6JbnPl"
Content-Disposition: inline
In-Reply-To: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>


--rbRfhJYT9E6JbnPl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 12:20:05AM +0000, Linus Arver via GitGitGadget wrot=
e:
> From: Linus Arver <linusa@google.com>
>=20
> Although we've had this script since 4d06402b1b (contrib: add
> git-contacts helper, 2013-07-21), we don't mention it in our
> introductory docs. Do so now.
>=20
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>     docs: recommend using contrib/contacts/git-contacts
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1704%2F=
listx%2Freviewers-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1704/listx=
/reviewers-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1704
>=20
>  Documentation/MyFirstContribution.txt | 3 +++
>  Documentation/SubmittingPatches       | 4 ++++
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirs=
tContribution.txt
> index f06563e9817..eb1e27a82df 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -1116,6 +1116,9 @@ $ git send-email --to=3Dtarget@example.com psuh/*.p=
atch
>  NOTE: Check `git help send-email` for some other options which you may f=
ind
>  valuable, such as changing the Reply-to address or adding more CC and BC=
C lines.
> =20
> +NOTE: Use `contrib/contacts/git-contacts` to get a list of reviewers you=
 should
> +include in the CC list.
> +

Should we mention that the script can be passed to git-send-email(1) via
`--cc-cmd=3D`?

Thanks!

Patrick

>  NOTE: When you are sending a real patch, it will go to git@vger.kernel.o=
rg - but
>  please don't send your patchset from the tutorial to the real mailing li=
st! For
>  now, you can send it to yourself, to make sure you understand how it wil=
l look.
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPa=
tches
> index e734a3f0f17..52d11ff510b 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -459,6 +459,10 @@ an explanation of changes between each iteration can=
 be kept in
>  Git-notes and inserted automatically following the three-dash
>  line via `git format-patch --notes`.
> =20
> +[[suggested-reviewers]]
> +Use `contrib/contacts/git-contacts` to get a list of reviewers you should
> +include in the CC list.
> +
>  [[attachment]]
>  Do not attach the patch as a MIME attachment, compressed or not.
>  Do not let your e-mail client send quoted-printable.  Do not let
>=20
> base-commit: c2cbfbd2e28cbe27c194d62183b42f27a6a5bb87
> --=20
> gitgitgadget
>=20

--rbRfhJYT9E6JbnPl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYLpYYACgkQVbJhu7ck
PpTJhg/9FQ3+s/NS76zQCpf7UdOFotdBLsuq4jchqm2jUk5IjY4qOTL4oXevYft/
bzE6aw+TgISnxjSDcaUyn2BYnmnEjWVSPGWjHkxByzRzZI9FsFETBDh3oczu0PcB
GbcfDheR/DIcbshfq6DPlnOBVLQQ40zY5qKTxOEpEkps3KLGmjW01nYjmMG4T1bU
OP++GKEjtIYRKUDelLE0AV/tV6oNWKmiX1/e0lZIBqNthPAML682uebnY6gfu2i0
yAT0Df+c3zomKuF1bP+8+1aOOYh/q/4d1mf32ZTngWAm32YRMZCWM26vYsQC3BTB
qhC9CYOV8t4YDoH/M5cHhAktBQFmyv1pa6gmwkEZbNUTYee8S8mTuVwBeVttCtFI
9lbjMlHVLjUS33e2gN+ID4UFN7yaCdCb1LT6x7NpkADfyKJh8y6ZZvN2QwQW9+sT
CcN7VhxOEQDYbteal+M2IQ1qIR8QyZfIQgtNdSbmtZKy8iM+f5k4vSmAhtFAT6Zd
UlGVx9ckbbBZwBfT0gWwVMcp4oI40OfVdgBQEmW5BlXXnP15XTGlc+weWCjjPX3/
YQLJAjqiQWN0+64RYBmRQqbT0NAkoD2CVb9/kQYT7t1hxpCM4URCJwWiLqOMQhj7
FX5GxFdnHK5wMafDYA2gekjJZex55L50O2ZJgXD0/xygKXdiJbI=
=fDAl
-----END PGP SIGNATURE-----

--rbRfhJYT9E6JbnPl--
