Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710AF32D442
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266950; cv=none; b=W958BwU/B86mmZHltizfM02QZHnsU4kGh8+V9bMU6uoy3zzxoMapEKZyGC2mqmcl2oy0jpCvtCBdtKmE1yE5Ys3fqy4y7cuynlimd+oLSVoldw9cFdo8y3uB7zr4p02XcgHGunwStvIip+XBhZu1MWM/g6+V1qrXn7tToKzMNAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266950; c=relaxed/simple;
	bh=tZir3XfE5Sh1apFipgnxYbkobXM/dT/pUVvmGDS/pIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OQB7LvjSXurzjU70ScybcS0MUWu7+4kgKidPIZoVLoPSRX+AvFetStSvt9PHJ0v6zB24zUseWM+sQuWi/YMa+DbSCdvWqF9wZ8e1ahp/zYMPgIA/pO1o0809VSWfdOs7ldOu0YvlqrXbdRz9gRC9NBEzyYXSL24Lg5wsjCbl0A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ievn0Xpu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xaQN5S0m; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ievn0Xpu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xaQN5S0m"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 86232EC04DB;
	Tue,  4 Nov 2025 09:35:46 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 04 Nov 2025 09:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762266946;
	 x=1762353346; bh=PY1Lz2KKXpw6eowqS6Tb2F2mbbE9x8NXDPkFAKsMYrs=; b=
	ievn0XpusqNhVQNrwPQSCL4qCyoTcKn7PpXRXA/ZXSLXU6ls9J5gT/p/1oCs/G4A
	piErX495YO0bjT5SPFI81XCWm7RR/6xSc5sIyYizpK9zXX9wPUTpbgANyyk2cEB2
	rCuAtZNBhNB2pV6dHyQOr5YvQd3b0IxA5URepvBc29AXAnd7XCfRjySbwpzH0HqW
	HXccQNNqJz07GFqEQWM9te0yR0F1l5juiwLuXlfRCvbmDqEt9bKs4tN+rUS+F4LY
	nwsh21i1VCk4Q279mnr2na2ulxT+nhiJcdBQHxBcwqgMzGT2pRw+c/VP7UQq3yyz
	FCeSCv+fDnPMiu80s7k6Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762266946; x=
	1762353346; bh=PY1Lz2KKXpw6eowqS6Tb2F2mbbE9x8NXDPkFAKsMYrs=; b=x
	aQN5S0mlmcv+Vm77UkBr3rGdbcW9+SwEqAmYVQjruK49ryq6wLA1HDflCK/qD9Nj
	IJBn9LdBWhmx3+/xlHCL6Z0LmHlZUU2wBX5LPtI2JTL3tTSSAh6Ii8ZHA0o3IdpB
	PMbnXDzs/g4HlMdF6LDtv9CbbUFuBmlr7MiFgr+x5LW3ZVKPpVGrOBRIKrS/99N0
	EzmAugrLNBdw5sFXW38e00bffOcxCkldBUB9VBA1lNF7yWRFmSXL2GL4dFzVwOF6
	9vUkp6rYfrqNJyr5hP7ut69TC4rbVJudj6CPZrWuqGXk16ZoFG7k1/SA2IskxIh+
	7OSmgvqQqDL28sLedjR6A==
X-ME-Sender: <xms:Qg8KaaqPO0Zz-ZnwNc3BaA-7vTmwJG4s-Lvu8tF-b74CGana9r5shA>
    <xme:Qg8KafjNU2JZSLkzVSKUnwjvNDQeHg-uKOsa_4I6gj0w4P5hHmKPkVGYOZwzTMDpw
    wzWvuWn1xid7-nklovkB0cqvEh5IAR9fSq8vcYkfF3tKlnd3_XaBvQ>
