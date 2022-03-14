Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845F9C433FE
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 10:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbiCNKzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 06:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238707AbiCNKzV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 06:55:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B2022B0E
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 03:54:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n31-20020a05600c3b9f00b003898fc06f1eso11710888wms.1
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 03:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xz1B+1MXeTJSbEfArYYlKvKK9IYFl/PlHkBRQGwq/jg=;
        b=qMeszuZ3EtGaQsDI4G0y/Ncb8lbrMrue141kciOghK8/fmsdxrpJ16P6f1+POhkQz8
         enMGGMiKZy6mjJAurfvfAofjRUdyluHKmRUAWog2kdD2lhMb3Dkm4ynbrFnHpbj7ocCi
         TZJ6bD3xN9RNBe/FWIsJeyW+KVTRI4FwBEJ70jZsEqXT5zp7h6iEZq1d+kL0uS5oXkpy
         dj6tBgeAHFhWkeXtQ1+FvziyI1kQFegB39YQIiMUE6/IrT1UgmC/MTV6jOH9VYjfjwTS
         QQIP3mX1aR6VdMSaIZ9Yc8N4gE0/O5olgq/liAaihwePTMYjV2KhCRW32zTg00ERyUwO
         VdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xz1B+1MXeTJSbEfArYYlKvKK9IYFl/PlHkBRQGwq/jg=;
        b=4I2vRWvbGFX1OhThsIPEbvGyqsAWFvKrwHFozwrsXa6L3gZV5SZ+wfAjjD91vcyrK1
         ShSaFWtzHXTKOyCE0nVbBcWe1h6wV2TzNlib77rVIz8P6oLiCZhmZsYP9zIllZQ3EBeX
         X30ihY/DY1Pp16FDhVAG9ic1KQMQPXgRC6iQzh0ocmu+eAqEIvyTviIqjXtJyOzrKl1s
         7ltpF7csqNajJNkUZ/AnluFGGTEfD2FEJCoazPhUEbZVTQ1KE31TH3z4hVbSmaWUdVn6
         +i6WeHenFa4pAG2M6RFQB1ohW3hoG5qkiDgREurgDab3yh2PiI+aftfPkkzdfJcl3Vc6
         L5bw==
X-Gm-Message-State: AOAM53074v2cFNShGr5UyR25G/+IR7M7Vp9tTSL6X25UZVcmIjvMy+oO
        vhWK5YxuyqMVpDt4VCv5x73vZ1YoDJzr8w==
X-Google-Smtp-Source: ABdhPJytvna980HoAKzJil8sAkirwjOXpZRfKYbS2ssyPW7HxVsaUj69JYZ0HV1DTzBZ3adBwXnNwA==
X-Received: by 2002:a05:600c:4f16:b0:389:d686:7dd0 with SMTP id l22-20020a05600c4f1600b00389d6867dd0mr16496830wmq.136.1647255250257;
        Mon, 14 Mar 2022 03:54:10 -0700 (PDT)
Received: from [192.168.1.201] (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.googlemail.com with ESMTPSA id n16-20020a5d4850000000b0020373b34961sm12735096wrs.66.2022.03.14.03.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 03:54:09 -0700 (PDT)
Message-ID: <b35edfb8-9b48-d5b3-8d77-cb61a22f85ef@gmail.com>
Date:   Mon, 14 Mar 2022 10:54:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] rebase: set REF_HEAD_DETACH in
 checkout_up_to_date()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
References: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
 <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
 <0e3c73375c18a470fd5357b09acefeaf5ca4017f.1647019492.git.gitgitgadget@gmail.com>
 <xmqq7d8ywaf0.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq7d8ywaf0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/03/2022 07:58, Junio C Hamano wrote:
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/reset.c b/reset.c
>> index e3383a93343..f8e32fcc240 100644
>> --- a/reset.c
>> +++ b/reset.c
>> @@ -101,6 +101,9 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
>>   	if (opts->branch_msg && !opts->branch)
>>   		BUG("branch reflog message given without a branch");
>>   
>> +	if (switch_to_branch && opts->flags & RESET_HEAD_DETACH)
> 
> It's just style thing but it probably is easier to read to have
> an extra () around the bitwise-&.
> 
>> +		BUG("attempting to detach HEAD when branch is given");
> 
> I wonder if there is a valid use case NOT to use RESET_HEAD_DETACH
> when switch_to_branch == NULL.  If there isn't, it could be that
> we can get rid of RESET_HEAD_DETACH bit and base this decision
> solely on switch_to_branch'es NULLness.

"rebase --skip" and "rebase --autostash" are two such uses I think

Best Wishes

Phillip
