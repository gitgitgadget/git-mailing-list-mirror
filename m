Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5902B28726F
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262558; cv=none; b=JHVxRO46hSUJ6TilRd528xe38gBW8xSTZXXZazp+kQlWUK1x+n3B7JyGshme5EUUiZ5ZfOAtxdYFdEQrRwJ7vUD4VQ/TKt1GxmmzuHKyV980Ph5/eo7UwcJ2ygG9gCnfrYvOsDaxFhJjQ1Lm6NPJlnq8S/4aCM4miwdBbYE6bCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262558; c=relaxed/simple;
	bh=jJms9BNg0N52nHZZNQp5HbDeDfhzepPPwY/rDqLfjm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SIdu3HRZVjL4LiyoyK2Yl9Xws3xECeICBYva58NuFJMNfhWixGpDyaiv4vE/bCw+ILc36jtONHqM8jajhCy3A8ubsFeP7410fXEervAkiHFed7YZvNrl02BmhkruQgqXI8MdOABmTYPoU8EV0NKEtu116UEAQi9F/mVhm7jGMBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gTclrKU/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I0ofYQIK; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gTclrKU/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I0ofYQIK"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 66E01140004B;
	Tue, 30 Sep 2025 16:02:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 30 Sep 2025 16:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759262555; x=1759348955; bh=lQbBn8aumP
	h96CixBQpkH2dujo0FRaXca0u+AMp0XcM=; b=gTclrKU/E9p3a37U6R5/kYx0Nx
	Kdz16bWGLDMyQoNyxUkhZSBEKrUqWFx6hujktqvRgY0DWrZQ7STAIN/4iDPcrOjb
	WVX8wELgfpFB5DxlYuzSOAJ0ShCLF12Mdk/PxwZTwMLZ9wjr2ck4CKfGWEHu+Uo4
	lIKbRGZJ+M6YDKK+cJj+It3xU8PY5eJ5IozIe/kBaUlIdiU3nwUYz3ZFqWvOfafp
	gsAlYjimTheD05jBHPZRmBndU3lGA0kmxe0n/crxHpGxcuMXVq1PzZuzx9M/lou6
	YKRtZ1nz0A2puZPjdSKjezlVpJoNRn7qZI98CmnZVo/Jbf9opjcNzlNWGDkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759262555; x=1759348955; bh=lQbBn8aumPh96CixBQpkH2dujo0FRaXca0u
	+AMp0XcM=; b=I0ofYQIKGvc3Y6RNjri8qVhm9ohCpc9ehYmc3l6l0xhycgjqmpg
	HVgsMpdugcNaR4sQMm3EK6qcIw7ZhijaUkZenB0qRMDbHPKe4R+x7AubncD5PPFa
	yxJM0ZS5RpAhYV0gXDH36hUGknXe+hsXRMAOo0wbTKRZovi8db9j2Nn/k2tkxwJa
	sXM6r5owK2ISakWsDdVIxNs+P73IxUrdj+Y6nndfxplO7+mHQXGzmy4lM3BUTmvj
	dcxzAMWgGSRK5WtJNczeZATTu6ilH2MQcEban1aPEj6XUU4xFndgmjGxUbN54qNA
	41kfwH3zSA94kTQqXbdlnMxHGI+n6Z6/dWQ==
X-ME-Sender: <xms:WzfcaLJ9dEo6BZihetjKyliprhZZrdqgcHGgRDiSUraJHJrDt1gB_w>
    <xme:WzfcaGlocUoSHtqm_yDNLK04K3EJDyPwABiZJFRpmacRfJr2eYCzu8P49MW51Svbn
    FD_PxGgomNlrXIkNe_hs3b0YysDGqiJha0-6MlaVDVbMpTp3Y1pFts>
X-ME-Received: <xmr:WzfcaBHTYRlmRZVRKXl3yW14sFfmOB_w_MbeQaX-AYCMUxacjxsuj09WOWGpNQUCwQC4E6gFhnuOe8Zmr4dV_dZHx9vpzxk5w9US>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthhhrghrughinhhgsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WzfcaOGnvuyTIE1E8rQeEiXkSnFmZAhh6ulvIBRe7oONnXB6Y2i_Ug>
    <xmx:WzfcaGMcz2MgukfHTJBMQS9RrjFbdfTa0JinsMQBNcdJHXtEGKzRSw>
    <xmx:WzfcaFGJhaJrzs9doY5iUu_ZeeXJpC9Zv93-x9e1sy4E_mWi2eLPTQ>
    <xmx:WzfcaFNHuW4zJhgWRRRdPR4lGjH3rmsbUgCq9hPblf7svBh8RUn9iw>
    <xmx:WzfcaOlPRTVrbDZs1vn2IhbOGPjwyLetPjJFlGQPGkclNxYRe2mu3oke>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 16:02:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Stephen Harding <stharding@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: I still use this!
In-Reply-To: <CAKu9fqx-fkOmKLby0mWU8D-T9vL1oY49kVLN2zWwhyfTUKSPsw@mail.gmail.com>
	(Stephen Harding's message of "Tue, 30 Sep 2025 12:49:16 -0600")
References: <CAKu9fqx-fkOmKLby0mWU8D-T9vL1oY49kVLN2zWwhyfTUKSPsw@mail.gmail.com>
Date: Tue, 30 Sep 2025 13:02:33 -0700
Message-ID: <xmqqldlv4skm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stephen Harding <stharding@gmail.com> writes:

> I just encountered this:
>
> 'git whatchanged' is nominated for removal.
> If you still use this command, please add an extra
> option, '--i-still-use-this', on the command line
> and let us know you still use it by sending an e-mail
> to <git@vger.kernel.org>.  Thanks.
> fatal: refusing to run without --i-still-use-this
>
>
> I use oh-my-zsh and I rely on the git aliases. I used this today:
>
> which gwch
> gwch: aliased to git whatchanged -p --abbrev-commit --pretty=medium
>
> and apparently you want me to send you an email to prove that I, an
> actual human really do use that ...

It is not about proving, and sending an email will not change our
plan, but it gives users an opportunity to tell us a use case where
no possible workaround exists, which we haven't anticipated.

You can change your alias to

    git log --no-merges -p --abbrev-commit --pretty=medium

and should get output identical to what you are getting.  Also, I
think "--pretty=medium" is the default.



