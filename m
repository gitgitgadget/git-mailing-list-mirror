Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDE801F597
	for <e@80x24.org>; Thu, 19 Jul 2018 20:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbeGSVdx (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 17:33:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52991 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbeGSVdx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 17:33:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so7442198wmh.2
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Govj8Py2qK/ocrsiCr4sZK+nISCH0Cj4rr1NlCrZcg4=;
        b=pqyPOej3QKjrDmYiLbdCe+yB3fyqKPmGCnhUQ/zOtGoK6hMjpMXy82D9uyxmPeihzN
         RxZxVRexyVB8GyYK90ToM8LgmObh+0eVrhhSpALASiiV8roT9652LX6iZexa1BLq6xb7
         kQ44Yy2VkHa83M8+cftxZ55nXEQ6uYk2PwChAr3lkeRrEAingjvLnL6j2UMlYrk7318J
         qYCGxGJZR2cLp1z5wbhucge1zIuu4VnVV9+TpzfALVj4fSnkB6qui3nYnDi05Qro80Kx
         1hxqI9AaKhuNftqHZl8zd72rv9h6rYL1Di39sljZjIAxGnG1vLAGXkbz4+WNKJRGjzIE
         rs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Govj8Py2qK/ocrsiCr4sZK+nISCH0Cj4rr1NlCrZcg4=;
        b=tPHaiJdxxsMNIvAv0ZIibQL2wjAGqG8jS3Q1NOeqvvT6Iv169QUudRlrI8Tv7Qt965
         9W+WOcWSE6pEg/4ZcJ69/mjeitSTOAQViP4C1LToIDWKawjzsakTKwO142ZEpIHtdjji
         FgmE7x5b7jA6ARu1uNrs0lRS7RyvWvwbBN25QV0rz7sqLC57uTLM2xUx6pytpwUhXqdl
         K51PFi6dVSfXUiEeDxKDU0Ih73DLylj+AG54oPUOwy3XSHGUoxjs3TdewfV8KlVY9YtZ
         2w62UNEY094WWbXqIW3GiU/x33eNUnh0+e6ZwU42Md9giY82rUsb9tW3kKOkQ/E7cTrl
         mDjg==
X-Gm-Message-State: AOUpUlFOf+No1pyC4SzoksoBETPZZ31uJjpSdBE7h3CkTe0s7+ctzBZQ
        t2FKulSMosB/V0yqs2gc7No=
X-Google-Smtp-Source: AAOMgpdPD7J932Kdshr7Q/ptJGHXHatQQIyUtYZri1yTZOQnJ2tpGi1hKitXwokuIuEFuiVvxjlCAg==
X-Received: by 2002:a1c:ad42:: with SMTP id w63-v6mr5537608wme.100.1532033343397;
        Thu, 19 Jul 2018 13:49:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u4-v6sm308044wmc.1.2018.07.19.13.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 13:49:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] repack -ad: prune the list of shallow commits
References: <pull.9.git.gitgitgadget@gmail.com>
        <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com>
        <20180713203140.GB17670@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1807142351100.75@tvgsbejvaqbjf.bet>
        <20180716173636.GA18636@sigill.intra.peff.net>
        <xmqqh8kxrfrf.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807191840490.71@tvgsbejvaqbjf.bet>
Date:   Thu, 19 Jul 2018 13:49:02 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807191840490.71@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 19 Jul 2018 18:42:56 +0200 (DST)")
Message-ID: <xmqq7elrdk8x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 17 Jul 2018, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > I'm OK with having a partial fix, or one that fixes immediate pain
>> > without doing a big cleanup, as long as it doesn't make anything _worse_
>> > in a user-visible way. And that's really my question: is pruning here
>> > going to bite people unexpectedly (not rhetorical -- I really don't
>> > know)?
>> 
>> Yeah, that matches the general guideline I follow when reviewing a
>> patch that claims to make existing things better.  And I do not
>> think I can explain to a third person why pruning here is a good
>> idea and won't cause problems, after seeing these patches and
>> the discussion from the sideline.
>
> It is very easy to explain: `git repack` can drop unreachable commits
> without further warning, making the corresponding entries in
> `.git/shallow` invalid, which causes serious problems when deepening the
> branches.

That explains why you wrote the patch very clearly.

> The solution is easy: drop also the now-invalid entries in `.git/shallow`
> after dropping unreachable commits unceremoniously.

Sorry, but I do not think I can relay that as an explanation why it
won't cause problems to a third person.

The entries in shallow file says that history behind them may not
exist in the repository due to its shallowness but history after
them are supposed to be traversable (otherwise we have a repository
corruption).  It is true that an entry that itself no longer exists
in this repository should not be in shallow file, as the presence of
that entry breaks that promise the file is making---that commit
ought to exist and it is safe to traverse down to it, so keeping the
entry in the file is absolutely a wrong thing to do.

But that does not automatically mean that just simply removing it
makes the resulting repository good, does it?  Wouldn't the solution
for that corruption be to set a new entry to stop history traversal
before reaching that (now-missing) commit?  If your solution and
explanatoin were like that, then I can understand why it won't cause
problems, because the resulting repository would be shallower than
it originally was, as if you cloned with a smaller depth, but it is
not corrupt.

Perhaps your rationale is that by trading one shape of corrupt
repository (where a commit that does not even exist is in the
shallow file, breaking the early start-up sequence when it tries to
read the entries) with another shape of corrupt repsitory (where
shallow does not completely tell where to stop, and traversing the
history can eventually hit a missing commit because no entry in the
shallow file stops such a traversal), at least deepening fetch can
start (instead of dying while trying to see how shallow the
repository currently is) and that can be used to recover the corrupt
repository back into a usable state?  If that is the justification,
I can fully buy that, but that is not what I am hearing in your easy
to explain answer, so I am still puzzled.

