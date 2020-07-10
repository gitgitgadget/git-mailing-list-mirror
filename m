Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D3AC433E7
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 16:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13DE206F4
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 16:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2Duo3BJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgGJQcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbgGJQcN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 12:32:13 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE473C08C5CE
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 09:32:12 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id o25so2014461uar.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 09:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r30G0eeceZYDHpQzkfKQ49pUySf5NuQ3ao0pgEOMKUg=;
        b=m2Duo3BJvZ8OcvsmOIBMzQMeZYUaVOwZXy2A4x7nkNDwPyxco5w2ySjxvtBABYROOw
         ZbEGig9K1izt9ylLV4tbBwUlK6cdFWyrn/4XJWrdTYMnruQbIk3v4Di9bF/knb1Tyq8L
         9twT4prZ4aKvvGbd3+0CS0od3066tkWJixLpD4X4Nfxy4/b3XZ3H0A4VP2CdJleuMt6X
         3/x5PfzLs0Aev/nQ0VKxKUZMJw+0NGtsUZ/PqFHT+bIiAS2rYWchl3VGTCuh//ir/V2v
         aG0LtMyhdfmWIlcicT12Zay4RlVx1EbNY0B4YQjnlmGcQqVJUiGpT7vwye7i3CsQMGr1
         vTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r30G0eeceZYDHpQzkfKQ49pUySf5NuQ3ao0pgEOMKUg=;
        b=DZ4+DVHBWD0r32uyzCwoNoyf6X6rkEJUHNQInHnSWMO0FKHJIc4G3OfwBjbaENqQMB
         0Pp3csIWPvcFREpLCfvG5iEc71XRZOoqf9te1dzin2XFstWa2PJ/L8MTf89Cv+dNg2Nn
         fo5Aw/FD1dVmJuEClYuEHRzkFNrMnQN9FjY9hT4XNtgoZptNIomDrtJ3zomaArGHApTn
         x/MsR68iCU8Ba+HIBDp+KUoWhS4FRFTY1imwww9NU/DL7v2yHtiHb6aknKT9kiCliutk
         dCcjIv8W53ReWoNV3HNdwTbvy0byCXduEvmnlxmhsCKEXyy9nKF90lhBALavIigf+9nW
         jlUw==
X-Gm-Message-State: AOAM532/6+7J3V5DHSxrFUhXs1lueUwvPs5wHuqzqy/2OVMVT7h5PYRc
        A9k3xsP4MDNrnvBJ2n++kEC0CmwC8NJ/M7AMCtnUSIpq
X-Google-Smtp-Source: ABdhPJwULUCI/RFecWutoewc1pqlZdyLiUDYG88lTQ50wEvgtZKZaP36OWsXzOPeQHJlnBACZPZC+lzyut5PqYYjelk=
X-Received: by 2002:ab0:22cf:: with SMTP id z15mr18173053uam.52.1594398732057;
 Fri, 10 Jul 2020 09:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAFMGiz97fcw_nvaa=Xo-roTtB1o25qO06=PHGSrBzv4k_zGqaw@mail.gmail.com>
 <878sfr1rdm.fsf@igel.home> <CAFMGiz8+pjskPpPqVgQUevKdWgxPvCKBcmx-07E2yizDqhm9mg@mail.gmail.com>
 <874kqf1n65.fsf@igel.home>
In-Reply-To: <874kqf1n65.fsf@igel.home>
From:   Tom Browder <tom.browder@gmail.com>
Date:   Fri, 10 Jul 2020 11:31:35 -0500
Message-ID: <CAFMGiz_5Jop2nVXJuMOR7NT9gKEygueic1m5-yw8BrkDgZ-O3w@mail.gmail.com>
Subject: Re: "git rm" could be safer and have a better help msg
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 10, 2020 at 9:04 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Jul 10 2020, Tom Browder wrote:
> > If the existing file has been modified, with 'rm'  the '--cached'
> > option doesn't remove it from Git
> > unless one uses the '-f' option with it.
>
> It doesn't?  Worksforme.

Thanks, Andreas, that does indeed work. I must have done something
wrong, so I'll pay closer attention to what I'm doing.

Best regards,

-Tom
