Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C8F220248
	for <e@80x24.org>; Sat, 20 Apr 2019 07:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfDTH7S (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Apr 2019 03:59:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44527 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfDTH7R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Apr 2019 03:59:17 -0400
Received: by mail-ed1-f67.google.com with SMTP id i13so5994221edf.11
        for <git@vger.kernel.org>; Sat, 20 Apr 2019 00:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RoUl//LpQtRPb2fe+YC+KFnGopBzT/IBSfXSXqcF7QE=;
        b=EZOJLvT0pyWpiDx61bdfYNbPY/7oOB3oh3Xnr1xRLvpqLG90iXPTSJOJ0cHgMnXvAa
         DE4LrhlcJKlHQSJxHySCGKkTYpV72z3142gKJ7IPE3uruyMNI3/IBEH2Nh+vHZtCfPgR
         22bgHzPCrgwgyP8q9ELWT8cQqLvpffPIbAlnzK/ClsTUuFwcvaZYtJHFLGTzf09gKo2w
         OybRS9BAzS8XulB68w1m2gPY1bgoGPZXb4B19rAOG/UzSvEmW6ILkm1Ol442S5pq4vHo
         JPLqDNsuCQ3rQocDFZP8qsRp8zR2tkKYLQ67H/9eM38/6aY8A3Q4j0v8l/e9w6R2nQIk
         dbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=RoUl//LpQtRPb2fe+YC+KFnGopBzT/IBSfXSXqcF7QE=;
        b=s6Yayqo8a9ofIHTZ3AxNPR0uf+zeTFhhtKDBdLGPhzx7JY19ib1SNlklhf2CfPVJSx
         BP/kJmzsmmGjEsNlWMaKTrP5c7KYKzPIkSY6yIpzU+0lPz1mV08LdjcnMeWxbNWpIGvi
         czIBF+HPpbnV866tPtu48hHdtg6XJFJi4Yy/SBh7mMakGepliZvp/xu3Rh0UbK/l6WqM
         nwpRloF8ZZSx7CChubyj26Gul0huXTbtX/uo/3XzsUcXOiYzPTzAYd1IsYZKQfMCVhr7
         xEO3rhuKnW5F+w0yux++OdeZ/0ldj+PPaDuVs/NTOvEtG49tJKBWho92Hboy2AmFaz8s
         r6Iw==
X-Gm-Message-State: APjAAAUr9rM4B2TPOKZ8+F5TbEa9opNVVzyzBERYtjcD0UfpK05E8s4C
        2jUhynU1x8GOO0NA2hP3qRs=
X-Google-Smtp-Source: APXvYqxAg2mZ+4glfVfOQ+HJiNjGOA3eJJLXS6hiLv0a+eKfqwRy/PBshm42a3KrNVjEn9nJKP+gQQ==
X-Received: by 2002:a17:906:4bc3:: with SMTP id x3mr4049987ejv.150.1555747155037;
        Sat, 20 Apr 2019 00:59:15 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id ka15sm43876ejb.11.2019.04.20.00.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 00:59:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Resolving deltas dominates clone time
References: <259296914.jpyqiltySj@mfick-lnx> <20190420035825.GB3559@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190420035825.GB3559@sigill.intra.peff.net>
Date:   Sat, 20 Apr 2019 09:59:12 +0200
Message-ID: <874l6tayzz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 20 2019, Jeff King wrote:

> On Fri, Apr 19, 2019 at 03:47:22PM -0600, Martin Fick wrote:
>
>> I have been thinking about this problem, and I suspect that this compute=
 time
>> is actually spent doing SHA1 calculations, is that possible? Some basic =
back
>> of the envelope math and scripting seems to show that the repo may actua=
lly
>> contain about 2TB of data if you add up the size of all the objects in t=
he
>> repo. Some quick research on the net seems to indicate that we might be =
able
>> to expect something around 500MB/s throughput on computing SHA1s, does t=
hat
>> seem reasonable? If I really have 2TB of data, should it then take around
>> 66mins to get the SHA1s for all that data? Could my repo clone time real=
ly be
>> dominated by SHA1 math?
>
> That sounds about right, actually. 8GB to 2TB is a compression ratio of
> 250:1. That's bigger than I've seen, but I get 51:1 in the kernel.
>
> Try this (with a recent version of git; your v1.8.2.1 won't have
> --batch-all-objects):
>
>   # count the on-disk size of all objects
>   git cat-file --batch-all-objects --batch-check=3D'%(objectsize) %(objec=
tsize:disk)' |
>   perl -alne '
>     $repo +=3D $F[0];
>     $disk +=3D $F[1];
>     END { print "$repo / $disk =3D ", $repo/$disk }
>   '
>
> 250:1 isn't inconceivable if you have large blobs which have small
> changes to them (and at 8GB for 8 million objects, you probably do have
> some larger blobs, since the kernel is about 1/8th the size for the same
> number of objects).
>
> So yes, if you really do have to hash 2TB of data, that's going to take
> a while. "openssl speed" on my machine gives per-second speeds of:
>
> type             16 bytes     64 bytes    256 bytes   1024 bytes   8192 b=
ytes  16384 bytes
> sha1            135340.73k   337086.10k   677821.10k   909513.73k  100752=
8.62k  1016916.65k
>
> So it's faster on bigger chunks, but yeah 500-1000MB/s seems like about
> the best you're going to do. And...
>
>> I mention 1.8.2.1 because we have many old machines which need this. How=
ever,
>> I also tested this with git v2.18 and it actually is much slower even
>> (~140mins).
>
> I think v2.18 will have the collision-detecting sha1 on by default,
> which is slower. Building with OPENSSL_SHA1 should be the fastest (and
> are those numbers above). Git's internal (but not collision detecting)
> BLK_SHA1 is somewhere in the middle.
>
>> Any advice on how to speed up cloning this repo, or what to pursue more
>> in my investigation?
>
> If you don't mind losing the collision-detection, using openssl's sha1
> might help. The delta resolution should be threaded, too. So in _theory_
> you're using 66 minutes of CPU time, but that should only take 1-2
> minutes on your 56-core machine. I don't know at what point you'd run
> into lock contention, though. The locking there is quite coarse.

