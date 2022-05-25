Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA36C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 14:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiEYOHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 10:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245642AbiEYOFy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 10:05:54 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E90C6E7B
        for <git@vger.kernel.org>; Wed, 25 May 2022 07:03:47 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id i66so25093287oia.11
        for <git@vger.kernel.org>; Wed, 25 May 2022 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ssWJU4SfppniKkCj6BaE0BuB+u+0hIxMe17UFc1FYpU=;
        b=Y+c7Q1CHzHzRCTHqNuTXA5TsShdVCkEVmA95/Bit4ibzI1PJhe0f54lKE96qy9azI/
         TitHq2CPXsW6oRQPMtTcsp5DHXc95qVmn4mgqxAsI+Ri9JpZusp4LvJJdnYH0XGBdLIC
         LHkIMQomGSoC242DuNB4JIsQESlpAQGT2g08UPHrSS7Zz10cV8+ekCRnnErNBh5Ki/iy
         dTrC3S/qLMhy6jZEpK54MJwEpCzt7qkfYrVl/ELnSIKOw7PcxYN6P4wAPViFSZOdCFzA
         YRp4sMX2ulkQKZ9BH0t2iNGXifAIw0n7j9z9Ap1LRwj4F9LNOmPm7BNYJ55FU+eOhpbg
         ChYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ssWJU4SfppniKkCj6BaE0BuB+u+0hIxMe17UFc1FYpU=;
        b=ovkTCz035TpJZcbh1N7twUdvO9t1yePrk6Dj0GRysEnSBi8bfZVr/PIO3Dx97Hv8Jm
         AJJGkeIjJr687LwDOUTe0DmvhpKDNnr24tiS/9XQCUiwRhQd+XdagfoabXTIxR0An4CD
         iBKzGG+O6ZVIY1n+mJIvV1wwnEgAfX3A2wxzKpijTSk1/dhvu+3/vdpCA79Jk3nPqtBf
         eF3JrdP7cPDTtyt2XybrnDJvDE1Z07bFA1NsGtqp3i+isz5oPPbTv7KW1kFICEdvXVVM
         /P/gwEsAg2DwUzB2Qa0fciLW2u1EklzSBfztrBFrlIHktY4KIzKDvuBPUELnHWilIe2X
         xnPQ==
X-Gm-Message-State: AOAM530fc35SR3Rpq2QxGtcZ07OM/q/CrkPsxDmP7WHATUINPf+QboxU
        ThwJvo/Hc+WCDH3F/6lzqMWM
X-Google-Smtp-Source: ABdhPJyFoOO9mk4XNEJqIRuhDTeqnZQP5ddR/mtU/T7vYZovw2cPbQFWUxO+WcacZno5qdZ1wJnXMw==
X-Received: by 2002:a05:6808:1185:b0:2fa:49c3:fea4 with SMTP id j5-20020a056808118500b002fa49c3fea4mr5250746oil.49.1653487426592;
        Wed, 25 May 2022 07:03:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b144:5f1c:7ca1:15fd? ([2600:1700:e72:80a0:b144:5f1c:7ca1:15fd])
        by smtp.gmail.com with ESMTPSA id d130-20020a4a5288000000b0035eb4e5a6besm6635414oob.20.2022.05.25.07.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 07:03:45 -0700 (PDT)
Message-ID: <b9eff859-ee1a-6cfd-7d83-e24284c14eec@github.com>
Date:   Wed, 25 May 2022 10:03:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] urlmatch: create fetch.credentialsInUrl config
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
 <220524.8635gzxr9h.gmgdl@evledraar.gmail.com>
 <0dc38d46-7c5a-5532-c843-ef3c8b6cfa28@github.com>
 <220524.86ilpuvcqh.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220524.86ilpuvcqh.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/24/2022 5:01 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, May 24 2022, Derrick Stolee wrote:
