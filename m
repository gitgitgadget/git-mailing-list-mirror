Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD49EECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 16:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiIIQ4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 12:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIIQ4U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 12:56:20 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750A7F653D
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 09:56:19 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id g11-20020a17090a4b0b00b001fb5f1e195fso1091759pjh.6
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=HiwRV9tk6zCfbl2HmoQ+MkArZYAXJ3F51X8xCFmfY8A=;
        b=mb1NKqQQ0ZIt+FD1N8bFOOHzd3u3ECZuwID1Qc2wh0lrRVU7PXzomCi/g9hXPtZbhx
         oDd18pPRcmdVA0DNO/N55uSdl8XtJr6G+lfsFLo7XLFT2NG/3Kxz7bLAkMzRHazJmrSd
         /YzF8xUJUZw9k9UgGnsdMsL1iLJRKEZnLN3UsQAjmEx91rDglCmObjjblsaTGROf++oE
         +2YFM5shF/SU3TIqs098Z5tCnpePAjdnKp1g8ruVGL5oi5u3SFhfd4Y3wgw+7jpMqpm4
         oaniGG340ccd05WXa2JcTz0oJYSgFhe7Nc3Jp8JtOwQUwElYdeuJIqUHkS3WQ+sQc162
         /mMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=HiwRV9tk6zCfbl2HmoQ+MkArZYAXJ3F51X8xCFmfY8A=;
        b=s4nZNlnwKDS/4ZLAgRMaPg82LkM1LrVHbE7YM4vccMQea49e5FzJeQTmjBDn1tPnCj
         i/iEr9YlwkljSVoNuX0t0sg/B296EyZ9yVzdrmC0zIDH+V97kYjRAyhf18A/usjEZA/B
         H0EWKBpQtLTuDhkaqXSGj/f1bukJnErFZdmkAX3QLZohe0UWO29U2SL4SSWhQlTPYwEx
         Oui8HMHQHD2YQOBjX2f/p5VHi+4qTohs1WdpIGDTztCbpQxUqUWbU0Uldg1U9YwjO1il
         Xpvxz2LgeWAYTiFdqWXns90ieoYeK6bjZwIQ8XzxQY+GYf1Y+gVCUIGCVRenQtp+mHdX
         j6+Q==
X-Gm-Message-State: ACgBeo21QfAoAxGPBcX5eR6vKT+n31aJkZf+qSm7MwsY+/Vbl3+Rf4ZN
        t8uOpkorXn6Ce1bZpfDszIJ6OZhkM3khMg==
X-Google-Smtp-Source: AA6agR5dMxwPhScUx3KR4in6c3fSX/msOb5UlXCXl7VWypgjyKg02R2yBBnSspPtSp/P0BD5AOh1MfKjdhfLBg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:ba01:b0:200:8769:1c34 with SMTP
 id s1-20020a17090aba0100b0020087691c34mr10742287pjr.0.1662742578969; Fri, 09
 Sep 2022 09:56:18 -0700 (PDT)
Date:   Fri, 09 Sep 2022 09:56:17 -0700
In-Reply-To: <xmqqpmg5rehf.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqilm1yp3m.fsf@gitster.g> <kl6ly1uu94ca.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqpmg5rehf.fsf@gitster.g>
Message-ID: <kl6lmtb88p1q.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: What's cooking in git.git (Sep 2022, #01; Mon, 5)
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> * gc/submodule-propagate-branches (2022-08-29) 6 commits
>>>  - clone, submodule update: check out branches
>>>  - submodule--helper: refactor up-to-date criterion
>>>  - submodule: return target of submodule symref
>>>  - t5617: drop references to remote-tracking branches
>>>  - repo-settings: add submodule_propagate_branches
>>>  - clone: teach --detach option
>>>
>>>  "git clone --recurse-submodules" and "git submodule update" learns
>>>  to honor the "propagete branches" option.
>>>
>>>  Needs review.
>>>  source: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
>>
>> I suggest renaming the branch - the config "submodule.propagateBranches"
>> will be used by many more commands in the future, several of which will
>> probably be authored by me :)
>
> OK.  So this is a "clone" and "update" part of the larger topic?

Yup; submodule.propagateBranches is the "branching" part of the
submodule UX work that the Google team is working on.

>> Maybe gc/submodule-update-with-branches? Or
>> gc/recursive-clone-with-branches.
>
> Both sound good suggestions.

Ok, I think gc/recursive-clone-with-branches captures the intent better
(the improvements to `git submodule update` are more of an
implementation detail).

Thanks!
