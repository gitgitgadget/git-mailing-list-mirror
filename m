Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463AA266B40
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 05:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001162; cv=none; b=ag+bNS1rmBueYHeTnI9gq3H83dPcV5PEo3HqEuV/5MkAzrq3wU2Yrsis3wb/yeSpyhbZYqLCbKMDe8whO/01bF008W2y9sk62z4kTe1pHQ2FyxnLrVQMY5nolcJv9+kAAD9AMJ5gLZShUEGTO8YixXYDdG3x+VXn7VKGrb1uNTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001162; c=relaxed/simple;
	bh=UPa8oqHbpPNykj8v82mGySsVBBQxAnUeby7p92YX/sA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rcLMhOqAxCWQ3vixwAW4wfRk+Nm7O5fh5o3L4LKUE0KkGtIBcYR9WiMpNSZYt3UVaKSHNb68fKf5XOQNO7lsDnSumygc7ie0bgpqVO7bRKxPZyCJVgJAxZQcawmfGMTo4jN53MDk32QHrLH7gAdLSLPOe3CuSvMe/P0rNTq6y6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0MiUKYOf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K7O14r70; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0MiUKYOf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K7O14r70"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 33EC21D00183;
	Tue, 16 Sep 2025 01:39:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 16 Sep 2025 01:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758001159; x=1758087559; bh=T+5ffJgCSv
	KOgpBa6ILXicBJ1lKLipYIwAjuwc2TarI=; b=0MiUKYOf+93LDv3wuCeir43i4P
	cnCrTXdieldSQkTm5dX2C2S2c6swbE9SINhfBJLVsqe2NgPMlkLKn1RYovJHEGAK
	/+BU6fm0B3uO6W+GmX9LOU/Je08njdytHqxCAo1yGmf2m2qcc2Iu+y/GbTLs0+Z3
	AYCrr3/mkET7KKwIldep0Yikq1BGBs3h22YwfWW2gqoZgGVYcP70qglOa4U5WabG
	zIEJNCI4P3S58vhc9SGQwbUfTaSnJVBc3wZdRpQIXvWYTTb4Jj8536ouiL2xjZWj
	xCZYf4Kp8J8bEW7dKtzHVBZEPC0THERYsmgMRJ4TXjUm/ZhdvTD/LPmX0vdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758001159; x=1758087559; bh=T+5ffJgCSvKOgpBa6ILXicBJ1lKLipYIwAj
	uwc2TarI=; b=K7O14r70b+YuJMiqU1rYMXiAluumAVp+cCVMxyYmDMjKHaG3Wtr
	KkrkZZkBjVnExkXiOKYb0A3B7H0Al1LoAqfL6lAItP4nIwKExcBGsBJn2rGB/3vX
	Ch50jj4BkP/S7Lxoh8uFAyNTz06TqUWdZ3dCraLz9GkkHoOxzBKE+A+R5HaDcAaB
	EjrnpD50xfs9I+UgENrDGo/awe6dUii+ulmP8+8Vxkhy7Tm9yjSjrbZYvKwu3oq5
	mmKft2axHW0YxxHKNXD+QJncVQACDPQ4UaATTq1PXzusvRyjprJESGUQTKHK6Hzr
	B20J1HK6VPg462C1Hx/z+5a9uc9Lj6H2yKA==
X-ME-Sender: <xms:BvjIaCh42k0Ayt9eQp52OHoEx-UZUy68xM-i6kkiMq3VCocWs9EKYA>
    <xme:BvjIaLdznCs4KcpXWsXC5ap-XD4fqRuK44P7ktT55AONFIup1EfSe6whx5gCgkM_m
    VnXN4A5GqNYhHt26g>
X-ME-Received: <xmr:BvjIaKgeNWRhkBt0zr-52eL4OahQppIiHMxpL0AzPgg0wfl1ygD6m-VuWaJCVbSmJE9Z7tnldsbaTnZZahGRGErb8v0UpIoqsjZYFJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefleejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhu
    lhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:BvjIaLzMfr22MSvef4ZohOoLvVBkiKJErBgaRBhinCZ0zvAwA88h6w>
    <xmx:BvjIaOMybu9J-UsWFok4BZcVrWY8e5k1aIZaSOCJ0vP5WwIvWRd7-Q>
    <xmx:BvjIaEUT8MRGe-JK9JXrwjWPmkEMEAvdtKnx1c4FRkeiQRGu7HV4lQ>
    <xmx:BvjIaK028iOO7RG5HlXzSZEIlvuzF3MSqQYK3JE0TCCYfmJNqc1Ncw>
    <xmx:B_jIaNGAzx6hYaBpHs-7ntpTYZcg9sNrIvQWAUGNckrT_5IwHGcS2e0A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 01:39:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v2 2/4] doc: add an UPSTREAM BRANCHES section to
 pull/push/fetch
In-Reply-To: <xmqqqzw7arls.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	15 Sep 2025 22:33:51 -0700")
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
	<pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<0ec629d4037bf5d1ccc248ca1bbd87ccc08119a3.1757703309.git.gitgitgadget@gmail.com>
	<xmqqzfavarz4.fsf@gitster.g> <xmqqqzw7arls.fsf@gitster.g>
Date: Mon, 15 Sep 2025 22:39:17 -0700
Message-ID: <xmqqms6varcq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> For now I'd locally patch it with the attached, which does not seem
> to change the output at all when formatted with Asciidoctor, and
> does not break the build when AsciiDoctor is used.

Sorry for the subtle typo on the last line.  i.e. "AsciiDoctor" ->
"AsciiDoc".

What I meant was that Asciidoctor has no issues with your
version (while AsciiDoc complains), and with the attached patch,
Asciidoctor produces identical output as your original, and AsciiDoc
no longer complains.

> Thanks.
>
> diff --git a/Documentation/urls-remotes-upstreams.adoc b/Documentation/urls-remotes-upstreams.adoc
> index 1e9c56dc5f..f40db15b20 100644
> --- a/Documentation/urls-remotes-upstreams.adoc
> +++ b/Documentation/urls-remotes-upstreams.adoc
> @@ -107,11 +107,9 @@ Git defaults to using the upstream branch for remote operations, for example:
>  The upstream is stored in `.git/config`, in the "remote" and "merge"
>  fields. For example, if `main`'s upstream is `origin/main`:
>  
> -```
> -[branch "main"]
> -   remote = origin
> -   merge = refs/heads/main
> -```
> +	[branch "main"]
> +	   remote = origin
> +	   merge = refs/heads/main
>  
>  You can set an upstream branch explicitly with
>  `git push --set-upstream <remote> <branch>` or `git branch --track`,
