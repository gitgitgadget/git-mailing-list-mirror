Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA97C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 08:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B0E60249
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 08:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347851AbhIHICF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 04:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347621AbhIHICC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 04:02:02 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25028C061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 01:00:55 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q39so2038660oiw.12
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 01:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=12pPMsOolvdNLT/bi7OAAnIjtO9rPtyx8Dmne1KHdbA=;
        b=lJEcfvksxKcvU3aPK/PJDPXFGQMmUpKT2Q/6mrTHvuyLMC7nWFPvgZ5tvX4F5LfXaD
         +yMC8AxUHo+5Nvd9Wtn8Ke9hoACej1rSIJR/GRA246GnWE6RYjgmzOKOgXkdf5UWbLci
         aeZJDYchjhVdtp+ixiJ77JgwSZy1YT4ZXHwQTMCCe2nUf/eAjrwhRdBXn00tTJL9eCRw
         Z7Llz37ILm/HdzxCHRXxR3nu9O/lhBnGLo93Uqzynf7hbNKtLE47aEbOmLYe56rpg4i7
         +Z2fTSfXxU+xUjSI3qmhPUvu/hMhiGb3E0tWbcf0YBBe3N+L2i14xvCx4ZrzoWgnu1yp
         wDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12pPMsOolvdNLT/bi7OAAnIjtO9rPtyx8Dmne1KHdbA=;
        b=TFk0QKEgjtI+7ibI/wT5tDvL6vG7K4hMTVbny31rrYrPgY693gJU/+wHfpTFJSCLnN
         pUuEFVzvUbVjyF2AK4+BYaGbD3rKtvZ6dHNGwTPX8+GvHqP4+BwftY49PbcexMgv5yGu
         yxEgI1p174W+dJZYRMonb+NIEROc7sZbDUJ8PS0CeE17mpaxcC8e6UEfMz4bAxJ4Gkwp
         VP0EJeNhPQA2IUCABpRCAbaqbUl+5c11lqiRdlUyMV082aPcdVMiLzFFQcwFVZ5ybiaw
         534uvRiyR0O/yriy/JZch/cJmlUkkDf47EoKxLy9nFovijr8NEDg3foRtzpjSP76bdPm
         ekeA==
X-Gm-Message-State: AOAM530C80Sn4dUT63bVzsd3pP+l3h0x4bPwsdM8C+WO9lCu+tKNaoV6
        Kr5ppTCZjneTh4KDmnUxZnnYl6qy1+XS/IhuK2o=
X-Google-Smtp-Source: ABdhPJyXkWM0j5XD7LbLjylUzgv0x5LWj19B6uwOgcpdahL2ES7QZ/jI95Mo/8QPUf01uMPExKVM7XTgHmvUTQ/55nQ=
X-Received: by 2002:aca:bfc6:: with SMTP id p189mr1482461oif.167.1631088054459;
 Wed, 08 Sep 2021 01:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com>
 <b8a418bc63ab0a4add25724a11eb5f992e3d4472.1631067429.git.gitgitgadget@gmail.com>
 <xmqq8s077doe.fsf@gitster.g>
In-Reply-To: <xmqq8s077doe.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Sep 2021 01:00:43 -0700
Message-ID: <CABPp-BGD9WdeiquX0eiMz2458pDhJpjOXGyUOqoXu52ohZVCsQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] t4151: document a pair of am --abort bugs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 8, 2021 at 12:02 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +test_expect_failure 'git am --abort returns us to a clean state' '
> > +     git checkout changes &&
> > +     git format-patch -1 --stdout conflicting >changes.mbox &&
> > +     test_must_fail git am --3way changes.mbox &&
> > +
> > +     # Make a change related to the rest of the am work
> > +     echo related change >>file-2 &&
> > +
> > +     # Abort, and expect the related change to go away too
> > +     git am --abort &&
> > +     git status --porcelain -uno >actual &&
> > +     test_must_be_empty actual
>
> This test makes me worried.  It is perfectly normal for "am" to be
> asked to work in a dirty working tree as long as the index is clean
> and the working tree files that are involved in the patch are
> unmodified.

Ah, I think I am just too used to rebase where it refuses to start if
the working tree isn't clean, assumed the same with am (which I don't
use that much), and then projected from there.

I'll drop the second test; thanks for the explanation.
