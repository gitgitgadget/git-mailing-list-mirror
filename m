Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C59544BCB7
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 23:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036525; cv=none; b=DL+MGfv6XvcplfBa6fV5RAqMdbPFCZk1WAVzAgk3mcnjJv5LOjhviDZLrHmmfLgjR3n7JiYDJEeiH1mIPCe26Wge+v5l1qza6MY42LkQrcZSJBOgL62cWxhiwAK19obo0OXe/dANFgI+l6yvh/Buuqujo6LYqipYorigPzy1qKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036525; c=relaxed/simple;
	bh=EC/K2gCexMgeJcO3/tHP4XHuJHbwySvC5YgAERryOOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lzICL3dbD0nTe//K2gob5Cf2pykDyxpXlEAYpZF74Wb8z6M08ZFyyUekZsqCw7nUsMZDN/zkiUQ8SAkF9FINVFgfJaI2+u3SfemOwuNISAaLAxtLyZMUqguCrwKHgNvAp182HAMuVDxZ2c70MSeSp3tQSUya4Cn6AUO1IcFHmR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C79PkB5o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vUzcUHc/; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C79PkB5o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vUzcUHc/"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA0387A00F7;
	Wed, 21 Jan 2026 18:01:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 21 Jan 2026 18:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769036515; x=1769122915; bh=PrwRhR0Cnx
	efactpt+KbvF4ZfUWfvOvlrb/njWiN/5o=; b=C79PkB5oC/v6WwWr8FmVhqksJt
	fZj00597cJBIR/6cWsHSAsPfX8jC6B9ABLF7b9gItnAXDGVaEFXOJwz4kqGuy04U
	Wj1blne2y+8XHeHDaGN56+uAsrfI+Kwth+60kET8KBO9liX57uUeRQydPNqs4sKu
	Ac4PJF6KgamBsj5bQFU41DkDD+GvSMv4gpYFB3A8UERcBHIgWFYcklcZP2UgX9lh
	2kAIHXDUPyT1HecRt6UzmtoonS4+FSSuHfQN/97aKg9rCu5KVbA4N5Q0MV9jiQBI
	qv+JB6Q7d+Cw9cCsiimrM/EiauQzeyvKSUnZi8WdhY6HrmHzyeSSEw38T42w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769036515; x=1769122915; bh=PrwRhR0Cnxefactpt+KbvF4ZfUWfvOvlrb/
	njWiN/5o=; b=vUzcUHc/hsCSwBHybHuD+oHIgWD+XdKJ+Bh8t7oJFGgwb0zNtBx
	nQ6mQdDf8RFzd3GEk76qWMENZKLmN5NtnwW5fAox6OOjviVfgyxvxrvGcTv5LImN
	zjhZwfwH6fVdnpvf8y3UtuPH0+v6EtDyiwfSV2tpyDXB8psgMAYZlgoauc1QvX2e
	VBrx4f5botNBNXQg76THbiH/8twds1mJqeis2KG71Wehg3Hezz9ZqPUzO+TJaT6K
	z1mry+eJh7wAZYVpC2h3YM0CqVjuAys5Tuk3hpCG32GJfHu1UjZo0mN8E9Wl6sgT
	5N4fO7OujzLs8NuDzf1aztEEokSUQTIa9Ew==
X-ME-Sender: <xms:41pxaevtFB9_fPBsRqGC4yAQhQ-gIIrMR8T-HAWavxN2Lg5L4jcsQg>
    <xme:41pxaShqt7b2UrI48cB7o7c95_xTibOtwtQfRWoiLN4V36_R-7745cYs38BDzWsNw
    Tk-1Oag71jvv3qV2FfLVJoIadMNTp02AtUAUnsOs2-x4-wpKqsjLg>
