Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 633BB1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 00:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753753AbeDWAQP (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 20:16:15 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33752 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753664AbeDWAQO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 20:16:14 -0400
Received: by mail-qk0-f196.google.com with SMTP id c70so5631785qkg.0
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 17:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=EpPCd1NMngMv48jQST/HVB7QfwAgkSOOIorJ6Qglevk=;
        b=KUv6i21C5SNey4njX2RC4QUWgY4o6nzmFa6qGAW4yZKXflFhSJstD65GtmcZLiBl03
         F+4RTmTppMNA5cCUup6QOPblO+trv5EPntnS0Hg6jFoDhZpUsBIrHP09uprdK5KeraiQ
         hLXrIW+dBkp3sU2MkDUZpxmwd+EWay7EuxH7X3VlbKY0CSWBphiWOdHtBtlm1M8H6tJ/
         9byR5BX2aTZqm4IysvkkS+oxTF3O2eSh+2jbWaHUuMeNczLkZ2Iqi78cm6xaBwbeoY1h
         3cK/MILAMtlljrmF1b8rTZzE/EgKqhiAelDahbfyqg8tHHpNZFuG1OQIwD0Pdz8gZLRi
         6VvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=EpPCd1NMngMv48jQST/HVB7QfwAgkSOOIorJ6Qglevk=;
        b=n/zHMc9JYgujFR3QTlNacvCiHtSA/a2CQfmVu448m825QykOE0g8hjaC45UOtVs4o9
         4GORG0NMo83qdjITGYFgx090NuaZKpfNa8/B1bz9DyPuVg6sKEsY/0b2R3SU3Zk7CiM0
         6BQkEbkLfn5oRXNDQAo3DC7E2ZXyIRir5+RzZw4fhRvh9k3oyTvLj6W4I2dcOVxTQnat
         ByY0AI5Un6Opm/B+U/dAayvnJb6L+UORXyJ17F0DK/5DiTvKAp5tnCFWGtNErM7ixWhO
         S+4HVO9XpQ5ahv0Vk7ZLhjMuHvPBAclBAh9jRlivdo4JU5/ovjt+jqW0uXl9WEon0/RS
         GX7g==
X-Gm-Message-State: ALQs6tALLe53iJKOcukNxkBB2TWFG0F0RHrq2h7Tede0Fej2mpzJsTBN
        1wCvGK76Gx+Lspeq/Sua3HP1hI1IjHBe0WCGR1k=
X-Google-Smtp-Source: AB8JxZpuudLUKwZMZgB4pCUT8RvTrnr+4nhkQIpi/2VA7dXK/eDz08lTn3AxpdjrizrQt5ntdnZT2bJOffY7clPUQQA=
X-Received: by 10.55.79.9 with SMTP id d9mr20161518qkb.2.1524442573184; Sun,
 22 Apr 2018 17:16:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 22 Apr 2018 17:16:12 -0700 (PDT)
In-Reply-To: <5aaf7bebb27d385ea090cb83e97c596983ebae47.1524429778.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local> <cover.1524429778.git.me@ttaylorr.com>
 <5aaf7bebb27d385ea090cb83e97c596983ebae47.1524429778.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 22 Apr 2018 20:16:12 -0400
X-Google-Sender-Auth: j3HBg3HYs8PwSJbhjnIiuppj5tw
Message-ID: <CAPig+cQ2+wTTXE0mhnGnp2pZug=Po0SCVwCO_2agxUDaOsFRLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] grep.c: take column number as argument to show_line()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 4:47 PM, Taylor Blau <me@ttaylorr.com> wrote:
> show_line() currently receives the line number within the
> 'grep_opt->buf' in order to determine which line number to display. In
> order to display information about the matching column number--if
> requested--we must additionally take in that information.
>
> To do so, we extend the signature of show_line() to take in an
> additional unsigned "cno". "cno" is either:
>
>   * A 1-indexed column number of the first match on the given line, or
>   * 0, if the column number is irrelevant (when displaying a function
>     name, context lines, etc).

This information about how 'cno' is interpreted seems important enough
to have as an in-code comment somewhere. Unfortunately, this patch
never actually uses 'cno', so it's hard to add such a comment to
non-existent code. In fact, the granularity of this patch feels wrong;
it seems to exist for some purpose but, at the same time, is a
do-nothing patch.

This issue illustrates a larger problem with how this patch series is
structured overall. In his review, =C3=86var suggested collapsing several
patches into one, but the problems go deeper than that when you have
patches which implement some bit of functionality but don't document
that functionality until some later step which exposes some other bit
of functionality, and so forth. As a reviewer, I expect a patch series
to hold my hand and lead me on a straightforward journey from building
blocks to final product, but this series tends to jump around without
apparent logic.

One way to achieve a more coherent patch series would be to build the
machinery first and then expose it to the user in various ways. Also,
each patch which implements some user-facing functionality should also
document that functionality. For instance, a more understandable
series might be structured something like this:

  1. grep: match_line: expose matched column
  2. grep: extend grep_opt to allow showing matched column
  3. grep: display column number of first match
  4. builtin/grep: add --column-number option
  5. grep: add configuration variables to show matched column
  6. contrib/git-jump: jump to match column in addition to line

There may be fewer or more patches than shown here (I believe =C3=86var
suggested a cleanup patch), but this should give the general idea.
Patches 4 and 5 might also be swapped if that seems more logical.

(Sorry if any of the above sounds harsh; it's not meant to be, but is
intended to be constructive.)

> We additionally modify all calls to show_line() in order to pass the new
> required argument.

Nit: No need to state the obvious; this final sentence could easily be drop=
ped.

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
