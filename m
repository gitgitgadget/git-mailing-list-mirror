Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D638C3DA6E
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 22:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiLOWhv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 17:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiLOWhh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 17:37:37 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8150D5EDCB
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 14:37:36 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q71so588954pgq.8
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 14:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Jdk7yXJIcxtb9tN8DjMf4J8RCvLe7ao3n7c7FKGOK0=;
        b=dZamopHjhgDmQ3XonWmRIhnTu0ftafkp+AZfGHLAJ2ZF2Cn+3TsiB5t+0UwCs1DdNX
         ZYHqU9QKJz8rC+pOcoeEDkjDi6xWQhJnGCqc1mPpXc2t9qSMlKJLxTdcR3JpeDwY7gLX
         FMFgdpUn1AmlXj1QbfuDTnZ7oxM5wKgsjdK0o89fte66q9TTnuQG/armfNgTlFeSCuVs
         kvWVVPstu7wPNhyiTIMZs2W1UzNJ8v570AcdtSRGBcGdZhf3blinBEFpa0HQF+Yy17ms
         +MGoJgrHdIRipk1sb+g+bQt+FXAgzXh9QJ/dLgNAPo1LLvRIFUxr3LylTtdBGqYOlcsp
         M50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Jdk7yXJIcxtb9tN8DjMf4J8RCvLe7ao3n7c7FKGOK0=;
        b=JVFZzmz1QJCSi8SiDZs57DZ6nXzIS0cbZjmK8cq5oOBGl4ZhM0JleSf68quxjvmwHk
         kQqLQX7AYmCZObE3hiv5vh0YhKIEUoLmSg3dmTVzkWePxW9c45bD6KmXQvOjwQ8fRySO
         HgyMwcmSKQRHyLDvwbdov2HP5RSLcxVUHAvk9qjHpiNHaMfjofSH1DvzZfi52MuztNEF
         1MFru3+PWvC3sGAXCKRTPLIjOyVovHCWasSLDMis7Ur2pCKuTKhAOHPhcj3OhsQKZzeW
         kSfLUoqxcCcBkYQl6BJCSNwYPYTpQdVdeI7MONEn+lScXMhi2TlwAzFEXNBskW0L0TKZ
         3EdA==
X-Gm-Message-State: ANoB5pnk63q6Vu4wNTHlvnqVh2/OWnfwwGo74agJhCEKNOJivVgkf0WB
        uo+bSFxDWVn6t+q7ygb+jC9UtDGdu8iBUA==
X-Google-Smtp-Source: AA0mqf4fCs3A1DKSf8bDQXuH5s9g+QaynM3kEAdaqU2qcbSpAO4xVMXtsfl0mW992I17iVoYqToaUg==
X-Received: by 2002:aa7:928f:0:b0:56d:465d:9fbc with SMTP id j15-20020aa7928f000000b0056d465d9fbcmr26074061pfa.25.1671143855963;
        Thu, 15 Dec 2022 14:37:35 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 74-20020a62194d000000b005771d583893sm111621pfz.96.2022.12.15.14.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 14:37:35 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2022, #05; Wed, 14)
References: <xmqqiliewbje.fsf@gitster.g>
        <aedc0911-5538-603e-b0e0-71435039545e@jeffhostetler.com>
Date:   Fri, 16 Dec 2022 07:37:35 +0900
In-Reply-To: <aedc0911-5538-603e-b0e0-71435039545e@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 14 Dec 2022 14:18:01 -0500")
Message-ID: <xmqqfsdgqonk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 12/14/22 4:59 AM, Junio C Hamano wrote:
>> * jh/t7527-unflake-by-forcing-cookie (2022-12-02) 1 commit
>>   - fsmonitor: fix race seen in t7527
>>   Make fsmonitor more robust to avoid the flakiness seen in t7527.
>>   Will merge back to 'next'.
>>   source:<pull.1437.git.1669937534944.gitgitgadget@gmail.com>
>> 
>
> There was no discussion on this item and nothing needs to be
> revisited, so it could go as is.

No discussion is not a good news, though.

Always using cookie files means we no longer sometimes use them and
sometimes not---which means fewer variations to think about and in
general is a good thing.

As you explain in the last paragraph of the proposed log message, if
the test caught a bug introduced by a premature optimization that
was not-well-thought-out, the test served its purpose very well.
Good.

Let's mark it as "Will merge to 'next'" again.

Thanks.

