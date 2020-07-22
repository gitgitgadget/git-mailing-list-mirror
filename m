Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5356C43445
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 06:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 984C420684
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 06:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ukpu7EAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbgGVGq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbgGVGqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 02:46:25 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1FCC061794
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 23:46:25 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id c7so306760uap.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 23:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnkQrlkDcyfwn57GLaDdtxkHXuhDgoXW1w2ZdkbSL4w=;
        b=Ukpu7EAIodt3ded27AEkLTapcLCuJhZZibEZ9Mhh5KzbQfguU4Sa7QdxuQAnxStPkT
         RixQcJKpMMhNZefumGZyNObXNPlsxN4ozkX55ZsJlGB2SHK62BTQ7G1cW39FDPyVw4PL
         xlkomgK9+CeP1REd7TVvRCToNRHJYp50wGj9yBVmpzXp1uHjwJ4VWfGlmWdrROIah8QE
         XDyYel31C+8xWrrg3m2c3q2dhW3Dzi6swVs9gG2J8pPuJZQxAq+OjxP0MmgPU+AKnMKq
         znE/wiNtM2ZFHkc/q2t52hLdqRkU5CNpjA7oWnjj/V/aNOEbvI0ZG6hjpwiRJwe2yVL/
         r6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnkQrlkDcyfwn57GLaDdtxkHXuhDgoXW1w2ZdkbSL4w=;
        b=M2+R8dRjQHtPHaSW3rFumu9D3cxHg60hjiSm6yjRDh3YLYSgrjdSQ3dIsOdupFrUIe
         xC61SC/NOvvyEH6qH1ilBoXfmh62yKk7wIa0Q02Yc7r0ygF9VZbNF5HnOXO/G0/dH2qa
         /JCFIrIBltLPKKb5Tn4NEesxJ7g54qCXaaa1tm1jfJ28qZE/ULXZrN70JZjEV5Kmv7z1
         tIf30NXAKq3KTDHLvqmQ94Zcs7hfeAdL98qhYf5oJwZlU23sznHEszwg5UwzgS7vb5II
         7Fz0q1XDdj11RW/T1+I5W3QwLxJ90YDBkyZPFOYm6bylN4TM1/zaFNIKUoNeT06n4yu6
         QCSA==
X-Gm-Message-State: AOAM533+I+IAQnmPSkKsp75EfmDidQ1/zxYuFiQ6wlDqz+rHa7vtGlxN
        0WY0st4ZqWpU6FFq8rJfBWls7RLjuCMBj9yEMqs=
X-Google-Smtp-Source: ABdhPJyHWcTFWX96GucmsimHrXfSAEL2qUKz1Fag9IkHyJXsMr0G9FcUoXfdiCpppirIbp5K5FkzZVm7oYgfZw5ZU0o=
X-Received: by 2002:ab0:2eab:: with SMTP id y11mr21252092uay.22.1595400384589;
 Tue, 21 Jul 2020 23:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvDm6Z2HcQkyinCD4hKTnqGR3gcXodhoo0YKSnbB-vDJcn3MQ@mail.gmail.com>
 <CAPUEspg=4HJL8iiNrNp9Wr9sVj5Gw_PciSezHV5iJ1w-ymdzdw@mail.gmail.com>
 <CAAvDm6avvkXrU-Q8zu7C5WFqfCbf0DN=6cPMU-rOxgmdAh1Ebw@mail.gmail.com>
 <20200716153159.GA1061124@coredump.intra.peff.net> <CAAvDm6Z6SA8rYYHaFT=APBSx0tM+5rHseP+fRLufgDxvEthsww@mail.gmail.com>
 <20200717063324.GB1179001@coredump.intra.peff.net> <xmqqd04ufutq.fsf@gitster.c.googlers.com>
 <xmqq7dv2fnpb.fsf@gitster.c.googlers.com> <CAAvDm6bG-s2m9fGXVtuyLB7_FSDRduhb3ptrBsL3ezR9LaS-hQ@mail.gmail.com>
 <xmqqlfjgbssl.fsf@gitster.c.googlers.com> <CAAvDm6aNN2kDh=SF6_K-v+cq0a94tcQ1AQ-Fpgs2mNo18FTFfQ@mail.gmail.com>
 <CAPUEspj3A-bCo+WqiGksuLkqm65HAPiOjrWaAyy7S8XSy_Ohiw@mail.gmail.com> <xmqqmu3u9itq.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmu3u9itq.fsf@gitster.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 21 Jul 2020 23:46:13 -0700
Message-ID: <CAPUEspjggE9w5EQcMaXeU75Jo0+s=bK09cb9fcUsU1J3ZAqKYw@mail.gmail.com>
Subject: Re: How can I search git log with ceratin keyword but without the
 other keyword?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 20, 2020 at 10:50 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Arenas <carenas@gmail.com> writes:
> > repository that looks like:
> >
> > $ git log --oneline
> > b1824b2 (HEAD -> master) second
> > 00d85f1 first
> > 68757c9 initial
> >
> > $ git log --oneline -n 1 HEAD@{1}
> > 00d85f1 first
>
> You meant HEAD~1, not the nth reflog entry (which does not have
> anything to do with the parenthood sequence between commits).

indeed, thanks you; and for more documentation in the syntax of those
"revisions" :

  https://git-scm.com/docs/gitrevisions

Carlo
