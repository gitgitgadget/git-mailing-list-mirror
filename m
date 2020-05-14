Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABEEC433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2B92065F
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuU3aEY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgENVqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 17:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgENVqT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 17:46:19 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05873C061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 14:46:19 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 72so319160otu.1
        for <git@vger.kernel.org>; Thu, 14 May 2020 14:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZRMdsJLnKLum20RZwrSBV20Z8GP5MZXXZJatCiqVQjw=;
        b=QuU3aEY6AwJdkXUmM+y/yUguc5uaBEYyhfW6uGbC9x4WSC3+Y5+zyZN3aixqLrymLL
         XAcCna4CuF43PnWvfO0Puefj/hBe3rQ37h0ox6+gU4L7Tb8zA4sQUuJSwToHoxyvpsNh
         lhvKUDHDjtpvmZ2JUIAhKvvFZfS2TRAtG/ynechKgZbIVHxUHcWhEopUH05vBoAFHFRZ
         PpMpcYJKHnntHagHjfVQdtU91qWsIJClNfEmGZo0F2aJGR5KT9J29m5mu2zPvKdD0s0I
         IO7bTUE1IVqwmgZtkMtIRK7dfIL7vJgjug3W9ZXHPX2hdHeJPEL3Y6jfjQnKUvo2dxIZ
         eVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRMdsJLnKLum20RZwrSBV20Z8GP5MZXXZJatCiqVQjw=;
        b=LiY9p0tRB3vkdfjtyLaj0yfPL1opZbRd0EeLCKzyI49yVsnkq4CQF4UL+ROxsOj6tM
         a97Gas4bL9WTBOPjOitW6yJMlW1+5lzWff0RRnfP5vjJR0nWwonYYTKhakQGY+/DFYKe
         vFRR5BhUtFX66nEaSXYHCnv/gKS28fFHfNKE+4nlfE6uB5maxSL1Jh+Q9kB23tyJRVEj
         L0kx1bjRdgK0wRNctAiO/5I5AXn1aI3CGg/Yc51S8CYUt0/eye7U7ZEZg3BcvZ5xgeCG
         4nm4oO1Wv42PvNk9OCslF02wOo5ndXvyauSjqdKhde0tIkJ1ZRN9EUrnp8f4Ii7zp6r5
         TJCA==
X-Gm-Message-State: AOAM532tFYDTWU+W+FC7GU4hrx64aDuYDuVtUpZUlEvNKkA/wU27+ZlY
        krP56kZXsFT2Ff7q+vBUUmgd3WCbtSdx/RPJVUk=
X-Google-Smtp-Source: ABdhPJym5YOQsTP+2RYdW3P7qh3ls/tr9+OkvRPagN8JZcIuaNO0IDWcumMWksyhR8LOJKuwT5eXvqDRixNGAwA+H3Q=
X-Received: by 2002:a05:6830:186:: with SMTP id q6mr2673ota.162.1589492778275;
 Thu, 14 May 2020 14:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.785.git.git.1589486002453.gitgitgadget@gmail.com> <xmqq4ksiqnbf.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4ksiqnbf.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 14 May 2020 14:46:07 -0700
Message-ID: <CABPp-BHM8uS1yxAtjE=Frh_V7JF7-EJ8+47e-cr9TpEMZr4nfw@mail.gmail.com>
Subject: Re: [PATCH] unpack-trees: also allow get_progress() to work on a
 different index
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 1:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > commit b0a5a12a60 ("unpack-trees: allow check_updates() to work on a
> > different index", 2020-03-27) allowed check_updates() to work on a
> > different index, but it called get_progress() which was hardcoded to
> > work on o->result much like check_updates() had been.  Update it to also
> > accept an index parameter and have check_updates() pass that parameter
> > along so that both are working on the same index.
> >
> > Noticed-by: Jeff Hostetler <jeffhost@microsoft.com>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >     unpack-trees: also allow get_progress() to work on a different index
> >
> >     This is a fix to a minor 2.27 regression, from the en/sparse-checkout
> >     series.
>
> OK, so update_sparsity() calls the function with o->src_index,
> get_progress() without this fix would iterate over an unrelated
> o->result to count the cache entries that are marked for update or
> removal and show the progress based on that number without this
> patch?  The other caller in unpack_trees() uses o->result so there
> is no change in the behaviour with or without the patch.

Yes.

> The flag bits on cache entries used to count the entries in the
> index by the get_progress() function are applied only on the
> o->result side when merged_entry() and friends call do_add_entry(),
> no?

Not quite; unpack_trees() also calls apply_sparse_checkout(), passing
it o->result, and apply_sparse_checkout() also sets those bits.

> Do we see these CE_UPDATE|CE_WT_REMOVE bits attached to the cache
> entries in the o->src_index array when get_progress() is fed the
> src_index in the first place?

Yes, before calling check_updates(o, o->src_index), update_sparsity()
loops over o->src_index and calls apply_sparse_checkout() on each of
the non-conflicted cache entries.  apply_sparse_checkout() will set
either CE_UPDATE or CE_WT_REMOVE whenever items flip from or to having
the SKIP_WORKTREE bit set.
