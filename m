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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A1D41F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 18:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfDVSBX (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 14:01:23 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:38286 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbfDVSBW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 14:01:22 -0400
Received: by mail-ed1-f53.google.com with SMTP id c1so4154496edk.5
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 11:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=YAWlAlZQ5wLlEiWxfLDK9Llnzeh8N24eH2siBhluKb4=;
        b=XieK6zQy3LrsZZLIi0oEaPTlQGVdV0Np/kaxJbnVeMi6G0lMpZe9PBROts3uL8c68k
         SzPE1d0PBh544vlqfMIfAyOrcQJQ3xlHcH34ErqQlfkTvMX6VHUqOs5A1lQaQhvDzDks
         2qgZIDUHb+hT3f6syreVjxPDCojzbQ4jwlupb5yWGYfwu1XzSnNOmGOR6NkelsP0Pnsq
         BFE1a05na6VwIdhIk0EPKE9rpAp7TOv9/7CuuEqtjAGXqiP0jc6LPGIalug635jv15KS
         +gWnawAYYgY0t9xDNxO1HSx6R0HZKlKzKQg+SEeTnnaDl/aPYk/wLlwBwH+oyfoBm+cL
         2j9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=YAWlAlZQ5wLlEiWxfLDK9Llnzeh8N24eH2siBhluKb4=;
        b=dYQGoR6Hj7RH/OeNYUkac9+1fHvTLoq28Pj/Hr8d1n3dosn7X5Q3ZxFcCyyjAx1/Fk
         MhG6V+wo52brB6zX+z82jtnK1S1Cdwy0DkVW8uzknznWZ2dMBWcS/Zp58spfNM+xbrVf
         L64UIrPNkTJ+R38wQiSUEHF9g0/Qs+0niXZC//2vosUezDqoyJT9+jo9+Au4m0Mk/EgR
         zUPRjOZ2A+KD2+hwaY3wFn1tcBQFFXfH9YcXOpUzm5iW/Jzi67PeUvQVgZY2eYb6g1va
         okGMeEN7brLmfNLsWVbi61xGQYjJMdpTJFHN7/oazuyS0xPpJxhYtC5wpbN/5ZTo/hn6
         oK+A==
X-Gm-Message-State: APjAAAWP1OgcCuksDAjMjarGPi5Q/IMTdMzj5qQSKpbizVo9N7wC8pKX
        nrfacQc0rsRFOiFdQK51peSrlcAP
X-Google-Smtp-Source: APXvYqzl1BNhAIUplp0+xbwELYN6druccQ6SdwgbwKO0DLEruON1Bs/j9VEYjvPik/U/jQGMrRYnSg==
X-Received: by 2002:a50:a705:: with SMTP id h5mr12914740edc.226.1555956078953;
        Mon, 22 Apr 2019 11:01:18 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id r24sm356372ejo.84.2019.04.22.11.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 11:01:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Git Mailing List <git@vger.kernel.org>,
        "Jansen\, Geert" <gerardu@amazon.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Resolving deltas dominates clone time
References: <259296914.jpyqiltySj@mfick-lnx> <20190420035825.GB3559@sigill.intra.peff.net> <874l6tayzz.fsf@evledraar.gmail.com> <20190422155716.GA9680@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190422155716.GA9680@sigill.intra.peff.net>
Date:   Mon, 22 Apr 2019 20:01:15 +0200
Message-ID: <874l6pudg4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 22 2019, Jeff King wrote:

> On Sat, Apr 20, 2019 at 09:59:12AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > If you don't mind losing the collision-detection, using openssl's sha1
>> > might help. The delta resolution should be threaded, too. So in _theor=
y_
>> > you're using 66 minutes of CPU time, but that should only take 1-2
>> > minutes on your 56-core machine. I don't know at what point you'd run
>> > into lock contention, though. The locking there is quite coarse.
>>
>> There's also my (been meaning to re-roll)
>> https://public-inbox.org/git/20181113201910.11518-1-avarab@gmail.com/
>> *that* part of the SHA-1 checking is part of what's going on here. It'll
>> help a *tiny* bit, but of course is part of the "trust remote" risk
>> management...
>
> I think we're talking about two different collision detections, and your
> patch wouldn't help at all here.
>
> Your patch is optionally removing the "woah, we got an object with a
> duplicate sha1, let's check that the bytes are the same in both copies"
> check. But Martin's problem is a clone, so we wouldn't have any existing
> objects to duplicate in the first place.

Right, but we do anyway, as reported by Geert at @amazon.com preceding
that patch of mine. But it is 99.99% irrelevant to *performance* in this
case after the loose object cache you added (but before that could make
all the difference depending on the FS).

I just mentioned it to plant a flag on another bit of the code where
index-pack in general has certain paranoias/validation the user might be
willing to optionally drop just at "clone" time.

> The problem in his case is literally just that the actual SHA-1 is
> expensive, and that can be helped by using the optimized openssl
> implementation rather than the sha1dc (which checks not collisions with
> objects we _have_, but evidence of somebody trying to exploit weaknesses
> in sha1).
>
> One thing we could do to make that easier is a run-time flag to switch
> between sha1dc and a faster implementation (either openssl or blk_sha1,
> depending on the build). That would let you flip the "trust" bit per
> operation, rather than having it baked into your build.

Yeah, this would be neat.

> (Note that the oft-discussed "use a faster sha1 implementation for
> checksums, but sha1dc for object hashing" idea would not help here,
> because these really are object hashes whose time is dominating. We have
> to checksum 8GB of raw packfile but 2TB of object data).
>
>> I started to write:
>>
>>     I wonder if there's room for some tacit client/server cooperation
>>     without such a protocol change.
>>
>>     E.g. the server sending over a pack constructed in such a way that
>>     everything required for a checkout is at the beginning of the
>>     data. Now we implicitly tend to do it mostly the other way around
>>     for delta optimization purposes.
>>
>>     That would allow a smart client in a hurry to index-pack it as they
>>     go along, and as soon as they have enough to check out HEAD return
>>     to the client, and continue the rest in the background
>
> Interesting idea. You're not reducing the total client effort, but
> you're improving latency of getting the user to a checkout. Of course
> that doesn't help if they want to run "git log" as their first
> operation. ;)
>
>> But realized I was just starting to describe something like 'clone
>> --depth=3D1' followed by a 'fetch --unshallow' in the background, except
>> that would work better (if you did "just the tip" na=C3=AFvely you'd get
>> 'missing object' on e.g. 'git log', with that ad-hoc hack we'd need to
>> write out two packs etc...).
>
> Right, that would work. I will note one thing, though: the total time to
> do a 1-depth clone followed by an unshallow is probably much higher than
> doing the whole clone as one unit, for two reasons:

