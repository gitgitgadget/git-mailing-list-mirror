Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7104B1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 13:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbeGRNth (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 09:49:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38424 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeGRNtg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 09:49:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id t2-v6so4198863edr.5
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 06:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3ClPVyCbGxbwErooZLJpjl+Nqsq+DxY5dZ5o+8WNIpY=;
        b=siBXFfeWiKwD8QssqEGS/9ZuDc73DfSRFbdn6PsOf84kqU4M6BzzILajem98q7+Gcl
         S6JWogEmNLIRK2BHI80oacbSvpeQGZUFuFvYkGHBotyT2a1gu3E/f+gWASULqG19xfCV
         0R9lMvWSDGw92dUFcOoNlT9W29FPmf11N5MlpIhB9DZqJNGtY1CTpZbSfJdZA46wwIXj
         +ZX77puiDlj254las3mFuCGkdk5P5/WlyiSaQ8XzfPhLFPNBgBJ3OmsOU+5IaEMlxpu+
         Y0Ptqi9GAtNJtIBuzvXNQ0BBGiSN+285W131kecyndZcVJ/WzT+1Ki5aYRQhkV1gWHDP
         CF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=3ClPVyCbGxbwErooZLJpjl+Nqsq+DxY5dZ5o+8WNIpY=;
        b=NAwnf4gVTy4YY6s0O7JhsSkLPfDcdtUWie93spn6LxPJkquSSMYHInj3eZDTRB6kH4
         Qf9Owxe8QRa/JTwKKj0u9D8af/UfujRVWUjUCODq75rGtYlk4BCL4I/GA2Te8Wwccclo
         ju0qwIQl3/IvCJhZLDcbcpfHGXDEKMIlFFLcT4xhoN+rtIZNp0ZGxrsS3j776mTGIjHo
         lwgG+3te+AbszwG9/5v5zXoYYEyE+uJe15L1Xu67UpS8gvz3j2DHJVcLDmArn8jPwpu8
         +yZGeaeEHfV/izh02sDdrMAZxd+mnKa1ipK9io4dWhEqibb0S/dbuPwrRlIfdNTndAoz
         Jxng==
X-Gm-Message-State: AOUpUlHbiJa2o01udLYlouzQhtA5LjV48ic+NEwUJ7g/uftlCGgz6x6R
        FflFTtS2g4i0cE/bIX21lKs=
X-Google-Smtp-Source: AAOMgpfOV7nokCUdXJFvYW3jnJVdTTrGSUioDBaEAnfFtxfN+BUsQyEBgTq3OorDxxLbYqSXCkXXDg==
X-Received: by 2002:a50:ed09:: with SMTP id j9-v6mr6785715eds.28.1531919502377;
        Wed, 18 Jul 2018 06:11:42 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id g14-v6sm3620767edm.25.2018.07.18.06.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 06:11:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Andrii Dehtiarov <adehtiarov@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
References: <20180716203753.GE11513@aiede.svl.corp.google.com>
        <20180716210938.GF25189@sigill.intra.peff.net>
        <20180716214003.GH11513@aiede.svl.corp.google.com>
        <20180716214539.GL25189@sigill.intra.peff.net>
        <20180716220306.GI11513@aiede.svl.corp.google.com>
        <20180716224337.GB12482@sigill.intra.peff.net>
        <20180716225639.GK11513@aiede.svl.corp.google.com>
        <20180716232603.GB13570@sigill.intra.peff.net>
        <20180717015339.GL11513@aiede.svl.corp.google.com>
        <87d0vmck55.fsf@evledraar.gmail.com>
        <20180717202700.GE26218@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180717202700.GE26218@sigill.intra.peff.net>
Date:   Wed, 18 Jul 2018 15:11:38 +0200
Message-ID: <874lgwd6yd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 17 2018, Jeff King wrote:

> On Tue, Jul 17, 2018 at 10:59:50AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> That doesn't make sense to me. Just because git itself is happily
>> ignoring the exit code I don't think that should mean there shouldn't be
>> a meaningful exit code. Why don't you just ignore the exit code in the
>> repo tool as well?
>>
>> Now e.g. automation I have to see if git-gc ---auto is having issues
>> can't just be 'git gc --auto || echo fail @ {hostname}' across a fleet
>> of servers, but will need to start caring if stderr was emitted to.
>
> If you're daemonizing gc, though, there are a number of cases where the
> exit code is not propagated. If you really care about the outcome,
> you're probably better off either:

In theory a lot of the other stuff can fail, but in practice I've only
seen it get stuck due to running out of disk space (easily detected in
other ways), and because of having too many loose objects (e.g. due to,
but not limited to
https://public-inbox.org/git/87fu6bmr0j.fsf@evledraar.gmail.com/).

>   - doing synchronous gc's, which will still return a meaningful code
>     after Jonathan's patches

(Reply to this and "we've found at GitHub..." later in your mail)

I'm targeting clients (dev machines, laptops, staging boxes) which have
clones of repos, some put in place by automation, some manually cloned
by users in ~.

So it's much easier to rely on shipping a /etc/gitconfig than setting
gc.auto=0 and having some system-wide job that goes and hunts for local
git repos to manually gc.

It's also a big advantage that it's driven by user activity, because
it's an implicit guard of only_do_this_if_the_user_is_active_here()
before "git-gc" on a fleet of machines, which when some of those get
their disk space from shared NFS resources cuts down on overall I/O.

>   - inspecting the log yourself. I know that comes close to the un-unixy
>     stderr thing. But in this case, the presence of a non-empty log is
>     literally the on-disk bit for "the previous run failed". And doing
>     so catches all of the daemonized cases, even the "first one" that
>     you'd miss by paying attention to the immediate exit code.
>
>     This will treat the zero-exit-code "warning" case as an error. I'm
>     not against propagating the true original error code, if somebody
>     wants to work on it. But I think Jonathan's patches are a strict
>     improvement over the current situation, and a patch to propagate
>     could come on top.

Yeah, I can check gc.log, if others are of a different opinion about
this #3 case at the end of the day I don't mind if it returns 0. It just
doesn't make any conceptual sense to me.

>> I think you're conflating two things here in a way that (if I'm reading
>> this correctly) produces a pretty bad regression for users.
>>
>>  a) If we have something in the gc.log we keep yelling at users until we
>>     reach the gc.logExpiry, this was the subject of my thread back in
>>     January. This sucks, and should be fixed somehow.
>>
>>     Maybe we should only emit the warning once, e.g. creating a
>>     .git/gc.log.wasemitted marker and as long as its ctime is later than
>>     the mtime on .git/gc.log we don't emit it again).
>>
>>     But that also creates the UX problem that it's easy to miss this
>>     message in the middle of some huge "fetch" output. Perhaps we should
>>     just start emitting this as part of "git status" or something (or
>>     solve the root cause, as Peff notes...).
>
> I kind of like that "git status" suggestion. Of course many users run
> "git status" more often than "git commit", so it may actually spam them
> more!

