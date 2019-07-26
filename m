Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B9221F462
	for <e@80x24.org>; Fri, 26 Jul 2019 14:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfGZOMq (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 10:12:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32825 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfGZOMq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 10:12:46 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so105129065iog.0
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8A79zlELf21A3+EBgYdqI3eVx49012Oj1MNKZhixJeM=;
        b=mm+P6R5qgRzBE++RdIl0f5/9w0h+pRBA5y0UeW7AQJGmmneMYpfa60aCBnLksVVEha
         TmQH6OkJet/SkcGgHZ54HvQHdW1sKVqrfJIcY2A927PtLYmS+BFuLZXyA2w+fPpJZqIs
         hM5bkMBkNstmT/TKuj8lj+R4vGTI5vpg1zdbzUUR3cqLGbD98rbV9juf1KC7gOiPwVqs
         DPZxEcz+/KkwVi6gLOR73kKTXJ0dahdeizJlWMpV6NyvjrLhKGsSe4JsksfBQUxSYqZb
         RXhz3HRkE1ihhGmICz+iiN/XRdkRFKzerKP0Vv/SkaLuhLZF65KpJmj7gmCvbGSgCJ+z
         uM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8A79zlELf21A3+EBgYdqI3eVx49012Oj1MNKZhixJeM=;
        b=jA8GcJ2D2gizfXPrmgbB+YsJsh+hiOmT7bI1eXel9kDukFpoOs3AQQhRnWFBj/L9L3
         znKlqHfG7I6JkYFxC9epzYOhOTmnwqy8vhHH+Bb3PjMByQKZLdU2gcnSqvvQ3PRcbZIZ
         PQFFOXYVhfHNV/p35E8omp+3RGj/bTG7TZh0SKBO9Ynm2Xgc2jpxyuxBFqURCy8jLaGH
         k56Ac4EOorLlJbkesA25bgIqaK8S0Y7Xr2H1Hwlx6qzAQkWRcqRz4FmgngHbgGASM0ez
         i1RHftmE3myaYmycoRSkpAezVK6YrjxjNJcNAI1az9svYVQ9BCX9sjgojhef8fkFqWEL
         gJAA==
X-Gm-Message-State: APjAAAWkA9cQo4jIs/qMHbsMPMMzEWQr7/boyP4GAbe04UtRqvD7eGx5
        0Wl+7l9m8jsmGcneRkqyiiL2331HNdpY9VTwxcRKgROP
X-Google-Smtp-Source: APXvYqwE3jbUYpO0uFXGW10APD0/cW/r5w3RpTR5N9nUpZUginH8v0wxkrCz9xZ4VUHedHPQv57BGf0/A6bIdfCWPo8=
X-Received: by 2002:a6b:c38b:: with SMTP id t133mr23627491iof.162.1564150365267;
 Fri, 26 Jul 2019 07:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190721194052.15440-1-carenas@gmail.com> <20190724151415.3698-4-avarab@gmail.com>
 <CAPUEspiCFup4wvNwOA+egiAjkUEPgU+YnU8x2DfKhdbqTdOV3w@mail.gmail.com> <87h8787vmt.fsf@evledraar.gmail.com>
In-Reply-To: <87h8787vmt.fsf@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 26 Jul 2019 07:12:34 -0700
Message-ID: <CAPUEsphZJ_Uv9o1-yDpjNLA_q-f7gWXz9g1gCY2pYAYN8ri40g@mail.gmail.com>
Subject: Re: [PATCH 3/3] grep: stop using a custom JIT stack with PCRE v1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 26, 2019 at 6:50 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Jul 26 2019, Carlo Arenas wrote:
>
> > since this moves PCRE1 out of the JIT fast path,
>
> I think you're mostly replying to the wrong thread. None of the patches
> I've sent disable PCRE v1 JIT, as the performance numbers show. The JIT
> stack is resized, and for v2 some dead code removed.

I didn't mean JIT was disabled, but that we are calling now the regular
PCRE1 function which does UTF-8 validation (unlike the one used before)

> > introduces the regression where git grep will abort if there is binary
> > data or non UTF-8 text in the repository/log and should be IMHO hold
> > out until a fix for that can be merged.
>
> You're talking about the kwset series, not this cleanup series.

a combination of both (as seen in pu) and that will also happen in next if
this series get merged there.

before this cleanup series, a git compiled against PCRE1 and not using
NO_LIBPCRE1_JIT will use the jit fast path function and therefore would
have no problems with binary or non UTF-8 content in the repository, but
will regress after.

Carlo
