Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A9B152165
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728252523; cv=none; b=rRTcJFREsEvPY5gGBSIZiKqzLGyUuSqM4+MwsaS1Roc8kWoZ5IakZsRDsBbp4+9HJe4nunRmXObviltfC55cuD6TihzV3Eqia8dzPHgnFxi4It8wqjGAGnVJMQz2Kg4DeX/GetteUKWvDfgxoQkO9izrVrTpN0Qunotdm8V1QFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728252523; c=relaxed/simple;
	bh=WUVVZHmxo1kC+9azeDpwV9R5t6bB6Cz+ea/Pjz1/BkA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMwmvad8XZEgHJ8duJB1n/26Q+rFRoxrZ6tzjXUcjAZ09yf/Z22oS2RbXzgUhroqyzgTOw93pSkkXOKtrQOTm97ludy4NkZRvpEoX7rnzkT6B/1X7FpUhy12D08YMOFuEGC0sw1B+WJjn/clxJ6XV3qk+EkzmMCShHvVXp2fkcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=G8aiuibV; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="G8aiuibV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728252520; x=1728511720;
	bh=WUVVZHmxo1kC+9azeDpwV9R5t6bB6Cz+ea/Pjz1/BkA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=G8aiuibVyRcwL2URarVih8kMCe8iO6rHi3lrY19NvwAvbQYPNNKcyEa300q+6rT1D
	 C2v6LoERjpWEbzS71z808X2FHxzspcqZsWmhEyVD47gSvSj64gug2YjhknHnFHhs2u
	 5WrIceHopDhHTNvA3co+e7HicbZfGidVwFvDS+BNAs1EiFiMmszF1p4VvxHPQrICzD
	 xha/1iU3pM3wUR0VUW2BYEpxkJBKdJZheenWedN8RfThxE0YHpNVqnhi+KuaqRiw3x
	 kSKWMldY8E2zISC204VgpZbqJqBuJQBYKdKjFY0OT7sWFGAJAnDaY0nwNfn7UmqmR3
	 1vRqYQ4rEqUfw==
Date: Sun, 06 Oct 2024 22:08:34 +0000
To: Eric Sunshine <sunshine@sunshineco.com>
From: Caleb White <cdwhite3@pm.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] Link worktrees with relative paths
Message-ID: <w7hncKNNAlJFs7fyi_ZzMj8iNF-GMgbm3E-7Wit9qUey2FDVTwj0CKg_Youi3mPpOcBvDEWyVEaeryeL10LqAY002FdBxBpi7zTQervXgyM=@pm.me>
In-Reply-To: <CAPig+cQZmEdx1Th9VAHbEkJ=zm73TP7Wuda_G5CzFw7j9HTFQQ@mail.gmail.com>
References: <20241006045847.159937-1-cdwhite3@pm.me> <TEfKiit-RYyr0ZuiQszaKaM64iSonfaQwWRqExOgXyPR1tVWyAzR3kVKmCd3aREZwDGuS5VXcHjCvneY-gCg2OuZyv2N2EkfARlZu4AVSsU=@pm.me> <CAPig+cTE0gaD=7dwSqY4S+7AqRoU9yOrS4sdBoybj0Pfyk9vxA@mail.gmail.com> <K1lpl_AWj4xpiHLG9AloFDP7hkJ7Ysf-LA5H-OeP6suaBcES3WS6NTYZGX96oQuNQ3x36eEOxGdqlj3fG3ybrn5y3LRPfCNqC7yqTyvqVrk=@pm.me> <CAPig+cQE0RNLhktuja-BbF8WwZmKC3cox_GUC-o4w87PadDpgw@mail.gmail.com> <gX8RNUg1e1FCYFS1vP-uT4rbMpg21Ax07CZm5Ha7Dsk93EN6CTuXiLr3boTaoNEi71O1rDoUxhTs6KQt7Cvfz7B3KlbpZzis5b05KW7ARls=@pm.me> <CAPig+cR4FXsGDE9Uu04EjK+vOo-Pi_VwOub8+Dy3r9t7z8GdkQ@mail.gmail.com> <AtSpzKynOkmMPZ3bR4qx-eA93Xo-1miPCIQSxIKP534tD-qpDU1AI74vqB78RsukQ0XP5eKdvzHcwy_lf8lpL9wAoHoom-koo5GKcbrcuX0=@pm.me> <CAPig+cQZmEdx1Th9VAHbEkJ=zm73TP7Wuda_G5CzFw7j9HTFQQ@mail.gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: e9ff99f1dac8c3cce63755b52ae6685d239ccb92
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------16c9e14c85203ad7a7e2220b572990c1db78ef4660c2c6c983ce35082d1492a5"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------16c9e14c85203ad7a7e2220b572990c1db78ef4660c2c6c983ce35082d1492a5
Content-Type: multipart/mixed;boundary=---------------------1c1ab60a17155a296d907c9c2ee69eef

-----------------------1c1ab60a17155a296d907c9c2ee69eef
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 02:45, Eric Sunshine <sunshine@sunshineco.=
com> wrote:

> Can you try GitGitGadget instead (preferable) or perhaps publish this
> series somewhere (less preferable).

I just created a GGG PR [1], can someone please give me /access? I will
integrate the changes requested before I send out the v3 series through GG=
G.

Speaking of which, is there a way to tell GGG that I want to start on v3 t=
o
keep the continuity? I suppose I could always just reference the other ver=
sions
in the PR body but I wasn't sure if there were other commands available be=
sides
just `/submit`.

[1]: https://github.com/gitgitgadget/git/pull/1808
-----------------------1c1ab60a17155a296d907c9c2ee69eef--

--------16c9e14c85203ad7a7e2220b572990c1db78ef4660c2c6c983ce35082d1492a5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnAwpVCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAADUxgf/VzSOz7A7V7+rJZxmayBwp+35K/iJ+Rxv+kM+bqObEk7u1sBA
VCHuDdTEg21vvSySjqKsY2SV/+lZqeOmFnNi7mLSWWgAN8ik2dymT5F65OI6
VHwSBMby8oq+U7FGUR2x0Gv+DDAg1ksBIDQEttqM41hQfU4LG0R665HmwP2V
RgdOKUDsQ701hYc7Rf4knNUl2XFiRNaNywbLjQ2Bwq47CNHGayUhL/9bFKY1
FZSx1VLhqLofB5MamPEpgFFn368jAlNUQFsNFZmt83+Y3bUEgX6vNxCylQ/A
bBlkw6NY99GpswcDMUFY59II8DtcbwLO1iZq9oLTPGtlXlv+3iaSeQ==
=qO4F
-----END PGP SIGNATURE-----


--------16c9e14c85203ad7a7e2220b572990c1db78ef4660c2c6c983ce35082d1492a5--

