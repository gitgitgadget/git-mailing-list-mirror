Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E816208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 16:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733198AbeHFSTz (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 14:19:55 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:44953 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733074AbeHFSTz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 14:19:55 -0400
Received: by mail-ua0-f196.google.com with SMTP id k25-v6so12756837uao.11
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F3ru0RYkoYbljKiv/YNjsrYIKt12QOCvilGl4nTrBtk=;
        b=UIqhsQMo3KbmFN6UVp65hn7Hu6csyuIE7Jy8y+TLblBToIZuKhYWpXTe2nU+lU7ZfG
         sGkrdF1TlM2zL1bYMIL/az8lv716Ys16HWiyC0tZe7AKxFEVhum9CLvuKiJ0Qi6u/gUT
         zuILdBZDbFFPc1evTpVmr+1Yp4PLjGG9nwt3FtS/uIHyN7AsbctC29Y1WoN0hTZXgoT9
         qyCZioNLnLLwd8PZ97IwoRT8pLjIgSYn1vH2MwLBdeOmRL4nhG0QozYoJqHy/Gx/YeBc
         iKHowjJIqhNYmev70vMKcI4kE5WbI+AxW1gYNZ17VRKh/kjAaW7R/uVZAzhYQ/cMWau4
         mdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F3ru0RYkoYbljKiv/YNjsrYIKt12QOCvilGl4nTrBtk=;
        b=VLLWPTXXo67WFTJ+a+tVg5DpxjnipbaAeL0lA6esWTSL/Db8QVKTJOy7pF+7PTvfp9
         9SRNGJE0vItaz8OE7Xdsw36woYS6ZIC4oskbVt+GGZQToRjEustQrcjofk4YBPid4B9k
         1i6/LweDoZYJK5Lrk+R0cx4Ao8S9rT06sNWNTlTpKR7IC82KPSf+fTuExVPqYKztLIf5
         9kr1MSIkbtNzuv0fkhEooNDHfsvZRKvLN6KmNkCvSkw7bskiiwt9BnPvlv+6v9Q+Qvfr
         rIitlE/hstAlVsO9xSG2SGa0PemZb1GdAop8B3IuupqAAf8XjEQlgr0OB7XjBh/QbTAr
         uD6Q==
X-Gm-Message-State: AOUpUlE0+ISJBOGgOHOjThvHbsGdZDEYmTw4DMoj/DwngXd5t3btpOCk
        lo4rj8heMR0lIIb1tZpxtpl94D0IvNkJ1v/9Ia8=
X-Google-Smtp-Source: AAOMgpfV5wrc6xOtVDhMHfzs989KfmhjrScHJBiCMvRlSP6+N9sHyQbawyikvfmqAl0RUu4IFpKI62/2zorZnH4+S6Q=
X-Received: by 2002:a9f:3d1a:: with SMTP id l26-v6mr10749166uai.29.1533571808111;
 Mon, 06 Aug 2018 09:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180803231407.10662-1-newren@gmail.com> <20180806152524.27516-1-newren@gmail.com>
 <20180806152524.27516-3-newren@gmail.com> <20180806154814.24585-1-szeder.dev@gmail.com>
In-Reply-To: <20180806154814.24585-1-szeder.dev@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 6 Aug 2018 09:09:56 -0700
Message-ID: <CABPp-BEJn3fj8y_K27MOX48t9W9DRS-OOGuJGhq+zuHsMz3SrA@mail.gmail.com>
Subject: Re: [PATCH 2/3] t7406: avoid having git commands upstream of a pipe
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 6, 2018 at 8:48 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
> > @@ -922,7 +928,7 @@ test_expect_success 'submodule update clone shallow=
 submodule' '
> >               sed -e "s#url =3D ../#url =3D file://$pwd/#" <.gitmodules=
 >.gitmodules.tmp &&
> >               mv -f .gitmodules.tmp .gitmodules &&
> >               git submodule update --init --depth=3D$commit_count &&
> > -             test 1 =3D $(git -C submodule log --oneline | wc -l)
> > +             test 1 =3D $(git -C submodule rev-list --count HEAD)
> >       )
> >  '
> >
> > @@ -938,7 +944,7 @@ test_expect_success 'submodule update clone shallow=
 submodule outside of depth'
> >               test_i18ngrep "Direct fetching of that commit failed." ac=
tual &&
> >               git -C ../submodule config uploadpack.allowReachableSHA1I=
nWant true &&
> >               git submodule update --init --depth=3D1 >actual &&
> > -             test 1 =3D $(git -C submodule log --oneline | wc -l)
> > +             test 1 =3D $(git -C submodule rev-list --count HEAD)
> >       )
> >  '
>
> These two hunks don't have the desired effect, because command
> substitutions used like this will hide the exit code anyway.  I'd
> suggest
>
>   git -C submodule log --oneline >out &&
>   test_line_count =3D 1 out
>
> instead, with the additional benefit of a nice error message on
> failure.

Ah, good point...and good suggestion.  I'll wait for further feedback
then resend with this change.
