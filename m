Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DBDC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 06:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLGGJ4 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 7 Dec 2022 01:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLGGJz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 01:09:55 -0500
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F1E31350
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 22:09:53 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so545904pjd.5
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 22:09:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12cAwFYhzgdHtDFhtUovj5K3A1gUJJWar/xc+j7Aqzg=;
        b=sixrA0VHEVzJEVQiktg4mBvB9jyHqCWdcjyklfe45vyVhdGV+H4UadItBEuoZ6KaGQ
         YAyr4q1U9Myb0nWFQA177TkaHlvhd/ALVnkfep4Dz0rH2EG6ImCoHO+j71tXYXpf7UQ3
         GbKKKjda4RP/tI+9Sjb4faKiPZUffWVXljIa1Er4YLKlprQkH0UJ5/v9ZtKfUoz648BC
         XsWsS6Vma/SUAUQhC5G5zPRppb8nrb68ItP7d8u+vEWap7D9XLah7GZcaO2fJqfiCqfq
         a/vzSpXvhnyooD1CMeNfMNzikGC4FM4FlK8NixTjvPjNYc1VclkwEGh4p5ZlM/c59/Gq
         7+PA==
X-Gm-Message-State: ANoB5pnaMi1VV5FCeQbINDiuUJLucRls4mMFBr1MlwVPT7fdtlEGb9Ue
        sj/HL/2YkHvhSbk9ty1RNLnrN2HvIZEmSCf3QZk=
X-Google-Smtp-Source: AA0mqf4CAcR5e8mhhukQO6rj9pch8iv4JTci8bV0YMWegNCJonU9VvjICDyMgZUaJDqGkHn3kmF6qTe9XSl2Xko2Hec=
X-Received: by 2002:a17:902:868b:b0:186:8c19:d472 with SMTP id
 g11-20020a170902868b00b001868c19d472mr74021266plo.12.1670393392943; Tue, 06
 Dec 2022 22:09:52 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
 <patch-v2-1.8-7c9f8d2830f-20221202T000227Z-avarab@gmail.com>
 <CAPig+cQK8BRU0u0g+jAkyJaqSamYBynJ6s00_6H2beb6gXaRDA@mail.gmail.com>
 <xmqqwn7apodp.fsf@gitster.g> <221202.865yeugp7e.gmgdl@evledraar.gmail.com>
 <CAPig+cQvqPgo1UKbAAtyz8UVJZiwrG7j+kAokMEimv1E62pR0A@mail.gmail.com> <221202.861qpiglto.gmgdl@evledraar.gmail.com>
In-Reply-To: <221202.861qpiglto.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 7 Dec 2022 01:09:41 -0500
Message-ID: <CAPig+cSgzzNhSx=iauGxgvP5OAqRChuDoenFYYs06iW_=Z_vEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] log tests: don't use "exit 1" outside a sub-shell
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 2, 2022 at 5:08 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Fri, Dec 02 2022, Eric Sunshine wrote:
> > It might make more sense to turn this on its head and make it a
> > linting issue and simply throw a "?!FOO?!" as is done for other
> > suspect shell code. In fact, I already have local chainlint.pl patches
> > which detect whether a subshell is active so that the linter can
> > complain if it sees `cd` outside of a subshell. I would think that
> > warning about misuse of `exit 1` outside a subshell (and perhaps
> > `return 1` inside a subshell) should be possible, though I haven't
> > thought through all the possibilities.
>
> That would be great. As a reminder I think (maybe it's not what you have
> in mind exactly?) that we had a brief discussion on this topic starting
> at [1]. I.e. I was hoping chainlint.pl could be extended to detect
> exactly these sort of "test...$(git" patterns (among other things).

I recall it but haven't really put any additional thought into it. I
did put a little bit of thought into how to upgrade chainlint.pl to
supplant check-non-portable-shell.pl, though that doesn't help much
with your wish list. More recently, I've been thinking that it might
make more sense for chainlint.pl to generate an AST rather than
working against the raw token stream, which may mesh better with the
sort of rewriting you mentioned, and may simplify (or complexify) some
of the linting heuristics. I haven't really thought it through yet,
and I'm always concerned about slowing down the script too much -- but
perhaps I'm worrying unnecessarily if your Makefile-based
parallelization patches land, or if we just rip out parallelization
altogether as Peff was suggesting.

> This topic doesn't get us there, but once we finally get rid of some of
> those patterns it would be nice to have assertions to ensure they don't
> come back.

Ya.
