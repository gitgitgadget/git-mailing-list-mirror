Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F1F91F597
	for <e@80x24.org>; Mon, 16 Jul 2018 20:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeGPVHA (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 17:07:00 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35641 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeGPVHA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 17:07:00 -0400
Received: by mail-pf0-f196.google.com with SMTP id q7-v6so25746666pff.2
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 13:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vWtDdu1wOlFh08XbGpoEGZztGGFrHefvJ1o8elaj6z4=;
        b=Hvx16Qf0nT81u5qBcHFsJCysiZdh+vMoPLpWCiQO3yaFWS6esN2KEV3AryVYwMY7qy
         jRRUWJArssSVm110wlf8i85TK3DYt3heB3zbRxSqjioOzH9bMnBjSbVmavfGfbtwnFYo
         LScrHe+9kLw7QySdIE3T85Ss+sZoOb4OYA1VD6E+w3f+9bL4HGQ41BiEudsKkhc62Wl9
         JuvLn/7iQoRZZYXOQAdXPaH4WdlJVHxLIkrH6/baDnw4O1sIHJCXSSBs/NmQswLCfO3K
         I1BVP78nj5FYXKsKPdqKk+zqD10MEJ6X/KtI7wxfVj20BUT6P+YA78Jliw8QSizuB2Jm
         W4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vWtDdu1wOlFh08XbGpoEGZztGGFrHefvJ1o8elaj6z4=;
        b=LdxEDa+FJ1pY2aNflSKOJeiQGvLnta266XkRngKO4ijm7NKgE5Z7g8jkYObH8mtbV3
         11/tv75UDITbUtaa/uy4Z1i85ebnER01HW5Di4/AI2YZQ6aetJmePj9SFRmBsTk13yza
         bwG4gvCkJQ88vYtX18aBTFsJvqUHPdptg7/mc5B6zbT7Pl0WVZeNblQEKy+bodOfk/lC
         5AAWT+E1pIyS6wrvrjbbvPcMBLpTgoco25Ee7kdB787uLf5qwhP74e/Uwx+cRoNcU0Pt
         rlFnVX9WO0u9dthIIFgBO8vjUkeOpLCk37rxGzf7bahIsbgpf8kNi6ePzx7/MiUwG42r
         sq7Q==
X-Gm-Message-State: AOUpUlFoNGiBhJ0cV/9wPSAU8lPHrby7I2cKnB9LQp0JiXal7imqyEwK
        wKkltROhivKBPaOUGQC2oP8=
X-Google-Smtp-Source: AAOMgpdjrWwxiDxQT7Kjs6fbeoexCD/avqBCWO7iQNDBD/uu7zBqyQal9au0Izi77GgUI11Lgqt/DA==
X-Received: by 2002:a62:ca0d:: with SMTP id n13-v6mr19289421pfg.69.1531773475841;
        Mon, 16 Jul 2018 13:37:55 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a11-v6sm58987592pfl.66.2018.07.16.13.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 13:37:55 -0700 (PDT)
Date:   Mon, 16 Jul 2018 13:37:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716203753.GE11513@aiede.svl.corp.google.com>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716175103.GB18636@sigill.intra.peff.net>
 <20180716182207.GA11513@aiede.svl.corp.google.com>
 <20180716185255.GC22298@sigill.intra.peff.net>
 <20180716190949.GB11513@aiede.svl.corp.google.com>
 <20180716194136.GA25189@sigill.intra.peff.net>
 <20180716195431.GD11513@aiede.svl.corp.google.com>
 <20180716202915.GC25189@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716202915.GC25189@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Jul 16, 2018 at 12:54:31PM -0700, Jonathan Nieder wrote:

>> Even restricting attention to the warning, not the exit code, I think
>> you are saying the current behavior is acceptable.  I do not believe
>> it is.
>
> I didn't say that at all. The current situation sucks,

Thanks for clarifying.  That helps.

>                                                        and I think the
> right solution is to pack the unreachable objects instead of exploding
> them.

That seems like a huge widening in scope relative to what this
original patch tackled.  I'm not aware of a way to do this without
breaking compatibility with the current (broken) race prevention.  If
you're saying that breaking compatibility in that way is okay with
you, then great!

[...]
>> I think you are saying Jonathan's patch makes the behavior
>> worse, and I'm not seeing it.  Can you describe an example user
>> interaction where the current behavior would be better than the
>> behavior after Jonathan's patch?  That might help make this discussion
>> more concrete.
>
> It makes it worse because there is nothing to throttle a "gc --auto"
> that is making no progress.
[...]
> With the current code, that produces a bunch of annoying warnings for
> every commit ("I couldn't gc because the last gc reported a warning").
> But after Jonathan's patch, every single commit will do a full gc of the
> repository. In this tiny repository that's relatively quick, but in a
> real repo it's a ton of CPU and I/O, all for nothing.

I see.  Do I understand correctly that if we find a way to print the
warning but not error out, that would be good enough for you?

[...]
>> Have you looked over the discussion in "Loose objects and unreachable
>> objects" in Documentation/technical/hash-function-transition.txt?  Do
>> you have thoughts on it (preferrably in a separate thread)?
>
> It seems to propose putting the unreachable objects into a pack. Which
> yes, I absolutely agree with (as I thought I'd been saying in every
> single email in this thread).

I figured you were proposing something like
https://public-inbox.org/git/20180113100734.GA30698@sigill.intra.peff.net/,
which is still racy (because it does not handle the freshening in a safe
way).

[...]
>           Even if we were going to remove this message to help the
> daemonized case, I think we'd want to retain it for the non-daemon case.

Interesting.  That should be doable, e.g. following the approach
described below.

[...]
>> A simple way to do that without changing formats is to truncate the
>> file when exiting with status 0.
>
> That's a different behavior than what we do now (and what was suggested
> earlier), in that it assumes that anything written to stderr is OK for
> gc to hide from the user if the process exits with code zero.
>
> That's probably OK in most cases, though I wonder if there are corner
> cases. For example, if you have a corrupt ref, we used to say "error:
> refs/heads/foo does not point to a valid object!" but otherwise ignore
> it. These days git-gc sets REF_PARANOIA=1, so we'll actually barf on a
> corrupt ref. But I wonder if there are other cases lurking.

What decides it for me is that the user did not invoke "git gc --auto"
explicitly, so anything "git gc --auto" prints is tangential to what
the user was trying to do.  If the gc failed, that is worth telling
them, but if e.g. it encountered a disk I/O error reading and
succeeded on retry (to make up a fake example), then that's likely
worth logging to syslog but it's not something the user asked to be
directly informed about.

Thanks,
Jonathan
