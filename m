Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5557D15A865
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862735; cv=none; b=Mu34IwrF1KWqyVfyW8aQe4CcCYsoSZ0WsODc9O0a8KJ0Iy0zYJDQ1uzEzmNB8aE7G+KOMkendFug+wTObzokELQ4eqgDcKELhlovTFeXHMHNBcbq+23jENnrha036Oyq7u2mq5PqbEfK2ToM7XXt9mGqmbh22TJG88IgC/4nbe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862735; c=relaxed/simple;
	bh=YmtMT/WAWtRERLi69J5ryC2nENHIEvA7uh4sOYKfWk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7Dt65LnWyAtpSxLx8olPhPrTBYoibRB2WqvF0KvMdAard1jGcR9YaHAwnbjn3reFVIXVqzXXiGXwnBAyL79D5qfhaHiVMEJYOnlbTUeyV8Dkg5UkOYFzEBupJWyBAVmLRI+cq5IWcuI1PUNrlQ/Y5IFUtSpKRTi4HInsDAg1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=idYLUMLw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PXcjrdAd; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="idYLUMLw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PXcjrdAd"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7D885138FCC1;
	Mon,  5 Aug 2024 08:58:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Aug 2024 08:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722862733; x=1722949133; bh=RWBRQ+mxFV
	7PK2sxMgIcpO2gkL2FZngUXZiALaOCVL0=; b=idYLUMLw/QZy7PRon2yDaRVnwc
	RtCM13ye2l6htli7h7h8XSj+NHgrXwsIBMkOYisxXcQv5xN8mmUELtYwiA/gUN7c
	4HZgSfKrRHVMUirU4DrVeSEqCklr9mu7bnxJUx3pYgMkPCgrgtMIhDZXUltpxyi8
	utR1o0yQ/V64glF7uo77zA7keNDmJsqklFG19bGwB5qj6Ic1uvFD5Gxla+8wLQO7
	hxy+ude1bs+J8wD76YBVDlIIG1BYxvFIDkeKUONS9mJuelrDUosr/RwENpac0orj
	GILkk8FToBxzHyjudRYt9NFLXOsxmwt1xYXwxpkT0QtL9gNPkFLsDf5qS73Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722862733; x=1722949133; bh=RWBRQ+mxFV7PK2sxMgIcpO2gkL2F
	ZngUXZiALaOCVL0=; b=PXcjrdAdMg++B3GT0r8b1ABOmQoWZrcQM42frWqlqcKl
	qysVBETrTIHvmWFRWK0My79ofMbNdlK5wHhUwrA6EUtFWRXKo0YQW+Uye5EYbRs6
	FJiyd4RqCvCXdxuMOwlWpen7NWMJaQEojS4jR74kMrInYcUidmiUT7nnjrTyc4Jb
	HXP5npnp9BGdtwbSwYZUZ9+fqayDJ429uGpO+t0rEEoSZhDamaNVaRN4qZ1NGJk4
	8WCw2J2OcKf2MBqzp1wMMAraEtGd6iUkF5JuiMJPtUX2xSnqRTbtb+pgZFNY5kz3
	R1dDWDA/J4lsDoCn/25NiwtKhrXTVtgycFBs9zIvTg==
X-ME-Sender: <xms:jcywZtvL4nOBGVmNUnBVey3Pd1KSZiA1X1jFh1QRiTDG90dhid1VhQ>
    <xme:jcywZmeqkTppIjuh87nEVxjyhutG9H03e6-u9okLbWEyUEPbwZzq5NimxPv9Bhv7w
    AVrSmfBOvhanoIyEA>
X-ME-Received: <xmr:jcywZgxwci9cyzQy6otpSQxWX0JNVN5UPl7FmOklYnpG0wapylOGInXEOg_na4_mYT6wX8lFnqZ3g1nmFqLGqrFCNBUhBBR7_BOUrX4brtfg0TY6BQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfelgfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    td
X-ME-Proxy: <xmx:jcywZkPpV_yus1naHjTXHFX9eEFSmEoHXZbmOxgHC1umsXJssjAX-g>
    <xmx:jcywZt9HCM38PcdS7aDKXeN15mnT-cBnSWeJ33BgGe6hqBBunEJJ7w>
    <xmx:jcywZkWQk-GNB_CpfLkRX06wyYcdvlbyRq3jhLSpH3OrxjKzQBR2MA>
    <xmx:jcywZuf8q-eJBEdf6lRWvLoP4hyYi5rwuBNhY5SfG4_7KA09vUhsUg>
    <xmx:jcywZtzd1lySskjb7tNCb1Y_Jwy-xv9uQzcgbTS0IHSQuxvjkTqzRrkl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 08:58:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1c753386 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 12:58:51 +0000 (UTC)
