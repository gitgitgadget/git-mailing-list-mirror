Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7342259CB5
	for <git@vger.kernel.org>; Mon, 12 May 2025 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039850; cv=none; b=OEaV2pLDRzU/oITnUH6msJmrX+7x55I/C7GtBqjIrW3wOwEX14687xVspObvFRmRPY4YCSNq3el1LmRwgChAovo8/QnHqJMMYOxztmDYMO/mZqoNhobrhazH0dlKBPN6k/fnda+ZmhvC+rbaH+wePriBC08EeqgvqNP5TnsV8CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039850; c=relaxed/simple;
	bh=SYZWdF9rj3wL7qp8P9e7rjSHNIWVvqWf1y/Yyp3oYNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzkSaTfU6yeeUnIP1Bjviffdo2f99JvpR0er887ECf7x7fYBxQicrCzud0jIIgnTdnyX0b5pzoNZo/OVjXWJRGqo5oRbL7MW5f5wb/Sq3HK43RqgBK3vNzWI1OTeuYN5nIhWxe1pIIhuqdZUIaOI2h0DPMBcmPmzymmPUezw5dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MD+38OXh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NP1+BoOU; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MD+38OXh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NP1+BoOU"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D272D1140148;
	Mon, 12 May 2025 04:50:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 12 May 2025 04:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747039847; x=1747126247; bh=MT3wnPcSuS
	mUvccc69PBy/eJRX1idoISh5W9msAxEMs=; b=MD+38OXhTtVW45ShZk5d1rwVX6
	Z9gRwCfpJbK5CyGKP6USZdJHTpIQUdH+aMKKLf7HuTGyN+5YrVY90KZRXpVeln6g
	clMMijs8SdQrr0KO7SismhxgA7ELoR3N15ef2OWPESPOKSlUnalVkc8tXrA0m7YR
	AZqO0hgW9mhEjatRF5thZeodUvFtI5nOb0SAC7eyq8pE8T4/LT8R0iilgIjDARwQ
	DFloQFh639ldhwx5kobAr6J5CcN1ronjHqqSlL7++woa+sDjnVeDuCpQjjU3qC1k
	mQ/gVK3W5faORhEaGI2/WFAZoyp3xTuJUMLYt7F1CcyNU1BBsYaVyfJCeCtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747039847; x=1747126247; bh=MT3wnPcSuSmUvccc69PBy/eJRX1idoISh5W
	9msAxEMs=; b=NP1+BoOU6BXNnmOlYqiRAk43zUNZY9DNVaTvIxCCdtmpTnLt/y5
	pjkuHc7UwwhOZQVwogr+8NbWn2RCYMQWcqaZFEJT3DOeGwiBaIfxpqM/BTaoJ7US
	IIElTh3CefxfjEaezptsp8ZhiFUTv7Flr93VP8Ej+vgdu6O3y+FoGssTTyN7yLDU
	18lvDXCQqOUaVu9V+kKUDEk2jhBB7FFuM3ZGSMMNZUsORCmpKMzf7D5AYmw+HOmu
	6ZZgUIn8Q938DsC7UydxNJUdFPcRczF3fCZau9P7/9UrvpAqrDA6I855VxNDyTC5
	aGw8iQ4jhBlh5kNR89D13yGmqsZwM4/qlOg==
X-ME-Sender: <xms:Z7YhaK-ii8I7_vE462ulF-oOF9TrvmkqU9nsOJFXmTH-eW3hWRvDNw>
    <xme:Z7YhaKua50xtFzvmwzjB2n0Xoxm3Zzjpuef24Feu00VB6IryFz6Fg1n9bpn2NzeRY
    HeJt9HH7LwoqAHnmg>
X-ME-Received: <xmr:Z7YhaADVlqrZ4sfKhGd1jqOXPRx1x1kfynkE7lVeUl2vvVpp610g7DySwtBhE_EK4lCdz_yf3PK1SdLv7DSJwa6rVajXy85KaQRrttrleho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Z7YhaCcdesYx4dzZJQePeYbT2Jq6XV1MQnyVlCgDpHtvUtAph-tA5w>
    <xmx:Z7YhaPM3ZyYVeviUaNgZSvLjn1z8lJbs9tMoQz_pxxtPXNI1HMFO5g>
    <xmx:Z7YhaMnAIeWo0LCfwK9FMydkbHa01iAnlRLkiY9nhL4xydy3GnkoCw>
    <xmx:Z7YhaBs9fVyLcIdz-4ufBWzo86pB2GaI7cyVCnYti8Rxh9HHwDZZug>
    <xmx:Z7YhaL51bt_-cL6r6qNaN2o1KUF5Lhnx39-UkL7vPbUOOtdjZr5heV-h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 04:50:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6488c1ad (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 08:50:45 +0000 (UTC)
Date: Mon, 12 May 2025 10:50:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, karthik.188@gmail.com
Subject: Re: [GSoC PATCH v2 2/2] json-writer: describe the usage of jw_*
 functions
Message-ID: <aCG2ZBKC8Xvr-mMQ@pks.im>
References: <20250512020935.73140-1-lucasseikioshiro@gmail.com>
 <20250512020935.73140-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512020935.73140-3-lucasseikioshiro@gmail.com>

On Sun, May 11, 2025 at 11:09:35PM -0300, Lucas Seiki Oshiro wrote:
> Provide an overview of the set of functions used for manipulating
> json_writers by describing what functions should be used for each
> JSON-related task.
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Mentored-by Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>

Same comment here regarding the "Mentored-by" trailers.

> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  json-writer.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/json-writer.h b/json-writer.h
> index aa513e86cb..8b7470af67 100644
> --- a/json-writer.h
> +++ b/json-writer.h
> @@ -28,6 +28,34 @@
>   * object/array) -or- by building them inline in one pass.  This is a
>   * personal style and/or data shape choice.
>   *
> + * USAGE:
> + * ======
> + *
> + * - Initialize the json_writer with jw_init.
> + *
> + * - Open an object as the main data structure with jw_object_begin.
> + *   Append a key-value pair to it using the jw_object_<type> functions.
> + *   Conclude with jw_end.
> + *
> + * - Alternatively, open an array as the main data structure with
> + *   jw_array_begin. Append a value to it using the jw_array_<type>
> + *   functions. Conclude with jw_end.
> + *
> + * - Append a new, unterminated array or object to the current
> + *   object using the jw_object_inline_begin_{array, object} functions.
> + *   Similarly, append a new, unterminated array or object to
> + *   the current array using the jw_array_inline_begin_{array, object}
> + *   functions.
> + *
> + * - Append other json_writer as a value to the current array or object
> + *   using the jw_{array, object}_sub_jw functions.
> + *
> + * - Extend the current array with an null-terminated array of strings
> + *   by using jw_array_argv or with a fixed number of elements of a
> + *   array of string by using jw_array_argc_argv.
> + *
> + * - Relase the json_writer after using it by calling jw_release.
> + *
>   * See t/helper/test-json-writer.c for various usage examples.

Nice, this is something I wanted to ask for.

Patrick
