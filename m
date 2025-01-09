Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D918224B1C
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439406; cv=none; b=a9TN5GTfywCDQwDQK74Gu0SKkjINPBLZrAxrskHPzy0HRhgmT+/oyHvuG7oqO0skb5/PVwg9uT+APlEOMVLaAva2rnwLDKsEFXQ56RBnSbN6vFBnQrcSGau5kANUajAnFsDIcE/g86zE/Ju9WVNZbGac67RDje6OrE4dp1szvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439406; c=relaxed/simple;
	bh=lo/GMcdROAS7umpM0FE1qnwXz3KTihJhW5iaoLRyI94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rspI4CfUgFWViMNKJkUVu7T3IWZ798ekgFW87BMB/ES0vAC/HXIN+oddUh//zSdzFaNWjnOaoitcp0zzZvhIzTuEWXKIiaw94BuB7N6rytRCrfhFxZQEtbLGpoTa4KeQtTkDi8X+p0U1NDj4ORM/a9k75hlhV9cAmbtO51uuOkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bm4YlVzG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bBCjzAdg; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bm4YlVzG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bBCjzAdg"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 47DB613801AB;
	Thu,  9 Jan 2025 11:16:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 09 Jan 2025 11:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736439403; x=1736525803; bh=pmCS5oD46s
	vodRhTZG5HkyhwkcPXdo1m+/VoZ8LHMsU=; b=bm4YlVzGW5ZdVbYaDUvQW9R8A3
	8/j2M6EJCejQ4BFbHYlptHiMnVuvwEWDijXDzIn5dkfz1nRtAKQkRNqaA7504T6f
	AwfTGkm5s/SxXDt1fNdx82N6zxEgimeW4XbcAUFu7SdUIYIDXJwQe4SR7CS9ojqZ
	4qDTsRqDTtDDb6MZssHnYve7MPIaYrFbLlDBNvuhOtkhwPyAqjiop6wcXSa7LUh9
	b5iYvWTt2MMh90gDjV7w7qnhN7sr6i17+ZNA833kImEDf19bG+yeWtKBCxdqsAJe
	AeE0SZdj09bTEhlLDpXtnQTve3sebJ54hbCtYAcXcK7uBv86BBNR26q/3cnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736439403; x=1736525803; bh=pmCS5oD46svodRhTZG5HkyhwkcPXdo1m+/V
	oZ8LHMsU=; b=bBCjzAdgwAOC9BAQO43Vm7WLd62JXNH5X17zDITmY31Ke1X2YOJ
	6a0ff2i+sK0f09q2ozEqAryLI9pR5HNcce3lmOzWdzWU/qeGxMJ1nXRU/RngVR7N
	dT9CI+86+UFIVsPFDOxO0gIhhpYGfctqrStbyGj19D3ALhJ9HY6va+KhqlBSpaeX
	HUydy6dSOw3ESORn8jOqPDIqyboHUKssQ6Hh9sO13+cCLrfu4JE7gRJ7BEvZTlU1
	gBdhUH+CjSEuBP4kAue16Ng7hI9LcjAAKry8JPAQ8ugerrtsmUgYubykIuLryNdy
	4U2cNShSPTtbGcGSIC0gPSQrULZwalCKPQw==
X-ME-Sender: <xms:avZ_ZzcQYbAf197bUMjMzKfrFYdaP7dMDExnHbL04xq8sW6r6uyJ0A>
    <xme:avZ_Z5Ntjzp3qj_ISIr_iU0cJMSm4gNFqYjriVknOl3AGrxJsoM9fYcIGSVSHORok
    TYaFTzOyhkNZXAjWA>
X-ME-Received: <xmr:avZ_Z8gRaEDgwuABGubDou-OL8D7stjRqHRGgpG6lNdA-EWcqDSL701S7x_3mbLaAQFd-5Z4g1AAUqCgH1_fyWP8XtAZeS7owE6U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesug
    hunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:avZ_Z0-ujAUWVst0-sC67DwQT-FBYit7zbXqroORpsN4uVAHS8gA8g>
    <xmx:avZ_Z_v1mDBtUKyJ0S_ln0rS32C7hit7S1vX__9iJdBi9_PyfTMWxg>
    <xmx:avZ_ZzHaagxwRihcNq-kEz0FhWsfE8puQAr17jycOvXLUZ_R7V6-lQ>
    <xmx:avZ_Z2N-UF-ZQytWmAT5hW6dF-F40PnbNA2dvQXf-Wt7eKGTY0A2Xw>
    <xmx:a_Z_Z1X-bMAG5w_KacLe-1-aZBsjmVP6tNVHNyfW84NlfbHpdd46Qv42>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 11:16:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 02/10] t7422: fix flaky test caused by buffered stdout
In-Reply-To: <20250109071707.GA2735258@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 9 Jan 2025 02:17:07 -0500")
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
	<20250103-b4-pks-ci-fixes-v1-2-a9bb95dff833@pks.im>
	<20250103181739.GA2527684@coredump.intra.peff.net>
	<Z3u6lj_bpM7N93Fd@pks.im>
	<20250107023904.GB2363@coredump.intra.peff.net>
	<Z3zqKSx8NVK-QQNL@pks.im>
	<20250109071707.GA2735258@coredump.intra.peff.net>
Date: Thu, 09 Jan 2025 08:16:41 -0800
Message-ID: <xmqqikqoj72u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, Jan 07, 2025 at 09:47:43AM +0100, Patrick Steinhardt wrote:
>
>> On Mon, Jan 06, 2025 at 09:39:04PM -0500, Jeff King wrote:
>> > So I don't really see a way to do this robustly.
>> 
>> I think I found a way, which goes back to the inital idea of just
>> generating heaps of submodules.
>> ...
> Your solution looks nice. It's O(1) processes, since all of the heavy
> lifting is done by the long gitmodules file and tree.
>
> I was going to suggest that you could reduce the number of submodules by
> giving them large paths (or large checked-out branch names) to get more
> bytes of output per submodule. But there is not really much point. What
> you have should run quite quickly.

;-)

>> I'm a bit torn though. The required setup is quite complex, and I wonder
>> whether it is really worth it just to test this edge case. On the other
>> hand it is there to cover a recent fix in 082caf527e (submodule status:
>> propagate SIGPIPE, 2024-09-20), so losing the test coverage isn't all
>> that great, either. And keeping the race is not an option to me, either.
>> 
>> So I'm inclined to go with the below version. WDYT?
>
> Yeah, I was tempted after my last email to suggest just ditching the
> test, too. :) But I think what you've written here is a good approach.
> I'll look carefully over what you sent in the v3 series.

Yeah.  Thanks, both.
