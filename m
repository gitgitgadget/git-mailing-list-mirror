Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4415CC4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B23C23D98
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgLJAcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 19:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgLJAcK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 19:32:10 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4BCC061793
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 16:31:30 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i9so3672158wrc.4
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 16:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pRIRoQq/f8U/5mswsXoVFnDRoeUo6PSHGgF/Lsxbp9A=;
        b=PKXTaKlGWw97Bbc22MbqwibhREOUZW9huZXn0dhAQccWcSDad5vtkho2/U4tRUSwGQ
         HXhQlrAyP9prOgnl6wOX15NbzDemEVzxAcFR+XO8admMdnoS+aS18GNCLSFsPAaHysjH
         OboUhra956gYLdidsc6WnmHWnP4UdrqE9V4siAYiC5HedQM2onBcxMlDvCtDt5SxYakm
         jAM8bfUrltH+yjquRj0Luzn1coFirEczZ7gjY0UuxD9zktRGcMPKOGfowuOM8ly0xCyY
         C3muFhN9NQD6uAb7fliRrFpltiSWmrMT1B2DZvWheh0wQlg/rQp1qrSr1sV1rGSbgcsI
         KHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRIRoQq/f8U/5mswsXoVFnDRoeUo6PSHGgF/Lsxbp9A=;
        b=KceemWPiEtIfHFHA3x4tZVfUA3UuAi7RYtqLD775YugcNUstMJ7uOqnFHhCgPHICZy
         ziaILIML/0CGgBaXQphAW3n9yBuC4dam0BUaFQCsXzJACMN2KCQu/r4+KpS48ZAJUTzK
         zaNpBXxn1V0C1LbUrZFlKVQelMqv+aNPxBP/v6s48VnnczCmns2EdSOMelR70L7zYRje
         ISnVYSge6wtCRxKK7QGceKZY50PyGYLowpHajhcZM5NJ3H9I1ivee+OaNBmceE9mMOtx
         H+36Vwaww8fwzgJQNTn/mu7c1WuKd14gLAfINuCfc0yXgmcX7R8Rrq/qK7ucneTLnysH
         Ucag==
X-Gm-Message-State: AOAM532nWqeRy+upbhsTWqMSgi+M17gd8aEC9dSzt1+A6Kj0To1phtp/
        QUML5wQDg11oMpJW8h5ssinsF2YGmGoiU4YSOUs=
X-Google-Smtp-Source: ABdhPJy3phyMOXIBN4PGiXMg80sh2MIkA/AwFbcnksNiUttlR44XL5fKizn4q00zhqTyzZNhGvV83byEzUckcgRfHFo=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr5111188wrr.319.1607560288999;
 Wed, 09 Dec 2020 16:31:28 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2012091502000.25979@tvgsbejvaqbjf.bet>
 <xmqqk0tq1xf3.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0tq1xf3.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 9 Dec 2020 18:31:17 -0600
Message-ID: <CAMP44s0663k2M20UACkiBfFERXgj5-_50777zbfa_s1PNYRgww@mail.gmail.com>
Subject: Re: fc/pull-merge-rebase, was Re: What's cooking in git.git (Dec
 2020, #01; Tue, 8)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 3:28 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> A spot check: do you have pull.rebase set to anything in your
> config?

I haven't. I typically make the choice to leave Git defaults, to
experience git as most of our users would.

Plus I don't use "git pull".

> So, if this "default change" is done in such a way so that it won't
> make any difference to those who have pull.rebase set to either yes
> or no, I suspect that the fallout would not be as bad as what these
> test failures imply.
>
> On the other hand, if the implementation in the topic forces
> everybody (including those who have made the choice by setting
> pull.rebase) to set another variable before allowing to work with a
> non-ff pull, it would break everybody and is a disaster.

It doesn't. If you have configured pull.rebase you get no warning and no error.

pull.rebase=true translates into pull.mode=rebase.

Cheers.

-- 
Felipe Contreras
