Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35E5B1F4B6
	for <e@80x24.org>; Tue, 14 May 2019 10:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfENKdQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 06:33:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38975 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfENKdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 06:33:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id e24so22129985edq.6
        for <git@vger.kernel.org>; Tue, 14 May 2019 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uGF3mN0YHs+zrHsdAyWwoH4y4iAAdAW3v+HXc9RjvaQ=;
        b=UGolxDYYbeyTeHYDr4VwwIpO0G3JVGlsyHDEw+bo0zBTmCbfiWbjBw8EH3Qve022f+
         lgzy56K3FVIDgBWiessOc+hkgCKv7HodIWo4KaEmTvmcLN45FihY4ep3v4Ti3IorD9rz
         Ih10SW909yHKHINGcc66dwiT0XPu2WVq3ztDELB+gmIaAzf0XH+F9pGIFNO+RH4lfJv+
         22ffkt+H47juFrtEoE+v22ZbpyOfCHexItyMq52Civ6Fsr64R9B2V2RVVK6MVwpsw8w2
         VqQ/CGysdJvunBpwpOGfnKCBRmcA+w2RlD6zvbAs+NGgbseujMr+bDK310CQi7zT6fxd
         REcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=uGF3mN0YHs+zrHsdAyWwoH4y4iAAdAW3v+HXc9RjvaQ=;
        b=YfnbI/7SI95FoU9rOU/seF0wVHOkTjXoKosKeCK2iDXwDe7xxjYzw72znEe+O8S398
         lAMJgUcpen1JkHl9ATagHO23K7+MJQPYBN7TVEC/bbihPAVsAYXOyrDKiFfLh20KmnO6
         H9Lyr+hi2gKleK9uHEwvca3Z48D8r63A/3qXKpXIETImSYqZxrsHif+cHETqiv80Z1o2
         DQPjJhPsP0AYdAOktoX7fROSpfU/JQpgfJnUfpUlzYGvHQaPT3LGWKGnMEIKpKwRP57F
         RvkOmIw2a82XcHIPMTS68cdLg3v+OlU6y91T8XStsjSj7HQ8cKIvi2kTsmCS1tOq95bx
         oT2Q==
X-Gm-Message-State: APjAAAUkrnwFknxGRksXgJkXYc7kIpHDv7hM/AKWmRyvlydCMbw4IdjW
        VubpvHGVfBpZ1s0PV9FFNA4AP3GfCjg=
X-Google-Smtp-Source: APXvYqypXDf0Mx7VzlxJCRaFsRKS/HA75zT+DsVeOUL3RZlzU4URfAEXbdqT7u3knOBI4ncB2Tdyzw==
X-Received: by 2002:a50:90af:: with SMTP id c44mr34630991eda.206.1557829993705;
        Tue, 14 May 2019 03:33:13 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id p52sm4420188eda.79.2019.05.14.03.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 03:33:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-server-info: avoid needless overwrites
References: <20190511013455.5886-1-e@80x24.org>
        <87v9ygwoj0.fsf@evledraar.gmail.com>
        <20190512040825.GA25370@sigill.intra.peff.net>
        <87tve0w3ao.fsf@evledraar.gmail.com>
        <20190514094729.GA12256@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190514094729.GA12256@sigill.intra.peff.net>
Date:   Tue, 14 May 2019 12:33:11 +0200
Message-ID: <87imudwck8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 14 2019, Jeff King wrote:

