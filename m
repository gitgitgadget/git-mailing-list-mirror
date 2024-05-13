Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5DB148FE3
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594419; cv=none; b=gmS+byHw3+7aLHq5m4STF0OPRJfcLxZero5Pt88UdgoMP6NjUat0/MZ3VkDfrpZi58wGmhpuiz9DoZdlG5WClUKyIOmrH4IzVEB5DMv12Z50+t+42U0rL/LW5tp12vN+PSLebDYEV+VMjHbKQWLg3y7yWVbU31Iu6kf49zM7GiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594419; c=relaxed/simple;
	bh=Rr9UA6hHqWsMoAW6yhjYTVo7taKR7QOkcvOMq6g9vdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmfRY6Nt24TWgBYT5AOBS3rVCXC2nNUL3H2jOoIDp/xiFOvtKYb97+BunxnHBAfy8baX/jFiw89fcE8AjZ6scC6ZbzU2aJru4IaCI+qiwVIRI/6CiRDMcbskAS++uj1Q5KOfhHhLPgLhT0EtESfjKQ1OmZZkMm9qOARYdMTNf4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MHnqwuEo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JEDGEGVo; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MHnqwuEo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JEDGEGVo"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id AF8051C0011E;
	Mon, 13 May 2024 06:00:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 May 2024 06:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715594416; x=1715680816; bh=8tprjyt+/L
	36q54wmZ4UnUjtq74WlguCgf99iFj3Z84=; b=MHnqwuEoVGZmUjpxz5xyRVZGg8
	yVtdUwMzgKXXVeEgjfOkHY+EFie03sYBkYu+Szh/pw6bBVvuXL+4Saa7MYKh2O9y
	aMSEu3hNkOb18sB9jzQ4kx4FDWIZyz4zj9iI7uz3XTB0SNjAZSNKEKnTzKpCtCk0
	2pw7Fv1M+cpOY2ujQYOrajRdeebr23ZIz5bRTex/eK0AI9hgjsQzaETGDBMTo8e3
	ugaGP6CUy+ChMDLAIGuU1XEF+kYe6RPKA955EUPNt4/d4mMbTN7aKubUDEpRujtS
	uweNvX0DHYN06eBHyAUbnDSnHfVR0TZBDqwYjIRZGqZ7fy3+9IVw/rEeP94A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715594416; x=1715680816; bh=8tprjyt+/L36q54wmZ4UnUjtq74W
	lguCgf99iFj3Z84=; b=JEDGEGVoI6mU/5UQTyuwD7j3y/8IxEKfUGzKvuBlHwYt
	NtkheJrnQC+vyYLNj21tim+ELjej+3oLARjIOuoag86NRQXqlaHRwJEa0Xspxqpp
	IPZ7krAo8AH3QQhX2Szierzt2lfNwScg89m8l1akfrmQmnIrw68LeNBr0hbD2Di3
	i07B5z4AVcLWsFDDjhuCRg1Yz8y86enabxhRMGsrKnh8oqvTxcfkUCYyaAtISB1y
	iYZH9mzSYmN/3Lax2XWmopUIZu0l4W9rn+Jr1MgOYnofxjPVkoZO/GsNph1CNVoO
	wwZojXRJ0+KEwGa7SYa6mwULlekr+6OB0xyT+ev/vQ==
X-ME-Sender: <xms:sORBZsAWDZTT9RuSde9eMd9l-R7i9oXm4M_5Fb0r9LWj3hQblDrx0w>
    <xme:sORBZuhL-YyUYLcKPsv11BfVTigtbgRfiXSO78uOVHrwCJroIfPGC6XEMPMpBJYwf
    4teRdLyFRZMurEv1w>
