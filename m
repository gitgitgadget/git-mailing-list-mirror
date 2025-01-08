Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BA419DFA7
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736320740; cv=none; b=ovaDGRPBLsJq7dMlK/AeTiDtLViWpo8H4wr3jSWQH2plw9isPNjT7WfjZIDogYGPJw/lHS7Wvo/gi/D3IuEi7Ur4gBrPth2CrbLQ1YS0esYtADrc/vecF7ytrPZJbN03IXRSW1f9uxFKtJ0kDB8mkEkSJSszuj42K0t+TMxm30g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736320740; c=relaxed/simple;
	bh=xJ0Q+lABFnD3eo5aBTVdZssrQQ/2zuLQ1kOe1UVbj54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQfMr5UtjfY3THEviLdUKhN2kGbRJJ7sMgpzVDWgxgd3a4XGhVWgYjI9LAOQsXVwKDZFDuWfzXoWD/HwWrze0qp4K06YJRc8yqJ2IkqLFBnOoMzS8n7UjvYDSbpBVlVk7o7slJU6+4VNIvvGMI/1ZznZhWDU6zjWaa1nZ14BNx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xu66W9oS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=od0n/q2s; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xu66W9oS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="od0n/q2s"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B28671140187;
	Wed,  8 Jan 2025 02:18:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 08 Jan 2025 02:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736320737; x=1736407137; bh=ORWJeL5jMk
	NPkL2aVlY9sccQeIswi/1Sih309QvpotI=; b=Xu66W9oSZk/NDbRPIVQ3ihi8Sz
	dFyUbl3OnkYHZ1yQ4FLQA4djfHVneonWlaFeyBiU3m/VHmNapm0agAHm8S+gC7l2
	ykJKErRZukoXMvWZet2mWKCC5bAfINaaIn0Z2fGB1pIkn3zWVgzYkL7wOFcZPlP6
	B/6d/hGx7yVlhYIpYsOTBLAGkNw9n4o9qeA+jbYUD4MEG1d89UzjEz0+DqnlpYtZ
	J2XijdTqxH0L6KDfpSvWuuZFKipDLKDDMXvF+Td+qMBaIHdvXtxCdDoTWzrbuNeP
	MPCJZvEXFmc+j2ITrTO0gzAxQiU0kJRFaH1A5I6Ez4Hp3r53TWOzF6VNV1/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736320737; x=1736407137; bh=ORWJeL5jMkNPkL2aVlY9sccQeIswi/1Sih3
	09QvpotI=; b=od0n/q2s9KUXQQhM49mxrNtT2C90CQn0RxS7KUhhPhP2eACHf6H
	eAT2AkfuCT8LXnrnZnn0iaAEJuu0IJeOcBEPEsu/hm6V9Tf11lxB8gd2cuMYHArZ
	rw7ZrST6DWidgfZO+uy0isvd9MVd6M1hy/dWRcn/mfNR1c5G69O7q3rfPZDU71nQ
	Jd/zCSJGqZXtZQ1bPnaanqetytCR2EwpQ4SDe8uXPE72s1znjgw5LTw0JSrDZiLO
	j0q0WOupwzeThTMJoHBAa8ET58FJMozmbup58oz0UVyac2waPf1FQITaa2Eo5h8k
	9IlNDlP78dXR8ATEs1JlzE5FNV8Ii7wLG+Q==
X-ME-Sender: <xms:4SZ-ZwXGwiyassYzgoM_U9TuD3dvTh8a9HY6hQNOA6VnmoS0oL9t9w>
    <xme:4SZ-Z0nqaDfBrr8-MDljd82Z_qWBEv4glvF2bYBRmyTk8mTymOD5JcEeLmyGRPb75
    vKWKrNRP6NqKTWvoQ>
X-ME-Received: <xmr:4SZ-Z0av1Rr1MZ30mYeUV8LFj8xN0IAmzei5v_WAh-UfaVu1qKJaJAA7xafa0dlnVTTfF92eM3PR5kMGxhqFYaDhxLIFfJAAHVIhyEfNz-mPVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegfedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejvedugefgffffieegtefhgfeikeevfeefheevvdeg
    ieetgeeujeeliefhiedtueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprh
    hssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtoheprhgrnhgurghl
    lhdrsggvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthih
    thhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:4SZ-Z_Xw3_WC4Y2yXB8W8n-1akkttWiJ5RXvTYlf8Aiw7vJvTJeTmg>
    <xmx:4SZ-Z6l69bab1TOO-9fB29EXq-uAS_yhaveeBe3bJUdFW3bL3RMkpg>
    <xmx:4SZ-Z0esa5UWhJ6zgUmF4TApricKwLhJK8FrL8dJpszYWL9Nl_hc-g>
    <xmx:4SZ-Z8G1sTFitJC_n30lwbab9BlnfrRqYmau7ec7zIA_Xz9pqpy8fw>
    <xmx:4SZ-Z7DboUAX0edhF1ZGH_VuDBAGGLZAAjoFOAmCaI_ttAeVp_zmayhV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 02:18:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fabcccd5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jan 2025 07:18:53 +0000 (UTC)
Date: Wed, 8 Jan 2025 08:18:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org,
	"'Randall S. Becker'" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 0/2] reftable/stack: stop dying on exhausted entropy pool
