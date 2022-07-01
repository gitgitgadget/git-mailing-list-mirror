Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82137C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 13:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiGANke (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 09:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiGANke (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 09:40:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05FF15808
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 06:40:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d17so3267778wrc.10
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 06:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tdXJguGrPvP7VXmuRVBBJuNmbEDcTpZTLj+5rGEtg5g=;
        b=G1oMiU0nA1W6DtMZSO1BW5flShJ9Cd0UF1EuFIBFLpi2os2rbRtFaacye/iM+7+cPJ
         3NFI1F5Vc4gBJlBfZq8L1W5xk+BnnVnl56HpJPveZw0UChPWlUrHHcRfbocDP/HPEEy1
         GkizRx4YyhJ0Kp605yVTILdfFyxpP+WxBCiSNNwNfV0nbSJJpy9wkBLkcVWHqzSI4l/g
         wN3nGLnciChTQF2F4QhV/40erGXJ9eXNuUB/gYz3cgQ30QWhA+VsySJ96OOJa3h64/ZA
         Z45zl7cnI6cgkyceBFp3PW0xz4NA/CrJtg2A0YM2i0vhcf8YyJpkQplaXyuhROBjSVnP
         IT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tdXJguGrPvP7VXmuRVBBJuNmbEDcTpZTLj+5rGEtg5g=;
        b=6MRtXvgLxi21TLmN+mwmSOMFXbWQjWIqBuRXDLDfhXyvHCKNjtzlleki7HbahYbKJA
         HnoPGLTjNOjZwDwdbkH975yHhpShxNvm4KdagK0VuQ4RD+wTAchWSdMqmHmnu3NDrfpn
         b9j3KP1sYF0rwyst33GQVslaqf5HdAWbwbs/g7tBIJ+CVXVauLBH3U/fvJva8RxsCYO4
         VzHJGb6Tbi8TKNZYVvTD497i/W8mZR5Y3+aNpVVpOTSA8FJj27zQziMmRBawyNCzNGNT
         9Hmv/PJMA+Kjlx2x4KxlrMxXwtu1xooqVBC9RsaS08VhvLbt+u3Beew6K2UhGfAV6g9a
         uT2g==
X-Gm-Message-State: AJIora8AP5xB8VoXtX801l3Ak/25CXSQ1JotQQZBglHJHTiL1vLnTnAJ
        jBcgSMjbQzAQtXROI2zwu0M=
X-Google-Smtp-Source: AGRyM1vqYkGPpuzJvz1H3gkRcO4QNn/BGSJvQlxOV1SQlYvRITkVb7TcZSuhnZtnfrcs9oEhAn3Ldw==
X-Received: by 2002:a5d:5c03:0:b0:21b:90e6:42bc with SMTP id cc3-20020a5d5c03000000b0021b90e642bcmr14536774wrb.36.1656682831081;
        Fri, 01 Jul 2022 06:40:31 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id ay29-20020a05600c1e1d00b003a03be171b1sm7692724wmb.43.2022.07.01.06.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 06:40:30 -0700 (PDT)
Message-ID: <85541613-cf4b-8631-0aa9-2a80ef4b5213@gmail.com>
Date:   Fri, 1 Jul 2022 14:40:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/8] branch: consider refs under 'update-refs'
Content-Language: en-GB-large
To:     Derrick Stolee <derrickstolee@github.com>,
        phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <2bc647b6fcd6032a1e97e67739ced31117bfbfce.1656422759.git.gitgitgadget@gmail.com>
 <f27d563b-d011-9983-8f7d-52232b052608@gmail.com>
 <b0c596d6-f4aa-9575-4d79-64bd112d0baf@github.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <b0c596d6-f4aa-9575-4d79-64bd112d0baf@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 30/06/2022 14:35, Derrick Stolee wrote:
> On 6/30/2022 5:32 AM, Phillip Wood wrote:
>> On 28/06/2022 14:25, Derrick Stolee via GitGitGadget wrote:
>>> From: Derrick Stolee <derrickstolee@github.com>
> 
>>> +int sequencer_get_update_refs_state(const char *wt_dir,
>>> +                    struct string_list *refs)
>>> +{
>>> +    int result = 0;
>>> +    struct stat st;
>>> +    FILE *fp = NULL;
>>> +    struct strbuf ref = STRBUF_INIT;
>>> +    struct strbuf hash = STRBUF_INIT;
>>> +    char *path = xstrfmt("%s/rebase-merge/update-refs", wt_dir);
>>
>> I think it would make sense to introduce rebase_path_update_refs() in this patch rather than later in the series
> 
> The biggest difference is that rebase_path_update_refs() only
> gives the path for the current worktree, while this method needs
> to read the file for any worktree.

That's an important distinction that I'd failed to notice

> There is likely some opportunity to create rebase_path_update_refs()
> in a different way that serves both purposes.

That would be nice, even just having a #define for 
"rebase-merge/update-refs" and using that here and in the other patch 
would mean we're not hard coding the filename in two different places.

Best Wishes

Phillip

>>> +
>>> +    if (stat(path, &st))
>>> +        goto cleanup;
>>
>> What's the reason for stating the file first, rather than just letting fopen() fail if it does not exist?
> 
> Not sure what I was looking at that gave this pattern, but you're
> right that it isn't necessary.
> 
> Thanks,
> -Stolee
