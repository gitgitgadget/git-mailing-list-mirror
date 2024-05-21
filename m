Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66584F885
	for <git@vger.kernel.org>; Tue, 21 May 2024 06:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716272261; cv=none; b=Ok6Eucmj2+mJpEYkk77JhYjY0vKwBMjRnYnUDCFovtfn3yK7gc/WwylvL30H7w45FVaXAgTgE22GqKS6/mXtiWScqIvnuQ3cxV15iwh1uLK9WUItPHvKJrFud+tWjVEn2FEj7eUbP4+zcsndAv7Xl/phbxP72uxVW6F504+lqH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716272261; c=relaxed/simple;
	bh=dW4Nc7nudWry7RByRHJgxGfFBatDK4TQF3JrdAENfug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjVoMu8S5ugPQraxML/5QOHU1gtimSVZvUx4/ZvfFY7x68ziTlU+g9MdA/nHg6JaBytfW0jlJcKxQy2EjdJliZx/p479N22WgOR8HwrwjD2hYUK02oNEzgshQAD1nCsny+K4J6WxqxDG/IyHl02ybxoTV65KpErEq6vmBMxWxwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nkazoppy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nZ969zur; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nkazoppy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nZ969zur"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 034FD114010A;
	Tue, 21 May 2024 02:17:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 21 May 2024 02:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716272258; x=1716358658; bh=dW4Nc7nudW
	ry7RByRHJgxGfFBatDK4TQF3JrdAENfug=; b=NkazoppyQNIhjaYAH24mr0lfzc
	ZHumrvHLCc6JpLetGsqIAGf95V6pODCCGOh4nFpe0jg8QaFk2H1BEa2aAwLvqLJj
	LY2hDNcMpUqgxfZ2dl3aHsRImM+//vlxOut5MjbfjQE9nu8CGoQuAj/qymDkRWTA
	ZqeMnRDgBMvRv7306z9vOs5Xu4i8j2LEyQ7QbLC7jWdK1awWLIU4DqESegnYL58L
	P2JpW7/EcO3ICXQBf6N0s7vkho38//9MecIlkDvAZiSy5w+Wfqq4jUjtFNTsCymr
	8L3q7nNWn9VwCdHfJ+cn/lwValeN7+CkwCm6e3Ay42LU1M3FPsi095CU8rig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716272258; x=1716358658; bh=dW4Nc7nudWry7RByRHJgxGfFBatD
	K4TQF3JrdAENfug=; b=nZ969zurAg++/y2Dbk4clkAuztzP7CyPCA5CJoOeM5Bo
	H05lTm5WcnZIpzmtAToSl/34v6zkAPPIgzN6us6uVMuvu/TEuhr/ZpOmLV0UTkja
	DAXVEoNS+q3RiJH3knDNtQK4qxv8mFMi7+VyzxQaZMY3g4W7pSHGKsIc51JLuOXR
	YFqmWZ7b/BCboNn1UnzZbwxBnh6Yw9nqXQ4a3iUUTcaCjSzC8Akf4+LCwWcCmcwF
	QNztvWcjsLVy3UWhBKhHivoQsZAmXc6aUmba6iXaUM0titfK7keNYP4ouXuVKZhd
	5P3cGsMgQZjZTRfC9CLV7bAEVyhLamTp3kepMi5MjA==
X-ME-Sender: <xms:gjxMZtSZ80AEi6wyJzZt-g51kRoCSC4R8VKyC-W0GlbOe2rdqcZEmQ>
    <xme:gjxMZmwTU3NqMB37Ni3bGWJ_MauwrTHI6jAOmhQklIe-RUnVlve6hJSytDjrfs6m5
    bJwENtk5oFjGwBeDQ>
