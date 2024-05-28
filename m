Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519D216E894
	for <git@vger.kernel.org>; Tue, 28 May 2024 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902861; cv=none; b=Bb89sRW20ptZnr9bUioUd9VooRsD21r9sIbwlOs7CsMdbNRA3d+hKAvTq8Hjb7P8IOF3Y9Qcdbk3B4M4pY3k5k8dzr9uat+NHxmRaCY1CrysqnK3prMKoF9kbeJBmVFkE9h7XfDDqhjHa6otqG1DXxFXzh6v9f0pHEyh9p3CI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902861; c=relaxed/simple;
	bh=miFiN2SVtc9RxjJjGP4LDDYN6bIKFKlaPHZ26zcNB3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dt6sBIdSVtMj9WWsLxGzL8YVCqKclrIdtf/xVWORBGEDzU0BSKGV11dXYEMgYHuUAXA43nBEO05oPeomNxZ/63AXHiHmQszk4w7YqQnfFYpyGrPLdoyUXXcPrDn/3l0nRLqHZ+5AWUGBglulfxWzWD/U9hykFNMnIiQj7rJzREA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HBWAxIJk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jw2nHar9; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HBWAxIJk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jw2nHar9"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 88775180014B;
	Tue, 28 May 2024 09:27:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 28 May 2024 09:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716902859; x=1716989259; bh=9LjPPbLXOy
	V+ocXdc38cjrjm6In2xiSp+ZLT0PMGKT8=; b=HBWAxIJkTZb8EyRAh8ucoo4G7s
	Z/YUEt6yXDZfTaJASDd4GUzod7XSKRN74sPiiXiC1S2u2rpeXnZHlMhTA+Ftj+o2
	XJ7FiYXGDmJKWeFY/8/ZYXIWv5hr21egAJ2uVThcxu+LxX0f61tbDjEAHK6o4W1h
	Fa67twunkSNZd1i+zNPTLb4KesAjFV2+RjVAs23BdJ61g3OViGbv/f4SAnDgQ6FK
	PEexjXnoXLxPdtjCj8Bt+4aB9vmp0m89i8Ba1xULQXtOof5GTsrqNycfbvjSMu8n
	MinLhnrFZuf3kW+Rmg7pTL3eVX7kaI75+XPDYcMkN/4pwtOHUQe4NV2FaVSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716902859; x=1716989259; bh=9LjPPbLXOyV+ocXdc38cjrjm6In2
	xiSp+ZLT0PMGKT8=; b=jw2nHar9mt+QQhczoT/g/gEIo7izzggd5rue5oBoVKdl
	UmDKCSLuNzk5IRGo1/0Q1SzxaTzCI07MFIYxUWQapvE3rXSMEIKN4Mq60TtsML6T
	Ee01nx1wmSfJMwE9JlVdH13hsg6erjyijJokouditHhN9kGbZV1HiwCQ0p0IOW4F
	sX50yO5L1DUvSmt9kahzINliAjEeXNHYmMekmRSBuBBLNVrxKmVTu+unDRMatJ32
	b6vH3VoUV8E2OZdCBYRJh10oVMzn5WNqTQcsFzFqSAk16d73Vv6w5P62dPUENXbg
	2In3yr1kWnJfDbz2h2Jo4q0gyKXDurfaUrWOqhloQw==
X-ME-Sender: <xms:y9tVZqsZipW3EDahJ3WSeoPgc-7soJu3LeJRo8KPFYNU1VybTTlUAg>
    <xme:y9tVZverdvppCd0YqKdYdBaWsVlwJ6v2EpkwWaVv7sJeLd4yrw7qyRj1mnTcU42Vo
    twSjivccIgdpdPvIQ>
