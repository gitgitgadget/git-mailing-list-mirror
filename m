Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C44E1D5CFE
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772820739; cv=none; b=CekkyG98tVAuThkoLNgYukfeWNOaxyC6wZ06Qy+CQI9t0L1YOxV1USB75cXzbfkbz/kEpkPqeQmSQPpdsSY/V/THyy95HEA59IvV7p76VEM4idHB/4W7qvCVMO+9aX787oh0LlOJk1/7N3CtPkMJxZDy3eJSj43KePK7yextYIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772820739; c=relaxed/simple;
	bh=V1XzUtU4teSNVVPTvA6o0TLjNchpkjL2dPtYFteCalM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WsXh9dhUYzhV4Fn3v+XoNcp6WJ0rTOXXB7x8etNWdFQHSm21aSTkqmcwJnShAUtdgcLlySgKC/uaR50yVvqE7h1ldxOos0OAderK2pLOw1c1pyIU7SlCS0qt0DdvzBaHES1kmdtvfQSQrz7Qvh8mm52QkDUnJeVSZcJy0q1zGaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OA5pFo8W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UbvEiGgd; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OA5pFo8W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UbvEiGgd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D3671400199;
	Fri,  6 Mar 2026 13:12:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 06 Mar 2026 13:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772820736; x=1772907136; bh=ybt5lcexs1
	E56QLhdRz6w0+4f0A0BKvCVOyOqzJkU8M=; b=OA5pFo8WQJbH0uSvpxzHwoymFx
	gJ7JCTyz/yqxsiCOfEGEkNB3u1aE4zj8jPKuTdm/FlqsbfzIq+OPWb1G+WPitGHm
	wF/sfwLZS4sgpHpfwkzmj3JfaB39olPMr2nHrPpaGobu1wa0FrSr6Mli/GyTB/9A
	dqYnFs1fK87RiLKLL6WihXbomRlGajDsjz/6sW7j+jIIx2P5irPbSmKMKNrp2xzf
	9hJS0PWD+fmaFGtsbENH1ReDMqryeNWNbpVIl4Hh3GUU1HBUPes4msuZ/Xd72cIE
	ceZDWGoRD0bp1khiFoeD7E/sWDBucK32joU5cY2nlS3xLokZXVpVTfhd2HEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772820736; x=1772907136; bh=ybt5lcexs1E56QLhdRz6w0+4f0A0BKvCVOy
	OqzJkU8M=; b=UbvEiGgdc2anqIr0hAubMzEDANTFe/M261Q/q2bvS/et/BomG6b
	Z1yJbqTeNIdiE/ioamXc9bqHEkS3oVo6clDIUcSQRcP+mL6d0SAPhK4oJszuc2mW
	o+UAh5cmi2RIbqwhPPY5XRxxC+gb7CKuBPrqneiotjS/b6IFt4jmTqDJhawo9nrJ
	qZSkzwKBbb+8zxkwtHz2svl9CYCoOOzL9WROMHexyQtyj+BBChd7Qz7da0YQOOMJ
	fZzaA9Io4nvPiSC6EguTd0z5AQz89a/Ao8rZzavvRXCwi+P3AAyBgtHeGw/29WMk
	mkMNXqejy1Djc/lmOy2Jb5PBYC7ZrMNGPaA==
X-ME-Sender: <xms:_xiradtKtdQcD8FLLgbw7ca_Prz882Q0loe9bOh6MfZCgrhx7EAGOQ>
    <xme:_xiraYulI12T1hT9D15qyZSbbzimiociFF8nxwdbZqb4Ei1U7VQv_1N88xg6LM66B
    0umsx1-83Zp1bgLoV_fOzk1Ik3EHe-fW2YON2J2zNoz6OxLyfR0LQ>
X-ME-Received: <xmr:_xiraTA6UMBIoJwjQ7GLIJQlyYschOjxz02nFOMGkaNMHkVORP7cpK6B6FmR_EugfgrT_GTRv23Z670GxIHRmk7T1Le597-EpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieelleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdr
    fihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_xiraaNUX8n3fv8rZjniYMNrpiowf4nNHe7pCK6M3nF7cjWR3sV8Lw>
    <xmx:_xiracxPmgvKJDg58LtC4FjJv4hC6a7vHo9Zm0BMjjtjqDPjr3fayg>
    <xmx:_xiraaWhwl7gXhT2q0YR8k6AiOsEMBf57rMOEOGdEYACJmnmgBjDEw>
    <xmx:_xiraeNsD8T7mS0ZUEUIXNMviBdU5Cu5WqYf6bjC2YuX1Rn22QkyMw>
    <xmx:ABmraQXXuUYAp8gpMFnbEKvLpBf_Jduz9P-XuWgQEPkS9ixL5o7AiYZv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 13:12:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  me@ttaylorr.com,
  phillip.wood123@gmail.com,  ps@pks.im
Subject: Re: [RFC PATCH 1/2] remote: move remote group resolution to remote.c
In-Reply-To: <20260305223248.170785-2-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Fri, 6 Mar 2026 04:02:47 +0530")
References: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
	<20260305223248.170785-2-usmanakinyemi202@gmail.com>
Date: Fri, 06 Mar 2026 10:12:14 -0800
Message-ID: <xmqqcy1g25fl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> diff --git a/remote.h b/remote.h
> index fc052945ee..fa38f951a2 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -347,6 +347,18 @@ int branch_has_merge_config(struct branch *branch);
>  
>  int branch_merge_matches(struct branch *, int n, const char *);
>  
> +/* list of the remote in a group as configured */
> +struct remote_group_data {
> +	const char *name;
> +	struct string_list *list;
> +};
> +
> +int get_remote_group(const char *key, const char *value,
> +			    const struct config_context *ctx UNUSED,
> +			    void *priv);

It is dubious to carry UNUESD over to an external declaration in a
public header file, unless it is a "static inline" definition that
comes with the implementation.

Other than that, move looks correct and it is generally a good idea.

When moving functions and types that have been private to the
implementation of a subsystem to public namespace, we need to be
careful to consider if the names of these things are specific
enough.  With "remote_group" in them, they are all good as-is in
this case, and can go public without giving them "better" names.

Thanks.

