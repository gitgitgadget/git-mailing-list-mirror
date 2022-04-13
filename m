Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBD2C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 16:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbiDMQYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiDMQYX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 12:24:23 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642DC2E083
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1649866908;
        bh=hffIhZypjUS3lIqn+H1+esPymrr04xn1xinnVuqusFI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=J/G4SspNXZd2JJglLxwo2It+gBEYGsvOdlIsy8TH/QGSnyxgKGVlYfTSUUq4o+dqY
         /cL+yBZLRgh7Jh8dv3rDMe4YXsrxEYqBGuQqeBv+5+1KAUTHYxtuiH7vPP1kHQq/JW
         r+GnRPT1oLZOVyL6Nawmc9HC7kQVoQ5H7FFSw/Dw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFJnh-1nlUJR0L3h-00FrXB; Wed, 13
 Apr 2022 18:21:48 +0200
Message-ID: <d804fd56-ce41-f7c0-23bc-9e9d14f6b200@web.de>
Date:   Wed, 13 Apr 2022 18:21:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: reference-transaction regression in 2.36.0-rc1
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
References: <CAGyf7-GYYA2DOnAVYW--=QEc2WjSHzUhp2OQyuyOr3EOtFDm6g@mail.gmail.com>
 <CAGyf7-GaoBarXD2xKG3KUXwGZgbhKgv-4Mz45achbr6G9ihTBQ@mail.gmail.com>
 <220413.86r161f3qp.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220413.86r161f3qp.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sXdN9p56sxN8JmwP8UDHa9fp4RCBWmAzdRSTXVNkm2FoeBgmHBF
 Sq6OAVVV0kAy7NeBlkBWrTAvVyGkMg/FSrUhOt9+4lLXt/DKU1yJRDb8bWa+u/KsR+OTEaA
 VNR4oeEAPKKF1QXeTIwz7PfZj7Dkfm2verlbnVOXLwf3A8nCppmAhQEkj0kqBRygm417Tuo
 PXHHMzkvLgvRyLfEGGp9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Ulm2dStruA=:W+RNiwU0K1GC64R/xMk0cq
 D/Tk/98lUrtTHMR4PGZnow5e35gmTjSwE3hyM0HBRTP9nYGvP90t3HJfPsd9UTMCNLJo24hwo
 42/+f+YVKDOPpriS/Iq4AZKTFOHDj8G5UABjf/Xyi1uY/byi31L+POQ31DO/YHmcvgDcqmBT3
 LXW9o70fI0+k5BLbAYioppis5B7QyflJ2sMjtBma0+wdy47hKEbLRh3tlky9qldpHje6Dc4lu
 2bLMvMFrgCQDAGzG9h7N+Bq4sTRLaSYPK/kP47/YIDEy/hn53TArgbo6Ew+oTBIyrQJGgUheq
 agOGKvadh0RkDScAxFaS/e+Xd07P2U6rVV4dz2uNwZHY5NitK6tw9j2VWWVxQdJ32YrgJY+Pd
 LNY1wgh20JVyQIf+B6vZixco2RBbXSW24+/oIAi9JD6waC+ABg/D1fruopWIO73At5MAVQzYr
 fQOFMBz20ofX2lvrZQxDfaIoPGVKmLKmg9hARior3UHt7GD0OxnuVRolznTto/ScHV++6V0sZ
 2R0bMK6xZxySgMpt/TxhV538M8mLmbJP//GoSm6gZs4b2jAyoMI4v+sWFG9rpBf/pxHCp34a3
 XSqyrQOd69dDUuvUKnQbn33qWzOlUC5hyfANoHNesNWzky6O9YWBtUvyM/VFfAxtG+EgVgs3D
 bwOSlzgSWJs9aAYIrcvXauz6hEGuIvQ0Fzuf4B3LfKWOlY3r6Gf1Xc0tU5kx0/e+k7HtQLxGq
 TFC0jMSOqON6YoSGSY0qcE5AfEfH5N6EARJ2Qve03UJU3ZOKc6VoufWadxnOESoECZl6B/jeq
 GJ9RRAjfUOcLWlQyB22WLoqQ42kh95a7jBV9P+rErVdinXgHfuKXFY60JJKFJKMfEGpbzpKf/
 pi8veN/2eaRhuuw6c/Anwg+szzxduQpdgp9Grdo/09sTqxZLV9yrGUmcl9EAgp85gdASOanZN
 j+caDaqD/LfMv7ljkU35CNwSjrTposnUIMyaxzMaTiwC/j5Y8dq9UH/ZuHlY7Tfqns8Ql3903
 L6+Tvbk/pToNQ+hxBUOd1V4mOmbBGK6RUkzj8Xy/UcQMV5k+G4pniWTiyBLP5gF1cQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.04.22 um 16:34 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Tue, Apr 12 2022, Bryan Turner wrote:
