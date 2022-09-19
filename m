Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7326AC54EE9
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 04:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiISE1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 00:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiISE1V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 00:27:21 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39A519039
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 21:27:18 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c19so17866725qkm.7
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 21:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lpWZh7eMoua2R4OkzTlR9mMmSTa/4vvIUpAPhPzT8Uw=;
        b=ZFvmMNy9eAVDyjzOMPxckcNMP8piarZEtlO7WBiuUWgXdVsqi0xk2FdF29JqZv7cKz
         c1PmqijQn/PhrhWCPdE17+f+eXtqVYAwkWhwuQHeE54kCNwaW3D2CZlHYdJI/FSprLE/
         lMfBbEfp4UDEyhFyllDB7GtXclsrr+mFfc7qA02VTbK/pN1M+Czar26Y671wozxshpHp
         IaCfUOXIz1WihSN4QVB4mcv3ViuBCsiFGkxpvlYbCzuU12Kfk97P7oEm709q0sO/KsFy
         NrKDiF7ky2U1lMGpwh+TSrJtDnKToN0F+UBclEX2lVXhB8gxLTfFyNH8J7s+np8++McP
         mUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lpWZh7eMoua2R4OkzTlR9mMmSTa/4vvIUpAPhPzT8Uw=;
        b=cW6C824IU/QqSqaw7x6pyG+QumCblZ1OjeBmQfWDto2QhqTHVtnqeLuRjEYWN4lQe8
         +gcWUVbX0wIT8zZL74eg0duemKZG4dZySYVsWM1Vfq7096fr2N95SRYL7LynjnUpkU9q
         QvzoRGq9Ae9EUieSEP3xvc8zayP3YbcjPyYE7tX4jOkbEM2I5SJTfWzlieLm07MUHYAd
         8cpVUFD6/o+TRqemnHw9F0Iy9d1k7CEru4JDyUTZbfRb1GPRpEX6ZA6zUsTo5vQ0DHii
         /KB60ymEPnYnopYlo85L1uFjtG1cYecE5AuxIXuVYs5Un3aQH6CKYpeSWnaLLJ7ouosy
         v7ww==
X-Gm-Message-State: ACrzQf3DtE6ob5Nual2sx6W5bQnSAzpkGzhEUl5FQOP4dm0G0+Oa2NXT
        LVNjI6XuviK6MwjzD5kdmvSwl8wYNBQ=
X-Google-Smtp-Source: AMsMyM6ggbRg9LsoBDmHADYqtU9+PmkiIFvwbHLIFuWTj4KEyjETF+bIi4+D89jYc9MOcZ+iLkPxBA==
X-Received: by 2002:a37:6c44:0:b0:6ce:731:9974 with SMTP id h65-20020a376c44000000b006ce07319974mr11546389qkc.598.1663561637826;
        Sun, 18 Sep 2022 21:27:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:5a60:7720:a1e5:4d99:81b9:c022? ([2600:1700:5a60:7720:a1e5:4d99:81b9:c022])
        by smtp.gmail.com with ESMTPSA id o17-20020a05620a2a1100b006ce9e880c6fsm10867514qkp.111.2022.09.18.21.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 21:27:17 -0700 (PDT)
Message-ID: <5d367e04-a23d-ebd7-a923-9988ca1431eb@gmail.com>
Date:   Sun, 18 Sep 2022 21:27:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 1/3] builtin/grep.c: add --sparse option
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-2-shaoxuan.yuan02@gmail.com>
 <CABPp-BF-z72=hY_Jf8h3g95s+wwZOsV_S=+dDNs_AVskQxoaTw@mail.gmail.com>
 <xmqqh719pcoo.fsf@gitster.g>
 <CABPp-BEOVGfgmAMGCjP6Q3k-t=C1tL=f27buhiCiL-Wv0eDF_A@mail.gmail.com>
 <cafcedba-96a2-cb85-d593-ef47c8c8397c@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <cafcedba-96a2-cb85-d593-ef47c8c8397c@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria, :-)

