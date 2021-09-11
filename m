Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A34EC433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 01:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 455AD611C0
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 01:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbhIKCAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 22:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKCAm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 22:00:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895AAC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 18:59:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a25so7947041ejv.6
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 18:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=HXNw42Z+q0wUan5+t63a/ZcRBp6p9hCSbbq+Q7QPtt4=;
        b=oKYLhFtNCp9/eFruFD0LBIU05xbmLJOWMK9nhZGOY5sEJGuSoB9W+bFEZ/SjhJOC4O
         /M4YTIcnEs1ZrtLuFU/GcaIyRRiSnD8ZwJen3gNJmbOKt8lJC3ABSTpvRwqWtpZJJ4TU
         kD38pivDD/5OZZsL4dEDLVvuBSlad71HmxgznTpXq6hUuk5b3JcSrE2iGfko7JNX7F4m
         qO0Lylw0QqvtB6BzyZzbFvHeiQTI8+5jJw05WO+qtNbNsJq+eDdvS2lm0WKp9MH7QtPm
         xUMnN9sNj/VQHIpGaWxuqsPkkOC++mx3KT3bSLtJDHglivGN3LrdR+Y306SPxAwP13NQ
         qIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=HXNw42Z+q0wUan5+t63a/ZcRBp6p9hCSbbq+Q7QPtt4=;
        b=rtmoswE9Ea/88qd0XVc9ZQG+tNMzlsm5M09TXcg79DI3vD2CzH79baUrC7S3lQ6XT/
         TqXV9kOfw2bVrN5z2iloWrYWaBrdQrOQ5NT/M5TBA8cmLPd3WpGamJ4NKQ6InLUEG0AP
         T0dzsxbuQs5o/tiyfdrqoY1NH85/R3qwMz5sZ+6/IsPNlXdD5aibNEuRoPheh6qRvryq
         EogX+uLs28p9ya6tF18FtLxpyyQe4ndr01tRrKqftmysmN1I0HLu8SG0JWV7Uh4uxX5X
         JgrtQEh3y2NOdKQvmjtutRSuxzrPHzdlz63tP+FwR1RUskagRdMty4IX1fKs2vkarqA8
         eO7A==
X-Gm-Message-State: AOAM531Fp5w5VSQHl8mCR7OFHLzIef5ufWCkVOngTSYtyvBGvd6WSG8m
        5qC9gQlv27+ECq5VStq6t/4=
X-Google-Smtp-Source: ABdhPJwPbldRy6zkL8MtxCxJbZ1cos4Q3c6Rpvzpw3lOJR6R3nfebbRgJdrVTSVA8Vb9f/xcuMoevQ==
X-Received: by 2002:a17:906:c251:: with SMTP id bl17mr585075ejb.219.1631325569043;
        Fri, 10 Sep 2021 18:59:29 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bw25sm130016ejb.20.2021.09.10.18.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 18:59:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] notes: don't indent empty lines
Date:   Sat, 11 Sep 2021 03:53:38 +0200
References: <20210830072118.91921-1-sunshine@sunshineco.com>
        <20210830072118.91921-4-sunshine@sunshineco.com>
        <xmqqwno2505w.fsf@gitster.g>
        <CAPig+cQ6FA0rUnkkTDRUD5vAD3cDXW9vtR1oX0pUJK5eJB9CHg@mail.gmail.com>
        <xmqqeeaa4y0v.fsf@gitster.g>
        <CAPig+cQdXp0c+JYthvy+bbr6vLR7nq4pQY3w+CADUtzr+Ang4A@mail.gmail.com>
        <CAPig+cTFbnrPPSZbzihJ9gdGV2c4poXWyNjhK3mnr5_uRwpxbg@mail.gmail.com>
        <xmqqwnnos2jz.fsf@gitster.g>
        <CAPig+cQdAuLkZ0pDK6XOfm_WXCJAOm8Tr19oK14n-Tf7DcfW=w@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CAPig+cQdAuLkZ0pDK6XOfm_WXCJAOm8Tr19oK14n-Tf7DcfW=w@mail.gmail.com>
Message-ID: <878s03c1of.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Eric Sunshine wrote:

> On Fri, Sep 10, 2021 at 2:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > Have we made a decision about whether this patch series -- which
>> > avoids indenting blank notes lines -- is desirable? Or are we worried
>> > about backward-compatibility?
>>
>> I do not know about "have we made" part of the question, but an
>> input from me to come to an answer to the question is that, while I
>> can see why it may be desirable in some cases, I do not view it as
>> compelling enough to risk any unforeseen breakage to other peoples'
>> workflow.  My opinion is based on an assumption that it is desirable
>> because it would squelch "here is a trailing whitespace" noise in an
>> editor and/or a pager that is appropriately configured and allow the
>> user to spot whitespace breakages in the payload more easily and for
>> no other reason.  If there are other reasons that make this change
>> desirable, they might influence my opinion.
>
> Thank you for the response. I didn't have any other reason beyond
> squelching "here is trailing whitespace" noise when submitting the
> series. Thus, I can't provide any other reasons to promote the change
> as desirable.

This change per-se seems nice, but even having reviewed it to the point
of rewriting parts of it, I didn't really look into what the whole
workflow you were trying to address is.

So e.g. just to pick a random commit of your for show:
    
    $ git show c990a4c11dd | sed 's/$/Z/'
    commit c990a4c11ddZ
    Author: Eric Sunshine <sunshine@sunshineco.com>Z
    Date:   Mon Jul 6 13:30:45 2015 -0400Z
    Z
        checkout: fix bug with --to and relative HEADZ
        Z
        Given "git checkout --to <path> HEAD~1", the new worktree's HEAD shouldZ
        begin life at the current branch's HEAD~1, however, it actually ends upZ
        at HEAD~2. This happens because:Z
        Z
            1. git-checkout resolves HEAD~1Z
        Z
    [...]

Here we end up also adding the whitespace indenting to the empty lines,
whereas if we were trying to feed this to an editor we'd place those
later Z's at the start of our line.

Are notes different? Or are they just similarly indented? For commits we
don't insert that leading whitespace in the commit object, do notes get
that part wrong too?

It might be showing, but I've only used notes a few times, my main use
of them is Junio's amlog.

So even for someone experienced in git, I think some show & tell of
step-by-step showing in the commit message how we end up with X before,
and have Y with this change would help a lot.
