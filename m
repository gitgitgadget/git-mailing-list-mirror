Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BDB1C6B2
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728253968; cv=none; b=dQ6x1lJOU4sd3lPtoP/G5jpDswK4Hc/HkaID/loSnzgugY36jhOxfPaCqeLn45K8ClJylcG8fnSCHYBP9JeR6W97+WKjBS2LWkzXUVYQzz1nw0AH1DwKPKdO2+nfL9iyQgpRLb3O7Qrqu58Z0GhT1QtFNJa6mh5kP7h5JrqQTxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728253968; c=relaxed/simple;
	bh=QJeSvok7j/d6VZBYdJq/vIC36ceSFaklXER8owDNsps=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSoxSHO0MT1SolXnkNmZNiXJMKOSBwcShu9T5xIInFy07r+zfx6RqetpdyHJ3ugw+By1sGM1m1Onpwp2tHUTOVCdN1RP9o2Ywd06Ikq8JFRpJ7Z8DP6Dx/XCsiPy0ZQqRZVEm1pS756h1Q3v+vNkaLOAzAqRSqLXGcdomXQZ4Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=kxD5Ltif; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="kxD5Ltif"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728253964; x=1728513164;
	bh=QJeSvok7j/d6VZBYdJq/vIC36ceSFaklXER8owDNsps=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kxD5LtifLxdNBdCOws8mTNMHLXWgQiGxO3HR81usQOomRMemFrkV1DTYzkTJlJZqX
	 VKe3Z9LjxhgUIAsfQbgYf7apNbOqNuuk2XZxCHEQX+1xZDxV1JfXq5bDbnRwrMTwKO
	 B88I5779h8XAqFhupVw3N/7CAg9BErrr4ccfyyOnOEzUHLvkys+vMwdxCvEapp2adH
	 stNbitS65Rcb8eCnrsow/726e5XrkCj5Sz33ReLJsemLxwmqNw4vSMLe7WLjArT9J1
	 XPsF2NDSLjuLwhdbCNAJ7Rmg1RqJldRuiE4nMJ42+xoGv9yuM4mdKpKTErXbafatYY
	 0qeVLo7wCCmwQ==
Date: Sun, 06 Oct 2024 22:32:39 +0000
To: Eric Sunshine <sunshine@sunshineco.com>
From: Caleb White <cdwhite3@pm.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] Link worktrees with relative paths
Message-ID: <ybfcgODkgeT2Oad2eQmXxyDtJEE04nlFjlM42VdfDgPbgHJc6FAEeOHcYNDmdyaN0H5YtnTD_tCq77m690t0WYbpSzUe3OcFnFAAY-2sKWA=@pm.me>
In-Reply-To: <CAPig+cRzvKddHsqahndU-pnScqNB9tL1KR-XBBGB6wx6U9v40w@mail.gmail.com>
References: <20241006045847.159937-1-cdwhite3@pm.me> <K1lpl_AWj4xpiHLG9AloFDP7hkJ7Ysf-LA5H-OeP6suaBcES3WS6NTYZGX96oQuNQ3x36eEOxGdqlj3fG3ybrn5y3LRPfCNqC7yqTyvqVrk=@pm.me> <CAPig+cQE0RNLhktuja-BbF8WwZmKC3cox_GUC-o4w87PadDpgw@mail.gmail.com> <gX8RNUg1e1FCYFS1vP-uT4rbMpg21Ax07CZm5Ha7Dsk93EN6CTuXiLr3boTaoNEi71O1rDoUxhTs6KQt7Cvfz7B3KlbpZzis5b05KW7ARls=@pm.me> <CAPig+cR4FXsGDE9Uu04EjK+vOo-Pi_VwOub8+Dy3r9t7z8GdkQ@mail.gmail.com> <AtSpzKynOkmMPZ3bR4qx-eA93Xo-1miPCIQSxIKP534tD-qpDU1AI74vqB78RsukQ0XP5eKdvzHcwy_lf8lpL9wAoHoom-koo5GKcbrcuX0=@pm.me> <CAPig+cQZmEdx1Th9VAHbEkJ=zm73TP7Wuda_G5CzFw7j9HTFQQ@mail.gmail.com> <w7hncKNNAlJFs7fyi_ZzMj8iNF-GMgbm3E-7Wit9qUey2FDVTwj0CKg_Youi3mPpOcBvDEWyVEaeryeL10LqAY002FdBxBpi7zTQervXgyM=@pm.me> <CAPig+cRzvKddHsqahndU-pnScqNB9tL1KR-XBBGB6wx6U9v40w@mail.gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 689380f97d9f168eba2023cec89c91aeb83cc516
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------55da059032a6718460e09e2df51261bac4eb8030c036ab54e8e1dda7c83f9ed9"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------55da059032a6718460e09e2df51261bac4eb8030c036ab54e8e1dda7c83f9ed9
Content-Type: multipart/mixed;boundary=---------------------319bb413dbda324a379b8dfb94aa3ff3

-----------------------319bb413dbda324a379b8dfb94aa3ff3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 17:24, Eric Sunshine <sunshine@sunshineco.=
com> wrote:

> On Sun, Oct 6, 2024 at 6:08=E2=80=AFPM Caleb White cdwhite3@pm.me wrote:
> > I just created a GGG PR [1], can someone please give me /access?
> =


> Done.

Thank you!

> Referencing the previous versions is always appreciated by reviewers
> anyhow since it makes their task simpler. In particular, in the cover
> commentary for any given version, reviewers like to see an explanation
> of the series, references to previous versions, and a prose
> description of what has changed in the current version as compared
> with the previous version. Reviewers also really appreciate seeing a
> mechanically-generated difference between versions, such as generated
> by `git format-patch --cover-letter --range-diff=3D...`, or generated
> automatically by GitGitGadget.

Thanks for the info, I'll make sure to include that in the PR.
-----------------------319bb413dbda324a379b8dfb94aa3ff3--

--------55da059032a6718460e09e2df51261bac4eb8030c036ab54e8e1dda7c83f9ed9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnAw/2CZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAADoxAf/W/NOq8jjzl3poX4hCrxw0DU3tckbj9x5/P1zCZY41NILfLsJ
GpBZJ53dZtAxaot6CK1TNMtqBCbvSpZ2Lpqe5PdNSAyx+hAZYrKzryUC13tf
jl9yJOX4gU7fgniBhgtrh3vVYGBNADeJeuBAcLA2KhQjaoWzsb3MKXzXOS/s
AeuNkFSP1QoVANVZGOp9Z9w8C2ybhlcUoIU6BWyR9f0Y0z4cPnANWcHb34Mw
eICTVlXv+qlo45GkSfmZfaMCr1S90uOXhYSRhxpcx6fNpwL1yS7LGdfADpX5
uMLo/dyq314kdymU/yLcTJhPoF+7RlMKGO8B6X3+r53wGj7ImBZjnA==
=vdem
-----END PGP SIGNATURE-----


--------55da059032a6718460e09e2df51261bac4eb8030c036ab54e8e1dda7c83f9ed9--

