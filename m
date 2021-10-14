Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57622C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 17:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3203460F21
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 17:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhJNROV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 13:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhJNROU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 13:14:20 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E65C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 10:12:15 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id a17-20020a4a6851000000b002b59bfbf669so2100783oof.9
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YxI6nq7XXLCJXG5WroX0oLDiiD6N8MJZyCcGWvtUgKE=;
        b=ar62TBS56ky6TskeIGOqEkCwunelIqO3N1Xv8qtG8PZJhxQFQtX3kdeYzwo0/Vlu4z
         sfFNuntw4XfIBA6C0hs2RMhGZDJ3uzKVDtWhxjzEdp+jAYLtImvK7G9KcWZpXEx9oWkI
         TbKc9fG00vt5XNKY7iwXMV87Ojqp/DO7nFBAF+jqCEy7bVjxndOkZoF+jmqo2PheMUX+
         FSGIV4vAyuUQYacvuay1mt1S05ifdbhLgH1UA+RJMYnEmQw9VaxRx4q234odNBYBnsas
         vwPNsrFiZliQevMnr91+D/PUF/t0CF+QdbU6+Ush47AGIeExB8oPCre5KjdTYGwdrUTM
         yhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YxI6nq7XXLCJXG5WroX0oLDiiD6N8MJZyCcGWvtUgKE=;
        b=Dxwo2XOMVjm5NscfOBcKFx3jWIBBzBqjZahQVQBqETJ72pWgzWMgN4A0sCif+DpxbL
         dobIlwPlJ8Dk72nBaSeOj3N9rIJttH8ptkmxQ6a9sW406XOJ2QcVYF3Jlw3SIDnChEpv
         x7KM3Yisu62IM9pQzjJ2ogJc4kWql3caY9wnzC9eslaK2x7zqMoAEBju9D7RlDT4jFF3
         BVCTn1/tkpA1Pkd00J5RFw2ItxhKFJzByuzjpiuBqatMX4DEgS+qzcfSLGQr1fb+EGWw
         iVS4zWLPInPFrD6WsGrlCM8JkBC+lvSMZZ4hA//A+uxQ9T+hxzQGRMXOewD1jkqkz2H8
         scbA==
X-Gm-Message-State: AOAM5314qiw3Ujajd6dlOm5rUSwJFcKNmqv7AI46qptnAw3xZOeGB5et
        YgG349Z7biM9jUjlDN0Ql9M=
X-Google-Smtp-Source: ABdhPJyU/k0DWF+RivLH0z77W+C8K4Js+WpVv6i45NpUnW/pI4Po3ICnGJIc1rX8gadvacdOxu5MdA==
X-Received: by 2002:a4a:dfdb:: with SMTP id p27mr5181703ood.70.1634231534711;
        Thu, 14 Oct 2021 10:12:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:254d:795e:811:9a2c? ([2600:1700:e72:80a0:254d:795e:811:9a2c])
        by smtp.gmail.com with ESMTPSA id bk8sm68501oib.57.2021.10.14.10.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 10:12:14 -0700 (PDT)
Message-ID: <461f5fa8-42a4-b9a0-b223-7f97b764efd0@gmail.com>
Date:   Thu, 14 Oct 2021 13:12:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 0/4] cache parent project's gitdir in submodules
Content-Language: en-US
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20210819200953.2105230-1-emilyshaffer@google.com>
 <f5197594-550f-3bd8-2d22-c9e1b3e161fd@gmail.com>
 <YWcquctPsrRm964k@google.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YWcquctPsrRm964k@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/13/2021 2:51 PM, Emily Shaffer wrote:
> On Thu, Aug 19, 2021 at 09:09:46PM -0400, Derrick Stolee wrote:
>> but I do have some concerns that
>> we have not covered all the cases that could lead to the relative path
>> needing an update, such as a 'git checkout' across commits in the super-
>> project which moves a submodule.
>>
>> Leading more to my confusion is that I thought 'git submodule update'
>> was the way to move a submodule, but that does not appear to be the case.
>> I used 'git mv' to move a submodule and that correctly updated the
>> .gitmodules file, but did not run any 'git submodule' subcommands (based
>> on GIT_TRACE2_PERF=1).
> 
> During a live review a few weeks ago it was pointed out, I forget by
> who, that this whole series would make a lot more sense if it was
> treated as the path from the submodule's gitdir to the superproject's
> gitdir. I think this would also fix your 'git mv' example here, as the
> submodule gitdir would not change.

I think that's a great way to deliver similar functionality without
the issues I was thinking about.

>> You mention in an earlier cover letter that this config does not need to
>> exist, but it seems to me that if it exists it needs to be correct for us
>> to depend on it for future features. I'm not convinced that we can rely
>> on it as-written, but you might be able to convince me by pointing out
>> why these submodule movements are safe.
> 
> Yeah, that is a good point, and I wonder how to be defensive about
> this... Maybe it makes sense to BUG() if we don't find the
> superproject's gitdir from this config? Maybe it makes sense to warn
> (asking users to 'git submodule update') and erase the incorrect config
> line?

I think we can complain with something like a die() if the config points
to data that doesn't make sense (not a .git directory), but a BUG() is
too heavy-handed because it can just be a user modifying their config
file incorrectly.

I'm happy to shut down a process because a user messed with config
incorrectly. Since your proposed change allows operations like 'git mv'
to move submodules without needing to change this config, I'm much
happier with the design. It becomes impossible for the config to get
out of sync unless the user does something outside of a Git command.

Thanks,
-Stolee
