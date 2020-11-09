Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A765C4741F
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 15:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A7C206E3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 15:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTyxyZaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgKIPUD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 10:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbgKIPUD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 10:20:03 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506EDC0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 07:20:03 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id m17so10566862oie.4
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 07:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3R45g8VX84aW6OKsiExnNSbiDTEO5XarAuOKSw04N4=;
        b=WTyxyZaI19QqYvxuGNjS0CGEv3gb197L+zIRnLF8BD5xMt14FojvGkKm4L0uxqG02r
         5EXjEG8Z3lCmws4B7FwaEchK1W+23cez+ZWLVdHHhL/kcGiGLOy8uek6zFMDbDOnbl9V
         d7yevzwfde58iwTl5vkvjEld9ky257h17Bwqfz1m4JGxAtEQee40xCQumD/qSwjRyh8X
         Njn1IlNT+xHrTaVh9lycsi4G7UAcFASfDBpY9c9GkhmoiEpNQLb8b2k7O0KJDRDtEt1W
         04o/pBxm2jgcCJl64FBZmBcltI+Mgw/khjT66swRjQkdXBdNd5P0aJrD5BDMpny1xdtw
         PacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3R45g8VX84aW6OKsiExnNSbiDTEO5XarAuOKSw04N4=;
        b=FzXiiJFxy6+YmHLK3Ks0ejBt41Wrl9B6uUySWnmqH6cVfyqBbeF5ppgAmCwaXSs9dc
         HNfSaKwVFBYwOTTWrh2kS7dXVq2Mp2lbOodb9oCQN/ajGqJXnhmzxHUC6aKnU0rR3eMn
         Zc6lhj30AA9BFT8PRSY+GcB1MG2DMoqGUllMqlh5SSKKzvhp8Y1j8HUwdqfF7oEYa2gg
         7xOi30WmsUhgJwdeZUAqzmbGT+u9tTIIobLwUXxQpDHVyUwdXXF5fMIilIyxAPXq4bL1
         rI9z4QPy8FZRrrUOCotuAYl+35D4loAb3ckgYLBeKCsLph5IPFk3N70dBoins7AM8UZB
         oIuQ==
X-Gm-Message-State: AOAM531Jtd8YtzGeW8lBYIvkZtEawiGL0Tx0IEiEo33a1mdOBNMpO6eB
        d+9JznEm83L3mtuxstvCoTpt9SJ0QDHKH1R0dy4=
X-Google-Smtp-Source: ABdhPJyNZa54MerGfpH2QN4fS9dalF98XAsiu5BQFnvX3odfFDk57ZjpGBtk8xs/wzavrKP5X541HUyst2/hTCzOe/8=
X-Received: by 2002:aca:c3d6:: with SMTP id t205mr9796291oif.10.1604935202717;
 Mon, 09 Nov 2020 07:20:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
 <20201026175742.33356-1-sangunb09@gmail.com> <20201107111002.GA21309@danh.dev>
In-Reply-To: <20201107111002.GA21309@danh.dev>
From:   Sangeeta <sangunb09@gmail.com>
Date:   Mon, 9 Nov 2020 20:49:51 +0530
Message-ID: <CAHjREB4=ESipt0r00WmueTH8h+2zQxLjJhky72M6dF-EX3WafQ@mail.gmail.com>
Subject: Re: [Outreachy][PATCH v6] diff: do not show submodule with untracked
 files as "-dirty"
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Danh,


> > diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> > index ca04fac417..9104d1946d 100755
> > --- a/t/t3701-add-interactive.sh
> > +++ b/t/t3701-add-interactive.sh
> > @@ -765,6 +765,11 @@ test_expect_success 'setup different kinds of dirty submodules' '
> >       cat >expected <<-\EOF &&
> >       dirty-both-ways
> >       dirty-head
> > +     EOF
> > +     git -C for-submodules diff-files --name-only --ignore-submodules=none >actual &&
> > +     cat >expected <<-\EOF &&
> > +     dirty-both-ways
> > +     dirty-head
>
> This will throw-away above change to "expected", I think this is not
> what you expected to write!

I am sorry I couldn't understand what you mean by that. I think that
is what I expected to write. I want those changes to be in "expected".

Thanks,
Sangeeta