X-ME-Received: <xmr:sORBZvkZmCH6-dg4H3qQOVZa4QL-aKMBlC9Xrkq5ja0aUDSpc7Sr1WgRkSOV9tsON8Ex_RxsvtApt4VM06wWfytqtab4ezCsQe0nG-SRQRkil40>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeljeetffevheeggeetkeetieduieeiie
    egieegtdffheegkefhjeehfeekhfevleenucffohhmrghinhepghhithhhuhgsrdgtohhm
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:sORBZiwxiBnTxPSAIn2sF8RyTa-A4KgmA8TKj1xncqrN4JHUTJaweQ>
    <xmx:sORBZhQ8_vPcK5rXzQULR9xmEREZl57QalQuWfKioIwjm94dZ4rkKA>
    <xmx:sORBZtYokIihTEyhkm8qXvizXNWuXOjbxoHRzNWSZoGxXtvRdBp57g>
    <xmx:sORBZqQ491XNTSlyIDTa9qzXVdLHzAhM841XTNazgbh3xszTdanpCA>
    <xmx:sORBZsc3xTKoWmACnzfPNi6JFXaMDDDovcPDEHRoPuJF9MKyeM51nfwl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:00:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e7cbd887 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 09:59:54 +0000 (UTC)
Date: Mon, 13 May 2024 12:00:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] compat/regex: fix argument order to calloc(3)
Message-ID: <ZkHkiBa2hSbjcmZd@tanuki>
References: <xmqqbk5bim2n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3h4COUpms57mP4o0"
Content-Disposition: inline
In-Reply-To: <xmqqbk5bim2n.fsf@gitster.g>


--3h4COUpms57mP4o0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 11:25:04PM -0700, Junio C Hamano wrote:
> Windows compiler suddenly started complaining that calloc(3) takes
> its arguments in <nmemb, size> order.  Indeed, there are many calls
> that has their arguments in a _wrong_ order.

I think this is actually new to GCC 14. The release notes include this
bit:

    -Walloc-size and -Wcalloc-transposed-args warnings are enabled for C++ =
as well

It's a bit puzzling that this seemingly only changed for C++, but oh,
well.

> Fix them all.
>=20
> A sample breakage can be seen at
>=20
>   https://github.com/git/git/actions/runs/9046793153/job/24857988702#step=
:4:272
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>=20
>  * I wonder if there is an easier way to deal with toolchain and/or
>    platform changes (I am assuming that is what caused this
>    breakage) than just seeing and then reacting to a breakage after
>    it happens.

I think the best thing we can do is to be proactive and be faster than
our toolchain to enable (sensible) warnings. Over time all the compilers
tend to become stricter, and if we are already as strict as possible
then chances are less likely that we'll have to do anything about
upstream changes.

But other than that I don't really have much of an idea.

The patch itself looks obviously good to me, thanks!

--3h4COUpms57mP4o0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB5KkACgkQVbJhu7ck
PpSSVw/+IiNnUZzpcACsNkzjMteyw/eSiX5yzqP5igYgI+9SAO6YZSfaoefUGbfh
knuE7ZhSEzYlbB4d+sc9Wc2aChbAQ7sbpI9ibvQVS2gXONQzEBznP4ryAc42Hji+
xGCFR7XfjipIt/G7/IfqmaAwB1ulwjTs+m2PY1iXd9TPUrDVBZxnO20fiuoz1/Gh
MTaU57gEzJDlDi3qTCYj6j81eX296YY9ZrluwVbJlR/siL/9Y+KgUWbWsCDVM/hW
i4ct+7qA6Kzhy6U4ZNOF7cun15dGyar19lyGPpc09FC0aK7Z0d0Io0gP3gnBLkAR
1Lg98vEqKAu0AzdW0oJtAW5PZEPoCi9iTr9RIKWjWfu0SgvKFC2VQIiYltXOqTux
G2Jab5gynfsW109m1WM3jq7onGOdUAO11Lqjkx4kYExSJTAwqkfGBxUTEClSc0t/
/YQJWbHVFTbhvUVxDnauMNyN7JdGPn2BaSWqfsUoQ7GqPeNx2TbYr4vLu9HXYPar
LXMGFgkvCZpc+gWd3M6WHuZ2j4i0ExltwzD6pt1ssO8XS5gyotiE3IkGcIUi2yK/
hy7WEsEVHBVokfSaKFYkTwp/g6fSTptiqmagXCy+tjMu3Qsl5uoKaM/Bm8rs72Ur
ePFwy5ZudVj5u5KULrwaa5I1ZEJwuudcyehLQtUxKYGpR7aUlf8=
=V90L
-----END PGP SIGNATURE-----

--3h4COUpms57mP4o0--
