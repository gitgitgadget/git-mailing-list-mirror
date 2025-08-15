Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EBF13635E
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755301066; cv=none; b=CAUMHjyLtPvCveS8Tw0o7dBwPU00jaFr32cW1gWxW8Dcp1L/2PmHX8gDezijDUZh7xfsqLrRayZtUwlg95yI3S0vw229E2p1UNr+eP1nt9PUT30hkOfPjLAspUIuYk3C6XwFW5Veu8Jv4wJaM5592VwgSN7dT5wKiwr87tvijWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755301066; c=relaxed/simple;
	bh=w7i+XD2aR3R+HH6MVgwBMd4zIrqMoxt4Vi0XuKVDiFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IrLVVmcl95Kqb9inVMtIiMGInmzagTzxbz/mzOXXi+nk1GPcqmMh0MfHY1MNbdm2o+Tt5G1F36UbnHkZpklxoA1F0TOadBgu+UjLCcU4nkwH04aEiBHHWFvbtnSjjqw1xEaKrdZIs/MOBnDbjq9BAwiP29pW5rKhOV/JPTLlHwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RDIx54Hw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YdVIFOSi; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RDIx54Hw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YdVIFOSi"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B7271400078;
	Fri, 15 Aug 2025 19:37:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 15 Aug 2025 19:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755301062; x=1755387462; bh=Qt7Gtyh67R
	jrAmKprI75USI84DE3SsjwK5L12UwouXM=; b=RDIx54Hw2Sx+zVI3X0aZI6XMib
	MAZQ8GjvPEHT4Y2yPCPfwZOzBGfTUlRIOwO7CVsVIMj/ztTPz6Z2bRJrWRQlr8J0
	sHX+9arJGmythfVmRmnChvnJNSQLKR3Z+i00X2XrQNhlBU7oyIkO3EppdGRMjduH
	9htEJ6HOM1ev/ClOVjNAIy3XcG5CMSAd7J4xjrp2tQ0AinhtNimRO06lyimth04d
	IQ8Yq6BwqRwGSNYsS/JANccpcrT/TSJXDiSIZ8RzJ07nuEefVZ101t6Cr4OJFq44
	E9m4+JGnX5C0+L7m2DVY93X5QuuWaHakRjl10zmKwV/z8zhWauXD+0+brtDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755301062; x=1755387462; bh=Qt7Gtyh67RjrAmKprI75USI84DE3SsjwK5L
	12UwouXM=; b=YdVIFOSidUUbKQa9pOmpc5j9oUcAqB0zJ3niulULM1dBixgG4S4
	W0Nw6MyTGtKoeZQXzuD0J5n9McAA8DHvnhPMZ9kFIxUHsGwLu7CAGAzrIQ/8gAqQ
	iZMGRstKc3pBserWP3x1pCtMblrUqzLrb9nVB1UAtiutsfwYGGzewZK09V9sBDyE
	RlWUrImau98+QtdL30HMe2BDX2Ke+cG94HaqlGaW2OUy0/8MVJD+/Ch55d88lyKt
	dc/OjIXzaqVKGTn8Z1zVHiaObqyK4ZVDH741WZRgpsXhcwSzruUsEiiAmFQ4ynXP
	wBSmqs0vKq8PZiivMPe0i/jPMQgiPziqx4w==
X-ME-Sender: <xms:xcSfaHmMHAJDN3lKQn0y6I6ULcbulPabRTLXW6AnHYq38Q18evRaGw>
    <xme:xcSfaAWlh0QW8twuvWYLIIIiF07up0omx1i-CNtyc6baX4AH-cxLZoeevX7SrLJTn
    y-pucoSy2QlwUlJ0Q>
X-ME-Received: <xmr:xcSfaF9YuuQboytN1RPQtUPa1JBJxYkuALo7C7z591-aM02ouMmdOXTLFTNqhi8mI7WiFqHWobtfL4qj0guiUu4nK9sKXAypplly5zE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmhhgrudelleefsehlihhvvgdruggvpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htoheptggssedvheeisghithdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnh
    htohhordhorhhg
X-ME-Proxy: <xmx:xcSfaNq5B0RF4H9U8oMbG8d1sZFHKpEC1w_TQpP6mWsWY6d6Tuv-cw>
    <xmx:xcSfaHm0Mk2Xs7oM2K6dOtGa-aDRJ4sjnJRxH6yLd48ulmac2JI7Mg>
    <xmx:xcSfaBaX7c_intADH2B8jgZ7NzyyiML0pxNNujjZZkBfJ2PXLM6eNw>
    <xmx:xcSfaPV1Em9zb__QypLOEWuQ-JJjre_Dkv8wn_iMXhCObjWSn1XmCQ>
    <xmx:xsSfaGVDCSkvxInV_fqC3sfxRikHBuHo6l2Z8el2dQ4AVx2t7gw6IAoi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 19:37:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Taylor Blau <me@ttaylorr.com>,
  Christian Brabandt <cb@256bit.org>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,
  "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,  Sam James
 <sam@gentoo.org>,  Collin Funk <collin.funk1@gmail.com>,  Mike Hommey
 <mh@glandium.org>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 09/17] Do support Windows again after requiring Rust
In-Reply-To: <xmqq349sntms.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	15 Aug 2025 14:48:43 -0700")
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<96041a10d545e0e431d05b93544771c6bdfc06f1.1755220973.git.gitgitgadget@gmail.com>
	<DB9P250MB0692900F30A3E71E4F01DFFFA534A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
	<xmqq349sntms.fsf@gitster.g>
Date: Fri, 15 Aug 2025 16:37:39 -0700
Message-ID: <xmqq349sma0s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I do not think we spell out which releases of various platforms are
> still supported by us (we do list requirements for platforms in the
> Platform Support Policy document, though), but in general we should
> not be attempting to give extended support to systems that the
> vendor no longer supports.
> ... so as
> long as we document our intention of dropping a commercial system
> that is no longer supported by its vender clearly, I do not mind the
> above that discards 8.1 [*].

Apologies to authors of the PSP document.  We do have this as part
of "minimum requirement":

 * Has active security support (taking security releases of dependencies, etc)

So, being implicit about dropping 8.1, while it may be less than
nice as we could, is perhaps fine.

If we wanted to support a tad older releases that are still used
widely, that is fine as well.  I didn't check what additional
documents and policies GfW (Git for Windows) project says about this
issue, so perhaps it is all documented there, in which case our PSP
document is fine as-is, too.  In other words, if GfW project takes
responsibility of supporting ports for an older release that is out
of support, what our PSP document says does not matter.

