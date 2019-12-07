Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F146BC43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 20:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD38724670
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 20:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="vqTlTfCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLGUAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 15:00:03 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32954 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfLGUAD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 15:00:03 -0500
Received: by mail-lj1-f194.google.com with SMTP id 21so11321153ljr.0
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 12:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Wnp+rgTtrXQ4DM0j9i/Cl/IKAb3eoqtXcVeg0qdmvY=;
        b=vqTlTfCZRSGZRoMWbgwibEXKgIOb/4r3UQJli7j7EtVczXwJ1HA2FiDKbsG1bKIJtW
         YNd2pmW1xpUxfzhtKaV8Y8woKGFpKu080RVhSIc8HPRmQxQ/OfwKhoOzFJXVdzGez5Q7
         XuREUjMheWX0Bu2pDbJuD2WiQB1L8hOWfZIX2K3e+x0KxFDf2VwGhG+QzMSsrB9V+Ukd
         NCS3mfZ/7YL9eqxatBQI9DmtKsHsleXNujCWYq+71JooB6mAZo4xeh3TkVWcOyEvi1VZ
         UE6fxhCOiTuCDHX+Ovwfmd6HSovix8u2aD4tMu7XqxQg0z25ISa4za/h5rfFaYRxkvFL
         YuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Wnp+rgTtrXQ4DM0j9i/Cl/IKAb3eoqtXcVeg0qdmvY=;
        b=bemopwFzs2CDdYOsB1h4P6ChTkJUj2eSeV/qahJ3YSuxtpr0gS7kdy8VreVeSb61n7
         JL/c/ibxWSWjWfFEbiKOP3MEn1jEkpTG0uREvBZO8UOYYoYYj3l+sCWlkKgB0aLd7Zml
         DKfBd7MpiH0L4lf8Ez+NnNFgufAVql0N6ZBvrZu764uZzNoL4tp/oHKkF1LDylqd026o
         b8XHF7fGXJbe2QxVlwkuo1qcp3252Bc3B1fBO9uPCTRssuCqtI+pj/qKRKrwqruVP7O6
         3cZAaHYJg8YjZIasLvWPUBLjI6EBECir8vRci3LNgFIirQfjaw6xc+rWOzLqT5zf7+u8
         JEvQ==
X-Gm-Message-State: APjAAAXDHo72XjW9UZMxxBCYQFird7+aJjz8fyp6J/KJabhKxjTlt0Yq
        wSUz78M4e67jSw7WUC/VIla2L10BhDAzhdm04/D8s8wKu62rAA==
X-Google-Smtp-Source: APXvYqzm2LcGk17+lTRxEtMmUuGEyRwYHcSAMEb01hETyrS6ZfxUl/JrGil4cWgFkEVd7dMQIucNKaeSop9bUO6eSIU=
X-Received: by 2002:a2e:b0db:: with SMTP id g27mr12528666ljl.74.1575748800903;
 Sat, 07 Dec 2019 12:00:00 -0800 (PST)
MIME-Version: 1.0
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
 <20191207010938.GA75094@generichostname> <CABvFv3+viMXJO0z5HAQbCya7MU9tWd7P_LxUhu66T74XGN99yA@mail.gmail.com>
 <b21d153a-02f9-b9a1-7388-59b5a882d4f2@gmail.com>
In-Reply-To: <b21d153a-02f9-b9a1-7388-59b5a882d4f2@gmail.com>
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
Date:   Sat, 7 Dec 2019 11:59:47 -0800
Message-ID: <CABvFv3Jf9i06OmBqOC2zfS+7Sm88PRYa19_rB8rELtMoN2E8CQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] git-p4: python3 compatibility
To:     Ben Keene <seraphire@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 7, 2019 at 8:21 AM Ben Keene <seraphire@gmail.com> wrote:
> On 12/7/2019 2:29 AM, Yang Zhao wrote:
> > Ideally, I would prefer we land something minimal and working in mainline soon,
> > then further collaborate on changes that clean up code and enable more features.
> >
> > My end-game is to have P4 Streams working in git-p4, and maybe LFS-like support
> > that uses p4 as the backend. It would be great to not be the only one
> > spending effort
> > in that direction.
>
> I have similar goals.  I would love to get the smallest set of non-breaking
> changes in that allows the program to basically work with Python 3.5+.
>
> My rush has been because I need to use git-p4 for work and have been
> working
> on the project at the office.  Once I reach a point where I am able to
> generally work (when t9800 is complete) I'll really not be free to spend
> too
> much work time on the project, but I am eager to see this through!

I'm in a similar situation, but we use p4 Streams and so I actually need further
development before being able to make a full switch. I am given more liberty
in terms of how much work time I can dedicate to this, though.

Given the situation, can you give my patch set a try in your work environment?
It is currently passing everything except t9824-git-p4-git-lfs.

If you're OK with it, I would prefer that we work from my version as a base and
add some of your quality-of-life enhancements on top. I can do the merges myself
if you are pressed for time.

Thanks,
Yang
