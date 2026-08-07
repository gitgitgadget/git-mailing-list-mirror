Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F8A363C5A
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786138872; cv=none; b=deSofH3XZZQTnODFhx86E/vdSAwxT8YnSbBOg6bKtdQmnYir0or0ygGaID2xpPEM6Wtx/yctHKSuKtlbs/kZ8ww1IVasy0HQs7VU/NAkeShjtEsz0ZPiCe9SILrTvmQ8wy8ZcY5+F7AhFFTI4agy2xu4cYWJ6YU8LGwkCjl3Qoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786138872; c=relaxed/simple;
	bh=YzUXgwQWp80xI+/iph02kEzvJV1LEibJflRMZh4mJS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nRszfz8Oh03D6Zs2GVGFafXFjGUjR2u1iNm7v+2LN/sPGG3ZMrhgPANZJLWvgGU4T7OHfW7m2DlldpgcD+YfJsm7HK1YFzEgjG7WzfxHvD/Kj1JqXs69mnBx+4PnSr6z0r8WK/mvSuoIMgVjxmZGA1GbY808CxWPVu8rwQ0b8sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lZA41R9s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YKE8qese; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lZA41R9s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YKE8qese"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B630C7A015F;
	Fri,  7 Aug 2026 17:41:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 07 Aug 2026 17:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786138869; x=1786225269; bh=M16wGTo0lB
	HHMwWwncE44ohVcUVP56h3dr0wdRs3s70=; b=lZA41R9sp0FJ9b5G38U1o5jEi3
	Qmsz4NlnPtfqKo7C6gQWJMonOUhdbtztV46wWNmc7Kra4dyC5Zk+RqSYky5iTQs8
	EAmHfWdkirlS2Tek+bxDwwdRSB/1qDuzry5i9nc7waCpqWYI1LrV2oihtB9ZE6a6
	AUoV+98id+qZrDbQQyuqnnJe6E/gWFLmzvc0hygjcS5psM/Nsq1rb1qsy3/bqD3/
	WSXnrui4jbSI7okO6clkWRFxnc3Pa+1pmX3QBYRXDgnJvtR54Ly+KF71euI7o6U7
	HChqD6vn+ikTtSnC/bl6pw4QkbuPEueuIgsbxOKss8Yugt9xfPQh7dg3U07A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786138869; x=1786225269; bh=M16wGTo0lBHHMwWwncE44ohVcUVP56h3dr0
	wdRs3s70=; b=YKE8qeseYJVDINN6MfsvMmi2umWFqGMYr03yF4pOF8UnteZ9xxG
	7RtXbChYSmvsDB0ZPq/Tcb1+BaX6iGp0E8uyTcLhWD9EapgsogWKqkiFGSyTYtyv
	5Kna837jskaVONjreUIhJMZsbmMs39lPrbnzMFf/V/zmhzqxVRB1isWlAEpw4LK/
	49vzr3L0ryscYaUNMFd/wtHFcYg09BzNPyyPh/tGJgz3m2yhqfNp4ItX4blQpQFZ
	bumzYOuqMGbL7jJuvqNsPeJom+fwlkpA0vjtNsYBzVZ72P/fPO34FPspL4foiB0T
	Z9gAzzfldcSGr0i0TmLxCK+Jdj4Rt4Sx0LA==
X-ME-Sender: <xms:9VB2apwaoX0kwJZSRd7mNgcFxDQqb0eIuFiAdPmB0qzftWqyUmeLFA>
    <xme:9VB2agJjfSYeoGR43lGylWTQWjmtt_w1LG0cAdrud-yMmZ-VGVa_ohf8UQZRU_4kY
    uoAeD6wFE3xDYwgpJt-9ryJ-mXOOtyS-9HupkQRE_y2U31_dG0l>
