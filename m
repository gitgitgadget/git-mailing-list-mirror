Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AAA296BCF
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768066291; cv=none; b=kpjTNLlZX8dWTFBrokmIjCgmzix4KM4E+tPRZEAs0WAvwNP44QjDiTKpgeluaQBZxwhw9t1zRZdCVnWlHI89DRzCyxS0tvYSV0hBpteTdSjRyHgMfrJfITpshJMpZx49QcHzV4PSbLDYfysJQEyzT4fKfxNTNKIN1UJs1CmiyjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768066291; c=relaxed/simple;
	bh=L41nt0qMrn3XMwb6CxIJJuGLM5mKO+wxwfLueJ9uC6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K9hDIbJqCiP41r4hVNchWwrzEIoCY2bQeeSVQG1OkU47qAIS+/ME7BX4bpv/8PE5US/wdED8QiRJ+rd/c2GzIYNKphx/JMTAlkx7h2R771GK+Q+WAk9H35v9Fy4w3w1i7TcY132vbC1UOgaX8jZsZZrzqcmrWa52QQyk1FGXJQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dq+Kj2NJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T71ak3sD; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dq+Kj2NJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T71ak3sD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D2D8EC0057;
	Sat, 10 Jan 2026 12:31:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 10 Jan 2026 12:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768066282; x=1768152682; bh=SA1PMkqSRX
	caOOmXHgdqfWw1OnQpmRj3c09HuFCdZCM=; b=Dq+Kj2NJQN87Zmr5EeHnwqa/aT
	4E0W9g0Kqvk7T6CFarziWtk5GuokNKJNmb/jlaFJZ6nxSt5cw7v8Tvdt+2XqMQXa
	FUmcm33kTHaE3J9v5kES7InZ4UUcu0ZPVxA9zdI0EDRjuYPQI535VX/Zu1zHB1Rb
	yosJdEXQkwV+DzuMpyVweXXQdRnoR+P2Uq4UDvzAc39ZN7mP3EZZL3wg3wXK28cK
	MLji6C1fHee+wNCoS0JnBhKbDXIrOegl+k2e64cn6lPGd/oirTFX8c7AKCKHvPIC
	Y+k5E7Lb9PPvKAVpZ9Ie7pMdfT1YjOPxrF5nuAgOm/0y8Nn7XEmI/GDZSiLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768066282; x=1768152682; bh=SA1PMkqSRXcaOOmXHgdqfWw1OnQpmRj3c09
	HuFCdZCM=; b=T71ak3sDejOtNap4VENK/OESZRluapPcgbeu7ZWkFqGMIAqRc/4
	HhMBSwpFQFKRi+3+Cb+so8qNQK005kwSk2lPIax7Nd9Pf4tTjFTc+B1jNMUfvPGO
	4rJcLTUwu6eQ6S47qb6ob5ROmVZ5laKW8tUx02e4CLbZXAxTwkolalwi9BrM7tZw
	Orsu0uHhwlmcbc3IIKyqoNWATmE13VTWbINqrKXRd7bnbI+NZPuRdMkKSXq/QRuI
	2aW4Bz9Yjy5WvG5lGsbeSJTkKy4ZonWRN05Yv0HAq1Yb5/t/CLfPBSvoAiTeRelv
	ecmA0dBOkWBnK/NQbBr5C1U5LzOXbBJAKDg==
X-ME-Sender: <xms:6oxiaQ-iuCOR57W9v8JLYBVun6OKokp5J7QJCGzrf2rje3o5gDjCmw>
    <xme:6oxiafs6OeK5dp4wqSZuILf4fFMx7z-PzbDoVyh-S7a9xvhkprLiKKqJq8PBXD5qy
    9WrZAEax-IIMpyYV_uf7LSuuAG13gFtkI9TMKttemE77ayRMNST8g>
X-ME-Received: <xmr:6oxiabCsqTQ_G-uLX9_Grj1r626yY5EkcIlss2gUn0Yd01OQ9fFmvIAJYgXdkVTcoiKexCBU6Nh4odwODYQ0P2a1H-qVfiLmtMY7hMU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddvfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6oxiafW0xIigVjMHVOit7HRLE5bOO_ivCGd5PIoy5ev21-yLQP_4Pg>
    <xmx:6oxiaRBgcut1beFFf5wWclysMtUQiyC2Amoqif03SnxnG2gwkhrmbg>
    <xmx:6oxiaa-UV78Wxumlc1pEIj5UA1oI0KNSzStVAVfh5rmLTHqlOKOkZg>
    <xmx:6oxiaQGcHoOQh2UsPSFFhI6OOBKqkuDIoSJ231aVNiLfzzlY7fsbhA>
    <xmx:6oxiaeiOsWhF3Vr_zyz7AVlE1XIdl-bmnE9D69usFQYiOuyTw3DFa68c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jan 2026 12:31:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH v17 1/2] refactor format_branch_comparison in preparation
In-Reply-To: <20260110110629.18501-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Sat, 10 Jan 2026 12:06:29 +0100")
References: <xmqq7btqtdgy.fsf@gitster.g>
	<20260110110629.18501-1-haraldnordgren@gmail.com>
Date: Sat, 10 Jan 2026 09:31:20 -0800
Message-ID: <xmqqfr8ds7br.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> I can rename the sti's to 'cmp_fetch' and 'cmp_fetch_push', but does it
> help?

Not at all.  Unless the contrast were "something_fetch" vs
"something_push", that is.  And that something being cryptic "sti"
(recall my comment on it, being the name of the function that
returns the value, which is less understandable than using words
that signals what the variable _means_), would not make much sense
for the "push" direction, as "sti" is not even an abbreviation for
the function that gives the value.  "cmp" (or "compare" for that
matter) still has the ambiguity "compare with what and what for?",
but at least it would be better than "sti".
