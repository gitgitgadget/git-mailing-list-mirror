Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D119EC433E6
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 13:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD74C206A5
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 13:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7tU7Rl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGJNOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgGJNOs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 09:14:48 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E1CC08C5CE
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 06:14:48 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id p6so1797389uaq.12
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Px6mrpxHg4GxC3dpd2DpsqZej71W66Q3oRle0bGz/is=;
        b=p7tU7Rl3nuLDqX+qLVe+nvbP3mGutrGsbvtQdcMWvbZwL1zeg2jCex/9h4mqCDKt2M
         yGpL5t/Uu6Q2NzO3fgMNHP6n58Jz0baHfLNvguyqvaoV9yoVKiZIyCmpWBHe9tEiNYHG
         bZ+Ey+TdQYovNpHcRe/epCan8Alv5dsTcgMrwDXssOquaa28B1lI8X4Mj1vWt9BRdwUl
         FChmhMFs4c1q/gbNnihT14XGojiw1kIyZZdMAiwZoUJRHioYr/ZhvZKjseJXXp73DFQH
         pL3xuqDZoDMcM3+c+13D8NjXLmLIoH8rFcy1DZksv9PKqa1/uHxXas+5ee+ZAUW7GWEb
         mCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Px6mrpxHg4GxC3dpd2DpsqZej71W66Q3oRle0bGz/is=;
        b=qVxq304zXhC32BoKKbnjcvyNa7KY1ib55U27S7f8QOiZHVCTxIDGLB7gyPoXcJWQSY
         lZUqtdCkIb3m+J6kz14QeWkD/UTECMgbqI8NyRZj0Pw+xecapeIZWuQwpLtCrQSc5Tq0
         ilqkM/bpceHXRXFS8IDx07bvAM0YfW+4uRhUijEFMUwagMSfM3/eUZ0ESQknG7DvO4US
         A8AzFwR5DqQlkZDAAQh2X3Li5RD6nUgoO0yZau3aW2/5EEqfkPLJzCnFA1sv0oa5Mc3Z
         S/wxzZGdIOPFEQRVuIMCXEk0XE6hLUoAA3UvFBnHX+S2phXCF6C03Tzz7VtHaofJyujt
         BTzg==
X-Gm-Message-State: AOAM533xFIASRns1W1zb7UGwOB9hR1Tc30Rxgw3WbeICamJCxzewBTvc
        T9k+t8z76DNN/1RnRho0Cxm8TETpTWnFf9KP9yxQHjn3
X-Google-Smtp-Source: ABdhPJy1Q7CqHyfD7T/qh6SpMskcvk0rMYGKN6fsvs2SpvOecoyDxjrPuXan/x41jTdtvWfUh6ttKEDCTzEYrkFJ+R4=
X-Received: by 2002:ab0:53cc:: with SMTP id l12mr22394168uaa.24.1594386885787;
 Fri, 10 Jul 2020 06:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAFMGiz97fcw_nvaa=Xo-roTtB1o25qO06=PHGSrBzv4k_zGqaw@mail.gmail.com>
 <878sfr1rdm.fsf@igel.home>
In-Reply-To: <878sfr1rdm.fsf@igel.home>
From:   Tom Browder <tom.browder@gmail.com>
Date:   Fri, 10 Jul 2020 08:14:08 -0500
Message-ID: <CAFMGiz8+pjskPpPqVgQUevKdWgxPvCKBcmx-07E2yizDqhm9mg@mail.gmail.com>
Subject: Re: "git rm" could be safer and have a better help msg
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 10, 2020 at 7:33 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
> >     $ git rm -f --cached myfile   # many thanks to @jast on IRC #git
> Why do you need -f?

If the existing file has been modified, with 'rm'  the '--cached'
option doesn't remove it from Git
unless one uses the '-f' option with it.


-Tom
