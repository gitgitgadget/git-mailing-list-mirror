Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB4D27F01B
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017520; cv=none; b=pK3c5k0QRL4OvaYVN3mcRGLpn7/FovBRThPP5GsZbQtqrqG0ufB8WdQ4z7G2R3RiAV8PQZwrfSUjSfWkvuxe1oQ/TTNuGS/6UEkxvytpz6LG3mbb7XoEpZpW6q94QXMzWjdvVg4rf021uYuLvgtOZhKi+PQpKdqFgWeuLUb1/E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017520; c=relaxed/simple;
	bh=dcfvMRqagofYx+NkcAJPl4YCmG1B8QxsNxHu/VzquMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZvjjRbpxVYtrrnZ/CjcFX031ZENE6oTvoOqJNFC9ZSfk/WGjMeaxhheldCZBacYth9jbIvafaP+lhtiNnCLqhldKj9JDGfVYTY0jrJaE+rbS2seB8DxzbhYVLWYJyd48RkwgXbSL8kkdGldfpM97TVzFPs+TrYH4kx/qkuB2JXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0IYtSbNb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RgN+O8ee; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0IYtSbNb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RgN+O8ee"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D47801D0051D;
	Thu,  4 Sep 2025 16:25:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 04 Sep 2025 16:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757017515;
	 x=1757103915; bh=Pgg6BK3WqgktIZ87JBH9mJJqDt4xtzuks/qVXRXBIPU=; b=
	0IYtSbNb+Cu/Ro06BrUJLY729OtDaqCMWsxbbnQQVYDE7//J0NFmBnxTOAIMZcMZ
	/h+zUbgjrXnoqWRnZvtcBIenmExIezhr1c+EpWDAS0ZQq9nAWaqt3lO2vOLseIFd
	J9on+KS2qU6UEHc31j79Cl0OgkjJAA16jY3XnzjMHY1yA27g4MorAfsPme73SQ7x
	dqZ25t4Gli9J7uZxTQG6O5fWJJ9xnmKCQloyWHmFOIf/0WunBC9aDdZgm5rAY0PZ
	Q2MJoIMySkmNtvPs49e89bgblqdsduH/ksK0IK+U54d3IsF+Moyxx7cLuENUag0V
	fn11NBPiHGKn52I0p9gz3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757017515; x=
	1757103915; bh=Pgg6BK3WqgktIZ87JBH9mJJqDt4xtzuks/qVXRXBIPU=; b=R
	gN+O8eedljvs1l6Le4YoY1cqRNM615KcSxpTXrSFSCf8DffSm0xeWssOB7cPeYLQ
	2TH+V1WhHriEV/9G9DZROJ8/bLMxnAh8Kz93yeCX5Qbl3EWZn532bOZ57ysWg2Wj
	BQUlyY4MVSWpEpn7d9g3BHtA4qzqHjuhJpl6TXDqe/oUNI6X3jq36BQrCosEUsq5
	Q3QTaDMDA4Y4+5inb0+Qx5XLT2E6AI1t0tSFIJ+IaVvgRwr2eaqKIlhrTcOZU8YF
	yxU4QIk2dQgzez2rU3kIaQk0RowPylani9eXhVrZUHkIEgTbmRnx2sYLuHSp20OI
	CWIQpYIuuXrqn0BlHwRQA==
X-ME-Sender: <xms:q_W5aKW1KC_PYxHDo5HO7DnHIG9jM0F51pK2n3nbJW-654_9mOkt1A>
    <xme:q_W5aBKjjZ87KuxXplb8TJZNnmVOrRk5OttQxgh2S1DNhF2FZ4ThC0iwvIFNZp2hQ
    iNZq6ir3-u0bANVxQ>
