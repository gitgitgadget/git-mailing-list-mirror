Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB212C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJTXxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJTXxI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:53:08 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4ED229E5E
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:53:07 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id j7-20020a170902da8700b0018540711393so482867plx.18
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4awTHI25cgF/KMuChXIKkRIF6pMlnPmivl77ZoPTzfU=;
        b=h+1aYqP07u+lhTKEurq3Irp4B9JKy+VusqDbijnM1RxjVKq/0vSgi8iKEJ4qal02Vr
         8RvGean1IuPacOejkpdWPbVvIsP4ZlCoj5cFDyIFRItsBoJSRMOUVgMZcWXPTp8iZ/2C
         8Nk66R0kzcnL06OmGXuPKxW6Pcxbgg8X0eCre0I3EN4f4GOEn3CGeP+gzrPQC2Zeuk0+
         aMN18bide9DfeebNO6hlEZtqYa01FVk2ocmBF+e1gYzh2ElcKEDu0Cc7DQ66+y84CZu1
         caaje0PFm/g4RgPIyVJzY7hj+0SEVgxAPwlSgVmjvGHqD9I3Inib0Xm4mI7BwrlcOCyN
         TnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4awTHI25cgF/KMuChXIKkRIF6pMlnPmivl77ZoPTzfU=;
        b=I+3XV6JkTg1GaNanKK1+GqRPV+DYI7ZsNjYGWb9US5SgqmhLA2K1HjKBrzXjvGJUQ4
         Wyxtho2zRSlpACyctLlsSXIK1s6Ft19YWw21S/ty15TTRL9OVrsXONf0TAIgz7+kgcN+
         lG4F9mlLBn+1igPfhI870V3Cu4yTCuITrSsmaX1RZlYZHO4d0kzx0pPIiXhz7U7VUb/+
         PYiN0kDD1cRmuhM3EE39JoT3C/hdiPEdqx2awCQjdlnz22pkNwXDRVU2vvJ/SIpAgWnk
         lmmc9UDSDaV2C6dtqfBGsPsYkHQ+Jso/kzbASatVl5dPfNHGdoob/SGSq8Bxr7NT+85U
         vObw==
X-Gm-Message-State: ACrzQf2SijOxtdd3fss/R1jTtkzVUtqIoLctMfo65Xpe7HHPDYnl9blY
        8h7j0D1jgxKJrIouryPSg8BMyij9Qn2f3Q==
X-Google-Smtp-Source: AMsMyM7tBKXab0FbsPyErGnRxAskSZvI7lTR+BUpvICM8vQi+JdibSmTJI0SXj9jB8vq0VT9u8DsDmI1dv1PVw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:9ed2:0:b0:563:276:d858 with SMTP id
 r18-20020aa79ed2000000b005630276d858mr16076808pfq.23.1666309987108; Thu, 20
 Oct 2022 16:53:07 -0700 (PDT)
Date:   Thu, 20 Oct 2022 16:53:05 -0700
In-Reply-To: <xmqqh6zyqftv.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
 <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com> <xmqqh6zyqftv.fsf@gitster.g>
Message-ID: <kl6lh6zyxdb2.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 0/7] clone, submodule update: check out submodule branches
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> = Description
>>
>> This series teaches "git clone --recurse-submodules" and "git submodule
>> update" to understand "submodule.propagateBranches" (see Further Reading for
>> context), i.e. if the superproject has a branch checked out and a submodule
>> is cloned, the submodule will have the same branch checked out.
>>
>> To do this, "git submodule update" checks if ...
>> = Series history
>>
>> Changes in v2:
>>
>>  * The superproject's "submodule.propagateBranches" value is always used,
>>    even if false.
>>  * Branches are now created at clone time (by adding a new flag to "git
>>    submodule clone"), instead of at update time.
>>  * Rebase onto newer master. This got adjusted slightly to incorporate
>>    ab/submodule-helper-leakfix.
>>  * Add more tests to demonstrate edge case behavior.
>>  * Assorted commit message and doc improvements.
>
> As the previous round was more than a month old and is clearly not a
> bugfix but is adding a new feature, I do not mind updating to the
> newer base after a new feature release was made.  There isn't much
> to be gained, other than that we can easily sanity check by running
> "git diff @{1} @{0}" on the branch to compare the iterations, by
> keeping the same base.  We are not going to merge this topic down to
> maintenance tracks after it graduates to 'master' anyway.
>
> But I got curious and tried to adjust these patches back on the
> previous base 07ee72db (Sync with 'maint', 2022-08-26).  It turns
> out that the conflicts needed to be resolved were fairly trivial.
>
> Merging the topic that was recreated on top of the same old base
> into today's 'master' of course needed the same conflict resolution
> but that is something we've been doing every time we rebuild 'seen'
> (read: at least twice a day, but often more).  Applying these
> patches directly on today's 'master' of course produced the
> identical tree as the tree of this trial merge.

Thanks for your patience. For future reference, do you have a preference
either way? I suppose choosing a later base might make it easier for
reviewers who don't have the bandwidth to remember what "master" used to
look like, but it's just churn to you, since you're already rebuilding
"seen".
