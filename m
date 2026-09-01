Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9220396B76
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283900; cv=none; b=uUpCq2h47wRm5X5fm5kBUdjM3zGN6gvdaufFR9wtwYX6Eky3RrB4ra5rbqB1EjwkHUbCpoijehkL6tD/GyQtm7NNfHyujjzBUuH8jz82i7Jvp8WL9p6kpJGaZ2xWT82aHE/X/h0W+FksembSSpO38v7JVFd4s4161bSMkD70r5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283900; c=relaxed/simple;
	bh=kdk49M59s5Es4HnjGMdaFNQe21PXaCS8+pezarIKYFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dNWACw+WYjxVXEGyp0sPA7/bpTvIb0Y9DueQBL6MstpIPWXd9RtVUJYIQfpVBeOXk5LB5RKUFf6vL43rh0ZVgPIFtneI6/UXO0zQgSjjvhz1/v67QT3pInn7SmUqOIejL2Wt7J5FKXJr98ccVTpMsOR9lNnC3zyYffVqtouS29w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BHt8IupA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UlpyI/da; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BHt8IupA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UlpyI/da"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A3F9F1D00111;
	Tue,  1 Sep 2026 13:31:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 01 Sep 2026 13:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788283897; x=1788370297; bh=eQc9v2AJd8
	er+tAJXTZe9HzICUfNFvfHUWN97UoNQZY=; b=BHt8IupABRDr2M9ndS8il3q5Ig
	AhZB6jQczVNZ+s09rbzNJn/C4uMZJnQpdScaU/wNBJLn44E4z/4aTMngqovLOK6y
	vK1Knl8BMKaTaToBBoLDodGuaVycr6ihmMjBfT95Zf++aWMNhe5+FmcstvUZ3tYn
	zMvMo2J4dEt0HFTofQoQk0nNhDXF7GGIrbkLjXkJd0gNX1UWDRNm3nJug8JJCtd3
	/qaztzfS1a1IydlITZOYMEt9qFXT3paOCrLJk+5tYJ34u7hYuWejyR7UoA4cEF3a
	FfLqv/wBsTUSWzq80h+oM9ZvNsOjZq2CCCvwINErfznxdI+nr0WpeDtLLtrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788283897; x=1788370297; bh=eQc9v2AJd8er+tAJXTZe9HzICUfNFvfHUWN
	97UoNQZY=; b=UlpyI/dalIVpBlaSuxXkCK3HIGi5Rf7oDSI6y1Q3uwvzQ+B+GJg
	r/2L/0xrlC4ScGQxmiLWw1yjNFGk0kGHJ42SjDgr/28QzNo4k4YrqP61ZWqusvut
	WgrUDq79DrDYmxlyDiZ5aZ062fgbvd5AERW44ffLY14h+aVay9nvsPTGLp6GU4EK
	WOeA8nqKGbtpJDfRn7xuewRv1wlYNQMXFAtl3IfyZDcBUuJAL81eZsuP99eCF2RZ
	0hbo6NaaUQA9FtdJJaveVXE4afbjHyujtg/rjmS04OwOkwxoZfO5blN7ZVQZJR1a
	mkzUpoR+B1t4kz+T3op7Yg4DgmhA7S7qT2A==
X-ME-Sender: <xms:-QuXagw8-bBmTQZ32i8jeP3Hhxb9X7uWzcRNV0UOHPfOy9qkq8SeQw>
    <xme:-QuXarI_TiR_DgmkDo2qPNrrXqH1r1QFnTTziuQ_mprws16AGXyE_vVRs5KXNw4Hs
    d0RlmF2O7vmbhtRt00FKD9-vujUP5bemY-n0HFd2bA7XETvVYUXtA>
