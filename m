Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8D1F37B0
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056119; cv=none; b=E1EEIgbbzCN2gCkOa/wpDVM13fxy6D0i5PBe70JBjWs0m+N+IeMg0DOlsQ/LDHU/qaNuNdLRBok596MWTr0S0N2jNPoAlUcotFmt6HOgLGa0vcWIUr20nUyd/urdeNrLOBUFdBuejObVOAd0WAb/5FGwup5X2N4dfRXW4zsrb2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056119; c=relaxed/simple;
	bh=w+LxlgqjRT6XoIwe9ReUE+O1BJugLcKPnZIeOljwupE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a1gbehz+G1RmUQ2G2ifYypt2Jb/Io94/Fo4M+9Rzy1zAqWzhn3x1Uh2Y+YfZgU/YC8lOsjGht/Tf3+57RM0kU43CsSR4+pFsuGo2XSocMI1pqAffWA1wDTA+QU7lDKCCh8nbOmjrcn0X8asgzwH74pKVQAFnvsALk98mU7GOTBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=13X0C3qb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M4+HU/Eb; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="13X0C3qb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M4+HU/Eb"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C966213802CA;
	Thu, 16 Jan 2025 14:35:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jan 2025 14:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737056115; x=1737142515; bh=i+xp1Db894
	nQ7tANrpVbllf1NCkPoY8/1eWmZSXGyz4=; b=13X0C3qbwubXG8O+wtni8brOhL
	IVKAaBDdJWYQdD6hjY29mOYhR6ClmdXFKUrEUlNRpursWY8KmSwgcgY+mfJrchM3
	72cow3dYsAB/mNyV0lWpHbH2NXM23rGV7UWY+A6gcN6AFcw+vIhCg9H7bIGnlTR0
	GGWZcOAxrZnn7DHwWy/FJzls3rOVpSqfB/zmzfZDAhoZmK1clZBLFTlVmnsn3+42
	E11vERPxBcTblW0DOZWDf3D4vfLbO/vrd4Pp3lWvQ3je060D1uIKB0P/9EjuVM6r
	ZSIvlyY+zrqL+FMSjW9ONJaK2zXyiL5IJ+AfA8u0yhVowussi9KCa8kEG1ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737056115; x=1737142515; bh=i+xp1Db894nQ7tANrpVbllf1NCkPoY8/1eW
	mZSXGyz4=; b=M4+HU/EbIBU40n9kROAKrHAuBoOkX3kBBGEm8Qxj2ugPff3lqhJ
	/v/uqPUMGCL1tdnUioLouU0Z/Mg8YfAE1nWBqWX3j8sgjFXAEGJuaZbefReCe6Z6
	lxudO1rdp7re0IGNgPzPSEL/Twy+yT6tGoaqmEP4exeUpLnncsumi5TU+FvY7GEO
	Vw/mg59Dk6+8HbCesD9CMFJ18TtPrgz3AZgKLQyuqtsYAACvPnwdT84LxvpoqPty
	8XWzfaN7NxwngLoi4dA74VGZg/E3egyMXgdF/Qca/SyIoL5sxS1+XZl8F5MpBtJZ
	Ene7CHqpKhnrlk7VwV0avUN4UOKm1j/2Kcw==
X-ME-Sender: <xms:c1-JZ6daJaWrYwIBHZtpD_U9-eqwzisFzqTDTn7f12zDqMY3ovl92g>
    <xme:c1-JZ0O_Q4wCZriN3zawdFuzMi84BnsPOGnScCtjvSVAEGmzex39cPHIerh9tcYj7
    HtKEPtE8sSqB_DZ0g>
X-ME-Received: <xmr:c1-JZ7j50vlFeDQN7Bo-AW1Kx0qQ3cUdSOExxf3gjplnATJtUwR7IyXlrWdlN0dlwP8n_zUyIj31Glc9N6HWGO26l-KV2NfRVKRo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvnhhulhhlod
    hkrghrthhhihhkrddukeekrdhgmhgrihhlrdgtohhmsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:c1-JZ38Ps_U6qJMzY6r4RTBlMiU1c810OBdXX34F4ZRVTT_sPwvFiw>
    <xmx:c1-JZ2t3gSQJTt76RAIV2-jLhqurnkNwM5Bk9Frfydxp0wPVTM2ENw>
    <xmx:c1-JZ-GW9D2YkgSZ-tGY4dq2UmEkO1cyJj_YEwo_Drc7a9Yi4cw5Jw>
    <xmx:c1-JZ1P1u8iZxzL3UlKZ0tBdZ2qSqqRXXg-BoRZt05o7gI3Uzt9qEw>
    <xmx:c1-JZ4K7ifR6Fm4AVY2sLrxyAswdmrYwBC_MidLRDIod0mwXMnI98qJz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 14:35:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak via B4 Relay <devnull+karthik.188.gmail.com@kernel.org>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 1/5] pack-write: pass hash_algo to
 `fixup_pack_header_footer()`
In-Reply-To: <20250116-kn-the-repo-cleanup-v1-1-a2f4c8e1c4c3@gmail.com>
	(Karthik Nayak via's message of "Thu, 16 Jan 2025 12:35:13 +0100")
References: <20250116-kn-the-repo-cleanup-v1-0-a2f4c8e1c4c3@gmail.com>
	<20250116-kn-the-repo-cleanup-v1-1-a2f4c8e1c4c3@gmail.com>
Date: Thu, 16 Jan 2025 11:35:13 -0800
Message-ID: <xmqq8qrar1qm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak via B4 Relay
<devnull+karthik.188.gmail.com@kernel.org> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> The `fixup_pack_header_footer()` function uses the global
> `the_hash_algo` variable to access the repository's hash function. To
> avoid global variable usage, pass the hash function from the layers
> above.
>
> Altough the layers above could have access to the hash function
> internally, simply pass in `the_hash_algo`. This avoids any
> compatibility issues and bubbles up global variable usage to upper
> layers which can be eventually resolved.

OK, so the aim is to make a bug-to-bug compatible rewrite at this
step.  We used to use the_hash_algo at the lowermost callee, so have
it take a hash_algo as parameter, but have everybody pass the_hash_algo
to it, even though a caller might have a more "suitable" hash_algo
for the data it is feeding the lower layer.

Which makes sense.

Naturally, as we are producing pack stream, we ought to have an idea
on what hash function is in use to name these objects in the pack
stream and the hash function used at the csum-file level, so all
callers ought to have the information eventually (and if some of
them are relying on the_hash_algo currently, they need to be fixed).
All of that can be left for some future date and blindly passing
down the_hash_algo from all callers in this patch is a good approach
to establish a solid foundation to build on.
