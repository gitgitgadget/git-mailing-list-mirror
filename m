Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80AD1E885A
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767651881; cv=none; b=drRMzRRGUYZ7InKEU555jgkrzZeZQccc2FrW6I8j8x66Phj7uQCVWqqg+X3F7aD6FxYF/F87B4qYf0Cg3h8wKmEJtVqt2Sh/43zLXvlEILPr0J2KLPSmtjJgCsVrTIddQ6UE9oIKtJBXDkS8UrroHJqRjyB1lrcEOS23000ZE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767651881; c=relaxed/simple;
	bh=TCGK8ZT1u70BTABwIt+x9M3NYztIavIhndURngVbWT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=spRqGAUO0RNUY/Uv721rMqLzItGmqEl3dMW26My1mBBMCvCrKjU5xz0oNNKVjLH19p/9cFdBXs8cSQqzGhUDNpHCWoen7OKntSYu3RFbJyqGMXn1iMmuiwiL5OPBKh80+GSvQ8UhCpvaas8lEDEuttDofc/yiZfVI/Hlp685u14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j3YUssI5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SQlG10Zn; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j3YUssI5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SQlG10Zn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 003F47A00E5;
	Mon,  5 Jan 2026 17:24:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 05 Jan 2026 17:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767651877; x=1767738277; bh=eMSJcnoVzI
	tB7fwEYshbZBYYENNi9z88mMxYwXyKNLo=; b=j3YUssI521fCRCKU3jFub0n8Rk
	fJSH+B/S/0tg3XfzW5cSZd6JU+Ib7LEinQoBODTQ84Z5Ht9QatsTUyNRccfNrvzQ
	umSRXARr20BmQ17s9lHHvWYsltUyU6SIM9jgzf06khl7SWVPqvYZ/D4f/ai7nEex
	xqRy+ijTBb/KjMjxwL+ft/cApXs+gtEcZ6QW1O7v/HeXIExHb7nUWeRKJ/rFOFek
	Bg55lsT3IHGdljiLf5BiM1CjZ7vgWKRCDZTeEBw5xLGQMMEIZVGXoZROCJrxtUpm
	PPro4vfFbUeaRetRYKFF5tYsLiTGsrTVeIXK810NBOO6dRWE3nxEImoVlVUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767651877; x=1767738277; bh=eMSJcnoVzItB7fwEYshbZBYYENNi9z88mMx
	YwXyKNLo=; b=SQlG10Zn6gOwlo7pEKvLyg7snE7EuDSNLmmd4EwvpDlFbatsu8c
	rwizWVUpIFCVRgUIvVh2DwT4ozPpAK2qfTBbIVUfuDH3WwePDcNCrW5OEuaFqc61
	0JRZlYlw5oWvttsuYl8MRHifDI4j1b/N9u5ggVwX0scDbhbkAbV9VhCZKsjr+u/w
	H1pfLDDhIfhTzBJkfWMHqXzgAaF+eiRyDUm+KtY1WqLIo9fME1+uI/hR9F9GfX5D
	1Si9Es64Hs2wrM1OXQ9pF8vb0OnnQ7ZV7AIsPtwSN0b+Z4wvlJX8x2ZoryWH20sp
	o2SbLzAAA1XCXwKmshR7I0kZFDU0suuxTmg==
X-ME-Sender: <xms:JTpcaXS3CeS643LMmU1-lNDRqYN1Za-mhkEhmW65mylZGnLLLkreSg>
    <xme:JTpcabU0mbw6X2GZiqxsjyFffmpIEu1qKNGtF8bNPv7Oz0U_XOdWT7ooC3SqtKkdk
    _oWm3IVFF3LMBHZXL0kazrt1gsl5E-GSIicsrQAKg8YYT7vP6GqDQ>
X-ME-Received: <xmr:JTpcaQfkjwYBfP0OvhObRNawCE4So0canLlhRx92BkbafknrZeXl3LNcl9SCeviMKRTCGlZvb8FR5eOJ8Y_-p_fsBdp7lE1hnB7afmo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelkeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvlhhkihguleeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehushhmrghnrghk
    ihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehkrggrrhhtihgtrd
    hsihhvrghrrggrmhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JTpcaXIWI2iZL7gmJ_hHCdhBVuhCof6OVkv-5NN-GVzLGTe8rR5pnA>
    <xmx:JTpcaVwqs-sdR6OGCTG1wWfnc_I3sdkSF5D2dpT4ra8cOALM3SRynQ>
    <xmx:JTpcaVtnyTmAykD0dtSuhI4GzVP3Le6sqMEQvsv7c8cyMMDK3FEaxA>
    <xmx:JTpcaQDAh4g7LJ0sB0TW0PNel0a_Z-FPxyEOUw91a5alKR6daWyJhg>
    <xmx:JTpcacy9UZ_NKRcG7zOHDHBlBW5PTIXN6JuvCqkBwi0jZVG6wlgoKK_U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 17:24:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Olamide Caleb Bello <belkid98@gmail.com>,  git@vger.kernel.org,
  Christian Couder <christian.couder@gmail.com>,  Usman Akinyemi
 <usmanakinyemi202@gmail.com>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>,  Taylor Blau <me@ttaylorr.com>,  Karthik
 Nayak <karthik.188@gmail.com>
Subject: Re: [Outreachy PATCH v2] environment: move "core.attributesFile"
 into repo-setting
In-Reply-To: <a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com> (Phillip Wood's
	message of "Mon, 5 Jan 2026 14:23:26 +0000")
References: <aVfzMsN2ouY3UBFG@ubuntu>
	<a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com>
Date: Tue, 06 Jan 2026 07:24:36 +0900
Message-ID: <xmqq1pk3lmu3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> If I run 'git -c core.attributesFile=~does-not-exist rebase -i' with git 
> built from master it fails immediately with "fatal: failed to expand 
> user dir in: '~does-not-exist'".

Hmph, if you call any behaviour change a "regression", this may
certainly count as one, but I do not necessarily think the above is
a good behaviour.

Think about a use case where attributes are not used at all, e.g.,
"git -c core.attributesFile=~does-not-matter cat-file -t HEAD";
would it make sense to barf when your configuration file has an
invalid definition for what you are *not* using?  So if the change
makes it stop barfing, it can even be argued that this is an
improvement.

> It is quite common that moving from parsing config settings eagerly by 
> calling repo_config() at startup to parsing them lazily via 'stuct 
> repo_settings' causes regressions like this. We really should find a way 
> to address that before moving more settings into 'struct repo_settings'

Very true.  If we know the set of things we parse early and have a
way to say "this command only X, Y, and Z matters (but not W)", then
the above cat-file example can omit the attributesFile from the "we
care" set.

I think overusing repo_settings is a disease.  Moving a singleton
global to per repository (by adding to struct repository) is one
thing and it is very welcome.  But changing the way configuration
variables are parsed (e.g., what used to be parsed by only those who
care about is now parsed by everybody, or vice versa) needs to be
handled carefully.
