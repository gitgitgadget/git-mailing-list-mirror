Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203184594A
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773328; cv=none; b=OFyDNC7J8oOE150/r2RljllA6+cE1rVjXR8iptB7MX89QX/yRwKioPe82AeDzPFHJavJKZk5BptlWGVxQITu/CvputgiteHKSITzcoVBb29RINkcrH7twoeEId7QWJUzkRhZCinCjb7F9tYQReEEVodLySr41pc2r2QBjPyrsnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773328; c=relaxed/simple;
	bh=9R3sjWUbWJngdxL25eugNBgwQj1oloH2pJsFpLPD/0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S7zeip+YvdmQw4NJMlmnS+Xct+eIP88Xi2kyQ7QyOOY1fGV4SLCyCUO0Erh8FSXu8G4L3S4oqYa3Oylwer6C/Qh5UPrM7ZNoqIyWL15zGOrKWfUh+ZuYHg2bop9L6wl0OeiYxISv3CsLPul/QToAWT94AaI7KdRryVmS7qjKKNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kJ4TtYc2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d/y3ayxO; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kJ4TtYc2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d/y3ayxO"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 17A4C7A0188;
	Thu, 17 Jul 2025 13:28:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 17 Jul 2025 13:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752773324; x=1752859724; bh=SUAB+zh9tQ
	gWR7G2MEzCsXl1HaPQnWcHKWf7bFoRbTE=; b=kJ4TtYc2GYJIw0IIa9eovq9qT/
	o+68J62QhL7FeVkHddueppsbMXx5tboDpGaTwGyDZb1/I8byB8m3DZkLu6g8bu0s
	5gPyCo/xTVq7vRWaS7Ce9MTDS1pw+/bJt/m5d7u+LlguYejFWf7HiW6OcwQeDw3i
	V9nWPaeehJXnnQbGe4/S0h5Uw2IN9j1KjP/hjwwfJbN4+H66tYgV20jT5rJloleu
	s9x0jJnZcSP72Dj3q94QSHpuk9WEmLph18dy0DMIWDAnohFNuM8ktJEwBrbd5lvM
	bsjBQQa3mnECBH011N8LssZTpfePZiG4k9anNuxnbmkzGiLdLRoBhE6vYvfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752773324; x=1752859724; bh=SUAB+zh9tQgWR7G2MEzCsXl1HaPQnWcHKWf
	7bFoRbTE=; b=d/y3ayxOIhx5ZRqTSaks+m4kWr4HFtxLr8TZrvnNAp9HH9FMMhx
	eA3CjnxlnXK/o/WvxX3vvfm3rFcTVmN4lPSkfwL3FKNHm3AVkV0bjaT7BGJbwePC
	TcxX34sb0jA7Iv7+L1UiQ81kRCtvIm5VTX4dIpzOTLtwuNCZYnp/VJpCeLGcQcwq
	Gg2lq5AoD2GcPh5aKF53nsRwjUxWl1YQC14dqTuh3l2n8Uc3XmHXvPqkwhuWu4bT
	cpZsr/scbJJa0jKal4a1dqcra2VUKc5wAH1cGonbds1g8j74HChp0aZ3E6Yv1AVQ
	stnbCMzX3jUgOUBRrI70fffvpVZmWr0vbYw==
X-ME-Sender: <xms:zDJ5aFJ1mOR0N6-Ndkw5vZn8_uGQYhAEb6Q0m_G2Hdo5OooJEnDVoQ>
    <xme:zDJ5aJn6rNoFmSsyWMCuZIigi7iJ-iX6ibFRz-2tdBFMYuctLc8wCiBcRQI7mPkPi
    Yxb0vIWkaDBEiNRNw>
X-ME-Received: <xmr:zDJ5aOKYxRsVo_KYqePX6ZBz8ltKTXYZIfUfL1_djll_9Q3fUngVK_U8lFwYUh-S-wh-o5Hgjd6Mk5APB38ROtzbt-Jl1kWRHAoO1CY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiuddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsh
    htrhdrfihrihhtvgesghhmrghilhdrtghomhdprhgtphhtthhopehlvghvrhgrihhphhhi
    lhhiphhpvggslhgrihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:zDJ5aG7zSq1ZX3hXHh1GXJn_SjNPV29agfqGyDVgmZQTwaFeiCCK_w>
    <xmx:zDJ5aK2YNnxjoDh-Iu0F7X63916As3f1QMHLRSprRknk9NWXQIL7Mw>
    <xmx:zDJ5aEfm7sN6f1FSzJSTosw2Y0KjS3I66S71RfVzA8K-uJkMm5exaw>
    <xmx:zDJ5aIfa3elnE2Y1lac2Gc8zrK-KG3Q54EwdMdowNYaEKhGdHaBcQw>
    <xmx:zDJ5aIrUp88HTlhTp7mW5aJwdIWyCy84TSyOU1X5NvNeKIfQr4nexhlH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 13:28:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Timur Sultanaev via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Timur Sultanaev <str.write@gmail.com>,  Philippe
 Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] docs: correct mistakes in git-merge
In-Reply-To: <6518dd3b-ca05-1ce8-e700-81167cd2e88e@gmx.de> (Johannes
	Schindelin's message of "Thu, 17 Jul 2025 19:12:55 +0200 (CEST)")
References: <pull.1940.git.1751737158670.gitgitgadget@gmail.com>
	<6518dd3b-ca05-1ce8-e700-81167cd2e88e@gmx.de>
Date: Thu, 17 Jul 2025 10:28:43 -0700
Message-ID: <xmqq1pqe7mlw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Additionally diagrams on the page are adjusted
>> to use spaces instead of tabs, so that they align
>> regardless of tab size. This is in line with
>> diagrams on other git documentation pages.
>
> To be precise, you could add to the commit message that the faulty
> description was introduced in 0c514d576685 (git-merge.txt: mention
> 'ORIG_HEAD' in the Description, 2023-01-10). (I Cc:ed Philippe Blain who
> authored that patch.)
> ...
>>  ------------
>> -	  A---B---C topic
>> -	 /
>> +          A---B---C topic
>> +         /
>
> ... while correcting the description seemed fairly straight-forward, this
> white-space change appears to tread on more delicate territory. It might
> deserve its own patch
> ...
>> @@ -38,11 +38,11 @@ Then `git merge topic` will replay the changes made on the
>>  its current commit (`C`) on top of `master`, and record the result
>>  in a new commit along with the names of the two parent commits and
>>  a log message from the user describing the changes. Before the operation,
>> -`ORIG_HEAD` is set to the tip of the current branch (`C`).
>> +`ORIG_HEAD` is set to the tip of the current branch (`G`).
>
> This is obviously a good fix.

All comments are good ones for contributors to keep in mind for
their next attempt.

For this particular one, which is already in 'master', there is no
point in polishing and resending the patch, though ;-)

Thanks.
