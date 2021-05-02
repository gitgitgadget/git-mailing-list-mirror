Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2B0C433ED
	for <git@archiver.kernel.org>; Sun,  2 May 2021 07:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A79610A6
	for <git@archiver.kernel.org>; Sun,  2 May 2021 07:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhEBHPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 03:15:36 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:40907 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhEBHPf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 03:15:35 -0400
Received: by mail-ed1-f51.google.com with SMTP id c22so2759639edn.7
        for <git@vger.kernel.org>; Sun, 02 May 2021 00:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=paLtJpqa5+cmiEHT7vXnQvnJmRxgbntRi/1V4TftDG0=;
        b=sSt6msE7Yc3mziXm5JIBLAL5SosUYQj5RC2dkaVbBRi4AMaJJagnK2TfII1LjLhz20
         FFmBtit8EKgMXmY70sGhcIfEo2ZwZV0hGwCWlCt1HbqMnQuTT5/AkkDIhK+ek7Si9458
         Zc20xSLoQBFkHA+8n71N0hHWCeXzhL9giTqknWfbr0usyG8R1jV9iXZIbM7CI2R4dIW9
         ajwjB9K8F0OTJ+Z+MQsssDVESWtM0eRwh6+Aq/HyiWpeqA+rpV96hi8djSLh3Q5QG0kW
         O7NbRjbZlKsFDg5kwb2OzXRBBiyX83YpuxD879gCju92IEIM98cw1qqayG3KtLg71zsx
         UaIw==
X-Gm-Message-State: AOAM530ezgT4impK3LhcFQxz6vlMqr+HNk7Fx2A7wlJYdsLOL6XTqMPs
        dHDDwr4tXwa6028PslQf6l3JRyc465lhR2x87IF3cURqVMc=
X-Google-Smtp-Source: ABdhPJyviJClai88qEpaACGBjZob13bEnBQ4JuWPgs2856AX/VKiFbs8VTspVuHuB2KK2xNzklo9COAEIlOw9K085iU=
X-Received: by 2002:aa7:c412:: with SMTP id j18mr14360108edq.163.1619939683680;
 Sun, 02 May 2021 00:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.934.v2.git.1619047347605.gitgitgadget@gmail.com>
 <pull.934.v3.git.1619052906768.gitgitgadget@gmail.com> <xmqqbl9zcawf.fsf@gitster.g>
 <xmqqk0ol7cka.fsf@gitster.g> <CACZqfqCXrhUtsC3TLYaw6u7D0VohsBcz10aVxpe-1u8gg77qxQ@mail.gmail.com>
 <CAPig+cR0Z=sUPHW8kuMG0sOv4bb309MV=WTR1nMGOoYB+1yfVg@mail.gmail.com> <xmqqr1ipbqif.fsf@gitster.g>
In-Reply-To: <xmqqr1ipbqif.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 2 May 2021 03:14:32 -0400
Message-ID: <CAPig+cRm9yE9vpcms4rpPwJxd-C0MQ8n17tiyW8ufXwG=1UaTg@mail.gmail.com>
Subject: Re: [PATCH v3] git-merge: rewrite already up to date message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Soref <jsoref@gmail.com>,
        Josh Soref via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 2, 2021 at 2:26 AM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > I don't have a strong opinion between Co-authored-by: and Helped-by:
> > in this case. Here's my sign-off if you want to retain Co-authored-by:
> >
> >     Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>
> I am not in principle opposed to the idea of co-authored-by; for
> this particular one, we historically have used Helped-by (i.e. a
> reviewer offers "writing it this way is cleaner" suggestions on the
> list and then gets credited on the next version), and it wasn't
> clear to me if you consented to be a co-author of the patch.  If the
> party who were named as a co-author responded that it is OK, I would
> be perfectly fine.

It wasn't my intention to be co-author but I'm OK with the designation
in this particular case since I did end up authoring all the code in
the patch (aside from `void`), even if that authorship was by accident
through the circumstance of reviewing the patch (but, as mentioned
above, I can go either way with it).
