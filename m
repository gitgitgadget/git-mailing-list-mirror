Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCF71C84D0
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309051; cv=none; b=EHpm8dmWIC3v/phvaApRjCl+PJAtsDhL+2X1deiSNZLC8lEkpMPVRHBBxZjejN1/VhOA/mpvWb7j8Wl2Y5y3REqzLy3LI0zg4nOe7wdGBzC0/QW8G8yCix3lLIq/Q+n3Q/SwlVtppCVP0Y1wIa/0a4K5J/+G5lTXukTD3NxLPtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309051; c=relaxed/simple;
	bh=w8lNqSh6TWuJz8tihsgybm8vASDKEroETtSRxwLbEvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TNcxUHA9wuu2QOkPHENvPMfWBw8qo3hQhlKOgb521hX0W42VVd4I+gZbDPAq/Bw1m4RxUE4o3SLyPUILxEEQs7e9FR8N25m6asns1JuLpWYiooNgpeZVxa/IEW62+0T7pKlV8Vq4XMm2Ov9Ajh2aS4b6ocZ1d+bM/5MMJf59fFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ne6lUyaO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oQYgSj/K; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ne6lUyaO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oQYgSj/K"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0358B14023E1;
	Wed, 23 Jul 2025 18:17:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 23 Jul 2025 18:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1753309049;
	 x=1753395449; bh=w+WxgfK/rOXdda6axlJoczLg9J2lA14Igia7IUEBvts=; b=
	ne6lUyaO3pYK9S7N1xO2m7xh/lHrNev1q+nkMyyPrA8BZMUAZEERXy9TDC7h+Xrv
	u9XpTl18yWVPyR2eYuRr/Wdo4s7z5B8DbIEAPljHJKvbZHkKxm7tMmuSu5gMulSO
	wypLCZADQCurc+W5Q2DPysCf7ede2nonWB+omlleUwvsDbTd6FtnC1/JzoxxeLjB
	9scQSNUpMOq4X3SmN0N+QBcHWCHwUDAS29PSm2IX4Hw/zHbwuCJJDCR6gGPsS74K
	N75lq2dMLngMU3teRkrsr1ZqBzi3klRgLLDu3OwMW6lUvN93nLhXf3pKG2vZ4sLd
	BFdiG//Tagmnhr9wIPCGBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753309049; x=
	1753395449; bh=w+WxgfK/rOXdda6axlJoczLg9J2lA14Igia7IUEBvts=; b=o
	QYgSj/KFkPEu0Npl1CW8qE11MRPLPtDRujgjbXqViBDBz2uo32WXAaTs2Ws6R6lK
	D9RIcH4nkvyJQhGfNGYEzUzGJ3MUlqtsOpBJDlOTJDZykrFxTIAab3iBevObUCAH
	yaLRRw3nvaqciBBB+tHbTPGMS6U2veixk/rN5IoJdN9zOFghwjIomogp/iPibTAx
	+Ih4eQXPCMECzyzDMpKYQK5EReNq4ADX09cfo+jpyt0cFUyoruFwPMcujpFIkQUw
	Q+C4QFsWvtALvFyEPOzOaKE8TbZ/+KdMh6By4dJKfKcFyEj1QIrsl47h6TUHe8+k
	SFEIXCMHCAN3Bmos8xYZg==
X-ME-Sender: <xms:eF-BaHj-0tsQ-X8aeYakJiMwwVpARIAcx8RSmCDij7Ep0Bht1AMmaA>
    <xme:eF-BaBkFWrvAYgiWLHVo1s3_oEO5-VJG1Rs4uX7NnfqL8KGkEJHxcx29JR6FV_JvZ
    rLzWrwpDtwiuAANRA>
X-ME-Received: <xmr:eF-BaNgPpJVqcFx0hNue5cbUf-qZHU_LmRb-K7pyUbojks_JitZ_ngLwa9Uq_6Ke2owslaiQ2jULsOzVcDz6m_tG8C-xqbwluomF1XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:eF-BaF2j60-QpkCdXeE9hzwJpk66GZMJFjyEwd_sP9-GtgfPYMkCfw>
    <xmx:eF-BaGJ8I04gURWsSXU1vRmrtWECdco4cn35A2xWW3uUSfnuY67vaQ>
    <xmx:eF-BaFxdDkEwLtdG7xnait1IsXYyJl4GIl-F_MaZ41YDXs9T1nivOA>
    <xmx:eF-BaEVjNwKAz6Bykbv1vAMwR_3BWJ2klQ6NuLv_Hn-yu_Mt1A1POw>
    <xmx:eF-BaHKlUpKQow8pajRVO2wgbDOU1BNU47KEClwlVPiUt-_oMkIq4jS5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 18:17:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  sandals@crustytoothpaste.net,
    Eric Sunshine <sunshine@sunshineco.com>,  Eli Schwartz
 <eschwartz@gentoo.org>
Subject: Re: [PATCH v6] meson: work around broken system PCRE2 dependency in
 macOS
In-Reply-To: <20250718170225.6063-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 18 Jul 2025 10:02:25 -0700")
References: <20250716193000.44673-1-carenas@gmail.com>
	<20250718170225.6063-1-carenas@gmail.com>
Date: Wed, 23 Jul 2025 15:17:27 -0700
Message-ID: <xmqq8qkelfgo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> macOS provides a PCRE2 library in base that is not usable and not
> configured properly, as it installs a pkgconf module that
> points to a non-existent pcre2.h header in /usr/local/include.
>
> Detect that case and if the feature is enabled, try to fallback
> to a wrapped subproject through an anonymous dependency, aborting
> with an error if that is not possible.
>
> Change the feature to "auto" and print a warning and disable it
> if a broken dependency was detected, but to keep consistency
> with the cmake build system used on Windows, add a special rule
> to re-enable the pcre2 feature by default there.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Suggested-by: Eli Schwartz <eschwartz@gentoo.org>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  meson.build       | 28 +++++++++++++++++++++++++++-
>  meson_options.txt |  2 +-
>  2 files changed, 28 insertions(+), 2 deletions(-)

The thread went silent after this iteration.

I _think_ it incorporates all the good suggestions offered during
the discussion on the previous iterations, but is everybody happy
with this version?  If so, let me mark the topic for 'next'.

Thanks, all.
