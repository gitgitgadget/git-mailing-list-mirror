Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0819BC54EAA
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 22:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjA0WS1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 17:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjA0WS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 17:18:26 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0231987378
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 14:18:26 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id a1-20020a056830008100b006864df3b1f8so2664057oto.3
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 14:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2zoFpgnAc2KtegCCv435lAcn0DF81oTgEQYqm0b5/A=;
        b=OHqW5fyq7VrN7dDZYdcxoCyDIbzsARg2WOPO6/Yn0IaliK4nkzmil/5cUQkStBS22O
         NY/2+TVYSBMBSONHHNZVkHcJPtu7DhBmFnZuIjTBK4zDAa1kErvaNTXSOl+to4c0wAEi
         JrEpnXlKsoWcBZgX0gCt5vP8Y5J8j/zCsZfMIB+inbwvIZszLlQxd5Hysu7AFoxHnMDW
         aib218yduxT5HsYK37ehzWWFi3QYlRsIm95FGbRvxF3cbu7cMZJNidx2qEq+aMw8wMC6
         1N5VYaH3qtnuUUTE6psAT+sEkXs2bBUJVojeo4d35pbqhpkLCkSdpY82BmiRw2paWy0/
         XbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2zoFpgnAc2KtegCCv435lAcn0DF81oTgEQYqm0b5/A=;
        b=4Efqvp+H9WMS697CQRDXH8fQeX8diIiMPjZnhphBcfYZanDgviW2dKKgcbT9/Slugw
         rym/5Eamw6uRWQePHOucqCc1hIH4J0+T79VweZ7ulm3IuABkb19GNehYrP5vrqiw701k
         zdKrSYPRgIqrutZEcyra9C3zsAn49tauvs9hU7Tpjol/i2oqvAflD0FPrRtsPNhajHg0
         a0Csma/8r539+nEE3EEAMsKfG9KojKDUijtxqHaN/NnXax/qISIF2i1Es44neRr39wOE
         rAKO9+B9tkBWwgWWUdgziwCV9NBkdo34KP6/0B0Xe48zgO/cNYIaYT5hkUCrM/P0D6t6
         Bf3g==
X-Gm-Message-State: AO0yUKWfCWk4Kvq2C3x5InW26JL7S7OPcLJVTyuuWfelp9AfNyX5QE/O
        riMsdGYaSiI7QqdfRzPwShWP
X-Google-Smtp-Source: AK7set+ufEU1F6n8YJj5JGHW78K985KAtH3ULURefXzsIyiNfsT+9/XSmkDOJmkPZwWyk/dFXU22TA==
X-Received: by 2002:a9d:6405:0:b0:686:e281:fe49 with SMTP id h5-20020a9d6405000000b00686e281fe49mr3453083otl.14.1674857905225;
        Fri, 27 Jan 2023 14:18:25 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:a857:f20:476a:b382? ([2600:1700:e72:80a0:a857:f20:476a:b382])
        by smtp.gmail.com with ESMTPSA id v24-20020a9d69d8000000b00670763270fcsm2290651oto.71.2023.01.27.14.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 14:18:24 -0800 (PST)
Message-ID: <4913381a-769f-aba0-c04d-559d103e8396@github.com>
Date:   Fri, 27 Jan 2023 17:18:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] scalar: only warn when background maintenance fails
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com
References: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
 <d75780e0567b5f765816ab7522afe550ebaa3521.1674849963.git.gitgitgadget@gmail.com>
 <xmqqleln90ka.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqleln90ka.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/27/2023 3:36 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> A user reported issues with 'scalar clone' and 'scalar register' when
>> working in an environment that had locked down the ability to run
>> 'crontab' or 'systemctl' in that those commands registered as _failures_
>> instead of opportunistically reporting a success with just a warning
>> about background maintenance.
>>
>> As a workaround, they can use GIT_TEST_MAINT_SCHEDULER to fake a
>> successful background maintenance, but this is not a viable strategy for
>> long-term.
>>
>> Update 'scalar register' and 'scalar clone' to no longer fail by
>> modifying register_dir() to only warn when toggle_maintenance(1) fails.
>>
>> Since background maintenance is a "nice to have" and not a requirement
>> for a working repository, it is best to move this from hard error to
>> gentle warning.
> 
> Wasn't the main selling point of scalar that users do not have to
> worry about various minute details of configuration settings to
> maintain their clone of projects on the larger side?

Yes, and that includes things like partial clone, sparse-checkout,
and FS Monitor which are independent of this maintenance change.

>  The "maintain
> their clone" certainly should include running periodic maintenance
> tasks without them having to worry about it.  It feels like this is
> calling for an explicit "disable periodic maintenance tasks in this
> repository" option to help these esoteric environments that disable
> cron-like system services, while keeping the default safer,
> i.e. fail loudly when the periodic maintenance tasks that the users
> expect to happen cannot be enabled, or something.
> 
> Perhaps I am not the primary audience, but hmph, I have a feeling
> that this is not exactly going into a healthy direction.

Here, we are in an environment where background maintenance is
unavailable in an unexpected way. If that feature is not available
to the user, should they not get the benefits of the others?

Not having background maintenance is definitely a downside, but it's
different from failing to connect to the server or being unable to
complete setting up the working directory. The warning communicates
the issue, so users can realize the problem exists and work to resolve
it in their own way.

Thanks,
-Stolee
