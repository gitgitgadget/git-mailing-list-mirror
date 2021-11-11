Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BB2C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 23:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E78C961267
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 23:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhKKXrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 18:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbhKKXrI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 18:47:08 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB11C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 15:44:18 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g190-20020a25dbc7000000b005c21574c704so11630838ybf.13
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 15:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OFNM9Kdp5XyvnEK8jJwCr1+wKXEjG189xCLE6zCUY+c=;
        b=qzFY0Tffv8ip2Do4hCYnFUyy6aPtedMd0GxmYQbTLf/TEcsUya4kzf3/txHHBqojAz
         0kcARiqAS4c5UC9F5Akg6ljX96ieh/8MR6BampBX4339wTu2a1qRsnO0p9YitEsqS6m8
         b4Uxx0uTL3Vbv9XFg+s0td566F074aIf4NL9TnVb2rsIRbMlhRpUtfWwqZ3sGAjy9buB
         rbFuqnGrvYlA3Q8YwFHF87Xj2ZMZcjC/reqx0ftQOma25Ibo4v/mzD600r7wL4TxlMWx
         cYhnIT3FKaHNtglXQ5FhrERFp0yPkviAd/DCjf21iL6b02L+A2MBOQJmLMlLwzu5olHy
         +aiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OFNM9Kdp5XyvnEK8jJwCr1+wKXEjG189xCLE6zCUY+c=;
        b=tMv/djw/JhLsywLBX0BdTGMVo77u3QTs0d8ulNVS4Ic6Xq+TSoA9xFHUyHn78syecL
         pD0zv9yS1XA5qGkc50IenyftZmcENnFJEAZyElq7Yav89yUGctEMncEEFIy6c79p0qnP
         FOyw/pPdixK1UnCWUT2MB7r7FuL7KU9ANy7xYiQxWjkaKPxnKsyGiA7hKw59j9pWUkgW
         BkbPecDZRt/N0mLDrWbS3MDEu9pTHW5yOk2WEKqhSPLeCcXG/nDWpb1wPSPno0Pc/0hq
         bKmg2MDDIhUIeR5EeIBGHUNIUezOimspEnFiLvAEEs4G2xxdSHbYUJjL7AMJsWHEHtjF
         AB3A==
X-Gm-Message-State: AOAM530CapiLepU3IjZBGnoT7cEh3CwimKbq/NseMpeHGIlwYp4B3bGY
        2Z2lI1oTyhDUvXP0cebxIW6YkuEFd5bz9Q==
X-Google-Smtp-Source: ABdhPJxz6RNR8C2qssq9SBcmRx35Fv7yTpQEhUGg2snRWg9ezN+MYBfkkQOpimrynxRMh4TsOw+76rO4MTtDjA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:e90a:: with SMTP id
 n10mr12073786ybd.180.1636674257570; Thu, 11 Nov 2021 15:44:17 -0800 (PST)
Date:   Thu, 11 Nov 2021 15:44:08 -0800
In-Reply-To: <xmqqlf1ujo4g.fsf@gitster.g>
Message-Id: <kl6l1r3muuk7.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqqy25wygek.fsf@gitster.g> <YY2W6ESIxSz9lakK@google.com> <xmqqlf1ujo4g.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Nov 2021, #03; Tue, 9)
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Emily Shaffer <emilyshaffer@google.com> writes:
>
>>> * gc/remote-with-fewer-static-global-variables (2021-10-28) 6 commits
>>>  - remote: add struct repository parameter to external functions
>>>  - remote: die if branch is not found in repository
>>>  - remote: remove the_repository->remote_state from static methods
>>>  - remote: use remote_state parameter internally
>>>  - remote: move static variables into per-repository struct
>>>  - t5516: add test case for pushing remote refspecs
>>> 
>>>  Code clean-up to eventually allow information on remotes defined
>>>  for an arbitrary repository to be read.
>>> 
>>>  Will merge to 'next'?
>>
>> What's still blocking this from being merged? Anything? Release
>> schedule?
>
> I do not think I saw anybody giving sufficient review on any
> previous rounds or the latest round.  I did read some part and
> commented on earlier rounds, during the -rc period, I don't have
> enough concentration to judge a new design properly myself.
>
> So, in short, these patches are unreviewed yet, if I am not
> mistaken.

Thanks for clarifying, Emily and I were under the impression that this
would be merged soon. I'll ask for more reviews.
