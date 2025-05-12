Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FAB24EF91
	for <git@vger.kernel.org>; Mon, 12 May 2025 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039848; cv=none; b=BzMiofS8Zvc7RZ4j/csdcPQDxtdoYv3qAF4NRkrTlx+eBgYrvJpY6HzZLw+oC5rnTmIh0TkbY0/6y/g1V5GC7SpH5rzmymB45lCsUYcP6HYotNx1OCb+ZOkH7fUSSt7b/+vaGsUxzW6GKxF0hcve07h6R40mHVnIT65zihMZRT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039848; c=relaxed/simple;
	bh=yBRShAVbAwgA936Kmh+dPTEhXCZbw7xQ7eWwXf8F7qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia12BLozGRksyihuJSMIORTMbukQ54qKwvdwVfAQcMB9UTyp93gT/F2bIWMIgdxDKqv7CSl1hdwlx25zws2OblrFxU76FLRW9Lys+jv29v0pofe2zXZExY6uMl0zQr8nnp/p8Ely4WyFRqr1mjbUi1Xg6tTVkdKFbhTC66HgSMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hwIOFiKQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YsQ05jD6; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hwIOFiKQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YsQ05jD6"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C45D114016A;
	Mon, 12 May 2025 04:50:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 12 May 2025 04:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747039845; x=1747126245; bh=k093zmjSxi
	4ilm4v/r3YQPVGHKu4q9QADX3Wt6U81aA=; b=hwIOFiKQ2RxQJ2KN8qO82ZC4Gl
	r0uWB6b8LfnOy5EI9DI/bk9SS1+ZBIFdCt+kPJ/bYZ9/OHYFYAMQ67HY9uuyY0M7
	i6iSYrO4DxS0TUZU6khk86hcWE+f3kSdU7NPJjfqiaxYaS5MCuZMDF5jQvitBw+4
	1ObUhKU+Ah6aVfp4cIp1kqkQxUNGpd3qDgDuaKzHRU5p1vHLEyyeiadsftvziCr8
	FOq9+pSxBfZGpNkfyjAOcsSnpNxx8Zis4mr9J7MxKWvJB1MG/Gtx96+KvggcnRJV
	Q5l9aDN13ArZ+SxyKJcsUZsulkhIL6sgIsAPqGpVGZeaFhKLQWSIanXG4cng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747039845; x=1747126245; bh=k093zmjSxi4ilm4v/r3YQPVGHKu4q9QADX3
	Wt6U81aA=; b=YsQ05jD6eEO2RLXOHTDntKk1SHZQb8S8xJrm2yJV+jdyZnswu0S
	eBaGuq5IkgsiLpCtN2mDWd4xImmFlrcellUexUz7lYZPoVuTNYHEjRMl+XEnmeqd
	6+RfZ0RKKUjUEvPVv3Ufyo3y/j6doYD0/sKEwDZSP0139WAWJY2xkAckiVjuS7Cp
	Lyvwv4Mqp/A89OhoiaCwD93tIzEc0dvZvRQ7i6NhsV3eOHhuN3RNdeZdPJOeQayM
	O4zSNkwHI7bCeOuqkIdYf3Q2tZHH5JDICffXsElofsSmKs+lbRzv29zOyKPe06dW
	g3U/aVrTq8FZe/d71x5cpiNtp+5CYiD1azw==
X-ME-Sender: <xms:ZbYhaCld_MojMpmWCL5UXLqyi6drgyDru_mUjWXQLpKiDuud3Bq-aA>
    <xme:ZbYhaJ2c6OBrjlINt_Q0VdPBtga_mx3nqLTBjoEiAOJemEJOgmCMUzUlyJ9X4gAGJ
    icpvCUex_5S_4Poyg>
