Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B930527FB21
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836742; cv=none; b=J5fEkhj3itYGZR2ln8xAQBH+6Uz+3tmrfx9UzfUSd3VHnNSp4fg7qcI9c6CBCQCwfLYYFi6rUAZK3bSFd2yfxJkV5xOAOfc0ZPb9L1s9164+YgssLG07AnUbeEFTaYzsMZH52SzgggzeTuGcNsY6kLIg90YluCk+4imSVttOuew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836742; c=relaxed/simple;
	bh=SdwzjCXnZoTqvOopyD7SJ61iKPU5yCLbnT3Ww6n80wY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FX5+bMY8MRPN1IZ6LqXxNq60KT/VENpceCkxAevBAuus51K6iD7UxQSGGUMzx28gKS34L4cHsHFnN/85u1PPSyqTwDtUpSpvgxY7G8cqNS73SPHt2XlO/nVRHtWq3HJUWOwG4UuZyOPKu5/9y1wqgWBh7bzCSrGHo7ZvD07784A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=29xPzhZY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lndnVTdV; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="29xPzhZY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lndnVTdV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C881E1400096;
	Thu, 25 Sep 2025 17:45:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 25 Sep 2025 17:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758836739;
	 x=1758923139; bh=H95hzFULkWLweOHH4Mek/HSOYm9MVZ4H3gjHjOQBJL4=; b=
	29xPzhZY1KdEy9AYZDoUOgfZNuIKxw7S+fJgwh3Rkb0Hsy7cwrtl++x1nhiuK7Do
	0N7HZLUn3fkxRSqkSf/nSLzIeexmRZyvVejavUgCYF9MgbrJsfWIbtGlYa3TYXfP
	COVukioeMhaLmh9He3FDS5z3Ab+RBcznSNV2JsE4y4RZxgeIvMZH0F2wFN9ZbjF4
	+RJEpoc3Vu1tkrTcDOVjgCZ1l+oiwlpP9fy7Dd5C7uZ8gIk9bnd1Ab6DStQrwvgq
	uxSYNRapnW1c6v2RcISWj/zvJLiRuR4YaBHSN18HXCpYATwV09eS7ZWQ61IF64zo
	Dj7kXvmpx/GhYyuC8Fqieg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758836739; x=
	1758923139; bh=H95hzFULkWLweOHH4Mek/HSOYm9MVZ4H3gjHjOQBJL4=; b=l
	ndnVTdVlqb7pL3C9bVMXAfxJ8k1j0CMcOOTiFh51nEk9hm5KWqUCN3r+8071Npub
	oiqVU+O/K7kgDTz7QP+MvxHwbVuRjiE0HxlXMLi3H3IWfjFHu35uUfe1e0igZBsl
	BszA54xgDAikkb3p7GS9zucZ0YQiZzFboPWpiEmXzDJmUbJmVkbU8J2HRXR4BASb
	i+RaGxVbbZcik3PQlrvQlBOpJEiSouic6aI+EC6AtwJjEDGdP5xTfr/UU3l0YxxF
	dKw5wvRaVchaN6hUfTZbtaYD+T+wkVj+gSTw5FvVbFazSiClJ2eL3RjOgHY91etV
	dCxw+LnR9Oi/C14GduSdQ==
X-ME-Sender: <xms:A7jVaLG97PGuEuXLabxEQXee4bG-gZNZe3huYUDE9ShVAFeIVsg1mQ>
    <xme:A7jVaHbFzp94MCfAw6H-y2-EahgqXdxn0yycglz_oGv4oGsTun1hG-rnmO3YKAPKC
    GjfdairkZsTwfOT2V4XiYBmR-d5vXluYibVcJ6s-J_Zyy7XXf7d9w>
X-ME-Received: <xmr:A7jVaDXVxsAzQ66UIdpdJttfhGdsGMqihZ98UF4i90Ml5Zm22IOtAVRMnQmtzK_vLMv-kD5hodkhLqj9B8fD4wJDVIDU3xQXcT87>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:A7jVaFmD-6-gczkmmN60E17F4uEsgFH8xgpZEJeogwVxRtYoBOxzyA>
    <xmx:A7jVaGBxY1KuxU-CY1GXxgk8_jZCFODAx-4Yzp4frv7gdeA7dkd1TQ>
    <xmx:A7jVaMiDaxFw_ne1l-t498zLZDgwL6In9EFOLdvDF8kG7lltVV8T9g>
    <xmx:A7jVaLwcUHKB6IYAiQcy6n1OtvIlwzNriiN4gdLpLyoaYtrH1g7JBA>
    <xmx:A7jVaDxCM6oi-ypqM3WoRrcdk6ea2rGClFIWCpPXIc_ywYf67rFA_GFv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 17:45:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Patrick Steinhardt <ps@pks.im>,
  Josh Steadmon <steadmon@google.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 05/10] reference-transaction: use hook.h to run hooks
In-Reply-To: <20250925125352.1728840-6-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Thu, 25 Sep 2025 15:53:48 +0300")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20250925125352.1728840-6-adrian.ratiu@collabora.com>
Date: Thu, 25 Sep 2025 14:45:37 -0700
Message-ID: <xmqqv7l6dx4u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  refs.c | 61 ++++++++++++++++++++++++++++------------------------------
>  1 file changed, 29 insertions(+), 32 deletions(-)

Please describe what is done, why, and what benefit we are reaping,
just like you did for the previous few steps.
