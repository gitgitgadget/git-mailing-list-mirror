Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB7BC433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 17:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD9A61221
	for <git@archiver.kernel.org>; Sat,  8 May 2021 17:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhEHRVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 13:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhEHRVx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 13:21:53 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD35DC061574
        for <git@vger.kernel.org>; Sat,  8 May 2021 10:20:51 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id t4-20020a05683014c4b02902ed26dd7a60so556262otq.7
        for <git@vger.kernel.org>; Sat, 08 May 2021 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IkN08JMONV1p5I7PMr0mqbts4Ubmj+QpJ15F5HnnM3I=;
        b=TNbq+qwuMqKYxhgbzlKBqYYYEvGQcOF+io05ftPPUmMppDcex6MK9GfYdoVCRPJRYW
         EiBcUUVPmCLmtjIgj0xP7Xf7Q85PEj7w+2OMEpVFiPSnmZaCxOdjRGq8vqhhGq1EtL6e
         qZRd+R9nq44NiuAeiAOqbE7J/IozOS4r8Bc/ywihY57Sc+pLkxhbtbb6lK63KHX4OxYe
         uJkAqvupPg+e6glKrI26UFXgejNJFoBNMv7n+djxT23f4GBJHzRKXp5MUEqP+WzrotTc
         /rbOk3qpNELBZ0FO5lE2VMX4RviK+ACEuFnDqiYlQtd0R9o6LewY2VpEA1t3aS3m8rPo
         rniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IkN08JMONV1p5I7PMr0mqbts4Ubmj+QpJ15F5HnnM3I=;
        b=HxnJKN40oG9r3MnYu6qzpdRZdVtTqRz4wKEpwWYukc2dagInZmtCJS8XUMna2Tfpc5
         DLqW2ZSspxgcO0vHCi/50hE9vSihEjVjkcupFy7Rs1XmcFglOEJtUSVeJN4M94gMptTS
         4iNBIFpHbTtdPH0xLMY32djwsCm1KDAOzYS9SqW7k020fnd/+Y8ZWzAdWpN05Hmcu8Al
         KnjmDYXWoooLHfGWENzMxgLBqyCT9RPqG9DbPgWJdNZ2C7T8QVTOfA8etJakpV7BjDTv
         6K8c9p0+yQHq7R7cxqcFtPF0uolZmjiYUrOx5LWkrPw8e3P8rBsRk5wI410G16gDtD95
         R9VQ==
X-Gm-Message-State: AOAM533lmUqB8n2g79Ex3AaucUsaGnn/j6NV9L/2JWyhXaQDtFzDOdz4
        HcTrKYS2UoTw7sQDmWEVt/63wMlATHukpd4zfl8=
X-Google-Smtp-Source: ABdhPJzfEtRu5OC8Yh42N7qptVed1jZMgd5KlanzKTvhobqGig1yl0oRjKaBnycsHqdU1ij5ASo+xiuYFQXUuGHinvA=
X-Received: by 2002:a05:6830:108d:: with SMTP id y13mr13129604oto.162.1620494451171;
 Sat, 08 May 2021 10:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
 <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620360300.git.gitgitgadget@gmail.com>
 <2b4e818f-9429-83f1-51d6-d8eb0ba618ff@iee.email>
In-Reply-To: <2b4e818f-9429-83f1-51d6-d8eb0ba618ff@iee.email>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 8 May 2021 10:20:40 -0700
Message-ID: <CABPp-BFvTMzsyD1fbt5BxA6Na=MFLqUkcLyCtnxfADcsu9KPjA@mail.gmail.com>
Subject: Re: [PATCH 1/5] t7300: add testcase showing unnecessary traversal
 into ignored directory
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 8, 2021 at 4:13 AM Philip Oakley <philipoakley@iee.email> wrote:
>
> On 07/05/2021 05:04, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > PNPM
>
> for me, this was a UNA (un-named abbreviation), can we clarify it, e.g
> s/PNPM/& package manager/

Will do, thanks.