Indeed. The hypothesis is that the user doesn't really care about the
clone-time, but the clone-to-repo-mostly-usable time.

>   1. The server won't use reachability bitmaps when serving the
>      follow-up fetch (because shallowness invalidates the reachability
>      data they're caching), so it will spend much more time in the
>      "Counting objects" phase.
>
>   2. The server has to throw away some deltas. Imagine version X of a
>      file in the tip commit is stored as a delta against version Y in
>      that commit's parent. The initial clone has to throw away the
>      on-disk delta of X and send you the whole object (because you are
>      not requesting Y at all). And then in the follow-up fetch, it must
>      either send you Y as a base object (wasting bandwidth), or it must
>      on-the-fly generate a delta from Y to X (wasting CPU).
>
>> But at this point I'm just starting to describe some shoddy version of
>> Documentation/technical/partial-clone.txt :), OTOH there's no "narrow
>> clone and fleshen right away" option.
>
> Yes. And partial-clone suffers from the problems above to an even
> greater extent. ;)
>
>> On protocol extensions: Just having a way to "wget" the corresponding
>> *.idx file from the server would be great, and reduce clone times by a
>> lot. There's the risk of trusting the server, but most people's use-case
>> is going to be pushing right back to the same server, which'll be doing
>> a full validation.
>
> One tricky thing is that the server may be handing you a bespoke .pack
> file. There is no matching ".idx" at all, neither in-memory nor on disk.
> And you would not want the whole on-disk .pack/.idx pair from a site
> like GitHub, where there are objects from many forks.
>
> So in general, I think you'd need some cooperation from the server side
> to ask it to generate and send the .idx that matches the .pack it is
> sending you. Or even if not the .idx format itself, some stable list of
> sha1s that you could use to reproduce it without hashing each
> uncompressed byte yourself.

Yeah, depending on how jt/fetch-cdn-offload is designed (see my
https://public-inbox.org/git/87k1hv6eel.fsf@evledraar.gmail.com/) it
could be (ab)used to do this. I.e. you'd keep a "base" *.{pack,idx}
around for such a purpose.

So in such a case you'd serve up that recent-enough *.{pack,idx} for the
client to "wget", and the client would then trust it (or not) and do the
equivalent of a "fetch" from that point to be 100% up-to-date.

> This could even be stuffed into the pack format and stripped out by
> the receiving index-pack (i.e., each entry is prefixed with "and by
> the way, here is my sha1...").

That would be really interesting. I.e. just having room for that (or
anything else) in the pack format.

I wonder if it could be added to the delta-chain in the current format
as a nasty hack :)

>> We could also defer that validation instead of skipping it. E.g. wget
>> *.{pack,idx} followed by a 'fsck' in the background. I've sometimes
>> wanted that anyway, i.e. "fsck --auto" similar to "gc --auto"
>> periodically to detect repository bitflips.
>>
>> Or, do some "narrow" validation of such an *.idx file right
>> away. E.g. for all the trees/blobs required for the current checkout,
>> and background the rest.
>
> The "do we have all of the objects we need" is already separate from
> "figure out the sha1 of each object", so I think you'd get that
> naturally if you just took in an untrusted .idx (it also demonstrates
> that any .idx cost is really focusing on blobs, because the "do we have
> all objects" check is going to decompress every commit and tree in the
> repo anyway).
>
> -Peff
