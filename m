Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471B03594A
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152989; cv=none; b=tBeRDbbWQAkI0Uenhp3sX/3MkV3IIq6lwx/gkKUjV2LwO2lN5qCXOPF3mjkhKesYtlXUnp7YD5DJCatYJRMeS8uRHblHiKxE4srxJu+r0s2b6MZhxA6Z5O8pruNA74thluEhYu73jUJG5IMvwTjSxDNYXOGhjB/UvyrvunxFGuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152989; c=relaxed/simple;
	bh=h4170F2dfrGLI5O7kRpXaBbsw0RAR+ixis2NLXAmrX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qKgCQUtNexaLFlFAK6XNjsxEfwKEDa3yIHLL5CI0QwRHbMWB7tnU/cmtKCdV9cLKm6kTel/EWATNwumT1pAAJOkpSlNCj1aR9SUXDPtoyAXfZG9Fy61uZz9kdFVwS/9ZFXasDBBQ0yWt75poePQnw1VshswwP7yaBerxrtUvyMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vw6I2yn8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YpE1obXt; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vw6I2yn8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YpE1obXt"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 6AADEEC00A2;
	Thu,  2 Apr 2026 14:03:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 02 Apr 2026 14:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775152987; x=1775239387; bh=ZssWZfPFa8
	vrbDo7MQ7HHyDrILbUxIZKJXHymAuJiI8=; b=vw6I2yn8cevjFMkgSRFnOA9tr/
	hOhCDguDRNxfRrA/Y62Wq74Fyd7Rf+/tlgdVLahggQyh8Be1l+Z3XTISqNPhmr31
	AgUXmKKKdqLrRjkvDEyEUH+YMaKp4jPIZ47WPWGm+8ZLDNduVt6Vy3utOvJMvMSA
	HQeI2lgU4L/CzvKXVw5todb2qvqATlENNXWzXbbhYStaG9kwSWbXu9wwtHS/9cFz
	Is04OdoUUg9Ofw9it0sbTHGNFdvXILoapLHoOQM/JoSlV7OFuDXKGdmxA4uxzN/p
	En4XpK4GzYxCYpJYsed+1vjqnkLD0hRV3J12avMbyzMLxag8b8yivJ9L8T8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775152987; x=1775239387; bh=ZssWZfPFa8vrbDo7MQ7HHyDrILbUxIZKJXH
	ymAuJiI8=; b=YpE1obXttEwhQ7OHGNBlW1aBtw/5U88Xm4uuaH5MUrdrnfexgVL
	NeVJUsNrKudxzikD4SdpPB2KvFEk1vDgtIJXBxpXHI3JWHFIijCDgOmMgquRYt2N
	sHMJZvh3HQOdobhGlB9DVDaq78f46e0H0lyTo5OGkKGCJCTuhWyeh6h7tqxCPFIY
	0EDIzZ3IO8f2eAA0SOYSXWkd6Jw+x8WtjMX13IteoXW4cFcEzLWzkr0GKEzIjmSY
	SA+6eM6fXgJdkouVrwg1lY5up4a+VV5AZYIyQ2B3M1bboMQg8MRNmNrM2baFklTs
	+pHZddT4fbwL4mPatMBe/XEUH5iqzIfZyUA==
X-ME-Sender: <xms:W6_OaRGnu0O9cKHB7wDa69g89ojnHPpM2VyXyJJRwwWLF_iR2a-FsA>
    <xme:W6_OadNO2EvnmanyUl7QceMQX41n82OdmuQUlu9afkf_PE1WO8CkA1qVRjhACpctI
    YL8UlUs9yIGSnu1GrHPSh7v-R3NwiRy6wYZHySr3706f957NJp5ERc>
X-ME-Received: <xmr:W6_Oabe0genn3Jeg1RtU_fYmWoS74-iYkqjGQziyy25tal1Zvp0mH9WQ4FYfy-rtPVzLUCcV7Esfbsnc4voBZddFRdgh21BYhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijedtucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:W6_OaSuG68TArTL9LqKIhQobz-2i8HDEITFBrpMepRWM3FZy7XWbsA>
    <xmx:W6_OaUl_jKFXUXgYrIcEh_pYzYRQaOS0fJXOG9XZggKzM_GRFswUJA>
    <xmx:W6_Oacwhdqx4YeCf4pwdVJqLEq8x7LjydJwXoT8WJlVQfgl4TJ9K8w>
    <xmx:W6_OaePz8vbHODQvhkuvCcv5PwgtWPRPdW7SiUydiF4qzLDhGZCnYw>
    <xmx:W6_OaRKOOJ24hGkr3yxPS0uyHrhiZ10qLtwaC89nc0rDUjf7wusiIwJ1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 14:03:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  "brian m. carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/5] reftable/stack: provide fsync(3p) via system header
In-Reply-To: <20260402-pks-reftable-portability-fixes-v2-2-bc110cee0ae0@pks.im>
	(Patrick Steinhardt's message of "Thu, 02 Apr 2026 09:31:15 +0200")
References: <20260402-pks-reftable-portability-fixes-v2-0-bc110cee0ae0@pks.im>
	<20260402-pks-reftable-portability-fixes-v2-2-bc110cee0ae0@pks.im>
Date: Thu, 02 Apr 2026 11:03:05 -0700
Message-ID: <xmqqika9qlye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Users of the reftable library are expected to provide their own function
> callback in cases they want to sync(3p) data to disk via the reftable
> write options. But if no such function was provided we end up calling
> fsync(3p) directly, which may not even be available on some systems.
>
> While dropping the explicit call to fsync(3p) would work, it would lead
> to an unsafe default behaviour where a project may have forgotten to set
> up the callback function, and that could lead to potential data loss. So
> this is not a great solution.
>
> Instead, drop the callback function and make it mandatory for the
> project to define fsync(3p). In the case of Git, we can then easily
> inject our custom implementation via the "reftable-system.h" header so
> that we continue to use `fsync_component()`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c    |  6 ------
>  reftable/reftable-system.h |  3 +++
>  reftable/reftable-writer.h |  6 ------
>  reftable/stack.c           | 13 +++----------
>  reftable/system.c          |  6 ++++++
>  5 files changed, 12 insertions(+), 22 deletions(-)
>
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index b124404663..daea30a5b4 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -366,11 +366,6 @@ static int reftable_be_config(const char *var, const char *value,
>  	return 0;
>  }
>  
> -static int reftable_be_fsync(int fd)
> -{
> -	return fsync_component(FSYNC_COMPONENT_REFERENCE, fd);
> -}
> -
>  static struct ref_store *reftable_be_init(struct repository *repo,
>  					  const char *payload,
>  					  const char *gitdir,
> @@ -408,7 +403,6 @@ static struct ref_store *reftable_be_init(struct repository *repo,
>  	refs->write_options.disable_auto_compact =
>  		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
>  	refs->write_options.lock_timeout_ms = 100;
> -	refs->write_options.fsync = reftable_be_fsync;


It used to be that by swapping the write_options settings the
project can choose to perform its fsync in different ways depending
on what they are writing, but now we have a chance to specify a
single fsync() in <reftable/system.c>?  

The project code does not set up write_options and the project code
has no say in the choice of the kind of fsync used for different
data files the reftable library uses, so it is not a problem.

OK.

