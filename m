Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87192143887
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712143301; cv=none; b=UNWi08lepWryXovXRV2zH4mgq2gPnw6lfuARsF+vV6P+Mfnxo1jEWC8FYGiWa9ti2y+Yp6XDJt4l0W1MLUOlXLx7gnDBK5zdYTQQ3kGwuixCuddk2Mqbn0PRTS8GgVgCC631VvXAK8xhNttZBbSMLEwf/JUufYsW2pTM7ryFnpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712143301; c=relaxed/simple;
	bh=u4qyJt8a3ZrFvJxgSVQSUxOEheawswJVZ2bypMPKZDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppLjjB7RtAnmrXN6dnxgpNRqMaIhbO+Gd8Pa1n83MVRw0k8JQ8cJ85sfe7vGMqA33Au+/zga12QPCL1HpQM2AkoRu5wd6aW5h8Iv7cwZG2jzaZYYmP9mMKwtXU/hYTAId1Tw3B0sS3/uqgNtmD4YX/qyixFmArZZ+AQ0baGg3/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CXUGxRLL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xjaav/c9; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CXUGxRLL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xjaav/c9"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7A8A5114012B;
	Wed,  3 Apr 2024 07:21:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 07:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712143298; x=1712229698; bh=NnXF0BVOKw
	NTPL3ee+qCj3k5MtPU8W5XWqYZC8StOJM=; b=CXUGxRLLAKxe6LWBNhSCvNTYxT
	bHerU7PhklN+7Tt6wbmvxwrv+wfbURLSIr+YvRBaq18IqBg7hDB0o+tj/EDD4jQa
	/JQepFgKjNt2ykh+2w1mq/gLbl2Irdv8763t+AiSXXranrD/25DTpFfUUnlT+pxK
	qNx65bi0WM7X7UiTN921QqisphxySqSIGBT4h97LEezS7qKqyARiUxMAB7ePAnfi
	CxSaqz7/IbjqzlVBAhs2+SxnCTex9TkzxgDq8nxxFaIfj73ekGi6p0n5GrphB1wE
	fJnd4jvYSp6Z+wwaYFa9A6T37VH4Ja11yNjZTcdWlYm7eSYWGluR/Djqlifw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712143298; x=1712229698; bh=NnXF0BVOKwNTPL3ee+qCj3k5MtPU
	8W5XWqYZC8StOJM=; b=Xjaav/c9vl4Q2V0zWfUcqBsjnUkBLFATqQvzV/9ES99C
	oKngvBjPthM/k38ugsD8NcG9Bu+8JXuGaWXHL3GflvvWsuWCnhOZtPvtmStvREnx
	JuZysrP1L0xTSmtRqco6cifoklgFPIs5fEtoh2LR51ZObJ8yY2TWKJ/0q63K8DLb
	+AIqD90z4h4YOTn+cFKqW+ON7A9EnBzw6lXbGOxqt1buzCxgBwcniW4ljyCJY23X
	21oCQnn4S4xf9Hm2ongkrAww8Km/ZPETGf29gzJcSE1dgikpvMmeclqimsuvIeUe
	SzrZ4BEVfuUwJrpUjPo+DD+b10abpIRa7S0IrDuz/A==
X-ME-Sender: <xms:wjsNZkPCIxyoNHPaFJ0hkC3qx9IkTIPBMbqCzTizDW8SLj3ZqMRXsA>
    <xme:wjsNZq8EfJNfGnaNjz4qZCdToU1mRnJ1bSo3SrLoyv3btnExceL2ftWJyRUewG_m2
    e37x7p3Px3CMuanyg>
