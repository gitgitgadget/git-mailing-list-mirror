Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728CCC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 14:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5737960F58
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 14:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbhHZO1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 10:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242737AbhHZO1r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 10:27:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6652FC061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 07:26:59 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id m28so7241595lfj.6
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 07:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JpdBCOJo7tdfgXtu9BZtdw/NRG2rBB6CnFow3h1lazY=;
        b=h/Z0FaoWoNDJf+1xqpD+ruJBzF6T2umMzLNAb+uPFzs2TLGpqgHLkF01BHgzxQueqY
         +yQp9TWoi/WVVxs3aRz06aYgUhPLdOA51pZW3XyE8rJfMqy46kKoEg8OPaIyG+CP4ggL
         Bs8dDTmdbnF2wDZojch088lsnVA0H12phaM5+xgiyDkQaUOGQDB65PaV8thaquGKVh8s
         6F1ZWYylSu8q1oLd0Zq5aEBi4qu3fQmL9PngVuVt6NUMu5kfI24RLbSNOb+Fb+f1VnEU
         rNvrH9aTwUVdUObT9+DOdiFgwhd1q6KqRS6mQ2hNwPoQMZzF1CtzVqQb8EKfltfSADCE
         Yzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JpdBCOJo7tdfgXtu9BZtdw/NRG2rBB6CnFow3h1lazY=;
        b=eJkF4Yp8hRuoXGqkc8D/AJodQnsikMTm4yqwvdLZHNWxzlMM1zGMjB/jsBEPIAK0EY
         lg94KF6X+zzBRxBWmwjpkoYHOosFstpfirrdPp+1sQ39zWCZD3QBQ13ZZ5ihhpP84z41
         Q0jW3z27jIiMf/MTA6yhe69YQ1gK49iy81usbmJrZh0AXCQzkjUXB0yfdakF6yMLQ0eG
         ycyuD5Q2fMXdnREB28XCV727meaXr4MCQQ+Axp/DYSA/2niGl1W5jGMMhIDMXpi17ly6
         mVVEXGtIiaMpH9+GVcGSPVppEwcE0PUrIdnHMa3Poii8ojiY4Duu53O/NLUVJjl02KNi
         D26g==
X-Gm-Message-State: AOAM533/zsk2VVlNjRcU3g3SK+ZklBuUyGzlnZ9mKL7wPZshDSWF0Oh9
        MadrH1PQyU1SRw9uZ4XVCP7/+lpoJUoiKxFYfTffmQ==
X-Google-Smtp-Source: ABdhPJwJqFofqhhDZ/Q9DfP5M1+4f2ym8m/wywrrRoXZkmraZP7ud/u/5gQ3GvJKRJtaA6McJANgQnYmT4JWin0NowI=
X-Received: by 2002:a05:6512:304b:: with SMTP id b11mr174066lfb.502.1629988017734;
 Thu, 26 Aug 2021 07:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <YF2b8LLhE0vjc7mg@coredump.intra.peff.net> <d1405b781915c085ac8a8965dadf3efbe1b0f6aa.1629915330.git.matheus.bernardino@usp.br>
 <87bl5lccx0.fsf@evledraar.gmail.com>
In-Reply-To: <87bl5lccx0.fsf@evledraar.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 26 Aug 2021 11:26:46 -0300
Message-ID: <CAHd-oW7Z8TXZTRmSN0FkCpqEzz7-chJwYbDqyJaQ_ETW8xoG+Q@mail.gmail.com>
Subject: Re: [PATCH] checkout: make delayed checkout respect --quiet and --no-progress
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, allred.sean@gmail.com,
        git <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, =C3=86var

Thanks for the comments!

On Wed, Aug 25, 2021 at 8:39 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Aug 25 2021, Matheus Tavares wrote:
>
> > +test_expect_success PERL 'setup for progress tests' '
> > +     git init progress &&
> > +     (
> > +             cd progress &&
> > +             git config filter.delay.process "rot13-filter.pl delay-pr=
ogress.log clean smudge delay" &&
> > +             git config filter.delay.required true &&
> > +
> > +             echo "*.a filter=3Ddelay" >.gitattributes &&
> > +             touch test-delay10.a &&
> > +             git add . &&
> > +             git commit -m files
> > +     )
> > +'
>
> This doesn't seem to depend on PERL,

