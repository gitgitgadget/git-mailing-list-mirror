Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 581FC1F462
	for <e@80x24.org>; Thu, 23 May 2019 21:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388331AbfEWVu3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 17:50:29 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:55527 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388290AbfEWVu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 17:50:29 -0400
Received: by mail-wm1-f47.google.com with SMTP id x64so7303536wmb.5
        for <git@vger.kernel.org>; Thu, 23 May 2019 14:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=66GUWhmvhaIFVgmkI5iT0Y3DE50lFwM2EpFEzJTrAu0=;
        b=khlqKr7oRhEMCWzJEoR6e/Av2PzAoBMnGBbbfEC1FQbK9IoMFfx3EZf6UskHEgjT23
         sq6RujGvspHsZWFTIHOF/GTCnYjPyVxlVhHbkw3hSUo2eI9OqFrGCx3BOk+MOYVbSOKf
         bWR/E4FPFO9g5Coa+Q5PiXgDJab/PRYbOC3jQDDmuvA10/8tA3CD3zuKPU9P2RLBAe1A
         JOCV9u1hSYinJTKbvV9IOIZX9Y1GAAKFCgZFehP2hHG935JM0HvS45vrdgC5s672yxHv
         SohN4xJgbZhndLlkkG29EFtW+b0/tmj9whrqE1sv1NYbHBJL77O9iVEf5+KcO1gy2cF2
         Nn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=66GUWhmvhaIFVgmkI5iT0Y3DE50lFwM2EpFEzJTrAu0=;
        b=OfjG/FoyW5makpwIyFqShpcR423SVdDqJxnGDi184e6Zsz16jaJxRTHHlfMHmIvL8Z
         fyzwuUI54EXtFQuxUbsKZ1SIqllpcyNkw3pN3TriFdxlx6JAWzDL+6MDR0BWh3A/aWJn
         hgh2bgXr0ONqD0FLZ5FZNymT74fuN1Gml7a8gpqtpHdlk2jpOHVNwfFFNH8ucv0aieHd
         tzTBZrhf7aS82Jfr7leFmKqXDtvprBzYu4Mm7cIgHm/klqooWAqLgk2nm4u6OlvmjViJ
         rm83In/ghdLlmHa8wlArg5ndAjK5rTuQB4hatX/OlNdRtyrlCgDAC2BWKEKbqM8NWV4y
         +iTQ==
X-Gm-Message-State: APjAAAU6sxIHefJHlb9kUcf9kqunBO/c4qCW77w6s8pY06TGefLPbeDM
        Qa5aDKJ1HZ2Q71yjymTCu3w=
X-Google-Smtp-Source: APXvYqyf+qInMZYVjMu5PFkscyTAU4gRVJDWWyGv0VKm7zWNvaKm19ni4SAMvqSwHMWT5g5aVLE1Cg==
X-Received: by 2002:a1c:700b:: with SMTP id l11mr14291443wmc.106.1558648227039;
        Thu, 23 May 2019 14:50:27 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id b194sm501106wmb.23.2019.05.23.14.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 14:50:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "Eric S. Raymond" <esr@thyrsus.com>,
        Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Subject: Re: RFC: Separate commit identification from Merkle hashing
References: <20190521013250.3506B470485F@snark.thyrsus.com> <86h89lq96v.fsf@gmail.com> <20190523205009.GA69096@thyrsus.com> <20190523205457.GC70860@google.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190523205457.GC70860@google.com>
Date:   Thu, 23 May 2019 23:50:24 +0200
Message-ID: <87v9y0g7rz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 23 2019, Jonathan Nieder wrote:

> Eric S. Raymond wrote:
>> Jakub Narebski <jnareb@gmail.com>:
>
>>> Currently Git makes use of the fact that SHA-1 and SHA-256 identifiers
>>> are of different lengths to distinguish them (see section "Meaning of
>>> signatures") in Documentation/technical/hash-function-transition.txt
>>
>> That's the obvious hack.  As a future-proofing issue, though, I think
>> it would be unwise to count on all future hashes being of distinguishable
>> lengths.
>
> We're not counting on that.  As discussed in that section, future
> hashes can change the format.

I think both of you are also missing something that's implicit (but
unfortunately not very explicitly talked about) in that document, which
is that such hash transitions are assumed to have an out-of-bounds
temporal component to them.

I.e. let's assume that instead of SHA-256 we're switching to SHA-X,
which like SHA-1 is also a 20 byte hash function, so they're the same
length.

You'd then get a git.git with SHA-1 today, next year you'd have A
SHA-1<->SHA-X mapping table, but the year after that we'd be fully on
SHA-X for new content.

So even though we carry code and lookup table for looking up the old
SHA-1 values we're not going to continue to pointlessly generate that
bidirectional mapping forever. We'll have some sort of gravestone marker
where we say "past this point it's SHA-X only".

That's not implemented or specified yet, but could e.g. be a magic ref
of some sort advertised by the server, and the client would enforce that
such a marker could only be made with the stronger hash function.

Thus a couple of years after that the SHA-1 -> SHA-X transition someone
generating a colliding tag where a new good SHA-X tag *could* point to
bad SHA-1 content won't be exploitable in practice. At that point
clients won't be downloading SHA-1'd content or generating the mapping
table anymore.

So I don't see why a format change for the tags is needed, it would only
matter *if* we have a full collision *and* the hashes are the same
length (which we have no plan for), *and* if we assume we don't have
some other mitigations in play.
