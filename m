Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7761C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 17:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbiLBRmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 12:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiLBRmm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 12:42:42 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E81F2C
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 09:42:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so5782164pjo.3
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 09:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uw02MpZNlTCmQr8N7UQDBHtEe3qSiRAUn3A5knqtYtc=;
        b=P5zkJqHjRHy0KGwBZFMSQUjR8mL/y34fBreu5S1O9wtBJJDWzFLxKSllHenZFJkjoi
         u/L3TM9ifV/hf9urEkyoZDjC1U/ty6rF3zQX8+JUqgKvF1KPgH/YBHBGsTpNFEbFardH
         ae1n/9d9RELvtB6T0OZRUAELrE/WSuHFhuAVED9Dw498Pzuq6RjuO7ckk0wFnn8my0bL
         rb0HCoMOSJFvFxmzs2SgJgpiyPJhfVjutwzPAf+A4CE1yk/UqEuRx343yFxQR73lzHS+
         VnG1lEwurN4RZnMOiYnUWtqoQx2SSxQvds42YHe74Lagux+KQu0tHgUrWqubSVI/c9xi
         t08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uw02MpZNlTCmQr8N7UQDBHtEe3qSiRAUn3A5knqtYtc=;
        b=yp7JCAg+lbeuTpuiQ+CtSGyqK7TavqlQg6kUlif6lN9IqpU67xeg2/xm4jz0qGI7vg
         fcaj/IEOBc5cqQssn8/FmxBKPXl7yBcUPCOKcSPl+mwlVgkBQa4Yh3p97vpJPzu91hpL
         YlzG9piAJ327LZLJhJKeKUPcUhm9FNFhGlnoiDpWNp6fi5pnWDe1/MIyNUhbJPUY1IhZ
         +LJVVkxP5NTtyBQp4popfxD6/wNdMvN2SYmgfvYyYE3Jv5yZSKB3CpPANobAv4uI7AMb
         v5D3khf7dWEAhK9xNb0u1r2tNXOHUau0DWvjA/ImRmjQjiVAYZWcf61ErM6LzVCP5JRn
         12bQ==
X-Gm-Message-State: ANoB5pkTW6wlfEQc7BK9AbXt6bDdJE9tb44eyAu2VchHerNxTF7kDG2i
        ZUBPTbkjAG2vsuTNSmO+NTQi
X-Google-Smtp-Source: AA0mqf6Brq5ZQEcBNrNm1e/ESJB32rkNjkzKNcIZ4624TxYzB1fxkYxSmjA49wSKPc7cs1GLzlbYsQ==
X-Received: by 2002:a17:902:868b:b0:186:8c19:d472 with SMTP id g11-20020a170902868b00b001868c19d472mr54317551plo.12.1670002957490;
        Fri, 02 Dec 2022 09:42:37 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id 33-20020a630b21000000b0046ffe3fea77sm4397398pgl.76.2022.12.02.09.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 09:42:37 -0800 (PST)
Message-ID: <43769297-8e31-9420-5d2e-dd1d400b5358@github.com>
Date:   Fri, 2 Dec 2022 09:42:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH] fsmonitor: eliminate call to deprecated FSEventStream
 function
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Stefan Sundin <git@stefansundin.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhostetler@github.com>
> 
> Replace the call to `FSEventStreamScheduleWithRunLoop()` function with
> the suggested `FSEventStreamSetDispatchQueue()` function.
> 
> The MacOS version of the builtin FSMonitor feature uses the
> `FSEventStreamScheduleWithRunLoop()` function to drive the event loop
> and process FSEvents from the system.  This routine has now been
> deprecated by Apple.  The MacOS 13 (Ventana) compiler tool chain now
> generates a warning when compiling calls to this function.  In
> DEVELOPER=1 mode, this now causes a compile error.

I just updated to MacOS 13 and have been building without 'DEVELOPER=1' to
work around this error, so thank you so much for fixing it! 

> 
> The `FSEventStreamSetDispatchQueue()` function is conceptually similar
> and is the suggested replacement.  However, there are some subtle
> thread-related differences.
> 
> Previously, the event stream would be processed by the
> `fsm_listen__loop()` thread while it was in the `CFRunLoopRun()`
> method.  (Conceptually, this was a blocking call on the lifetime of
> the event stream where our thread drove the event loop and individual
> events were handled by the `fsevent_callback()`.)
> 
> With the change, a "dispatch queue" is created and FSEvents will be
> processed by a hidden queue-related thread (that calls the
> `fsevent_callback()` on our behalf).  Our `fsm_listen__loop()` thread
> maintains the original blocking model by waiting on a mutex/condition
> variable pair while the hidden thread does all of the work.

