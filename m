Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2135421FF4C
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346209; cv=none; b=TVEcxCY0qdzTUwwELIHp6M2CqUW9pjRHobQB49LLjxNq8Lt2ALjSus87R2UljLM4llRIbFfMo9refWvtJI/wkxhgJP/X7rhi3ZtIwc3ATblAhPCGCVmz0QzI7yB58a/i6YUn0hwYuoSj3AwOWiKnnb75dwzJnLpoww02ieWY1PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346209; c=relaxed/simple;
	bh=hdu5g9XTgDOTVdcTZFuZ0F7zkdyRXY1GZa9TaGeeNrI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MiczVVT0J7QquzA/ZfkHBKnmQbaYr9xjlGapnioEWSATpFNjw30gfiwsxxWnyo/hj3jDUS3p2w0BqGUQbjCdnS/SV0Gx0eozIhuEIoZ6W5tZsJnj66yODSFTIzvGnmY8Mj9XdUPALRE3a4Pa5vsgp8bMijahfgWFxRzL4tNHbPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mk8GXAtP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=adadcXuW; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mk8GXAtP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="adadcXuW"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C611D254011F;
	Thu, 19 Jun 2025 11:16:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 19 Jun 2025 11:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750346205;
	 x=1750432605; bh=cWg4rD6yRpwZ0qIPlQPsqu6rS8M/13x+cYYmoJvjtyg=; b=
	mk8GXAtPhEl2bRUr08lTzBgOgB0oUqPxHh9dkYhqglVko7USa281inf3MRBinhjP
	1CdluL5GhV2eVYw/2v3b/l+fwB3K0CuQNFawaQ4dmQqnMnFMj1FSQDSpU4smG6ec
	bQmVwwlJfyo9js5darFqCyN8jtmsQs7wDLRqcQBLURiI9m5FZbAVlAQLV3o983ij
	6tskN/m34t8anvCZkQOuAN/jp6OjndDMARAgH9/3b+KBikDepgBkNGG/T4m1FNc9
	ayQTKP4sVTI2Oe33nOFLoEvEoeSJovCpUIB8Rl8cOz6OCOkRGz071jXp5LLIF9fq
	vIJvQSFd5PU59ElWKc7YlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750346205; x=
	1750432605; bh=cWg4rD6yRpwZ0qIPlQPsqu6rS8M/13x+cYYmoJvjtyg=; b=a
	dadcXuW7hJso5LeG2ZQOw542B030ZA/XmEmgwLz6ZwrqQTP2opEmjl7Q8Y67aDI5
	Bq0LdFWq3S+fiP5yqrYbWBGAYcqTfOMmUAOAPAb1ZnTb8AQBXXjUNnDQXSHXHnYO
	vpIL5nhlC9ozWyK/VEtWWme+bwuXdqYwErGfNZK9HLaWMFXaeCwz5abJu4cK3Eun
	CYxEkQ2/Wq64kA/WEvKDYU4DtQ0s2AoIQhZta5XxbTEcS7OIm9feJUpi8kDjL+LG
	r2pu/+fxY+Eoc0jsY6cQw56jGKLQVN7qgivfR+8Z1MDoopz2+jB2g8jHGt/eU+Jb
	bvx4gmBHj3onrm0WnPafA==
X-ME-Sender: <xms:3SlUaEWLh9Q9ekgGSaQMVKT9Ncer4HzrxaRZ7h8Ulk98mlIzqrOsAg>
    <xme:3SlUaIlmaMY5D_-eUs0FR5mOIjyOtExg0F8q73kw9m3xMAXLJugUvgjmFglkQVqHz
    uBaO5MMMZJ2vQqIBA>
