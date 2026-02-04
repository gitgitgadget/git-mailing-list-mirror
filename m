Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0860838945D
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770247402; cv=none; b=IZJEg4YFROF8p1Q5LN9MI1O3U+PSb81WyemNCEhAiRnYEqJOKSHztl7+zapo3lduU5U+8RtPj2XvU2/iBobXAPVoJpWp9+dwNdzRB1pMbhF+pEzLSwpSMP2H87pg8Ckr7/KxB/jJLj7ywmeivF8f61oiujlS55VJJCdlxNFAmSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770247402; c=relaxed/simple;
	bh=B4tk90x3+XSPdzNP6ymSf3r4GPgZTzOTkFcnwNoA+9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QuY9t/UkwnBsD7EKUBk4mjVfckAV8At3ZakjGO7dOGD96LWhtMTtbwk2YWz29BK/1ZfLhUuZOkQRI1gDLuMEDozKsMe7HhABCgCPd4gF62gDzHeWw7qazwCP9+dMubdrjiWjXRqVKUO1eAwiWO52yuXP4ZY/96tZwPp/E1orjLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YpJCs03S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HTuMS6ri; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YpJCs03S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HTuMS6ri"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4622DEC00A9;
	Wed,  4 Feb 2026 18:23:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 04 Feb 2026 18:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770247401; x=1770333801; bh=B4tk90x3+X
	SPdzNP6ymSf3r4GPgZTzOTkFcnwNoA+9g=; b=YpJCs03SaPOl5WkYCksjwmxVZy
	gH1rjWsz+3I6nDoIX5vAt4FeuZ9s1b6moVoE0tdvMtTa+mV5jWfG3x6VcId9afF3
	3u8oil1XembOqJ+wiiZgC5jTN8Hnavkzl74ieZxpgbpIMXtctqzkcg3+odR2H4M2
	R0GtVj5voOsrDG6qdDudC93oPvOtx8oXCCj6ejyfbcj1VjKpBgP/dhhZV6R3zIok
	kC9aYq5U2GWelAHfymx3YrukOpHCWOL06J7lG8DEzRo7Bl9+Vw5Vozl4QV8V+vQR
	SpZJjhSw440J+7z0Uew/gwVZeDsHgHC/8dKLYJ4fLP97ZVSJJT1XT+Xf0D3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770247401; x=1770333801; bh=B4tk90x3+XSPdzNP6ymSf3r4GPgZTzOTkFc
	nwNoA+9g=; b=HTuMS6riwpzfGt63Gkldrooy68RD+FWoB0A6ClzhgeFFONDQz/B
	MMsmYaDT1iKdRI/Y7X6J4F00MNNSFU9kJSCBIuSVts5rwwZnB80ZzsOImyekvKke
	OpTf6DH498JXbtjHTTlFfHx3ZjOMi58oCdlpxdhv9lvJOZT6utqIZEk3X9nZq70B
	IdTisHyItYQ7jDELlS/ZRaak1i6g/CpT/RtRsoW53kryYpxUUxJQzfvJn8NjIT9b
	kiXvX593b+LtfoKJB7nJG0R0G1dgO9z0XK2rryxQrqUwANBVKJ+gqyNzg4Es0p4W
	ACIfDPswOqO7c/qGRg78iLsKd+l6v16t+0Q==
X-ME-Sender: <xms:6dSDaS5BfG9vDX6w05g7ODmVwHo9cp_2r67c2o41OumABtGmmHZuSQ>
    <xme:6dSDaS7VDXjINrw_iHuzye_lXxxfZg_tsEw6rJJnESc3_IxqcSWqUxoXGoclZtGNt
    Mh_VUFhBXUUJah9FIOL8dcH52gxYivdRM7JvgUz_JgHAgCCf7UL>
X-ME-Received: <xmr:6dSDaWcmvWN_P0t87R8WIJj3kOpaNf571QlpWAQzRjB8oWlRhcedehfyonSCV8243HfSehzbJ_VYBVlOH2LhJIs95pkkPn-Gww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeefjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:6dSDaeDxHfqNAJe-tqXZMe530y5QP3xHNfuVLbJ1WX1nUE3q7V9llQ>
    <xmx:6dSDaR9y0E3Zc9x_tsD0RqzA-Pl6QJaJ7k3cpgy801OBX70WzhbRNw>
    <xmx:6dSDaRK_cs2M0GB2aePzOfoxOZaM1-grFvxupgG-qCMtO89TjMfkBQ>
    <xmx:6dSDaSiaCNos68hV5B9JfE9VRD2sxlYu3SWAIQmzpvWKhRQAN5HeAA>
    <xmx:6dSDaV-zIktIF35ZCJwaRtd7c9rwJH8n3rHVSV9qO0LiYyYwjLjdcMqj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 18:23:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 01/11] config-batch: basic boilerplate of new builtin
In-Reply-To: <c4dab0609613bc5d43bce705dca2f057674a5d5b.1770214803.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 04 Feb 2026
	14:19:53 +0000")
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
	<c4dab0609613bc5d43bce705dca2f057674a5d5b.1770214803.git.gitgitgadget@gmail.com>
Date: Wed, 04 Feb 2026 15:23:19 -0800
Message-ID: <xmqq1pj0nleg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> Later changes will document, implement, and test this new builtin. For now,
> this serves as the latest example of the minimum boilerplate to introduce a
> new builtin.
>
> Recently, we updated the comment in builtin.h about how to create a new
> builtin, but failed to mention the required change to meson.build files for
> some CI builds to pass. Fix that oversight.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---

We have had a bad reputation for having too many commands; would it
be better to present it as a new mode of existing "git config"
command at the end-user level, I wonder?

Also after reading patches for a few early steps, I do not quite see
"batch"-ness in this protocol; it is strictly "a single request is
met with a single response".

