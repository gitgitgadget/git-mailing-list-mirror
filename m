Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A736DC433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiCKWvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiCKWvM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 17:51:12 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E9C1688EA
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:32:05 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n31-20020a05600c3b9f00b003898fc06f1eso8370991wms.1
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5tzDqe/AUvrhw7Xg3l/ztGmY3an99HvRdVsk/c0Tkxw=;
        b=clq71SfwwfHRczVkFL8IKzOebxErNCdJj+eyX98wMxdV0XLXTSZPSSqoZd4hbIkyTl
         QsEI4vICce5LSABNJGJM1JRzao0BWpK53bbjkv5+ohmgqpL6tGXbh8pyHxqPvBj18pon
         IyOWdZaRireVURYfp6ssEjwiUorJKv+puicpBZ3rpCwc9QZQ0hFtP8KfcnybvvGTT4cx
         mR6Lm4tig62iF9psqV6/kWQ91TKeZLzifhWjUGrFMs8/FMLfT6UuZuqsUX4byq0QG9Il
         pCgNNMFHlFiR5mfwDzbrY2v2yj7C6QsESccbRBdImLUDuPemiXIKagkAbwy6Cs9BE6Bf
         31QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5tzDqe/AUvrhw7Xg3l/ztGmY3an99HvRdVsk/c0Tkxw=;
        b=Z+Fwtd65KZWAvMAy0mLNPDm8fZd/O1VCHUyo/Pq1maspxqxCfC0SLGdzKAkWT7H8xP
         YM0P8AoOKLM9vjLx5j9lq/kODPA1vmEKzByo63eIqOkDTXLfET0d9tjvsMvnE18R9Tox
         tbQWOyjaEHhxhEZRUqCNRSfHZ58qhsZQf5ZmXQlTG4VrJVonOwrejWbAlthkJ6LoWuPD
         F9dC/tl0E3Q5t49M++tq8uHuo7bCEXfn0vSgaasztfzXyv74pgQq2rsU9hWjxm/N1hxq
         i/Koq8vrMo6EqNIT8zio/Aji9HuBY9jd1BuOXnOj1n0i83l9CeezKELvQaItjcbsm6xu
         k96g==
X-Gm-Message-State: AOAM533LAWcTct2XTx+mn4MXq5iYN1vliqvgVPYh687Btyg/cdbg9URe
        mkyuDRCRXcHMugqIq/AVhGPjcvFk/xRBhQ==
X-Google-Smtp-Source: ABdhPJzk+N/2pGp14HXzah8mbveXNKmk1FON4SWQm6qGkQRZEDdNwfxuR8QPbn2uMnv40Ugj+8Js3Q==
X-Received: by 2002:a05:600c:27cb:b0:381:400d:3bba with SMTP id l11-20020a05600c27cb00b00381400d3bbamr17158456wmb.60.1647034304977;
        Fri, 11 Mar 2022 13:31:44 -0800 (PST)
Received: from [192.168.1.240] (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.gmail.com with ESMTPSA id r187-20020a1c44c4000000b0038377fb18f8sm11963948wma.5.2022.03.11.13.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 13:31:44 -0800 (PST)
Message-ID: <16c02a8a-46bd-0ddd-aca7-418b1ed96c6d@gmail.com>
Date:   Fri, 11 Mar 2022 21:31:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase: set REF_HEAD_DETACH in checkout_up_to_date()
Content-Language: en-GB-large
To:     John Cai <johncai86@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
 <7c1c0b8e-7895-7a0e-6ab0-e45e21ec7329@gmail.com>
 <C97F4239-AA5F-4623-A15E-1E90927DA758@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <C97F4239-AA5F-4623-A15E-1E90927DA758@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

On 11/03/2022 19:42, John Cai wrote:
> [...]
>>
>> I think it would be clearer if the post image ended up as
> 
> This is entirely for my own sake and revealing my ignorance, but what exactly
> does "pre" and "post" image refer to?

The old version and the new version

Best Wishes

Phillip
