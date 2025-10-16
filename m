Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CB222D4FF
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640730; cv=none; b=Vqq4bNR9n2oMpKgybHYP6tTbD4htjItMqMoyWBeiJt0gB6MgyKUp92byGSu5l08Rij38HSLnxppJZORtR9UP9EGLPJj00dO+uuWJeOMzJj1kZt2vtdxSEHwXHgqHrq9eMdwWQ6ovk1ZAvwpM/T9VB/SV23v1XlCEnn0+rFivXQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640730; c=relaxed/simple;
	bh=fSopAxre+b7uAAmzPTf5Fnm52YQfltVmyBOvQ6TSbfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UxhQZEM8ITmgRSOvaecJ37Ylw98HHTsUgtP0kRKXoTboNm6KtUdgri9WnYFLnrdn9by/AqdXRsRJGAoQefOfHZ7SLe9W9NXXfNHWSvR6IM4wgm8dnyE/enMOqf6lOb2zPWyEJ2a9vEBEAfClgJgngPIBoUedyO5tWuHU0/MVapA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=edcQGw/9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i3kQo5kE; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="edcQGw/9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i3kQo5kE"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 46C9DEC0102;
	Thu, 16 Oct 2025 14:52:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 16 Oct 2025 14:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760640727; x=1760727127; bh=yQXLWh4vT+
	w7cDuxmoAhVabh8HhaGVnKI6OcVSWrxws=; b=edcQGw/9tRGMqpp0r8vuVCMNPS
	8Osox9fLMx4zgrg0iZIY1U8Ejo5htMN4V6rywSDv1cWwMDIqxJeiIHyURagRo3v/
	dTIbQaaXBt5HptvdJAiEHbuPrAwIrKZlTSD2iZbvXtC0kroQh6ac60SJG5xWsuoh
	UjpyIWoQSM5yjU27YE5/d7zXDvZV+OVdKdoq9N75d1ECTXkUTyDwWOOqSSI0Lym+
	v5vGJfmQNJUdCtgtxCYRhsMwfRNhZ2J9fTlfTR4HR37LqZu+fAjRJyE2pMfv+hhh
	/tX4M6GJDbxGTcQ0Qb20dO52LQYQsXhVLLTS6RoSK2PWUs3oG2SyR98aDeMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760640727; x=1760727127; bh=yQXLWh4vT+w7cDuxmoAhVabh8HhaGVnKI6O
	cVSWrxws=; b=i3kQo5kE63gxhnwJlWfrb9Dy+VhbsAUw1gr0TTxRo0ViMkZDbOL
	znnFAcsCebye1WcjZBqNpl9IaAJqxbmWtJEjqjfiTfSM86FvIYxVRj5kCbOVG7bU
	DC7lixm/k90AalrBOKzVXO3N6Yn8zFHCZwAWaWhxgDOCeeGfEy5TDQbf2P//bxWn
	rC6MnBGAWnmDlHJ7Z3Is7I+wViUbvYc2YyUGUMbb0fcKGBXP4VzxLB25AlxXwMEa
	3JFA+mjqzMYn0YsYMdgRvVbCWPyNFWMEleamp9tN9Bb2r0m68khaYrkesOxGBgJI
	vPAQ8gXS5FU6PV69Sq91pg+IDNRsw6P0Y1g==
X-ME-Sender: <xms:1z7xaF43TRcQ6hZKol9sXFaXgoOq44izBCxfjiCYt1vXUwotsPbENw>
    <xme:1z7xaKX-GIx0fnR3oyQn65SLg2PvNnklsIOCtPHKHw8JnpF9IrUq8TqIFgHIF3neg
    Z58uLYzFBx3LD8djrFbXLpcGu7pRw_2eoXA3celY6Am6BbnvHeIkQ>
X-ME-Received: <xmr:1z7xaJ2yBibG0n85bIKOXIQjgIhWcupq5kiVwRh-X4cm-H9ppCQ4q2PeyAF1esF-w7vrkGip_8V-gXY3O6zoZfwvEvK4v7dxEa_y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepohhkhhhuohhmohhnrghjrgihihehgeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1z7xaH2e2ezgyn1xnu3MPfc2DJPwpyioAGHgjdp_WZJ6-25DGQMSQA>
    <xmx:1z7xaM9EqkiQDeVdC39IZxV_xAE25uq-quEnseJOyOBYKTBf1xI2lA>
    <xmx:1z7xaE3HtuXzBjv9maPY8DN7LjzfQJdwFidRQKNzI1YlF3Cpj47qXQ>
    <xmx:1z7xaJ8TsfRyvQtaCmTqx8rbkqBpPet4jZP8avenZYWFlcrBr91xBQ>
    <xmx:1z7xaCWJNMgZUGYLtzCf64RE7MHhVuzgzmD_BkAZ0tsNw21KVrgrByKd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 14:52:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: trim only CR characters that precede LF
In-Reply-To: <20251016184420.78268-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Thu, 16 Oct 2025 19:44:20 +0100")
References: <20251016184420.78268-1-okhuomonajayi54@gmail.com>
Date: Thu, 16 Oct 2025 11:52:05 -0700
Message-ID: <xmqq4iry4r3e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

>  /*
> - * Strip CR from the line endings, in case we are on Windows.
> - * NEEDSWORK: make it trim only CRs before LFs and rename
> + * Trim CR characters only when they appear before LF (\r\n) line endings.
> + * This avoids removing legitimate lone CRs from teh content.

"teh" -> "the".  I know, I myself often make teh same typo.

>   */
> -static void remove_cr_after(struct strbuf *buffer, size_t offset)
> +static void trim_cr_before_lf(struct strbuf *buffer, size_t offset)

In other words, this normalizes crlf to lf line ending.

>  {
>  	size_t i, j;
>  
>  	for (i = j = offset; i < buffer->len; i++) {
> -		if (buffer->buf[i] != '\r') {
> +	     /* skip CR only if it comes right before LF */
> +		if (buffer->buf[i] == '\r' && i + 1 < buffer->len && buffer->buf[i+1] == '\n')

Are two different mixture of tabs and spaces used in the above two
lines?  I think they wanted to begin at the same column.

Also, the second line is overly long that it does not even fit on my
92-column wide terminal (yes, 80 is the limit, but this will let a
line in the patches quoted a few times to still fit, as long as the
patch honors the 80-column limit).

> +		    continue;

>  			if (i != j)
>  				buffer->buf[j] = buffer->buf[i];
>  			j++;
> -		}
> +		

Do we need a blank line here?  I dunno.

>  	}
>  	strbuf_setlen(buffer, j);
>  }
> @@ -1023,8 +1026,10 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
>  	}
>  	strbuf_release(&gpg_status);
>  
> -	/* Strip CR from the line endings, in case we are on Windows. */
> -	remove_cr_after(signature, bottom);
> +	/* Trim carriage returns (CR) only when they appear before line feeds (LF),.
> +	*  mainly for handling Windows-style line endings
> + 	*/

	/* Convert CRLF to LF, in case we are on Windows */

> +	trim_cr_before_lf(signature, bottom);
>  
>  	return 0;
>  }
> @@ -1110,8 +1115,10 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
>  			ssh_signature_filename.buf);
>  		goto out;
>  	}
> -	/* Strip CR from the line endings, in case we are on Windows. */
> -	remove_cr_after(signature, bottom);
> +	/* Trim carriage returns (CR) only when they appear before line feeds (LF),
> +	*  mainly for handling Windows-style line endings.
> +	*/
> +	trim_cr_before_lf(signature, bottom);

Ditto.

>  
>  out:
>  	if (key_file)
