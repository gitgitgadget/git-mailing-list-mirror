Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB9F1A9F82
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364338; cv=none; b=pJEL/oM+vQWuEc2tDvJ2aWWIcZzWE8jcBNh5FYn47UXminE7v8obtILLrHfOBq4QbAW1whLb2ZG8p+J9siiWSHvMgmQlxh87gMfJkaThN4PMf5B1FXP7mprnlrhGOEiYIrMQuq1V5mm5obit/fsmKpnrrybypY6+C5eOTNytBMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364338; c=relaxed/simple;
	bh=FtRWtGG6fkHJWoH/lgxx/q3WRqEAtv3RfVJqcuHc2OY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aNGxIzx0yMlZjo/8Ajq2AOdYQpA8B8C5DWY3bY5cklOqsIJ1pABFaC5ZMo7gejaoK9Hng7GbsvHZfd1x3Naq6w5qc3VKFbY9VipuzDVDAOlT+ar+ts4hLzsJ21eiEUieopROLYO85MPbG2cMGFRE1RA4zODCLUiilplS6A1BJEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dl0beR38; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WSb8sSXE; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dl0beR38";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WSb8sSXE"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C2CE47A01CB;
	Wed,  5 Nov 2025 12:38:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 05 Nov 2025 12:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762364334; x=1762450734; bh=B8wmLrBX7o
	7s2QtsqhmjI5rOe9B58mBEpEMWeumWiYI=; b=Dl0beR38Q2aEnZbNOIq2KpMBqX
	nBeXX2WxC7XdntKyCrLyWCr4L9gFAYWKWUd2WAJh2P707GOCQrmzHRFrPtfIptrT
	djwk0Dp5dsPjeGGRC7DX2IEszXo/H2BpkavJhMPqwU096kd1p1X4pdh9jED8j561
	YaAda90lKrbMp4RhK3acR/xm0DtnTD/esPYJ5VNR5bYFikvuZMle79MczxuXTRn6
	ND+0A+ivVcH5+YpPFkMId2tDHroPSjUvXsWAGDxOyJ1WNCV6mXjE5tINhtJU0OQP
	rVzKCgujxsfzN2TcANkNVset/sebzMbVewjhKxdOyK7JVdC5kEh68P5wZrqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762364334; x=1762450734; bh=B8wmLrBX7o7s2QtsqhmjI5rOe9B58mBEpEM
	WeumWiYI=; b=WSb8sSXEFJcQAgE5la8/VYX1P2X17IuTQkCbofW3yVD1TczSHQD
	gj4uOFKMBz2lBRj4SV0h6ya8n71ShIB4AH0Cuk9xlFmG2KQ1w+1ah346QDxza189
	0i62uxFV7/RBoyo+T1Rqb1La1VJML8hPcnEHPAABgNbYRbZdJ1y8COEaaWDeKZSo
	WjYQk1RYAmYiDvOC1oKQsiM/JrLS0SkXFqMlCrlgTlukZTnNRuFWpEdEBpwYrDdc
	lqxJFsNRmP+38XJL+H0lNKONNfF3oQBsj8ZTs64zGlyeujSXIkok8tUAWn6ysJ9p
	IQzCAFNV3aVd6ymDvZfHNE41k67rbEqkQcQ==
X-ME-Sender: <xms:rosLaeu4QXQtcZZmLPIH0ipObG8_Jv0LgBkO9dFaCnUmiMBQAl3New>
    <xme:rosLaU8IZFTa4d2e5lU0ZjktSPlv8BGZYbDQ7lSzE1j7uQe0UvD7_qOi-CyQ74V38
    O6OYSGEpSHXeny_u-HGXreHST1B5VOIlS-2udOqauwjyTcFVZNuFw>
X-ME-Received: <xmr:rosLaZ1A-C00IelU-iY2E5l0vzTK3TOkyKFwB3XgaCtVTq-TqXsN9kscg_p-h5aZrlrvJLJll9RkRxIuiytibHM9wbJQjMx0JVDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeghedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehlihhnuhigrdgsvggruhhthidprhgtphhtth
    hopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rosLaZDqeFf0jwLwRK_VXi-iEzbd73pGyy-6U_zFEQIfx08yxUs83A>
    <xmx:rosLaVeHMlTbMFU4bxvmeFc1b-gX1yhcsuB2tRliWW4tKhEKCS42Iw>
    <xmx:rosLaW4LwWyK_hYaCKOMugmmTHPWZHxkjfKm6E5M7PR_XNnbfGdWuA>
    <xmx:rosLaYUMovRGL5OCGu_51TuBCyXTUysdKhhS2EKJNwfxIgMFHW7MMg>
    <xmx:rosLaRU0y7IdTPaC0ZEYU0VJPKYfIDzNXyl6VoazvsYor6CXRgTEBcO6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 12:38:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Li Chen <me@linux.beauty>
Cc: "phillipwood" <phillip.wood@dunelm.org.uk>,  "git"
 <git@vger.kernel.org>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v6 2/4] trailer: move process_trailers to trailer.h
In-Reply-To: <20251105142944.73061-3-me@linux.beauty> (Li Chen's message of
	"Wed, 5 Nov 2025 22:29:42 +0800")
References: <20251105142944.73061-1-me@linux.beauty>
	<20251105142944.73061-3-me@linux.beauty>
Date: Wed, 05 Nov 2025 09:38:52 -0800
Message-ID: <xmqqv7jol6qb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Li Chen <me@linux.beauty> writes:

> From: Li Chen <chenl311@chinatelecom.cn>
>
> This function would be used by trailer_process
> in following commits.

Please make sure that the body is understandable without the title
of the commit.  Are you going to use process_trailers() from
trailer_process()?  Can the pair be named less confusingly?

> Subject: Re: [PATCH v6 2/4] trailer: move process_trailers to trailer.h

Declaring a helper that used to be a file-scope static to a public
header file is better described as "make process_trailers() public".

> diff --git a/trailer.h b/trailer.h
> index 4740549586..44d406b763 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -202,4 +202,7 @@ void trailer_iterator_release(struct trailer_iterator *iter);
>   */
>  int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
>  

Befero the function, instruct potential future callers what this
function is about, what parameters it expects, and what side effect
it makes.  As pointed out in the previous step, "sb" definitely has
to be renamed if this becomes public.

> +void process_trailers(const struct process_trailer_options *opts,
> +		      struct list_head *new_trailer_head,
> +		      struct strbuf *sb, struct strbuf *out);
>  #endif /* TRAILER_H */
