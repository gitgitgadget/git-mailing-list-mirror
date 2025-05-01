Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C1042AB4
	for <git@vger.kernel.org>; Thu,  1 May 2025 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746110193; cv=none; b=QGGg0xjI0ECyOtUyApsqWhNntD+Pf9X6bRa2TB2yBhJtzV35XUzYYSMeaQY5afUn9HBXTKCRrLfvPhixAmnJPjLs2jC1MJ/zpaJ6EUU4QckQFCp3paUOmIgF6xkMmaBbYiMeHFrlEINfn2QLKZfvsOT35yGr10+bNJIkpuZglus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746110193; c=relaxed/simple;
	bh=WvN0TXEWOp1MSdCR0RLf/sQnQiHyJd/eMpt4fux7xnU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GD6zLsuk4DmDXsSAqNZ3FyAQHkY1eg9m0kMcD9Km6WrO/ACwVs1ekr6w9gqA4GtSazwwAYvumGGGAaEXRQP+gOgl/Y7joPBcnUHw7nRnV8DiAycVLvcBMqZJuTHwXgL1639xVRa9siQ2YGceh2PwEEFBAVnvY3s88OGkJCZe4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3rrx64q; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3rrx64q"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394a823036so9191725e9.0
        for <git@vger.kernel.org>; Thu, 01 May 2025 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746110190; x=1746714990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TdKZnMayUSG2fVMX6irZAs3Y3q+vv/OtjhYFqtCy9WE=;
        b=e3rrx64qrUPuSIBHyZLdw3bjYVw5IqvNohA6MXbbkGE1Nakh4MqzzTulAu8na0oKKK
         dmTmgOESmGE6/OciH4BW25IkVhNgeIfEFo0o8Ix0RC6eZZplGNrMb28WL5DesV2Ilo9J
         TigzK+dHRM4FWjqdKVBJd5hipOXUmW6EaoqgILXliSCfzR5KSnPLuH9E9ajAGnX9Z5Te
         1mt8RQKrUd20LlFr6ULHpIxKQJj7O9CszHgvqL+JgPjQNhLjTXLJQ+9iEQj/20SB/9D2
         6Py/iHYmNyVDAdsvrmns3h4B23x0aYTYXKzRWnzhWMgl4m+jkcUqlg2leE4ZkZjRt+8+
         kdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746110190; x=1746714990;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdKZnMayUSG2fVMX6irZAs3Y3q+vv/OtjhYFqtCy9WE=;
        b=v+K67BQJ8XNVetfubLguQnmpeuQmTbxNmJJH0ol2EadqeRpssjaktaC5rNyJjXeaHX
         kO0dc/yUfwML94yDTdPhQyIGwGm5BffsbRt4webXH4DDpV10lrWaWmfFEe5GryVu50iS
         u14gqi+7MLS9pBIuZgXzsZWN/iV02rM3wosaBsfm1i07i7mjkbTxOxW6Fe5JhKhiMFCe
         hFk93QkiynOJ9zCt2UCHmDv49PRimAqZHN/PrSg6Qk5VbZpkOaXS9ctQPJgRdmeKd9iF
         sVikYSemvCCqidstrxBTeFU3ZgS7i8nPk9/x5avAryF4NsSLOVo2yHX11tnpZtuEf1Uz
         OTRA==
X-Forwarded-Encrypted: i=1; AJvYcCWr8Qecg5rUyb9+FnERv+yajBaHNgGCzNLDEgVbWqrzWmJ5vKBnZ6gJg/IBv0nD5WJ8jfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxt4t93T5IlaK8QSYDMEvaQTC3p7KfFwM8LneSaDyN8Twt/k80
	aMjrbA3Zf7RYn1kFX1y+AfqvghcCXbe9pEd2+OdimRnLlWlUp4JE
