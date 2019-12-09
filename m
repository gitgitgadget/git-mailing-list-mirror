Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AE0C00454
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 21:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471D0205C9
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 21:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG7zx53r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfLIVvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:51:39 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33001 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIVvj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 16:51:39 -0500
Received: by mail-ot1-f68.google.com with SMTP id d17so13693906otc.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 13:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7lYLPwvNqTmyxvG/79Gg5Xu4L1gonSEnG/NkiGp4Gus=;
        b=HG7zx53rpbhqRTIOdhKIfHpO4YmRUEsbhLhemBH4GVIG2mupWDt3lCqOWd+WDv1jb4
         RyplE8c9IHpaKTuMJAOCO6MGiAYW2VI5PXHihLRlDYDlnHFUBuXOnWMNVCw8WhmhXb/D
         SMAc1BfkZR1g0nXtYXzoqjNHW+AErjEB9uO6vaiuFrgnrwapeIf+L4h3pRtlj0hKnGv1
         E8k3+KRwS54YRbh+DAgc46jCB9JbRlOwih2Rv971+mO/IaXYDUPCcM26hOEvcULyHeyQ
         3CJz37BwtkPOc66i0tlS9POaj5+tTBeUI3/Z4LuC63eHsSrjLtabuqf+8NE5Ao/AYqDO
         Vd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7lYLPwvNqTmyxvG/79Gg5Xu4L1gonSEnG/NkiGp4Gus=;
        b=PMMT7CW8Y5IhkqHOHmnxhw7D4+fLAe/snctIQexG9LFEP3RwO9ZxJs63OI9xypddDL
         S+h9f1GFxaziVv2rYzw3oBsN/omT9PR3tN7m1xOhf7FXWlSiMqK3B0Ltcvmw/p4zMF/J
         MFR/C+2HWE1zPEf8cijFVKeUnlgUFRZQn4OhD960rocq1gJWtHO5KER1ely3dRGMRqLD
         oE0B5++OTFQN9kOLJJQc9Lus4AkBENVhJcSZysRyIAwSV5wik6FWgy0z4pZTIMr2a9fS
         Nc6S09vd62arWm6oK+pbEUg7aUKccr2QKQYnrpTrqhBY1wHcJMBhg+mhbMLyb5ExcCh1
         qG7A==
X-Gm-Message-State: APjAAAXeMHCUZm3VgvYSgjaglLdyr2QizROdLKD0PTjrjdPzM0flcG6v
        wRdZ7np0E4vc90stivq5O1jL3gXIed0PTbzlcdSliw==
X-Google-Smtp-Source: APXvYqxEdzlT54GcIf+0If6YmwzQMWwfoRonYFn6qP+6kevPVEkB5d30dEjNnJKExvJK/zqyfdsIu6LLuYMEGb6q8u0=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr15636997otn.267.1575928298300;
 Mon, 09 Dec 2019 13:51:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
 <bfaf7592ee611f7e9f6fbcf7b1e4ae32f8307548.1575924465.git.gitgitgadget@gmail.com>
 <20191209213246.GA41680@generichostname>
In-Reply-To: <20191209213246.GA41680@generichostname>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 9 Dec 2019 13:51:27 -0800
Message-ID: <CABPp-BGdUjQ8gg-VH+udmwBmW-cfhiE7wX=qkQ2jnCgS6eQJiw@mail.gmail.com>
Subject: Re: [PATCH 2/8] Revert "dir.c: make 'git-status --ignored' work
 within leading directories"
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 9, 2019 at 1:32 PM Denton Liu <liu.denton@gmail.com> wrote:
>
> Hi Elijah,
>
> On Mon, Dec 09, 2019 at 08:47:39PM +0000, Elijah Newren via GitGitGadget wrote:
> > diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
> > index 0c394cf995..ded7f97181 100755
> > --- a/t/t7061-wtstatus-ignore.sh
> > +++ b/t/t7061-wtstatus-ignore.sh
> > @@ -43,11 +43,14 @@ test_expect_success 'status untracked directory with --ignored -u' '
> >       test_cmp expected actual
> >  '
> >  cat >expected <<\EOF
> > -?? untracked/uncommitted
> > +?? untracked/
> >  !! untracked/ignored
> >  EOF
> >
> > -test_expect_success 'status prefixed untracked directory with --ignored' '
> > +test_expect_failure 'status of untracked directory with --ignored works with or without prefix' '
> > +     git status --porcelain --ignored | grep untracked/ >actual &&
>
> Can we break this pipe up into two invocations so that we don't have a
> git command in the upstream of a pipe?

Sigh...yeah, I keep doing this.  And I'll probably keep doing it if
someone can't chainlint (or pipefail) it.  I'll fix it up.
