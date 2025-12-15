Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6BA2459D7
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 07:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765783386; cv=none; b=oMEJGAKJ6RHy4ftKf2gh6qB4COlI96hDgMqgvOE7btp8kn66g22ZkVojaa65Zb2lkpZ5tUBpFXL4LuotvlPfd/gjFYwhFYnKyHVDv9v74PUQNoBlKxIwFjEO2aymbtoDhF7bolH7yakNYskpzyRFYXXW5PWcxwc7SUqHyphaLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765783386; c=relaxed/simple;
	bh=eOHudZNFrYuZyuyQDM/o8DJuHNFDGXUXkQelg201xWg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVFNcLtbMl/lN3sAoSpmythrtguWlIa7wL2VhjcrDwkc4sOBSBnUQgNp342sr0oKT60JWnL2F8Rdx4Tb4Raj9ExjooA4n7Z2OP697vFSCrgJQ8+sTCBlXy2uLRpd1Q1zo1XbuDnaPvC/xl7bS4kgQwbZ14ICqzvBncitU8h1dHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TvrnYBIg; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TvrnYBIg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=3niv5hfr6vflnobdkhcjtg2ofq.protonmail; t=1765783380; x=1766042580;
	bh=eOHudZNFrYuZyuyQDM/o8DJuHNFDGXUXkQelg201xWg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TvrnYBIgvcLevh/MifcBATIBxM+ei4n1pqUdusDl3RC4Dyqzff0w067xsuk0HFsWB
	 hHloEBbAtGkPYyHmIis/NJwVMtkn6/ED8DNK4Q5lXUlTgpvPiEIl1voeBBwXYLGAR8
	 b3SCrtrqkUAg3GLMt2i2Dxk2qGiFltQb04RsOXzg3dufiAsS8E6OEb2ijwQsTJIZPo
	 bixnIC4kmlgVTPte3HCTY0/dFmEutG4cpRlucgVi/mN4uqTVl9TXKWqa+PVawKeyhN
	 QC5gBMCCPt5HIyBZ0BeGBgjxlbX+SHsI+d00hWbptPpq1hNyiWfwyC5JDOQC8SrWfS
	 wxHDaHv1aMalg==
Date: Mon, 15 Dec 2025 07:22:54 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Koutsouflakis Stefanos <koutsouflakis.stefanos@proton.me>
Cc: Johannes Sixt <j6t@kdbg.org>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] reset --hard: warn before discarding staged content with no commit history
Message-ID: <inl6W-7dpE2-dCPugnjAM-X01zhKAp5niQNigtqe5EVKEMEy1KEPFegzDC1zjpm7etuqAoVjg1gUd8_5vFO90LhaGmzLc3HJTE4MREXtzH8=@proton.me>
In-Reply-To: <xmqqwm2o8x0v.fsf@gitster.g>
References: <a5wKtD6Tn0gzcba1IEUhukYnXPHxMwPq6puQKIPywmjNufi5vc6vX-v5BpPJ7qj_zZsuXF5FiS2gbpsurWmVjoWHtMm8A-kAbaZyjMfrTcs=@proton.me> <xmqqldj9g0pj.fsf@gitster.g> <0lbeTWjDGq8hINMi-lj65HLgAIlUNZe_tzANStd9xxHQqAyZaEnaA0yPzVeY_VcReQIKNjY7eBEUGwMGvlbZ-0W0QZpux22cIHnosa0eX_k=@proton.me> <d318c46c-fbc3-4e47-8c3f-165ca9a26225@kdbg.org> <xmqqzf7ocrhk.fsf@gitster.g> <Ai2bA2Zt8bsexgQEIKg1vK7-SNNhTlsmmFp_gOJp8IKX9dJME7UC97EtqRhAUfD00sFmqRdHg9xgGW82rikrLIDUIswrUPr3RKm-LQgGuNY=@proton.me> <xmqqwm2o8x0v.fsf@gitster.g>
Feedback-ID: 140350232:user:proton
X-Pm-Message-ID: b1593aaf35d13ca55ee634668cee3245645e5003
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, December 15th, 2025 at 01:27, Junio C Hamano <gitster@pobox.com>=
 wrote:

> Inconsistency.
>=20
> Treating "newly added files" specifically is making the behaviour
> inconsistent with others already, but doing so only when you haven't
> created a commit or after doing "checkout/switch --orphan", which is
> essentially what special-casing an empty tree case is about, makes
> it even more inconsistent.
>=20
> > If it is about breaking existing workflows: any script that
> > automates either of the two use-cases discussed would be relying
> > on behavior that is almost certainly unintended.
>=20
>=20
> I do not think that is the reason for "special casing an empty tree
> would not fly well", but I have to say your view is too narow. I do
> rely on "reset --hard && clean -f -x" working in order to make the
> working tree spiffy clean, and I somehow doubt I am in the minority.
> And "reset --hard" MUST not fail in such a case.
>=20
> > Such scripts
> > would fail, but without data loss, and give authors a clear
> > signal to fix a likely bug.
>=20
>=20
> And most authors will consider the "bug" to be fixed is in the
> degraded behaviour of "reset --hard". that does not do what is
> written on the label Then what?

That actually makes sense. For tools as versatile as Git, it is
sometimes hard to see the bigger picture and the different ways=20
of people using it.=20
I'll drop the proposal, and thanks everyone for your time.

-- Stefanos
