Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3628F9DF
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 05:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712037594; cv=none; b=q/nDJiTjPScRmEzy9YoJbsbXis33EOvY58ezBFJCkEO5smSPHVbVZGl5skq2GXSqNc6ufNg/Vk2tAPC/nVPRkIbUOfGDsh5EuiE2BCdyWwfms7SMIA9ktmo0yND4yOLrmwCTpDQq5TJhTA3q30ALDKnQuFL57OjA7bpN845bdk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712037594; c=relaxed/simple;
	bh=dJybhQqLs/1SFBm5yyPqxPQG3kr5wGGMD4dQNkxHDDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCNi0osVkGhHMs3OqvoJpw/K38YHu3nc605vYKriFjysWBCaXWsgnJdwS+OL/vgMdf8Cd4XVNwmP9QAIq/4muHLcdRSYG2nbPJyjSi9hLtjcV52CwIilgAv/eOcQs4iRcTedaSzclqknId5BVcEr18TfpQhwqpv101jrfEch4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PTq4zuXW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oUr1lDGh; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PTq4zuXW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oUr1lDGh"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id BD6385C00CD;
	Tue,  2 Apr 2024 01:59:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 02 Apr 2024 01:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712037590; x=1712123990; bh=i4R/mu3G9e
	PkCXrZuWSO7NpajHWy5ak9FF45bkcM1cQ=; b=PTq4zuXW+odqhNVWWVv3d/a4XT
	ht8mv/CTXm+talxddR008inNzofWpqalYq7eNlqiB6dp3ET13pqWd84FWtWMtFen
	4Wr/PQkUtYj/a3UdbOhIOCTG+KaUqD4K/wlj9Br3MhP5FI0iehSnE7R0wSAYXvx4
	4+pebD7+sJKF49G17FxyCDtUTllBe1NMJRbgZWu5TTD27+0QJ/if4AABZUr7PDpl
	im9sM0/MFIN8cNrbviEgAHmhwJ1CdEldILsqqe662Uk/QFERvGLnpytNhARJq4gc
	ERiAOHhie3gA0FxpzwIIDW4X2g5iFzdNwe/+Aq+yq6s4MlIWkWBvfTul6Bfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712037590; x=1712123990; bh=i4R/mu3G9ePkCXrZuWSO7NpajHWy
	5ak9FF45bkcM1cQ=; b=oUr1lDGhqOfXIGCTEnIYelUnsZkcIn0aXDPekaHOKoIz
	tg1KOLRddYmBccNfbv1BESJTJjR89LavO7TSLmWb23NGCxHF58b2612R8EsHXcPF
	ZQ7SvZljEgXYEi1qImxsrpO+ncoYvRy7gTyZZm0K59ZiY7y2jpQYq1SLa9f/y9Eb
	n/r2a5MqwFynMLpxOpaOkeDSSjCjOxSVh77OIPL+Cq+nVoLJfzzS3BqIaOuUZfsG
	KvF5ntYARdryblZZvRnv1vcGKxgr/Ia/WqOAF9mKadsNJFzCt2No6Ry8Yn65wmfO
	87nlkQIbY+sYMHJREg7xLXd7hQxouxghbm+3BGv2Ew==
X-ME-Sender: <xms:1p4LZkQyHoXgE1UoMr0V8NrYQXfMQSvypHf1oQF9o_NvSw-1levDLw>
    <xme:1p4LZhybqmWb_hwU5tPDtT66ie-M_SOfGCzFBKPs9UcmtEMmT3X3ZHr25dwU9anff
    Y7GjhvYa1TR_L-BIg>
X-ME-Received: <xmr:1p4LZh2LL85ypKBEJVYWJ9OMbkdWXjQHJVSDrnCMxVxO3N-sLi2RQfrN6OM_hOOI-dmXMPfICrPjD7i8uisITWRAlyjc6eGAFm26JcAMfHHlfrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:1p4LZoC12SrhvqRZ8KW1fwzzmbEhkv1bZTPWDVrtAGhG2Pb1DtB52w>
    <xmx:1p4LZtgLB2ZEmc_HM1z1ZPPJupBi6_7JbM7aWGfsKIPNxH0p4oMN-Q>
    <xmx:1p4LZkq3qoHJAH0KNj-0RePJsMWrlhtf-n7vWG2wdcF-7xTSCO6XYg>
    <xmx:1p4LZggYMi0aqu6A0_XeBaOzPyW4VYUCCqlwL4xRGYfloU8qaLFz8g>
    <xmx:1p4LZlgkoeCblw-sMLytfT8blguq-hgZ73OcVerb2m1C5rpTBte6zfBjQllV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 01:59:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5891071b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 05:59:39 +0000 (UTC)
