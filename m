Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDECEC33CAF
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 18:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B464021569
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 18:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="aaFmOKwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAWS1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:27:49 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:39371 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgAWS1t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 13:27:49 -0500
Received: by mail-lj1-f173.google.com with SMTP id o11so4697249ljc.6
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 10:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Wfl4znRPjIdFYV2FKvM88HDBAKegeUW4Um1oVjwq9c=;
        b=aaFmOKwAoNom7Nwe+WMXd6rMICYORxc/mx51C0qKDL3b/hu8CP2xqBJcqMzKERQDGS
         B6/WucpD2c4+UwPcjf7NlLan2eLpHlpwqdViO1/dBhBnJaNJdeGGFwzT+7/hL2Pb1B4q
         svV7J313FGP3esB0rb05iLNZfnjgf/4tEAvrasbO8qSvu3MtFW/ktdL/sh/w9ZEeWaDy
         RcL4waCuhdg99FV3EyP3/+YK5oHcU6UYLJJZDLoKPzuaG2/4oHcHoRzCmiXIPvH/dwu2
         9t8TRRF0DkqOOmLtTyztYgyZy4xK50oxmqR4HqgSMRl6l349luJ+W2iCTKm5PDAkw2bZ
         ojJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Wfl4znRPjIdFYV2FKvM88HDBAKegeUW4Um1oVjwq9c=;
        b=g2uldi9Bojhkm4yh5w8crexhsdmU//02n/vqUMQjdxF88SLHR/BsHUMY5FJyD8F0h7
         7GZNdrlrYzHnK2Lg5RkRW49XWhM2+d02lV8GdcN2QDxhBZyh36KlSFbYUcmb6s3QLbLx
         T6B/BVidQs3vJPQTmJ2CV3ywI209AorzTMONjUYGxChXBiXwE2V63RUvBBj+vkKhvq1k
         Kw6o2TNjxOYHf/LUoPnj1T/CpmJed25lx7k/XMaEZa0VueG+jK7OfbhzpxTvkIqdSeWN
         D2LCLu6zGC2iouVyp60qkRAa6Q0cQGdJ1db9VUmyju+3IOCvDOQ2nscUTYGze+RopCj1
         3cTw==
X-Gm-Message-State: APjAAAUh7IXLy9ld9umo27IhPcwsblpTWGuZNFT0DbLQnmM709y3v/FZ
        rUJXksxjJCI0IrqhRbYjp4htXWzrNxqbuILdDI/1/Q==
X-Google-Smtp-Source: APXvYqxj89Mf2WAJcd7ubtVzJgYdqgQbjkxHVjB70mSMYSJ3YHnQn9aryxYxuFW2lZ3Zb0qBukEhFYP/MenMYJqlTH4=
X-Received: by 2002:a2e:2a84:: with SMTP id q126mr1142835ljq.258.1579804067332;
 Thu, 23 Jan 2020 10:27:47 -0800 (PST)
MIME-Version: 1.0
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com> <20200122235333.GA6837@szeder.dev>
 <xmqqftg6671g.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.2001231306351.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001231306351.46@tvgsbejvaqbjf.bet>
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
Date:   Thu, 23 Jan 2020 10:27:36 -0800
Message-ID: <CABvFv3KRAA9i75qBWDpnOro+CKRfqtPbh+LwpB1+EN+GwRGkkQ@mail.gmail.com>
Subject: Re: yz/p4-py3, was Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 23, 2020 at 4:11 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Should we declare `t98xx` to be the namespace for the Python-based
> scripts, or alternatively declare that we won't ever include another
> Python script but `git-p4`?

Seeing how git-p4 has de facto taken over t98xx, declaring the former
makes sense. I intend to introduce more features into git-p4 so it'll
probably be practical to reserve more of the space for it, probably up
to t9850.

On declaring `git-p4` the sole approved use of python, I'm personally
OK with it if there's no appetite to better integrate Python on
Windows.

> But yes, I think that we should probably "tack on" the Python 3.x tests to
> the `linux-gcc` job.
>
> Or maybe finally split this job into three: ...
>
> The reason to split it off is this: on rare occasion, I have to restart
> the `linux-gcc` job because _one_ of those `git-p4` tests failed due to
> some reason or other, probably timing-related, I did not have time to
> investigate this. Having to re-run the entire test suite, twice, just to
> work around those flaky tests is rather wasteful.

Agreed.

-- 
yang
