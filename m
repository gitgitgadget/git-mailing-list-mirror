Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47EB21C179
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772736; cv=none; b=BTeMQUs+iQu7Ngc7XwPEvDV/jlkOl9fTuDI2gM8uiXnGwF6p/AS4NeOj1KhsHnz1K7TLokZA0pUCJzm5nBztMaRW+eUbJ7RFlDQilDR7LYJ1Ay1mW3XtJkju6tE4LVv4tV4qVt5x+WDPJf5W0+3eu1Fo/Yt9//Ms6vbALusOFxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772736; c=relaxed/simple;
	bh=w9ZUeienA+CvuFlFpn8YdaFoUjDqWAgRqrqlWFz9fFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KTCAhUKV5WFSFLzx0Yyyd+kDW34UmFp+P+Qur4zIxyFJ5sywd2yTrOQPWxf6/qgITI30mbZg+Gi7ffnjXSk9TrLpYp6vjUhQ3imaqqQt1QLRYbyqnWpvnNZuUtG6UJAi4SWOw6jLeskZiMVbx+8yEgoorotRy61BwXMiaI3o0Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bTynPEG6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hZPWx1hF; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bTynPEG6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hZPWx1hF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7C7DF7A048B;
	Mon,  6 Oct 2025 13:45:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 06 Oct 2025 13:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759772733; x=1759859133; bh=j6Oj2U0CGL
	/hp00UDBK7NYT0kB6DhplbjvYzICNC3Lg=; b=bTynPEG6Y02qKmEN3dXrwV6kwI
	LFkozMW3uGOj4RSGWonKA5/cHU2BejUkVd4K6zeJREBk4LGT3XbU4+AIa5mBbSBH
	ecJXU4bZvHXS5O8PihkLwMTFWt4T6BQvjjlQEng/dJ5pepDLYNCzs1aQ+2217tWx
	tuszp9YtFlJ7dJCQJxiShaZ6NXy4eL0Bq41SszhMISMP7PcjEKSW3EHvMEcIswQW
	xnuwf2xfzh4YclNIdpjRkiBP70TdZkA1cmMPwngfaSEp322tvb7jhppD9xiz4lgw
	r1DmvMM7+mDGB/wT1P19wUGF4EwLyXwhQG4iZ9SxMAacKjN6y1et9CE/IVUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759772733; x=1759859133; bh=j6Oj2U0CGL/hp00UDBK7NYT0kB6DhplbjvY
	zICNC3Lg=; b=hZPWx1hFlzyFMDvcmHanOPNqMRzK0BeFa5DxnpGnzEHtRjxr+sg
	QKk8gkUYdpKQ6NZxVpLs+y0DS2L2DYuQhGXP10dVxK70zZAbkQA513ukQk8F82AV
	enkQNmAS2VrXt93ZNlSq9iEwRmb9xUfGK18BK0z1Znprpm8VhCcI5FodV9BWGPV2
	UhN+OhByCJmGxVJP+ZVscf7Bk2UmxEN1S/z9yyqLdzffgj8Z3eyZOz9ZPUQ1K4mI
	5hZvAOGgIn/fxmMK4ENn6SOUf67uYfudC1WHSOcmkATB1XwDNV1wG1DcjTOrMnbt
	2BBnWrd4lT8naD+tLBrloFCApskPVp0OoXA==
X-ME-Sender: <xms:PADkaHBzz91VcJ-DNeCTqAZlyrO7kXlr0XZZ92KNMTi-y79Hg6UXOQ>
    <xme:PADkaNOIxeertLl7Gw8pw0JNjowHPxyhcX5uQ613VFKBdav4nxLu6KsWrWecs7G5C
    dF0b3guhfUC9LwMTsXf25G9QiqSEcBZi6h9BiSv75pihI-3fbkWq8s>
X-ME-Received: <xmr:PADkaONZBafMGC2ymMLl8ynL6LhmbJ6SECD-sVS-sSg6LPkr5sBkPsskZ8roN3LWHxZ54gpw-GOY-b2jjIFOUEUNVSVg4MzNhH5Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegieevvdekveeugeelkeeuhffguedvueetvedttdduveffjeeihfeviedtgffh
    feenucffohhmrghinhepfihikhhiphgvughirgdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnh
    drtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtoheprhhitghksehsfhgtohhnshgvrhhvrghntgihrdhorhhgpdhrtghpthhtohep
    ghhithesshhftghonhhsvghrvhgrnhgthidrohhrghdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehpshesphhkshdr
    ihhm
