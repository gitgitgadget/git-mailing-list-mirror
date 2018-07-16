Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B0FF1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 19:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeGPUX3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 16:23:29 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:47072 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbeGPUX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 16:23:29 -0400
Received: by mail-pl0-f65.google.com with SMTP id 30-v6so15711076pld.13
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 12:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=niGxnWial1UWX71NbsioKvT75/M5yj0gHsE4UR68A48=;
        b=VWTvZEO3DT1UfmW/hLG2WDpmrhqrmg/XpPeXQ+ZnHwr4FhuHyzgLGZSGGjH4yl1JfB
         7xdI3DQHG+04WNeg1lnwYG8vSm7cFjN5sVHdXfjMoP+EwtsFgNmTZXjXR2YSJkpywatV
         tvjr65ATdB8cNKQG6xdpwKY0Y6iJERoXvlqO7l84pcpHzKh+8UYhVXe11JOGGIhVs4lt
         /QC/A3r8pKwbrB6QNMRR9pr3pNYT/mVAnmDfiXYWFsSA/YzoV1dhRe+VQi71H94ZdXOg
         69shcBOBurcpaGidNg33FnAdbXVY2uL0AZTyTY1x9JjghHgomw/5QjxyhnKwB8lDvseh
         uVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=niGxnWial1UWX71NbsioKvT75/M5yj0gHsE4UR68A48=;
        b=Lc+6WXzov1IHtrd96DfsEldm97l9IGvId41S8DajoBmws86KVWw1WAf17YrTx/QYGI
         QkT5K424ddHIhCX+3edG3fyf9mq2rTwKaCwSlN/Hm40/o6bwd3rspOz+wMPo0LBIntiG
         Uox7Qkwof+3awAjIhAF1CNFmnI0l5OsunGhRKI0a2a58Z7h/R+nmsgP/Jc0JLcrXmrOK
         gsA1a53Ys8ALjuzfSD1AiMokc/XR2Svq1yNI5HgIAaCWzGPgaNYZGtzZ7NNcW3j1xNUc
         6ahciXTw0XCzpsEk2gGWw/ujHrPRUqOGvZy3NdYinUZbEga2oJ/moztvrrWaZYcVAzFF
         xbDw==
X-Gm-Message-State: AOUpUlHcQBlugkTPKbWl4Su45a4BeTV7z3eH2YctwLAw46zBW4ivgY6j
        Q1DaEf8rZqHw8naXCgo6ZHE=
X-Google-Smtp-Source: AAOMgpfEUhrayG4smyrkRl9Bywqy3sSfg4B0136SMa6bCySbCgwxiTk3k04kCHU8ZP8OBJXPTPO3eg==
X-Received: by 2002:a17:902:683:: with SMTP id 3-v6mr18032011plh.291.1531770873608;
        Mon, 16 Jul 2018 12:54:33 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h7-v6sm54560957pfd.155.2018.07.16.12.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 12:54:33 -0700 (PDT)
Date:   Mon, 16 Jul 2018 12:54:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716195431.GD11513@aiede.svl.corp.google.com>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716175103.GB18636@sigill.intra.peff.net>
 <20180716182207.GA11513@aiede.svl.corp.google.com>
 <20180716185255.GC22298@sigill.intra.peff.net>
 <20180716190949.GB11513@aiede.svl.corp.google.com>
 <20180716194136.GA25189@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716194136.GA25189@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Jul 16, 2018 at 12:09:49PM -0700, Jonathan Nieder wrote:
>> Jeff King wrote:

>>> Er, the action is to run "git prune", like the warning says. :)
>>
>> I don't think we want to recommend that, especially when "git gc --auto"
>> does the right thing automatically.
>
> But that's the point. This warning is written literally after running
> "git gc --auto" _didn't_ do the right thing. Yes, it would be nicer if
> it could do the right thing. But it doesn't yet know how to.

I think we fundamentally disagree, and I would like your help getting
past this impasse.

Even restricting attention to the warning, not the exit code, I think
you are saying the current behavior is acceptable.  I do not believe
it is.  I think you are saying Jonathan's patch makes the behavior
worse, and I'm not seeing it.  Can you describe an example user
interaction where the current behavior would be better than the
behavior after Jonathan's patch?  That might help make this discussion
more concrete.

[...]
> See the thread I linked earlier on putting unreachable objects into a
> pack, which I think is the real solution.

Have you looked over the discussion in "Loose objects and unreachable
objects" in Documentation/technical/hash-function-transition.txt?  Do
you have thoughts on it (preferrably in a separate thread)?

[...]
>> This sounds awful.  It sounds to me like you're saying "git gc --auto"
>> is saying "I just did the wrong thing, and here is how you can clean
>> up after me".  That's not how I want a program to behave.
>
> Sure, it would be nice if it did the right thing. Nobody has written
> that yet. Until they do, we have to deal with the fallout.

"git gc --auto" is already doing the right thing.

[...]
> I mean that if you do not write a persistent log, then "gc --auto" will
> do an unproductive gc every time it is invoked. I.e., it will see "oh,
> there are too many loose objects", and then waste a bunch of CPU every
> time you commit.

If so, then this would already be the behavior in non daemon mode.
Are you saying this accidental effect of daemon mode is in fact
intentional?

[...]
>>>                                 But in practice, I think you have to
>>> resort to scraping anyway, if you are interested in treating warnings
>>> from sub-processes the same way.
>>
>> Can you say more about this for me?  I am not understanding what
>> you're saying necessitates scraping the output.  I would strongly
>> prefer to avoid scraping the output.
>
> A daemonized git-gc runs a bunch of sub-commands (e.g., "git prune")
> with their stderr redirected into the logfile. If you want to have
> warnings go somewhere else, then either:
>
>   - you need some way to tell those sub-commands to send the warnings
>     elsewhere (i.e., _not_ stderr)
>
>     or
>
>   - you have to post-process the output they send to separate warnings
>     from other errors. Right now that means scraping. If you are
>     proposing a system of machine-readable output, it would need to work
>     not just for git-gc, but for every sub-command it runs.

      or

    - you can simply record and trust the exit code

A simple way to do that without changing formats is to truncate the
file when exiting with status 0.

Thanks,
Jonathan
