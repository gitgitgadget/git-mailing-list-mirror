Return-Path: <SRS0=m+L4=A6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78456C433DF
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 05:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 459B82073A
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 05:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWRLA6M0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgGSF22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jul 2020 01:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgGSF21 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jul 2020 01:28:27 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48605C0619D2
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 22:28:27 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b185so12459618qkg.1
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 22:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zd+hp8zmYUSRlvWP+SLP1nuTRK6stcerOzbvDFof5ls=;
        b=NWRLA6M0MdFAJ+pNAPvQqz4KNC4IjYRl/JTAvZ3jfbYhQdyZlAAtcaJUeYxFImWER4
         Jr4hceQVNVG4ZxaQqKGb4DosRUsasdZDlcdw8ekUSMYsPMHng4QdI6HdmaqR0YmYzeHb
         pEWVwSpm1DVDv+gWnB6KI7TJpTb/Of1QAvb/ZCiGv7lWIwvu+Ox1Z9w8RSKJPGyCrowI
         uxaaP8nMg/Ua2i38I5s8DTHLCAqHl1k84WUT0bxH3gCcN+iuvEqlzNFkyxFxRkjJ3Z91
         8cEnpSqCbS+u9EIHgBZQIsX871lRvEN1WSD4eq0KNefwXoSwSCEE6Cw3hoNeUbgqdgYM
         UkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zd+hp8zmYUSRlvWP+SLP1nuTRK6stcerOzbvDFof5ls=;
        b=qMsolTEiVSx+nwv9LIE6bOvLoOO9XX2A74G5KipAPRD9evC8aHmdiT7kpbu3vY+1oR
         h9wz7mZNltNt125IKrpmL28N2+GkGnejvHA9DWTk6ZV7ly6EeqVRQOMycfYFZhh0Pc6t
         +LvVJW5ubyIg2MFQsB/Vi1vmwd73W06gy0BtXrPDhq6tetQcT16NPuA/kGYZnQ7p4wLd
         eY4+YH+pkAxHDeNdBtOOKRcpAd8Am1pJtB4YVU5OaFEdGw9v+YtE7I59oUDcMcJEC0bN
         I6PEUSUL4/6YQGiYcRVcvc6fnpDDkMHLdiymrE6OpIb77ooZcX37Zv+a+xPFsh7WH0T+
         0koQ==
X-Gm-Message-State: AOAM531Wkfj3uQmTz6zaXC9cMKl561l/VPkTjoFJpKko122A6uVtldg5
        pr6WTHFMQuPQ21YSG7FdytZ1sCopAMK6lmBE/4o=
X-Google-Smtp-Source: ABdhPJyGz0GTZ7v0yUVHHdW596Q0uAi/0Ipc9ShGnqcSkYIu2QzyAIGhgJcovIbWnzseuzg2/3dggQqP1brVBbfk96s=
X-Received: by 2002:a37:b141:: with SMTP id a62mr14613220qkf.201.1595136506217;
 Sat, 18 Jul 2020 22:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvDm6Z2HcQkyinCD4hKTnqGR3gcXodhoo0YKSnbB-vDJcn3MQ@mail.gmail.com>
 <CAPUEspg=4HJL8iiNrNp9Wr9sVj5Gw_PciSezHV5iJ1w-ymdzdw@mail.gmail.com>
 <CAAvDm6avvkXrU-Q8zu7C5WFqfCbf0DN=6cPMU-rOxgmdAh1Ebw@mail.gmail.com>
 <20200716153159.GA1061124@coredump.intra.peff.net> <CAAvDm6Z6SA8rYYHaFT=APBSx0tM+5rHseP+fRLufgDxvEthsww@mail.gmail.com>
 <20200717063324.GB1179001@coredump.intra.peff.net> <xmqqd04ufutq.fsf@gitster.c.googlers.com>
 <xmqq7dv2fnpb.fsf@gitster.c.googlers.com> <CAAvDm6bG-s2m9fGXVtuyLB7_FSDRduhb3ptrBsL3ezR9LaS-hQ@mail.gmail.com>
 <xmqqlfjgbssl.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfjgbssl.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date:   Sun, 19 Jul 2020 13:28:15 +0800
Message-ID: <CAAvDm6aNN2kDh=SF6_K-v+cq0a94tcQ1AQ-Fpgs2mNo18FTFfQ@mail.gmail.com>
Subject: Re: How can I search git log with ceratin keyword but without the
 other keyword?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Carlo Arenas <carenas@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

>Sorry, it is currently not in the area of interest for me to examine
>an extensive rewrite of the "grep" machinery for unknown benefit.
>The cost-benefit ratio does not look too great to just add "X && !Y"
>support to existing "X && Y" logic.  If we were seriously extending
>the machinery, I'd rather see us shooting for even more generic
>boolean expression support, not just "our --all-match currently
>requires all of the AND-ed terms to positively match, but lets make
>it possible to require some of these terms not to fire at all".
I see. Maybe, there is a workaround method to achieve this goal(
i.e. X&&!Y) without rewriting the "grep" machinery.
Is there some method(or command provided by git) that could get the
comments of a certain commitment(e.g: first, second,... nth) other than
getting the last several comments by "git log -n"?
So if there is an answer to this question, we can achieve that goal by shel=
l
script and git commands.

My answer to this question is:
git log -n 1 --skip certain_number

Is there some command that could better achieve this goal?

Thank you for your attention to this matter.

On Sun, Jul 19, 2020 at 2:07 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> =E5=AD=99=E4=B8=96=E9=BE=99 sunshilong <sunshilong369@gmail.com> writes:
>
> > Thank you for your detailed explanation.
> >
> >>There is not much room for the line-level "--not" operator to
> >>participate in this picture.
> > After I have carefully read your explanation again and again.
> > Maybe, I think there is a way to achieve this goal.
> > Please point out if there is something wrong.
>
> Sorry, it is currently not in the area of interest for me to examine
> an extensive rewrite of the "grep" machinery for unknown benefit.
> The cost-benefit ratio does not look too great to just add "X && !Y"
> support to existing "X && Y" logic.  If we were seriously extending
> the machinery, I'd rather see us shooting for even more generic
> boolean expression support, not just "our --all-match currently
> requires all of the AND-ed terms to positively match, but lets make
> it possible to require some of these terms not to fire at all".
>
