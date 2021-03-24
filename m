Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D54C433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 05:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045BB619BB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 05:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhCXFZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 01:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbhCXFZV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 01:25:21 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6F2C061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 22:25:21 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w70so19613977oie.0
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 22:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XfTbPWlVwOt+io8HlTyXd80iekaRiqsXags8EQnUPjs=;
        b=YBJ+3sZIicUPDtKsp67GkrFTf6PB2/wyRpujXZhSzE8v5Ronuh/crpxIaq1MOXQ6au
         qySc0en0uVihN6QvV0Vfj/y5FGizobJn8dbl3iTruy5JesLFA0HfapMEZoLMOIjLVwLV
         JjR8v6VJs5ZaLuNmZlO8TTViwK5d77AVGQlhUdnbiXOMUEAbaBBHdi6E3U2dxQ/MUWej
         t2nH5kYSXkVqt8NU8wH25fwHthiXIgIdO0+8airrg/5hp9i7ZFL6TVRSfCWZHNN3pPYq
         tVmyktJPOZMNLFS7ZPBX3yCwQO/XQ7F21EesfOUfkseVg1ATJc76HTiZJ1FxlktYojtU
         mJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XfTbPWlVwOt+io8HlTyXd80iekaRiqsXags8EQnUPjs=;
        b=Wm7hauHcjOT6NH+EnCRxemdoewOwj+QvFvkJ+n8wZCEbJX7rEpT3Pj3ps5RGYLdn+1
         JYXKdf/3KATW4R5FkhDE/BzqRvT0uR+SvClfhrVXC3UTVbUrsWaBO7AjDOpCLMb+THIF
         3Qlaz2MiFXq7St3cLOOHvi2aEHd6Avu3EtKlhWsr4m6rEH6K8Y6A0a+wLF3cqrItvzlA
         0k5dD36zP8XKEGvjSIwnqJ4eyZ9nsG5xdYxnMhLC7+XjKwmD5b0avk/G1oCaoVxH1vlx
         lNjoY1UKGvApDwDcU0IuYxTpTDYSsvfievdJznuoFY+QKLWhJEoV/7lRp/qGSPTymgmt
         RDNA==
X-Gm-Message-State: AOAM533q9N6sXkWbYHQEmFl5QxtyQljMZdwHMfPmEVO5m5COro56Qtch
        BwF8sEOeLQ7tM6uuucyR8Zoc+ezDxPdotAMnx88ZKC9fObMjSm0q
X-Google-Smtp-Source: ABdhPJw3LzWCFlGbOVJJAAtWMWzA0xCH8z0EZ/eHtzQED1LlMtjImDJBiBqiGB0Ccap7b70tCFIylOQ8puhmQDwFkmw=
X-Received: by 2002:aca:af10:: with SMTP id y16mr1110127oie.120.1616563521083;
 Tue, 23 Mar 2021 22:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v12.git.1616247681211.gitgitgadget@gmail.com>
 <pull.901.v13.git.1616387093662.gitgitgadget@gmail.com> <CAP8UFD0rtX0m+fGcvGFtsFFKZ2LVyxHx8dptYFvM9kWnbxEwFA@mail.gmail.com>
 <CAOLTT8Ty5kabU6ivX946=FDWJ4SEXBzPinq2aG5t7Rp9jCCEPA@mail.gmail.com>
 <CAP8UFD3fYTc8=y+kru-mN5KmTsnqc6X8mf14VtyWf1Nj9CJ1EQ@mail.gmail.com>
 <xmqqv99i4ck2.fsf@gitster.g> <CAOLTT8TKqDWnu3k1Xz=qBhmdZYFhM452WzVGG=OArgJL3z0yGQ@mail.gmail.com>
 <xmqqa6qt4wvw.fsf@gitster.g>
In-Reply-To: <xmqqa6qt4wvw.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 24 Mar 2021 13:25:08 +0800
Message-ID: <CAOLTT8Sff+Kn91QjvPZdX1JxEQp8eDBrWfqprtd=6mKQjCWGew@mail.gmail.com>
Subject: Re: [PATCH v13] [GSOC] commit: add --trailer option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Maybe like this?
>
> Code is not an important part.  We should think through
> ramifications of making (and not making) such a change first.

Sorry for without careful consideration.
Thank for this valuable suggestion.
