Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CE2C2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 17:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CAAC20767
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 17:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyR6gh8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502897AbgDNRuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502783AbgDNRt5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 13:49:57 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EADC061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 10:49:51 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c63so14271312qke.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=paUr5L/35Vl+BKcIE9Z5BzPk9tAet9YiAimvXhVZeKw=;
        b=jyR6gh8d7PGol7ITgSuL8zdpSBFTXhGgShXUaroY1o/gl/AZACDCLPVvCkthxrcC5h
         i0+HDE9QI6ekUgQlWu6nTnG7LPs1Mu2Gmnw4AIK4tQkDT/suV1W1FfwDFfM6vqO4qi7P
         kNoZkrVAPVqBzu29qXR+cEQyb/T7nugRBmXeyTDqiEzj5HZSfgma3KqBAFBp9eY3ZClq
         ZX4sKwGzjG9RY3P6LRa/qvHIzMpGRsFfTi0hYI/lWqBTfiLKfV/YreGwSpZTPm0u0oM7
         Ng3R1cVOW8Ur4plxFVu7N68PBNjmJoG8R20rQ1kFsmFXfRRNg+KS5f4I6Lbm0WdwxCr2
         Ydyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=paUr5L/35Vl+BKcIE9Z5BzPk9tAet9YiAimvXhVZeKw=;
        b=V8Hdvry0g3mSI0rEBug+pqebFg0RYk8JXKzJDx3mdJYs4JH4zLs4HOglfAEaIpDSpp
         +sJ7I8OBKK7qcGof/c2hbtLy+Bx7z9wmOU0Eyh1eFSLYuQFq3BUCOcK0vuYbpD6Wez/0
         7hEWXqWNaFUZaV0TzP0LUA3M6GfUBKHDsDuFhrVzzlEzmJ57AdaD9tVh9t1MSCGl9skd
         hSSQhbaGflSzkj8sp31jo5dJ8wTYF347wr+dxDD0+Rmp4OQuh1ZUPEMDAVGepWdF5xsc
         4dcf11Djv90Qu5UEB+wfqp6z2jK/eDBnGPccjY2fagj0Q6fOoMGGfJ7En5EZ9jjjsBxq
         qufA==
X-Gm-Message-State: AGi0PubpRS+i5cExE3xxZFxTAUPaKcFsS1fgKN38tg2x5eV6yPE9ngQj
        uu5t8MZNsUL6zHMYNqMi70o=
X-Google-Smtp-Source: APiQypJIxDHIK2vyJKS8wyYULD5pOqxK5jPqb5mNbvojng2Y0+R7Hpq9W8F8Iye087KQv8BHSjzatg==
X-Received: by 2002:a37:aa8e:: with SMTP id t136mr13704845qke.175.1586886590750;
        Tue, 14 Apr 2020 10:49:50 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id r15sm10812337qkm.53.2020.04.14.10.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 10:49:50 -0700 (PDT)
Subject: Re: [PATCH] log: add log.excludeDecoration config option
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.610.git.1586791720114.gitgitgadget@gmail.com>
 <xmqqeesq9e8p.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5c8cd2dc-f1e2-5c93-094c-e15e45e8543e@gmail.com>
Date:   Tue, 14 Apr 2020 13:49:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <xmqqeesq9e8p.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/14/2020 1:19 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>  	if (decoration_style) {
>> +		const struct string_list *config_exclude =
>> +			repo_config_get_value_multi(the_repository,
>> +						    "log.excludeDecoration");
>> +
>> +		if (config_exclude) {
>> +			struct string_list_item *item;
>> +			for (item = config_exclude->items;
>> +			     item && item < config_exclude->items + config_exclude->nr;
>> +			     item++)
>> +				string_list_append(&decorate_refs_exclude,
>> +						item->string);
>> +		}
>> +
>>  		rev->show_decorations = 1;
>> +
>>  		load_ref_decorations(&decoration_filter, decoration_style);
>>  	}
> 
> A few random thoughts.  Unlike my other usual reviews, please do not
> take "should we do X" as a suggestion (these are purely me wondering
> and nothing more at this point):
> 
>  * Given that we have command line options to specify what patterns
>    to include as well as to exclude, it feels somewhat asymmetric to
>    have only the configuration to exclude.  Should we also have a
>    configuration for including?

I left the other side out for simplicity and because I didn't know
the use case. It seems all refs are included by default.

>  * The new code only adds to decorate_refs_exclude, which has the
>    patterns that were given with the "--decorate-refs-exclude"
>    command line option.  As refs.c:ref_filter_match() rejects
>    anything that match an exclude pattern first before looking at
>    the include patterns, there is no way to countermand what is
>    configured to be excluded with the configuration from the command
>    line, even with --decorate-refs" option.  Should we have a new
>    command line option to "clear" the exclude list read from the
>    configuration?  And if we add configuration for including for
>    symmetry, should that be cleared as well?
>
>  * As this is a multi-valued configuration, there probably are cases
>    where you have configured three patterns, and for this single
>    invocation you would want to override only one of them.  It might
>    not be usable if the only way to override were to "clear" with a
>    new option and then add two that you want from the command line.
> 
> What if we had (configured) exclusion for X, Y and Z, and then
> allowed the command line to say "include Y", that would result in
> the combination to specify exclusion of X and Z only?  Can we get
> away by not having "include these" configuration at all, perhaps,
> because "if there is no inclusion pattern, anything that does not
> match exclusion patterns is included" is how the matcher works?

This is a very good point. We should be able to use command-line
options to override configured values. Something like this should
show decorations for refs/hidden/origin/master:

  git -c log.excludeDecoration=refs/hidden/* log --decorate-refs=refs/hidden/*

But, the current patch does not.
 
> I guess the last one, despite what I said upfront, is the beginning
> of my suggestion.  If we take the quoted change as-is, and then
> before load_ref_decorations() uses the decoration_filter, perhaps we
> can see for each pattern in the "exclude" list, if there is the same
> entry in the "include" list, and remove it from both lists.  That
> way, when the users wonder why their "git log" does not use certain
> refs to decorate (let's say, you configured "refs/heads/*" in the
> exclusion list), they can countermand by giving "--decorate-refs"
> from the command line, perhaps?  It is still unclear to me how well
> such a scheme works, e.g. how should patterns "refs/tags/*" and
> "refs/tags/*-rc*" interact when they are given as configs and
> options to include/exclude in various permutations, though.

My next version will allow this "overwrite" of configured values.
It seems like an important use case that I had missed.

Without getting into the code immediately, I predict the change
will be to include a second pass of "configured patterns" after
the command-line patterns. If the explicit command-line patterns
have already included the ref, then the configured exclude
patterns should not be tested.
 
Thanks!
-Stolee
