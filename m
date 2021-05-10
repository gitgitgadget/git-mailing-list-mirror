Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE691C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 16:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4E5610FA
	for <git@archiver.kernel.org>; Mon, 10 May 2021 16:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhEJQna (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 12:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhEJQn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 12:43:27 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6B4C061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 09:42:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2so24336233lft.4
        for <git@vger.kernel.org>; Mon, 10 May 2021 09:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CL8SwWkagJslg/UcYu/qjenDX+2Vfi/6ACDFMVfZZSA=;
        b=r0A0mSfQKRNL9vLNBmDaCKdMM8M2HqhJDI7WUEhinDv4Q+tdScj4pOVI2+6xknkLud
         57v4r2kuufJjT0/iAAIw6d9FfnhaQUPqsTLDj+D7Hw+k806tSTnrLG94QxQYg2R3oYqC
         GOJJVDcI27jBLcmbajaPhuAWUQE3mIznzrJ5coyrDsrhp3hPXydKnKy2m0xRvmKAoxnq
         YU6+k7To1yoWwqbfMLsi3VFawXqinDYlcub6IGwgJgY64Ccg77TA202azBsJdgv/XGKn
         rELfaonqr5qHjFG69hFDWmvolq4M6FNVoGnE7dfKZhxhxQLeccCIl9z2Mrbc22wSQU8N
         Bu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CL8SwWkagJslg/UcYu/qjenDX+2Vfi/6ACDFMVfZZSA=;
        b=cxZHh9V4TSledsBnAO9fYF/i811jrTVFor/bZ4O961N2B0YKxtRUqtAC4WiK12RJyr
         DLNDJn6JAZ2VXMofaYA1/DMESQc9AUU2mEzEyEr+LVtiCP4e+LXRuxdcr7tY1XVDKAaL
         ktJkj8Rj+UwWodA7FlB0vXIZUjZBZzKifETVn8AzG32x4ZPeFRypHABt2N5ZRm+66k1S
         wWK4zotjng1Ea4uJaKhHdfsy8COEygmWP074m72Lqy71O86M1eywWoKpbzk1NlJ0grWi
         pnYkaf7qvNrQgyfVF7uHepz4ML9tkU2/hn4gWb+T9v64+D7jXGzHM2ikQbGRoxqm0rzb
         5hnw==
X-Gm-Message-State: AOAM533LnEPcEMGcAK2RbSH6XY2v1Vvnfx07IbZ6pv2a2RdJ6j3A4skL
        4/PDlbGZws1hBgumUhvVYYLymWm8X60dzo1xyYY=
X-Google-Smtp-Source: ABdhPJy9yORvLmdZf4rGc+Q/a3T2MZZlhV+7Kk4OiJbo14VvOHD9gm1AaQP1hFF1lmhQwDmYCLDIMEqejd4qW8Mden8=
X-Received: by 2002:a05:6512:c04:: with SMTP id z4mr17282622lfu.167.1620664938552;
 Mon, 10 May 2021 09:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210509215250.33215-1-alexhenrie24@gmail.com> <bb3a3968-f78e-7534-1274-2e6c916b9a8a@gmail.com>
In-Reply-To: <bb3a3968-f78e-7534-1274-2e6c916b9a8a@gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 10 May 2021 10:42:07 -0600
Message-ID: <CAMMLpeT7ezjh95rpJ4_MJ=QyEgCpjYBNG5kaQt00RUKGA7Jd9w@mail.gmail.com>
Subject: Re: [PATCH] merge-ort: split "distinct types" message into two
 translatable messages
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 9, 2021 at 11:36 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 10/05/21 04.52, Alex Henrie wrote:
> > The word "renamed" has two possible translations in many European
> > languages depending on whether one thing was renamed or two things were
> > renamed. Give translators freedom to alter any part of the message to
> > make it sound right in their language.
>
> What are the examples? In French, Spanish, German, Portuguese (pt-PT),
> or even Slavic (like Russian) or even Hungarian, and etc?

The ones I know of are Catalan, German, and Spanish, but I'm sure
there are others.

-Alex
