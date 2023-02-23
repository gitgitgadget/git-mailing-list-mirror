Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89CCC636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 05:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjBWFfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 00:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjBWFf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 00:35:29 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694B7E04F
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 21:35:27 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-172663f1956so4219138fac.12
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 21:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=62LN3zJWP3tFV8zo6fTh2veCDcupMrDVmEy4cZhy3hw=;
        b=V47KMrAfmsieGWTznR8qRMew3PaLZYsUXgqzFMC0XRTHxzbmCQGhHO6E6VRJWshl1a
         mzzX9v/MWufYYqINl+tyddSxf4nNcq0G1c+RmvrAPOgDQpfP2tjr2C+2ACuZR3/UOLSY
         TBsiYGLJkH6+rCBUgiIV7VovbzkjYElxzpZ2x/B+6HtIL2FSKUXWIxYVYxbbA0OBBVvm
         H8CRNZoEGX2zwMDecU87SsoVCHF4JqFrKsWwyEh+XTljeXzFvRkuqdFFGwA0zoWVqVt8
         6aaeRMyPN2RF+6R+90EQL1as62bwDO8Y7xkwgRjw9ovLAjZp161Z5feZx4S8qltgEt8v
         pUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62LN3zJWP3tFV8zo6fTh2veCDcupMrDVmEy4cZhy3hw=;
        b=Bj7m0XgH1VJaE5TLE8Jq5y9znEDNFVxQefwTDS7ue/vhrq2Ev93649FkhEce/19IBV
         tRYgjmob+nZKiuxWV1ci596OkKwFps1jQHRfQbmApt+yeJjQlh5drmGnzG+8xjohCOu1
         AVZCJQ0EdDsmWmCj+rY1y7J+yd9ljnuYwZUbFHQmgOu6n27tPeZ5OTBKFQxgeefaOn9J
         Ltx1tT/NmHZQ0AtxKZ0/wPy2rcw4oebWStyB9fP7TJEcAWDbgy67GD816Uy8mw1Hvkuy
         DjcdaA3n+b9PJX0iAr0xr4gAGWuYyOmd7S60QCO3OmwP33YLR3TaFSxVz977T5DZc0Ol
         CoPA==
X-Gm-Message-State: AO0yUKWkCpkZBxxZNVKK2Z5L6V4rrrUH/gcMoQUN7Pmrl+UOxPe0BCbb
        1YfdPbWoSX820GTF91AX0ey9nkP04DgCr3IbGQ+De7f0
X-Google-Smtp-Source: AK7set/7rnBT2xS+4Wg+vh7i1mqjFslCNK+/ZPUL2e0ZOvo469yJKLSdxYih1nvciEt0Jp4pFXvvV4/2JVjEgxDS02k=
X-Received: by 2002:a05:6870:75c5:b0:16e:4b62:df20 with SMTP id
 de5-20020a05687075c500b0016e4b62df20mr1133532oab.141.1677130526614; Wed, 22
 Feb 2023 21:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20230221055805.210951-1-alexhenrie24@gmail.com>
 <20230221055805.210951-2-alexhenrie24@gmail.com> <24be0c50-9dfa-e9d9-9d78-1b993832884b@dunelm.org.uk>
 <CAMMLpeSMO38acvnxK2QX18CdoaEiUojwLsV+AQZYOTe5h4Nq=Q@mail.gmail.com> <36090abb-72a0-f9b7-5a41-ddd8ccde92bd@dunelm.org.uk>
In-Reply-To: <36090abb-72a0-f9b7-5a41-ddd8ccde92bd@dunelm.org.uk>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 22 Feb 2023 22:35:15 -0700
Message-ID: <CAMMLpeSAOjo9rghuGKLKNWnz8Wm5SgFamzyPsMvZBB6AMONJTw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] rebase: add tests for --no-rebase-merges
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2023 at 3:16 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 22/02/2023 01:37, Alex Henrie wrote:
> > On Tue, Feb 21, 2023 at 4:00 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> >>
> >> On 21/02/2023 05:58, Alex Henrie wrote:
> >>> +test_expect_success 'do not rebase merges unless asked to' '
> >>> +     git checkout -b rebase-merges-default E &&
> >>> +     before="$(git rev-parse --verify HEAD)" &&
> >>> +     test_tick &&
> >>> +     git rebase --rebase-merges C &&
> >>
> >> I don't quite follow what this part of the test is for
> >
> > The test is modeled after the existing test "do not rebase cousins
> > unless asked for". First, it verifies that --rebase-merges rebases the
> > merges, which in this case results in no changes to the branch. Then,
> > it verifies that `git rebase` without arguments flattens the history.
>
> I think "do not rebase cousins unless asked for" is a bit different
> because it is checking the default for --rebase-merges which seems
> reasonable. I cannot see the point of checking that --rebase-merges
> works in this test as we have a whole file of tests that already do that.

I've removed the test in v4. Thanks again for the feedback.

-Alex
