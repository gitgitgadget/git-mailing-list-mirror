Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870D824B26
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 03:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730865285; cv=none; b=F27UkZe1ejSjsEqSDMH9OGKbMG8VkB54TfcaU0wWnq8/BasO9PAXpunOcYvgA3qnXRGKcmU/VM9yJ+Db2+vUk7qkwe4bUVIEPtvfVLu+YcmB2No9RoyJ/mIH90Aw4/I0j2OfZ0U304zgG8BJCsMsVyu1E3uiZ4N41tOmB1JI/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730865285; c=relaxed/simple;
	bh=pupIrVodEdWGi3V0o9YzqhY7SGIBvcC2arS8bkSxAoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZlSFp8+25NcsZ5Ciog03M6x6iQ3P9SA1gFjSA6MJbrt2ANeKv8LtfXI6ttP3747kpWDym6ByZGOcppTY5qTVghWb5aBdy4KNJwkQ5+9T70jGhs1j9vGjHsI91KAg9Hb4lumRCRpgMr7Y0olGA8cK5PHJitNh6UMOLwQHCcLWyvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M7cXuawL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XO+RpRC8; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M7cXuawL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XO+RpRC8"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8B1B3254014F;
	Tue,  5 Nov 2024 22:54:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 05 Nov 2024 22:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730865282; x=1730951682; bh=PmGNTmQ70R
	WOXw2g625qAvtrf0UKLVVhNEyyOkteyX0=; b=M7cXuawLIaMXekV5QqRC5oMDkC
	TM6bebzWF2nyuyCHFs0P1UMQ1ryLL+JnEWwj2uIhHz1gLyYbDpCG3f+P8231O+M7
	bpvfxsMH0LYmreQvg+OIGUdNEbdVSOFdjBxZ/0QrHmZsC1AZ6DNuXK94ZFP6yAMx
	0XrlJdhBtlLN1EALY3ocqA6MrJhVrHuxgdMCt1vKMTyH7wMubiQpDGwlOvXDjB2Y
	PVVB6pZNZpXkPiRHquug13n+BuXmU88w0lDCDi0SaLGirBrccaOECTieSCOaX6m1
	hySCHSehPKQU1uHxEBnR7i1nj5DPg5z2eleoOx43ufYnsVN0mWahDjagFcvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730865282; x=1730951682; bh=PmGNTmQ70RWOXw2g625qAvtrf0UKLVVhNEy
	yOkteyX0=; b=XO+RpRC81me/Dio2LxN/sJHWqwsSyqo0DRq9NhdT2umFpCgTnIZ
	5KMG2Wi31ixvfCnPKxwqwG/gnx/VtkIyVY/t/cMlfwBOagudJpC3ZwAP4NeX7hki
	ymN4VdbilSBNTGtPi3zvg1LvmaJyGEZp1ukLNJRyYDzqrbG2rK8fRK8GG+SuhY0E
	MySqQEY/3Wges5gkAhMGZm2J0IyVYdv6aD5xknzMdC+vdOHpe93uuFBGIpfYe6Cu
	9ubaSW5eFjwkI1zITCTL403A2OiTNZRJSc8/3HRA1W0Xdzfeoi/vFA8Xm7W1EmmP
	iScdZAx+bnp0jO+OMWeyCLB9/rpiKQXK+EA==
X-ME-Sender: <xms:gugqZ6nSd1ydfNAKW0ffbG9hu2YslKnrubWNK3boB8EZYSctcTxAxg>
    <xme:gugqZx2kChBaMCbR36JTAAItY9sY1YoAH_J1zSYp3ewTxYZlTDFQhfn9tyLAKtwUJ
    9ni_C2V7_42vadwpA>
X-ME-Received: <xmr:gugqZ4pGFszuTH0rnTZN-xYTyCvxj1ksNc7Dq9_H_Tf0zN_tX7cX67mz1wXkdmDrqGypvaxK3EAzOY5ayFEmg-JLUgOPdhdoVOUE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gugqZ-lw9-CRJE3KwM5Gz86mzlV7FOzVniyGJ2pbYqkEneKpwthlSQ>
    <xmx:gugqZ40t3HnFZzRkmhwuVW6BwdZ6KZXhTya3hZKkrr3uSHg4DJaP_Q>
    <xmx:gugqZ1uvjngQ8_idAgBRX8RDH0p8ZyPqfTj3nWDJAkQtsuA8GHTLmg>
    <xmx:gugqZ0X9zYq5A6r7kTPc8y06PbscnSZPuZmHwikveYj1kfPr_zYPhg>
    <xmx:gugqZ5lviVdGj9_5ym0Fltca-cKyaigz6vEcrvZnwNjiym13s4QMEL1A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 22:54:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>,
  Taylor Blau <me@ttaylorr.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 0/3] compat/mingw: implement POSIX-style atomic renames
In-Reply-To: <cover.1730042775.git.ps@pks.im> (Patrick Steinhardt's message of
	"Sun, 27 Oct 2024 16:39:32 +0100")
References: <cover.1729695349.git.ps@pks.im> <cover.1730042775.git.ps@pks.im>
Date: Tue, 05 Nov 2024 19:54:40 -0800
Message-ID: <xmqqwmhhow3j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is third version of my patch series that introduces POSIX-style
> atomic renames on Windows to fix concurrent writes with the reftable
> backend.
>
> Changes compared to v2:
>
>   - Use `DWORD` instead of `int` to store the `access` flags.
>
>   - Fix handling of `oflags`.
>
>   - Add a comment referring to `mingw_open_append()` for why convert
>     `ERROR_INVALID_PARAMETER` to `ERROR_PATH_NOT_FOUND`.
>
> Thanks!
>
> Patrick

Thanks, Patrick, for listing those who gave reviews on the previous
iterations of these patches.

Reviewers, how does this round look to you?  Is this a version you
folks are comfortable to have in 'next' and later in 'master'?

Thanks.
