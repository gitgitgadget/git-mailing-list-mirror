Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99498C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 19:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242004AbhLMTmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 14:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242455AbhLMTmL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 14:42:11 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C14C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 11:42:10 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y13so55292559edd.13
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 11:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=YwqShff3KOkjHMEVhRMAInt9VdZ171WtihPl/UG3h5M=;
        b=HW59VBxUYVPXtQFiEf5FdPx0kA1OPwIhIqPWhmdqYWFq/NTg2f3luIY216+OEft982
         5Gh/q/1SWbzJdTtqQcVgo8AhEsNBHd+EmQoa232wI0zXhE30mir0UUCOZuSFRZg+14g3
         gD9twHRy93dV/LVG9Nt7yjpsgWiGUVxHaIRSrFks4J9sG9LM/lLiCFDx0y0mznmNukJF
         3u8lnvtsiuMzj838P7xuqZv909oOvLGPy5wKPqOnoj69RT1WgOx9Ch+f+++RRsW/e3A+
         CWTmwlI705mBwDefkPtFfgxDuDh/cYFjT9xjlbKtPp2OdGQ11va3PwjAzeh/TE3ax7aJ
         fjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=YwqShff3KOkjHMEVhRMAInt9VdZ171WtihPl/UG3h5M=;
        b=lFA++VnbeHIzfpPkP5jd3m87qH/MmKA4BezFe5a20gJBV7fnkNMP2KQuVxQJbX9KVU
         R/Ccp8bBhB4gkP+hrLJOPLNOUKS1NjWmyn1CY6270Brdt0tCD8Cp3qJYyrD2v0f+14Yo
         +5poSdEaaXLXCJZZxwQHiAUTBnZ/lBfaT5dpDqMUWvXZ8f22jh/rouWdj3wfXlbX1zKQ
         Cl95NL2jC6VvX//lPMbHWVX+lEqwtD0h5SoRF62gXTn57GIDZl/g36PL+eyk9v+1zM86
         /yeUw0ymUDxnyodm071sDDdawz6ZfHTJHrv/rUgrdGij+bkNsgSFGYO3tEJESfTuzp67
         VCAA==
X-Gm-Message-State: AOAM532gYLL0Xyhb7aIuy4g/jaNDEQBdb9BQU57frlMOidmDWCGcz3iO
        hU8Eixa46rXEFgt1byhWEp8=
X-Google-Smtp-Source: ABdhPJwjN5FjIGF/TAnR9eJTqfuit9U7LpXPxZFO2gI03z324zNxUKxczJCETRkp72m/yo/F8cQqzA==
X-Received: by 2002:aa7:c7cf:: with SMTP id o15mr1164426eds.176.1639424529216;
        Mon, 13 Dec 2021 11:42:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qk9sm5972741ejc.68.2021.12.13.11.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:42:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwrD5-000vfT-OI;
        Mon, 13 Dec 2021 20:42:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 10/13] test-lib-functions: add and use a "write_hook"
 wrapper
Date:   Mon, 13 Dec 2021 20:37:08 +0100
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
 <patch-10.13-ca55471d134-20211212T201308Z-avarab@gmail.com>
 <CAPig+cSkiFd27o8uACdX9ftg=N2XukqNSU_Tt+7rWT08JD7CAQ@mail.gmail.com>
 <211213.868rwo8o3q.gmgdl@evledraar.gmail.com>
 <CAPig+cTDu+gXOTeBHALCuS9ZqvuqxQW-gXdYUsyAxTOT=gHEnA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAPig+cTDu+gXOTeBHALCuS9ZqvuqxQW-gXdYUsyAxTOT=gHEnA@mail.gmail.com>
Message-ID: <211213.86v8zs70mo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 13 2021, Eric Sunshine wrote:

> On Mon, Dec 13, 2021 at 11:29 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Mon, Dec 13 2021, Eric Sunshine wrote:
>> > It's not clear whether the intention is to maintain the &&-chain in
>> > this function...
>> > ... or not care about it since it's broken here before `shift`...
>>
>> Thanks, those should all use &&-chaining. Will fix.
>
> By the way, the new chainlint could be made to catch broken &&-chains
> (and missing `|| return 1`) in test script functions, as well; it
> doesn't have to limit its checks only to tests. The reason I haven't
> done so yet is that it's not clear how much we care about &&-chains in
> functions, especially since we have _so many_ functions which don't
> maintain the &&-chain. In the long run, I think it might be beneficial
> to extend chainlint to check shell functions too, but fixing the
> &&-chains in functions probably have to be done incrementally, thus
> would likely require some sort of whitelisting or blacklisting
> mechanism until all functions have been fixed. Anyhow, it's food for
> thought.

I think doing that & phasing it in would be very useful.

E.g. if you run the tests with SANITIZE=3Dleak and
GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue in "next" now you'll find it passes,
but we'll still (especially if you log them or --verbose-log) have
memory leaks in various places still.

Those aren't new issues in anything I've done in the leak testing mode,
although I'm hoping to eventually getting around to fixing them. They're
just cases where tests pass because some function is lacking a &&.

Although to be fair the SANITIZE=3Dleak default is to die at the very end,
so if the program had something useful to do it probably got around to
doing it, but that doesn't apply when we invoke ourselves via
run-command.c (as that invocation will fail, and we'll usually abort).

But it would have been nice to have had those failures cascade up from
the functions up to the top-level.

We've also said we shouldn't use things like this, i.e. a pipe with git
on the LHS:

    git <cmd> | ... &&

But I've run into a few cases where a test succeeds, even if both
commands here die:

    test "$(git <cmd>)" =3D "$(git <cmd2>)"

Which, if we're adding more lints is maybe something to consider
too. I.e. it falls under the general umbrella of cases where we'd hide
failures in "git".

