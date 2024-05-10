Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24D3172790
	for <git@vger.kernel.org>; Fri, 10 May 2024 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357637; cv=none; b=aMiDO5Rid363g13M3HpxJ9JEKCi1ApV2TtiKpG/HnypidWOKL0kXGDa8Jby3sierI6KWVhCNTZitlg2PSTWXpjeMCkd+1Tfca7BYXS5xC0QI/hUj/ustkRPmRXg6jEd7MW4PuH6rtFXwfMpE53ByfpxGsGwgECS9KXwVFAsdDWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357637; c=relaxed/simple;
	bh=r0uaHiNJVnrRdv5wCHstWnIdbhODXbmoOnm9ev8YRBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjUyW2zyKeR1h3CcQhnz8C9zkLVOMKa8f02v3PYk9zPstsNsDsyCttFJMoc8sMQvT/jT4YsG8tgtjbBQXzbFPCF2hOz7QIeCmTu+3fLLeOFKvPH40sJTgM85FjcyqPJenhcpuSvIleNeagAYgdd/lxfFrmgqLbUZjmWFFKKsTIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nb5G48OL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OW0EHtF0; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nb5G48OL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OW0EHtF0"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CE65B11400E5;
	Fri, 10 May 2024 12:13:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 10 May 2024 12:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715357634; x=1715444034; bh=Jor/NxhNhN
	siTqpBn8LwinLsCfqChr8EY31EQY4ldbI=; b=nb5G48OLfuasBPu0Z/vimhdIuo
	llUath6r2IStY9zTW0tpp+fkcFSkcm8W0eWzptV70UUMMpAZLcwbaOJ54h+XtGPR
	Q+QZr4rkGXC/bqomvKpjGY4xBFz6YGWPoGkTmdfXrf9MHqvlRfO1yhCEm9525Iui
	kacmz/W5CNKRuxMT8DUnml50qgWL3CbTho9MWxuzRiownHNyfM+20aNZcQEPWUwI
	7zPMlvHSNicDhjC7mzdiWjbGwGnFQy59f994RwAPB6vz6pvAhDyT7RVwPt3CD/ZK
	t8pO5w/wPmzHKGF8HhbmBVqFpjMdHzMS4hEGj1XYDupySgEFRMnak5MPixfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715357634; x=1715444034; bh=Jor/NxhNhNsiTqpBn8LwinLsCfqC
	hr8EY31EQY4ldbI=; b=OW0EHtF0PW2AM+R6mL1Up+MYCYF84VZwwkYbdbeG5K1a
	zQcrta+Vlbl91XZXuWMtIZYcd7K+wdm/NS0DML1wMf9orw6BDk+H3DsWggqH/1ru
	thgxBgIMnbyApbb+/IYEnKXb0OY+JU1wddMGUds7PjfUhSUkyBTy+lcFVhSVRIGh
	8JUEduJTkcGW7Qa+eYXVWaybln8xSWigGlEbup/LI3dtiKFkrRgGm8p5jF5fO90B
	Le8bn3nV3P1t+kVsTIsHFq0mRuRROJ0Vej27IXp6+6MrfEOhMwetaCnBugF8+g9k
	XcKAAaUWB//TEdpEGmyH4GkNy0fOIYfb3KpycgWXKg==
X-ME-Sender: <xms:wkc-ZoUARrY0e626OHMeIEX2L2uxo-3ut0OZmSP5Sa6bxaCJgi4NXg>
    <xme:wkc-ZsnS15gH74oFLGvkhNrmInwBqLsHM6oZZ6-oAPzpeKqqYhzS6gAP8-Ez0PaGc
    V5vLyYtxbFTAJEH-A>
