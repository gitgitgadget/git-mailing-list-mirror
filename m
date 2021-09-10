Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9EAC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3018611EE
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhIJOsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 10:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhIJOsf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 10:48:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A1CC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 07:47:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id jg16so4784415ejc.1
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 07:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=NyHxyXb6rWeBMRsHSB6rx9KvJ3fNpdS5HRpBOxQHzUw=;
        b=gx1NZsTtNbdXc9VrjFQe2Rjy6uiSFTNcePKzI4YFASrDX7chu6NuhdVXJCVsRDNOYW
         BIqvgXVNPtj6RygCcn+HiQPdaRJ+E7vxNdSxc5BOvtNLmqVwF34yKwLUreUTmw+WYI3x
         lXv+4nMxpAHHQs4DDYexDtE+ndYsdQUzyy004S4BXKL0vATdE8UQ8qNhVw92ODi7qBC3
         GarYaNs4h+wD2I+2N2wBE28Tn2bFEMBJWBeWp9HgxVe9B7AoLXZFU72cd6afgOmmjBZe
         sxHs6rMPIUNNtKdRlvY+Xm3XWCi1efg5XYV4Gj90IKTHvwGo5QVa06765020BP5np+y3
         MFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=NyHxyXb6rWeBMRsHSB6rx9KvJ3fNpdS5HRpBOxQHzUw=;
        b=CX1MsrBmseIiqPPMH+e+prutWjgfJz5aBWsbR7K51YOqGJLLjYaGs7AN4CmiYzQ9Qv
         x3eP9+YYU4/3Gwoj2u5ylHC+3r6Bl0RzUel8SZs4OWuYZEVbZB0wpnHNPFbdZLjTuKoR
         jbujkyqZoti8nWndeMMlRcK0uQ7yDFjgD+e3wFs7wwUaURya4AaiRp0Q3DhQL5X3r9gX
         A/LhjwS4WeyGfJpydTq1P91t9D4+tC5WSFLq1UxXZXvvuhcXA7KEoCADUbpUCc6mI+Kv
         yTre78/Wx0yW6EdbcbmJsBT/jC6g37UuXhh3ChQqrR2NMP6lETGC/rS8jlpSMB2uAb5Q
         AOhQ==
X-Gm-Message-State: AOAM530HPZ9o8SwXVnY5eM2FXNfS633PgaRN2t60lphYRI8q0ZKngC75
        fz3d3V9WTduOfmwOPY0OxpI=
X-Google-Smtp-Source: ABdhPJwDkt/pqET6avQscRUrBtggkrTcCv6zZu2EuFJ2828ZEMUQVQg4Mucm9myFbop1c9py7P9AQA==
X-Received: by 2002:a17:906:4d01:: with SMTP id r1mr9509826eju.471.1631285241792;
        Fri, 10 Sep 2021 07:47:21 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l8sm2580663ejn.103.2021.09.10.07.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:47:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 2/5] http: correct curl version check for
 CURLOPT_PINNEDPUBLICKEY
Date:   Fri, 10 Sep 2021 16:37:48 +0200
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <patch-2.5-511534ce17a-20210908T152807Z-avarab@gmail.com>
 <YTkNdGk28UJnSDVt@coredump.intra.peff.net> <xmqqv939wdgl.fsf@gitster.g>
 <YTtpWADzTJEAIvk+@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YTtpWADzTJEAIvk+@coredump.intra.peff.net>
Message-ID: <87tuiscwso.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Jeff King wrote:

> On Thu, Sep 09, 2021 at 04:12:26PM -0700, Junio C Hamano wrote:
>
>> > But in terms of compiling, all we care about is that the constant is
>> > there. So I think the cutoff point you found is what we want. Presumably
>> > when the file format isn't supported we'd get some error, though it's
>> > not clear if that would come during the actual curl_*_perform(), or if
>> > we should be checking the curl_easy_setopt() result.
>> 
>> If we were evaluating a patch to add support for pinnedpublickey
>> afresh back in, say, 2017, perhaps we cared enough about the
>> distinction between 7.39 and 7.44 (Nov 2014 and Aug 2015,
>> respectively), but I'd say cut-off at 7.44 for this, once it is
>> written and committed in our codebase, is good enough for us.
>> 
>> If the code originally had cut-off at 7.39 and we were raising the
>> floor to 7.44 with "sha256 weren't usable before that version" as
>> the justification, it would be a totally different situation and it
>> may be worth the code change, but I am not sure if going backwards
>> is worth it.
>> 
>> So, I dunno.
>
> I don't have a sense of whether the functionality difference between
> 7.39 and 7.44 actually matters.

For what it's worth I tested this as part of re-rolling, i.e. I grabbed
the tarball for 7.39[1].

By using the correct version number of 7.39 we'll support pinned public
keys there, but if you supply e.g. the "sha256/[...]" format we'll
instead of printing a warning about this version not supporting pinned
keys, we'll die with an error from curl itself.

I think whatever happens with 7.39..7.44 doesn't matter much, but this
does seem like more useful behavior, and we avoid the oddity of
hardcoding the "wrong" version (until you start looking more into it,
that is...).

Aside from 7.39..7.44 though it does seem like a really bad thing to do
to just warn that we don't support pinned public keys, but proceed with
the request anyway (which could also be a push).

I don't think it's worth changing that s/warning/die/g now, since the
target audience for a new git release with such an ancient curl version
is probably zero, or near enough to be zero.

I mean, we do have new git + old OS, but it tends to be *specific* old
versions, namely for releases of this age the one released with RHEL. I
think pretty nobody else does that (the rest are probably all
RHEL-derived). Per 013c7e2b070 (http: drop support for curl < 7.16.0,
2021-07-30) none of the RHEL out there have a curl in the 7.39..7.44
range.

The commit doesn't note the RHEL 8 version (which b.t.w., is something I
added to it, not you), but it seems to be 7.61.1[2]. So at least as far
as RHEL goes we'll never be stuck in the 7.39..7.44 range..

1. protip: curl.git git tags are rather useless, since (at least for old
   versions) the embedded version number is bumped sometime *after* the
   release).

   I also ran "diff -ru" on at least one old tag/tarball (I forget
   which) and there were a lot of changes (and not just some "make dist"
   stuff like autoconf files, version numbers or whatever).

   So in testing this I stopped using curl.git for anything but "git log
   -G<str>" searching and the like, and just tested with archived
   release tarballs.

2. https://access.redhat.com/solutions/4174711