X-ME-Received: <xmr:y9tVZlx6G_S4E8a2xnF9VErPiizmxr9VWzKqFtyvOaCD1kUBnzNkBEuZ41OItM2NtkoKT3Qz-ld2MJgiw9fJKNObDXTgxX8QPteEhHI7wNKA2Uj_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:y9tVZlMtVXmCyghodtiphEYehXvHG-J-JGMcOOdBnHhF6EdH6vUyFQ>
    <xmx:y9tVZq-ixC7-a3EivcxAPeNMjnfXfZD_c6fQktBA66onoQY8gZfIQA>
    <xmx:y9tVZtUaHdDu3q18R53BYO-mQc9VvwIzSccpwy0DWcwJxnx50ATrKg>
    <xmx:y9tVZjdceaf-B6MBGGaravss1pRoRybNpOO_-I_5vZF_4u9RLkLEyQ>
    <xmx:y9tVZsK2eRlcWIoK2lmjm2gvJwatQ86qBbg7U4BON_HQkzAbLwcbfUn1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 09:27:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 35dfa8eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 13:27:25 +0000 (UTC)
Date: Tue, 28 May 2024 15:27:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] format-patch: move range/inter diff at the end of a
 single patch output
Message-ID: <ZlXbxzFOJ8gVv7r5@tanuki>
References: <20240523225007.2871766-1-gitster@pobox.com>
 <20240523225007.2871766-3-gitster@pobox.com>
 <ZlB2g5bTuBFz5m5_@tanuki>
 <xmqqo78ukhmk.fsf@gitster.g>
 <ZlQX0FmIsz2eFgsC@tanuki>
 <xmqqsey39mmt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ogzM7JDpNz2Op8JF"
Content-Disposition: inline
In-Reply-To: <xmqqsey39mmt.fsf@gitster.g>


--ogzM7JDpNz2Op8JF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 10:43:06AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > The machine can cope alright. But I think that it's way harder to parse
> > for a human if there is no clear visual delimiter between the diff and
> > the interdiff. And "Interdiff" isn't quite ideal in my opinion because
> > it is text, only, and may be quite easy to miss if it follows a long
> > diff.
>=20
> Apparently our messages crossed.   See <xmqqed9qke3k.fsf_-_@gitster.g>
> that takes advantage of the fact that "the machine can cope alright"
> with an extra blank line ;-).  The message is its own demonstration.
>=20
> Thanks.

Yeah, that's definitely better. Whether it's preferable over having it
after the signature separator I don't know. I personally liked that
version better, but can totally see why others may not like it.

Hm. By now I've gotten a bit indifferent, to be honest. I'm not a 100%
sure whether it's an improvement or not, but I don't have a strong
opinion either way.

Patrick

--ogzM7JDpNz2Op8JF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZV28YACgkQVbJhu7ck
PpRxcBAAp4cCU+qRChgY+g1tO+kFldzB0ELamHfV/eoRcfgKB574w0PT6kuKMafo
S946N1TGwCEru4mCaWgP4rEO/IbxdFNIi8nGtqinN+q9BLdktVHC/xIE8kLz637T
fRd++olLFWWiJLWNPNVdrLcHFLUiLBr77vS9PXo1l78fOcgTeeGYQaehP8tHKYXE
l6iDXJ9ZCxGC23xP1Ojd7rK5lECOC3Xy9u8pqLVBPOyVbPL/4eYNk0Fnlt7S1kbC
DMbn9fDvLmoaKTDz8vsHouGXZD5pCpFORUb2osr8ki5SmPGJDVcBS49gfptAxeWy
bt8Gbf7OooOt/yM4LlvGXArZvNb2f8iyYrhCOY3IKT7weph2/M1rIzervhOFtvL5
nDmQ7o0A7TZccu0KY5pnGBcW+xhNPZ9cnLtACMO6y1G++nnq+hQFZF5A4GDWWkhI
RAORj10wZpmUegUK33nTRisls5ptpYL3fEwMeJj7QJYXoqo1U1K/tZibJqZeNuaO
RgVKY5gl/XJFMxkfUzHPWMeGnoU03LmjgKKNmDcdTF1CV4aJKS4W/KEvFO7m4w5Q
eGv9yPHPLuQr4g914gih5Fw+TxkmABQ2KeKEkAu1rL9C6zgpahpVKl0PEXxAF1Z5
K4tRtHWHZnovpfZsW8rEdr/b/mqIGyssI29ucQUu2X08Gap2tRI=
=nfcI
-----END PGP SIGNATURE-----

--ogzM7JDpNz2Op8JF--
