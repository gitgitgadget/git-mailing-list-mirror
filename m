Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA44C2D0C0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 17:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F21920663
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 17:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fxy46GMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfLWRRd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 12:17:33 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36458 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfLWRRd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 12:17:33 -0500
Received: by mail-oi1-f194.google.com with SMTP id c16so6951071oic.3
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 09:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7dFRbo7v3SNpyxbcZhe/751yNexof1g57jMsh5vui7s=;
        b=Fxy46GMuZE987exUDVTO/EDhHpNwjjvzNHLIiI2IsimaHpR8nocNg0xonQdgZX/I4J
         3ZHBkHcZyC3oMvcpveYco67eNFn+Dzwh18X27wJTat2m5QpqYm5xqaFRIvAJX2FYTDOJ
         v/vzjgAJZNtqxHIVS1IDY7t5L03dQgjUj8ANWbowyKj/U/sGmPMnuhJuy7BmBzI0nRjk
         7wiY08vluexGu0pX1oaqa7CvWfFkKaEwaG8rjyA4BoxOh9B8KDy8eDj4ROTMOAzDr2Gw
         F2s3FPg0bd3WQQ/mWla0ChwXa0VV/BTwSM/D6lXQPmm01QTgi9avWjUFeJw0VOeGWwKw
         S9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7dFRbo7v3SNpyxbcZhe/751yNexof1g57jMsh5vui7s=;
        b=KM9ZlPvYSsxkhyGAUEhYC07izDH0iPToiICKIWuCDn7Y+TF11rlSuanoC77Be1839m
         KWZdjnAqY/uOX6wABkBr74NglmDJrdLhnjjclomN1RaWPNaCEaB9hfwcsFN7J+TOPgCB
         1EiYrDmsF5iHTDP5rlvg5NtZ2g1Ziz/20T76i1mUGiw+E34HPyPAjcIYw8X+lL3XoqM9
         PZi+kC1CJbICo9iUcAqQ0Y5709ECC/T/XB2PUJqRGn5QHksyMOY0Dac+fxHL7Uliazbj
         BAxLMuH68s/fEx6g4eVz/xG0tQjgBIriXrqwZ9LC0pQydJ59q8gR7lYQ+r0upasNm3e5
         sSWg==
X-Gm-Message-State: APjAAAWO4Yih39c1jYey14zCxLg9xhKpmZZWk2O18hFCkVtX52CV6COa
        ItcT7Km2VjZ1MmYKMwmaN+lgZ+xLn2WyIhL+Dh8=
X-Google-Smtp-Source: APXvYqwFkSmazga1tljVaW1kQ1guBLBLEV1Ojkzw13JCa8oWl0udrH/ddncO7NDHzGGD4oZh40t0ePETrMsVuF/FcgQ=
X-Received: by 2002:aca:ba88:: with SMTP id k130mr23705oif.167.1577121452065;
 Mon, 23 Dec 2019 09:17:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
 <9b1ad46c58b7f8397acbf2a8339e150dfb04c956.1576861788.git.gitgitgadget@gmail.com>
 <20191222051106.GA28890@generichostname>
In-Reply-To: <20191222051106.GA28890@generichostname>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 23 Dec 2019 09:17:22 -0800
Message-ID: <CABPp-BHXZHaQk--6=8-BBLqmCeRrLXYXRRru_gbVKUUdGAWqXQ@mail.gmail.com>
Subject: Re: [PATCH 06/15] t3432: make these tests work with either am or
 merge backends
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 21, 2019 at 9:11 PM Denton Liu <liu.denton@gmail.com> wrote:
>
> Hi Elijah,
>
> On Fri, Dec 20, 2019 at 05:09:39PM +0000, Elijah Newren via GitGitGadget wrote:
> > diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
> > index 92f95b57da..3879a43fa0 100755
> > --- a/t/t3432-rebase-fast-forward.sh
> > +++ b/t/t3432-rebase-fast-forward.sh
> > @@ -44,19 +44,16 @@ test_rebase_same_head_ () {
> >       test_expect_$status "git rebase$flag $* with $changes is $what with $cmp HEAD" "
> >               oldhead=\$(git rev-parse HEAD) &&
> >               test_when_finished 'git reset --hard \$oldhead' &&
> > +             cp .git/logs/HEAD expect &&
> >               git rebase$flag $* >stdout &&
> >               if test $what = work
> >               then
> > -                     # Must check this case first, for 'is up to
> > -                     # date, rebase forced[...]rewinding head' cases
> > -                     test_i18ngrep 'rewinding head' stdout
> > +                     wc -l .git/logs/HEAD >old &&
> > +                     wc -l .git/logs/HEAD >new &&
>
> Are the above two lines some yet-to-be cleaned up leftovers? I can't see
> where `old` and `new` are being used elsewhere.

Um, this whole section is broken and causes it to pass the test for
stupid reasons.  Not sure how I bungled that so badly.  I'll send a
re-roll with a corrected 6/15.

>
> > +                     test_line_count '-gt' $(($old + 2)) .git/logs/HEAD
> >               elif test $what = noop
> >               then
> > -                     test_i18ngrep 'is up to date' stdout &&
> > -                     test_i18ngrep ! 'rebase forced' stdout
> > -             elif test $what = noop-force
> > -             then
> > -                     test_i18ngrep 'is up to date, rebase forced' stdout
> > +                     test_cmp expect .git/logs/HEAD
> >               fi &&
> >               newhead=\$(git rev-parse HEAD) &&
> >               if test $cmp = same
