Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9715138F23D
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937658; cv=none; b=Aac4EaY5IUylvR09UuNOyqoUeIdeaUyDYX1yh31BP4ebuEepuQiG8+yetJ3HPmSbbiH4a7Z3rNwVOwzA9qFlzxDQuYD6KqhwbbRQuuRuvGKfztNcVJ7z03TeixeTwVEQcL6t5pPfAaHupZuBsDXZQjUyUWrBf/1X1MyOtVYyBC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937658; c=relaxed/simple;
	bh=Ny0BzcnJkO0Cyhxq7tFNifXmtlV5PS983Jt53ijD4LA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YiDcIAaUlPoWQiPtBZ74eaJKy2Q3342A7mLSoKgzKZC8WphkKRXRK3KkgxnGBkfeQq+BmuGPD3rELJHvZP1eS+knl3XCyUybEMlH9YVssnssa4wqY6AQmVxSkAbmUtjcbDOdNNlhFoNxyNfXeoAb6WKl0MjpQaaVFFYmME5K904=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Id6iRDZh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ou7+f9Wp; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Id6iRDZh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ou7+f9Wp"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7C2887A017D;
	Thu, 19 Mar 2026 12:27:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 19 Mar 2026 12:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773937651; x=1774024051; bh=3gv8tgJK45
	9hon5i0Y7GAKH+yeQiI8Jl4+zzdG9qbzk=; b=Id6iRDZhz7uhU/YZYM8/MNgnOY
	p4V9Gsb9jEiROUPv9Aq23AmqQKyduKHFM5QQUZUf5+tJPN8aBFgw46KffjQFm0E5
	8NGO5lROPDul8W96NgzNPKhCpIktiw2lz4H6O7oFZycNyAwgykW7lNAbVHDsIbn2
	Z1Z/yiVkuY4keRqtT/F4OXbHYICxQ29buhYwsSB8Dz3GBUfkmCoec+AvpQsIolwN
	pyVKwCwZ7fQ/q2KpXKdpM6kXtjp9BqxCn/KcA2NxHYjkte//kVME85GTFUiYqlAH
	oVJndofGoh2PABen77q/sL/3g5JaOiUoBAeCPucgjfjYsLEs689OpwYkb/og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773937651; x=1774024051; bh=3gv8tgJK459hon5i0Y7GAKH+yeQiI8Jl4+z
	zdG9qbzk=; b=Ou7+f9WpnU8Z6UFaJMZrIIuA883GB/cpyzUbWa/eZ7tiyejqHBZ
	AU33o2hZLN/1g4eCmLTlbyapTZ4ovz/RWUwNQrLXvFcf9ipKyLUP0o7wFA21/Lcp
	ikUi9WWBQ43buF7qgowexqx7bhlZarH9tFJ6/ZN+rnChCs8JM/eUEUWMsJ2uOn/i
	PEGO0fqBw1OudngvlQd9t44gl9UG09syiN3C5vryXURQDyy5ry93KoH3WPXnCs+Z
	Km56tSU3oI5Dkaz14C35pFcKWxDtGRezv54aeA9zwKa4pDJ3pZzd7KR5QMmwX/8J
	PpKIbVL9DyyC6r41DQ9Qrf6huJkT5Me9HOw==
X-ME-Sender: <xms:8iO8aQ2R6B6y9XvnDLaKo_PbW6vRoIwLvDbRK51MgjLR2fGglo6wqQ>
    <xme:8iO8aShoJcvkTu0yX8sQfkTLZekFUAyX-phVmjyYOBQreGbbbO5jn2yGs4K_14mzV
    g_2Lf4BksXfqOWKq4iWI_RAe2JTTIvGz30qjcM1xda5ZhzfBaQp7Q>
X-ME-Received: <xmr:8iO8aWRR3wNgWub64p3Z3RKqaKnmanfMO6Ddy4gvO9ety-ENyba78W0Lq3-5yzbIW3anC7pKWTlVu4WUzV9tLJNV_eMuAvE3ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejgeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:8yO8aTgDMPLihDd20AmY3Rl26Z6CXe9rRNRzvw39u0H7V-MKFSRCWw>
    <xmx:8yO8aW4qVzPXrRZGF4ESFtSnsCBdwyhsXTFEtUq6KmurG1cYEQ4qag>
    <xmx:8yO8aQBmNbhuogd3ZDIX-KQD6UCeBZoli3EDZsd-jBRDF6-FGglttQ>
    <xmx:8yO8adZ3M95nRBVG7QYIBjbqME4XXycJ6e0cX9zl-eOH2O4r6n-ItA>
    <xmx:8yO8aSoKQOt89lekl_l8xqFmaeNoy6SVxjPS12pZRcGcr6e0E_lQYgWk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 12:27:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/14] oidtree: extend iteration to allow for arbitrary
 return codes
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-2-5ddebad292b0@pks.im>
	(Patrick Steinhardt's message of "Thu, 19 Mar 2026 07:53:00 +0100")
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
	<20260319-b4-pks-odb-source-abbrev-v1-2-5ddebad292b0@pks.im>
Date: Thu, 19 Mar 2026 09:27:29 -0700
Message-ID: <xmqqa4w3n5se.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/cbtree.h b/cbtree.h
> index 43193abdda..4f644d6e45 100644
> --- a/cbtree.h
> +++ b/cbtree.h
> @@ -30,11 +30,6 @@ struct cb_tree {
>  	struct cb_node *root;
>  };
>  
> -enum cb_next {
> -	CB_CONTINUE = 0,
> -	CB_BREAK = 1
> -};
> -
>  #define CBTREE_INIT { 0 }
>  
>  static inline void cb_init(struct cb_tree *t)
> @@ -46,9 +41,9 @@ static inline void cb_init(struct cb_tree *t)
>  struct cb_node *cb_lookup(struct cb_tree *, const uint8_t *k, size_t klen);
>  struct cb_node *cb_insert(struct cb_tree *, struct cb_node *, size_t klen);
>  

This change does make sense,...

> -typedef enum cb_next (*cb_iter)(struct cb_node *, void *arg);
> +typedef int (*cb_iter)(struct cb_node *, void *arg);

... but it probably now warrants a bit of comment as readers cannot
guess from the values in cb_next enum that is gone.

   cb_each() keeps iterating while this function returns 0; a non-zero
   value returned from the iterator callback is relayed back to the
   caller of cb_each() after immediately stopping iteration.

> -void cb_each(struct cb_tree *, const uint8_t *kpfx, size_t klen,
> -		cb_iter, void *arg);
> +int cb_each(struct cb_tree *, const uint8_t *kpfx, size_t klen,
> +	    cb_iter, void *arg);

or something like that, perhaps.

