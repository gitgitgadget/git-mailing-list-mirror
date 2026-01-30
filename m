Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3FB33CEB7
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 05:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769751835; cv=none; b=MJRtL+B71OqYbc0eFc64Bf8krcr/C7OO7WAaNM77b/eWKT6OJsSDSz6ZGdtbAUsBo8x+/iPniox0AjKt93Fn0QV5OI6kuNbXQmwaYa84w0oOfbULF2+6wcvjtFOr8tv9OoNYFNM4rNCp5S9PJAFCSbWr5UP6aPVRWGt494UcCmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769751835; c=relaxed/simple;
	bh=nk9t5hBk8k2NjrIAdIFA1bGKYf4w7ixDI5O8C9PmmR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JzKAUy5+feVJxGPNgTEd7zeZZ8qg8SREdLcqmeCj3c4veehu7yB5RNCujzlxNMltyPqwXw9HjxHQzc9ljIK71YubxQC1OJDEiEz6mJx2xFiFdmr/eTLuHsdghXxuLYp6a+B9wItAwe7bnvGOVLCWMoVTspj/b02ZZUilN88LIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D1jV93wi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BYHpNJFB; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D1jV93wi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BYHpNJFB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id CA3AAEC030C;
	Fri, 30 Jan 2026 00:43:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 30 Jan 2026 00:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769751833;
	 x=1769838233; bh=jVYMTCa200ueFl7B+U3o+frzblJMfZnZdeR2jWLkSuU=; b=
	D1jV93wijYgI9i4pAkKT5YQBDF1O4hkDXEjnNsVJTUUrXwpqJ0Cve9M916Z4DS7h
	8BO2NYGDbwaQOJ1BfjdMILkZrDy9Ff29AGAWmvRrTzwLF8J7FsCBUU0p3mQy6tZl
	TLeRyPMDR1kWoKr89Czx6NvXyB7CZRa5NDaQa4a9AgEj/JKDT2HRZqkyCHKo49+c
	5KvG+hQSfdkxvIyW4L0EajceDosWkxmeNRrrRzpNs2RdYNwqxemG9FBShZYmfl/A
	dPfJ0fjva9u6ucueMYrBjyRAAiHhwPDDV6xLLjFWUilmbz9SbyxKoxcDuz0iEbQb
	PCpC5SuWYqhqLGPQ5R5dKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769751833; x=
	1769838233; bh=jVYMTCa200ueFl7B+U3o+frzblJMfZnZdeR2jWLkSuU=; b=B
	YHpNJFBgGGHId/WzqWw8+WSP+2FAMsKiqucC+XUn2t02eyDjLNInfXbUJ06yHqDj
	yGXgnWPtDgwS9gqBOS+ZwKgZDTWqwxw/RdDs2qcWm5gPwtgF7gyCsDZZoygTCYwJ
	99rl1j3uox/ncfRUAPZg4/uprLIUXJywhh8KImZoOO2TrjXlYbUX2SybkW6TuLUD
	MAvdsYxh2YcOIL4hRScMhf6S5KYR543NOdDhUQBJUMAZDXeAcmHnImy3Rp+vSqBS
	SP6oSulHslsYRR9GHqJvYNi86i/pa6eYYLhNMDeJUOd4Op19FWSVDo3v/lu3Jch7
	l4LRSZTUeTOOZeg4Pa61A==
X-ME-Sender: <xms:GUV8abVUImEZXxe4x488Av5OgYvebvvvAzXi5CwyzyQHQvmjBnINyg>
    <xme:GUV8aalvw6P_7KXJcVlJBbP2lq7mu1CVxZJxv_yBieZfGnVUl_5x4l0-GdgMsz3Nt
    gZEKRQcBVvxFBE_3zrqlB60J-wISC3rPITVjchkFrKc9nJbZhEc0Q>
X-ME-Received: <xmr:GUV8acZuPjzsy3tQ8LhshRsNl4ZEqDM0TqnxtAWlpBlp3ctHpw06Em4fpdohFtSEkzXV0CWjZa5_sLdpeCK1qh-Wm-8HdiS222lsig0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieekvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehsrghmrdgsohhsthhotghksehshhhophhifhihrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GUV8aVMcw2nJQkVpj5V3nR3eLY-39nsNZ9E1yGdkHh35Yc8D2uaf7w>
    <xmx:GUV8aRbXShcUFnfbnIHcRMDuLGqgKJGJ6uqI-zqmobDr5IonewovKQ>
    <xmx:GUV8aT2m-dKCin1y_N7YdHkEpunVP4Rx9O4JbWZj6HSMcZVlc0WAiw>
    <xmx:GUV8aXepzc3InYhdJiFD9b1nPx5O8JJjOU9n5rOeMJtjCiB90ZHFDg>
    <xmx:GUV8ab2HWnUbN_iJnKaDekCta23lbzRCzwgC5hmR16huXsh77IcGsLro>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 00:43:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org,  Sam Bostock <sam.bostock@shopify.com>
Subject: Re: What's cooking in git.git (Jan 2026, #10)
In-Reply-To: <CAPig+cSH3exmnXXarrGb+UU4izOt8bJJNkEwmU+wJFGXVC8XJg@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 29 Jan 2026 19:33:07 -0500")
References: <xmqqwm107za7.fsf@gitster.g>
	<CAPig+cSH3exmnXXarrGb+UU4izOt8bJJNkEwmU+wJFGXVC8XJg@mail.gmail.com>
Date: Thu, 29 Jan 2026 21:43:52 -0800
Message-ID: <xmqqo6mb8xk7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Jan 29, 2026 at 6:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * sb/doc-worktree-prune-expire-improvement (2026-01-27) 1 commit
>>  - worktree: clarify that --expire only affects missing worktrees
>>
>>  The help text and the documentation for the "--expire" option of
>>  "git worktree [list|prune]" have been improved.
>>
>>  Will merge to 'next'?
>>  source: <pull.2135.v3.git.git.1769578785381.gitgitgadget@gmail.com>
>
> Yes, I believe that the recently-posted v3 addresses all the points
> covered by the two reviewers (Eric & Junio) who commented on the
> submission.

Yup, the latest round looked good.  Thanks, both of you.
