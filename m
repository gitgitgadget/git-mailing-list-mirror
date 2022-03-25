Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5C0C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiCYRao (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237322AbiCYR2i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:28:38 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86186FDE30
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:26:59 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-de3eda6b5dso8802439fac.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l68mApwg+qViUOXSZqxWN/7QEgC+WLEh1rWWO1097ZA=;
        b=Ed1ISOVGA05L9daeS6kkAqmzH2Dw9bPHcyBQIcJnCqqjJusJim3Srs18Xb45gLofpX
         rOyci5ID4ahNZzwzsPTzJvjuVo36tQetSCUkeDnMA1X61+MEDAKrqa18ZvqguN1Gfv10
         AHCqjjSL5cmLF04JnJ0+XdEPaivm4h54iZQgByL7vsfn9CjTV+0I8+YmCnVRpwzIDZlF
         SBPjwak/uagVB9NJMg/TjD6tW+5Vhtkh21a5mBZWJ+FOXAz7PU2f5rP1EByZQ8BXkiT+
         rpr3uiieOU4O5DzoIEeUF0db0xp2cx28LLqUe+0clTcN1cUte30QamqB5O6XaYnhTqLP
         /hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l68mApwg+qViUOXSZqxWN/7QEgC+WLEh1rWWO1097ZA=;
        b=JBHcZGp7lYmIZc9xXSNkGZU7UZRJN1FPavjRwUGDvshjzJig9ydm6U3IWcIMeqpura
         lcwOhGAaUGZ5bGpuWmGKzBvMtoENyvFIUoxiuqV1JcwtWYez2G7Hx8oUe4/OlxsNI0mi
         OuMW5pDouI4AVuru2/SrucTht/Zn10hRTux3Hgu/cpoI1uv7WLER+jNF9cd6T4UlqxAZ
         CwrVgzYJELaWSraXbmC/bHBZBUjW3STBwfATsUbdAw2nW4H44YNOcXmdhq3kObPyQy31
         z0fz4ERk+ubElNAIYd7f7fHsnU0U6GWYNgWi8+UpBnaHXTB4PvJytIhCl8v/J8p8h8eS
         yh/g==
X-Gm-Message-State: AOAM533mDG12YcuE8tmXfJtnxOjfafL8TmdkpTyoyk70OmD2iKr7cz1J
        OoJNTVWf3gJaAgnigKxhFGcr
X-Google-Smtp-Source: ABdhPJy5cCf7BUs6r6DH/3/3kvy3St3nMEzS4PyafmXDOuhK9ngPLI+6tN18H0y9TIg7SFpSOAXx3A==
X-Received: by 2002:a05:6870:e30e:b0:de:ab76:eed7 with SMTP id z14-20020a056870e30e00b000deab76eed7mr1764394oad.101.1648229008679;
        Fri, 25 Mar 2022 10:23:28 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id a10-20020a056808120a00b002d404a71444sm3206349oil.35.2022.03.25.10.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 10:23:28 -0700 (PDT)
Message-ID: <3fab1246-1451-597c-4359-c01f9675e3f1@github.com>
Date:   Fri, 25 Mar 2022 13:23:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] t7700: check post-condition in kept-pack test
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, chakrabortyabhradeep79@gmail.com,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
 <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
 <f2f8d12929bcbd630b2de3ce770a6763989ffcff.1648146897.git.gitgitgadget@gmail.com>
 <xmqqmthearlz.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqmthearlz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/25/2022 1:07 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +get_sorted_objects_from_packs () {
>> +	git show-index <$(cat) >raw &&
>> +	cut -d" " -f2 raw | sort
>> +}
> 
> As pointed out by Taylor, this "the standard input gives us the name
> of a file to be read" looks strange.  It may work, and it may even
> give the easiest interface to use by all the callers, but if we were
> designing a more generic helper function suitable to be added to the
> test-lib*.sh, we wouldn't design it like so---instead it would be
> either "we read the contents of the .idx file from the standard
> input" or "the first argument is the name of the .idx file".

Ok. Can do.
 
>>  test_expect_success '--write-midx -b packs non-kept objects' '
>> +	git init repo &&
>> +	test_when_finished "rm -fr repo" &&
>> +	(
>> +		cd repo &&
>> +
>> +		# Create a kept pack-file
>> +		test_commit base &&
>> +		git repack -ad &&
>> +		find $objdir/pack -name "*.idx" >before &&
>> +		>$objdir/pack/$(basename $(cat before) .idx).keep &&
> 
> We probably want to sanity check "repack -a" by insisting "before"
> has found exactly one .idx file, before using it this way.

> 		test_line_count = 1 before &&
> 		before=$(cat before) &&
> 		>"${before%.idx}.keep"

Good idea. This mixture of a file and variable sharing
a name is a bit muddy for me, though. Using "before_name"
as the variable would be enough of a differentiator.

>> +		find $objdir/pack -name "*.keep" >kept &&
>> +		test_line_count = 1 kept &&
> 
> Since we've made sure "before" is a one-liner earlier, we could just
> say
 
> 		test_cmp before kept &&
> 
> instead, no?

'before' contains a .idx name and 'kept' contains a .keep name,
so this direct comparison does not work. We could do that
additional check like this:

	kept_name=$(cat kept) &&
	echo ${kept_name%.keep}.idx >kept-idx &&
	test_cmp before kept-idx &&

Thanks for taking the time to clean this up, as it might become
a good example for these kinds of post-condition checks of the packs
directory in the future.

Thanks,
-Stolee
