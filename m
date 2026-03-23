Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7EC395DB5
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280635; cv=none; b=W3qiKdTq1dTCLgSOf3iOoKCjK3ie+n/XJEXug6/b7WHA2zsx9AEbGzrxAjlYMxRZzHAEEyJSOdoLSi0rqu2JmBlB1Il++TTXx3KmnE/1ODeE2LPaAAwOg4Czp6Cp2BVUEysN8/QftAZqsa/ZAweocd8GW60J7ZOZLrfxQFgSasY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280635; c=relaxed/simple;
	bh=+raw6JHjm9J2JEluDmm6CiL3iTt72h/xULfP7P8iuto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Is0EXdIw8PVkFZQeb6RCfL0QVoAavJc7rBl/ca7VLIP15auMkQse/6xvdlFeyqbBj2LtlsLVagy6NOW4ve5MliXcFMDsR672Agg+TqYcWV6ISm+jfQ/xfNQf+F50kE8DI56tAb1Nk7hccwAk8LfBQSTHhRu45hd9ePUIz0gL+a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EClkDC/T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HD7E9bYb; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EClkDC/T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HD7E9bYb"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 13BB3EC0143;
	Mon, 23 Mar 2026 11:43:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 23 Mar 2026 11:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774280633; x=1774367033; bh=3DQNIrGUGb
	W2NuAn28y5TVAL6JT5YxYoy/2rFzFd8Qo=; b=EClkDC/TSl+KMZdDGXofrhn4dB
	bSf3P0FLCDTIMtaMooiTNgAspeVzfU/xoIkIOtSEdy9871nSj4DlvhfZZ8wCoxaW
	5p7yvCRE5vJi7v3cGNvAcWk+MoyNGjWXhtNNCo7pRats8rHMEF7jzAF1qdrFmfho
	2Fak+AIYj+D/V7ht25iJZnV1QwxNd81xCJiKug8vUmdQu+3NcCbB6c7Y3/mm/bG1
	nwWI1Z0i1NSOBK7WiuctufmpEm3wO/UX/rQuPbNykvkAZnyDDd9yK+HSKIoA2ukB
	VseYMcb9mUHdNu0+oZ7OrFyErT+Jljqyg9r7/tGECxK6JRfb7fMpd/ehWOAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774280633; x=1774367033; bh=3DQNIrGUGbW2NuAn28y5TVAL6JT5YxYoy/2
	rFzFd8Qo=; b=HD7E9bYbeXKVykx0p9sypxUdNkl7FAHz2joiK+EiuV3can4gunu
	KrSBDbKWDmimUoOaoLmKAqeuNfqzdNCU/qGBHQRLMq+wPM7b34Jf/Fcw+EmzmZKL
	gtdBd81ZPfmsHG2Qxy4U86KAbDNraxsfIjwaVoM39bqQg5JEb+OemKVF+YxFk2p1
	iSWrdPV/UfMTRKCn4FrcACM+HVMVIO0ZDatelbBYib3wR4sDjVU8w4jwUX6oR5pH
	9+M01t1Pj/hNfTRW4ud8wNLIvGKmUkYn28T0aV9RvxCtlWh9z7q7blJMkonrJK1N
	79p/qVq6fa6VVWd7PyWLvf6OpN9wPxg37Mw==
X-ME-Sender: <xms:uF_BaY78hYbDqjM7NeqlTLkZlIHZBNNH48c81WPiCtz-ABS5PxEpwA>
    <xme:uF_BaRUUrlBr725HNhb-XjxFhwnkvzhioBAvKAXe8ppuImd3FRXKjpnleZZ5eVoQv
    j8GOq0To9wpVTtglnD2FwwDF2DRCHjnfE9Gg03wzLPHIC553gFRGg>
X-ME-Received: <xmr:uF_BaU1zA67J2goXSf4G7nVJcFJCUT8qlBbizE4S99InFDgbEtd2KXX2srm6XcnSJs2LQcMgpvAOCSZUFnyBlGQsVTpOCAh54Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeluddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:uF_BaW3J1SpNKhQ5M33aHDCSq4sOheIcQpJ_6RYm3NxY0t5Wdju64A>
    <xmx:uF_Baf8s3PBdr0yTwzUK3kChmpKLYgzB6jC4KGq5zfjdu_rb63CiAQ>
    <xmx:uF_Bab3D0QUD-D9MkdsXqDz2TztaSjFJdnY4SVZiSKLqCARImIBHrg>
    <xmx:uF_BaU8vO7aZngR6lZGYFA_HP22CW7R6_3ndMtxzKCXOjLTlmBCFfg>
    <xmx:uV_BaZcw9g45NzLb8XX84kIWx5NfLuI6iVC2jGH7KJei2WmZwvtsX0ni>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:43:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 01/12] fetch-pack: move fsck options into function scope
In-Reply-To: <20260323-b4-pks-fsck-without-the-repository-v2-1-e8dc79bca651@pks.im>
	(Patrick Steinhardt's message of "Mon, 23 Mar 2026 16:02:52 +0100")
References: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
	<20260323-b4-pks-fsck-without-the-repository-v2-1-e8dc79bca651@pks.im>
Date: Mon, 23 Mar 2026 08:43:51 -0700
Message-ID: <xmqqv7em5z60.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When fetching a packfile, we optionally verify received objects via the
> fsck subsystem. The options for those consistency checks are declared in
> global scope without a good reason, and they are never cleaned up. So in
> case the options are reused, they may accumulate more state over time.

Great realization.

So we have two code paths (the original and v2), both of which used
to use the one in the global scope without cleaning up, but now we
have a way to proerly clean them up.  Very nice.

> Furthermore, in subsequent changes we'll introduce a repository pointer
> into the structure. Obviously though, we don't have a repository
> available at static time, except for `the_repository`, which we don't
> want to use here.
>
> Refactor the code to move the options into the respective functions and
> properly manage their lifecycle.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  fetch-pack.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 6ecd468ef7..ec5abb92b5 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -51,7 +51,6 @@ static int server_supports_filtering;
>  static int advertise_sid;
>  static struct shallow_lock shallow_lock;
>  static const char *alternate_shallow_file;
> -static struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
>  static struct strbuf fsck_msg_types = STRBUF_INIT;
>  static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
>  
> @@ -1100,6 +1099,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>  				 struct shallow_info *si,
>  				 struct string_list *pack_lockfiles)
>  {
> +	struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
>  	struct repository *r = the_repository;
>  	struct ref *ref = copy_ref_list(orig_ref);
>  	struct object_id oid;
> @@ -1235,6 +1235,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
>  		die("fsck failed");
>  
>   all_done:
> +	fsck_options_clear(&fsck_options);
>  	if (negotiator)
>  		negotiator->release(negotiator);
>  	return ref;
> @@ -1654,6 +1655,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  				    struct string_list *pack_lockfiles)
>  {
>  	struct repository *r = the_repository;
> +	struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
>  	struct ref *ref = copy_ref_list(orig_ref);
>  	enum fetch_state state = FETCH_CHECK_LOCAL;
>  	struct oidset common = OIDSET_INIT;
> @@ -1882,6 +1884,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  	if (negotiator)
>  		negotiator->release(negotiator);
>  
> +	fsck_options_clear(&fsck_options);
>  	oidset_clear(&common);
>  	return ref;
>  }