>
>> On Tue, Apr 12, 2022 at 2:20 AM Bryan Turner <bturner@atlassian.com> wr=
ote:
>>>
>>> It looks like Git 2.36.0-rc1 includes the changes to eliminate/pare
>>> back reference transactions being raised independently for loose and
>>> packed refs. It's a great improvement, and one we're very grateful
>>> for.
>>>
>>> It looks like there's a regression, though. When deleting a ref that
>>> _only_ exists in packed-refs, by the time the "prepared" callback is
>>> raised the ref has already been deleted completely. Normally when
>>> "prepared" is raised the ref is still present. The ref still being
>>> present is important to us, since the reference-transaction hook is
>>> frequently not passed any previous hash; we resolve the ref during
>>> "prepared", if the previous hash is the null SHA1, so that we can
>>> correctly note what the tip commit was when the ref was deleted.
>>
>> I've re-tested this with 2.36.0-rc2 and it has the same regression (as
>> expected). However, in playing with it more, the regression is more
>> serious than I had initially considered. It goes beyond just losing
>> access to the SHA of the tip commit for deleted refs. If a ref only
>> exists packed, this regression means vetoing the "prepared" callback
>> _cannot prevent its deletion_, which violates the contract for the
>> reference-transaction as I understand it.
>>
>> Here's a slightly modified reproduction:
>> git init ref-tx
>> cd ref-tx
>> git commit -m "Initial commit" --allow-empty
>> git branch to-delete
>> git pack-refs --all
>> echo 'exit 1;' > .git/hooks/reference-transaction
>> chmod +x .git/hooks/reference-transaction
>> git branch -d to-delete
>>
>> Running this reproduction ends with:
>> $ git branch -d to-delete
>> fatal: ref updates aborted by hook
>> $ git rev-parse to-delete --
>> fatal: bad revision 'to-delete'
>>
>> Even though the reference-transaction vetoed "prepared", the ref was
>> still deleted.
>>
>> In Bitbucket, we use the reference-transaction to perform replication.
>> When we get the "prepared" callback on one machine, we dispatch the
>> same change(s) to other replicas. Those replicas process the changes
>> and arrive at their own "prepared" callbacks (or don't), at which
>> point they vote to commit or rollback. The votes are tallied and the
>> majority decision wins.
>>
>> With this regression, that sort of setup no longer works reliably for
>> ref deletions. If the ref only exists packed, it's deleted (and
>> _visibly_ deleted) before we ever get the "prepared" callback. So if
>> coordination fails (i.e. the majority votes to rollback), even if we
>> try to abort the change it's already too late.
>
> This does look lik a series regression.
>
> I haven't had time to bisect this, but I suspect that it'll come down to
> something in the 991b4d47f0a (Merge branch
> 'ps/avoid-unnecessary-hook-invocation-with-packed-refs', 2022-02-18)
> series.

Indeed, it bisects to 2ed1b64ebd (refs: skip hooks when deleting
uncovered packed refs, 2022-01-17).

> I happen to know that Patrick is OoO until after the final v2.36.0 is
> scheduled (but I don't know for sure that we won't spot this thread &
> act on it before then).
>
> Is this something you think you'll be able to dig into further and
> possibly come up with a patch? It looks like you're way ahead of at
> least myself in knowing how this *should* work :)