X-ME-Received: <xmr:3SlUaIYWP5JDgbv0PMnKd9MCyBZ5tyyJ0IE1lVGeg2CbryaBjPomVxQlQxU7eSMYWUlnSdM5gMB0eg6G2CS_mvi-BVH3B0Zab6-D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdehkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtvddtffeugfduhfdugeeikeejiefgjeduudevfffgkeevtedtheevuedvheek
    veenucffohhmrghinheplhhlvhhmrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlseht
    uhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3SlUaDVnhC8Uxt7f72p2rcfaVTi3jbAkWCnr5yAMrkXJX0MMHYxc3Q>
    <xmx:3SlUaOlTOYduXEKjmw18o72kQjFDZfDh9jjQmhmoT26NrSiQyDbVrg>
    <xmx:3SlUaIesfv7tWPI3pAuV6fu5AJT1fB6GU75bOw3wHsARVkclxqAu0A>
    <xmx:3SlUaAFRArwBh1eUJnoX2IGMgIul0WvlgcmmMWEkwTbMKIVx6OBTkQ>
    <xmx:3SlUaOLAnd0EIwQYCOvicrUmmpHTV9PGOho2l2xPvt-rTk5ct13S9L7a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jun 2025 11:16:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org,  git@vger.kernel.org,  jltobler@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v6 6/6] ci/style-check: add `RemoveBracesLLVM` in CI job
In-Reply-To: <20240723082111.874382-7-karthik.188@gmail.com> (Karthik Nayak's
	message of "Tue, 23 Jul 2024 10:21:11 +0200")
References: <20240718081605.452366-1-karthik.188@gmail.com>
	<20240723082111.874382-1-karthik.188@gmail.com>
	<20240723082111.874382-7-karthik.188@gmail.com>
Date: Thu, 19 Jun 2025 08:16:43 -0700
Message-ID: <xmqq5xgrdan8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Karthik Nayak <karthik.188@gmail.com> writes:

> For 'clang-format', setting 'RemoveBracesLLVM' to 'true', adds a check
> to ensure we avoid curly braces for single-statement bodies in
> conditional blocks.
>
> However, the option does come with two warnings [1]:
>
>     This option will be renamed and expanded to support other styles.
>
> and
>
>     Setting this option to true could lead to incorrect code formatting
>     due to clang-format’s lack of complete semantic information. As
>     such, extra care should be taken to review code changes made by
>     this option.
>
> The latter seems to be of concern. While we want to experiment with the
> rule, adding it to the in-tree '.clang-format' could affect end-users.
> Let's only add it to the CI jobs for now. With time, we can evaluate
> its efficacy and decide if we want to add it to '.clang-format' or
> retract it entirely. We do so, by adding the existing rules in
> '.clang-format' and this rule to a temp file outside the working tree,
> which is then used by 'git clang-format'. This ensures we don't murk
> with files in-tree.
>
> [1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebracesllvm
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  ci/run-style-check.sh | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Have we done enough experiment by now and don't we want to move it
to the set of rules in our tree?

How often do people use "git clang-format" before they submit their
series these days, by the way?

> diff --git a/ci/run-style-check.sh b/ci/run-style-check.sh
> index 76dd37d22b..6cd4b1d934 100755
> --- a/ci/run-style-check.sh
> +++ b/ci/run-style-check.sh
> @@ -5,4 +5,21 @@
>  
>  baseCommit=$1
>  
> -git clang-format --style file --diff --extensions c,h "$baseCommit"
> +# Remove optional braces of control statements (if, else, for, and while)
> +# according to the LLVM coding style. This avoids braces on simple
> +# single-statement bodies of statements but keeps braces if one side of
> +# if/else if/.../else cascade has multi-statement body.
> +#
> +# As this rule comes with a warning [1], we want to experiment with it
> +# before adding it in-tree. since the CI job for the style check is allowed
> +# to fail, appending the rule here allows us to validate its efficacy.
> +# While also ensuring that end-users are not affected directly.
> +#
> +# [1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebracesllvm
> +{
> +	cat .clang-format
> +	echo "RemoveBracesLLVM: true"
> +} >/tmp/clang-format-rules
> +
> +git clang-format --style=file:/tmp/clang-format-rules \
> +	--diff --extensions c,h "$baseCommit"
