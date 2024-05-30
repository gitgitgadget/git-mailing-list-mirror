Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B5183989
	for <git@vger.kernel.org>; Thu, 30 May 2024 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068643; cv=none; b=pQh3zwkykS4AVe1s0wTMsTEPgW1Uw63ENrp1Dn2ZDukA8YyXrstgT8667q6JBNydY7KAUbtymYQCkBijY+FbYADDRlRLVmvY5/HMBkKOGxhsF8bpLrWjJvfkWud384ueW1DMJuB6E5LM0Y9GM3y0SMl0uY1wR0ZCVYjZIasvU2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068643; c=relaxed/simple;
	bh=FqsbwYh+TRvMhLcPbRARZVuJHpk3JPsaDOpSr/UghdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZBhLZmiZUyHMNfvpxh6wHj0WX0qKJOqT0a2Qcyb0W159cPU6fUQp/BYxgmkfLxAfJ+f17lrehMadnfikagwXLfyPyiQ3UG4/Y+6tJDX+XwpCAXN2jiyCgSmpYa7JlcuYxf6maCLtamyk2xu+Yuz3iOV9IcZJNgoGD+07Ht+z/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iHyVO6fm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GIkRsgRg; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iHyVO6fm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GIkRsgRg"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 370A9114024E;
	Thu, 30 May 2024 07:30:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 30 May 2024 07:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717068641; x=1717155041; bh=t9XQeIK2d0
	M+MBLA+lQA9fFoATrbNNR1t5dydL/uQ0U=; b=iHyVO6fmaD0ZglDpLRPagdITTo
	vE+qpH3KEj2WdNSIivg44STDwjFEWDD0Fo3FqFX/W3RvI1A7minTjDou+qtHuvHw
	VLUMtfC6xd8n9WqJsgmE1Y4CYDYWEws6N/Zz38r/+/7M5w+eDLoS+z4wDIdbH8B/
	FH3AtdQHenQvpPKt+2mIr3/c8bOox8GfIuRBhfLIR4CzNf9n9KBkB1vIPMJgq7ip
	x5UVPF4wJu5Bx1rQLNKQmIHdPdsyXBaJVILf1r2mMZ3f8LwUKcJc5E3HzVrthlCc
	Wz0yoO4TW/5W8Lr35k1FN+jRytLm/93taqfDsm8ieWxfQY8zDVab8o5gzMRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717068641; x=1717155041; bh=t9XQeIK2d0M+MBLA+lQA9fFoATrb
	NNR1t5dydL/uQ0U=; b=GIkRsgRg+27pHIy7eblaePn2t559NtEWI3A1AGWOFcVV
	QDYBp/Ic2U438BpMXcJ98+uuNpp6toUXlU8bxDROU21dS2TDVO9TBIM6fIgciJaG
	e37OwEIDCwBfWlbLPdddBskQ6AXes0ZB8UXr9aoJIrhSMGZT32oeUAwYNU05wksN
	L0I8AlU6OI8ADlJTF8zlBpGU8a9bD0t2RHVV8ihw/c/JgVVBTcBwlK2Cbgw6ecUe
	LDC4bWJ3aHpidX/rkpi6PIJkFvvNBYW9Wwh2/E6tSlUZlWtXXfcMrzFOrgCnrGKB
	tmxk19TQ6ZD9Lr07OJOc8ebu72hIfI6TKhdCp6uLsg==
X-ME-Sender: <xms:YGNYZmFybINwNjiCZge-tq1qnUx8SNPmTf6JY499TFdymdowQzEyHg>
    <xme:YGNYZnX1UTtCv1IAJWCOzqSrvbehnKid9aDk8cSdt53e-fL1C-7E9DrYE29NWxqOj
    PU4bESGYmV0A-cv2A>
