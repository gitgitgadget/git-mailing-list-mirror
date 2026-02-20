Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4F33987
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594853; cv=pass; b=R0KYl7qRzwSDt9J6y4ajjBp87ojmnW+HI/Ix8GQDTvGD2Zpy4eBV9bFu3QHLVBYZCvuFEpkgpniG1Mm8rdoNZCqkHn9t9/6T4FhB6RcqrT6BoyfvCOA7tpaBQDP34a/bqFLJ9rCE//DqTPj9PAGwFsTgNY8fvhJHSRy12/HJGGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594853; c=relaxed/simple;
	bh=Iu5kjr5aU0Yp8ogednuBVf8hbEqKusoi/HH6h398yaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lTk4Fax9ZGivAa4ftUvaArr3mI3EUdKZaLTluiu3GJImivINzQN0oCc3zSiTpwShCTwjlwbAgRe37kFKOGCSeSFsZT9f59IEEB97cbEmLOd1B2yJL/LoqhEPHA/XWiHV33l4SoGiDiZ7bN4DjmBodhMVkDlHS7ypb1g3sfq97Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=NouG+kJS; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="NouG+kJS"
ARC-Seal: i=1; a=rsa-sha256; t=1771594837; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=draLrHNZuKgs2yMqkYsjiHhuXCIk/wPNNm+7HBLW20n6nza6Xt4lr/t9UghIwiN4kF4yQoGzPDFTS23msIRr5AFFB6oYxbA+7ls5qM7a87u6i+V+jpAlbPLMmrLt2H+O0hsmlEXTq+AWpNvF0A6jwOBekvLS38sxhE+JASJtqXw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771594837; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gAL6tX6YoxW7X9lVuy07hrXwoEExY0cQEQSyWnTrPkY=; 
	b=GxGJbD6JJXUI7DcRQhIHfwP7LnBBAdhHKBaLCzC/GgH0ypesVr50CYe0yfzQKzHWDIHt8JLLrnJMH4fhx/aUYMwpJnvBonyYcqIzFFCtvOPJfbPtoIVSWG64RTZlenRWnpbnj5JCecZn/52p/yL6POcWIwRQqe1bI0Ylqb+HcbM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771594837;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=gAL6tX6YoxW7X9lVuy07hrXwoEExY0cQEQSyWnTrPkY=;
	b=NouG+kJSSV3W552PLtHjyQlxbbPoA6SAaWXAK33JPNCfnVRlDG8j8SJff5H5kmOe
	shpSxCBYIXEM6OGT9WKv07LThQzDOxvHuxdPDOAKAiNAtpKLkna2nilq79P5Rhu9xBJ
	dtiRlxdrkKPKsoizsTu5TTz0qpql4TEzn4wqRoyA=
Received: by mx.zohomail.com with SMTPS id 1771594834530535.1791127662793;
	Fri, 20 Feb 2026 05:40:34 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Junio C Hamano <gitster@pobox.com>, Josh
 Steadmon <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 1/8] hook: add internal state alloc/free callbacks
In-Reply-To: <aZhXh6aqlY0VMgEG@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-2-adrian.ratiu@collabora.com>
 <aZhXh6aqlY0VMgEG@pks.im>
Date: Fri, 20 Feb 2026 15:40:30 +0200
Message-ID: <87342vy1m9.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 20 Feb 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Feb 19, 2026 at 12:23:45AM +0200, Adrian Ratiu wrote:
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index 2d2b33d73d..f23772bc56 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -901,6 +901,26 @@ static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_
>>  	return state->cmd ? 0 : 1;  /* 0 = more to come, 1 = EOF */
>>  }
>>  
>> +static void *receive_hook_feed_state_alloc(void *feed_pipe_ctx)
>> +{
>> +	struct receive_hook_feed_state *init_state = feed_pipe_ctx;
>> +	struct receive_hook_feed_state *data = xcalloc(1, sizeof(*data));
>
> Tiny nit, not worth addressing: we often use `CALLOC_ARRAY(data, 1)`
> nowadays.

I'll fix this since I'm planning to do a v3 anyway. Thanks for the
pointer.

>
>> +	data->report = init_state->report;
>> +	data->cmd = init_state->cmd;
>> +	data->skip_broken = init_state->skip_broken;
>> +	strbuf_init(&data->buf, 0);
>> +	return data;
>> +}
>
> Okay, this basically creates the new instance by creating a deep copy of
> the "template" structure.
>
> One could split this up so that we have a "configuration" struct and a
> "data" struct, where we then provide a pointer to the configuration into
> the data structure, as only the buffer needs to change between the
> individual hook invocations. That would avoid some copying around, but
> it feels a bit unnecessary.

