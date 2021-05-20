Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227C0C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 07:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFAE6610CB
	for <git@archiver.kernel.org>; Thu, 20 May 2021 07:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhETHXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 03:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhETHXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 03:23:16 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FDCC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 00:21:55 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id j30so14389283ila.5
        for <git@vger.kernel.org>; Thu, 20 May 2021 00:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D+9Dz6iso3sDgMiD3nMRkHdUd+fhrRJFbFks2gHRSYM=;
        b=n5pUhXEskKN4xEBtLaJpAbkWjeSKREN/9trHuOT7svR8iBw5KN3zKM97oyCvz2Rpce
         M4xof6YFRxqaIA+EbskQvGj83Xm3YaOM6JuLVdK85QmXhrpWaoFQ0bc9ITqhtclLX0gJ
         irp/cOqvCTuPeUwZLCsvsqLZ8EdhTkC/DKOCVwCQsV7xAHu8nRfOhtMJpmsuQ9V2l7se
         7BqB2VwX5SDo0Bfa4kpIvupHeYgSnPBwuw6hfCLgh8Y37Jav+wJGphhVFTvD9PJz7Y9B
         gnN49vB1WkUO89dVBG+prVFlgZvKi3yijBi70OXhxjm3ZRHA4P+5db/03J6DCihBnYOV
         CebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D+9Dz6iso3sDgMiD3nMRkHdUd+fhrRJFbFks2gHRSYM=;
        b=OUbQSA6h6dMrglSrXTiid7NDScCHSFAPqIsq+xnQQZXVVMuQqgz7BVOiTsPmCjgE56
         TmztlaX7qJanuAsFyjJTbyf7ISyTZiVacYHXE26Y33DhsT3Wu5iY6yyOIk0Ann0HvCrP
         fW2NIahEOyX42G1ik7f0+1hYxl9mmhEBezkhVmRn3lUamcUTG1TFuRpzStAfL0WGmfIu
         wADwIBdnTDPNwZ0hS2za098uC5UcyaEhOp+FJBsQmDCbMTdLhStDTVkpQn3WCtlH6uNU
         bzYcz8W1MElrvsNxwXx0N3aK7O8C4IjWfh+W+pG4BBVwSBE9Z0/Eice1SNW95SJIVrB9
         wYhQ==
X-Gm-Message-State: AOAM5323zNPdsblZF2y2rD8h2y0w/tPE/JHdiXpVYsMzQHbwlCEUyuE5
        no6WqJXXM3O12LtsT7oN2l84guTDDLzQAUGM8rw=
X-Google-Smtp-Source: ABdhPJyRiTx7NlrazKbnlfVr3CwoMXzvvhP9EuSqztRAMQE5tgccPuZiaB+LZkFLW0QWZ66e8ks8uKsrsoB/hgiprxE=
X-Received: by 2002:a92:d24d:: with SMTP id v13mr3641006ilg.174.1621495314407;
 Thu, 20 May 2021 00:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SHE-ok3D+oLNSWFi7KPU==VQnTMDmC4YxUyNBJKmBD8A@mail.gmail.com>
 <CANYiYbGV1LO33piD+oMxjF83K6Nt=19Lk_8oBgzNCVcB=AokfA@mail.gmail.com>
In-Reply-To: <CANYiYbGV1LO33piD+oMxjF83K6Nt=19Lk_8oBgzNCVcB=AokfA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 20 May 2021 15:21:43 +0800
Message-ID: <CAOLTT8Qa7+8oA2C9HC-9a9i=xVD+4eL-RCEt7K9EG5Fv8OTFaw@mail.gmail.com>
Subject: Re: [GSoC] Hello Git
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:19=E5=86=99=E9=81=93=EF=BC=9A
>
> > I'm ZheNing Hu, I am very lucky to participate in the GSoC
> > git project this year. Many people in the git community already
> > have given me a lot of help in the past few months.
> > Junio, Christian, Peff, Eric, Denton..., it's great to get along with
> > you guys! Your review and guidance have greatly benefited
> > my growth.
>
> I admire you so much that you can join the open source community at a
> very young age. I will continue to offer my help both online and
> offline, in your favorite language (Chinese of course).
>

Participating in open source is a very fun thing! Thanks for your help haha=
!

> > In these days before GSoC, I learned some simple command
> > implementation and data structures of git, learned strict coding
> > standards and learned how to test, More importantly, I learned how
> > to communicate with these kind-hearted reviewers.
> >
> > Of course, there are still many difficulties for me:
> > * My poor English sometimes can=E2=80=99t express the meaning clearly.
>
> There are too many differences between English and Chinese, but don't
> worry. Remember, practice is perfect. You can also practice your
> English by reviewing Git l10n in Chinese, see: "po/README.md".
>

I have noticed that the language translation comparison table is in *.po,
which really helps me a lot sometimes.

> > ### The connection between Git and the file system
> >
> > I am currently studying operating system course, git as a
> > file system on top of the file system.
> > There are many differences and similarities with ordinary
> > file systems. I am very curious about this knowledge, do
> > not know if there are any relevant reading materials?
>
> Git objects are stored in ".git/objects" directory in two forms: loose
> object and packfile.  These two types of files are deflated in zlib
> format. In order to increase the speed of traversing these objects in
> this object store, many meta files are created. For example, index
> files and reverse index files for packfiles, bitmap file, commit-graph
> files, etc.
>
> Docs for these files:
>
>  * Documentation/technical/pack-format.txt
>  * Documentation/technical/index-format.txt
>  * Documentation/technical/chunk-format.txt
>  * Documentation/technical/multi-pack-index.txt
>  * Documentation/technical/bitmap-format.txt
>  * Documentation/technical/commit-graph-format.txt
>  * Documentation/technical/commit-graph.txt
>

This is what I want to know: how git objects are stored!
This can help me understand git itself at a deeper level.

> --
> Jiang Xin

Thanks!
--
ZheNing Hu
