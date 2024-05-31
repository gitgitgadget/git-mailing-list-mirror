Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2C37442F
	for <git@vger.kernel.org>; Fri, 31 May 2024 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717142197; cv=none; b=aW2g7R6XEe2vgOt+Lf33Hg54eE/LRkYtacO39V7df3y0sudHwBH4Sm5glxcFgDfGifCD61AL/RtxAsLVDX3dq5YlqIZPpG2OkP4y8GuBXux8NeLGK5p3uVrnwvVdlaCplloLmba6KK1b1mXpbu17e3wXYJJBKvezIWr2QpRFUPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717142197; c=relaxed/simple;
	bh=v+lsM8vR17UcrKGvr90zf4xwPfHvT0G59LhMOIrwFL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udCClbqsVkIxmpgj+bXi3ivVErrfAcl5AISt4UAXtimLqPHPNnWM1FjOwW7jNWsRwdKXFnjYw7yj7DQGIBLbb2lVmJk+nIXkCi+9iS19pgoz67kPDigIDU+aU5RP69qzagM5RurkX/5035M3423MH4aIKXgDSYGWcDn0V6msrPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QnAyytBn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R6H9EO/Z; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QnAyytBn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R6H9EO/Z"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id CE1D31380117;
	Fri, 31 May 2024 03:56:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 31 May 2024 03:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717142193; x=1717228593; bh=JwlicQyUKX
	mgdFhfWiO2IcKoPOc6fx5Mlsg7N/b9Dlw=; b=QnAyytBnAAOqa//vZySVqJLbaI
	2RUzMBPwVP3GYQeyBhed7z/FPswc+Ws+xMkkV4E2yiAGcUQAv35/M/BWzNn2ROkX
	PX3/M5v7gBchiNExPemG/ApLtRikf1lai/j3wBtJb4kDh47FNojzcTFGWJhIfk6F
	/FG/T4QS0xunTWD2rI13Qcm7UW4AKMCkghGZUtlbO3zowbx50mwW47uROifhsanl
	sqZzGxIg0cn0ITVEqbnGD7ASEbTgz9jG0BI7/ZqaqTuiHUDmdr9HZJBSWYdIQZX9
	q1FXjUNkDwT96XphIjsmoG+/wBhQ4t5/shaqNNgXgQR1OZeTb5bcFWPlzpKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717142193; x=1717228593; bh=JwlicQyUKXmgdFhfWiO2IcKoPOc6
	fx5Mlsg7N/b9Dlw=; b=R6H9EO/ZA5zSAqdrtp+gbG3eoHlL0igRw8clNSuw69FK
	CtbDSqWlIJr+JZ47Og6dfX36MfoeR4Z3v5QBmwEoXSJZfM200Qx9x55PItjxTA7u
	7nUtgSsMhRhAWWXVAa87jLr+LSNjwbG62kQvQELS3JubXQjGluXLzlZ1gO6eFQKM
	LubHVNa0oBcPLgipw4TQ/DC2uUujwuyKUILFiEpiJ0XlYRrDBjq91LhEjzwyATmU
	rwk/pWm6xV1HNXw8viNS6Mu/rML0cPMLl9MlByWZl20VmNNjcFRnly0A7S7ood/1
	H975qYPFZMLueSlm9bBGR7Lt6wIiexbNMrMjMfjTeQ==
X-ME-Sender: <xms:sYJZZsntJB17aM-ee1P3jXnAItomrkZrWpqasXannKc64zzzMnpyPA>
    <xme:sYJZZr3wnWHABgPySDM7OxogKzUgXn5dygcTByLqzXBcBZe8dwlSSVbTfnAkgVeYk
    kN8d2gKnOJppGxdAg>
