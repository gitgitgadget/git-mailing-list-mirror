Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346813148AE
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 21:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054029; cv=none; b=ESBXVfUfzLr/3AoSiTXpKMOLZKWCQkEFkEpJcJ+Dya4ejb0tpDf02Q6xBB2PjLIpsvDtvvPq3mtrdE7GuCrJHMGGge+kM2SkN5+Lf1KFJst2fEtmUfWvbPrT1yAlTd1DV+kq9OgGKN9Y2mVzwWMeclwcsWtmSjKk1FxQSorNXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054029; c=relaxed/simple;
	bh=5pYHsAw+GCY6e2sqK2kI/PL+0swqHOPeiGUP9bHfXIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Inz+6egDDX4ReXz973wPJstmQwIYToCHzOSPwaT+CzFdvZG9PJdPSNRVgFXBejKZ2bjpEjY5CHg0MU4X7N1yALxY3tmBGiGNnWOD9HsuD8QXZSEC7WLBEQcCr7QRCMmtlj5uTQ8ZcnIAlsKhln8SeOGnqht0d2GJEapDfezO/RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SDlIvqn/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HPt828Kv; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SDlIvqn/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HPt828Kv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5034114001E0;
	Wed, 25 Feb 2026 16:13:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 25 Feb 2026 16:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772054025; x=1772140425; bh=pX/XVvG22+
	a+gXw74XN8Uzb0xBIJ+zdNY1etEskXnyw=; b=SDlIvqn/MRrfiZSYfPImHqjfrr
	ht7H1ep729s/bmocRvvh7WGD3dO0LLeuXrWe5L/fjIog/K+AHk7ZgoOoutpzMC6o
	78gRZzFySprFInK3k5QKLUX1Lhq6gniTg6r7GHydapE+Uv5k4o2yEGabw8UTsWg9
	G5YcfH5wSxuwxLlgGpwwrNjdwuQQVunZij9DCG3Z10lVBSfj5IPslDjdIptgGA0o
	+zwN4pU6ZJUANeTjaTDJYj2ku0Zj2H/PqM3QYIFrb1wMVu03ea3ySuIKZ/BbwIoz
	kqmyloHPZEhBJBNPyOjs2d/UWVciCmX5jDFB6AUJwy95heT/B1Cp7O3VMiTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772054025; x=1772140425; bh=pX/XVvG22+a+gXw74XN8Uzb0xBIJ+zdNY1e
	tEskXnyw=; b=HPt828KvNPpxXxLJfVtm3uWtMCJoaUGdQa9GPv3xWp7PBSG96Cc
	i9zziIKHqevszvJBZdUiEe8XyQ68NfF7WK3S9j4IQryPuG5Bu+rCophOE1h+5DXs
	Yr6SsANut3dsaB9l6eksR+KXSixVJUIMVAAEKLFlrV1SBJ0Ob0Ff+V2/Gk6pzrEu
	+9QMrh5mLaN0i/c4nZ0hwAoOgO/2fjXFoUYV/ywoIg+EezW8C6vy8RgnpDdEuxJ3
	Q8O1xCm+g4Apvm6xrVB3JBmiyfhOJMypWlKZWFQ4x1r8N2BS8ptUqn2AGxgxVw5l
	O1UIt48/Z9O2VzxhQA/MFyCkNj+zFF2nNCA==
X-ME-Sender: <xms:CWafaWLwSlya5llxQKw0IYqm23aHVLtv2ySsoDK1mRa-y5Zb3rUulg>
    <xme:CWafaVBMZVFYt-7Wdlh7x3t1uQJqJWUB0neunlndjycO_UCYn6v_5L6fqSNEMRquc
    XiOlgqIbQfSt1Y50Pl5h20G6Zkj50dAcDlqNGLsNTpxR8qRMe1Few>
