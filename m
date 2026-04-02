Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848FA37CD31
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775154428; cv=none; b=F+ioLTI1mM/0dzirh3fSg7ntOtqOoAA7hHXQ9SkdSBNIn1yX18zi77RxzXWk8qCX2VqHA8T8i92KRBOfha0SeiwUarMtc7YZMeYxdMfasyKE7s9cPjmJka6/Al5KsVlVdENzAUiI6YwYG4m9r0WusCaYJWuL5hQmUR8SOEuVTPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775154428; c=relaxed/simple;
	bh=bZNzeb42mC+oVoOH1AMzoKVhAcRnga9be/Sxyom7j0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r+np3J5y5dXEqvMmmWaMrYPSGXvmKNTS0SjuDwv4SZY0aPPZQZ9QOIkez3z5lUBHNL++7YCUpM5e2fR6OySFm5tXsS/2ow9BLQmr8oY6XmCfA7KgA5aoGEXd+zrYxXObtC3QVNYWby/ApJo2UwshQYxbJaNxLdqXUy1yiKfH0So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uiAY8ypy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GoTiIMoR; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uiAY8ypy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GoTiIMoR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87C95140002C;
	Thu,  2 Apr 2026 14:27:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 02 Apr 2026 14:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775154425; x=1775240825; bh=3kULUHm4Qp
	ge35x+bVYQVg+YbXlVVH12oGW7EXVrbCQ=; b=uiAY8ypyBRnsEqTZDyQNQF3jxU
	G7Tw23t1a+Ud4/+PADHLIUUoqD3woFpHbbE3UAll+PBEB4A4lyrA0qX5F/f48D+V
	M/hTPut3vULlCkMKpLo/4fRenttSgLXV58eeQuU4l9yLw2JO9rIpiUgvmYlbbu5Q
	kwR79jevl0WMxVjPoIa3CPtaT3qCFssCInhKrXKRhd7ShW1a+UrP3G7jhg90gF12
	YEDMxGD8l+htwPhst/I0StXY/KyMQUhloNhQa0YDXHqFdCXPVhta9qpN4jYQ2j6v
	P0s3Od4evPPA2Rdc3p9rHHmchO2q3oR3qSfvkAkhhhA/LfLryTgcrl8+y2Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775154425; x=1775240825; bh=3kULUHm4Qpge35x+bVYQVg+YbXlVVH12oGW
	7EXVrbCQ=; b=GoTiIMoRX7asJGPAMMxs8Xp3SQ6qMv+xBjkmNSsaYhorurewzi6
	CMSe2yzgXJb8jzMR6gHclV1AkN0jc29cjbysKdlYcBNyazm5So2KWVzstd2E13q4
	0K6tzJWihaMVmiWS+GwKcKDgBX9jzySUDwCyjrBgsOuqTtJ7Ec6Wbi+G/n8p60HP
	U8Z5gY0vPmeooutn0H8GzGSDzfgMVq7IF+ZvlLnTvIRg06MAhCOM61HuBO3JwrBR
	1c04uZ7IxqUTD9HXMUS4RwE5YUTjvv9gq7S/BPiVk45naqiv0AtmQkgJGnEhqJWL
	OP1zXCCLOVpI6z1KNvgYwTVbvIlElHMIuLA==
X-ME-Sender: <xms:-bTOadGpZ4CcvH3HV9IP5DonHunnjfzKavmaLsHKQ7sXVJlE0UsLQw>
    <xme:-bTOaZP6jbTeFEmkwjhCrFzCh5m6PMRdm-3Ckh3UCVkJQEbhbZfbdq-BAp01g89vP
    GYhD06T76GFnGpJvUeNtoJSe_T1pm7ad0SNdT2zR5hCdVnLX_GCW4g>
X-ME-Received: <xmr:-bTOaXdVKoyOY1h742303mSdcdR2_1xabW6cO-FBiPu7aQJMgBypU6uQYlSuETUVLSR3ehTKUBtgy0ER2wE8YtKUxmBwnsBCQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-bTOaet3JDgMj5rLXEq45ZhLpS1ONI1-ANeguhHtXZ8wAfxS1_Q3-Q>
    <xmx:-bTOaQnu_TZBnapghut9cTueekzWkpuGEMK8ePIYPJ_c3Bi-5K-CbQ>
    <xmx:-bTOaYzJQtAWfeqnETBBinaDaYrc8W5lpvc7aUByGbxQ7t1i5FqSDw>
    <xmx:-bTOaaPgzDhcWTt_NpjfBjsyOgyOXv3TqjXk5hccUGFxzBQaMW8fWQ>
    <xmx:-bTOadrLWtF8NCOJwpIGCxoKzp0O3aRjX52AieUV6PN3MpvHE7TJO1MH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 14:27:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  "brian m. carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 4/5] reftable/system: add abstraction to retrieve
 time in milliseconds
In-Reply-To: <20260402-pks-reftable-portability-fixes-v2-4-bc110cee0ae0@pks.im>
	(Patrick Steinhardt's message of "Thu, 02 Apr 2026 09:31:17 +0200")
References: <20260402-pks-reftable-portability-fixes-v2-0-bc110cee0ae0@pks.im>
	<20260402-pks-reftable-portability-fixes-v2-4-bc110cee0ae0@pks.im>
Date: Thu, 02 Apr 2026 11:27:03 -0700
Message-ID: <xmqqa4vlqkug.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We directly call gettimeofday(3p), which may not be available on some
> platforms. Provide the infrastructure to let projects easily use their
> own implementations of this function.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack.c  | 27 ++++-----------------------
>  reftable/system.c |  6 ++++++
>  reftable/system.h |  3 +++
>  3 files changed, 13 insertions(+), 23 deletions(-)
> ...
> +uint64_t reftable_time_ms(void)
> +{
> +	return getnanotime() / 1000000;
> +}
> diff --git a/reftable/system.h b/reftable/system.h
> index a7eb6acd4a..071bfa3d58 100644
> --- a/reftable/system.h
> +++ b/reftable/system.h
> @@ -111,4 +111,7 @@ int flock_release(struct reftable_flock *l);
>   */
>  int flock_commit(struct reftable_flock *l);
>  
> +/* Report the time in milliseconds. */
> +uint64_t reftable_time_ms(void);

This must be give the current time in milliseconds, measured from
some fixed point in time.  It is up to the implementation to choose
what absolute time as the epoch, since we only use this to compare
one timestamp returned by a call to this function with another.

The "we do not care what epoch you choose, but you have to be
consistent" requirement may want to be written down here, though.
