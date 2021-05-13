Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE331C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 17:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7046143B
	for <git@archiver.kernel.org>; Thu, 13 May 2021 17:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhEMRbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 13:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhEMRbf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 13:31:35 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05421C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 10:30:24 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id e19so4208134pfv.3
        for <git@vger.kernel.org>; Thu, 13 May 2021 10:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PX/o9UBXI/HRzTpJw1RYL/YK58cn/rO6+GX0UjXPpb0=;
        b=N4EeHiK2lpx1h2VkrdIOSmpZV6FC4l8KHFs68+IQTGA2oAVaSErNZJvBKdWjENdR4v
         cPpxopucy7xIFNcHiFXLNrtkquKsc/2Eskwax2hbbqYNzEFQJhaVJ8yf8B2zAJXLqicd
         C+0xNwzeJcmIGNcp1KfWvWzYUcvqjlKPUHdpIP/tBYId99J3kZkfqjmrIe6N1u+2ZkFv
         3DXZMQEkTKJHjvmpbBkn24R8F1VbTIDA4SPO/Tc1Ut4iprpSnxETmdQGvEB5vPzxNVqm
         D4EE5kNEAdsnXUQSy6OnQKJ0Cr4MalTQTXXKXTxBd1VEb0hWHRoNJrMgzTEaTdPLTiyg
         TphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PX/o9UBXI/HRzTpJw1RYL/YK58cn/rO6+GX0UjXPpb0=;
        b=KYZA0pkdVbJQtI6EbJ8g72aMyo/0KRdQThIwguqhJf2vMH6Y2HyRafRlYuSMPn0xjq
         qQVtPOQVxm4jqwlGfB5B0SfIjKOqg1tPkhzb+7beaMFrrWJ2HQr4+pTISWdB+0Jm6h0s
         bk0OmCOHruJcZeD3AeCv4zy8XO2PT5LNIcxzi0uvLFbhTCZuRAXfaaKI0pO4LuzXIoxJ
         W7asiAz8wlkpZVc0rBzT8TE3SQaespsZ8fnI2u1pr255zmlUHj64QVhoLoVZ731kjH7x
         kqQJBJZs7Z9FOYExhr9VT7wrBQ+HBk+nrDd/Ud6dMG4IU7wGzL0+0+JwrvLwCdq/vsVq
         Hd2Q==
X-Gm-Message-State: AOAM5328F3/36+kDenIKZ2lTMxldMLHdz+ipYT2WzotOen+Kuhj+UGQE
        6FngUKpe8FJgTEY5U0eFKGbxqHSkO2AuphT77V4=
X-Google-Smtp-Source: ABdhPJzGHWuGumhKjzcvWRJLwToTq4w+FBJfVv1ybj+jIaYerRXMFVOMsloRsIvd0pBdauLF7sNK5sr5lur7XZsdEao=
X-Received: by 2002:a17:90a:fd95:: with SMTP id cx21mr6299162pjb.137.1620927023586;
 Thu, 13 May 2021 10:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <609b2828309fc_678ff2082@natae.notmuch> <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <YJt0Dv7HP2VnLLwv@coredump.intra.peff.net> <YJt1/DO1cXNTRNxK@coredump.intra.peff.net>
 <YJt81neO7zsGz2ah@coredump.intra.peff.net>
In-Reply-To: <YJt81neO7zsGz2ah@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 13 May 2021 19:30:11 +0200
Message-ID: <CAN0heSqxFdiwF=--DaBFMqmvjMDY__hvs+u0vfc=GG1jcqZwoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: add an option to have Asciidoctor build man
 pages directly
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 12 May 2021 at 08:59, Jeff King <peff@peff.net> wrote:

> We seem to have a problem with some escape codes. E.g.:
>
>   -           of nothing). The other file, git-add--interactive.perl, has 403
>   -           lines added and 35 lines deleted if you commit what is in the
>   -           index, but working tree file has further modifications (one
>   +           of nothing). The other file, git-add&#x2d;&#x2d;interactive.perl,
>   +           has 403 lines added and 35 lines deleted if you commit what is in
>   +           the index, but working tree file has further modifications (one
>
> and:
>
>   -           Added content is represented by lines beginning with "+". You can
>   -           prevent staging any addition lines by deleting them.
>   +           Added content is represented by lines beginning with "&#43;". You
>   +           can prevent staging any addition lines by deleting them.
>
> which is a pretty bad regression.

ASCIIDOC_EXTRA += -aplus='+'
ASCIIDOC_EXTRA += -alitdd='\--'

seems to have done the trick for me at one point, but Todd had some
concerns [1] that it interacted badly with the html build, so we might
need to use a less aggressive choice of makefile variable to only affect
the direct manpage generation.

[1] https://lore.kernel.org/git/20190323192756.GK4047@pobox.com/

Martin