X-ME-Received: <xmr:CWafafDwgwc4xmPepUi3F9kfMtGbSSd834Pff2tCIRNeuPIb85vCefn1HhvbLPaahu_sgTdPZvyX2ZRoKNru8W8Su-JYParisw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepghhithhhuhgssehprghulhhishgrghgvvg
    hkrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:CWafaXBghoCTjtfmHocnHyOiRh_VVx5ptDp1Ar-wVdCyKfctrCm__g>
    <xmx:CWafaapsMbBoXhfvIUrWRzl7jPmqA8BMX1OxJABqtYV-lQbr5uLSWA>
    <xmx:CWafaRlaYAkSjbdpmvd_X802teNFdIforikUYkq4vTY48SBFmDYoSA>
    <xmx:CWafaawaPqLTKS3s2O66b4AGG2SpXMnbdDz3fvhdEL5IQoL4si0zgw>
    <xmx:CWafaSdDx6E6HPgh0zhQ6LYjYHYVneNmDL1hX7NYlOjZojkBmHrY6SmX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 16:13:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Paul Tarjan
 <github@paulisageek.com>
Subject: Re: [PATCH v6 04/10] fsmonitor: use pthread_cond_timedwait for
 cookie wait
In-Reply-To: <0051a1930349878fd25bb5d2240073beef36da7d.1772050636.git.gitgitgadget@gmail.com>
	(Paul Tarjan via GitGitGadget's message of "Wed, 25 Feb 2026 20:17:10
	+0000")
References: <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>
	<pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
	<0051a1930349878fd25bb5d2240073beef36da7d.1772050636.git.gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 13:13:43 -0800
Message-ID: <xmqqzf4w8r20.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Paul Tarjan <github@paulisageek.com>
>
> The cookie wait in with_lock__wait_for_cookie() uses an infinite
> pthread_cond_wait() loop.  The existing comment notes the desire
> to switch to pthread_cond_timedwait(), but the routine was not
> available in git thread-utils.
>
> On certain container or overlay filesystems, inotify watches may
> succeed but events are never delivered.  In this case the daemon
> would hang indefinitely waiting for the cookie event, which in
> turn causes the client to hang.
>
> Replace the infinite wait with a one-second timeout using
> pthread_cond_timedwait().  If the timeout fires, report an
> error and let the client proceed with a trivial (full-scan)
> response rather than blocking forever.

I cannot convince myself if one-second interval is not too frequent
to force everybody, including those with working inotify, to poll.
I wonder if this is something that may want to be configurable (or
better yet, auto-detectable, but that may be wishing for moon).

> Signed-off-by: Paul Tarjan <github@paulisageek.com>
> ---
>  builtin/fsmonitor--daemon.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index 4d52622e24..f6c406ff12 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> @@ -197,20 +197,31 @@ static enum fsmonitor_cookie_item_result with_lock__wait_for_cookie(
>  	unlink(cookie_pathname.buf);
>  
>  	/*
> -	 * Technically, this is an infinite wait (well, unless another
> -	 * thread sends us an abort).  I'd like to change this to
> -	 * use `pthread_cond_timedwait()` and return an error/timeout
> -	 * and let the caller do the trivial response thing, but we
> -	 * don't have that routine in our thread-utils.
> -	 *
> -	 * After extensive beta testing I'm not really worried about
> -	 * this.  Also note that the above open() and unlink() calls
> -	 * will cause at least two FS events on that path, so the odds
> -	 * of getting stuck are pretty slim.
> +	 * Wait for the listener thread to see the cookie file.
> +	 * Time out after a short interval so that the client
> +	 * does not hang forever if the filesystem does not deliver
> +	 * events (e.g., on certain container/overlay filesystems
> +	 * where inotify watches succeed but events never arrive).
>  	 */
> -	while (cookie->result == FCIR_INIT)
> -		pthread_cond_wait(&state->cookies_cond,
> -				  &state->main_lock);
> +	{
> +		struct timeval now;
> +		struct timespec ts;
> +		int err = 0;
> +
> +		gettimeofday(&now, NULL);
> +		ts.tv_sec = now.tv_sec + 1;
> +		ts.tv_nsec = now.tv_usec * 1000;
> +
> +		while (cookie->result == FCIR_INIT && !err)
> +			err = pthread_cond_timedwait(&state->cookies_cond,
> +						     &state->main_lock,
> +						     &ts);
> +		if (err == ETIMEDOUT && cookie->result == FCIR_INIT) {
> +			trace_printf_key(&trace_fsmonitor,
> +					 "cookie_wait timed out");
> +			cookie->result = FCIR_ERROR;
> +		}
> +	}
>  
>  done:
>  	hashmap_remove(&state->cookies, &cookie->entry, NULL);