X-ME-Received: <xmr:41pxaf_g5LWevFzr6MKln-zX1AccvQ8Y_XAOkLcmne0eZ3dLyBrkWq8YhbtgbPqgW4BZJYOBb_1-ofiVr8nga1DaKXXGUAzjVwm6T3M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:41pxaVsElhY6X79v-bYkcfRLBjuzqPKxaxYjN_DjmeZBH5uvOHC9IQ>
    <xmx:41pxaTor7HshbDzTNeZFhYNpDgahxhFCxxI7TaUqwXLAtPyZzHkC4w>
    <xmx:41pxaZqBlPizFxNQbmhUP6ypUXDTf_UuGRm41ZWIDX1mlifzUndcRQ>
    <xmx:41pxaSbbZswVzRWhcFyt_r0YDvQjvrLX6KQduPqYPJhLcSlGjeDrXA>
    <xmx:41pxaUQJGe5HmRXZAJxCO7mO9ot2d23DXDDuSocDUci2JFvl4GSYm7cF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 18:01:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v7 02/12] run-command: add first helper for pp child states
In-Reply-To: <20260121215436.1473800-3-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Wed, 21 Jan 2026 23:54:26 +0200")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20260121215436.1473800-1-adrian.ratiu@collabora.com>
	<20260121215436.1473800-3-adrian.ratiu@collabora.com>
Date: Wed, 21 Jan 2026 15:01:52 -0800
Message-ID: <xmqq7btar2n3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> There is a recurring pattern of testing parallel process child states
> and file descriptors to determine if a child is running, receiving any
> input or if it's ready for cleanup.
>
> Name the pp_child structure and introduce a first helper to make these
> checks more readable. Next commits will add more helpers and checks.

I needed to read this three times to understand what you meant by "a
first helper".  In the bigger picture, the helper being the first
one you invented does not really matter.  Perhaps drop "first"?

> +struct parallel_child {
> +	enum child_state state;
> +	struct child_process process;
> +	struct strbuf err;
> +	void *data;
> +};
> +
> +static int child_is_working(const struct parallel_child *pp_child)
> +{
> +	return pp_child->state == GIT_CP_WORKING;
> +}
> +
>  struct parallel_processes {
>  	size_t nr_processes;
>  
> -	struct {
> -		enum child_state state;
> -		struct child_process process;
> -		struct strbuf err;
> -		void *data;
> -	} *children;
> +	struct parallel_child *children;
>  	/*
>  	 * The struct pollfd is logically part of *children,
>  	 * but the system call expects it as its own array.
> @@ -1509,7 +1516,7 @@ static void kill_children(const struct parallel_processes *pp,
>  			  int signo)
>  {
>  	for (size_t i = 0; i < opts->processes; i++)
> -		if (pp->children[i].state == GIT_CP_WORKING)
> +		if (child_is_working(&pp->children[i]))
>  			kill(pp->children[i].process.pid, signo);
>  }
>  
> @@ -1665,7 +1672,7 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
>  
>  	/* Buffer output from all pipes. */
>  	for (size_t i = 0; i < opts->processes; i++) {
> -		if (pp->children[i].state == GIT_CP_WORKING &&
> +		if (child_is_working(&pp->children[i]) &&
>  		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
>  			int n = strbuf_read_once(&pp->children[i].err,
>  						 pp->children[i].process.err, 0);
> @@ -1683,7 +1690,7 @@ static void pp_output(const struct parallel_processes *pp)
>  {
>  	size_t i = pp->output_owner;
>  
> -	if (pp->children[i].state == GIT_CP_WORKING &&
> +	if (child_is_working(&pp->children[i]) &&
>  	    pp->children[i].err.len) {
>  		strbuf_write(&pp->children[i].err, stderr);
>  		strbuf_reset(&pp->children[i].err);
> @@ -1748,7 +1755,7 @@ static int pp_collect_finished(struct parallel_processes *pp,
>  			 * running process time.
>  			 */
>  			for (i = 0; i < n; i++)
> -				if (pp->children[(pp->output_owner + i) % n].state == GIT_CP_WORKING)
> +				if (child_is_working(&pp->children[(pp->output_owner + i) % n]))
>  					break;
>  			pp->output_owner = (pp->output_owner + i) % n;
>  		}