X-ME-Received: <xmr:Qg8KaXgVbrz5GMvqseNyGmfbDYFHxfgulivS1wy4V9I-NXyc2ofJXedKWcGXHz6pZ0heAIIIp0QkKxDlnibkI_nk_rLhCYHl158y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeduvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdtjefhgfekhffhteeiffetheelhedt
    gfehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehqjhgvshhsrgeiiedvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    hhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehush
    hmrghnrdgrkhhinhihvghmihesohhuthhlohhokhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Qg8KaVgeaoIDVWIZoMhGeDc2xdk6wR41T11UZNf3Sj6xIL3Ywp9kFg>
    <xmx:Qg8KaXK4p1wQFrVbPZZ_Kon2ZM5qTQNHyOgGlFxfSAsDjvquqp9wNA>
    <xmx:Qg8KaUFONAwFkugstl4BJpCYDGjM-z5VYkr5KZwvtfqNfdrvTluTTQ>
    <xmx:Qg8KabT_uAiUKZbypySypYAmNsZqZlEERIgCR_-LPd1JbnA1vodInw>
    <xmx:Qg8KaU9PIgHr58jMcqxPp-HF049CZufpFqf13GbPMcxDlChabiLOTzdH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 09:35:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Queen Ediri Jessa <qjessa662@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usman.akinyemi@outlook.com
Subject: Re: [PATCH v2] doc: clarify server behavior for invalid 'want'
 lines in HTTP protocol
In-Reply-To: <20251104100653.2152-1-qjessa662@gmail.com> (Queen Ediri Jessa's
	message of "Tue, 4 Nov 2025 11:06:53 +0100")
References: <20251104100653.2152-1-qjessa662@gmail.com>
Date: Tue, 04 Nov 2025 06:35:44 -0800
Message-ID: <xmqqqzudrhkv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Queen Ediri Jessa <qjessa662@gmail.com> writes:

> From: QueenJcloud <qjessa662@gmail.com>
>
>
> From: Queen Ediri Jessa <qjessa662@gmail.com>
>
>
> Update the documentation to clearly describe how the server responds when a
> client sends an invalid or malformed `want` line during the HTTP protocol
> exchange. This improves understanding of Git’s behavior when handling
> incorrect object requests and helps developers detect and handle such
> protocol issues accurately.
>
> Signed-off-by: Queen Ediri Jessa <qjessa662@gmail.com>
>
> Changes since v1:
> - Rephrased the explanation to be more concise and aligned with reviewer
>   feedback.
> - Clarified that the server includes the offending object name in its error
>   message.
> - Adjusted tone to describe the expected behavior rather than prescribing
>   implementation-specific messages.
> - Improved readability and technical consistency of the section.
> ---
>  Documentation/gitprotocol-http.adoc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

I'll locally fix up before queuing this time, but

 * You now have one in-body header to force "From: QueenJcloud",
   after which the blank line declares everything below is the body
   and no in-body header remains, and then you have another line
   "From: Queen Ediri Jessa" that is not an in-body header.  Perhaps
   you should send your e-mail only to yourself without sending to
   the list as practice to prevent them from appearing again?  You
   only want the second one, IIUC.

 * Describing "Changes since..." is a very good idea, but that
   should be done _after_ the three-dash line, not beffore.

Thanks.

> diff --git a/Documentation/gitprotocol-http.adoc b/Documentation/gitprotocol-http.adoc
> index d024010414..f3f48d3f35 100644
> --- a/Documentation/gitprotocol-http.adoc
> +++ b/Documentation/gitprotocol-http.adoc
> @@ -443,7 +443,10 @@ If no "want" objects are received, send an error:
>  TODO: Define error if no "want" lines are requested.
>  
>  If any "want" object is not reachable, send an error:
> -TODO: Define error if an invalid "want" is requested.
> +When a Git server receives an invalid or malformed `want` line, it
> +responds with an error message that includes the offending object name.
> +This clarifies the expected behavior for Git implementations and helps
> +clients detect protocol issues accurately during fetch operations.
>  
>  Create an empty list, `s_common`.
