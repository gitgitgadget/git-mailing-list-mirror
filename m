Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB11F956
	for <git@vger.kernel.org>; Sun, 28 Dec 2025 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766933870; cv=none; b=Ws47RpzJLkuC6OP6vrBJE6WuczWReUdgwaAuQt1VgW5AQQ2JTkBNObnDHfc8IWymVBva7bgEXx8s85DM+NGNkmC2pJzLu5Sq4NkdgL2XjUmxjMh+AGpWimDu5AJVfUmcuJD7stzK0QsBxsa92NOu7w+ZTQpX4UztTO4GJ8EwHe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766933870; c=relaxed/simple;
	bh=49NRUu2EHYDjEJNezFz8wa4UKP+9gWX3bFFWSNHp9zE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PaxfQBart8teElqOgiWU6b4EAJAK6rne3/w89NuBbTaMs4w66l9l/w7c4AqCv18+Lam3OTgAe7v5nCL3hdJozqETPwm1R5XVDx7xeZYYkGRzC3N5b6F6fkRfakFx8F9VpC7P1NoDhj+/mv9inx8cEMY8s5oQmJOUy81XhRnI0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NeDLDTzq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zDkLYRcP; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NeDLDTzq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zDkLYRcP"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C801EC00CD;
	Sun, 28 Dec 2025 09:57:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 28 Dec 2025 09:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766933867; x=1767020267; bh=3LcQ/lwAy8
	B40sUVz/2UdwHyQNZM9wib0CP2NONbtMc=; b=NeDLDTzq0doH3m3FtS4I26QKa+
	9aq5tXgDaLxl04a3t7eK6PYNlLITfwcQq9Ukb7eDrzjrl2YPjGPr/SUUlmzZiHDi
	zXJ5aLsZDXOg4HXbRwkV2b1g2L5lODjHEVT/QT2x+sFQ7lmhYntpYPbTRLB9JnUM
	jqg1D3Z/dtndSoZjlNWfw4MusbYeFJeso0+gOGOvEsxxUfG0E+gg9hCaBWICET+6
	E7839XQiWxRxunbOWV7LqFTCrPuSQVMuOUrmuB3KRGiRe9/rFZ8Y5ujP1s3zNGV8
	aVMuYBfJrBqeSZtzomVSIfTgpbL/n3TUp9/DsbQoJ2Q3iRH4R1hCJNDj5SSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1766933867; x=1767020267; bh=3LcQ/lwAy8B40sUVz/2UdwHyQNZM9wib0CP
	2NONbtMc=; b=zDkLYRcP/KqMMEMjtpNWwrhL/lB9bY2RTrVhZQLxTxbcPhr2q1n
	OqD04Bw4jXuTErw0w7WMK8xwroJhnCW5F03F+Jiqwr776lss0jZ/YAgxmzBfKqCG
	vTMTMRqu6rk1fz2QxDDR2sXnplarhYu4oCyiCmB+h3N4vqiTs9GhCHaRKY+wpgvk
	8BUPfqgVCK5Y2PmXkC2EuD7zhhh4KQNe/9bzqaqM9Ac9YbJlekMzLqgsZplX1VhM
	tjOErm1B7VgFYzmDtdQDYsuMoHtwAmxWphzdd15V8JfTSRixTWz7lOBX1OneLbLO
	BWJG2OoxN2ESn8hUY/fjp1kR3fydLknJI9A==
X-ME-Sender: <xms:a0VRaeaupfNzqjDS7DlJ32htpLAr3DictcThOrYwnq0MKGt5BkjQtw>
    <xme:a0VRab8poLbojqFNVvpr7y_vALr711YWX4uVZQll3ygz-92FOC33nKaIk5CLNm-be
    ebmHXlz_A16ohYKeJLFgLMxHp2Jdu8dDagqyUHB-QvB7bFMf6KHYw>
X-ME-Received: <xmr:a0VRaVhu557_hnszQ8MmBXJD5CXdkXakvxSFbGTKjWxlC88g9j7VdizZwvNZ3Nx1iKkwTD2qiaqnSxX9n79DNrOnkYODuWtQwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejgeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    thhrohgvlhhssehthhhomhhsvghnrdhiohdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:a0VRaTdBDkwZpMhiuhQBk-x37e677fP2c8G2hQOU23QyyvPxTdMzWg>
    <xmx:a0VRaUp880_IuS51tB9OWpf_fR1NUmJvELui_tt-HhgCvRy2lHJGQA>
    <xmx:a0VRaQB7eRRFmEJOiY2AS4MYriJJWubgm9Aj9b8i3W7g7Uhms0fpQA>
    <xmx:a0VRaZZFaFuK7vSbg5zPJXSaNMCGYUn0IUMgyMb9hJ9ik70SrUBO_g>
    <xmx:a0VRaSL6Ft56Tayx--35Igsqh92SlnhUD9UjdUsVsSIX9T-r6n9i5MKu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Dec 2025 09:57:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Troels Thomsen via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Troels Thomsen <troels@thomsen.io>
Subject: Re: [PATCH] receive-pack: fix crash on out-of-namespace symref
In-Reply-To: <pull.2144.git.git.1766850014289.gitgitgadget@gmail.com> (Troels
	Thomsen via GitGitGadget's message of "Sat, 27 Dec 2025 15:40:14
	+0000")
References: <pull.2144.git.git.1766850014289.gitgitgadget@gmail.com>
Date: Sun, 28 Dec 2025 23:57:45 +0900
Message-ID: <xmqqfr8uk61i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Troels Thomsen via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Troels Thomsen <troels@thomsen.io>
>
> `check_aliased_update_internal()` detects when a symbolic ref and its
> target are being updated in the same push. It does this by building a
> list of ref names without the optional namespace prefix. When a symbolic
> ref within a namespace points to a ref outside the namespace,
> `strip_namespace()` returns NULL which leads to a segfault.
>
> A NULL check preventing this particular issue was repurposed in
> ded8393610. Rather than reintroducing it, we can instead build a list of
> fully qualified ref names. This prevents the crash, preserves the
> consistency check from da3efdb17b, and allows updates to all symbolic
> refs.
>
> Signed-off-by: Troels Thomsen <troels@thomsen.io>
> ---
>     receive-pack: fix crash on out-of-namespace symref

Fixing crash is certainly a good thing, but when the namespace is
segregated and receive-pack wants to get updates only within the
given namespace, would presence of such a cross namespace symref
cause updates outside the namespace through the symref, defeating
the point of setting up a namespace in the first place?

I am not objecting to the new behaviour, but am not sure if it is a
sensible one.  You _might_ be able to argue that an attempt to update
underlying refs outside the namespace through such a symbolic ref
should result in an error (i.e., a fix to the current crashing
behaviour is to die in a controlled way).

Thoughts?
