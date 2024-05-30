Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF16183987
	for <git@vger.kernel.org>; Thu, 30 May 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068606; cv=none; b=l++VOMc1it/kUS5IKEUSA1c70+K7j+9C1pz9CBGow+Q7/SjOJUnjeneigKjJG8BTo7jQOy9cakq8l5UlKuzPhhvnHEaWPl/7Mdfq209Im+q/+bHIr6v6MFw9t7xveuGPptpkdKmZo3qYUcibPAPltmgb0DxWyhstp1cx/x8jdOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068606; c=relaxed/simple;
	bh=yp+gBcW9EIseRcccixmVxfS97BRDQqdRtesEnNiWqPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qx/+kknmnj4NSgs2CzVJyAIEGM2djrvw3yKdVkKPcrxygJ4nJa3w1ZgA8vFnW0uhLz+fKJvOGjLQ9wQUVvla5ldy31OCvRwtLMe8jowFeVervBAyqGSVjPEhyGqfu3XGE3M4SDtdbEtdx9X9aMGFMxI4yIszwrRwRVOEIQ2/4ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lghAiRmp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DAykspaU; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lghAiRmp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DAykspaU"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2886B1140250;
	Thu, 30 May 2024 07:30:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 30 May 2024 07:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717068604; x=1717155004; bh=WB80SiDIlH
	fG9SKm93mxooQ3gLBV7PtTn/vyRJf5TCI=; b=lghAiRmpx5nfORx1LKdWAdpMab
	m0Jb5eRLl6H78fq25wxUvzGnM5t6mfSMP/54QVJQKNsuTJTNM6SPzYlCV6LaxeHe
	hI/X782372XgLCmYpO5t2EAhfz/xs32FXZt9hC8jc/pOiM2gbqnB1/97E31zLArF
	i/RZ9c/Uj9dfA9NFrcW8nex+Rm680X7FSTZgScbjrNZ1bxaqFEH/40nuGDDThRgm
	9roxziMiwvp+TRGaFshfzaIC4SPBmNqt0GKgRr+LvQR7PnBqX/3+wRYfO9os6p31
	SwkmwwZthfxHyaUfh5ZV0HQBRfjgc58MhV2Te9ErjMKCFPqcaK7FEgLjzquQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717068604; x=1717155004; bh=WB80SiDIlHfG9SKm93mxooQ3gLBV
	7PtTn/vyRJf5TCI=; b=DAykspaULTRxq7xP0qxQZ07pdETTogC9BpQV5DngZwI0
	zoU6bx6GenVvJSSfG2mE684f2MT9NYQziL+fQwslIDCXtA0trMGd96e4Fi0u4AdE
	S9gXK653wbL0s2/W3evsQwQU6E8xq3NLX0yReKUEY3GeezW8Qj/MGubtINHwmih4
	cKE8GXc7/lAl73y5Gy5hjz3EbzBUCbexwgdQr17+ZEy8BydOTxVKOJdILApDmq1z
	hwG0av9YwBWnkvVFYjSJzr6E++IEUfDC12w5+2HR0NM9N5fHbp6Noq27NGuke2fU
	yzW6TepgnwxylAK2HiwThgXzky7IGc9tyoK464jpXw==
X-ME-Sender: <xms:O2NYZq8GmAXJ3dcsdr_vn3WMETHpt4NpNwVWqlUsdreW4l3BOdrA8Q>
    <xme:O2NYZqsuBiuAV_f_zMwDmiskFeLIZ2aUy1KGNw9nw2hbwQFmjZkUJTAlnweegayvN
    zZx1pS4Cl1WqkJxcQ>
X-ME-Received: <xmr:O2NYZgDZkyZXw_1PHOFZveyH91gwjMJ63BjImQOpZS3-r0NKDkeXYqSNcathqZhs448478jvSG9pKfVAaCxa1L4JmKk_daFeYoeZXlBSublw43kNLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:O2NYZifRzJIo4r_6aVejzaLllU3SW6AWKY-TjYohT9RYOEqYQIIudA>
    <xmx:PGNYZvPbVWPKK-CVaBRw2_gJviHm7cAQtkauU5B6H2K7cESFsTxr-w>
    <xmx:PGNYZsmUFW4SkLMeXCmal2G4OrtYhhchMKPnRFbKJkzchHVfd20hWg>
    <xmx:PGNYZhuBxiz42PJa2M7JXpRSVpnTD9flrhj1m0fuXPlo1fCnikgXCA>
    <xmx:PGNYZopq5tWOs-k2iYMyQ87GpOY--a4BUb2lM2_fZXIc_7Wr333J27aH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 07:30:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c5d677d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 11:29:45 +0000 (UTC)
