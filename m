Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23412C432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 20:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E276E207DD
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 20:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCB01KDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfKXUQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 15:16:00 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:36431 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfKXUQA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 15:16:00 -0500
Received: by mail-il1-f195.google.com with SMTP id s75so12270293ilc.3
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 12:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qzp/6+ZYjWPjOtdIfjywcbHm6XmrWnzNLdolg4cCVMQ=;
        b=KCB01KDTC2TIfitfeQK4SsnuRh7qKNOik8j8dO0q8b1tB7IDmSR//MGpekrAVN3m+6
         MWSq1Z28skf1LjMUoTaFWSRaNM02U0y6LVvUn49b8Nah3YPSnVDQJlR9VwDTQUAUr8ZU
         A/BTx9uyUv9+sAyK1HeQR0fy9+hXzludvDJyEvqkbsjDqhs3KTc+IgDhvCZ7gTDnCF1e
         MS5x9OjZ9COAtEyvdhempsKk3sUnpt5JYdiWA+HkgRmguJrjSzq/ChbpaEllxyruFuhd
         CBzV3RxOOXiMpgRGbd0r9HiArFTITz7wwKkQh8jyOh4UjeotxuK8CpO4q6y1IpMb1Jzw
         hZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qzp/6+ZYjWPjOtdIfjywcbHm6XmrWnzNLdolg4cCVMQ=;
        b=LrF3lWbAks3dLJXAxk4+ORwiCouXtqbAfVd5f6a4E9+ceaC82LK2mQlXcPgRN3efXv
         PaV3WRIBB1lD65IVOAh7tH2TJ9CCJNgSG6ZSRRfG6PKSugs5VS3DtWILRFke2MFAykUd
         h8AKApQpqSdTAIkxew2meIlq/pN5rlvcAbTqpW2e7szcfJCp7j94rPa3XuUysyi/oe63
         P7d5hZdpwVahMPQzqQ0aGjrAypX6zeTUQkXS8rDu2TSmzM4lLz4MRzoGvn2uFu0+5zBO
         c7e0/ViDPCtOB79jW7y0dhSpu43DQzTSxYR8ODVSvN7fkrR1D8KrzRnDxpUvesbl/gPN
         vPyQ==
X-Gm-Message-State: APjAAAURj/HUK6jXy2RNS8SOe214vBfnDHMJ2dy4OOE9jO0BaQKqc48S
        Qtl5lBdNDs9aHdUm71see1SHGAECtyEjWDyAAd0=
X-Google-Smtp-Source: APXvYqyWhXLO7gbOykACZTK2SzHAV4jyvpEPenb6k5x6TwugCy2wIuKeAulMeCaO/ZAWDYMQjUCAYRb/mqPwB+r3kKU=
X-Received: by 2002:a92:aa48:: with SMTP id j69mr30172088ili.162.1574626559468;
 Sun, 24 Nov 2019 12:15:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.473.git.1574600963.gitgitgadget@gmail.com>
 <177deddcf83c2550c0db536a7a6942ba69a92fa5.1574600963.git.gitgitgadget@gmail.com>
 <20191124170643.GA16907@sigill.intra.peff.net> <CAPUEspjAjR+QojRbC8dkoj=9adAKEv4StYYiy6hFmbMwQZ7CNw@mail.gmail.com>
In-Reply-To: <CAPUEspjAjR+QojRbC8dkoj=9adAKEv4StYYiy6hFmbMwQZ7CNw@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 24 Nov 2019 12:15:47 -0800
Message-ID: <CAPUEspjTpWsaT=pm1HLwTUQQye+WMCeWwpmC9RWkBuKQELubRw@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-compat-util.h: drop the `PRIuMAX` definition
To:     Jeff King <peff@peff.net>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 24, 2019 at 9:40 AM Carlo Arenas <carenas@gmail.com> wrote:
>
> I think the problem might come from places where the default compiler
> is still not C99 by default (ex: old CentOS)

CentOS 6.10 (using gcc 4.4.7) compiles this without problems by
default so nothing to worry about, sorry for the red herring

Carlo

PS. non GNU89 (AKA ANSI) mode will obviously break but not ONLY
because of this change
