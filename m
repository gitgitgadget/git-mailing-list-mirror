Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AFA01FA14
	for <e@80x24.org>; Thu, 25 May 2017 10:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933864AbdEYKdz (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 06:33:55 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:34861 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753399AbdEYKdy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 06:33:54 -0400
Received: by mail-it0-f50.google.com with SMTP id c15so54051973ith.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Letx7XNsal4/L4aaOYyoN8PgO8s+crxT0TJ6Nulneq0=;
        b=IckRVlcRE5YqsZ184NDGCNrIp7oFoUsK+rzxrO7Lv7wTYWFkCGUUjKb6j2Jr83pJDg
         C+U4KDigY6WjgGsaCRBj2uc983cOSapsHs4a9un6M0rjgGxAi4xlMLYgtKbDEYDKpKqM
         XkhSr3VLfRL8obGSRF8HhZV/cJpBfz0V9KFepmYJ8w6l7lwJ9qUw++vfEL+qWVHtpYs1
         4DTwQxtwtIW26GHPNMrbnjXswD1MNMwUeWCXTu2SWnDaslGMTG9QVmZVZn4XOydlJNMM
         qtNwoqsdPGKyYoHm2tOGGjv6DfStLZyoGMX44nAj5KuBt85ph31YcmMMsCIl3J/t2GuX
         GIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Letx7XNsal4/L4aaOYyoN8PgO8s+crxT0TJ6Nulneq0=;
        b=EhH0B0S/njEvWxozS40lXnXuB14mTPAH+j3P8ifoSHQ5Tk5gESXfUuP25xN8JtDYnw
         73AFwMpmoIBH3CN/8VYtZXP5yYjEiMDNuDSktsdUr9rvjPf4jDTUdu+FEI0TE1jJsbPc
         17kWS/aKtjpRXCJ23enAbGcuT4ZQglZz3isWjP5Xle8oDWys5hgiWpjFsyNdKonsW+qs
         BJHH6UGOA/Gay79qPxKMr0Kx8/D/SdipaQ1u7YtSeIu/02GIUATzeovm/bVveRxAJiQI
         y6nao9ebWSYrUDYPqu71xk+aRQ5pAw1rNm6D3NyaDd3QR7mNVjlua4qoH4HYIj4gxXh6
         c20Q==
X-Gm-Message-State: AODbwcCVsA5E61cbBfvuMf/iRFwZQ0h/VGfdZ1IArVvXkOVE36fhnnmd
        KTz9IsrNp2Hj+8c+rpfCwFZjaJ56FA==
X-Received: by 10.36.89.207 with SMTP id p198mr12540902itb.71.1495708433549;
 Thu, 25 May 2017 03:33:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 25 May 2017 03:33:32 -0700 (PDT)
In-Reply-To: <xmqqvaoqhnlw.fsf@gitster.mtv.corp.google.com>
References: <20170523192453.14172-1-avarab@gmail.com> <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
 <20170523192453.14172-2-avarab@gmail.com> <xmqqvaoqhnlw.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 25 May 2017 12:33:32 +0200
Message-ID: <CACBZZX51hmq-jCkwyDt6QWfLJ+qxziUV-Bef+yVDoViLNhC4dw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] grep: don't redundantly compile throwaway patterns
 under threading
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Simon Ruderich <simon@ruderich.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2017 at 6:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Rather, it's just to make the code easier to reason about. It's
>> confusing to debug this under threading & non-threading when the
>> threading codepaths redundantly compile a pattern which is never used.
>>
>> The reason the patterns are recompiled is as a side-effect of
>> duplicating the whole grep_opt structure, which is not thread safe,
>> writable, and munged during execution. The grep_opt structure then
>> points to the grep_pat structure where pattern or patterns are stored.
>>
>> I looked into e.g. splitting the API into some "do & alloc threadsafe
>> stuff", "spawn thread", "do and alloc non-threadsafe stuff", but the
>> execution time of grep_opt_dup() & pattern compilation is trivial
>> compared to actually executing the grep, so there was no point. Even
>> with the more expensive JIT changes to follow the most expensive PCRE
>> patterns take something like 0.0X milliseconds to compile at most[1].
>
> OK.
>
>> The undocumented --debug mode added in commit 17bf35a3c7 ("grep: teach
>> --debug option to dump the parse tree", 2012-09-13) still works
>> properly with this change. It only emits debugging info during pattern
>> compilation, which is now dumped by the pattern compiled just before
>> the first thread is started.
>
> When opt is passed to run(), opt->debug is still true for the first
> worker thread.  As long as opt->debug never makes difference after
> compile_grep_patterns(opt) returns, I think the change in this patch
> safe.

Right, the --debug feature only impacts pattern compilation.

> I do not know if we want to rely on it, but we can explain it
> away by saying "we'll only debug the runtime behaviour for the first
> worker only", or something, so it is not a big deal either way.

I think it's a pointless distraction to start speculating in this
commit message what we're going to do with --debug it if it ever
starts emitting some debugging information at pattern execution time.

As an aside, I'd very much like to remove both --debug and the
--and/--or/--all-match, gives some very rough edges in the UI and how
easy it is to make that feature error or segfault, I suspect you might
be the only one using it.

There are pattern matching optimizations I'd like to do that are much
more of a pain with that feature around. It's easy to AND multiple
regexes together into one match via -e, but when you have to deal with
negation and arbitrarily complex chained & parenthesized  AND/OR you
end up having to run your custom state machine on every line with
multiple regex matches per line.

The system grep doesn't have this feature, and people seem to do
without it. The motivation for it isn't explained in commit 79d3696cfb
("git-grep: boolean expression on pattern matching.", 2006-06-30), but
I suspect it's a hack around not being able to do "git grep ... | git
grep -v ...", which is how you'd do "I'd like to match this, but not
that" with the system grep.

Just supporting that would be much easier than supporting the and/or
matching machinery.
