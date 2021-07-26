Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB177C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 14:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3192604DB
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 14:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhGZNaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 09:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhGZN37 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 09:29:59 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AE1C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 07:10:27 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id h7-20020a4ab4470000b0290263c143bcb2so2273920ooo.7
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 07:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mrUdk0EQx8rXBuZgHyQ+dDrC05Jct5VOeEpR9i2rWP4=;
        b=S/V52R3UtI8aBf7sgTK0GVS7Wu0R15uD7Y6vp+oIQQPbseOdbZUvtkmdfIoycWr85I
         uh9q9iXnMk7BzLc37aS9Z0l0lIib0ixSbRDtarCI9N6q0oPTTlGyAVkFR44+SOJnHvxV
         kQr03P9KRX8drKWijjaKghzNPL6zEhBcFke2wUIigETbuxV7EU/Q6aSkqrZvfmPgwV4Z
         l30SaiNak3FIdii3e/ay9IqV9a9rwcfYcSCp+ACLMCa0cKX87+ZQr9Z/YCMWUKnlU3v0
         e8K36PRvIUS+EUnJvTlGyzJqua9QH6M1H0OkBjYrY5qa0hNSd2M/mqKPhkJvSCTH86E1
         tL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mrUdk0EQx8rXBuZgHyQ+dDrC05Jct5VOeEpR9i2rWP4=;
        b=kLw1yOggURyAV+9wId/bp2tr4u9r3wF572VXj8vAY5TC/FVvRumWFFi/+bbe4fR7J4
         GDl8hkkADs4PRQ7CqgDhm7bdF0AZO4RbdoIbvys8Q0O9pLadWZTwQl3lKFGsrLyndn0/
         YdU8UPvvrYFjWoSu3EDMzruk1mFo58N5SxrLl0I64tHgctkY14+5lkdXof4Z9I6eDknc
         zSqnSPhcEHbsEYCRyZTJkTJN+C+7oSDO3RoPCw4PAXtynL8DV+fzgH1iK2catUBMQfSW
         329pXbeCb06NVDhqrDw8c8otP0BEsVWl82TzR5a35rz4eBD/znJOjNmKf5f1qsYZPRKe
         cfRw==
X-Gm-Message-State: AOAM531Ewkip3NoUHt18XI+zymFToEHPG2yu765Y7Rj9BzBydeuY0AaJ
        xGtABl58DdcmfPiGNhSsdmw=
X-Google-Smtp-Source: ABdhPJweKdrIMoFJvDyevFmQXhVJqD13GkgLD8mXTqx6kFrqXRh+S6d090eDA6bZ3vHXOW9jTHysgQ==
X-Received: by 2002:a4a:94e2:: with SMTP id l31mr10510877ooi.62.1627308626377;
        Mon, 26 Jul 2021 07:10:26 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:8509:d58a:ff00:9b31? ([2600:1700:e72:80a0:8509:d58a:ff00:9b31])
        by smtp.gmail.com with ESMTPSA id a83sm7249649oii.13.2021.07.26.07.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 07:10:25 -0700 (PDT)
Subject: Re: [PATCH 1/5] t1092: test merge conflicts outside cone
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
 <a763a7d15b8e92dec61c1fa328ecb647b6f61682.1626901619.git.gitgitgadget@gmail.com>
 <CABPp-BF-UVZKWmsohjCzRLpbHZii+1g=SShEYg_cwScsOHi=5g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ced1c678-225b-c915-d019-f9ebfb3898b6@gmail.com>
Date:   Mon, 26 Jul 2021 10:10:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BF-UVZKWmsohjCzRLpbHZii+1g=SShEYg_cwScsOHi=5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2021 1:34 PM, Elijah Newren wrote:
> On Wed, Jul 21, 2021 at 2:07 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>

...

>> +       # 3. rename the file to another sparse filename
> 
> But...that doesn't resolve the conflict.  Shouldn't this be titled
> "accept the conflict & rename the file elsewhere"?

Sure. I'm less focused on the content of the file and more the steps
the user might have taken to resolve the conflict.
 
>> +       run_on_all mv folder2/a folder2/z &&
>> +       test_all_match git add folder2 &&
> 
> 'mv' rather than 'git mv', then followed by 'git add'?  Any reason for
> this order rather than git add followed by git mv?

I'm trying to mimic that a user might realize that a filename might
need to be renamed (say, because a naming convention changed that is
causing the conflict) and I don't expect users to use 'git mv' to do
this action.

> Also, if you really do want to move first, did you use mv instead of
> "git mv" due to the latter's shortcoming of only operating on stage 0?
> (https://lore.kernel.org/git/CABPp-BGJdwpwhQUp4Wa4bKBp4hQFB9OM3N1FXH7SzY0mvLDa7Q@mail.gmail.com/)

'git mv' had not occurred to me as a thing to do in this case. I'm
focused on ensuring that 'git add' works as expected to update the
index in response to filesystem changes.

> Regardless of order, though, I still think mv or add should require a
> --force to rename or add a file outside the sparsity paths given the
> deferred negative surprises for users around such files.  (Or come up
> with a solid way to remove those surprises.)

--force is focused on _ignored_ files. I imagine that it could be
repurposed to allow entries outside of the sparse-checkout definition,
but we would want to be careful for users who are adding the entire
directory, not just the individual files, as they might _also_ get any
ignored files that exist in that directory. That might justify creating
a new option instead.

Further, the error message reported when adding something outside of
the sparse cone should probably mention whatever option exists as a
way for users to bypass this limitation. I'll collect my thoughts (in
response to your detailed thoughts shared on my cover letter) and
start a new thread about hardening this behavior. I've got an internal
ticket tracking this, and I want to wrap my head around all of the
interesting commands (add, mv, rm, update-index?) and create a full
recommendation to bring as an RFC.

Of course, if someone else wants to create this clear vision in the
meantime I will not complain.

Thanks,
-Stolee