It's unfortunate that Apple doesn't seem to have any documentation on how
they'd recommend migrating in either [1] or [2], but your approach sounds
straightforward. Rearranging the patch a bit...

[1] https://developer.apple.com/documentation/coreservices/1447824-fseventstreamschedulewithrunloop
[2] https://developer.apple.com/documentation/coreservices/1444164-fseventstreamsetdispatchqueue

> @@ -490,9 +499,11 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
>  
>  	data = state->listen_data;
>  
> -	data->rl = CFRunLoopGetCurrent();
> +	pthread_mutex_init(&data->dq_lock, NULL);
> +	pthread_cond_init(&data->dq_finished, NULL);
> +	data->dq = dispatch_queue_create("FSMonitor", NULL);
>  
> -	FSEventStreamScheduleWithRunLoop(data->stream, data->rl, kCFRunLoopDefaultMode);
> +	FSEventStreamSetDispatchQueue(data->stream, data->dq);
>  	data->stream_scheduled = 1;
>  
>  	if (!FSEventStreamStart(data->stream)) {

First, you create the dispatch queue and schedule the stream on it. The docs
mention "If there’s a problem scheduling the stream on the queue, an error
will be returned when you try to start the stream.", and that appears to be
handled by the 'if (!FEventStreamStart(data->stream))' that already exists. 

Looks good.

> @@ -501,7 +512,9 @@ void fsm_listen__loop(struct fsmonitor_daemon_state *state)
>  	}
>  	data->stream_started = 1;
>  
> -	CFRunLoopRun();
> +	pthread_mutex_lock(&data->dq_lock);
> +	pthread_cond_wait(&data->dq_finished, &data->dq_lock);
> +	pthread_mutex_unlock(&data->dq_lock);
>  
>  	switch (data->shutdown_style) {
>  	case FORCE_ERROR_STOP:
> 

Then, you block on the 'dq_finished' condition variable until it indicates a
shutdown (forced or otherwise). The two causes for that are...

> @@ -379,8 +382,11 @@ force_shutdown:
>  	fsmonitor_batch__free_list(batch);
>  	string_list_clear(&cookie_list, 0);
>  
> +	pthread_mutex_lock(&data->dq_lock);
>  	data->shutdown_style = FORCE_SHUTDOWN;
> -	CFRunLoopStop(data->rl);
> +	pthread_cond_broadcast(&data->dq_finished);
> +	pthread_mutex_unlock(&data->dq_lock);
> +
>  	strbuf_release(&tmp);
>  	return;
>  }

...force shutdown due to a major change in the repo detected in
'fsevent_callback()' (e.g. moving the .git dir)...

> @@ -479,9 +486,11 @@ void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
>  	struct fsm_listen_data *data;
>  
>  	data = state->listen_data;
> -	data->shutdown_style = SHUTDOWN_EVENT;
>  
> -	CFRunLoopStop(data->rl);
> +	pthread_mutex_lock(&data->dq_lock);
> +	data->shutdown_style = SHUTDOWN_EVENT;
> +	pthread_cond_broadcast(&data->dq_finished);
> +	pthread_mutex_unlock(&data->dq_lock);
>  }
>  

...or, shutdown due to an 'fsm_listen__stop_async()' call from the cleanup
of 'fsmonitor_run_daemon_1()'.

Between those two, all of the possible "stop listener" scenarios seem to be
covered (as they were when using 'CFRunLoopStop()').

> @@ -471,6 +473,11 @@ void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
>  		FSEventStreamRelease(data->stream);
>  	}
>  
> +	if (data->dq)
> +		dispatch_release(data->dq);
> +	pthread_cond_destroy(&data->dq_finished);
> +	pthread_mutex_destroy(&data->dq_lock);
> +
>  	FREE_AND_NULL(state->listen_data);
>  }

And finally, cleanup the queue, lock, and condition var in the destructor.

This all looks good to me. Practically, I'd like to see this merged sooner
rather than later to stop (myself and others working on MacOS 13) needing to
hack some way around the deprecation error, but I'll defer to others more
familiar with FSMonitor if there's anything I didn't spot.

Thanks again!

