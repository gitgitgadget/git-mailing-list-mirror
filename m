Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0891BCA1C
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 07:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152777; cv=none; b=MnJ9KLdAKQ5NzRsemDdQY2nBcpsOta0ao/rPhortRMm6hMW0l883gmm5ttujlv83Wfvsa9lMZNDLUmso0eAD21kVBK4nhUR1QWLMk0J4KpQSEeB2kTEGIu6xXjc7Ga/yL9jwxKiD3ePBfz8ENs4X5Jq8ECYHNExK5lrNOkA26Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152777; c=relaxed/simple;
	bh=IlO1Au05OtIeCzxTsG4Ed3bFys6fr3kHfsPpHmJQwdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DB6UIPHVVeH/99mZzOhbYc1cOnXO6wC+Y/pvRrvuv7h100PdZ+bagb4GPB58ol60+d+VdREc0KR5Le+QC+ha4PGboD/+GgHrzg9eQJcBfIo+0vQmZRzn5wkQBP84bEkEjtfnYB1mZwTSbtTdTp83UlhtyX6DjIeDTEM80vLFeGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VcApGWoj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T3YlGYKP; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VcApGWoj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T3YlGYKP"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4F00F7A00D2;
	Fri, 23 Jan 2026 02:19:34 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 23 Jan 2026 02:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769152774; x=1769239174; bh=D7GtWhQKcY
	PeZ/q7fV9tlCPnbNU9A27vJIu7WPp3AO8=; b=VcApGWojHFn4YS1xgyzSnOizXr
	LUJzybPbDicE1J0P21d8tJjbMa2ZQ0URilIGA/4Q3OCe2X3uI1RtHEXyA4T6iJ9e
	Czi2u+XFtkJP707L+r2/H3tMGVeV5/0p9sBJsnvRawF7+W/QCYAQvZZEFP/kJB+C
	As/yci4BbEuLdoXAtj/+Tl66X/ZFhh1Sw8ih5ez6pieePBKkiQdfHCGZApghAb31
	/37rUnVYTfcJ/JMdgvSaiO+X9GU2nw9Dfv/XC2db3kxnZRK952oe77PwFzWKq2OZ
	NCdA1qbpWvA49tFIWVfjBcKCB7zzxFb/pV3vRBGzNLkeK5tPD40EZRqMkW8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769152774; x=1769239174; bh=D7GtWhQKcYPeZ/q7fV9tlCPnbNU9A27vJIu
	7WPp3AO8=; b=T3YlGYKPVjkNa8OVBIAgT1DsXvt3IVqjUkD3RR8XN81rtlAu88o
	QZIJtLQwZRSYEog4Q4VXAoCsTTsAzYwMFSIqzZFuVn8W9sIyW9gBQ4/HhwQXf9Md
	iQ/kF5tOPhMR0gstPzV4PuNUZ8RjEuYHvJpFcwqSngPE+0p//NFNgGRsLQ2tujRn
	NXHEwNxWxrHGuRX2TRGz42yIuP9luRYiSNvVabMZ1I9VDyyj+HESNTyjmhwXt9Qh
	NrC6UKERW8yd1O3wQ/MJ6rA96YJ1/Sw1q+Vtr+VyJojWwxaeOlE22kZ5Wf3RKFFy
	iNWnCF/U/sWvAjAFTe03zZ7pRIgRfGiHNog==
X-ME-Sender: <xms:BSFzaR4XpXFrOJxr_18cDb7oz4Q0gCX9HeBoaF6NB1RPX1AK2lnebQ>
    <xme:BSFzaResazxYMTJVcuRTS3QZTKOusgDvSBZiDlFcggRu4GxtuosBvXv-9jcY5d9gU
    FHHUq7O0t2cXQmHG9_9CfrWm8sJMORFrj7dVRS71yDWdYXmjyNQlA>
X-ME-Received: <xmr:BSFzacHExpRIVpKd4uWbAXzxtS82n3qPb7phjmMiB-hGHn0bOzfuNI4VPQMC0XftbQK-YevCOsjuvp5HvMSyvi374XxQyxclIpk4Irv5NknW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeekgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrughrihgrnh
    drrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghhrhhishgusegrphgrtghhvgdrohhr
    ghdprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:BSFzaaTh37q5UBzybvyXBRDcNtL51QIIICw0ffYPgg-NBdguKF4R1A>
    <xmx:BSFzaaaavHJ4p5AwFR7mqpCmW3wJSTe-IB9lEyukkowAi-AH7yquqQ>
    <xmx:BSFzad2y6OMJVd_eiiObIL8QGT76W4AAAba5-oK4h4QTEfHyPru5qg>
    <xmx:BSFzaVqyiW3VK82a9cWcFlVjsEMuw1Y4N01yLZzr00VREr5KHT7oHQ>
    <xmx:BiFzaeeEWYBY44ilrxK4ptaWc9gJQPJ6FlC2JjnD2S_nfxqdYHC-hovb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 02:19:32 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 76a3a560 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Jan 2026 07:19:30 +0000 (UTC)
Date: Fri, 23 Jan 2026 08:19:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Chris Darroch <chrisd@apache.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v7 06/12] hook: allow separate std[out|err] streams
Message-ID: <aXMg-SKKhYzIXvv8@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-7-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121215436.1473800-7-adrian.ratiu@collabora.com>

On Wed, Jan 21, 2026 at 11:54:30PM +0200, Adrian Ratiu wrote:
> The hook API assumed that all hooks merge stdout to stderr.

Tiny nit, not worth rerolling over: we typically write the observation
in past tense. So s/assumed/assumes/

> diff --git a/hook.c b/hook.c
> index 5ddd7678d1..fde1f88ce8 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -81,7 +81,7 @@ static int pick_next_hook(struct child_process *cp,
>  		cp->in = -1;
>  	}
>  
> -	cp->stdout_to_stderr = 1;
> +	cp->stdout_to_stderr = hook_cb->options->stdout_to_stderr;
>  	cp->trace2_hook_name = hook_cb->hook_name;
>  	cp->dir = hook_cb->options->dir;

The implementation looks easy enough. We convert the static value we had
before into a configurable one, and...

> diff --git a/hook.h b/hook.h
> index 2169d4a6bd..7cbeef0a1e 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -34,6 +34,11 @@ struct run_hooks_opt
>  	 */
>  	int *invoked_hook;
>  
> +	/**
> +	 * Send the hook's stdout to stderr.
> +	 */
> +	unsigned int stdout_to_stderr:1;
> +
>  	/**
>  	 * Path to file which should be piped to stdin for each hook.
>  	 */

Another tiny nit that is not worth a reroll: might be worth mentioning
that this is the default behaviour.

> @@ -80,6 +85,7 @@ struct run_hooks_opt
>  #define RUN_HOOKS_OPT_INIT { \
>  	.env = STRVEC_INIT, \
>  	.args = STRVEC_INIT, \
> +	.stdout_to_stderr = 1, \
>  }

... make the old behaviour the default.

Patrick