It actually depends on PERL because `git add .` will run the clean
filter for `test-delay10.a`.

> should this really be a skip_all at
> the top if we don't have the TTY prereq, i.e. we shouldn't bother?

Yeah, I think it could be a skip_all. But as you pointed out below,
one of the tests doesn't really depend on TTY, so I guess we could
leave the independent prereqs for each test.

> > +
> > +for mode in pathspec branch
> > +do
> > +     case "$mode" in
> > +     pathspec) opt=3D'.' ;;
> > +     branch) opt=3D'-f HEAD' ;;
> > +     esac
> > +
> > +     test_expect_success PERL,TTY "delayed checkout shows progress by =
default only on tty ($mode checkout)" '
>
> All of the PERL,TTY can just be TTY, since TTY itself checks PERL.

I don't mind changing that, but isn't it a bit clearer for readers to
have both dependencies explicitly?

> > +             (
> > +                     cd progress &&
> > +                     rm -f *.a delay-progress.log &&
> > +                     test_terminal env GIT_PROGRESS_DELAY=3D0 git chec=
kout $opt 2>err &&
> > +                     grep "IN: smudge test-delay10.a .* \\[DELAYED\\]"=
 delay-progress.log &&
> > +                     grep "Filtering content" err &&
>
> This seems to need TTY...
>
> > +                     rm -f *.a delay-progress.log &&
> > +                     GIT_PROGRESS_DELAY=3D0 git checkout $opt 2>err &&
> > +                     grep "IN: smudge test-delay10.a .* \\[DELAYED\\]"=
 delay-progress.log &&
> > +                     ! grep "Filtering content" err
>
> But this one doesn't, perhaps it could be a non-TTY test?

Good catch, I'll split this test in two.

> > +             )
> > +     '
> > +
> > +     test_expect_success PERL,TTY "delayed checkout ommits progress wi=
th --quiet ($mode checkout)" '
> > +             (
> > +                     cd progress &&
> > +                     rm -f *.a delay-progress.log &&
> > +                     test_terminal env GIT_PROGRESS_DELAY=3D0 git chec=
kout --quiet $opt 2>err &&
> > +                     grep "IN: smudge test-delay10.a .* \\[DELAYED\\]"=
 delay-progress.log &&
> > +                     ! grep "Filtering content" err
> > +             )
> > +     '
> > +
> > +     test_expect_success PERL,TTY "delayed checkout honors --[no]-prog=
ress ($mode checkout)" '
> > +             (
> > +                     cd progress &&
> > +                     rm -f *.a delay-progress.log &&
> > +                     test_terminal env GIT_PROGRESS_DELAY=3D0 git chec=
kout --no-progress $opt 2>err &&
> > +                     grep "IN: smudge test-delay10.a .* \\[DELAYED\\]"=
 delay-progress.log &&
> > +                     ! grep "Filtering content" err &&
> > +
> > +                     rm -f *.a delay-progress.log &&
> > +                     test_terminal env GIT_PROGRESS_DELAY=3D0 git chec=
kout --quiet --progress $opt 2>err &&
> > +                     grep "IN: smudge test-delay10.a .* \\[DELAYED\\]"=
 delay-progress.log &&
> > +                     grep "Filtering content" err
> > +             )
> > +     '
>
> It looks like these tests could be split into one helper function which
> just passed params for e.g. whether the "Filtering content" grep was
> negated, and what command should be run.

Makes sense, I'll do that.

> Also if possible the two sections of the test could be split up, and
> then the "rm -rf" could just be a "test_when_finished" at the top...

Hmm, as we are removing the `test-delay10.a` file in order to check it
out again with custom options, I think it's a bit clearer to remove it
right before the actual git checkout invocation.
