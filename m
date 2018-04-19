Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB0BB1F424
	for <e@80x24.org>; Thu, 19 Apr 2018 08:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeDSI2j (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 04:28:39 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:39899 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeDSI2g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 04:28:36 -0400
Received: by mail-wr0-f181.google.com with SMTP id q3-v6so1575941wrj.6
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 01:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=kujTB2Rqs0/egzsaudmqyRaAPlgP3kEkIfDmU2aNLvk=;
        b=nc5Z4bQXq9tzrtv89XoC5AcuV5MO/gsU4SSeIqcPDDYxiWJ6aY5mfhsrb2M9AtIJXU
         JpZlQeptaCQqgh8rz0IumxJ/kUU9fUeuiinVzo6B2vfWYly72jQkJq8tsaODdGMieH4v
         ZjKrcGNCRP1Pdwi46Qi0RoBYieCOwc7j0rjGcj8C+WbLIy08UGso5803LdLXvM1TQ2+H
         78oB0mA80tLwYWa7eR7foQwV9u3h2oH97MFGxdH4NQry+yEb/S+d2BAHe0xev2FLkrO7
         KjSMG+UBvm+Q7PvpdVgvkpYyAKRjPmO+IzJBHQlHKkhfXFFRzYCX6PFzUYCoXgS/NlpY
         pmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=kujTB2Rqs0/egzsaudmqyRaAPlgP3kEkIfDmU2aNLvk=;
        b=fiy2GDEqEtpp3SXXMx1WMasrO//bRk/evD7vvkIj5Ac/ooc761Y5RrZahmqlr6kfbn
         oZ/EvHbyLth7eaxU08msNzvhwGCJzmtYxwkEkxjrgLm3WIQLAAlDzxngiNOmt7uJvAES
         zvDSze62VeJ4z/Oh/G9VZWjshw9XcNNx+RuFpGxiaKjtcY2K8I+BT/i36E3NNs2hF6jm
         oijPbq6WJ7cMsU2s9GMRlN9olHvlccpkxDRdMchvfN6IJaiDQwbhjYSDzNgIsumF12MG
         hrh2Os9JEeiRLlf2VqsqIUdo3GWIk+OzWZRx9LeMXwHw6+ZYH9sKLE7eujbto9Jv30k+
         ++DA==
X-Gm-Message-State: ALQs6tD2/DVTgLHviKFUf5QepSb1JitHKnUyCqE6AgxflBmD6xHH/Q5V
        9Z6dz/fSNacuf1Bf0XdaritcLpD1
X-Google-Smtp-Source: AIpwx4/Su/hEkyQZC33jT1beDwQqWnpQVsRLXL8Xbxd1yLdt9xvpYOXB3OHUzK1wMYBHdrUaSLiCeg==
X-Received: by 10.80.142.9 with SMTP id 9mr7317306edw.101.1524126514333;
        Thu, 19 Apr 2018 01:28:34 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id x49sm2273156edb.94.2018.04.19.01.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Apr 2018 01:28:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <junio@pobox.com>,
        demerphq <demerphq@gmail.com>
Subject: Re: [RFC WIP PATCH] merge: implement -s theirs -X N
References: <87sh7sdtc1.fsf@evledraar.gmail.com> <xmqqpo2verc6.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqpo2verc6.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 19 Apr 2018 10:28:32 +0200
Message-ID: <87r2nbeh1r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 19 2018, Junio C. Hamano wrote:

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
>
> I am just wondering what would and should happen to the non-fix
> commit in the middle in the above example.  Perhaps your workflow
> automatically does the right thing to it, perhaps not.
>
>
> [Footnote]
>
> Obviously you can do this the other way around if you had "-s
> theirs", i.e. instead of the last two lines from the above sequence,
> you could do
>
>     $ git merge -s nth -X 2 origin/master
>     $ git push origin HEAD:master
>     $ git reset --hard HEAD@{1}
>
> but it is not all that interesting (at least to me) either way, as a
> larger issue with the above I'd imagine people would see is that
> even temporarily you would expose "master" material in that working
> tree you usually have "prod" checkout.  That would irritate those
> who consider that "push to deploy" aka "live site is actually a
> working tree" is sensible more than the lack of "-s theirs" I would
> think.

Yeah this -s theirs is redundant to just doing it the other way around
as you describe.

The reason I want it is to always do the hotfix merge the same way
whether I'm dealing with a case where there's original work in the
hotfix (rare) or the case where there's just stuff to "prod"
cherry-picked from "master" (common).

I.e. I have:

 1. No original work on the hotfix. As determined by comparing the
    patch-id output of @{u}.. and ..@{u} and seeing if the patch ids I
    have cherry-picked are from commits that exist since there was last
    a full rollout.

 2. Original work during the hotfix on top of "prod", which we'll then
    want in the next rollout (when it'll be synced with "master").

Only #1 should use `-s theirs -X 2`, but #2 will just use the normal
merge strategy, i.e. it's possible we'll conflict, but then we should
resolve the conflict and push the fix to "master" (or at least
explicitly decide not to keep it).

I think that supporting this use-case explicitly in git is better than
having some unintuitive workaround where I'll first need to check out
the other branch purely because git-merge has an artificial limitation
of the "ours" driver having no mode to pick the Nth commit.
