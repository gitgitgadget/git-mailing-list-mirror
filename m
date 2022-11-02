Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2858C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 14:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKBOwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKBOwl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 10:52:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C636F2A27E
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 07:52:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f5so24421992ejc.5
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9+iHqWr4gPX69W5a0uZbHEoEef9qttRQJ3cFndEWGAU=;
        b=ndjqpq06kWX1izZoJD2jhv/taQ7nLviqNefU5A9HG1y5cuVa829XyMe/VmcEAxxb3h
         mkQWjRtQfvvuGuifl750VtbF1j4/6Sn7/Qyh1+HclLpL2i1a/9bAAQ3W+YExGNLJ9tke
         4GvnHhViXh6v9NxsHHpiErtEh9EKuKK5uIpj6b6m4mYQaKjf26JizGzs/uj0O1sq9YJC
         hSZVuc/PPXI4a1K6L3l7KAxiHznoysgBy9SVG+ri79lc4txuYa3PuOelx5SDENyP80uT
         oSA0id2zXEdo/Goh5yDwuLNxC5k3m0vT6Cwux11zKG2kLZ+UYpzMk8emingAbh2ntHnS
         x8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+iHqWr4gPX69W5a0uZbHEoEef9qttRQJ3cFndEWGAU=;
        b=jaUDOtkZ+yNrzFQo3bKJVab1IgP+0BZQg/EEqyUpGSrMZGKd1pPJDqnJetjcdHGycs
         yHvp23rjObSuR0D1jZlBSU4A0Q6qEIyNRwF+Lsr0EDAcAkYcuS3yN4unwcl9x/9a+ngR
         kF7mH+oOK8f5IeQKsX3071TD9nkTuRkTAnx1A9d0cRaBFu7M4a3yUuq4dxjta39UDl5x
         2dLZWi8LUgv69eaIAPFmz+4j+89CJcxlEz0FENCW88+2f1rE8QbMOHhhn683UFJG292f
         HedA5ewcO6wHbFAMHM2E9i2C/XosXj9E9ee1LbCsSbwpmW401GUaxJvXUCIRhBHUphcS
         XN8A==
X-Gm-Message-State: ACrzQf0mbCXrWiWqnrQZtJdxBfYEOKgBxPQz7A0/rBYd7m0dm53+XCKK
        wviKIwfjGlIoA2Er0FFfypqbA02HsxqKLg==
X-Google-Smtp-Source: AMsMyM6mySZTigbkfvgApNJU2N3KLfsfBKylQXGkTtlNruulgoQdWGLpBDoCJBZT4mMIszJSyFyC3w==
X-Received: by 2002:a17:907:31c1:b0:742:28a3:5d08 with SMTP id xf1-20020a17090731c100b0074228a35d08mr23984822ejb.112.1667400758304;
        Wed, 02 Nov 2022 07:52:38 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r17-20020a1709061bb100b007789e7b47besm5508320ejg.25.2022.11.02.07.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:52:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqF6b-00BowM-11;
        Wed, 02 Nov 2022 15:52:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Mark Hills <mark@xwax.org>, git@vger.kernel.org,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Subject: Re: Consist timestamps within a checkout/clone
Date:   Wed, 02 Nov 2022 15:45:17 +0100
References: <2210311614160.25661@stax.localdomain>
 <c060312e-0d35-8439-85dd-920b172c90be@xiplink.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <c060312e-0d35-8439-85dd-920b172c90be@xiplink.com>
Message-ID: <221102.86leot2ytm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 01 2022, Marc Branchaud wrote:

> On 2022-10-31 15:01, Mark Hills wrote:
>> Our use case: we commit some compiled objects to the repo, where compiling
>> is either slow or requires software which is not always available.
>> Since upgrading Git 2.26.3 -> 2.32.4 (as part of Alpine Linux OS
>> upgrade)
>> we are noticing a change in build behaviour.
>> Now, after a "git clone" we find the Makefile intermittently
>> attempting
>> (and failing) some builds that are not intended.
>> Indeed, Make is acting reasonably as the source file is sometimes
>> marginally newer than the destination (both checked out by Git), example
>> below.
>
> A fix for this was proposed in 2018 and dismissed [1].
>
> Back then, the problem was that as Git wrote files into a directory
> sometimes the clock would tick over at a bad time, and we'd end up
> with some files being "newer" than others.  This would sour Make runs
> as you describe.
>
> Nominally this is caused by putting generated files in the repo, but
> many times that is unavoidable (e.g. you're forking an upstream that 
> puts automake-generated stuff in the repo).
>
> IMHO, dismissing the problem back then was a mistake.  At the time I
> advocated teaching Git to give all the files it touches (creates or 
> modifies) in a directory the same mtime (e.g. the time at the start of
> the checkout operation).
>
> Instead the decision was to do nothing in Git, and instead let people
> create their own post-checkout hooks to touch the files.  I (and
> others) argued this was inadequate, to no avail.
>
> 		M.
>
> [1] https://public-inbox.org/git/20180413170129.15310-1-mgorny@gentoo.org/#r

I think that's the wrong take-away from that thread. Maybe a patch for
this will get rejected in the end, but in that case it wasn't because
the git project is never going to take a patch like this.

Maybe it won't, but:

 * That commit has no tests
 * It's clearly controversial behavior, so *if* we add it I think it's
   better to make it opt-in configurable.
 * Once that's done, you'd need doc changes etc. for that.

Now, maybe a sufficiently polished version would also be "meh" for
whatever reason, I just think it's premature to say that a change in
this direction would never be accepted.

That being said, I do wonder if software in the wild is being
monkeypatched to work around issues with make (or make-like tools)
whether such a change isn't better advocated in e.g. GNU make itself.

If it added "B" to "MAKEFLAGS" if it detected:

 * I'm in a git repository
 * It's the first time I'm running here, or "nothing is built yet"
 * My dependency graph would be different with "-B"

Wouldn't that be what people who want this feature are after?

It's not like it's SCM-agnostic, it already goes to significant trouble
to cater to RCS and SCCS of all things, so I don't see why they'd
categorically reject a patch to cater to modern VCS's.

And, unlike Gike, GNU make wouldn't need to guess that munging
timestamps would fix it, it can compute both versions of the dependency
graph, so it would know...