> On Sun, May 12, 2019 at 09:16:31AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > You're probably right (especially because we'd just spent O(n) work
>> > generating the candidate file). But note that I have seen pathological
>> > cases where info/refs was gigabytes.
>>
>> Wouldn't those users be calling update-server-info from something like a
>> post-receive hook where they *know* the refs/packs just got updated?
>>
>> Well, there is "transfer.unpackLimit" to contend with, but that's just
>> for "packs are same", not "refs are same", and that file's presumably
>> much smaller.
>
> Yeah, I think there's sort of an open question here of who is calling
> update-server-info when nothing got updated. I think the only place we
> call it automatically is via receive-pack, but I'd guess Eric runs it as
> part of public-inbox scripts.
>
> I agree that this is probably mostly about info/packs. Not every push
> (or repo update) will create one, but every push _should_ be changing a
> ref (if it succeeds at all).  And I'd guess Eric's interest comes from
> the use of Git in public-inbox, which is going to make frequent but
> small updates.
>
> So this does seem like a really niche case; it avoids one single HTTP
> request of a small that should generally be small (unless you're letting
> your pack list grow really big, but I think there are other issues with
> that) in a case that we know will generate a bunch of other HTTP traffic
> (if somebody updated the server info, there was indeed a push, so you'd
> get a refreshed info/refs and presumably the new loose objects).
>
> That said, the logic to preserve the mtime is pretty straightforward, so
> I don't mind it too much if Eric finds this really improves things for
> him.
>
>> > I don't think our usual dot-locking is great here. What does the
>> > race-loser do when it can't take the lock? It can't just skip its
>> > update, since it needs to make sure that its new pack is mentioned.
>>
>> Right, I mean a *global* .git/I_AM_DOING_WRITES.lock, because there's no
>> way to square the ref backend's notion of per-ref ref lock enabling
>> concurrent pushes with update-server-info's desire to generate metadata
>> showing *all* the refs.
>
> OK. I agree that would work, but it's nasty to delay user-initiated
> operations for ongoing maintenance (another obvious place to want such a
> lock is for pruning, which can take quite a while).
>
>> > So it has to wait and poll until the other process finishes. I guess
>> > maybe that isn't the end of the world.
>>
>> If "its" is update-server-info this won't work. It's possible for two
>> update-server-info processes to be racing in such a way that their
>> for_each_ref() reads a ref at a given value that'll be updated 1
>> millisecond later, but to then have that update's update-server-info
>> "win" the race to update the info files (hypothetical locks on those
>> info files and all).
>>
>> Thus the "info" files will be updated to old values, since we'll see we
>> need changes, but change things to the old values.
>>
>> All things that *can* be dealt with in some clever ways, but I think
>> just further proof nobody's using this for anything serious :)
>>
>> I.e. the "commit A happened before B" but also "commit B's post-* hooks
>> finished after A" is a thing that happens quite frequently (per my
>> logs).
>
> I think it would work because any update-server-info, whether from A or
> B, will take into account the full current repo state (and we don't look
> at that state until we take the lock). So you might get an interleaved
> "A-push, B-push, B-maint, A-maint", but that's OK. A-maint will
> represent B's state when it runs.

Maybe we're talking about different things. I mean the following
sequence:

 1. Refs "X" and "Y" are at X=3DA Y=3DA
 2. Concurrent push #1 happens, updating X from A..F
 3. Concurrent push #2 happens, updating Y from A..F
 4. Concurrent push #1 succeeds
 5. Concurrent push #1 starts update-server-info. Reads X=3DF Y=3DA
 5. Concurrent push #2 succeeds
 6. Concurrent push #2 starts update-server-info. Reads X=3DF Y=3DF
 7. Concurrent push #2's update-server-info finishes, X=3DF Y=3DF written t=
o "info"
 8. Concurrent push #1's update-server-info finishes, X=3DA Y=3DF written t=
o "info"

I.e. because we have per-ref locks and no lock at all on
update-server-info (but that would need to be a global ref lock, not
just on the "info" files) we can have a push that's already read "X"'s
value as "A" while updating "Y" win the race against an
update-server-info that updated "X"'s value to "F".

It will get fixed on the next push (at least as far as "X"'s value
goes), but until that time dumb clients will falsely see that "X" hasn't
been updated.

>> > I'm not entirely sure of all of the magic that "stale" check is trying
>> > to accomplish. I think there's some bits in there that try to preserve
>> > the existing ordering, but I don't know why anyone would care (and the=
re
>> > are so many cases where the ordering gets thrown out that I think
>> > anybody who does care is likely to get disappointed).
>>
>> My reading of it is that it's premature optimization that can go away
>> (and most of it has already), for "it's cheap" and "if not it's called
>> from the 'I know I had an update'" hook case, as noted above.<
>
> That's my reading, too, but I didn't want to be responsible for
> regressing some obscure case. At least Eric seems to _use_
> update-server-info. ;)

Yeah I agree with that sentiment. I don't use it. I was just wondering
if for those who still want it this wasn't a relatively obscure
use-case, so it should perhaps be hidden behind an option if there were
optimization concerns.
