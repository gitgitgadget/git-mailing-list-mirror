Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E0C342173
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762454530; cv=none; b=OOfO+TGLS+fCyHo1RS4BBp2JZ4n+qPd4xRdJXsLPl5maPAZ4HSNrOl8cdS1mmkweSN8tIQzxcF9kEnqB3z/onK+VmLIJdfljMg4+kf85WlggShK+BLzMWM0f5JTeVAY2IzIZs1f+wR47XjhgWlaZbl7P68kRFkRj1A8fino9ok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762454530; c=relaxed/simple;
	bh=3v3W1lI2hKB+dQBjBVURScs66yS0nnPGpiBMKBzTljg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kIBpxvoLZVZjf6MSUm64BCSLdUIdQSJUcbnESWwqsQ8SzkTloljnXSL1rqqISyaP+3li5G+n0KOY7tXuyEMWbnI8Fe5QJhMpDVOExAe3skZQ7yBzmLf8SJ4CyZOwlbQipAYMBB+p+s8S9XkuFIV1d1MXY75haJYRxasOub8ZkVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n5Iix1m1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wMfkL8gO; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n5Iix1m1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wMfkL8gO"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70A4B140011C;
	Thu,  6 Nov 2025 13:42:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 06 Nov 2025 13:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762454525; x=1762540925; bh=lhriG2bWY1
	bwoowjpZdnssl3nYQZxHmgpAdO4I/fTmI=; b=n5Iix1m1ypn2shzLPSY4vEC+Ny
	+Yh283YsoIsyDpPKxglDu3rTxb2vHqtGFhUKA/9R8jDGzeqOaTPZ0MwCRy1HvG7K
	THR1m28ClmDFQMLsIXLRAxYGLAHSWhIy9GAtnoDnnJAKrs+QgECIaSYlRxN+z+8f
	26zFmqtQ0OJ4P5dUIK+6qyDX0iJLyv5mcC9pvMbu4RG/hI5uW9rwiZQAXkNsOpoY
	4GaB47BqeJxPxwCbBUK2sJAkmVeUSwT3BV0lDP4Oq/9i4yikvvQdo1aQDKQfy4pt
	AZRSwZcJnq7i7ce4H8/Z+W75ApEaCcuSd84vCF6PKnsOh5x+Mtvr78/Re49w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762454525; x=1762540925; bh=lhriG2bWY1bwoowjpZdnssl3nYQZxHmgpAd
	O4I/fTmI=; b=wMfkL8gO2+k53Ya2lWvxJb3/HEI0AU7Dg4vn+S/apsfbURtxqWn
	Bryvat7XKkMRXBPv/6YldZaiYvLSUAPUs7zACgHdAzfThcguuhDM7gNZL3p/zKtA
	BSjyGLCYR1yWnzpd4cew7Zb9WfoSJozl2xWY+0DkaW6ZBkALt5RIY5x/N5roLsuf
	egLIoH5dyQFj+nou8TVEp+CP7oDq2lskoLaFpZv/w8LfoZ/TAXbgKwSOMfYgPheR
	qLhnQqlHNeCU8cLtCqypMSH0NlH6qKsEZ85DgT5H34/gnlG9ycAFuvQMU7L4yAcU
	NKYrNMCJQeBv27nmRRgmIw6arnBkVJGqYzA==
X-ME-Sender: <xms:_esMaUVvp3_gX6SwGzjHJnBTHPy43noOXCquvixmcCsOnwKFmApVzA>
    <xme:_esMafkeDZVhPY-FfJnC-foNxglxtbms6M2SHrk6-MsdKXTwJ87NyEv3z53CJOz2u
    gNOL1SKZkmPiWTIEcBm93mHnj9UiLx0s2FmWtWOvwdpzw1fZGVaWA>
X-ME-Received: <xmr:_esMadbz3ynO71l9aMfZyGNDbTn3w5R3pBH9fYTKb00q6h1kWV1_isYrMz0GiG8kOHnr6FiYDX9GkpjTnMbsvuW0ojfD5_L2LZ_v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnug
    gvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:_esMaSMk1T9ON4m8uzM9a63dN9GfVL2M_4et5XDmRXtMcGBQ5ICpAQ>
    <xmx:_esMaaYKvQMc6VAPj8QomErrMOymUAXuuAWLZAHyJgCvr3THF9iptw>
    <xmx:_esMaY36rIK4Lz1lcoHiNJAl-HboGv6jrYCUTrMmcMojys6my8NaOA>
    <xmx:_esMaYdvqNQ5yenFae6nuWpbVA6SAoJD8Sn6zXc3HsYZLFVlQtPHtw>
    <xmx:_esMaawbGABaEIrIxjzecebZDcapQyJHMmAe1GpkqowY9bmuiABPRFxZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 13:42:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: update {download,upload}-artifact Action versions
In-Reply-To: <pull.1996.git.1762437576488.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Thu, 06 Nov 2025 13:59:36
	+0000")
References: <pull.1996.git.1762437576488.gitgitgadget@gmail.com>
Date: Thu, 06 Nov 2025 10:42:03 -0800
Message-ID: <xmqq1pmbhukk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Bumps `actions/upload-artifact` from 4 to 5.
> - [Release notes](https://github.com/actions/upload-artifact/releases)
> - [Commits](https://github.com/actions/upload-artifact/compare/v4...v5)
>
> ---
>     ci: update {download,upload}-artifact Action versions
>     
>     These changes correspond to
>     https://github.com/git-for-windows/git/pull/5914 and
>     https://github.com/git-for-windows/git/pull/5916.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1996%2Fdscho%2Factions-updates-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1996/dscho/actions-updates-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1996
>
> updated-dependencies:
> - dependency-name: actions/upload-artifact
>   dependency-version: '5'
>   dependency-type: direct:production
>   update-type: version-update:semver-major
> ...
>
> Bumps `actions/download-artifact` from 5 to 6.
> - [Release notes](https://github.com/actions/download-artifact/releases)
> - [Commits](https://github.com/actions/download-artifact/compare/v5...v6)
>
> ---
> updated-dependencies:
> - dependency-name: actions/download-artifact
>   dependency-version: '6'
>   dependency-type: direct:production
>   update-type: version-update:semver-major
> ...
>
> Originally-authored-by: dependabot[bot] <support@github.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

The above description, with three-dash lines interspersed, looks
somewhat confused, but the contents of the patch matches the title.
Both upload and download are updated.

Curiously we have updated download side less than a month ago with
d014fb29 (build(deps): bump actions/download-artifact from 4 to 5,
2025-10-16).

Let's merge it down before the final.  Thanks.
