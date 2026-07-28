Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AB74749E7
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785278707; cv=none; b=f3wH0j/NNwPmI0dSnrLxaJiZrcyialPdFIkfIE/0OeYJ6srT9S0HGGJ1tl+SDk8VrBVeD2/RqxG3T1PjuMks8LrSdHHFaDd23Zg6bSKKYYcTAK3bcDkrlR5zSIGFg7WBVJDgoiR1S07LsKcNULwRfYBakI9aEsTd9BxVQF+bTJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785278707; c=relaxed/simple;
	bh=T/wddv4dHiT40/2l06Qb9FeU6qOpjFgijbBpOPPNLEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K2MhYn7IgYUHe0SS7/cPkRJArcu1B3GyGHvWRtfaNXGyxjL+Hc8Hn64hhCjWAPY9FF69uf1fMNPBQujjTxqyNPmbSwWX07WduEVkUxGdKz+0AJ8/u+yEwLPQ2V9vUzRFWqyotYsIP2H1mVKIw36RRL4oYFEiK1jrXFHM+dts1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X/GNYPRy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O/jfoa0o; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X/GNYPRy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O/jfoa0o"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 04AE77A0465;
	Tue, 28 Jul 2026 18:45:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 28 Jul 2026 18:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785278704; x=1785365104; bh=kfzRRk1bRb
	fMFwzFc1g9tCQJPb7uSSUuxNWvYOYXV0U=; b=X/GNYPRyszNkRheorbmYl+iLqM
	3I5bnaZSon6ZbjEacIcMKVpJbROgTLojSQWGdg1qseMfwp7nKd1lKnaITd26SCU4
	66KiZtNdh4lajHTCxJJFU0hCqgzNlIkfcYr0iG6G8pSHy5eWOyGjYcm8gBk+yhsI
	DnZQCgRJnPLsjJ6uudUDap3z52wcBlNsaKNsPbhm7p/6wfjjZtWWRbpms1xlP4b6
	FuNRKdEy/JA4+HRmdyhr8DmX+rbKM8PMe0qMAlAWDsgf3TDx2pJgdLRLnRW6nTtT
	5Bj7ulie6uVBJG1ET5ZeZ88y4bm1UzLFI9LH1VD9/A7GX+auetqRQe09CQew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785278704; x=1785365104; bh=kfzRRk1bRbfMFwzFc1g9tCQJPb7uSSUuxNW
	vYOYXV0U=; b=O/jfoa0opxxEGbqHYRPaFMfvjZmDHYOTWJjxmltIP7nrLYrjF6Z
	mR4hGIKuCQeOqpW44jUwFc/Khi3KJnlyPEHt0vDsHeMLtz+GnY8da5jC/MLUkFcG
	WLrgr+7yZO6Xfoaeq40AwIJ4hpRCtReHTJnS57GCRtnQFMAf9xLiUgTVEQ/qoTIJ
	CXsfd4ez9hZ4AK5E98dVD0Mm+ChhQ/v1/Cci3iZg798MlYETSfV67UvoSAX7FiPe
	9PX0Sqav4iY97NOdR0reSa8taIJ5HcRXSPuhXKMho3PmnXyryTXsbnLPXr1tX5nE
	7YNBP9t1U51enmjefR9Lu8aDYFd/EwcglBg==
X-ME-Sender: <xms:8DBpaggjs8ec8Ng7S6qJy7dKdcy_mwVX2wsVJioacYN5M-27AgoynQ>
    <xme:8DBpagDbTZfKI_N8qhC7FWN4DizheWie1Gx6PSVfmUjyOzf9nEk1TJ0WMUUV5AYM2
    ZWuBM87H3gTx6VO64908tUGovflN3YRoxMoVEE5BsRt_ANmVjkwKZI>
