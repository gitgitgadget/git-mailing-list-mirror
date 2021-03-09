Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD421C433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5366764FAD
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 21:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhCIVkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbhCIVj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 16:39:58 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71FBC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 13:39:57 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id t16so14321850ott.3
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 13:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RtNC7Sx1gGrZQZpdD/EH7m5Qk11p90FeP/YiYOjVYdg=;
        b=TZ1WnjvwDltTSmvBtEz9PgUaLil7QF7XHiLwzJicTU8rmlup/qgEc28qofl8gEx0I2
         VSwSSTacYsGE85r8ueE/hx4FqK8oVXLtbDQflJ1K8G0cGI2P2t/rTKa5Rotb6hxAIUAk
         /aL2zDpk6UyWpB9PndmHxSDUPIsSsNAJxx2Rn04hbJ7aFu7RugoxmBjUUYFF6QljpADe
         De0HbBXwjGOgqkzhf33jL8mmZ3u7UG0dtkO1slnwiSsx6QnnjkALq+MdP3eFkXVk9o6k
         a+bL86pGSG7n55eCdpOHEcqqPUsG8sbnWTkdtRcXA1PBMcyEjRcqthsixgh57u/LQl87
         KjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtNC7Sx1gGrZQZpdD/EH7m5Qk11p90FeP/YiYOjVYdg=;
        b=sAEnA5lqlEcdeO00IIgGr8Jb1I1QsmvMc+L9mC5cN7TWIj3Llw/ZVZgfmbTDXZzmas
         O02d6eFe8oYOagJwAtdeC2yfTwh8R+h35Ivty89ssX53elcWHIqnTBIhqA3JB1mBTyNC
         J40moB5C1ZHQS1mtfw2aolgyf15wKCn0opS+8CUy5K7K41+W5CyK9RFMKh8Zi5hUKJbD
         C99mKA4+PqV91cDBR5J60dW1KQlxLEpw7VqxYYwqSWexzw5tbX3DrwiMkNRLOt9eDQgS
         kGD42rFxz+v3nbYTr1jofSWJvfJpn5IUCw9nL9HltCRLq0ncbH2jTqb0k6jJOhXP2IQA
         5juA==
X-Gm-Message-State: AOAM533T1RGCC0lqrSO/WrnznHIUgk3BgKj1aaQiJEs813OIrT46GtHh
        BNPZ8zhFlgkUJBEEwSh5yYAcZ1L3l1yS4uoBCcc=
X-Google-Smtp-Source: ABdhPJyegZrQN2qnvATOJR+2LVnofikwkjTBU0mpRf45Sl3CmEU38zIHHSSXrLUU6u00C/D0IxHrqhjDAsLEw5S09ks=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr125133otf.345.1615325997402;
 Tue, 09 Mar 2021 13:39:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <fda23f07e6a20408b0a10c8944d54e7c65a1d629.1614111270.git.gitgitgadget@gmail.com>
 <CABPp-BEMNavqAEG54VYkZvSiJ4=X3vZUXsubCmFfk3yxUWOjXQ@mail.gmail.com> <4d5d12e9-cd14-c195-b267-0e130109f1e0@gmail.com>
In-Reply-To: <4d5d12e9-cd14-c195-b267-0e130109f1e0@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 13:39:46 -0800
Message-ID: <CABPp-BFu2N33MDeHXx-JogjQwRpOSqrx41L5cB1OAyLBT8zm9w@mail.gmail.com>
Subject: Re: [PATCH 13/20] unpack-trees: allow sparse directories
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 9, 2021 at 1:35 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/25/2021 2:40 AM, Elijah Newren wrote:
> > On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >>
> >> The index_pos_by_traverse_info() currently throws a BUG() when a
> >> directory entry exists exactly in the index. We need to consider that it
> >> is possible to have a directory in a sparse index as long as that entry
> >> is itself marked with the skip-worktree bit.
> >>
> >> The negation of the 'pos' variable must be conditioned to only when it
> >> starts as negative. This is identical behavior as before when the index
> >> is full.
> >
> > Same comment on the second paragraph as I made in the RFC series --
> > https://lore.kernel.org/git/CABPp-BGPJgA4guWHVm3AVS=hM0fTixUpRvJe5i9NnHT-3QJMfw@mail.gmail.com/.
> > I apologize if I'm repeating stuff you chose to not change, but I
> > didn't see a response and given the three typos left in previous
> > patches, I'm unsure whether it was unaddressed on purpose or on
> > accident.
>
> Yes, I dropped this one. How about this?
>
>     The 'pos' variable is assigned a negative value if an exact match is not
>     found. Since a directory name can be an exact match, it is no longer an
>     error to have a nonnegative 'pos' value.

I like it!