X-ME-Received: <xmr:wjsNZrSQt0JBdTLvtgzRfmw0NEnaX_f1jQd1y2LaxbXpEenDpHW9rbdvbiMSbJNrWI6HqxWGmpnd91N05oz9S0wTDaC_cuAfoTHLpmvS4SmlGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefhedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:wjsNZsvA_RZ7Z_8qu5mCjWZVLH1uQH5yvXz3UMcXiPS96KoACzABCQ>
    <xmx:wjsNZsc8qcaA3Q0exbkVnufsheDQhpf_zt2GWFKfwhKfU10GfiytNQ>
    <xmx:wjsNZg1HBL0jEig-z-7CU7O-BH_2mF9izCVj4FY2ja9zcJ9TI62uGg>
    <xmx:wjsNZg-AQYuB3aEzo4pS0Am0UzdAgtkqRpG1T3WL9uDmVAXRWbeynw>
    <xmx:wjsNZk6hN0OmONDvsTNA2PTKaFeizBjkFa7VoErRBGIETx448QbQC_eK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 07:21:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 07c39176 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Apr 2024 11:21:24 +0000 (UTC)
Date: Wed, 3 Apr 2024 13:21:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: git <git@vger.kernel.org>
Subject: Re: Subject: [PATCH 3/9] refs/reftable: skip duplicate name checks
Message-ID: <Zg07vKzkeXt7l8RW@tanuki>
References: <CAOw_e7YspBkOo7QE0Z3QqWXd6P1OVnF9j3q7ircrce25KNbKLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pN56aPOtbDPCL5Pm"
Content-Disposition: inline
In-Reply-To: <CAOw_e7YspBkOo7QE0Z3QqWXd6P1OVnF9j3q7ircrce25KNbKLw@mail.gmail.com>


--pN56aPOtbDPCL5Pm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2024 at 11:47:10AM +0200, Han-Wen Nienhuys wrote:
> I can't remember why I did not rely on the available routine (did it
> not exist at the time? or maybe I assumed the files backend relied on
> the file system to enforce well-formedness).  If the functionality is
> covered by refs_verify_refname_available, it's probably better to rip
> out of the reftable library (essentially, just delete refname.c and
> friends) rather than disable it. I am assuming libgit2 will have an
> equivalent routine as well.

Yeah, I was on the fence whether I do or don't want to delete the
corresponding code. In any case, without Git as a user it's much more
likely to start bitrotting even though we do have some unit tests in
this area. Whether libgit2 does have a similar generic D/F check I
cannot remember though -- it's been a very long time since I have
written the reftable backend for libgit2, and the pull request is
bitrotting.

My assumption is that as soon as there is going to be a second user of
this library we'll have to do some cleanups regardless. So I'm inclined
to delete the code now and potentially bring it back if we ever see that
it's indeed important for external users.

Patrick

--pN56aPOtbDPCL5Pm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYNO7sACgkQVbJhu7ck
PpRY4BAAqgGVqozCw53mxN6WJe1bS8Qv7tnaFO/em4vJDyaQCqns11UbQmv0Ha08
HgE+hGa8LLQ8xSO1+77OI9oHILa0LbtKCRmUj2o5cxSNm6Rnb5D9B2H0GB8TpvHO
h0C8gaHw9DmbSRRh6Cw69+DuAuelxbeqKpa/ax31iCsr741eOJi6dxluKype96b5
huf25KRe8I7UAYpLOr4bFhDQzk7X/eqI4W6qB+5rgGUlsgPxIZpYFu8Su+ktaXpi
2o0LIH7PjIPIBRQNKXH1e7IkWkKJLYxI7ObvS/qn1Uva3ka2gs69cq8gSlMbyDUk
JxWWTaT97+eHViqQT1p1/kUpz1K861m9gEX9xqBGFBdwCTtZMvaAKrZ86XlQORSx
H2yzZwpr6FnScqloZ7tLfseC4BXOjsKX52xpyGJu1m/OC0nTYByGoH3mCQrm4KJE
uZ0pnch1uj+zQjGd7xBLcN+fwsSg7HFfVJgHOLbA1L1gdTiR9ahOwY2B0nS0g03W
R+G66edVjSaT4tMXgPAHEwiE12z3ney38WXw/AqHS4IgIJhivC9mwVvnl66izErf
j3/l8QcKJAHtPKQ3U/PoGih/UkqsPVVpT/YWFSTgYS8kmUs/FIRlqeIbReStYNNv
UsIxDX1cs7v+FkKIzEB/Orp6nb2nwUz1DGTf5pUZ++yeKaQhAZs=
=1hS5
-----END PGP SIGNATURE-----

--pN56aPOtbDPCL5Pm--