X-ME-Received: <xmr:8DBpatFM0rDQli6lPY3lj-aQvpajSCk6yWQcvi2gV9Q6QcisJWwA1g0GBFzudYgWfyBVyBYjHkHJixqKnvjUMcwcDRo86a561w>
X-ME-Proxy-Cause: dmFkZTEnHx4o2bOH7IWco/Ey0SeIm14ntGS5rmcN1b5MNW/Av8cbpVQqkxascLllWDEpDP
    ksVbOXbnPuOi8/7FDrlQ7EieFh4GMEhQBtBOPTWnn7/TDc8MPdoBTFvhKbjSKVVNJZOpNJ
    VU4I/1KH82fUl49TmWYA27AV3r55H4Xq/VVToWEuoC8KWQeH8D75H8PpbhlhM18dfwJ4jC
    n9a6A73QcdqtoGfp5L5n1/X8/AOVEqKI3ExgPVBYdfogQW3cVNgbHFjBkd54+vlKZQkDez
    8vROptRLpQBunJSH8kDXU6Lefpid/PtYwIc2nOzboDxIV0qhQ2ZYzufkIAtr+2TsF3EmNc
    /aarsPB2fmLxXqV4GtmpucsWhu6T/S7/DV8vzp8EWsO9B2oxjfYD7H60PlhsUtceN6LuNu
    NlhUVcqt2rDQHFjw45EXXsGzxkMMaEAeb17BY8h3RZd1fLcy4sZ7f5C0pfgv1ss4bv5qcf
    Hv4HSd9N1331+hHRvnAjVyyaDGpcSJYgkJ7VMKVjzwOt0FM/CX4HbAB5TJo0qz+zbFxacm
    Qs5oNyM/S02poM+KZw8Mw88ImwfHxB/EN8DMQfIehpxKrXx41T3KFCbVY4EBwalnp+Divv
    lLENteH+/4+EUwaGxBFzpPCNQ3bxOplGUTpCBs2tcRq2xrmwS67mB4egBtAQ
X-ME-Proxy: <xmx:8DBpagKJWiKgaNetG0RHuZxd1MEKgL4kzrqdRY54JsRQpqNBEf31uQ>
    <xmx:8DBpaplXva7jmfA-ynx6mpEhAQyeWHtzG5q-FOPpSlxlqJyzsLWRyw>
    <xmx:8DBpagQQ9ECy6FmZSpsNX6u7w796yhTLEzfffvJ5T5MUbD0jIqT8NA>
    <xmx:8DBpajJ96bEDQX6atihfYbwO4gaZXD4a2kyUWnYdzDYrrxMDLAnLeA>
    <xmx:8DBpaicBCIJR_LOHf6U8hV6LhCT10ElMNEtOzEzGPqEJlMjMriqXQpmP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 18:45:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mingw: skip symlink type auto-detection for network
 share targets
In-Reply-To: <pull.2189.git.1785239196007.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Tue, 28 Jul 2026 11:46:35
	+0000")
References: <pull.2189.git.1785239196007.gitgitgadget@gmail.com>
Date: Tue, 28 Jul 2026 15:45:02 -0700
Message-ID: <xmqqcxw6d98x.fsf@gitster.g>
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
> On Windows, symbolic links come in two flavors: file symlinks and
> directory symlinks.  Since Git was born on Linux where this distinction
> does not exist, Git for Windows has to auto-detect the type by looking
> at the target.  When the target does not yet exist at symlink creation
> time, Git for Windows creates a "phantom" file symlink and later, once
> checkout is complete, calls `CreateFileW()` on the target to check
> whether it is actually a directory.
> ...
> Note that there are legitimate paths starting with a single backslash
> that are _not_ network paths: drive-less absolute paths are interpreted
> as relative to the current working directory's drive. In practice, these
> are highly uncommon (and brittle, just one working directory change away
> from breaking). In any case, the only consequence is now that the
> symlink type of those has to be specified via Git attributes, is all.

Thanks, will queue.
