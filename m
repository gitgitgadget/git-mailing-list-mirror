Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3300C43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 19:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346091AbiFMTEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349491AbiFMTEC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 15:04:02 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404134C410
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 09:52:24 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x1-20020a170902ec8100b0016634ff72a4so3339481plg.15
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rN8/KYd4jiLv/eok4yFw4dKFh+R79fWxYgInG9/dSKY=;
        b=N52hywWpEcT/+yYMVNGUJTA1Zbgg3/zfi7n31wKQ1V/bIJkfWSjjKCxyTj23CbnvWm
         /N5cyDs+wK2Ei+EY/W0kMKFgDQmIHjm5/9V/k03waGyJCqV9iVxPsxyLUpsWP6aVysHQ
         X+eODa9YxUnrEs1jj01vhjN9zsrGMExGOV/2RjY3d4V8LZOX/LsPsprci9VgpSiKMi1i
         lgIzgsRt+h+FvF47cK7LGvVWSt7F6B08GbfVGchFr3EfskLfXo455fSgL3pJbEgKRF28
         LYKnoq3RV5cQTIusXfI1Oqn+jN5AC2viRBELVLBr4DhCXp/Fv/yVZZecRVJ1Bh8NTgDi
         vlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rN8/KYd4jiLv/eok4yFw4dKFh+R79fWxYgInG9/dSKY=;
        b=0pSxXcY0fmk7o3vVSCoa79sfBLuhjxIHeE9p8UiTMVKOUv1kCeLl5qMr8XUePf2PDi
         wwIhMFJfAeHpmWcX1aGwHPCEcd5DIVqnuoE3MOLmQhRn22KjHZxCIESmSOaQQYZH20Nf
         5/88T8QgEL9HNo7jNaicrM4/oaq21zjM+Aa5AIp2JinxjQTQb4jU/4L6b+DcKlnuUDdr
         db70R0DFXRGhIYmzuEm/sOXkenise7PGrp8kv6tsDClT4IFXZD4M+hpcCZfC8MGjOn0S
         ycvJZ50p96dFBeefig2cjd2eCXuLtafchZooBFDUTaCAI+p68ppaqwtEiMtfrT5tpPYu
         ByQQ==
X-Gm-Message-State: AOAM532XNtX9mnsuv9lmdRFLb9i3aVIVNsmqCJExsEK3r3AP95SwR8gZ
        bYJqwvCmHbSZpyGxukiLUVmCPcycE4LmtQ==
X-Google-Smtp-Source: AGRyM1v7ARg9lIIGBnfpSCEUP65neLbsvmbIK8Ne6Z8OoHg1sCJO9tl7zOIKVgHvJX456B3w+hD88Q26uqOJvw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d4d0:b0:163:d4dc:bff8 with SMTP
 id o16-20020a170902d4d000b00163d4dcbff8mr22764plg.129.1655139143670; Mon, 13
 Jun 2022 09:52:23 -0700 (PDT)
Date:   Mon, 13 Jun 2022 09:52:21 -0700
In-Reply-To: <CABPp-BEXdfEw5jYn-WM_pyEyS5AHmYEJhVNS8GtHAd2BXCaB_A@mail.gmail.com>
Message-Id: <kl6l35g87bga.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lee006mle.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BEW2WF5AJeKqCiL2zhcPwPH-u6p=myoX_GkU6tbV=+TZA@mail.gmail.com>
 <xmqqczfgfojb.fsf@gitster.g> <CABPp-BEXdfEw5jYn-WM_pyEyS5AHmYEJhVNS8GtHAd2BXCaB_A@mail.gmail.com>
Subject: Re: Bug in merge-ort (rename detection can have collisions?)
From:   Glen Choo <chooglen@google.com>
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks Elijah, your explanation is really great :)
This looks like a pretty nasty bug. Ugh..

Elijah Newren <newren@gmail.com> writes:

> On Fri, Jun 10, 2022 at 9:53 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Tue, Jun 7, 2022 at 5:11 PM Glen Choo <chooglen@google.com> wrote:
>> >>
>> >> (I'm not 100% what the bug _is_, only that there is one.)
>> >>
>> >> = Report
>> >>
>> >> At $DAYJOB, there was a report that "git merge" was failing on certain
>> >> branches. Fortunately, the repo is publicly accessible, so I can share
>> >> the full reproduction recipe:
>> >> ...
>> > Thanks for the detailed report; very cool.  Interestingly, if you
>> > reverse the direction of the merge (checkout origin/upstream-master
>> > and merge origin/master) then you get a different error:
>> > ...
>> > Anyway, long story short...I don't have a fix yet, but just thought
>> > I'd mention I saw the email and spent some hours digging in.
>>
>> Thanks for continued support for the ort strategy.  From the very
>> beginning, I was hesitant to make our tools try to be too clever
>> with excessive heuristics, but at least we are not making a silent
>> mismerge in this case, so it is probably OK, especially with "-s
>> recursive" still left as an escape hatch.
>
> In fact, the more general problem area here appears to affect the
> recursive strategy as well.  I'm glad the specific testcase reported
> works under recursive and gave Glen (or his user) a workaround, but
> that feels like luck rather than design because my minimal
> reproduction testcase not only triggers the same issue he saw with the
> ort strategy, but also triggers a previously unknown fatal bug in the
> recursive strategy too.

Yeah, hm. I was surprised that we encountered this bug at all, but it's
not so surprising after seeing how many edge conditions this bug
contains.

I wonder if there other rename detection bugs lurking beyond the
horizon, whether we already assume that these bugs exist, and if so,
whether we should officially document "merge without rename detection"
as a workaround [1].

[1] Assuming that the workaround works of course. I tried to disable
rename detection several times, but I couldn't really figure out whether
I did it correctly or whether it fixed the bug (which is why I didn't
include it in the initial report.)