Message-ID: <Z34m1HRLAeEszXDG@pks.im>
References: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>
 <Z323CLrRsnOko1gB@tapette.crustytoothpaste.net>
 <00ac01db615f$70b72600$52257200$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ac01db615f$70b72600$52257200$@nexbridge.com>

On Tue, Jan 07, 2025 at 06:54:02PM -0500, rsbecker@nexbridge.com wrote:
> On January 7, 2025 6:22 PM, brian m. carlson wrote:
> >On 2025-01-07 at 15:26:58, Patrick Steinhardt wrote:
> >> Hi,
> >>
> >> this small patch series fixes the issue reported by Randall [1], where
> >> an exhausted entropy pool can cause us to die when writing a new table
> >> to the reftable stack. I _think_ that this is only an issue with the
> >> OpenSSL backend of `csprng_bytes()`:
> >>
> >>   - `arc4random_buf()` never returns an error.
> >>
> >>   - `getrandom()` pulls from "/dev/urandom" by default.
> >>
> >>   - `getentropy()` seems to block when there is not enough randomness
> >>     available.
> >>
> >>   - `GtlGenRandom()` I cannot really tell.
> >>
> >>   - The fallback reads from "/dev/urandom", which also returns bytes in
> >>     case the entropy pool is drained.
> >>
> >> So OpenSSL's `RAND_bytes()` seems to be the only one that returns an
> >> error when the entropy pool is empty. I did wonder whether we even
> >> need to introduce the new flag in the first place, or whether we
> >> cannot just use `RAND_pseudo_bytes()` unconditionally. But I'm a bit
> >> uneasy about it given that OpenSSL has this doc:
> >>
> >>     RAND_pseudo_bytes() puts num pseudo-random bytes into buf.
> >>     Pseudo-random byte sequences generated by RAND_pseudo_bytes() will
> >>     be unique if they are of sufficient length, but are not necessarily
> >>     unpredictable. They can be used for non-cryptographic purposes and
> >>     for certain purposes in cryptographic protocols, but usually not for
> >>     key generation etc.
> >>
> >> It might be too easy to accidentally rely on `csprng_bytes()` where it
> >> actually requires strong cryptographic data, so I was erring on the
> >> side of caution.
> >
> >The reason I didn't use RAND_pseudo_bytes is because it's been deprecated since
> >OpenSSL 1.1.0 and RAND_bytes uses a CSPRNG just like RAND_pseudo_bytes as of
> >that version.  Once it's seeded, it should be able to generate plenty of bytes,
> >because I believe it uses a CTR-DRBG, which only needs to be reseeded after 2^48
> >bytes (which is far more than we should be using).
> >
> >We can full well use RAND_pseudo_bytes, but all operating systems should provide
> >an appropriate entropy source that can provide 256 bits of entropy on startup.
> >arc4random will just kill the process if it can't seed itself, so your changes won't
> >actually prevent dying on a lack of entropy.
> >
> >I don't want an option that chooses "insecure" bytes.  My preference is that we
> >require people use a different backend or an up-to-date OpenSSL version that
> >shouldn't have this problem.  We can use RAND_pseudo_bytes if we really need to
> >support older versions, but there are also no major operating systems which
> >require that old of a version (CentOS 7, which is dead, used OpenSSL 1.0.2, and
> >CentOS 8 uses 1.1.1k), so it's probably not within our support policy to do that.
> >
> >Note also that if OpenSSL is being used for TLS, a lack of entropy will result in TLS
> >not working, which means that Git will be randomly broken on that system, which is
> >not really an experience that we want to encourage, so that should be taken into
> >account.
> >
> >Can we get some more information about what version of OpenSSL is being used
> >and what the system entropy source is?
> 
> In my situation, OpenSSL 3.0.11 on ia64. 3.4.1 and 3.0.13 on x86 (x86 works fine
> Because OpenSSL uses hardware. On ia64, we end up on PRNGD, which does fail.

You reported in [1] that a couple more tests are indeed failing, not
only t0610. That changes things in my opinion as it shows that this is
not a localized issue in the reftable library, but likely in multiple
callsites where we use randomness. So my current patch series is not
sufficient as it only fixes up the reftable codebase. But in the case
where it's a general issue I tend to agree with brian, because I don't
want to play whack-a-mole with all the callsites of `git_rand()` where
we can indeed use insecure bytes.

Honestly, this rather makes me want to remove the OpenSSL backend for
our CSRNG completely. NonStop is the only platform that uses it right
now, and it seems to be easy to misconfigure. All the other backends we
have don't have the same issue as explained further up in my message. So
does NonStop support any of the alternative backends that Git has, like
`arc4random_buf()`, `getrandom()`, `getentropy()` or reading from
"/dev/urandom"?

Might be I'm coming to conclusions too fast, so if I'm missing obvious
usecases then please stop me :)

Randall, you mentioned that your platform had a maintenance window right
during the release of v2.48.0-rc2 [2]. You never mentioned issues with
randomness before that maintenance window, and after it you hit them in
many tests without any changes to the CSPRNG between v2.48.0-rc1 and
-rc2. Could it be that something broke on your end?

Patrick

[1]: https://lore.kernel.org/git/00ad01db615f$ce9b6740$6bd235c0$@nexbridge.com/
[2]: https://lore.kernel.org/git/000501db607c$40c009a0$c2401ce0$@nexbridge.com/
