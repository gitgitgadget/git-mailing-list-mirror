Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164C5C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 20:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCFUk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 15:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCFUk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 15:40:56 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437453609D
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 12:40:55 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id n18so9487256ybm.10
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 12:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678135254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SY+Epk4f3ftW2/oIGWj9rE99H1mczxvqw/E70fdNg7M=;
        b=VUWpkjofl5rDMASeYEBAY9sDmgG4unc7JoMYcv6BZ0I/BovfvWwMYuTRNzo8PZLsOp
         u4ZSRbeefAR3rHryAoVsE4bwMZA9B42b/XCX7/1KKh8SApsZvq86mlYMZgJeVJ7Z85Pg
         iJQyOqrVAC0Dt0WVeevu+tMkwtq/SVjcscmUw/Qc1cX1qo0+gWfWHuwcekUcIW3ftufK
         VL7loRA0OTLCwMHEt1tYM20rfWOy/qyMW76RyrwVm0j4EL6IQTwRvSbCms3rnDOb0qLz
         T2FSkX4VmvpFEV6+1+f17Tm/j95+Zvmbcu5qiFzp+a/9BTtPi2cp54YUzwKbZorh5vhP
         UyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678135254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SY+Epk4f3ftW2/oIGWj9rE99H1mczxvqw/E70fdNg7M=;
        b=v6iIXntJ3tkR78e6AK4aQadjMmxm7EMA4Sqld7AMGpTz/gMxk73QGlnYqQUQxyo6gU
         iI9FFidAmGRjZ2br1zi8Fv6uKG43tbooViPICgHKFd3YSdS3fxgwi0FImdz3p0hte/4Q
         ME/13rFx3qgAzZQFxw7365P2He4t+SPxncPcfvD5bNkp12bm+O7EX77TCaTlw9uD1xfX
         Gm7BRz7viAiTBa7lrgNZAWqjVbKNiAuNO9R6nOx7PUF9GJNusPkY7/yGMgH+/eqgIGmJ
         FcbEolokV0bBQ+nS/raUD+qqswFI80Cmh1EpQaL++kWKcz63up3iOXUEvmINyONlzDpP
         LRPQ==
X-Gm-Message-State: AO0yUKU+CIdtx9fH53yQOI+Q9h7fktXTG1Fla889hAz6J5E3a7H7oiG6
        hNXeyLqN5YZnK4/Q4zXCGijfM2AVPLlenrNXaDfsQw==
X-Google-Smtp-Source: AK7set80REsqSfGy+DgR08sjXhzuZCvYOCy7WDnSra0mjVCfJ5ZpfM0cbji8DXRlO35Y5WQKffgyc6Aqf7h2LNOd+TY=
X-Received: by 2002:a25:9281:0:b0:b0a:7108:71e9 with SMTP id
 y1-20020a259281000000b00b0a710871e9mr3012774ybl.4.1678135254258; Mon, 06 Mar
 2023 12:40:54 -0800 (PST)
MIME-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com>
 <20230228185642.2357806-1-calvinwan@google.com> <kl6l8rg9ekvz.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6l8rg9ekvz.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 6 Mar 2023 12:40:43 -0800