There's also my (been meaning to re-roll)
https://public-inbox.org/git/20181113201910.11518-1-avarab@gmail.com/
*that* part of the SHA-1 checking is part of what's going on here. It'll
help a *tiny* bit, but of course is part of the "trust remote" risk
management...

> We also hash non-deltas while we're receiving them over the network.
> That's accounted for in the "receiving pack" part of the progress meter.
> If the time looks to be going to "resolving deltas", then that should
> all be threaded.
>
> If you want to replay the slow part, it should just be index-pack. So
> something like (with $old as a fresh clone of the repo):
>
>   git init --bare new-repo.git
>   cd new-repo.git
>   perf record git index-pack -v --stdin <$old/.git/objects/pack/pack-*.pa=
ck
>   perf report
>
> should show you where the time is going (substitute perf with whatever
> profiling tool you like).
>
> As far as avoiding that work altogether, there aren't a lot of options.
> Git clients do not trust the server, so the server sends only the raw
> data, and the client is responsible for computing the object ids. The
> only exception is a local filesystem clone, which will blindly copy or
> hardlink the .pack and .idx files from the source.
>
> In theory there could be a protocol extension to let the client say "I
> trust you, please send me the matching .idx that goes with this pack,
> and I'll assume there was no bitrot nor trickery on your part". I
> don't recall anybody ever discussing such a patch in the past, but I
> think Microsoft's VFS for Git project that backs development on Windows
> might do similar trickery under the hood.

I started to write:

    I wonder if there's room for some tacit client/server cooperation
    without such a protocol change.

    E.g. the server sending over a pack constructed in such a way that
    everything required for a checkout is at the beginning of the
    data. Now we implicitly tend to do it mostly the other way around
    for delta optimization purposes.

    That would allow a smart client in a hurry to index-pack it as they
    go along, and as soon as they have enough to check out HEAD return
    to the client, and continue the rest in the background

But realized I was just starting to describe something like 'clone
--depth=3D1' followed by a 'fetch --unshallow' in the background, except
that would work better (if you did "just the tip" na=C3=AFvely you'd get
'missing object' on e.g. 'git log', with that ad-hoc hack we'd need to
write out two packs etc...).

    $ rm -rf /tmp/git; time git clone --depth=3D1 https://chromium.googleso=
urce.com/chromium/src /tmp/git; time git -C /tmp/git fetch --unshallow
    Cloning into '/tmp/git'...
    remote: Counting objects: 304839, done
    remote: Finding sources: 100% (304839/304839)
    remote: Total 304839 (delta 70483), reused 204837 (delta 70483)
    Receiving objects: 100% (304839/304839), 1.48 GiB | 19.87 MiB/s, done.
    Resolving deltas: 100% (70483/70483), done.
    Checking out files: 100% (302768/302768), done.

    real    2m10.223s
    user    1m2.434s
    sys     0m15.564s
    [not waiting for that second bit, but it'll take ages...]

I think just having a clone mode that did that for you might scratch a
lot of people's itch. I.e. "I want full history, but mainly want a
checkout right away, so background the full clone".

But at this point I'm just starting to describe some shoddy version of
Documentation/technical/partial-clone.txt :), OTOH there's no "narrow
clone and fleshen right away" option.

On protocol extensions: Just having a way to "wget" the corresponding
*.idx file from the server would be great, and reduce clone times by a
lot. There's the risk of trusting the server, but most people's use-case
is going to be pushing right back to the same server, which'll be doing
a full validation.

We could also defer that validation instead of skipping it. E.g. wget
*.{pack,idx} followed by a 'fsck' in the background. I've sometimes
wanted that anyway, i.e. "fsck --auto" similar to "gc --auto"
periodically to detect repository bitflips.

Or, do some "narrow" validation of such an *.idx file right
away. E.g. for all the trees/blobs required for the current checkout,
and background the rest.
