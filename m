Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96431C7EE2F
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 18:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCASkx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 13:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCASku (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 13:40:50 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117733B3E8
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 10:40:32 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id s22so18909030lfi.9
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 10:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aRaVlI9swcNd1JoZjOq91sX3UYnsCDjbg3ANYJnFMx8=;
        b=YnRe1EYkYTmB7igoJ5DsupnkEG+GsrNXdv/xtVV7xGnkDTwtqswEj7HlRkbLowHUR1
         q6Uvw7tEzhQpatERwV+an/mP70AkrMtzB7A/jXaZwlZS6E/3vlAEvJ6+YwFKAHH8SiwN
         yvUVMRY2B8mWYICgiyoRoWZL7vYwhL36pXaaeydeQtPoyZ0ZXAmGE8DIKqTFgJnxSYFs
         wL2k8kU0T/7o/dC0gARkYJjAua2wfTpzSQ/M4eRGVwPU/rQVLGkKLTYNuaTOuFRJHwxK
         ot05drlHm3GoiBEBgPQLneTCzw6ZW1639zzFFLtymaoazhMrl6OmbQXrA9zbHkx5mN+g
         PrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRaVlI9swcNd1JoZjOq91sX3UYnsCDjbg3ANYJnFMx8=;
        b=FMUCxoFhfCxmroCffCNFUqFEa97EQU4aAqowhq4qOj8VF3jbbfaRQVodhvCpFj2Etf
         0jMiCR28kTTLRTzz+nWnpLeVHlylqf9D3KUuPivAuKwdGfJAEl/hnMj+ROqVPJvwcgcw
         CIDl1tVB1dDWouOazQsnk8M8OatdhW878q9730VTQq5kw20keAq+iXvItkFSEsc0GbSX
         Us9fCgWdiDn/pLV8s2iJ80aeVhKcOuLHN0iy1uRjK6erGuMGEX8sPOwV/tQMX4/kZtmW
         OKnLL0v9lsOSLhmPyKTwMWFxu8VKeQkFkJY84kZ0MhsIkrxjjDgDtLKEfmCYeSOKmcIP
         7UpA==
X-Gm-Message-State: AO0yUKVRyZRj6yXbSfaoP58Y7M4xBb8TVahoO9KVMHfoQJ4YpwBuzqAT
        64E14gaTSfAlKDjfkn7bbI3zQLNW3hk=
X-Google-Smtp-Source: AK7set/Sd+Z8sqrJobsaR7sztAUf/3EvEj0HFjATkBZUPXQrdWUf0VhgKXNhSDiYPrOXlKL5l1ymzQ==
X-Received: by 2002:a05:6512:63:b0:4e1:7dd:1142 with SMTP id i3-20020a056512006300b004e107dd1142mr2022778lfo.51.1677696029815;
        Wed, 01 Mar 2023 10:40:29 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x23-20020ac24897000000b004cb0dd2367fsm1830648lfc.308.2023.03.01.10.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 10:40:29 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2023, #01; Thu, 2)
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
        <xmqqedr28wwb.fsf@gitster.g> <87357ischs.fsf@osv.gnss.ru>
Date:   Wed, 01 Mar 2023 21:40:28 +0300
In-Reply-To: <87357ischs.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        07 Feb 2023 00:35:59 +0300")
Message-ID: <87wn402u3n.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio!

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>
>>>> * so/diff-merges-more (2022-12-18) 5 commits
>>>>  - diff-merges: improve --diff-merges documentation
>>>>  - diff-merges: issue warning on lone '-m' option
>>>>  - diff-merges: support list of values for --diff-merges
>>>>  - diff-merges: implement log.diffMerges-m-imply-p config
>>>>  - diff-merges: implement [no-]hide option and log.diffMergesHide config
>>>>
>>>>  Assorted updates to "--diff-merges=X" option.
>>>>
>>>>  May want to discard.  Breaking compatibility does not seem worth it.
>>>>  source: <20221217132955.108542-1-sorganov@gmail.com>
>>>
>>> Hi Junio,
>>>
>>> This does not break any compatibility, as far as me and I believe
>>> reviewers of these series are aware.
>>
>> The last paragraphs in the review two months ago still describe what
>> this series does fairly accurately, I think.
>>
>>     These patches do look like a good approach to solve the first point
>>     among the "two problems" in the previous round. Thanks for working
>>     on it.
>>
>>     IIRC, the previous round (why is this round marked as v1, by the
>>     way?) was reviewed by some folks, so lets wait to hear from them
>>     how this round does better.
>>
>>     Unfortunately, I do not think of any "solution" that would avoid
>>     breaking folks, if its end goal is to flip the default, either by
>>     hardcoding or with a configuration variable.  IOW, the other one
>>     among the "two problems" in the previous round sounds unsolvable.
>>     We should question if it was really an "issue" worth "resolving",
>>     though.
>
> Well, we may end up flipping or not flipping the default (even though
> I'd prefer we indeed do), the series are still valid either way, as they
> allow *me* (or anybody else who prefers more useful '-m' behavior) to
> flip the switch for myself, locally.
>
> Also, the only patch that got some resistance from reviewers has been
> removed from the series, so I don't see anything left that'd prevent
> this from being merged.
>
> From my POV the only remotely questionable patch is:
>
> - diff-merges: issue warning on lone '-m' option
>
> and I hereby agree to remove it if it feels wrong to you.
>
> Let me state it cleanly: once these are accepted, I'll turn
> log.diffMerges-m-imply-p on for myself, and will suggest it to others
> who already asked about '-m' inconsistency, or will ask in the future.

This is still marked as "probably won't merge" in the recent "what's
cooking". Could it be merged, please?

Thanks,
-- Sergey Organov
