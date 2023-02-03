Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D02C05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 22:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjBCWBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 17:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjBCWBK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 17:01:10 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A43A1E1E5
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 14:01:05 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id d26so6120768eds.12
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 14:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=InB/t6dkrKqgL9XBdRKsvMpjkIQCbRJ4qOL3fgwu1NQ=;
        b=C9T+VqkKSPV8k/StUEXfJY7k6eNInG5Im8mF8owvDLgfh1p5fWyeOzw3x2pW1evgTH
         E/ch3d7eR/8K5eJn9QXLx1QnaQwsLZOfgAp2nHMit7qEHp8h+e+qOLLA524jawdEUQQu
         lq/ZZ/EDD5AOP6FcRTjJajQVe82YI6SbTnr80pcaq8BcrPAaZYVxwp4Og4JLm30v4ZaY
         6CU9CHXZ2Q8fNbqf1F/qG8npRF83UpjpjEocvX+M0KTnt+9GHWfuXdd7ekWo+SvRmKfo
         RmbIRsE5PRP3KN2ElHmeGZc47P0hFLWhb2SM+G7Q3rc4wWsWezlqpwiYTrsp3DmdJXE/
         j05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InB/t6dkrKqgL9XBdRKsvMpjkIQCbRJ4qOL3fgwu1NQ=;
        b=c0CqnvxHV0fiJwJSuH87ajULPp65q7+GAvY+JKJ4T8Xz+3ikBjsiv3OGciLshTkzrq
         quF56zymPqhIMk94zd53TshP0/6emcRj8PWDDKqn05p1/qygoahLducR2HQIEhpiaV5+
         UPNFK6lpSK6aRHpilPdoAWbW8URBV7GRByAoI0D/JXxi4q3H3jHMr686AJIlS/wqlvP/
         ympNMM5vR0QmgAjcDGylcpcPfS4ZJTYkX8hNFsAumYACUZlGQQx9x5jsH7P7m5JwKN9y
         BEPtduQ2+r6y+zCwoacONLplKfpvyXgGE6fNXXhl4uVNP1Xf2K3EQy8JW5HmrFoUav0W
         o9gw==
X-Gm-Message-State: AO0yUKV9WE6yZx5NKKQYCi9zQv6yVnQhzzw5C99ndzftp05lie2FGW58
        2yOnLtlsHSZkbrRZyfcHvEs=
X-Google-Smtp-Source: AK7set+GbvTndRyJZMlxyndyMd8qX5nuVHFUvvNsqyxojWSXijEomE/kfP76UJ9cWBe5MKu73zO8jw==
X-Received: by 2002:a05:6402:128d:b0:499:1ed2:6456 with SMTP id w13-20020a056402128d00b004991ed26456mr11240949edv.22.1675461663899;
        Fri, 03 Feb 2023 14:01:03 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id g8-20020a056402114800b004a216fa259esm1678980edw.60.2023.02.03.14.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 14:01:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pO47C-000TcK-1I;
        Fri, 03 Feb 2023 23:01:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     demerphq <demerphq@gmail.com>,
        "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Subject: Re: grep: fix multibyte regex handling under macOS
 (1819ad327b7a1f19540a819813b70a0e8a7f798f)
Date:   Fri, 03 Feb 2023 22:56:53 +0100
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
 <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
 <Y9rv29c0dYUAYx8B@coredump.intra.peff.net>
 <CANgJU+XNLqf0E2+YC8yxtRPVh=mevc3P0eeye2_nx=ULB2iVWw@mail.gmail.com>
 <Y9098dyaTtiNk506@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y9098dyaTtiNk506@coredump.intra.peff.net>
Message-ID: <230203.86357mbe8x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 03 2023, Jeff King wrote:

> On Thu, Feb 02, 2023 at 05:22:37PM +0100, demerphq wrote:
>
>> I've been lurking watching some of the regex discussion on the list
>> and personally I think it is asking for trouble to use "whatever regex
>> engine is traditional in a given environment" instead of just choosing
>> a good open source engine and using it consistently everywhere.  I
>> don't really buy the arguments I have seen to justify a policy of "use
>> the standard library version"; regex engines vary widely in
>> performance and implementation and feature set, and even the really
>> good ones do not entirely agree on every semantic[1], so if you don't
>> standardize you will be forever dealing with bugs related to those
>> differences.
>
> I think this is a perennial question for portable software: is it better
> to be consistent across platforms (by shipping our own regex engine), or
> consistent with other programs on the same platform (by using the system
> regex).

*nod*

> I don't have a strong opinion either way. The main concern I'd have is
> handling dependencies. I like pcre a lot, but I'm not sure that I would
> want building Git to require pcre on every platform. If there's an
> engine we can ship as a vendored dependency that builds everywhere, that
> helps.

We can just make that fallback engine be PCRE. I submitted patches a
while ago to include a minimal version of it in compat/pcre, as we seem
to have some allergy to external dependencies:
https://lore.kernel.org/git/20170511175115.648-1-avarab@gmail.com/

It's ~80k lines instead of compat/regex's ~15k, but it's actually
maintained, and would be much easier to upgrade.
