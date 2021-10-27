Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9983BC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 17:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 815C560ED4
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 17:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243403AbhJ0SCC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 14:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243393AbhJ0SBv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 14:01:51 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED946C0613B9
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 10:59:25 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id v14-20020a170902e8ce00b0013fcb85c0ebso1564697plg.22
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PnFIxPMrnCrNAAMdwDnpnktmIBa/V10bZwlrRdHthrg=;
        b=heA1Lp3GV7LpRZoJRIIqJUxpVLC1XhzG3vE/ZTERtxHoPdsqtMyEWb9Vu9jsoJ4iyL
         s/g+sf1qdt/NIOWixdmnD7iA2Gr0wNP+I6HeLBBKmc+NF5ahF89QCfXVJ8Vfsr7ZhTyc
         DZn5xeW1TjbZ7tXzxLDruf4ktHYxjLf9v1ROS6iZcHWhOHTJ3fWVXQDRhEhkuPp8Kop2
         QQMbmRu+0As4vg0Kh1sCKGE05mRelJWfgm6NPllBoR4B1fIBvvJnIYdNLV2Jtoq9PRDy
         y9YKrufZH7gFsFRhqK2z7fphYnC/JXfqnzKyGuU6mLWVsBQeNnj4qFFPdrL7mXG/Fv+Q
         7cBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PnFIxPMrnCrNAAMdwDnpnktmIBa/V10bZwlrRdHthrg=;
        b=xSF5VNX4S8RaB3RmPJXBeiJFKP82rrdP7dimRd8wXl+mMYyXudMOZ2qMhdFWShdPcI
         LPIhZijdj6aVCF2ZQsxioKF3wPcpbKK46VHcWGVdUuSPK7oxnyicUY7IDEeXXItlI1Fm
         hdZbNRe1jSbkhCe5zjSgmBH+PgIeSoV++7B4xrJEL6IGrSapshMlGiESShE2/YyChvGL
         WthiRIIeq5Uw6J8ssSPnaBy6aZn4YWTYEATPMSFu1sZVzipIO6VRGOQUrXZhAz78anWB
         PVqaEj7jTHvnh3gLyYbxJMdLBuZKyf0Jep/OMTyC312jYBfCn3sV6BdTn1SDhC9x1gh/
         W8RA==
X-Gm-Message-State: AOAM531RrgZOPLvzLRiVWz3SFw5nulUFMmeNgKd1+TDUQN83ebP/7k4c
        Kw1zN2P7/l2zyoTjh8BcRJAqOZMP6aWVCw==
X-Google-Smtp-Source: ABdhPJzDYwrVR6U2mBjdtfToNatf6fNIiCo0r2vhoplHd4gsV7Tmb/jwsJFgjJGWneJJFkjhMPf+4b/e8pK8zw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1b4c:: with SMTP id
 nv12mr7221105pjb.157.1635357565428; Wed, 27 Oct 2021 10:59:25 -0700 (PDT)
Date:   Wed, 27 Oct 2021 10:59:22 -0700
In-Reply-To: <xmqq8ryfxkuj.fsf@gitster.g>
Message-Id: <kl6l35om9wn9.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lbl3c7lsa.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqfssozk8r.fsf@gitster.g> <xmqqbl3czik5.fsf@gitster.g> <kl6l7ddz7m54.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq8ryfxkuj.fsf@gitster.g>
Subject: Re: [PATCH v3 2/4] remote: use remote_state parameter internally
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
>>>> c) Replace the backpointer with a remote_state parameter. Expressive and
>>>>    fits the paradigm of "defaulting to the repo when needed", but
>>>>    interfaces are repetitive and shifts the responsibility of
>>>>    correctness to the caller (see v2).
> Hopefully.  Of course I think the implementation of the safety would
> actually be done, not by iterationg over branches[] array, but just
> checking branch->remote_state == remote_state pointer equality.

With (c), I plan to eliminate the backpointer altogether, so such a
check is not possible. However, I plan to add a branches_hash to
remote_state in the same way that we have remotes_hash for remote_state.

>> This "longer term direction" sounds like what I envisioned with (e). I
>> agree that detached HEAD is a state that should be expressed with more
>> than just NULL, though I'm not sure that "struct branch" is the correct
>> abstraction. No point bikeshedding now of course, we'll cross that
>> bridge when we get there ;)
>
> I actually was hoping that the time to cross the bridge was now,
> though ;-)

Hm, well I don't want to get too lost in the weeds here and lose sight
of the short-term objective. I have a few strands of thought, but
nothing concrete enough to propose a full alternative:

- It seems odd that the branches and the "current_branch" are handled by
  the remotes system, perhaps it would be clearer to move it elsewhere.
  Separating branches from "branch remote-tracking configuration" might
  clarify our thinking.
- branch_get(NULL) and branch_get("HEAD") are not entirely coherent with
  the idea of "getting a branch by name", perhaps we should just move
  this functionality into a different function.
- Similarly, variants of remote_for_branch() are misleading because they
  behave inconsistently when branch is NULL. 

I might not want to take action on these ideas though, e.g.
branch_get("HEAD") or remote_for_branch(NULL) are very convenient for
callers even though they behave slightly inconsisently. I'll propose a
longer term direction when I have a better grasp of the system and the
tradeoffs.