X-ME-Proxy: <xmx:PADkaFl7m5osIpr_Hqs2lNrGfrm9PGibJcjToZ3I07JYKziiYM1gAw>
    <xmx:PADkaMtN9l8RKo9wFaBR8VRTIS1Wzm3ECsc6EDAdgTvw0M0H5rMP1g>
    <xmx:PADkaIqcsrZfuJGzYsEBUIvGFp_pBddamwTQfta0hDvhwe1DkOF1hg>
    <xmx:PADkaKcNGvtYmE3og-o_85N8Qj4vdVs1pEDbvmmIbY8c646WKGgL9w>
    <xmx:PQDkaOoDX5a-i5gf19uQh3KVruRkmgnHmdF2CzxgmzEDCT7TlclufP4->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 13:45:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Elijah Newren <newren@gmail.com>,  Christian Couder
 <christian.couder@gmail.com>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>,  Rick Sanders <rick@sfconservancy.org>,  Git at SFC
 <git@sfconservancy.org>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
In-Reply-To: <aOBMHqLxNd86vgjH@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Fri, 3 Oct 2025 22:20:14 +0000")
References: <xmqqcyalm0mh.fsf@gitster.g>
	<20251001140310.527097-1-christian.couder@gmail.com>
	<aN2fG-nS9fE5-2jD@fruit.crustytoothpaste.net>
	<CABPp-BFcg9M=XjqGPd+akrUOqJqREBmE9+NvO1Q05r4pUcOmEQ@mail.gmail.com>
	<aOBMHqLxNd86vgjH@fruit.crustytoothpaste.net>
Date: Mon, 06 Oct 2025 10:45:31 -0700
Message-ID: <xmqqh5wbq5z8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> It may matter less what the situation actually ends up being legally
> (although it could end up being quite bad) and more whether someone can
> imply or suggest that Git is not being distributed in compliance with
> the license or contains infringing code, which could effectively make it
> undistributable because nobody wants to take that risk.  And litigation,
> even if Git and its contributors are successful, can be extraordinarily
> expensive.
>
> So I think, given the circumstances, yes, the right thing to do is to
> ban LLM-generated contributions with a policy very similar or identical
> to QEMU's.  If, in the future, the legal situation changes and it
> becomes unambiguously legal to use LLMs across the world, then we can
> reconsider that policy then.

OK, so here is theirs for further discussion minimally adjusted for
our use.  I do not see much difference at least in spirit with what
started this thread, but phrasing is certainly firmer, and I have no
problem with it.



Use of AI content generators
~~~~~~~~~~~~~~~~~~~~~~~~~~~

TL;DR:

  **Current Git project policy is copied from what QEMU does.  To
  DECLINE any contributions which are believed to include or derive
  from AI generated content. This includes ChatGPT, Claude, Copilot,
  Llama and similar tools.**

The increasing prevalence of AI-assisted software development results in a
number of difficult legal questions and risks for software projects, including
Git.  Of particular concern is content generated by `Large Language Models
<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).

The Git community requires that contributors certify their patch submissions
are made in accordance with the rules of the `Developer's Certificate of
Origin (DCO) <dco>`.

To satisfy the DCO, the patch contributor has to fully understand the
copyright and license status of content they are contributing to Git. With AI
content generators, the copyright and license status of the output is
ill-defined with no generally accepted, settled legal foundation.

Where the training material is known, it is common for it to include large
volumes of material under restrictive licensing/copyright terms. Even where
the training material is all known to be under open source licenses, it is
likely to be under a variety of terms, not all of which will be compatible
with Git's licensing requirements.

How contributors could comply with DCO terms (b) or (c) for the output of AI
content generators commonly available today is unclear.  The Git project is
not willing or able to accept the legal risks of non-compliance.

The Git project thus requires that contributors refrain from using AI content
generators on patches intended to be submitted to the project, and will
decline any contribution if use of AI is either known or suspected.

This policy does not apply to other uses of AI, such as researching APIs or
algorithms, static analysis, or debugging, provided their output is not to be
included in contributions.

Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
generation agents which are built on top of such tools.

This policy may evolve as AI tools mature and the legal situation is
clarifed. In the meanwhile, requests for exceptions to this policy will be
evaluated by the Git project on a case by case basis. To be granted an
exception, a contributor will need to demonstrate clarity of the license and
copyright status for the tool's output in relation to its training model and
code, to the satisfaction of the project maintainers.
