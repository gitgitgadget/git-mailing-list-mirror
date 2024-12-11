Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5B58632B
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958591; cv=none; b=IfjQP2DRqhyO35I1/iLRtnv6KBjro/c7xioJuX91JJVr/8Qqirn9ps6SZ6e5V47vfTWNHyp5JRUv3OPwWBzxXtO228tXWdAjcnsHwA66Zed8nbmdPGLxaDDbLT8L9GGWfY4/3HmhB00KA62M03ho8r+iVAzU4m1Q9Njdhv9/85A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958591; c=relaxed/simple;
	bh=NnW8Cr1KD76/snenK9qnBKsI/56dn6NRFHqsDKzdf5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K7bAkR4nW8XY4l+ouQnlbmtcVyVTw3wCXjSNA2apC1nR/buo9FhWVrNv1jV1BprCHtKj/UES3IqojTCjLRlfnq/tTNoSkB32jSn+WfDrmcxG4GWmQEYEsKbqJudPDt1UEQbr9DIsFBMzTts363pc1KPXQdUiXWMhv+ViVz+xbfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L0HhpSOS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pdkpIcmJ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L0HhpSOS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pdkpIcmJ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 18A001140170;
	Wed, 11 Dec 2024 18:09:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 11 Dec 2024 18:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1733958587; x=1734044987; bh=UE+JEr3qvH
	NXrmcegWLYFktKBemq5Hsli6lk25ggckI=; b=L0HhpSOSqVeK939d3Ip8PxtLb6
	N0z6llJCHHKR87M3xVnAujhAzHj0vx8seDTPePSTy4BtDYoCgcICe8rjRBaYSJjv
	MDJDysh76+qHIvJ5o2PMFVB7/Sq9nlL7ZFAUPTLR6t8N3k58kHchFE6qgAbMR2MM
	b2tWCQGauvvL2/xzmbpGasSXdNoBc2ydFvSHWBH9vHe3Fp/Nyic0LmvbdkclfM4k
	aFX9XvWL3zXh2Nfg5CZpva2mjbNSq/iKPujYeKNKTnHqEqJyi6iJj+X1vGobYJ+i
	V9rMNG5JmtHJN9IpT6Wvl2CGaTX0HFtZNwBnSG4mNd7YGJeHeLMLbBFQSSCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733958587; x=1734044987; bh=UE+JEr3qvHNXrmcegWLYFktKBemq5Hsli6l
	k25ggckI=; b=pdkpIcmJ7M9Xe9D6u2xntx8wuuvnxddYk5v3/h77nZKrYdXQIWe
	FL2N+HIHYM/XjrXha8gGcm0qYb0WGgib4GkY4QFmNxez9rwXHvgoExWlO4ylfL9c
	rsUW8Qresuj2Zb2Lj9G9mD0qFRiAPJhF2sYFGtx2mRIbzVAaVR7uVw6AhMn3w6qC
	cdseTk1daSuYUwbZV8RRGtrmEwshJorT8H3mTz2XzxKBJYHcDEyySO3tjZiemV9D
	1EXoHUtTVJeQYne1nrmdbLCfgFX0xDRcwbb6BmMLcjfdlVE9nIG0ItJdKZRHCXDz
	LtPHRgX4sRrlWrYfhjfTf275PIjyoDg29xA==
X-ME-Sender: <xms:uhtaZ2BaQw2zwPXEh_fqrfumJDcBdDrAT72app5tfKN-JjIxbK9fyA>
    <xme:uhtaZwjXVQF-GLhvnr35dcQp770rY3XKCak4LBKL-uaHY5ldgtCzKX0_4pomHnjT6
    1Scnql2mEM3F5VqlQ>
X-ME-Received: <xmr:uhtaZ5kWftOXaBgwPw0jsdvRXacqq3l_hh3VzVwnNtxOXHRj9dhKioumEDFcS2fFgqH5Mm8BUk_vSkpgaqWwfoigaRBI2LjN-uCz-nI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedugddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffieejgeefhfdt
    vdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnh
    gtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:uhtaZ0yB7BwFvZ50EYJf-eui_GDqdJ2VJ9D1C-Ymqtz9evfA1LcDrg>
    <xmx:uhtaZ7QZMSO9KsYpbjPbMEpuiECam6n540d4T-0_BAPpYyJuN2WN9Q>
    <xmx:uhtaZ_ZF1mM-G_brRUORYL_uX8WNRaOcPM5svg_EA_iTDHaHyttEHQ>
    <xmx:uhtaZ0RffEqBjUMsIqzxxVj9YeTNS0zMnW_qlUbrCfpgg8kR1t7XLA>
    <xmx:uxtaZ5MS-S5EzZIOl6Zg9vA-SkWfm32Be7WnBP-jSKuSv4d8HKjZIsIg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Dec 2024 18:09:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: (RFH Windows breakage) Re: [PATCH 0/3] Remove
 is_bare_repository_cfg global state
In-Reply-To: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com> (John Cai
	via GitGitGadget's message of "Wed, 06 Nov 2024 20:47:59 +0000")
References: <pull.1826.git.git.1730926082.gitgitgadget@gmail.com>
Date: Thu, 12 Dec 2024 08:09:45 +0900
Message-ID: <xmqqzfl1hl52.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series removes the global state introduced by the
> is_bare_repository_cfg variable by moving it into the repository struct.
> Most of the refactor is done by patch 1. Patch 2 initializes the member in
> places that left it unInitialized, while patch 3 adds a safety measure by
> BUG()ing when the variable has not been properly initialized.
>
> John Cai (3):
>   git: remove is_bare_repository_cfg global variable
>   setup: initialize is_bare_cfg
>   repository: BUG when is_bare_cfg is not initialized

We've been seeing a job "win test (5)" fail on 'seen' for a while,
and I happened to have rebuilt 'seen' without this topic (first by
accident) and the job started passing.

The topic coming from GGG, I'd assume that it byitself will pass the
tests (including Windows ones), so I suspect it is some interaction
with other topics in 'seen'.

As I do not have Windows environment to test and dig into any
problem, often pushing 'seen' with suspect topic(s) removed is the
only way for me to isolate which topic might be causing a problem,
and after doing so, I'll have to leave it up to the author of the
topic to dig further with help from others.

(failing) https://github.com/git/git/actions/runs/12279217687/job/34263221584
(passing) https://github.com/git/git/actions/runs/12286174648/job/34286039276

The difference between these is that the former (failing) one has
this topic with three patches merged at the tip of 'seen', and the
latter (passing) one is the result of tentatively dropping this
topic from the CI run.

Thanks.
