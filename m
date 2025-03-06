Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBD21922ED
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282046; cv=none; b=Oe02s0zZf5FEPokPUNr8Q645o5/aS1RInVx8ykT9Qz1pcIZ2fDVs9k9YmRm8lOLWK+TBv772Y9uI6pdxG1ABasOe1kKYTPirFTSeFFOyVOp1Hw38D2LfSiliO/AE6aOOCQFNd+VoOrb5Th3ChOWJoiu+nT/MYMsC00t1hZeE0EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282046; c=relaxed/simple;
	bh=JyaFXsnN7yX6qDG391MjPdvc4/6Aq3XT+x2uhAJJKVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c+KNTcxd86i7RnWrYxKDnMq87Qg4U7ojPLIwepg+ZPui0Cag/4jLPM2GPcCUbpf6HWC9VBcGSIbME/kvYJCyt+M0LfS25jV0Xpz/79E7E/lpWJWg5NlGm/LxT8kLNWJbSSaTqF0nwGbioCoxQbkfQinw53dfkzoMe9ICbuiRjFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=houNptI2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QBBLRG1P; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="houNptI2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QBBLRG1P"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 80A341140138;
	Thu,  6 Mar 2025 12:27:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 06 Mar 2025 12:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741282043;
	 x=1741368443; bh=Xcd7cOsXZSCIdAIw6JvFMWZ4VLrET4GjSBRZpXWtTmI=; b=
	houNptI2mr+MKe9AQ1rfV/X1X5sQHl2uwogvnpJjQ79ur+TQLWgB6PbkMXbDkUB/
	Eu7Xo0x1d13d+ZuUhGQe6upWs+Sb5U7rnU3RobhI5XRh1f8c8Ynp1lMLItQ2pMne
	3Xom1nw4DFsimsv4NSSWJ2bewbC35jrjBKfBMYCZUwh2FQG6ba+u7RkwHQ4iMJvq
	1NSRm5HtEc5GWmZVKqIy0hIKha1n4O5NXcXk9gTMQAfhi448MavVjzkP81L+cwpD
	MD/rQcNPAOSGi6fHjf6ENJOZFHVOiQLsDI3pg+X788r4zVtcOzMvnKRL+aidShW8
	50lx2BtNfrRifI3LES9/0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741282043; x=
	1741368443; bh=Xcd7cOsXZSCIdAIw6JvFMWZ4VLrET4GjSBRZpXWtTmI=; b=Q
	BBLRG1Pqm2SSpd7DegPgXzkrB2HiE41hgoF2rqw1wGO/Y7HKAbMlLO1UWuqAKt9G
	NAs0mIhb+z4pj8TrpakDZbkQpt2xA4iLO7jtTe6XeEFSBVelfgv0BOvkJ5cSS7Ml
	QFklUbmq09NexbamvmdmvknrjWcTVu4rIFqKV0LCIekJyzED8jgrWTKwckux1CzA
	xJHO+6BZaacqJk6Bl1//o47tE/Ag38lsiCVD6MuWhfK87yxA3z86py5MkudzP8IK
	se9OfIpix/x7RlfhtwidaI97V6UfDpD1IkfUA5VyenGSJT4rNfXtTtfOraWIQ6VL
	xzBs7ZLH84HR4pxOx6Kng==
X-ME-Sender: <xms:-9rJZzTNAqyr6J7kAHLbFdaQQG3MlgqM6pnrn1Pgy0OmE_7wmjeGDw>
    <xme:-9rJZ0wzdE0WMKuOX_cj2bfQUwNpJvq3zpkWr9Bx96yx5HhB9eDTqEYyEUO_RRM1T
    0osheWmV79m7wpxhQ>
X-ME-Received: <xmr:-9rJZ413AIoX_SDjQ-BbKnLHlsIVc3vU-BPQ9YYOs4aXbc9CsKk2QUk5JQbG7Zy4firiZ55zQjtfVRgPGf99pd4MZHfozXajqzE_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehsuhhrrghkkeektdeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:-9rJZzABe-5P3FsUjN6z9uVkPlLvQc5qbQ8cwl17g9ujx3sltyPH2A>
    <xmx:-9rJZ8hl9AG_U-3s_0PPDvqHuwaRE4HS-og6upDhCIk4OeDd82RDdg>
    <xmx:-9rJZ3qixy038DZyT49YmzgZ-gHGX1BpfXZvF2wfEOlWb1it_4WhUA>
    <xmx:-9rJZ3hbD-GofSkPbF_OBJvINNYBxocNQBzQUgOUTUQeXjrm6h1hCg>
    <xmx:-9rJZ4gowUMI4u-vRAzUIkNL3NRHNAnENIQzVKc1Z1cbB6IQLW224xwL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 12:27:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  SURA
 <surak8806@gmail.com>
Subject: Re: [PATCH v2 2/2] refs.c: stop matching non-directory prefixes in
 exclude patterns
In-Reply-To: <67c8c5f797833a9a35f4805059d7e759020f54bd.1741275245.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 6 Mar 2025 10:34:53 -0500")
References: <cover.1741223981.git.me@ttaylorr.com>
	<cover.1741275245.git.me@ttaylorr.com>
	<67c8c5f797833a9a35f4805059d7e759020f54bd.1741275245.git.me@ttaylorr.com>
Date: Thu, 06 Mar 2025 09:27:21 -0800
Message-ID: <xmqqjz92hxxi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Taylor Blau <me@ttaylorr.com> writes:

> So there is a subtle bug with '--exclude' which is that in the
> packed-refs backend we will consider "refs/heads/bar" to be a pattern
> match against "refs/heads/ba" when we shouldn't. Likewise, the reftable
> backend (which in this case is bug-compatible with the packed backend)
> exhibits the same broken behavior.
> ...
> There is some minor test fallout in the "overlapping excluded regions"
> test, which happens to use 'refs/ba' as an exclude pattern, and expects
> references under the "refs/heads/bar/*" and "refs/heads/baz/*"
> hierarchies to be excluded from the results.
>
> ... test (since the range is no longer
> overlapping under the stricter interpretation of --exclude patterns
> presented here).

The code change, reasoning, and the tests look all good.  It just
leaves a bit awkward aftertaste.

In general, I think our "we have a tree-like structure with patterns
to match paths" code paths, like pathspec matching, are structured
in such a way that the low level is expected to merely cull
candidates early as a performance optimization measure (in other
words, they are allowed false positives and say something matches
when they do not, but not allowed false negatives) and leave the
upper level to further reject the ones that do not match the
pattern.  If packed-refs backend was too loose in its matching and
erroneously considered that refs/heads/bar matched refs/heads/ba
pattern, I would naïvely expect that the upper layer would catch and
reject that refs/heads/bar as not matching.

Apparently that was not happening and that is why we need this fix?

Is the excluded region optimization expected to be powerful enough
to cover all our needs so that we do not need to post-process what
it passes?

Thanks.  