X-ME-Received: <xmr:q_W5aK-oiPlrTD4uNJcudiNo2EADLx1GLgajD5if2GzxDk8yx6WIZTsiUmtzifQpS1tPYh--jQ1b5zYrZNNuTKh7magKFDAE-_cvWE8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeileeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedt
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhhouhhrrggvlhhlmhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:q_W5aEJCUvcIkphIiKXfitFBf3omwxqx6wT2cL46mWNYzNegg92NYg>
    <xmx:q_W5aPnP-9Rbt5EQIMdmnt2G68O-DedVojNgR4lssTn_g96yszclpA>
    <xmx:q_W5aINWiBsozD9uEqLBPUUP7nFj75fcto2EvRi_lYXyG-qYW2RUAg>
    <xmx:q_W5aF1ut6x4skwNNSSxbGd2o0XKL3mkGWI6u3qqAXCa338GgiLA6g>
    <xmx:q_W5aDnn8FmQfgssY1YfCjkv_gq2o-wiIs_n6-bmtFcIP-qxXEeKmGV3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 16:25:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?=E3=83=8E=E3=82=A6=E3=83=A9_|_Flare_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?44OO44Km44Op?= | Flare
 <nouraellm@gmail.com>
Subject: Re: [PATCH v5] alloc: fix dangling pointer in alloc_state cleanup
In-Reply-To: <pull.2040.v5.git.git.1757007856062.gitgitgadget@gmail.com>
 (=?utf-8?B?IuODjgnjgqbjg6k=?= | Flare via GitGitGadget"'s message of "Thu,
 04 Sep 2025 17:44:16
	+0000")
References: <pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
	<pull.2040.v5.git.git.1757007856062.gitgitgadget@gmail.com>
Date: Thu, 04 Sep 2025 13:25:14 -0700
Message-ID: <xmqqqzwm6k45.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"ノウラ | Flare via GitGitGadget" <gitgitgadget@gmail.com> writes:

> index 377e80f5dd..3a5d0b2bd8 100644
> --- a/alloc.c
> +++ b/alloc.c
> @@ -36,19 +36,22 @@ struct alloc_state {
>  	int slab_nr, slab_alloc;
>  };
>  
> -struct alloc_state *allocate_alloc_state(void)
> +struct alloc_state *alloc_state_alloc(void)
>  {
>  	return xcalloc(1, sizeof(struct alloc_state));
>  }
>  
> -void clear_alloc_state(struct alloc_state *s)
> +void alloc_state_free_and_null(struct alloc_state **s_)
>  {
> +	struct alloc_state *s = *s_;
> +
>  	while (s->slab_nr > 0) {
>  		s->slab_nr--;
>  		free(s->slabs[s->slab_nr]);
>  	}
>  
>  	FREE_AND_NULL(s->slabs);
> +	FREE_AND_NULL(*s_);
>  }
>  
>  static inline void *alloc_node(struct alloc_state *s, size_t node_size)

Looking good.

> diff --git a/alloc.h b/alloc.h
> index 3f4a0ad310..87a47a9709 100644
> --- a/alloc.h
> +++ b/alloc.h
> @@ -14,7 +14,7 @@ void *alloc_commit_node(struct repository *r);
>  void *alloc_tag_node(struct repository *r);
>  void *alloc_object_node(struct repository *r);
>  
> -struct alloc_state *allocate_alloc_state(void);
> -void clear_alloc_state(struct alloc_state *s);
> +struct alloc_state *alloc_state_alloc(void);
> +void alloc_state_free_and_null(struct alloc_state **s_);
>  
>  #endif
> diff --git a/object.c b/object.c
> index c1553ee433..986114a6db 100644
> --- a/object.c
> +++ b/object.c
> @@ -573,16 +572,11 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
>  	o->buffer_slab = NULL;
>  
>  	parsed_object_pool_reset_commit_grafts(o);
> -	clear_alloc_state(o->blob_state);
> -	clear_alloc_state(o->tree_state);
> -	clear_alloc_state(o->commit_state);
> -	clear_alloc_state(o->tag_state);
> -	clear_alloc_state(o->object_state);
> +	alloc_state_free_and_null(&o->blob_state);
> +	alloc_state_free_and_null(&o->tree_state);
> +	alloc_state_free_and_null(&o->commit_state);
> +	alloc_state_free_and_null(&o->tag_state);
> +	alloc_state_free_and_null(&o->object_state);
>  	stat_validity_clear(o->shallow_stat);
> -	FREE_AND_NULL(o->blob_state);
> -	FREE_AND_NULL(o->tree_state);
> -	FREE_AND_NULL(o->commit_state);
> -	FREE_AND_NULL(o->tag_state);
> -	FREE_AND_NULL(o->object_state);
>  	FREE_AND_NULL(o->shallow_stat);
>  }

Very nice.

Thanks.  Will queue.

