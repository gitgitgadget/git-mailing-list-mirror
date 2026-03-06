Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1061256C8B
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 22:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835501; cv=none; b=MVOU1kssTzY8ByWFUyDUYtYwKn0xJxtDKoBKOsF7XfBPRavpTRdobwQHeETEOhJd7lh6UjNOfk4dA2XMI2/hwIhRXhs1jeZRjnT8k20TkaGibVZF4d/b1HW6p1Fw+LxUzkMy/2PnquG/4NH3ckiwi7cvyDH8Tk5dSsWv2OwwhJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835501; c=relaxed/simple;
	bh=dywQoiHNUrSYWiGs7LUqZGxFGBQO5mL8gYNKnkIYj5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QY60dKI1CdCOcMbyjctmiyNRKNSedg3T+qOJM5cXZr/4P0O1H2TgOK8RK2N7FmEmCof2XN+DDj+mscOw7n1ZOL3Itg3PfOTSmdgD1eM1NGQyr/337D7GXcD8S+fs2BqpJZHLVHSC//Tkuu+ZJ6VBtRLzNXZh1NDSzKAZziQ1Rt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ze9+mfks; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=urpNnaod; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ze9+mfks";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="urpNnaod"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C5761400144;
	Fri,  6 Mar 2026 17:18:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 06 Mar 2026 17:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772835499;
	 x=1772921899; bh=nVc98sE+iCLBSKkLVk7tbxVOfHfjB8Rl6idks8xVmOc=; b=
	Ze9+mfksQ6Heqrs/clK8kVFLMM8GY3UbipbpMV57O1FN6d57+zJ/FS5gwcyaCUPl
	OohIbO8g3kI0RVQtm5zXXPmPu+cSpqAKWQbbpG+fITEOa4wDWyIq5WKdVuxGPW+W
	mIEKXCIU4c9e5z3dVnyq9YIPZy6nXyOxczdEc4cFbHgP0n9ttJSjXRyqmQowHYjp
	P2Hxz5qywa7IXN5CFfMvhnaGLQzq7NUvXQwEsTUxtpAlMPb+ABjs8E9Tde/XvU/i
	m4ZrV9ODKf1pbvKOK9pJQL/4YVpV7QppJNGXgy1R85GY5ZtEO8q3ryCAoxZ8u+0X
	F64dJAKNoKP9AYNv7L3USA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772835499; x=
	1772921899; bh=nVc98sE+iCLBSKkLVk7tbxVOfHfjB8Rl6idks8xVmOc=; b=u
	rpNnaod1aV9gtr5ByFbL966fAss/V6KjhrIyelesCWocgKAIw856olH7smAPoaL5
	3BuL+gxL74iOkzek2lOGeYMa8uXe5qDQ5n43XTcL+gpXg7p0InzXVjeJaPj5BxIo
	XJI9mn1FOgTGQZynCFME8H+6kXTeiSliUHq8L7L+fEUyIQZIq0EtoNFavkpCuPrP
	8UnCBHzBZ+rYoWNuMQP6qs7VzOCxQwFxFWjh8kLDd5UHYRMW/AEU+/ZgYrBHvJln
	PJixi87XT57JpR+5wr4VWaZZwbZxoZPWjGORAiXKTl6luEvlIJ4dJGLcS6a4IWGL
	DBOhVsb46DAC2fs61Fglw==
X-ME-Sender: <xms:qlKraYVVi9xV5Rv5X9eLS-6ZC3Idd4SyA2e_8SoMQ1dWcksnXC7thQ>
    <xme:qlKraYQga7aatM3ub2oJx851DLAzYeg6aoAGefg0_Wp4Gi-ePoKg3HPJiHiyhOxWx
    I-I-W0yhYBjoZEmIN-Kqzxj0XmN9AI14YvRQfWQ752h87F1v2nImg>
X-ME-Received: <xmr:qlKraY1x-IxPN8bwWXPt-Rly3YQYPAgyihZRm56m0qDwtC8Qhf3PjyPIQv5FdRrmmQeOmly1EuSkj0KSaMDwNHio9RUmD_AEvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeekffekiedvhfejkeehhfegteeilefgvdelveejtdetuddtledtffeuuddu
    kedtudenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgtohhrphdrtghomhdpuhhrlh
    drqdihohhupdhthhgvmhhoshhtshhpvggtihhfihgtuhhrlhhmrghttghhfihinhhsrdih
    ohhupdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhonhgrthhh
    rghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    shgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoh
    eprghlrghnsegsrhgrihhthhifrghithgvrdguvghv