X-ME-Received: <xmr:9VB2arqGQa_v41fxcxcXj10J_IXCBuci9VF1rdw5XlO6ZlooQAdQvUJb2vVKOC8GLzREklpVgacJ1ykeeaqxIpjlg3NSqonyEw>
X-ME-Proxy-Cause: dmFkZTFaoLCZQm09K/rRxBTvaICkYjvITCTx7mClZklY5pE9bVbdnrQwsQtAEVdHiYGv8k
    Zzm7loOc661OUQmYfgtZLlCpW4Z10lWOdGFxVTq3oAftIHQQe/p+U5UeMU701/Ff/z3z9k
    OgooJKK5Jj/kCtXPZ9N63RuL33UluLT2nu6flQqoCh/x3aSI0uWWv++p3hWTqRAQvQI3Je
    eZrReEYLkvZ6X2AacQ06Dg47q0DycwYdTnYuzIb5MdyacZTKpz+Lh7U8wSZezmym+Jk5IM
    O1AIAi22J5XMwecgltQhGtqoTSn+7e1sIhMjkHtGYOcYjKItAsC4S+ArWwH9l2zRGBGDil
    WP2k5aprWjP26oeVUoyZEJbgywoG3jAUzzNFL1yVl3zJRpIMBJR+ZBbnapMVSFsRhbSfy3
    1lHWDhFxIy97tsreZH/Wqtv0L//NliEdTObPZ/8SA+BpjOZiIvjyERIJs1q5F+sMVEcFMv
    Z+t01ROKO3uA8x/I7JpZhjcuDXwtn7YIJmpoeSEhySUAYmviuHGbp27ON2K2jwWmb7nSf2
    juaozGbSHfgcJDu/qobDvb9SwVLSF7UH4NNpkQ3jw0hNpQStQ5kXkCXetraUmkNg0iuO5B
    OLL21qmd9bOlTDxMrvWTLy0Xr/JbWkXcY/YHlk+EavR08QfUhqJnH3vLT3zA
X-ME-Proxy: <xmx:9VB2anKjCoMJxA94v8JcFqDt_7dQwn66lxq6V3mMjpXOAxSMaNtUJg>
    <xmx:9VB2aoTAjRjggkYLBeZYRrWIKHR8jUOlW9bXv8yGYzsTRFMpeJu24g>
    <xmx:9VB2auvp_cQY757mHojBnaISsG_MwVy24n19VCHwyNQdfSTh4di4YA>
    <xmx:9VB2ahYDI8VFQjm_qcncsyKyWmdQFtFbkjEVKtp5lfFddQHF2gFH0g>
    <xmx:9VB2atjw2cz6I9mbolOByxV9ym2ZlUfk18lpVw9Bzntwa0z2Zu9TF0bu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 17:41:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 07/12] packfile, git-zlib: widen `use_pack()` and
 zstream avail fields to `size_t`
In-Reply-To: <ca928b457959ab8bfa643c65f83ca1ec4289fdd3.1785946479.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 05 Aug 2026
	16:14:34 +0000")
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
	<ca928b457959ab8bfa643c65f83ca1ec4289fdd3.1785946479.git.gitgitgadget@gmail.com>
Date: Fri, 07 Aug 2026 14:41:08 -0700
Message-ID: <xmqqjyq1d2x7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/git-zlib.h b/git-zlib.h
> index 44380e8ad3..0b24b15bd0 100644
> --- a/git-zlib.h
> +++ b/git-zlib.h
> @@ -5,8 +5,8 @@
>  
>  typedef struct git_zstream {
>  	struct z_stream_s z;
> -	unsigned long avail_in;
> -	unsigned long avail_out;
> +	size_t avail_in;
> +	size_t avail_out;
>  	size_t total_in;
>  	size_t total_out;
>  	unsigned char *next_in;

We have these size_t which means we can use a buffer larger than 4GB
where size_t is larger than 32-bit ulong.  But these are sizes of a
single contiguous buffer, so I think that is why the log message
mentioned that this is more of type consistency than being able to
handle larger data (I do not think people feed >4GB contiguious
buffer in one go in practice).

 - zlib_buf_cap() is still "unsigned long", and zlib_pre_call()
   feeds these potentially wider values to it.  Is it possible that
   we trigger truncation before the avail_in/avail_out is compared
   with ZLIB_BUF_MAX in the zlib_buf_cap() function?

 - unpack_object_header_buffer() still takes "unsigned long" length;
   builtin/pack-objects.c:oe_get_size_slow() passes size_t avail to
   unpack_object_header_buffer().  This comes from use_pack(), so it
   is a relatively small value stored in wider size_t but I am unsure
   if your static checker would not flag for potential truncation?

