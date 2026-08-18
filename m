Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD453812FB
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064486; cv=none; b=uzNa7ocwrpDc0ZOtoEhGZllGvM2eJVqP7Gz1jUm348ZTksMcMg2kmzM+cN7F6dzRInBiFbq30fwRyWWE7OMuofao5uMdgnyXyxJN68zDj9kVTh02hiYXhmklxa69TanWydO+RRaTB0h6cYVz9tVYxAWrfgXhS3hpEe/d8GIHMZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064486; c=relaxed/simple;
	bh=fZFI5p6s5nN+tXiryrQf4yBXpwoveyx8QMXM4TbibEQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i4DYFJb3tP7SVX6R1cMK6Urm4WpZAf8/nENR5kWOQAvRgcCTOFCabQmF8yCgUxXOY0O8DBbbRwZXnsUoNPBM1B0hx7aqvJi3mnAiE/01F0svtaxPFP4KkbjM3SXij+StP9Ze+H5CF8w5PXzUlLBdrGXejc8T8Uop6deMa6Bfxn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=im8sNHxB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EUb8x9vA; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="im8sNHxB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EUb8x9vA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2A6577A00CF;
	Tue, 18 Aug 2026 10:48:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 18 Aug 2026 10:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787064483; x=1787150883; bh=Q8ETKKD55K
	1cOQqYASy7vTRIL+yR8cXncrw8VAV9S0M=; b=im8sNHxBGoT8hdvTaXaYtNhYZY
	4oZI5Taf1Upg+Z5swE4zstsMLF6kFGc25eqnjGDDwwM2sHyR9pehqRSSAt7/x/Nd
	TLBmLYcNOoWToW+D6+RhOGEcZkI5RZ3kn78EQzL/tKQ/wfK+pQtNOJ7lwkRuHOue
	mpY0I6OTGx9UF6IzCQWRsgwOHHpSP8wA98VA7owfQAGA371XB9xnn1pO4liFD0wz
	/1/83pjJoH6MuTBYIu8i2hQh+XohsWSeEIcc5xUS1SD9SEP+4e7BZ1QlMUou6LoU
	nT+x18kQ8eupgeexKhHBZ4kfE2sSKBkpDcvge0LLclRtff1vyJeo0USQTmNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787064483; x=1787150883; bh=Q8ETKKD55K1cOQqYASy7vTRIL+yR8cXncrw
	8VAV9S0M=; b=EUb8x9vAxWQwK/7jVqWF2dNvbyxjLqLCqG2LNDQCDLQwkKjWpPq
	LBm/bAa//LUkiNWqt7uHkisVnRpe/aNQwkGGbIAi7DuHMEFOYGkwd3EToeHPg6co
	+8LGWmZZhKdQj7Nk5ws2ArDqxCQ1q/NCRC7PJ2cZxmBLZ+uvQrrfou48e/krzSoN
	RLBFMmEmmb+U45K5LKhaWht31JpxJps/Ukop4j3wsaSwOnln09S030biX3vPESAU
	ihoBQiu7bB4sDi/GagFPUd7lG6UiLgs+AhZfxeLuPlrWZL7LiB1aMD7oLXrZB7yz
	S7gSpzuAZaAsi7XVz1JhYt6oyM/PR/JqlCw==
X-ME-Sender: <xms:onCEai9kjJISLpeoWunOHDEZ7bk7HrLvfjQ7RniPWGkpr1omCAsPLw>
    <xme:onCEauN0L0h7emhAuqyyib9YRyRtKuFZfDw3BAPCrLK0bzblM6xejlimxeTE_aCgD
    1AdlsNfNZsH3uv93b_qxKdkpgmLvTN7ly5fFWy5aVpZokmq_yLEXmI>