On 9/18/2022 12:52 PM, Victoria Dye wrote:
> Elijah Newren wrote:
>> == Overall ==
>>
>> For existing querying commands (just ls-files), `--sparse` already
>> means restrict to the sparse cone.  If we keep using the existing flag
>> names, grep should follow suit.
>>
>> For existing modification commands already released (add, rm), the
>> fact that the command is modifying actually gives a different way to
>> interpret things such that it's not clear `--sparse` was even a
>> problem.  However, perhaps the name of the flag is bad just because
>> there are multiple ways to view it and those who view it one way will
>> see it as counter-intuitive.
>>
>> == Flag rename? ==
>>
>> There's another reason to potentially rename the flag.  We already
>> have `--sparse` and `--dense` flags for rev-list and friends.  So,
>> when we want to enable those other commands to restrict to the
>> sparsity patterns, we probably need a different name.  So, perhaps, we
>> should rename our `--sparse/--dense` to `--restrict/--no-restrict`.
>> Such a rename would also likely clear up the ambiguity about which way
>> to interpret the command for the add & rm commands (though it'd pick
>> the second one and suggest we were using the wrong name after all).
>>
>> (There are also two other commands that use `--sparse` -- pack-objects
>> and show-branch, though in a much different way and neither would ever
>> be affected by our new --sparse/--dense/--restrict/--no-restrict
>> flags.)
>>
>> Other names are also possible.  Any suggestions?
>>
>> == global flag vs subcommand flags ==
>>
>> Do we want to make --[no-]restrict a flag for each subcommand, or just
>> make it a global git flag?  I kind of think it'd make sense to do the
>> latter
>>
>> == Defaults ==
>>
>> As discussed before, we probably want querying commands (ls-files,
>> grep, log, etc.) to default to --no-restrict for now, since we are
>> otherwise slowly changing the defaults.  We may want to swap that
>> default in the future.
>>
>> However, for modification commands, I think we want the default to be
>> --restrict, regardless of the default for querying commands.  There
>> are some potentially very negative surprises for users if we don't,
>> and those surprises will be delayed rather than occur at the time the
>> user runs the command.  In fact, those negative surprises are likely
>> why those commands were the first to gain an option controlling
>> whether they operated on paths outside the sparsity specification.
>> (Also, the modification commands print a warning if they could have
>> affected other files but didn't due the the default of restricting, so
>> I think we have their default correct, even if the flag name is
>> suboptimal.)
> 
> One of the things I've found myself a bit frustrated with while working on
> these sparse index integrations is that we haven't had a clear set of
> guidelines for times when we need to make UI/UX changes relating to
> 'sparse-checkout' compatibility. I think what you've outlined here is a good
> start to a larger discussion on the topic, but in the middle of this series
> might not be the best place for that discussion (at least in terms of
> preserving for later reference). 
> 
> Elijah, would you be interested in compiling your thoughts into a document
> in 'Documentation/technical'? If not, Stolee or I could do it. If we could
> settle on some guidelines (option names, behavior, etc.) for better
> incorporating 'sparse-checkout' support into existing commands, it'd make
> future sparse index work substantially easier for everyone involved.

This sounds good! I am always confused about the inconsistency of the
meaning of "--sparse" across a variety of commands. A guideline
definitely corrects prior integrations and helps future ones.

> As for this series, I think the best way to move the sparse index work along
> is to drop this patch ("builtin/grep.c: add --sparse option") altogether.
> Shaoxuan's updates in patch 3 [1] make 'git grep' sparse index-compatible
> for *all* invocations (not just those without '--sparse'), so we don't need
> the new option for sparse index compatibility. It can then be re-introduced
> later (possibly modified) in a series dedicated to unifying the
> sparse-checkout UX.

Are you suggesting that we should still follow the original "use --cache
to search within the index and show SKIP_WORKTREE entries found"? I'm
asking because the tests in the second patch [2] are still using the
lately-introduced "--sparse". If yes, then I think it sounds good to
re-introduce the (potentially) modified UI in the future :-).

[2]
https://lore.kernel.org/git/20220908001854.206789-3-shaoxuan.yuan02@gmail.com/

> 
> [1] https://lore.kernel.org/git/20220908001854.206789-4-shaoxuan.yuan02@gmail.com/

Thanks,
Shaoxuan