Date: Tue, 2 Apr 2024 07:59:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH] RFC: add MAINTAINERS file
Message-ID: <Zgue0LGaAa5BfqKZ@tanuki>
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
 <xmqqsf0gvjrg.fsf@gitster.g>
 <xmqq8r27nhwo.fsf@gitster.g>
 <ZgPIEgFGVokYWc-H@tanuki>
 <ZgsoOnle3CC8DqUR@nand.local>
 <xmqqzfuc7muw.fsf@gitster.g>
 <ZguaLjWGte3zdQGW@tanuki>
 <CAPig+cSp=GjQWF1t+O6w+Ad=NUmeAM8ZAQp+CeetERgiSaUe0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UVNR9Ze5EcgXR+2A"
Content-Disposition: inline
In-Reply-To: <CAPig+cSp=GjQWF1t+O6w+Ad=NUmeAM8ZAQp+CeetERgiSaUe0g@mail.gmail.com>


--UVNR9Ze5EcgXR+2A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 01:46:22AM -0400, Eric Sunshine wrote:
> On Tue, Apr 2, 2024 at 1:40=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> > When it does know about both I also see myself using it more frequently
> > in the future. It would be nice if git-send-email(1)/git-format-patch(1)
> > had a switch `--cc-command=3D` or similar that you can pass the script =
to
> > so that To/Cc lines would be added automatically. The script then gets
> > the commit range as input and can decide based on whatever criteria whom
> > to Cc. To the best of my knowledge that is not currently possible.
>=20
> I may be misunderstanding your statement, but this automated mode was
> exactly the original use-case. contrib/contacts/git-contacts.txt says
> this:
>=20
>     This command can be useful for determining the list of people with
>     whom to discuss proposed changes, or for finding the list of
>     recipients to Cc: when submitting a patch series via `git
>     send-email`. For the latter case, `git contacts` can be used as
>     the argument to `git send-email`'s `--cc-cmd` option.

Ah. I myself use git-format-patch(1) and mutt(1) to send the resulting
patches, and that command doesn't know about `--cc-cmd`. But
git-send-email(1) in fact does, good to know. So my statement still
partially stands, and we might want to make `--cc-cmd` available in
git-format-patch(1), too.

Patrick

--UVNR9Ze5EcgXR+2A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYLns8ACgkQVbJhu7ck
PpQCqg//S9X1NL9RO/mekZJCgHOuOv2shgBsNw1Zy0EsDt2RmzPISHeO4QsgAbvS
uxWT4XbZ0F9wAIOlprFpYT6RD0+LS5Vp6ZAUHqrwbkjdgROicEgbs7oozehWwssE
2Zf43/pCKk1KIYUTa4gReQcNQrNsdPTt+3Eoykgwd15rjS2SBwo06wfnoRkW0Fmo
aDqjo9ZJyK10tQzhV6Z/I7FdL1OGCIg2VpH5dh2lB0GkO4L66Va+YOKwZ6NpEc6O
9UvVne1Y10jB+VmlrZKabWR9CV3dmPTaDy07pF7Q9mT6hUVk9NRadhgS5reCmS6Q
0qxQ8NdJrzrQ65Jd6M4nMNwf1lm8IQOOhxOsNyP8ZhL/XgZYCJ2GA/I5uzM8NxoO
JdQ9v9Dp+dwcBdrinzwgJz6rYQnfGft7zBgPThs1U1dDswicYMtaacfxBJJNfelU
o5gpdt+jCOwjDwtz0khMiHbsnwGClW0Gw7chuMWZTUjzKx8EAQl/28UIiHCvSrwh
zrc6ll57/sRfGEu8+hH42HiN3XKiahdSrBotzbavkYhaKO4xzJXqsAnKJ+7zeVw1
V7pk8GSlcT0IcRSpJV9/k7Jk0iFijmwv/NFiv7hnwZztEnvQR9QI8Eu3QIWYefZo
lT+PWvVhhcHyld/Sb4zkPU84P50W2EuqwjQmpT6rCzW/yus6VJI=
=H1cb
-----END PGP SIGNATURE-----

--UVNR9Ze5EcgXR+2A--
