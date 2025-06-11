Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BF019A
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675984; cv=none; b=fab74MaIIdWQ3XTyZSO6XqvO6Yn6Bxv65iw8Io902Lghf7tFXk9WIvkRWvIarlqkeDVEUz7yDNvPuZHtUHCNmPy5ZKIZc6kwe0dmE+l7X91OXA/EXx6Yxq88FoHh5kdec+avZm8TZxIpkFA7NQGIoWxzQ2/Bx3CqqHI5olI+PqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675984; c=relaxed/simple;
	bh=+oyhhZu3eLlyhS7c35DSwV1rGr1JTf0cHq+Ngfu31os=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=umRozOFOe0YHZjPldzlgxeMepsS4/zq9WtASfaVk/MXv9selsV+vihviXgR40a2Oi0LGv9QZFq2DX2e7xOKVxm8hxzEztgDahScU1+euSR00R8oeNPxJo7yAwUH4lauyjDr226xRumgKevpfWHuj6RyyYDHtxAnYjFzKhC80z9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ycwg66GG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NmC4NZD9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ycwg66GG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NmC4NZD9"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E87A11401C7;
	Wed, 11 Jun 2025 17:06:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 11 Jun 2025 17:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749675981; x=1749762381; bh=6jxQWBgD3D
	IvpTalWhdyPQadAS7ZXQO/vpnFnhKv4dM=; b=Ycwg66GGnUlq6s5DRiQx1J/9vs
	bGu/AvVu+KO4DNBF7SMxJGb3waiE9jEMYnI3fGl5wJfZzI6r6MQrtML1U3C0c/2V
	NLwZExhnVBObR/663OuL+ECBV0Jl/QsjAruZRIIOuftMTbXb3MQaEMGj0rD/MVD0
	kiTCrpmcMpDRvNUe90lAe4ZcShSaubMUfs1/TaBy4SCqCNkyYd/0Y6Q3U1294Jyr
	ZYTZsWo5PtRdp9kUn8D8ItBbDqD5tTLSbeO9UP/qHwqIr3SL8iEfgdzCKBQOtcwv
	DQpY4e15pq3w7ZcTydeFhUBKja1EySnelzhfRgke12UyY8tEj1bwueTFzEHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749675981; x=1749762381; bh=6jxQWBgD3DIvpTalWhdyPQadAS7ZXQO/vpn
	FnhKv4dM=; b=NmC4NZD96iJqPiaDg3g9TgH1d8zP7fh0/lDUTLwgQaiA+BrL8ks
	TuGhwwJUxY8naBCxQTX8KsjbJ9TwzxaaM4jOZ+TdZbM3IOOB+PZ2FVkHZAbaI0L3
	GUAQRzwX3zr4KMtJZ9BS3psrWSKNpSg5pv0mXfxDDOnhFQbygQg74ySVFM7q0rva
	GEYtB2oYt0BTPxesnzNgIgLY4yKajFqArd0TNqRr+3kR2QZLeuA5mf8Ea17GIdAn
	TSHA14kyLPf5ZDn2kHR/kTH4fgQZ0l/OTlKwp47mTZJMSpH3oOiQCjBGPB/09Y40
	z8bep9g+5X9BodiQ5E+naIdtDwvAN2z6+ag==
X-ME-Sender: <xms:zO9JaBraGxwAuZyuM-ubcBpUmdFTwFHk4L7bXJ-cYw_25_n2cXllTg>
    <xme:zO9JaDpVveFbQTUEvcipY7a69PjD3HOs3FBSWxYvtcYXQNxUEMKp06VWZJBBSW2H3
    2akV0ta5YrHR5NRcw>
