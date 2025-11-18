Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADF0377E88
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485362; cv=none; b=u6W5DP8BhHea7+9zQn5Na11hacNZ1kZXMWerlSQEL6BKp9NcBj3xWQF9Romoytx5tQcgNfDV7fmbjIX9dB4pDceL0sFDXkfw4h2wpx+6xCOLYYr4BU6TQL47baIWL8mkFIyWf1+ORU1e7bIt3Z2NxAudURlwIShsKMQ3usr/kYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485362; c=relaxed/simple;
	bh=MhTXVwQbEOmdgTZ9QsTNAMps3SH0MISwUJ04Mq/+E8o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Om34eFfogZvlx968Ugfkofo6i2d/+Kw+TD8bPpsF02ykPHZTTYVp705+CH7GchR9DO0FeJkzhTHm/vtyank1glrwJMvD/3lYt6ast257o5uCLkZLO2Myv1lWu0K/oD43N4u51JFUivbDq4A7L4V+sNB2u7XiY3qdGa37X8uKwxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pu3BmQX1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fZaDE60A; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pu3BmQX1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fZaDE60A"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E7B56EC0171;
	Tue, 18 Nov 2025 12:02:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 18 Nov 2025 12:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763485358; x=1763571758; bh=tpf6aH3h7E
	+tqdyBFPbyj6ySABGFykwDIf/zYJHXLSc=; b=Pu3BmQX1vXQEpaoKC9ElL5CliV
	vMtpCuzjaUb2qkpGn1g/y2uxsRwipNfrbxkyGdK61ksqpHDOm/mo6yl2D+f/igKd
	sM2SiJPBsQ0h+8vxQgjzOwxZhMNm7Kso7NjpwbbSQB38jn53H9a3NuEXDu9NcVWw
	wbqLjjDZQ4MNUtDD9K+MVrOeR1WJM0E0922dBqC+S2k6+r0FHhjPn4o3ofGZg+r8
	mPgqWB4mAJXUzI8M6PEm7rK/6DhTDzo+lxUs0iwSjPPLHw+hbdGr6CsXokogmP1c
	bb3vECff8Gp3zSvyZ8Uy9+0ZrBjYPypsCM54cNH4lIP1cVW5BXC5Pp6KbZKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763485358; x=1763571758; bh=tpf6aH3h7E+tqdyBFPbyj6ySABGFykwDIf/
	zYJHXLSc=; b=fZaDE60A1+i7tzOd1kskX5eVaZeYwO8hJghUygYh1QRgNEhxfwr
	bane7GZBp/T/x4K0E4fiM1gdGYs0faAi+PL/j09oakYcJPvzQ0loj38XYhl0wzNC
	IWOpWmz1mvcXHXQAyiQrBjnPZQVDRr3b2K1ZLfUF/t0bpqjm/2aIkwiduZDG3QIb
	5OWivil7rZlndIShG7BAsRs5Nri3Fs1ChvgvvwW6FQ+6FjjEsDCF9m2lSVCAQQfr
	4mM1/KEbHspkOcCkKzcK4frYkBzuTfIofOyEh/3L2m7Nc+gYV0zSC6Ukb/V05xSz
	Za2kXcDD6ED750SK8l1My53NwQzYpWWsueg==
X-ME-Sender: <xms:rqYcaY90TpVabfTN_-t8W68oeel_48qQsjwQt0j13LU3p2u9YRltZw>
    <xme:rqYcaXvbIugcQEs2fJQgwiX3cfMjbBSgbJipaPEsAFCVGmiKnVGoXeU9Z01RzgxpR
    tab8yuhKwseRBYm2haroQqIY-zmoUwLsLT0t0hhIPc2qMyb3iC6ug>
X-ME-Received: <xmr:rqYcaTADVpVKFptlmOURwdkSFNr-mUIo845sv6kZYv8RklaspwBC1LIvAeZL_HGMbkY7y160e904PKUqd8Jvkaamk95QW7z8EcCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddukeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgfhhunhhnihdvfeegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:rqYcaXWJ3EWrWirx2LfUzAJlluKMLEi_8Nc5wsaNPllMEc8X9xD-4Q>
    <xmx:rqYcaZDagr1S1yo6Mn7ikrgG24cfGM-WvEYvZoUVpJL3Nh6XwLhbIg>
    <xmx:rqYcaS-9auzW_fmLRSDi6gnWT5kG80LeKieL7GnIGHc-nrpRDg1hWw>
    <xmx:rqYcaYHaqUC6et8fgPB392yL3ee8AaXiWWUKvG7wvH6luuFnbQNRGA>
    <xmx:rqYcaWgFO1UshP-D0cA9oqUuEnhpsg_9wRqIELTgx5b-f7Wh6B3Qa6rd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 12:02:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  AZero13 <gfunni234@gmail.com>
