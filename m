Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A318A346777
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858011; cv=none; b=gTnH1zu6rawdGgZTADm5UfQHwlMnF1wwiOfcT85z2wlYTFGg3v10hCIrC+uKzMQ9e2tG0DvzZfKOhWzCAssJNJ/s9yeqjmmFVvN0DPLfqOl8+pJBoGd1Dh9T7kLlsVlxU+EgCuF2duy8MDOTmFG5jVASb61CAAj6TpTmZE8MEyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858011; c=relaxed/simple;
	bh=Dp3nbXvYRjjRgMwAiWGq1PrfuKk6igJNanifPy920H8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cG3cdCeqFt5wyRLSYJlBxtnCSCCQHyyg0K7hptut58PhqyjY0NSMlWK3pe+MNK0mOSxO0L2h2u2PPjsZMCE1McL9KrjlKFnKX4M1OYpO7ATv7YEgqHJz0gSTJrEWgA1IQpU/F0DKCUQKdtVf84uhlOWjAv9VUIYpaLZRD9q/y+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vcoenZVj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UYW82Yvi; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vcoenZVj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UYW82Yvi"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 876487A00BF;
	Fri, 10 Apr 2026 17:53:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 10 Apr 2026 17:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775858008; x=1775944408; bh=AqlIN7NZsa
	FC491qhlOhfIxpnootS1Mtu/awNIXvH/o=; b=vcoenZVjde4ZMcYU2xjQFlpuA4
	PZBD04DAzRFk6SdejsMD+pk/HjgCPCqGdmsPtdw5lgQiMNwmkZCcYKBSxebeu1YA
	ROP1ZsqPqmCKP7vNytzKxeIU3XrVSXNouUq96t9BTzwtzEo1TDTP4kPUIUNMceB+
	aJWgLyf8EYsW6CJx7p1u6vPCFcu0iG5VWGdSyUsWk/jLuhggEHfJkSSTN0GCbjfP
	t9pO9M2RtPXjBU0zBbCvKgN73OlTSHWRO0wq+DZ5jPp3o4Hga/NPrANazG5eHMOS
	7jwRfst9tIfBLqUlpBvxTiIfRTk/PTNyS5ClFj3Qpw1N9dqFLhUmWK1CaMCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775858008; x=1775944408; bh=AqlIN7NZsaFC491qhlOhfIxpnootS1Mtu/a
	wNIXvH/o=; b=UYW82YviMsDTYYyKt4x49rv4c489cohWERDVc10PRjPMrnHuNPG
	fhnFh0iMR8iEn36eP7NJSfBnkfXyE7TRrtQ4j5y49vqyyDd9uNMsIJN1LHZdQic6
	2pPRLH/YHoAlUUJRSvQbNFZ4Y4oAsZVDLoskFNlcdGb2nk4xV/0dvsQJXgEH6GhW
	iNaUp1qSwB1o9Q6IwpEFgytaqDFZyqUzxfMKGb/CGJ6pU/3kcXsvkSeY6e+ZqxwJ
	cRPzMj5Xr0iZ4oKqV7yobCiANPKNiaWpg/UFtEjsm5lECTbwyCY33FcLcpnzS1Jq
	pPEeeVXXXEmwargA2YjmaLj/s1j/pmHq9Sw==
X-ME-Sender: <xms:WHHZaQrodEg5-pW3dr1uGHmnOQo2Q-v5zm-6rA3ogfJ_BXMpF66H3g>
    <xme:WHHZaaUJ6W5qvaaYU8i2WntJ73BA6eQCmTXqgt4YPzmgm48hmU97rrA4HwyxVCZEg
    S7gYNtYGXJ-nRqE6qvW-B1jxBgPs12JERoUxSRoJ1dSc7Ryn53-iA>
X-ME-Received: <xmr:WHHZafCzwtqcJY-HbFhcdm-Z9BopZ9otPyAVK_xDVdPqBl1S5cSMJBJn4qUFrqDmp7M2FWMGlTNLvyv8MPFiguap8Lz12MpSiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftdehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegthh
    hrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrrhgrlhgunhho
    rhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:WHHZae2svfcb4ry-w1a18RbzKkoJYQ3LeEA5rYpDmnx-wqSmR2-JSQ>
    <xmx:WHHZaR1eETzaTFStEtvrsOSkGrrdMpt_hHJXn4IIKrdsnBGI4TFBwg>
    <xmx:WHHZaTA_36VHoeik7yS2tijts6phx5hpnfq8YuSqRQIpxIttyyegrg>
    <xmx:WHHZaQ5-GyG7t-TD2gp_mDQZ89Dvuy1hYzgqspiAGUdO00XkIG5RCQ>
    <xmx:WHHZaYPoteYVpJ2ElIV_MLX4ituXCIhltJ21Otf_bF5UK3hnkDb6vD9x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 17:53:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Chris
 Torek <chris.torek@gmail.com>,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v9 0/4] checkout: 'autostash' for branch switching
In-Reply-To: <pull.2234.v9.git.git.1775854874.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Fri, 10 Apr 2026 21:01:09
	+0000")
References: <pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
	<pull.2234.v9.git.git.1775854874.gitgitgadget@gmail.com>
Date: Fri, 10 Apr 2026 14:53:26 -0700
Message-ID: <xmqqy0iumqi1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      -    stash: add --ours-label, --theirs-label, --base-label for apply
>      +    stash: add --label-ours, --label-theirs, --label-base for apply
> ...
>      -+`--ours-label=<label>`::
>      -+`--theirs-label=<label>`::
>      -+`--base-label=<label>`::
>      ++`--label-ours=<label>`::
>      ++`--label-theirs=<label>`::
>      ++`--label-base=<label>`::

I guess it is a good change that makes things align better .  One
potential downside is that "--labels-o<TAB>" is slightly longer than
"--ours-l<TAB>", but I do not mind too much either way.

>      @@ sequencer.c: static void create_autostash_internal(struct repository *r,
>        
>       -		printf(_("Created autostash: %s\n"), buf.buf);
>       +		if (!silent)
>      -+			fprintf(stderr, _("Created autostash: %s\n"), buf.buf);
>      ++			printf(_("Created autostash: %s\n"), buf.buf);

Keeping the behaviour of shared code path unchanged would be a safer
move, I guess.  Sending progress-like messages that are meant for
human consumption to the standard error stream may be a good change
but should not be part of this topic, I think.
