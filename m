Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D69BC4332D
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 17:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061F864E02
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 17:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhBORq6 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 15 Feb 2021 12:46:58 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:44193 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhBORp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 12:45:59 -0500
Received: by mail-ed1-f42.google.com with SMTP id g3so6642338edb.11
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 09:45:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jltj82lH1uyHDF2SbmFcPDC2rdscZs/U5yEYFFoffkA=;
        b=CHGytGlAZgF/lSIwU3iCkUhzsI98kwJIakNZ4+HiaTJ8kqqEue1aLdHET6cx2BqTrC
         /5rmA9GB6+ThI8gYfJ9yu3PzIEpgTe2sVPAq88HDYYiSxKlIKAwAWn8YD5BHRPoufurX
         WyAzzOiTbwroc1fdFjN+aZw2ppOPH1gQKKXZitEazwndSQ40cCy5ipv3EqXxlVpzVe4I
         uHMiYckJbzTLyhJE00GVwUN3lT2zVlAnzRqMo8erAFEz8z7cnZbEljNsVvSUazlX74W6
         3CjjJzPJf1lzOtplT+kTCKTwbcy30YpWevaZMDeZ0N8wILWmup3g45UcVoLBhCxk+FWM
         7Nmw==
X-Gm-Message-State: AOAM533UHRGTi8CzwTWFW9sKmQJlAB5YKJRYbwSIiQpRXqZWeQgp/sfr
        sx3NpO61y+XZtCwTqbYm3tySFsStUxNc4aVM4f0=
X-Google-Smtp-Source: ABdhPJy9nKa3eCigRVjTapdXcDUjEklP5Tmfr5gGDgfXi6cPTLLBdvzwIklcI020ySNOY5G7kR3X2jNDzVd30Deeztg=
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr16783117edu.163.1613411117551;
 Mon, 15 Feb 2021 09:45:17 -0800 (PST)
MIME-Version: 1.0
References: <20210215005236.11313-1-avarab@gmail.com> <20210215154427.32693-1-avarab@gmail.com>
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 15 Feb 2021 12:45:06 -0500
Message-ID: <CAPig+cROa_77Wb4z3+-7WVQ0f=PQMvN-QmdOhqkMm28Gz7qsAw@mail.gmail.com>
Subject: Re: [PATCH v2 00/27] userdiff: refactor + test + doc + misc improvements
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Chris Torek <chris.torek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 15, 2021 at 10:44 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Incorporates all the feedback on v2 and more, see the range-diff
> below.

I hadn't finished reading the previous version of this series...
Nevertheless, see a few issues below which I noticed while scanning
the range-diff...

>     ++expect to appear in the hunk header. We munged away the starting "@@
>     ++[...] @@" part of the line for ease of not having to hardcode the line
>     ++numbers and offsets.

Nit: "munge" is an oddball word to use here. "We strip away the
starting..." would be simpler, but perhaps it doesn't matter too much
as this documentation is aimed at developers, not end users.

>     ++For built-in patterns, you do not need `diff.<lang>.xfuncname` in your
>     ++configuration file as discussed above, but if present, it will
>     ++override a built-in pattern.
>      +
>     -+You still need to enable built-in patterns with the the attribute
>     -+mechanism, via `.gitattributes`).
>     ++Nevertheless, you need to enable built-in patterns via .gitattributes`
>     ++for the pattern to take effect.

Missing opening backtick on `.gitattributes`.

>     ++Patterns in in a list of multiple that begin with "!" are negated. A
>     ++matching negated pattern will cause the matched line to be
>     ++skipped. Use it to skip a later pattern that would otherwise match. It
>     ++is an error if one or more negated patterns aren't followed by a
>     ++non-negated pattern.

s/in in/in/

Also, "of multiple" what?

>     ++To match a literal "!" at the start of a line, use some other regex
>     ++construct that will match a literal "!" without "!" being the first
>     ++character on that line, such as "[!]".

Overall, I find this description easier to read and understand than in
the previous version.