X-ME-Received: <xmr:wkc-Zsat8ZFZviT6WGfCjp8XsT3pL-DUrPqI1OMLmDNb5mA06VCD4PZRZhNmeXP8UmUId4G_v2F6y2PpVCpiCWzpsLoCoMzDXX3w4NTsJ52WPcm8IA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:wkc-ZnVNcnGqUosdDFF8fADvXKqJSAQqLYhE2H2pPUPHguq2zoBVIA>
    <xmx:wkc-ZindYRl11rvAQZUCjFmu0KnCiQIhQCYd7x-dWIZ-KFpjoScEWw>
    <xmx:wkc-ZsecEKwTxFdFhDOLuPZrDq7w6-8Lev36SscFQJBZ7iv6wQ-qRg>
    <xmx:wkc-ZkEc_7vlrqkVwzWJkTy7KK456fUIkVj4bXHzwtlY8UGz-vazLw>
    <xmx:wkc-ZnwGsjh7ZdncAiPG5xuQRCC7NXwavTcWqbJjtl7ubsRy4yuCZBfb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 12:13:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 85745004 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 16:13:38 +0000 (UTC)
Date: Fri, 10 May 2024 18:13:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/13] reftable: prepare for re-seekable iterators
Message-ID: <Zj5HvF-Uq0uWranj@framework>
References: <cover.1715166175.git.ps@pks.im>
 <xmqqwmo3x44s.fsf@gitster.g>
 <Zj3RR-I1v1XwSuJ-@tanuki>
 <xmqq1q697jzr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="14qu5iwYxGOXSvG+"
Content-Disposition: inline
In-Reply-To: <xmqq1q697jzr.fsf@gitster.g>


--14qu5iwYxGOXSvG+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 08:40:56AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > The below diff would be needed on top of what you currently have in
> > `seen`. In any case though, I can also resend this topic with
> > ps/reftable-write-options pulled in as a dependency. Please let me know
> > your preference.
>=20
> Is it "needed", in the sense that "without the fix what you posted
> is broken in such and such ways", or is it "I think it is niceR to
> have it on stack because this one instance does not have to be on
> heap"?  To me, they look equivalent and I have no problems with the
> "nicer" variant, but your "needed" makes me wonder if I am missing
> some correctness invariants I am violating without realizing.

It's needed in the sense that your version leaks memory -- the `ti`
pointer is never free'd. Other than that they are equivalent indeed.

Patrick

--14qu5iwYxGOXSvG+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+R7cACgkQVbJhu7ck
PpQmFhAAnbaQS+6L6y/ohr1xZFaxQ3zTYSbnusHXQwm5De6rn+K84PFccpPK75t4
jO9eKv4kfcZjqghr1tQSRLHzX12OEY7lEBidx02s969JHAtXiSCU0Q5REcXaw/l2
Qlyh4S6AVEf7ecsAkCCjHG8xmV7gGuTZr6NQqKqFQXJk+TM9LnbXkGZaS5U2clbs
VJn+BrWF+YpoTzKHErM9usZR1N48b5qUitQ0nZ0DBqCi7AjUnNdfM0ki/4bViJC7
9ZgXKyqLVJMYfN5U6H8/ODFcL74u9Wy9ShwfQe9muZbnsuostoapo8i3LxnXgsaB
GeXjhuRZbAXAqorUi4tPcz0TV+Owme2lh2IvpVEYgFwcCg1GVZsr+/DSnI1mXSOy
7uOQboj2m2ytoi/FeCeD3CYDAMCMAIIgvNihu97jZDa2wLPST5fFUZBrd2pbdVFu
iCc77gQvlr4bEItdKr8abMfFtEolbCxmr7Jgt2PnGR9o+7swQ/mJAT0F0oqR1nrU
SFgiN5gkEG81JxGGmCeWngYB9jsbFgnOft0WdeAelFwDMOwgJcyFubfsAEUNPE78
94nyp9IWRXfW9EQcQhI5Ivn22cnFCV4xnCctf77zAdG+tavWKOWmwk+I6FNqVrq6
eH3lpzW75zWbrfHvdH914dDJpolg5O9Grnf7Wit/pYk4tB5Toyo=
=Ehnh
-----END PGP SIGNATURE-----

--14qu5iwYxGOXSvG+--
