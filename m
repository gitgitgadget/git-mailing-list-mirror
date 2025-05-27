Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A990327FB02
	for <git@vger.kernel.org>; Tue, 27 May 2025 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366398; cv=none; b=S5Wqe1ffEDXspfaMCKazgRYsAAw6P1D/dR7OiFeDPau2DC9uCCGvEUYlNLBZbLZ//T5Ik5RtXzo/qrOrcIBhUbO7Vr3OD+dOpDWVRgVPVRpsI4JOP3hOfy2mcBd8XoGXr185AxGdWsAhHUaaAjoDPMKVnM4zd7plpcyXGGmvj7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366398; c=relaxed/simple;
	bh=fYYY1CZ//ZEDDmvGprBs7HVvGw1su+1/gZO5L54JdsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eW+QLwVN7qpMPoW15u+iVrsfwo/LxdH6d6IAMyuIbXocPxfLIsf0UI4Q5bsehIbSHQ48W8dXNLAtj2J17FFmHCFxQAqa4P4R3ax1qN/uGeJN4lZTkcLUHS7SRxQBuArZHIz5Rcc6Uu9Ps6qGuAvet5DHCsmuhIEMLRm0+uC3hTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xScMeM6g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ergFDGit; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xScMeM6g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ergFDGit"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 90C411140072;
	Tue, 27 May 2025 13:19:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 27 May 2025 13:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748366395; x=1748452795; bh=hkRxiIvAts
	EOBvui89myJN1tOK6Zn/3tSoliS8thZeM=; b=xScMeM6gAIVQdvpSEY+vs4E7n0
	gb0BF0q/l/WkUkrCwdcacWPue9GGlFYkb8ce9yInN7lJ7YW7pchw3XkjqDY01umN
	Ev2mRRVkOtIUQOdfv1pnpAMUqPRL1w+Lt+ITPTz2vP0txS9fXQ9Yauz7v84XgvT5
	w1iKOFsoAK8RntzeCd0VlxgO12L5cmc2xtyI11DHNH3lZXIRYprWVm/AzqR/8TTQ
	Wpj5juumao+KmRNJha1Un4vYTrzCGBqixaSS5ip2wc1SiZhmup6mC1KkZLE6bfax
	HKXXQG4CUQQq9aHjFSp541hM2sfIYUNCdgYY0ucBxmslJoSZgNfBj5nYAqyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748366395; x=1748452795; bh=hkRxiIvAtsEOBvui89myJN1tOK6Zn/3tSol
	iS8thZeM=; b=ergFDGitRDyJG7x06inR7c0MfQZ7FC2UXu9bw3cDBwcVj8CGg/Z
	q1SNd/Brt1gYH+/MLPtjGb37gWurJR7f5cG98/kC08w2DelPj0YEHCJqLFxVT/hz
	lkTJ3BgbHSGfR4V2ZWTmmNy2t35RIIraFd12AtU52ypxKlVNVRu1zc16/CE9nTAK
	suAFCU6d/YJvGv5E4SRMDH8CNnKZh4cMD79LCwSiC+sAa+3NKzpHz5Z3fz2lKF46
	iQPIZ30fqAeHOPI/UYe0lIkRBblh2DoFAzOHMCk667MLzzz+x11S2BIbLlyvza52
	GPvd8k5itt9zJcFNcRYBILuWK7TgZs1q+3g==
X-ME-Sender: <xms:OvQ1aFqgPppQ6t8InfztSNRIFFPv1n3NSyRBHQuics7mtEdOma6ZSQ>
    <xme:OvQ1aHo-qRe8UwW5QboupN_WZb36_QPxo4waA4DcHGnQLEeiogReztrqv1-SMOTKM
    o22SMYkuFMfVb5zDQ>
X-ME-Received: <xmr:OvQ1aCOOCX0uTTKnA0xiyc4nJ_npRi9tR1Gfp5JdJflNEG4qHqeH6BgQivdzVTNE4-MtEdLvqqXcf31iq951PZiGC4ZLP-CLhnr-Gts>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdelieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehmrghrkhestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OvQ1aA5j7Hm-NGJlNB8lp6HGZoCSNBvXTrXteak7gwgr2bWXzHpUug>
    <xmx:OvQ1aE6F0PtKyU4Tl8c1u6KN1kR5d-z2gsvapRdANFuJGAdTwcMGpw>
    <xmx:OvQ1aIhyW5iMlUtW3iaCJrktz-qjDtlMTjR2fbeHpx993oxchVlFMg>
    <xmx:OvQ1aG6F0_9WNVSmJMX6mgxqKs4VsAC3BEbWqx-aEdJzoKD_Jwi2MA>
    <xmx:O_Q1aOso1yjqrUJO7ppAEVL1aFsaXLWnfxljCty9IVHjGsMwgrukXDOk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 13:19:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mark Mentovai <mark@chromium.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Git Development
 <git@vger.kernel.org>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] t7900: use pwd -P in macOS maintenance test
In-Reply-To: <9e9ed1ce-76dc-536d-56a6-e85e1dfe58c6@chromium.org> (Mark
	Mentovai's message of "Sat, 24 May 2025 00:39:20 -0400 (EDT)")
References: <20250523193722.68344-1-mark@chromium.org>
	<CAPig+cRpS=t-wNLxdV_WoKF0Wzy-S1oLUEyS18S9r-4OBQ87VQ@mail.gmail.com>
	<xmqqsekvvz1t.fsf@gitster.g>
	<CAPig+cQLG+zveZg73E=TiC5uShhhRXKmK5Z_M8zN3fpGNEN1ng@mail.gmail.com>
	<xmqq7c27vvv3.fsf@gitster.g>
	<9e9ed1ce-76dc-536d-56a6-e85e1dfe58c6@chromium.org>
Date: Tue, 27 May 2025 10:19:53 -0700
Message-ID: <xmqqy0uiug1y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Mentovai <mark@chromium.org> writes:

> Forcing the entire test suite to run from a realpath-canonicalized
> path seems like a blunt instrument, though.

I view it differently.

It is a very effective way to make sure that the tests work for one
person does not mysteriously break for another, only due to where
they kept the git repository and where in their filesystem they
arranged the tests to run.  That is not the kind of breakage we want
our developers to be scratching their heads about.

The part of the test-lib I showed already was trying to make sure
that our idea of $PWD matches the physical world.  It did so only
for PWD, by doing 'cd -P "$TRASH_DIRECTORY"' early in the test setup
sequence, but it did so after setting HOME, leaving it inconsistent
between physical and logical world.

Which is the bug that my suggested fix addresses.

Besides the problem we saw in this discussion thread is *not* a bug
in Git and its normalization of its working directory, is it?  It
was a bug in the test script that assumed that $HOME already was
normalized, right?

If we want to make sure Git (not its tests, but Git itself) works
when (pwd) and (pwd -P) are different, we should have a dedicated
test to arrange that for everybody, regardless of where the tester
checks out their git repository.  We can only do so on symlink
capable filesystems, but we do have enough support in the test
framework to do so if you want to write such a test.
