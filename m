Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D61C81F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 19:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeK1GCq convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 28 Nov 2018 01:02:46 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42373 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeK1GCq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 01:02:46 -0500
Received: by mail-qt1-f196.google.com with SMTP id d19so22998212qtq.9
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 11:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+TRdDuUEJ6A+U/RjAH4tWmF9ZhPDoYh74SzV49wc1DU=;
        b=EdnPMLg94+JoRQGJFYouJEbLyWPjM0wmbmBnPJAdqtiFIbL3Ay/GGC9HDPqPAF13a3
         q2cRREySNMJFw5ILZlY6mHgx/khDdSoZaAmRVFAaUOaEK9xmEdvMVMH3ep/oiUtKtSM/
         7ZGpseNWUCCkFGRBDxXjEWxkQgPRce89c5rTxqjN0Oa+gQwxyu3zbzhW9qmWYCxCDJ9E
         LJpf8CovgZjF5IawDOQK9YB13+FgTOstVut2R9y7xo4YIOz6tt4FnEw58AkX1lYCmDiu
         1Zjvn1AreioqkHSR0HPawObiNN08oII4x11Lb1x/d2Zx7occMe3n5WelDZ5vaGgNs8Se
         U1VQ==
X-Gm-Message-State: AGRZ1gI1P9zOjg0lHzRInY455cJfcKPtqj0Ysksp2FGTdVp7xVDP3CeR
        midlr6sSVGTJf+PMcwgJSyzvALa/Jhyex21tedA=
X-Google-Smtp-Source: AFSGD/UMmuJOGSaVd+Gs4fMM288rir2MEovok3s+cMu8QLI5otMcNg02LkPgqqXwFOJClBgRYuFqRNmcDN7wvv7WIKk=
X-Received: by 2002:ac8:90c:: with SMTP id t12mr31580328qth.335.1543345434462;
 Tue, 27 Nov 2018 11:03:54 -0800 (PST)
MIME-Version: 1.0
References: <20181127100557.53891-1-carenas@gmail.com> <CAPig+cT1ruGsd-7yXV3Oxs2_9zOh-d4HgZiQ-OVZzHc1buo4FQ@mail.gmail.com>
 <CAPUEsphe5E4ZrLy=NmuAHhdE4jOjYhAstOzHRNtBcuwrhvwbvg@mail.gmail.com>
In-Reply-To: <CAPUEsphe5E4ZrLy=NmuAHhdE4jOjYhAstOzHRNtBcuwrhvwbvg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 27 Nov 2018 14:03:43 -0500
Message-ID: <CAPig+cQXkNo_Sztf3y5ciZ3jjj=XrJ+ESCxEsU_RKxb_0x+STw@mail.gmail.com>
Subject: Re: [PATCH] config.mak.dev: enable -Wpedantic in clang
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 10:48 AM Carlo Arenas <carenas@gmail.com> wrote:
> On Tue, Nov 27, 2018 at 2:53 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Tue, Nov 27, 2018 at 5:06 AM Carlo Marcelo Arenas Belón
> > > +ifneq ($(filter clang10,$(COMPILER_FEATURES)),)
> > > +CFLAGS += -Wpedantic
> > > +endif
> >
> > Should this condition be tightened to match only for OSX since there
> > is no such clang version number in the rest world outside of Apple?
>
> instead, I changed it to clang4 and tested it in a FreeBSD 11 box I
> was able to get a hold off, would that work better?
> will update patch accordingly then

Playing Devi's Advocate, what if Apple's clang "8" was, in reality,
real-world clang 3? Then this condition would incorrectly enable the
compiler option on Apple for a (real) clang version below 4. For this
reason, it seems we shouldn't be trusting only the clang version
number when dealing with Apple.

(I suspect that it won't make a difference in actual practice, so it
may be reasonable to punt on this issue until/if someone complains.)
