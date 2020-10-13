Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A25C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 17:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B0B25351
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 17:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ9n9rQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbgJMRXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 13:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJMRXp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 13:23:45 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC30C0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 10:23:45 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id i12so760677ota.5
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igTB3bpC+SU7keNUWVkBO4iL6vebpwOPYYyDDCazSKo=;
        b=gQ9n9rQvyAM6E66kng7FvFUYdNYeV48cHRVeLw/HOh3N7RK05gIoDKnMpUWv83EC8O
         6znaqDF+r/f5NDG0IRCtq9U9002cUMfoNO56UYZebcuFkd5bWjQtv5DYQZbq2xXmMeTo
         zDhdgYLX5Uprek+SN+ezhYU0BFFalWRd2kr5B21ZcqzyteU3fpBnYTl7Yl8tf2qEwx7B
         Z2qvU6q8DgpTIp0E41eiaY5/f7g3H6MoxCLUBWxYY7OKyPvyY4Ysm2E2a7eyYGLLrd6W
         fsF7/MUfyZezBDWVtYPmIkWJm7p/k9r/BmEYa80KynJCm0uEv1ntgi22FPSlw2IwgNmV
         gBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igTB3bpC+SU7keNUWVkBO4iL6vebpwOPYYyDDCazSKo=;
        b=HOwL8wf1kFYqUKrjaJgtUJIBXURXTShB2i9kjilO7LOm89OesxCxqTCWMjwNZj4IgK
         T9DE/Sfp70OVM/V5N43FSeAOnWkBhXiqngWF2r3gSCqVteYaD9sAxZTI8hfMFZBlbtHz
         OOP0fnGagS6h6sJ+A3BU8ve465OIUz+L5y5lIWDh6DOOwcjkXiET5m9u8uoxLappPl/5
         Psc8ghwq2AfwT/EIzhPNiYGW15CKfHwShfaArexsT1xXJvPXuLQ6xM/klgys+thVGoP4
         brIXaBN/w06KCljciwEzK07mMv3ETeinJCTywC5ckCdH9O48HJf1STXWE8+jijnGR8EV
         E1cg==
X-Gm-Message-State: AOAM531aT/sjyiuq/Elt413dL3vANOFvPeZxq9ha6ITKDAejG565Gjb7
        9cYSErqOwRpjaXUzY2SGiSpxpR9pvf9qbn0wVd4=
X-Google-Smtp-Source: ABdhPJzthfN8C/UpIDfACMmXdnbTqZz92tIqU4ADPwkIbYXMsMnmHShILKFkZT1XKNgDP5kkDfXJ3i6GVAsO5ogQeHA=
X-Received: by 2002:a9d:6e96:: with SMTP id a22mr500765otr.345.1602609824343;
 Tue, 13 Oct 2020 10:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <46fce3a844c90b4078578f5aa2058bd6825af1d6.1602545164.git.gitgitgadget@gmail.com>
 <20201013153901.GA1913367@nand.local>
In-Reply-To: <20201013153901.GA1913367@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Oct 2020 10:23:32 -0700
Message-ID: <CABPp-BF4bqNXGusoUgzKUTecaR9bzXJbVODGVB2kqX5qTp2Fug@mail.gmail.com>
Subject: Re: [PATCH 1/3] test-lib: allow selecting tests by substring/regex
 with --run
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 8:39 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Mon, Oct 12, 2020 at 11:26:02PM +0000, Elijah Newren via GitGitGadget wrote:
> > diff --git a/t/README b/t/README
> > index 2adaf7c2d2..23639c5bcf 100644
> > --- a/t/README
> > +++ b/t/README
> > @@ -258,13 +258,13 @@ For an individual test suite --run could be used to specify that
> >  only some tests should be run or that some tests should be
> >  excluded from a run.
> >
> > -The argument for --run is a list of individual test numbers or
> > -ranges with an optional negation prefix that define what tests in
> > -a test suite to include in the run.  A range is two numbers
> > -separated with a dash and matches a range of tests with both ends
> > -been included.  You may omit the first or the second number to
> > -mean "from the first test" or "up to the very last test"
> > -respectively.
> > +The argument for --run, <test-selector>, is a list of description
> > +substrings or regexes or individual test numbers or ranges with an
> > +optional negation prefix that define what tests in a test suite to
> > +include in the run.  A range is two numbers separated with a dash and
> > +matches a range of tests with both ends been included.  You may omit
> > +the first or the second number to mean "from the first test" or "up to
> > +the very last test" respectively.
> >
> >  Optional prefix of '!' means that the test or a range of tests
> >  should be excluded from the run.
>
> This piece of documentation looks to be now out of date; it mentions a
> "test or range of tests", but that only covers a two of the now four
> ways to describe a test.

Personally, I had read "test or range of tests" as general enough to
cover all the cases (I would have agreed that "test *number* or range
of tests" would sound out of date), and just left it.  However, if
there's something clearer, I'm happy to adopt it.  Do you have an
alternate wording suggestion?

> The rest of the patch looks great to me; and I, too, am very excited
> about it.
>
> Thanks,
> Taylor