X-ME-Proxy: <xmx:q1KraQff5ovAz-DjUDzgqeQIRooak5WUdHEmVkpSMlSWYXoIX2cZSA>
    <xmx:q1KraYO3I4MUQz9H3P1-7qC4ep7-Elh8VvcRk_B7HAm0meFmWKKmUw>
    <xmx:q1KracU9mUe4gaAFKyLlPftLsvyAIwDZzZwdyboaWl5-AKHBddCkxQ>
    <xmx:q1KraYxbzLOZbA4M4srUtmH6yYG04YZp90HaOwPknmMnHFhxVLidCg>
    <xmx:q1Kraes1DHfFntX2isloEke-d95bBjROoYJCn35WwBd3Wxv5_3Ppumrs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 17:18:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Alan Braithwaite via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  christian.couder@gmail.com,
  jonathantanmy@google.com,  me@ttaylorr.com,  Jeff King <peff@peff.net>,
  "brian m. carlson" <sandals@crustytoothpaste.net>,  Alan Braithwaite
 <alan@braithwaite.dev>
Subject: Re: [PATCH v4] clone: add clone.<url>.defaultObjectFilter config
In-Reply-To: <pull.2058.v4.git.1772833649843.gitgitgadget@gmail.com> (Alan
	Braithwaite via GitGitGadget's message of "Fri, 06 Mar 2026 21:47:29
	+0000")
References: <pull.2058.v3.git.1772780113400.gitgitgadget@gmail.com>
	<pull.2058.v4.git.1772833649843.gitgitgadget@gmail.com>
Date: Fri, 06 Mar 2026 14:18:17 -0800
Message-ID: <xmqqfr6cy53q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Alan Braithwaite via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alan Braithwaite <alan@braithwaite.dev>
>
> Add a new configuration option that lets users specify a default
> partial clone filter per URL pattern.  When cloning a repository
> whose URL matches a configured pattern, git-clone automatically
> applies the filter, equivalent to passing --filter on the command
> line.
>
>     [clone "https://github.com/"]
>         defaultObjectFilter = blob:limit=5m
>
>     [clone "https://internal.corp.com/large-project/"]
>         defaultObjectFilter = blob:none
>
> URL matching uses the existing urlmatch_config_entry() infrastructure,
> following the same rules as http.<url>.* — you can match a domain,
> a namespace path, or a specific project, and the most specific match
> wins.
>
> The config only affects the initial clone.  Once the clone completes,
> the filter is recorded in remote.<name>.partialCloneFilter, so
> subsequent fetches inherit it automatically.  An explicit --filter
> flag on the command line takes precedence.
>
> Only the URL-qualified form (clone.<url>.defaultObjectFilter) is
> honored; a bare clone.defaultObjectFilter without a URL subsection
> is ignored.

Is this still valid?  It is inconsistent with the updated
documentation where both clone.defaultObjectFilter and
clone.<url>.defaultObjectFilter are listed.

These iterations of patches may require a bit more careful
proofreading before getting sent to the mailing list for others to
comment on, I suspect?

> Signed-off-by: Alan Braithwaite <alan@braithwaite.dev>
> ---
> ...
> +`clone.defaultObjectFilter`::
> +`clone.<url>.defaultObjectFilter`::
> +	When set to a filter spec string (e.g., `blob:limit=1m`,
> +	`blob:none`, `tree:0`), linkgit:git-clone[1] will automatically
> +	use `--filter=<value>` to enable partial clone behavior.
> +	Objects matching the filter are excluded from the initial
> +	transfer and lazily fetched on demand (e.g., during checkout).
> +	Subsequent fetches inherit the filter via the per-remote config
> +	that is written during the clone.
> ++
> +The bare `clone.defaultObjectFilter` applies to all clones.  The
> +URL-qualified form `clone.<url>.defaultObjectFilter` restricts the
> +setting to clones whose URL matches `<url>`, following the same
> +rules as `http.<url>.*` (see linkgit:git-config[1]).  The most
> +specific URL match wins.  You can match a domain, a namespace, or a
> +specific project:


In the test script we see a handful of lines like these

> +	test "$(git -C default-filter-blobnone config --local remote.origin.promisor)" = "true" &&
> +	test "$(git -C default-filter-blobnone config --local remote.origin.partialclonefilter)" = "blob:none"

added.  They may have been written to mimick an existing line in a
test elsewhere, but see efforts by others like

    https://lore.kernel.org/git/20260305225128.54283-1-francescopaparatto@gmail.com/

Thanks.
