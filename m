Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EE6C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 10:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbiCNKxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 06:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiCNKxq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 06:53:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF28743ED4
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 03:52:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b19so856087wrh.11
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 03:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ni09ienE0QsleZsKNR1SzZg0dsM+z/I3pkRA7a2Davc=;
        b=Es20S241EUUjzndt/d4ntogsfnN5GHSZv//ebjvzLmPyJBmVLsljNRjcYhGwgvbKHG
         T4t8a+Msuxfi0kpKoRPicoLPFgl1zXP1yO6tic9l0pSISfdt3LzhVUkGje+AicAMeSt4
         tS0rVttuLCb7ruILSnMpcQRNw1h5CuazZd0hf9lEQVQfE+Z0QG9rtTenSRTUBXK0GXcg
         IUC4X/NeEC9AGag/GOZMa+mleFQ8Xq3M1f5xdbECFG8EL7PobCOxv/mwUv6CMpIqJxRU
         SC+5RqhfL3vEpJ91R2B3ue21RwTuVhuBBD3ABfdR9BtWRxGnhYxefzSOGwg+N4YoJDMU
         7/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ni09ienE0QsleZsKNR1SzZg0dsM+z/I3pkRA7a2Davc=;
        b=8L0nLRmkDYHzBB4z7giz3s5eXSvytFLOkyNR1pLPT6w4SSXGqgLkqTFypHGA4hfRsj
         jIb06Yvq4+jG7kdhtAO3kYxtLX7aot3Nu475L1SjWBjx/f3KJ3uwJD3T/76Lp+s0tUFh
         GIo0zNHM0cCtVvsUFngUMfvIW4XAPLcmwUk5MbS9ZbEb5DbG6yEO1JK1j+Nq2ghmdo27
         +I5qaQH/1yYYnSyK0X3TUPjw4sF4RuSXV6nFzdjfKEbF9qju3g4oCFTuWiCbtHK1x3Vc
         G2mMjSc/OfdXH1HhulLQ7it3QtB8yk/jIc+/6Ef86mCcTOCFBpyOTqCrB22T8TCxsAxh
         eHKQ==
X-Gm-Message-State: AOAM530AysyFg0B5nPUXt8V21UzLJJc8bql0QgqSsmSec94oUmVZbBjx
        uhcjHy42PKGyL8RjO+gCqNY=
X-Google-Smtp-Source: ABdhPJy5NsXqj18PcogrFwlU/KPMk3CBMjEK5MGI1nCKTDAJpCWVZ2ftwbXwwcIqO9hBlHq1TqnbZw==
X-Received: by 2002:a05:6000:154b:b0:203:7564:930 with SMTP id 11-20020a056000154b00b0020375640930mr16326240wry.349.1647255155603;
        Mon, 14 Mar 2022 03:52:35 -0700 (PDT)
Received: from [192.168.1.201] (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.googlemail.com with ESMTPSA id k14-20020a5d518e000000b002019c7402aasm12951321wrv.25.2022.03.14.03.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 03:52:35 -0700 (PDT)
Message-ID: <4072d712-4138-6cf0-e0e0-5a3303ce010a@gmail.com>
Date:   Mon, 14 Mar 2022 10:52:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] rebase: use test_commit helper in setup
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
References: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
 <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
 <f3f084adfa616a7bae7e7c94644f65a36f38652b.1647019492.git.gitgitgadget@gmail.com>
 <xmqqee36watb.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqee36watb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/03/2022 07:50, Junio C Hamano wrote:
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: John Cai <johncai86@gmail.com>
>>
>> To prepare for the next commit that will test rebase with oids instead
>> of branch names, update the rebase setup test to add a couple of tags we
>> can use. This uses the test_commit helper so we can replace some lines
>> that add a commit manually.
> 
> OK.
> 
>>   test_expect_success 'prepare repository with topic branches' '
>> -	git config core.logAllRefUpdates true &&
> 
> This lossage is not explained.  I do not know if we actually make
> use of the reflog in the tests, though.

It is the default these days so we don't need to waste a process setting 
it here.

Best Wishes

Phillip