X-ME-Received: <xmr:onCEaufgHYCuDrjdFlMBduy9Y_dfmOKeGfE7x8wOLZ59GWwrow7TQ1bCzdix-8jRKWAQoRParLxlYhWzliaDxNtiU5CTMe-vbQ>
X-ME-Proxy-Cause: dmFkZTGrA+3bmzAMtmksxvHvB61OeXQY/r3orpWWDWc/np4Z83lBCNPF9rVGrNrW+nyiKM
    VO3kHCZVKATMwYrHQSwuIPp6ga5HtA1ZnHd9c44LbvjuFlTV9LTyBWE9lKoEDWYlcqf9QF
    diik5Z3mvWtuWnAHuVGqWtXdNv7okl4fq44IgJatzjF1cnM3JsmNiNu1s0Llr1dQ4NnxBA
    qXFFisDvzcW7y0tOp0lKaBU8+mW0RE6uqjxfabjBEXfApHIU1EoZFBFm/LBX0t1ttqXqCM
    PWXuhsYCj8ZcgWxbtqesgarmklrLeldfiu9aZS8pvF3UWZXiHV1KO/UcBIBMT5JneXGiN/
    q7VOLGEkQumvOnAbFWt5WHiS93k3/ZKpHAFTSO5UcXYVbtWcUETdOf2OSF1iGhHtpA4SFW
    Fi3iRUATi3Wwd2Z5pLKb5Os5vl97B+KyzmtDH7kuLzxdbo+PpKUJUIZ5HnfWmPsUYEi6DX
    kDF5Q55ZjbLvAGWGAFvxpvaHOzngWkWwuD4t9+hLRQyzaujzlFX76JaqAjUahgCOnQxHam
    gri5Ajh/uKfn/++NjpGEl2qZdmBT10EpOZzMJhy/KBNog/YP/gP3WZspvHa11XZs+Z4nLB
    +cmFx5edxD4qA+qUtOVTY8tXcV8xyPh3r0aXA9FSDki1M7ZNrBN3RYJw27Vg
X-ME-Proxy: <xmx:onCEalUJ0kCQ9Et859dDZN3UtHaSOJssKVYXWqXFQo42uNcgBGQPGg>
    <xmx:onCEauiwKKK_3gjFuAAtv5C5wpSakeP0rdgxaItKvB4kA_xKd1h9jg>
    <xmx:onCEas8KXTbwPvcv6qU6wq6KTOSdokS2lsVS3X8TuWyH9FVwlJg_2w>
    <xmx:onCEaobVmC0TopMRGwkN9u_Ehv1NPJMJFr5xaD1wiqI0m1xii_9eBg>
    <xmx:o3CEavSFk5aVwPQCO5ONvKi3UDtnTuZyb0it7cTOITj38RwZ0AOE2DoG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 10:48:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Artur Bieniek via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Artur Bieniek <abieniek@antmicro.com>,  Artur
 Bieniek <ar2rekb@gmail.com>
Subject: Re: [PATCH] pull: add --hard mode
In-Reply-To: <pull.2384.git.git.1787052873141.gitgitgadget@gmail.com> (Artur
	Bieniek via GitGitGadget's message of "Tue, 18 Aug 2026 11:34:33
	+0000")
References: <pull.2384.git.git.1787052873141.gitgitgadget@gmail.com>
Date: Tue, 18 Aug 2026 07:48:01 -0700
Message-ID: <xmqqwltn1o4e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Artur Bieniek via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Artur Bieniek <ar2rekb@gmail.com>
>
> Add --hard as an explicit alternative to merge and rebase. After
> fetching, require a single integration candidate and reset the current
> branch, index, and working tree to it.

There may be a population of users who *never* make changes to their
history or working tree, and always want to "hard reset to the
updated upstream".  Doing so would be safe for them because they
create nothing in their tree whose loss matters.

Giving them a convenient and safe way to do so might be worth
considering, but the behavior is already safely and explicitly
achieved by running 'git fetch' followed by 'git reset --hard @{u}',
so I am not sure whether it is worth adding another way to do so.

More importantly, throwing it into 'git pull' feels very wrong.

The core purpose of 'git pull' is history integration.  The command
is designed to help those who make their own changes and advance
history.  Adding a destructive option to the command makes it easier
for them to trigger it by accident, and unlike the main target of
this new feature, they have things in their tree that they cannot
afford to lose to accidents or mistakes.

So, I am mildly against adding anything of this sort to 'git pull'.
For that matter, I am generally against making it convenient to
discard or destroy history.  I prefer to keep these destructive
operations explicit, e.g., "fetch + reset --hard".

Thanks.
