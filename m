Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CCEC4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 14:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiKPOhI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 09:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbiKPOhG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 09:37:06 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B32E1AF36
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 06:37:05 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id p18so11720773qkg.2
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 06:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HX6vCucEm5NnWDG+jY0GAFoqJxt9YVKngDMmg1WUOLw=;
        b=LIxa4Q09i+AQJ166n7UX6RMZsnk7UkNyPpEVSCTPARBnrg0vFhLeI/IKstyzNomttw
         eSzhw+hhEByftFCzbmvv/XyiCK78uxgZxvItW0e1OMJqwZtakxQOYARh7WfVU+qwru5V
         VhhMDmTGiC++4KU3pm/xdQrN1RkLaE5Ju7CnU21Q9mmha87H9X/1uGOeo0RhazGd3kFr
         Ihc+0PyH7Cf/rrvYZXLmprAxsJOguHZEzNkPdMjK+KBQ30zlv+3JVB6Qfy3LlxRTdC1/
         P73a0jLQWp0KRxvnG5JTbUCOFecTeLmxZa+WlF6ANfWOW17qADWLmCB33ZFwe58FJ5mR
         HyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HX6vCucEm5NnWDG+jY0GAFoqJxt9YVKngDMmg1WUOLw=;
        b=X6xmnm0OX8IjRj5RcS5mdUAt/UFT8748u5PYqLviYsF+PDoPwIwNQi/ThHelhLe168
         4qS2vgoaEE9BZLBIRaUTkouBDq7XeAf+VZG3i+fepLVCqP3btCV6YTMxROpysMLXza6/
         LS2wd3q0rSDfAs6WjoGtdKKfYFFGHKM7Oxif4YMHoAHZLVS0k9wEvZUHLfFKdef+K6yy
         Fj2cA2pI1/7IeoFU93gxHGhhBy5k7xk9LmLfv42iCxSR8QqYAIYIahjXfN252CZ923Ai
         77YIbkF3nQcydbLA/C5pamUsnQw9z5Se1GC6jU5syWGhyJl0lsCzNoAQ1dhVscFiKlc1
         hxMQ==
X-Gm-Message-State: ANoB5pm4CqbvaB+GtUVLluSdPUnPlsb1xneJH5ju/6u5DQA3yZinYGXh
        P6dJEJ/InnChh5o3omMt9vntJArh6AXM
X-Google-Smtp-Source: AA0mqf7DWN9l7IwDrGs2M8NzoKJBk89KGYxOEk9ljpOfJaHDpNBo6xPigO5fybvLhOq4DU6z+rGlzg==
X-Received: by 2002:a05:620a:997:b0:6fa:aa59:ef9d with SMTP id x23-20020a05620a099700b006faaa59ef9dmr20096471qkx.108.1668609424623;
        Wed, 16 Nov 2022 06:37:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:f553:9f0c:85c5:38e1? ([2600:1700:e72:80a0:f553:9f0c:85c5:38e1])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006b9c9b7db8bsm10166850qkj.82.2022.11.16.06.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 06:37:04 -0800 (PST)
Message-ID: <d14744cf-5ac3-e1c2-0239-4c33b701d5bf@github.com>
Date:   Wed, 16 Nov 2022 09:37:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 03/30] extensions: add refFormat extension
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
 <4013f992d15aab69346bf6f8eafe38511b923595.1667846164.git.gitgitgadget@gmail.com>
 <CABPp-BGqkSmExRN=bV2014sM5n0msiSOXBG-q-REc8Of4CM4wg@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BGqkSmExRN=bV2014sM5n0msiSOXBG-q-REc8Of4CM4wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/11/22 6:39 PM, Elijah Newren wrote:
> On Mon, Nov 7, 2022 at 10:48 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> [...]
>> One obvious improvement could be a new file format version for the
>> packed-refs file. Its current plaintext-based format is inefficient due
>> to storing object IDs as hexadecimal representations instead of in
>> their raw format. This extra cost will get worse with SHA-256.
> 
>> In addition, binary searches need to guess a position and scan to find
>> newlines for a refname entry. A structured binary format could allow for
>> more compact representation and faster access.
> 
> This doesn't parse very well at all.  The scanning is due to refname
> entries being of variable length, and changing hexadecimal
> representation of object IDs to binary values isn't going to help
> that.
> 
> I _think_, after re-scanning your RFC cover letter that you had other
> ideas to allow a binary search in order to read a single ref's value,
> and that the juxtaposing of these sentences together leads to an
> unfortunate assumption that one change is related to the both goals,
> but something extra here to clarify would help.

The v2 format has a structured list of offsets that can be used to
navigate directly to the ith ref in the file. Thus, we can use a
more precise form of binary search. Since we have these values, we
do not need to scan for newlines or spaces for the end of the ref
strings. This allows us to use the raw OIDs since we are not using
special characters as string boundaries.

I will work to clarify when I submit this for review.

>> diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
>> index bccaec7a963..ce8185adf53 100644
>> --- a/Documentation/config/extensions.txt
>> +++ b/Documentation/config/extensions.txt
>> @@ -7,6 +7,47 @@ Note that this setting should only be set by linkgit:git-init[1] or
>>  linkgit:git-clone[1].  Trying to change it after initialization will not
>>  work and will produce hard-to-diagnose issues.
>>
>> +extensions.refFormat::
>> +       Specify the reference storage mechanisms used by the repoitory as a
>> +       multi-valued list. The acceptable values are `files` and `packed`.
> 
>> +       If not specified, the list of `files` and `packed` is assumed.
> 
> This sentence doesn't parse for me.
> 
>> +       It
>> +       is an error to specify this key unless `core.repositoryFormatVersion`
>> +       is 1.
> 
> ...is at least 1?  Or are we trying to be incompatible with potential
> future core.repositoryFormatVersion values?

Specifying exactly 1 is consistent across our extensions documentation.
The intention of the extensions system is that we should never need a
value 2 here. If we do, then we should consider all extensions to be
redesigned from scratch. Perhaps we'd have different defaults, or older
options not possible anymore.

Thanks,
-Stolee
