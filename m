Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22773101BD
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881385; cv=none; b=QDQcjfP4LvUmGe0XbKRJ8wQI73WC2Ff9zv/bnDtfA3mIkXJhgAraHQNiYEwjCqrksL8YEyONT9Au1Jc8TnHdTlIMibAGTlKWpRIMwm6F9HVCz6iipk1GLQFHFDfHGSkCVAhMNhmUDBGjCooUtVbfsLi5mj0AmVCRJwZjFfjr/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881385; c=relaxed/simple;
	bh=PK8ZRYKVCFO1kiIbMzqotB/VH2wQKqUTDrQFS2Sx/9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C+FFT8THe7VKVXeyhT+dE+KHK3riVtH2Wpgbt45G1mc/8Shh9NS9RUNJQa+c2gpl4PZEABnGMXni5sOwV/vwD+c6MTPFGXLqXkBhp8+59gD0NCg1+vv+r4r5nXeOm+L15Vgt9/sd2ryRIqn0nobSlAUdmVlpJFvROe6XCRBPq1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NvNXoD/s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TMcXB3bf; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NvNXoD/s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TMcXB3bf"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 09721EC0715;
	Fri, 22 Aug 2025 12:49:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 22 Aug 2025 12:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755881381; x=1755967781; bh=lV1gQECtu6
	RxUIswkKgdmB0eHSTRNBCDH2MKKPtv0k8=; b=NvNXoD/sr+ZN4m2MUS5Ob4boIi
	dZiDb0PeEjPuwyAauybNqIMb/E3B3e4yqK/Yv8Ua6pmdesMJdQ1gLhvBEbYzwmZl
	jqaDcfheO0UBr7LT7/uujrw6GaCkbU7cUeX7Iq8uUSpDufbqnC3iNXhaWOdW4aXt
	HtDfnBX5+lmyXU0DetU/2rzZ5lphEPF2zoCZnX7HgFy3E0RdqSP1CV3ZYgYWu/Ue
	snHXAM9zdOLu2RdQmDnfg9D+xnXUfTWYmy5YWz62EO53tSRV0ht1CxtsXD/uu5my
	Xl7vXAdp+J4cHU2p1xO5/PjDV17vJ2zwmleI4A4rBDfCtWpuNmDvxl+dL6dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755881381; x=1755967781; bh=lV1gQECtu6RxUIswkKgdmB0eHSTRNBCDH2M
	KKPtv0k8=; b=TMcXB3bfNU+/9kZzmVbvSfJyHwbrDIpx2RHcHhEnGo/LBaNVJH/
	ojH2rrIBbQ2qNnWgT5gyaCIbvetiWw6yXJXZwIvxI12eid4egQLFVJu3d9rnaFjQ
	UpQwA8zX26oqJT75lmXixBFGGofax1d4CZcijnxekl2rfsbN3F4gTx0sr/4FggYd
	lO1q8XXTKBbhpQPnw5CuAImvl7UHZXQxcSC70dss0rZcZ0HrN7w+zhnTOSNnX9Uk
	60VVFwTOjzoR4UJnRrgkjhezfYpme8tzF0uD2zxfvzBgyANsR4NzGe03PSN1VQNY
	bzo1Yo+cTBsuHAfSFz5qgEBejq8uQnNjp1Q==
X-ME-Sender: <xms:pJ-oaD65mAe6CIoVQ11JIvWXgmj45Jw6vhWSe0HjELY2HQ-mcQ0Gcg>
    <xme:pJ-oaDehhmlLk1V8lLslCGmDIDlF0y-QLX1OsoX1gyqCVhQp1xTUEuSdCLceB19Sr
    J7eUlKAGyvl3lobDA>
