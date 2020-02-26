Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC657C4BA21
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B2E2072D
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8JgCFVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgBZU2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:28:33 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46556 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgBZU2d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 15:28:33 -0500
Received: by mail-ed1-f67.google.com with SMTP id p14so337774edy.13
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 12:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZW//2y1a7w4CKCDNqlvjhPeyNaf95Ae53uD9f8sF81A=;
        b=R8JgCFVGjhJWBL5/rSgG/3dQD5JznFuZr4PLv2fxYeP4I202taDobCfWZKSGIiJFfX
         nrC/+f3cTMzrzbIEzowfEkSdqUjeakGtm7Lsk093sv/PSW12rGm2i1ki/OB0EVEJRnYS
         2XIj1p+eNL2rcAeOwV31k4T/x+XEcLwzhIOeL4jx9ApP8BDT9TpjJyWq9epv7pat3JLU
         RI9EdganFsET8lUodSdm1qb/zHjRI5pYdmF1HKqbKfcEb949AQ6vvLgOCPxvB6H8PQg5
         TKB62rEWNtsV/P5GM6HtGNXRzWp8NXb2VtiWjAFLG4ejD92r1yQLih976wSBmtsvbZIg
         z2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZW//2y1a7w4CKCDNqlvjhPeyNaf95Ae53uD9f8sF81A=;
        b=L/dUoTpFL3iCIPUb3jNKHRXVcyJ3nJKDkGpMgD9q49X6bKkVdGoCtynYr+s5B11rWe
         e1mCkHmYqa3gE1afDc6BXBF9UGMKhILOb5cRXX1bPLtnk1T0WVGRSuoVARusJfoi9wbt
         2EPM3gMq5HfvI5c076au5egEd4ewVf3gftVKVrBHtalCPs5UZ99DWUQ5JW0U7tF7Q2eY
         Nsdqt+scz9fOkpiJ1mbCYUKZvjgLf14EC0MS4cqljVn8+cREdmH06g2PWLax9o954mfz
         d6C7+m3yrJO6mW+FISinOSePQm40YmnRGwPz/1pIYOXTQcEee6P2Yuo2bzXXzs6q2d6o
         q/7A==
X-Gm-Message-State: APjAAAUiQMwXr3NNSsckSLaNSm8LVCBCfz0HTXHTFDLz8J4SRZdi4bBG
        IaAYVFjTcpIuzQaUrmfjzUJ1dFYGuTJpeTMYS84=
X-Google-Smtp-Source: APXvYqyzMHcI0o/V3AtvSXAnsKgVHUNWWtnNS3iqkeIYo9q+WD2DiqHqwwhDsfFSSMdiOmPJfXL37DAICjQM82dtLfI=
X-Received: by 2002:a17:906:1956:: with SMTP id b22mr502213eje.276.1582748911808;
 Wed, 26 Feb 2020 12:28:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
 <pull.548.v5.git.1582628141.gitgitgadget@gmail.com> <b7f10d060a41c1ef3d25e4c07be3747c7902b997.1582628141.git.gitgitgadget@gmail.com>
 <xmqqsgiymupf.fsf@gitster-ct.c.googlers.com> <CACg5j27SfWsj2t_z8zxOvjc6MSot2yMi1J+R4HJinFhHgTpveg@mail.gmail.com>
 <xmqqy2sql405.fsf@gitster-ct.c.googlers.com> <CACg5j25EdX2fPHpAq3TEhaJPiQg4dA52soOyCMm17wg_O-c4Ng@mail.gmail.com>
 <xmqq8skqkq35.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8skqkq35.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Thu, 27 Feb 2020 09:28:20 +1300
Message-ID: <CACg5j24F=rU1EKPpq-TnMOUNLZqT3HTJZXuCXORVtPPa=hK-Cg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] advice: revamp advise API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 26, 2020 at 4:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Heba Waly <heba.waly@gmail.com> writes:
>
> > I'm not against this approach as well, but as I mentioned above, we
> > need a list of keys to be returned by list_config_advices(), that's
> > why defining the constant strings will not be sufficient in our case.
>
> Sorry, but I do not get it.
>
> Either you use enum or a bunch of variables of type const char [],
> "list all of them" would need an array whose elements are all of
> them, so
>
>         const char ADVICE_FOO[] = "advice.foo";
>         const char ADVICE_BAR[] = "advice.bar";
>         ...
>
>         static const char *all_advice_type[] = {
>                 ADVICE_FOO, ADVICE_BAR, ...
>         };
>
>         void for_each_advice_type(int (*fn)(const char *name))
>         {
>                 int i;
>                 for (i = 0; i < ARRAY_SIZE(all_advice_type); i++)
>                         fn(all_advice_type[i]);
>         }
>
> would be sufficient, and I do not think it takes any more effort to
> create and manage than using an array indexed with the enum, no?
>

hmm, you're right, I just personally prefer having related variables
collected in one data structure (whenever possible) like a list (or
enum in this case) rather than defining each independently as a const
variable. On the other hand, I understand that you'd prefer to skip
the extra step of converting the enum to string.
hmmm ok, I'll change the enum and send a new version soon.

Thanks,
Heba
