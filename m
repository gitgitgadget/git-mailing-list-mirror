Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C840DFC7
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774142420; cv=none; b=bm0fVYxpFnf9JUN5bpTkIAb/YzLT3CHaw8kVeKHglyiLT5O5+ou4Paj94Vxu4f5Ppzue0zPLTGmOLGG/lSvSdu5ULJ1IFF+VZWa/2yYwrmNH3zl9Y7RkY5o8ofNoc4KTNb4G2XUsg0K4yyNuUXF/TbS7kklysHQ4eumQItq5pVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774142420; c=relaxed/simple;
	bh=j9pCHSE7zATpTRnaqtKL8fLC9AfII9hJ/Z43VKqzsxc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PPbwcYqBG2vLDC290HVWSVKCn5sxYRMThF+hTYFEeGMJgq0N1qL7nKunUonf/rCF05SmFAzzXcsFjH9L+avLVUPTtQXog0n+IuYNbi+NPimncKh3X1BTIdgKLKJEyPgufSHUOeariHOE5l/ZIo+dRTIbOXvfz8eunZvRnBNubI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lfUDnFmp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3NhguP/T; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lfUDnFmp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3NhguP/T"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B01D7A0163;
	Sat, 21 Mar 2026 21:20:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sat, 21 Mar 2026 21:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774142417; x=1774228817; bh=P3DpTNLT7p
	VEWPl9RCX4o8VObno+t9Xy9ENj8p0t2ko=; b=lfUDnFmpfmsadudhtomBJM/LaZ
	pDi1pJr1lOXjeAer5+ddzJcb94g4bAfaNcSD+i4DaHYSIWa9YcE8Q6yMxFOO3pBb
	Aeijt+WBVWV191SP5jxBfC+72TPJJ9tqEoxNY0KckIENtDLmR+2rYI6fcox13DSB
	Kh43dos89xiaBl/YW7QQoXCSc5wRib/dIlQqXOWwBpTLQIEh+63QbGntth/4oiLy
	1d8CbUqgA3wGIyx4C0LKgSzgoU6yzUSpP8N5/ZYtqHJJXtn4/34CvBQZcG0Xqv3j
	S20syZ/eAsUoLvdZ4uS6IujJ/AdhtM4nFH3C1zNu9I2pTUnC3jpNzZ/hlxNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774142417; x=1774228817; bh=P3DpTNLT7pVEWPl9RCX4o8VObno+t9Xy9EN
	j8p0t2ko=; b=3NhguP/TyDsnVMQ62osM4xK7L9ipj9ZU/GQtIqhZTCLVBm3qvVx
	JoKSQXmHdKa8bFZN2rOn+GDdazZWftGHlCsRbEruv6Ve3lGQXyBlhqmE/VVpg8qG
	5H4nsnwmHraXT4o3Jmoz20D+c/hlf2A+enSsQL0YEy0hIdI8l3HBV2LV1xH8lfie
	HggkO+roVDl9fFl1fABb0WqhKnSb02EYR5VwRJkk/wILoRAF0N/p+GflSR9gBBOP
	ix+RQDlx7PA2eNJFfJStHpg900oAqLDcny51t3XGAJZkc3LO0lYj08eLMQ/GfwTO
	TL3G8zHLDGnu3nkH657ubVMUYETRKd78f9A==
X-ME-Sender: <xms:0UO_aU4vFkAtx9TABZ0j6_2Mz40YzLGaJI3q71veqGcMMkTcd55Tbg>
    <xme:0UO_acweB5OPHODKXz6PMKR8WoaAicSYct74zzw4Bxk5U0hOIUIplFkAiSqL3zQlG
    xRwgID_sgyhLwIyOgUbcouBOQ0yysD0LoMX5unjpk5t1QFy5_SASw>
X-ME-Received: <xmr:0UO_abz31e7OAAR8lzsTIBcMv4sXhYBYBJrbwFy4_eo-xReQWq4att1Mwy8EwJkQaFdc9_IsTHNk5dJJttBf2tzkfs5elnP-BQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeggeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhholhhishhsgedvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:0UO_aUyNntzqyiDnx5Kp2ZRSTe5nLINqf10_2wQUdXdoNTn44X38iQ>
    <xmx:0UO_aVYumsGRA0YnaHhgniAUd63k1FGC1xz66wdD0k6viAcGeaCfkA>
    <xmx:0UO_aVVYi0MKue3_Vbb0wPrv_Q8-zdEX5olaCDDgp9PPYFbBfouKAw>
    <xmx:0UO_aThCRm5IlyUZNM7E_qiFirRfBfQGv9EjZJNVki7oDx01Wokrsg>
    <xmx:0UO_adSbT4doYKqeWHgYuD8IZcO3JAyIjRgslbxrWYNPK2tV1AKWAeyf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 21:20:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jo Liss <joliss42@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: remote-curl: segfault parsing remote.<name>.fetch outside a
 repository
In-Reply-To: <20260321210602.GA736981@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 21 Mar 2026 17:06:02 -0400")
References: <CAN=xy38zCRdOAnMtBXtRyUHE=+gtS8J6mwUWFQqxDAaBLAm7dA@mail.gmail.com>
	<20260321210602.GA736981@coredump.intra.peff.net>
Date: Sat, 21 Mar 2026 18:20:16 -0700
Message-ID: <xmqqa4w0acdr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> It's a curious case, though. The crashing code is parse_refspec() does
> this:
>
>   if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
>         item->exact_sha1 = 1; /* ok */
>
> But what is the correct hash algo to use here when we are outside a
> repository?

Hmph, who is calling into the transport outside a repository in the
first place?  Even "git clone" should create the receiving
repository before it calls into the transport, no?  Is this "git
ls-remote" or something?

> In this particular case, the origin refspecs are not even going to be
> used, but you can construct a similar one where they are:
>
>   git -C / \
>       -c remote.foo.url=https://github.com/git/git \
>       -c remote.foo.fetch=whatever \
>       ls-remote foo

OK.

> We could do this:
>
> diff --git a/refspec.c b/refspec.c
> index 0775358d96..e6c29b7dd0 100644
> --- a/refspec.c
> +++ b/refspec.c
> @@ -101,7 +101,7 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
>  		/* LHS */
>  		if (!*item->src)
>  			; /* empty is ok; it means "HEAD" */
> -		else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
> +		else if (the_hash_algo && llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
>  			item->exact_sha1 = 1; /* ok */
>  		else if (!check_refname_format(item->src, flags))
>  			; /* valid looking ref is ok */
>
> to make the segfault go away, but it is mostly papering over the
> problem. I'm not sure if the exact_sha1 flag would matter when we are
> not actually fetching (and we cannot fetch when we are not in a local
> repo). Grepping around, it looks like it does influence the ref prefixes
> we send to the other side (yet another chicken-and-egg!).

Yup, I agree with your assessment that exact_sha1 should mostly be
garbage if we do not have a repository in the first place.
