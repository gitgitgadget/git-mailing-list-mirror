Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7A9C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 19:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348029AbiA1Th2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 14:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344219AbiA1Th0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 14:37:26 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DB0C061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 11:37:25 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id w8so6500744qkw.8
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 11:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MohTi/7T09DB5Bmr3VAx/lb1eypVgsTde2V5BCKt4Tg=;
        b=o1DSESlTugFLm0rYyr3LAtMdZ36O7E/xNDiywydoUh8H5bC//WNSrQ57tjNULaNj56
         1/JZpiMvS2Ma3L8e0O1THKJr0bc4zNVzGHrpB0BjVZEpa1H6up53oxdygFoVZ0Q64sGe
         +F9XajtxktiOEfHtS77RWQeB4HWM9FQFHYWXOEqbn73qeRUkBTWRXpCsfsBHHu37ljUz
         eIXf+40S71fRxOMS7uJEDpLF+qoqj454oBjxZV6N6LeSjbBlrwTuwfh0j7Mkn4oGZsof
         qegmbbTiTHodvSwnFanlCCXcLqxjVXmKfA9o9Gn4bMhiPSg2/vzBfs0ZloXsziO6IyXE
         r85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MohTi/7T09DB5Bmr3VAx/lb1eypVgsTde2V5BCKt4Tg=;
        b=s+f5rw9b2r9wQaKtoueJkxAAK/m4UCCkKmprNb66jbBBijVrrs1MtxNdY36AubEVw7
         GnDJ+en4OXmLt/uabQMGkjQV562rIfEYD9oss2nLmai+QKCwyNDDOpjSIY/1+RbxlfcQ
         eC4eLlj7Wq5w4b+NJOb+yOtN6cVhSqMyuK1fLd99FTkW6ju8cLVyqsX3RorkQTaacBPJ
         65XO7u2TjV7ilyCcfPS/jSS8F7h6wTWUz1Hjt3atWpc49FQDpAmaChf0BJ15TNpos2BU
         8uRfKS1xPkc2y/3S5EDmX8grpOJ5Y3bhQDkRQKWHxxtUFy7EIqFtOuCCQqIshDcbZ/Eq
         dX/w==
X-Gm-Message-State: AOAM531fSvwLinO4cwIphA1y0EUN4JSIJCCCaDZXR9Abj/b1hkX+VLr1
        4gJDj0QqSxBuwnjYASXuLbI=
X-Google-Smtp-Source: ABdhPJxplUnonGdYVdo0Yj7S0UUzJCoFmyghVBw/qJCqMcCRNKjWnnMVYjufSg+SrYs8ZNvrUlWXsw==
X-Received: by 2002:a37:a2cb:: with SMTP id l194mr6686783qke.531.1643398644123;
        Fri, 28 Jan 2022 11:37:24 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5cd8:5d5f:ba81:6c67? ([2600:1700:e72:80a0:5cd8:5d5f:ba81:6c67])
        by smtp.gmail.com with ESMTPSA id w5sm3964795qko.34.2022.01.28.11.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 11:37:23 -0800 (PST)
Message-ID: <5283a1b2-a31f-1657-1a67-cab6d9fec0ac@gmail.com>
Date:   Fri, 28 Jan 2022 14:37:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] scalar: accept -C and -c options before the subcommand
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <pull.1130.git.1643195729608.gitgitgadget@gmail.com>
 <220127.86v8y5dgus.gmgdl@evledraar.gmail.com>
 <0f8d5d04-e86c-48e2-fea0-32c25c3f9325@gmail.com>
 <nycvar.QRO.7.76.6.2201281148310.347@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <nycvar.QRO.7.76.6.2201281148310.347@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/28/2022 6:27 AM, Johannes Schindelin wrote:
> Hi Stolee,
> 
> On Thu, 27 Jan 2022, Derrick Stolee wrote:
> 
>> The biggest benefits of using handle_options() is for other pre-command
>> options such as --exec-path, which I use on a regular basis when testing
>> new functionality.
>>
>> There are other options in handle_options() that might not be
>> appropriate, or might be incorrect if we just make handle_options()
>> non-static. For example, `scalar --list-cmds=parseopt` wouldn't show the
>> scalar commands and would instead show the git commands.
> 
> Right, and since `handle_options()` lives in the same file as `git`'s
> `cmd_main()` function, we would not only have to disentangle options that
> work only for `git` from those that would also work for `scalar`, but we
> would have to extract the `handle_options()` function into a separate
> file.

I agree that these would be necessary steps.

> But since I had a look at `handle_options()` anyway, I might just as well
> summarize my insights about how applicable the supported options are for
> `scalar` here:
> 
> # Beneficial
> 
>   -c <key>=<value>
>   --config-env <key>=<value>
>   -C <directory>
> 
> 	Since I added support for these (except for the long form
> 	`--config-env` that I actually only learned while researching this
> 	email), it is obvious that I'd like `scalar` to support them.
>
> # Won't hurt

These "Won't hurt" items look to me as "they probably don't matter, but
it would be nice if "scalar <option>" didn't just fail for users who are
used to "git <option>".

> # Detrimental

I think your "detrimental" choices are actually more useful than any of
your "won't hurt" choices.

>   --exec-path
> 
> 	Since `scalar` is tightly coupled to a specific Git version, it
> 	would cause much more harm than benefit to encourage users to use
> 	a different Git version by offering them this option.

As mentioned, I use this option in my local development all the time.
This compatibility issue you discuss is something that happens within
Git itself, too, when it calls a subcommand. So, users can already
hurt themselves in this way and should be cautious about using it.

>   --list-cmds
> 
> 	As you pointed out, this option would produce misleading output.

It would, but I also think that a correct implementation would be
helpful to users. It just takes more work than just calling
handle_options() as-is.

> Given that only the `-c` and `-C` options are _actually_ useful in the
> context of the `scalar` command, I would argue that I chose the best
> approach, as the benefit of the intrusive refactorings that would be
> necessary to share code with `git.c` is rather small compared with the
> amount of work.
> 
>> So my feeling is that we should continue to delay this functionality
>> until Scalar is more stable, perhaps even until after it moves out of
>> contrib/. The need to change handle_options() to work with a new
>> top-level command is novel enough to be worth careful scrutiny, but that
>> effort is only valuable if the Git community is more committed to having
>> Scalar in the tree for the long term.
> 
> I am okay with holding off with this, for now.
> 
> On the other hand, as I pointed out above: I do not really see it worth
> the effort to refactor `git.c:handle_options()` for the minimal benefit it
> would give us over the approach I chose in the patch under discussion.

I was thinking that it would be good to maybe extract just the "-C", "-c"
options from handle_options() and call that from scalar.c, but it wouldn't
work to "just parse "-C" and "-c" and then parse all the other options"
because if someone did "git --exec-path=<X> -C <Y> status" then the "-C"
parser would want to stop after seeing "--exec-path".

So, perhaps the code copy is really the least intrusive approach we have
until we see a need for more of these options.

Thanks,
-Stolee
