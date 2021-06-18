Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED84C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 23:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF73F61264
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 23:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhFRXuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 19:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbhFRXud (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 19:50:33 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A79C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 16:48:23 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id n20-20020a4abd140000b029024b43f59314so1063071oop.9
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 16:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=NP9HeiXtdcGalAtifGvzvRWlTv5MOSdqwdkltKcpipc=;
        b=bhLWOYMycE8o+2vZZR89zIuMrHAl9Kg2vwe/P9AypMKFsnWM1DwKAwduixIn1s71O4
         fFFmvQudR4ToMaZMIKKkMcosDov19g/A/tsLs6C/0uqBA0gTSPH2q2If2xxEd5/oYV/V
         cpz+WZSxaopxupBKFgzqFZeiCB2q9t3XW2agAJJXxfDBUehqf4f1Evyk5nG//VMQFf/c
         TWBF4oBSrHadgIA0hbW5O3GQYvikp42z2myyWi3AUKQ3LCN2mRsXMX9pRHzWuSlWw1G3
         WI6nyzuFGlxUBP0kC+X2y4Jv1a5msoNBls2Qd6cXGQFB+3+dL0ApUW0ISHWX/04c2/+O
         jisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=NP9HeiXtdcGalAtifGvzvRWlTv5MOSdqwdkltKcpipc=;
        b=Mhqf0mXmjw2B5iB6aqL24n6Es5TEdLD7Jn7VJ7/ogFGiyOA23OA9F8W78q5rs+2HOC
         BSxrqFekSt/YYgPsFRXKBKzbyNT5lw6H/WTRUbKs6j9GKf628oagVS1GsDSyh6fWChof
         mHTujODqFo62mITfkiQyRXBntWewjl66Htvtuh2FhbPmekreMEywv9Cn95ht6tDpLAa5
         mPzg/q474abBXvchASYtgVWnkP16g3DJQqLn0hMjXrKUD5T5pncl5d7h7PyJji9XG6LE
         2f6l3AuPDx+O1VEDcp1+ojS+onjIs1R0eAz/V62/7SolbDBLeT6bjqerJsQ7EzGz6jzn
         Wwgg==
X-Gm-Message-State: AOAM532QEodB09Kl2kpny+ZhWwVd+hRq8uZhE/vMjBBNb4gCJOIMWW9+
        8G9MHFVM0nDkzRqcDbhkPtk=
X-Google-Smtp-Source: ABdhPJyOunj7ypJqdl1VL3DuEMx4vmnpTlVvfKpc2cEZdwALMtzJThPSepfmveo3Mqm5I/YSJfocSg==
X-Received: by 2002:a4a:3904:: with SMTP id m4mr11182043ooa.61.1624060102360;
        Fri, 18 Jun 2021 16:48:22 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id b198sm2129044oii.19.2021.06.18.16.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 16:48:21 -0700 (PDT)
Date:   Fri, 18 Jun 2021 18:48:20 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Dave Huseby <dwh@linuxprogrammer.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
        stefanmoch@mail.de, philipoak@iee.email, bagasdotme@gmail.com,
        sunshine@sunshineco.com, avarab@gmail.com
Message-ID: <60cd30c487a12_ca73a2084f@natae.notmuch>
In-Reply-To: <20210618204348.GA3763@localhost>
References: <20210512031821.6498-2-dwh@linuxprogrammer.org>
 <20210512233412.10737-1-dwh@linuxprogrammer.org>
 <60c0fc311144f_1096b2081f@natae.notmuch>
 <20210618204348.GA3763@localhost>
Subject: Re: [PATCH v3] doc: writing down Git mailing list etiquette
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dave Huseby wrote:
> On 09.06.2021 12:36, Felipe Contreras wrote:
> >What happened to this? I see value in having this document, so I would=

> >be glad to pick it up if you've lost interest.
> =

> I fell off of the face of the earth. My life turned upside down but it'=
s
> slowly righting itself. A number of things took me offline but the last=

> of which is my father nearing the end of his life. Things are stable fo=
r
> the moment so I am getting back in the saddle. Like I said in my last
> update, I'm going to try to combine all of the contributions and
> feedback into a patchset that includes =C3=86var's patches and cleaned =
up
> versions of mine on top.
> =

> Right now I'm trying to get my head back where it was.

Sorry to hear that. Hopefully soon you'll find some familiar ground.

Cheers.

-- =

Felipe Contreras=
