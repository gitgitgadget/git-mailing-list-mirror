Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98643002D3
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769214; cv=none; b=aKt3+iPLqGFGmIIi2oE67vUn+IAucQuK0STfcCJ9g/OPiDpqyFPR7Yzx9eaTQYc5PP6jUKHl9oSwOmO10/EKZgjdxMqwW0cWcrlKE0eBnbI4viX6cxkZ4GguI3ChTMje6vmuM6b5F7GGBTiFjkd76lEBB8x0RSF/EVam5UHmb/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769214; c=relaxed/simple;
	bh=dhj+PGn4VdiZt/XZicyIBqDSTWMvD8HWOB/KCXRFjTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDYnPDv5kDXmmQRRxtWbNGitIa/K9ugsj/fTre7P4yqwllPFzLJok8trLt82b6FzUaB9XVpI7OYi/njuI6PjAVagf6QIdNeWJal8Yq2uTbQAfkvUgLX34vN1mluV4v+HQ5WQg32bIc1Jk7qU8V44HKfensptR+E5eTb/8KI0nf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=edCl5s2L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bzo13a7I; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="edCl5s2L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bzo13a7I"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E1E011D0003D;
	Mon, 10 Nov 2025 05:06:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 10 Nov 2025 05:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762769210; x=1762855610; bh=ztRceRDTwo
	82SnqodRL2yrWEAyukihiIk7b8rkfuXWg=; b=edCl5s2LyYQIf0B/7plt72+1el
	NHRCfha4If0rcWP11fz/9gzdtAi1tUM0Cy+t2c3M/ADmPbwcHn3RT8NaEsGw095b
	2BXc3FC933Xm7m3E6Z4BgjulcdJVI7JfStzOwrWFnMJGBo91zCfa98mmi4bFbmD3
	LraMstlxCpAUuKY0H3m8vNihNGj4qJridcwxJWzqfDHnTHvuEU/Kptprszd4gi4u
	Ph5V0+pRRhZL9UalOzvW2DzCBOoEp+XiYot7mSbWEcXSiXx7BZYWUTKT8CvgYxaG
	LY/T2dAFvIvYS6ZEScmrryXSWbSHalfFqlWG5WMRSC+4uHLudArMD/h/MliA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762769210; x=1762855610; bh=ztRceRDTwo82SnqodRL2yrWEAyukihiIk7b
	8rkfuXWg=; b=Bzo13a7ISx/0D6ZmUoLJAjTxscHV1lscuhT1cWvreJnLHM4MJhi
	4h5eccskIXjAJVz3il67lmb9yvt1kFTEs+KS/bIbpYNv0KUTtQr4iXOpCvFjjkvH
	r+2jWpxUaJyB3ffJpEXw60Fllp6s9W00TEHOlFEVG5R7QmSAm72LSLyhSamA9Q9c
	17rBCf0EAYAg334ZRV7G1Q60J3eDia/wNsXuilucFtqh8tBhMx/RCwxPeivKjiwP
	w9iOPAD7AifAi+nBTdjl36VTpMZHO3kRWm+k0FhQX8EfIo7ewc4xRB/uS5Ue/q2o
	UuvgXcrzt9gHy3ptw8YLS74pwTyCfn+qWEQ==
X-ME-Sender: <xms:OrkRaU0SLv2w6B6FnVfc-ydc88FRf50SWSwVWCdPiA5YuBaEBavBPw>
    <xme:OrkRaVGYnq4J4zQAdCvhqS43xNIlhlp_M1PugC7VnLP4MhKpQK5mGau8DsVHeHxkf
    qG19RfrHn7Xs5yIDGVmmYT18K-udbQ-D5MHYYeMJPlQpd9-mLueJc8>
X-ME-Received: <xmr:OrkRaaiWVLM4YZCTcNOTgSI9juNQfQmHOORO1KNTx_rhTUYiB4WhKydArl3S2wgUlcK-NejDW2PSljw5dXWqs2JvxdM1idMwkMP0IRlxBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleektdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OrkRaY9eGRXNKurw7WdAOhqgtFGN-ccjvR6zJNJpHwOpj0ASZwXviA>
    <xmx:OrkRaZo6XN6T_4tVQXKl-5Z8PR5Nb2sctvwsP3eaSObIjzlZ_wbVqQ>
    <xmx:OrkRaf86e7kDuff4I3DgQWKt_ybagmY4i3uBHGBYFuuC5i7RNLTplg>
    <xmx:OrkRaVXrIREb1ma98xRxrEjc4DbxrrNq6fRe7fH5dnN49QinQJpR8A>
    <xmx:OrkRaQNLQ4fXZoxKGFa-3MGux870j-HC8pKxG55Wr-zzm0g8USb7snSC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 05:06:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b73adfdb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 10 Nov 2025 10:06:49 +0000 (UTC)
Date: Mon, 10 Nov 2025 11:06:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 07/12] diff: update the way rewrite diff handles
 incomplete lines
Message-ID: <aRG5NSvzeie_J3x9@pks.im>
References: <20251104020928.582199-1-gitster@pobox.com>
 <20251105213052.1499224-1-gitster@pobox.com>
 <20251105213052.1499224-8-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105213052.1499224-8-gitster@pobox.com>

On Wed, Nov 05, 2025 at 01:30:47PM -0800, Junio C Hamano wrote:
> The diff_symbol based output framework uses one DIFF_SYMBOL_* enum
> value per the kind of output lines of "git diff", which corresponds
> to one output line from the xdiff machinery used internally.  Most
> notably, DIFF_SYMBOL_PLUS and DIFF_SYMBOL_MINUS that correspond to
> "+" and "-" lines are designed to always take a complete line, even

"complete line" as in newline-terminated? I only recognized that this is
what you meant in the next paragraph, so it might be useful to clarify
here already what you mean.

> diff --git a/diff.c b/diff.c
> index 347cd9c6e9..99298720f4 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1786,22 +1777,36 @@ static void emit_rewrite_lines(struct emit_callback *ecbdata,
>  	const char *endp = NULL;
>  
>  	while (0 < size) {
> -		int len;
> +		int len, plen;
> +		char *pdata = NULL;
>  
>  		endp = memchr(data, '\n', size);
>  		len = endp ? (endp - data + 1) : size;
> +		plen = len;
> +
> +		if (!endp) {
> +			plen = len + 1;
> +			pdata = xmalloc(plen + 2);
> +			memcpy(pdata, data, len);
> +			pdata[len] = '\n';
> +			pdata[len + 1] = '\0';
> +		}
>  		if (prefix != '+') {
>  			ecbdata->lno_in_preimage++;
> -			emit_del_line(ecbdata, data, len);
> +			emit_del_line(ecbdata, pdata ? pdata : data, plen);
>  		} else {
>  			ecbdata->lno_in_postimage++;
> -			emit_add_line(ecbdata, data, len);
> +			emit_add_line(ecbdata, pdata ? pdata : data, plen);
>  		}
> +		free(pdata);
>  		size -= len;
>  		data += len;
>  	}
> -	if (!endp)
> -		emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0, 0);
> +	if (!endp) {
> +		static const char nneof[] = "\\ No newline at end of file\n";
> +		ecbdata->last_line_kind = prefix;
> +		emit_incomplete_line(ecbdata, nneof, sizeof(nneof) - 1);
> +	}
>  }

Okay. I was wondering at first how this would get executed for both
pre- and postimage if it's not part of the loop anymore. But this is
mostly showing my complete ignorance for the "diff" subsystem, as we end
up calling `emit_rewrite_lines()` itself once for each image.

Patrick