X-ME-Received: <xmr:sYJZZqqmJULL0R8ESZyhNlmKFvtQtEpx6c0m88VbVjtLWAV-VvfYyTmatkCSIxY_baM8AIqeO-__YPpmpArC_N-OAyFEt_sOi11ePFYIPzb08iE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekhedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:sYJZZokeYFPbpmsGADznz-qtmVSMPQPVtiFS9-KgSq-bsNXt0Ffviw>
    <xmx:sYJZZq3a6wvSDn_x8bqh-jLBjrQzFcSXrqT7wy7-6mT3MFhIN7AVug>
    <xmx:sYJZZvslRhjrcm52AnFQELdMJrjcNIWlR9kpRt8cBeaOYRBEdXHKdw>
    <xmx:sYJZZmU__3uax99iysJrV2ZXpTCGzWU-uYjujImseXpVc6MXtAnIvw>
    <xmx:sYJZZjkkCe0dP9XsXRdbYMGcODA50gj6aLz0Gj-5sKbsrTuEHZkH_8rJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 May 2024 03:56:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6b522649 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 May 2024 07:56:12 +0000 (UTC)
Date: Fri, 31 May 2024 09:56:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/4] docs: document upcoming breaking changes
Message-ID: <cover.1717141598.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="19b1IvD6cpZLGUh4"
Content-Disposition: inline
In-Reply-To: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>


--19b1IvD6cpZLGUh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth version of my patch series that documents upcoming
breaking changes.

I have restructured this series now, booting out most of the proposed
deprecations. This is not because I think that those deprecations
shouldn't be done, but merely to bring this series into a format that
can be merged.

The first patch introduces the document in a skeletal form. The next
three patches then introduce one item each to the three sections that we
have in this document. The intent of this is to start out with examples
of how this should look like. I have tried to pick topics which may be
the least controversial ones for each of those sections while still
being interesting enough to demonstrate the proposed format. Let's see
whether I succeeded with that goal :)

As said, I do not have the intent to shut down any of the other proposed
deprecations. When this document lands, I'd encourage folks to propose
their deprecations in standalone threads, ideally together with a patch
to "BreakingChanges.md".

You may have noticed that I dropped the "Upcoming" prefix from
"UpcomingBreakingChanges.md". This is supposed to reflect the fact that
we also have a section that point out features that we are _not_
deprecating. Those aren't upcoming, so I thought a rename makes sense.

Thanks!

Patrick

Patrick Steinhardt (4):
  docs: introduce document to announce breaking changes
  BreakingChanges: document upcoming change from "sha1" to "sha256"
  BreakingChanges: document removal of grafting
  BreakingChanges: document that we do not plan to deprecate
    git-checkout

 Documentation/BreakingChanges.md | 113 +++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 Documentation/BreakingChanges.md


base-commit: 3e4a232f6e3bd3b7dd920bb07b21cf1c8b4e1a7f
--=20
2.45.1.410.g58bac47f8e.dirty


--19b1IvD6cpZLGUh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZZgqYACgkQVbJhu7ck
PpS2jA//Yj1mN8gcexVZI/3X6byGP3V2Xms0bWET5oT9ZY3M1cCs7HCQZ2Qsy+CA
B/kF9ufD22CvbHCiPEeMXsxrJVhlEN8qMV3QgYrUl0aDQYyXsVu9j0u1l0u3bNSt
SzbL+V7PDr08AzaFGeWNhvmyA++4FnS27dAN7Yr0FFOiOuJcor8H1aFcWm/Z+SmH
RIb1+SWAqExumNnsZfQtZ4Xll3juOjC5YayHPxXrzcoiaxcu44xdPT3/DlilYqUr
kCqPokrbjn8Ox2AXFsnO3v1uAjIq5hdUU0j6mfRu6SImjsC12CLOWjESod13tVyQ
FBrbroa7uI51f4vfSUHPJX0M9m7ad1+i1zyoj4v6YZ0e+GYZzLkCy/q1EX0th8KQ
vFrnEpffd8S6my+YkcqxjU2R+q8j2nY00wizMdGIRQnR/Yq93WA3NfhpVUf247Sh
5lDqEzGEIaAZ1byJnp3puGJkAz9jgdO1Z3V557mP42ePolQyHS5TJv0ZGAbqxS2l
fJP7dGHw5fuAwPdtEdB1jEBeCsyBczfREy6ktLfsAKNiaGf83llAyAufD1l23ScA
q55Sj56qbIHBa8IhMREQVUCZFXUTqNHcFStKdEY56kCEsfTEEDyJTrTLp5AxvklH
dSaLKmTmjiryYqER4r7IvWlKNIVtv26DvN0qwYCjF3uVu5RzTuY=
=mNgr
-----END PGP SIGNATURE-----

--19b1IvD6cpZLGUh4--