X-ME-Received: <xmr:zO9JaOO9Bw0U9khmyz1gYdCB6hXSiEJe7i32KsTkO3F3tTxQdrQZVpXIooQ0YCrz6PvXiywOvA7uCZW4VpIIxlN1r6p2v4oBqz9C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrhihurdgthhgrnh
    guvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtgho
    uhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehshhihrghmthhhrghkkhgrrhdttddusehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:zO9JaM43Da18gP_57RTnCyUmzEDuyubwnV9UvWy7bw2iUxpblkQsDA>
    <xmx:zO9JaA6b7-DViz5hHmeTi7k4GE3C2RaXaXg4HjZj88bloF5EnKPbig>
    <xmx:zO9JaEg1IqHTz0D12nr2r-GSi2E_ehhPXdVu_R_QXEAdZrEcT1iX6w>
    <xmx:zO9JaC7xbFhXDOQ6JyjlUKdspN7c8Ca7mkaQFDHBkLb6g1zmxWZuZA>
    <xmx:ze9JaH3ytWPqUinCmm_Nf1Q5blOTuwDgdzumEQxYc196FeRb2cA-MiO9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 17:06:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,
  shyamthakkar001@gmail.com,  ps@pks.im,  ben.knoble@gmail.com
Subject: Re: [PATCH v3] environment: move access to "core.sparsecheckout"
 into repo_settings
In-Reply-To: <20250611173433.74393-1-ayu.chandekar@gmail.com> (Ayush
	Chandekar's message of "Wed, 11 Jun 2025 23:04:33 +0530")
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
	<20250611173433.74393-1-ayu.chandekar@gmail.com>
Date: Wed, 11 Jun 2025 14:06:18 -0700
Message-ID: <xmqqmsaegf91.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> The setting "core.sparsecheckout" is stored in the global
> `core_apply_sparse_checkout` and is populated in config.c. Refactor the
> code to store it in the variable `sparse_checkout` in the struct
> `repo_settings`. Also, create functions to set and get the value of the
> setting and update all the occurrences.
>
> This also allows us to remove the definition `#define
> USE_THE_REPOSITORY_VARIABLE` from the file 'builtin/backfill.c'.
>
> This change is part of an ongoing effort to eliminate global variables,
> improve modularity and help libify the codebase.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> ---

It may make sense to move the sparse-checkout bit from the
process-wide global to per-repository settings.  One advantage of
having it at the global level is that the code that does not require
to be in a repository can refer to it, but the nature of this variable
requires a repository to make sense anyway, so that advantage does
not apply to it.

But looking at members of repo.settings, among 25+ of them, there
are only a handful of variables with getter-setter pair, and this
patch seems to add yet another for a simple boolean.  Among existing
setters and getters, prevailing pattern seem to be

	/* getter */
	if (!repo->settings.foo)
		repo_cfg_ulong(repo, "core.foo", &repo->settings.foo, FOO_DEFAULT);
	return repo->settings.foo;

	/* setter */
	repo->settings.foo = value;

but there are more involved ones.

This new one adopts the most expensive pattern from
get_warn_ambiguous_refs() where prepare_repo_settings() is used, as
if it fears to be fed a repo instance that hasn't been prepared yet,
and it even does so for its setter, which I think is probably a
mistake.

And there are tons of members in repo-settings that are initialized
in prepare_repo_settings() (perhaps reading from the configuration
file or assigned their default values) and without having an
explicit setter/getter pair.  If the code paths that depends on the
value of these members are functioning correctly (and they should,
given how widely Git is used these days and not having heard about
bugs coming from these variables), would not it mean that in the
program start up sequence, prepare_repo_settings() is called early
enough so that all the code paths that care about these repository
settings values do not have to worry about having a getter setter
pair at all?

What is it so special about sparse-checkout bit that cannot be using
the same "initialize in prepare_repo_settings() and access it
directly thereafter" model, or "ah, do you need to know about this
bit?  Let me see if I already have figured it out, and otherwise let
me read from the configuration, and give it back to you" model?

My gut feeling, if I have to choose between "lazy loading" and
"popluate in prepare_repo_settings() and then access the member
directly thereafter" for this variable, I may pick the latter for
this particular variable.


