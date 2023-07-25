Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7697C001DE
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 16:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjGYQsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 12:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjGYQrj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 12:47:39 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1202D45
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 09:46:50 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55c475c6da6so2628636a12.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 09:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690303590; x=1690908390;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jTCVtsH6AXF6OQstyyAb/HNfavf7Ey+9RfjOauPVpIk=;
        b=Fb16ZsjSWZTUrCBu9qpYCtXVfm3Y5+tun9y4+H8SJaG2CADKK8VTh7AbAu277jol+j
         9kdNeRXcOI00UcaXHO/+YHx0Yio5/c8VwMXY7G9z304pn46xYw2AZgeBN1SMSksCt38/
         oVk61rypZSt5NOxDLff1Ieq9sSz3tpI2qyhXpuiqIqzBXqxYpNmT+IYD2tkjFLrz3cYF
         A4HYt4Z0nqkghm+McSof2ADrHhh8TZzJxttLwja+XpFkkZvLdIWrioxVoO0SLOZbW9t6
         Ar8wGTxGdyoogiUIHQP3DGEZiNSSoqfnaCnugujntjS5i+OvgMSLgWOT8rxtLq/Xunb6
         Hcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690303590; x=1690908390;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jTCVtsH6AXF6OQstyyAb/HNfavf7Ey+9RfjOauPVpIk=;
        b=Dh3u/Ffrb0e/f7iSOXgparTlRUpfufR6er94EuXtqKP6G9gbxAmQlCwcfFEUpDWiw9
         Otwjdx3f9ON7RKh10RZVpHruQz8WvHcsdNxn9MSHmcHBRMIwXyCjCx8UZWZXJl0wSz5v
         4rtyWiPKO60fTG6MJHimrE/OLEkSR8woKuwA9Z6PRg9EGlgPLh0/2jhIsfa7yD3Gdv8/
         kIs6qaLh/bk/x9/l3Wj6qGlKXXdYepe1tEQFpNMVVTxGyCDHSD3DZJDY7Go3fh4fqF/8
         DTTHBb3NO+JzXUF0FZEbO844a0uF3C8j9dBuTzxxPyGjnLLDE11Fen17a/rqp3B11hMa
         1uFg==
X-Gm-Message-State: ABy/qLZdSOYidnXQBMCRCagpZN220VK0d1fVw/OcfER98cVZqdYhArL5
        HJpORpJ0vLA2RGWy5FZDWeA/CqSTENKe8g==
X-Google-Smtp-Source: APBJJlFJMUYsTZ9JhzAnkTTlVfaPnMQfRBxb150n1pecZvDzJG3gF8CXRg8mE5shAaslYInRKMOhArXB9ywwUg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:fa08:b0:1b8:3c5e:2289 with SMTP
 id la8-20020a170902fa0800b001b83c5e2289mr46476plb.2.1690303590256; Tue, 25
 Jul 2023 09:46:30 -0700 (PDT)
Date:   Tue, 25 Jul 2023 09:46:28 -0700
In-Reply-To: <fdb605bf-938d-6135-b341-6cf20600abaf@gmail.com>
Mime-Version: 1.0
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
 <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com> <f8e64c1b631116367e6e68fcfde711b507a03a94.1682089075.git.gitgitgadget@gmail.com>
 <kl6lmt0sr16k.fsf@chooglen-macbookpro.roam.corp.google.com> <fdb605bf-938d-6135-b341-6cf20600abaf@gmail.com>
Message-ID: <kl6lo7k0ym57.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 5/6] rebase: fix rewritten list for failed pick
From:   Glen Choo <chooglen@google.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> When rebasing commands are moved from the todo list in "git-rebase-todo"
>>> to the "done" file just before they are executed. This means that if a
>>> command fails because it would overwrite an untracked file it has to be
>>> added back into the todo list before the rebase stops for the user to
>>> fix the problem. Unfortunately the way this is done results in the
>>> failed pick being recorded as rewritten.
>> 
>> I could not make the connection from the described problem to the
>> proposed solution. In particular, I couldn't tell what about "the way
>> this is done" that causes the incorrect behavior (e.g. are we failing to
>> clean up something? are we writing the wrong set of metadata?).
>
> Yes, on reflection that first paragraph is not very helpful. I've 
> updated it to
>
> git rebase keeps a list that maps the OID of each commit before
> it was rebased to the OID of the equivalent commit after the rebase.
> This list is used to drive the "post-rewrite" hook that is called at the
> end of a successful rebase. When a rebase stops for the user to resolve
> merge conflicts the OID of the commit being picked is written to
> ".git/rebase-merge/stopped-sha1" and when the rebase is continued that
> OID is added to the list of rewritten commits. Unfortunately when a
> commit cannot be picked because it would overwrite an untracked file we
> still write the "stopped-sha1" file and so when the rebase is continued
> the commit is added into the list of rewritten commits even though it
> has not been picked yet.
>
> Hopefully that is more helpful

Ah, yes that is much easier to visualise and understand. Thanks so much.

>>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>>> index c1fe55dc2c1..a657167befd 100755
>>> --- a/t/t3404-rebase-interactive.sh
>>> +++ b/t/t3404-rebase-interactive.sh
>>> @@ -1289,6 +1289,10 @@ test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
>>>   	test_cmp_rev HEAD F &&
>>>   	rm file6 &&
>>>   	test_path_is_missing .git/rebase-merge/author-script &&
>>> +	test_path_is_missing .git/rebase-merge/patch &&
>>> +	test_path_is_missing .git/MERGE_MSG &&
>>> +	test_path_is_missing .git/rebase-merge/message &&
>>> +	test_path_is_missing .git/rebase-merge/stopped-sha &&
>> 
>> This also seems to be testing implementation details, and if so, it
>> would be worth removing them.
>
> With the exception of the "patch" file which exists solely for the 
> benefit of the user this is testing an invariant of the implementation 
> which isn't ideal. I'm worried that removing these checks will mask some 
> subtle regression in the future. I think it is unlikely that the names 
> of these files will change in the future as we try to avoid changes that 
> would cause a rebase to fail if git is upgraded while it has stopped for 
> the user to resolve conflicts. I did think about whether we could add 
> some BUG() statements to sequencer.c instead. Unfortunately I don't 
> think it is that easy for the sequencer to know when these files should 
> be missing without relying on the logic that we are tying to test.

Unfortunately, it's been a while since I reviewed this patch, so forgive
me if I'm rusty. So you're saying that this test is about checking
invariants that we want to preserve between Git versions. I think that's
a reasonable goal - I am slightly skeptical of whether we should be
doing that ad-hoc like this, but I don't feel strongly about it.

IIRC, there was an earlier patch would be different from an where we
tested that author-script is missing, but what we really want is for the
pick to stop. Is the same thing happening here? E.g. is 'testing for
missing stopped-sha' a stand-in for 'testing that the rewritten list is
correct'? If so, it would be nice to test that specifically, but if
that's infeasible, a clarifying comment will probably suffice.
