Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8747AC433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 13:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346314AbiC3Ntg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 09:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243622AbiC3Ntf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 09:49:35 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCF5BABB8
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 06:47:49 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y10so24464407edv.7
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 06:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Z7We3xr15w7y43CAQGhhXSb9P3JQYvxv0FoS4zP/X4o=;
        b=eIIkGMbb3zJg+itKV4kTeSCnK6QA1mEX/DZPZ4mycUdJe40dj2X6bplVbs7IMSPOTQ
         q7H8iiMJyjTa8et2USeUZm1oNuWuxRuGM99v0GrXwvW8REx+4lk84dhFgpsegMaelr4g
         kDqyu1TChfqzsswG8BsYEctZbdp3Riy5QIxNUgy1a6EQaTMP3WtKZOTibsNP3qf60AF2
         uUZWHwo3daYHpdbj7JvrvP0oi/MfOqGk3u80x6UI3sTTjRBG1pJDJYY5CK0tcxVspuNf
         O9fBxAF5ZH4Qr5Rj+53HdsYwLlbnhmiwB7r9SUQvLw4xg7jJpWjVoDp//YIac47Lj5Jq
         65WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Z7We3xr15w7y43CAQGhhXSb9P3JQYvxv0FoS4zP/X4o=;
        b=4xR89OlQEi2o/IVUwtxnZSFbWYkHeMXA/IH8bTcUbpvUbScpo2No5zXg23pZuqJkNv
         jHdw4gDii2yhg206ZGmLRHehUEy1Rs7DiRPI9MKKXNt9oQix9Wt9Yc+CLLQISadQeG+n
         8lYcSbH4l497JD3xGG9NvMdFa8aVJoVn0YJ9jVIe7874+FvtQAaC6cWEpEdh8URirkOk
         huBiDqNzjZnkNSH1sOzrR9cansxsRn+ogFfwMEUMxLLZ3Wv0BcOzx83TnEl0qCZeXa+7
         e8bQ6LFRPJg6tanFRlsjj6x7z1/2fCdg/rAoq7zzAsHIuurG9aS07FfWMqMj7UHbTONj
         Zsrg==
X-Gm-Message-State: AOAM531kHu14Qczzjn1vbsNcFGUFqC+xx0Y8TaZSqgVEVpotbyky2ts4
        NInYGgVGjO9mVRfLy8r9J6Q=
X-Google-Smtp-Source: ABdhPJy4+f9JAekvWiL20IEitJgRvHqjBRp1CdshBcaWZWJoWzCqnaTnR61Q+6Kf/sx7ybrC4ruywg==
X-Received: by 2002:a50:c099:0:b0:415:f5c7:700e with SMTP id k25-20020a50c099000000b00415f5c7700emr10650739edf.205.1648648068282;
        Wed, 30 Mar 2022 06:47:48 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640210ce00b00413211746d4sm9833452edu.51.2022.03.30.06.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 06:47:47 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZYfr-004I26-CO;
        Wed, 30 Mar 2022 15:47:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH] trace2: add stats for fsync operations
Date:   Wed, 30 Mar 2022 15:29:10 +0200
References: <pull.1192.git.1648616800529.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1192.git.1648616800529.gitgitgadget@gmail.com>
Message-ID: <220330.86zgl7o8l8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 30 2022, Neeraj K. Singh via GitGitGadget wrote:

> From: Neeraj Singh <neerajsi@microsoft.com>
>
> Add some global trace2 statistics for the number of fsyncs performed
> during the lifetime of a Git process.

This make sense.

> These stats are printed as part of trace2_cmd_exit_fl, which is
> presumably where we might want to print any other cross-cutting
> statistics.

[...]

> diff --git a/t/t0211/scrub_perf.perl b/t/t0211/scrub_perf.perl
> index d164b750ff7..299999f0f89 100644
> --- a/t/t0211/scrub_perf.perl
> +++ b/t/t0211/scrub_perf.perl
> @@ -59,6 +59,10 @@ while (<>) {
>  	    # and highly variable.  Just omit them.
>  	    goto SKIP_LINE;
>  	}
> +	if ($tokens[$col_category] =~ m/fsync/) {
> +	    # fsync events aren't interesting for the test
> +	    goto SKIP_LINE;
> +	}
>      }
>  
>      # t_abs and t_rel are either blank or a float.  Replace the float

This part doesn't, per the comment at the top of t/t0211/scrub_perf.perl
and the rest of the code the reason we scrub trace2 output is to get rid
of variable output, i.e. startup times and the like.

If I omit this and run the tests only t0211-trace2-perf.sh fails, and in
exactly the tests it seems we should be updating instead of sweeping
this new data under the rug.

Maybe I'm missing something, but your comment/commit message doesn't
discuss the interesing "why", we can see that the author of the code
doesn't think "fsync events [are] interesting for the test".

But why? Unlike the platform-specific APIs fsync() is something we'll
call everywhere, and surely any platform-specific API calls will be
guarded by the relevant options, and we could skip this there for those
tests.

Here I'm eliding that git_fsync() we are calling the platform-specific
APIs, but that's something this logging is explicitly hiding, e.g. if we
call it in a loop this will log once, so this shouldn't be variable
based on the OS, we're logging our own git_fsync() and
FSYNC_WRITEOUT_ONLY v.s. FSYNC_HARDWARE_FLUSH.

> diff --git a/wrapper.c b/wrapper.c
> index 354d784c034..f512994690b 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -4,6 +4,9 @@
>  #include "cache.h"
>  #include "config.h"
>  
> +static intmax_t count_fsync_writeout_only;
> +static intmax_t count_fsync_hardware_flush;
> +

nit: stray whitespace change.

>  #ifdef HAVE_RTLGENRANDOM
>  /* This is required to get access to RtlGenRandom. */
>  #define SystemFunction036 NTAPI SystemFunction036
> @@ -564,6 +567,7 @@ int git_fsync(int fd, enum fsync_action action)
>  {
>  	switch (action) {
>  	case FSYNC_WRITEOUT_ONLY:
> +		count_fsync_writeout_only += 1;
>  
>  #ifdef __APPLE__
>  		/*
> @@ -595,6 +599,8 @@ int git_fsync(int fd, enum fsync_action action)
>  		return -1;
>  
>  	case FSYNC_HARDWARE_FLUSH:
> +		count_fsync_hardware_flush += 1;
> +
>  		/*
>  		 * On macOS, a special fcntl is required to really flush the
>  		 * caches within the storage controller. As of this writing,

Isn't this making this very low-level API thread-unsafe?

I.e. shouldn't you be using something like the tr2tls_locked_increment()
API to keep track of this instead?

> @@ -610,6 +616,12 @@ int git_fsync(int fd, enum fsync_action action)
>  	}
>  }
>  
> +void trace_git_fsync_stats(void)
> +{
> +	trace2_data_intmax("fsync", the_repository, "fsync/writeout-only", count_fsync_writeout_only);
> +	trace2_data_intmax("fsync", the_repository, "fsync/hardware-flush", count_fsync_hardware_flush);
> +}
> +

Is this logging really all that useful in this form? I.e. if we were to
log these as they happen they'd be attributed to whatever the open
region is, and you'd see them "as they happen".

But these sorts of aggregate statistics just seem no give us pretty much
the same thing that strace and similar tools would give us, i.e. we
don't log the number of open(), write() and close() calls.

It *does* abstract away the OS-specific syscall though, but for anyone
looking at the level of detail of "number of fsync's" is that going to
be that useful (and the same goes for logging this v.s. open() on
e.g. mingw).
