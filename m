Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D71152165
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728252614; cv=none; b=qArawrSQxIOTkVSOeQNtvfHE8On+Asqsgk1LlCHM9izIJHoaJEIk2+nmF7+offdx9nspyT6a7px87G+OC9UT5ZMkTl03JmTM3Fntp1jJohkGFn16iNfBNlVvnfypNJSqKdxPLRnsbHoUOTB0P0bfq0eoySbV/YpkAjmqOXttuyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728252614; c=relaxed/simple;
	bh=Dx/voKq0ZSq+w49bxYhZkWwCoAja7v0Cuz4VjVOAQuc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKu9hkJpHc66PyReXsLwi9xArIdQ2Qqx5M3ey37hsuW34oKTkJJqhOkXkOBJ6zGIWuaFKY22a97M35/PejKAgc7w+fDt9eDWGt0931ohgfllPrE7HdBpOTi+waUWr45DsdII+qewdu02Cqb08fU9WbFxtlOb0v6u4YXmhaMP7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=JQ3yxJ2g; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="JQ3yxJ2g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728252610; x=1728511810;
	bh=Dx/voKq0ZSq+w49bxYhZkWwCoAja7v0Cuz4VjVOAQuc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JQ3yxJ2gN8Ez7LbIBDHROUCxExHPrXKS5Q3RZLp/JKQyC38Ub0lQP19kWtGgIpjdn
	 VBRxRtkvnl8u3cjm2MZgd2075HLT0easJGxXpYo1huUQ+TmQPxjvITKahBpzMEaKEq
	 n0eNsXrp5f0obNbLUPlJ2T7aVwcniq0inJUb2D9R8ay77OxA+aK6WGq0arW4wyFGqz
	 m3+1laksQFqreftBC7SOzX1dZsEWd8ESnUggQuAOuQq0HTefMVvg1mEU0K50kZcnxp
	 VxEeUWnh46wADCphipR6mdxwkGviPLzDnLaCYNtPUEDd6BjPw+RexGRCwQ/EeHPyMo
	 756Y4MdkcVgNQ==
Date: Sun, 06 Oct 2024 22:10:05 +0000
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
From: Caleb White <cdwhite3@pm.me>
Cc: Eric Sunshine <sunshine@sunshineco.com>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] Link worktrees with relative paths
Message-ID: <HQHFMbnFwMCxJ6lusWsy7qEnWtEwYovUv7x59Jh0BmuSjJyKiM7IbPOivNmLvA_9mm_YqxDfVfzqf2rUeixky-XApO2FdVeo48YR8O1_8WI=@pm.me>
In-Reply-To: <4bbe8ceb-2e72-463a-81a0-138815a1cf8c@app.fastmail.com>
References: <20241006045847.159937-1-cdwhite3@pm.me> <CAPig+cTE0gaD=7dwSqY4S+7AqRoU9yOrS4sdBoybj0Pfyk9vxA@mail.gmail.com> <K1lpl_AWj4xpiHLG9AloFDP7hkJ7Ysf-LA5H-OeP6suaBcES3WS6NTYZGX96oQuNQ3x36eEOxGdqlj3fG3ybrn5y3LRPfCNqC7yqTyvqVrk=@pm.me> <CAPig+cQE0RNLhktuja-BbF8WwZmKC3cox_GUC-o4w87PadDpgw@mail.gmail.com> <gX8RNUg1e1FCYFS1vP-uT4rbMpg21Ax07CZm5Ha7Dsk93EN6CTuXiLr3boTaoNEi71O1rDoUxhTs6KQt7Cvfz7B3KlbpZzis5b05KW7ARls=@pm.me> <CAPig+cR4FXsGDE9Uu04EjK+vOo-Pi_VwOub8+Dy3r9t7z8GdkQ@mail.gmail.com> <AtSpzKynOkmMPZ3bR4qx-eA93Xo-1miPCIQSxIKP534tD-qpDU1AI74vqB78RsukQ0XP5eKdvzHcwy_lf8lpL9wAoHoom-koo5GKcbrcuX0=@pm.me> <CAPig+cQZmEdx1Th9VAHbEkJ=zm73TP7Wuda_G5CzFw7j9HTFQQ@mail.gmail.com> <4bbe8ceb-2e72-463a-81a0-138815a1cf8c@app.fastmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 4a1d60522fbf250ddddeb9a15e028508cb8a3298
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------1a00ae0567235e785c92e072001dc69db18c74d05a6ea7e5b1cefd53d35c62ed"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------1a00ae0567235e785c92e072001dc69db18c74d05a6ea7e5b1cefd53d35c62ed
Content-Type: multipart/mixed;boundary=---------------------87e27aa3776e23837e82406cdc1f9c01

-----------------------87e27aa3776e23837e82406cdc1f9c01
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 04:00, Kristoffer Haugsbakk <kristofferhau=
gsbakk@fastmail.com> wrote:

> If Caleb gives us a clone link then I could try to send.

Here it is!

[1]: https://github.com/gitgitgadget/git/pull/1808
-----------------------87e27aa3776e23837e82406cdc1f9c01--

--------1a00ae0567235e785c92e072001dc69db18c74d05a6ea7e5b1cefd53d35c62ed
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnAwquCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAADoTAf/Vi0AVlolnaSel7lb/xcioNuLxUe6HeHwhNEmzzsTLjIbT5ck
Z5sfzJjWEGUydKRvnO5SUKv/sLIm8kmWtcr4dbB1jyXuuRXaNjp+DMeVRn1I
L92GbIPsui9DeIKO+0GJcyCbo8wR+MPWEGcirdLQQ+zrypWZSUTGqQ3ZFHIu
NeOJB2ZCWo7jjIjYDRCu8Bz+2iXIRNn9ialnTmKS0trf0Jo7tCpipxc4zQyP
MtrRDuY1fQ+gHT8nQLf2zEtF9nffRZs6QHoQJ9bM6chYdJgcrRTWBCDXFu94
AHjqmeSV7pTnfoCruJlhHGfYt8zctldwvyWhEaX8LtqRGlZ6AvnRcQ==
=ydzI
-----END PGP SIGNATURE-----


--------1a00ae0567235e785c92e072001dc69db18c74d05a6ea7e5b1cefd53d35c62ed--

