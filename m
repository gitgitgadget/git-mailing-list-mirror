Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C2AC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 15:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3BBB61106
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 15:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbhGNPMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 11:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbhGNPMY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 11:12:24 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7FDC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 08:09:32 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 42-20020a9d012d0000b02904b98d90c82cso2794631otu.5
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Jj6h+Nx1lX3blqq1lgBAlgTTfk3oYaqx1La/PSqb+k=;
        b=GC11brKln4cg7159PWzoRI08W+5uoM8l8dTU2R+HF/5coqCWdh+ey4Bc1lpOD5ozQB
         r37mP6L0Su4DPOnTEJ4h/kYDyS/GcX0expxLIn54LTPUprPZkGReocc9F7dZnKnnfWFX
         zKif91zdXMWMT+KGj/LIWuSxhaDFJTV4ttgCpxOjrWqvsD0XYdMo/r9jOqYPH88JdLa4
         Fs/ve1E5egVOgWd3XVs1Tg5XDB5bCUkW92dheMTwQ0Gy8rfirBms4VXi8lBuI+RaL3ZD
         Jb6CufQdwO7uQIc1kWrNrFUvhR5DJxvMpFCN6sPOi1M4/vJntC/0XHjqPK/eSqi3tkEt
         8YKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Jj6h+Nx1lX3blqq1lgBAlgTTfk3oYaqx1La/PSqb+k=;
        b=alI48DddEFCU48cSgKwYStP6zVoXV6lqCcDmSYBmpMn5B8xU6+kvg1e3q4IBf01Kg/
         IV7PxRbjtGXBG2PR5h9NUqVqxQ1yzj6xNsO8sZCz8CU5Cy5296V7lNzzMkpucskTiDQs
         CkZBOyg91Zd++mD03m+cQ/jxb6VZy2R3SWYG+UF+Z7eynEpQy1jCk7Xy1CubVEiNChAQ
         3Ot38zDZdOcY8Xw5Nm6SMGn2wQ8At1l/imVADkgbRwSH1cf33aH7xwPUC+/159SSkf+I
         Y3A8TbRrnNtdZop0OLpDx2GN4pT7drc3pAsl9DbDxbTfbxgLb4ovB4ou37+B4ybyXTJa
         M4iQ==
X-Gm-Message-State: AOAM532MNxO949ckJZ6GV7A1L9g+lkt0Akioo8sJ19NMWmTHmhxUEtdb
        EnnKpxjcM8ZD5FcB9BWzDg1HTGw0/XLxKxS5rqI=
X-Google-Smtp-Source: ABdhPJyLwBD4fXMGXai1t44IrVByQSPcQ7XJC2hMjrLKr1lPZA3D/57JPqjfgmZNYXqSOyzEtOtgmdy8be/WKMk2qF8=
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr8584480otd.345.1626275372322;
 Wed, 14 Jul 2021 08:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <44a5d5efaa637d01ec3266b34f31d46acce5ef24.1625964399.git.gitgitgadget@gmail.com>
 <9707b299-3846-6388-36ba-e8d93a28e2ac@gmail.com> <CABPp-BHF3Os7fOeaF_EQOo+Bs7f1DXbYr26WmAQrPjv63nq1Pg@mail.gmail.com>
 <xmqqzgupzppb.fsf@gitster.g> <CABPp-BHdAZYPf0QPOTiekU914u6pNxUSRQEmdN0xOLGv5hdkzA@mail.gmail.com>
 <xmqqim1dzomt.fsf@gitster.g> <CABPp-BFrLd+h0rzkY5nijVLzXh7bUK5t7Go=EY9jZksCeKqQLg@mail.gmail.com>
 <xmqq7dhtzd7n.fsf@gitster.g>
In-Reply-To: <xmqq7dhtzd7n.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Jul 2021 08:09:21 -0700
Message-ID: <CABPp-BGj3JNDOOBcPfR9i1HxSq9e0UtC_O7MCQpweX2O-UTFjg@mail.gmail.com>
Subject: Re: [PATCH 3/3] diff: correct warning message when renameLimit exceeded
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 13, 2021 at 10:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Am I mixing up negatives/positives (as I'm prone to do), or would it
> > be more correct to say the new algorithm risks suboptimal positives
> > rather than that it risks false negatives?
>
> I'm prone to mixing them up, too, but I think they are the sides of
> the same coin.  Imagine there is a path X on the source side, and
> two paths Y and Z on the destination side.  With exhaustive match,
> Z might be a better match (content-wise) to X than Y is to X.
>
> For the path X on the source that is matched with a suboptimal
> counterpart Y on the destination side, we may call the situation a
> false-positive because with a more exhaustive search we might have
> been able to find Z that is a better match.  For the path Z on the
> destination side that was culled too early with heuristics and
> failed to be matched with the source path X that got matched with a
> suboptimal destination path Y, it is a loss for Z---it wasn't chosen
> when it should have been (i.e. a false negative, as Z saw no
> counterparts).
>
> In any case, during the word search for "inexact", "more precise",
> "more expensive", I do not think negatives and positives will play a
> big role anyway, so...

Indeed, I've gotten us off on a bit of a tangent, but thanks for
taking the time to answer my questions.  :-)
