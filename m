Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2BDC433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 14:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiCNO0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 10:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiCNO0O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 10:26:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026032E0BF
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 07:25:04 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e24so24220961wrc.10
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sLrJ4AhgRSjGSsyOdYuBjVnxI0WYjIAON30+CQlw4IA=;
        b=REd3xKQiBYFTKbMCOgX3xbbOKVAIWh0DxuQCXQ6IxVxK1G+Cmx6UkQu1kBCP7Dexg4
         RqSpjCrCnMU9IhpRUOcn3EyTg0VXWfSybb/PqT6m8dNS4QYJ8gSkIA/iqA5zRSn1pAbp
         mzYGcU3jQIAKWMhh9CIpz+bB2j6NmwQO6UMbqF+TJ/qZMP0JS4DcTOVKPE60Fu2smjpH
         +SCN6I3oxx9UcI7Va/LU7eDGY32AyN2sAHMw4O9H5n+ASdGGXkZwPG8VzyqLDeyMydKw
         RDAvs3ts2okA5cvXouaMZQLk5HdBZ1Oopoy+pt2y0lr7v/vpPS0dS3NFP+/vIAf6vkYb
         4pkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sLrJ4AhgRSjGSsyOdYuBjVnxI0WYjIAON30+CQlw4IA=;
        b=qCHXussWKl9LAsewDTgBhPNYKdpOix8iWn7cTLAt3z07/9HNpcl05AhbubmOQC8e4g
         UDKREZ3nrgq7if67qZ56xP8SNhJgs8JGi5T4zwhq4l+0rj6uAw4kDge4jsMpOAHfPX9r
         leGkSWXlOIeVtKoRtyaFljBk+7W2WNJAilHelU/fxGNIOAFUrbzHm6IUHyuKX0COle/L
         L0QeWDrqeNfb6czYNBQUUmaNah5FSEsBleBtKTlR8rh5VwKMad+zxeE6Vga360sdPOch
         L31tAClZaQ8CgRmqSFCdC6AZXOahhFfLOb3yOn0K73oRFgWlY/dYMQR7wBbHQ0QQaqzP
         JYXw==
X-Gm-Message-State: AOAM533Qu8nrVyHDltNALfb3h2cqJjUJZKUrStSCvYaE0WEzyYjennik
        /Bm161bmZAV3QX1DozRF/h4=
X-Google-Smtp-Source: ABdhPJyWzqxU3AP9vw4H37Zv4WX8A7pL4YDFKLN79wA7QMMxOTQPVN7/d3g/8/cOZf6uGrS69hcmrA==
X-Received: by 2002:adf:eccc:0:b0:1f0:1a33:a7af with SMTP id s12-20020adfeccc000000b001f01a33a7afmr17560780wro.113.1647267902447;
        Mon, 14 Mar 2022 07:25:02 -0700 (PDT)
Received: from [192.168.1.240] (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm17175413wmv.31.2022.03.14.07.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 07:25:02 -0700 (PDT)
Message-ID: <2aa6bd95-caf1-2882-e0a6-2fbf9b0d9741@gmail.com>
Date:   Mon, 14 Mar 2022 14:25:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] rebase: set REF_HEAD_DETACH in
 checkout_up_to_date()
Content-Language: en-GB-large
To:     John Cai <johncai86@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
 <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
 <0e3c73375c18a470fd5357b09acefeaf5ca4017f.1647019492.git.gitgitgadget@gmail.com>
 <xmqq7d8ywaf0.fsf@gitster.g> <4313B834-90B4-41B3-B810-746EF91F8BBB@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <4313B834-90B4-41B3-B810-746EF91F8BBB@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

On 14/03/2022 14:11, John Cai wrote:
> Hi Junio,
> 
> On 13 Mar 2022, at 3:58, Junio C Hamano wrote:
> 
>> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> diff --git a/reset.c b/reset.c
>>> index e3383a93343..f8e32fcc240 100644
>>> --- a/reset.c
>>> +++ b/reset.c
>>> @@ -101,6 +101,9 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
>>>   	if (opts->branch_msg && !opts->branch)
>>>   		BUG("branch reflog message given without a branch");
>>>
>>> +	if (switch_to_branch && opts->flags & RESET_HEAD_DETACH)
>>
>> It's just style thing but it probably is easier to read to have
>> an extra () around the bitwise-&.
>>
>>> +		BUG("attempting to detach HEAD when branch is given");
>>
>> I wonder if there is a valid use case NOT to use RESET_HEAD_DETACH
>> when switch_to_branch == NULL.  If there isn't, it could be that
>> we can get rid of RESET_HEAD_DETACH bit and base this decision
>> solely on switch_to_branch'es NULLness.
>>
>> But that is totally outside the scope of this fix.  I'd prefer to
>> see a narrowly and sharply focused fix, and to be quite honest, I
>> would be happier if this assertion weren't in this topic.
> 
> I'm okay with taking this out, but would be good to get an ack from Phillip.

That's fine with me. The rest of the patch looks good as far as I'm 
concerned.

Best Wishes

Phillip
