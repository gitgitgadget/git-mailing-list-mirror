Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BC129B766
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748507; cv=none; b=F0c+PGxHFj0I1k1fIhnwBgXKpy6TZNRY78xrTj0qlZwgxqoXsTtIgnEu5/gNkVgQLdNuGToMU5bx3Hy0mU5tpMD6KqjjmqbwlxpTKNAJpwjqaCaFmJm8sRSaM6/ReWvwQTQnUaA2ylKEGtsOJ0sytQ3iYDkuRfIY4HSv0DVJ4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748507; c=relaxed/simple;
	bh=ToaFFkT5ZrIN9fpNE2PSp89rnek8IzC7EjQvQDGn11g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VzijDT1BC0lFZm3i6oZBaQK4kYrVL/9RYpchRKW3khvqKKHQRHaV6vstQuATwRHWMbjDTHyazSWBcFQrpjoHUdlytMqlXldf5+zrqETvCGWwLunRiCAGsgOm0RoVWSDSFMJsvj+7eUzbCzm+DYj3+76L8lM42zybfAAOZy5HvBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BxNGE6fP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RNZmWdFo; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BxNGE6fP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RNZmWdFo"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1CD867A016B;
	Fri, 21 Nov 2025 13:08:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 21 Nov 2025 13:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763748503; x=1763834903; bh=vZittnviMT
	eO5EpvETNQ0psEWCF9Xn+nEqAGJbTNlJQ=; b=BxNGE6fPPJNphI2qFEyyxbVHlG
	aIS1VhW0gb+rzrV64o6wDwcQ/jfa4v2wbHtojlwXKeuDFF+geHOGGO1mWYunTSXW
	/BKGwm/PUIj/yL8c63t4xAEPjr4sLprhwCXqorG+ov+kYyKc1YeSgW7/W5+rZQxv
	hh0IxdIBAnnvVshhM1p4nJzGsS2BJjzCj19sEokiq1MT6LGe8KuIkPh4ART+FwAP
	9ZTmZTYDg4aUBJj3isVkYHoyz8qB0xfGltWS/8T5kPbVBqV6O7iEwCv16sFMYA1T
	pOwkkGVn4ap23lkgR2sEiNlBWwFoofLhTqVJ73qkFZsopUFqRybKnHsOYxDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763748503; x=1763834903; bh=vZittnviMTeO5EpvETNQ0psEWCF9Xn+nEqA
	GJbTNlJQ=; b=RNZmWdFomUK/eJemo6t2OwmdQtR1i8R2thz/8h/7BFClYTkNgRN
	Tnr22zo4gHLHuJClSXRtmyfTZ94YtopfDmdgY4fzUeZfi/pSAGyz7mDHIXPJAaTr
	BOlXDCjFW+iWVnOqKC8iz/v6XZZKttu+PUTKmZPchlquzGptcEdPWj4zXkp8yup5
	8FIHb5JhL2cvukuSNJfOk8ZrtyCh4J4136bygRuVxJOIKsdtfkOrvWczNLFXqoAf
	Fwi8/3a4p7/EjNz5uQ9utWqY3gUSYn6ptpCAem+kA0/ui7yseO551z/O/S7AVmkp
	WB4l9Nx0kehWl5CTcrzZPh20reJ7auHJhtw==
X-ME-Sender: <xms:l6ogaUh4LL6MrohWIw4fdOS5XuHY-rAkxv4eFKWsulbRXD5P4fIzwA>
    <xme:l6ogaT7NjForeeVZpnkKxi7LrgiRTt_pB2zla4SZfEJk3gUbY5xmljUv3GfcvNMqr
    nbQlMqrER9kxU-tsHLhn0menSw5c9Gh4OEilwrxd5HS4k0F0TOU>
X-ME-Received: <xmr:l6ogaUaqk6obetYTOMsRr3kL1P3wR88rVRtueLkAjoh6DcP4fdca5Xed6bBhLYHKIzr_b5poGkQqiT4rIAlDrVYGYP8bOfHqCBqo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedtieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:l6ogaQ6OA36m0K41rtpwLh7ET7soH7F4KAKP1QmhzcVtNh2j63v_rg>
    <xmx:l6ogafDMISeQavpqC9Y60ehbfC2YeuIEFXdCciS9PZ0pNfGBmCRAcA>
    <xmx:l6ogaec7wBglx852izjdoHjpnUYwVW1-5dtftDmC6xL3c433rvG-gg>
    <xmx:l6ogaWJT2CDUMqr0JsgNmlqDMyEml_f-2l81ty8h7sjzop80XS_E0A>
    <xmx:l6ogacLNDNkSwlzhPwbVXDl4aY5pc1SYycm1WtdKRkREybNd43EZtYQb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 13:08:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 02/19] streaming: drop the `open()` callback function
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-2-ca8534963150@pks.im>
	(Patrick Steinhardt's message of "Fri, 21 Nov 2025 08:40:47 +0100")
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
	<20251121-b4-pks-odb-read-stream-v2-2-ca8534963150@pks.im>
Date: Fri, 21 Nov 2025 10:08:22 -0800
Message-ID: <xmqqqztr45t5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When creating a read stream we first populate the structure with the
> open callback function and then subsequently call the function. This
> layout is somewhat weird though:
>
>   - The structure needs to be allocated and partially populated with the
>     open function before we can properly initialize it.

It is unclear what are left for delayed initialization from this
description.

>   - We never use the `open()` callback after having opened it initially.

I was not sure what this means in v1 and it still is not clear to
me.  Naively the above reads as if it is somehow desirable if we can
call open() after we have already called it on an object.  The flow
being a caller (e.g., stream_blob_to_fd()) first ask open_istream(),
which calls the open method after figuring out which backend knows
about the object and how to open a stream on it, I am not sure what
you want your second and subsequent uses of the open() calklbacks
do.  Puzzled.

> Instead, drop the callback entirely and refactor `istream_source()` so
> that we open the streams immediately. This unblocks a subsequent step,
> where we'll also start to allocate the structure in the source-specific
> logic.

Because I do not think these open methods specific to each storage
mechanism cascades into each other, open-coding the logic to
dispatch into these open() methods in istream_source() itself,
instead of setting the method there and then have the caller call
it, is a perfectly fine simplification, I think.

> @@ -478,19 +477,14 @@ struct odb_read_stream *open_istream(struct repository *r,
>  {
>  	struct odb_read_stream *st = xmalloc(sizeof(*st));
>  	const struct object_id *real = lookup_replace_object(r, oid);
> -	int ret = istream_source(st, r, real, type);
> +	int ret;
>  
> +	ret = istream_source(st, r, real, type);
>  	if (ret) {
>  		free(st);
>  		return NULL;
>  	}

A patch noise?