X-Gm-Gg: ASbGncuvCHWtXLGkZwVsP8pnWydtC0TW12Oi50t1cwifts24ZETao5B4RraxMOrfszK
	SaC77mn6DOnECb9tFLB9Ha4ejYSoxH6I1xbxZUTgexUG7MC73Zj39+LtYMmBnOjN4Uo09hk5VUm
	OVGHwaQ+sl6sdKbXdVZIxJTfz42Hn9ADgkQCxBATyG/NqeBzplA7phJlfMDJ3vaWpVUG6zKuIYv
	N3DJOJoNSeZQ9FBb13aYWZv15GWGdQtTyjfiyjMjOf1Eks8GRfPwxCftn9TZvCQ93nQz61VNki2
	D0pVYDiULYOnSyky19JIR2aTJim32cwQKLNyYymTg81qyZywenqkeOqudpWWX94DDKanNh0UmwK
	Ie2n1sq+Ih3yea3EU
X-Google-Smtp-Source: AGHT+IEydsM0CerWcxPpdvJ9egjy6fbWm5AXtiVR7p9/yl4sEYir3bc4TzwMdpDlXPXYk16mHJ5SzA==
X-Received: by 2002:a05:600c:502b:b0:43c:fb8e:aec0 with SMTP id 5b1f17b1804b1-441b1f2f0fdmr58461805e9.1.1746110189757;
        Thu, 01 May 2025 07:36:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b8a2873csm13922605e9.30.2025.05.01.07.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 07:36:29 -0700 (PDT)
Message-ID: <e4ea1e44-af7e-4c24-b0ee-f87091200b90@gmail.com>
Date: Thu, 1 May 2025 15:36:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] rebase: can write reflog with uninit. `action` string
To: Jeff King <peff@peff.net>, Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <20250428194048.149348-1-code@khaugsbakk.name>
 <ce0f41e4-7d90-4398-a0e9-e8ba69791e57@gmail.com>
 <fbc97d6a-2022-4a64-a2ba-5a7255cd81a6@app.fastmail.com>
 <20250429215155.GA36727@coredump.intra.peff.net>
 <6743a9fc-11ca-45ac-bc40-4148f5d85d27@app.fastmail.com>
 <20250501131751.GA1725607@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20250501131751.GA1725607@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff and Kristoffer

On 01/05/2025 14:17, Jeff King wrote:
> On Wed, Apr 30, 2025 at 05:17:38PM +0200, Kristoffer Haugsbakk wrote:
> 
> Probably the smallest solution is for ctx->reflog_message to copy the
> result and always own the memory (and then remember to free it, both at
> cleanup and if it is ever overwritten).
> 
> But I think the way reflog_message() returns the "buf" member of a
> static strbuf is kind of an anti-pattern, exactly because you can get
> this kind of subtle re-use. It probably should just return a non-const
> pointer, handing over memory ownership to the caller. That would require
> adjusting its other callers, too.

Getting rid of the static buffer would certainly protect us from the 
use-after-free. The bug here is that we're not calling reflog_message() 
and storing the result in ctx->reflog_message() to create the correct 
message in do_merge(). Looking at your patch, having to remember to copy 
the string returned from reflog_message() is a bit of a pain. I wonder 
if we could change ctx->reflog_message to be an strbuf and update 
reflog_message() like so

diff --git a/sequencer.c b/sequencer.c
index ad0ab75c8d4..59d80ddf0cc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3941,11 +3941,10 @@ static const char 
*sequencer_reflog_action(struct replay_opts *opts)
  }

  __attribute__((format (printf, 3, 4)))
