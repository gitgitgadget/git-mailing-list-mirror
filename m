Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3849DC4741F
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6BCD2083B
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOnrPT74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbgKEVWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732265AbgKEVW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 16:22:27 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8607FC0613CF
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 13:22:27 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id 9so3210378oir.5
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 13:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wD8FmPTy457oE43zg+PyRa4eu6DxscZ88XS1hzN6KhI=;
        b=QOnrPT74rZCeIK/HgOM7xxmBM6HtvBtUNzN3qq1Mlu1Q1Tlp3W1eybePWeN/bHbUrg
         A4EvCy5yheklc25dmKBnupkplAW5gQOrSK1Nw0PGn0DvNtXbPVO3torC3FJswwEaqEq1
         9x2zVddIZ+T21XncN6nhV6l1FtjACZUAtvdsYxbTqZG7li3FmRNbAlmcyzytKPlKKmZF
         NmIPamwxVJB78/Zg1qC37raYmzUPk38rA/4eh4gfh8PoLw678iVvuzBreh3xjMP3ZmnM
         MxYGWaA2fF07M4o/mLgQeMKrpKVF+AgIccfABjVFJHbaa+dBc8hi73sxOJd3MuXHSUyG
         2yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wD8FmPTy457oE43zg+PyRa4eu6DxscZ88XS1hzN6KhI=;
        b=K/R7mZqX1eZb8/mS2xGjfah2Oviie5oyWRWNYOX6OODdzIak676neEyWl6W4WFv/Nk
         2699+zIfXBN0giJuy3rk6AAtgg0TL4LBD/JDoSbZa3yOo6uLas22JnoXXt3MqRVchhto
         7r0fWcdAz29Mocrd87SNschCciYGCFnV0ATqMpGkym4030Fy3e0hc+B+N7S38ibwaK0Y
         AU2sNOtJm2e9mJ1S5+pDZKik231G/A61mDNpHfnxT/wNvbCd09f2MTVgtSyT2X+zFkdO
         phnhXDYWa3qHEqT95IB8djKr4sHcuoYn0Ei0ecLlAqg/jcREcM/oFbyCj+5owzjdWgOw
         XImw==
X-Gm-Message-State: AOAM5319DWSPvdBQlNWH7pLUn22bnGAqG+z+ya7SIE/i7QRSBSpm6Chw
        u6l11BjqiBcVgiyrYvl2l3jiYSfsO1rVChha6Y4=
X-Google-Smtp-Source: ABdhPJxfmMJk6dLtHKa2JOqhukU3XO8forlowqK55K1IW/koVwftmxydwvm2jYMebv08emjOFYy60kehjrcMjFN4O6k=
X-Received: by 2002:aca:3b0a:: with SMTP id i10mr915351oia.167.1604611346852;
 Thu, 05 Nov 2020 13:22:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
 <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com> <20201105132909.GB91972@coredump.intra.peff.net>
 <xmqq8sbfk0ut.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8sbfk0ut.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 5 Nov 2020 13:22:14 -0800
Message-ID: <CABPp-BGFa_e-nncnCH5GSjhn47Sxf7Tpn7prsJCWiJo-SWoYNA@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] Add struct strmap and associated utility functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 5, 2020 at 12:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > Subject: [PATCH] shortlog: drop custom strset implementation
> >
> > We can use the strset recently added in strmap.h instead. Note that this
> > doesn't have a "check_and_add" function. We can easily write the same
> > thing using separate "contains" and "adds" calls. This is slightly less
> > efficient, in that it hashes the string twice, but for our use here it
> > shouldn't be a big deal either way.
> >
> > I did leave it as a separate helper function, though, since we use it in
> > three separate spots (some of which are in the middle of a conditional).
>
> It makes sense, but check_dup() sounds like its use pattern would be
>
>         if (check_dup(it) == NO_DUP)
>                 add(it);
>
> where it is more like "add it but just once".
>
> By the way, is a strset a set or a bag?  If it makes the second add

strset is a set; there is no way to get duplicate entries.

> an no-op, perhaps your check_dup() is what strset_add() should do
> itself?  What builtin/shortlog.c::check_dup() does smells like it is
> a workaround for the lack of a naturally-expected feature.

Is the expectation that strset_add() would return a boolean for
whether a new entry was added?
