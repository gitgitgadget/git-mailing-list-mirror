Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24F9ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 18:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiIASur (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 14:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbiIASun (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 14:50:43 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738DB8C024
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 11:50:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id a36so19965633edf.5
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 11:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=ne8pSsdJ96jYikWmUNghzGpUK3kK/DOKnCLgnH9kYO0=;
        b=GfeAqAYjOFPaz7y8mgomZijG9+oCnP5dhwsBvawsoNf/fLFFmzftC8UVxpNbp8KvE6
         YpjfnxjR6f/m2vszUuFC78xlhYKVcqmqdhjMJ22/9Fg2HzbPTp1kBQ4sw9Xcymazen+H
         k5nzfG06mynEviGsdyFfsf7+vNUfACh/9BQ8aE+TK57wFqtBmuXdbJytwiDsQC7pw7z0
         Vpc8oll6y1YnjDX7MonOk272EfB7niC6OOdRUR4LRVDzM8Fg5N2lTh7nOaZ6MjWEBKf0
         Up8C4kKmCCLFgflDJKw0rXel6OOUjxJ+qme0WOe8I4TBWnkUxnlvLz+6zM92uYfPUqWw
         P4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ne8pSsdJ96jYikWmUNghzGpUK3kK/DOKnCLgnH9kYO0=;
        b=4K/9XJLfGENPbS/6h4Ej6iTcH6TSD/Fiy3ymPZ8/lMpkTc5NOF2mEVQrkSQs/Eer5W
         5s0Dmb1yHv5NR15oRBIpV5ztmJe30GNzkfhurvLoDDLVQ7hLOMDo5gyNAS1QlF9GNTyH
         aB10H7Ls1J6Nld4IEzDWH3B9uwouOkvG6U7jrJbQt1T/hKAyqPkTZO7urVogD6dpC0Sh
         5YVix9umaBSRefWvGkndZRGB7JTFtOkULSP3gqydXO5Ck1GAe3jt+Zjd5JXzcA9e+iZX
         dHq43LAvqOpVyyPufa9T++APBOXEgJT1Qknmfc6ZUl5XywoF4eOZGjevNrCx9R6bLr4R
         JbDA==
X-Gm-Message-State: ACgBeo2yir3xGGdy8BqbgFREimj27qZS/Z9eHCHC5c5fmFiZxFMvnhmi
        rZNEGx+OMpIDsvD9XB/6nog=
X-Google-Smtp-Source: AA6agR6nlcY2YzgLjD7HvgFR6t71zH4XjZllDrFEmbCbpkeGES+7C2EKKFvlIul23YRwsViHeno6ew==
X-Received: by 2002:a05:6402:1f86:b0:447:8edd:1c4b with SMTP id c6-20020a0564021f8600b004478edd1c4bmr29340739edc.163.1662058236634;
        Thu, 01 Sep 2022 11:50:36 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id s2-20020a1709064d8200b0073923a68974sm8677714eju.206.2022.09.01.11.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 11:50:36 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oTpGt-000MNc-0z;
        Thu, 01 Sep 2022 20:50:35 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 0/3] Output fixes for --remerge-diff
Date:   Thu, 01 Sep 2022 20:46:44 +0200
References: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
 <xmqqv8q7dhh4.fsf@gitster.g>
 <CABPp-BHULBGAbmY1r9fpRr+MrjqOp7j-devOgkfA25jpYBGY9g@mail.gmail.com>
 <xmqqo7vzce39.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqo7vzce39.fsf@gitster.g>
Message-ID: <220901.86tu5rhqtg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 01 2022, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
>
>> On Wed, Aug 31, 2022 at 6:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>> > Philippe Blain found and reported a couple issues with the output of
>>> > --remerge-diff[1]. After digging in, I think one of them actually counts as
>>> > two separate issues, so here's a series with three patches to fix these
>>> > issues. Each includes testcases to keep us from regressing.
>>>
>>> Including this to 'seen' seems to break the leaks-check CI job X-<.
>>>
>>> https://github.com/git/git/runs/8124648321?check_suite_focus=true
>>
>> That's...surprising.  Any chance of a mis-merge?
>>
>> I ask for two reasons:
>>   * This series, built on main, passed the leaks-check job.
>
> Ah, that.
>
> Yes, I did rebase it to 'maint' to be nice to our users as this is
> not a new feature development but a bugfix or two.
>
> This is why I hate the leak-check CI job (yes, I do help maintain
> all parts of the tree, but it does not mean I have to love every bit
> of the codebase, and this is one of the things I love to hate).
>
> Instead of saying "subcommand X with feature Y? It ought to be clean
> so complain if leak checker find something. subcommand Z? It is
> known to be unclean, so do not bother", it says "In this test in
> entirety, we currently happen to use only the ones that are clean"
> and penalizes developers who wants to use an unclean tool merely for
> checking.  The approach is fundamentally flawed and does not play
> well with multiple integration branches, just like we saw here.

We've discussed doing it that way before. I wouldn't be fundamentally
opposed, but I do think we're far enough along the way to being
leak-free that we'd want to mark more than just a "top-level" command as
leak-free.

It's just also not the case that we even could do that in all but the
most trivial cases. Most commands still leak somewhere in some obscure
cases, but we have entire tests now where the code they run in those
common cases doesn't leak.

However, in this case this seems to just be a case that Elijah tested
his code on base X, and you applied it on base Y.

I don't really see how the approach you're suggesting would be any more
likely to be resilient in the face of that. Then we'd presumably use
some command that's leak-free on "master", but that command wouldn't be
leak-free on "maint".
