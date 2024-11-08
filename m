Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908D31BD9D1
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067020; cv=none; b=GSPoEMXAzaVOW+4XIcDgdoxXU4DLRXW730mYHRfXcN8ScA99oz1QqlOPlX3kYqcziz7/G2ZivmadNkwP7feb/VvVXzDDe0EPDd/9HhLXNXDhMa/ZHY/fIRRBeiXacWOu4dZL6G+wggFqoF5A7NZ659kIa1tOnprK6JIbi8Hcl0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067020; c=relaxed/simple;
	bh=PRLlVWzuwQ5+pugJ6W/uXPgyLj64C9NXU03ipeMjjy4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DqTYqsbFTdOrToCKlU0UJFz0rQEw6fXvU/d73SQu4zeFVsbxCdKKMXV0NGspZaaWNAIQcOmoyvsepyK6mDvsL8gYKp4Ru2G2SSqFW5Uk/9YSLSPkwvuMd9lMPBPLamOJxWkEKgg6HeqGrMNUIGszVH6UvlypNLCXazyfOK3uJCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gs52GGql; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JnlD4fHD; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gs52GGql";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JnlD4fHD"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E047138012D;
	Fri,  8 Nov 2024 06:56:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 08 Nov 2024 06:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731067016; x=1731153416; bh=/RzIsoZoXE
	oTk9FpF0UgKDH8+l2/xzycDM4nM3KPmzE=; b=gs52GGqlhDpU7zQYs9HvLfqsrb
	c5b2ydec+0DRoOahLF81FTVSfkhTlgY4/tIam6LWMZif46gjSqJ/KnuQjFHey/iw
	9HsIDU0FIo5IBTorPkn8FwE7Y34Ti9psLVzzidgWPoj32sj5CHHbkjrtRKCLXU8H
	PUJFTpaeVm9Kxlq11XOWKphfPjuTFliBASbQwmAxUJNEjYQ+SCbK3cYc3qy5BPy3
	eexWbss3X3Hi3Oi4Ii7bFlSTzOmu2qSgrfLICD44WcMyzefFrE4wNQJEaMscHdte
	t4uVPP5E7r+tSIZcFJ+msiHdySbHgpS7ecJB9n1PpAPik3VTGfNTKxmUIQ/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731067016; x=1731153416; bh=/RzIsoZoXEoTk9FpF0UgKDH8+l2/xzycDM4
	nM3KPmzE=; b=JnlD4fHDYd8NL2CcVk5XW+g59ixcbpn3SatEBpoMu9iD2uvEB5X
	LJleSvMFQ+j2uyKQ4e3RzuELYBMWjCdaMeHsUpa0mLX5xjZi2gTwy+xWp+HichJ8
	VzSDye94tqjY1cJTD4pBio+f6cS1pbGwDhhUG562cNl38LuRyUE8CGqsjw/m8a/s
	lgZqBzOhvftF9pOpdXzZQDU5DDkbhQld6iX5+usN0STxvbMhsz71OZ/mfQJg8sEe
	fcuIrhKg/U3QAPZwCfBULY/Wvhwiowg9K0zCe4kWxQu7I+JVnF6SwfkPfUvjk3bH
	S6QZ0Kao8/quct0NZ5quR5t+GjLpyHKEsqw==
X-ME-Sender: <xms:iPwtZ90ZmMXnoJZtVmQETEkfawMBkk9nqnAZGCiVZ4hSRt89vKtquQ>
    <xme:iPwtZ0GtsY4TGhl3ejgdErKdyOrvaJmo_zY9tuChPVZdZHLG3ckwvYCSpiDbBa4Ru
    NywV8mFPhjGU0cXXA>
X-ME-Received: <xmr:iPwtZ96Cm3DASVApNOBdEWGflImnbBN_5V5M6iVZal0yPYICrAwTFm1fT1pLILhPuJnrVISWouB-s5jU6LGvhNYETKrxgiTZAmzH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdroh
    hrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdgu
    vgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhgvvhhrrghiphhhihhlihhpphgvsghlrghinhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iPwtZ62YVRdPRO2Ey3-2uxmtfDaVrQLvGqPH5LoSmvYGoJ42O2lILA>
    <xmx:iPwtZwE0Xdh3_NDh2h60lAmVIGXV4a7zNUpcU3xxrU4Y2xtwAie34Q>
    <xmx:iPwtZ7-mOix2I5h-u9ctgVOPomWizUIpRfilbYtJRrUQI6zugXKifw>
    <xmx:iPwtZ9kqelPsFuhTPhRrh0yf82j31MYd18d0ky-_qZrhUgIq8cvYjA>
    <xmx:iPwtZ16wY58IrlxY_auzLuEoDajby9ROaFjx5N0_GmS49OulHHhg7ejx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 06:56:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,  git@vger.kernel.org,
  Philippe Blain <levraiphilippeblain@gmail.com>,  Johannes Schindelin via
 GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] range-diff: optionally include merge commits' diffs in
 the analysis
In-Reply-To: <abc2453b-f7df-4601-8834-595881f9ceca@kdbg.org> (Johannes Sixt's
	message of "Fri, 8 Nov 2024 07:53:46 +0100")
References: <pull.1734.git.1731000007391.gitgitgadget@gmail.com>
	<abc2453b-f7df-4601-8834-595881f9ceca@kdbg.org>
Date: Fri, 08 Nov 2024 20:56:54 +0900
Message-ID: <xmqq5xoyndkp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 07.11.24 um 18:20 schrieb Johannes Schindelin via GitGitGadget:
>> +--diff-merges=<format>::
>> +	Instead of ignoring merge commits, generate diffs for them using the
>> +	corresponding `--diff-merges=<format>` option of linkgit:git-log[1],
>> +	and include them in the comparison.
>> ++
>> +Note: Some of the formats supported by linkgit:git-log[1] make less sense in
>> +the context of the `range-diff` command than other formats, so choose wisely!
>
> Can we please be a bit more specific which options are usable or which
> are not usable? Perhaps you even mean to say that 'first-parent' is the
> only one that makes sense? At a minimum, we should mention that it is
> the one that makes most sense (if that is the case).

Good suggestion.

I am curious to see how well things like "--cc" and "--remerge-diff"
fare in this use case.  I suspect that in a case where the original
round forgot to make necessary semantic conflict resolutions (aka
"evil merge") that the new round has, all of them (including the
"--first-parent") would essentially show the same change, but what
is shown in such a case would be more readable with "--first-parent"
by treating a merge as if it were just a single parent commit making
a lot of changes, iow, merely one among other commits with equal
footing.
