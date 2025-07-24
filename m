Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533E2EBDD5
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382661; cv=none; b=nrnyPk6sWaKICBQpJXwaapYAHBWbTAx9QVBNsP5sSUZC59aaGkBZ5ohpr17M06FqvSardVGNFb/UK6bPaRhAJURXW2bLA1npLkywP86AmzRtLJxx4f/WZ61PfQTDe5UiLOPeuwdkwTePKx58kV1mUFOtzJU3Fzi1XiKNpATCDHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382661; c=relaxed/simple;
	bh=eNFMjL0lndNxAEfvxSQLwMRp5oo1uddLp+A+KWXUt6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ASfwyZcoMCS4NBNG/You+avtzTKeM7tApGvqDXp7fsGJOpryu3lEUr8shtQ+09X5q3G8JjhoYh/aKFEvYkigY3BjXDvUF5PjM/3J6giWxi54qxCQPdppUSrZL5tc4EAP6OBLKZN/boZK69rJGlXy4wTDJ5/AogJA6ZlkK1MPs2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZMGUnHXE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LYkmOty5; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZMGUnHXE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LYkmOty5"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3DFA2EC01AF;
	Thu, 24 Jul 2025 14:44:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 24 Jul 2025 14:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753382655; x=1753469055; bh=5WZnu9FCer
	8PWUJIwAVjl89bhn/sytPLoIPREUszWV0=; b=ZMGUnHXEmBZUC2Tjmyc0QGu2X2
	czYHQg4LHM/LmZJ+dxlQquu+BY1rpa/v68ht72VpV05Yqw8eaGc52zviAzwalmVW
	Qe/2Av4sf88Ff3V8O42D8+3oDEMYrsIavLxUA4Sgkm3MOcLmM287pHLSgLhSYiut
	qHYlBcKk1aCnRSO7tAkzneXdT9LvBS545ACdqhe6er6BATJQsRg4ph2iKzRaOOT+
	BO7nC3aZ0PrOd+JxNOkO08njfxAGS9Rireegf+kiXqTZI9rkTqbROIHEWHqEcxlO
	ZAVYqGt8eyVHfNAXA5kSzQcGnCdK/1nHjc0MIg/QCohM9TnwXMIXgtk3pR8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753382655; x=1753469055; bh=5WZnu9FCer8PWUJIwAVjl89bhn/sytPLoIP
	REUszWV0=; b=LYkmOty5ZbFrs3B5aanGfMDPsGinJSDc5tWRE+DvrJmhQ3btJjK
	hitOOlfgMGI4mGI/CVUhy1UrF5UAYdGzWSzl2bgFh3sSIa1X9ilv0dg7MPHX4/L6
	l+UjffJjFwdG+VIqyISZVn9UN09tzK2DhF3lb1Qm8aZqoR3JlrdqaRq4vrltr41y
	ocgZPjPptng6TWQE748ZvaASYJaFSIDuOZST3XsdhSYimdbKuL6ec0/PA9cpZkOE
	ZDuHm9HjYyJMR7WiX660BuZI03Zbsb3WXNVPkeFwl8HQ0QcIvwGOPgAEyQjSKE4r
	lqukU5ObCA4JQ/KTAhRngKM/H6tXUe6vLdA==
X-ME-Sender: <xms:_36CaDAmMAnOOTpdWJdz_EoZA3H39e4aCly9D-k9zXgFXGWVqixcvA>
    <xme:_36CaGY3LYcDFZEK7fChORo3UFmECPsgxp8HtDqP6JcyLMIdeRaRjmcQpSxDg2XMh
    LfV71NrY7_CvFQ8HA>
X-ME-Received: <xmr:_36CaOXvmsGnjDmfwezuL6juDMLqh6HqQrON9Wy7Vl1aHFMTILbDix3X039-yZQ4FqnhkhZWvA-a8JAdkzJThuSSUeFpUXTlb1kQk30>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghh
    rhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhihrghmthhhrghkkhgr
    rhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguud
    dvfeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_36CaFMSHOG83UISu52mQ4lYktzdHlS7bggMDicsQh2xCVUesxpy1w>
    <xmx:_36CaIYVkAEpVH1VapeDwXAMOOIgiYpZGzB93VJUuDw0zTMMvp_qcQ>
    <xmx:_36CaE-KPvIOkY3xkPm2Fi9ULKADx7eBh6gg9OL0D4Ewd2uU2siwRw>
    <xmx:_36CaJTEg8-W-sKvZSW6whObC0ZzohAt-LizKNyWatUtesUdobyxQA>
    <xmx:_36CaLx0k43u6WKAI7eT6UsTgzTwFZV6owPvIgHh-s3_LZiQv8AHdwkA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 14:44:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,  christian.couder@gmail.com,
  git@vger.kernel.org,  shyamthakkar001@gmail.com,
  phillip.wood123@gmail.com,  ps@pks.im,  ben.knoble@gmail.com
Subject: Re: [GSOC PATCH v6 0/3] environment: remove sparse-checkout related
 global variables
In-Reply-To: <43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com> (Derrick
	Stolee's message of "Thu, 24 Jul 2025 09:25:34 -0400")
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
	<cover.1752882401.git.ayu.chandekar@gmail.com>
	<xmqqcy9qlfm8.fsf@gitster.g>
	<43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com>
Date: Thu, 24 Jul 2025 11:44:13 -0700
Message-ID: <xmqq7bzxh1j6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> There are two ways to change the approach here to fix the problem
> of needing prepare_repo_settings() everyhwere:
>
>  1. With the idea that these sparse-checkout variables are
>     critical to the functionality of the repo, they should move
>     into the repository struct itself and be initialized along
>     with all other values there. This changes the patches (and my
>     follow-up series) significantly, but mechanically.
>
>  2. If we are going to change the intention of the repo settings
>     struct to move from "optional one-off feature flags" to
>     "important information about the core behavior of a repo"
>     then we should prepare_repo_settings() when initializing the
>     repository struct.
>
> My preference is (1). The only argument for (2) that I can think
> of is that it is sometimes helpful to share only the settings for
> a repo without sharing the whole repo. But that seems like a weak
> reason right now.

I do agree with the sentiment that being able to pass &repo.settings
to helper function makes us feel safer, but I agree that it is a
weak argument.  If we reexamine other things in repo_settings, it
may turn out that the same reasoning applies to them and we may be
better off to roll repo_settings into the repository itself (after
all, it is an embedded structure, not even a pointer in the main
structure that points at an indenendent repo_settings structure),
but that is totally outside the scope of this discussion.

Thanks.
