Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68B4A1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 14:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965094AbeAJOB3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 09:01:29 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:44168 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbeAJOBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 09:01:25 -0500
Received: by mail-wm0-f41.google.com with SMTP id t8so26965191wmc.3
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 06:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4qQtKrTfiFFkNuSaxV8VH54QRQ0A+TXMYItHZoI/Jns=;
        b=HaLyGi4TdmxFUk4azI6MyPrZEW5YX3OTnRoQx66xaLu3m26/ql2RCxt6dNF5FNx+ZJ
         KE7ijgFP5oB/hxsJlc+S7KCle/qX+w7jKQz1B4nS1AhB5dQhiqiUUghibY8X8s9duABV
         cFQ7wOLxHmSjz/8P7FoFgEJfbPgjnjojogZlgZAup0lTbOqjAfG9zXudW7D2bIEe9ncj
         bTu0kDdyv6QoMb/gQ40O0Wed1o8p+R8Ganl0jHGTBlC8WXuzid4BijlAGMEnM6Xf79ur
         K2teMoZv0KwJUMaMZoBgJR3EXoI3tIR/W7F2tJcTkfC+NixCE0NTiaEwyt/z0Z7suHpQ
         6cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=4qQtKrTfiFFkNuSaxV8VH54QRQ0A+TXMYItHZoI/Jns=;
        b=DKIOxkDxb2ABOhihOpbHesLmINXORXM4oDUj953PAgPGZvnat/fR5m65Ho2F+6hXpk
         sre31gEUiJYFOwaRXK3VcaUYvNyGe1I1ej34rdTFKyqYg+mXdhEsgAsFLpLCC8xZsF9C
         QOtfq4VzY8LgG6eHjMX+CcfRUMG3glowzYHokrZXRbW6aeOr1PfbIkrzx5/6R0hx65dU
         g/HGGzb/JYp2BNjY5or/CywgQkwymlnIgLHG3sV8NzZirsupAORTDAt+fpz5tdbq1EXE
         swEWvNzSICsBH8eU8U/j7GcpelzvRH4Bagt8u59gcM0asPw2nQK7a/AzZCv4nIN81qsW
         quhw==
X-Gm-Message-State: AKwxytcko4IuaYYcc+B4f5pzpCzugbU2FAk/HcSNlkBHiI5s5vvK6ozw
        pxDD517ajxcQfuspqE1wbza2ItS/
X-Google-Smtp-Source: ACJfBoszLleP+hyCTVQr3bhuvUclcJvWJC9XeBQz+0i2lNk13eaAcH2jhQvZ8PbGsHw1EozUBRwVWQ==
X-Received: by 10.80.135.156 with SMTP id a28mr2217658eda.51.1515592884304;
        Wed, 10 Jan 2018 06:01:24 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id e46sm11076796edb.93.2018.01.10.06.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jan 2018 06:01:23 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: merge-base --is-ancestor A B is unreasonably slow with unrelated history B
References: <87608bawoa.fsf@evledraar.gmail.com> <2aa20617-6b1d-f5a4-d6e1-250a3ea8f5be@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <2aa20617-6b1d-f5a4-d6e1-250a3ea8f5be@gmail.com>
Date:   Wed, 10 Jan 2018 15:01:22 +0100
Message-ID: <87o9m1ak3x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 09 2018, Derrick Stolee jotted:

> On 1/9/2018 10:17 AM, Ævar Arnfjörð Bjarmason wrote:
>> This is a pathological case I don't have time to dig into right now:
>>
>>      git branch -D orphan;
>>      git checkout --orphan orphan &&
>>      git reset --hard &&
>>      touch foo &&
>>      git add foo &&
>>      git commit -m"foo" &&
>>      time git merge-base --is-ancestor master orphan
>>
>> This takes around 5 seconds on linux.git to return 1. Which is around
>> the same time it takes to run current master against the first commit in
>> linux.git:
>>
>>      git merge-base --is-ancestor 1da177e4c3f4 master
>>
>> This is obviously a pathological case, but maybe we should work slightly
>> harder on the RHS of and discover that it itself is an orphan commit.
>>
>> I ran into this while writing a hook where we'd like to do:
>>
>>      git diff $master...topic
>>
>> Or not, depending on if the topic is an orphan or just something
>> recently branched off, figured I could use --is-ancestor as on
>> optimization, and then discovered it's not much of an optimization.
>
> Ævar,
>
> This is the same performance problem that we are trying to work around
> with Jeff's "Add --no-ahead-behind to status" patch [1]. For commits
> that are far apart, many commits need to be parsed. I think the right
> solution is to create a serialized commit graph that stores the
> adjacency information of the commits and can create commit structs
> quickly. This requires storing the commit id, commit date, parents,
> and root tree id to satisfy the needs of parse_commit_gently(). Once
> the framework for this data is constructed, it is simple to add
> generation numbers to that data and start consuming them in other
> algorithms (by adding the field to 'struct commit').
>
> I'm working on such a patch right now, but it will be a few weeks
> before I'm ready.

Thanks, yes of course I forgot about not being able to rely on
timestamps at all, otherwise this check wouldn't need commit traversal
at all, we could simply note:

 1. A is older than B
 2. B is an orphan commit
 3. Therefore it's impossible that A is an ancestor of B

But we don't enforce any of this in the DAG, so now we need to do a full
traversal to make sure this B committed in 2018 doesn't precede some
commit added in 2005.

This has come up before related to various traversal optimizations,
e.g. [tag|branch] --contains.

I don't know the details of what you have in mind, but have you
considered a solution which involves either computing that all commits
in the repo have a timestamp later than their parents, or alternatively
declaring via some config mechanism that that's true of all (or a subset
of) commits?

E.g. for centrally hosted repos a pre-receive hook could be added to
assert that all incoming commits must have monotonically increasing
timestamps compared to preceding commits, and if that wasn't the case we
could declare that e.g. all commits added after 2019 would have that
property (after ensuring no commits had dates in the future).

It sounds like a subset of what you have in mind, so maybe it's
useless. However for many cases such as this one it should be faster to
almost instantaneously consult such config instead of some side-data we
need to maintain, but it's probably not worth the complexity.


> [1] v5 of --no-ahead-behind
> https://public-inbox.org/git/20180109185018.69164-1-git@jeffhostetler.com/T/#t
>
> [2] v4 of --no-ahead-behind
> https://public-inbox.org/git/nycvar.QRO.7.76.6.1801091744540.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz/T/#t