Subject: Re: [PATCH v2] win32: remove handling for impossible cases in
 win32_pthread_join
In-Reply-To: <pull.2102.v2.git.git.1763480720264.gitgitgadget@gmail.com>
	(AZero's message of "Tue, 18 Nov 2025 15:45:20 +0000")
References: <pull.2102.git.git.1763427606138.gitgitgadget@gmail.com>
	<pull.2102.v2.git.git.1763480720264.gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 09:02:36 -0800
Message-ID: <xmqq4iqrff4j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"AZero13 via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Greg Funni <gfunni234@gmail.com>

Looking much better, but there still are some puzzlement left.

> WAIT_FAILED is the only real possible error here.
>
> WAIT_TIMEOUT would not be returned as the INFINITE
> is given to the call.

OK.

> WAIT_ABANDONED would be returned if the handle
> pointed to a mutex object that was not released
> by the thread that owned the mutex object before
> the owning thread terminated.

... and we know the handle we are passing to WaitForSingleObject()
is a Thread, not a Mutex, so this error condition is irrelevant?

OK.

> WAIT_IO_COMPLETION would not be returned because
> we pass FALSE so the wait is not alertable.

FALSE where?  Ah, this can be done with WaitForSingleObjectEx, but
WaitForSingleObject() is what we call here, so WAIT_IO_COMPLETION
won't be returned with or without FALSE.  Is there a reason why you
want to change the code to call Ex variant (the manual page tells us
to use it _if_ we want to enter an alertable wait state, and I am
assuming that we are not interested in doing so)?

In any case, among the four possible return values from
WaitForSingleObject(), we know WAIT_ABANDONED and WAIT_TIMEOUT will
not be relevant for this code path.

Because WAIT_OBJECT_0 is the cryptic synonym for "Success!" for this
call, WAIT_FAILED is indeed the only possible error here, just like
you said at the beginning.

I think it is easier to understand for mere-mortal readers like me,
who are not familiar with Win32 API, if we explained this change
more like:

  Subject: [PATCH] win32: simplify win32_pthread_join() error handling

  Among the four possible result WaitForSingleObject() can return,
  WAIT_TIMEOUT and WAIT_ABANDONED are not relevant in this code
  path, because we do not ask for the call to time-out, and we do
  not pass a mutex object to the call (we are passing a thread
  object).

  Simplify the code to

  - return an error without closing the handle if the call failed
    (i.e., returns WAIT_FAILED that is not zero);

  - otherwise, WAIT_OBJECT_0 (which is 0) is returned to signal a
    success.  Do exactly what the original code did in this case.

What do you think?

> Signed-off-by: Greg Funni <gfunni234@gmail.com>
>  compat/win32/pthread.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)


> diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
> index 58980a529c..54c43b4146 100644
> --- a/compat/win32/pthread.c
> +++ b/compat/win32/pthread.c
> @@ -37,20 +37,14 @@ int pthread_create(pthread_t *thread, const void *attr UNUSED,
>  
>  int win32_pthread_join(pthread_t *thread, void **value_ptr)
>  {
> -	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
> -	switch (result) {
> -	case WAIT_OBJECT_0:
> -		if (value_ptr)
> -			*value_ptr = thread->arg;
> -		CloseHandle(thread->handle);
> -		return 0;
> -	case WAIT_ABANDONED:
> -		CloseHandle(thread->handle);
> -		return EINVAL;
> -	default:

And the above is what the patch simplifies away, which is great.

> -		/* the wait failed, so do not detach */

I think this comment is worth keeping (I am assuming "do not detach"
refers to the fact that CloseHandle(thread->handle) is not called in
the error case).

> +	if (WaitForSingleObjectEx(thread->handle, INFINITE, FALSE) == WAIT_FAILED)
>  		return err_win_to_posix(GetLastError());

The change is based on out belief that WAIT_FAILED is the only
possible error from this call.  Even if our belief turns out to be
wrong, we would want to take the error code path, wouldn't we?  IOW,
I think the above should be more like

	if (WaitForSingleObject(thread->handle, INFINITE))
		/* the wait failed; do not detach */
		return err_win_to_posix(GetLastError());

i.e., if we get an error, report the error to the caller, regardless
of what kind of an error it is, even though we expect it to be a
WAIT_FAILED.  And the case this if() condition does not catch is a
successful wait (i.e., WAIT_OBJECT_0), which is handled ...

> +	if (value_ptr)
> +		*value_ptr = thread->arg;
> +
> +	CloseHandle(thread->handle);
> +	return 0;

... exactly as before.

>  }
>  
>  pthread_t pthread_self(void)
>
> base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed

Looking good.  Thanks.
