Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B0231F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 21:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391817AbfJWVDb (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 17:03:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46711 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390638AbfJWVDb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 17:03:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id e15so12826874pgu.13
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 14:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y4uGdqdicX5BIgOLaEespFiRmd4pKkiKoIUDmB3rkKs=;
        b=bgQ+fy4JMdhcDzN5s9Pks7S7+BCGibSzueK6uUFlrijbeMa4J4YMX/iynT2+orsUZu
         pIqxqA4q6UktheK6x+q6t1vGQYRy5Bi5+JzYUTXQQMjEeAq2MJOwE8KhJ8VLAaqQ2opj
         p7RNuU1N+k9sxJefXFvpOg9+HwAz8YZLiWvRHREjp5B6gwUSY0qimxZSyBZnhA00VbDg
         heMyYryGoSqtRzzUGtaxIt/qhEn+rq8Di9NeX6Vyj6oCtbQb/CHHL25VTE5ZLdnupYs7
         wAxYM3FhCbq0R+Q/bhgaJ0fncsH/vt711AELxex/t65WY0WrS5xwFssZ1RNRxUJ6AV0v
         DQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y4uGdqdicX5BIgOLaEespFiRmd4pKkiKoIUDmB3rkKs=;
        b=BGkt5RePAvqucMb1LvQx8IVW3VUbV4/FYrEy3gMEFQMlXClatl/jkLdmlwTMtkcSWT
         /r05VMuQQF7dzUt1TrYi+yRdt1gFuwJI+zoiSTg67SSKiOk4yZveuHvRnCYBWGQo3/mK
         EBdG1nROaG5ktnTCNqaESd1GMAyFv8fHzIrfNnFayIT5DFQAgrQts8vKT54vveXwPxzC
         W7oCMUDitxa13cccFuFslm80ALtXqH088FWA+KiWZfEq7GbcwR3OdSoyXbk8oUtOY+8c
         FnF4t0GjQ50+cuKIylv+cvsbg7mTwN+MoXpodJxCn5iZ7GWXuGPVtzUfc7zVk9mdcpsZ
         7UCQ==
X-Gm-Message-State: APjAAAUT2olpAVfjDIZ3y2xAI1hFLXNbQPlejsa/q54N7gCps+35ETwx
        ZSzXDZiODlyvx0BZQiVvhQlrTg==
X-Google-Smtp-Source: APXvYqwYzgzX5p8yqFvrs20ewsAbT1IcqyZNi7liAp8iBFbig/vgBx7fkPkDCWd/OaHIYl8A/euBwA==
X-Received: by 2002:aa7:9ad0:: with SMTP id x16mr10951160pfp.51.1571864609945;
        Wed, 23 Oct 2019 14:03:29 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id b4sm170997pju.16.2019.10.23.14.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 14:03:29 -0700 (PDT)
Date:   Wed, 23 Oct 2019 14:03:24 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: delay fetch_if_missing=0 until after config
Message-ID: <20191023210324.GC139951@google.com>
References: <20191007181825.13463-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007181825.13463-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 07, 2019 at 11:18:25AM -0700, Jonathan Tan wrote:
> When running "git fetch" in a partial clone with no blobs, for example,
> by:
> 
>   git clone --filter=blob:none --no-checkout \
>     https://kernel.googlesource.com/pub/scm/git/git
>   git -C git fetch
> 
> "git fetch" will fail to load the config blob object, printing "unable
> to load config blob object".

I'm having some trouble figuring out which object is actually missing.
Is this the .git/config object? (That doesn't make much sense to me...)
Is it .gitmodules?

> 
> This is because fetch_if_missing is set to 0 before the config is
> processed. Git must set fetch_if_missing to 0 before the fetch because
> as part of the fetch, packfile negotiation happens (and we do not want
> to fetch any missing objects when checking existence of objects), but we
> do not need to set it so early. Move the setting of fetch_if_missing to
> the earliest possible point in cmd_fetch(), right before any fetching
> happens.

Doubts aside about what's actually failing, I definitely agree with the
premise of not setting this until the last moment we need it. Plus, I
may be alone here, but it'd make it easier for me to understand the code
if I saw a note explaining *why* we don't want to fetch_if_missing in
this case.

By the way, I think I understand that this is OK to go in
unconditionally because:
 - In the full clone case, it's a no-op; we haven't got anything that's
   missing, so who cares.
 - In the filter case, it's as you said - we don't want to
   fetch_if_missing because that will turn someone's partial clone into
   a a full clone.
   - This probably applies to bare checkout, too.

Of course if I'm wrong I'd like to know, but that's how I understand it
at the moment.

> ---
> This is not a full solution, but this helps in the use case described in
> the commit message. The full solution probably will involve teaching the
> fetch mechanism to support arbitrary struct repository objects, and by
> moving fetch_if_missing into the repository object. (Alternatively, we
> could add the equivalent of OBJECT_INFO_SKIP_FETCH_OBJECT to functions
> like parse_commit() that are used by files like negotiator/default.c, or
> split up commit parsing into object reading - which already has that
> flag - and commit parsing.)

Ah, I remember this was listed as one of the potential intern projects -
I think we dismissed it as being too tech-debt-y for an intern to feel
good about. :(

> ---
>  builtin/fetch.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 24d382b2fb..865ae6677d 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1666,8 +1666,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  
>  	packet_trace_identity("fetch");
>  
> -	fetch_if_missing = 0;
> -
>  	/* Record the command line for the reflog */
>  	strbuf_addstr(&default_rla, "fetch");
>  	for (i = 1; i < argc; i++)
> @@ -1734,6 +1732,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  
> +	fetch_if_missing = 0;
> +
>  	if (remote) {
>  		if (filter_options.choice || has_promisor_remote())
>  			fetch_one_setup_partial(remote);
> -- 
> 2.23.0.581.g78d2f28ef7-goog
> 

The diff, though, looks fine for me.

 - Emily
