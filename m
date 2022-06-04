Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E34C43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 15:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbiFDPYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 11:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiFDPYY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 11:24:24 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587244ECF0
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 08:24:23 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ff90e0937aso108081487b3.4
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQFrVpMkBFWAm7DsLlfNLtDKqFxlX+29DvFl8ZLQmSw=;
        b=QloDTCwp1fuKDBRhtUYItrQOTmY5SyDVZx1S1rvz+LmoLX5GCsMxVPEJQCarNrtevS
         BR3UC2un6OijNYQ1UM30CgYs+EvCx7Kyj9poPMOR7+98o3ZkDx+/5VX+zSH1Ph5pQ2rF
         pXOFAvJ57LR2CPzwcq/vJ07yTzHa1L6QFt2pOiQjmup2x9Kug3txe4DV4Gf52C+lOgIL
         tG6EErZ7bnt4foMo7DVVAaFT9dpO3QLkUlIOxYAsWmb8PCDIiQJA/o5Zc8d4CJc8N6gL
         +FDKwCmgXpLBZdpwz3JhNpcoevp3Bf8dg/Ott4/R/JpYKmes7wE08FMvA5eeqzy9zuok
         cZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQFrVpMkBFWAm7DsLlfNLtDKqFxlX+29DvFl8ZLQmSw=;
        b=VN03K0zD0/jbUUlPUwIsIi++O5vZC66By5rkldobxKsyv7Wljvcvz+3QDWLXAO0eZZ
         81auIorgtyayNu6yWVLFd+DngbA2OEGdhLL5D1QWTkoQnD0CGXpzryy3DUVbXHVr+/EJ
         Ntw0aOY0FmjAz5t1q488pL93xo6ZkqiR9ryqEPr2b2s/j1x5eSKvYKvVTAneX7sNQwnw
         3dPkhSINQf+8gtWk0PSwJqvQyJvU6P3sKcbZxGWCSWEfd/2Ugh21WUF940hIZKohAw4V
         0sZSioB3ijLwTMI7O6EmObIv01nC7/QC0IEkhjO6ZKQBAbN0FgF7NSmkqN+E4Jd7+vLW
         e28g==
X-Gm-Message-State: AOAM531vVZXhlGVLJw/PJZI+xeCDAyTQNwBH5QIcFZQDuX76kRYPQqc7
        sO+icsCriPTQu8ZgKRq0hzgOWGbXT7WZn6KH/4k=
X-Google-Smtp-Source: ABdhPJwoAJnrDMOj5KlAKP6tbi8iZQe2uDzXzUF8PIoUzbLF6XL6Dv91fx8PCvjha0TrG/sNqCHA7u2urifV47MACDA=
X-Received: by 2002:a05:690c:298:b0:2eb:564a:34b with SMTP id
 bf24-20020a05690c029800b002eb564a034bmr17173217ywb.258.1654356262526; Sat, 04
 Jun 2022 08:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <CACMKQb0Mz4zBoSX2CdXkeF51z_mh3had7359J=LmXGzJM1WYLg@mail.gmail.com>
 <Yo68+kjAeP6tnduW@invalid> <8adba93c-7671-30d8-5a4c-4ad6e1084a22@iee.email>
 <CACMKQb3exv13sYN5uEP_AG-JYu1rmVj4HDxjdw8_Y-+maJPwGg@mail.gmail.com>
 <0201db28-d788-4458-e31d-c6cdedf5c9cf@iee.email> <AS8PR02MB730274D473C2BC3846D9FA3F9CDD9@AS8PR02MB7302.eurprd02.prod.outlook.com>
 <20220530115339.3torgv5c2zw75okg@carbon> <220530.8635gr2jsh.gmgdl@evledraar.gmail.com>
 <CACMKQb3_j+iFcf5trZEcWoU7vAsscKv+_sLaEqg_qfazBPTo+Q@mail.gmail.com> <20220603152301.olqbjtt5j2kqyc3e@carbon>
In-Reply-To: <20220603152301.olqbjtt5j2kqyc3e@carbon>
From:   Aman <amanmatreja@gmail.com>
Date:   Sat, 4 Jun 2022 20:54:10 +0530
Message-ID: <CACMKQb3gYwdyfRSLWO4FWb6+Kxrk-WURpLayrgFsszCKMhWONw@mail.gmail.com>
Subject: Re: About GIT Internals
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     Git List <git@vger.kernel.org>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Philip Oakley <philipoakley@iee.email>,
        "git-vger@eldondev.com" <git-vger@eldondev.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 3, 2022, at 8:53 PM Konstantin Khomoutov <kostix@bswap.ru> wrote:

> Well, depends on what you mean when talking about the two mentioned designs.
> I mean, there's the design of the approach to manage data and there's the
> design of the software package (which Git is).

That's a good perspective on the distinction between the designs. I am
not familiar yet, with the design of GIT as a software package, and I
am guessing most people who'll be learning about GIT internals won't
be.

> If you do also understand the latter - that is, understanding that Git is an
> assortment of CLI tools combined into two layers called "plumbing" and
> "porcelain", - then you should have no difficulty starting to read the code:
> basically locate the source code of the entry point Git binary (which is,
> well, "git", or "git.exe" on Windows) and start reading it.

How do I do that?  What do you mean by the "entry point" of the git binary?
