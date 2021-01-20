Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D8FC433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57977233A1
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391192AbhATQLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391321AbhATQKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 11:10:16 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83950C061786
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:09:35 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id n42so23817212ota.12
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BIIVUFsIcia5pe7bChlug+Fljw5incrfKMoEDXm6uuY=;
        b=GvZ1EW0/dLw5CKpZgEqQDi3jyUQCO76d8Ft+QwYa4nKyieItFeqiOsdMGX2z9OiEgl
         HFPYSADznQ+mnUbkLLJXWLPi2ZZELZkDjGpWWE891UDpPMXAZiGEk81Q2AfUHtLTUZJ9
         VdxKnNPzNFGh31E/Osq/1maTeZ+bSRXdSCVkVYqXLPY1mMKEtjfn99KnU6cY8bDINj+7
         diFql0M50/lSLhHzlUoa63Qt3NJUjhLmZHpVgv+uGLLVQdxoTqidp2AMUF8DkY6R/Fqq
         EyNb7/TZEJ0ReptRPOY4B22dd00NWDhm6/6Yh2zdQaP5cbo2iY8gGE89NmMxf8PKrU2t
         BZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BIIVUFsIcia5pe7bChlug+Fljw5incrfKMoEDXm6uuY=;
        b=m0WDjP5G/lGSjNOh8rLI0N8szS9Yr75D6jAj1O/GTzxuFji7nchyDizGHOS9NBgxgH
         F8Nz3g6+gyv1gnW4Pk5X+Vf9NKSjDY3H6CrcrYlouNAgI8JVFCxGjfyIvTX3zATp8J5m
         eKE/sPcsQWcL44rf8bG3rN1FdQW6XjvGoT06oqj4Jjk3Yzy7BdMLdZrxlzeRh0mKswY2
         W7sW50/m/s//JKHaRTkaj5D/r7VGN1lGuiTY37sC7G7YpAe4NA/G6a5t1r6yLaLNVK3K
         NQve8/0WN4C/tPwIEcCTPhkTivkwkYosGr58LjK3FW29M82/Cq88Yqjo21z/goAC0aCY
         9JWg==
X-Gm-Message-State: AOAM533KWfq2Hg1du8E1pcxQnQJ0J7FilUXQJ8NPJ35DIdRyi+eGv0rt
        /uRrcuYimn11EEl2NnKKwsiNqY+TYvzMayibdGU=
X-Google-Smtp-Source: ABdhPJws9mk3iG1/hnDhbXP7nd0SY3f31O2bwN5/BBNU3Yz2DwFj6Czd97tdxpRRHG3Ad+8wFByUZrT9c/f0vhtqFkI=
X-Received: by 2002:a9d:313:: with SMTP id 19mr7437627otv.147.1611158974915;
 Wed, 20 Jan 2021 08:09:34 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210119074102.21598-10-charvi077@gmail.com>
 <8fd2b72c-d1d0-98be-e6a5-fb7dc699d5d5@xiplink.com> <CAPSFM5euGE_bUDPgdzx4-q5zYtkDymHdJP9rw-YkVVVzpOKWkw@mail.gmail.com>
 <7c11da69-d2f1-0aab-80bc-d8ae8735f8ca@gmail.com> <CAPSFM5f9JJk5xY-f2mNwHjZZfo-=LzSCpA2Q73T-ASGMxfqqeg@mail.gmail.com>
 <fda55ef5-ce37-67c0-f49b-fc2e5172853b@gmail.com>
In-Reply-To: <fda55ef5-ce37-67c0-f49b-fc2e5172853b@gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 20 Jan 2021 21:39:23 +0530
Message-ID: <CAPSFM5eOVmL+6zLJ0xj5Y43vJzPVmPpfgSw_05CuAOMZgRrRHg@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] doc/git-rebase: add documentation for fixup
 [-C|-c] options
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Marc Branchaud <marcnarc@xiplink.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Jan 2021 at 19:59, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Charvi
>
> On 20/01/2021 12:31, Charvi Mendiratta wrote:
> > Hi Phillip,
> >
> > On Wed, 20 Jan 2021 at 16:34, Phillip Wood <phillip.wood123@gmail.com> wrote:
> >
> >>> [...]
> >>> Similarly, if we have sequence like `fixup -c`, `fixup -c`, `fixup -c`
> >>> then also it will fixup
> >>> up all the content and here it allow user to edit the message, so
> >>> opens the editor once
> >>
> >> It is good that we only open the editor once in this case - I'd not
> >> thought about chains of `fixup -c` before reading this. Do we have a
> >> test to verify that the editor is only opened once?
> >>
> >
> > No, we don't. But I also agree, it's a good idea to add a test for it.
> > I think may be one sequence with 'fixup -C', 'fixup -c', 'fixup -c'
> > and the other 'squash' , 'fixup -C', 'fixup -c', is sufficient for
> > testing.
>
> Those are both good sequences to test. I think we should check 'fixup
> -c' 'fixup' as well - with 'squash' 'fixup' we open the editor after the
> fixup so the user can see all the changes that will be committed when
> they edit the message, we should do the same for 'fixup -c' 'fixup'.
> Also 'fixup -c' 'squash' might be worth testing as well.
>

Agree, I will add these two test cases also and send the next revision of
patches.

Thanks for reviews!

Thanks and Regards,
Charvi
