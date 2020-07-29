Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B87DC433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 06:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED09B206D4
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 06:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kmu9qcss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgG2Gz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG2Gz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 02:55:59 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D0DC061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 23:55:59 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id b13so14207939edz.7
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 23:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWeDgtC9Z5fQZiUkc9PiNJdhGLuSk5NxR1oZ1UkiH7M=;
        b=Kmu9qcss3/fE47hF4gJGHSz0+VqBtrunUs+oHSaUnM+3iWDViNVVKQyjvtCni5SCv4
         LL+BKNRicfsZPC6YsnnGETxeczKtCy2K1SgbgyzSc5hhNda5PPTLRYfRlINU8+y8Rf1q
         OOwC8exIIrr3WqiHjCk2VYiZ76LN3PDgiVbA+nIaB2/KvDDg87ZYrjs9BKQsSbYbQBmr
         pQOAWdSIUcqk2NHapFYFuIYVvw84U6QH1pUpnksCzXlwmo2t1O8jMX91CkIKJ++TuFlO
         t2xFehWpMai8Zt8h/UIUOLgkdBWxJZP6hGKO60pBAK4UE14rWe0WI3fNtn/Pmnpvcw21
         TkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWeDgtC9Z5fQZiUkc9PiNJdhGLuSk5NxR1oZ1UkiH7M=;
        b=EG0iGMWq8znRMhK7w66ZlG+qa4pZHMQfhO07zoGd0Az0t3mxXF8g0SJ/BLNbjhZVe7
         bO4oEFKZi+oaWKCk9LithN9nUiVwnSeHE7cRXEr0SPqoKorbpTxSuzXgYqJDs4bq0tcz
         RtHcRo4Olef3n1qs3T9geSAGdqfm44rg6lYaBBhtmIw9Fr9eZ6aymY3T2+90pNU26aYd
         YW+GPS3jVt/VRq1mq/kTxROV8Pv1yTlTJJCgD/prF9o0Fq6/KzHdiVyeSeyjSPsT0oG8
         nVvbHy7b+Sheixzb/t7UdIQVuS/8ZBiFFpTOmOVls4oICUItskEkc6OyLleRAgqA85l7
         xyDQ==
X-Gm-Message-State: AOAM531Y2R2s0Eg6hZRyfOyCYFM+86mm2fa6gYATtZoa/Jd4MjaQYN1z
        kQU8fXLYUAou8pKxJKqeSIGXujKmH+ZoYYWLZ9Q=
X-Google-Smtp-Source: ABdhPJwU8SKkxYzUe9glnT+rG3H5YPWB8KxmdTVsl4HSIZXPZoAuwpIe/zPC7EQEMMTCIvGZf5qOZavWJjRDAQ5WpyM=
X-Received: by 2002:aa7:d3d9:: with SMTP id o25mr3050808edr.362.1596005757768;
 Tue, 28 Jul 2020 23:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200728202124.GA1021264@coredump.intra.peff.net>
 <20200728202823.GK1021513@coredump.intra.peff.net> <xmqqr1svcpcn.fsf@gitster.c.googlers.com>
 <xmqqmu3jcp9u.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmu3jcp9u.fsf@gitster.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 29 Jul 2020 08:55:46 +0200
Message-ID: <CAP8UFD3Z86nQq_iZ3kqvuL4Vr9PxL+71VBgd7my+YUxgFyYvXA@mail.gmail.com>
Subject: Re: [PATCH 11/11] strvec: rename struct fields
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 11:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >> I'm actually not that fond of "items". I almost went with just:
> >>
> >>   const char **v;
> >>
> >> as the variable name which contains it usually provides sufficient
> >> context. But I worried that people would consider that too inscrutable.
> >
> > I'd agree that v[] is a good name.  If it is too short, I can live
> > with item[], but not with items[]....
>
> What are individual component of a vector called?  An element?  If
> so, elem[] would be much better name than item[].

Individual components of a string vector or a string array are
strings, so "str" if we abbreviate "string" to "str".

Using "str" would be consistent with oid_array where the individual
component is called "oid" as it is defined this way:

struct oid_array {
        struct object_id *oid;
        size_t nr;
        size_t alloc;
        int sorted;
};
