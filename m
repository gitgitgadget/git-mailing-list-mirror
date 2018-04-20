Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5FB01F424
	for <e@80x24.org>; Fri, 20 Apr 2018 10:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754462AbeDTKPA (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 06:15:00 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34005 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754294AbeDTKO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 06:14:59 -0400
Received: by mail-wr0-f176.google.com with SMTP id p18-v6so2347878wrm.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 03:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6HST0dxuk6MNnEfBy/LfudGC0jp7yXiDDzc7178MyXw=;
        b=D8SZtdkktZfAvqVO4aPD7NkC7KlR0PVO/LqTbhT7SvsI1OvlMJLFTD76awJbwNJBWs
         LvXeHuOeHDdqz7WAogxygHW5PIKLEADS8l9rIXoQ2AYJ28CXuc3W6AjNSMzEDwwoKYPR
         9TGNOAJijY5WW6PfQvYG73yoS6ZIorC7k9WevrB2B7af5IWZUh+g5nDKIDzvva3MG+B/
         zT2FHCBJo0O/lKI73rGziZVSeQTzYTu/Xla233/qRalLrus/M3HlShKn1VbpK0EVzcO0
         kqQB/1nla80i4HFyTRScoWX9VsQMSHR/XkKDBPa+SWPj3tyTRSjhjOdDlEblIihwM9iY
         9zEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=6HST0dxuk6MNnEfBy/LfudGC0jp7yXiDDzc7178MyXw=;
        b=g+u8QcXuZSBt9VTARfAhZlEfL6HK2J6JVq0QD+L04iaFLWEiP3OrdWa4cTaXUnPjAO
         21AoOgW3Kzc+2rF0ZPri+OgDtob2lSTxug87NT3xWekScMgkhd99158s+T+dhxPyGZSW
         YvsMMTVfuiUwA5+9TecS5fMtNFYcP1nd21QY/mkWnll3NmxENBrSCNh9jKKZRe2VtCs1
         RMn0p/STwfz7+WAX0EozAUIrx/pIXL6Mn+l1+OqIdqxBoju7VMH00fFYci4uV7SorzlF
         os2LZp1EtczjrYSAd/rW+mlXfm+l0vNy3cr13ipmenDh6DDUQa8Ro+xNwMCu4HfYkF/u
         r3sw==
X-Gm-Message-State: ALQs6tDT3MYhlsaz+D0U5VWduqXzPPTu+xLi4JP0Nq47ONhWfQeZwmPg
        in61RmFN2ZOCHD30o8fg8KFLJYoY
X-Google-Smtp-Source: AIpwx48MWB73pECM86zCk9kTVqJJMT8cchRUcetaYB6QKcFsyhc6XsrPNQygWHvMhb+LEh6ztj64lQ==
X-Received: by 10.28.182.70 with SMTP id g67mr1249358wmf.88.1524219297757;
        Fri, 20 Apr 2018 03:14:57 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id y42-v6sm10406552wry.21.2018.04.20.03.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 03:14:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <junio@pobox.com>,
        demerphq <demerphq@gmail.com>
Subject: Re: [RFC WIP PATCH] merge: implement -s theirs -X N
References: <87sh7sdtc1.fsf@evledraar.gmail.com> <xmqqpo2verc6.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqpo2verc6.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 20 Apr 2018 12:14:55 +0200
Message-ID: <87muxydw0w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 19 2018, Junio C. Hamano wrote:

I suppose this is more in reply to
xmqqpo2ud9ih.fsf@gitster-ct.c.googlers.com. I was trying to answer all
your questions in my 87r2nbeh1r.fsf@evledraar.gmail.com, but I think it
wasn't clear, hopefully this inline clears things up.

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> We have a -s ours, but not a -s theirs. This is a WIP patch to implement
>> that. It works, but I haven't dealt with this part of the internal API
>> before, comments most welcome.
>>
>> The purpose of this is that I'm working with a rollout tool that is
>> capable of doing hotfixes on top of old commits on "master".
>>
>> It does this by cherry-picking a commit from origin/master, and then
>> merges it with origin/master & pushes it back, before finally reset
>> --hard to the cherry-pick & rolling out.
>>
>> The reason it's doing this is to maintain the guarantee that all rolled
>> out commits are reachable from "master", and to handle the more general
>> case where original work is made during a hotfix, we don't want to then
>> do a subsequent "normal" rollout and miss the fix.
>
> This question has nothing to do with your "-s theirs" but let me see
> if I got the above correctly.  Suppose you have a deployed branch
> (say, "prod"), all developments happen on "master" elsewhere that
> can be seen as "origin/master", so you may have a few fixes that is
> not yet in "prod" you would want to cherry-pick from origin/master.
>
>     $ git checkout prod
>     $ git cherry-pick origin/master~2
>     $ git cherry-pick origin/master
>
> Let's say that "master" had a fix at HEAD~2, HEAD~1 is a feature
> enhancement that is not yet ready for "prod", and HEAD is another
> fix.  Up to this point you successfully back-ported the fixes to
> "prod".
>
> Then you do merge the tip into "master", i.e.
>
>     $ git checkout origin/master && git merge -s ours prod
>     $ git push origin HEAD:master
>     $ git checkout prod
>
> to make sure that the "master" at the source of truth knows that
> it already has what our "prod" with these two cherry-picks have.
>
> Is that what is going on here?

Yes, the idea is that all commits that are rolled out are reachable from
"master". In my case there's no "prod" branch.

Instead we just have a tag on an older version of "master", and we're
applying a hotfix (usually one cherry-picked commit) to that tag.

We then push a merge of that origin/master back to origin/master so that:

 1. The commit is reachable from "master" as discussed. I.e. a "git
    clone" with the default tag follow logic will bring in that tag & I
    just need to bring in master to bring in every thing ever rolled
    out, not bring in every tag.

 2. Because the working tree is now in a state where we're at that
    hotfix tag, and we want to fast-forward to origin/master on the next
    "real" rollout.

    We could just 'reset --hard' in those cases, but it's easier to
    always be able to do a "git pull" (except when initiating a hotfix).

> I am just wondering what would and should happen to the non-fix
> commit in the middle in the above example.  Perhaps your workflow
> automatically does the right thing to it, perhaps not.

If there's a non-fix commit that contains any original work in the
hotfix I won't be able to use this ~-s theirs" strategy, and I detect
such case swith the patch-id method discussed in
87r2nbeh1r.fsf@evledraar.gmail.com. Then we'll need to use the default
merge logic.

That's actually what we're doing now, but after running into several
bugs with merges gone wrong I'm hoping to fix it, and without bending
over backwards to use -s ours by doing the merge the other way around.
