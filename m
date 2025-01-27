Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A5C17B50A
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738005932; cv=none; b=dJrQjcwHtua2pC94K1wUeos9XEQ7uHfKdb1fk4iO0QSFuM+AWFucarjn9VTxotSXxkKKLQIkLGcZc6cbuiajVmdk/j7jhfS5/VlxZTh64T2tB4YQYpmZbBdiM63lLR0gehQqJ/ATnJgIfXnYitw5/J578g4burIVfXs9whovh7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738005932; c=relaxed/simple;
	bh=GyTW9qfZMSXeJjhrUPwXNFFEAxKdmKTrm8FVgwR4/X0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rGvkLfB42BEV+q7mgEjMZNuuOvYqcN0ytX1sSV4BwLJ2QvGYBtqw1I7a0yPKkuih0BY7AXGdmVUUBoVx+zWkwRGqNNYkQEr74poUHEGEkwTdm00fpSU1IzaDs7r7AmSbjsoysYb9KsAGK1EX4k610O9GcoRafas6UconCi7/+dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E+eijVSy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IZ75KuR3; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E+eijVSy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IZ75KuR3"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B7C3F25401B9;
	Mon, 27 Jan 2025 14:25:28 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 27 Jan 2025 14:25:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738005928; x=1738092328; bh=W8uSai2dgS
	R5gr93o0fIoAKVuQjFGIPAfw84AcTX1M0=; b=E+eijVSyv3hGEGtK5XU37BA1fB
	yvqAC4UEyDlZHbT99dn+532bqbDBJzRwWEGHOPZywbCieQk0erEIkbUuxhD2DMcn
	V52RwzNhlq2l1ih8fImsHrQDS1zoCsSMjECdzf7A0CzODpGoUI2km8vI7hapNNpW
	kZpzozzpovPUHzDM7v18DHTwiHy95oaXBK/nZK71AQPFkS3eHmNC8AtsulCLni5a
	wkuoRr+hZFY6SRKt/B33mrUsZV5IKjFhz008AJw74b047KrAxt1Ws3eKB/btgNYV
	gHCaB9JUztZS8JETBrVcGtPRptc3C+/SSzF2sY6MJzRdLCJNd5fIGE4QDtzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738005928; x=1738092328; bh=W8uSai2dgSR5gr93o0fIoAKVuQjFGIPAfw8
	4AcTX1M0=; b=IZ75KuR35f0hNLYwhTLy/PLmiXdDjoL8+/ZF/Rn1jyHkfXocMhx
	/m8ZkBYIqm9ia6EPXJVqXJt9DzA1OI1Q+C50mnvA+3I86oESkO5DwvozEVitdEB8
	28uMDOc0OPR3JTKVnsnz405ud38Y4k9ozEx+5YXIxw0yqbmIAVVJCZPTXtkRno3V
	iAViVpgrmbYGQnqh00YAbhT+DXOokLQS56pGOiLCY4+KnyVgS/NVIDg/2JqZM4OL
	jDTIfgt9TdNLDDVwP2hVBPYTVUrjDt78Ha08nvWUBHGawk8EkEw1po+JUwSYqDyV
	pWSq/HIV+RzAxYNZNkyaFtVSOKWnO1x3rNA==
X-ME-Sender: <xms:qN2XZzszB0Zk4A643igv8OQVPTnv0ckILyKWF4oUPARiRdgSnCswag>
    <xme:qN2XZ0fucfUcv8Ez1xAY7YkjR9ivgillw517oViT1ZTquvBejpvDQcuUtopU9yjXz
    y_sp4E8nx_ivUn8eA>
X-ME-Received: <xmr:qN2XZ2yWahBNNYcUJ6HQ3hCCqXCZz7DtJcw9U0K3X4e7Nfk7oDSWqggkk7vQ9iZOZq54BOGuYnum5PuuOjW3ltsS0c0GCpb9n_8j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudegtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvvghtshhonh
    hifedtudejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehshhhusghhrghmrdhkrghnohguihgruddtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehnihhpuhhnnhesughroh
    hpsghogidrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qN2XZyOA-lgmt2ZxkrkQY3qBFtvCF0nvWxvA8TAfP05zS7AKBT-FDQ>
    <xmx:qN2XZz_FT6guNOYhcbqHVqGsXfKIU21UA_m0_Qq-JDAkhnlGh_NRqQ>
    <xmx:qN2XZyUyKE4Y7hZ7ZO5NVkXAgt2i34D50KUWuWFGW8IhxAH1-9qRpA>
    <xmx:qN2XZ0cp5CZJnpWi7QT2YOCOU4y2JTGpiAydjQjmhGrA15jseeG4qw>
    <xmx:qN2XZ0OYX8BwfIarNH_EGpkBZo7IMUob2JHwMaoTZTV9_VB3DI5VwMei>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 14:25:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  shubham.kanodia10@gmail.com,  Jeff King
 <peff@peff.net>,  Elijah Newren <newren@gmail.com>,  Nipunn Koorapati
 <nipunn@dropbox.com>
Subject: Re: [PATCH v2 2/3] refspec: relocate query related functions
In-Reply-To: <20250127103644.36627-3-meetsoni3017@gmail.com> (Meet Soni's
	message of "Mon, 27 Jan 2025 16:06:43 +0530")
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
	<20250127103644.36627-3-meetsoni3017@gmail.com>
Date: Mon, 27 Jan 2025 11:25:26 -0800
Message-ID: <xmqq7c6grrdl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> Move the functions `query_refspecs()`, `query_refspecs_multiple()` and
> `query_matches_negative_refspec()` from `remote.c` to `refspec.c`. These
> functions focus on querying refspecs, so centralizing them in `refspec.c`
> improves code organization by keeping refspec-related logic in one place.

I think query_matches_negative_refspec() is appropriate named (not
that it matters much, as it becomes a mere private helper in the
file), unlike the ones in the first patch that are suboptimally
named.  query_refspecs() could probalby lose the plural 's' at the
end---there is only single refspec, which is a collection of refspec
items, involved and it makes a single query---but otherwise it also
has an appropriate name (this matters a bit more, but not that much,
as it was already public).

query_refspecs_multiple() is not a great name, though.  It does not
convey what is multiple.  Does it make multiple questions in one go?
Does it ask a question that can have multiple answers?

> Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
> ---
>  refspec.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  refspec.h |  16 +++++++
>  remote.c  | 122 -----------------------------------------------------
>  remote.h  |   1 -
>  4 files changed, 139 insertions(+), 123 deletions(-)

> diff --git a/refspec.h b/refspec.h
> index 891d50b159..d0788de782 100644
> --- a/refspec.h
> +++ b/refspec.h
> @@ -30,6 +30,8 @@ struct refspec_item {
>  	char *raw;
>  };
>  
> +struct string_list;
> +
>  #define REFSPEC_FETCH 1
>  #define REFSPEC_PUSH 0
>  
> @@ -84,4 +86,18 @@ int omit_name_by_refspec(const char *name, struct refspec *rs);
>  int match_name_with_pattern(const char *key, const char *name,
>  				   const char *value, char **result);
>  
> +/*
> + * Queries a refspec for a match and updates the query item.
> + * Returns 0 on success, -1 if no match is found or negative refspec matches.
> + */
> +int query_refspecs(struct refspec *rs, struct refspec_item *query);

This one now has an excellent comment.  Great job.

Thanks.