X-ME-Received: <xmr:gjxMZi2lwkRKLRoA20MzTfBcKtVD2DB4WUyAFxuRfPktipc6PbzbPUBfToaiiqkdHZyDvoGM7P_cPwSK-FoWUDXzJb2E-8TFJD8bwnt4fWLxEIuD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiuddguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:gjxMZlAuprcrmXH_WSnTnM9W20h82BuqreqMUpCGiOMFgSzz-KyoTQ>
    <xmx:gjxMZmhcYc3Ea2f0jfEo8pOIZ2BhMUkuY36ySRTJwALX2iYLlWX93Q>
    <xmx:gjxMZppkQMwadLKBCDNtwQWLHbsbbzbUD0b5qtdROdbFHNxgZarKWQ>
    <xmx:gjxMZhjDYo6X2lhnlkxCBOzgB64I2mTrmDHLm6mQn3J9ccIeWEBWWA>
    <xmx:gjxMZnsDs2hnMp3J3SAualKF6pyoGLhHQgU7tIBkYXWJJ7NM3GcDLP1c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 02:17:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cf82534b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 May 2024 06:17:33 +0000 (UTC)
Date: Tue, 21 May 2024 08:17:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] SubmittingPatches: add section for iterating patches
Message-ID: <Zkw8fTO0wk13Lf7n@tanuki>
References: <20240514123039.1029081-1-knayak@gitlab.com>
 <Zkbn9_-cOiapWSSb@tanuki>
 <CAOLa=ZS1bhHAtz59z71sMxOT63jwF0pHYO5YKtY7Lx_V8ubV4A@mail.gmail.com>
 <xmqq8r08jqsj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i3T+eyDaZaSudD3N"
Content-Disposition: inline
In-Reply-To: <xmqq8r08jqsj.fsf@gitster.g>


--i3T+eyDaZaSudD3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 10:23:40AM -0700, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>=20
> >>> +. Build on a suitable base branch, see the <<choose-starting-point, =
section above>>,
> >>> +and format-patch the series. If you are doing "rebase -i" in-place to
> >>> +update from the previous round, this will reuse the previous base so
> >>> +(2) and (3) may become trivial.
> >>> +
> >>> +. Find the base of where the last round was queued
> >>
> >> It's somewhat unusual for bulleted lists to start with a dot, but this
> >> is consistent with the remainder of this document.
> >
> > Yeah, that's mostly why I added dots instead of asterisks here.
>=20
> Here we want a list of numbered items so that we can refer to other
> items in the same list like "(2) and (3) may become trivial".
> Wouldn't asterisks give us an unordered list that is typically
> rendered as a list of unordered items instead?

I didn't even know that dots are rendered as numbered items. TIL, I
guess?

Patrick

--i3T+eyDaZaSudD3N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZMPHwACgkQVbJhu7ck
PpRd6Q//QvM6rPkaRd9woMM2irCzpZJadR3RO9pTsBZYY2nM2k/em3q4UVOx7ZNf
e4dZNrQV4nJ/ISCydXsgBwL5hjDq7K+DPlhOqSm3xnLMb/gZQYRXf8mTHhNtrkWD
UHh79qtS9X/nxZbvsZmr4wZ/7UYaQQqc/w8PDrr554t8z4KUYUt1Jfw5OIhQVHzD
aC7+JO2uwX2BygTJNXuzUaH7VnXX0bbX8m5q4/tlhPfPn7VeuLk4KE18ShU+HYgx
QMfq1/oyBJ0G3Rx7xAI4ExDtO1JsTqYmqTyexu9M6ppoWDR+GbtLRlRcZOYOuVRX
D7GjWpDZjCcW04z6Eag4t6gacGGgqq4aMWIs+uFJ9XzwJOQsXjptYn/KUF1l+IWE
id+VAMrhDlj0A8WD0Hf9GF1/r+xR+o0QkNuYVdL5+AaEL6YYKC+tyIzowiNaGNxe
qG+bVkF3vCfTtRvJafYZFHC3+u+ZiKlTxl1B/663zcG2kUlWqV/MIByaMYH3nRC1
I0/gFgkg7ikVEaJqmW2nOpynsSX/n2VyfGYsnj3W0CkohRXu/G+M5zaLfTysPpqw
KR7zEgKcWngvJwCZ0K8boiU4QY/Wd3sBC60JU3CTfj9AbQfEbXj60IvcVfbR//z1
1w2qXazHwFLsGamgEjdxB7wADmbg3GPf1t84WdSmk6/jMKKTa8A=
=EFQQ
-----END PGP SIGNATURE-----

--i3T+eyDaZaSudD3N--
