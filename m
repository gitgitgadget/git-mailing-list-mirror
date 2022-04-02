Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F687C433EF
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 09:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbiDBJYp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 05:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238044AbiDBJYn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 05:24:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342681BB7A6
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 02:22:52 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i4so7341281wrb.5
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 02:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oDGFUxtwHdVg5VDvVmZIJd2woZqH02YJLHXsVz2lYeA=;
        b=l1G/KFIgyoXhNvm9pp9m49VjPZRAmhBCnCc+zBdCD9RCYpbEp5L0uWfQB9mJDW+yBf
         9hwc6ngLBHHWdqYjX5NUYNZ+RuREl/r2LDZw6vkGzlpj+oBCr5vbiUkSUM0qblHfIn4S
         nRVMxwRfR7QwWQxsdVgtgze7A36YB9MlGBIqCboqK9+MvyhjZVduUEi+u2sIT3dlRHHC
         hPdUsR7W3lP4XN2BEZEhozi6a6HjNT4cMKXaA/Nwi8hmsx03VrTgqdZBzZjVopKOz6he
         r1QSDTwV31c9Id58noVcuy6dQ+SmQr3TqKUlPfgEr+WW91h0MEQwzxmUmPDC1kiilE1E
         c4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oDGFUxtwHdVg5VDvVmZIJd2woZqH02YJLHXsVz2lYeA=;
        b=qMgakJRUZcAXVzR8MH7HGaywEJgcDuoKtkjA8RO10e2NdmSNLNEXJAN2/Rafd+VGV4
         9nUOIk4dpgsM9K7xT/JBJe0kbwi2yUgFoDHDSjzr06ABcAjsD3zWyzctUHqQM+qE/7bR
         Zj4aOf4KgyJcOT0IU77rqIGIu3e7GAgj9oq0rRBIIYrdtqPzj/URFCL+3Sj1stXIjmRa
         qLtZRNKgM1o+s87guJtxa+17kQYvMv0z7pnzGKXH36MWVh6ZKlbAnl2ZC0GYRnaFiVOa
         +klgmh+h1QNlszZVQXXCfJQo9v/F4mvIIQYX2TCulctgWgxoGHi3tsGCVFKTE03L3OkB
         R2WA==
X-Gm-Message-State: AOAM5310zHfsGtb+hNJp3AvMY3Y4RzskCXSv5e1kuSynIoroOeCmkO4j
        nfwvwv0uObtNGlDvF5a0xTXeMshHtCk=
X-Google-Smtp-Source: ABdhPJz+UYrjCnd4IDwm1hnFcx4HGoMFGygPEFezr3WaPlsi7pQPHkWKhb1EbqDXlwgIFQs6XefZ6A==
X-Received: by 2002:a05:6000:1107:b0:205:b8e5:8929 with SMTP id z7-20020a056000110700b00205b8e58929mr10470723wrw.187.1648891370461;
        Sat, 02 Apr 2022 02:22:50 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b0038c6ec42c38sm3990125wmq.6.2022.04.02.02.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 02:22:49 -0700 (PDT)
Message-ID: <14c17fa9-e9ff-ac5f-dbda-4a566ed09fd3@gmail.com>
Date:   Sat, 2 Apr 2022 10:22:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 13/27] revisions API users: use release_revisions() in
 builtin/log.c
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
 <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <patch-v4-13.27-02ca92660af-20220331T005325Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-v4-13.27-02ca92660af-20220331T005325Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 31/03/2022 02:11, Ævar Arnfjörð Bjarmason wrote:
> In preparation for having the "log" family of functions make wider use
> of release_revisions() let's have them call it just before
> exiting. This changes the "log", "whatchanged", "show",
> "format-patch", etc. commands, all of which live in this file.
> 
> The release_revisions() API still only frees the "pending" member, but
> will learn to release more members of "struct rev_info" in subsequent
> commits.
> 
> In the case of "format-patch" revert the addition of UNLEAK() in
> dee839a2633 (format-patch: mark rev_info with UNLEAK, 2021-12-16),
> which will cause several tests that previously passed under
> "TEST_PASSES_SANITIZE_LEAK=true" to start failing.
> 
> In subsequent commits we'll now be able to use those tests to check
> whether that part of the API is really leaking memory, and will fix
> all of those memory leaks. Removing the UNLEAK() allows us to make
> incremental progress in that direction. See [1] for further details
> about this approach.

This breaks "git bisect" but only when running the test suite to detect 
leaks so I guess that's not too bad. An alternative would be to manually 
remove the UNLEAK() when you're testing rather than committing the change.

> Note that the release_revisions() will not be sufficient to deal with
> the code in cmd_show() added in 5d7eeee2ac6 (git-show: grok blobs,
> trees and tags, too, 2006-12-14) which clobbers the "pending" array in
> the case of "OBJ_COMMIT". That will need to be dealt with by some
> future follow-up work.
> 
> 1. https://lore.kernel.org/git/220218.861r00ib86.gmgdl@evledraar.gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/log.c          | 20 ++++++++++++--------
>   t/t4126-apply-empty.sh |  2 --
>   2 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/log.c b/builtin/log.c
> index 6f9928fabfe..c40ebe1c3f4 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -295,6 +295,12 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
>   	cmd_log_init_finish(argc, argv, prefix, rev, opt);
>   }
>   
> +static int cmd_log_deinit(int ret, struct rev_info *rev)
> +{
> +	release_revisions(rev);
> +	return ret;
> +}


>   /*
>    * This gives a rough estimate for how many commits we
>    * will print out in the list.
> @@ -558,7 +564,7 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
>   	cmd_log_init(argc, argv, prefix, &rev, &opt);
>   	if (!rev.diffopt.output_format)
>   		rev.diffopt.output_format = DIFF_FORMAT_RAW;
> -	return cmd_log_walk(&rev);
> +	return cmd_log_deinit(cmd_log_walk(&rev), &rev);

This is a rather unusual pattern, at first I wondered if there were 
going to be more added to the body of cmd_log_deinit() in later commits 
but there isn't so why not just call release_revisions() here to be 
consistent with the other release_revisions() call that are added in 
other patches?


Best Wishes

Phillip
