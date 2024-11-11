Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D48A29
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731284424; cv=none; b=uE5H9z4RtF+7aJIKHqo8uMeOfYYkxtRt/+ZA3vzp2RnW8/WpeM5sIvESIakYRwE9rp6YzsyO/DhOvxLKUQ1CBIqd+QbwmJf3Nr6QWUXPH9nfrxuN2aBz3vW5LuJlzIkrxn9guqBolezYOxjurwJ6hmmeLZcWhDtqh/JtIucC8EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731284424; c=relaxed/simple;
	bh=cLCCM4esbMGLCpYqt/OOLDpeQhrwiyuuaUV1G9g4r+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YNAuwHPcA2c/qBfe+hGYk1zbIbumtetYBy7hSB9rs63tPg4vNgZFRSXI/e9hjISzT5noJaInZ6rcDMuYnOZQFI9bt+hG4BriRzjT4H0f/CpLlq+DNyCNfphFC7FAIog4A2vkvOW2xe4Cp8/fiV4JkXBvALBtFUOIYos+JOVSovw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hGCIHQrY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=igDe6PqE; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hGCIHQrY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="igDe6PqE"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BED8825400F5;
	Sun, 10 Nov 2024 19:20:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Sun, 10 Nov 2024 19:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731284420; x=1731370820; bh=06KForFqX8
	OOTZyjonFWkLDyzRydgXUFa+udAJBjAL0=; b=hGCIHQrYhNk6PIB4fMGtNSm2N3
	4MSSSLNARmAPcVSh3ZiJwm93zXyhz5yTWaKT8XZsjthMUXUgM+CcZx6iKfK4dPGy
	FOnfAw/6syAjPSLQYI6rSoHUtoj4+P6M1mtBpRFIQpJVj9X9PP6WWrdH8b3roAjX
	/EwZG0yZYGBzfGchXwjS7a0dFbI4IS4oj0sojnL5qAKad1hqZbATLg9mW+DgMtAK
	YGS1mQkzKVgAznNRQwvJWK+AZnVnZp1a+aPkAsrufwTEJmQvyXP4ZBAGyDHKCN8r
	+d2WXuB2q71xyBPr8F4uFxkr90sqfJpuvAHnR3oolz2nwNMM7vzSsm8ExXdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731284420; x=1731370820; bh=06KForFqX8OOTZyjonFWkLDyzRydgXUFa+u
	dAJBjAL0=; b=igDe6PqEAbfIncjoENlpJqQOP8Gts6knoCxvgq/5mbZPcFj6gLp
	OR+xAVWLI/iw/ygyTRLvCZuzw2qHCA/G5qESWHjEmsQrIaIAeof/5vU/4VHKFt2p
	jj7S7pU6/g+CZE9BHBNFF9bpA4CwY/nLlpXdCmMVa0lNFeZTp4L9LHsZLMOEjFaa
	/Va/adavkj2yhNtKsxWBiBn6s33nc+rpGBeqgkD5Q09dCxDiSms/qEcqV3neKBAS
	nORqGc7HPKqvOUDymxCjOj0y01eR8facqfJbhTArt2g67TsTcglt/Se+Ba31w+qi
	IYP51WiBEFMXddx+7qpcTXnv5aS5rufgavg==
X-ME-Sender: <xms:xE0xZ_hKFL0UjHtdCMhjkzOdTzk0UCk77UN1ZW0t3kv5JR4SVip4ZA>
    <xme:xE0xZ8DXlDHIgl28XI14oV6VpcFJy61LSAjvRPbIsX2-JUB8kyLN_BMk2NGjVKbaw
    ED_Y50dhdUyANJYLg>
X-ME-Received: <xmr:xE0xZ_G0ljKYVjauDGvyMeBlBo-CEQf8EBZZ28WiI-v9t586XaLLqBasIqiFdw9Ec5vfrRa-B9TxWnHC0ICqrf4_xhVe74kMOgOq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehg
    mhigrdguvgdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvvhhrrghiphhhihhl
    ihhpphgvsghlrghinhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:xE0xZ8T8ygGGFqq2wx3rWU4Op7qLAzGCCpAcYngmyRCstAfaJjllcg>
    <xmx:xE0xZ8x7eVvpGFg6xU31G16m703EUk0NRn4U2PxSXuK825qXlY1ntQ>
    <xmx:xE0xZy6a6aBBO9VpNuUzEg5LcFQX_qDLDNh9jQP70RgrEaC1jF1cIQ>
    <xmx:xE0xZxyLAd0YhtavLtfbZHlA9QEDy4xS7JBos-GK8-F684y--M0Y7A>
    <xmx:xE0xZ_zR43VX0RTJGU0BFRVCPFwdKdmK_v_ZybDRAafqm-HUzCt25hJh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Nov 2024 19:20:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Johannes Sixt
 <j6t@kdbg.org>,  git@vger.kernel.org,  Philippe Blain
 <levraiphilippeblain@gmail.com>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>
Subject: Re: [PATCH] range-diff: optionally include merge commits' diffs in
 the analysis
In-Reply-To: <CABPp-BEaZXZ2wSfrkkOAX6W9An8MTf-LEVNKvXvRTxyV9XcKcA@mail.gmail.com>
	(Elijah Newren's message of "Sat, 9 Nov 2024 00:49:54 -0800")
References: <pull.1734.git.1731000007391.gitgitgadget@gmail.com>
	<abc2453b-f7df-4601-8834-595881f9ceca@kdbg.org>
	<af576487-5de2-fba3-b341-3c082322c9ec@gmx.de>
	<CABPp-BEaZXZ2wSfrkkOAX6W9An8MTf-LEVNKvXvRTxyV9XcKcA@mail.gmail.com>
Date: Mon, 11 Nov 2024 09:20:18 +0900
Message-ID: <xmqqzfm6k4e5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> That's particularly odd since the first category is the most
> common, and the third (snuck in unrelated changes or "evil changes")
> are the most rare.  Maybe we should just call these "user-modified
> merges" rather than "evil merges"?  Any better suggestions?

It is "evil" in the sense that it makes it really tough for those
who dig history to find out what happened later to figure out where
the change came from.  It could be an attempt to hide a malicious
and unrelated change, it could be a resolution for a non-textual
conflict, or it could be a "while at it I am fixing an unrelated
typo I spotted nearby while resolving this textual conflict".

The change does not have to have an evil intent.  It is just
something different from and more than what the textual and
mechanical merge would produce.

"more than" may give us a hint for what we want to convey in the
name, if we were to pick a new name.  If a new topic changed a
function signature to add one extra parameter, and updated all the
callers of the function that existed back when the topic forked, an
"evil" merge needs to address the semantic conflicts to do a very
similar update to a new call to the function added on the mainline
since the topic forked, when the topic is merged back to the
mainline.  Taken as a whole, the first-parent diff of such a merge
will show that a function gained a parameter, and all of its callers
have been adjusted for that change.  Most of such changes would have
come from the side branch, but on top of that, the merge needed to
contribute more of the similar changes to callers.