Message-ID: <CAFySSZDF5V6nV2uyg0NSvVGgG_ybSpeqGPi7CPSvsyZ10KfYwA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] t4041, t4060: modernize test style
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        peff@peff.net, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 6, 2023 at 11:32=E2=80=AFAM Glen Choo <chooglen@google.com> wro=
te:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > In preparation for later changes, move setup code into test_expect
> > blocks. Smaller sections are moved into existing blocks, while larger
> > sections with a standalone purpose are given their own new blocks.
>
> The changes where we moved lines outside of blocks into blocks without
> changing them look good to me.
>
> > While at it, have tests clean up after themselves with
> > test_when_finished
>
> I believe this came about as part of the discussion in
>
>   https://lore.kernel.org/git/xmqqedqtbbf4.fsf@gitster.g
>
> I think it's good to have tests clean up after themselves, but I'm not
> sure if that's what we're doing in all of these cases, see below.
>
> I'm leaving the diff header in place, since the two files have very
> confusingly similar tests.
>
> > diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-=
option.sh
> >  test_expect_success 'typechanged submodule(submodule->blob)' '
> > +     test_when_finished rm -rf sm1 &&
> >       git diff --submodule=3Dlog >actual &&
> >       cat >expected <<-EOF &&
> >       diff --git a/sm1 b/sm1
>
> This hunk and the next...
>
> > @@ -212,9 +215,9 @@ test_expect_success 'typechanged submodule(submodul=
e->blob)' '
> >       test_cmp expected actual
> >  '
> >
> > -rm -rf sm1 &&
> > -git checkout-index sm1
> >  test_expect_success 'typechanged submodule(submodule->blob)' '
> > +     test_when_finished rm -f sm1 &&
> > +     git checkout-index sm1 &&
> >       git diff-index -p --submodule=3Dlog HEAD >actual &&
> >       cat >expected <<-EOF &&
> >       Submodule sm1 $head4...0000000 (submodule deleted)
>
> were changed so that the "rm -rf" happens in the clean up phase of the
> earlier test (test 14) instead of set up phase of the later test (test
> 15). But, the "rm -rf" actually results in a _different_ state from
> before 14, so it isn't actually cleaning up, it really is preparation
> for 15's git checkout-index.
>
> You can observe this by running
>
>   ./t4041-diff-submodule-option.sh --run=3D1-13,15
>
> which fails as expected. On the other hand, it passes if we move the "rm
> -rf" into test 15.
>
> Nearly all of the other test_when_finished here have the same problem,
> where they 'clean up' state that wasn't changed in the same test body. I
> believe they will show similar dependency issues, though I didn't go
> through and test them all.

Good catch. I'll go thru the rest of them and remove the dependency
issues.

>
> > @@ -643,7 +643,6 @@ test_expect_success 'modified submodule contains mo=
dified content' '
> >       diff_cmp expected actual
> >  '
> >
> > -rm -rf sm1
> >  test_expect_success 'deleted submodule' '
> >       git diff-index -p --submodule=3Ddiff HEAD >actual &&
> >       cat >expected <<-EOF &&
>
> This one is fairly obvious, since the test says 'deleted submodule', but
> we no longer delete the submodule in the setup.
>
> > @@ -779,9 +780,8 @@ test_expect_success 'diff --submodule=3Ddiff with .=
git file' '
> >       diff_cmp expected actual
> >  '
> >
> > -mv sm2 sm2-bak
> > -
> >  test_expect_success 'deleted submodule with .git file' '
> > +     mv sm2 sm2-bak &&
> >       git diff-index -p --submodule=3Ddiff HEAD >actual &&
> >       cat >expected <<-EOF &&
> >       Submodule sm1 $head7...0000000 (submodule deleted)
> > @@ -804,9 +804,9 @@ test_expect_success 'deleted submodule with .git fi=
le' '
> >       diff_cmp expected actual
> >  '
> >
> > -echo submodule-to-blob>sm2
> > -
> >  test_expect_success 'typechanged(submodule->blob) submodule with .git =
file' '
> > +     test_when_finished "rm sm2 && mv sm2-bak sm2" &&
> > +     echo submodule-to-blob>sm2 &&
> >       git diff-index -p --submodule=3Ddiff HEAD >actual &&
> >       cat >expected <<-EOF &&
> >       Submodule sm1 $head7...0000000 (submodule deleted)
> > @@ -836,9 +836,6 @@ test_expect_success 'typechanged(submodule->blob) s=
ubmodule with .git file' '
> >       diff_cmp expected actual
> >  '
> >
> > -rm sm2
> > -mv sm2-bak sm2
>
> This is the original case that Junio flagged, which I think is an almost
> correct use of test_when_finished, since we do get back to an earlier
> state before this string of tests, but not to the state before the
> actual test with the test_when_finished.
>
> If we want to use test_when_finished here (which I think we do), we
> should add another test_when_finished to remove the dependency between
> the two tests. like so:
>
>   test_expect_success 'deleted submodule with .git file' '
>   +     test_when_finished "mv sm2-bak sm2" &&
>         mv sm2 sm2-bak &&
>     git diff-index -p --submodule=3Ddiff HEAD >actual &&
>
> ...
>
>  test_expect_success 'typechanged(submodule->blob) submodule with .git fi=
le' '
>         test_when_finished "rm sm2 && mv sm2-bak sm2" &&
> + mv sm2 sm2-bak &&
>
> Currently, they're still dependent because one creates sm2-bak and the
> other moves it back, but if we have each test restore sm2, there will be
> no more dependency.
>

That all makes sense. Thanks for the recommendations
