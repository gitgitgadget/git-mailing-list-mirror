Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853D2C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 19:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241858AbiA1Tir (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 14:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiA1Tir (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 14:38:47 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C538FC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 11:38:46 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id h25so5182751qtm.1
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 11:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Wo8//hN5oOjxzptNCKacILvPMrTlEfnLg98pObXMF6M=;
        b=A0zWeRfK0OE7M+s9it0i+C3YF7/vZzqoUEJpGbKk4i3FrGWUkqp413aE8+vDqtXtoR
         cVk16hJ2gluD+WW2j25pWdS86tI67+bjFxFB4R1wKwIhywV/PWIzk2OvXPamutCRc3q2
         atXrEpf42Fmnb4eozwEcbaoRN6V2SWKZKx3v49uqez/RbmjS7SKyF+1oZ7v0d1Oy2h24
         8yEQgULnQ03dNFe2FRlUz1L78FrqKC/glgrWEQILYxzDK5qk+rbQFjtx1EidXwSoq1wA
         PJ9uURsjTCtryllyVL/g4aP8tWOxYOZ+XBZ3pkHEDnwe+a9WR4pIyJFYOZ+d9JskvYki
         2JWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wo8//hN5oOjxzptNCKacILvPMrTlEfnLg98pObXMF6M=;
        b=31dmfxgYv8UqZ436/Q7Cb4tJsuI1FXnm7dP5ffsP/vfl4vz9Rd/d5xfHBw3EmhYX4D
         chuPJit4BC2HghdPvkZ8niYvRutqFzjLQIWIC3aamfM+OV9GwH5JIYbjfe5kZJ0fRwOA
         HqGuk7ZyoQj78QKoBrwUHYQkPEt/1pwpaNBiAOzjVH1jYv61Si9dNFsT18VoU5x9ZgRR
         258ze2XAxYJVWNhIzNK7wSXsWr5sMaEaYttNfs5dQ3ppYiwyz2ZoeK02cjZUaRSOCfrS
         8Us0nQI1wz3tiGd8zTDT4N6PHen2aevFN2VD7/1rakD2q8nHaBFbMU91DC+Bc5DmWm+3
         ud9w==
X-Gm-Message-State: AOAM530lMYuM3JBu8G2ZCgR/iUItvYaHxnVBLu5LKz3TaGCLZDivjFLK
        yaXQKfeIjLC4Iyik22/S2wt++AQE6qs=
X-Google-Smtp-Source: ABdhPJw4PrILJO2OdeovrnHqb47aNn2BcqOzMJUvciTpKUa3fFJliCw7xXwMR2+XmemeBRdoAPTgYQ==
X-Received: by 2002:a05:622a:388:: with SMTP id j8mr7241482qtx.535.1643398725802;
        Fri, 28 Jan 2022 11:38:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5cd8:5d5f:ba81:6c67? ([2600:1700:e72:80a0:5cd8:5d5f:ba81:6c67])
        by smtp.gmail.com with ESMTPSA id g20sm3659473qko.27.2022.01.28.11.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 11:38:45 -0800 (PST)
Message-ID: <a41a53ac-cdaa-3e84-12de-703efed0ce78@gmail.com>
Date:   Fri, 28 Jan 2022 14:38:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] scalar: accept -C and -c options before the subcommand
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1130.git.1643195729608.gitgitgadget@gmail.com>
 <220127.86v8y5dgus.gmgdl@evledraar.gmail.com>
 <0f8d5d04-e86c-48e2-fea0-32c25c3f9325@gmail.com> <xmqqv8y3wxas.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqv8y3wxas.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/28/2022 1:05 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> My understanding was that this was ejected so we could find the right time
>> to lib-ify handle_options() (as Taylor suggested), but we didn't want to do
>> that while Scalar was still in a tentative state (in contrib/ with a plan
>> to move it out after more is implemented).
>>
>> The biggest benefits of using handle_options() is for other pre-command
>> options such as --exec-path, which I use on a regular basis when testing
>> new functionality.
>>
>> There are other options in handle_options() that might not be appropriate,
>> or might be incorrect if we just make handle_options() non-static. For
>> example, `scalar --list-cmds=parseopt` wouldn't show the scalar commands
>> and would instead show the git commands.
>>
>> So my feeling is that we should continue to delay this functionality until
>> Scalar is more stable, perhaps even until after it moves out of contrib/.
>> The need to change handle_options() to work with a new top-level command
>> is novel enough to be worth careful scrutiny, but that effort is only
>> valuable if the Git community is more committed to having Scalar in the
>> tree for the long term.
> 
> The usual caveat that little things tend to accumulate and you can
> die from thousands of paper cuts aside, if "run in that directory"
> and "pretend these configuration variables are set" are useful
> enough features to Scalar, I think that the straight-forward option
> parser this patch adds is very much acceptable.
> 
> If we need more options (i.e. when we need to add the third thing),
> that would be the best time to see how handle_options() can be
> restructured to serve the different set of options git and Scaler
> need.
> 
> And this loop, which is too small to be even called "duplicated
> implementation", should suffice in the meantime.
 
I have come around to this line of thinking. My response to Johannes'
detailed examination of my idea goes into that more deeply.

Thanks,
-Stolee
 
