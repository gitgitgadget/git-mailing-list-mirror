Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6019130DED4
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595703; cv=none; b=QNGkB+KtRAGaLJbVTgsQjQoeDG2H7p+qPeXxN37j2lTdzNV6oyV4j1Sa6l3VSzJY4GJYNAG468PI+3TS6RaK4GCDEXPsfT7ScZ2W0V5/TBla9PbXghCuVw9EV8zzeR6Ggo2ScRQsSmpJzYd/Y7ZrgoLwpNmezKCWvb55Kc9SgJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595703; c=relaxed/simple;
	bh=pTHj3TKyKJJK2II67NJM/u/mhcVRj1bKkUVekzMpNKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgkW2Gfe5axumdRRJ2zg7wJlpcSKZnavytZqnifE4W5/iYdqIje6UIYHoA3cDuKzJfdPv4haBdBwMUgfsSJ51S1BqXV8PdFUsNR4ZX8RlIxE//4QxRpJbv/Ad66RVie7+r0ERwpqdjUkqziqmlsXeJ+D5zwdHaI6OpHYLWid7k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TZr1srex; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iAyw7fhK; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TZr1srex";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iAyw7fhK"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7489EEC00B4;
	Mon,  1 Dec 2025 08:28:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 01 Dec 2025 08:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764595700; x=1764682100; bh=IJHPWo0Uv8
	HRtSRwE+G6XV8AhObnoJXjmoTmZ62vQX0=; b=TZr1srexp4RYPlsqkHSlGmevX/
	oZf0L4/5J3VZwmESfUAEkS7pFxFsV1R+lKSR8TtIPDPGCaI0ydK+hCXLc30jFpjj
	u2ex3tH0NBnBhv9yyL9i1b5cFnpfjZFUDx+DLKZj8dMWqEvwM8fYdsXXQsxH82tW
	Rf1Du5oO9fTLsTPQLYMryl2lO4MWN+k27inPSffU2P6c6ucnlMJiPrNVtfoyispG
	LLW7Zz0crLp3sCDoZAgxobrMjhllCNmTqXia3XtOBxPRkmA9PqfDvfUDL7qby2EQ
	L7nAsOBZWgbZeFv+wdfMtmYi2jzRJaybBpBOiqUEjtYLRKVtHRHyWDyqPF4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764595700; x=1764682100; bh=IJHPWo0Uv8HRtSRwE+G6XV8AhObnoJXjmoT
	mZ62vQX0=; b=iAyw7fhKXBd2VWF4s9xTQ66Ap8zHtpZr1OvqLcPGXpLJkkvsdx6
	vHZHs/GSS1YZ51bJw74NzdpiZJBz6mjOfXw7e2kmScrNJUlqpLBvkvLuDADdiyfr
	LjWXu5HpTPGpJ8SpQPc8rftFB2erXyrDfG9YRHuok9+sShbRilv0BcDGr955SmGj
	UvbFzaKwCR5kIzqFOyanBf2/eMWduvRmZwy9HEoL742u3wjUCLAsUw8yOorn/Nkg
	k5r6aCYt+u4X8EFwpxWRNjAxcubRhCzR0eJ8skmlHTQyczMYVmtBsxAjNuuRvsUj
	evJcIbVwriB+PUCtAXwJFA6clE7ztnzIFLQ==
X-ME-Sender: <xms:9JctaalANgfqOIzKZ9k94fC8DQnPFyzzVioR_oH7bjSEuG_oGbemEQ>
    <xme:9JctaX39kNJ1gGtez-r3im6nlM_seUnR-NNuhPMw4HCWNVhCtr8g_8tdPDd4dGIl2
    niuCiDcy_hXXYJMvhzKl9LSkj8F4KZJ0227eODwZieG8mv22s5cXg>
X-ME-Received: <xmr:9JctaWQy_zQacHRFqZJPhN3lnuK0GcF4a9EvaUHVnuMGIxOKOZvlTAVDK33dBO_xim1WC6yMcTHaSXqSg7CIkqljdiEfxoTKS8meZFqn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9JctaZuV-Cu3fZ48EmcIMxUGISonf9288FnmT7ke5xLfNSxGpLJRHg>
    <xmx:9JctabZy602aHiel4ik5hiOgOZjdggT8N07dudXSzJXZ4NE88yDBaA>
    <xmx:9JctaetGr-fF6V7LHKUzKDeKXGwe10Xa9yYijGWG8qEFvLoSISwnwg>
    <xmx:9JctadEGkSWbhVVPWKjlyfTEc8Qh9Ufn0whaBRYjaZaXceMSP49etA>
    <xmx:9JctaTVes0UebDcQcA5tXoYVJmjx0mqkoMeFm7DmOIuJdi9oPBdhTRtW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 08:28:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 475e5e57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 13:28:17 +0000 (UTC)
Date: Mon, 1 Dec 2025 14:28:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] refs: add GIT_REF_URI to specify reference backend
 and directory
Message-ID: <aS2X7pI8muco7a1Z@pks.im>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com>

On Wed, Nov 19, 2025 at 10:48:53PM +0100, Karthik Nayak wrote:
> Git allows setting a different object directory via
> 'GIT_OBJECT_DIRECTORY', but provides no equivalent for references.
> This asymmetry makes it difficult to test different reference backends
> or use alternative reference storage locations without modifying the
> repository structure.
> 
> Add a new environment variable 'GIT_REF_URI' that specifies both the
> reference backend and directory path using a URI format:
> 
>     <ref_backend>://<path>
> 
> When set, this variable is used to obtain the main reference store for
> all Git commands. The variable is checked in `get_main_ref_store()`
> when lazily assigning `repo->refs_private`. We cannot initialize this
> earlier in `repo_set_gitdir()` because the repository's hash algorithm
> isn't known at that point, and the reftable backend requires this
> information during initialization.
> 
> When used with worktrees, the specified directory is treated as the
> reference directory for all worktree operations.
> 
> Add a new test file 't1423-ref-backend.sh' to test this environment
> variable.

Based on my reply in <aS2V4TKeS4V_oxAb@pks.im> I wonder whether we want
to take a bit of a different approach:

  - We extend the format understood by "extensions.refStorage" to
    understand "schema://data"-style strings and adapt the "data" part
    to be passed through to the reference backend.

  - We then use the same mechanism to parse both "extensions.refStorage"
    and the environment variable.

This would have a couple advantages:

  - We make the ref storage extension more flexible so that you can move
    your reference backends somewhere else entirely.

  - We prepare for a potential future ref format that _needs_ to receive
    data as input.

  - We have consistent behaviour between the environment variable and
    the extension. So basically, the environment variable starts to
    behave as an override to the extension.

One issue that we'd then have to solve is how to derive the worktree
references from the backend. Arguably though, I think that the extension
that was specified should also be sufficient to identify the location of
the worktree references.

We'd have to refactor the code base a bit though to properly reflect
that in our tree. One way to do this is to extend `ref_store_init()` so
that it receives the worktree (or NULL) as input. In that case, we would
continue to pass the combination of format and "data" to the init
function, and it would then know to locate the worktree references
itself.

What do you think?

Thanks!

Patrick
