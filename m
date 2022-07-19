Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D305C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 15:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbiGSPxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbiGSPxE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 11:53:04 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A721D0E2
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:53:04 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10c8e8d973eso32408344fac.5
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TdgekbrjBze2CImvmCCbhyaM1jBMii6QU3g1VAFz/UY=;
        b=JizMzTpgNME+hqoWxNQIAy1YUTGBUD5Nid48b5sp0zQOb3VKlusc+TXEcUKOX1dBBI
         mSpQ3tK9GHwMGEhSljcE1WE6sVycGP4wF8hrLY/w9cynKwSIenWWvKyW2P7ZiisaUJSV
         I5cEUwwuI3Qs9r1APuT483h0A9Ns/j6x80cJtTEarcWdRDC9OBS8vR6oF3LYAKbWxtSR
         mgWteSqWawtMRXo5ogvDhlbStDp0NTn/Lljq7bJxAeIIs8GxI4u1Vk8SEtAus9MsRbws
         deyVBMLKFtgUz8lbpcN0XuKzQEdpDbhBB1susZQdcBaRlrmaHNyFMcDRrXarTnvdRQnL
         7LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TdgekbrjBze2CImvmCCbhyaM1jBMii6QU3g1VAFz/UY=;
        b=jqqofkC4H2CqKw0hRaAJ8z4ucL55E2jwupmEklhISNGkn0fvAtBdLchTryxqdisv3Z
         AYtMhK1Fla7C0eHmgDwhc5gta5AWbP6SAfdGEG5BEbEVeQW77qVvQWxjUJTIb6VJ7whH
         lzdljs20mlvsGQGJuxgEahvX7VTt7n3DFw+lN5pY+SHa0F+7uXI22v1Rlipjx0SOlQ88
         OZ3/4cTIgzudJMBI4NBR304IhgUJPRMo+f6ZxPxQdJTVtrJP2ZXuVqIPKsK7Slx7H9Jv
         osfFM//vPRqpCN7c+nn/qkYL+ruEqsmYsseRmEgQ6jQC51n+cC9BcpsVE26fCGNpFcSC
         Nu1A==
X-Gm-Message-State: AJIora/S8XHgBuBsCHNW0liGiXTAh7cei42aFPP8YScvFf1MvGc+oNLC
        XdnIyQJ385wbeqHV0u2pCv4P
X-Google-Smtp-Source: AGRyM1tf16aqxfUi/crn33aWubkYV6geWbC3/H6DT6zCVE4BCO4ITKVqFizbH8wasJLXAHmkOvAOAg==
X-Received: by 2002:a05:6870:ac0f:b0:10b:f3f5:26b2 with SMTP id kw15-20020a056870ac0f00b0010bf3f526b2mr21612956oab.271.1658245983614;
        Tue, 19 Jul 2022 08:53:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id i3-20020a4aa6c3000000b00435785e7b49sm5618900oom.19.2022.07.19.08.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 08:53:03 -0700 (PDT)
Message-ID: <6b6746cb-2456-0733-32ed-c0a7a3f57087@github.com>
Date:   Tue, 19 Jul 2022 11:53:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 07/12] rebase: add --update-refs option
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <3ec2cc922f971af4e4a558188cf139cc0c0150d6.1657631226.git.gitgitgadget@gmail.com>
 <20220718090557.GA5616@szeder.dev>
 <11aa9b43-adea-4e90-9c70-ab3579aa445f@github.com>
 <xmqq4jzefc3e.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq4jzefc3e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/18/2022 3:35 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> ... I think I should use "branches" here, but
>> keep the name "--update-refs". The biggest reason is that it provides
>> a nice parallel with the "update-ref" sequencer command. This command
>> allows updating _any_ ref, such as lightweight tags in refs/tags/*
>> or even refs in refs/my/namespace/*.
>>
>> The --update-refs option doesn't create the commands to update tags
>> or refs in places other than refs/heads/*.
> 
> I guess it would make the choice of "branch" the most appropriate.
> 
> I was hoping that we can repoint refs in private namespaces that are
> not branches with the option.  But as long as the underlying
> "update-ref" instruction can be used by advanced users, that is OK.

I would like to keep the --update-refs name for a couple reasons:

1. 'update-ref' is the right name for the sequencer command. Having
   a parallel there is helpful for learning about the option.

2. We could extend the boolean '--update-refs' option into a more
   advanced multi-valued '--update-refs=<refspec>' option to allow
   advanced users to specify a ref namespace that they want included.

Thanks,
-Stolee
