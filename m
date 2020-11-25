Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA7AC56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 17:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07AC3206D9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 17:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4la2AC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbgKYRWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 12:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730567AbgKYRWY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 12:22:24 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1335C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 09:22:11 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id k3so2886556otp.12
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 09:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sIwv9ZbQYLHP3OZ8jkeq14O2GktQfyk2oPjXxwLr+os=;
        b=P4la2AC8e7xswJ+HapxNQUt0Yl4YZNViRrUxgYjWgWk4K2rrgkvMuNUBO4dTS3l4i4
         dgCFd4KY6OaSn/7HWjF3IfyOUpTAUczQb4lCmysjHy1jemZCeujZeIq37WOn6AZpjmCJ
         2pFhKv2onsuwglV1XdgNlcIOaCrA2TNuA6hslVBeHgDT+RTlZPIOade1XcU5ZiOS9swO
         d2pqDXQmmmWmRFMgvDEbBNMW18jgZq5zFg/aMjuwZUO1fvbXgoi/4NHviO/5AKMpSHqN
         GLF1+Guok95a/T03w9eGQBOrKy9LHjW87XnOA+TFC2uXgFyLzZysji3Vp4Nn81tayzG3
         ShUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sIwv9ZbQYLHP3OZ8jkeq14O2GktQfyk2oPjXxwLr+os=;
        b=uXlE7wTBPfr0OMwf6mFqUC7eiCDl5/k51CQkPMFoImjfDtRCRVJgjVAyilWqDgxGfX
         A1I6ny+2M+j14QGz0DWhc3AmNgNiNoDdhj/AVvwSOsZWZ9AcqxGFnkqmdKlqgF6rbTZp
         qV5PMgHiFcCIlYk1OMEqaj2/4I/flNVHDs8/y4xMsPwQdB42wacXtIidis/n8u0nACfU
         V6Dq/ff8OwD7a273N7PPnTmZv4mdXtTw1iiaTJ1VKPJU+6fVKJV+DrW7cimHib6zaxp6
         ON1yLF8dt2le5weUx97t7R3Q/lhGx8PqxaO2M2Vbgvj4jiCSjru3CA+3Ow2m59SlV2L8
         1OQg==
X-Gm-Message-State: AOAM530TpJiX+jMRIyegWJ9zT37sFCEYk+pwLP9xrYs/yPJlecBnQ/co
        chXaWdf/0eYzm/t0K0E1uNY=
X-Google-Smtp-Source: ABdhPJx11d+xSeJDsKLRXZvXBbx9rrcZpDPtZu76BymhCsFMWCSxiKsmADIzG44M5ScLVYc8JHpVvg==
X-Received: by 2002:a9d:1a9:: with SMTP id e38mr3626156ote.240.1606324930983;
        Wed, 25 Nov 2020 09:22:10 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:b5e9:7f83:ac96:1a69? ([2600:1700:e72:80a0:b5e9:7f83:ac96:1a69])
        by smtp.gmail.com with UTF8SMTPSA id n62sm1489175ota.74.2020.11.25.09.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 09:22:10 -0800 (PST)
Subject: Re: [PATCH v2 4/7] config: add --fixed-value option, un-implemented
From:   Derrick Stolee <stolee@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
 <0e6a7371ed4696f6cc85df07466fb6c20d58d62e.1606147507.git.gitgitgadget@gmail.com>
 <20201123215122.GD499823@google.com>
 <xmqqy2irlmq5.fsf@gitster.c.googlers.com>
 <91af356f-d0a0-1149-15dc-32da803ac6d9@gmail.com>
Message-ID: <6b2b5af7-e73e-7584-6515-0e1d65c5e6d1@gmail.com>
Date:   Wed, 25 Nov 2020 12:22:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <91af356f-d0a0-1149-15dc-32da803ac6d9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/25/2020 9:08 AM, Derrick Stolee wrote:
> On 11/23/2020 5:41 PM, Junio C Hamano wrote:
>> Emily Shaffer <emilyshaffer@google.com> writes:
>>
>>>>  	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
>>>> +	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when matching values")),
>>> I'm not sure how to feel about this phrasing. I wonder if it would be
>>> clearer to say something like 'treat 'value_regex' as a literal string
>>> instead'? Hmmm.
>>
>> Update the document and help text with s/value_regex/value_pattern/
>> and say "use value_pattern as a fixed string, not an extended regexp",
>> perhaps?
> 
> If I go about changing all documentation and error messages to say
> "value_pattern" instead of "value_regex", should I also update the uses
> in the *.po translation files? Or, should I leave them unmodified to
> trigger manual intervention by the translators?

I have discovered that changing these causes conflicts with automated
line number updates. I'll leave these unchanged with a note for
translators.

Thanks,
-Stolee