Yes, I also thought about this and reached the same conclusion.

>
>> +static void receive_hook_feed_state_free(void *data)
>> +{
>> +	struct receive_hook_feed_state *d = data;
>> +	if (!d)
>> +		return;
>> +	strbuf_release(&d->buf);
>> +	free(d);
>> +}
>
> I would expect that the hook interfaces know to not call `free()` in
> case `alloc()` wasn't called, but I guess it doesn't hurt to be
> defensive here anyway.

Agreed.

>> @@ -908,7 +928,7 @@ static int run_receive_hook(struct command *commands,
>>  {
>>  	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>>  	struct command *iter = commands;
>> -	struct receive_hook_feed_state feed_state;
>> +	struct receive_hook_feed_state feed_init_state = { 0 };
>>  	struct async sideband_async;
>>  	int sideband_async_started = 0;
>>  	int saved_stderr = -1;
>> @@ -938,16 +958,15 @@ static int run_receive_hook(struct command *commands,
>>  	prepare_sideband_async(&sideband_async, &saved_stderr, &sideband_async_started);
>>  
>>  	/* set up stdin callback */
>> -	feed_state.cmd = commands;
>> -	feed_state.skip_broken = skip_broken;
>> -	feed_state.report = NULL;
>> -	strbuf_init(&feed_state.buf, 0);
>> -	opt.feed_pipe_cb_data = &feed_state;
>> +	feed_init_state.cmd = commands;
>> +	feed_init_state.skip_broken = skip_broken;
>
> As far as I can see all of the data that we pass to the state struct is
> static, so we might just as well initialize it right away, right?
>
>     struct receive_hook_feed_state feed_init_state = {
>         .cmd = commands,
>         .skip_broken = skip_broken,
>         .buf = STRBUF_INIT,
>     };

I missed this. Thanks. Will do in v3.

>> diff --git a/hook.c b/hook.c
>> index cde7198412..83ff658866 100644
>> --- a/hook.c
>> +++ b/hook.c
>> @@ -133,6 +133,8 @@ static int notify_hook_finished(int result,
>>  
>>  static void run_hooks_opt_clear(struct run_hooks_opt *options)
>>  {
>> +	if (options->feed_pipe_cb_data_free)
>> +		options->feed_pipe_cb_data_free(options->feed_pipe_cb_data);
>>  	strvec_clear(&options->env);
>>  	strvec_clear(&options->args);
>>  }
>
> I guess this here would be where we could skip `free` in case the data
> wasn't even allocated. But as I said further up, I don't care all that
> much.

That is correct. I think I'll just drop that pointer check anyway in v3.

>> diff --git a/hook.h b/hook.h
>> index 20eb56fd63..a6bdc6f90f 100644
>> --- a/hook.h
>> +++ b/hook.h
>> @@ -5,6 +5,9 @@
>>  
>>  struct repository;
>>  
>> +typedef void (*cb_data_free_fn)(void *data);
>> +typedef void *(*cb_data_alloc_fn)(void *init_ctx);
>> +
>>  struct run_hooks_opt
>>  {
>>  	/* Environment vars to be set for each hook */
>
> Do we maybe want to scope these function typedefs to the hooks subsystem
> by calling the `hook_data_free_fn` and `hook_data_alloc_fn`, or
> something like that?

Good idea. I'll rename them in v3.
