Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7E21F03D2
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 01:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766714372; cv=none; b=mDhuYFwaejRV0Zt7lLk1cK6YohKyLIRaXYTXSOzfBaKeIMcx8hQTH2ZIyMeqzY+CYtp7Itp8Tq4nmXdRUDQg69PV7rWb+VFkSOh4IPXnzq73pTTkVp7d9K2hWDqYf5xeNTttlWXcBFRM1/OYq7DPkpuO4tmTTm5larjkGW1Y36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766714372; c=relaxed/simple;
	bh=rMtw6rdIkougvNVL8R0VnOCX4iYnMkQPv6MbSLppfIk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NggfcOIvLKYb4oBwGkBgH4P1H3Yg+zNHYdR+6cN1KiPISlyjFdwgsATVbN/k1+3RJZ8pGkum5j4f6e2r6bT5wpDyR7Z2wwUT8/5iP+XtNl6vuTs+nMpUzvG1ZiiHIaol6gG2LMCfDaBPNkLDPuCq/xJLh/XXqYOAA9qEyNTojNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NAER/jOy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HjEDIz+I; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NAER/jOy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HjEDIz+I"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C42151D00031;
	Thu, 25 Dec 2025 20:59:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 25 Dec 2025 20:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766714368; x=1766800768; bh=rMtw6rdIko
	ugvNVL8R0VnOCX4iYnMkQPv6MbSLppfIk=; b=NAER/jOyk9fQWLF7Tlf2SuQ3P5
	N3gsPzhJobSkWzvGS3il+UNZ+SpEdhks2sW2WHbrebneMIsKQegVugn/j1IMR6ni
	unfLE8QV9gpj6+2JgoPVztSQIJqShtKxPyqUGrfgx05sGKal8zfylthVt9a7igH2
	BgrHJ4YR2DR7mxGXP/RVQDa4Gd0LgGIBi92Rm6OaHxIfaA2qtPMGlk2jLXfk7LYT
	Vo/nYJ6kTRjCHnQ9PFA9FoFxu/m0WqaRSsW/ua66+dRVb6SQApmlZcKmkVCzKjjU
	bLSCe/JFqY/R5rJmEW1QQsXVreD5ROmTLjqQXxkkt7xJhdWwh//0PpImn93A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766714368; x=1766800768; bh=rMtw6rdIkougvNVL8R0VnOCX4iYnMkQPv6M
	bSLppfIk=; b=HjEDIz+IaEb5577fBPqbLLsX7UAkn8I86aZZ5nhsnR/VSmdrjPp
	BHO2mN9Nw95FcCpPJ7L/HxFSeWXW6xkJqdrKK9ZI5DQqFuCw+1rTXOpbmw30Lm4v
	bJZRql2FYXIMifeZ/JSCAQoEw+taondaK+BM5CVlMXaUJw/tR3GjuQ8xBV5Z1U3G
	lPqnmb0N+R9NRcS3SKyReSS9eesTkTn2iHqwFfybutHpwqCdUBIoSWHzHUTREjVq
	LuqECR7HlRlaypCN7Sp7ttsSyNPLPoT/JpvgIrfqrYOfbysjBUkvj6VhPAO8ayMf
	g4oZewUkqEgWCoiWEGIdIlkZSvjRGS+Gu7g==
X-ME-Sender: <xms:AOxNaZ5Wdr4zW9swZOgBPsY7fhb0nPiafJCC3I3l_Ki1uzr0P46JMg>
    <xme:AOxNad6VC6v_eS9SVw_-9OET7O7i7WXq5TZ3y1FdKrLvsNTMP92bBbhmcW65KMxoY
    3PfZWQsCku7tgl2IS2k1IV0xt2YrCFXUmQGg8WYkD7ZG1GMKakYWg>
X-ME-Received: <xmr:AOxNaVdRJldnJXBSblu_ZpZUSKxqo56b5tI_NiXBp7zEAdEaPFALrApnhg_yT-A3NmZUOhzbiJntbFVh94eJBPqP4M6ErGxN7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeijedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:AOxNaRDauM87iLA46mSco2IWRb393hBM4skB5RylkodaI4OkCJ2t5Q>
    <xmx:AOxNaY9uoBkaUfYBA1Isa3mADJ2KHOVM9Ca81zmC8QVqrHIBljk5Mg>
    <xmx:AOxNacLaDUnSPG-8rhMHB-iPP6_EFnCkHdnFizuh0ixc50trMRYkAw>
    <xmx:AOxNaRiEM_w2kN96MaCDeT7uUJ7AueOiFvg75XyeR5M2gD7WnPBX5w>
    <xmx:AOxNaU_qpEzHAjti07br6LxihsR7YXScaPV6MvqV0ThRhMZ7diKVD6kb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Dec 2025 20:59:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH] status: show default branch comparison when tracking
 non-default branch
In-Reply-To: <20251225094556.5944-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Thu, 25 Dec 2025 10:45:56 +0100")
References: <xmqqms37m1n9.fsf@gitster.g>
	<20251225094556.5944-1-haraldnordgren@gmail.com>
Date: Fri, 26 Dec 2025 10:59:26 +0900
Message-ID: <xmqqikdum29t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Got it! I'd rather just squash all the commits then, the total diff is
> quite small still.

Well, that is quite different from what I meant, but let's see what
others may say.

Happy holidays.
