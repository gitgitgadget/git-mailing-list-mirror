Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06717C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbiCDKjb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbiCDKja (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:39:30 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F093B150409
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:38:42 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x5so10161187edd.11
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 02:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=GB4KfTICJ7jc441sWZXoCSuH9nQkHwk9yO7aziwT0Eg=;
        b=awc1p1c/xNcFAOs5Ote5nfDryqhP8Hqb2gGtGNaq9mEy+uCl7raF0UXhKcdG1lsMfu
         I8EkEcOfc7s6hwYnrd/MII9spHodtDNhS/c+bWg2wqs6NQUFZrVl/s2Gw9eW32GC5U9s
         HCBL/86ynjaDY9aGiRjXRehFJditzPBDM4niPILxsidhpBUf7XXpENLEeZFS44CEQXsK
         ZMKwR8ZYGNyny/PM5ZqCBPmK3lPw/joX92Hdn/WMrVoWCDCJu13WXIjE0wN3zsAtQqBo
         PAT34Acnif5HVTrx7lHXDlBJEmsR7UHN+YuYnj2WP9rIH2HO9B3pwWfpf+BnOnWgRPqj
         ksXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=GB4KfTICJ7jc441sWZXoCSuH9nQkHwk9yO7aziwT0Eg=;
        b=wqYFVxbB8ZT1xoLBKyxlF2tL9VdS2I0lLs3c8zJHy+ZFXS/vH0V3vPncWdMwe72EJ6
         wzCjfcnovpiT1lgVyqy7VAn5po+IcKhJHSB6zgwPrNxmxKTswRksnAYMisUVvejIQk3P
         8Qzc2iFs5nEeIZip9IoqqTCLlOFsJK+kfLwsVwh33UZxPSeEOfAo58Kt81WfaqVWvIT4
         wSMuxyLvI8L4ISxScf07ncKL3YdNHqK6YhQtEuMyzBAKYgtlVTzfxFs8crmJBiEKvLAw
         liGQM1A5eyRD2XhPGtSs+nc3bERzHwJAf8nB1vHlgrekoGw5fsed/TF0pCjWTGf8QMpX
         Qnfw==
X-Gm-Message-State: AOAM533FJ7J74lmMFpPO0fMyA7lLjHY/lhKnEdo4BrYw58XvOSfNxKCC
        I6WsDTdTsrvjXV+loLqMT1kZF6ukhELV0w==
X-Google-Smtp-Source: ABdhPJw9kWNshdUe2isvdBh8IjIdpvfYyLniCzQx9ybRvdd70srh2JKprHMnfayjsmpC+Ql8P9ZXOA==
X-Received: by 2002:a05:6402:1507:b0:415:f3c7:60fe with SMTP id f7-20020a056402150700b00415f3c760femr3362189edw.350.1646390321212;
        Fri, 04 Mar 2022 02:38:41 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090657c300b006d01de78926sm1631442ejr.22.2022.03.04.02.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 02:38:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nQ5KZ-000ECQ-QW;
        Fri, 04 Mar 2022 11:38:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: log messages > comments (was: [PATCH v3 3/3] SubmittingPatches:
 explain why we care about log messages)
Date:   Fri, 04 Mar 2022 10:52:01 +0100
References: <20220126234205.2923388-1-gitster@pobox.com>
 <20220127190259.2470753-4-gitster@pobox.com> <YiFY693P6E/eVS3k@google.com>
 <xmqqr17i5zlu.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqr17i5zlu.fsf@gitster.g>
Message-ID: <220304.86ilsuf1e8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 03 2022, Junio C Hamano wrote:

> Emily Shaffer <emilyshaffer@google.com> writes:
>
>>> +The goal of your log message is to convey the _why_ behind your
>>> +change to help future developers.
>>> +
>>
>> This is pretty compelling. Is it clear enough why we care about this in
>> the commit message, as opposed to in the patch description (cover letter
>> or post-"---" blurb)? Is it too obvious to explicitly mention that the
>> commit message is the first thing we try to make sense of during a 'git
>> blame' or 'git bisect'?
>
> Again, patches welcome ;-)

