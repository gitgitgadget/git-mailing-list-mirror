Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD61078F
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739541676; cv=none; b=RRcEQJOa2GFuPgEA2kkJ/axWjJNuIkVetecuSBdm5Za5OjspnFdKKJZs5eooKLsiiChQrIFqpkusIsVHw/r00X/HTgroVJXyeVJ9ErofNAJ6emiy7/158ebIlUzuvK4Gv97tBd4cywSQzNBIK4dmoNL5bcNz/9AaDVpOumshzAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739541676; c=relaxed/simple;
	bh=zmwmE+D0gOg8Xrgch2Lud8bOGstFnEEyehQJ7AzFAl0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g5MH2ZxguWAMhSNxSfQU4DtTS+5T+w/LNBR08NLNftb3NxuHtIh/pQh3Q4AKfgJN+8TtAv6sAj/Lg0su7NdCTz/BplAkWZ3h1N9lOZekPN9Q/Qn/cxbdlVMejy5/BYetYhfc85Tk0ElGKollpvNXaf1BcRzz4Qo8qvcXfGsXC0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AooOYbGg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sn5T7eph; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AooOYbGg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sn5T7eph"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 047301140198;
	Fri, 14 Feb 2025 09:01:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 14 Feb 2025 09:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739541672; x=1739628072; bh=thY1EV0hL8
	XjnkVjo0buyKHrPx/uK6FM6ipjbEAGrMw=; b=AooOYbGgthh/r0mosThmS1cUYN
	SISxzXiUYmWYmcgyDMXTMyXkohbJU9QPdCfzISmMl5B9todh5cdSA4pQy2N6+Xr5
	MCReofAa6ZtXRdLGHDEly+HOg/FFmolsQD+IVO0+ydbOsLR6FVISyh7PqMnt2dSo
	bIwOEYLYfd8x/0uV/nyZiCimaq63dxTjDXJfoVAul/klyF6zQUx1JUXU5VH07ery
	c84OHz/PXY4J8QTjlVJ1V4iZWTv4dPDNf4Tk1/iqPwdzyLxoMCNwGEnptW6RA59q
	paDpLDh35BoM3A0YSQt3ZNSuuhi2McQdaV4wST8mAFJqE2kNfmNGe/oStX8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739541672; x=1739628072; bh=thY1EV0hL8XjnkVjo0buyKHrPx/uK6FM6ip
	jbEAGrMw=; b=Sn5T7ephaOsTIqf2VoNVgvkigur5paqsvRk+JrjWwkp0a4mTCWc
	JPLFTd9Gz9e1o/m1Sq5RqTvLkc7D2d9Zp87fjABlZ2lxh5VziAlndi7FmZjTLabJ
	hGQ+3NH4au9VzNL5RsmTFAcn1DjOH0PaYNlUX8Zt/nChGwRTEyOXWCOh+jA2qzEG
	MnFN0odMGp501rh7NgbbChu/ylUAmrLRSf0dDgjb4IHFPliCEHMHiFf4JyH3IZ10
	7Rb8r3m0SaK4JDYHg/OBrljB1pGGMfLopNJsdZ1Khy36eCsgvHRiLQjUta/3A4/7
	/LYCVEuEIWg7uOZsjt2wc7X+A2ynZoTbT/g==
X-ME-Sender: <xms:qEyvZxE4adv5X2cWSvoMgVcKlNcVIZRBWmdoSPLqgQ9UzN3S2fgoyQ>
    <xme:qEyvZ2VBzqlXQpPTWA0KakX3ipS1EA57-8yfrmTZ1X7Bjc028RAAt41_hDwkmjIxT
    Sp-dH7GsIEyeXY-ew>
X-ME-Received: <xmr:qEyvZzLuDnLkVMPk_zuzsXwJZNftoVcIuYwLM57a2Xc0chH1xi454dEci6iDVZYmwEKrnWlPzwzpJHCUNdkV_3I8l_ci2ytXtaXM5II>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdr
    mhhithdrvgguuhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qEyvZ3HDVzFwaG03r85mY-7lQ7gJ5B_iYddDtRDMMvkZ-fW1O1pTSA>
    <xmx:qEyvZ3WBZUJYMHZt2N2wycW3qwhkRxCeIbqDP8s7r_bNN40iUD7O5A>
    <xmx:qEyvZyPZScbRbEfX9jDHeRH1xjjqJ3fRbiXFnWZYbCsQNrolldf42Q>
    <xmx:qEyvZ213aL8jqQhvRn4yQ8vBd-g5R_Qsxouiusnos12NTvLABn3DtA>
    <xmx:qEyvZ5LDSPuNwfKdgVxsqf2049T6Sn0oHxk8l8_nZkQ8UtXrgjSFfRw0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 09:01:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 4/8] packed-backend: add "packed-refs" header
 consistency check
In-Reply-To: <Z67MG8utrQfUrakz@ArchLinux> (shejialuo@gmail.com's message of
	"Fri, 14 Feb 2025 12:52:43 +0800")
References: <Z67LkxAFIAeaYr0U@ArchLinux> <Z67MG8utrQfUrakz@ArchLinux>
Date: Fri, 14 Feb 2025 06:01:10 -0800
Message-ID: <xmqq4j0wmxqx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> In "packed-backend.c::create_snapshot", if there is a header (the line
> which starts with '#'), we will check whether the line starts with "#
> pack-refs with:". Before we port this check into "packed_fsck", let's
> fix "create_snapshot" to check the prefix "# packed-ref with: " instead
> of "# packed-ref with:" due to that we will always write a single
> trailing space after the colon.

A more important reason to be more strict is not "we will always
write", but "we HAVE ALWAYS written", I think.

> However, we need to consider other situations and discuss whether we
> need to add checks.
>
> 1. If the header does not exist, we should not report an error to the
>    user. This is because in older Git version, we never write header in
>    the "packed-refs" file. Also, we do allow no header in "packed-refs"
>    in runtime.

Yes.

> 2. If the header content does not start with "# packed-ref with: ", we
>    should report an error just like what "create_snapshot" does. So,
>    create a new fsck message "badPackedRefHeader(ERROR)" for this.

OK.

> 3. If the header content is not the same as the constant string
>    "PACKED_REFS_HEADER". This is expected because we make it extensible
>    intentionally. So, there is no need to report.

Nor there is any need to check for literal equality with the
constant string.  We may want to split the traits that are recorded
on the "with:" line and see if there are ones that we do not
recognise if only for curiosity, but because create_snapshot(), which
is the only run-time consumer of this information, only uses the
ones it recognises while ignoring everything else, presence of an
unknown trait is not an error- or even warning-worthy event.  Unless
we are curious and want to emit "info" level message, there is not
much point in checking the remainder of the header.
