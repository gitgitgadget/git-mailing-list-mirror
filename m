Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FD7C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1646C60F92
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhHaNhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhHaNhv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 09:37:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C03C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:36:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id x11so38929581ejv.0
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CR/PcUGVKtW3Z/V+Tlgqr66RYtV5MfdvpSu2jucPkkg=;
        b=RAj1z0O4bOifJvrq0HIO6QZiQx3dythyqd5oTgdhyIe0vYfstdhqoYdva3hH7xCfJA
         KnmreY1wfWm9UbDrDcSEAYa/RmjrN96CMQa7hlpJEy4/Gda4aDgEEJHnQgFmCRzqs44G
         tQeETq5mzEecJyNzO1YUXjRxxGXcyrzt2acEYBVNrt/C+Al+XGaknMiUQwl1Qt+9VXM7
         Xtr6MfyheAm0zRolk9YpU7B8QM62jj+GmnpVU5qFf3IanTjjHVikVIGWrtIDED4grjp4
         ezpitd9Gu2h19/5TuttwfZfDjTmdHSmjgBppZ6oYbebz8MsOrEj5f0LB8/fLAlaagRgV
         ncjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CR/PcUGVKtW3Z/V+Tlgqr66RYtV5MfdvpSu2jucPkkg=;
        b=tuxlPCY/ABCMdo7Sw0Sm6CvO5uBYflLWlNn7SOzfptf/UbxLpfekFViMucG7MY1KEY
         OCqhQRr/3rQSi6vjl2ZUd244TNPmBUWGI0fAuSzqoVhdi5hxYrh2mF3Pb2jQrNonnOHr
         d10Z2MFmpXs1dvIUES9wEKiYTHCI4BXQ84MRSMgnqAbRO9aWFlfRumP5M6rT1Wivrdfm
         8eTDZELm0p1FgLL6Ag0+kg46GOl1gYVN7KgiG3kt5o7fqfPHlRSE1vRh95YjGTsGCB5o
         4PpOoFVTU1TymaY2rPyHcjJn8MjT9XYfXLrkcm/WMUAbH5o62LyrBEqQU5IHoEkG3WRm
         1A/g==
X-Gm-Message-State: AOAM530hsEPgOqNeEnPH1p6h6KC6mBpfX8FH9bZ8HYWl1aMnILNjPT8n
        w1jTeqqFTM4JzVyxdVjCyIltteiy8PNIeRip/BQ=
X-Google-Smtp-Source: ABdhPJwX2MtNxP68qSTmuu3p468oV3KpOQ66TmLhDXhgiXG93HOb+DyHVsi+xyISWQ7/4w1MpcZxnHlDmlzci4Kuemo=
X-Received: by 2002:a17:906:4784:: with SMTP id cw4mr30661937ejc.160.1630417014645;
 Tue, 31 Aug 2021 06:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD197_XdFZ--khJa_E7bkG4VCsD0dPVP60AD=AfQU6Sz1w@mail.gmail.com>
 <CAP8UFD2YgpjB4oMEE7X2G4f_hN4=-mKcwBEAXn=qpkXCCWjVWg@mail.gmail.com> <b4636123648204338ee2c6180a1822b2a9a65c4c.camel@jansen-preisler.de>
In-Reply-To: <b4636123648204338ee2c6180a1822b2a9a65c4c.camel@jansen-preisler.de>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 31 Aug 2021 15:36:43 +0200
Message-ID: <CAP8UFD21pDJtgEF4_btkMmasQhFmjZst26uXHubzDO=gNMuPAw@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 78
To:     Markus Jansen <mja@jansen-preisler.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        German Lashevich <german.lashevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 29, 2021 at 11:36 PM Markus Jansen <mja@jansen-preisler.de> wrote:
>
> Tried to sort out tenses in the story, and added my usual tiny amount of correction suggestions in 34d65d4.
> As usual, feel free to further correct/revert/rephrase etc.

Thanks for the fixes! They LGTM!

> I like the backreferences to past editions, which I regard being a build-up mechanism for a collective/community memory :-).

Yeah, it's a balance between making things more useful without making
the text harder to read. But I think so far the result has been
positive.
