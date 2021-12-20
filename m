Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2A6C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 16:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbhLTQmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 11:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239178AbhLTQl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 11:41:59 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F15FC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 08:41:59 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o20so40654321eds.10
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 08:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ciBK/vtGlGEZoP5Jb2k+FE8PcH/xkoBn4MurxKkryUI=;
        b=J/9hPR0uG2hEZSOZ52OsP4STAbRFTX1e16ok2LfYowtxzjMXAGueq+iiVnzpUnBgW9
         jCtYZCucwMYZSC6ofTxB7kpoq4O3K7pop76mB390vH2vlqpT39HSkZWMQe15We2VdGIg
         /dbXbsKJJLcOR3yRbaRq4e0CkrQzLlJnd7svE8gRT++C7lTrLMRsXkcpMU0bjFwaqN6e
         epTXm9BLMTc/vYneE0cPBr24cdYSWtqcw802ePn7C3OPwrE7EKFZ438bPGLSGCrmeS+r
         wo/z3Ao/L5SGMKtjVwdD/czNk3GAXuXH74xa5OZWZpeH+U8XQnMmQ/YuTczTEGVkfRDS
         gAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ciBK/vtGlGEZoP5Jb2k+FE8PcH/xkoBn4MurxKkryUI=;
        b=CGE/o5eeE8o9JUs1dba4neU+o5GcCCtL+Y/y9VI3/yJnbHnhZN6hcv8ZA+U+JEvFEi
         Foki7hzNGnrUaddvlMidvu4c/KvwKu746yeTleDbpWzYsKZwigSJLTCBvo/W0wAoERLW
         4umQIUTlc9LeeBh544Mgm3dcI/VkDrrPqoEiXfeDDYpUiKM15FI4ujZWW3JlEMFiF6ev
         0upBdJMKBNRwPzUzxIeLrxSPBETsfW9hLUZAHHOofTInwTzlYNVUXRYyUEoXV0DpJzK/
         W4ncG7YrplEdOmOSnTDqxJ8JSCh6kOSvAanog7+7ItbxD6dezqhRrwZyxOg44XQ3Z2Zv
         BeAw==
X-Gm-Message-State: AOAM531cUQ1HuGSvsGquBCHYTQLZwZKvz9VQiIV6uEJpISYaXx3rYHkU
        ZzesWiI9DZwX9bkGHEdor/U=
X-Google-Smtp-Source: ABdhPJy9hoJ2+OGsda3vXFbuzQmSEiBzTMABboiPWGZ/odB7x08SI5zAe70Qx5ZK/sFYQFxTSFEipw==
X-Received: by 2002:a05:6402:100e:: with SMTP id c14mr17099925edu.196.1640018517980;
        Mon, 20 Dec 2021 08:41:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n10sm7171335edx.3.2021.12.20.08.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 08:41:57 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzLjZ-000TNq-6W;
        Mon, 20 Dec 2021 17:41:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 6/9] trace2: add timer events to perf and event target
 formats
Date:   Mon, 20 Dec 2021 17:39:09 +0100
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <c5d5ff05e6ca5729993133ce0b6b94af2503808a.1640012469.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <c5d5ff05e6ca5729993133ce0b6b94af2503808a.1640012469.git.gitgitgadget@gmail.com>
Message-ID: <211220.86lf0fut2i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Teach Trace2 "perf" and "event" formats to handle "timer" events for
> stopwatch timers.  Update API documentation accordingly.
>
> In a future commit, stopwatch timers will be added to the Trace2 API
> and it will emit these "timer" events.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  Documentation/technical/api-trace2.txt | 25 +++++++++++++++-
>  trace2/tr2_tgt.h                       | 25 ++++++++++++++++
>  trace2/tr2_tgt_event.c                 | 40 +++++++++++++++++++++++++-
>  trace2/tr2_tgt_normal.c                |  1 +
>  trace2/tr2_tgt_perf.c                  | 29 +++++++++++++++++++
>  5 files changed, 118 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index bb13ca3db8b..e6ed94ba814 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -391,7 +391,7 @@ only present on the "start" and "atexit" events.
>  {
>  	"event":"version",
>  	...
> -	"evt":"3",		       # EVENT format version
> +	"evt":"4",		       # EVENT format version
>  	"exe":"2.20.1.155.g426c96fcdb" # git version
>  }

FWIW this seems like a time not to bump the version per the proposed
approach in:
https://lore.kernel.org/git/211201.86zgpk9u3t.gmgdl@evledraar.gmail.com/

Not directly related to this series, which just preserves the status
quo, but it would be nice to get feedback on that proposal from you.

> [...]
> + * Verison 1: original version

A typo of "Version".

> + * Version 2: added "too_many_files" event
> + * Version 3: added "child_ready" event
> + * Version 4: added "timer" event
>   */
> -#define TR2_EVENT_VERSION "3"
> +#define TR2_EVENT_VERSION "4"
>  
>  /*
>   * Region nesting limit for messages written to the event target.
> @@ -615,6 +620,38 @@ static void fn_data_json_fl(const char *file, int line,
>  	}
>  }
>  
> +static void fn_timer(uint64_t us_elapsed_absolute,
> +		     const char *thread_name,
> +		     const char *category,
> +		     const char *timer_name,
> +		     uint64_t interval_count,
> +		     uint64_t us_total_time,
> +		     uint64_t us_min_time,
> +		     uint64_t us_max_time)
> +{
> +	const char *event_name = "timer";
> +	struct json_writer jw = JSON_WRITER_INIT;
> +	double t_abs = (double)us_elapsed_absolute / 1000000.0;
> +

nit: Odd placement of \n\n

> +	double t_total = (double)us_total_time / 1000000.0;
> +	double t_min   = (double)us_min_time   / 1000000.0;
> +	double t_max   = (double)us_max_time   / 1000000.0;

Both for this...

> +	jw_object_begin(&jw, 0);
> +	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw, thread_name);
> +	jw_object_double(&jw, "t_abs", 6, t_abs);
> +	jw_object_string(&jw, "name", timer_name);
> +	jw_object_intmax(&jw, "count", interval_count);
> +	jw_object_double(&jw, "t_total", 6, t_total);
> +	jw_object_double(&jw, "t_min", 6, t_min);
> +	jw_object_double(&jw, "t_max", 6, t_max);

[...]

> +static void fn_timer(uint64_t us_elapsed_absolute,
> +		     const char *thread_name,
> +		     const char *category,
> +		     const char *timer_name,
> +		     uint64_t interval_count,
> +		     uint64_t us_total_time,
> +		     uint64_t us_min_time,
> +		     uint64_t us_max_time)
> +{
> +	const char *event_name = "timer";
> +	struct strbuf buf_payload = STRBUF_INIT;
> +
> +	double t_total = (double)us_total_time / 1000000.0;
> +	double t_min   = (double)us_min_time   / 1000000.0;
> +	double t_max   = (double)us_max_time   / 1000000.0;
> +
> +	strbuf_addf(&buf_payload, "name:%s", timer_name);
> +	strbuf_addf(&buf_payload, " count:%"PRIu64, interval_count);
> +	strbuf_addf(&buf_payload, " total:%9.6f", t_total);
> +	strbuf_addf(&buf_payload, " min:%9.6f", t_min);
> +	strbuf_addf(&buf_payload, " max:%9.6f", t_max);

...and this, wouldn't it be better/more readable to retain the uint64_t
for the math, and just cast if needed when we're doing the formatting?
