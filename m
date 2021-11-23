Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8253FC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 17:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbhKWRbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhKWRbp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 12:31:45 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254C6C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 09:28:37 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id e27so9933790vkd.4
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 09:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=td+Yzt2mN9JHg1acIBBqDdaavC1cJn9AmppD4fAfsn8=;
        b=VYBHnkTWIb8wNO8vQ72iX3exzVV3H1VUetIgqamepiNVp1+M5IRu3cYsw7jiDYJWR/
         kRGPfrIUqNjHqL0YlC9nj2GgF6P3/rJ0Qb7rgCaZtW311yT6/R9npeoxrjMr8+Af+Uhg
         OUXkorOZ24rS2YcFlkvR7Ht8bXeeRIkP5OkTCt2RfOxfAtMOzsOeYCB2FFHz/bDi1vtP
         omOUqTdsSt5bWHL5J2FvGeNa1KqUdNKs1V5w3IGs1r6e8cuglDFTYnmBOylq5RUUhIgP
         iDZEl7ZStyO3gtZ3gzh7mKIlygyIF/0I2/mbAbEQ4NIGXV/WnUX9T5q3R3+uoqoLyGQg
         cDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=td+Yzt2mN9JHg1acIBBqDdaavC1cJn9AmppD4fAfsn8=;
        b=yOiE8Dg6gaHhRnB3qul9xel0l1z/jQPBHzgXK5hFsEHzkc27Z1JYQALit9jmTRNPoG
         fmRyWXC5LPmDCTbmAydFsXL9VUjTHvqGCOE5lqCsy4ngFRwrnOTg6al/5dNyudFwhCtP
         LzmvAi6VG1EBsXckP93xF4dxJ+S7mK9AmqZZEWKiBDnZAiZ89X4h3m7QDpcr58DvtgP9
         XxXKZzsSbC5QeDbX0Y38f4IvvnQgaQ5oQ9s5OyvviGvun1r9jThsB8MPdoPR83hIIalX
         i4/cd5pFujQjXTfhHgvWpDByRWAAXFQjlAofOypjJnc7mK1IVsMAPirde7A/XqQd9k39
         Ur7Q==
X-Gm-Message-State: AOAM530d1vLBD5o+iME0B8AKKpqwUedzVdqV4uu5/CRBiHVRepqi7avY
        usk09nv6inmaZ7NLBHhP4jSERS5g9pvhlpxyI5PEoA==
X-Google-Smtp-Source: ABdhPJzBGRL3b3uauiJHJg+zAywvm0YWDseUPGJ1FM7+Q2zltv8LjTrDHqql0M7oemzSsuXtAq3X5eGRGUZMMdq7tys=
X-Received: by 2002:a05:6122:98d:: with SMTP id g13mr13659856vkd.15.1637688516045;
 Tue, 23 Nov 2021 09:28:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
 <xmqq35nnddw7.fsf@gitster.g> <CAFQ2z_PE7TMj=qfQVroK_gRfZk-xF9PKhk2yxqF-bB+2aA7eoQ@mail.gmail.com>
 <xmqqczmqajdk.fsf@gitster.g>
In-Reply-To: <xmqqczmqajdk.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 23 Nov 2021 18:28:24 +0100
Message-ID: <CAFQ2z_Mct+KBZ3vO6udwqeiHYA8od8CGH_w5BO5LaidP-AYDsg@mail.gmail.com>
Subject: Re: [PATCH 2/4] refs: trim newline from reflog message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 23, 2021 at 6:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> > On Mon, Nov 22, 2021 at 11:27 PM Junio C Hamano <gitster@pobox.com> wro=
te:
> >>
> >> If this were truly "user-provided", then I'd argue that all backends
> >> should follow whatever the files backend has been doing forever---if
> >> the files added LF implicitly, others should, too, because that is
> >> pretty much what these "user-provided" callbacks have been expecting
> >> to see.
> >
> > I think it's just wrong. If you pass `msg` to a storage API, you
> > should get `msg` when you read it back, not (msg + "\n").
>
> If you give a log message "git commit -m 'single line'", you get LF
> at the end of the commit message for free.  This is no different.
> And you know that this is not a "storage API" that stores the input
> in verbatim after looking at refs.c::copy_reflog_msg().

I'm talking about refs/refs-internal.h. It seems you want to add something =
like

/* The ref backend should add a '\n' relative to the message supplied
to the delete/symref/update functions. */
typedef int for_each_reflog_ent_fn(struct ref_store *ref_store,
                                   const char *refname,
                                   each_reflog_ent_fn fn,
                                   void *cb_data);

?

--
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
