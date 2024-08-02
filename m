Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F37D1C2BD
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 05:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722575548; cv=none; b=oHE/Y/Oee8mRzS/WlCUrpAIR6gFFPWxSDG3moAimtsapve8LXAQMyl2unHY485FZz7dPmu0B8UtJT+g8CvSucEZtY9jRQG3WfngJq0Y4azEkHXIKstxKoBDspiB2BhjWoBc6wUE87J4UA/DOFIA3SoYf+33k5V5SS50+qtfXfYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722575548; c=relaxed/simple;
	bh=vGc6CLumbYsU5Mvhpgy8YySkw5WhvNap6DbUjgjZK+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wd52Ql0vVaBjWTep2wMWqspXfCXqpYlqI7Wp6b2eb9mvzOaoNXt4o7bBKrXyDR9r99+LNo6Y0u/y9vhjpqhNRp3N/P3KzEeQyNChG1HnIzDqLJ4Li19tuAlHC0mkmdyxMPijuIU/iy4br9a/hgZfeapLEFwZ/RHyEGzGF7VFWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ial1DvaO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rqY2wFVJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ial1DvaO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rqY2wFVJ"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id A8281138FD18;
	Fri,  2 Aug 2024 01:12:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 02 Aug 2024 01:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722575544; x=1722661944; bh=vGc6CLumbY
	sU5Mvhpgy8YySkw5WhvNap6DbUjgjZK+Y=; b=ial1DvaOEu/y3JBibzceeWmSdO
	WsGx87UdvTLwcts2lasrFbbWh92GCIIvrIXPqRtpZYlXm4yR/NZ8KO8/H6czeeOq
	R8t5WGAf0ilyqrjLVJMdJVTnG/mJWsQq+ujX2UYfLZW/0M44Fmo1q3pdYjB92tpQ
	Rq6KfBifHBtnjtutSIGbIHRouGZTQSdXGiAvwabg7QnKMraSgs+aJPVVccFp0trL
	RvFyBr9+SrfRuKRfiNQnO0iWNH7RdYl2qcnxgkJs8qr6NboCIgob7lkzDla/+KLF
	JsTnOpQBubcwA8wANefQI1NzA5b+RQW/g6d7LbNel1TFpmNBCj9x4V+g0qwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722575544; x=1722661944; bh=vGc6CLumbYsU5Mvhpgy8YySkw5Wh
	vNap6DbUjgjZK+Y=; b=rqY2wFVJpqx1dmJNbL2KpZKuD2A8bcF79WXcaYpVZWqW
	gvuwW9D5g/dn7qRiG1zbRmaQ0Y2By6+wRsTTamYpZ3ObOWtu66xVXjAx63FQdqtf
	OkQem7seZChdu3TpMw66H49ZIdgOb4MLRvbIvDfUWcoWjf+/G+oS6ONzo2P6rHGt
	V6PApUyM+OSSib9/ct1KIrGYzlRfcq/eZptFfjDPrqjtLqQFomlo3DBPCiPC32T1
	9ysgj+K14hzGKBwaNcTqbx1zXpQIjU2otG+cYR+VstEVfDPLSLraEvikccDN7x1+
	GxCVaPIF75mdea2XLlp02VXUFdQa4By8DoChTNqYEg==
X-ME-Sender: <xms:uGqsZlYYE-z6CiAsCAXSL_1_UhylmyRglMFPqVrIaAV4BXVBGT7Ewg>
    <xme:uGqsZsa8PPfk3DAIAdizan83kxWs3CfiImdb37d8jY2_XQjiKX4dkIxGQuRsZbtvH
    QOgqOoM6VNDkNPuSQ>
X-ME-Received: <xmr:uGqsZn-cXohuIdZ1MQ28B--8ccpsMCp3Au50IZCJ-pYDtiZRMIai6hJd14AMhqw-HurWhDoNqEZ6KV1jSRh-Xl5ullZdfVmW_DedfNMpHs1LfUrm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeelgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:uGqsZjoo2rylAMUorcDdbWS4KSoNWF45gbVrk2asVhAka1botMIX2A>
    <xmx:uGqsZgoBwwawaGjG7YTcthVkYx3NUKMUWR-H3aZ8PXUg58KDvlTGJw>
    <xmx:uGqsZpQJFTb5KLdNr0gQFC7q_-wAz-uYZzo6xAKIiwuhf30PXqnowg>
    <xmx:uGqsZoqdnYyaNFuZuS32H6uVKwgetyVcDS5G4mwzXuEHo42qM5MR5A>
    <xmx:uGqsZrWNtT0Lo8f9_A4CIAPAeKOWBRKeKWYpS7e3N57tT4JVgnEikN4B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Aug 2024 01:12:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 35c54ba9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Aug 2024 05:10:48 +0000 (UTC)