Date: Thu, 30 May 2024 13:29:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/19] global: assign non-const strings as required
Message-ID: <ZlhjN7K8JKYz6Opd@tanuki>
References: <cover.1716983704.git.ps@pks.im>
 <51ee5660a1452797ac0a45819210141c57f3dcb9.1716983704.git.ps@pks.im>
 <xmqqplt4y1gk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o8MpRNaVna3SJYwX"
Content-Disposition: inline
In-Reply-To: <xmqqplt4y1gk.fsf@gitster.g>


--o8MpRNaVna3SJYwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:25:47AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > +	char refspec_str[] =3D "refs/heads/*";
> > =20
> >  	memset(&refspec, 0, sizeof(refspec));
> >  	refspec.force =3D 0;
> >  	refspec.pattern =3D 1;
> > -	refspec.src =3D refspec.dst =3D "refs/heads/*";
> > +	refspec.src =3D refspec.dst =3D refspec_str;
> >  	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
> >  	matches =3D guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
> >  				    fetch_map, 1);
>=20
> I have no objections to changes along this line, but this makes me
> wonder if we somehow have ways to ensure that after everything is
> done, refspec_str[], empty_str[], and the like in other hunks remain
> to have their initial contents.  Stepping back a bit, without
> applying this series, if we told the compiler to store these
> constant strings in read-only segment, any attempt to write into
> refspec.src or refspec.dst string would have been caught at runtime
> as an error.  With the patch, that would no longer work.  The piece
> of memory in refspec_str[] is a fair game to be overwritten by
> anybody.

True. Ideally, we wouldn't have to do these acrobatics here in the first
place. That would likely require quite a lot more work and go beyond the
scope of this patch series.

> Which makes me wonder why these refspec.src and refspec.dst members
> are not "const char *" pointers in the first place?  Obviously we do
> not expect "refs/heads/*" to be overwritten after storing the pointer
> to it in these members and making the get_fetch_map() call.

Well, we do. Not in `get_fetch_map()`, but in `query_refspecs()`. It
does weird stuff where it writes the result into either `src` or `dst`
depending on which of these fields is provided by the caller. Which
means that one of the fields would typically be a constant, whereas the
other one will be allocated.

Really, once you start looking you find all kinds of weird interfaces
where we cannot quite make up our mind whether fields are controlled by
the caller or by the callee. This patch series certainly surfaces quite
some places that left me scratching my head.

Patrick

--o8MpRNaVna3SJYwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYYzYACgkQVbJhu7ck
PpT0yA//V4/V3wk3VKqVjP9S3BMhcQOO62c7viAm0owaISqtviOKeG99EY7sudDk
5amCNzYuJcGT+FPvxma5oRSXesnF2vYvCF/1QopYWJuFxrPX8NIkfEYqOnORX87K
NQxJbgQmKbDV7j27kgD6AydCK3XIrBX6de7NqLiawtRix7XENvr2ZjgO41yc437e
olc/tOENhtlv0USX+Prtmy3/4mxetMEiRmctARIYI6gBrUIGUkfqvgUBYHQ4OnCZ
pFfymmQhRjx1rWwxTpXWPTjL6MiqxzqFtZafsJK8nS0PBxAvIOVuIvnKqyRytNkH
DBPBtjnNl2WtdysoWnn+862k+i6JxAFTrpKtxIBy4FgLgAO0j3VgOpQ14WbaWk+L
eccs1rkf96UPyEZZoB9S2xDc7BDawOv4cwojgtA0dORd9JKOBrYta1nXudMuz4Wh
Q4N51Xjj+hT3dOl4qSXW7Zet/5hiBxk4r5h+CSW7+XwWkvnJazrLbYhJxTo/iKho
B4kAgwaQvmctJG+l5439oO0Jbb5O9j2XLr+JzwBQ9w5DqTRczbXSAMC5PcqyTMLG
DuGCbG8myBFY3UaltWCcPF80r1pDYIblyhIMW1jIQUnCJLYuvnzp6s9SHXdSSacd
bQjDkH8XByr5cOY3HXmZ9Eka9zoBpu015ueNuB3KInwDarEtsQc=
=gZpn
-----END PGP SIGNATURE-----

--o8MpRNaVna3SJYwX--