X-ME-Received: <xmr:pJ-oaHAc_gwqUKt-zYFaJMdZOP01n7rOW4VkiwtOI3ruSTlWgyxDL6zqC2TFKgqlvd42n7QXSOw3f2fXUzA_gu4we-74ezTy0caunBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieegvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pJ-oaG_xP9qWE6EQBKdrj_gqfGUdvbTfC1m8J_3MmbtM21dnQWX0Lw>
    <xmx:pJ-oaCLUDYPbcIHYtKEuPQ2Pz32q3GlbXl9Oe7Mc5x1xv5sTktfLoA>
    <xmx:pJ-oaPjxvMwVXlW90fz_XU3OKJU_zv6OvNjYZUPAskHNGZuM0twQfg>
    <xmx:pJ-oaC69pCli-ZJKgXsjbSKczzAHL_n2I64bEpX9WjqLCgEWV3ulAA>
    <xmx:pJ-oaDo285yyPjPZJ4cnYWNzhXH-13E0nx0GqQXSU2lHUkJ1H7H3Aufe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 12:49:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 3/4] bulk-checkin: require transaction for
 index_blob_bulk_checkin()
In-Reply-To: <20250821232249.319427-4-jltobler@gmail.com> (Justin Tobler's
	message of "Thu, 21 Aug 2025 18:22:48 -0500")
References: <20250820225531.1212935-1-jltobler@gmail.com>
	<20250821232249.319427-1-jltobler@gmail.com>
	<20250821232249.319427-4-jltobler@gmail.com>
Date: Fri, 22 Aug 2025 09:49:39 -0700
Message-ID: <xmqqqzx3xpwc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

>  /*
> - * This creates one packfile per large blob unless bulk-checkin
> - * machinery is "plugged".
> + * This writes the specified object to a packfile. Objects written here
> + * during the same transaction are written to the same packfile. The
> + * packfile is not flushed until the transaction is flushed. The caller
> + * is expected to ensure a valid transaction is setup for objects to be
> + * recorded to.
>   *
>   * This also bypasses the usual "convert-to-git" dance, and that is on
>   * purpose. We could write a streaming version of the converting
> diff --git a/object-file.c b/object-file.c
> index 1740aa2b2e3..bc15af42450 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1253,19 +1253,26 @@ int index_fd(struct index_state *istate, struct object_id *oid,
>  	 * Call xsize_t() only when needed to avoid potentially unnecessary
>  	 * die() for large files.
>  	 */
> -	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(istate, path))
> +	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(istate, path)) {
>  		ret = index_stream_convert_blob(istate, oid, fd, path, flags);
> -	else if (!S_ISREG(st->st_mode))
> +	} else if (!S_ISREG(st->st_mode)) {
>  		ret = index_pipe(istate, oid, fd, type, path, flags);
> -	else if ((st->st_size >= 0 && (size_t) st->st_size <= repo_settings_get_big_file_threshold(istate->repo)) ||
> -		 type != OBJ_BLOB ||
> -		 (path && would_convert_to_git(istate, path)))
> +	} else if ((st->st_size >= 0 &&
> +		    (size_t)st->st_size <= repo_settings_get_big_file_threshold(istate->repo)) ||
> +		   type != OBJ_BLOB ||
> +		   (path && would_convert_to_git(istate, path))) {
>  		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
>  				 type, path, flags);
> -	else
> -		ret = index_blob_bulk_checkin(the_repository->objects->transaction,
> +	} else {
> +		struct odb_transaction *transaction;
> +
> +		transaction = begin_odb_transaction(the_repository->objects);
> +		ret = index_blob_bulk_checkin(transaction,
>  					      oid, fd, xsize_t(st->st_size),
>  					      path, flags);
> +		end_odb_transaction(transaction);
> +	}

Interesting.  If the caller does the odb transaction management
itself by calling begin/end before calling this function and fed two
or more large objects, the original code did the right thing with
.nesting set to 1.  In the new code, it still does the right thing
even during the call to index_blob_bulk_checkin we raise .nesting by
one, because the all non-zero .nesting values mean the same thing to
the machinery, thanks to lazy initialization of the .objdir.

So, isn't the comment above the function now less accurate than
before?  The caller of this function does not have to do anything
and we do not expect the caller to "ensure a valid transaction" at
all, no?

Thanks.




