Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04CF295DBE
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420783; cv=none; b=bSDLp9gms+S3gjHOO7NA00k1hM8jXP5jyxJa+MtpO2XsVQT3p4CkncPmKLcDChGUm8AvXLFOkfMUtK0aMmsOWsbBmwEjhFk87t2q0OZaL+9OJetTh0qjI85+E8Nd+soZXp5XnxNLF3jpNzln9AosH5AVKuwtEsCbcokoFhHsdM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420783; c=relaxed/simple;
	bh=khSDThI/HlJ2QQk+JzcsPBD/0+sp6u0q60EjQQiNyAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OVyybsheVEfC8qk9X1ZiMCX/BWCCODSPAnHMaQ3JZwcwlVXmdkDejxXUUSuhLNacifUar1aY64WqEzZbBtOv3JLO7O1ptlwIFbmcn4yd40zoi9DutJ+DazIBh0HrFqrcQ0wpJCQpTGs5fU0cBGhll390gm5NVsXRBP99HHTNY1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VCgdJ6qz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vp6AtQys; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VCgdJ6qz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vp6AtQys"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E8F9514001FD;
	Tue,  5 Aug 2025 15:06:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 05 Aug 2025 15:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754420780; x=1754507180; bh=URmX3xCd+s
	rfxQxJqJZx/07Ncc4cW7aFauZKxMBJq5s=; b=VCgdJ6qz2aUL02swkb75ANM/G3
	sz8dzVK3bKlrW005vHAkiCsx9yojLerFeV4OQgPN93YSr9fV3skLHyZe8sOWQf86
	f0slsigXXJarL+xF2QtFKG4gvAI10glIF4iw0wgDSuQO2w22T8Bne6PajTJe4uap
	ihZ9hNGXtFR/oB6DEgY1fEK5xNcp+bpj++0d3GLJCGb1WUHvqbscZQsOR/pQGFnh
	mEw5wwNCUrAAzCPgc8SsQplHjUIAK0gl1u7EDiecQPQpIaUCLzo+qplf4fq+qDGJ
	F0FnAMqdsvMjB2tYGzxOFfNVjFxPVnzyRYfClJK67bhego9rLJjIm1JxJiAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754420780; x=1754507180; bh=URmX3xCd+srfxQxJqJZx/07Ncc4cW7aFauZ
	KxMBJq5s=; b=Vp6AtQysv+1nOOIfzSER+tvPpCCPNjSyAK4qId2VR13CYkeyTeo
	/fTt1Yq9XkL7sKbnI4KphEdC5lUPR6lUxvjKu0yKOgO5yPK+yMrtC2FTiEjv5uCK
	05IzkjQZPryb0AwnDG/r/y3XdOFR/HgDrQraLiwEr7x33Owpf40vpB1m1YIQzW3+
	2+REpwixQyrlrvMUr416z2JZ9WRlEX5wGmZNMaWw/ZXfF4QCTEb3116cz+HHjfFt
	XWE8RPTCVhPcIpMHhA5/ZOqh07Q0p/5u+Iv6xZZPoDZkLCQdMBg0smFQB6j0lDCn
	ARoiO+XqjNyH5QaRwk5imXppzmrSydT+ShQ==
X-ME-Sender: <xms:LFaSaGUKPBA7wWMNARHWnqIhjW-2deprGfvdc5Cm27RUtpnYjOllvw>
    <xme:LFaSaNI47XNPVvPHRJT5Cngy0zGhLMQWXw2liGWKHK275VIIPmg9XMcd0h3qmx2BM
    W3LdeGiufDFHNQdsw>
X-ME-Received: <xmr:LFaSaG_rxdO5uWqSVxG_yThFHT0VG1T3ME6diFcIbb28u05zGDZxRv7PMOLaVHnOyfw5T263ZfWsKkg3ckwwL4i0taWPDjP2-S8Gs5k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    uhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LFaSaAIuYPYwUCtlq9e5IAZMLzk71faRXTdWvBo05TNHc7DJ2-accA>
    <xmx:LFaSaLmwt8QBjMzcZOzUm8tfFujg22W11gzMjV8VTuBojnsW6KXchA>
    <xmx:LFaSaEOIc6uogm6qD0nLStAL1eb4DXRCy8oKwbAkUFOI_EtshlURww>
    <xmx:LFaSaB0djp_rzQDxBCjFfpVSFqFm_VHkjsznA3jvwXVZq11MRrhjqg>
    <xmx:LFaSaPkZlfF24yeVPihjuv2QlyfF2WAp9sA6IBZKWIYbb4MNMN96t7Jb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 15:06:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
In-Reply-To: <CALnO6CASXHv_wwmAfn9tZ4D1qdJBgVKfLEQ9+LTEF9FJPiS0qQ@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 5 Aug 2025 12:30:04 -0400")
References: <xmqqms8fbilv.fsf@gitster.g>
	<CALnO6CDm5n0oZsXzvKz89jVg7E_h=1gqPFs2x7-UojdcY_Di_w@mail.gmail.com>
	<xmqq4ium3w2x.fsf@gitster.g>
	<CALnO6CBLF2Zxhy=mvz61U7M3X3UNA-V8R4tkzOvVjKWpEwi8Mg@mail.gmail.com>
	<CALnO6CASXHv_wwmAfn9tZ4D1qdJBgVKfLEQ9+LTEF9FJPiS0qQ@mail.gmail.com>
Date: Tue, 05 Aug 2025 12:06:18 -0700
Message-ID: <xmqqectpziz9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> With apologies for the mail noise, but I can't seem to reproduce any
> failures here on 371c45b569 (Merge branch 'dk/help-all' into seen,
> 2025-08-04), which is the latest seen I can find.

When I report a public CI failure, I'd try to give an exact URL, but
otherwise the failure would have been seen in my local environment,
and because I tend to refrain from pushing out a know-to-be-broken
tree, it is unsurprising if 371c45b569 did not fail.

That commit does not have lo/repo-info, I suspect.  I didn't know
exactly which topic was causing, but the error was observed when
"repo --help-all" was given, so perhaps some interactions between
these two topics.

Thanks.
