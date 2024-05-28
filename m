Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086542563
	for <git@vger.kernel.org>; Tue, 28 May 2024 05:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873008; cv=none; b=smrjqv3LeCNZigzZVSKgYGI6fZErGk6L11MG95kY1oNRCv4TInngWFsPLJb8teUUi+3cSaYgs4Ch1H0eAodVCTkfgv+l9AzLJE/iolL3BST7UgQNJoqXs9/8k/pdFmIAKlhnOEg1uKH0PvrA00VQej4gXvspiwoLO/BY9QWOCl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873008; c=relaxed/simple;
	bh=FoL738S4TinQFtoP9tsDab68VTKLJ5ut+2RDudd+ZCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBY8dONJVPkgRQEkj/n9oIjFN3MR+mNsfZ4A2JTdmTRLjoU2D9eqgISoDZ8thC7PmGs71HNsfdU9QrU2CDgPEpZublTLBcZm/0TbOQWlj7TrkA1fwOEjnt7YL6ZwlhAWFbNxL8wG4rJoYT83BKmRRubK7bJqFW46ztOALohYEDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nmKbUwWe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a2ylDU57; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nmKbUwWe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a2ylDU57"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id E7CE71800155;
	Tue, 28 May 2024 01:10:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 28 May 2024 01:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716873004; x=1716959404; bh=kS3qgXpCAG
	b0ODGV39QjgKugtD5GC3TuAmej4p5Jz7Q=; b=nmKbUwWe9NFpkkv5+L6S9ZbFXW
	gN/Bg2wq0AF3t9fbHcPpCf+v2A4Xnuop08/scpxiXZO/bagIEQx88L2Kclxexzld
	kGVhHUXGzVQq/lNkkb/m+41GeSvmYV0MeQ5Sq5GNoTz3GpHyOUAtmDgvN3HvPb8q
	M1J6pSB2HnvfMgb8wY0De/xkpJ+a98pOCPc3knVgopIYL57jtjB9eYUyzQT1AJzU
	0C1hiWSMbzbxnCspLxn4PI/k4XP32lvOWvsnYXVHhZPOYeTPbQLqWtV2yrYFqPzA
	r+4TXRSIlAfPQbTeTS0BzQjznkBVCfCAFeX50nR1ZkFe8LI+zeybr4Nv8d1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716873004; x=1716959404; bh=kS3qgXpCAGb0ODGV39QjgKugtD5G
	C3TuAmej4p5Jz7Q=; b=a2ylDU57wmaq2xx+3q29TliCup7ThvT5hXkdRhF/24Sy
	EJY7Gq5DDTnCV7ZRQI+xJFVc0vnaoY52Pyw1sjHklXefQVvQc7zCKS1XZR3AHceV
	EEEeGvxL7aEqZToEmfwZvv1kW0WoSPpHEWuTu0GUhfKm7GacgJMFAfVM7unGIgB9
	M9z2+tAL20FeKiRfkn9SIm04n+bDFJ+IAaDXUXUweqJVzcZVhcFqH9k6mzw0u+FB
	uGU1DhYPxuso8W27Q3wVu7wbUEqFpPDkh1QcSzTbxC9RpznBUFfDpQGlxV1mGbet
	ytmKxvkyPg6NMIvgo2s2VU16NftefnykvghHUFKfQw==
X-ME-Sender: <xms:LGdVZiwyx4g1cUlo8Iv63WfYN9sAF_-henqbu-jFVviRrnhda2TnEg>
    <xme:LGdVZuQAauQjSRZXYIa6KNyx2p3AtJRNFFlZUlsBZgeCttWv3KOYIxpwwN1K_uNBm
    avp-LF69-9pUhnEiA>
