Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AED311F4B7
	for <e@80x24.org>; Tue,  3 Sep 2019 21:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfICV6Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 17:58:25 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42940 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfICV6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 17:58:24 -0400
Received: by mail-vs1-f65.google.com with SMTP id m22so3843414vsl.9
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 14:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6o8LFauJSDsitQchWveuNnn+lQDz6esW337d9RwbVmk=;
        b=PAgaE/zDByw3IB+ZXssf0sVmz8wXgoY9mO/Q1Cbf7IPfYPmdYrCUGa/dx2n1Ap6zrn
         mvCSglFxbAP/t7VZILDWnpMZtqelDd51xxzrk5z43wpndLGVKGVKvC6eej0fgN6+qy4C
         N+gTcOV85QMg8ct74UGCJCBAnfwCMtybHa+urz2dL4tJMABINj0w5G3DfTiuh4mt354A
         MvLxnn2al5O8SVNUyRKNzuh5TyusAAXvZvr4/qtvTt/bARr0xQKr+e5sbW28VD3LvKFJ
         fWP1tJfu1PTWcU6xGAmpaQVVSDFdLthR2BsdxXE1wYfJmPNffzyl1eAjEUnNq65t/ixq
         HXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6o8LFauJSDsitQchWveuNnn+lQDz6esW337d9RwbVmk=;
        b=CR28GM5qA0GbmV/oRm6XfFeeMygQyKmnhsm7zaVtD6XTd+sAzQ/j+i7CHdHk9RiVfW
         Otl/PKl1sg/48HzUsFpT/Dr3VJTcWuSm7/Y5+IYPKfT8UTNX9Zb5fvYsG7m4KAYkUSUc
         otv/xCyvTUTlm/3N2Qcql4/6JEfbudswCXCM+xQsuHIwsTPjpHmkeOHyGRKnu4pTqbCc
         zUeDUzlyp1G5flE4eC0HURR0cboimopeFpX2kujGSLRVmRizLx7mK1elGocWGc6HEBeH
         Nd7eBEjg04MW0eaYftDkSEhqb/oYa7MBEb55wyBNSu8hVM3qnxrI7wKDGNHmprkxKNuF
         /PMQ==
X-Gm-Message-State: APjAAAVVCK7mW/ZNJDJa7IknsCd8cleTnHyxojUpLvDjMAeXH4hsKshg
        THGlOzqFZho3JBum/NUqiYKidNKoh7kHo+6mzJA=
X-Google-Smtp-Source: APXvYqzOjnIXcoHjanXxYkeESF6MJ1Mz8X7m1daqWYr/nls+GD3I6vlAHxIlaj61vWaGXAFxX2DtRwPX4WXWbOhT2TY=
X-Received: by 2002:a67:e886:: with SMTP id x6mr11581476vsn.117.1567547903544;
 Tue, 03 Sep 2019 14:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190828002210.8862-1-newren@gmail.com> <20190903185524.13467-1-newren@gmail.com>
 <20190903185524.13467-2-newren@gmail.com> <xmqq1rwxt7eu.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1rwxt7eu.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Sep 2019 14:58:12 -0700
Message-ID: <CABPp-BHx7=kZJ5rgz5q8xRSbVtbE-UEHMyZxjvEq1tRXW7mCzQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] t6006: simplify and optimize empty message test
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 3, 2019 at 2:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Test t6006.71 ("oneline with empty message") was creating two commits
> > with simple commit messages, and then running filter-branch to rewrite
> > the commit messages to be empty.  This test was written this way because
> > the --allow-empty-message option to git commit did not exist at the
> > time.  Simplify this test and avoid the need to invoke filter-branch by
> > just using --allow-empty-message when creating the commit.
>
> The result of filter-branch seems to have one empty line as the body
> (i.e. "echo X; git cat-file commit A; echo Y" will show two blank
> lines between the committer line and Y), while "--allow-empty-message"
> does not leave any body (i.e. the same will give you only one blank
> line there).

Ah, good catch.  I checked out the commit before 1fb5fdd25f0
("rev-list: fix --pretty=oneline with empty message", 2010-03-21), to
try and see the error before that testcase was introduced.  I tried it
on a repo with both an actual empty commit message, and one with a
commit message consisting solely of a newline.  Both styles exhibited
the bug that the testcase was introduced to guard against.

> Was this test verifying the right thing in the first place, I have
> to wonder.
>
> IOW,
>
>         git commit --allow-empty --cleanup=verbatim -m "$LF" &&
>
> would be more faithful conversion of the original (and hopefully
> just as performant).

Yeah, it'd be a more faithful conversion of the original, though the
original didn't match the testcase description nor the commit message
(it claimed it was testing with an empty message).  Also, in terms of
future proofing, any code changes are more likely to omit a needed
trailing LF if the commit message doesn't have one than if it does, so
I think it's a more robust test with this change.

I can update the commit message to explain this, or, if you prefer, I
could duplicate the testcase and tweak the second as you suggest so we
test both with and without the LF.  What's your preference?

> > Despite only being one piece of the 71st test and there being 73 tests
> > overall, this small change to just this one test speeds up the overall
> > execution time of t6006 (as measured by the best of 3 runs of `time
> > ./t6006-rev-list-format.sh`) by about 11% on Linux, 13% on Mac, and
> > about 15% on Windows.
>
> Quite an improvement ;-)
>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  t/t6006-rev-list-format.sh | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> > index da113d975b..d30e41c9f7 100755
> > --- a/t/t6006-rev-list-format.sh
> > +++ b/t/t6006-rev-list-format.sh
> > @@ -501,9 +501,8 @@ test_expect_success 'reflog identity' '
> >  '
> >
> >  test_expect_success 'oneline with empty message' '
> > -     git commit -m "dummy" --allow-empty &&
> > -     git commit -m "dummy" --allow-empty &&
> > -     git filter-branch --msg-filter "sed -e s/dummy//" HEAD^^.. &&
> > +     git commit --allow-empty --allow-empty-message &&
> > +     git commit --allow-empty --allow-empty-message &&
> >       git rev-list --oneline HEAD >test.txt &&
> >       test_line_count = 5 test.txt &&
> >       git rev-list --oneline --graph HEAD >testg.txt &&
