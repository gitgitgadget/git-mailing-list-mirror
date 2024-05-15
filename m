Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2E213F450
	for <git@vger.kernel.org>; Wed, 15 May 2024 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783110; cv=none; b=ZmaX7ZtnzPZc+k8193zBIktqOj85PuPoQ6gSBqo12Fg+ni9sA4TCeNLWZojgkcqiSmRtwLcmb2FAgWsJ+IGK90S7doYjGFmFb7BBs4g2ukIhIFQKKfi0xPZP4vvye6ymBszolRdLslaPkUlh7/XkPAIiucaqk6CtDK1vWB34I9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783110; c=relaxed/simple;
	bh=Rd+NS0zcwZdO5w06phbFfHd6hoV+m8kFARvOaBIUPFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjYi4CIojHBZNVI3+wxW+1l6dkyyfYZCdLKnaIvZEV8i4vOduwQQkjUAws5Lg2fE25rAyXZdJQwHr3SFWtIYZUuNMF7HvfXzw1Ft0neKIMl/I7/OvIJpnVNcwm1g5CHYGTKN1iAz2mwgZpfiSlkWrNEm51WAH4b9E0lUkVPZFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=okHBq8dQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PK0mtUxs; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="okHBq8dQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PK0mtUxs"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7FC971380222;
	Wed, 15 May 2024 10:25:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 15 May 2024 10:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715783107; x=1715869507; bh=oWvvlZklmu
	y/+2x+v7p6lbbSOqrHJaXlX/ABM6rCi+A=; b=okHBq8dQfApXzwbKrXxt1jR0Xa
	FLB7UhzTxM7oaMvKddYeZE4y6shHjUPJBCf8q0CKFlkWYzaGJSWCAdkJfpmXQhaH
	OTc1oQPlVVQI5DiVK82GFdawRuWR/GFgS1MWTGq/x8p1MHHdZ3aCUeF2MIMjlik3
	EWPeYP8afsfVv74S83/lr/+gm4BvJ09yFobwTJ1kbsWKlXM31qjN8/mKoTm8jRb+
	ooLAHqop1Jcll1/9reXJIcUsQ1NbfKKlpIT6gjQOs/Wo0KUAIrkjFQ+1xCSBML3D
	4jUd9QUjGoc59UKPPUG1oCoQM/DML8uyu7i1V1jFZSl0mfOWZ+tUa0QG6x8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715783107; x=1715869507; bh=oWvvlZklmuy/+2x+v7p6lbbSOqrH
	JaXlX/ABM6rCi+A=; b=PK0mtUxsDUS4bcPJ8FPNHn9MMTX+dyyFgIQON96GsbsE
	rlEK5M9wkwlQzV3KJrb+k6g3tt8oluKKwaRBf7P3Wk4uBHU9v4LJApGVgaV5I1eM
	NLhYQktxz5dTaCiM5kC3+0CXuYBzfjEBq2neenyU0trmIDKdAeylUgvtVFouwnxy
	YoPj2mjAs2TsrVH1YdZ9W/OvL+MxRnNxp7qpXULdBH+JoyTtSeh2LOzkDqksDiUN
	gZSrjukfjVKXGMMjswP4itbwmHFmT2glPCeTqVmkW2tUQJYO6gWHT7iy7BLyF1Z3
	j4GL/k+ufyJTeymfRjTTLCENvmrigUdENSTsZ87kPQ==
X-ME-Sender: <xms:w8VEZgKLw8ClJPhJCj9rECdVeL3wgCABWBCQkAwekzayY9od5OTsJg>
    <xme:w8VEZgIY9OsqMfLp4kkrR8cWAtzra64rGGOjZ5xtQvYTdakJDNSJLum6hg2LRVxq9
    XVhyv7n9yMLbLb-9A>
X-ME-Received: <xmr:w8VEZgtduJn9spGLQcCNG02ShzJzxKuSYEeK0OoBYFmQyafZ481DirAkxaFSwsmTDhRpfyuv0c3j9DfLgT9a8aB7Ns6vZ_g4HHDixzF-9Tv16atC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegkedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:w8VEZtbrHqzCKfPfUwHNUyE3B-BvB5-F-IzqxQZ278VhCmzdK9SztQ>
    <xmx:w8VEZnZymEomKDVKZ0mo6Lgzo5DnrTJSgiRTXOO2yTPIK1h9sAU47g>
    <xmx:w8VEZpBcbRPVWiqZhvsSM4Js7ocaUexTXH_AUBodNaLAGUBIkAyBmQ>
    <xmx:w8VEZtZaFy6vQniPmP5UOxymV69_xcxhghUIXSluV7BxKT1_BZeWnA>
    <xmx:w8VEZmkYl94R_Bus7rK-9eBnNKOsm5ryxRozCj7LdXiWBGkFvCYTGjke>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 10:25:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7d0d080e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 14:24:40 +0000 (UTC)
