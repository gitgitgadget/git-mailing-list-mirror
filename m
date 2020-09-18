Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400BDC43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 15:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE98D2100A
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 15:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpI8yZM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIRPc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 11:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIRPc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 11:32:57 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9104CC0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 08:32:57 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id y9so6643465ilq.2
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c05kNpUDrCPe4CA6fXSaVP6jlHKeh24jHgigZREyNGo=;
        b=IpI8yZM7Ya5g8MD03Q8W3bEdamiXrxOSV1w7mpgLzMhWJrOB3OccaCTF5j2on38zla
         KOP68/82YNqWs+dCO2piffmjhXlpYdyNbLrCpolO8juvxqGfKQKf8SEbBB/gqf9yNi+E
         dtR29Ky+gARrN3HNi46kFpFiybWEDX9rqFxJ06ZPmLgLMXgsojauw8wzvZiZhrV5efai
         IY6oTsCvS32AsjKO/KyB74hhyfonFHWdS0vSsk4wDm7NQHYoZmSSpSRmJkMuA/kZ18M8
         lZIQNJivJk8ooyk6nCnCDPtSXZtaa2BDrKTkWeQ6iCiE6DHL6G2o+EPzvgEdXdJIHQS+
         umlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c05kNpUDrCPe4CA6fXSaVP6jlHKeh24jHgigZREyNGo=;
        b=c3g0nqRzUVeB5UzxX7RWtDTGrMnwti+r18R3zv+VvoEpl8tp6BW4d8fLK9kvKO98Vp
         8HCTwdXs8+cGrsT0xTBwYowU8M0a3CnEpauWomWRfA5DH/m90p4gLkFrYQunwdoSl4lw
         naD+KGmzOB0dC8ZDMoxYLhJ3Dh9YNKwmX61lIQK+gw02NDJUh90vvj5TRHgvRtOINpmC
         NR6nCI4WwJJWegjTWN1qnYEy517M9uCuN5DmBA0LJnd2LciwyeHg9ksyjjoY+nf6MIKY
         P71K0ZupTSb3K/hkVoMICfvEJML+XZFGhaS7aMXSC30b6X1TGPocHlUFo2RPQ9B+T2ON
         A9TQ==
X-Gm-Message-State: AOAM5329neCW1sozihB+AuIBCcoytKqpEeiWWwf4nUZRdnoLEnF1LBob
        cAiqyZELBt2BW9oRTWN+R0xjUBHI9l7mWrb4DCnS78Si
X-Google-Smtp-Source: ABdhPJyAhQWw43W4rBA4TpehDGplHMUBteWPszxjQIaYZQabZDKHpMxFZUa/b55FHP7U3SHxUOuH9rhsWzWT42cJOxs=
X-Received: by 2002:a92:9646:: with SMTP id g67mr30234225ilh.116.1600443176035;
 Fri, 18 Sep 2020 08:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMJqmUmCR_u3fxSVppzwBo8_6RJG5-WLrXAWXm+OQ6_3bA@mail.gmail.com>
 <20200918140236.GA1602321@nand.local> <CAHpGcML=EFRngwjgaXNE53OOPoEBz+4Qi1v354gAv_vHNYS_gQ@mail.gmail.com>
 <20200918141725.GA1606445@nand.local> <CAHpGcMJXZ++t0UtyCRSh=cB8uzy51hJTNxaF1Zd8Z-AQs4w+QQ@mail.gmail.com>
 <871rizglfv.fsf@igel.home>
In-Reply-To: <871rizglfv.fsf@igel.home>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 18 Sep 2020 17:32:45 +0200
Message-ID: <CAHpGcMJhp7Z6YnuTKRXadiOOUYV=tFPRE-_-rAri1iHDPk-C=A@mail.gmail.com>
Subject: Re: Apply git bundle to source tree?
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Fr., 18. Sept. 2020 um 17:21 Uhr schrieb Andreas Schwab
<schwab@linux-m68k.org>:
> On Sep 18 2020, Andreas Gr=C3=BCnbacher wrote:
> > Am I right in assuming that v5.8^{tree} isn't included in a
> > v5.8..v5.9-rc1 bundle?
>
> From git-bundle(1):
>
>        As no direct connection between the repositories exists, the user =
must
>        specify a basis for the bundle that is held by the destination
>        repository: the bundle assumes that all objects in the basis are
>        already in the destination repository.

It's pretty clear that the original objects are needed when trying to
reconnect the objects in the bundle to them. That wasn't my question,
though.

Thanks,
Andreas
