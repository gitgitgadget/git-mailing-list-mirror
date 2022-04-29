Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAE9C4332F
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 20:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380941AbiD2Ulb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 16:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380891AbiD2UlN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 16:41:13 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9647CEE1C
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 13:37:41 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x4-20020a1709028ec400b0015e84d42eaaso805613plo.7
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 13:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/B5rdXHkRxEQOiSOHQZOSJGb5+/b0RIOujHAZTKZj6Q=;
        b=NiOwLxaXKDekJoPUjq8muCYZAOLG38gI2+Fb6ge1ydXC51kCQ/gurZhIQVpAXhE1o9
         3kMefHTKamjg04AHUv+XSDjZ3V8DULm2IjLebJgO+FL+EQYcazaFFbus+9Y/0a0V3VRM
         SdjKcgz1/mly1n+/pp3u794jTgODTcBQM1mc+7f/zKrWIHwCHaK0lmFpEa0rg4jGKipK
         Gd4+l/GL/mr4IjgsYFuU8S+ccR7wUIK/tp8r3s97yNFQBCrGMl2kwK1W0VolbgAiUXme
         tFGlimR9nAyyicY7JDl5WmIxOwTzThb87j3xEN1UpgRB9DBJKwSmmbLqYH5TfY/jHTwV
         R04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/B5rdXHkRxEQOiSOHQZOSJGb5+/b0RIOujHAZTKZj6Q=;
        b=CSnGC2XDD0AOpuL+wJYz0uvfhS86vulHmjbpO83yRegpFUcP+e1sL8z+XZ174J1U/O
         1NEw1YDZvVwWTXv1ET6O1LVQgSfQkaFSCJCXki7skapbmI1qpRXpyAv7AjCEhjWAL7t6
         cnhD8Y6rpfCeFDVBRwZH9Z18ln4nfVcAI2XO98wtHzzF2StLJh9LU4MhvaoG+sEmeH+r
         jkxflPC9MvdRq72YFcDDAgV9AXNBM5ySf1AHOIHQ/wVjBd+jmGIytV1pU0fRr3RnRztz
         gXastP/joOEF2xuvUmlO/yLWhh7Tn0mrrXU8fLtGW9DWe9ED7FkCpRxeTjUU6OOGtRqm
         XUIQ==
X-Gm-Message-State: AOAM532n4usOxK/MyuLDRqIQLPfX6AAlvUzicO7i0N2PAPnk9aMr3KZQ
        yX5GNVN6hiv7yD8zBdQZo/dVjrnrOzsQNg==
X-Google-Smtp-Source: ABdhPJyfN5y0iCro4hr9EiluvvoN4Y62K7gVVpUHKUBnQgFDtYhj1o1tt6ucL1aDKE1Rxrpg9+EJfIVdOnbuYg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:a58d:b0:1db:ed34:e46d with SMTP
 id b13-20020a17090aa58d00b001dbed34e46dmr5827246pjq.124.1651264661382; Fri,
 29 Apr 2022 13:37:41 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:37:32 -0700
In-Reply-To: <xmqq1qxfbqtq.fsf@gitster.g>
Message-Id: <kl6l1qxfpqwj.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <CAN8jHOgwVF5g=jM_KYT0Oh+j+Lk3qvdyA4zNRbzf8e1Xp5WAUw@mail.gmail.com>
 <xmqqczgzdc1r.fsf@gitster.g> <kl6l4k2bpv61.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq1qxfbqtq.fsf@gitster.g>
Subject: Re: Bugreport - submodules are fetched twice in some cases
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Benedek Kozma <cyberbeni@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> A simple and concrete reproduction 
>>>
>>>     git init top
>>>     cd top
>>>     date >file1
>>>     git init sub
>>>     cd sub
>>>     date >subfile1
>>>     git add .
>>>     git commit -m subinitial
>>>     cd .. ;# back to top
>>>     git submodule add ./sub sub
>>>     git add file1
>>>     git commit -m initial
>>>     cd .. ;# out of top
>>>     git clone --recurse-submodules top copy
>>>     cd copy
>>>     git config submodule.recurse true
>>>     git config fetch.parallel 0
>>>     GIT_TRACE2=$(pwd)/trace git fetch --all --prune --prune-tags
>>>
>>> This throws the three lines to the output.
>>>
>>> Fetching origin
>>> Fetching submodule sub
>>> Fetching submodule sub
>>>
>>> The two "Fetching submodule" messages are coming from two separate
>>> calls to get_fetch_task_from_index(), and the trace does show that
>>> the code is doing "git-upload-pack" three times (one for the top
>>> level, twice for the same top/sub).  We can see it by grepping
>>> for "git-upload-pack" in the resulting 'trace' file above.
>>
>>  
>> Thanks for the reproduction recipe and findings, that'll be very helpful
>> :)
>>
>>> Glen, as submodule.c::fetch_submodules() was created in your heavy
>>> refactoring quite recently, I thought I'd redirect this report in
>>> your direction, as I expect you'd be the most clueful in this area
>>> ;-)
>>
>> Hm, this does look like something that I probably introduced. But even
>> if it turns out to be older than that, I think I am the right person to
>> fix it, yes.
>
> It seems that ever since the introduction of the --prune-tags option
> at v2.16.1-16-g97716d217c (fetch: add a --prune-tags option and
> fetch.pruneTags config, 2018-02-09), we always behaved this way.
>
> Without "--prune-tags" (but still with "--prune"), we can go even
> older than that version, and v2.10.0 seems to fetch only once.
>
> And the command keeps working that way all the way back to the
> commit that starts honoring submodule.recurse configuration, at
> v2.13.0-137-g58f4203e7d (builtin/fetch.c: respect
> 'submodule.recurse' option, 2017-05-31)
>
> If we instead use "git fetch --recurse-submodules" with versions
> of GIt older than that, we can go even older.  I saw v2.5.0 behaves
> that way before I got tired and gave up.
>
> So, we still would want to eventually get to it, but no rush.  This
> is an old thing and not as urgent as fixing a recent regression.

Ah, thanks a lot for investigating even further. I'll still take a look
when I can, though this alleviates the time pressure a lot :)
