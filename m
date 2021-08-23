Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A04C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 13:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C61661373
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 13:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbhHWNUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 09:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbhHWNUI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 09:20:08 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6962FC061757
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 06:19:26 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so36280385oti.0
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iGVpZ4mx/KQF2+7SKdfAtlDX02ElHvJ4ESMTucnzpq0=;
        b=vUmJvqQMhBoMY+ayYHq4BhWzPWr8pFpKrRS8/vWzCwmegZBuJM8P5V2mqI/tgEud2Q
         JJBM5Q4rXZqypg6tJQeTOpCVwEI3TUHTvE+QDVWzpqh2j2CmAlnUUo5lzJFiNjGjLIv9
         iX+YwM2TZEWqll8ZJVwgvrxiGLD+T47N2hR5kGVbSXvFcRUrb0e4/8HISLWqBzJpxD2b
         hvoOSPUSfvo3dnQBsb8q6l9+Fpjkj01VRqIedjXSh5Qxw+jnSdSinHfB3g/sR5YUYlKu
         Ehlrxexlc1zGlcwKoGEWrju+Ef4hATdV5svFaSu7aBBLTjvJSgGBlhu9Sb6PMluCZX0p
         otfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iGVpZ4mx/KQF2+7SKdfAtlDX02ElHvJ4ESMTucnzpq0=;
        b=W1SbsZk/eCP5tAVtIGtCN/2bfh/pjBe9lXTwBqXiqJQvYUIp/ho3AN3kmv2NX2CsL+
         ppk4a4jG3yAcWM2zx5y+RCNWIWocoax+HSPDwGfr+KD72XdAV6NUZ43bS2zdNzj3qxaF
         GHOpEvIQXD9KIv8o+CAbIE5gGTUY4sN2h3p/QuoK7hkVYG8dgwh3ZxF/YxyuYwKkVAQ0
         HJ2NnqrNLJwrX0Vwtb7oB7pXraGc45cdHhRwQg8yd4cIiFKX5UTr/KM9NhN4zZsD1MiA
         q70avWtsABG4HrK6dpFwd2Dec/5sp4dmwGl/Y+/OsfswQTt9BFU9zFU/hNfM2/g7AVX6
         hLtg==
X-Gm-Message-State: AOAM530iAdCV2wIJ6PX0T3C9G5iC8OSHhPVhlbIgmbW6LT/6tPIvfx6d
        UUVO8UsRKBlOnADOnYn3Uco=
X-Google-Smtp-Source: ABdhPJyPFRiwKgZh4d5nueqVuqV2Kl9EsK5aGvpZQArCIWGwNyUlNvxukLvftHNjY62rsp+5Na78rg==
X-Received: by 2002:aca:c005:: with SMTP id q5mr11414994oif.153.1629724765625;
        Mon, 23 Aug 2021 06:19:25 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:48bd:24c0:4055:3255? ([2600:1700:e72:80a0:48bd:24c0:4055:3255])
        by smtp.gmail.com with ESMTPSA id 33sm3686079ott.19.2021.08.23.06.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 06:19:25 -0700 (PDT)
Subject: Re: [PATCH] multi-pack-index: fix --object-dir from outside repo
To:     Johannes Berg <johannes@sipsolutions.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <20210820193504.37044-1-johannes@sipsolutions.net>
 <04ed58aa-94fa-010e-f4db-f41cd51876a5@gmail.com>
 <4d65ef5b0a9e4104d763facc42d10a20557d054d.camel@sipsolutions.net>
 <xmqqo89osi0b.fsf@gitster.g>
 <caafaf945ec43ba606b054bf4c4faa42e35a8db1.camel@sipsolutions.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <414ed641-2bd3-1316-8189-ad542988d091@gmail.com>
Date:   Mon, 23 Aug 2021 09:19:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <caafaf945ec43ba606b054bf4c4faa42e35a8db1.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2021 4:10 AM, Johannes Berg wrote:
> On Mon, 2021-08-23 at 01:05 -0700, Junio C Hamano wrote:
>> Johannes Berg <johannes@sipsolutions.net> writes:
>>
>>> I just needed to go outside the current test git directory, the tests
>>> are running in a way that the current working directory is already the
>>> git tree I'm operating in.
>>>
>>>> Even if you mean to use "cd",
>>>> please do so within a sub-shell.
>>>
>>> I thought about it, but clearly all the tests are run in a sub-shell, so
>>> it didn't seem necessary? But happy to change, I don't really care
>>> either way.
>>
>> Please learn to care before you write your next test, then ;-)
> 
> Hey now, I'm fixing your segfaults ;-)
> 
>> These tests are not run in a sub-shell; they are eval'ed, so that
>> the assignment they make to variables can persist and affect the
>> next test piece.
> 
> Makes sense. FWIW, the test *did* restore the CWD so things worked,

This assumes that your test completes to run the second "cd".

> and
> subshells are actually ugly (need to import test-lib-functions.sh again
> if you want to use those), but I'll make it work somehow.

We just add subshells this way:

test_expect_success 'test name' '
	prep_step &&
	(
		# now in a subshell
		cd wherever &&
		do things
		# don't need to cd again
	) &&
	continue test
'

> More importantly, how do you feel about the "cd /"?
>
> The tests are always run in a place where there's a parent git folder
> (even if it's git itself), so you cannot reproduce the segfault in a
> test without the "cd /", though I guess "cd /tmp" would also work or
> something, but "cd /" felt pretty safe, hopefully not many people have
> "/.git" on their system.

Don't leave the directory your test is set up to run in.

Git has a very large test suite full of examples to use for inspiration.
If you do not see a pattern used within the test suite, then there is
probably good reason to avoid that pattern.

Thanks,
-Stolee