Date: Fri, 2 Aug 2024 07:12:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kyle Lippincott via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH 1/3] set errno=0 before strtoX calls
Message-ID: <ZqxqtIJi4-xBL9Sj@tanuki>
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
 <4dbd0bec40a0f9fd715e07a56bc6f12c4b29a83c.1722571853.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8OdtMhl+qrgBR9Dy"
Content-Disposition: inline
In-Reply-To: <4dbd0bec40a0f9fd715e07a56bc6f12c4b29a83c.1722571853.git.gitgitgadget@gmail.com>


--8OdtMhl+qrgBR9Dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024 at 04:10:51AM +0000, Kyle Lippincott via GitGitGadget =
wrote:
> From: Kyle Lippincott <spectral@google.com>
>=20
> To detect conversion failure after calls to functions like `strtod`, one
> can check `errno =3D=3D ERANGE`. These functions are not guaranteed to set
> `errno` to `0` on successful conversion, however. Manual manipulation of
> `errno` can likely be avoided by checking that the output pointer
> differs from the input pointer, but that's not how other locations, such
> as parse.c:139, handle this issue; they set errno to 0 prior to
> executing the function.
>=20
> For every place I could find a strtoX function with an ERANGE check
> following it, set `errno =3D 0;` prior to executing the conversion
> function.

Makes sense. I've also gone through callsites and couldn't spot any
additional ones that are broken.

Generally speaking, the interfaces provided by the `strtod()` family of
functions is just plain awful, and ideally we wouldn't be using them in
the Git codebase at all without a wrapper. We already do have wrappers
for a subset of those functions, e.g. `strtol_i()`, which use an out
pointer to store the result and indicate success via the return value
instead of via `errno`.

It would be great if we could extend those wrappers to cover all of the
integer types, convert our code base to use them, and then extend our
"banned.h" banner. I'm of course not asking you to do that in this patch
series.

Out of curiosity, why do you hit those errors in your test setup? Do you
use a special libc that behaves differently than the most common ones?

Patrick

--8OdtMhl+qrgBR9Dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmasarMACgkQVbJhu7ck
PpQBhQ/9FkVJiAFBPVvmfWzcNglegGjy4Thgl4fMFOx1maUDsvU9RZU+Xis+eagD
8BQE268c0ob4meDBGJDcwnH/FM/LR0p39gScSsaDhbHdn+MGJk7j1t7hvOh0z5XH
MyZHR0KCN5YKQecZPIwPWAsRGSAeFJImHG11Dj1CPvt299M9NiIB0EQg5dFsBKJ6
sZ0Ptv+i/SsCYFE6VRj3lPrD5tvjADCYBg9FoiaOo7qRCow0XV0Rx+TcJAPDgw9z
H67DUBFfKo4afDEiBrST80QzkZtGyxSJZgE4X9JU0/gRmVcOIPaqCJgSf/N8GGM3
lzFo0whUSRPayNNcGefbKweqcVLKfME4ciaC0xAd+GSZRarFcn8YzYnKyx9N8Ghw
GjCduGh4NG+JvunnNETyuE5Nqkm48LXpsxzef/IDtxjfjg84X7rmlMjYL3cTWx9I
0t0jy7W2AuvNmHR83Jt90S6ql3OMAqwIHFoy85IE6r2UO3+/RvkIH8RYu0K3lKow
jQRCtvkqIsD3FKW0INvCgfYfOjiuirhnX4RnxmTcQ5XLU8v8JHUdQmEj17aRFd4F
kqaplFw3Dx0cw1NUzW9YUqg7L1h1b+qplN+TzKXKRzanMkWRPxePvO3nWMGeH3FD
HEfVS1zuIbHB4rnqqhZQUdY2N5qHJ7YrtYnStt/vVh7ALjtEwks=
=bdPo
-----END PGP SIGNATURE-----

--8OdtMhl+qrgBR9Dy--
