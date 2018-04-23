Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A24F1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 00:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753791AbeDWAca (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 20:32:30 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34720 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753669AbeDWAc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 20:32:29 -0400
Received: by mail-qt0-f178.google.com with SMTP id a25-v6so15878466qtm.1
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 17:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BBcqUx/SkGnvWxib1emZ9x/nxROXhxUoE/d5zbf9aXI=;
        b=PWAiGtSjV6soFYvtOHk/Pwaeu7TsKPbWcaC1lnZau5mnNW4O6wsySHUpUSG9/PHJiU
         d/7QDEBv9R1eVf/iNycMbTk7AXKqb0sFJSNCN/t9KfXxP9y5ukbSneFlCeKVOnoRKS9z
         dqA71ZFIN9EBtOyGtqegX3ub0R1Jne2fhQIJEofGPZpTEZrQW1577MpgUY++pR6WHCf8
         toIVxSFUprXno/MwYRuhId3wrdcsVIQAsuOfPNKUajkfzWuhwDE+PX7OguwiExH9Hv7i
         vHPYiQrDb4rn6EYL5thXLWCiNwc2MCL2xgBBRFMbRbyGr/lMNl7/lK/uWdVlh6MgeNKa
         JLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=BBcqUx/SkGnvWxib1emZ9x/nxROXhxUoE/d5zbf9aXI=;
        b=FZKw4+NZllHgho4jgumvQXMQzhe+yo1NTRZ6YBW/Mxm14qDbFR4FdNXbexDCR0oU3K
         N9yXyZrFOEmW28JctEALvhcOi+Y+1JFbrb305NkGHS741Lbw92SuizvzoJHI2iVVv07o
         U8hceAiuk+ys+8Q0PdpV6/SBjBMSBZPZSZwjW7YdZJjfmrmkdRZH6bJzlkbIixWCoMa0
         okeL/4zeHwrruKe6NfbKXDMNI/XhJjaiJRC5oqa6/26dVke47fRJfYPelOMcRzWvMp77
         SpCxP8TWcBdSihhWIwh6h5V3NpIAqxcYKnwzGksHM7c/VYVQHQPqMwE0+bmGK2Y4elbh
         wunw==
X-Gm-Message-State: ALQs6tCdGXcWPsscNrS95lmbO8A+rLVq+Bgo0B/AjpvPE7De+RcKQFat
        ieZyZD3EEUr0ol6o/SKQvpWzs4j/dCCS3f0drfs=
X-Google-Smtp-Source: AB8JxZoN3j+i8HnxVC+uNa2leRKjqp9/vH188cT/q+7NDqSYV4aPMcB9wEggq2HkcDu7NJ0az+Y+wPoG83UzuaLfuqM=
X-Received: by 2002:aed:26a4:: with SMTP id q33-v6mr20580462qtd.165.1524443548908;
 Sun, 22 Apr 2018 17:32:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 22 Apr 2018 17:32:28 -0700 (PDT)
In-Reply-To: <6dd73ad84cad5a749bf05c500295955970577e04.1524429778.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local> <cover.1524429778.git.me@ttaylorr.com>
 <6dd73ad84cad5a749bf05c500295955970577e04.1524429778.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 22 Apr 2018 20:32:28 -0400
X-Google-Sender-Auth: Ja-aZXOr_ALTw0n8P4Qu3fXwKVE
Message-ID: <CAPig+cTozduqSAxh+w4H85m7en72Yo09asdx+1KSTswqbnBr4w@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] builtin/grep.c: show column numbers via --column-number
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 4:47 PM, Taylor Blau <me@ttaylorr.com> wrote:
> This commit teaches 'git-grep(1)' a new option, '--column-number'. This
> option builds upon previous commits to show the column number of the
> first match on a non-context line.

Imperative mood (and dropping unnecessary "builds upon previous"):

    Teach 'git-grep(1)' a new option '--column-number' which shows the
    column number of the first match on a non-context line.

> For example:
>
>   $ ./git-grep -n --column-number foo | head -n3
>   .clang-format:51:14:# myFunction(foo, bar, baz);
>   .clang-format:64:7:# int foo();
>   .clang-format:75:8:# void foo()
>
> Now that configuration variables such as grep.columnNumber and
> color.grep.columnNumber have a visible effect, we document them in this
> patch as well.

As mentioned in my review of patch 2, document the configuration
variables in the patch which introduces them.

> While we're at it, change color.grep.linenumber to color.grep.lineNumber
> to match the casing of nearby variables.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> @@ -99,6 +99,28 @@ do
> +       test_expect_success "grep -w $L" '
> +               ...
> +       '
> +
> +       test_expect_success "grep -w $L" '
> +               ...
> +       '
> +
>         test_expect_success "grep -w $L" '

I realize that several existing tests in this script are already
guilty of this sin, but please give each new test a distinct title
reflective of what it is actually testing in order to make it easier
to correlate failed test output with the actual test code.