Maybe piggy-packing on the advice facility ...

>>  b) We *also* use this presence of a gc.log as a marker for "we failed
>>     too recently, let's not try again until after a day".
>>
>> The semantics of b) are very useful, and just because they're tied up
>> with a) right now, let's not throw out b) just because we're trying to
>> solve a).
>
> Yeah. In general my concern was the handling of (b), which I think this
> last crop of patches is fine with. As far as showing the message
> repeatedly or not, I don't have a strong opinion (it could even be
> configurable, once it's split from the "marker" behavior).
>
>> Right now one thing we do right is we always try to look at the actual
>> state of the repo with too_many_packs() and too_many_loose_objects().
>>
>> We don't assume the state of your repo hasn't drastically changed
>> recently. That means that we do the right thing and gc when the repo
>> needs it, not just because we GC'd recently enough.
>>
>> With these proposed semantics we'd skip a needed GC (potentially for
>> days, depending on the default) just because we recently ran one.
>
> Yeah, I agree that deferring repeated gc's based on time is going to run
> into pathological corner cases. OTOH, what we've found at GitHub is that
> "gc --auto" is quite insufficient for scheduling maintenance anyway
> (e.g., if a machine gets pushes to 100 separate repositories in quick
> succession, you probably want to queue and throttle any associated gc).

I'm sure you have better solutions for this at GitHub, but as an aside
it might be interesting to add some sort of gc flock + retry setting for
this use-case, i.e. even if you had 100 concurrent gc's due to
too_many_*(), they'd wait + retry until they could get the flock on a
given file.

Then again this is probably too specific, and could be done with a
pre-auto-gc hook too..

> But there are probably more mid-size sites that are big enough to have
> corner cases, but not so big that "gc --auto" is hopeless. ;)

FWIW I don't deal with gc on the server at all these days (that's our
internal GitLab's instance problem to solve). I just mentioned the edge
case of a growing number of pack files on the server upthread as
something that we'd be shipping with git if we had time-based backoff
semantics.
