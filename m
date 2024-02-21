Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ACD364BC
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499665; cv=none; b=j1Fx5sErKEC5/tE0F24z/aqwPUBBv7oYiasqmo5UOu1//o5u2vNvOZDsQajVOd9uset2yH7o/LkPE633BBfUSNP9gR+XY+/4RQJy018BJTuK317U5/9OcPJv1WUr7Z4nt2Lcv+d65/stu+BxiFplfzV4LIh618Le3OakymC4ORU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499665; c=relaxed/simple;
	bh=XMRotAjLw28P0eEVJhYejD3Pb4N1DQODWsRewdhkFC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5s+Zg75DROum7fwe8ewMfScS4JG/ICD7hjkFS+evvJGFrhOMGyJ6tEboBphKE1riIgfaoWOfY+wV4gkdL7LsYZmgdCJyORA+dcseEi5AYsPBq7F5ToqXNWgVjZNXZNH45gAH4S16vUk+/azVd3HDudTEj/PDdRK+C9L8tNdVuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X5IVzRKm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hayHsk+I; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X5IVzRKm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hayHsk+I"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3733D11400B7;
	Wed, 21 Feb 2024 02:14:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 21 Feb 2024 02:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708499662; x=1708586062; bh=x3agpx1mG+
	LCk1RsnR0nDRueP6zl0jF8DnryZ8EON68=; b=X5IVzRKmoYXHrVKYqgWmevSsfA
	yhtPT3E+c+1ipi/PzoZdMTrUOT8rPQ4Q4PETT8cFqmhhlJJvNJlXBsgZrxERZu07
	S1OFCOCR0tvfCCbbK3i+6GxcKkcjvY7vq9zoDAetR5jjtEWf/YW2vnDKgYNxdpjh
	OOMbf5Dnjusha+CTBtpKKO9es8NxcMbTC6q55F+b+lbXhtCUQR2DYhxcLGU1lPfC
	VtEsuY78Av0hyxbs9kmc99IOtaLidQS+hcm3SimgeR4GQyzlowdb4RZM5acCxrsz
	zqPEUwToDjfWK8wdI6VYIdZWU7zAUFXZmdA1HnCXbqID7MnY3LTGgUKlZVRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708499662; x=1708586062; bh=x3agpx1mG+LCk1RsnR0nDRueP6zl
	0jF8DnryZ8EON68=; b=hayHsk+IeqWF7igmUFuaBHdhJ6Cmn+WlPBEQuJP8CjY4
	w1GEYx2QhEpiUJjHlEB5GhJuidLdVE8BbrFyLKhH9FFr610LfdTjNUR+v+mCb4JN
	5tibqydWJKLpV1QSr/9TRiOF/80lFR6NX6mQGQMdK/pAygZTNWS8uHh3F75WJYO8
	gq6K13ME8qS60fH8JAvbewxTiDhJVHURzLQ8u9JTWNkNRoYzVtlL3vCcyaI5//Pn
	SbBuGIMY7FThLsNeidUdvSXvSz6bjmF8DEIUykXV+GskFGO9IfRYAlFDCyodqaUb
	j6hZH7J7WvJTmXyCFaLhHZCNjV1gfS2x4YORlw8y+w==
X-ME-Sender: <xms:zaLVZS_Pu_xBIddRXI7NsAhC02zjNhnggPLVlFgEFFz4olwrsr6v5g>
    <xme:zaLVZSuNZWEIXljTfJIfajeYle7owzXUEX_ng2U4uLQ19e_7sPq1Lu9Kx5GY0KrqO
    JONWPDlmTV0IjVwUg>
X-ME-Received: <xmr:zaLVZYAVFhp0gc57tvoDGS6XXbXcEFQP6wvbGUqLzCel9GowBbXMPN9QVyIo4qEB_uS7CuITr2dxZH7yeqZVHH-dohVMRNoMWfpbQeHEdkxO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:zaLVZaeTmwmSccJ0Ou6yvVhr1d-cIPztvOBusKcnAE2RRIlCt1EtCQ>
    <xmx:zaLVZXOsHQpRdvBwDTn-j_qgwwopFuQ2aegccA0kFDH8naSJl_mbfA>
    <xmx:zaLVZUlbfCxyHi_9cK6wUgvVsmN-Nc75BkFD27qf5wVjGnfxgmAsAg>
    <xmx:zqLVZQqB72aKWIuJkC4TpOrv0Ku3Q9ay0u5SB0eJm72OtAAOf3SbZA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 02:14:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 851025ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 07:10:15 +0000 (UTC)
