Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC5528B4E2
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771525025; cv=none; b=SncieCwAyOJ1RMusXL0zs/sEaLxWKHusRaVleRGnKmR0pHWwjg9MOCRPQT1zGUF558obTx+0C7RrRVqsl5rI10/YrPnVP8xRU0xaWUCwWHYhzuqWPjk5cVsBv/KLCgvdomQw0QfQj0MfBbnPOr4zwEZ2im1ymSQQbn3dFCNRpkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771525025; c=relaxed/simple;
	bh=OUaGtoX2dPGEl9HVVPzvbR+IjUkcanM7aOMS7vKpwNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WeEvLTDed1tC/8eLVGSlrMDwMT9/IBOE86Oj4ddtrFXSkdoDvfInb4P39OQiaI7L93FMz2+nxXPGHOkHUlZVIQy0tSL0vBlu+6c6dDaF4PQBG9YPvq8bAqdcj2o6YKsFZj14yIJyDGyA+c6Zc2g6DuelW+e7kxecANVv7vrD8wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pwl59Wo7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RYKMeKPJ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pwl59Wo7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RYKMeKPJ"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7839B1400108;
	Thu, 19 Feb 2026 13:17:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 19 Feb 2026 13:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771525023; x=1771611423; bh=m3cTV6Ejav
	W2A6I1G6i0SyRAqzZuDwVyttN5FJeA+Vc=; b=Pwl59Wo7LwvfhocYIknfsTpOBE
	qOS0rNStUz5EiWAu0fFpBOLgbJqf9L140z9lNa/HSHeRjWXDdICgztcrdWemRz78
	z4K0bZx83OiBeL5vZw46gy75F6CUQQ/SZIbLgGfnvo0ct7ihxA2h1QIwbl6V2DhS
	Hs/8Hi0Wzj09NEiumHzGhBe0Vl0rzRtvAr8ooqiq43WFvv+kub4YYL58y8ela4Cg
	va363nbyKycq6Ur1MUCZtMjtH5O4zhdXU6rBuwA/St1s9vaOMG3go8svelbsBW7p
	fSMUuAP58VLBQcubSMeciXlKSbqCXNFubuY5QYR/q73S+5nahsO593F+NDMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771525023; x=1771611423; bh=m3cTV6EjavW2A6I1G6i0SyRAqzZuDwVyttN
	5FJeA+Vc=; b=RYKMeKPJY+XKylIb18cJcZQk3pBFGpmfP9WXtVRKEAQ9x3RV8XY
	dm6L8awGO7Rz15z4ue52oVQaL5SCLU+4mFBonC4Q/N50er/7Gkh8CrO+wtflQjUS
	lH7fUdES97FOQ73CQ/3sZDfSa5BH0dr8kL5B3VAFvHMPRZnx6IYWxSZHSq4CmLCM
	7CYKvxlUWav/iJJy885jcMwGceEBLf0SVoJOleH6DV9gnWGykPWfhn0kXt3neTi+
	Xd9Ji1YuSSdzSWp27KTckwn7GzjQptBMxDtGa+RJeB2VZVbwQuWb07QcofHrtHFu
	BbuDlgcOGiLgZnTf9fwMv7xn4rbqgW7pKCQ==
X-ME-Sender: <xms:n1OXaT-6UdmzIpeAiIg1eEhsf0fx7swpb-VLIRxG9VucNuDpcU1gAQ>
    <xme:n1OXaTYopkD7aho_OoV91VlCdmbYlup4esjdje9J3CfOHPR2rwJo_AkrE8rwVL-cN
    5VL18_rxW1fII1p3KvtaVKKTUTR5YG3B4n-A4W760BcFAQesAmv7Q>
X-ME-Received: <xmr:n1OXaa39av32G-DuIpFK4xsZZ55Hy6J0NlDeVP0xRe181QmilvZqt362peu6hZRoDNcaN9R7zZ7fuZ97vVxr_k1DAATxQls1_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeivdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:n1OXaWbg4MtBezT88BuSWNqIeLNfMfRZAG6wygh6vlLsxVVmo9JnhA>
    <xmx:n1OXaaL-2JBKws1uggZ3ceZVEnBGpSr0moLTUxguYeJUmMc88-pBXg>
    <xmx:n1OXadEVsmkGNBt8uMgWyhXUVsrSnnizhuNRu0r7rJMhxGFD4njfgw>
    <xmx:n1OXaZuGIWlYVsOkwshKnwLxGsQMSMZWtWojACgEhm2h_5S3QCPACg>
    <xmx:n1OXac5orwbsyeg1y501Z-p8Idnepj227Vulyt5EY8legzM6f0BNFsYO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 13:17:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org,  peff@peff.net,  "D . Ben Knoble"
 <benknoble@gmail.com>,  "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v7 0/4] support UTF-8 in alias names
In-Reply-To: <20260218215737.1181147-1-jonatan@jontes.page> (Jonatan
	Holmgren's message of "Wed, 18 Feb 2026 22:57:33 +0100")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<20260218215737.1181147-1-jonatan@jontes.page>
Date: Thu, 19 Feb 2026 10:17:01 -0800
Message-ID: <xmqqpl6061k2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonatan Holmgren <jonatan@jontes.page> writes:

> Hi all!
>
> This series adds support for non-alphanumeric (including UTF-8)
> characters in alias names by allowing aliases to be defined using
> git-config's subsection syntax.
>
> Changes since v6:
> Reverted the --aliases-for-completion output format to
> use a newline as the field separator between name and value within
> each NUL-terminated record (name\nvalue\0). In v6 I changed this
> to use NUL for both separators, but this diverges from the
> convention established by git config -z, which outputs
> key\nvalue\0. Matching that convention is the right call here.

OK.  The key cannot have NUL nor LF in it, so either _should_ work,
and using LF in the context of -z somehow makes our eyes feel dirty,
but it is how "git config -z" chooses to work, so I agree that this
change makes sense.

Shall we mark this topic ready for 'next' now?

Will queue.  Thanks.
