Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66803C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 10:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiFUK7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 06:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiFUK7M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 06:59:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0532980F
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 03:59:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id h23so26613732ejj.12
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 03:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=pU4BpQBrPd4S279+lUXq2QCNRvKcXgiW3gymG44QTIo=;
        b=BfM0iI2HEedrDc19welEuLc0TsabCVUrzfpSUeIJ182ENTYNvIHm1On0jJ93Lh9PkO
         EtX82BTPDNFvi1rCb0OYZap4d7wZIDHnXmkpLokbUZy/t3D7WD4yt0vXJr7CK31GiQ0y
         b+vdD0jaq5+dzErwLkMUX5CC+aml3a/MM3sd8r6uZyxfD86uSefSHTM2KMlGKBFgxkc0
         umsqMJWTKAppZE9bdnM9VaMZBVHoIHPBdd6HAMtijJtZ2580oQ5ZNi8T0F0X69h/HYxK
         9uotVPtqBIjVJvNzO5ciVxM7E3ac8qDNa1Tacq7jw8xsa0Xvqv0NSi5Ki6tmtd0vxfk3
         Cvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pU4BpQBrPd4S279+lUXq2QCNRvKcXgiW3gymG44QTIo=;
        b=Or45k9VLMbbUkBz8/pHF9Tk6qiBnkpCbSHuQra3Mrlz/Qo4fIYaDfeEiVwX0ph64ye
         4pXoWwFOMYARBU+pcVRIO7daXBQ8WvX4gVErfeVB9WeSFtrHeqIy4H53YPXIF1nanF2h
         fPN13lWApPS4w8+6Zw1RTvkGElr9rLB0NJ9VVEoaSQr2vQSCgDqmGB8PtdPLFaEob2MY
         mQzktw59Re6Xzcbv7TUZo6yZSUWFMvsBF6QdzI6WAx2WtPHp5OnEfNtxTyYzkth2X7oO
         kunjJna6ghEyw4P64bzFfeVGhV7g5RT9NldorSobipqxeJY89s4qhTAIB8gWEL/n83xl
         MkEw==
X-Gm-Message-State: AJIora+hlpXwos/fNIsxH88SejXhaJRsbHXQpzj11BrumtGzbQfihlL2
        wh31NOOcr//oBV/gp9hZbClvxpowNVk=
X-Google-Smtp-Source: AGRyM1u4cBUBfaS9TSUMfFo4qmb9IgJmI1HRhPpaGtKv52D7hOL3v01obW++BcI2ZNtnZyuPW4zkqw==
X-Received: by 2002:a17:907:3e03:b0:722:e694:438 with SMTP id hp3-20020a1709073e0300b00722e6940438mr1311541ejc.755.1655809149005;
        Tue, 21 Jun 2022 03:59:09 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bx25-20020a170906a1d900b006fe8d8c54a7sm7428597ejb.87.2022.06.21.03.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 03:59:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o3bb9-000J7I-Ek;
        Tue, 21 Jun 2022 12:59:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stephen Smith <ischis2@cox.net>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.org>
Subject: Re: SHA-256 transition
Date:   Tue, 21 Jun 2022 12:25:01 +0200
References: <12011256.O9o76ZdvQC@thunderbird>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <12011256.O9o76ZdvQC@thunderbird>
Message-ID: <220621.86sfnyuvt0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 20 2022, Stephen Smith wrote:

> What is the current status of the SHA-1 to SHA-256 transition?   Is the 
> transition far enough along that users should start changing over to the new 
> format?  

Just my 0.02, not the official project line or anything:

I wouldn't recommend that anyone use it for anything serious at the
moment, as far as I can tell the only users (if any) are currently
(some) people work on git itself.

The status of it is, I think it's fair to say, that it /should/ work
100% (or at least 99.99%?) as far as git itself is concerned.

I.e. you can "init" a SHA-256 repository, all our in-repo tooling
etc. will work with it. We run full CI tests with a SHA-256 test suite,
and it's passing.

But the reason I'd still say "no" on the technical/UX side is:

 * The inter-op between SHA-256 and SHA-1 repositories is still
   nonexistent, except for a one-off import. I.e. we don't have any
   graceful way to migrate an existing repository.

 * For new repositories I think you'll probably want to eventually push
   it to one of the online git hosting providers, none of which (as far
   as I'm aware) support SHA-256 repos.

 * Even if not, any local git tooling that's not part of git.git is
   likely to break, often for trivial reasons like expecting SHA-1 sized
   hashes in the output, but if you start using it for your repositories
   and use such tools you're very likely to be the first person to run
   into bugs in those areas.

But more importantly (and note that these views are definitely *not*
shared by some other project members, so take it with a grain of salt):
There just isn't any compelling selling point to migrate to SHA-256 in
the near or foreseeable future for a given individual user of git.

The reason we started the SHA-1 -> $newhash (it wasn't known that it
would be SHA-256 at the time) was in response to https://shattered.io;
Although it had been discussed before, e.g. the thread starting at [1]
in 2012.

We've since migrated our default hash function from SHA-1 to SHA-1DC
(except on vanilla OSX, see [2]). It's a variant SHA-1 that detects the
SHAttered attack implemented by the same researchers. I'm not aware of a
current viable SHA-1 collision against the variant of SHA-1 that we
actually use these days.

But even assuming for the sake of argument that we were using a much
weaker and easier to break hash (say MD4 or MD5) most users still
wouldn't have much or anything to worry about in practice.

Discovering a hash collision is only the first step in attacking a Git
repository. This aspect has been discussed many times on-list, but
e.g. [3] is one such thread.

The above is really *not* meant to poo-poo the whole notion of switching
to a new hash. We're making good progress on it, although I think the
really hard part UX-wise is left (online migration).

Likewise I'd be really surprised if given the progress of that work the
average Git user isn't going to be using not-SHA-1 with Git in 15-20
years, of it's even still around at that time as a relevant VCS.

But should even advanced git users be spending time on migrating their
data at this point?

No, I don't think so given all of the above, and I really think we
should carefully consider all of the trade-offs involved before
recommending that the average user of git migrate over.

1. https://lore.kernel.org/git/CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com/
2. https://lore.kernel.org/git/cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com/
3. https://lore.kernel.org/git/CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com/




