Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F14C433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 20:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243533AbiCPU4B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 16:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiCPU4B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 16:56:01 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FDD332
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 13:54:46 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id t184-20020a6281c1000000b004e103c5f726so2352457pfd.8
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 13:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TWjZDerilmXBlFynLYxrIpGJLLG3zghXC6HQ7F7do3A=;
        b=BxUK0N16T1JfC+6nvbJwTLg4nY4KG1Dk1G4bUcZsapu+DXznPAdNxrWrTNDayv8RvV
         tWCt6m9QdCLpRSQDY/7FXklrKoU/RXWOd7K0uULeQTDRLV4GPG0r3EJRqz4GIpgJSnm/
         YPV8+xBTHSoxWlO0+/0et1DUAUExFpvDSQ3ILDt7jnz1tIBX6Ulo2ptQljvZZu/lAvhB
         HBhG09YB7Ob5I76hv+uoBS+Ks4ngVLTYQa9iDNdaHeGf85c3Js/a6aV+IrKFvQoJu1yA
         YvQ9MZDVZOqRIGGKNyXLRfEJSHZR6CX+pB2TxPW8/ZNM3eCNu+no3ZzjNPxAQCXQ4vWo
         Qaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TWjZDerilmXBlFynLYxrIpGJLLG3zghXC6HQ7F7do3A=;
        b=o2CFYn7/43lFptC0DduP1pHqj3w63SzSw8AAUYcJO5i5CgpI0LqbtoSKxb+TXF37zR
         c/6ACHxMgcJPjMi1MHxJw+SboPYVESQqxtrsfJFRD1cbxa0jPSs52eELdtPABTH+P4gq
         7hQEiK9Q6DLmWm/JwldSfI+B5nhZyUPXDoS52DRSzUXWaNc/DauFnoWGLsoEo9dsSNuT
         buyezjT0uzLYE9PKisgGNs28p9p8odum1niEIJ13iYknOIhZYlOoSsKE3v68ES5o+aWf
         uYoMVyQvCZhQIjScH1CAzZ3VtqBMiR/M+ZbcOXLzk4yK18dqyYTjcwWPMuH2jP+bsmRY
         8YEA==
X-Gm-Message-State: AOAM53163VSFsqznI48kN/w1EqzUyKjadk8KefW862m2DJeTfZx6o+0H
        2AeMhHdqMfeCFhQsLN9Om0vPI4T3eGgvhA==
X-Google-Smtp-Source: ABdhPJyDxDFPqwH9kgdv7rWnQXz5mIGBW1KwZFI2HzZ1HIS4a9ZUEeZhoPn6KePoT72NLVngC9yNRMi8Xjz/7A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:e81:b0:1c6:5a9c:5afa with SMTP id
 fv1-20020a17090b0e8100b001c65a9c5afamr154445pjb.1.1647464085800; Wed, 16 Mar
 2022 13:54:45 -0700 (PDT)
Date:   Wed, 16 Mar 2022 13:54:36 -0700
In-Reply-To: <xmqqa6dpllmc.fsf@gitster.g>
Message-Id: <kl6lczillisz.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqq5yogp6xo.fsf@gitster.g> <kl6l5yodyej3.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqa6dpllmc.fsf@gitster.g>
Subject: Re: gc/recursive-fetch-with-unused-submodules (was Re: What's cooking
 in git.git (Mar 2022, #03; Mon, 14))
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
>>> * gc/recursive-fetch-with-unused-submodules (2022-03-07) 10 commits
>>>  - submodule: fix latent check_has_commit() bug
>>>  - fetch: fetch unpopulated, changed submodules
>>>  - submodule: move logic into fetch_task_create()
>>>  - submodule: extract get_fetch_task()
>>>  - submodule: store new submodule commits oid_array in a struct
>>>  - submodule: inline submodule_commits() into caller
>>>  - submodule: make static functions read submodules from commits
>>>  - t5526: create superproject commits with test helper
>>>  - t5526: stop asserting on stderr literally
>>>  - t5526: introduce test helper to assert on fetches
>>>
>>>  When "git fetch --recurse-submodules" grabbed submodule commits
>>>  that would be needed to recursively check out newly fetched commits
>>>  in the superproject, it only paid attention to submodules that are
>>>  in the current checkout of the superproject.  We now do so for all
>>>  submodules that have been run "git submodule init" on.
>>>
>>>  Expecting a reroll.
>>>  cf. <kl6ly21p2q00.fsf@chooglen-macbookpro.roam.corp.google.com>
>>>  source: <20220308001433.94995-1-chooglen@google.com>
>>
>> Is 'Expecting a reroll.' accurate? <xmqqr17dp8s9.fsf@gitster.g>
>> indicated that this topic would be queued.
>
> "Queuing" is just that.  It may stay there for a while and be
> dropped unless it sees a decent progress (if it is expected to be
> further worked on).  That's vastly different from merging down to
> 'next'.
>
> I just re-read the message with "will queue" in it, and I only said
> the changes listed as updates from v4 looked all sensible, which
> does not mean the changes listed there are sufficient to correct all
> problems we may already had in v3.
>
> Downthread in <xmqq4k46nae4.fsf@gitster.g> and its response, I see
> we agree that "reading .gitmodules in a particular superproject
> commit is just as wrong as reading from the working tree---it should
> not be necessary to fetch in the submodule, and the API to get the
> necessary parameter to run fetch in the submodule should be cleaned
> up" and that "fixing that API can be left outside the scope of this
> topic for the sake of expediency".  I would at least expect the two
> decisions are described in an updated log message of relevant steps.

Thanks, that's really helpful :)
I'll address next steps on that thread.