-static const char *reflog_message(struct replay_opts *opts,
+static void reflog_message(struct replay_opts *opts,
  	const char *sub_action, const char *fmt, ...)
  {
  	va_list ap;
-	static struct strbuf buf = STRBUF_INIT;
+	struct strbuf *buf = &opts->ctx->reflog_message;

  	va_start(ap, fmt);
  	strbuf_reset(&buf);
@@ -3957,8 +3956,6 @@ static const char *reflog_message(struct 
replay_opts *opts,
  		strbuf_vaddf(&buf, fmt, ap);
  	}
  	va_end(ap);
-
-	return buf.buf;
  }

  static struct commit *lookup_label(struct repository *r, const char 
*label,

All of the other callers should can then use use ctx->reflog_message.buf 
where they were using the return value of reflog_message() before. That 
would protect us from the use-after-free.

I'll try and put a proper patch together next week that removes the 
static buffer and starts calling reflog_message() when we're merging.

Best Wishes

Phillip


> So the "smallest" version is perhaps something like this, totally
> untested except for confirming that t3430 no longer complains:
> 
> diff --git a/sequencer.c b/sequencer.c
> index b5c4043757..07aa3b3731 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -228,7 +228,7 @@ struct replay_ctx {
>   	 * Stores the reflog message that will be used when creating a
>   	 * commit. Points to a static buffer and should not be free()'d.
>   	 */
> -	const char *reflog_message;
> +	char *reflog_message;
>   	/*
>   	 * The number of completed fixup and squash commands in the
>   	 * current chain.
> @@ -411,6 +411,7 @@ static void replay_ctx_release(struct replay_ctx *ctx)
>   {
>   	strbuf_release(&ctx->current_fixups);
>   	strbuf_release(&ctx->message);
> +	free(ctx->reflog_message);
>   }
>   
>   void replay_opts_release(struct replay_opts *opts)
> @@ -3939,7 +3940,7 @@ static const char *reflog_message(struct replay_opts *opts,
>   	static struct strbuf buf = STRBUF_INIT;
>   
>   	va_start(ap, fmt);
> -	strbuf_reset(&buf);
> +	strbuf_release(&buf); /* guarantees realloaction */
>   	strbuf_addstr(&buf, sequencer_reflog_action(opts));
>   	if (sub_action)
>   		strbuf_addf(&buf, " (%s)", sub_action);
> @@ -4886,9 +4887,11 @@ static int pick_one_commit(struct repository *r,
>   	int res;
>   	struct todo_item *item = todo_list->items + todo_list->current;
>   	const char *arg = todo_item_get_arg(todo_list, item);
> -	if (is_rebase_i(opts))
> -		ctx->reflog_message = reflog_message(
> -			opts, command_to_string(item->command), NULL);
> +	if (is_rebase_i(opts)) {
> +		free(ctx->reflog_message);
> +		ctx->reflog_message = xstrdup(reflog_message(
> +			opts, command_to_string(item->command), NULL));
> +	}
>   
>   	res = do_pick_commit(r, item, opts, is_final_fixup(todo_list),
>   			     check_todo);
> @@ -4947,7 +4950,8 @@ static int pick_commits(struct repository *r,
>   	struct replay_ctx *ctx = opts->ctx;
>   	int res = 0, reschedule = 0;
>   
> -	ctx->reflog_message = sequencer_reflog_action(opts);
> +	free(ctx->reflog_message);
> +	ctx->reflog_message = xstrdup(sequencer_reflog_action(opts));
>   	if (opts->allow_ff)
>   		ASSERT(!(opts->signoff || opts->no_commit ||
>   			 opts->record_origin || should_edit(opts) ||
> @@ -5423,7 +5427,8 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
>   			unlink(rebase_path_dropped());
>   		}
>   
> -		ctx->reflog_message = reflog_message(opts, "continue", NULL);
> +		free(ctx->reflog_message);
> +		ctx->reflog_message = xstrdup(reflog_message(opts, "continue", NULL));
>   		if (commit_staged_changes(r, opts, &todo_list)) {
>   			res = -1;
>   			goto release_todo_list;
> @@ -5475,7 +5480,8 @@ static int single_pick(struct repository *r,
>   			TODO_PICK : TODO_REVERT;
>   	item.commit = cmit;
>   
> -	opts->ctx->reflog_message = sequencer_reflog_action(opts);
> +	free(opts->ctx->reflog_message);
> +	opts->ctx->reflog_message = xstrdup(sequencer_reflog_action(opts));
>   	return do_pick_commit(r, &item, opts, 0, &check_todo);
>   }
>   
> 
> I'm hoping your or Phillip can decide on the best fix from here.
> 
> -Peff

