Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC09C47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 05:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DECB8613E6
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 05:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhFCFNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 01:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhFCFNy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 01:13:54 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49211C06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 22:11:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z26so4007245pfj.5
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 22:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EEDtSPVbh8+JANOFVRzOdF+Q6Dg6KgiqUiHEfeE0ugo=;
        b=kv9Zdtk8mDV/veW29pMG3UsC4yuBTQ5W/fKYo/cYMIi0XKrCxLxziM/ppJq1gtXq+C
         +mViLCZt+9ShZnjpqRqyrXeZnWG1hgJ3cm7Cr7ucNQhzRy7smA8qTQ8F2YpWRcYYBsRE
         9D5UG1RroJR7GxWm8HscecZcn4rHvewcwl/xE87pZyUrkbpNpZTlO+KbVgcXIaFSpSMT
         5FEbBg5EiWPoPl3PjiU1L6+8jlv1wKOgnFvWTXEL2HQiNouWh9+B4JQfZymxcuXO9F5E
         J7f4Dy4P2PR/NlvZCZW9KC5hj6nKormJ/XnezAaYmamnSp9Oy9ehiNjSIC+nwkTF+Efi
         BWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EEDtSPVbh8+JANOFVRzOdF+Q6Dg6KgiqUiHEfeE0ugo=;
        b=J9XQknUkl1tgmR19ZRv5LxI24h2evxhO1yolucBe8AHqwcux9e7kz5nq/j1eiLv50N
         FGadTf/c/0orff6YtBgTo1RNEkY13g5EX84BntyBPSJ7kLj6BHtO01AolyyqtWDHW8XR
         Yk5TXKmH5O8ekMNHFgtvjGuR+iVblLDJOiP+/wpnnHyL3ceeQrfBhvrKxmEjAEpUWVfe
         YDpRqPFdSgyVHz9nA+FHFLn+eQ4knqn0NY3kLJdPVudJXy896m3iJO1dgSfeli4iMJN5
         IG1WXiArSl7ibVM2Ke4bSqaOzZb2T9fWoEk8pPXax6r3W/BN/PeL49/JbznTmjLzClX4
         KRYg==
X-Gm-Message-State: AOAM531oM5s9OXUmTvJaKvq9t2nGRyYH7bG7ehgUIq0VbD5ld2yBng0S
        9LqjT04oyuYzTNpoZhPpTIo=
X-Google-Smtp-Source: ABdhPJwOz6NMolIrjDFdoA4u7RjNyubd20JxUm7Gdg7QWS8uzaQmYSitRkfNTKUigSaRBBl2iqUErw==
X-Received: by 2002:a62:e102:0:b029:2e9:fc9f:1199 with SMTP id q2-20020a62e1020000b02902e9fc9f1199mr12207282pfh.33.1622697113527;
        Wed, 02 Jun 2021 22:11:53 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-82.three.co.id. [180.214.232.82])
        by smtp.gmail.com with ESMTPSA id n72sm1114410pfd.8.2021.06.02.22.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 22:11:53 -0700 (PDT)
Subject: Re: [PATCH 0/2] [GSOC] ref-filter: add %(raw) atom
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.966.git.1622558243.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <0961dc61-e785-8e3d-8c06-bdb8f2d6ee6a@gmail.com>
Date:   Thu, 3 Jun 2021 12:11:49 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <pull.966.git.1622558243.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 01/06/21 21.37, ZheNing Hu via GitGitGadget wrote:
> In order to make git cat-file --batch use ref-filter logic, I add %(raw)
> atom to ref-filter.
> 
> Change from last version:
> 
>   1. Change is_empty() logic.
>   2. Simplify memcasecmp().
>   3. rebase on zh/ref-filter-atom-type.
> 

I prefer no first-person pronouns (I and we) in patch cover letter and 
commit message, so better say:

"Add %(raw) atom to ref-filter to make git cat-file --batch use 
ref-filter logic."

-- 
An old man doll... just what I always wanted! - Clara
