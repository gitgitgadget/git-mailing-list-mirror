Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6622FC433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5002D60ED4
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbhJMFda (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 01:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237705AbhJMFd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 01:33:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B046CC061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:31:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id om14so1287198pjb.5
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=2oP+USo1L8AyvrGlQQ+Fv+z8rUILzVDiwzUYQryYsWc=;
        b=Xfwf3/VIh+XfYI/O7l4Uxo5NPe6EIPmTIaq74d5rMaYLU3/ushqEJPKeYBWpG61o1Z
         SMf6wEPG8aVWWvD84F/T/H4raD0fotBFtxNXBIN3oVD74aYSvKfXk70WnZErjXWdasTX
         JtoGkFVcwwGv9d0RL5tgu6o0kdOkglOGY9XFEjsPNhlLtgh49sqXvGlzZpOfPGHXFsZB
         hLi93PLY+PBrBGEKcxAMX5C+wvly8NJAY5xaWpL30oibvpq/++TEJRg6WT/EbFg4eei1
         ksF2jO6sr478PrUPhLKWjdJXcMfTyOcrKmV2+bOYInKzFAooNq0mZFncPet/z4yhn8+p
         FQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=2oP+USo1L8AyvrGlQQ+Fv+z8rUILzVDiwzUYQryYsWc=;
        b=YUau0FF9W9cXCMxCn7guSoas/pUue7SP4UrzMe5Ty+iDin4Vt1MnfGXkXlLKKD3f6J
         tIT1GHjXu1KPdubqLRQf3aXJ/Ba4rYyxOTI8gmzmmo+iFzcSqofcEWOUaZIXdvx2Tmfd
         gOWws485FZXPTsEK97qZxdMe/VJEp2uM6SNM5bQTHnPZ6O1Od84fvvkCrVGsQINXCQd4
         BCqxJ9RQPdNBwHVJOx6wpMqmUzK71blB7OpiWHwjgOBJKDmzyhVw1u5IqHT65LOaL0Rs
         QCDiKlnquN1Y2W30KbPOwCNB9Ehg737NK9E+La/uaDkALZwnxIoom55x9JuXfc35hw8/
         lhVw==
X-Gm-Message-State: AOAM530qcAuLBisy6yMVqdyxgjTgekN/2c9eRo95AgdWZwH5aONO8QJw
        jVW6FAnVMMAao5vB9aG6Q1k=
X-Google-Smtp-Source: ABdhPJxUZuIrm/MKPEE6E8L2NuGTg0SqzzCghByfGqy+s7RHz/omX0f5IBgpEKEY0yMy5LQppHRseQ==
X-Received: by 2002:a17:903:1c7:b0:13e:d05b:ed09 with SMTP id e7-20020a17090301c700b0013ed05bed09mr33656198plh.52.1634103085103;
        Tue, 12 Oct 2021 22:31:25 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.111])
        by smtp.gmail.com with ESMTPSA id 17sm13767353pgr.10.2021.10.12.22.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 22:31:24 -0700 (PDT)
References: <xmqqv9239k15.fsf@gitster.g> <YWYHCnpPnrjwTjhA@google.com>
User-agent: mu4e 1.6.3; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        gitscale@google.com
Subject: Re: Submodules UX overhaul update (was: What's cooking in git.git
 (Oct 2021, #03; Mon, 11))
Date:   Wed, 13 Oct 2021 10:50:23 +0530
In-reply-to: <YWYHCnpPnrjwTjhA@google.com>
Message-ID: <m2h7dlij88.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Emily Shaffer <emilyshaffer@google.com> writes:

> As I promised in IRC yesterday, here's an attempt to filter this into a
> submodules newsletter of sorts.
>
> For context on the broader submodules effort I'm discussing in this
> note, please see the design doc:
> https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/
>
> I'm aware there are other submodule efforts ongoing too, but in this
> letter I've highlighted ones that are necessary for the above-linked
> design doc. Selfish, I know. ;)
>
> On Mon, Oct 11, 2021 at 05:14:14PM -0700, Junio C Hamano wrote:
>> [Stalled]
>>
>> * ar/submodule-update (2021-09-20) 8 commits
>>  . submodule--helper: rename helper functions
>>  . submodule--helper: remove unused helpers
>>  . submodule--helper: remove update-clone subcommand
>>  . submodule: move core cmd_update() logic to C
>>  . submodule--helper: refactor get_submodule_displaypath()
>>  . submodule--helper: rename helpers for update-clone
>>  . submodule--helper: get remote names from any repository
>>  . submodule--helper: split up ensure_core_worktree()
>>
>>  Rewrite of "git submodule update" in C.
>>
>>  Kicked out of 'seen' to make room for es/superproject-aware-submodules
>>  which is among the topics this topic stomps on.
>
> Mentioning this series in the "newsletter" since I'm aware that I'm
> blocking it with es/superproject-aware-submodules. I have it open in
> another tab as I type and plan to send a reroll today or tomorrow.

I am not sure if this will be helpful or not, but today I sent a reroll
of my topic, and while I was at it, I tried to reapply your series and
my series on the up-to-date master to see where conflicts appear. I have
written a note about it in my cover letter [1]. I hope it can be helpful
in some way!

[1] https://lore.kernel.org/git/20211013051805.45662-1-raykar.ath@gmail.com/
