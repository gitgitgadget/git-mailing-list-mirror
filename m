Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7380C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 23:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFEE0205ED
	for <git@archiver.kernel.org>; Wed, 13 May 2020 23:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXrHMyQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbgEMXVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 19:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732374AbgEMXVv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 19:21:51 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679B3C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 16:21:51 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id o24so23023585oic.0
        for <git@vger.kernel.org>; Wed, 13 May 2020 16:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/j5kPIpaT+TAPhrUaFBFKgc/xEbJ365einw4tGasmxk=;
        b=rXrHMyQcYK0weais58qobycsz7eP4Nvmie4diMu1gp8kmv44Cb25W1iCihgt7hGqAI
         5/3gGNmYYnEM1iIeL1qEfQ5ZgqF0fgXJt7EvnyNxgBWfCB+HIOGv5aFIXWerAxXQRhz3
         Qlnwl9oZJbrmp2twIJYYw8/YQgbY6eW+qzt6B38fQ7kDKMBLedgp7NdODIZPLpmTs4tD
         LB1U/1sjVNJMuZBi4NwOnZD+HCEbsHrSAcxGbiaKqnu8tnntnGeevgJDd5Dghrc8Y4B6
         MnfvcTaOp0qVMjFuXhH69gc0yYs3QGWjy3/Bkw2SKqrC7B/e9LxJqazaiACRohK0HQlN
         LnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/j5kPIpaT+TAPhrUaFBFKgc/xEbJ365einw4tGasmxk=;
        b=A1jzoW+4pUU01nv9p0Tm7FweRLQwkZUr6xRRQN57YqzmHYmcVWG2stlozI2L4e0cWD
         mDmuThCazvr1iS7OpfiObsdG8tg5gFDylnVFsSNKUnU5SsAGrvbdZjzOX25Mj/393qig
         uAw9UVomtbMBWpAoGLmEO7Gt4/ssRnBepdWN6IrUOzIBucdsskBcwp3CSY86I1Mgs9rt
         BUBaUBKzwPUz73LoQvbGVtm8aLIrREjyLy5gQ4ninzDBpXPSpyzHr5aawG3ogJOGyDwO
         gqCEgz5ZlkNMVmpx7b9p/tHA0/bqK3thQpW3aZ7EJJFyi9RXgv+tRsVy/SzwmwW6DdXC
         lquQ==
X-Gm-Message-State: AGi0PuYzvS0qo+B1siKnQr3h9rfMHRfUgbU7YIKfCWI1oE3n75oDlYDt
        EqlUeaCRnVVJIHDxlhdM2iKNT1ezKIs8eP0z5DY=
X-Google-Smtp-Source: APiQypLchK7bQ7lAuU6gRpk7svGMZXBPh0M1vxbZXWGb0MagyyzFJ2ZIaMsJfa/KvrHevSlNZNO5uyzi8ilmNXpokGE=
X-Received: by 2002:aca:40d4:: with SMTP id n203mr30150055oia.39.1589412110593;
 Wed, 13 May 2020 16:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAG2rzA=c8bGD6A_8kKCdz+UABjed9W6mSJYjLhYckbsXiFe4CQ@mail.gmail.com>
 <xmqqsgg3vmiz.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsgg3vmiz.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 13 May 2020 16:21:39 -0700
Message-ID: <CABPp-BFdDC0LsFUZuwqw2S+L_yFy5gf-QhQebG56FBOAw+wkAg@mail.gmail.com>
Subject: Re: bugreport: Wrong binary file content after cherry-pick
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Chunlin Zhang <zhangchunlin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 9:15 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Chunlin Zhang <zhangchunlin@gmail.com> writes:
>
> > git version: after v2.21.0 can reproduce this bug
> >
> > reproduce steps:
> > git clone https://github.com/zhangchunlin/gitbug
> > cd gitbug
> > git cherry-pick dev
> >
> > Then there will be a conflict with the cherry-pick, but if you run
> > "md5sum *", will get:
> > 6f96c8bc9e3df2f6fef1ecbb09f218f6
> > ICS_usc_any_any_9.1.5_8871.uscc_261_130664_2048-release.apk
> > 6f96c8bc9e3df2f6fef1ecbb09f218f6
> > ICS_usc_any_any_9.8.0_b2cbd84d94.b2cbd84_297_131010_2048-release.apk
> >
> > The second file get a wrong file content.
> > 3 related files md5:
> > 6f96c8bc9e3df2f6fef1ecbb09f218f6
> > ICS_usc_any_any_9.1.5_8871.uscc_261_130664_2048-release.apk
> > d1bdd852b32c09ec93a5494afb3c67e7
> > ICS_usc_any_any_9.1.5_8871.uscc_266_130703_2048-release.apk
> > b2c50a9d7d488aa0b62ec7e68706ea85
> > ICS_usc_any_any_9.8.0_b2cbd84d94.b2cbd84_297_131010_2048-release.apk
> >
> > I use git bisect to found the commit which cause this problem:
> > https://github.com/git/git/commit/48c9cb9d6d058bcf18e931a1ed0d88792bb506c9
>
> That's Elijah's 48c9cb9d (merge-recursive: improve
> rename/rename(1to2)/add[/add] handling, 2018-11-07)
>
> The history Chunlin's repository has is a three-commit single strand
> of pearls; each commit's tree records only a single blob:
>
>  * 'master' that has "uscc_261" file whose contents is f98ab07.
>
>  * another commit on top of 'master' that renames "uscc_261" to
>    "uscc_266" with some modifications; the contents after the
>    modification is 3f71e11.
>
>  * 'dev' that is a child of the above, which again renames it to a
>    name without "uscc" in it, whose contents is 4f19f66.
>
> As the .apk file is binary that cannot be merged textually, it is
> perfectly fine for "cherry-pick dev" to leave the index unmerged.
> The index has
>
>     f98ab07 at uscc_261, stage #2 (ours)
>     3f71e11 at uscc_266, stage #1 (common)
>     4f19f66 at the name in 'dev', stage #3 (theirs)
>
> which is perfectly expected.
>
> In the working tree, we see
>
>     "uscc_261" with contents f98ab07 (i.e. "ours")
>     a file with the name in 'dev', with contents f98ab07
>
> The latter is unexpected to me.

rename/rename(1to2) is unique among our conflict types in that it
attempts to copy the as-merged-as-possible content to two locations in
the working copy.  Problem is, as-merged-as-possible for a binary file
means randomly picking one of the two versions (okay, not quite random
-- it always picks the copy from HEAD).  For rename/rename(1to2) where
we have two copies of the contents in the working tree at each of the
paths, it'd make more sense to keep two different versions of the file
in the working tree.  I'll send in a patch soon.