X-ME-Received: <xmr:-QuXaqqdtXloOaONdnW3nk8qZuZBj9jPIpyUaHB-TZz_yE491BdvOnLk4CBe0kMpHxHTz1x3xNxfQtgxN0Zi__M69tiQ2rPQBA>
X-ME-Proxy-Cause: dmFkZTFKEvlWXZMJDFQV1xn5JTQy9A2lAHnFAyDkdKvPZpsf0KPei3icCYm7ziV8PhrYZw
    Eh1fXBP+LppQ8eCRF3H6b/gL9GdOdfKnZhNS6xY1PEwTZBYR1CfHMkSaGCj0gC4n+K32B5
    sKqVv06Yh6+Niyn2MgUHkrOZmpzMW1pysfthYcGcUK0gXnDx9HITvkStY4GzzTDjS2INgP
    w4BX304+MNdecfjNXWPN/Pr6Ii19PjBIVOUbqXa2uewFkzeP2XJlQ5AXL+JCOXAT6Bpohi
    /iRU8EqbEr5SshUtVquCRSOT6eybQm41izBUB38ZL2x28AgylDnUdThko9pxhRrrVYHfAa
    w9+7Z4yp6JZjXt9Fc2JYQBCDh5xFdMs+8N7kAsrgfKW2/vSZvIrqg6rgy8N8KJ30otXMQH
    ti647ZBYLQZ5NM55+2gjHkqJ/FuQ8LuFHT2sbrTiHZbu5NxhCQ8WgF7VFLKr4b4FRh8hJB
    I5BHpIhXR7LUL9iLxkDQS960DVFzYjKYXDZFhzxE5lGLZ4rF2peuhM4BpiGQ0S8nfcbXuV
    tOC1pitG5on/9tel4cnuo/hUmxwymVMEGH25uhCMqWpK9Lim2WTAceNZvDDJEeFMavybNX
    xrfYvQYPzPf0R79eDWu5/I31REYwVHeXICCgwO69iRB+BtPb7ViFnfwRX30Q
X-ME-Proxy: <xmx:-QuXaqIHVEgYWNfWkHa8cfB0fuentn_DTsi9KaWEdWCaZBY8klCLqQ>
    <xmx:-QuXavSIEAVGqRGeRI6dbhkN8iS05Jv1bf0bCHk4cqKywb1BXegEFA>
    <xmx:-QuXapvhAeA4W9AY6BF_I9UBMwvRGPKXd41KgMgU799AqfsZwLQXag>
    <xmx:-QuXagaZm8xDVe2azjTZRf3PtaZ1lm4qguUgQmjpxos5exD-tR7erw>
    <xmx:-QuXalaICWHnZpWYckRPv2_dKLTszzH0_BTYn9_PaRp91oGWFhRH-6Ra>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 13:31:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3] checkout: separate autostash conflict advice from
 branch-switch message
In-Reply-To: <7dbebce0-1814-4b0b-8167-6a464d893612@gmail.com> (Phillip Wood's
	message of "Tue, 1 Sep 2026 14:42:19 +0100")
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
	<pull.2364.v3.git.git.1788256199679.gitgitgadget@gmail.com>
	<7dbebce0-1814-4b0b-8167-6a464d893612@gmail.com>
Date: Tue, 01 Sep 2026 10:31:35 -0700
Message-ID: <xmqqtso8swso.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Harald
>
> On 01/09/2026 10:49, Harald Nordgren via GitGitGadget wrote:
>> From: Harald Nordgren <haraldnordgren@gmail.com>
>> 
>> "git checkout -m" stashes the user's local changes when it cannot
>> perform the checkout, and then applies the stash.  When applying the
>> stash results in conflicts, the advice on how to deal with them is
>> printed directly on top of the branch-switch message ("Switched to
>> branch ..."), making the two hard to tell apart.  Print a blank line
>> in between so that the advice and the branch-switch message are
>> visually distinct.
>> 
>> To make this possible, "git stash apply", "pop" and "branch" now exit
>> with status 2 when applying the stash entry resulted in conflicts, in
>> which case the stash entry is left in place; other failures exit with
>> status 1, as before.  The exit statuses are documented in the "git
>> stash" documentation.
>
> Other commands such as merge-tree and merge strategies use 1 to indicate 
> conflicts and another non-zero exit code for errors. That matches the 
> way grep and diff use the exit code to distinguish differences from 
> errors. It is confusing if we start using a different convention here. 
> I've left a few comments below, but the exit code is my main concern. It 
> would be nice to separate out the stash changes into a separate commit 
> as well.

This is half my fault.  I should have made it clear that my sample
code was merely to illustrate the need and ability to allow the
callers to tell general errors and specific failure modes.  I agree
with you that "1 if X, other non-zero exit if error" would fly much
better.

Thanks.
