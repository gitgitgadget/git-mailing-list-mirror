Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A62BC433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 22:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A8F64FD1
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 22:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhCIW6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 17:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhCIW5q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 17:57:46 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B34C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 14:57:45 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id f8so9474818otp.8
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 14:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AlEj3EXPO+k5UC7VscVWqCPoTi49KUr9LoySwyzqpT0=;
        b=VIc89hhGa1VmSxIAcVXEIB7kg3OtU8cGP+wP2HTeziBikDZz+L9MwUEIUxTUajzQSg
         18dDWloFl+/dXcmU5f4UD6p3c+7hrgu3f4m5eLfpfYcaSBJboia13Dq8MP08e+egiRY8
         C8s/JvJRUZwbGrRJJAbgxx7aD6MyJX8KyDdAxIoDrEKz/5dgzBKljLsaaSLhiA6K/ywR
         5IIfoFEARlOEVY7HQDePMuDeMSDqYp+aB7bB+Bb7VdtoFzx/uYC7E8Dc3LznKyErs55l
         eKiekEI+eyxNkIAiKC/yEhhQ5q+WeUjHD2RrH3KCqLiV69/ZznJShEY2GN8iqzYQ3gmG
         1XHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlEj3EXPO+k5UC7VscVWqCPoTi49KUr9LoySwyzqpT0=;
        b=s/1w0mL/TfZ778BEFGEEQk9nIfc1ioAdGA6PRaj0TpfxlumQ2gBuquPqPnRlIWTPzs
         MU8xJZq2teW7TyD0vpXTFbHfgMRqooZrNwusX1+MPXXJYo3vR04bCH3sJ4DuOZUmn6hH
         UQSX/kooaAyL1k6dSwFL+MRi5zH9jm8RTp1cGsUgqj9Jbk/rszK+lK9KmrgE0LrfSF9h
         n3WyeAIM7OaNoVvK8kPYXn+Wi0boZjK/pdrsSrGubhkiM5siAiuL0ZnvG63R9v5S3QjZ
         I3dKLqRTt6NeAc/QmKCSn8CxjIZ/7vjLPBN9kxazanKlCmTKTobf55RRcNjtcPDCWhYX
         xEgg==
X-Gm-Message-State: AOAM533pYUi+3LpKmD9vcMWEVZHnGvWSYNqwHj9Ik9AKRKojdOmpyCtK
        c8+McpQOcFSu1PFE26j4etB40ZtzsNqLfBqlUwQ=
X-Google-Smtp-Source: ABdhPJzr0+G6Ceb6JW64xV2cnttTSMqpzRXwEIH4yVOjJnqSqzC2ATA5GfkbTrK5uwAI2CBMZ+i4x1B/d+KsnLgPDOA=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr326523otf.345.1615330665327;
 Tue, 09 Mar 2021 14:57:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
 <pull.845.v2.git.1615248599.gitgitgadget@gmail.com> <cd931286f24d66efbf6b0f0a1f520b58ac468f88.1615248599.git.gitgitgadget@gmail.com>
 <82be59b5-a930-ddca-c694-14f27a9fbae6@gmail.com>
In-Reply-To: <82be59b5-a930-ddca-c694-14f27a9fbae6@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 14:57:34 -0800
Message-ID: <CABPp-BFORhHL5L+zcY0qEFC-Qp4pnKVtWJaMFro-ExYNRyc8Wg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] merge-ort: skip rename detection entirely if possible
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 9, 2021 at 2:51 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/8/2021 7:09 PM, Elijah Newren via GitGitGadget wrote:> +   goto simple_cleanup; /* collect_renames() handles some of cleanup */
> > +
> > +cleanup:
> > +     /*
> > +      * Free now unneeded filepairs, which would have been handled
> > +      * in collect_renames() normally but we're about to skip that
> > +      * code...
> > +      */
>
> "but we're about to skip that code"
>
> Haven't you skipped it already, earlier in the above part? This should
> instead say "but we skipped that code", right?

Oh, indeed.  I wonder if I moved that comment around and didn't update
it.  Anyway yes, I'll fix it.
