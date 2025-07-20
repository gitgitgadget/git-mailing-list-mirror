Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B07182B4
	for <git@vger.kernel.org>; Sun, 20 Jul 2025 01:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752973976; cv=none; b=kF4W98/KQ9q/VDgTRjrEYCCYEA+0kkxUvPVSOBsLxG28XVYNJITFuUpSA4uqSnPSmFeyBdfMNwMsEzz3YwBR7kJHf4BswulfjFZd00G90oTYELxmECnDRXtti//59fKZUL8Qp64dLXXhNeZZ4XYL9MOp3ar6JL1KfiOBlxJbzdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752973976; c=relaxed/simple;
	bh=hggVzcAvkrNVC4KRm3iSnLFVvcaGppXYliVlgbnECTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jkxFBuLMTJkJslZJY6Cs3RFQ+45LgI+qzrONIN6abbH32CCQBsE0PR0E8ZqurgivP6x91/E2KO9cGGEMjmiv5z0iBXjuowGuvOyIG9yWOOj2shTNNyMEwKsl49hMeeTJ+ZceMztMHwtiCkHvO2YUlI2/85Ha3hD+tEtujPwC3ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gpfllf+u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MadkPswG; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gpfllf+u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MadkPswG"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6BBA21400218;
	Sat, 19 Jul 2025 21:12:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 19 Jul 2025 21:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752973973;
	 x=1753060373; bh=hggVzcAvkrNVC4KRm3iSnLFVvcaGppXYliVlgbnECTM=; b=
	Gpfllf+u9GjfISjg+FIbW6xpsi9AOLCRB4NscdlYs8ilIbRdFP362jrVWrt+YAnD
	Ktbcih+HQwA74yY9padrrQv6DBkgzYZ8FFCpTv1hBNTN2fjbi4tBdNJYSeiGMVDm
	9qJ+2WsXEX/mm8Ut20roCnAYITuNgt2E8JJ+be1t1qDCe36dNsdMT0KOmHMfR/Z2
	FrY7WUVz6zx11YL+9hP+Qlh19LSus+k6FMn8qBdhUohR0W9w/mq0xg3Lk9CdHZMe
	0SraT7vCNI2pfEy9+Q6iKjxVQ8gmZWkEe6tHd0Tt9KxIClh0JDScwoPQxKudlIX2
	Ccb4pYeM2ucNDEvpX2ET+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752973973; x=
	1753060373; bh=hggVzcAvkrNVC4KRm3iSnLFVvcaGppXYliVlgbnECTM=; b=M
	adkPswGT4OJglrYrKmQxYWwnIHqm65r46VhWwCsDZZMnUkZmgT7Aul95IaQeCxwI
	y6vEmYruJ/2yFlYvh292XUpX7cEZwOrVGvqMGSD/r3cB1tAEY1qo8MLbLEow9gkV
	nJ9IvwT4MriEuFjpJQznDOGVUPs6mhLsQuIh/zy3+87s4Cc8hWhH5pLmLM3YNVLj
	nE0UQIjDa8JADNvPGknrnRwPNTSp4y5PqsHVUbSMIujGSduzIhN75MrGEWyraTCq
	euhXIjHpg85NMAc45dBfx55xdyxovKyGNj39AfHd9xjPqAK80DfYQCQTDrQuV520
	k4nlRQcJFf/cvd0PikPJA==
X-ME-Sender: <xms:lUJ8aAzVY6M3xWRiT9-O4s3Ez37HpXY5WAaavX4QpCoTT1w1V5bhJw>
    <xme:lUJ8aO2L5H-6o7lEpfslDtDBKExDDkYBjaoEuAL0s38JLEhiKSMok594nDWqxTDFV
    QVhS6bHY6q3DFP9Tg>
X-ME-Received: <xmr:lUJ8aO6Poidg8I6QrNKDARCzXkyFOy6wkcNzE-b8tCR0IBRHxbKr8zLFQA9C8bQ27xbXo3UaWzDZPElu6W6Ha45TI-3jihdWldz8LaY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeijeekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvghgrughhrggsihgsleekleesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lUJ8aBVSMK7HlmiJXLcdbMWoBsNkXGNdAuTDXJqymafboF95_ZDlbg>
    <xmx:lUJ8aNAeRMTk7oel7Z0jpZO-DmbiPINSG16v5r9gMr8PJPwcK_JozQ>
    <xmx:lUJ8aA4SWxRby0GB4vuJvsGq7-3XN9j7E8QX5Cxg9unV3JqHDNPSgg>
    <xmx:lUJ8aIwqFGEoIxrpiQnogWBatkbmHVfpLqdG-GeX1g_FsHg4PEsIlg>
    <xmx:lUJ8aED9x7m2gRZjCN_qO_iEDsX14ExyNvpDyWGqhsUG13uaAEdL57wd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Jul 2025 21:12:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Begad Habib <begadhabib989@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Possible git bisect behavior issue when skipping commits
In-Reply-To: <CACy3CeRjyGb-T=hJURJbXXcR+_KtCsRsMzyw0EvusCZOpWb4Xw@mail.gmail.com>
	(Begad Habib's message of "Sat, 19 Jul 2025 18:31:19 +0300")
References: <CACy3CeRjyGb-T=hJURJbXXcR+_KtCsRsMzyw0EvusCZOpWb4Xw@mail.gmail.com>
Date: Sat, 19 Jul 2025 18:12:51 -0700
Message-ID: <xmqqwm83zmuk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Begad Habib <begadhabib989@gmail.com> writes:

> Hi Git developers,
>
> I've been analyzing the behavior of `git bisect` when dealing with
> skipped commits and noticed what might be an unexpected result. I
> wanted to share a minimal reproduction to understand whether this is
> intended behavior.
> --
> ## Environment
> - Git version: 2.43.0
> - OS: Ubuntu 22.04
> ---

Thanks for a report.

CC'ing the primary author of "git bisect skip" and showing of
skipped ones for their thoughts.

> Steps to Reproduce
>
> ```mkdir bisect-bug-test && cd bisect-bug-test
> git init
>
> # Commit 1 – good
> echo "good" > file.txt
> git add file.txt
> git commit -m "Commit 1 - good"
>
> # Commit 2 – skipped
> echo "middle" > file.txt
> git add file.txt
> git commit -m "Commit 2 - middle"
>
> # Commit 3 – bad
> echo "bad" > file.txt
> git add file.txt
> git commit -m "Commit 3 - bad"
>
> # Start bisect
> git bisect start
> git bisect bad
> git bisect good HEAD~2
> git bisect skip HEAD~1
>
>
> Observed Output
>
> There are only 'skip'ped commits left to test.
> The first bad commit could be any of:
> <commit 1>
> <commit 2>
> We cannot bisect more!
>
> This output is a bit confusing, since the bad commit was already
> identified (HEAD, i.e., Commit 3), and the middle one was explicitly
> skipped. Including the good commit (Commit 1) in the potential bad
> list could mislead users into thinking it might be faulty.
>
> Question
>
> Is this the expected behavior for skipped commits? Or could the output
> be more accurate by excluding commits already marked as good?
>
> Thanks for your time and the amazing work you all do on Git 🙏
> Best regards
