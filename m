Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CF83B1B3
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782712221; cv=none; b=SEdCVjY+QPcJr0fufJ3Ft+7Jg1LCwnBO60dJ2pMOqSL2iZJne6wB+pPvjfMfuVHoWzZt3358NqS5eHlzLWiZyOjMqgvOMN+/iftgx/7hEsxN7VwozxnnXmUfcdiW+OdazZoTIl/HvrugH6KgLkSmbGeo7MKESevGeDVnoU8V/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782712221; c=relaxed/simple;
	bh=svff47lNAk2PfG4aF/w07p4YUerbIS0xztm6fRb2Uec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N9zHfsFw8Qu/lhZ6DHHF3HseFReyFnj4SnZvG6vXlr/xl5fgYVkKEZ8leLJeGRynav2dixtiRDyT7ODmrPGWo6v66hEPfm8/IcQfhC83zXhumVd/o5uD1o7LqbDLQOt6UukhkRHJmCdSOkKkLX6kmHlFvlJXl4GYGc+/4/DSx8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B76vT+fq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KMlNTcUL; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B76vT+fq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KMlNTcUL"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 35C5E1D00071;
	Mon, 29 Jun 2026 01:50:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 29 Jun 2026 01:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782712219; x=1782798619; bh=svff47lNAk
	2PfG4aF/w07p4YUerbIS0xztm6fRb2Uec=; b=B76vT+fqTfOmNDzz/GmkxjZqAS
	bJzJ9cwEXNzIlWMww2xPn9k5wzMW0Usaa1/CC+8mQChm9wlrHHe9dq3PEPsb86IW
	kemuKuUFtgz6ilPG1RfAIAsb1SOP65C8hjsV5tsUKCAoDHkK//X9HEKcdh8UrMs6
	vsZ47YvoiLm9e93tVGMa/h+JMmb5WNRSxtQdEAQpuTp5DPWNUCff7Aw8TecxaSkO
	lp5da9uyjYFKUBeC1wdbQXuqAQH9ga4JLECnGQOpodmSaZQ1BF2yU4BX8+5Pc5gy
	+aYAQbQLrqAQy0DsTRFLMzXy8XCY7TOifem9ipAaYj9hnbWaoM4ZWSLVl6fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782712219; x=1782798619; bh=svff47lNAk2PfG4aF/w07p4YUerbIS0xztm
	6fRb2Uec=; b=KMlNTcULXAOdFK6XsxqePev9oMztZnJxpGvT9zXimA+/a5/KWT8
	5Cr9ZB5fL+AyWBI6nEe4E+Ju0M/AVx/Ywwbr73C+s2JB6u//nyZ44PV/gPE50jNY
	tyfSEa9upMIGFgtzC2AkD/61Uk2UiUgvTuYQ8zFS2CAB8y35GEIwpH9Or2gOPQ0p
	8SXoR3/A8LyE5AX++8c6Gfi0Kclgkocpb6hXjLdGoXceQwUXAQSotrQu+jwEZ119
	fwrNODM40YzcR//Dh1pA3v7ByMVMHAmRM2fhUcFoL9BQ2LgMZO3+ThX2tceLN1Tc
	j67V4PZvkCM6s6QreDL1ozHfYhM67TniQhQ==
X-ME-Sender: <xms:mgdCah6turvl5laBpy2dfJY2js5MdmKrr9mNb1MQoqjG8d9yxfhQ7w>
    <xme:mgdCal5q26R-SOPAi09I1Aj7zzqHd17O7E9F1fh_vcchcFkcXzATTzWmUs6cpY6vP
    iTg1IvV71Ud5_OSRY1GwSWpiYW6ThEBc8XCLov-VvtsDJhk6Z2P-b8>
X-ME-Received: <xmr:mgdCatfLjlP7VyRfssLvvUDxHMM1mSXtHpI39XzwCq30yT8XeBafRsqXMxPs1mWUIPIgSHfqZX2wTtjvUoM9o7jadGPbJzbCXKGcFHc>
X-ME-Proxy-Cause: dmFkZTGRh+boFSZg958yhIKDd2uriENGTA0U7ESH1ikGVMyRyprjAIkqQH0kPRm+5bYp+G
    XCDKmrUCkoB2s0L+IJqOgWk61yqd7YAqEPvUd8nXPDmyzWghQMhky5r3kUXH5InJ+FP4qA
    i10Y/yf3nOJOkuSumi9zZ9YJX2PIGm0sup1RZvc5n/8Yx4j4yuvdG7/ULSeNLFVjvKbQFb
    kIm6ULqcc8AF4aRzug5Vk0Qf/je9OZOpwyqWPPTPeoGfznbeZRQF6JofjgI+AodU/HZQgH
    /lbh8IrJJLhOcmYN5b9z8iDv08WFKM5YmSC0aEudBllVJgg46I8JnkHQTRHsuamBzbHZiB
    kJpEK+vZPxUHLVBR3ylcIla9clX7tGzR/MwYGb9Z9pfKIB8BldKjiL5Dlf8CVvcBV3GmQM
    9hfMhkOg7f4A9E74JPW/eE6+XC/slR64L47xgF/yWd20FtFlIEfzOyyfIgme5J+DolAqlp
    euhVCCijJ7JEpikGPieLLTrXksSjuumdlW/TnqTTnNQa+n4/rAnJTNWYFKeVpxFfFuy0eE
    PSL7Aqe3o/AeKrPbw2z3+WbcOhqyjak7R1EnFlaCVtHaVHJHNoQI8CUxff0FjCcW9U/JRK
    LZG+6ms1a6bgDkNtvLxRZBrG9io5T3o9wDeQG+Q22awsjqBXuRvOCRBxSVtQ
X-ME-Proxy: <xmx:mgdCapACRBSJ8fzswbeXnbtEIz-dQ7DWF6BoV4eiAZ2mowSQTfsFzw>
    <xmx:mgdCag-tQ6VxjyCQ42AR_KWgeP7rP0dyaIRHexTFYPn4Zc_5mPqmTw>
    <xmx:mgdCakJ3tgVch3vaHDrRwHq2AYNsfbr3vtidFvI2pY4UeeBdDD434g>
    <xmx:mgdCapgmmRIQdeUkTT1TzuP2vgLVpJGe7CmBvzINMZO6nRuF-e7N8w>
    <xmx:mwdCas-E_6c6e_USH4E-rBvzG1iSqu_xTjJ-8zy8dHgtiOjg4llaKMqA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 01:50:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v6 4/4] history: re-edit a squash with every message
In-Reply-To: <4edf012b77fd2f2fb2a51eb10863bbf852fffa40.1782635349.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Sun, 28 Jun 2026
	08:29:09 +0000")
References: <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
	<pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
	<4edf012b77fd2f2fb2a51eb10863bbf852fffa40.1782635349.git.gitgitgadget@gmail.com>
Date: Sun, 28 Jun 2026 22:50:16 -0700
Message-ID: <xmqqwlvhzyhz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> By default "git history squash" reuses the oldest commit's message.
> When --reedit-message is given it only reopened that one message, so the
> messages of the folded-in commits were lost.
>
> Gather the messages of every commit in the range, oldest first, and use
> them as the editor template when re-editing, mirroring how "git rebase
> -i" presents a squash.

I doubt it would make practical difference, but one thing I notice
is that unlike "git rebase -i", this one does not intersperse
markers like "# This is the 1st commit message" in between the
messages taken from the squashed commits, so it is not exactly
"mirroring".