I think for something that's a stylistic preference I'd see why Emily
would try to see how you feel about it first.

I.e. in this project it's ultimately up to you to decide on those
things, so for coding guidelines you've just updated I'd probably do the
same.

Don't take that as a complaint on the end result b.t.w., I think the
overall excellent state of the codebase in this project speaks for
itself on that front.

I just see why other contributors would be gun shy about pulling the
trigger on a patch submission on this particular front :)

> Having to say "this may be better in the in-code comment rather than
> the log message" to some patch recently (I do not remember), I tend
> to agree that some guidance would help people decide between the two
> (or writing both).

[A somewhat sneaky $subject change :)]

I think you're referring to this comment on (some admittedly tricky)
code I wrote[1].

First, given the above I'll adjust that to your preferences on a
re-submission. So don't take this as some argument on *that* specific
point. I'll add a comment in a re-roll.

But on reflection I still wouldn't put a comment on that code if it were
purely up to me. Why?

First, I think all programmers go through a phase of learning where they
feel more compelled to comment on the "how" v.s. "why" early on.

At the most extremes beginner programmers explaining how say a common
standard library function works in code that's relatively
straightforward.

But that's really not the case in [1], that code really is doing
something odd and worth explaining. So why not add a comment?

Because access to ubiquitous and *local* source control from git changed
a lot of people's habits on this front, including mine. For this code I
*would* definitely add a comment there if it was the pre-DVCS[2] days.

But I'd say that today my criteria for adding a comment is closer to:

    Is this so essential to note for the understanding of the rest of
    this code that nobody who's skimming past this line or reading this
    part *wouldn't* want this information?

    Or rather, they might not absolutely want to know, but it might be
    useful, *and* there's nothing odd about the pattern itself that
    makes you go "hrm?" enough to run "git blame/log" on it.

In this case it's clearly pretty weird that we run the exact "test-tool
regex" command twice. But I think that "hrm?" applies. To elaborate:

 A. It's setting up a self-contained prereq, so it's not essential
    to understand that implementation detail to read the rest of the
    code.

 B. Anyone who does want to see why that odd case is the way it is can
    run some version "git blame" or say:

        git log -p -L14,21:t/t7812-grep-icase-non-ascii.sh

 C. Each comment you add, even within a function or other scope dilutes
    the value of other more important comments. It trains people not to
    read them, as they're probably not that important.

 D. Comments that are "frozen in time" by adding them to the code
    itself are almost always in danger of drifting in accuracy from the
    rest of the implementation and its assumptions.

    Even in well-curated codebases like git.git they're *much more*
    likely to drift away from the "ground truth" than code is.

 E. Even if "D" isn't true, commit messages (in this case my [3]) are
    almost always at an advantage over comments in that they accompany
    a change to the pre-image.

    So e.g. that commit message doesn't need to waste time explaining
    what pattern we'd prefer not to have here instead of the post-image,
    you get that context for free.

Due to a combination of "D" and "E" I almost never read comments in
their current context, unless it's painfully obvious that they *must*
still apply to the current code. I'll usually run some variant of "git
blame" or say:

    git log -p -L:relevant_function:file

And then see how the code looked when that comment was added, and page
through what's changed since then.

1. https://lore.kernel.org/git/xmqqsfryah42.fsf@gitster.g/
2. To those who'd nitpick DVCS v.s. VCS: Yes nothing changed in theory from CVS/SVN
   etc. on this front, but in practice it did.
   
   Access to version control didn't tend to be ubiquitous, and even if it was
   accessible many people browsing or contributing to your code would probably
   do so via a downloaded tarball than trying to get CVS or whatever to work.
   So the "D" in DVCS really did change this.
3. https://lore.kernel.org/git/patch-12.15-f3cc5bc7eb9-20220302T171755Z-avarab@gmail.com/



