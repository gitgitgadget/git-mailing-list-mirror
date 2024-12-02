Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832801FDE05
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144062; cv=none; b=pXy2nmOWrLQOG+HPqXQROs05dwe6JMsTlGjEL72UNXvGL6h81y1pVMYQ040t5kg6McXe186PmN38cPErQpLFq5aRS9/X0u9QmmjnC/aOm7CO8MeE2+tuQOLhVXAbtsCuIpTC7enwqvI4pX+wy8F6zaSfoprelbXWCyDez9IHqwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144062; c=relaxed/simple;
	bh=eu2lTwSrb+rxEYdcgcECCtYmMV13W1DwSL5ernVjbek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqv1QtuvBmyu2oDvVKZ+ofXhCdicM7//Yb+alv8fNcY5j5svBicJ11B7BsJDtsKEEc+PH5xX/0LvcKuE7y5nSXj+bhAcpcxph1yLX8t0xLrvkWzF66rij1swMVK4gMDq3MQ0ebJ/DwV6SfD+kMonJ6K9riOJ6KxZW1BMQPkO4SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rt8Bipf9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2A3gZ5Qw; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rt8Bipf9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2A3gZ5Qw"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 91D5A1140153;
	Mon,  2 Dec 2024 07:54:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 02 Dec 2024 07:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733144057;
	 x=1733230457; bh=Kd43KjqdO2jxm8eEAuOpvx2P154v32VWZlHxJjTdQ0A=; b=
	rt8Bipf98gu6N+Ez0y/GBCwaC9UiFlyj9fxuioMnX332Y0/eFU5QnIu0BH1pvIZJ
	vh8wM+xH8R9XFyxVF9wngDdWnnfkcdgEDVaJy4isTsQWg8rN5AS5ri8Yd55Pfkw0
	ykeTNczMJLjJNs6ntlX8KD5UsdZ1/sfEVrq8isocmarmUIGh/Ibcvzk14AOe0bVe
	a4MDS2LufBgtegjNSyRoLcNiNCRl7jZuYD+T/lNii3oe1nwrPeMOaNIkWYaQx8qu
	T4L8Vfk7oeIEsKtTWyTKvmdJcH+F03ieY7TCQO7iDMOoPRIvE7xGKFPHnQwYffxz
	3yeN8EIh6yAH690zfarcMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733144057; x=
	1733230457; bh=Kd43KjqdO2jxm8eEAuOpvx2P154v32VWZlHxJjTdQ0A=; b=2
	A3gZ5Qw7HebmxzTjYmVsz0Qrl9XIW6nD9hqwtE2wz6TYlj+SyDVF/mQt3f1L+XvO
	i5d1gDy4PFus9Vp37ZDOOYQtMwvKmVK4UAMISOfAQ0TwB68YSnI+cyiZGhJCdK3W
	qh0LKVNLsH21Nq7SoBE+kLdHl7RlDEDc+lst2Kqa7WtpxINh0VhYv+uOoA6C/q35
	Ow28BRf/YIfPP5FC+VPvg4ZUO4Tp0oMtB/PavwiQKvnIZ2EefIC3lBjMEROICcO5
	9dFlxTI96S++5FAwJTOP5h/IH5UGhXV5YCwww4Y74cwliRX/97siTZ+EnG298NfP
	GLEogFvx1rAW6mm3MOwiA==
X-ME-Sender: <xms:-a1NZ_UxQvxgPG8-5lkpRhR-FHEltB42cpBE3bCwqHlZfQWMeZ7IqQ>
    <xme:-a1NZ3l_46y3jmsPZF38fPxOzvWqbAWNoTAvCH5NB851atbVhUjQPwF5qunqTnFHc
    t-YP3pew28EiWw3SA>
X-ME-Received: <xmr:-a1NZ7ZUUGr8W9fJgxP-l8A5wDfCV9EmoCLzCT5f50_vURWbue6d-n9fI_alcNfjPxJPLeWOmyp70LunCF5Oi0jnR8AVp8WxtVtL0APAKeNXOS_22g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdevteff
    vdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrjhhushhtohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:-a1NZ6UB-6CWJuGPuztqALNwv9ztne1S2vvocdAEnRE_4vjT_oXCGg>
    <xmx:-a1NZ5m1ueTiz5EKSdI-83UEz5d-hLqgHv-k6f0rq1KFwwMO9jbqSQ>
    <xmx:-a1NZ3dkLNTHrW56VPj8Zm2ra6_ixyQcT111i-69bbrQtUedFfXx-A>
    <xmx:-a1NZzFCe3vFUEztMfMYXcakAu7S9LyrAqIN7oKSmwfvsQsu0XD3ng>
    <xmx:-a1NZ-x8otZBJPkM7yjKGpd_jKZed0S-MH0TJA2zpL6mC4MmYOhVv__P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 07:54:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a61ecbc6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 12:52:59 +0000 (UTC)
Date: Mon, 2 Dec 2024 13:54:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] strvec: `strvec_splice()` to a statically initialized
 vector
Message-ID: <Z02t4zPTR6O2Px1n@pks.im>
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>

On Fri, Nov 29, 2024 at 06:23:45PM +0100, Rubén Justo wrote:
> Let's avoid an invalid pointer error in case a client of
> `strvec_splice()` ends up with something similar to:
> 
>        struct strvec arr = STRVEC_INIT;
>        const char *rep[] = { "foo" };
> 
>        strvec_splice(&arr, 0, 0, rep, ARRAY_SIZE(rep));
> 
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
> 
> I've had some time to review the new iteration of the series where
> `strvec_splice()` was introduced and perhaps we want to consider cases
> where we end up using `strvec_splice()` with a statically initialized
> `struct strvec`, i.e:
> 
>        struct strvec value = STRVEC_INIT;
>        int s = 0, e = 0;
> 
>        ... nothing added to `value` and "s == e == 0" ...
> 
>        const char *rep[] = { "foo" };
>        strvec_splice(&arr, s, e, rep, ARRAY_SIZE(rep));
> 
>        ... realloc(): invalid pointer
> 
> Sorry for getting back to this so late.  This slipped through in my
> review.
> 
> I know the series is already in `next`.  To avoid adding noise to the
> series I'm not responding to the conversation, but here is a link to
> it:

Thanks a lot for fixing this!

> diff --git a/strvec.c b/strvec.c
> index d1cf4e2496..64750e35e3 100644
> --- a/strvec.c
> +++ b/strvec.c
> @@ -61,16 +61,18 @@ void strvec_splice(struct strvec *array, size_t idx, size_t len,
>  {
>  	if (idx + len > array->nr)
>  		BUG("range outside of array boundary");
> -	if (replacement_len > len)
> +	if (replacement_len > len) {
> +		if (array->v == empty_strvec)
> +			array->v = NULL;
>  		ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
>  			   array->alloc);
> +	}

Makes sense.

>  	for (size_t i = 0; i < len; i++)
>  		free((char *)array->v[idx + i]);
> -	if (replacement_len != len) {
> +	if ((replacement_len != len) && array->nr)
>  		memmove(array->v + idx + replacement_len, array->v + idx + len,
>  			(array->nr - idx - len + 1) * sizeof(char *));
> -		array->nr += (replacement_len - len);
> -	}

Okay, here we only move existing entries around if the array actually
had entries in the first place. Otherwise there's nothing to move
around. Makes sense.

> +	array->nr += (replacement_len - len);

The braces aren't required.

Thanks!

Patrick
