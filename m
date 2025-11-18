Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD50B2FE054
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 02:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431872; cv=none; b=D+IiAfdVZyvbwRHQihpdZSmwMD3N+EDg0nKWHUiCIYwdH7LLqiOhja+XUwRWIneCjNUkHKIXrc8pMhjVTYsjWUSdjpcb4EK1QCRjNBNCdgExKkbtR1B6/wf+X4/RkDy0mceuUdvTYPTLQux4y9dfyQcY83ESISygkDmdDhhxEf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431872; c=relaxed/simple;
	bh=ix3JZWjgrCylhnA4fqa03Cdl/ZYVkEGGR0C3mPRDOoM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=O/b8aAU59LQnp2H9qcHzckYsP8tf5acgdePkEEHjL/nZX7FCGw0ImFDFzBkc/QahYagAWLbsbel7vlDcnbice3WwPhc3ZxX5nID67kBeSQpz0cZOo1qQ4YgB+FlFjeeGsBQIr49CIBtx/fCSD9vh8Ki0tGr1U9bfVkIT8TLnKoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Tln3kCG9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=awn1DVdn; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tln3kCG9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="awn1DVdn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A7E301D0007C;
	Mon, 17 Nov 2025 21:11:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 17 Nov 2025 21:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763431868; x=1763518268; bh=vgZ5/Lt0W9
	+VBQ1DFi2GJTveOkvDhaF6Q6SaSom/ZeM=; b=Tln3kCG9r/jakMLqwBxVmuSKtK
	PIRZTJuHluRCCDQUjrCgqwRh7hu/G3+raH0uerDT1ffIGyioiFWGcqKuzBsabyXN
	m7oGx+wU2WNvyV0vKy1dBNSrQDZNsCMRk58nw3IOdD7+6+L5Ns4sJXzT+CM90AxS
	HoJuEHyLDDFjw0Dnc7QEv25XxRcPsSEMnwvp2Y0EBnm0EeSWORXlw7g4lL5seXw+
	zgqb6TcvKGUnbjdnmpoYO1xHH/YQ+PLF4h9Q2m0Gu1qaxzjRDUaNdy49A8V2Mpne
	82Hhp+Xj2yuhsj2NCf67qvI8unr00viLGkhksy5LZ12L7k8YHSyDEfRrsU6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763431868; x=1763518268; bh=vgZ5/Lt0W9+VBQ1DFi2GJTveOkvDhaF6Q6S
	aSom/ZeM=; b=awn1DVdnk0QVIn6RS4KsXM5BO+bRUaKztW+gGEMTh80JjO13gck
	XZT6Pv+FuvOYCxIZKaqK+AUPo0jZ067VUEwiyDOrHhme5CDEQp2swh2D+sdFrZbD
	XJctWJGMt2yz7a8KWH+ggukko/r2Q0xm7ypJyPKZOvvdVdOo7N7DY994N5SXIGPJ
	qt37cx+fKAWbMe3GU93rHDLg0BY1J2b4VGeJ7knhg2jy91aQatsqmFdYVyRQDF+S
	6Bz4NeDuCHgBpYEFy2g2FJHA5Etu4DOG6118ZUggmKoO4LYbcDmhFuLQeK5/bsTd
	RX3wVeMyDrSXVAdXboN/qlp4M8WjuheHffg==
X-ME-Sender: <xms:vNUbaX5_yXwHNwgpDA_nYp4yBPaLZttB7Yjyak_tSqcvqk6B9SafTA>
    <xme:vNUbaT49rVmXrCXJPwqJ8ZtF4S0r5j1uEys_FX0WG85XPeIHMy-40WLLhloG_emiZ
    e47kBH_v-Gtp2F6cVXhdk4Me8GIKeg9TWPOfuJTPlXgjPEsSmCq-w>
