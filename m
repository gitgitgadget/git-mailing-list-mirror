Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15D3C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 21:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 666F661289
	for <git@archiver.kernel.org>; Thu,  6 May 2021 21:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhEFV4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 17:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhEFV4I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 17:56:08 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57FBC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 14:55:09 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id k25so6899329oic.4
        for <git@vger.kernel.org>; Thu, 06 May 2021 14:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ARdjrxCddDx+D3hoPJfgsvULIuv0gr5h+nV4PU83zS0=;
        b=GEgGLxCd6oZD5J8prUkyUY4ZdxEiVOnqkNwkd5siYRWjrTw50yee15WXnT0rBJd7s/
         +AQGbbCwVNlFOsqPLedD5TUYjsI7fZHiijgfie0d+bU3ROmyXExHdyNOmEIcTP5+tE5d
         j3Lsk05joSXLIY98fX7qr6LQnHXIsXTLIR6rDKfTYbxHJmBRiT1Fr/Gqw/B6ifWzSSHA
         c5H5deCGIAGqATK35Rg+88EMH1aelU9IQ2eF294zboyVMNmZgmVM8GKQ2707ffwFy1A9
         Tt/DTyep/93kxYBLHmBP3YRMOhu4UAN6C0aGvVLZJAATz7jz27DxupOrTlrNOdamnaZD
         A5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ARdjrxCddDx+D3hoPJfgsvULIuv0gr5h+nV4PU83zS0=;
        b=SoEbcmM8PLgAv9kYitm90M0o6rrsezwi0QG5BITHuSbhwZ7bmsYoyQu3BTU6KxjJ33
         UFoLUACcrcnQo9AtXFL05XdHPTGtlHe4zDiNnQzQ7VjQE6ouqc57dZcCKHV4Yr52IVIo
         B0AqPYo0A6I42jTWNlmajMe98Dx+0JcioOcNFQjKxldQndXuKGqxCS4cOFpMCLLTIaQk
         6gAB/rHZNUP8uV87niUVa/GpdCQwJbOuvhPdrgQAu9AghxFkxR0sO0sIBbZU3rcWkoPN
         M04W6dhBXcujSlDYRviEJHHCXHSZO7fvRgA+zwbhvEtzQd6sXceI6tGdTZDm8stxsIZh
         iZYA==
X-Gm-Message-State: AOAM533fl0/4M31PCunOA/BmCkxd6WMm/Yrg1KiVh6Kssg5pGBKcUaeT
        NPHtpgP146tNgQZqXzaxMebE0p4Ra/n28A==
X-Google-Smtp-Source: ABdhPJx5SeK9d0l93uyJ+KcD92SMZ4JvzA4HXlwPYy2RI7n/dxSqnYm1P8PQbenVm+NVewui4BMwOw==
X-Received: by 2002:aca:4487:: with SMTP id r129mr12731672oia.106.1620338109214;
        Thu, 06 May 2021 14:55:09 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id j8sm861052otj.49.2021.05.06.14.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 14:55:06 -0700 (PDT)
Date:   Thu, 06 May 2021 16:55:01 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?R8OhYm9yIEZhcmthcw==?= <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <609465b55e183_577f20852@natae.notmuch>
In-Reply-To: <87h7jfvq09.fsf@evledraar.gmail.com>
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
 <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
 <877dkdwgfe.fsf@evledraar.gmail.com>
 <xmqq35v01ua3.fsf@gitster.g>
 <6093cc63a4e81_325720840@natae.notmuch>
 <87h7jfvq09.fsf@evledraar.gmail.com>
Subject: Re: git switch/restore, still experimental?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, May 06 2021, Felipe Contreras wrote:

> > If you use natural language:
> >
> >   1. Git, switch to a new branch
> >
> >   2. Git, switch, create, branch
> >
> > One of these simply flows, the other is complete gibberish. I think
> > anyone familiar with English can identify which is which.
> =

> Well, there's "Git, create a new branch and switch to it"

Which command is that?

  git create branch --checkout?

I'm following the order of the words from left to right.

> Also, there's the verb "make" in common use in git's command set
> e.g. git-mktag, git-mktree, as well as mkdir(1), mkfifo(1) etc.

Sure, although I wouldn't consider them main commands. I for one never
use them.

> In any case, unless we're talking about rewamping git's entire command
> set (e.g. having a git-newtree or whatever) I'd like to think that it's=

> more productive to focus on making the commands/switches we have
> internally consistent when possible, which is what I'm advocating in th=
e
> E-Mail that started this sub-thread.

But we are talking about a new command, it is precisely at this point we
need to think about what could have been if mistakes of the past had not
happened.

We should not repeat past mistakes without a very good reason.

I don't think we should seek consistency for consistency's sake. Sure,
consistency is good, but it's only one of many considerations.

In this case however we have a rare occasion in which both consistency an=
d
natural language meet, we should not squander it.

In fact, to be even more consistent we could add a -n option to git
branch, which would be reduntant but more explicit, like --list.

Cheers.

-- =

Felipe Contreras=
