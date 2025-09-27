Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2498714BFA2
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758990799; cv=none; b=oJykh6K9TuDKHYNJtggXfjswZw+9hc8Iu6Kq0n+bmXFNRo7YFAyuOY9/xCwIb13sG3Pejw/xXysltM+CrpRA0jLlKq5le85uMwHK6wpuCljScyjH4PhlyvFR4Yaglqz4yG/ciFDa1MBNwI+EryBLWJDhSXYxr24SFYGEMBTrd+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758990799; c=relaxed/simple;
	bh=xmB81VjtsIhGYJk+1kwUUqFVg10GvoRJFAKPcqgIz1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wd4lceslAr56+7S9CaPXvFGEeueYRDKjGbZCa2IpfIpi1Sfy+/9Qbp4QYATRJXEQpMhzvXhjHY6e8xCFLUy+7eRp27TgIal/UanQ8ZMndgP6BhI1C9teuNbPB1QkInprCOwutORFeyJGtkjA1Yui6oLKxzV6HOUX2q7Og06DZEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PGP8tCnD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cH/6Jscb; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PGP8tCnD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cH/6Jscb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 35A2F1D00068;
	Sat, 27 Sep 2025 12:33:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sat, 27 Sep 2025 12:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758990796; x=1759077196; bh=YOn02wqOFK
	TL4gARhPzcxZaFA4IeUwxU3OdsC2gE28Y=; b=PGP8tCnDqEB2Ycah7mYJYafgRC
	mcQGzJTqRlcOKn60xMFH5ZLL/GuNfv3CgCyjAUyTBUsuUfwfjCCmsLbyTP7WjEGQ
	PEwV0iaz3ZNj6eJkfnIYf5BCA0qh/FuFm7v48PzctMk2F/aLwR3OQNPjl0cfZ2rp
	WG3YG66Qk+SmkfWBVsZ3TEchwAhHvonimMljTxA/Pto0DWEyj7/P5pGXV8/CRNMF
	fJeAfdzb24qrTadTWEMPldri9uD+riqNPSTBpDIzptdE02VVoRqGU+uDf/WWqgPC
	LJY9kgh4xbYlYYY3Cxoeh7nQdm66Fj/urrujpe7ZO7rBB7b3Jyta0gGZkeCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758990796; x=1759077196; bh=YOn02wqOFKTL4gARhPzcxZaFA4IeUwxU3Od
	sC2gE28Y=; b=cH/6JscbJL/mpVMHXfHJPgjEUmdy37hEWAQKAFgLizfVcUfFVFI
	UPsns5w5R5Anv5aVsTZQSTQMOd2cg8m4Aau+UW4MZwxIDzdZyfqwIIV40oYNnf7w
	q38jBWODB3J5oWxnlPstU7Q2RbCJHILkrnEdlVz/nGDnaHIyL4BmxQ5O4IS8uQIw
	issA2iy2LFwPli0m9aX11WuBYnDqivg/F/eFkLzdXrwflDWOGIkpTbEL5NSj4zdA
	0PdZcFhPri9sVt+QK2IEbPW1ZYSk6o9mmY4o/bNQlEUPCWKoyh801rncBGBAabJ5
	U2U2P2jHl1bu5YECP9iiVyOIu/+0JhY7wzg==
X-ME-Sender: <xms:yxHYaH0NCbI_I9t432cAugfDS6fRYDNkYZ0vxQLkzA50TjAFahR6fg>
    <xme:yxHYaJxNprzY4kqEbuwcg1w3PPC_oY0OceP0cOwV-qK4EfzwY_YE3G0Aews8sIYF9
    P2UQIplusWqaUbO5o77KhGIc4IhDqezS6QnDW6Djl9MLUah-mVX>
X-ME-Received: <xmr:yxHYaBuOHNkzbmj-2vESDY3et0unB66khhWLzoxoFUXqtw0y2Ept7n_ZGlLaiAZ7vkICwlaACsec6N-IdRukl9I8_G9yPeCgqhx->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejvdejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yxHYaDwzpmdDreAeuzJ21g_i5rz0JZs_T5yuqSRi0gYeqTGDpvoSsA>
    <xmx:yxHYaMCHkR3OeFdqmuZLGkpAJETH8y-y3EAkJQ11x73Fgy9oTSQglQ>
    <xmx:yxHYaJdrHYt1l3q-opoDBzJG6zcj6IcvbV9nXxeiFMU06tg_VHwmaw>
    <xmx:yxHYaOnvbNnIHfmfjRBdnAApmLS8cvI5lkNBZ3DXgpg5R7VHeZxYvw>
    <xmx:zBHYaI5osLmcNDi9pDU-z6IgPbc-31mAU9p9sQ1QjcpgOsyR0tX2lDfg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Sep 2025 12:33:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com,
  sunshine@sunshineco.com
Subject: Re: [PATCH v4 0/7] builtin/repo: introduce stats subcommand
In-Reply-To: <20250927145049.723341-1-jltobler@gmail.com> (Justin Tobler's
	message of "Sat, 27 Sep 2025 09:50:42 -0500")
References: <20250925232928.3846-1-jltobler@gmail.com>
	<20250927145049.723341-1-jltobler@gmail.com>
Date: Sat, 27 Sep 2025 09:33:14 -0700
Message-ID: <xmqqa52f97p1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Changes since V3:
>
> - Changed from using strlen() to utf8_strlen() to take into
>   consideration that translatable strings may have characters that are
>   more than one byte.

If you are truncating a string, chopping the tail end of it, you do
have to take into account the fact that a single character can be
more than one byte long and avoid chopping in the middle of one
character.

But your use of <utf8.h> to measure the display columns for a
formatted name in stats table needs a different care.  You are using
utf8_strwidth() to account for the fact that the number of display
columns consumed to show a non-ASCII string may be different from
the number of bytes in the string.

No need to resend, for the obvious reason that the cover letter
material would not make into the etched-in-stone "git log" history.
I just thought I should mention the above to unconfuse potential
readers.