X-ME-Received: <xmr:LGdVZkWRf__lDS79euL_CKA2Gi43zGD2vcm4h9eAWtmJ5Yfa3i-FqL2NBfQWNH0rPui9HoOJ7i-4U6HmFnxyvrhnQcPRX8Qz8MR4EN3xMmeg8tR2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:LGdVZohEVGyQRCV2X1PLtmAcBkrRtYELplAM3U8CLqhcJiYp57wAQA>
    <xmx:LGdVZkAiFy90y1Dc59Bo4hWUvuJh8rY6ZN6MfkG-gv-CGLXiSIQ2lA>
    <xmx:LGdVZpKxhWmCIdzPeNcxdZ8AGXaX_6VlumSYHFIHLNV39KKqwhXySA>
    <xmx:LGdVZrBYq8zDNmpmsNHAPqkuL77cfZ5b6Dy2la3J0KCXPz5p_vWHiQ>
    <xmx:LGdVZn9NjUTA_mgSYXmrRktV0N3wabdWb6Y2Rq8K63cGT29VMtLAtT0t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 01:10:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8bf78fb7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 05:09:49 +0000 (UTC)
Date: Tue, 28 May 2024 07:09:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/21] Various memory leak fixes
Message-ID: <ZlVnJm4OcPGHdC3P@tanuki>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
 <xmqqwmniiqv2.fsf@gitster.g>
 <ZlQr11P_C-KyO2DF@tanuki>
 <xmqqwmnf9mto.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ash79tmFwlsLRCS"
Content-Disposition: inline
In-Reply-To: <xmqqwmnf9mto.fsf@gitster.g>


--4ash79tmFwlsLRCS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 10:38:59AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> >> Also
> >>=20
> >>  https://github.com/git/git/actions/runs/9231313414/job/25401102951
> >>=20
> >> shows that t1460-refs-migrate fails on Windows.
> >
> > Hm, this one is curious. There are no leak logs at all, and the exit
> > code is 139. Might be SIGSEGV, indicating that something else is going
> > on here than a memory leak.
>=20
> Sorry, I wasn't clear enough.  I do not suspect this is about leaks
> (and the failing job on Windows is not about leaks).

I figured this one out now: Windows of course refuses to remove some of
the files because they are kept open. This shouldn't lead to a segfault
itself. But we call `free_ref_cache()` on a partially initialized files
ref store, nad that function didn't handle the case when it is being
passed a `NULL` pointer.

I've addressed this by releasing the reftable ref store before trying to
remove it from disk so that all files are being closed. But it also
surfaced another bug: our worktree code creates a copy of the main ref
store by accident because we set up `wt->is_current` _after_ we have
called `get_worktree_ref_store()`.

I fixed all of this and will send a new version in a bit.

Patrick

--4ash79tmFwlsLRCS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVZyAACgkQVbJhu7ck
PpQDFhAAk9Nb9Yj4D8KbTTJ/91cbP4X2XHUkSm1AY23u7WVY2xtCgGhkVoSv3uSm
hBbvMxqBFs8aLpMKPTUo+8IyeRYmLb9U5ueoKlEZ8CP56Dlu48bt782PLJg8/bHr
7xiZFjMrynO9bNF0OXFQjj1xlF8NMhSwYGA5DpInhykQMj5d0NrwF/i9dDNUNWjG
n4jawGF7jPbzofvhO3oqkgWid38DmtZZIrz4Kqfg/95tIVqj6oMrFpt9a4AlO8li
RLagROmxVkH5/x0uOJlakbTfwmVHfJ2aXWufPnkBdYJbocSOVPlgyMsNDBr1BLfB
gKObeQrIhvPCj0L5cwuDG4BdHa76YTThs6ShaYbOu83DSk6wPG+a44oAwz2Cd1+h
tbKxkqIBowksr6XFrAn5oLI4399++onAd1iu4K5UVyyQ6aTRiQfExV2ebDbPJ2mF
aQYpGCU7+UewChRan/CcQLc8eKKcukx3etLnI9XpdJTXdLg+b5WNOJZNQMkBXMbf
Ots8yLaNvSjX1ToZxpsnF0/c16yvw9F+oI2Ic65h8sWonb3hpJO6dtg017kNevVA
1UI7ZIgemQ0pFMA0libUjTn7dUBDKi3UYyFccCa5xqPiFLySpA9TGG+e567diSVr
6m6oM6DFQvhv2bX1jLywxltTuFWVFPdiw/t/D4GL9ogV97wRTAU=
=d/1X
-----END PGP SIGNATURE-----

--4ash79tmFwlsLRCS--