Date: Mon, 5 Aug 2024 14:58:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v14 00/11] ref consistency check infra setup
Message-ID: <ZrDMiXX5KhA9WVNI@tanuki>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
 <ZqulmWVBaeyP4blf@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sxI3WupF3Ia+ypZa"
Content-Disposition: inline
In-Reply-To: <ZqulmWVBaeyP4blf@ArchLinux>


--sxI3WupF3Ia+ypZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 11:11:21PM +0800, shejialuo wrote:
> Hi All,
>=20
> This version does the following things:
>=20
> 1. By following the advice from Patrick, we should make the callback
> function be generic by adding only one "void * fsck_report" parameter.
> Thus the commit sequence will be much more clearer. And it wll be much
> easier for reviewers to review. And I have split the commit into more
> commits in this version.
> 2. Enhance the commit messages to provide more context about why we
> should do this.
> 3. Patrick advices that we should initialize the "fsck_options" member
> when parsing the options. However, because the original "strict" and
> "verbose" field are defined as the bit field, we cannot take the address
> of them. So I simply remove the bit field.
> 4. As Patrick said, ".lock" should not be reported as error. At current,
> ignore files ending with ".lock".
> 5. Add a fsck msg type called "badRefFiletype" which indicates that a
> ref has a bad file type when scanning the directory.
> 6. Junio advices instead of using "fsck_refs_fns", we should use the
> singular version "fsck_refs_fn", fix this.
> 7. Drop the last patch because in this series, we mainly focus on the
> infra, I will add a series later to add ref content check.
>=20
> However, there is one thing holding. Junio advices that I should
> follow the Patrick's change to change the prototype of "files_fsck_refs_f=
n"
>=20
>    https://lore.kernel.org/git/fe0e2c3617c8040c632dbc3de613a1d22e8070f7.1=
722316795.git.ps@pks.im/
>=20
> However, at current, this patch is not in the cooking tree. I will
> handle this later.

This looks very good to me. I've got another set of smallish nits, but
all of those should be quick to address, I think. I think that the next
version should likely be ready to go.

Thanks!

Patrick

--sxI3WupF3Ia+ypZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawzIgACgkQVbJhu7ck
PpTzbg//YvOKQ3SpBhnWgs16Db5h886uNqvwExgAejjGoxYw0yYCXYsNNuZ2TSx1
CFI9rJg1N3SDkaO3h20j4TX5GxCqDNCvnUV6QVv1DB1vC7CfzDk3RbcPhqZ2NZPT
Xlax7cj+SiaumsoVtGFrKoMUBCPVe6bAoPkVs2k5ZJym76eqLXG7w/9Llc8Vu0ka
KBpNhX3bEzrO2RvoKKdd1kbai3n+EXEXUg0UVdXCXL6cWqZjE0bb8QpoLlrC8wfD
gEZ3LRmxb9DLckF9TQqp/hkAE0tr+KaBWcPk+DNAqWc4Hmm41tea7Up3E+XDJ99h
rNYpAwqu23mqfvtOc1BE2uHLbyceJCXhaiLwrH2Ow+PSLhU2yvaRAnHTkG4adlwd
KTasph9zVYlxL86aIhm+cSaEzo2D27TUEOBdqBpQcmiv+1eoR4MaWxATbyB/dY39
bzUXJGtXHIQ9UlA4Evmj0Q9fwrK6kMHSt72dumIhXozhta69JwfA9KtiRm6M4yak
I0eGKsil8jrKIgWs9IwlUnUTQxhqhGL+3QeySLMhpDUiVhy3IZe4rqUPdCBhJcdH
ZrdT/XHCcFhz9DlTB9UySZF2O6Bosj2AgRKQEIdNSknRmqdu2Nto1Ccz+YHc3VNE
PhDCD8x9JYKUc2SkbT8YhDfA/K1mp44xAAdcNGSRYdIBzZoL9Yw=
=p+do
-----END PGP SIGNATURE-----

--sxI3WupF3Ia+ypZa--