X-ME-Received: <xmr:vNUbaTfV2npj5x3AOjvHeuv5z9tJ3NRIrCdMfsnIwLCvhAuYNWWE0BInl4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufhffjgfkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffdtjeevtdefveegffejteekgeefueegjeffieeitdefgeeguddtfeehvddv
    ffdtnecuffhomhgrihhnpehmihgtrhhoshhofhhtrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidr
    tghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgfhhunhhnihdvfeegsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vNUbaXBAkAQTEXZoT7TtfdXccFBV3T746GeUnusuNmrdaqDRvlkq9g>
    <xmx:vNUbaW9F0b9YFsVVvoBhipiHW7XbY4PcpU5Rq_3mJGyqisDDbqcyAg>
    <xmx:vNUbaSKYZkN1C6k9bpnu0dViVEhXQljfz1cOIQzoncp5isnApiqnaQ>
    <xmx:vNUbafhloCJds4kHAMKXH5GPF-hROv_c0I4Z_D3pH_ACtbmtqLhKIA>
    <xmx:vNUbaS8G0b1g7Q7_Ws0jG31Bb4N6S5ciq58wr-Hgn8JfoQxAEHTu8YJI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Nov 2025 21:11:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "AZero13 via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  AZero13 <gfunni234@gmail.com>
Subject: Re: [PATCH] win32: remove handling for impossible cases in
 win32_pthread_join
References: <pull.2102.git.git.1763427606138.gitgitgadget@gmail.com>
Date: Mon, 17 Nov 2025 18:11:04 -0800
In-Reply-To: <pull.2102.git.git.1763427606138.gitgitgadget@gmail.com> (AZero's
	message of "Tue, 18 Nov 2025 01:00:06 +0000")
Message-ID: <87h5usf5tz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"AZero13 via GitGitGadget" <gitgitgadget@gmail.com> writes:

First, welcome to the Git development community (I do not think I
have seen e-mails from this address).

Common to all three patches, this name on the in-body From: line ...

> From: AZero13 <gfunni234@gmail.com>

... that overrides what is on the e-mail header (which always points at
GitGitGadget address if you are using GitGitGadget) comes from the
user.name configuration that was used when you recorded the commit.
It has to match the name you use to sign-off the patch, when you are
sending your own patch, which is ...

> WAIT_FAILED is the only real possible error here.
>
> Signed-off-by: Greg Funni <gfunni234@gmail.com>

... on this line.  Perhaps do this once

    $ git config user.name "Greg Funni"

in the repository you are doing the public work on Git, and then
check out the commit you committed under the AZero13 identity and

    $ git commit --amend --reset-author

After that, force update the pull request would be necessary to
correct them.

Other two patches I saw no issues with, but this one needs a bit
more than the above "is the only real possible" single liner
explanation.  For example, somebody who is clueless on Win32 API
(like me) would visit

  https://learn.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-waitforsingleobjectex

and wonder why among those 5 listed, WAIT_FAILED is the only one
that can be returned.  Something like

    WAIT_TIMEOUT would not be returned as the INFINITE is given to
    the call.

would have been a reasonable explanation if this patch were removing
the case that reacts to that result (but the original does not react
to it, probably they already knew that it is impossible).

So the original code used to futz with *value_ptr when the result is
WAIT_OBJECT_0, but left *value_ptr intact when the result is
WAIT_ABANDONED.  And with these results, it called CloseHandle().

Other results, including but not limited to WAIT_FAILED, returned
error code without calling CloseHandle().  The updated code does the
"return error without calling CloseHandle()" only for WAIT_FAILED,
and for all other results, including WAIT_OBJECT_0 and
WAIT_ABANDONED, does the same futzing with *value_ptr.  Are all
these changes intended, and why are they good things?

Your proposed log message should answer these questions for future
readers of "git log", because for them, unlike me who can ask these
questions real-time to you in a patch-submitter and reviewer
relationship, it is not practical to ask you.

>  compat/win32/pthread.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>
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
> -		/* the wait failed, so do not detach */
> +	if (WaitForSingleObjectEx(thread->handle, INFINITE, FALSE) == WAIT_FAILED)
>  		return err_win_to_posix(GetLastError());
> -	}
> +
> +	if (value_ptr)
> +		*value_ptr = thread->arg;
> +
> +	CloseHandle(thread->handle);
> +	return 0;
>  }
>  
>  pthread_t pthread_self(void)
>
> base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
