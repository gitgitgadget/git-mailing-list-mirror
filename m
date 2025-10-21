Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E1B27FD4A
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032470; cv=none; b=QYkRF1WFbZ5eA0w5zOtVFgW8NaeEK/gJWL6Buufq5naPs/jeYJKp5el0aYbRkjsy1JYROCm5SkgUgUd39eVSasJrxMbwVa2DMyn6t79/qqif7DDzmabaQH7ptCfSf+5eQrZvwqdDFmoee2FD0noWFC9N8mEgVR7vMsFb5wJqpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032470; c=relaxed/simple;
	bh=vtTXoy3SauYrneseZ7LZCbYCsR36Z2gJv8zDyUZjzMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz+kQ0/Y2P6MxmkA9XmZ+79gy++U7AveZ8KLb9TasHg8Yaqst8ksOTfJonmlXJgf+2z6D3wFBL84bEPY6xGBEPjIIYxFv2cdKadJ4vkObU8IzgNqvg2rXBMROqtbVAQYlkcHKuTP+6hncjkfcWkmhqwK5k7n594s3EcRfV18FKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VLoSnLUr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aAT+fzHx; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VLoSnLUr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aAT+fzHx"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B68FC1400129;
	Tue, 21 Oct 2025 03:41:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 21 Oct 2025 03:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761032466; x=1761118866; bh=EN9rRvA9p2
	70tp6pPiD2jwc07bsU3L9kZM9oU3AJrag=; b=VLoSnLUrscZ8uLQExWLj3VDrXP
	F7Yr07Ywi0IL7fPpQ3j+MINBTpmAlKdXGT7TQ/91s8TKTmnZwHLejKoO+GVj/OEk
	nvzezjsr+Q5JRxbTI7pHvLHHAyoyg67EjgFpHFK8hmxDXykfBUUF+PFdWoKzOucL
	7H2W/VHh5scmyWYXSjslrj8CEPOpEleOcmZS9Ivhlprmziwm4KKRFXycpv8NVqBb
	6DwS77bnco1vVsJuM7eKOAyMYfc0IxQ2ZnssoJMUwmpgQoYIMsS2VA7U2WyKJWSY
	imIWgCHNFty7QhmM975ESLlFqfqDuCA1dRXIstKyug2Z6zXFBX6z9XiVw0Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761032466; x=1761118866; bh=EN9rRvA9p270tp6pPiD2jwc07bsU3L9kZM9
	oU3AJrag=; b=aAT+fzHxGlfyu5c+MaCu9cBVvnhvgBjewwBjjxM+1bFLmWwUobF
	O5EhZjxg5Eulev1QFEQQRzJGoGnfrLbaTC/LYaYn7NUxKJWJOnj7epfbI/Zxui5T
	Qgx64IerCHenJCJk3AhWnflPScZJdlZP2cXl/eQZfL7LGtfG40sdTzTKCvSXPK4k
	9W5q+2yJyXQ49j6+vR9ZcBbsRcdqjagOYwCH9V7QA76N0vr4R6Npt+1KmaQi4bp6
	I9dZ3Q+UckmcAFm10qACa3dg5okrmcF0FjDyYiOTtEm2eAtcCLkj7QnJ6fCVl5Mw
	jHgXKuxYzL/yEPltSuUJ5HEepnja5C9dwmw==
X-ME-Sender: <xms:Ejn3aEWghmIwkp5i34BRg85g4LzrIKfPBnPI-Gd0ZozDJ6nkVFQYqw>
    <xme:Ejn3aLIboK91-DgyTggqizbmsnyjfA4ca4aaLeQRX41RbbTBtnugJPNu3dn6ujxop
    orzmeu48sIFq4xup7A989iLAxkS5K-_xUjTUv-MJNFFncQ9ZHHUGQ>
X-ME-Received: <xmr:Ejn3aMCLQwsFYWZkmSGxoAN3ZatRudPDwawjXCFYeDPTiNnsDCNUrBOmbYznZqBTARG5k95vd_-4mOrsExtBpa8AzK_CdNtzJzN9VjfapgiKPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghvrghrrg
    gssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegr
    ughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehrug
    grmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:Ejn3aDe23d2wQP8-gLhXXYkPo8cV1cUR7iqmxhZVdEf3OJG08Yf_lQ>
    <xmx:Ejn3aD0vUNcfX0hjKIiVKTEAbWSbYsKbHiC6-OAG5QlpwuzFhOCSgg>
    <xmx:Ejn3aCihcjvRT6PJ2U-WvtQt-g_kAYHBtnvoxk4ReXPopnkXmVudpg>
    <xmx:Ejn3aEmKf1aTCGXG4p7jBcSIcf9yC9R5k0MMEvW_qZSORZLUcrOSuQ>
    <xmx:Ejn3aKrEDZA6utc8eyLfbyPEYQLhqfAxypA0CvL3O8dW5XSSjQQgyEqI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 03:41:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6e899924 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 07:41:04 +0000 (UTC)
Date: Tue, 21 Oct 2025 09:41:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 02/10] hook: provide stdin via callback
Message-ID: <aPc5Dm_ZSpN0Lakk@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-3-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017141544.1538542-3-adrian.ratiu@collabora.com>

On Fri, Oct 17, 2025 at 05:15:36PM +0300, Adrian Ratiu wrote:
> diff --git a/hook.c b/hook.c
> index b3de1048bf..7537cf0f9e 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -65,11 +65,22 @@ static int pick_next_hook(struct child_process *cp,
>  
>  	cp->no_stdin = 1;
>  	strvec_pushv(&cp->env, hook_cb->options->env.v);
> +
> +	if (hook_cb->options->path_to_stdin && hook_cb->options->feed_pipe)
> +		BUG("options path_to_stdin and feed_pipe are mutually exclusive");
> +
>  	/* reopen the file for stdin; run_command closes it. */
>  	if (hook_cb->options->path_to_stdin) {
>  		cp->no_stdin = 0;
>  		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
>  	}
> +
> +	if (hook_cb->options->feed_pipe) {
> +		cp->no_stdin = 0;
> +		/* start_command() will allocate a pipe / stdin fd for us */
> +		cp->in = -1;
> +	}
> +
>  	cp->stdout_to_stderr = 1;
>  	cp->trace2_hook_name = hook_cb->hook_name;
>  	cp->dir = hook_cb->options->dir;
> @@ -148,6 +160,9 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
>  	if (!options)
>  		BUG("a struct run_hooks_opt must be provided to run_hooks");
>  
> +	if (options->path_to_stdin && options->feed_pipe)
> +		BUG("choose only one method to populate hook stdin");

Nit: we may want to reuse the same error message here as we use above.

	BUG("options path_to_stdin and feed_pipe are mutually exclusive");

Patrick
