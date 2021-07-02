Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FBDC07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63AC2610CA
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhGBWRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 18:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhGBWRP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 18:17:15 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977A7C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 15:14:41 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id a133so12984751oib.13
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 15:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=v8M6iibCAdZU2dr5OFg9l/+8qpq07oWxgrE5Xhh19O4=;
        b=sGw9f9707btH98eiUjoGf4YXgKgBAzB6+FSI8ttgZYxFhTjN2rr11XqfCLXlckVyfP
         I+h5KV1aXspdWuf7OW00K88b7FJQDY8nMKn5Dd3phcUMv+tG5crj/DQa0i4zp6g1t35i
         rFII0d+9zisVaDAkmADFQKZOoWhZ9O7QPhrmzUihrepLYlF5wL3nF0l4uq6Esinhoul9
         TSMcm3pjr70lFyRcgjEUVy2SjUh5zYRBIqLztzEH+BYOUAZ2Wi/pfQD2F8Hi9vikZVBz
         OmOI6+41KDx49ceHbyhCklQhr1vw/Zhj2oz9UMZrkmNBxXm+ECZ+p4gqA9dA3NRObapx
         +NeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=v8M6iibCAdZU2dr5OFg9l/+8qpq07oWxgrE5Xhh19O4=;
        b=ZWqaujM+ZXwGmCHTl3LKccU03PTJDXWUKvjPk2nyHJSPMrYITwmclcQrHxFQ+b8BqL
         GZnUY0NNURBNHqsqTWaDQidminwqyJqn1puxoIvuiSoSDrJL7fieQZ3cQifMhBz8AW7L
         q+sr+zAFjgjKaKAPakHiihMHvk5O6vsXSe10+4AMSgb6HXwT8z0r7SEqJEz7XM5R2+Wb
         bFjltRjcHnzcr0MwADbKjh5QGUT4EM8NeR7f3yR1Wt192e9k2pQQvi5mXaabvj6yla2g
         O0QcNjgPSI/4DE9Rl6zllefQpL76/gmQMMqZsIUab9MfiEXsUK+0bBHXgGuKjny3vOq8
         mEPg==
X-Gm-Message-State: AOAM531lErEA2MBhN07YlGso28l3SaOjuhmnnye/K0Bv4lbR1geXQrk6
        xL2lbIMD6d6lqpx5eVYAruc=
X-Google-Smtp-Source: ABdhPJwlN2mMgkK2SMYLqlANr9PloSv0NcMpHHAdu1+/l2DJBksYkcy7poegt0qgUathOqNRL+QZ6A==
X-Received: by 2002:a05:6808:aa6:: with SMTP id r6mr1374370oij.35.1625264081001;
        Fri, 02 Jul 2021 15:14:41 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id y6sm998584oiy.18.2021.07.02.15.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 15:14:40 -0700 (PDT)
Date:   Fri, 02 Jul 2021 17:14:39 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     martin <test2@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60df8fcf71d11_28bb20873@natae.notmuch>
In-Reply-To: <cb40e459-7862-b917-b4bb-7bd6f929adef@mfriebe.de>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <871r8hauvi.fsf@igel.home>
 <60dee7d4e27bf_2964b20817@natae.notmuch>
 <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de>
 <60def07e686c7_7442083a@natae.notmuch>
 <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de>
 <60df813938303_28bb208c8@natae.notmuch>
 <cb40e459-7862-b917-b4bb-7bd6f929adef@mfriebe.de>
Subject: Re: [PATCH 5/5] config: add default aliases
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

martin wrote:
> On 02/07/2021 23:12, Felipe Contreras wrote:
> > I know, but it comes from CVS.
> >
> > In both CVS and Subversion "commit" pushes a commit, so it can be see=
n
> > as the opposite of "checkout", which pulls a commit.
> >
> > That's not the case in git.
> >
> >> But of course other letters can be picked. I don't see an advantage =
in
> >> it though.
> > The advantage is that it's straightforward: co -> commit.
> =

> But it is not that different between git and svn/cvs
> =

> svn/cvs both store/restore from the repository. That happens to be on =

> the server.
> git=C2=A0 store/restore from the repository. That happens to be local. =
(the =

> remote is optional in git)

Fair point.

However, I don't think git actually checks out anything. If you see the
English definition [1] the CVS checkout can be thought of as checking
out a book from the library; the item you check out is not part of the
repository afterwards. Git doesn't do that.

Either way we could leave the 'co' alias pending to see what happens
with switch/restore, but my guess is that as time goes by 'checkout'
will be used less and less.

> That, said, it is ok to break with the old patterns. Otherwise =

> innovation can't happen.
> But, plenty of users have old habits, and those die hard.
> If the new aliases should help people, then those used to other meaning=
s =

> of the same alias may not think of it as that much help.

Right, but not all users have old habits. Some were born after
Subversion was created. An important decision such as default aliases
should look into the future, not the past.

> Also, git has plenty more commands than other vcs. Even if not all of =

> them will be aliased, people will expect different sub sets of them in =

> the list of those with alias.
> Maybe 3 letter aliases will be less controversial

I don't think so. In my opinion the list of default aliases should be
small, and for that two characters is fine.

Cheers.

[1] https://www.merriam-webster.com/dictionary/checkout

-- =

Felipe Contreras=