X-ME-Received: <xmr:YGNYZgL5qJlV6jlwPZNB-AiepgC0mXESCYyCyz6D2RDsUVbScrrYuz7fRdEEL0LgzD9n4jxysabtFnp-kI-eCxdMg-CAseRrRDPyqlQS9Uht7Hmz-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:YWNYZgE-ZcsgDPKGRVye9Be34UjF4W0s6LVstcZLSlLQagwgescGiQ>
    <xmx:YWNYZsUQANOjR7d1jsjKDJLvdiRLILxMs0mQ4ADIH6WvUNuEnUpgMQ>
    <xmx:YWNYZjO-mrKa0mDqveplOJfxVbaw6mtwihw9e_piaVXuALeaO92Qmw>
    <xmx:YWNYZj1fZhYCUo7WmOU1-AhzoEIoQDKfvIrtMN-OPlsGvBkZWjxDpQ>
    <xmx:YWNYZjSXGzLUdzk7tl9AiTAIOm0vtoNtboWT9SOgw008dqpKs4Q1JnzC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 07:30:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d91fb7ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 11:30:23 +0000 (UTC)
Date: Thu, 30 May 2024 13:30:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/19] remote-curl: avoid assigning string constant to
 non-const variable
Message-ID: <ZlhjXcTdyCZb8eKa@tanuki>
References: <cover.1716983704.git.ps@pks.im>
 <00b4a7dbbcdfd8a0f7b4beb4ecaf272257838460.1716983704.git.ps@pks.im>
 <xmqq5xuwweqs.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A/0E2A6I/wSLo/3L"
Content-Disposition: inline
In-Reply-To: <xmqq5xuwweqs.fsf@gitster.g>


--A/0E2A6I/wSLo/3L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 01:21:47PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >  		} else if (skip_prefix(buf.buf, "option ", &arg)) {
> > +			const char *value =3D strchr(arg, ' ');
> > +			size_t arglen;
> >  			int result;
> > =20
> > +			if (value) {
> > +				arglen =3D value - arg;
> > +				value++;
> > +			} else {
> > +				arglen =3D strlen(arg);
> >  				value =3D "true";
> > +			}
>=20
> There is a micro optimization opportunity here.
>=20
> 	const char *value =3D strchrnul(arg, ' ');
> 	size_t arglen =3D value - arg;
>=20
> 	if (*value)
> 		value++; /* skip over SP */
> 	else
> 		value =3D "true";
>=20
> But other than that, very cleanly done.

Indeed, that version looks nicer. Thanks!

Patrick

--A/0E2A6I/wSLo/3L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYY1wACgkQVbJhu7ck
PpTcBhAAgVpDJiwrgT/qzZU3yPjgddCyvlswmDLE3+w1CVgsU8UO8JS/oJPOXBgu
n+l6lE+DG01c1FlvsqZ2Lhk/UAaDxp3CNb06e/941k5ZOqVnG0HnwILd8asD1ZwF
pfOCnWq+s3y/tgJO40vfQ90P1vc2cy7W6Sy6r9rNmiZ+m3buMxQiukay1lqa+0JD
Ku7aJpswb07IQf0BtwOmUAu0Ha5qLfYdaqCsN2Kg4ovFKSW/PaipLIHPu8dA/eim
M4tJfOnP2teHQ/bBtGHLGmYQjm90u40Ncv21Jbh7TGircQ+qTgbkO4YPx1XaZFxI
qhdyQuvAAf1eR3I0VC7l11LHtvrhw3LXudqTDpNBebR6ZyJso8g88jvNkfNc97B1
vzxdwKBLsyygSXqFbP9dH6pZ5PAwPoGYHDPbkJQMCJhA4Mjxf0AT8yfUqjO+GE8d
Ns0NGWsbNzHUl+8JjxtA7uLbE5kPQryTHNOTakJC3wLF7ruGazFRXwx95Yx9ikbK
E4spzvmYZbt0X9NsJHKIWomWkd7+I6R4HnW3Xp+mSAyd8pjDPkCemKK1i39Q1xNr
WhWDvPcJQeUuu3IeAzWvKu4ps2xiHj9CsIjtpg0xq6kTlSNy7/5FB0UnwVmrt7fo
kChdIGQj1jhEYJoEY6TORWcjMdSAkAF5wW50KaV1no3GsoeTJ/g=
=I3Eg
-----END PGP SIGNATURE-----

--A/0E2A6I/wSLo/3L--