Date: Wed, 15 May 2024 16:25:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 2/5] t1517: test commands that are designed to be run
 outside repository
Message-ID: <ZkTFvVihZAY184Gm@tanuki>
References: <cover.1715582857.git.ps@pks.im>
 <20240514011437.3779151-1-gitster@pobox.com>
 <20240514011437.3779151-3-gitster@pobox.com>
 <ZkLpTwNgFGFyC4_N@tanuki>
 <xmqqo79877oc.fsf@gitster.g>
 <ZkSpk3v2kRsdOcbQ@tanuki>
 <xmqq4jaz2may.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pkwKtg0Q33Zsrome"
Content-Disposition: inline
In-Reply-To: <xmqq4jaz2may.fsf@gitster.g>


--pkwKtg0Q33Zsrome
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 07:15:49AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > On Tue, May 14, 2024 at 08:08:19AM -0700, Junio C Hamano wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
> >>=20
> >> > Is there a specific reason why this needs a whole patch suite, as
> >> > opposed to adding the tests to the respective test suites of the
> >> > commands?
> >>=20
> >> Yes, testing out-of-repository operations needs certain trick and
> >> people forget to write such tests using the GIT_CEILING_DIRECTORIES
> >> mechanism.  Having one place where we have an enumeration of
> >> commands that are designed to be usable outside repository is a
> >> handy way to make sure that we have enough test coverage.  It would
> >> make it easy to control how GIT_DEFAULT_HASH environment is set
> >> during these tests to have them in all one place.
> >
> > We already have the "nogit" command that neatly encapsulates all of this
> > logic, so the trickery is contained in a single spot in practice.
>=20
> Heh, you asked for "a" specific reason, and I listed three.

Hm. I guess I got thrown off a bit as this was written in a single
paragraph, so my mind didn't process it as different reasons :)

> The tests that are spread across many scripts make it harder to see if
> we have enough coverage for the out-of-repository operations,

Put this way I in fact agree with you.

> and the use of "nongit" helper does not change the equation, does it?

No, it doesn't really.

Thanks!

Patrick

--pkwKtg0Q33Zsrome
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZExbwACgkQVbJhu7ck
PpSWJxAAojBn17VwlTwTOtNRxRhFHd6qdaftssSWcPRNq8fwz8tpL2Q0GpVPMM/x
eaMW+rQeItlrd9wzaRooY8wZInmNeAtdmzFZ+/6cI6zGvFkppffFdlU5bdFG3QlF
syqatrD3Utb12kkY4eJ/zx4qAzqW6h84SzYa0XvbnOLJl7Un6ENXY3salYLxDREa
TP2wsPDEoPn7jzklR/txX9vpHUtpOCM3vSAI1tIfAbGOiMpFhreaMx5Oe8NbA9gW
qisbBjmeQFgyPkbnvLLUCo++ic0Eur6EGIR4LT1pw2iRsVpFV1v8kRWI+pr7tLVr
nBMllCV7MVaUl2Zq3s1KT7/ECF/d4kPV7aTB76RE7B0y80bJfetsb7ayGWJpSQ36
t+Cg44Fnvrc9A7lNf/R9Ztez+ciPYaXuQV4aze7B+y1w+kQ79XFKQ4GdcmQZMKRf
FH5IXhzTIkGbqVdiWE9iu3xSr6qYPZcqbrpuw21ZkKMtbLx3/yzruKFdiOfjbbP4
kfPX5IyskwNE00TjHeYuP7/iYICjTJpQwYCw3fxsjtuuFYwnZl2cboNRPS3Eizfj
9Cw4Tr9cUTMHSuGONeTL51yxPeDCl77rtaEizx461e8WNqWSuTlUKLlOYwCKe/Ay
fWfGhyBAW3t0KjqtsA7XyCb14AiL8YlxOWKvYfeFMJwMHZvYMPE=
=Pqg2
-----END PGP SIGNATURE-----

--pkwKtg0Q33Zsrome--
