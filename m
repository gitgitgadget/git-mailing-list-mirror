Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0904BC433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 00:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B381922CAF
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 00:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbhAVA20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 19:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbhAVA2P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 19:28:15 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE24C06174A
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 16:27:34 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id y128so3831532ybf.10
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 16:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z02imV18iB/qMaigug9VCJeshzrtiN/riGyOMGNU+Lk=;
        b=gkn//neYCccpEAcdhCkQlEIyzIEoKYaMHbvoI3OtJhLz9ipK6+1vzv9JIIkBbKNVti
         qilw9REA62Q1kg1dwJTSuFM7OOW9YfCFHNG31atqsMGzeW77nW6NmQqKPas5Ij8nktsr
         Ii3Tr1T9Xysd2Nxju7rr3PmLGm2IoDtH7EV+a3ya3OsNt2iX2fJAXApMDdNDDw7sPUs3
         HN+ce03FnZf2zbvlkfgB747q91Z8Rlia6ZhRgPOYK+uecwRedSyEDDoJz0EdfRlqDBDJ
         E1XkYjfan0VuSuM2HjUfvQBBaonmbnjycweuLT2nUzYWUdDZUxodR+TYxybBVRcVmLol
         4+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z02imV18iB/qMaigug9VCJeshzrtiN/riGyOMGNU+Lk=;
        b=Yi1/FULjjMZqtXxnPOnhSzavlf73IMFgK2twwlogz1xe5G/nhRQJDKN8pAdVU7YNP5
         BbFQNQPQEKX1xCdCIWPs2UqIUxnJ5RD8gehVEQ9gbedahawcUJ4hteNkCPKutI1aL8gb
         Upr0uGnYpvGYeUBM+WSSNnulMAd54a/Uq8gFlTEtombE5YVtnziiRe8d5Amtk6N1xrUS
         nTNd/pfOXyeD/eDhlswVPMxnrF06S+hpTsBPk9Vtcvwc2diAgiZxzi1/AIGwq/1EDSsZ
         FNCSIWM1VZEJ0xmH9+P50+fWf8Hzd8LTJQNaUlSMBGZTBg4fBwk5WmjVMPjR1rpGhXQi
         7FQg==
X-Gm-Message-State: AOAM531NxXSM0MLToWL4UhJ70MXYAdaeVK2rC2uZJmcBe0Hgi8xcf5Gl
        QCCSWj/g2v3y+3ID9HmCM9tOFDmWEsBsw/ASDoI=
X-Google-Smtp-Source: ABdhPJyws2EHUBGkIB+gLK2XJAsZ2JCdAXB23shoCcyJUIwK8+JKNEWl4nKh7684Rx7fsInQA/oehHU3Il+nPyzCg04=
X-Received: by 2002:a25:d84d:: with SMTP id p74mr2740016ybg.135.1611275254069;
 Thu, 21 Jan 2021 16:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20210121032332.658991-1-phil.hord@gmail.com> <xmqqpn1xalav.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn1xalav.fsf@gitster.c.googlers.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Thu, 21 Jan 2021 16:27:22 -0800
Message-ID: <CABURp0pqdK+Mrqi=r40YeUitaB2s44iYO=2UFFSh0UC_o4Mosg@mail.gmail.com>
Subject: Re: [PATCH v3] use delete_refs when deleting tags or branches
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 21, 2021 at 4:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phil Hord <phil.hord@gmail.com> writes:
>
> > diff --git builtin/branch.c builtin/branch.c
> > index 8c0b428104..bcc00bcf18 100644
> > --- builtin/branch.c
> > +++ builtin/branch.c
>
> You wasted 15 minutes of my life by choosing to deviate the list
> norm of sending what "git apply -p1" (default) would accept.  I am
> fairly trusting type and did not suspect anybody do such an evil
> thing.  Why?

Oof.  Sorry.  I forgot I have diff.noprefix=true in my local config.
It is a huge timesaver for me when looking at diffs on a console since
I can quickly highlight the filename with a mouse to paste into an
editor.

Sometimes it bites me, though.  Usually I notice in the diff, but this
one I was sending with format-patch / send-email.

I guess I'll turn that off in git.git so I don't misfire at you again someday.

Phil
