Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D051CAA86
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744152570; cv=none; b=Kvb4z4Y/gMRG6Hw1CKUCEnWdPpqrtJ42+UAHh7dZu98wcct8IAQ8hmUEepe3IU6qrWKjP0oRxi16jRGvY+QGaEHPPpezRJg9FVq57MmhTYX8jW/2aVPR8LmvQO30SBfFAXANJ1mJ42rBLBx1wWAJS2U2ytMH1NmvVMFocVxWrcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744152570; c=relaxed/simple;
	bh=hW914YkDwb3PcgjipzKYjkLlpw4wqvjEnSz9kBGorxo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pr80EvpZ01uc3arlz3pHgvR+NYCvnXgpJ9TTxcLC1hJQFx2yKrehYWq8jO7VEP+sZrt54JPEmvWFn43CyLDaNnNMyzgRRSgA4XcY+4AhZAN99kTkB7rqX2nov4r69RKaa290v1uZEy+c9BYxak8DpwxibYuyEGuBy4DbYABLaak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L28+uiLu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LaBZhrQp; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L28+uiLu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LaBZhrQp"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3A9C92540202;
	Tue,  8 Apr 2025 18:49:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 08 Apr 2025 18:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744152567;
	 x=1744238967; bh=cr5OrStKUtp3MzxuEEeDtz1Ppx9bOSU+1yvDhzq7Bx0=; b=
	L28+uiLuFXo+8ZQdZfd5HTIN/+t7cKRrFHUnrW78A1w2ljLTnrtalFKJiQr+wB1O
	NvjrYA+gDOSAtIdFU9KgxaVptzTLdmOe9jkIUJbLGtVKi6+my5/2HmRPoiekWwZB
	j1Qr9AMk/RIpq9urdghqZ0BiNIN5fQCsZ/mP0uBuSMv4LNfHNP8uRlD5JyzS/Qqp
	JG2G+9HYK8QrfYlDAIe790r5xYc3sdc/TrDL/7mu2bQh+VI+v638TfvCTdgTNTg2
	lyhL5Tsstpe2o08Gv0VV1Lmbc5w5GMwEUIaqDfhwR72nz17lrdaNByltxFgT/UEZ
	Uiw5ojdI2B6Fcs5CX0Fzpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744152567; x=
	1744238967; bh=cr5OrStKUtp3MzxuEEeDtz1Ppx9bOSU+1yvDhzq7Bx0=; b=L
	aBZhrQpF5jjVCLHitP24OuqLK+fKU48AOPL/SpAPpTzl8jEZmwGipK4m+7MZHm7M
	IGsjm55I60JFguJdreCLR3wYpna2ueUEvQKl/lBXdpVX6e7TQHWZW9hf3kBO5IBO
	nLIgFz9XDKH6+zjHjCoohKR8ozRKhEbu9LYmh3zyXXmA5wXfxQ2p0bbgao84Lt4l
	q/kglSTxTDcHB6rLr4JwzQItNQpldyv36gfxcxs8yS4LcxNMPvOU4rakm3/A4++5
	KSpapJWObbEfCJvTL3NH2mJg1Z1wS0Z9W/aAXkUdl2nqBk8X8Tbq0PZefrMZ0tlL
	EH/ak1qwryFhq+9Q2LWnA==
X-ME-Sender: <xms:9qf1Z_GLYudSsUu26Gt-5vOo6q6vr8EdSMBxYzCvWB1B9COkruv7zQ>
    <xme:9qf1Z8U30lYHNI8mDnG6kX-XDGDGIT3KZQdsduQzfw8IIci81CrZxAt0V8ZoprfHi
    qMxm8F12uTEFmu6cA>
X-ME-Received: <xmr:9qf1ZxIVmQyhKU6M4JsTPRJ6nfzGvI9w8vdEz9nxqBpo71vy89T-tlQBzOpQHDpvBMN_L72paJ8ZlFQJgR4oVmFZVJxbn1ygoCUe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9qf1Z9GQlzOtMt9EACsGZRRmxgZhye0wOFSPpIAdrQGAIbZ_dq0Fpw>
    <xmx:9qf1Z1UzlB5ghcqv7OGmxnGOwHNnxaNcWwyWtKZC_FrdVw3u0SgsxQ>
    <xmx:9qf1Z4PVerQo652FXLGoAFBb2Saj9PYOxqid7t42L61vloXngLU4kQ>
    <xmx:9qf1Z00sghUzfxQUFgfsCjdGNkCChZFR_bDloJqP4d-5jsTfdbBKiw>
    <xmx:96f1Z8Arwj_Ofxci4TjMtOGpieKOHX8ggyJK_YvFR9WhzGdNDOQfSGEY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 18:49:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Mar 2025, #07; Wed, 26)
In-Reply-To: <CALnO6CAzCANvC_BGYNV7a704Tmar8XyqE+0L_HEyDr1WYKo1Xg@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 8 Apr 2025 18:39:12 -0400")
References: <xmqqiknwhsdz.fsf@gitster.g>
	<CALnO6CCcE0zyqUtFOkBZetj9HCzg_mmnWq=+gOEaRn9Np32UKQ@mail.gmail.com>
	<CALnO6CAzCANvC_BGYNV7a704Tmar8XyqE+0L_HEyDr1WYKo1Xg@mail.gmail.com>
Date: Tue, 08 Apr 2025 15:49:25 -0700
Message-ID: <xmqqy0watgju.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Fri, Mar 28, 2025 at 8:34 PM D. Ben Knoble <ben.knoble@gmail.com> wrote:
>>
>> On Wed, Mar 26, 2025 at 8:46 AM Junio C Hamano <gitster@pobox.com> wrote:
>> > * ib/diff-S-G-with-longhand (2025-02-12) 10 commits
>> >  - diff: docs: Use --patch-{grep,modifies} over -G/-S
>> >  - diff: --pickaxe-{all,regex} help: Add --patch-{grep,modifies}
>> >  - diff: test: Use --patch-{grep,modifies} over -G/-S
>> >  - completion: Support --patch-{grep,modifies}
>> >  - diff: --patch-{grep,modifies} arg names for -G and -S
>> >  - docs: gitdiffcore: -G and -S: Use regex/string placeholders
>> >  - diff: short help: Add -G and --pickaxe-grep
>> >  - diff: short help: Correct -S description
>> >  - diff: -G description: Correct copy/paste error
>> >  - t/t4209-log-pickaxe: Naming typo: -G takes a regex
>> >
>> >  The commands in the "diff" family learned longhands for "-S" and
>> >  "-G" options.
>> >
>> >  The core part looked mostly good.
>> >  source: <20250212032657.1807939-1-illia.bobyr@gmail.com>
>>
>> I'd be interested in seeing this land. I think I can read through
>> review comments
>> and split the cleanups from the addition of long-form options (both of which I
>> think are generally improvements), but without signoffs in the original commits
>> I feel like I might be overstepping on the intellectual property---and I
>> certainly wouldn't want to cause licensing trouble for Git.
>>
>> What's the usual way to proceed in a case like this?
>>
>> PS enjoy the vacation Junio---I'm hoping someone else will reply so that you
>> don't need to :)
>>
>> Cheers,
>> Ben
>
> Looks like maybe my query got dropped during the vacation time: I saw
> the newest "What's cooking" said "Expecting a reroll"—did I miss an
> update in the original thread?

Yeah, unfortunately it wouldn't be good to add changes of dubious
origin that is not certified with DCO sign-off.

Thanks.