X-ME-Received: <xmr:ZbYhaAoV3D28HxTL5eZ0xmOKzwhbTzRCQ8zp_ClV9VlAjO5UlOavh6R9VdIGWWmWGwiGK9uBHRIFeG5PPMJSM7gXBVT7NJPoOqKIL51uWE4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZbYhaGldt2eYwSfqfrWqiBV0fSnlaAlS46EzGF9ZJj9QDNvqshg2GQ>
    <xmx:ZbYhaA3gDk5qaFKCZ13RM9jhZfVM2Hvw19EAYOykRvby8RL_mFB-VQ>
    <xmx:ZbYhaNuvg-xg3eB6A6t4gU25F3KavGLcx6eEF54RudCR5jfQcLcCqw>
    <xmx:ZbYhaMUzkn75H1et9s4Cm5PPF4SsRE9mU8xUTTc7uOEYzTHczuiehQ>
    <xmx:ZbYhaHFHmDQbskDtoiUZqQ2HwGATB2e0D5lkmU46G7kTERAiPaxNndBN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 04:50:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6029a40f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 08:50:42 +0000 (UTC)
Date: Mon, 12 May 2025 10:50:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, karthik.188@gmail.com
Subject: Re: [GSoC PATCH v2 1/2] json-writer: add docstrings to jw_* functions
Message-ID: <aCG2XkW2lJ1qYHKW@pks.im>
References: <20250512020935.73140-1-lucasseikioshiro@gmail.com>
 <20250512020935.73140-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512020935.73140-2-lucasseikioshiro@gmail.com>

On Sun, May 11, 2025 at 11:09:34PM -0300, Lucas Seiki Oshiro wrote:
> Add a docstring for each function that manipulates json_writers.
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Mentored-by Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>

I don't think there's a need to add "Mentored-by" trailers to every
commit just because we happen to be your mentors right now :) If we
actually helped then sure, makes sense. But to the best of my knowledge
we didn't, so I'd just leave them out for now.

> diff --git a/json-writer.h b/json-writer.h
> index 04413bd1af..aa513e86cb 100644
> --- a/json-writer.h
> +++ b/json-writer.h
> @@ -69,42 +69,175 @@ struct json_writer
>  	.open_stack = STRBUF_INIT, \
>  }
>  
> +/*
> + * Initialize a json_writer with empty values.
> + */
>  void jw_init(struct json_writer *jw);
> +
> +/*
> + * Release the internal buffers of a json_writer.
> + */
>  void jw_release(struct json_writer *jw);
>  
> +/*
> + * Begin the json_writer using an object as the top-level data structure. If
> + * pretty is set to 1, the result will be a human-readable and indented JSON,
> + * and if it is set to 0 the result will be minified single-line JSON.
> + */
>  void jw_object_begin(struct json_writer *jw, int pretty);

I think it would be interesting to learn _when_ to use this function. Is
it mandatory to call it? Can it be nested? Why is there no corresponding
`jw_object_end()`?

> +/*
> + * Begin the json_writer using an array as the top-level data structure. If
> + * pretty is set to 1, the result will be a human-readable and indented JSON,
> + * and if it is set to 0 the result will be minified single-line JSON.
> + */
>  void jw_array_begin(struct json_writer *jw, int pretty);

Same questions here.

> +/*
> + * Append a string field to the current object of the json_writer, given its key
> + * and its value.
> + */
>  void jw_object_string(struct json_writer *jw, const char *key,
>  		      const char *value);

What happens when called after `jw_array_begin()`? Same question is true
for all the other `jw_object_*` functions.

> +/*
> + * Start an object as the value of a field in the current object of the
> + * json_writer, given the field key.
> + */
>  void jw_object_inline_begin_object(struct json_writer *jw, const char *key);
> +
> +/*
> + * Start an array as the value of a field in the current object of the
> + * json_writer, given the field key.
> + */
>  void jw_object_inline_begin_array(struct json_writer *jw, const char *key);

Do these nest? E.g. can you call `inline_begin_object()` multiple times?

> +/*
> + * Append a string value to the current array of the json_writer.
> + */
>  void jw_array_string(struct json_writer *jw, const char *value);

Same question here as above: what happens when called after
`jw_object_begin()`?

> +/*
> + * Return if the json_writer is terminated. In other words, if the all the

s/if/whether/

Otherwise it reads as if the function wouldn't return in case it's not
terminated.

Patrick
