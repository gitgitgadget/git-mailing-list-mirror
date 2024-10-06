Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D124A23
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 06:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728194731; cv=none; b=VhSnGz652GF3wDTaTCoUoWJ1ZWtEmF89LrM8FKsaJJNIk/IJOD2TozyzOT3/5Kld7XUEiFG4yxkX08g9Q8R/hjf/HhObOJrb/owBHUB8dc8aTRBpaDBlqPcEozJmAFa7I3pyaVvCqat0OKCZPJYJTj3Zy8OdqMuvPikjuw3WSU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728194731; c=relaxed/simple;
	bh=kdM1gBPD3bkEHa3Dc3jqUcwP+BtrR3VOpvV4yiehYY0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjB6EQMO5XtjKXbKt7h2/xRKRclRcFFrPLVtgldtiFshvPOfUvC0JD0aCWqVDVT0/dDxTsUUMeNiNS63rD2kOJEuUutD5myCfTVBrIlfcPCaQG4DHMnl51n2o2cKyzKCezeISS9//rQw9OHtPUaeMatItNU+tPhdr4MNedWSfTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=PnThrmIU; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="PnThrmIU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728194728; x=1728453928;
	bh=kdM1gBPD3bkEHa3Dc3jqUcwP+BtrR3VOpvV4yiehYY0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PnThrmIU3O8UZJwdUWN0MXICiPWBkCrPDWUNXP8hzR5murwZWisC4JUqBLIwaHytd
	 QBVG7r/4nsKZwX3MIijJSuiRJyGihawLL9WONVdQKRnCe0KCarHMSekjgBrPxRBVdr
	 myb0G0flLbpER7yp+bGIP9fpmd1uGps7mlCAMBTjmn+n68ARbqz9ikdtaYamyxsJBi
	 Ja0kcr36+1rHfe+mNO5EZkwdjgKnpXo8/QlsYnvdvyHLcgwT7rZ9KgImW+0CFNvGpX
	 gDNowGWA+idLTqMhcexTvtMoq/wvIESQ2D7QHYrcvYuRYdS4Zne9G7w/NCMynUl2kx
	 bcPyB2scWjUxA==
Date: Sun, 06 Oct 2024 06:05:25 +0000
To: Eric Sunshine <sunshine@sunshineco.com>
From: Caleb White <cdwhite3@pm.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/4] Link worktrees with relative paths
Message-ID: <gX8RNUg1e1FCYFS1vP-uT4rbMpg21Ax07CZm5Ha7Dsk93EN6CTuXiLr3boTaoNEi71O1rDoUxhTs6KQt7Cvfz7B3KlbpZzis5b05KW7ARls=@pm.me>
In-Reply-To: <CAPig+cQE0RNLhktuja-BbF8WwZmKC3cox_GUC-o4w87PadDpgw@mail.gmail.com>
References: <20241006045847.159937-1-cdwhite3@pm.me> <CAPig+cTB-sA-g4cdhfEjWwY1mnbWJ41e=bOCNwp=Y8JKvpmpRg@mail.gmail.com> <zKUnWY8u1SJNeS4oLK85znjacgYJJeN8HefenwaJ9B9Q1YrQAumpAxWos4svaawkTfQZ_HaS3yp6WrOQQI7yt3ZO0UMCfkM0lJDDnMD-Lno=@pm.me> <CAPig+cT6LALKjEappB7QkB7oc88NyMcr40T_qJGL2mPA77K7XQ@mail.gmail.com> <CAPig+cT7CEnb6cQmAOMbD82wxkg=7T0MMW=QNUSPU62a0rEGLA@mail.gmail.com> <TEfKiit-RYyr0ZuiQszaKaM64iSonfaQwWRqExOgXyPR1tVWyAzR3kVKmCd3aREZwDGuS5VXcHjCvneY-gCg2OuZyv2N2EkfARlZu4AVSsU=@pm.me> <CAPig+cTE0gaD=7dwSqY4S+7AqRoU9yOrS4sdBoybj0Pfyk9vxA@mail.gmail.com> <K1lpl_AWj4xpiHLG9AloFDP7hkJ7Ysf-LA5H-OeP6suaBcES3WS6NTYZGX96oQuNQ3x36eEOxGdqlj3fG3ybrn5y3LRPfCNqC7yqTyvqVrk=@pm.me> <CAPig+cQE0RNLhktuja-BbF8WwZmKC3cox_GUC-o4w87PadDpgw@mail.gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 3c376cae0db5a7d90fec92e55ffa9a3e052a708f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------64d2511e1e95c9c395a1eaed0cbf263509d5f5e6a31fe220cf95763cd973181b"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------64d2511e1e95c9c395a1eaed0cbf263509d5f5e6a31fe220cf95763cd973181b
Content-Type: multipart/mixed;boundary=---------------------b25a3d026a9b315b066794af6e4c3930

-----------------------b25a3d026a9b315b066794af6e4c3930
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 00:50, Eric Sunshine <sunshine@sunshineco.=
com> wrote:

> On Sun, Oct 6, 2024 at 1:41=E2=80=AFAM Caleb White cdwhite3@pm.me wrote:
> =


> > On Sunday, October 6th, 2024 at 00:32, Eric Sunshine sunshine@sunshine=
co.com wrote:
> > =


> > > It's broken in the Git mailing list archive, as well. If you search
> > > for "mbox.gz" at [], you can download this email thread. The patches
> > > in that mbox file have the same damage as I'm seeing.
> > =


> > That's interesting...what's the best way to try and resubmit? As
> > a new thread or as a v2?
> =


> =


> For continuity in the archive, probably best to submit it as v2 as a
> reply to the original cover letter:
> =


> git send-email -v2 --reply-to=3D'20241006045847.159937-1-cdwhite3@pm.me'=
 ...

Thanks, I regenerated v2 patches with `format-patch` and then sent with
`send-email`. However, the issue seems to have persisted (at least it's
consistent?). I looked through the the patches on the listserv and that
seems to be the only location where this occurs.
-----------------------b25a3d026a9b315b066794af6e4c3930--

--------64d2511e1e95c9c395a1eaed0cbf263509d5f5e6a31fe220cf95763cd973181b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnAiiXCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAACgxggAkKGnC3UZDERnZNfeSS4HJ7EtRa+ZaliIj7BLLjsPWxn/DVCN
E6P8F+hx690c8yropLBpTVtOG+jnGPCBNIEB2vz1HVTqEecQoUquRWgqUYKb
/7SZASsV9T2Gp1wcLsnkoTxl5XV6vFGBguxTYl3Sh+lEAgfc0ibc19ntwUGH
2DQVmDDeF5MkhBVM0y4lB8PGP3t6CdeptrV3/flBecBXXimGQmgwTcm3mtmZ
FcdBPI1wGIvdCm07b5kxJtCLsh69LBVOO+asKolrAxflhnZptXqTZ5EtZLk8
fWSv4SPtkaRrzNT/yR4ZeTpALgZTT1BVbguVvqrnMHy5FwripNvJvw==
=xDhG
-----END PGP SIGNATURE-----


--------64d2511e1e95c9c395a1eaed0cbf263509d5f5e6a31fe220cf95763cd973181b--

