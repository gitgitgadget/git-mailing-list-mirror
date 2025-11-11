Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433972F361F
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 23:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762904416; cv=none; b=EMGAxVKtjr/7D0dhS8pIEC/10bROI2pcmbcAffPhX1v8s0tI/NW055K8tKlMsBzLi6ZIYXFGUporI6d1jY08DmJ1XZldqvrA5/Z34Is5nVE+dcO6D1K4UOQkGP1jv9eh5b7IzpOBhZMEKZ39P9Uljj74JwzrX714h2o/HBcB1bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762904416; c=relaxed/simple;
	bh=Tc6pTVS4CBAZcIpQNzHmv2V7YPiuvzzWuKyqrJD4GsA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r9/4HgonogqoBu1sVdCxCJnLeltSXBhTWQ5S23ODx7KQHJduAZY7m7Z7ZuoqBKKoAYVuGVqrO1FUjlkkiqUMJPpkNZzGBbfEL44CGOCnfq+dgXvn4m/jm+iwCAVtzMg8Bh9raDXgDl+07tq+4cSkZ3G1Ryi8jdeHYOU3WAYFQSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bo4l6tPM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JywVw8OA; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bo4l6tPM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JywVw8OA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3ADA97A0054;
	Tue, 11 Nov 2025 18:40:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 11 Nov 2025 18:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762904413; x=1762990813; bh=DaWxGeUpzq
	kI/DgtsP+0t1lzc1pQasnH2A+jJrgMRf8=; b=Bo4l6tPMbue3PllfuRVJREvgUJ
	NFsFsFe07emzOeEsK13+e7K6rYS7UYdJmYZJHkvemfuQQAd3IuVGlVmJuCzp5axM
	9pZMl6Xl5fxYGe0iMG7Lk01chP1NEFFSXdzIMgdwJdbJ4RHmVXP0Tg7a6HS0Aug2
	dBRo5AjW+5N540Qg1dOXJv1W6xskw75Q/z6V4Y1Ok8R9RSubuk79njWcRtaMzN5X
	KpE0vK0iV8D55BHLFZ8+cURfXvtfbIyFoSm5ZEJA4B0SfPwzr4U1DhNuKmOYvaWq
	DRMdoMtoDwEstjRYDBEwbowRiGMYYTuAPyDPjHyQnSb4hWsKuTZf7tEvlowA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762904413; x=1762990813; bh=DaWxGeUpzqkI/DgtsP+0t1lzc1pQasnH2A+
	jJrgMRf8=; b=JywVw8OAVSHUWH8ncFp29SRqbZrfnkw34zts/Cjm9LLhzgP4Mzf
	8JKB3Quo40r9UljIEaGlWnxlUrAhGKJnjGvVd3rI3QiVUvsTqNRG1KpKw6S8XWQx
	ogwK+FrewO4MVjqctL0C+qJdBV0Zo42eL60eHE/bHJB+zAxx/YAWgILD0DrnHT3K
	Ngn+untVjr23cqNkqgKGgOTKiShxkZsMaxn9sGL6B+SnjhYCNHwKr1/eJAqemt50
	PahLPCaAXx4SvmrZocC3N3koDbhIFXq2vFA7nVBKvQmDWuOn9Esl5QYndsSJeik8
	27wqleSlT5U0SLZXQCckCO6OAder6P1G6Sw==
X-ME-Sender: <xms:XMkTae3dL7hEcTgYmLISTrlDJmUn-9wQJf0yGSAnw0nfCGwxZGRLeQ>
    <xme:XMkTaQJnqRgGIBhBP0DVjkm14n1CE8-Lg1MGICBPvbnIax25gCfOrHMui1-azLeYI
    RsaVcJ8uRw3TjtaLi7CHmsssG-S4Gr7YPbHyDkrM_N8cCdP2HBKh2I>
X-ME-Received: <xmr:XMkTadFlEfilmFJCXJC9C3w0W9WcgjiBLZA3wwhj26AOmaO_lQ1DJfJT3BlYsIgqsROmvR6qKEe7pFqw92RmyFCh-HQIE_f5Viw2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    uddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XMkTacU9d9C-P0dLXbNCLQhox0kLSiPAFp7UfjsEbatolKfxk2l_Og>
    <xmx:XMkTaVzZHtSrlSTPxnU3GwOs8XWl7ghG6WoLE1SbGUhSc77iGLSGbQ>
    <xmx:XMkTaRQy8xFo66MLrjYV98caWbF40vcU88jRHsBo5XGIpr2uNEM3kA>
    <xmx:XMkTaRibvSia8c8zEKxK_nV0Ex80ksnxF-QVSUoEE9sOx8kJ3UbigA>
    <xmx:XckTaZVPRUd98-mOCOOQzwVhwcE-fdmEhsRbnOZQV-05w_mVo7Vs0Ob_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 18:40:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood123@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 00/10] Xdiff cleanup part2
In-Reply-To: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com> (Ezekiel
	Newren via GitGitGadget's message of "Tue, 11 Nov 2025 19:42:22
	+0000")
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
	<pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
Date: Tue, 11 Nov 2025 15:40:11 -0800
Message-ID: <xmqqqzu4t9yc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The primary goal of this patch series is to convert every field's type in
> xrecord_t and xdfile_t to be unambiguous, in preparation to make it more
> Rust FFI friendly. Additionally the ha field in xrecord_t is split into
> line_hash and minimal_perfect hash.

After having read the series to its end, I am left with this feeling
that it does only half the things that it needs to do.  It does all
what the above paragraph claims it does, sure, in that the relevant
data structures now use not "long" but "size_t", not "char" but
"uint8_t", etc., and I do find the resulting data structures sensibly
described.

But for the code to be truly consistent between the data structures
and the operations that work on them, types of on-stack variables
and function parameters would need to be updated to match these
struct members.  As we convert one structure member at a time, casts
may need to be sprinkled for assignments to these variables and
passing these struct members as parameters to functions (which I
commented on one of these patche) to keep the blast radius of the
changes in each step manageable, but I would have expected that
functions that used to take, say, an "int", would be updated to take
"size_t" if the value coming to the parameter is from these struct
members.

Perhaps that would be the theme for "Xdiff cleanup part 3" series
that we will eventually see after the dust settles from this round?

Thanks.