Date: Wed, 21 Feb 2024 08:14:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harmen Stoppels via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harmen Stoppels <me@harmenstoppels.nl>
Subject: Re: [PATCH] rebase: make warning less passive aggressive
Message-ID: <ZdWiyYhKAB3_P6_k@tanuki>
References: <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G14VVutlkuRltS7a"
Content-Disposition: inline
In-Reply-To: <pull.1669.git.1708442603395.gitgitgadget@gmail.com>


--G14VVutlkuRltS7a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 03:23:21PM +0000, Harmen Stoppels via GitGitGadget =
wrote:
> From: Harmen Stoppels <me@harmenstoppels.nl>
>=20
> When you run `git rebase --continue` when no rebase is in progress, git
> outputs `fatal: no rebase in progress?` which is not a question but a
> statement. This commit makes it appear as a statement.
>=20
> Signed-off-by: Harmen Stoppels <me@harmenstoppels.nl>
> ---
>     rebase: make warning less passive aggressive
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1669%2F=
haampie%2Ffix%2Fpassive-agressive-message-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1669/haamp=
ie/fix/passive-agressive-message-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1669
>=20
>  builtin/rebase.c | 2 +-
>  po/bg.po         | 2 +-
>  po/ca.po         | 2 +-
>  po/de.po         | 2 +-
>  po/el.po         | 2 +-
>  po/es.po         | 2 +-
>  po/fr.po         | 2 +-
>  po/id.po         | 2 +-
>  po/it.po         | 2 +-
>  po/ko.po         | 2 +-
>  po/pl.po         | 2 +-
>  po/pt_PT.po      | 2 +-
>  po/ru.po         | 2 +-
>  po/sv.po         | 2 +-
>  po/tr.po         | 2 +-
>  po/uk.po         | 2 +-
>  po/vi.po         | 2 +-
>  po/zh_CN.po      | 2 +-
>  po/zh_TW.po      | 2 +-
>  19 files changed, 19 insertions(+), 19 deletions(-)
>=20
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 5b086f651a6..415783c4a21 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1254,7 +1254,7 @@ int cmd_rebase(int argc, const char **argv, const c=
har *prefix)
>  		die(_("options '%s' and '%s' cannot be used together"), "--root", "--f=
ork-point");
> =20
>  	if (options.action !=3D ACTION_NONE && !in_progress)
> -		die(_("No rebase in progress?"));
> +		die(_("No rebase in progress"));

While we're at it changing this message, do we also want to convert it
to start with a lower-case letter so that it aligns with our error
message style?

Patrick

--G14VVutlkuRltS7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXVosgACgkQVbJhu7ck
PpRvLA//TyqpslTe5pcczZJ1UAxJ5ty0iq2s+HqCFrr82Ex29dRh6P2fogPIsOKE
eg32M5gIwhCdcvJiS8spRldQg5A5/k7bh0VnzCqDHfevQ4qzKZCNgKSth3H1xLeh
qxPR3fLy+44Rk8DD1S5s0AL/89uWWra/cZ5AEIfmEob+ZGTTnVc+nab6Nvsb3JBF
K2g1Nwh5OQPZPCYxcwWHHkqY8rom9ppi4yuSFwKJ5+eI5dHEnUPlyPE9t5lZ2yhs
imMIpHgPQ3Xm7oobuNXX7elwFbry1d7u8l2UJ9vzQvr6Zoit1r41LmETSfYRjCAC
F3j4DjEFjE0Ai/tn/Adp0OTYPopLsyHENBNsdq6rt+s4nWdky2E5rCfSBWfuUSID
W2ATMJLg3VgaoSmtQbE+4725PNrqgVNyKFsyEG1owKDrNvqMs28K0iZDe9wVdGg0
FEYJtHdR3FVE7lW3vQ4Jjsq/bnLvjrnVv1dJoJ7fp3Va5JV2vEcdtmNOpH1Sn66X
lAFcUL7eRuVN2/L0htcX5xWqHgViQkH2LoDhnef1l0oqV8EB2AxR6w8CvDfbgmJX
VIfBp3DkiJblblPhQEj3ZAvgk/ejpZLxWm9wptuxw73c4tj4C5rVaU2ja/AP6gTz
OQleuR83MoHRNSDW0atEY0U+qM+21n/sXWHcm4Ld92yFifFLcY4=
=3AQH
-----END PGP SIGNATURE-----

--G14VVutlkuRltS7a--
