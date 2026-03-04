Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEEE3542E1
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 07:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610173; cv=none; b=WN70BwowgMrjBDUYdfacJf/di56eRP3xv9q/TWeBuo27RyDTaswM4AcH3ikSl4puSwAprUKvgDHxg/NNHVhfMCtK7TMkEBUJUmhDJOXlnJdoawXTuDwkxJj7Sy+1AwXc0T9gmxqOI+u9DQbNKp+S/8Qp9bx3ayjFAMgdCpPtGP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610173; c=relaxed/simple;
	bh=O+26+DyLlfdW0CXuBMZ0qHq+3kTd21O3gHAWG7YIgo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GezO4rjfp2jVRW3VTXNqvuSv2HdCWLJw+THiUEbDvuF7T+gNoNmayOFSbXkl2CqYClXIsEnvRsi/iXP6kyC3BhGrknF5ZYdWSdFPTnqO2mQFycerAkHlxiHf/Vucokz67pUUCMuor/JYGlwvnf7VQ10gGdb4vqgYBu8/qYGna8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dT2yOzHH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3dPieYs0; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dT2yOzHH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3dPieYs0"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D6C1CEC007B;
	Wed,  4 Mar 2026 02:42:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Mar 2026 02:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772610171; x=1772696571; bh=P9sstkdjQZ
	/b5W12QDqsPvwrXLzE8SNg0MfULVjSc4Q=; b=dT2yOzHH/5OA+Tklatlvwn4BOK
	kO0hLU0L7f8OQQcAXsCCQGh7DSdgiMIFHJXL7cLBxDw6UFKXP6O8ZaUn/gVP4RYS
	b97ENJ4vbMHkJ5wAEbHEzcMZG18DKI0w2D3BidTrbB9ZfcdnVMO9RuUzAQolEjp0
	bcvot2AahyIdM5kceZQsUiOPoVyiOHI12eiA+mxU8KG10EHjlZG3ewpHdLjXKA+m
	m6ISA3OGMEoSBcXxNdH9hFlPG8durrfm4dgCr+Al/bNWE7KIvkpIuieHSE4Cm/z1
	hyNL8HlinRXRDoHTFtnqT5qTDAkpyPX2tbXrEMMc6fEse0BstdRZYLuHw3Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772610171; x=1772696571; bh=P9sstkdjQZ/b5W12QDqsPvwrXLzE8SNg0Mf
	ULVjSc4Q=; b=3dPieYs0TEQguBEPYbTCPFUrj2h5jQADBfvfEFikUde5t/B27nu
	aGCULE9T6pt1579QVyJL6fEKZCHUFdBOnQJ62/QAcecz4dBDYj5QtE/P2wxP7hOY
	M/MV1pXHcPM9dmgqMdGoKF50Hs4hC0y8LpZ/4jVLBNdxyjjrFEe87tI9DCw5dlrP
	v4BtYbmoCwZ0ei7vjXgI2gvc95tgrQco6JJU4J97X6lkE5S5xET2KaR07DZPAVPn
	TTxtNs3shRSJF83dF4J1axJqK2GfvLBADKglXGqt7yuoDjfqWJZyTD9m4niX6+Si
	/MvfdzQGAr77fa/n1WjPw5Ib3cEl78Gk1pw==
X-ME-Sender: <xms:e-KnaS9mpXjLG2-7DwrvfZoIfemkrEcgYAVeyMrgUUfKd5nvDdl13Q>
    <xme:e-KnaaKzYJ-F9jmXKTjfR1nILV3zXpdrdsZvHV35xsvWzNDte3sNLejBdVH4bsMu0
    TjXVoDp-C2Poa1f3tpCwG-MtJ5GR1mDUP3nBBJ8rcQQuIfNcszu4A>
X-ME-Received: <xmr:e-KnaVYQZgee2mIlS6ipcVLPR1_w46uEspw6cDoiJufKRhEtAKV54l26x5nHehc9QP7QtHshxKkNiduPmQwxr30FB2kOcgpIOAyDIy9_7DWW7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhthhhusgesphgruhhl
    ihhsrghgvggvkhdrtghomh
X-ME-Proxy: <xmx:e-KnaUK8NGXMbkLyMVum6kbxuG3C8j8VP44BeOzLl5GQ17wnYoY04Q>
    <xmx:e-KnabDv0Ktm70N0n6RVi5xcAUeiyslm3urvBsTm37wZEI_qd1NGPg>
    <xmx:e-KnaRqvH4ApDm_5M41Glf7DjjgMd484aI6Wpj4WdDzZgJrkro6Iww>
    <xmx:e-KnaejzmWpEmL7R_221ZiOAratYh9Ov7HDmkY12Y84W6cQtlPwqOw>
    <xmx:e-KnadkiJSArJ_rYLzVO9BxcVp3N8V8jgjRQSW8Hs_GT726YJmPau9Bq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 02:42:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2cc54d84 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Mar 2026 07:42:50 +0000 (UTC)
Date: Wed, 4 Mar 2026 08:42:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v7 03/10] compat/win32: add pthread_cond_timedwait
Message-ID: <aafieD42pMaYsnRw@pks.im>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
 <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
 <d2c5ca09396e020adb717055d82f50de7c1b7431.1772065643.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2c5ca09396e020adb717055d82f50de7c1b7431.1772065643.git.gitgitgadget@gmail.com>

On Thu, Feb 26, 2026 at 12:27:16AM +0000, Paul Tarjan via GitGitGadget wrote:
> diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
> index 7e93146963..538ef92d9d 100644
> --- a/compat/win32/pthread.c
> +++ b/compat/win32/pthread.c
> @@ -66,3 +66,29 @@ int pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex)
>  		return err_win_to_posix(GetLastError());
>  	return 0;
>  }
> +
> +int pthread_cond_timedwait(pthread_cond_t *cond, pthread_mutex_t *mutex,
> +			   const struct timespec *abstime)
> +{
> +	struct timeval now;
> +	long long now_ms, deadline_ms;
> +	DWORD timeout_ms;
> +
> +	gettimeofday(&now, NULL);
> +	now_ms = (long long)now.tv_sec * 1000 + now.tv_usec / 1000;
> +	deadline_ms = (long long)abstime->tv_sec * 1000 +
> +		      abstime->tv_nsec / 1000000;
> +
> +	if (deadline_ms <= now_ms)
> +		timeout_ms = 0;

According to pthread_cond_timedwait(3p) we should return an error in
thas case:

  The  pthread_cond_timedwait()  function  shall be equivalent to
  pthread_cond_wait(), except that an error is returned if the absolute
  time specified by abstime passes (that is, system time equals or
  exceeds abstime) before the condition cond is signaled or broadcasted,
  or if the absolute  time  specified  by abstime  has  already  been
  passed at the time of the call.

So I guess it's safe to return ETIMEDOUT directly here?

> +	else
> +		timeout_ms = (DWORD)(deadline_ms - now_ms);
> +
> +	if (SleepConditionVariableCS(cond, mutex, timeout_ms) == 0) {

The function returns a BOOL, so comparing with `== 0` is misleading. I
see that this is following the pattern of `pthread_cond_wait()` though,
so I guess it's okayish.

> +		DWORD err = GetLastError();
> +		if (err == ERROR_TIMEOUT)
> +			return ETIMEDOUT;
> +		return err_win_to_posix(err);

Wouldn't it make sense to extend `err_win_to_posix()` instead?

Patrick
