Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CDDC4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 20:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE66206D7
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 20:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9rYaN9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgCSUSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 16:18:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40207 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgCSUSX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 16:18:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id 19so4006769ljj.7
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 13:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BuJvD9yVOTyqgJe65z5rhJv/WxHwgMBOZ3ospB2BDwY=;
        b=E9rYaN9X4fwsrVEqfT8PXYLTOUc41Sog7NFWgwMGvrI8czmpTxJMvdEC1goMdkQaWE
         EF4IqOE9XXCzBHHDrw2Par/NVtPbVqrB2+hkK6XO1SwqxFEO1nGPU6CfzWeSimZKvEwk
         bMl5HxM7pGrpCTLMvRUM1bWbEwu0i/cHL7qGkfg20iX6QDN1/dljkEG48K0TlnZw45fc
         tobqHe3QdYXVuzPGvPHiW2d1TrjWAa9ux/XYLCoT9vv3NWNu4MHVu2vHPkuZMHcoVT82
         pN3wtwcSvppjaa/nt1NSKu5tXSrqxexrFsg4+vPZrIkKWUUSD7i6pRpVqYIVZt5zb5L3
         kzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BuJvD9yVOTyqgJe65z5rhJv/WxHwgMBOZ3ospB2BDwY=;
        b=gMNtWg6g+XmLOS06l5QgoD1R3DJSWWLz1X+ywSXW4BegeuCtYt6xmlG2fPfvrFTWgb
         0OXViDshcJ+BvUxBb6cTDidAnf/EPxBeZRlU7WiML+u11vhSg1hl7bD9YEQgwHXdCV1x
         eig0P9Z6y5qFTU03rga7m6wtyaQoZS6Y5VBKnC8y8vtPrKAAG4chDh7YU5BeNqXQGJww
         kmbU2QS4p3Il2jzV343HSYD8t+uJ7b4fFMfiMlSH09dq1E34LeSY44ppmoI11K76YXo/
         b1wGo2zaZXwnqFyFN0AW5bHQnPUGHE8EZPKNHmKtV94bq12oKm2bRWKcyivJkwA4uorV
         xJrw==
X-Gm-Message-State: ANhLgQ0tvFDpBemZmVPh0DVCci3ZSgfjiI05/RcUb4nRKRG0/vd+hkwh
        IvvNonKXK8hr1W8mV5XY9hVYN20frINYSQVt924=
X-Google-Smtp-Source: ADFU+vv+jXyOuEUyebT0hbkH3EFB9Esbanf4CqW2D/rRqZfbJjTui3Ah6l5+BYaaow11PeF4H9vUcOAhwVoCRU9dFkc=
X-Received: by 2002:a05:651c:1b5:: with SMTP id c21mr3244249ljn.174.1584649101306;
 Thu, 19 Mar 2020 13:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200319132957.17813-3-harshitjain1371999@gmail.com>
 <20200319164234.4441-1-shouryashukla.oo@gmail.com> <555da203-0740-3d79-15cf-83c5a8d5dbae@gmail.com>
In-Reply-To: <555da203-0740-3d79-15cf-83c5a8d5dbae@gmail.com>
From:   Harshit Jain <harshitjain1371999@gmail.com>
Date:   Fri, 20 Mar 2020 01:48:09 +0530
Message-ID: <CACuU+s-0VQgDOhdoc66FRFunHLdKGUu55NAwL95LcHNEK8J6Vw@mail.gmail.com>
Subject: Re: [GSoC][PATCH 2/2] t4131: use helper function to replace test -f <path>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 19, 2020 at 11:04 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> On 19-03-2020 22:12, Shourya Shukla wrote:
> > Hello Harshit,
> >
> >> Replace 'test -f' with the helper function 'test_path_is_file' as the helper function improves the code readability and also gives better error messages.
> >
> > Again the same thing, you may follow what I stated before regarding commit messages.
> >
> > The commit title can be of the form:
> >
> > t4131: use helpers to replace test -f <path>
> >
> > <<commit description>>
> >
>
> Just curious, isn't the commit title already like that in this patch?
> The subject does read:
>
>    [GSoC][PATCH 2/2] t4131: use helper function to replace test -f <path>"
>
> What am I missing?
>

Hey Shourya,
Can you please clarify, I am also a bit confused.

Regards,
Harshit Jain