> 
>> On 5/24/2022 4:18 AM, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Mon, May 23 2022, Derrick Stolee via GitGitGadget wrote:
>>>
>>>> +fetch.credentialsInUrl::
>>>> +	A URL can contain plaintext credentials in the form
>>>> +	`protocol://<user>:<password>@domain/path`. Using such URLs is not
>>>> +	recommended as it exposes the password in multiple ways. The
>>>> +	`fetch.credentialsInUrl` option provides instruction for how Git
>>>> +	should react to seeing such a URL, with these values:
>>>
>>> Re the previous discussion about this (in the v1 patch /
>>> https://lore.kernel.org/git/pull.945.git.1619807844627.gitgitgadget@gmail.com/):
>>> In what ways?
>>>
>>> That's rhetorical, the point being: Let's adjust this documentation to
>>> discuss exactly why this is thought to be bad, what we're mitigating for
>>> the user etc., are there situations where running git like this is
>>> perfectly fine & not thought to be an issue? E.g. no password manager
>>> and you trust your FS permission? Let's cover those cases too.
>>
>> This documentation is not the proper place to tell the user "do this
>> and you can trust your plaintext creds in the filesystem" because that
>> is asking for problems. I'd rather leave a vague warning and let users
>> go against the recommended behavior only after they have done sufficient
>> work to be confident in taking on that risk.
> 
> I don't mean that we need to cover the full divergent views on different
> approaches to local password management, but not leave the user hanging
> with the rather scary "exposes the password in multiple ways".
> 
> I.e. if I read that for any software whose implementation I wasn't very
> familiar with I'd be very afraid, and in git's case for no reason.
> 
> Does in mean that git has some scary git-specific feature that would
> expose it. perhaps there's a local log that's unsecured where attempted
> URLs are logged, or perhaps we send the raw requested URL to the server
> so it can suggest alternatives for us. We do neither, but even a
> generally knowledgeable user won't know that about git in particular.
> 
> Whereas what I think you actually mean and are targeting here is better
> explained by:
> 
>     Git is careful to avoid exposing passwords in URLs on its own,
>     e.g. they won't be logged in trace2 logs. This setting is intended
>     for those who'd like to discourage (warn) or enforce (die) the use
>     of the password helper infrastructure over hardcoded passwords.
> 
> All of which I *think* is correct, but maybe I've missed something you
> know about, as that "in multiple ways" is doing a lot of work.
> 
> I also wonder if this wouldn't be even more useful if we took some
> lessons from ssh's book. I.e. per "git config -l --show-origin" we know
> the original of all config. We could be even more useful (and more
> aggressive about warning about) cases where we have passwords in config
> files that we detect don't have restrictive permissions, as OpenSSH does
> with your private key.
> 
> Ditto perhaps when the origin is "command line", as we do nothing to
> hide that from the process list on shared systems (and that would be
> racy whatever we did).

I tried to be careful about how "it" (being "Using such URLs") can
expose the password includes things that are not under Git's
responsibility (such as command-line histories and other system-level
logs) but I can add a bit about how Git stores the plaintext password
in the repository's config.

>>>> +	char *value = NULL;
>>>
>>> This init to NULL should be removedd, as we....
>>>
>>>> +	const char *at_ptr;
>>>> +	const char *colon_ptr;
>>>> +	struct strbuf anonymized = STRBUF_INIT;
>>>
>>> nit: Just call this "sb"? The's at least one line below over 79
>>> characters that's within the bounds with a shorter variable name, and in
>>> this case it's obvious what we're doing here...
>>
>> I will not change this name to be less descriptive.
> 
> Sure, just a suggestion. The other way is to just re-wrap that one
> line... :)
> 
> In the end I don't care, "just a nit", but just as one datapoint from
> reading this code: I find this varibale name in particular to be the
> polar opposite of descriptive, we're explicitly not anonymizing the URL
> in this function, since we're not stripping the username part.
> 
> Wouldn't descriptive be something more like uri_redacted_password or
> uri_no_password in this case?

How about "redacted"?

> Just for the implementation: It's slightly more wasteful, but in this
> case we don't care about performance, so perhaps a strbuf_splice()
> variant is easier here? I.e. add the full URL, find : and @, then
> strbuf_splice() it. It gets rid of much of the pointer juggling here &
> adding things incrementally.

TIL. strbuf_splice() will work perfectly. Thanks.

-Stolee
