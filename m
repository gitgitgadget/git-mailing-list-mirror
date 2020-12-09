Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DFFC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 00:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E68233A2
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 00:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbgLIAbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 19:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731945AbgLIAbo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 19:31:44 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9875AC0613D6
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 16:30:58 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t16so146262wra.3
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 16:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7LrbCosmNnAL1RQPV5fryxT8N4NzlnVzyXtLWL/Gno4=;
        b=gweW/euWgRVohz1dx3FgAk31nBbGvEgVnNdi2YvsRgUCIQeJopQ7u1yFrMoAaYRYvb
         E0SmOtUFQt6Jk0WRajfKUB0HoOeZR77S7g+Oo5NKw4YXJmTBSYy6TBK9fdWiKFRcWVzM
         vYtXK02ryPaXYzgTxMjAI00BZvge2qd380LQdICZu/gg54XwDtnuCiF+4NYs3XPOY+Z0
         EiKaOa9N5uDP6n+MYLOBL8kehTQKnKFJM6hYcDG1Sb2KDhN/jtN0W3OmrgT+1ZZH4P9m
         84UWFbg7GeSr6liX1E8GG33xuLkBCHU/GjKbza6aTg7bo8mlkygppk2moi7G4Q30sman
         Uwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LrbCosmNnAL1RQPV5fryxT8N4NzlnVzyXtLWL/Gno4=;
        b=e9sNLN9sk7hCGGRNvJcj5gZJj+D0V0ih498VmXgWT+BQpeVuFlSSlxRPrIdFm9kxgs
         m3OvCRaAAkc2Sx195Xf7psy/61q4xZckG1mabpQFRl8rlue3RF49x34HMXxT6HFjfbmT
         trzyH1hlG98XmfmkpK9ReWHLOnOmgxLJhprq9763u98wTntrgYHaqxJVoR6s6k9urTYn
         sPHpcxZKkBrP7mSLqgeA0t7taAisFgaqbgmU33DX3345UEvDRecQNufcFHNkspqYdirg
         a4MdXM8RmOZ2IIOvgGgftnLxBJxGObjoCrADlYK6tI8VLW4mnGyDQz9JlU8lVKZSSQqA
         TKbw==
X-Gm-Message-State: AOAM532DPJrv1vYP5i764kBJ5LBxMC00fjze+BmC9eIhjEc/8GII5uMz
        jk+cyzAPyJll8zda6+gWMvbaDr3JPeaSCxrhERg=
X-Google-Smtp-Source: ABdhPJxazQxjCle8y807/ZZtKZnq5VuJxBr0sCOCTXDTAp0CK6x05sYsr6qw8tF5D63/H+H72khAUzqJYZ/Dpsbs4QY=
X-Received: by 2002:adf:ce90:: with SMTP id r16mr691693wrn.100.1607473857294;
 Tue, 08 Dec 2020 16:30:57 -0800 (PST)
MIME-Version: 1.0
References: <CAMP44s1D-Zp3KDS+Hi74a=Lkc7Nc_0qiEzQEF0Pmj=bD8i+=JQ@mail.gmail.com>
 <X8++TTnv95IAIkZL@coredump.intra.peff.net> <20201208215411.GB3783238@google.com>
In-Reply-To: <20201208215411.GB3783238@google.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 8 Dec 2020 18:30:46 -0600
Message-ID: <CAMP44s3qUNdGHV2sCovj1Ls7MGesB8_uuX39h4zhCZ_aG-jCsQ@mail.gmail.com>
Subject: Re: New sharness/test vim syntax
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 8, 2020 at 3:54 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Tue, Dec 08, 2020 at 12:56:29PM -0500, Jeff King wrote:
> >
> > On Thu, Nov 26, 2020 at 04:24:42AM -0600, Felipe Contreras wrote:
> >
> > > It gets a bit tedious to see all the tests in the same color, so I
> > > wrote my own vim syntax file so that at least the body of
> > > test_expect_success is highlighted properly.
> >
> > Thanks for sharing this. Over the years I've gotten used to the horrible
> > all-red view when editing our test scripts, but I'm looking forward to
> > leaving that behind. :)
>
> Thanks for bumping this mail, Peff - I saw it come in, said "oh heck
> yeah, I'll install that later" ... and then forgot :)
>
> But I've installed it now. This is awesome. Thanks for sharing it
> Felipe!

You're welcome!

I also sent a patch to add a project-wide .vimrc file, to minimize the
burden on each individual developer.

A little bit of quality of life never hurts.

Cheers.

-- 
Felipe Contreras
